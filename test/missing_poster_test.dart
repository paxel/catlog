import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/missing_poster.dart';
import 'package:catlog/src/pdf_fonts.dart';
import 'package:catlog/src/screens/missing_poster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/widgets.dart' as pw;

/// The missing poster: one page from the ticked record, phone in the
/// band, QR code when the payload is small enough.
void main() {
  setUpAll(useSystemSqlite);

  test('the poster builds with and without a QR code', () async {
    final fonts = await pdfFontsFor('en');
    final full = missingPosterPdf(
      const PosterContent(
        headline: 'MISSING',
        name: 'Miezi',
        since: 'Missing since: 9/1/2026',
        place: 'Last seen near Grimmaische Straße 12',
        phone: '+49 30 1234567',
        looks: 'Size: Medium · Colours: Black, White',
        standing: 'Please check cellars, sheds and garages.',
        qr: 'catlog:abc',
        qrCaption: 'QR code for cat(a)log',
      ),
      fonts,
    );
    final bytes = await full.save();
    expect(bytes.length, greaterThan(1000));
    final bare = missingPosterPdf(
      const PosterContent(
        headline: 'MISSING',
        name: 'Miezi',
        standing: 'Please call.',
        qrCaption: 'QR',
      ),
      fonts,
    );
    expect((await bare.save()).length, greaterThan(500));
  });

  testWidgets('the page ticks the record and shares the poster', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final home = store.createClowder('Home');
    store.append(home, 'f:address', 'Grimmaische Straße 12');
    store.append(home, 'f:phone', '+49 30 1');
    final cat = store.createCat('Miezi', clowderId: home);
    pw.Document? shared;
    String? fileName;
    tester.view.physicalSize = const Size(500, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MissingPosterScreen(
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
    expect(find.text('Grimmaische Straße 12'), findsOneWidget);
    expect(find.text('+49 30 1'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Answers to Miezi');
    await tester.tap(find.byTooltip('Share as PDF'));
    await tester.pumpAndSettle();
    expect(shared, isNotNull);
    expect(fileName, 'Miezi MISSING.pdf');
  });
}
