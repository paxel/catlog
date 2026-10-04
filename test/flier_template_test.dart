import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/flier_template.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flier_fixtures.dart';

/// Rudi's poster as pairs: a different TASSO layout — no species row,
/// a composite "Geschlecht, kastriert" row, a month as birthday.
const _rudiPairs = [
  FlierPair(null, 'GESUCHT!'),
  FlierPair('Suchdienstnummer', 'S3098756'),
  FlierPair('Rasse', 'Europäisch Kurzhaar'),
  FlierPair('Farbe', 'rot'),
  FlierPair('Geburtsdatum', '5/2025'),
  FlierPair('Geschlecht, kastriert', 'männlich, kastriert'),
  FlierPair(null, 'Kater RUDI'),
  FlierPair('Kennzeichnung', 'Das Tier trägt einen Transponder.'),
  FlierPair('Verlustdatum', '10.08.2026'),
  FlierPair('Verlustort', '04229 Leipzig, Deutschland'),
  FlierPair(null, 'Haben Sie dieses Tier gesehen?'),
  FlierPair(null, '+49 6190 937300'),
  FlierPair(null, 'www.tasso.net/tier-gefunden'),
];

void main() {
  late FlierTemplateSet templates;

  setUpAll(() {
    templates = FlierTemplateSet.fromJson(
      File('assets/fliers/templates.json').readAsStringSync(),
    );
  });

  group('pairing', () {
    test('a label pairs with the value at its height, whatever the order', () {
      final pairs = pairLines(hugoLines());
      expect(pairs, contains(const FlierPair('Suchdienstnummer', 'S2983764')));
      expect(
        pairs,
        contains(
          const FlierPair(
            'Verlustort',
            '04207 Leipzig, Colberger Weg. Deutschland',
          ),
        ),
      );
      expect(pairs.where((p) => p.label != null), hasLength(8));
    });

    test('lone lines stay lone, body text never becomes a label', () {
      final pairs = pairLines(hugoLines());
      expect(pairs, contains(const FlierPair(null, 'Kater HUGO')));
      expect(pairs, contains(const FlierPair(null, 'GESUCHT!')));
      expect(
        pairs.map((p) => p.label),
        isNot(contains(startsWith('TASSO-Tipp'))),
      );
    });

    test('a value below, not beside, does not pair', () {
      final pairs = pairLines([
        flierLine('Name', 100, 100),
        flierLine('Minka', 100, 140),
      ]);
      expect(pairs, [
        const FlierPair(null, 'Name'),
        const FlierPair(null, 'Minka'),
      ]);
    });
  });

  group('template', () {
    test('the shipped file loads and knows TASSO', () {
      expect(templates.templates.map((t) => t.name), contains('TASSO'));
      expect(templates.templates.single.registry, 'Tasso');
    });

    test('Hugo is read as a TASSO poster, every row on its field', () {
      final reading = readFlier(pairLines(hugoLines()), templates);
      expect(reading.template?.name, 'TASSO');
      expect(reading.first(FlierTarget.registryNumber), 'S2983764');
      expect(reading.first(FlierTarget.name), 'HUGO');
      expect(reading.first('species'), 'cat');
      expect(reading.of('gender').map((e) => e.value), everyElement('male'));
      expect(reading.first('neutered'), 'yes');
      expect(reading.first('breed'), 'Europäische Langhaarkatze');
      expect(reading.first('color'), 'braun');
      expect(reading.first('birthdate'), '26.05.2024');
      expect(reading.first('chipid'), 'Das Tier ist gechipt.');
      expect(reading.first(FlierTarget.missingSince), '05.06.2025');
      expect(
        reading.first(FlierTarget.lostPlace),
        '04207 Leipzig, Colberger Weg. Deutschland',
      );
    });

    test('the registry hotline and mail are contact, never remarks fields', () {
      final reading = readFlier(pairLines(hugoLines()), templates);
      expect(
        reading.of(FlierTarget.contact).map((e) => e.value),
        containsAll([
          '06190/ 93 73 00',
          'Fax: 0 61 90/93 74 00 info@tasso.net www.tasso.net',
        ]),
      );
    });

    test('remarks keep only what no field took', () {
      final remarks = readFlier(pairLines(hugoLines()), templates).remarks();
      expect(remarks, contains('GESUCHT!'));
      expect(remarks, contains('TASSO-Tipp'));
      expect(remarks, contains('06190/ 93 73 00'));
      expect(remarks, isNot(contains('S2983764')));
      expect(remarks, isNot(contains('braun')));
    });

    test('Rudi: a composite row splits, a month stays a plain value', () {
      final reading = readFlier(_rudiPairs, templates);
      expect(reading.template?.name, 'TASSO');
      expect(reading.first('gender'), 'male');
      expect(reading.first('neutered'), 'yes');
      expect(reading.first(FlierTarget.name), 'RUDI');
      expect(reading.first('birthdate'), '5/2025');
      expect(parseFlierDate('5/2025'), PartialDate.parse('2025-05'));
      expect(
        reading.of(FlierTarget.contact).map((e) => e.value),
        containsAll(['+49 6190 937300', 'www.tasso.net/tier-gefunden']),
      );
    });

    test('a composite row with uneven parts sorts by word list', () {
      final reading = readFlier(const [
        FlierPair('Suchdienstnummer', 'S1'),
        FlierPair('Tierart, Geschlecht, Kastriert', 'Katze, weiblich'),
      ], templates);
      expect(reading.first('species'), 'cat');
      expect(reading.first('gender'), 'female');
      expect(reading.first('neutered'), isNull);
    });

    test('an unknown layout leaves everything in remarks', () {
      final reading = readFlier(const [
        FlierPair('Chip', '276098102345678'),
        FlierPair(null, 'MISSING: Minka'),
      ], templates);
      expect(reading.template, isNull);
      expect(
        reading.entries.map((e) => e.target),
        everyElement(FlierTarget.remarks),
      );
    });

    test('one matching label is a coincidence, not a match', () {
      expect(templates.match(const [FlierPair('Name', 'Minka')]), isNull);
    });
  });

  group('values', () {
    test('words turn into options, longest synonym first', () {
      expect(templates.normalize('neutered', 'kastriert'), 'yes');
      expect(templates.normalize('neutered', 'nicht kastriert'), 'no');
      expect(templates.normalize('gender', 'Männlich'), 'male');
      expect(templates.normalize('species', 'Katze'), 'cat');
      expect(templates.normalize('color', 'braun'), 'braun');
      expect(templates.normalize('gender', 'unbekannt'), 'unbekannt');
    });

    test('dates as posters print them', () {
      expect(parseFlierDate('05.06.2025'), PartialDate.parse('2025-06-05'));
      expect(parseFlierDate('5.6.2025'), PartialDate.parse('2025-06-05'));
      expect(parseFlierDate('2025-06-05'), PartialDate.parse('2025-06-05'));
      expect(parseFlierDate('seit 5/6/2025'), PartialDate.parse('2025-06-05'));
      expect(parseFlierDate('31.02.2025'), isNull);
      expect(parseFlierDate('Sommer 2025'), PartialDate.parse('2025'));
    });

    group('hand-made spellings', () {
      final today = DateTime(2025, 10, 20);
      PartialDate? read(String s) => parseFlierDate(s, today: today);
      PartialDate day(String iso) => PartialDate.parse(iso)!;

      test('hyphens and two-digit years', () {
        expect(read('03-10-2025'), day('2025-10-03'));
        expect(read('Weggelaufen am 03.10.25'), day('2025-10-03'));
        expect(read('3/10/25'), day('2025-10-03'));
      });

      test('written months, German and English', () {
        expect(read('am 3. Oktober 2025'), day('2025-10-03'));
        expect(read('3 Okt. 2025'), day('2025-10-03'));
        expect(read('seit 1. März 2025'), day('2025-03-01'));
        expect(read('Oct 3, 2025'), day('2025-10-03'));
        expect(read('October 3rd 2025'), day('2025-10-03'));
        expect(read('lost on 3 October 2025'), day('2025-10-03'));
        expect(read('Oktober 2025'), PartialDate.parse('2025-10'));
      });

      test('no year: the latest such day not after today', () {
        expect(read('am 3.10.'), day('2025-10-03'));
        expect(read('3. Oktober'), day('2025-10-03'));
        expect(
          read('am 24.12.'),
          day('2024-12-24'),
          reason: 'Christmas lies ahead, so it was last year',
        );
        expect(read('Oct 20'), day('2025-10-20'), reason: 'today counts');
      });

      test('what is not a date stays none', () {
        expect(read('Gewicht 4.5 kg'), isNull);
        expect(read('31-02-2025'), isNull);
        expect(read('Tel. 0171 1234567'), isNull);
        expect(read('Mail an tasso'), isNull);
      });
    });
  });
}
