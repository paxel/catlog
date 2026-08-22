import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() => store = CatalogStore.inMemory()..author = 'anna');
  tearDown(() => store.close());

  test('family derives littermates, siblings, and kittens from mother',
      () {
    final mom = store.createCat('Queen');
    final a = store.createCat('A');
    final b = store.createCat('B');
    final c = store.createCat('C');
    for (final kitten in [a, b, c]) {
      store.append(kitten, 'f:mother', mom);
    }
    store.append(a, 'f:birthdate', '2026-05-01');
    store.append(b, 'f:birthdate', '2026-05-01');
    store.append(c, 'f:birthdate', '2025-11-11');

    final fa = store.family(a);
    expect(fa.mother, mom);
    expect(fa.littermates, [b]);
    expect(fa.siblings, [c]);
    final fm = store.family(mom);
    expect(fm.kittens.toSet(), {a, b, c});
  });

  test('mother references survive a merge of the mother', () {
    final mom1 = store.createCat('Queen');
    final mom2 = store.createCat('Queeny');
    final kitten = store.createCat('Kit');
    store.append(kitten, 'f:mother', mom2);
    store.mergeCat(mom2, mom1);
    expect(store.family(kitten).mother, mom1);
    expect(store.family(mom1).kittens, [kitten]);
  });

  test('starter fields include mother and father as cat references', () {
    final defs = store.fieldDefs();
    expect(defs.firstWhere((d) => d.slug == 'mother').type, FieldType.cat);
    expect(defs.firstWhere((d) => d.slug == 'father').type, FieldType.cat);
  });

  test('the father sees his kittens too', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    final dad = store.createCat('Kater');
    final kitten = store.createCat('Junges');
    store.append(kitten, Keys.userField('father'), dad);
    expect(store.family(dad).kittens, [kitten]);
    expect(store.family(kitten).father, dad);
  });
}
