import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Sissi');
  });

  tearDown(() => store.close());

  test('plain values are sightings; flier values carry the marker', () {
    expect(CatalogStore.parsePositionKind('48.1,11.5'),
        PositionKind.sighting);
    expect(CatalogStore.parsePositionKind('48.1,11.5@flier'),
        PositionKind.flier);
    // Coordinates parse for both kinds.
    expect(CatalogStore.parsePosition('48.1,11.5@flier'), (48.1, 11.5));
  });

  test('sighting position skips flier entries', () {
    store.recordPosition(cat, 48.1, 11.5);
    store.recordPosition(cat, 50.0, 8.0, kind: PositionKind.flier);
    // Latest overall is the flier, latest sighting is the older entry.
    expect(store.positionOf(cat), (50.0, 8.0));
    expect(store.sightingPositionOf(cat), (48.1, 11.5));
    expect(store.flierPositions(cat), [(50.0, 8.0)]);
  });

  test('a flier-only stray has no sighting position but is valid', () {
    store.recordPosition(cat, 50.0, 8.0, kind: PositionKind.flier);
    expect(store.sightingPositionOf(cat), isNull);
    expect(store.strays().single.id, cat);
    expect(store.searchCats('sissi').single.id, cat);
  });
}
