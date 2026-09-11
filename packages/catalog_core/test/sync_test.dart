import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';
import 'dart:typed_data';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

/// Full two-way sync: entries then blobs — what every transport does.
/// Vectors are snapshotted first so conflict detection sees what each
/// side had actually seen before this session.
void sync(CatalogStore a, CatalogStore b) {
  final va = a.versionVector();
  final vb = b.versionVector();
  b.applyEntries(a.entriesSince(vb), senderVector: va);
  a.applyEntries(b.entriesSince(va), senderVector: vb);
  for (final h in a.missingBlobs()) {
    final bytes = b.imageBytes(h);
    if (bytes != null) a.putBlob(h, bytes);
  }
  for (final h in b.missingBlobs()) {
    final bytes = a.imageBytes(h);
    if (bytes != null) b.putBlob(h, bytes);
  }
}

/// Projection fingerprint: every entity's current fields.
Map<String, Map<String, String?>> state(CatalogStore s) {
  final entities = <String>{
    for (final c in s.clowders()) c.id,
    for (final c in s.cats()) c.id,
    for (final d in s.fieldDefs()) d.id,
  };
  return {for (final e in entities) e: s.currentFields(e)};
}

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a, b, c;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'axel';
    b = CatalogStore.inMemory()..author = 'friend';
    c = CatalogStore.inMemory()..author = 'third';
  });

  tearDown(() {
    a.close();
    b.close();
    c.close();
  });

  test('two stores converge to identical state', () {
    final home = a.createClowder('Home');
    a.createCat('Miezi', clowderId: home);
    b.createCat('Wanderer');

    sync(a, b);
    expect(state(a), state(b));
    expect(a.cats().length, 2);
    expect(b.clowders().single.name, 'Home');
  });

  test('sync order does not matter (A→B→C vs C→B→A)', () {
    a.createCat('One');
    b.createCat('Two');
    c.createCat('Three');

    sync(a, b);
    sync(b, c); // c now has everything via b
    sync(c, a);
    expect(state(a), state(b));
    // reverse direction on fresh edits
    c.append(c.cats().first.id, 'f:color', 'black');
    sync(c, b);
    sync(b, a);
    expect(state(a), state(c));
    expect(state(b), state(c));
  });

  test('repeated sync is a no-op', () {
    a.createCat('Miezi');
    sync(a, b);
    final again = b.applyEntries(a.entriesSince(b.versionVector()));
    expect(again, isEmpty);
  });

  test('concurrent rename: same winner everywhere, both in history', () {
    final cat = a.createCat('Original');
    sync(a, b);
    final catOnB = b.cats().single.id;

    a.append(cat, Keys.name, 'Axel Name');
    b.append(catOnB, Keys.name, 'Friend Name');
    sync(a, b);

    expect(a.current(cat, Keys.name), b.current(catOnB, Keys.name));
    expect(a.fieldHistory(cat, Keys.name).map((e) => e.value),
        containsAll(['Original', 'Axel Name', 'Friend Name']));
  });

  test('photos travel with the data', () {
    final cat = a.createCat('Miezi');
    final hash = a.addImage(cat, CatalogStore.compressImage(jpeg(50, 50)));

    sync(a, b);
    expect(b.images(b.cats().single.id), [hash]);
    expect(b.imageBytes(hash), isNotNull);
    expect(b.profileImage(b.cats().single.id), hash);
  });

  test('deletions propagate and drop bytes on the receiving side', () {
    final cat = a.createCat('Mistake');
    final hash = a.addImage(cat, CatalogStore.compressImage(jpeg(40, 40)));
    sync(a, b);
    expect(b.imageBytes(hash), isNotNull);

    a.deleteCat(cat);
    sync(a, b);
    expect(b.cats(), isEmpty);
    expect(b.imageBytes(hash), isNull);
  });

  test('concurrent different values flag a conflict on both sides', () {
    final cat = a.createCat('Original');
    sync(a, b);
    final catOnB = b.cats().single.id;

    a.append(cat, Keys.name, 'Axel Name');
    b.append(catOnB, Keys.name, 'Friend Name');
    sync(a, b);

    expect(a.hasConflict(cat, Keys.name), isTrue);
    expect(b.hasConflict(catOnB, Keys.name), isTrue);
  });

  test('sequential edit is not a conflict', () {
    final cat = a.createCat('Original');
    sync(a, b);
    // b saw everything, then edits, then syncs back: no conflict.
    b.append(b.cats().single.id, Keys.name, 'Better Name');
    sync(a, b);
    expect(a.conflicts(), isEmpty);
    expect(b.conflicts(), isEmpty);
    expect(a.current(cat, Keys.name), 'Better Name');
  });

  test('concurrent identical values are not a conflict', () {
    final cat = a.createCat('Original');
    sync(a, b);
    a.append(cat, 'f:neutered', 'yes');
    b.append(b.cats().single.id, 'f:neutered', 'yes');
    sync(a, b);
    expect(a.conflicts(), isEmpty);
  });

  test('promoting the loser resolves and converges', () {
    final cat = a.createCat('Original');
    sync(a, b);
    final catOnB = b.cats().single.id;
    a.append(cat, Keys.name, 'Axel Name');
    b.append(catOnB, Keys.name, 'Friend Name');
    sync(a, b);

    // On A someone decides the friend's name was right after all —
    // or re-asserts the loser: an ordinary append plus resolve.
    final winner = a.current(cat, Keys.name)!;
    final loser = winner == 'Axel Name' ? 'Friend Name' : 'Axel Name';
    a.append(cat, Keys.name, loser);
    a.resolveConflict(cat, Keys.name);
    expect(a.hasConflict(cat, Keys.name), isFalse);

    sync(a, b);
    b.resolveConflict(catOnB, Keys.name);
    expect(a.current(cat, Keys.name), loser);
    expect(b.current(catOnB, Keys.name), loser);
    expect(state(a), state(b));
  });

  test('putBlob rejects bytes that do not match the hash', () {
    expect(() => a.putBlob('deadbeef', Uint8List.fromList([1, 2, 3])),
        throwsArgumentError);
  });

  test('starter field seeds from two devices do not duplicate defs', () {
    sync(a, b);
    final slugs = a.fieldDefs().map((d) => d.slug).toList();
    expect(slugs.toSet().length, slugs.length);
    expect(state(a), state(b));
  });

  test('bookkeeping fields never raise a conflict; old ones stay hidden', () {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:remarks', 'shy');
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    // Both toggle privacy at once, and both pick a profile image.
    a.setFieldPrivate(cat, 'f:remarks', true);
    b.setFieldPrivate(cat, 'f:remarks', false);
    b.setFieldPrivate(cat, 'f:remarks', true);
    a.applyEntries(b.entriesSince(a.versionVector(), includePrivate: true),
        senderVector: b.versionVector());
    expect(a.conflicts(), isEmpty);
    // A badge an older version raised on a marker is out of sight.
    a.append(cat, Keys.conflict(Keys.privateField('f:remarks')), 'open');
    expect(a.conflicts(), isEmpty);
    expect(CatalogStore.isConflictable('f:remarks'), isTrue);
    expect(CatalogStore.isConflictable(Keys.withheld('f:remarks')), isFalse);
    expect(CatalogStore.isConflictable(Keys.chore('x')), isFalse);
  });

  test('option lists changed on both sides merge instead of fighting', () {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);
    final breed = a.fieldDefs().firstWhere((d) => d.slug == 'breed');
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    a.setFieldOptions(breed.id, ['Maine Coon', 'Hauskatze', 'mixed']);
    b.setFieldOptions(breed.id, ['Maine Coon', 'Ragdoll', 'Balinese', 'mixed']);
    a.applyEntries(b.entriesSince(a.versionVector()),
        senderVector: b.versionVector());
    expect(a.conflicts(), isEmpty);
    expect(a.fieldDefs().firstWhere((d) => d.slug == 'breed').options,
        ['Maine Coon', 'Hauskatze', 'Ragdoll', 'Balinese', 'mixed']);
    // Bob takes Anna's merge back; both agree, nothing left to merge.
    b.applyEntries(a.entriesSince(b.versionVector()),
        senderVector: a.versionVector());
    expect(b.conflicts(), isEmpty);
    expect(b.fieldDefs().firstWhere((d) => d.slug == 'breed').options,
        ['Maine Coon', 'Hauskatze', 'Ragdoll', 'Balinese', 'mixed']);
  });
}
