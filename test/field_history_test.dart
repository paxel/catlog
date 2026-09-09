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

  testWidgets('edit-mode long-press still opens the timeline with its menu', (
    tester,
  ) async {
    store.append(cat, 'f:remarks', 'Sneezing');
    store.append(cat, 'f:remarks', 'Vet: fine');
    await pump(
      tester,
      CatDetailScreen(store: store, catId: cat, startEditing: true),
    );
    expect(find.byTooltip('History'), findsNothing);
    // Looks joined the starters: Remarks now sits below the fold.
    await tester.ensureVisible(find.text('Remarks'));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Remarks'));
    await tester.pumpAndSettle();
    expect(find.text('Remarks — Miezi'), findsOneWidget);
    await tester.longPress(find.textContaining('Sneezing'));
    await tester.pumpAndSettle();
    expect(find.text('Correct this value'), findsOneWidget);
    expect(find.text('Remove this value'), findsOneWidget);
  });

  testWidgets('the history flips to oldest first and shares as text', (
    tester,
  ) async {
    store.append(cat, 'f:remarks', 'Sneezing', date: DateTime(2026, 5, 1));
    store.append(cat, 'f:remarks', 'Vet: fine', date: DateTime(2026, 6, 1));
    final remarks = store.fieldDefs().firstWhere((d) => d.slug == 'remarks');
    await pump(
      tester,
      FieldHistoryScreen(store: store, entityId: cat, def: remarks),
    );
    List<String> order() => [
      for (final w in tester.widgetList<Text>(find.byType(Text)))
        if (w.data == 'Sneezing' || w.data == 'Vet: fine') w.data!,
    ];
    expect(order(), ['Vet: fine', 'Sneezing']);
    await tester.tap(find.byTooltip('Oldest first'));
    await tester.pumpAndSettle();
    expect(order(), ['Sneezing', 'Vet: fine']);
    expect(store.localSetting('historyOldestFirst'), 'yes');
    expect(find.byTooltip('Newest first'), findsOneWidget);
    expect(find.byTooltip('Share as text'), findsOneWidget);
    // The text follows the order on screen.
    final t = lookupAppLocalizations(const Locale('en'));
    final text = historyAsText(
      t,
      store,
      cat,
      remarks,
      valueHistory(store, cat, 'f:remarks').reversed.toList(),
      'en',
    );
    expect(text.split('\n').first, 'Miezi · Remarks');
    expect(text, contains('Sneezing · anna'));
    expect(text.indexOf('Sneezing'), lessThan(text.indexOf('Vet: fine')));
  });

  testWidgets('a tap corrects a value in place, the old one hides', (
    tester,
  ) async {
    final remarks = store.fieldDefs().firstWhere((d) => d.slug == 'remarks');
    final when = DateTime.utc(2026, 1, 1, 9, 30);
    store.append(cat, 'f:remarks', 'Sneezng', date: when);
    store.append(cat, 'f:remarks', 'Vet: fine', date: DateTime.utc(2026, 1, 3));
    await pump(
      tester,
      FieldHistoryScreen(store: store, entityId: cat, def: remarks),
    );
    await tester.tap(find.text('Sneezng'));
    await tester.pumpAndSettle();
    expect(find.text('As of 1/1/2026'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Sneezing');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Sneezing'), findsOneWidget);
    expect(find.text('Sneezng'), findsNothing);
    expect(find.text('Correction'), findsOneWidget);
    final fixed = store
        .fieldHistory(cat, 'f:remarks')
        .firstWhere((e) => e.value == 'Sneezing');
    expect(fixed.date, when);
    expect(store.current(cat, 'f:remarks'), 'Vet: fine');

    // Hidden values show on request, struck through and explained.
    await tester.tap(find.byTooltip('Show removed values'));
    await tester.pumpAndSettle();
    expect(find.text('Sneezng'), findsOneWidget);
    expect(find.textContaining('Replaced by Sneezing'), findsOneWidget);
    expect(store.localSetting('historyShowVoided'), 'yes');
  });

  testWidgets('a long press removes a value, and restores a hidden one', (
    tester,
  ) async {
    final remarks = store.fieldDefs().firstWhere((d) => d.slug == 'remarks');
    store.append(cat, 'f:remarks', 'Sneezing', date: DateTime.utc(2026, 1, 1));
    store.append(cat, 'f:remarks', 'Vet: fine', date: DateTime.utc(2026, 1, 3));
    await pump(
      tester,
      FieldHistoryScreen(store: store, entityId: cat, def: remarks),
    );
    await tester.longPress(find.text('Vet: fine'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove this value'));
    await tester.pumpAndSettle();
    expect(find.text('Vet: fine'), findsNothing);
    expect(store.current(cat, 'f:remarks'), 'Sneezing');

    await tester.tap(find.byTooltip('Show removed values'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Removed · anna'), findsOneWidget);
    await tester.longPress(find.text('Vet: fine'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restore this value'));
    await tester.pumpAndSettle();
    expect(store.current(cat, 'f:remarks'), 'Vet: fine');
    expect(find.textContaining('Removed · anna'), findsNothing);
  });
}
