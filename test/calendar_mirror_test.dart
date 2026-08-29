import 'dart:async';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/reminders/calendar_mirror.dart';
import 'package:catlog/src/reminders/calendar_port.dart';
import 'package:flutter_test/flutter_test.dart';

/// #74: the one-way mirror — the app is the source of truth; events
/// are created, patched, deleted and recreated to match the plans,
/// and nothing the app does not own is ever written.
class FakeCalendar implements CalendarPort {
  final events = <String, EventSpec>{};
  final alerts = <String, int?>{};
  var nextId = 0;
  var created = 0, updated = 0, deleted = 0;
  var calendars = const [
    CalendarChoice(id: 'cal-1', name: 'Work', account: 'me@example.org'),
  ];

  @override
  Future<bool> ensureAccess() async => true;

  @override
  Future<List<CalendarChoice>> listCalendars() async => calendars;

  @override
  Future<String?> createEvent(String calendarId, EventSpec spec) async {
    final id = 'ev-${nextId++}';
    events[id] = spec;
    alerts[id] = spec.alertMinutesBefore;
    created++;
    return id;
  }

  @override
  Future<bool> updateEvent(
      String calendarId, String eventId, EventSpec spec) async {
    events[eventId] = spec; // alerts untouched, like the real port
    updated++;
    return true;
  }

  @override
  Future<void> deleteEvent(String calendarId, String eventId) async {
    events.remove(eventId);
    alerts.remove(eventId);
    deleted++;
  }

  @override
  Future<List<String>> markedEventIds(String calendarId) async => [
        for (final MapEntry(:key, :value) in events.entries)
          if (value.description.contains(eventMarker)) key
      ];
}

/// A calendar that answers only when told — the catalog can be closed
/// in between, as a switch does (#89).
class SlowCalendar extends FakeCalendar {
  final gate = Completer<void>();

  @override
  Future<List<CalendarChoice>> listCalendars() async {
    await gate.future;
    return calendars;
  }
}

/// A calendar whose event creation waits for a gate — the catalog can
/// close while an event is being created.
class SlowCreateCalendar extends FakeCalendar {
  final gate = Completer<void>();

  @override
  Future<String?> createEvent(String calendarId, EventSpec spec) async {
    await gate.future;
    return super.createEvent(calendarId, spec);
  }
}

