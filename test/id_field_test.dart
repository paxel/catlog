import 'package:barcode_widget/barcode_widget.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #28: ID fields — typed or scanned identifiers, rendered scannable on
/// the Card in the format the definition picked.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Sissi');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('Chip ID edits as text with a scan affordance',
      (tester) async {
    await pump(tester,
        CatDetailScreen(store: store, catId: cat, startEditing: true));
    await tester.ensureVisible(find.text('Chip ID'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chip ID'));
    await tester.pumpAndSettle();
    // The editor offers manual entry plus the scanner.
    expect(find.byIcon(Icons.qr_code_scanner), findsOneWidget);
    await tester.enterText(find.byType(TextField), '276098102345678');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(store.current(cat, Keys.userField('chipid')),
        '276098102345678');
  });

  testWidgets('the Card renders a barcode for the Chip ID',
      (tester) async {
    store.append(cat, Keys.userField('chipid'), '276098102345678');
    await pump(tester, CardScreen(store: store, catId: cat));
    await tester.pumpAndSettle();
    expect(find.byType(BarcodeWidget), findsOneWidget);
    // Once, not thrice: no fact row and no caption — Code128 prints the
    // number itself.
    expect(find.text('Chip ID: 276098102345678'), findsNothing);
    // The single "Chip ID" text left is the content-picker chip above
    // the card, not a card row.
    expect(find.text('Chip ID'), findsOneWidget);
  });
}
