/// A date known to the day, the month, or only the year (#76).
///
/// Stored as `YYYY`, `YYYY-MM` or `YYYY-MM-DD` — exactly what is known,
/// never padded to the first of a period: padding would invent a
/// precision that makes ages and orderings wrong. The three forms sort
/// correctly as plain strings.
class PartialDate implements Comparable<PartialDate> {
  final int year;
  final int? month;
  final int? day;

  const PartialDate(this.year, [this.month, this.day]);

  /// Day precision — the only form a scheduled thing (reminder,
  /// appointment) accepts.
  bool get isFull => day != null;

  /// The stored form.
  String get iso {
    final b = StringBuffer(year.toString().padLeft(4, '0'));
    if (month != null) b.write('-${month.toString().padLeft(2, '0')}');
    if (day != null) b.write('-${day.toString().padLeft(2, '0')}');
    return b.toString();
  }

  /// First instant of the period — a timestamp for what needs one.
  DateTime get earliest => DateTime(year, month ?? 1, day ?? 1);

  /// Last day of the period.
  DateTime get latest => day != null
      ? DateTime(year, month!, day!)
      : month != null
          ? DateTime(year, month! + 1, 0)
          : DateTime(year, 12, 31);

  /// The stored form parsed back; null for anything else.
  static PartialDate? parse(String? value) {
    if (value == null) return null;
    final m =
        RegExp(r'^(\d{4})(?:-(\d{2})(?:-(\d{2}))?)?$').firstMatch(value.trim());
    if (m == null) return null;
    return _checked(
      int.parse(m.group(1)!),
      m.group(2) == null ? null : int.parse(m.group(2)!),
      m.group(3) == null ? null : int.parse(m.group(3)!),
    );
  }

  /// A date as people type or posters print it: `2021`, `5/2021`,
  /// `05.2021`, `2021-05`, `14.05.2021`, `5.6.2025`, `14/05/2021`,
  /// `2021-05-14`. Day-month order is day first, as in German and most
  /// of Europe. Null for anything else or an impossible day.
  static PartialDate? parseLoose(String text) {
    final s = text.trim();
    final iso = PartialDate.parse(s);
    if (iso != null) return iso;
    final dmy = RegExp(r'^(\d{1,2})[./](\d{1,2})[./](\d{4})$').firstMatch(s);
    if (dmy != null) {
      return _checked(int.parse(dmy.group(3)!), int.parse(dmy.group(2)!),
          int.parse(dmy.group(1)!));
    }
    final my = RegExp(r'^(\d{1,2})[./](\d{4})$').firstMatch(s);
    if (my != null) {
      return _checked(int.parse(my.group(2)!), int.parse(my.group(1)!), null);
    }
    final ym = RegExp(r'^(\d{4})[./](\d{1,2})$').firstMatch(s);
    if (ym != null) {
      return _checked(int.parse(ym.group(1)!), int.parse(ym.group(2)!), null);
    }
    return null;
  }

  /// The first date found inside free text (a poster line), by the same
  /// spellings as [parseLoose]; null when there is none.
  static PartialDate? find(String text) {
    for (final re in [
      RegExp(r'(\d{1,2})[./](\d{1,2})[./](\d{4})'),
      RegExp(r'(\d{4})-(\d{2})-(\d{2})'),
      RegExp(r'(\d{1,2})[./](\d{4})'),
      RegExp(r'(\d{4})-(\d{2})'),
      RegExp(r'(?<!\d)(\d{4})(?!\d)'),
    ]) {
      final m = re.firstMatch(text);
      // The fullest spelling present decides; an impossible day is no
      // date, not a month plucked from its tail.
      if (m != null) return parseLoose(m.group(0)!);
    }
    return null;
  }

  static PartialDate? _checked(int y, int? m, int? d) {
    if (y < 1000 || y > 9999) return null;
    if (m != null && (m < 1 || m > 12)) return null;
    if (d != null) {
      if (m == null || d < 1 || d > 31) return null;
      if (DateTime(y, m, d).month != m) return null;
    }
    return PartialDate(y, m, d);
  }

  /// Full years and months elapsed at [today], as far as the precision
  /// allows: a year-only date yields months null. Null before the date.
  ({int years, int? months})? ageAt(DateTime today) {
    var years = today.year - year;
    if (month == null) {
      return years < 0 ? null : (years: years, months: null);
    }
    var months = today.month - month!;
    if (day != null && today.day < day!) months -= 1;
    if (months < 0) {
      years -= 1;
      months += 12;
    }
    return years < 0 ? null : (years: years, months: months);
  }

  @override
  int compareTo(PartialDate other) => iso.compareTo(other.iso);

  @override
  bool operator ==(Object other) => other is PartialDate && other.iso == iso;

  @override
  int get hashCode => iso.hashCode;

  @override
  String toString() => iso;
}
