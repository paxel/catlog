import 'dart:convert';

import 'entry.dart';
import 'fields.dart';
import 'store.dart';

/// Chores (1.2.0): the recurring care of a cat or a home — feeding,
/// drops, litter — as a daily checklist with streaks. A chore is one
/// `$chore:<id>` entry on the animal whose value is [Chore.toJson];
/// edits, pausing and ending are later entries on the same key. A tick
/// is its own entry keyed by the occurrence day, so two keepers ticking
/// the same day merge into one done and an untick is a later entry.
/// Everything syncs, reverts and merges like every other value.

/// How often a chore comes around; [once] not again (2.3.0).
enum ChoreRepeat { daily, everyDays, weekdays, once }

/// The gap a one-time chore is stored with, so an app from before 2.3.0
/// reads an every-N chore due on its first day only and keeps it so on
/// an edit — it does not know [ChoreRepeat.once] and would make it daily.
const onceGapDays = 36500;

/// The unit of an every-N gap: a vaccine comes every year, not every
/// 365 days. Months and years step by the calendar — the 31st becomes
/// the last day of a shorter month.
enum ChoreUnit { days, weeks, months, years }

class ChoreSchedule {
  final ChoreRepeat repeat;

  /// For [ChoreRepeat.everyDays]: the gap in [unit]s, counted from the
  /// day the chore was last done — done early or late, the next one
  /// moves.
  final int every;
  final ChoreUnit unit;

  /// For [ChoreRepeat.weekdays]: `DateTime.monday`..`DateTime.sunday`.
  final Set<int> weekdays;

  const ChoreSchedule.daily()
      : repeat = ChoreRepeat.daily,
        every = 1,
        unit = ChoreUnit.days,
        weekdays = const {};

  const ChoreSchedule.everyDays(this.every)
      : repeat = ChoreRepeat.everyDays,
        unit = ChoreUnit.days,
        weekdays = const {};

  /// Every [every] [unit]s.
  const ChoreSchedule.every(this.every, this.unit)
      : repeat = ChoreRepeat.everyDays,
        weekdays = const {};

  const ChoreSchedule.weekdays(this.weekdays)
      : repeat = ChoreRepeat.weekdays,
        every = 1,
        unit = ChoreUnit.days;

  /// Done once, then gone; due by [Chore.due] when that is set.
  const ChoreSchedule.once()
      : repeat = ChoreRepeat.once,
        every = 1,
        unit = ChoreUnit.days,
        weekdays = const {};

  /// [day] moved forward by the gap.
  DateTime step(DateTime day) => switch (unit) {
        ChoreUnit.days => daysFrom(day, every),
        ChoreUnit.weeks => daysFrom(day, 7 * every),
        ChoreUnit.months => monthsFrom(day, every),
        ChoreUnit.years => monthsFrom(day, 12 * every),
      };

  Map<String, dynamic> toJson() => repeat == ChoreRepeat.once
      ? const {'repeat': 'everyDays', 'every': onceGapDays}
      : {
          'repeat': repeat.name,
          if (repeat == ChoreRepeat.everyDays) 'every': every,
          // Absent for days, so a 1.2.0 reader sees the old shape; it
          // reads a gap in other units as days, the best it can do.
          if (repeat == ChoreRepeat.everyDays && unit != ChoreUnit.days)
            'unit': unit.name,
          if (repeat == ChoreRepeat.weekdays) 'days': weekdays.toList()..sort(),
        };

  static ChoreSchedule fromJson(Map<String, dynamic> json) {
    switch (json['repeat']) {
      case 'everyDays':
        return ChoreSchedule.every((json['every'] as num?)?.toInt() ?? 1,
            ChoreUnit.values.asNameMap()[json['unit']] ?? ChoreUnit.days);
      case 'weekdays':
        return ChoreSchedule.weekdays({
          for (final d in json['days'] as List? ?? const []) (d as num).toInt()
        });
      default:
        return const ChoreSchedule.daily();
    }
  }
}