void main() {
  setUpAll(useSystemSqlite);

  final t = AppLocalizationsEn();
  late CatalogStore store;
  late FakeCalendar calendar;
  late String cat;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    store.setLocalSetting(calendarMirrorEnabledKey, 'on');
    store.setLocalSetting(calendarMirrorCalendarKey, 'cal-1');
    calendar = FakeCalendar();
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  DateTime inDays(int days) => DateTime.now().add(Duration(days: days));

  test('a plan becomes one all-day event with name and field', () async {
    store.append(cat, Keys.userField('remarks'), 'vaccine refresh',
        date: inDays(30), reminder: true);
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, hasLength(1));
    final event = calendar.events.values.single;
    expect(event.title, contains('Miezi'));
    expect(event.description, contains('vaccine refresh'));
    expect(event.allDay, isTrue);
    expect(event.alertMinutesBefore, isNull);
  });

  test('reconcile twice changes nothing', () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    await reconcileCalendar(store, calendar, t);
    expect(calendar.created, 1);
    expect(calendar.updated, 0);
    expect(calendar.deleted, 0);
  });

  test('a rescheduled plan patches its event in place', () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    final id = calendar.events.keys.single;
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(20), reminder: true);
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events.keys.single, id);
    expect(calendar.updated, 1);
    expect(calendar.events[id]!.start.day, inDays(20).day);
  });

  test('a done plan loses its event', () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    store.append(cat, Keys.userField('remarks'), 'worming');
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, isEmpty);
    expect(calendar.deleted, 1);
  });

  test('an event the user deleted stays deleted', () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    calendar.events.clear(); // deleted by hand in the calendar app
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, isEmpty);
    expect(calendar.created, 1);
  });

  test('two reconciles at once create one event, not two', () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    final slow = SlowCalendar();
    final first = reconcileCalendarOnce(store, slow, t);
    final second = reconcileCalendarOnce(store, slow, t);
    slow.gate.complete();
    await first;
    await second;
    expect(slow.created, 1);
    expect(slow.events, hasLength(1));
  });

  test('resync removes every cat(a)log event and writes the plans fresh',
      () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    // Three stray copies from the old overlapping syncs, plus one the
    // user made by hand.
    final copy = calendar.events.values.single;
    for (var i = 0; i < 3; i++) {
      await calendar.createEvent('cal-1', copy);
    }
    await calendar.createEvent(
        'cal-1',
        EventSpec(
            start: inDays(1),
            end: inDays(2),
            allDay: true,
            title: 'Dentist',
            description: 'mine',
            alertMinutesBefore: null));
    expect(calendar.events, hasLength(5));
    final outcome = await resyncCalendar(store, calendar, t);
    expect(outcome, MirrorOutcome.ok);
    expect(calendar.events, hasLength(2));
    expect(calendar.events.values.map((e) => e.title),
        containsAll(['Dentist']));
    expect(calendar.events.values.where((e) => e.title.contains('Miezi')),
        hasLength(1));
  });

  test('the mirror stays silent when switched off', () async {
    store.setLocalSetting(calendarMirrorEnabledKey, 'off');
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, isEmpty);
  });

  test('no chosen calendar is reported, not guessed', () async {
    store.removeLocalSetting(calendarMirrorCalendarKey);
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    final outcome = await reconcileCalendar(store, calendar, t);
    expect(outcome, MirrorOutcome.noCalendarChosen);
    expect(calendar.events, isEmpty);
  });

  test('a vanished calendar is reported', () async {
    calendar.calendars = const [];
    final outcome = await reconcileCalendar(store, calendar, t);
    expect(outcome, MirrorOutcome.calendarGone);
  });

  test('switching calendars moves the events instead of doubling them',
      () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    calendar.calendars = const [
      CalendarChoice(id: 'cal-1', name: 'Work'),
      CalendarChoice(id: 'cal-2', name: 'Home'),
    ];
    store.setLocalSetting(calendarMirrorCalendarKey, 'cal-2');
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, hasLength(1));
    expect(calendar.deleted, 1);
    expect(calendar.created, 2);
  });

  test('an appointment becomes a timed event with its alert', () async {
    store.createAppointment(Appointment(
      id: '',
      entity: cat,
      date: DateTime(2026, 9, 3),
      time: (hour: 14, minute: 30),
      title: 'Vet',
      notes: 'bring the form',
      alert: AppointmentAlert.hourBefore,
    ));
    await reconcileCalendar(store, calendar, t);
    final event = calendar.events.values.single;
    expect(event.allDay, isFalse);
    expect(event.start, DateTime(2026, 9, 3, 14, 30));
    expect(event.end, DateTime(2026, 9, 3, 15, 30));
    expect(event.title, 'Miezi — Vet');
    expect(event.description, contains('bring the form'));
    expect(event.alertMinutesBefore, 60);
  });

  test('an all-day appointment without alert stays silent', () async {
    store.createAppointment(Appointment(
      id: '',
      entity: cat,
      date: DateTime(2026, 9, 3),
      title: 'Vet',
      alert: AppointmentAlert.none,
    ));
    await reconcileCalendar(store, calendar, t);
    final event = calendar.events.values.single;
    expect(event.allDay, isTrue);
    expect(event.alertMinutesBefore, isNull);
  });

  test('finishing an appointment removes its event', () async {
    final made = store.createAppointment(Appointment(
        id: '', entity: cat, date: DateTime(2026, 9, 3), title: 'Vet'));
    await reconcileCalendar(store, calendar, t);
    store.finishAppointment(made, notes: 'fine');
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, isEmpty);
  });

  test('rescheduling patches the event and leaves its alert alone',
      () async {
    final made = store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime(2026, 9, 3),
        time: (hour: 9, minute: 0),
        title: 'Vet',
        alert: AppointmentAlert.dayBefore));
    await reconcileCalendar(store, calendar, t);
    final id = calendar.events.keys.single;
    store.updateAppointment(made.copyWith(date: DateTime(2026, 9, 4)));
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events.keys.single, id);
    expect(calendar.events[id]!.start, DateTime(2026, 9, 4, 9, 0));
    expect(calendar.alerts[id], 24 * 60);
    expect(calendar.updated, 1);
  });

  test('a catalog closed mid-reconcile is left alone, without an error',
      () async {
    store.append(cat, Keys.userField('remarks'), 'vaccine refresh',
        date: inDays(30), reminder: true);
    final slow = SlowCalendar();
    final pending = reconcileCalendar(store, slow, t);
    store.close();
    slow.gate.complete();
    expect(await pending, MirrorOutcome.abandoned);
    expect(slow.created, 0);
    // tearDown closes again; a second close must not throw either.
    store = CatalogStore.inMemory()..author = 'test';
  });

  test('an event created while the catalog closed is deleted again',
      () async {
    store.append(cat, Keys.userField('remarks'), 'vaccine refresh',
        date: inDays(30), reminder: true);
    final slow = SlowCreateCalendar();
    final pending = reconcileCalendar(store, slow, t);
    await Future<void>.delayed(Duration.zero);
    store.close();
    slow.gate.complete();
    expect(await pending, MirrorOutcome.abandoned);
    expect(slow.created, 1);
    expect(slow.events, isEmpty, reason: 'nothing recorded, nothing kept');
    store = CatalogStore.inMemory()..author = 'test';
  });

  test('resync waits for a running reconcile instead of racing it',
      () async {
    store.append(cat, Keys.userField('remarks'), 'vaccine refresh',
        date: inDays(30), reminder: true);
    final slow = SlowCalendar();
    final running = reconcileCalendarOnce(store, slow, t);
    final resync = resyncCalendar(store, slow, t);
    slow.gate.complete();
    await running;
    expect(await resync, MirrorOutcome.ok);
    expect(slow.events, hasLength(1));
  });

  test('a calendar that never answers releases the catalog after the limit',
      () async {
    store.append(cat, Keys.userField('remarks'), 'vaccine refresh',
        date: inDays(30), reminder: true);
    final slow = SlowCalendar(); // gate never completes
    await expectLater(
        reconcileCalendarOnce(store, slow, t,
            timeout: const Duration(milliseconds: 100)),
        throwsA(isA<TimeoutException>()));
    // The next pass is not blocked by the stuck one.
    final fresh = FakeCalendar();
    expect(await reconcileCalendarOnce(store, fresh, t), MirrorOutcome.ok);
  });
}
