import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

/// The folder watch: manifests tell which writers moved on, the unread
/// lines tell what is new, and a writer that only moved on by absorbing
/// your own entries counts as nothing. A device from before is judged
/// by its file's size.
void main() {
  setUpAll(useSystemSqlite);
  late CatalogStore a, b;
  late MemorySyncFolder folder;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'ben';
    folder = MemorySyncFolder();
  });

  tearDown(() {
    a.close();
    b.close();
  });

  test('a manifest with unread lines names its writer', () async {
    expect(await foreignManifests(folder, b.deviceId), isEmpty);
    a.createCat('Miezi');
    await folderSyncIn(a, folder);
    final after = await foreignManifests(folder, b.deviceId);
    expect(after.keys.single, '/${a.deviceId}');
    final changed = changedManifests(const {}, after);
    expect(changed, after.keys.toList());
    final unseen = await unseenChanges(b, folder, const [], devices: changed);
    expect(unseen.count, greaterThan(0));
    expect(unseen.authors, {'anna'});
    // The own manifest never counts; a device with a manifest has no
    // whole-history file to size.
    expect(await foreignManifests(folder, a.deviceId), isEmpty);
    expect(await foreignFileSizes(folder, b.deviceId), isEmpty);
  });

  test('a manifest that moved on by absorbing your own entries is not news',
      () async {
    await folderSyncIn(a, folder);
    await folderSyncIn(b, folder);
    await folderSyncIn(a, folder); // both hold everything
    final before = await foreignManifests(folder, a.deviceId);
    a.createCat('Miezi');
    await folderSyncIn(a, folder);
    await folderSyncIn(b, folder); // b's segments grow by a's own cat
    final forA = await foreignManifests(folder, a.deviceId);
    final changed = changedManifests(before, forA);
    expect(changed, isNotEmpty);
    final unseen = await unseenChanges(a, folder, const [], devices: changed);
    expect(unseen.isEmpty, isTrue);
    // After b writes something of its own, a has news again.
    b.createCat('Wanderer');
    await folderSyncIn(b, folder);
    final later = await foreignManifests(folder, a.deviceId);
    expect(changedManifests(forA, later), isNotEmpty);
    final news = await unseenChanges(a, folder, const [],
        devices: changedManifests(forA, later));
    expect(news.count, greaterThan(0));
    expect(news.authors, {'ben'});
  });

  test('a device from before is judged by the size of its file', () async {
    await folder.ensure('');
    final line = jsonEncode({
      'device': 'old-phone',
      'dseq': 1,
      'entity': 'cat:old',
      'field': r'$type',
      'value': 'cat',
      'date': '2026-01-01T00:00:00.000000Z',
      'author': 'carla',
      'recorded': '2026-01-01T00:00:00.000000Z',
    });
    await folder.write('', 'old-phone.jsonl', utf8.encode(line));
    final sizes = await foreignFileSizes(folder, b.deviceId);
    expect(sizes.keys.single, '/old-phone.jsonl');
    final grown = grownFiles(const {}, sizes);
    final unseen = await unseenChanges(b, folder, grown);
    expect(unseen.count, 1);
    expect(unseen.authors, {'carla'});
    final shrunk = {for (final e in sizes.entries) e.key: e.value - 1};
    expect(grownFiles(sizes, shrunk), isEmpty);
  });

  test('the shared folder carries a .nomedia marker for Android', () async {
    await folderSyncIn(a, folder, catalog: 'farm');
    expect(await folder.read('', '.nomedia'), isNotNull);
    expect(await foreignManifests(folder, b.deviceId, catalog: 'farm'),
        isNot(contains('/.nomedia')));
  });

  test('photo files that land after the entries are fetched on their own',
      () async {
    final cat = a.createCat('Miezi');
    a.addImage(cat, CatalogStore.compressImage(jpeg(30, 30)));
    await folderSyncIn(a, folder, catalog: 'farm');
    // The cloud client has not copied the photo yet.
    final blobs = folder.dirs['farm/blobs']!;
    final held = Map.of(blobs);
    blobs.clear();
    final r = await folderSyncIn(b, folder, catalog: 'farm');
    expect(r.blobsIn, 0);
    expect(r.blobsMissing, 1);
    expect(await fetchMissingBlobs(b, folder, catalog: 'farm'), 0);
    blobs.addAll(held);
    expect(await fetchMissingBlobs(b, folder, catalog: 'farm'), 1);
    expect(b.missingBlobs(), isEmpty);
  });

  test('manifests come per catalog subfolder too', () async {
    a.createCat('Miezi');
    await folderSyncIn(a, folder, catalog: 'farm');
    final manifests = await foreignManifests(folder, b.deviceId, catalog: 'farm');
    expect(manifests.keys.single, 'farm/${a.deviceId}');
    final unseen =
        await unseenChanges(b, folder, const [], devices: manifests.keys);
    expect(unseen.count, greaterThan(0));
  });
}
