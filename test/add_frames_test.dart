import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/image_import.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// Frames from a video land one at a time, each announced, so a page
/// can show them as they arrive instead of after a silent wait.
void main() {
  setUpAll(useSystemSqlite);

  KeptFrame frame(int shade) => (
    bytes: Uint8List.fromList(
      img.encodeJpg(
        img.Image(width: 40, height: 40)
          ..clear(img.ColorRgb8(shade, shade, shade)),
      ),
    ),
    crop: null,
  );

  test('each frame is stored and reported before the next', () async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    final seen = <(int, int, int)>[];

    final done = await addFrames(
      store,
      cat,
      [frame(10), frame(120), frame(230)],
      onProgress: (done, total) =>
          seen.add((done, total, store.images(cat).length)),
    );

    expect(done, 3);
    // Reported after each one, with that many photos already on the cat.
    expect(seen, [(1, 3, 1), (2, 3, 2), (3, 3, 3)]);
  });

  test('a frame lands with its crop cut out', () async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');

    await addFrames(store, cat, [
      (bytes: frame(10).bytes, crop: (x: 0.5, y: 0, w: 0.5, h: 0.5)),
    ]);

    final stored = img.decodeImage(store.imageBytes(store.images(cat).single)!)!;
    expect((stored.width, stored.height), (20, 20));
  });

  test('a closed catalog stops the run without a crash', () async {
    final store = CatalogStore.inMemory()..author = 'anna';
    final cat = store.createCat('Miezi');
    store.close();
    expect(await addFrames(store, cat, [frame(10), frame(20)]), 0);
  });
}
