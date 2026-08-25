import 'dart:convert';

import 'package:catalog_core/catalog_core.dart';

import '../field_labels.dart';
import '../../l10n/app_localizations.dart';
import 'calendar_port.dart';

/// Local setting keys — per device by nature (#74): each device
/// manages exactly its own events, so two keepers of one catalog each
/// get the events in their own calendars.
const calendarMirrorEnabledKey = 'calendarMirror';
const _mapKey = 'calendarMirror:map';

bool calendarMirrorEnabled(CatalogStore store) =>
    store.localSetting(calendarMirrorEnabledKey) == 'on';

/// One-way reconcile, the app is the source of truth: create missing
/// events, patch changed ones, delete retired ones, recreate what the
/// user deleted while the plan is alive. Fields the app does not own
/// (alerts, attendees) are never written.
Future<void> reconcileCalendar(
    CatalogStore store, CalendarPort port, AppLocalizations t) async {
  if (!calendarMirrorEnabled(store)) return;
  if (!await port.ensureAccess()) return;
  final calendarId = await port.ensureCalendar();
  if (calendarId == null) return;

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

  // Retired plans lose their event.
  for (final MapEntry(:key, :value) in stored.entries) {
    if (desired.containsKey(key)) continue;
    final eventId = value['event'];
    if (eventId != null) await port.deleteEvent(calendarId, eventId);
  }

  final known = {
    for (final MapEntry(:key, :value) in stored.entries)
      if (desired.containsKey(key) && value['event'] != null)
        key: value['event']!
  };
  final alive =
      await port.existingEventIds(calendarId, known.values);

  for (final MapEntry(:key, :value) in desired.entries) {
    final snapshot =
        '${value.day.toIso8601String()}|${value.title}|${value.desc}';
    final eventId = known[key];
    if (eventId == null || !alive.contains(eventId)) {
      // New plan — or the user deleted the event while the plan lives.
      final created = await port.createEvent(
          calendarId, value.day, value.title, value.desc);
      if (created != null) {
        next[key] = {'event': created, 'snapshot': snapshot};
      }
      continue;
    }
    if (stored[key]?['snapshot'] != snapshot) {
      // Date, name or note changed in the app — patch, alerts survive.
      await port.updateEvent(
          calendarId, eventId, value.day, value.title, value.desc);
    }
    next[key] = {'event': eventId, 'snapshot': snapshot};
  }

  store.setLocalSetting(_mapKey, jsonEncode(next));
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
