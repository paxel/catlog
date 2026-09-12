import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/pdf_fonts.dart';
import 'package:catlog/src/screens/vet_report_screen.dart';
import 'package:catlog/src/vet_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/widgets.dart' as pw;

/// The vet report: which entries go in, the age line, the PDF with
/// summary and curve, and the page that picks it all.
void main() {
  setUpAll(() async {
    useSystemSqlite();
    await initializeDateFormatting('en');
  });

  late CatalogStore store;
  late String cat;
  late FieldDef weight;
  late FieldDef remarks;

  setUp(() {
    store = CatalogStore.inMemory()..author = 'anna';
    final home = store.createClowder('Home');
    store.append(home, 'f:phone', '+49 30 1');
    cat = store.createCat('Miezi', clowderId: home);
    weight = store.fieldDefs().firstWhere((d) => d.slug == 'weight');
    remarks = store.fieldDefs().firstWhere((d) => d.slug == 'remarks');
    store.append(cat, 'f:birthdate', '2020-05-01');
    store.append(cat, weight.key, '4000', date: DateTime(2026, 1, 10, 9));
    store.append(cat, weight.key, '4200', date: DateTime(2026, 2, 10, 9));
    store.append(cat, remarks.key, 'Sneezing', date: DateTime(2026, 2, 10, 11));
    store.append(cat, remarks.key, 'Fine', date: DateTime(2026, 3, 1));
  });

  tearDown(() => store.close());

  test('entries come oldest first, inside the range, facts only', () {
    final fields = reportableFields(store, cat);
    expect(fields.map((d) => d.slug), containsAll(['weight', 'remarks']));
    final rows = reportEntries(
      store,
      cat,
      [weight, remarks],
      DateTime(2026, 2, 1),
      DateTime(2026, 2, 28),
    );
    expect(rows.map((e) => e.value), ['4200', 'Sneezing']);
  });

  test('the age reads in years and months', () {
    final t = lookupAppLocalizations(const Locale('en'));
    expect(ageText(t, '2020-05-01', DateTime(2026, 9, 11)), '6 years 4 months');
    expect(ageText(t, '2026-08-01', DateTime(2026, 9, 11)), '1 months');
    expect(ageText(t, null, DateTime(2026, 9, 11)), isNull);
  });

  testWidgets('the PDF builds with summary, timeline and a curve', (
    tester,
  ) async {
    // Off-screen rendering needs real async: runAsync.
    await tester.runAsync(() async {
      final t = lookupAppLocalizations(const Locale('en'));
      final fonts = await pdfFontsFor('en');
      final png = await curvePng(
        [
          (at: DateTime(2026, 1, 10), value: 4.0),
          (at: DateTime(2026, 2, 10), value: 4.2),
        ],
        DateTime(2026, 1, 1),
        DateTime(2026, 3, 1),
        reportColour(0),
        'en',
      );
      expect(png, isNotNull);
      final doc = vetReportPdf(
        t: t,
        store: store,
        catId: cat,
        fields: [weight, remarks],
        entries: reportEntries(
          store,
          cat,
          [weight, remarks],
          DateTime(2026, 1, 1),
          DateTime(2026, 3, 31),
        ),
        curves: [(def: weight, png: png!)],
        summary: true,
        locale: 'en',
        fonts: fonts,
        today: DateTime(2026, 9, 11),
      );
      final bytes = await doc.save();
      expect(bytes.length, greaterThan(5000));
    });
  });

  testWidgets('the page unticks a row and shares the rest', (tester) async {
    pw.Document? shared;
    String? fileName;
    tester.view.physicalSize = const Size(500, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: VetReportScreen(
          store: store,
          catId: cat,
          share: (doc, name) async {
            shared = doc;
            fileName = name;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Patient summary'), findsOneWidget);
    expect(find.textContaining('Sneezing'), findsOneWidget);
    await tester.tap(find.textContaining('Sneezing'));
    await tester.pump();
    // The curve renders off screen: real async, then let the page settle.
    await tester.runAsync(() async {
      await tester.tap(find.byTooltip('Share as PDF'));
      await tester.pump();
      for (var i = 0; i < 300 && shared == null; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
    });
    await tester.pumpAndSettle();
    expect(shared, isNotNull);
    expect(fileName, 'Miezi Report for the vet.pdf');
  });
}
