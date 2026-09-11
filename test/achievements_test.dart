import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/achievements.dart';
import 'package:catlog/src/screens/achievements_screen.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// What the chores add up to: full months and years, a master ladder
/// per chore, recorded once per climb, shown on a page.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogManager manager;
  late CatalogStore store;

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-ach');
    manager = CatalogManager.open(root.path, defaultName: 'Berlin');
    store = manager.openStore(manager.active)..author = 'anna';
  });

  tearDown(() {
    store.close();
    manager.close();
    root.deleteSync(recursive: true);
  });

  /// A daily chore ticked every day from [from] up to [to].
  Chore dailyDone(String title, DateTime from, DateTime to) {
    final chore = store.createChore(
      Chore(
        id: '',
        entity: store.createCat('Cat $title'),
        title: title,
        schedule: const ChoreSchedule.daily(),
        start: from,
      ),
    );
    for (
      var day = from;
      !day.isAfter(to);
      day = day.add(const Duration(days: 1))
    ) {
      store.tickChore(chore, day, doneOn: day);
    }
    return chore;
  }

  test('full months, a master ladder, and the tiers between', () {
    final today = DateTime(2026, 9, 6);
    // August done every day; September so far too; July had a miss.
    final feed = dailyDone('Feed', DateTime(2026, 7, 1), DateTime(2026, 9, 5));
    store.untickChore(feed, DateTime(2026, 7, 15));
    final stats = gatherStats([store], today);
    expect(stats.fullMonths, {'2026-08'});
    expect(stats.ticksByTitle['feed'], 66);

    final states = ladders(stats);
    final month = states.firstWhere((s) => s.id == fullMonthId);
    expect(month.times, 1);
    expect(month.reached, isTrue);
    expect(states.firstWhere((s) => s.id == fullYearId).reached, isFalse);
    final master = states.firstWhere((s) => s.id == '${masterPrefix}feed');
    expect(master.title, 'Feed');
    expect(master.tier, 2, reason: '66 passes 10 and 50');
    expect(master.next, 100);
  });

  test('a full year is twelve full months', () {
    final today = DateTime(2027, 1, 5);
    dailyDone('Litter', DateTime(2026, 1, 1), DateTime(2027, 1, 4));
    final states = ladders(gatherStats([store], today));
    expect(states.firstWhere((s) => s.id == fullMonthId).times, 12);
    expect(states.firstWhere((s) => s.id == fullYearId).times, 1);
    expect(states.firstWhere((s) => s.id == fullDecadeId).reached, isFalse);
  });

  test('climbs are recorded once and remembered in the app database', () {
    final today = DateTime(2026, 9, 6);
    final feed = dailyDone('Feed', DateTime(2026, 8, 20), DateTime(2026, 9, 5));
    var climbed = recordLadders(
      manager,
      ladders(gatherStats([store], today)),
      DateTime(2026, 9, 6),
    );
    // August, from the 20th on, was all done: a full month too.
    expect(climbed.map((s) => s.id), [fullMonthId, '${masterPrefix}feed']);
    Achievement feedRow() =>
        manager.achievements().firstWhere((a) => a.id == '${masterPrefix}feed');
    expect(feedRow().tier, 1);

    // Same state again: nothing new.
    climbed = recordLadders(
      manager,
      ladders(gatherStats([store], today)),
      DateTime(2026, 9, 7),
    );
    expect(climbed, isEmpty);

    // Past 50: the next tier, and the first date stays the first.
    for (var i = 1; i <= 40; i++) {
      final day = DateTime(2026, 9, 5).add(Duration(days: i));
      store.tickChore(feed, day, doneOn: day);
    }
    climbed = recordLadders(
      manager,
      ladders(gatherStats([store], DateTime(2026, 10, 20))),
      DateTime(2026, 10, 20),
    );
    // September filled up too: another full month climbs with it.
    expect(
      climbed.firstWhere((s) => s.id == '${masterPrefix}feed').tier,
      2,
    );
    final row = feedRow();
    expect(row.tier, 2);
    expect(row.first, DateTime(2026, 9, 6).toUtc());
    expect(row.last, DateTime(2026, 10, 20).toUtc());
  });

  testWidgets('the page lists ladders, reached ones with their count', (
    tester,
  ) async {
    final today = DateUtils.dateOnly(DateTime.now());
    // Today only: nothing reached yet, every ladder shows its next step.
    dailyDone('Feed', today, today);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AchievementsScreen(manager: manager, stores: [store]),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Achievements'), findsOneWidget);
    // Nothing earned: one quiet line, no ladders to chase.
    expect(find.textContaining('Nothing earned yet'), findsOneWidget);
    expect(find.textContaining('Next at'), findsNothing);
    expect(find.text('A full month'), findsNothing);
  });

  testWidgets('earned titles and coats list by rank and month', (
    tester,
  ) async {
    final today = DateUtils.dateOnly(DateTime.now());
    // Sixty ticks: Butler (50) on the Feed ladder; a full month behind.
    dailyDone('Feed', DateTime(2026, 7, 1), DateTime(2026, 8, 31));
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AchievementsScreen(manager: manager, stores: [store]),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Butler (Feed)'), findsOneWidget);
    expect(find.text('A full month'), findsOneWidget);
    expect(find.text('New coat: Calico'), findsOneWidget);
    expect(find.text('New coat: Snow leopard'), findsOneWidget);
    expect(find.textContaining('Next at'), findsNothing);
    expect(today.isAfter(DateTime(2026, 8, 31)), isTrue);
  });

  test('ranks follow the tiers, coats the full months', () {
    expect(rankFor(0), isNull);
    expect(rankFor(1), 'servant');
    expect(rankFor(4), 'chancellor');
    expect(rankFor(5), 'minister');
    expect(rankFor(6), 'minister');
    expect(unlockedCoats(0), isEmpty);
    expect(unlockedCoats(2), ['calico', 'snowLeopard']);
    expect(unlockedCoats(9), hasLength(5));
  });

  testWidgets('a tick that climbs a ladder says so on the agenda', (
    tester,
  ) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final feed = dailyDone(
      'Feed',
      today.subtract(const Duration(days: 9)),
      today.subtract(const Duration(days: 1)),
    );
    expect(store.choreTicks(feed).length, 9);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AgendaScreen(store: store, manager: manager),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.emoji_events_outlined), findsOneWidget);
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(find.textContaining('Servant (Feed)'), findsOneWidget);
    expect(
      manager.achievements().map((a) => a.id),
      contains('${masterPrefix}feed'),
    );
  });
}
