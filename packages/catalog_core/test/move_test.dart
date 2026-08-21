import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void sync(CatalogStore from, CatalogStore to) => to.applyEntries(
    from.entriesSince(to.versionVector()),
    senderVector: from.versionVector());

/// Moving cats between catalogs: everything comes along, and the two
/// catalogs can never quietly grow back together.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore berlin, paris;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-move');
    // Each catalog is its own folder, photos included — as on a device.
    for (final name in ['berlin', 'paris', 'partner']) {
      Directory('${dir.path}/$name').createSync();
    }
    berlin = CatalogStore.open('${dir.path}/berlin/catlog.db')
      ..author = 'Patrick';
    paris = CatalogStore.open('${dir.path}/paris/catlog.db')
      ..author = 'Patrick';
  });

  tearDown(() {
    berlin.close();
    paris.close();
    dir.deleteSync(recursive: true);
  });

  test('a cat arrives with its history and its photos', () {
    final cat = berlin.createCat('Miezi');
    berlin.append(cat, Keys.userField('color'), 'black',
        date: DateTime.utc(2024, 3, 1));
    berlin.addImage(cat, jpeg(20, 20));

    final result = moveEntities(berlin, paris, {cat});

    expect(result.moved, contains(cat));
    expect(paris.current(cat, Keys.name), 'Miezi');
    expect(paris.current(cat, Keys.userField('color')), 'black');
    expect(paris.images(cat), hasLength(1));
    expect(paris.imageBytes(paris.images(cat).single), isNotNull);
    expect(result.photos, 1);
  });

  test('the history still says who wrote what, and when', () {
    final cat = berlin.createCat('Miezi');
    berlin.author = 'Kathrin';
    berlin.append(cat, Keys.userField('color'), 'black',
        date: DateTime.utc(2024, 3, 1));
    moveEntities(berlin, paris, {cat});

    final colour = paris
        .entriesSince(const {})
        .firstWhere((e) => e.field == Keys.userField('color'));
    expect(colour.author, 'Kathrin');
    expect(colour.date, DateTime.utc(2024, 3, 1));
  });

  test('what was moved is deleted where it came from', () {
    final cat = berlin.createCat('Miezi');
    moveEntities(berlin, paris, {cat});
    expect(berlin.cats().map((c) => c.id), isNot(contains(cat)));
    expect(berlin.isDeleted(cat), isTrue);
  });

  test('the entries arrive under the destination device', () {
    final cat = berlin.createCat('Miezi');
    moveEntities(berlin, paris, {cat});
    final devices =
        paris.entriesSince(const {}).map((e) => e.device).toSet();
    expect(devices, {paris.deviceId});
  });

  test("the destination never claims the source device's numbers", () {
    final cat = berlin.createCat('Miezi');
    moveEntities(berlin, paris, {cat});

    // Keeping Berlin's (device, dseq) would make Paris claim to have
    // seen everything that device wrote up to that point — a later real
    // sync would then skip those entries for ever.
    expect(paris.versionVector().containsKey(berlin.deviceId), isFalse);
  });

  test('a later sync with a shared partner delivers everything, nothing '
      'silently skipped', () {
    final cat = berlin.createCat('Miezi');
    moveEntities(berlin, paris, {cat});

    final partner = CatalogStore.open('${dir.path}/partner/catlog.db')
      ..author = 'Kathrin';
    addTearDown(partner.close);
    final other = berlin.createCat('Mausi');
    sync(berlin, partner);
    sync(partner, paris);

    // Paris asked for it, so it arrives — and it arrives whole.
    expect(paris.current(other, Keys.name), 'Mausi');
    expect(paris.current(cat, Keys.name), 'Miezi');
  });

  test('a clowder takes the cats living in it', () {
    final clowder = berlin.createClowder('Hinterhof');
    final cat = berlin.createCat('Miezi');
    berlin.moveCat(cat, clowder);
    final elsewhere = berlin.createCat('Mausi');

    moveEntities(berlin, paris, {clowder});

    expect(paris.clowders().map((c) => c.name), ['Hinterhof']);
    expect(paris.cats(clowderId: clowder).map((c) => c.name), ['Miezi']);
    expect(paris.current(elsewhere, Keys.name), isNull);
    expect(berlin.cats().map((c) => c.id), [elsewhere]);
  });

  test('several cats move in one go', () {
    final one = berlin.createCat('Miezi');
    final two = berlin.createCat('Mausi');
    berlin.createCat('Struppi');
    moveEntities(berlin, paris, {one, two});
    expect(paris.cats().map((c) => c.name),
        unorderedEquals(['Miezi', 'Mausi']));
  });

  test('a cat whose clowder stayed behind arrives as a stray', () {
    final clowder = berlin.createClowder('Hinterhof');
    final cat = berlin.createCat('Miezi');
    berlin.moveCat(cat, clowder);

    moveEntities(berlin, paris, {cat});

    expect(paris.current(cat, Keys.clowder), anyOf(isNull, isEmpty));
    expect(paris.cats(clowderId: null).map((c) => c.name), ['Miezi']);
  });

  test('the fields the cat uses come along', () {
    berlin.defineField('Ear notch', FieldType.text, scope: FieldScope.cat);
    final cat = berlin.createCat('Miezi');
    berlin.append(cat, Keys.userField('ear-notch'), 'left');
    moveEntities(berlin, paris, {cat});
    expect(paris.fieldDefs().map((d) => d.name), contains('Ear notch'));
    expect(paris.current(cat, Keys.userField('ear-notch')), 'left');
  });

  test('moving nothing does nothing', () {
    expect(moveEntities(berlin, paris, const {}).moved, isEmpty);
    expect(paris.cats(), isEmpty);
  });

  test('the destination keeps its own field definitions', () {
    // Both catalogs have the starter fields; Paris renamed one of them.
    paris.renameField(
        paris.fieldDefs().firstWhere((d) => d.slug == 'color').id,
        'Couleur');
    berlin.renameField(
        berlin.fieldDefs().firstWhere((d) => d.slug == 'color').id,
        'Farbe');
    final cat = berlin.createCat('Miezi');
    berlin.append(cat, Keys.userField('color'), 'black');

    moveEntities(berlin, paris, {cat});

    expect(paris.fieldDefs().map((d) => d.name), contains('Couleur'));
    expect(paris.fieldDefs().map((d) => d.name), isNot(contains('Farbe')));
    expect(paris.current(cat, Keys.userField('color')), 'black');
  });
}
