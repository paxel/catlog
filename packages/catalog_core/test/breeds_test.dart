import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// The breed list: what a new catalog gets, and what an older one is
/// given on open without losing what its keepers added.
void main() {
  setUpAll(useSystemSqlite);

  test('a new catalog offers the whole list, mixed last', () {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final breed = store.fieldDefs().firstWhere((d) => d.slug == 'breed');
    expect(breed.options, catBreeds);
    expect(breed.options.last, 'mixed');
    expect(
        breed.options, containsAll(['Burmese', 'Abyssinian', 'Russian Blue']));
  });

  test('an older catalog gets the newcomers appended, own entries kept', () {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final breed = store.fieldDefs().firstWhere((d) => d.slug == 'breed');
    // The 1.2.2 list plus a keeper's own breed.
    store.setFieldOptions(
        breed.id, ['European Shorthair', 'Maine Coon', 'Hauskatze', 'mixed']);
    // Seeding runs on every open; here it runs again by hand.
    store.reseedStarterFields();
    final after = store.fieldDefs().firstWhere((d) => d.slug == 'breed');
    expect(after.options.take(3),
        ['European Shorthair', 'Maine Coon', 'Hauskatze']);
    expect(after.options, contains('Burmese'));
    expect(after.options.last, 'mixed');
    expect(after.options.where((o) => o == 'mixed').length, 1);
  });
}
