import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'calendar_port.dart';

/// Whether this platform has a device calendar to mirror into.
/// Desktops fall back to the .ics export.
bool get deviceCalendarAvailable =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

/// The real calendar behind [CalendarPort], via the device_calendar
/// plugin. Only date, title and description are ever written; alarms
/// and attendees belong to the user.
class DeviceCalendarPort implements CalendarPort {
  final DeviceCalendarPlugin _plugin = DeviceCalendarPlugin();

  static bool _tzReady = false;

  DeviceCalendarPort() {
    if (!_tzReady) {
      tzdata.initializeTimeZones();
      _tzReady = true;
    }
  }

  @override
  Future<bool> ensureAccess() async {
    final has = await _plugin.hasPermissions();
    if (has.data == true) return true;
    final asked = await _plugin.requestPermissions();
    return asked.data == true;
  }

  @override
  Future<List<CalendarChoice>> listCalendars() async {
    final calendars = await _plugin.retrieveCalendars();
    if (calendars.hasErrors) {
      throw CalendarPortException(
          calendars.errors.map((e) => e.errorMessage).join('; '));
    }
    return [
      for (final c in calendars.data ?? const <Calendar>[])
        if (c.id != null)
          CalendarChoice(
              id: c.id!,
              name: c.name ?? c.id!,
              account: c.accountName,
              writable: c.isReadOnly != true),
    ];
  }

  Event _event(String calendarId, DateTime day, String title,
      String description,
      {String? eventId}) {
    final start = tz.TZDateTime(tz.local, day.year, day.month, day.day);
    return Event(
      calendarId,
      eventId: eventId,
      title: title,
      description: description,
      start: start,
      end: start.add(const Duration(days: 1)),
      allDay: true,
    );
  }

  @override
  Future<String?> createEvent(String calendarId, DateTime day,
      String title, String description) async {
    final result = await _plugin
        .createOrUpdateEvent(_event(calendarId, day, title, description));
    return result?.data;
  }

  @override
  Future<bool> updateEvent(String calendarId, String eventId, DateTime day,
      String title, String description) async {
    // createOrUpdateEvent with the event id patches in place; the
    // plugin leaves reminders/attendees untouched when they are null.
    final result = await _plugin.createOrUpdateEvent(
        _event(calendarId, day, title, description, eventId: eventId));
    return result?.data != null;
  }

  @override
  Future<void> deleteEvent(String calendarId, String eventId) async {
    await _plugin.deleteEvent(calendarId, eventId);
  }

  @override
  Future<Set<String>> existingEventIds(
      String calendarId, Iterable<String> ids) async {
    final wanted = ids.toSet();
    if (wanted.isEmpty) return {};
    final result = await _plugin.retrieveEvents(
        calendarId,
        RetrieveEventsParams(
            startDate: DateTime.now().subtract(const Duration(days: 3650)),
            endDate: DateTime.now().add(const Duration(days: 36500))));
    return {
      for (final e in result.data ?? const <Event>[])
        if (e.eventId != null && wanted.contains(e.eventId)) e.eventId!
    };
  }
}
