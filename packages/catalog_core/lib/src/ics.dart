/// iCalendar export of active plans: the non-syncing fallback for
/// platforms without calendar integration. Reminders (#74) are all-day
/// VEVENTs without alarm — the calendar shows that something is due;
/// appointments (#75) are timed, with the VALARM the keeper chose.
library;

/// One event for [writeIcs] — already localized and resolved; the
/// core knows entries, not display names.
class IcsEvent {
  /// Stable identity, so re-importing an updated export replaces
  /// events instead of doubling them.
  final String uid;

  /// The due date, rendered as an all-day event — unless [end] is
  /// given, then [date] is the exact local start of a timed event.
  final DateTime date;

  /// Local end of a timed event; null for all-day.
  final DateTime? end;

  final String summary;
  final String description;

  /// A VALARM this many minutes before the start; null for none.
  final int? alertMinutesBefore;

  const IcsEvent(
      {required this.uid,
      required this.date,
      this.end,
      required this.summary,
      required this.description,
      this.alertMinutesBefore});

  bool get allDay => end == null;
}

/// Serializes [events] as an iCalendar file (RFC 5545).
String writeIcs(List<IcsEvent> events, {required DateTime stamp}) {
  final b = StringBuffer()
    ..write('BEGIN:VCALENDAR\r\n')
    ..write('VERSION:2.0\r\n')
    ..write('PRODID:-//cat(a)log//reminders//EN\r\n');
  final dtstamp = _utcStamp(stamp);
  for (final e in events) {
    b
      ..write('BEGIN:VEVENT\r\n')
      ..write(_fold('UID:${_escape(e.uid)}\r\n'))
      ..write('DTSTAMP:$dtstamp\r\n');
    if (e.end case final end?) {
      // Floating local time: the keeper reads it where the visit is.
      b
        ..write('DTSTART:${_local(e.date)}\r\n')
        ..write('DTEND:${_local(end)}\r\n');
    } else {
      final day = e.date;
      final next = day.add(const Duration(days: 1));
      b
        ..write('DTSTART;VALUE=DATE:${_day(day)}\r\n')
        ..write('DTEND;VALUE=DATE:${_day(next)}\r\n');
    }
    b
      ..write(_fold('SUMMARY:${_escape(e.summary)}\r\n'))
      ..write(_fold('DESCRIPTION:${_escape(e.description)}\r\n'));
    if (e.alertMinutesBefore case final minutes?) {
      b
        ..write('BEGIN:VALARM\r\n')
        ..write('ACTION:DISPLAY\r\n')
        ..write(_fold('DESCRIPTION:${_escape(e.summary)}\r\n'))
        ..write('TRIGGER:-PT${minutes}M\r\n')
        ..write('END:VALARM\r\n');
    }
    b.write('END:VEVENT\r\n');
  }
  b.write('END:VCALENDAR\r\n');
  return b.toString();
}

String _day(DateTime d) => '${d.year.toString().padLeft(4, '0')}'
    '${d.month.toString().padLeft(2, '0')}'
    '${d.day.toString().padLeft(2, '0')}';

String _local(DateTime d) => '${_day(d)}T'
    '${d.hour.toString().padLeft(2, '0')}'
    '${d.minute.toString().padLeft(2, '0')}'
    '${d.second.toString().padLeft(2, '0')}';

String _utcStamp(DateTime d) {
  final u = d.toUtc();
  return '${_day(u)}T'
      '${u.hour.toString().padLeft(2, '0')}'
      '${u.minute.toString().padLeft(2, '0')}'
      '${u.second.toString().padLeft(2, '0')}Z';
}

/// TEXT escaping per RFC 5545 §3.3.11.
String _escape(String s) => s
    .replaceAll('\\', '\\\\')
    .replaceAll(';', '\\;')
    .replaceAll(',', '\\,')
    .replaceAll('\r\n', '\\n')
    .replaceAll('\n', '\\n');

/// Content lines longer than 75 octets are folded (RFC 5545 §3.1),
/// splitting only between code points so no UTF-8 sequence is cut.
String _fold(String line) {
  const max = 73; // room for the trailing CRLF within 75
  final body = line.substring(0, line.length - 2);
  final b = StringBuffer();
  var octets = 0;
  var first = true;
  final piece = StringBuffer();
  for (final rune in body.runes) {
    final len = _utf8Len(rune);
    final budget = first ? max : max - 1; // continuation costs a space
    if (octets + len > budget) {
      if (!first) b.write(' ');
      b
        ..write(piece)
        ..write('\r\n');
      piece.clear();
      octets = 0;
      first = false;
    }
    piece.writeCharCode(rune);
    octets += len;
  }
  if (piece.isNotEmpty || first) {
    if (!first) b.write(' ');
    b
      ..write(piece)
      ..write('\r\n');
  }
  return b.toString();
}

int _utf8Len(int rune) => rune < 0x80
    ? 1
    : rune < 0x800
        ? 2
        : rune < 0x10000
            ? 3
            : 4;
