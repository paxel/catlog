import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A photo the catalog knows of but never got the bytes for is shown as
/// such, on the page and in the viewer.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('a photo without bytes says so, tile and viewer', (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    // The entry arrived by sync; the bytes did not.
    store.append(cat, Keys.image('feedfacefeedface'), 'added');
    expect(store.imageBytes('feedfacefeedface'), isNull);

    tester.view.physicalSize = const Size(400, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CatDetailScreen(store: store, catId: cat),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Photo not received yet'), findsOneWidget);
    expect(find.byIcon(Icons.broken_image_outlined), findsOneWidget);

    await tester.tap(find.text('Photo not received yet'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 1'), findsOneWidget);
    expect(find.text('Photo not received yet'), findsOneWidget);
  });
}
