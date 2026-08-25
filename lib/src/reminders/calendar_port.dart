/// The narrow seam between the reminder mirror and a platform
/// calendar (#74). One implementation talks to the device through the
/// device_calendar plugin; tests drive the mirror with a fake.
abstract class CalendarPort {
  /// Asks for calendar permission; false means the mirror stays off.
  Future<bool> ensureAccess();

  /// The dedicated cat(a)log calendar's id, created on first use.
  /// Null when the platform refuses.
  Future<String?> ensureCalendar();

  /// Creates one all-day event; returns its id, null on failure.
  /// Never sets alarms — the calendar shows what is due, no more.
  Future<String?> createEvent(
      String calendarId, DateTime day, String title, String description);

  /// Rewrites date, title and description of [eventId] — and nothing
  /// else, so alerts a user added by hand survive.
  Future<bool> updateEvent(String calendarId, String eventId, DateTime day,
      String title, String description);

  Future<void> deleteEvent(String calendarId, String eventId);

  /// Which of [ids] still exist — a user may delete events by hand;
  /// the mirror recreates those whose plan is still alive.
  Future<Set<String>> existingEventIds(
      String calendarId, Iterable<String> ids);
}
