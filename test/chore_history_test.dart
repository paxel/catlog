import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/chores/chore_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The chore log page: each due day with what happened, flipping order,
/// shareable.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('rows read done, missed and open; the order flips', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final today = DateUtils.dateOnly(DateTime.now());
    final cat = store.createCat('Miezi');
    final meds = store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: 'Meds',
        schedule: const ChoreSchedule.daily(),
        start: today.subtract(const Duration(days: 2)),
      ),
    );
    store.tickChore(
      meds,
      today.subtract(const Duration(days: 2)),
      doneOn: today.subtract(const Duration(days: 2)),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ChoreHistoryScreen(store: store, chore: meds),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Meds · Miezi'), findsOneWidget);
    expect(find.text('Still open'), findsOneWidget);
    expect(find.text('Missed'), findsOneWidget);
    expect(find.textContaining('done '), findsOneWidget);
    expect(find.textContaining('· anna'), findsOneWidget);
    expect(find.byTooltip('Share as PDF'), findsOneWidget);
    expect(find.byTooltip('Copy text'), findsOneWidget);
    final tiles = tester.widgetList<ListTile>(find.byType(ListTile)).toList();
    expect((tiles.first.subtitle as Text).data, 'Still open');
    await tester.tap(find.byTooltip('Oldest first'));
    await tester.pumpAndSettle();
    final flipped = tester.widgetList<ListTile>(find.byType(ListTile)).toList();
    expect((flipped.first.subtitle as Text).data, startsWith('done '));
    expect(store.localSetting('choreLogOldestFirst'), 'yes');
  });

  testWidgets('a long press removes a tick, shows it on request, restores it',
      (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final today = DateUtils.dateOnly(DateTime.now());
    final cat = store.createCat('Miezi');
    final meds = store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: 'Meds',
        schedule: const ChoreSchedule.daily(),
        start: today.subtract(const Duration(days: 1)),
      ),
    );
    final yesterday = today.subtract(const Duration(days: 1));
    store.tickChore(meds, yesterday, doneOn: yesterday);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ChoreHistoryScreen(store: store, chore: meds),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('done '), findsOneWidget);
    await tester.longPress(find.textContaining('done '));
    await tester.pumpAndSettle();
    expect(find.text('Correct this value'), findsOneWidget);
    await tester.tap(find.text('Remove this value'));
    await tester.pumpAndSettle();
    expect(find.text('Missed'), findsOneWidget);
    expect(store.choreTicks(meds), isEmpty);

    await tester.tap(find.byTooltip('Show removed values'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Removed · anna'), findsOneWidget);
    await tester.longPress(find.textContaining('Missed'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restore this value'));
    await tester.pumpAndSettle();
    expect(find.text('Missed'), findsNothing);
    expect(store.choreTicks(meds).keys, [yesterday]);
  });
}
