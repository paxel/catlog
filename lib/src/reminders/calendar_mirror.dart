import 'dart:convert';

import 'package:catalog_core/catalog_core.dart';

import '../field_labels.dart';
import '../../l10n/app_localizations.dart';
import 'calendar_port.dart';

/// Local setting keys — per device by nature (#74): each device
/// manages exactly its own events, so two keepers of one catalog each
/// get the events in their own calendars.
const calendarMirrorEnabledKey = 'calendarMirror';
const calendarMirrorCalendarKey = 'calendarMirror:calendar';
const calendarMirrorCalendarNameKey = 'calendarMirror:calendarName';
const _mapKey = 'calendarMirror:map';

bool calendarMirrorEnabled(CatalogStore store) =>
    store.localSetting(calendarMirrorEnabledKey) == 'on';

/// The calendar the user picked on this device, or null.
String? chosenCalendar(CatalogStore store) =>
    store.localSetting(calendarMirrorCalendarKey);

/// What a reconcile found. Everything but [ok] and [off] names a cause
/// the user can act on; the caller shows it and switches the mirror
/// off, so a silent failure cannot pretend to be a working mirror.
enum MirrorOutcome {
  ok,
  off,
  noAccess,
  noCalendarChosen,
  calendarGone,

  /// The catalog was closed while the calendar was answering (a switch
  /// mid-reconcile, #89); nothing was recorded and nothing is wrong.
  abandoned,
}

/// The events the calendar should hold right now: reminders as all-day
/// events without alert (#74), appointments timed with their alert
/// (#75).
Map<String, EventSpec> desiredEvents(CatalogStore store, AppLocalizations t) {
  final defs = {for (final def in store.fieldDefs()) def.key: def};
  String nameOf(String entity) => store.current(entity, Keys.name) ?? t.unnamed;
  final desired = <String, EventSpec>{};
  for (final r in store.activeReminders()) {
    final def = defs[r.field];
    final fieldName = def == null ? r.field : fieldDefName(t, def);
    final day = DateTime(r.due.year, r.due.month, r.due.day);
    desired['${r.entity}|${r.field}'] = EventSpec(
      start: day,
      end: day.add(const Duration(days: 1)),
      allDay: true,
      title: '${nameOf(r.entity)} — $fieldName',
      description: '${r.value}\ncat(a)log',
    );
  }
  // A vet run is one event, keyed by its group: "Neutering — 10 cats",
  // the names in the description.
  for (final members in store.openAppointmentGroups()) {
    final a = members.first;
    final start = a.start;
    final names = members.map((m) => nameOf(m.entity)).join(', ');
    desired['appt|${a.group ?? a.id}'] = EventSpec(
      start: start,
      end: a.allDay
          ? start.add(const Duration(days: 1))
          : start.add(const Duration(hours: 1)),
      allDay: a.allDay,
      title: members.length == 1
          ? '$names — ${a.title}'
          : '${a.title} — ${t.catsCount(members.length)}',
      description: members.length == 1
          ? '${a.notes}\ncat(a)log'.trim()
          : '$names\n${a.notes}\ncat(a)log'.trim(),
      alertMinutesBefore: switch (a.alert) {
        AppointmentAlert.none => null,
        AppointmentAlert.dayBefore => 24 * 60,
        AppointmentAlert.hourBefore => 60,
      },
    );
  }
  return desired;
}

