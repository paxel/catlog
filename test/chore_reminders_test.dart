import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/chores/chore_dialog.dart';
import 'package:catlog/src/chores/chore_reminders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A port that records what was scheduled and answers the permission
/// question as told.
class _FakePort implements ReminderPort {
  bool allow = true;
  int permissionAsks = 0;
  int cancels = 0;
  int batteryOpens = 0;
  final scheduled = <(int, DateTime, String, String)>[];

  @override
  Future<bool> ensurePermission() async {
    permissionAsks++;
    return allow;
  }

  @override
  Future<void> schedule(int id, DateTime at, String title, String body) async {
    scheduled.add((id, at, title, body));
  }

  @override
  Future<void> cancelAll() async {
    cancels++;
    scheduled.clear();
  }

  @override
  Future<bool> openBatterySettings() async {
    batteryOpens++;
    return true;
  }
}

/// Chore reminders: which chores get one and when, the rebuild after a
/// change, and the dialog switch that asks for permission first.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;
  final mon = DateTime(2026, 9, 7); // a Monday

  setUp(() {
    store = CatalogStore.inMemory()..author = 'anna';
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  Chore make({
    ChoreSchedule schedule = const ChoreSchedule.daily(),
    ({int hour, int minute})? time,
    bool remind = true,
    ({int hour, int minute})? remindAt,
    DateTime? start,
  }) => store.createChore(
    Chore(
      id: '',
      entity: cat,
      title: 'Feed',
      schedule: schedule,
      time: time,
      start: start ?? mon,
      remind: remind,
      remindAt: remindAt,
    ),
  );

  group('planned reminders', () {
    test('a due chore with a time reminds today, once the time is ahead', () {
      make(remindAt: (hour: 18, minute: 0));
      final planned = plannedReminders(store, DateTime(2026, 9, 8, 9));
      expect(planned.single.at, DateTime(2026, 9, 8, 18));
    });

    test('a passed time or a ticked day moves it to the next due day', () {
      final feed = make(remindAt: (hour: 8, minute: 30));
      expect(
        plannedReminders(store, DateTime(2026, 9, 8, 9)).single.at,
        DateTime(2026, 9, 9, 8, 30),
      );
      store.tickChore(feed, DateTime(2026, 9, 8), doneOn: DateTime(2026, 9, 8));
      expect(
        plannedReminders(store, DateTime(2026, 9, 8, 7)).single.at,
        DateTime(2026, 9, 9, 8, 30),
      );
    });

    test('the chore time serves when no reminder time was chosen', () {
      make(time: (hour: 20, minute: 15));
      expect(
        plannedReminders(store, DateTime(2026, 9, 8, 9)).single.at,
        DateTime(2026, 9, 8, 20, 15),
      );
    });

    test('off, paused, ended and timeless chores stay silent', () {
      make(remind: false, remindAt: (hour: 8, minute: 0));
      make();
      final paused = make(remindAt: (hour: 8, minute: 0));
      store.updateChore(paused.copyWith(paused: true));
      final ended = make(remindAt: (hour: 8, minute: 0));
      store.updateChore(ended.copyWith(ended: true));
      expect(plannedReminders(store, DateTime(2026, 9, 8, 7)), isEmpty);
    });

    test('every-N and weekday chores remind on their next due day', () {
      make(
        schedule: const ChoreSchedule.everyDays(3),
        remindAt: (hour: 9, minute: 0),
      );
      make(
        schedule: ChoreSchedule.weekdays({DateTime.friday}),
        remindAt: (hour: 9, minute: 0),
      );
      final planned = plannedReminders(store, DateTime(2026, 9, 8, 12));
      expect(planned.map((p) => p.at), [
        DateTime(2026, 9, 10, 9),
        DateTime(2026, 9, 11, 9),
      ]);
    });
  });

  test('a rebuild cancels the old set and schedules the new one', () async {
    final port = _FakePort();
    final feed = make(remindAt: (hour: 18, minute: 0));
    await rescheduleChoreReminders(
      store,
      port,
      now: DateTime(2026, 9, 8, 9),
      body: (c) => 'Miezi',
    );
    expect(port.cancels, 1);
    expect(port.scheduled.single.$3, 'Feed');
    expect(port.scheduled.single.$4, 'Miezi');
    final firstId = port.scheduled.single.$1;

    store.tickChore(feed, DateTime(2026, 9, 8), doneOn: DateTime(2026, 9, 8));
    await rescheduleChoreReminders(
      store,
      port,
      now: DateTime(2026, 9, 8, 9),
      body: (c) => 'Miezi',
    );
    expect(port.cancels, 2);
    expect(port.scheduled.single.$1, firstId, reason: 'same chore, same id');
    expect(port.scheduled.single.$2, DateTime(2026, 9, 9, 18));
  });

  group('the dialog switch', () {
    late _FakePort port;
    Chore? saved;

    Widget host() => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              saved = await showChoreDialog(
                context,
                store,
                entityId: cat,
                reminders: port,
              );
            },
            child: const Text('open'),
          ),
        ),
      ),
    );

    setUp(() {
      port = _FakePort();
      saved = null;
    });

    testWidgets('refused permission says so and leaves the switch off', (
      tester,
    ) async {
      port.allow = false;
      await tester.pumpWidget(host());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Feed');
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(port.permissionAsks, 1);
      expect(
        find.textContaining('No permission for notifications'),
        findsOneWidget,
      );
      expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(saved!.remind, isFalse);
    });

    testWidgets('granted permission asks the time and saves the reminder', (
      tester,
    ) async {
      await tester.pumpWidget(host());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Feed');
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      // The time picker, accepted as offered.
      expect(find.byType(TimePickerDialog), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(saved!.remind, isTrue);
      expect(saved!.remindAt, (hour: 8, minute: 0));
      expect(store.choresOf(cat).single.remind, isTrue);
    });
  });
}
