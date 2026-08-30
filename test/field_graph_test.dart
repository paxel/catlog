import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/field_graph_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The graph (#97): offered once two values exist, drawn in the
/// device's unit, filtered by range, with the change since last.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;
  late FieldDef weight;
  setUp(() {
    store = CatalogStore.inMemory()..author = 'test';
    cat = store.createCat('Sissi');
    weight = store.fieldDefs().firstWhere((d) => d.slug == 'weight');
  });
  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ));
    await tester.pumpAndSettle();
  }

  test('points come oldest first in the entry unit; ranges filter', () {
    store.append(cat, weight.key, '4000', date: DateTime(2026, 1, 1));
    store.append(cat, weight.key, 'heavy', date: DateTime(2026, 2, 1));
    store.append(cat, weight.key, '4250', date: DateTime(2026, 3, 1));
    final points = graphPoints(store, cat, weight);
    expect(points.map((p) => p.value), [4.0, 4.25]);
    expect(graphablePoints(store, cat, weight), 2);
    expect(hasGraph(store, cat, weight), isTrue);
    final color = store.fieldDefs().firstWhere((d) => d.slug == 'color');
    store.append(cat, color.key, '1');
    store.append(cat, color.key, '2');
    expect(hasGraph(store, cat, color), isFalse);
    expect(inRange(DateTime(2026, 2, 15), DateTime(2026, 2, 15), null), isTrue);
    expect(inRange(DateTime(2026, 2, 14), DateTime(2026, 2, 15), null), isFalse);
    expect(inRange(DateTime(2026, 2, 16), null, DateTime(2026, 2, 15)), isFalse);
    expect(inRange(DateTime(2026, 2, 16), null, null), isTrue);
    expect(pointsBetween(points, DateTime(2026, 2, 15), null), hasLength(1));
    expect(pointsBetween(points, null, DateTime(2026, 2, 15)), hasLength(1));
  });

  testWidgets('one value shows no graph icon, two do; the page opens',
      (tester) async {
    store.append(cat, weight.key, '4000', date: DateTime(2026, 1, 1));
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    expect(find.byIcon(Icons.show_chart), findsNothing);

    store.append(cat, weight.key, '4250', date: DateTime(2026, 3, 1));
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    expect(find.byIcon(Icons.show_chart), findsOneWidget);
    await tester.tap(find.byIcon(Icons.show_chart));
    await tester.pumpAndSettle();
    expect(find.byType(FieldGraphScreen), findsOneWidget);
    expect(find.textContaining('+0.25 kg since'), findsOneWidget);
    expect(find.byKey(const ValueKey('field-graph')), findsOneWidget);

    // A range chip narrows the curve and is remembered.
    await tester.tap(find.text('Week'));
    await tester.pumpAndSettle();
    expect(store.localSetting(graphRangeKey), 'week');
  });
}
