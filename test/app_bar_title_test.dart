import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The row of buttons crowds the title off a phone's app bar — the Cat
/// screen left about six characters, so "Kathrins Second Flow" read as
/// "Kathri…". On narrow screens the title gets its own line below them.
void main() {
  setUpAll(useSystemSqlite);

  const longName = 'Kathrins Second Flow';

  late CatalogStore store;
  late String cat, clowder;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    clowder = store.createClowder(longName);
    cat = store.createCat(longName);
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget screen, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ));
    await tester.pumpAndSettle();
  }

  /// The title sits on its own line when it starts below every button.
  bool titleIsOnItsOwnLine(WidgetTester tester, Finder title) {
    final buttons = tester
        .widgetList(find.byType(IconButton))
        .isEmpty
        ? <Rect>[]
        : find
            .byType(IconButton)
            .evaluate()
            .map((e) => tester.getRect(find.byWidget(e.widget)))
            .toList();
    final lowestButton =
        buttons.map((r) => r.bottom).fold<double>(0, (a, b) => a > b ? a : b);
    return tester.getRect(title).top >= lowestButton;
  }

  for (final (name, build) in <(String, Widget Function())>[
    ('the cat page', () => CatDetailScreen(store: store, catId: cat)),
    (
      'the clowder page',
      () => ClowderDetailScreen(store: store, clowderId: clowder)
    ),
  ]) {
    testWidgets('$name shows a long name in full on a phone',
        (tester) async {
      await pump(tester, build(), const Size(360, 800));
      final title = find.text(longName).first;
      expect(title, findsOneWidget);
      expect(titleIsOnItsOwnLine(tester, title), isTrue);
      final rect = tester.getRect(title);
      expect(rect.left, greaterThanOrEqualTo(0));
      expect(rect.right, lessThanOrEqualTo(360));
    });

    testWidgets('$name keeps the title in the button row on a tablet',
        (tester) async {
      await pump(tester, build(), const Size(1024, 768));
      final title = find.text(longName).first;
      expect(titleIsOnItsOwnLine(tester, title), isFalse);
    });
  }

  testWidgets('home shows its title below the buttons on a phone',
      (tester) async {
    await pump(tester, ClowderListScreen(store: store), const Size(360, 800));
    final title = find.text('Clowders').first;
    expect(titleIsOnItsOwnLine(tester, title), isTrue);
  });

  testWidgets('no action button moves when the title does', (tester) async {
    await pump(tester, ClowderListScreen(store: store), const Size(360, 800));
    final icons = find
        .descendant(
            of: find.byType(AppBar), matching: find.byType(IconButton))
        .evaluate()
        .length;
    expect(icons, greaterThan(3));
    for (final e in find
        .descendant(
            of: find.byType(AppBar), matching: find.byType(IconButton))
        .evaluate()) {
      expect(tester.getRect(find.byWidget(e.widget)).top, lessThan(56));
    }
  });
}
