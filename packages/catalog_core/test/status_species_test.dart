import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  late CatalogStore store;

  setUp(() => store = CatalogStore.inMemory()..author = 'anna');
  tearDown(() => store.close());

  test('new catalogs carry species and status starter fields', () {
    final slugs = store.fieldDefs().map((d) => d.slug);
    expect(slugs, contains('species'));
    expect(slugs, contains('status'));
    final status = store.fieldDefs().firstWhere((d) => d.slug == 'status');
    expect(status.options, clowderStatusKeys);
    expect(status.scope, FieldScope.clowder);
  });

  test('a new cat is a cat by default', () {
    final cat = store.createCat('Miezi');
    expect(store.current(cat, 'f:species'), 'cat');
  });

  test('status accepts canonical and free-text values alike', () {
    final home = store.createClowder('Barn next door');
    store.append(home, 'f:status', 'forever-home');
    expect(store.current(home, 'f:status'), 'forever-home');
    store.append(home, 'f:status', 'Oma Erna');
    expect(store.current(home, 'f:status'), 'Oma Erna');
  });
}
