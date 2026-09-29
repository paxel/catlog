import 'package:catalog_core/catalog_core.dart';

/// A plan ticked today stays on the agenda for the day, box checked,
/// like a chore; the bin takes it off the list now. Which ones are off
/// is a matter of this device, forgotten with the day.
const doneTodayDismissedKey = 'agendaDismissed';

Set<String> _offList(CatalogStore store, DateTime today) {
  final raw = store.localSetting(doneTodayDismissedKey) ?? '';
  final bar = raw.indexOf('|');
  if (bar < 0 || raw.substring(0, bar) != dayKey(today)) return {};
  return raw.substring(bar + 1).split(',').where((k) => k.isNotEmpty).toSet();
}

/// Takes a done card off today's list on this device.
void takeOffList(CatalogStore store, String key, {DateTime? today}) {
  final day = today ?? DateTime.now();
  final keys = _offList(store, day)..add(key);
  store.setLocalSetting(
      doneTodayDismissedKey, '${dayKey(day)}|${keys.join(',')}');
}

String reminderListKey(ActiveReminder r) => 'r:${r.entity}:${r.field}';

String appointmentListKey(Appointment a) => 'a:${a.key}';

/// The plans ticked today and still on the list.
List<ActiveReminder> doneRemindersToday(CatalogStore store,
    {DateTime? today}) {
  final day = today ?? DateTime.now();
  final off = _offList(store, day);
  return [
    for (final r in store.remindersDoneToday(day))
      if (!off.contains(reminderListKey(r))) r
  ];
}

/// The appointments finished today and still on the list.
List<Appointment> doneAppointmentsToday(CatalogStore store,
    {DateTime? today}) {
  final day = today ?? DateTime.now();
  final off = _offList(store, day);
  return [
    for (final a in store.appointmentsDoneToday(day))
      if (!off.contains(appointmentListKey(a))) a
  ];
}
