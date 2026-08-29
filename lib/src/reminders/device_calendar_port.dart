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

/// The instant the plugin writes for a local wall-clock moment.
///
/// `tz.local` is UTC unless someone calls `setLocalLocation`, which
/// nobody does — so building a TZDateTime from the hour and minute
/// stamped "10:00" as 10:00 UTC and the phone showed 12:00 in a German
/// summer (1.0.5). Converting by instant keeps the moment the keeper
/// typed. All-day events stay at UTC midnight of the day: Android
/// stores them so and truncates any other instant to the day before.
@visibleForTesting
tz.TZDateTime calendarMoment(DateTime d, {required bool allDay}) => allDay
    ? tz.TZDateTime.utc(d.year, d.month, d.day)
    : tz.TZDateTime.from(d, tz.UTC);

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

  Event _event(String calendarId, EventSpec spec,
      {String? eventId, bool withAlert = false}) {
    return Event(
      calendarId,
      eventId: eventId,
      title: spec.title,
      description: spec.description,
      start: calendarMoment(spec.start, allDay: spec.allDay),
      end: calendarMoment(spec.end, allDay: spec.allDay),
      allDay: spec.allDay,
      // Alerts are written on creation only (#75); an update leaves
      // whatever the user set by hand.
      reminders: withAlert && spec.alertMinutesBefore != null
          ? [Reminder(minutes: spec.alertMinutesBefore!)]
          : null,
    );
  }

  @override
  Future<String?> createEvent(String calendarId, EventSpec spec) async {
    final result = await _plugin
        .createOrUpdateEvent(_event(calendarId, spec, withAlert: true));
    return result?.data;
  }

  @override
  Future<bool> updateEvent(
      String calendarId, String eventId, EventSpec spec) async {
    final result = await _plugin
        .createOrUpdateEvent(_event(calendarId, spec, eventId: eventId));
    return result?.data != null;
  }

  @override
  Future<void> deleteEvent(String calendarId, String eventId) async {
    await _plugin.deleteEvent(calendarId, eventId);
  }

  @override
  Future<List<String>> markedEventIds(String calendarId) async {
    final result = await _plugin.retrieveEvents(
        calendarId,
        RetrieveEventsParams(
            startDate: DateTime.now().subtract(const Duration(days: 3650)),
            endDate: DateTime.now().add(const Duration(days: 36500))));
    if (result.isSuccess != true) {
      throw CalendarPortException(
          result.errors.map((e) => e.errorMessage).join('; '));
    }
    return [
      for (final e in result.data ?? const <Event>[])
        if (e.eventId != null && (e.description ?? '').contains(eventMarker))
          e.eventId!
    ];
  }
}
