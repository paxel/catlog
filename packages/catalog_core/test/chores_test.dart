import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Chores: what is due when, what a tick does to the schedule, streaks
/// and week dots, and two keepers ticking the same days.
void main() {
  setUpAll(useSystemSqlite);

  final mon = DateTime(2026, 9, 7); // a Monday
  DateTime d(int offset) => mon.add(Duration(days: offset));

  Chore chore(ChoreSchedule s, {DateTime? start}) => Chore(
      id: 'x',
      entity: 'cat:1',
      title: 'Feed',
      schedule: s,
      start: start ?? mon);

  group('schedule maths', () {
    test('daily is due every day from its start', () {
      final c = chore(const ChoreSchedule.daily());
      expect(occurrences(c, {}, d(-3), d(2)).map((o) => o.due),
          [d(0), d(1), d(2)]);
    });

    test('weekdays fall on the chosen days', () {
      final c =
          chore(ChoreSchedule.weekdays({DateTime.monday, DateTime.thursday}));
      expect(occurrences(c, {}, d(0), d(13)).map((o) => o.due),
          [d(0), d(3), d(7), d(10)]);
    });

    test('every N days counts from the start, then from the last done', () {
      final c = chore(const ChoreSchedule.everyDays(3));
      expect(occurrences(c, {}, d(0), d(9)).map((o) => o.due),
          [d(0), d(3), d(6), d(9)]);
      // Done on time on day 3: next on day 6.
      expect(
          occurrences(c, {d(0): d(0), d(3): d(3)}, d(0), d(9))
              .map((o) => o.due),
          [d(0), d(3), d(6), d(9)]);
      // Day 3 done early, on day 1: the schedule restarts from day 1.
      expect(
          occurrences(c, {d(0): d(0), d(3): d(1)}, d(0), d(9))
              .map((o) => o.due),
          [d(0), d(3), d(4), d(7)]);
      // Day 3 done late, on day 5: next on day 8, day 3 counts as done.
      final late = occurrences(c, {d(0): d(0), d(3): d(5)}, d(0), d(9));
      expect(late.map((o) => o.due), [d(0), d(3), d(8)]);
      expect(late[1].done, isTrue);
    });

    test('a gap can be weeks, months or years; months step by calendar', () {
      final weekly = chore(const ChoreSchedule.every(2, ChoreUnit.weeks));
      expect(occurrences(weekly, {}, d(0), d(30)).map((o) => o.due),
          [d(0), d(14), d(28)]);
      final monthly = chore(const ChoreSchedule.every(1, ChoreUnit.months),
          start: DateTime(2026, 1, 31));
      expect(
          occurrences(monthly, {}, DateTime(2026, 1, 1), DateTime(2026, 4, 30))
              .map((o) => o.due),
          [
            DateTime(2026, 1, 31),
            DateTime(2026, 2, 28),
            DateTime(2026, 3, 28),
            DateTime(2026, 4, 28),
          ]);
      final yearly = chore(const ChoreSchedule.every(1, ChoreUnit.years),
          start: DateTime(2026, 3, 1));
      // Done late, in April: the next one is a year from then.
      final ticks = {DateTime(2026, 3, 1): DateTime(2026, 4, 10)};
      expect(
          nextDue(yearly, ticks, DateTime(2026, 5, 1)), DateTime(2027, 4, 10));
      expect(monthsFrom(DateTime(2024, 1, 31), 1), DateTime(2024, 2, 29));
      expect(monthsFrom(DateTime(2026, 11, 15), 3), DateTime(2027, 2, 15));
    });

    test('the unit travels in the JSON and old JSON reads as days', () {
      final s = const ChoreSchedule.every(3, ChoreUnit.months);
      final back = ChoreSchedule.fromJson(s.toJson());
      expect(back.unit, ChoreUnit.months);
      expect(back.every, 3);
      expect(const ChoreSchedule.everyDays(5).toJson().containsKey('unit'),
          isFalse);
      expect(ChoreSchedule.fromJson({'repeat': 'everyDays', 'every': 4}).unit,
          ChoreUnit.days);
    });

    test('a due day without a tick is missed, today is pending', () {
      final c = chore(const ChoreSchedule.daily());
      final ticks = {d(0): d(0), d(2): d(2)};
      expect(stateOn(c, ticks, d(0), d(3)), ChoreDay.done);
      expect(stateOn(c, ticks, d(1), d(3)), ChoreDay.missed);
      expect(stateOn(c, ticks, d(3), d(3)), ChoreDay.pending);
      expect(stateOn(c, ticks, d(4), d(3)), ChoreDay.upcoming);
      expect(stateOn(c, ticks, d(-1), d(3)), ChoreDay.notDue);
    });

    test('streak counts back from the latest done, skipping a pending today',
        () {
      final c = chore(const ChoreSchedule.daily());
      expect(streak(c, {d(0): d(0), d(1): d(1), d(2): d(2)}, d(2)), 3);
      // Today not yet done: the run from yesterday still stands.
      expect(streak(c, {d(0): d(0), d(1): d(1), d(2): d(2)}, d(3)), 3);
      // A miss yesterday ends it.
      expect(streak(c, {d(0): d(0), d(1): d(1)}, d(3)), 0);
      expect(bestStreak(c, {d(0): d(0), d(1): d(1), d(3): d(3)}, d(4)), 2);
    });

    test('week dots read the last seven days', () {
      final c = chore(const ChoreSchedule.everyDays(2));
      final dots = weekDots(c, {d(0): d(0), d(4): d(4)}, d(6));
      expect(dots, [
        ChoreDay.done, // day 0
        ChoreDay.notDue,
        ChoreDay.missed, // day 2
        ChoreDay.notDue,
        ChoreDay.done, // day 4
        ChoreDay.notDue,
        ChoreDay.pending, // day 6
      ]);
    });

    test('upcoming lists the next week without dailies', () {
      final daily = chore(const ChoreSchedule.daily());
      expect(upcoming(daily, {}, d(0)), isEmpty);
      final nails = chore(const ChoreSchedule.everyDays(10), start: d(-5));
      expect(upcoming(nails, {}, d(0)), [d(5)]);
      final drops = chore(ChoreSchedule.weekdays({DateTime.wednesday}));
      expect(upcoming(drops, {}, d(0)), [d(2)]);
      expect(nextDue(nails, {d(5): d(0)}, d(0)), d(10));
    });
  });

  group('in the store', () {
    late CatalogStore a;
    late CatalogStore b;

    setUp(() {
      a = CatalogStore.inMemory()..author = 'anna';
      b = CatalogStore.inMemory()..author = 'bob';
    });

    tearDown(() {
      a.close();
      b.close();
    });

    void exchange() {
      b.applyEntries(a.entriesSince(b.versionVector()),
          senderVector: a.versionVector());
      a.applyEntries(b.entriesSince(a.versionVector()),
          senderVector: b.versionVector());
    }

    test('a chore is created, listed, edited, ended', () {
      final cat = a.createCat('Miezi');
      final made = a.createChore(Chore(
          id: '',
          entity: cat,
          title: 'Eye drops',
          schedule: const ChoreSchedule.daily(),
          time: (hour: 20, minute: 0),
          start: mon));
      expect(a.choresOf(cat).single.title, 'Eye drops');
      expect(a.choresOf(cat).single.time, (hour: 20, minute: 0));
      a.updateChore(made.copyWith(paused: true));
      expect(a.choresOf(cat).single.active, isFalse);
      a.updateChore(made.copyWith(ended: true));
      expect(a.choresOf(cat), isEmpty);
      expect(a.choresOf(cat, includeEnded: true), hasLength(1));
      expect(a.allChores(), isEmpty);
    });

    test('ticks travel and merge; an untick is a later entry', () {
      final cat = a.createCat('Miezi');
      final feed = a.createChore(Chore(
          id: '',
          entity: cat,
          title: 'Feed',
          schedule: const ChoreSchedule.daily(),
          start: mon));
      exchange();
      final onB = b.choresOf(cat).single;
      expect(onB.id, feed.id);

      a.tickChore(feed, d(0), doneOn: d(0));
      b.tickChore(onB, d(0), doneOn: d(0));
      b.tickChore(onB, d(1), doneOn: d(1));
      exchange();
      final ticks = a.choreTicks(feed);
      expect(ticks, {d(0): d(0), d(1): d(1)});
      expect(streak(feed, ticks, d(1)), 2);

      a.untickChore(feed, d(1));
      exchange();
      expect(b.choreTicks(onB), {d(0): d(0)});
    });

    test('an early tick names the occurrence it settles', () {
      final cat = a.createCat('Miezi');
      final nails = a.createChore(Chore(
          id: '',
          entity: cat,
          title: 'Nails',
          schedule: const ChoreSchedule.everyDays(14),
          start: mon));
      // Due on day 14; done on day 10.
      a.tickChore(nails, d(14), doneOn: d(10));
      final ticks = a.choreTicks(nails);
      expect(stateOn(nails, ticks, d(14), d(10)), ChoreDay.done);
      expect(nextDue(nails, ticks, d(10)), d(24));
    });

    test('the log tells each due day: done by whom, missed, open', () {
      final cat = a.createCat('Miezi');
      final meds = a.createChore(Chore(
          id: '',
          entity: cat,
          title: 'Meds',
          schedule: const ChoreSchedule.daily(),
          start: d(0)));
      a.tickChore(meds, d(0), doneOn: d(0));
      b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
      final onB = b.choresOf(cat).single;
      b.tickChore(onB, d(2), doneOn: d(3)); // a day late, by bob
      exchange();
      final log = a.choreLog(meds, d(3));
      expect(log.map((r) => r.due), [d(3), d(2), d(1), d(0)]);
      expect(log[0].state, ChoreDay.pending);
      expect(log[1].state, ChoreDay.done);
      expect(log[1].author, 'bob');
      expect(log[1].late, isTrue);
      expect(log[2].state, ChoreDay.missed);
      expect(log[3].author, 'anna');
      expect(log[3].early, isFalse);
    });

    test('the chore keys stay out of the cat\'s ordinary fields', () {
      final cat = a.createCat('Miezi');
      a.createChore(Chore(
          id: '',
          entity: cat,
          title: 'Feed',
          schedule: const ChoreSchedule.daily(),
          start: mon));
      expect(a.cats().single.name, 'Miezi');
      expect(a.choresOf(cat), hasLength(1));
    });
  });
}
