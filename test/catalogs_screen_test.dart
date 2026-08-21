import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/catalogs_screen.dart';
import 'package:catlog/src/screens/home_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Several catalogs on one device: the home title names the one you are
/// in and opens the switcher; managing them lives one tap further.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogManager catalogs;
  late CatalogStore store;

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-ui');
    catalogs = CatalogManager.open(root.path, defaultName: 'Berlin');
    store = catalogs.openStore(catalogs.active)..author = 'test';
  });

  tearDown(() {
    store.close();
    catalogs.close();
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  Future<void> pumpHome(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: StatefulBuilder(builder: (context, setState) {
        return HomeShell(
          store: store,
          catalogs: catalogs,
          onSwitchCatalog: (to) {
            store.close();
            catalogs.active = to;
            store = catalogs.openStore(to);
            setState(() {});
          },
          onCatalogsChanged: () => setState(() {}),
        );
      }),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('the title names the catalog and opens the switcher',
      (tester) async {
    catalogs.create('Paris');
    await pumpHome(tester);
    expect(find.widgetWithText(AppBar, 'Berlin'), findsOneWidget);

    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    expect(find.text('Paris'), findsOneWidget);
    expect(find.text('Manage catalogs'), findsOneWidget);
  });

  testWidgets('switching changes the catalog you are in', (tester) async {
    store.createClowder('Hinterhof');
    catalogs.create('Paris');
    await pumpHome(tester);
    expect(find.text('Hinterhof'), findsOneWidget);

    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paris').last);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Paris'), findsOneWidget);
    expect(find.text('Hinterhof'), findsNothing);
  });

  testWidgets('a new catalog is created empty and becomes the one you are in',
      (tester) async {
    store.createClowder('Hinterhof');
    await pumpHome(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Paris');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(catalogs.catalogs().map((c) => c.name), ['Berlin', 'Paris']);
    expect(catalogs.active.name, 'Paris');
    final paris = catalogs.openStore(catalogs.active);
    expect(paris.clowders(), isEmpty);
    paris.close();
  });

  testWidgets('renaming shows the new name', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.drive_file_rename_outline));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Berlin Nord');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(catalogs.byId(catalogs.active.id)!.name, 'Berlin Nord');
    expect(find.text('Berlin Nord'), findsWidgets);
  });

  testWidgets('a name already taken is refused with cause and fix',
      (tester) async {
    catalogs.create('Paris');
    await pumpHome(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Paris');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(
        find.textContaining('A catalog called Paris already exists'),
        findsOneWidget);
    expect(catalogs.catalogs(), hasLength(2));
  });

  testWidgets('the manage screen explains itself', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();
    expect(find.textContaining('A catalog is a world of its own'),
        findsOneWidget);
  });
}
