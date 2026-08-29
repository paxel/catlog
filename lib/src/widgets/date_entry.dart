import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n.dart';

/// A date typed as text, with the calendar behind an icon for those who
/// prefer tapping (#79). Accepts the device's short format, `14.05.2021`,
/// `14/05/2021` and ISO; with [allowPartial] also `2021`, `5/2021`,
/// `05.2021` and `2021-05`, kept at that precision (#76).
///
/// [onChanged] gets the parsed date, or null while the text is empty or
/// not a date — the error text under the field says which spellings
/// work, and, for a past-only field, that the future is off.
class DateEntryField extends StatefulWidget {
  final PartialDate? initial;
  final bool allowPartial;

  /// Latest accepted day; null for no limit.
  final DateTime? lastDate;
  final String? label;
  final bool autofocus;
  final ValueChanged<PartialDate?> onChanged;

  const DateEntryField({
    super.key,
    required this.onChanged,
    this.initial,
    this.allowPartial = false,
    this.lastDate,
    this.label,
    this.autofocus = false,
  });

  @override
  State<DateEntryField> createState() => _DateEntryFieldState();
}

class _DateEntryFieldState extends State<DateEntryField> {
  late final TextEditingController _text = TextEditingController(
    text: widget.initial?.iso ?? '',
  );

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  /// The typed text as a date: the device's own short format first
  /// (month-first where the locale says so), then the common spellings.
  PartialDate? _parse(String raw, String locale) {
    final s = raw.trim();
    if (s.isEmpty) return null;
    try {
      final d = DateFormat.yMd(locale).parseStrict(s);
      return PartialDate(d.year, d.month, d.day);
    } on FormatException {
      // Not the device's format — try the spellings below.
    }
    final loose = PartialDate.parseLoose(s);
    if (loose == null) return null;
    if (!widget.allowPartial && !loose.isFull) return null;
    return loose;
  }

  bool _tooLate(PartialDate d) {
    final last = widget.lastDate;
    return last != null && d.earliest.isAfter(DateUtils.dateOnly(last));
  }

  String? _error(BuildContext context, String raw, PartialDate? parsed) {
    if (raw.trim().isEmpty) return null;
    final t = context.t;
    if (parsed == null) {
      final help = MaterialLocalizations.of(context).dateHelpText;
      final forms = widget.allowPartial
          ? '$help · 14.05.2021 · 05.2021 · 2021'
          : '$help · 14.05.2021';
      return t.dateFormatError(forms);
    }
    if (_tooLate(parsed)) return t.dateInFuture;
    return null;
  }

  void _changed(String raw) {
    final parsed = _parse(raw, Localizations.localeOf(context).toString());
    widget.onChanged(parsed == null || _tooLate(parsed) ? null : parsed);
    setState(() {});
  }

  Future<void> _openCalendar() async {
    final last = widget.lastDate ?? DateTime(2100);
    var initial =
        _parse(
          _text.text,
          Localizations.localeOf(context).toString(),
        )?.earliest ??
        DateUtils.dateOnly(DateTime.now());
    if (initial.isAfter(last)) initial = last;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1990),
      lastDate: last,
      errorFormatText: context.t.dateFormatError(
        MaterialLocalizations.of(context).dateHelpText,
      ),
    );
    if (picked == null || !mounted) return;
    _text.text = PartialDate(picked.year, picked.month, picked.day).iso;
    _changed(_text.text);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final parsed = _parse(_text.text, locale);
    return TextField(
      controller: _text,
      autofocus: widget.autofocus,
      keyboardType: TextInputType.datetime,
      onChanged: _changed,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.allowPartial ? '2021-05-14 · 2021-05 · 2021' : null,
        errorText: _error(context, _text.text, parsed),
        errorMaxLines: 3,
        suffixIcon: IconButton(
          icon: const Icon(Icons.edit_calendar_outlined),
          tooltip: MaterialLocalizations.of(context).datePickerHelpText,
          onPressed: _openCalendar,
        ),
      ),
    );
  }
}

/// Asks for one full day in a compact dialog — the typed field with the
/// calendar behind its icon. Null when cancelled. Replaces the month
/// grid everywhere a plan, a fact or a poster needs a day.
Future<DateTime?> pickDay(
  BuildContext context, {
  required DateTime initial,
  DateTime? lastDate,
  String? title,
}) {
  return showDialog<DateTime>(
    context: context,
    builder: (context) => _DayDialog(
      initial: DateUtils.dateOnly(initial),
      lastDate: lastDate,
      title: title,
    ),
  );
}

class _DayDialog extends StatefulWidget {
  final DateTime initial;
  final DateTime? lastDate;
  final String? title;

  const _DayDialog({required this.initial, this.lastDate, this.title});

  @override
  State<_DayDialog> createState() => _DayDialogState();
}

class _DayDialogState extends State<_DayDialog> {
  late PartialDate? _picked = PartialDate(
    widget.initial.year,
    widget.initial.month,
    widget.initial.day,
  );

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final picked = _picked;
    return AlertDialog(
      title: widget.title == null ? null : Text(widget.title!),
      content: DateEntryField(
        initial: _picked,
        lastDate: widget.lastDate,
        autofocus: true,
        onChanged: (d) => setState(() => _picked = d),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: picked == null
              ? null
              : () => Navigator.of(context).pop(picked.earliest),
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    );
  }
}
