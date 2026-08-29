import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/image_import.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// A photo compressed for a catalog that closed meanwhile is dropped,
/// not written into a disposed database.
void main() {
  setUpAll(useSystemSqlite);

  test('a closed catalog gets no photo and no error', () async {
    final store = CatalogStore.inMemory()..author = 'test';
    final cat = store.createCat('Sissi');
    final bytes = Uint8List.fromList(
        img.encodeJpg(img.Image(width: 40, height: 40)));
    final pending = addCompressedImage(store, cat, bytes);
    store.close();
    expect(await pending, isNull);
  });
}
