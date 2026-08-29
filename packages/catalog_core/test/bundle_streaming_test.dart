import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

/// Bundles are written entry by entry, photos stored uncompressed, and
/// read back exactly — the shape that keeps a backup of many photos
/// from needing them all in memory twice.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogStore store;
  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-zip');
    store = CatalogStore.inMemory()..author = 'test';
  });
  tearDown(() {
    store.close();
    root.deleteSync(recursive: true);
  });

  Uint8List photo(int seed) => CatalogStore.compressImage(Uint8List.fromList(
      img.encodeJpg(img.Image(width: 8 + seed, height: 8))));

  test('photos are stored, entries deflated, and everything imports back',
      () {
    final cat = store.createCat('Sissi');
    final hashes = [for (var i = 0; i < 3; i++) store.addImage(cat, photo(i))];
    final path = writeBundle(store, '${root.path}/b.catsync');

    final zip = ZipDecoder().decodeBytes(File(path).readAsBytesSync());
    final names = zip.files.map((f) => f.name).toSet();
    expect(names, containsAll(['entries.jsonl', 'blobs/${hashes.first}.jpg']));
    for (final f in zip.files) {
      final stored = f.name.startsWith('blobs/');
      // compressionType 0 = stored, 8 = deflated.
      expect(f.compress, !stored, reason: f.name);
    }

    final other = CatalogStore.inMemory()..author = 'other';
    addTearDown(other.close);
    final result = importBundle(other, path);
    expect(result.blobsIn, 3);
    for (final h in hashes) {
      expect(other.imageBytes(h), store.imageBytes(h));
    }
  });

  test('an archive of a clowder is written the same way', () {
    final home = store.createClowder('Home');
    final cat = store.createCat('Sissi', clowderId: home);
    final hash = store.addImage(cat, photo(5));
    final path = writeArchive(store, '${root.path}/a.catsync',
        entityIds: {home, cat});
    final zip = ZipDecoder().decodeBytes(File(path).readAsBytesSync());
    expect(zip.files.map((f) => f.name), contains('blobs/$hash.jpg'));
    final other = CatalogStore.inMemory()..author = 'other';
    addTearDown(other.close);
    expect(importBundle(other, path).blobsIn, 1);
  });
}
