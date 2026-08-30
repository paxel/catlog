import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Unit Values: stored in base units, entered and shown in the device's.
void main() {
  setUpAll(useSystemSqlite);

  test('kilograms and pounds meet in grams', () {
    expect(baseString(toBase(Dimension.weight, UnitSystem.metric, 4.25)),
        '4250');
    expect(baseString(toBase(Dimension.weight, UnitSystem.imperial, 9.4)),
        '4263.8');
    expect(fromBase(Dimension.weight, UnitSystem.imperial, 4250),
        closeTo(9.37, 0.01));
    expect(toBase(Dimension.temperature, UnitSystem.imperial, 212), 100);
    expect(fromBase(Dimension.length, UnitSystem.imperial, 2.54), 1);
  });

  test('display picks the readable unit and drops noise', () {
    expect(formatBase(Dimension.weight, UnitSystem.metric, '4250'), '4.25 kg');
    expect(formatBase(Dimension.weight, UnitSystem.metric, '980'), '980 g');
    expect(formatBase(Dimension.weight, UnitSystem.metric, '4000'), '4 kg');
    expect(formatBase(Dimension.weight, UnitSystem.imperial, '4250'), '9.4 lb');
    expect(formatBase(Dimension.length, UnitSystem.metric, '120'), '120 cm');
    expect(formatBase(Dimension.volume, UnitSystem.metric, '250'), '250 ml');
    expect(formatBase(Dimension.temperature, UnitSystem.imperial, '38.5'),
        '101.3 °F');
    expect(formatBase(Dimension.weight, UnitSystem.metric, 'heavy'), 'heavy');
    expect(parseEntry('4,25'), 4.25);
    expect(parseEntry('four'), isNull);
  });

  test('Weight is a starter Unit Value field of weight', () {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final weight = store.fieldDefs().firstWhere((d) => d.slug == 'weight');
    expect(weight.type, FieldType.unitValue);
    expect(weight.dimension, Dimension.weight);
    expect(weight.scope, FieldScope.cat);
    store.defineField('Body temperature', FieldType.unitValue,
        scope: FieldScope.cat, dimension: Dimension.temperature);
    final temp = store.fieldDefs().firstWhere((d) => d.slug == 'body-temperature');
    expect(temp.dimension, Dimension.temperature);
  });
  formatDecimalTests();
  entryUnitDisplayTests();
  dimensionDefaultTests();
}

void formatDecimalTests() {
  test('formatDecimal keeps at most the asked decimals, no trailing zeros',
      () {
    expect(formatDecimal(4.25, 2), '4.25');
    expect(formatDecimal(4.0, 2), '4');
    expect(formatDecimal(4.10, 2), '4.1');
    expect(formatDecimal(4.256, 2), '4.26');
    expect(formatDecimal(-0.004, 2), '0');
    expect(formatDecimal(980, 0), '980');
  });
}

void dimensionDefaultTests() {
  test('a unit value without a stored dimension counts as weight', () {
    const bare = FieldDef(
        id: 'fielddef:x',
        slug: 'x',
        name: 'X',
        type: FieldType.unitValue,
        scope: FieldScope.cat);
    expect(bare.unitDimension, Dimension.weight);
    const len = FieldDef(
        id: 'fielddef:y',
        slug: 'y',
        name: 'Y',
        type: FieldType.unitValue,
        scope: FieldScope.cat,
        dimension: Dimension.length);
    expect(len.unitDimension, Dimension.length);
  });
}

void entryUnitDisplayTests() {
  test('length and volume read in the entry unit, never scaled up', () {
    expect(formatBase(Dimension.length, UnitSystem.metric, '250'), '250 cm');
    expect(formatBase(Dimension.volume, UnitSystem.metric, '1500'), '1500 ml');
    expect(formatBase(Dimension.weight, UnitSystem.metric, '4250'), '4.25 kg');
    expect(formatBase(Dimension.weight, UnitSystem.metric, '980'), '980 g');
  });
}
