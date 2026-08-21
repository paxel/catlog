import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/catalogs_screen.dart';
import 'package:catlog/main.dart' show CatlogApp;
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
    // The creation flow offers to move something in; not this time.
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
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

  group('deleting a catalog', () {
    late Directory saved;

    Future<void> pumpManage(WidgetTester tester) async {
      saved = Directory.systemTemp.createTempSync('catlog-saved');
      addTearDown(() {
        if (saved.existsSync()) saved.deleteSync(recursive: true);
      });
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CatalogsScreen(
          catalogs: catalogs,
          store: store,
          onSwitch: (to) {
            store.close();
            catalogs.active = to;
            store = catalogs.openStore(to);
          },
          saveTo: (path, name) async {
            final to = '${saved.path}/$name';
            File(path).copySync(to);
            return to;
          },
        ),
      ));
      await tester.pumpAndSettle();
    }

    testWidgets('the last catalog has no delete button', (tester) async {
      await pumpManage(tester);
      expect(find.byIcon(Icons.delete_outline), findsNothing);
    });

    testWidgets('the catalog you are in has no delete button either',
        (tester) async {
      catalogs.create('Paris');
      await pumpManage(tester);
      final berlin = find.ancestor(
          of: find.text('Berlin'), matching: find.byType(ListTile));
      expect(
          find.descendant(
              of: berlin, matching: find.byIcon(Icons.delete_outline)),
          findsNothing,
          reason: 'its database is open — switch away first');
      final paris = find.ancestor(
          of: find.text('Paris'), matching: find.byType(ListTile));
      expect(
          find.descendant(
              of: paris, matching: find.byIcon(Icons.delete_outline)),
          findsOneWidget);
    });

    testWidgets('a mistyped name deletes nothing', (tester) async {
      catalogs.create('Paris');
      await pumpManage(tester);
      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'paris');
      await tester.pumpAndSettle();
      final button = tester.widget<FilledButton>(
          find.widgetWithText(FilledButton, 'Delete'));
      expect(button.onPressed, isNull);
      expect(catalogs.catalogs(), hasLength(2));
    });

    testWidgets('the typed name deletes it, and the file is kept first',
        (tester) async {
      final paris = catalogs.create('Paris');
      final parisStore = catalogs.openStore(paris)..author = 'test';
      parisStore.createClowder('Belleville');
      parisStore.close();

      await pumpManage(tester);
      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Paris');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();

      expect(catalogs.catalogs().map((c) => c.name), ['Berlin']);
      expect(paris.dir.existsSync(), isFalse);
      final file = File('${saved.path}/catlog-paris.catsync');
      expect(file.existsSync(), isTrue);

      // What was written brings the catalog back.
      final restored = catalogs.openStore(catalogs.create('Paris again'));
      restored.author = 'test';
      importBundle(restored, file.path);
      expect(restored.clowders().map((c) => c.name), ['Belleville']);
      restored.close();
    });

    testWidgets('the keeper is told where the file went', (tester) async {
      catalogs.create('Paris');
      await pumpManage(tester);
      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Paris');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();
      expect(find.textContaining('catlog-paris.catsync'), findsOneWidget);
    });
  });

  testWidgets('renaming a catalog renames its backup file', (tester) async {
    final removed = <String>[];
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatalogsScreen(
        catalogs: catalogs,
        store: store,
        onSwitch: (_) {},
        removeSaved: (name) async => removed.add(name),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.drive_file_rename_outline));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Berlin Nord');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(removed, ['catlog-berlin.catsync']);
  });

  testWidgets('each catalog shows what it costs in space', (tester) async {
    store.createClowder('Hinterhof');
    catalogs.create('Paris');
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatalogsScreen(
          catalogs: catalogs, store: store, onSwitch: (_) {}),
    ));
    await tester.pumpAndSettle();

    for (final catalog in catalogs.catalogs()) {
      expect(find.widgetWithText(ListTile, catalog.name), findsOneWidget);
      expect(catalog.sizeInBytes, greaterThan(0));
    }
    // A size is shown for every catalog, in units a person reads.
    expect(find.textContaining(RegExp(r'\d+(\.\d+)? (B|KB|MB|GB)')),
        findsNWidgets(2));
  });

  testWidgets('switching from the manage screen leaves no page reading a '
      'closed catalog', (tester) async {
    catalogs.create('Paris');
    // The real app, so the real switch runs: it unwinds to the list and
    // closes the catalog being left only once its pages are gone.
    await tester.pumpWidget(CatlogApp(store: store, catalogs: catalogs));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Paris'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.widgetWithText(AppBar, 'Paris'), findsOneWidget);
    expect(find.text('Manage catalogs'), findsNothing,
        reason: 'the page of the catalog we left is gone');
  });
}
