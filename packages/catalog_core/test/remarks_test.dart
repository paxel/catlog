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

  test('Remarks starter exists on cats and clowders', () {
    final def = store.fieldDefs().firstWhere((d) => d.slug == 'remarks');
    expect(def.type, FieldType.text);
    expect(def.scope, FieldScope.both);
  });

  test('search finds cats by remarks text, case-insensitive', () {
    final cat = store.createCat('Sissi');
    store.append(cat, Keys.userField('remarks'), 'Scar over LEFT eye');
    expect(store.searchCats('left eye').single.id, cat);
    expect(store.searchCats('sissi').single.id, cat);
    expect(store.searchCats('right eye'), isEmpty);
  });
}
