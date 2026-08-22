import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(useSystemSqlite);

  test('normalizeId: exact after trim, case-fold, strip spaces/hyphens', () {
    expect(normalizeId(' 276-0981 2345-678 '), '27609812345678');
    expect(normalizeId('ABC 123'), 'abc123');
    expect(normalizeId(normalizeId('abc-123')), normalizeId('ABC 123'));
  });

  test('ID field definitions round-trip their display format', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    store.defineField('Tasso', FieldType.id, idDisplay: IdDisplay.qr);
    final def = store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(def.type, FieldType.id);
    expect(def.idDisplay, IdDisplay.qr);
    // Plain is the default and needs no entry.
    store.defineField('Ring number', FieldType.id);
    final ring =
        store.fieldDefs().firstWhere((d) => d.slug == 'ring-number');
    expect(ring.idDisplay, IdDisplay.plain);
  });

  test('Chip ID starter is seeded as a barcode ID field on cats', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    final chip = store.fieldDefs().firstWhere((d) => d.slug == 'chipid');
    expect(chip.type, FieldType.id);
    expect(chip.scope, FieldScope.cat);
    expect(chip.idDisplay, IdDisplay.barcode);
  });
}