/// Whether the chore is due on a day depends on [ChoreSchedule] and, for
/// every-N-days, on when it was last done.
class Chore {
  final String id;
  final String entity;
  final String title;
  final ChoreSchedule schedule;

  /// Time of day it is meant for; null when any time will do.
  final ({int hour, int minute})? time;

  /// The first day it is due.
  final DateTime start;
  final bool paused;
  final bool ended;

  /// A phone reminder on due days, at [remindAt]; off by default.
  final bool remind;
  final ({int hour, int minute})? remindAt;

  /// For a one-time chore: the day it must be done by; null when any
  /// day will do. [start] is that day, or the day the chore was made.
  final DateTime? due;

  /// Keys this version does not know, carried through unchanged.
  final Map<String, dynamic> extra;

  const Chore({
    required this.id,
    required this.entity,
    required this.title,
    required this.schedule,
    required this.start,
    this.time,
    this.paused = false,
    this.ended = false,
    this.remind = false,
    this.remindAt,
    this.due,
    this.extra = const {},
  });

  String get key => Keys.chore(id);

  bool get once => schedule.repeat == ChoreRepeat.once;

  bool get active => !paused && !ended;

  Chore copyWith({
    String? title,
    ChoreSchedule? schedule,
    ({int hour, int minute})? time,
    bool clearTime = false,
    DateTime? start,
    bool? paused,
    bool? ended,
    bool? remind,
    ({int hour, int minute})? remindAt,
    DateTime? due,
    bool clearDue = false,
  }) =>
      Chore(
        id: id,
        entity: entity,
        extra: extra,
        due: clearDue ? null : (due ?? this.due),
        title: title ?? this.title,
        schedule: schedule ?? this.schedule,
        time: clearTime ? null : (time ?? this.time),
        start: start ?? this.start,
        paused: paused ?? this.paused,
        ended: ended ?? this.ended,
        remind: remind ?? this.remind,
        remindAt: remindAt ?? this.remindAt,
      );

  static const _known = {
    'title',
    'schedule',
    'time',
    'start',
    'paused',
    'ended',
    'remind',
    'remindAt',
    'once',
    'due',
  };

  Map<String, dynamic> toJson() => {
        ...extra,
        'title': title,
        'schedule': schedule.toJson(),
        if (time != null) 'time': _hhmm(time!),
        // A one-time chore starts on its due day: the one day an app
        // from before 2.3.0 shows it.
        'start': dayKey(once && due != null ? due! : start),
        if (paused) 'paused': true,
        if (ended) 'ended': true,
        if (remind) 'remind': true,
        if (remindAt != null) 'remindAt': _hhmm(remindAt!),
        // Read only from 2.3.0 on; an older app keeps both as unknown keys.
        if (once) 'once': true,
        if (once && due != null) 'due': dayKey(due!),
      };

  /// Parses a stored value; null when it is not a chore document.
  static Chore? fromJson(String id, String entity, String? raw) {
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final once = json['once'] == true;
      return Chore(
        id: id,
        entity: entity,
        title: json['title'] as String? ?? '',
        schedule: once
            ? const ChoreSchedule.once()
            : ChoreSchedule.fromJson(
                (json['schedule'] as Map?)?.cast<String, dynamic>() ??
                    const {}),
        due: once ? parseDay(json['due'] as String?) : null,
        time: _parseHhmm(json['time'] as String?),
        start: parseDay(json['start'] as String?) ?? DateTime(1970),
        paused: json['paused'] == true,
        ended: json['ended'] == true,
        remind: json['remind'] == true,
        remindAt: _parseHhmm(json['remindAt'] as String?),
        extra: {
          for (final e in json.entries)
            if (!_known.contains(e.key)) e.key: e.value
        },
      );
    } catch (_) {
      return null;
    }
  }
}

