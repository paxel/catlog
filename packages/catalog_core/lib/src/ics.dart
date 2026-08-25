/// iCalendar export of active reminders (#74): the non-syncing
/// fallback for platforms without calendar integration. One all-day
/// VEVENT per plan, no alarms — the calendar shows that something is
/// due; booking the appointment stays the keeper's move.
library;

/// One event for [writeIcs] — already localized and resolved; the
/// core knows entries, not display names.
class IcsEvent {
  /// Stable identity, so re-importing an updated export replaces
  /// events instead of doubling them.
  final String uid;

  /// The due date; rendered as an all-day event.
  final DateTime date;

  final String summary;
  final String description;

  const IcsEvent(
      {required this.uid,
      required this.date,
      required this.summary,
      required this.description});
}

/// Serializes [events] as an iCalendar file (RFC 5545).
String writeIcs(List<IcsEvent> events, {required DateTime stamp}) {
  final b = StringBuffer()
    ..write('BEGIN:VCALENDAR\r\n')
    ..write('VERSION:2.0\r\n')
    ..write('PRODID:-//cat(a)log//reminders//EN\r\n');
  final dtstamp = _utcStamp(stamp);
  for (final e in events) {
    final day = e.date;
    final next = day.add(const Duration(days: 1));
    b
      ..write('BEGIN:VEVENT\r\n')
      ..write(_fold('UID:${_escape(e.uid)}\r\n'))
      ..write('DTSTAMP:$dtstamp\r\n')
      ..write('DTSTART;VALUE=DATE:${_day(day)}\r\n')
      ..write('DTEND;VALUE=DATE:${_day(next)}\r\n')
      ..write(_fold('SUMMARY:${_escape(e.summary)}\r\n'))
      ..write(_fold('DESCRIPTION:${_escape(e.description)}\r\n'))
      ..write('END:VEVENT\r\n');
  }
  b.write('END:VCALENDAR\r\n');
  return b.toString();
}

String _day(DateTime d) => '${d.year.toString().padLeft(4, '0')}'
    '${d.month.toString().padLeft(2, '0')}'
    '${d.day.toString().padLeft(2, '0')}';

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
