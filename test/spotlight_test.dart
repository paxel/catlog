import 'package:catlog/src/spotlight.dart';
import 'package:flutter_test/flutter_test.dart';

/// The seen-tracking is per item, so features added later in the same
/// version still get their tour — the 0.2.0 version-mark bug.
void main() {
  final items = spotlightManifest['cat']!;

  test('nothing seen: everything due, manifest order', () {
    expect(dueSpotlights('', items).map((i) => i.id),
        ['cat-edit', 'cat-menu']);
  });

  test('partially seen: only the new item is due', () {
    expect(dueSpotlights('cat-menu', items).map((i) => i.id),
        ['cat-edit']);
  });

  test('all seen: nothing due', () {
    expect(dueSpotlights('cat-edit,cat-menu', items), isEmpty);
  });

  test('every manifest item id has a unique anchor id', () {
    final ids = [
      for (final list in spotlightManifest.values)
        for (final item in list) item.id
    ];
    expect(ids.toSet().length, ids.length);
  });
}
