import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

/// Blob names are hashes; a name that is a path must stay inside the
/// images directory on read and delete, and never throw.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogStore store;
  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-blob');
    Directory('${root.path}/catalog').createSync();
    store = CatalogStore.open('${root.path}/catalog/catalog.db')
      ..author = 'test';
  });
  tearDown(() {
    store.close();
    root.deleteSync(recursive: true);
  });

  test('a traversal name reads nothing and deletes nothing', () {
    final outside = File('${root.path}/secret.jpg')
      ..writeAsBytesSync(Uint8List.fromList([1, 2, 3]));
    // The images dir sits under catalog/; two levels up is the root.
    const hostile = '../../secret';
    expect(store.imageBytes(hostile), isNull);
    final cat = store.createCat('Sissi');
    // A deletion entry naming the hostile hash, as a bundle would send.
    store.append(cat, '\$image:$hostile', 'deleted');
    expect(outside.existsSync(), isTrue);
    expect(outside.readAsBytesSync(), [1, 2, 3]);
  });

  test('a real hash still round-trips', () {
    final cat = store.createCat('Sissi');
    final hash = store.addImage(
        cat, CatalogStore.compressImage(Uint8List.fromList(_jpeg())));
    expect(store.imageBytes(hash), isNotNull);
    expect(hash, matches(RegExp(r'^[0-9a-f]{64}$')));
  });
}

List<int> _jpeg() => img.encodeJpg(img.Image(width: 4, height: 4));
