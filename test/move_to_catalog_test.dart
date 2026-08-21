import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/move_to_catalog.dart';
import 'package:catlog/src/screens/catalogs_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/strays_screen.dart';
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

  testWidgets('a clowder moves with the cats living in it', (tester) async {
    final paris = catalogs.create('Paris');
    final clowder = store.createClowder('Hinterhof');
    store.moveCat(cat, clowder);

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderDetailScreen(store: store, clowderId: clowder),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move to another catalog'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paris'));
    await tester.pumpAndSettle();

    final there = catalogs.openStore(paris);
    expect(there.clowders().map((c) => c.name), ['Hinterhof']);
    expect(there.cats().map((c) => c.name), ['Miezi']);
    there.close();
    expect(store.clowders(), isEmpty);
  });

  testWidgets('a selection of strays moves together', (tester) async {
    final paris = catalogs.create('Paris');
    store.createCat('Mausi');
    store.createCat('Struppi');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: StraysScreen(store: store),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.drive_file_move_outline));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(CheckboxListTile, 'Miezi'));
    await tester.tap(find.widgetWithText(CheckboxListTile, 'Struppi'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Move to another catalog'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paris'));
    await tester.pumpAndSettle();

    final there = catalogs.openStore(paris);
    expect(there.cats().map((c) => c.name),
        unorderedEquals(['Miezi', 'Struppi']));
    there.close();
    expect(store.cats().map((c) => c.name), ['Mausi']);
  });

  testWidgets('creating a catalog offers to move something into it',
      (tester) async {
    final clowder = store.createClowder('Hinterhof');
    store.moveCat(cat, clowder);

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatalogsScreen(
        catalogs: catalogs,
        store: store,
        onSwitch: (_) {},
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Paris');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Move something into Paris?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Move to another catalog'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(CheckboxListTile, 'Hinterhof'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Move to another catalog'));
    await tester.pumpAndSettle();

    final paris = catalogs.catalogs().firstWhere((c) => c.name == 'Paris');
    final there = catalogs.openStore(paris);
    expect(there.clowders().map((c) => c.name), ['Hinterhof']);
    there.close();
  });

  testWidgets('skipping the offer moves nothing', (tester) async {
    store.createClowder('Hinterhof');
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatalogsScreen(
        catalogs: catalogs,
        store: store,
        onSwitch: (_) {},
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Paris');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(store.clowders().map((c) => c.name), ['Hinterhof']);
  });
}
