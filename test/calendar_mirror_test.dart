import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/reminders/calendar_mirror.dart';
import 'package:catlog/src/reminders/calendar_port.dart';
import 'package:flutter_test/flutter_test.dart';

/// #74: the one-way mirror — the app is the source of truth; events
/// are created, patched, deleted and recreated to match the plans,
/// and nothing the app does not own is ever written.
class FakeCalendar implements CalendarPort {
  final events = <String, ({DateTime day, String title, String desc})>{};
  var nextId = 0;
  var created = 0, updated = 0, deleted = 0;

  @override
  Future<bool> ensureAccess() async => true;

  @override
  Future<String?> ensureCalendar() async => 'cal-1';

  @override
  Future<String?> createEvent(String calendarId, DateTime day,
      String title, String description) async {
    final id = 'ev-${nextId++}';
    events[id] = (day: day, title: title, desc: description);
    created++;
    return id;
  }

  @override
  Future<bool> updateEvent(String calendarId, String eventId, DateTime day,
      String title, String description) async {
    events[eventId] = (day: day, title: title, desc: description);
    updated++;
    return true;
  }

  @override
  Future<void> deleteEvent(String calendarId, String eventId) async {
    events.remove(eventId);
    deleted++;
  }

  @override
  Future<Set<String>> existingEventIds(
          String calendarId, Iterable<String> ids) async =>
      ids.where(events.containsKey).toSet();
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
    expect(event.desc, contains('vaccine refresh'));
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
    expect(calendar.events[id]!.day.day, inDays(20).day);
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

  test('an event the user deleted is recreated while the plan lives',
      () async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    calendar.events.clear(); // deleted by hand in the calendar app
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, hasLength(1));
    expect(calendar.created, 2);
  });

  test('the mirror stays silent when switched off', () async {
    store.setLocalSetting(calendarMirrorEnabledKey, 'off');
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(10), reminder: true);
    await reconcileCalendar(store, calendar, t);
    expect(calendar.events, isEmpty);
  });
}
