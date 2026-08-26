/// The narrow seam between the reminder mirror and a platform
/// calendar (#74). One implementation talks to the device through the
/// device_calendar plugin; tests drive the mirror with a fake.
abstract class CalendarPort {
  /// Asks for calendar permission; false means the mirror stays off.
  Future<bool> ensureAccess();

  /// Every calendar the device reports — the user picks one. Read-only
  /// ones are flagged, not dropped: the plugin's flag is unreliable on
  /// Android and dropping by it left users with "no calendar" while
  /// their Google calendar sat right there. Never creates a calendar:
  /// a locally created one is invisible to the phone's account and
  /// syncs nowhere (1.0.1). Throws [CalendarPortException] when the
  /// platform answers with an error instead of a list.
  Future<List<CalendarChoice>> listCalendars();

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

/// One calendar on the device.
class CalendarChoice {
  final String id;
  final String name;

  /// The account it belongs to (e.g. a Google address), or null for a
  /// local calendar.
  final String? account;

  /// False when the platform reports it read-only.
  final bool writable;

  const CalendarChoice(
      {required this.id,
      required this.name,
      this.account,
      this.writable = true});
}

/// The platform refused to list or touch calendars; [message] is its
/// own wording, shown to the user as is.
class CalendarPortException implements Exception {
  final String message;
  const CalendarPortException(this.message);
  @override
  String toString() => message;
}
