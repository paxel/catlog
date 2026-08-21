import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/home_shell.dart';
import 'package:catlog/src/screens/search_screen.dart';
import 'package:catlog/src/screens/strays_screen.dart';
import 'package:catlog/src/screens/sync_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// On a screen wide enough for two panes, a list page belongs in the
/// right pane. Only Strays and Clowders used to; everything else covered
/// the whole tablet and took the list with it.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String clowder;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    clowder = store.createClowder('Berlin');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester,
      {Size size = const Size(1200, 900)}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeShell(store: store),
    ));
    await tester.pumpAndSettle();
  }

  /// A page in the pane starts to the right of the list; a page that
  /// covered the window starts at the left edge.
  bool inPane(WidgetTester tester, Finder page) =>
      tester.getTopLeft(page).dx > 0;

  testWidgets('Strays opens in the pane, not over the list', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Strays (0)'));
    await tester.pumpAndSettle();
    expect(find.byType(StraysScreen), findsOneWidget);
    expect(inPane(tester, find.byType(StraysScreen)), isTrue);
  });

  testWidgets('a Clowder still opens in the pane', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    expect(inPane(tester, find.byType(ClowderDetailScreen)), isTrue);
  });

  testWidgets('Search opens in the pane', (tester) async {
    await pump(tester);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(inPane(tester, find.byType(SearchScreen)), isTrue);
  });

  testWidgets('Sync still takes the whole window — it is an errand, not '
      'a list', (tester) async {
    await pump(tester);
    await tester.tap(find.byIcon(Icons.sync));
    await tester.pumpAndSettle();
    expect(inPane(tester, find.byType(SyncScreen)), isFalse);
  });

  testWidgets('opening a Cat from the pane stays in the pane',
      (tester) async {
    final cat = store.createCat('Miezi');
    store.moveCat(cat, clowder);
    await pump(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi').last);
    await tester.pumpAndSettle();
    expect(inPane(tester, find.byType(CatDetailScreen)), isTrue);
  });

  testWidgets('a deleted Clowder vacates the pane', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    expect(find.byType(ClowderDetailScreen), findsOneWidget);
    store.append(clowder, Keys.deleted, 'true');
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeShell(store: store),
    ));
    await tester.pumpAndSettle();
    expect(find.byType(ClowderDetailScreen), findsNothing);
  });

  testWidgets('a phone keeps opening pages over the list', (tester) async {
    await pump(tester, size: const Size(360, 800));
    await tester.tap(find.text('Strays (0)'));
    await tester.pumpAndSettle();
    expect(inPane(tester, find.byType(StraysScreen)), isFalse);
  });

  testWidgets('the home title names the catalog you are in',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeShell(store: store, catalogName: 'Berlin'),
    ));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Berlin'), findsOneWidget);
  });

  group('table view', () {
    Future<void> toTable(WidgetTester tester) async {
      await tester.tap(find.byIcon(Icons.table_rows_outlined));
      await tester.pumpAndSettle();
    }

    testWidgets('takes the whole window, with no second pane',
        (tester) async {
      await pump(tester);
      await toTable(tester);
      expect(find.byType(VerticalDivider), findsNothing);
      expect(tester.getSize(find.byType(DataTable)).width,
          greaterThan(400));
    });

    testWidgets('a row opens the Clowder over the table', (tester) async {
      await pump(tester);
      await toTable(tester);
      await tester.tap(find.text('Berlin'));
      await tester.pumpAndSettle();
      expect(inPane(tester, find.byType(ClowderDetailScreen)), isFalse);
    });

    testWidgets('tiles view still shows two panes', (tester) async {
      await pump(tester);
      expect(find.byType(VerticalDivider), findsOneWidget);
    });

    testWidgets('switching to the table and back restores the pane',
        (tester) async {
      await pump(tester);
      await tester.tap(find.text('Berlin'));
      await tester.pumpAndSettle();
      expect(find.byType(ClowderDetailScreen), findsOneWidget);
      await toTable(tester);
      expect(find.byType(ClowderDetailScreen), findsNothing);
      await tester.tap(find.byIcon(Icons.grid_view));
      await tester.pumpAndSettle();
      expect(find.byType(ClowderDetailScreen), findsOneWidget);
    });
  });

  testWidgets('the list pane keeps its title on its own line, however '
      'wide the window is', (tester) async {
    await pump(tester, size: const Size(1400, 900));
    final title = find.descendant(
        of: find.byType(AppBar), matching: find.text('Clowders'));
    expect(title, findsOneWidget);
    // The pane is 400px wide whatever the window does; a one-line bar
    // there would crush the title the switcher lives in.
    final buttons = find
        .descendant(of: find.byType(AppBar), matching: find.byType(IconButton))
        .evaluate()
        .map((e) => tester.getRect(find.byWidget(e.widget)).bottom);
    expect(tester.getRect(title).top,
        greaterThanOrEqualTo(buttons.reduce((a, b) => a > b ? a : b)));
  });
}
