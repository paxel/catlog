import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Breeds by species (#95): the option list of a species learns a
/// typed breed; cats and unknown species do not.
void main() {
  setUpAll(useSystemSqlite);

  test('a breed typed for a dog is offered for the next dog only', () {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final dog = store.createCat('Rex', species: 'dog');
    final cat = store.createCat('Miezi');
    FieldDef breed() => store.fieldDefs().firstWhere((d) => d.slug == 'breed');
    store.append(dog, breed().key, 'Whippet');
    store.learnBreed(dog, 'Whippet');
    expect(breedOptions(breed(), 'dog'), contains('Whippet'));
    expect(breedOptions(breed(), 'cat'), isNot(contains('Whippet')));
    // A known breed and a cat's breed change nothing.
    store.learnBreed(dog, 'Beagle');
    store.learnBreed(cat, 'Tabby Mix');
    expect(breed().extraOptions['dog'], ['Whippet']);
    expect(breed().extraOptions['cat'], isNull);
    expect(breed().options, isNot(contains('Tabby Mix')));
  });
}
