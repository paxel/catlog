import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/move_to_catalog.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Moving a cat into another catalog, from the page it lives on.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogManager catalogs;
  late CatalogStore store;
  late String cat;

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-move-ui');
    catalogs = CatalogManager.open(root.path, defaultName: 'Berlin');
    catalogManager = catalogs;
    store = catalogs.openStore(catalogs.active)..author = 'test';
    cat = store.createCat('Miezi');
  });

  tearDown(() {
    catalogManager = null;
    store.close();
    catalogs.close();
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  Future<void> pumpCat(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatDetailScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('with one catalog there is nowhere to move to',
      (tester) async {
    await pumpCat(tester);
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Move to another catalog'), findsNothing);
  });

  testWidgets('the cat moves and leaves the page behind', (tester) async {
    final paris = catalogs.create('Paris');
    await pumpCat(tester);
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move to another catalog'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paris'));
    await tester.pumpAndSettle();

    expect(store.isDeleted(cat), isTrue);
    final there = catalogs.openStore(paris);
    expect(there.cats().map((c) => c.name), ['Miezi']);
    there.close();
  });

  testWidgets('dismissing the picker moves nothing', (tester) async {
    catalogs.create('Paris');
    await pumpCat(tester);
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move to another catalog'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();

    expect(store.isDeleted(cat), isFalse);
  });
}
