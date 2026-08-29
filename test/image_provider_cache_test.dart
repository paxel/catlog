import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/image_provider_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// A provider recreated after the LRU let it go is still the same key
/// to the engine — the disposed-stream race needs a changed key.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('providers compare by hash across eviction', (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final cat = store.createCat('Sissi');
    final hashes = <String>[];
    for (var i = 0; i < 70; i++) {
      hashes.add(store.addImage(
          cat,
          CatalogStore.compressImage(Uint8List.fromList(
              img.encodeJpg(img.Image(width: 8 + i, height: 8))))));
    }
    final first = imageProviderFor(store, hashes.first)!;
    for (final h in hashes.skip(1)) {
      imageProviderFor(store, h);
    }
    final again = imageProviderFor(store, hashes.first)!;
    expect(identical(first, again), isFalse, reason: 'evicted meanwhile');
    expect(again, equals(first));
    expect(again.hashCode, first.hashCode);

    await tester.pumpWidget(MaterialApp(
        home: Image(image: ResizeImage(again, width: 32))));
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
