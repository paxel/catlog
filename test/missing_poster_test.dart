import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/missing_poster.dart';
import 'package:catlog/src/pdf_fonts.dart';
import 'package:catlog/src/screens/missing_poster_screen.dart';
import 'package:catlog/src/widgets/poster_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;

/// The missing poster: one page from the ticked record, phone in the
/// band, a code row at the bottom, the titles giving way to the lines.
void main() {
  setUpAll(useSystemSqlite);

  final photo = img.encodePng(img.Image(width: 40, height: 30));

  test('the poster builds with photos, lines and codes', () async {
    final fonts = await pdfFontsFor('en');
    final full = missingPosterPdf(
      PosterContent(
        headline: 'MISSING',
        name: 'Miezi',
        photos: [
          PosterPhoto(photo),
          PosterPhoto(photo, x: 0.2, y: 0.1, w: 0.5, h: 0.5),
        ],
        lines: const [
          'Missing since: 9/1/2026',
          'Address: Grimmaische Straße 12',
          'Chip ID: 276098100123456',
        ],
        phone: '+49 30 1234567',
        looks: 'Size: Medium · Colours: Black, White',
        standing: 'Please check cellars, sheds and garages.',
        codes: const [
          PosterCode('catlog:abc', 'QR code for cat(a)log'),
          PosterCode('https://tasso.net/?id=276098100123456', 'Chip ID'),
          PosterCode('geo:51.34,12.37', 'Position'),
        ],
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
      ),
      fonts,
    );
    expect((await bare.save()).length, greaterThan(500));
  });

  test('the headline gives way before the name, the name before the lines', () {
    final few = posterTitleSizes(
      lines: const ['Missing since: 9/1/2026'],
      photos: true,
      phone: true,
      codes: true,
    );
    expect(few.headline, 62);
    expect(few.name, 96);
    final some = posterTitleSizes(
      lines: List.filled(3, 'Label: value'),
      photos: true,
      phone: true,
      codes: true,
    );
    expect(some.headline, lessThan(62));
    expect(some.name, greaterThan(90));
    final many = posterTitleSizes(
      lines: List.filled(14, 'Label: value'),
      photos: true,
      phone: true,
      codes: true,
    );
    expect(many.headline, 38);
    expect(many.name, lessThan(96));
    expect(many.name, greaterThanOrEqualTo(52));
  });

  test('two frames share the row, one takes it', () {
    expect(posterFrameAspect(1, 0), greaterThan(posterFrameAspect(2, 0)));
    expect(posterFrameAspect(2, 0), posterFrameAspect(2, 1));
  });

  testWidgets('a gallery picture joins the poster at full size', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    PosterContent? built;
    tester.view.physicalSize = const Size(500, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MissingPosterScreen(
          store: store,
          catId: cat,
          pickPhoto: (_) async => photo,
          preview: (_) async => null,
          share: (doc, name) async {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(PosterFrame), findsNothing);
    await tester.tap(find.byTooltip('Choose from gallery'));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pumpAndSettle();
    expect(find.byType(PosterFrame), findsOneWidget);
    expect(built, isNull);
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
    store.append(cat, 'f:gender', 'female');
    store.append(cat, 'f:chipid', '276098100123456');
    pw.Document? shared;
    String? fileName;
    var previews = 0;
    tester.view.physicalSize = const Size(500, 1800);
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
          preview: (pdf) async {
            previews++;
            return photo;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    // The preview draws half a second after the page opens, and again
    // half a second after a tick changes.
    expect(find.text('Preview'), findsNothing);
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
    expect(find.text('Preview'), findsOneWidget);
    expect(previews, 1);
    expect(find.text('Grimmaische Straße 12'), findsOneWidget);
    expect(find.text('+49 30 1'), findsOneWidget);
    // Every filled field is a row; ID, address and phone start ticked,
    // gender does not.
    Checkbox boxOf(String label) => tester.widget<Checkbox>(
      find.descendant(
        of: find.ancestor(
          of: find.text(label),
          matching: find.byType(CheckboxListTile),
        ),
        matching: find.byType(Checkbox),
      ),
    );
    expect(boxOf('Chip ID').value, isTrue);
    expect(boxOf('Address').value, isTrue);
    expect(boxOf('Gender').value, isFalse);
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    expect(boxOf('Gender').value, isTrue);
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
    expect(previews, 2);
    await tester.enterText(find.byType(TextField), 'Answers to Miezi');
    await tester.tap(find.byTooltip('Share as PDF'));
    await tester.pumpAndSettle();
    expect(shared, isNotNull);
    expect(fileName, 'Miezi MISSING.pdf');
  });
}
