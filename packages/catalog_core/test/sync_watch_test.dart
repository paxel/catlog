import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

/// The folder watch: sizes tell which files grew, the grown files tell
/// what is new, and a file that only grew by absorbing your own entries
/// counts as nothing.
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

  test('a grown file with unseen entries names its writer', () async {
    expect(await foreignFileSizes(folder, b.deviceId), isEmpty);
    a.createCat('Miezi');
    await folderSyncIn(a, folder);
    final after = await foreignFileSizes(folder, b.deviceId);
    expect(after.keys.single, startsWith('/${a.deviceId}.jsonl'));
    final grown = grownFiles(const {}, after);
    expect(grown, after.keys.toList());
    final unseen = await unseenChanges(b, folder, grown);
    expect(unseen.count, greaterThan(0));
    expect(unseen.authors, {'anna'});
    // Own file never counts, and a smaller file is not growth.
    expect(await foreignFileSizes(folder, a.deviceId), isEmpty);
    final shrunk = {for (final e in after.entries) e.key: e.value - 1};
    expect(grownFiles(after, shrunk), isEmpty);
  });

  test('a file that grew by absorbing your own entries is not news', () async {
    await folderSyncIn(a, folder);
    await folderSyncIn(b, folder);
    await folderSyncIn(a, folder); // both hold everything
    final before = await foreignFileSizes(folder, a.deviceId);
    a.createCat('Miezi');
    await folderSyncIn(a, folder);
    await folderSyncIn(b, folder); // b's file grows by a's own cat
    final sizesForA = await foreignFileSizes(folder, a.deviceId);
    final grown = grownFiles(before, sizesForA);
    expect(grown, isNotEmpty);
    final unseen = await unseenChanges(a, folder, grown);
    expect(unseen.isEmpty, isTrue);
    // After b writes something of its own, a has news again.
    b.createCat('Wanderer');
    await folderSyncIn(b, folder);
    final later = await foreignFileSizes(folder, a.deviceId);
    expect(grownFiles(sizesForA, later), isNotEmpty);
    final news = await unseenChanges(a, folder, grownFiles(sizesForA, later));
    expect(news.count, greaterThan(0));
    expect(news.authors, {'ben'});
  });

  test('the shared folder carries a .nomedia marker for Android', () async {
    await folderSyncIn(a, folder, catalog: 'farm');
    expect(await folder.read('', '.nomedia'), isNotNull);
    expect(await foreignFileSizes(folder, b.deviceId, catalog: 'farm'),
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
    expect('$r', contains('1 photos not in the folder yet'));
    expect(await fetchMissingBlobs(b, folder, catalog: 'farm'), 0);
    blobs.addAll(held);
    expect(await fetchMissingBlobs(b, folder, catalog: 'farm'), 1);
    expect(b.missingBlobs(), isEmpty);
  });

  test('sizes come per catalog subfolder too', () async {
    a.createCat('Miezi');
    await folderSyncIn(a, folder, catalog: 'farm');
    final sizes = await foreignFileSizes(folder, b.deviceId, catalog: 'farm');
    expect(sizes.keys.single, startsWith('farm/'));
    final unseen = await unseenChanges(b, folder, sizes.keys);
    expect(unseen.count, greaterThan(0));
  });
}