/// One-way reconcile from the app's own record: a plan's event is
/// created once, patched when the plan changes, deleted when the plan
/// retires. The calendar is never read back — an event the user edits
/// or deletes by hand stays that way until the plan changes or
/// [resyncCalendar] runs. Fields the app does not own (alerts after
/// creation, attendees) are never written.
Future<MirrorOutcome> reconcileCalendar(
  CatalogStore store,
  CalendarPort port,
  AppLocalizations t,
) async {
  if (!calendarMirrorEnabled(store)) return MirrorOutcome.off;
  if (!await port.ensureAccess()) return MirrorOutcome.noAccess;
  // Every platform call is a chance for the catalog to be switched
  // away underneath; the store is checked before each read or write.
  if (!store.isOpen) return MirrorOutcome.abandoned;
  final calendarId = chosenCalendar(store);
  if (calendarId == null) return MirrorOutcome.noCalendarChosen;
  final calendars = await port.listCalendars();
  if (!store.isOpen) return MirrorOutcome.abandoned;
  if (!calendars.any((c) => c.id == calendarId)) {
    return MirrorOutcome.calendarGone;
  }

  final desired = desiredEvents(store, t);
  final stored = _readMap(store);
  final next = <String, Map<String, String>>{};
  // Events created in this run; if the catalog closes before the record
  // is written they are deleted again — recorded nowhere, they would
  // come back as duplicates on the next run.
  final created = <String>[];

  // Retired plans lose their event; so do events written into a
  // calendar that is no longer the chosen one (the user switched) —
  // they would double otherwise.
  final known = <String, String>{};
  for (final MapEntry(:key, :value) in stored.entries) {
    final eventId = value['event'];
    if (eventId == null) continue;
    final inCalendar = value['calendar'] ?? calendarId;
    if (!desired.containsKey(key) || inCalendar != calendarId) {
      await port.deleteEvent(inCalendar, eventId);
      continue;
    }
    known[key] = eventId;
  }
  for (final MapEntry(:key, :value) in desired.entries) {
    final snapshot = value.snapshot;
    final eventId = known[key];
    if (eventId == null) {
      final eventId = await port.createEvent(calendarId, value);
      if (eventId != null) {
        created.add(eventId);
        next[key] = {
          'event': eventId,
          'calendar': calendarId,
          'snapshot': snapshot,
        };
      }
      continue;
    }
    if (stored[key]?['snapshot'] != snapshot) {
      // Date, name or note changed in the app — patch, alerts survive.
      // An event the user deleted cannot be patched: the record drops
      // it and nothing comes back on its own.
      if (!await port.updateEvent(calendarId, eventId, value)) continue;
    }
    next[key] = {
      'event': eventId,
      'calendar': calendarId,
      'snapshot': snapshot,
    };
  }

  if (!store.isOpen) {
    for (final id in created) {
      await port.deleteEvent(calendarId, id);
    }
    return MirrorOutcome.abandoned;
  }
  store.setLocalSetting(_mapKey, jsonEncode(next));
  return MirrorOutcome.ok;
}

final _running = <CatalogStore, Future<MirrorOutcome>>{};
final _queued = <CatalogStore>{};

/// [reconcileCalendar], one at a time per catalog: a request while one
/// runs queues a single re-run instead of a second run alongside —
/// two side by side both created the same event (the duplicate
/// Tuesdays).
Future<MirrorOutcome> reconcileCalendarOnce(
  CatalogStore store,
  CalendarPort port,
  AppLocalizations t,
) {
  final running = _running[store];
  if (running != null) {
    _queued.add(store);
    return running;
  }
  final run = reconcileCalendar(store, port, t).whenComplete(() {
    _running.remove(store);
  }).catchError((Object e) {
    _queued.remove(store);
    throw e;
  }).then<MirrorOutcome>((outcome) {
    if (_queued.remove(store) && store.isOpen) {
      return reconcileCalendarOnce(store, port, t);
    }
    return outcome;
  });
  _running[store] = run;
  return run;
}

/// Starts over: every event cat(a)log wrote into the chosen calendar
/// is deleted (the one time the calendar is read), the record is
/// cleared, and the plans are written fresh — the way out of
/// duplicates or a calendar edited past recognition.
Future<MirrorOutcome> resyncCalendar(
  CatalogStore store,
  CalendarPort port,
  AppLocalizations t,
) async {
  // Never beside a running reconcile: it would record ids this resync
  // is deleting. Wait for it, then start over.
  final running = _running[store];
  if (running != null) {
    try {
      await running;
    } catch (_) {
      // Its failure is its own; the resync goes ahead.
    }
  }
  if (!calendarMirrorEnabled(store)) return MirrorOutcome.off;
  if (!await port.ensureAccess()) return MirrorOutcome.noAccess;
  if (!store.isOpen) return MirrorOutcome.abandoned;
  final calendarId = chosenCalendar(store);
  if (calendarId == null) return MirrorOutcome.noCalendarChosen;
  final calendars = await port.listCalendars();
  if (!store.isOpen) return MirrorOutcome.abandoned;
  if (!calendars.any((c) => c.id == calendarId)) {
    return MirrorOutcome.calendarGone;
  }
  final gone = <String>{};
  for (final id in await port.markedEventIds(calendarId)) {
    await port.deleteEvent(calendarId, id);
    gone.add(id);
  }
  // Events recorded in another calendar (a switch that never finished)
  // go too.
  for (final value in _readMap(store).values) {
    final eventId = value['event'];
    final inCalendar = value['calendar'] ?? calendarId;
    if (eventId == null || gone.contains(eventId)) continue;
    await port.deleteEvent(inCalendar, eventId);
  }
  if (!store.isOpen) return MirrorOutcome.abandoned;
  store.setLocalSetting(_mapKey, jsonEncode(<String, Object>{}));
  return reconcileCalendarOnce(store, port, t);
}

Map<String, Map<String, String>> _readMap(CatalogStore store) {
  final raw = store.localSetting(_mapKey);
  if (raw == null) return {};
  try {
    return (jsonDecode(raw) as Map).map(
      (k, v) => MapEntry(k as String, (v as Map).cast<String, String>()),
    );
  } catch (_) {
    return {};
  }
}
