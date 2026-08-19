import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
  });

  tearDown(() => store.close());

  test('normalized-equal chip IDs surface as an exact match', () {
    final a = store.createCat('Minka');
    final b = store.createCat('Fundkatze');
    store.append(a, Keys.userField('chipid'), '276-0981 0234 5678');
    store.append(b, Keys.userField('chipid'), '27609810 2345678');
    final matches = matchCandidates(store);
    expect(matches, hasLength(1));
    expect(matches.single.reason, MatchReason.idExact);
    expect(matches.single.idField!.slug, 'chipid');
  });

  test('a stray sighted inside the flier circle is a geo candidate', () {
    final missing = store.createCat('Minka');
    store.recordPosition(missing, 48.1000, 11.5000,
        kind: PositionKind.flier);
    final near = store.createCat('Nearby');
    // ~330 m north of the flier.
    store.recordPosition(near, 48.1030, 11.5000);
    final far = store.createCat('Far');
    store.recordPosition(far, 48.2000, 11.5000);

    final matches = matchCandidates(store);
    expect(matches, hasLength(1));
    final m = matches.single;
    expect(m.reason, MatchReason.geoDate);
    expect({m.a, m.b}, {missing, near});
    expect(m.distanceMeters, closeTo(334, 20));
  });

  test('an ID match swallows the geo pair for the same two cats', () {
    final a = store.createCat('A');
    final b = store.createCat('B');
    store.append(a, Keys.userField('chipid'), '111111111111111');
    store.append(b, Keys.userField('chipid'), '111111111111111');
    store.recordPosition(a, 48.1, 11.5);
    store.recordPosition(b, 48.1001, 11.5);
    final matches = matchCandidates(store);
    expect(matches, hasLength(1));
    expect(matches.single.reason, MatchReason.idExact);
  });
}
