import 'dart:io';

import 'package:catlog/src/map/cached_tiles.dart';
import 'package:flutter_test/flutter_test.dart';

/// The tile folder is trimmed to its cap, oldest tiles first.
void main() {
  test('trimming keeps the newest tiles under the cap', () {
    final dir = Directory.systemTemp.createTempSync('catlog-tiles');
    addTearDown(() => dir.deleteSync(recursive: true));
    for (var i = 0; i < 5; i++) {
      File('${dir.path}/t$i.png')
        ..writeAsBytesSync(List<int>.filled(1000, i))
        ..setLastModifiedSync(DateTime(2026, 1, 1 + i));
    }
    trimTileCache(dir, 2500);
    final left = dir.listSync().map((f) => f.uri.pathSegments.last).toSet();
    expect(left, {'t3.png', 't4.png'});
    // Under the cap: nothing touched.
    trimTileCache(dir, 2500);
    expect(dir.listSync(), hasLength(2));
  });
}
