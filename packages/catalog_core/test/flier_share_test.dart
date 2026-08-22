import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore owner;
  late CatalogStore finder;
  late String cat;
  late String home;

  setUp(() {
    owner = CatalogStore.inMemory();
    owner.author = 'owner';
    finder = CatalogStore.inMemory();
    finder.author = 'finder';
    home = owner.createClowder('Familie Huber');
    owner.append(home, Keys.userField('address'), 'Main St 1');
    cat = owner.createCat('Minka', clowderId: home);
    owner.append(cat, Keys.userField('gender'), 'female');
    owner.append(cat, Keys.userField('chipid'), '276098102345678');
    owner.append(cat, Keys.userField('remarks'), 'secret vet history');
  });

  tearDown(() {
    owner.close();
    finder.close();
  });

  String shareFile(Set<String> fields) {
    final dir = Directory.systemTemp.createTempSync('catlog_share');
    addTearDown(() => dir.deleteSync(recursive: true));
    return writeCatShare(owner, '${dir.path}/share.catsync',
        catId: cat, fields: fields);
  }

  test('the whitelist decides what leaves the catalog', () {
    final path = shareFile(
        {Keys.userField('gender'), Keys.userField('address')});
    importBundle(finder, path);
    final imported = finder.cats().single;
    expect(imported.name, 'Minka');
    expect(finder.current(imported.id, Keys.userField('gender')),
        'female');
    // Not whitelisted — never left home.
    expect(finder.current(imported.id, Keys.userField('chipid')), isNull);
    expect(
        finder.current(imported.id, Keys.userField('remarks')), isNull);
    // The owner clowder travelled with its whitelisted address.
    final clowder = finder.clowders().single;
    expect(clowder.name, 'Familie Huber');
    expect(finder.current(clowder.id, Keys.userField('address')),
        'Main St 1');
  });

  test('a partial import never poisons a later full sync', () {
    final path = shareFile({Keys.userField('gender')});
    importBundle(finder, path);
    // The share came from a fresh device id, so the finder's vector
    // knows nothing about the owner's real device...
    expect(
        finder.versionVector().keys.any((d) => d.startsWith('share-')),
        isTrue);
    // ...and a later full sync still delivers everything withheld.
    finder.applyEntries(owner.entriesSince(finder.versionVector()),
        senderVector: owner.versionVector());
    final imported = finder.cats().single;
    expect(finder.current(imported.id, Keys.userField('chipid')),
        '276098102345678');
    expect(finder.current(imported.id, Keys.userField('remarks')),
        'secret vet history');
    // Still exactly one cat — the share and the sync converge.
    expect(finder.cats(), hasLength(1));
  });

  test('dangling references import without crashing and stay dangling',
      () {
    // Whitelist the mother reference but not the mother herself.
    final mother = owner.createCat('Mutti');
    owner.append(cat, Keys.userField('mother'), mother);
    final path = shareFile({Keys.userField('mother')});
    importBundle(finder, path);
    final imported = finder.cats().single;
    // The reference is stored verbatim; the target is simply unknown.
    expect(finder.current(imported.id, Keys.userField('mother')), mother);
    expect(finder.current(mother, Keys.name), isNull);
  });

  test('Private stays home: cat refused, clowder and fields dropped', () {
    // A private cat never exports.
    owner.setPrivate(cat, true);
    expect(
        () => catShareBytes(owner,
            catId: cat, fields: {Keys.userField('gender')}),
        throwsStateError);
    owner.setPrivate(cat, false);

    // A private clowder silently stays out of the share.
    owner.setPrivate(home, true);
    final path = shareFile({Keys.userField('gender')});
    importBundle(finder, path);
    expect(finder.clowders(), isEmpty);
    expect(finder.cats().single.name, 'Minka');

    // A private field definition never travels, whitelisted or not.
    owner.setPrivate('fielddef:gender', true);
    final finder2 = CatalogStore.inMemory();
    addTearDown(finder2.close);
    finder2.author = 'finder2';
    importBundle(finder2, shareFile({Keys.userField('gender')}));
    expect(
        finder2.current(
            finder2.cats().single.id, Keys.userField('gender')),
        isNull);
  });

  test('QR payloads round-trip and reject garbage', () {
    expect(decodeShareQr(encodeShareUrl('https://x.example/f.catsync'))!
        .url,
        'https://x.example/f.catsync');
    final bytes = catShareBytes(owner,
        catId: cat,
        fields: {Keys.userField('gender')},
        includePhotos: false);
    expect(decodeShareQr(encodeShareData(bytes))!.data, bytes);
    expect(decodeShareQr('https://random.example'), isNull);
    expect(decodeShareQr('catlog-share:u:!!!'), isNull);
    expect(
        decodeShareQr(
            'catlog-share:u:${base64Url.encode(utf8.encode('ftp://x'))}'),
        isNull);
  });

  test("a share never renames the importer's own fields", () {
    // Both catalogs have the starter fields — same deterministic ids.
    // The finder renamed theirs and cut the option list down.
    final def = finder.fieldDefs().firstWhere((d) => d.slug == 'color');
    finder.renameField(def.id, 'Farbe');
    final ownerDef = owner.fieldDefs().firstWhere((d) => d.slug == 'color');
    owner.append(cat, Keys.userField('color'), 'black');

    final bytes = catShareBytes(owner, catId: cat, fields: {ownerDef.key});
    importBundleBytes(finder, bytes);

    expect(finder.fieldDefs().firstWhere((d) => d.slug == 'color').name,
        'Farbe',
        reason: "somebody else's flier must not rename your field");
    expect(finder.current(cat, Keys.userField('color')), 'black');
  });

  test('a share does not bring back what the importer deleted', () {
    // A sync partner holds the same cat and has since deleted a photo
    // and moved the cat out of the clowder.
    owner.addImage(cat, jpeg(20, 20));
    final bytesBefore = catShareBytes(owner, catId: cat, fields: const {});
    importBundleBytes(finder, bytesBefore);
    final hash = finder.images(cat).first;
    finder.deleteImage(cat, hash, date: DateTime.now());
    finder.moveCat(cat, null, date: DateTime.now());
    expect(finder.images(cat), isEmpty);

    // The same share, imported again, must lose to those decisions.
    importBundleBytes(finder, bytesBefore);
    expect(finder.images(cat), isEmpty,
        reason: 'a deleted photo stays deleted');
    expect(finder.current(cat, Keys.clowder), anyOf(isNull, isEmpty),
        reason: 'the cat stays where the importer put it');
  });
}
