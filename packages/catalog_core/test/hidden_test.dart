import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  late CatalogStore a, b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'ben';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  test('hidden is per-device and reversible', () {
    final cat = a.createCat('Wallflower');
    expect(a.isHidden(cat), isFalse);
    a.setHidden(cat, true);
    expect(a.isHidden(cat), isTrue);
    expect(a.hiddenIds(), [cat]);
    a.setHidden(cat, false);
    expect(a.isHidden(cat), isFalse);
    expect(a.hiddenIds(), isEmpty);
  });

  test('hidden entities still sync unchanged', () {
    final cat = a.createCat('Wallflower');
    a.setHidden(cat, true);
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    expect(b.cats().map((c) => c.id), contains(cat));
    expect(b.isHidden(cat), isFalse);
  });

  test('hidden follows the merge survivor', () {
    final keep = a.createCat('Keep');
    final lose = a.createCat('Lose');
    a.setHidden(lose, true);
    a.mergeCat(lose, keep);
    // The loser's hidden flag targets the survivor after resolution.
    expect(a.isHidden(lose), a.isHidden(keep));
  });
}
