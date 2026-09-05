import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/field_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A field's values as a diary: the clock on a read-mode row where the
/// field has two values and no graph; the page lists facts only.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    store = CatalogStore.inMemory()..author = 'anna';
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(400, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
    await tester.pumpAndSettle();
  }

  test('the history holds facts only, newest first', () {
    store.append(cat, 'f:remarks', 'Sneezing', date: DateTime.utc(2026, 1, 1));
    store.append(cat, 'f:remarks', null, date: DateTime.utc(2026, 1, 2));
    store.append(cat, 'f:remarks', 'Vet: fine', date: DateTime.utc(2026, 1, 3));
    store.append(
      cat,
      'f:remarks',
      'Check again',
      date: DateTime.utc(2026, 2, 1),
      reminder: true,
    );
    expect(valueHistory(store, cat, 'f:remarks').map((e) => e.value), [
      'Vet: fine',
      'Sneezing',
    ]);
    expect(hasValueHistory(store, cat, 'f:remarks'), isTrue);
  });

  testWidgets('the clock shows for two values, not for one or a graph', (
    tester,
  ) async {
    store.append(cat, 'f:remarks', 'Sneezing');
    store.append(cat, 'f:color', 'grey');
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    expect(find.byTooltip('History'), findsNothing);

    store.append(cat, 'f:remarks', 'Vet: fine');
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    expect(find.byTooltip('History'), findsOneWidget);

    // A number with two values gets the graph, not the clock.
    store.append(cat, 'f:weight', '4.1', date: DateTime.utc(2026, 1, 1));
    store.append(cat, 'f:weight', '4.3', date: DateTime.utc(2026, 2, 1));
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    expect(find.byIcon(Icons.show_chart), findsOneWidget);
    expect(find.byTooltip('History'), findsOneWidget);
  });

  testWidgets('the page lists the values with date and author', (tester) async {
    store.append(cat, 'f:remarks', 'Sneezing', date: DateTime.utc(2026, 1, 1));
    store.author = 'bob';
    store.append(cat, 'f:remarks', 'Vet: fine', date: DateTime.utc(2026, 1, 3));
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    await tester.tap(find.byTooltip('History'));
    await tester.pumpAndSettle();

    expect(find.text('Remarks — Miezi'), findsOneWidget);
    expect(find.text('Vet: fine'), findsOneWidget);
    expect(find.text('Sneezing'), findsOneWidget);
    expect(find.textContaining('bob'), findsOneWidget);
    expect(find.textContaining('anna'), findsOneWidget);
    // Read-only: no revert here.
    expect(find.byIcon(Icons.undo), findsNothing);
    final texts = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data)
        .whereType<String>()
        .toList();
    expect(texts.indexOf('Vet: fine'), lessThan(texts.indexOf('Sneezing')));
  });

  testWidgets('edit-mode long-press still opens the revert timeline', (
    tester,
  ) async {
    store.append(cat, 'f:remarks', 'Sneezing');
    store.append(cat, 'f:remarks', 'Vet: fine');
    await pump(
      tester,
      CatDetailScreen(store: store, catId: cat, startEditing: true),
    );
    expect(find.byTooltip('History'), findsNothing);
    await tester.longPress(find.text('Remarks'));
    await tester.pumpAndSettle();
    expect(find.text('Remarks — Miezi'), findsOneWidget);
    await tester.longPress(find.textContaining('Sneezing'));
    await tester.pumpAndSettle();
    expect(find.text('Revert this change'), findsOneWidget);
  });
}
