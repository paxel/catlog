import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  test('stored forms round-trip with their precision', () {
    expect(PartialDate.parse('2021')!.iso, '2021');
    expect(PartialDate.parse('2021-05')!.iso, '2021-05');
    expect(PartialDate.parse('2021-05-14')!.iso, '2021-05-14');
    expect(PartialDate.parse('2021-5')?.iso, isNull);
    expect(PartialDate.parse('2021-02-30'), isNull);
    expect(PartialDate.parse('yesterday'), isNull);
  });

  test('typed spellings resolve day first', () {
    expect(PartialDate.parseLoose('14.05.2021')!.iso, '2021-05-14');
    expect(PartialDate.parseLoose('5.6.2025')!.iso, '2025-06-05');
    expect(PartialDate.parseLoose('14/05/2021')!.iso, '2021-05-14');
    expect(PartialDate.parseLoose('5/2021')!.iso, '2021-05');
    expect(PartialDate.parseLoose('05.2021')!.iso, '2021-05');
    expect(PartialDate.parseLoose('2021/5')!.iso, '2021-05');
    expect(PartialDate.parseLoose(' 2021 ')!.iso, '2021');
    expect(PartialDate.parseLoose('31.02.2021'), isNull);
    expect(PartialDate.parseLoose('13/2021'), isNull);
  });

  test('a poster line yields the first date in it', () {
    expect(PartialDate.find('Verlustdatum: 05.06.2025')!.iso, '2025-06-05');
    expect(PartialDate.find('vermisst seit 05/2026')!.iso, '2026-05');
    expect(PartialDate.find('Geburtsdatum: 2021')!.iso, '2021');
    expect(PartialDate.find('Tel 0170 12345678'), isNull);
  });

  test('plain string order matches precision order', () {
    final dates = ['2021-05-14', '2021', '2020-12-31', '2021-05']..sort();
    expect(dates, ['2020-12-31', '2021', '2021-05', '2021-05-14']);
  });

  test('period bounds never pad the stored value', () {
    final year = PartialDate.parse('2021')!;
    expect(year.earliest, DateTime(2021, 1, 1));
    expect(year.latest, DateTime(2021, 12, 31));
    final month = PartialDate.parse('2024-02')!;
    expect(month.latest, DateTime(2024, 2, 29));
    expect(month.isFull, isFalse);
    expect(PartialDate.parse('2024-02-29')!.isFull, isTrue);
  });

  test('age follows the precision', () {
    final today = DateTime(2026, 8, 29);
    expect(
        PartialDate.parse('2023-03-14')!.ageAt(today), (years: 3, months: 5));
    expect(
        PartialDate.parse('2023-08-30')!.ageAt(today), (years: 2, months: 11));
    expect(PartialDate.parse('2023-03')!.ageAt(today), (years: 3, months: 5));
    expect(PartialDate.parse('2023')!.ageAt(today), (years: 3, months: null));
    expect(PartialDate.parse('2027')!.ageAt(today), isNull);
  });
}
