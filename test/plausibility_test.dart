import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/plausibility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  FieldDef def(String slug) =>
      store.fieldDefs().firstWhere((d) => d.slug == slug);

  Objection? check(String slug, String? value) => starterFieldObjection(
      store, cat, def(slug), value,
      today: DateTime(2026, 8, 18));

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Sissi');
  });

  tearDown(() => store.close());

  test('birth date in the future is refused', () {
    expect(check('birthdate', '2050-01-01')?.kind,
        ObjectionKind.birthdateInFuture);
  });

  test('date of death in the future is refused', () {
    expect(
        check('deceased', '2050-01-01')?.kind, ObjectionKind.deceasedInFuture);
  });

  test('death before birth is refused, with the birth date named', () {
    store.append(cat, def('birthdate').key, '2020-05-01');
    final objection = check('deceased', '2019-01-01');
    expect(objection?.kind, ObjectionKind.deceasedBeforeBirth);
    expect(objection?.date, DateTime(2020, 5, 1));
  });

  test('birth after death is refused, with the death date named', () {
    store.append(cat, def('deceased').key, '2020-05-01');
    final objection = check('birthdate', '2021-01-01');
    expect(objection?.kind, ObjectionKind.bornAfterDeceased);
    expect(objection?.date, DateTime(2020, 5, 1));
  });

  test('a male cat cannot be pregnant', () {
    store.append(cat, def('gender').key, 'male');
    expect(check('pregnant', 'yes')?.kind, ObjectionKind.malePregnant);
    expect(check('pregnant', 'no'), isNull);
  });

  test('plausible values pass', () {
    expect(check('birthdate', '2020-05-01'), isNull);
    store.append(cat, def('birthdate').key, '2020-05-01');
    expect(check('deceased', '2024-01-01'), isNull);
    store.append(cat, def('gender').key, 'female');
    expect(check('pregnant', 'yes'), isNull);
  });

  test('clearing a value is always fine', () {
    store.append(cat, def('birthdate').key, '2020-05-01');
    expect(check('birthdate', null), isNull);
    expect(check('deceased', ''), isNull);
  });

  test('a female cat cannot be the father, nor a male one the mother',
      () {
    final dad = store.createCat('Kater');
    store.append(dad, Keys.userField('gender'), 'female');
    final objection = check('father', dad);
    expect(objection?.kind, ObjectionKind.fatherNotMale);
    expect(objection?.name, 'Kater');

    final mom = store.createCat('Miez');
    store.append(mom, Keys.userField('gender'), 'male');
    expect(check('mother', mom)?.kind, ObjectionKind.motherNotFemale);
  });

  test('a parent cannot be born after its kitten', () {
    final dad = store.createCat('Kater');
    store.append(dad, Keys.userField('gender'), 'male');
    store.append(dad, Keys.userField('birthdate'), '2024-01-01');
    store.append(cat, Keys.userField('birthdate'), '2022-01-01');
    final objection = check('father', dad);
    expect(objection?.kind, ObjectionKind.parentBornAfterKitten);
    expect(objection?.date, DateTime(2024, 1, 1));
    // Older parent is fine.
    store.append(dad, Keys.userField('birthdate'), '2020-01-01');
    expect(check('father', dad), isNull);
  });

  test('a recorded parent role pins the plausible gender', () {
    final dad = store.createCat('Kater');
    store.append(cat, Keys.userField('father'), dad);
    expect(
        starterFieldObjection(store, dad,
            store.fieldDefs().firstWhere((d) => d.slug == 'gender'),
            'female',
            today: DateTime(2026, 8, 18))?.kind,
        ObjectionKind.genderFatherFemale);
    expect(
        starterFieldObjection(store, dad,
            store.fieldDefs().firstWhere((d) => d.slug == 'gender'),
            'male',
            today: DateTime(2026, 8, 18)),
        isNull);
  });

  test('custom fields are never checked', () {
    final id = store.defineField('Next vet visit', FieldType.date,
        scope: FieldScope.cat);
    final custom = store.fieldDefs().firstWhere((d) => d.id == id);
    expect(
        starterFieldObjection(store, cat, custom, '2050-01-01',
            today: DateTime(2026, 8, 18)),
        isNull);
  });
}
