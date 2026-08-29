import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// What an import must refuse: rows forged under this device's own id,
/// and photos far larger than the app ever writes.
void main() {
  setUpAll(useSystemSqlite);

  test('entries beyond the device\'s own counter are dropped', () {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    final cat = a.createCat('Sissi');
    final forged = [
      for (final e in a.entriesSince(const {}))
        Entry(
          seq: -1,
          device: b.deviceId,
          dseq: 1000 + e.dseq,
          entity: e.entity,
          field: e.field,
          value: e.value,
          date: e.date,
          author: e.author,
          recorded: e.recorded,
        )
    ];
    final applied = b.applyEntries(forged);
    expect(applied, isEmpty);
    expect(b.cats(), isEmpty);
    expect(b.versionVector()[b.deviceId] ?? 0, lessThan(1000));
    // The same rows under their real device id land as usual.
    expect(b.applyEntries(a.entriesSince(const {})), isNotEmpty);
    expect(b.cats().single.id, cat);
  });

  test('a photo above the cap is skipped, the rest imports', () {
    final root = Directory.systemTemp.createTempSync('catlog-cap');
    addTearDown(() => root.deleteSync(recursive: true));
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final huge = Uint8List(maxBlobBytes + 1);
    final path = '${root.path}/big.catsync';
    final encoder = ZipFileEncoder()..create(path);
    encoder.addArchiveFile(ArchiveFile('entries.jsonl', 0, <int>[]));
    encoder.addArchiveFile(
        ArchiveFile('blobs/${'a' * 64}.jpg', huge.length, huge)
          ..compress = false);
    encoder.closeSync();
    final result = importBundle(store, path);
    expect(result.blobsIn, 0);
    expect(store.imageBytes('a' * 64), isNull);
  });
}
