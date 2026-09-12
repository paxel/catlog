import 'dart:convert';

import 'package:catalog_core/catalog_core.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import 'achievements.dart';

/// The app's words for the values it stores as documents or codes:
/// a chore, a chore tick, a worn title, the privacy markers. Wherever a
/// raw value would otherwise show — history, timeline, conflicts, the
/// PDFs — these speak instead. Anything still unknown reads as
/// indented lines of key and value, never as one JSON string.

/// "every 2 weeks", "daily", "Mon, Wed, Fri".
String scheduleWords(AppLocalizations t, ChoreSchedule s) {
  switch (s.repeat) {
    case ChoreRepeat.daily:
      return t.choreRepeatDaily;
    case ChoreRepeat.everyDays:
      return switch (s.unit) {
        ChoreUnit.days => t.choreEveryDays(s.every),
        ChoreUnit.weeks => t.choreEveryWeeks(s.every),
        ChoreUnit.months => t.choreEveryMonths(s.every),
        ChoreUnit.years => t.choreEveryYears(s.every),
      };
    case ChoreRepeat.weekdays:
      final monday = DateTime(2026, 9, 7);
      final days = s.weekdays.toList()..sort();
      return [
        for (final d in days)
          DateFormat.E(t.localeName).format(monday.add(Duration(days: d - 1))),
      ].join(', ');
  }
}

String _clock(({int hour, int minute}) at) =>
    '${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}';

/// "Feed · every 2 days · 08:00 · reminder 08:00 · Paused".
String choreWords(AppLocalizations t, Chore c) => [
  c.title,
  scheduleWords(t, c.schedule),
  if (c.time case final at?) _clock(at),
  if (c.remind && c.remindAt != null) t.choreRemindAt(_clock(c.remindAt!)),
  if (c.paused) t.chorePaused,
  if (c.ended) t.choreEnded,
].join(' · ');

/// "done on 9/11/2026" for a tick's stored day.
String tickWords(AppLocalizations t, String dayValue) {
  final day = parseDay(dayValue);
  return day == null
      ? dayValue
      : t.doneOn(DateFormat.yMd(t.localeName).format(day));
}

/// "Butler (Feed)" for a `rank|chore` title value.
String titleWords(AppLocalizations t, String value) {
  final cut = value.indexOf('|');
  if (cut <= 0) return value;
  final rank = value.substring(0, cut);
  if (!titleRanks.contains(rank)) return value;
  return titleWithChore(t, rank, value.substring(cut + 1));
}

/// A JSON document as indented "key: value" lines; null when [raw] is
/// not a JSON object.
String? documentWords(String raw) {
  if (!raw.trimLeft().startsWith('{')) return null;
  Object? parsed;
  try {
    parsed = jsonDecode(raw);
  } catch (_) {
    return null;
  }
  if (parsed is! Map) return null;
  final lines = <String>[];
  void walk(Map map, int depth) {
    final pad = '  ' * depth;
    for (final entry in map.entries) {
      final v = entry.value;
      if (v is Map) {
        lines.add('$pad${entry.key}:');
        walk(v, depth + 1);
      } else if (v is List) {
        lines.add('$pad${entry.key}: ${v.join(', ')}');
      } else {
        lines.add('$pad${entry.key}: $v');
      }
    }
  }

  walk(parsed, 0);
  return lines.join('\n');
}

/// The words for [value] under [key], or null when the key is not one
/// of the documents and codes this file knows.
String? storedValueWords(AppLocalizations t, String key, String value) {
  if (key.startsWith(Keys.chorePrefix)) {
    final rest = key.substring(Keys.chorePrefix.length);
    final at = rest.indexOf('@');
    if (at > 0) return tickWords(t, value);
    final chore = Chore.fromJson(rest, '', value);
    return chore == null ? documentWords(value) : choreWords(t, chore);
  }
  if (key == Keys.personTitle) return titleWords(t, value);
  if (key == Keys.private || key.startsWith(Keys.privatePrefix)) {
    return value == 'yes' ? t.privateLabel : t.valueNo;
  }
  if (key.startsWith(Keys.withheldPrefix)) return t.withheldByPartner;
  if (key == Keys.deleted) return value == 'true' ? t.valueYes : t.valueNo;
  return null;
}
