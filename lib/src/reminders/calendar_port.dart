/// The narrow seam between the mirror and a platform calendar (#74,
/// #75). One implementation talks to the device through the
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

  /// Creates one event; returns its id, null on failure. The alert in
  /// [spec] is written here and only here.
  Future<String?> createEvent(String calendarId, EventSpec spec);

  /// Rewrites time, title and description of [eventId] — never the
  /// alerts, so what the user set by hand survives.
  Future<bool> updateEvent(String calendarId, String eventId, EventSpec spec);

  Future<void> deleteEvent(String calendarId, String eventId);

  /// Which of [ids] still exist — a user may delete events by hand;
  /// the mirror recreates those whose plan is still alive.
  Future<Set<String>> existingEventIds(
      String calendarId, Iterable<String> ids);
}

/// What one mirrored event looks like.
class EventSpec {
  /// Start moment (local). For [allDay] only the day matters.
  final DateTime start;

  /// End moment; the next day for all-day events, one hour later for
  /// timed ones.
  final DateTime end;
  final bool allDay;
  final String title;
  final String description;

  /// Minutes before [start] for the alert; null = no alert.
  final int? alertMinutesBefore;

  const EventSpec({
    required this.start,
    required this.end,
    required this.allDay,
    required this.title,
    required this.description,
    this.alertMinutesBefore,
  });

  /// What the mirror compares to know whether an event needs a patch.
  String get snapshot =>
      '${start.toIso8601String()}|${end.toIso8601String()}|$allDay|$title|$description';
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
