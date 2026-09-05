import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/auto_backup.dart' show backupFileName;
import 'package:catlog/src/screens/catalogs_screen.dart';
import 'package:catlog/main.dart' show CatlogApp;
import 'package:catlog/src/move_to_catalog.dart' show CatalogSwitching;
import 'package:catlog/src/pet_mode.dart';
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
          switching: CatalogSwitching(
            catalogs: catalogs,
            onSwitch: (to, {bool unwind = true}) {
              store.close();
              catalogs.active = to;
              store = catalogs.openStore(to);
              setState(() {});
            },
            onChanged: () => setState(() {}),
          ),
        );
      }),
    ));
    await tester.pumpAndSettle();
  }

  /// The gear on the row of the catalog called [name].
  Future<void> openSettings(WidgetTester tester, String name) async {
    final row = find.ancestor(
        of: find.text(name), matching: find.byType(ListTile));
    await tester.tap(find.descendant(
        of: row, matching: find.byIcon(Icons.settings_outlined)));
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
    // ...and lands on its settings page, ready to be set up.
    expect(find.widgetWithText(AppBar, 'Paris'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Fields'), findsOneWidget);
  });

  testWidgets('renaming shows the new name', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();

    await openSettings(tester, 'Berlin');
    await tester.tap(find.text('Name'));
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
    expect(find.textContaining('The gear on a catalog'), findsOneWidget);
  });

  testWidgets('the settings page explains itself', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();
    await openSettings(tester, 'Berlin');
    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();
    expect(find.textContaining('belongs to this catalog alone'),
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
          storeOf: () => store,
          onSwitch: (to, {bool unwind = true}) {
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

    testWidgets('the last catalog has no delete row', (tester) async {
      await pumpManage(tester);
      await openSettings(tester, 'Berlin');
      expect(find.text('Delete catalog'), findsNothing);
    });

    testWidgets('deleting the catalog you are in says why it cannot',
        (tester) async {
      catalogs.create('Paris');
      await pumpManage(tester);
      await openSettings(tester, 'Berlin');
      // The row is there — a feature that vanishes teaches nothing —
      // and says what to do instead.
      await tester.tap(find.text('Delete catalog'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Switch to another one'), findsOneWidget);
      expect(catalogs.catalogs(), hasLength(2));
    });

    testWidgets('a mistyped name deletes nothing', (tester) async {
      catalogs.create('Paris');
      await pumpManage(tester);
      await openSettings(tester, 'Paris');
      await tester.tap(find.text('Delete catalog'));
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
      await openSettings(tester, 'Paris');
      await tester.tap(find.text('Delete catalog'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Paris');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();

      // The page of the deleted catalog is gone without touching the
      // deleted database again; the list is back.
      expect(tester.takeException(), isNull);
      expect(find.text('Catalogs'), findsOneWidget);
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
      await openSettings(tester, 'Paris');
      await tester.tap(find.text('Delete catalog'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Paris');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();
      expect(find.textContaining('catlog-paris.catsync'), findsOneWidget);
    });

    testWidgets('the settings of a catalog you are not in act on it alone',
        (tester) async {
      final paris = catalogs.create('Paris');
      final parisStore = catalogs.openStore(paris)..author = 'Kathrin';
      parisStore.createCat('Minou');
      parisStore.close();
      store.author = 'Kathrin';
      store.createCat('Mimi');
      store.author = 'test';

      await pumpManage(tester);
      await openSettings(tester, 'Paris');
      expect(find.widgetWithText(AppBar, 'Paris'), findsOneWidget);

      // Pets there, cats here: the app's words follow Berlin, not Paris.
      await tester.tap(find.text('Pets'));
      await tester.pumpAndSettle();
      expect(petMode.value, isFalse);
      expect(isPetMode(store), isFalse);

      // Banning Kathrin in Paris leaves her Berlin cat alone.
      await tester.tap(find.text('Authors & bans'));
      await tester.pumpAndSettle();
      final kathrin = find.ancestor(
          of: find.text('Kathrin'), matching: find.byType(ListTile));
      await tester.tap(find.descendant(
          of: kathrin, matching: find.byIcon(Icons.delete_forever_outlined)));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Kathrin');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();
      expect(store.cats().map((c) => c.name), ['Mimi']);

      // Back out of the page closes Paris; what it wrote is there.
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      final reopened = catalogs.openStore(paris);
      expect(isPetMode(reopened), isTrue);
      expect(reopened.cats(), isEmpty);
      reopened.close();
    });
  });

  testWidgets('renaming a catalog renames its backup file', (tester) async {
    final removed = <String>[];
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatalogsScreen(
        catalogs: catalogs,
        storeOf: () => store,
        onSwitch: (_, {bool unwind = true}) {},
        removeSaved: (name) async => removed.add(name),
      ),
    ));
    await tester.pumpAndSettle();
    await openSettings(tester, 'Berlin');
    await tester.tap(find.text('Name'));
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
          catalogs: catalogs, storeOf: () => store, onSwitch: (_, {bool unwind = true}) {}),
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

  testWidgets('switching from the manage screen stays there; back leaves '
      'into the new catalog', (tester) async {
    catalogs.create('Paris');
    // The real app, so the real switch runs: tap activates in place —
    // several catalogs can be handled in one visit — and the screen
    // reads the store through a live lookup, never a closed database.
    await tester.pumpWidget(CatlogApp(store: store, catalogs: catalogs));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Paris'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Still on the manage screen, Paris now marked active.
    expect(find.text('Catalogs'), findsOneWidget);
    final parisTile = tester.widget<ListTile>(find.ancestor(
        of: find.text('Paris'), matching: find.byType(ListTile)));
    expect(parisTile.selected, isTrue);

    // Back leaves into the switched catalog.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.widgetWithText(AppBar, 'Paris'), findsOneWidget);
  });

  testWidgets('each catalog keeps its own backup file across a switch',
      (tester) async {
    final written = <String>[];
    final paris = catalogs.create('Paris');
    store.createClowder('Hinterhof');

    // Two catalogs, backed up in turn, as a day of switching would.
    for (final catalog in [catalogs.active, paris]) {
      final open = catalogs.openStore(catalog);
      open.author = 'test';
      open.createCat('a cat');
      written.add(backupFileName(open.localSetting(catalogNameKey)));
      open.close();
    }

    expect(written, ['catlog-berlin.catsync', 'catlog-paris.catsync']);
    expect(written.toSet(), hasLength(2),
        reason: 'using one catalog must not overwrite the other backup');
  });
}
