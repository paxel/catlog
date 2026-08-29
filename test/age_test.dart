import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/age.dart';
import 'package:flutter_test/flutter_test.dart';

/// Age follows the birth date's precision (#80, #76) and stops at death.
void main() {
  setUpAll(useSystemSqlite);
  final t = AppLocalizationsEn();
  final today = DateTime(2026, 8, 29);

  late CatalogStore store;
  late String cat;
  setUp(() {
    store = CatalogStore.inMemory()..author = 'test';
    cat = store.createCat('Sissi');
  });
  tearDown(() => store.close());

  void born(String value) =>
      store.append(cat, Keys.userField('birthdate'), value);

  test('a full or month date gives years and months', () {
    born('2023-03-14');
    expect(ageDisplay(t, store, cat, today: today), '3 yrs 5 mo');
    born('2023-03');
    expect(ageDisplay(t, store, cat, today: today), '3 yrs 5 mo');
  });

  test('a bare year gives years only, a kitten months only', () {
    born('2023');
    expect(ageDisplay(t, store, cat, today: today), '3 yrs');
    born('2026-05-01');
    expect(ageDisplay(t, store, cat, today: today), '3 mo');
    born('2026');
    expect(ageDisplay(t, store, cat, today: today), '0 yrs');
  });

  test('death freezes the age', () {
    born('2010-06-01');
    store.append(cat, Keys.userField('deceased'), '2024-01-15');
    expect(ageDisplay(t, store, cat, today: today), '13 yrs 7 mo †');
  });

  test('no birth date, no age', () {
    expect(ageDisplay(t, store, cat, today: today), isNull);
  });
}
