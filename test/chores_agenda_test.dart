import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Chores in the agenda: Today with checkboxes and streaks, Coming up
/// with early ticks, the plus chooser, and the cat's own page.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;
  final today = DateUtils.dateOnly(DateTime.now());

  setUp(() {
    store = CatalogStore.inMemory()..author = 'anna';
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(420, 1000);
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

  Chore feed() => store.createChore(
    Chore(
      id: '',
      entity: cat,
      title: 'Feed',
      schedule: const ChoreSchedule.daily(),
      time: (hour: 8, minute: 0),
      start: today.subtract(const Duration(days: 3)),
    ),
  );

  testWidgets('Today lists due chores; a tick records and shows the streak', (
    tester,
  ) async {
    final chore = feed();
    for (var i = 3; i >= 1; i--) {
      final day = today.subtract(Duration(days: i));
      store.tickChore(chore, day, doneOn: day);
    }
    await pump(tester, AgendaScreen(store: store));
    expect(find.text('Today'), findsOneWidget);
    expect(find.textContaining('Feed'), findsOneWidget);
    expect(find.textContaining('3 days in a row'), findsOneWidget);
    expect(find.textContaining('No appointments planned'), findsNothing);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(store.choreTicks(chore)[today], today);
    expect(find.textContaining('4 days in a row'), findsOneWidget);
    // The only chore of the day done: the header says so.
    expect(find.text('Today: all done'), findsOneWidget);
    expect(store.localSetting('choresCelebrated'), dayKey(today));

    // Ticking again takes it back.
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(store.choreTicks(chore).containsKey(today), isFalse);
  });

  testWidgets('Today sorts by time, chores without a time first', (
    tester,
  ) async {
    Chore make(String title, ({int hour, int minute})? time) =>
        store.createChore(
          Chore(
            id: '',
            entity: cat,
            title: title,
            schedule: const ChoreSchedule.daily(),
            time: time,
            start: today,
          ),
        );
    make('Evening', (hour: 19, minute: 0));
    final litter = make('Litter', null);
    make('Morning', (hour: 7, minute: 30));
    await pump(tester, AgendaScreen(store: store));
    final rows = tester
        .widgetList<ListTile>(find.byType(ListTile))
        .map((t) => (t.title as Text).data!)
        .toList();
    final order = [
      for (final r in rows)
        for (final name in ['Litter', 'Morning', 'Evening'])
          if (r.startsWith(name)) name,
    ];
    expect(order, ['Litter', 'Morning', 'Evening']);
    // A ticked row greys out.
    store.tickChore(litter, today, doneOn: today);
    await pump(tester, AgendaScreen(store: store));
    final done = tester.widget<Text>(find.text('Litter'));
    expect(done.style?.decoration, TextDecoration.lineThrough);
    expect(done.style?.color, isNotNull);
  });

  testWidgets('Coming up shows the next due day; a tick there is early', (
    tester,
  ) async {
    final nails = store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: 'Nails',
        schedule: const ChoreSchedule.everyDays(10),
        start: today.subtract(const Duration(days: 6)),
      ),
    );
    feed(); // a daily: never in Coming up
    await pump(tester, AgendaScreen(store: store));
    // Folded until opened; the fold is remembered on this device.
    expect(find.text('Coming up'), findsOneWidget);
    expect(find.textContaining('Nails'), findsNothing);
    await tester.tap(find.text('Coming up'));
    await tester.pumpAndSettle();
    expect(store.localSetting('fold:agenda-upcoming'), 'open');
    expect(find.textContaining('Nails'), findsOneWidget);
    expect(find.textContaining('Due'), findsOneWidget);

    final row = find.ancestor(
      of: find.textContaining('Nails'),
      matching: find.byType(ListTile),
    );
    await tester.tap(find.descendant(of: row, matching: find.byType(Checkbox)));
    await tester.pumpAndSettle();
    final due = today.add(const Duration(days: 4));
    expect(store.choreTicks(nails), {due: today});
    // Done early: the next one counts ten days from today, so it left
    // the coming week.
    expect(
      nextDue(nails, store.choreTicks(nails), today),
      today.add(const Duration(days: 10)),
    );
    expect(find.text('Coming up'), findsNothing);
  });

  testWidgets('the plus offers a chore and the dialog makes one', (
    tester,
  ) async {
    await pump(tester, AgendaScreen(store: store));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Chore'));
    await tester.pumpAndSettle();
    // Whose: the only cat.
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Eye drops');
    await tester.pumpAndSettle();
    // Every N days on a new chore starts at two; it used to throw.
    await tester.tap(find.text('Every…'));
    await tester.pumpAndSettle();
    expect(find.text('every 2 days'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('every 3 days'), findsOneWidget);
    // The unit: a vaccine comes every year, not every 365 days.
    await tester.tap(find.byType(DropdownButton<ChoreUnit>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('every 3 years').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(store.choresOf(cat).single.title, 'Eye drops');
    expect(store.choresOf(cat).single.schedule.every, 3);
    expect(store.choresOf(cat).single.schedule.unit, ChoreUnit.years);
    expect(find.textContaining('Eye drops'), findsOneWidget);
  });

  testWidgets('long-press edits; End takes the chore off the list', (
    tester,
  ) async {
    final chore = feed();
    await pump(tester, AgendaScreen(store: store));
    await tester.longPress(find.textContaining('Feed'));
    await tester.pumpAndSettle();
    expect(find.text('Edit chore'), findsOneWidget);
    await tester.tap(find.text('End chore'));
    await tester.pumpAndSettle();
    // One confirmation, then it is gone.
    expect(find.textContaining('leaves the list'), findsOneWidget);
    await tester.tap(find.text('End chore').last);
    await tester.pumpAndSettle();
    expect(store.choresOf(cat), isEmpty);
    expect(store.choresOf(cat, includeEnded: true).single.id, chore.id);
    expect(find.text('Today'), findsNothing);
  });

  testWidgets('a paused chore stays in sight, greyed, boxless, editable', (
    tester,
  ) async {
    final chore = feed();
    store.updateChore(chore.copyWith(paused: true));
    await pump(tester, AgendaScreen(store: store));
    expect(find.text('Today'), findsOneWidget);
    expect(find.textContaining('Feed'), findsOneWidget);
    expect(find.textContaining('Paused'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byIcon(Icons.pause_circle_outline), findsOneWidget);
    // Long-press still edits: Resume brings the box back.
    await tester.longPress(find.textContaining('Feed'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Resume'));
    await tester.pumpAndSettle();
    expect(store.choresOf(cat).single.paused, isFalse);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('the cat page orders chores like the agenda', (tester) async {
    Chore make(
      String title,
      ChoreSchedule schedule, {
      ({int hour, int minute})? time,
      bool paused = false,
      DateTime? start,
    }) => store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: title,
        schedule: schedule,
        time: time,
        start: start ?? today,
        paused: paused,
      ),
    );
    make('Evening', const ChoreSchedule.daily(), time: (hour: 19, minute: 0));
    // Started three days ago: next due in a week, not today.
    make(
      'Nails',
      const ChoreSchedule.every(10, ChoreUnit.days),
      start: today.subtract(const Duration(days: 3)),
    );
    make('Resting', const ChoreSchedule.daily(), paused: true);
    make('Litter', const ChoreSchedule.daily());
    make('Morning', const ChoreSchedule.daily(), time: (hour: 7, minute: 0));
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    // Due today in order; the rest behind a fold, closed at first.
    List<String> order() => [
      for (final r in tester
          .widgetList<ListTile>(find.byType(ListTile))
          .map((t) => (t.title as Text).data ?? ''))
        for (final n in ['Litter', 'Morning', 'Evening', 'Nails', 'Resting'])
          if (r.startsWith(n)) n,
    ];
    await tester.ensureVisible(find.text('Coming up'));
    await tester.pumpAndSettle();
    expect(order(), ['Litter', 'Morning', 'Evening']);
    await tester.tap(find.text('Coming up'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.textContaining('Resting'));
    await tester.pumpAndSettle();
    expect(order(), ['Litter', 'Morning', 'Evening', 'Nails', 'Resting']);
    expect(store.localSetting('fold:page-upcoming'), 'open');
  });

  testWidgets('the cat page lists its chores under Planned', (tester) async {
    feed();
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    expect(find.text('Planned'), findsOneWidget);
    expect(find.textContaining('Feed'), findsOneWidget);
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(
      store.choreTicks(store.choresOf(cat).single).containsKey(today),
      isTrue,
    );
    // Ticked, the row is still today's: checked, no "Due tomorrow".
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(find.textContaining('Due'), findsNothing);
    // The day's last chore, ticked here: the cheer fires here too.
    expect(store.localSetting('choresCelebrated'), dayKey(today));
  });

  testWidgets('a tap on the row opens the cat, only the box ticks', (
    tester,
  ) async {
    final chore = feed();
    await pump(tester, AgendaScreen(store: store));
    await tester.tap(find.textContaining('Feed'));
    await tester.pumpAndSettle();
    expect(store.choreTicks(chore), isEmpty);
    expect(find.byType(CatDetailScreen), findsOneWidget);
  });
}
