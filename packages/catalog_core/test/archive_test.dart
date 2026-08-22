import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List _jpeg() =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: 40, height: 40)));

/// #53: archiving is export-then-delete — nothing is lost, but the
/// deletion is a real deletion.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late Directory dir;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog_archive');
    store = CatalogStore.open('${dir.path}/catalog.db');
    store.author = 'test';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  final long = DateTime(2020, 1, 1);

  test('deceased cats and empty clowders qualify once they are quiet', () {
    final home = store.createClowder('Hof', date: long);
    final alive = store.createCat('Minka', clowderId: home, date: long);
    final dead = store.createCat('Mimzy', date: long);
    store.append(dead, Keys.userField('deceased'), '2020-03-01',
        date: long);
    // Recent activity keeps a cat off the list.
    final freshlyDead = store.createCat('Nala');
    store.append(freshlyDead, Keys.userField('deceased'), '2026-08-01');

    final ids = {
      for (final c in archiveCandidates(store, now: DateTime(2026, 8, 20)))
        c.id
    };
    expect(ids, contains(dead));
    expect(ids, isNot(contains(alive)));
    expect(ids, isNot(contains(freshlyDead)));
    // The clowder still has Minka in it.
    expect(ids, isNot(contains(home)));
  });

  test('private entities are never offered', () {
    final cat = store.createCat('Geheim', date: long);
    store.append(cat, Keys.userField('deceased'), '2020-03-01', date: long);
    store.setPrivate(cat, true);
    expect(archiveCandidates(store, now: DateTime(2026, 8, 20)), isEmpty);
  });

  test('an archived cat leaves the catalog and comes back on import', () {
    final cat = store.createCat('Mimzy', date: long);
    store.append(cat, Keys.userField('deceased'), '2020-03-01', date: long);
    store.append(cat, Keys.userField('color'), 'tabby', date: long);
    final path = writeArchive(store, '${dir.path}/archive.catsync',
        entityIds: {cat});
    deleteArchived(store, {cat});
    expect(store.cats().where((c) => c.id == cat), isEmpty);

    final other = CatalogStore.inMemory();
    addTearDown(other.close);
    other.author = 'other';
    importBundle(other, path);
    final restored = other.cats().single;
    expect(restored.name, 'Mimzy');
    expect(other.current(restored.id, Keys.userField('color')), 'tabby');
  });

  test('an archive coming home can be restored in the same catalog', () {
    final cat = store.createCat('Mimzy', date: long);
    store.append(cat, Keys.userField('color'), 'tabby', date: long);
    store.addImage(cat, CatalogStore.compressImage(_jpeg()));
    final path = writeArchive(store, '${dir.path}/archive.catsync',
        entityIds: {cat});
    deleteArchived(store, {cat});
    expect(store.cats().where((c) => c.id == cat), isEmpty);

    // Import alone leaves the deletion standing — it is newer than
    // everything in the file.
    final result = importBundle(store, path);
    expect(store.cats().where((c) => c.id == cat), isEmpty);
    final restorable = restorableEntities(store, result.applied);
    expect(restorable, [cat]);

    store.restoreEntity(cat);
    expect(store.cats().single.name, 'Mimzy');
    expect(store.current(cat, Keys.userField('color')), 'tabby');
    // The photo came back with the file.
    expect(store.images(cat), hasLength(1));
  });

  test('the archive file never carries the original device rows', () {
    final cat = store.createCat('Mimzy', date: long);
    final path = writeArchive(store, '${dir.path}/archive.catsync',
        entityIds: {cat});
    final other = CatalogStore.inMemory();
    addTearDown(other.close);
    other.author = 'other';
    importBundle(other, path);
    // The importer must not claim knowledge of this device's log, or a
    // later real sync would skip everything withheld from the archive.
    expect(other.versionVector().keys.where((d) => d == store.deviceId), isEmpty);
  });

  test('storage usage counts the database and the photos', () {
    final before = store.storageUsage();
    final cat = store.createCat('Minka');
    store.addImage(
        cat, CatalogStore.compressImage(_jpeg()));
    final after = store.storageUsage();
    expect(after.entries, greaterThan(before.entries));
    expect(after.photoCount, 1);
    expect(after.photoBytes, greaterThan(0));
    expect(after.dbBytes, greaterThan(0));
  });

  test('an ordinary sync never asks to restore what you deleted', () {
    // A partner who has not seen the deletion yet keeps sending news
    // about the cat. That is not an archive coming home.
    final peer = CatalogStore.inMemory()..author = 'kathrin';
    addTearDown(peer.close);
    final cat = store.createCat('Miezi');
    peer.applyEntries(store.entriesSince(const {}));
    store.deleteCat(cat);

    peer.append(cat, Keys.userField('color'), 'black');
    final applied = store.applyEntries(peer.entriesSince(store.versionVector()));

    expect(applied, isNotEmpty);
    expect(restorableEntities(store, applied), isEmpty);
  });

  test('an archive file coming home does ask', () {
    final cat = store.createCat('Miezi');
    final dir = Directory.systemTemp.createTempSync('catlog-archive-ask');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = writeArchive(store, '${dir.path}/a.catsync',
        entityIds: {cat});
    deleteArchived(store, {cat});

    final applied = importBundle(store, path).applied;
    expect(restorableEntities(store, applied), [cat]);
  });
}
