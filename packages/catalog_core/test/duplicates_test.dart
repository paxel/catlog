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

  test('normalized-equal names are exact duplicates, cats and clowders',
      () {
    store.createCat('Miezi');
    store.createCat(' miezi ');
    store.createClowder('Foster Home');
    store.createClowder('foster home');
    final dups = duplicateCandidates(store);
    expect(dups, hasLength(2));
    expect(dups.every((d) => d.tier == DuplicateTier.exact), isTrue);
    expect(dups.where((d) => d.cats), hasLength(1));
    expect(dups.where((d) => !d.cats), hasLength(1));
  });

  test('typo names need a shared attribute; littermates stay apart', () {
    final a = store.createCat('Miezi');
    final b = store.createCat('Mimzy');
    // Distance 2 without any shared attribute: no candidate yet.
    expect(duplicateCandidates(store), isEmpty);
    store.append(a, Keys.userField('gender'), 'female');
    store.append(b, Keys.userField('gender'), 'female');
    final dups = duplicateCandidates(store);
    expect(dups, hasLength(1));
    expect(dups.single.tier, DuplicateTier.fuzzy);
    expect(dups.single.matched, contains(Keys.name));

    // Littermates: same birthdate, different names — not duplicates.
    final c = store.createCat('Anton');
    final d = store.createCat('Berta');
    store.append(c, Keys.userField('birthdate'), '2026-05-01');
    store.append(d, Keys.userField('birthdate'), '2026-05-01');
    expect(
        duplicateCandidates(store)
            .where((x) => {x.a, x.b}.contains(c)),
        isEmpty);
  });

  test('equal chip IDs are exact even with unrelated names', () {
    final a = store.createCat('Minka');
    final b = store.createCat('Fundkatze');
    store.append(a, Keys.userField('chipid'), '276 0981 0234 5678');
    store.append(b, Keys.userField('chipid'), '276-09810-2345678');
    final dups = duplicateCandidates(store);
    expect(dups.single.tier, DuplicateTier.exact);
    expect(dups.single.matched, contains(Keys.userField('chipid')));
  });
}