String _hhmm(({int hour, int minute}) t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

({int hour, int minute})? _parseHhmm(String? raw) {
  if (raw == null) return null;
  final parts = raw.split(':');
  if (parts.length != 2) return null;
  final h = int.tryParse(parts[0]), m = int.tryParse(parts[1]);
  if (h == null || m == null) return null;
  return (hour: h, minute: m);
}

/// A calendar day, local, at midnight.
DateTime dayOf(DateTime d) => DateTime(d.year, d.month, d.day);

/// [n] calendar days on from [d]. Not `add(Duration)`: across a clock
/// change that lands an hour off midnight, and a day keyed at 01:00 is
/// not the day keyed at 00:00.
DateTime daysFrom(DateTime d, int n) => DateTime(d.year, d.month, d.day + n);

/// [day] plus [n] calendar months, the day of month kept where the
/// target month has it and clamped to its last day otherwise (31 Jan +
/// 1 month = 28 or 29 Feb). Midnight, DST-safe like [daysFrom].
DateTime monthsFrom(DateTime day, int n) {
  final month = day.month - 1 + n;
  final year = day.year + month ~/ 12;
  final m = month % 12 + 1;
  final last = DateTime(year, m + 1, 0).day;
  return DateTime(year, m, day.day < last ? day.day : last);
}

/// `YYYY-MM-DD` of a day — the tick key's suffix and the tick's value.
String dayKey(DateTime d) => '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

DateTime? parseDay(String? raw) {
  if (raw == null) return null;
  final parts = raw.split('-');
  if (parts.length != 3) return null;
  final y = int.tryParse(parts[0]), m = int.tryParse(parts[1]);
  final d = int.tryParse(parts[2]);
  if (y == null || m == null || d == null) return null;
  return DateTime(y, m, d);
}

/// What a day is for a chore.
enum ChoreDay { notDue, pending, done, missed, upcoming }

/// One occurrence of a chore: the day it was due and, when done, the
/// day it was done.
class ChoreOccurrence {
  final DateTime due;
  final DateTime? doneOn;

  const ChoreOccurrence(this.due, this.doneOn);

  bool get done => doneOn != null;
}

/// The occurrences of [chore] with due day in [from]..[to] inclusive,
/// given its ticks (occurrence day → done day), oldest first. For an
/// every-N chore the next due day counts N from the day it was last
/// done, so an early tick pulls the schedule forward and a late one
/// pushes it back; a due day with no tick is a miss.
List<ChoreOccurrence> occurrences(
    Chore chore, Map<DateTime, DateTime> ticks, DateTime from, DateTime to) {
  from = dayOf(from);
  to = dayOf(to);
  final start = dayOf(chore.start);
  final result = <ChoreOccurrence>[];
  void add(DateTime due) {
    if (due.isBefore(from) || due.isAfter(to)) return;
    result.add(ChoreOccurrence(due, ticks[due]));
  }

  switch (chore.schedule.repeat) {
    case ChoreRepeat.once:
      // One occurrence, on its first day; any tick settles it.
      final done = ticks.values.firstOrNull;
      if (!start.isBefore(from) && !start.isAfter(to)) {
        result.add(ChoreOccurrence(start, done));
      }
    case ChoreRepeat.daily:
    case ChoreRepeat.weekdays:
      final days = chore.schedule.weekdays;
      for (var day = start.isAfter(from) ? start : from;
          !day.isAfter(to);
          day = daysFrom(day, 1)) {
        if (chore.schedule.repeat == ChoreRepeat.daily ||
            days.contains(day.weekday)) {
          add(day);
        }
      }
    case ChoreRepeat.everyDays:
      final schedule = chore.schedule.every < 1
          ? ChoreSchedule.every(1, chore.schedule.unit)
          : chore.schedule;
      // Walk the ticks in order of the occurrence they settled: every
      // due day before a tick's occurrence was missed, the tick's own
      // occurrence is done, and the schedule restarts from its done day.
      final settled = ticks.keys.toList()..sort();
      var anchor = start;
      for (final occurrence in settled) {
        while (anchor.isBefore(occurrence)) {
          add(anchor);
          anchor = schedule.step(anchor);
        }
        add(occurrence);
        anchor = schedule.step(dayOf(ticks[occurrence]!));
      }
      while (!anchor.isAfter(to)) {
        add(anchor);
        anchor = schedule.step(anchor);
      }
  }
  return result;
}

/// The state of [day] for [chore], seen from [today].
ChoreDay stateOn(
    Chore chore, Map<DateTime, DateTime> ticks, DateTime day, DateTime today) {
  day = dayOf(day);
  today = dayOf(today);
  final hit = occurrences(chore, ticks, day, day);
  if (hit.isEmpty) return ChoreDay.notDue;
  if (hit.first.done) return ChoreDay.done;
  if (day.isBefore(today)) return ChoreDay.missed;
  if (day.isAfter(today)) return ChoreDay.upcoming;
  return ChoreDay.pending;
}

/// Whether the chore is due on [day] (done or not).
bool isDueOn(Chore chore, Map<DateTime, DateTime> ticks, DateTime day) =>
    occurrences(chore, ticks, day, day).isNotEmpty;

/// The first due day on or after [today] that is not done yet. A
/// one-time chore has one only when it has a due day still ahead.
DateTime? nextDue(Chore chore, Map<DateTime, DateTime> ticks, DateTime today,
    {int horizonDays = 3660}) {
  today = dayOf(today);
  if (chore.once) {
    final due = chore.due;
    if (due == null || ticks.isNotEmpty || dayOf(due).isBefore(today)) {
      return null;
    }
    return dayOf(due);
  }
  for (final o
      in occurrences(chore, ticks, today, daysFrom(today, horizonDays))) {
    if (!o.done) return o.due;
  }
  return null;
}

/// Due days after [today] within [days] that are not done: the Upcoming
/// list. Dailies are left out — they are upcoming by nature.
List<DateTime> upcoming(
    Chore chore, Map<DateTime, DateTime> ticks, DateTime today,
    {int days = 7}) {
  // Dailies are upcoming by nature; a one-time chore stands in today's
  // list until it is done.
  if (chore.schedule.repeat == ChoreRepeat.daily || chore.once) {
    return const [];
  }
  today = dayOf(today);
  return [
    for (final o
        in occurrences(chore, ticks, daysFrom(today, 1), daysFrom(today, days)))
      if (!o.done) o.due
  ];
}

/// Consecutive done occurrences up to [today]. Today counts when done
/// and is skipped while still pending; a missed day before that ends
/// the run.
int streak(Chore chore, Map<DateTime, DateTime> ticks, DateTime today) {
  if (chore.once) return 0;
  today = dayOf(today);
  final past = occurrences(chore, ticks, dayOf(chore.start), today);
  var run = 0;
  for (final o in past.reversed) {
    if (o.done) {
      run++;
    } else if (o.due == today) {
      continue;
    } else {
      break;
    }
  }
  return run;
}

/// The longest run of done occurrences ever, up to [today].
int bestStreak(Chore chore, Map<DateTime, DateTime> ticks, DateTime today) {
  if (chore.once) return 0;
  var best = 0, run = 0;
  for (final o in occurrences(chore, ticks, dayOf(chore.start), dayOf(today))) {
    if (o.done) {
      run++;
      if (run > best) best = run;
    } else if (o.due != dayOf(today)) {
      run = 0;
    }
  }
  return best;
}

/// The last seven days ending [today], one state each — the week dots.
List<ChoreDay> weekDots(
    Chore chore, Map<DateTime, DateTime> ticks, DateTime today) {
  today = dayOf(today);
  return [
    for (var i = 6; i >= 0; i--)
      stateOn(chore, ticks, daysFrom(today, -i), today)
  ];
}

/// Where a one-time chore stands in today's list, top to bottom.
enum OnceStanding {
  /// Due today or overdue, and not done: at the top.
  due,

  /// Not due yet, or without a due day: at the bottom.
  waiting,

  /// Done today: crossed out until tomorrow.
  doneToday,

  /// Done before today: in no list any more.
  gone,
}

/// Where the one-time [chore] stands on [today].
OnceStanding onceStanding(
    Chore chore, Map<DateTime, DateTime> ticks, DateTime today) {
  today = dayOf(today);
  final done = ticks.values.firstOrNull;
  if (done != null) {
    return dayOf(done).isBefore(today)
        ? OnceStanding.gone
        : OnceStanding.doneToday;
  }
  final due = chore.due;
  if (due != null && !dayOf(due).isAfter(today)) return OnceStanding.due;
  return OnceStanding.waiting;
}

/// Whether [chore] belongs in [today]'s list: due today for a recurring
/// one; for a one-time one, every day until the day after it is done.
bool showsToday(Chore chore, Map<DateTime, DateTime> ticks, DateTime today) =>
    chore.once
        ? onceStanding(chore, ticks, today) != OnceStanding.gone
        : isDueOn(chore, ticks, today);

/// Whether [chore] is part of what [today] asks for — the "all done
/// today" count: a recurring chore due today; a one-time one once its
/// due day has come, or when it was done today. One still waiting for
/// its day is in the list but not yet asked for.
bool countsToday(Chore chore, Map<DateTime, DateTime> ticks, DateTime today) {
  if (!chore.once) return isDueOn(chore, ticks, today);
  final standing = onceStanding(chore, ticks, today);
  return standing == OnceStanding.due || standing == OnceStanding.doneToday;
}

/// Whether [chore] still waits to be done [today].
bool openToday(Chore chore, Map<DateTime, DateTime> ticks, DateTime today) =>
    chore.once
        ? onceStanding(chore, ticks, today) == OnceStanding.due
        : isDueOn(chore, ticks, today) && !ticks.containsKey(dayOf(today));

/// Days from [today] to a one-time chore's due day: negative when
/// overdue, null without a due day.
int? daysToDue(Chore chore, DateTime today) {
  final due = chore.due;
  if (due == null) return null;
  final d = DateTime.utc(due.year, due.month, due.day);
  final t = DateTime.utc(today.year, today.month, today.day);
  return d.difference(t).inDays;
}

/// [chores] in today's order: one-time chores due or overdue first, by
/// due day; then the recurring ones (and one-time ones done today) by
/// time, timeless first, then title; then one-time chores not due yet,
/// by due day, those without one last.
List<Chore> todayOrder(List<Chore> chores,
    Map<DateTime, DateTime> Function(Chore) ticksOf, DateTime today) {
  int group(Chore c) {
    if (!c.once) return 1;
    return switch (onceStanding(c, ticksOf(c), today)) {
      OnceStanding.due => 0,
      OnceStanding.waiting => 2,
      _ => 1,
    };
  }

  int minutes(Chore c) =>
      c.time == null ? -1 : c.time!.hour * 60 + c.time!.minute;
  final far = DateTime(9999);
  return [...chores]..sort((a, b) {
      final byGroup = group(a).compareTo(group(b));
      if (byGroup != 0) return byGroup;
      if (group(a) != 1) {
        final byDue = (a.due ?? far).compareTo(b.due ?? far);
        if (byDue != 0) return byDue;
      } else {
        final byTime = minutes(a).compareTo(minutes(b));
        if (byTime != 0) return byTime;
      }
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
}

/// Chores live in the ordinary entry log; these are the readers and
/// writers around it.
extension Chores on CatalogStore {
  /// Records a new chore and returns it with its fresh id.
  Chore createChore(Chore draft, {DateTime? date}) {
    final made = Chore(
      id: newAppointmentId(),
      entity: draft.entity,
      title: draft.title,
      schedule: draft.schedule,
      time: draft.time,
      start: dayOf(draft.start),
      paused: draft.paused,
      ended: draft.ended,
      remind: draft.remind,
      remindAt: draft.remindAt,
      due: draft.due,
      extra: draft.extra,
    );
    append(made.entity, made.key, jsonEncode(made.toJson()), date: date);
    return made;
  }

  /// Writes the chore as it now is: an edit, a pause, an end.
  void updateChore(Chore chore, {DateTime? date}) =>
      append(chore.entity, chore.key, jsonEncode(chore.toJson()), date: date);

  /// The chores of one cat or home, ended ones on request, by title.
  List<Chore> choresOf(String entity, {bool includeEnded = false}) {
    final canonical = resolveEntity(entity);
    final result = <Chore>[];
    for (final MapEntry(:key, :value) in currentFields(canonical).entries) {
      if (!key.startsWith(Keys.chorePrefix) || key.contains('@')) continue;
      final c = Chore.fromJson(
          key.substring(Keys.chorePrefix.length), canonical, value);
      if (c == null || (c.ended && !includeEnded)) continue;
      result.add(c);
    }
    result
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return result;
  }

  /// Every chore in the catalog.
  List<Chore> allChores({bool includeEnded = false}) => [
        for (final e in [...cats(), ...clowders()])
          ...choresOf(e.id, includeEnded: includeEnded)
      ];

  /// The ticks of a chore: occurrence day → the day it was done.
  Map<DateTime, DateTime> choreTicks(Chore chore) {
    final prefix = '${chore.key}@';
    final ticks = <DateTime, DateTime>{};
    for (final MapEntry(:key, :value)
        in currentFields(resolveEntity(chore.entity)).entries) {
      if (!key.startsWith(prefix)) continue;
      final due = parseDay(key.substring(prefix.length));
      final done = parseDay(value);
      if (due != null && done != null) ticks[due] = done;
    }
    return ticks;
  }

  /// Marks the occurrence due on [occurrence] done — on [doneOn], today
  /// by default; an earlier day than the due one is an early tick.
  void tickChore(Chore chore, DateTime occurrence,
      {DateTime? doneOn, DateTime? date}) {
    final done = dayOf(doneOn ?? DateTime.now());
    append(chore.entity, Keys.choreTick(chore.id, dayKey(dayOf(occurrence))),
        dayKey(done),
        date: date);
  }

  /// Takes a tick back.
  void untickChore(Chore chore, DateTime occurrence, {DateTime? date}) =>
      append(chore.entity, Keys.choreTick(chore.id, dayKey(dayOf(occurrence))),
          null,
          date: date);
}

/// One due day of a chore as the log tells it: done on which day, by
/// whom and when it was recorded, or missed, or still open today.
class ChoreLogRow {
  final DateTime due;
  final ChoreDay state;
  final DateTime? doneOn;
  final String? author;
  final DateTime? recorded;

  /// The tick entry behind a done day — what a correction or removal
  /// acts on. Null unless done.
  final Entry? tick;

  const ChoreLogRow(this.due, this.state,
      {this.doneOn, this.author, this.recorded, this.tick});

  bool get early => doneOn != null && doneOn!.isBefore(due);
  bool get late => doneOn != null && doneOn!.isAfter(due);
}

/// The chore's due days from its start to [today], newest first, each
/// with what happened — the control a medicine needs: was it given on
/// day X, by whom.
extension ChoreLog on CatalogStore {
  List<ChoreLogRow> choreLog(Chore chore, DateTime today) {
    today = dayOf(today);
    final ticks = choreTicks(chore);
    final entity = resolveEntity(chore.entity);
    final rows = <ChoreLogRow>[];
    for (final o in occurrences(chore, ticks, chore.start, today)) {
      final state = stateOn(chore, ticks, o.due, today);
      Entry? tick;
      if (o.done) {
        tick = fieldHistory(entity, Keys.choreTick(chore.id, dayKey(o.due)))
            .where((e) => e.value != null)
            .firstOrNull;
      }
      rows.add(ChoreLogRow(o.due, state,
          doneOn: o.doneOn,
          author: tick?.author,
          recorded: tick?.recorded,
          tick: tick));
    }
    rows.sort((a, b) => b.due.compareTo(a.due));
    return rows;
  }
}
