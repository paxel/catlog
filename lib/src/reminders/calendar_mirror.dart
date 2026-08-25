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
enum MirrorOutcome { ok, off, noAccess, noCalendarChosen, calendarGone }

/// One-way reconcile, the app is the source of truth: create missing
/// events, patch changed ones, delete retired ones, recreate what the
/// user deleted while the plan is alive. Fields the app does not own
/// (alerts, attendees) are never written.
Future<MirrorOutcome> reconcileCalendar(
    CatalogStore store, CalendarPort port, AppLocalizations t) async {
  if (!calendarMirrorEnabled(store)) return MirrorOutcome.off;
  if (!await port.ensureAccess()) return MirrorOutcome.noAccess;
  final calendarId = chosenCalendar(store);
  if (calendarId == null) return MirrorOutcome.noCalendarChosen;
  final calendars = await port.listCalendars();
  if (!calendars.any((c) => c.id == calendarId)) {
    return MirrorOutcome.calendarGone;
  }

  final defs = {for (final def in store.fieldDefs()) def.key: def};
  final desired = <String, ({DateTime day, String title, String desc})>{};
  for (final r in store.activeReminders()) {
    final name = store.current(r.entity, Keys.name) ?? t.unnamed;
    final def = defs[r.field];
    final fieldName = def == null ? r.field : fieldDefName(t, def);
    desired['${r.entity}|${r.field}'] = (
      day: DateTime(r.due.year, r.due.month, r.due.day),
      title: '$name — $fieldName',
      desc: '${r.value}\ncat(a)log',
    );
  }

  final stored = _readMap(store);
  final next = <String, Map<String, String>>{};

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
  final alive = await port.existingEventIds(calendarId, known.values);

  for (final MapEntry(:key, :value) in desired.entries) {
    final snapshot =
        '${value.day.toIso8601String()}|${value.title}|${value.desc}';
    final eventId = known[key];
    if (eventId == null || !alive.contains(eventId)) {
      // New plan — or the user deleted the event while the plan lives.
      final created = await port.createEvent(
          calendarId, value.day, value.title, value.desc);
      if (created != null) {
        next[key] = {
          'event': created,
          'calendar': calendarId,
          'snapshot': snapshot
        };
      }
      continue;
    }
    if (stored[key]?['snapshot'] != snapshot) {
      // Date, name or note changed in the app — patch, alerts survive.
      await port.updateEvent(
          calendarId, eventId, value.day, value.title, value.desc);
    }
    next[key] = {
      'event': eventId,
      'calendar': calendarId,
      'snapshot': snapshot
    };
  }

  store.setLocalSetting(_mapKey, jsonEncode(next));
  return MirrorOutcome.ok;
}

Map<String, Map<String, String>> _readMap(CatalogStore store) {
  final raw = store.localSetting(_mapKey);
  if (raw == null) return {};
  try {
    return (jsonDecode(raw) as Map).map((k, v) => MapEntry(
        k as String, (v as Map).cast<String, String>()));
  } catch (_) {
    return {};
  }
}
