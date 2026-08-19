import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n.dart';

class NameAndDate {
  final String name;
  final DateTime date;
  const NameAndDate(this.name, this.date);
}

/// Name plus an "as of" date — so a clowder that has existed for ten
/// years, or a cat that moved in long ago, carries its real date from
/// the start instead of today's.
Future<NameAndDate?> askNameAndDate(BuildContext context, String title,
    {Future<String?> Function()? propose}) {
  return showDialog<NameAndDate>(
    context: context,
    builder: (context) => _NameDateDialog(title: title, propose: propose),
  );
}

class _NameDateDialog extends StatefulWidget {
  final String title;

  /// When set, prefills the name with a proposal; the dice rerolls.
  final Future<String?> Function()? propose;

  const _NameDateDialog({required this.title, this.propose});

  @override
  State<_NameDateDialog> createState() => _NameDateDialogState();
}

class _NameDateDialogState extends State<_NameDateDialog> {
  final _name = TextEditingController();
  DateTime _asOf = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.propose != null) _reroll();
  }

  Future<void> _reroll() async {
    final name = await widget.propose!();
    if (name == null || !mounted) return;
    _name.text = name;
    // Selected, so typing replaces the proposal without extra taps.
    _name.selection =
        TextSelection(baseOffset: 0, extentOffset: name.length);
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(NameAndDate(name, _asOf));
  }

  @override
  Widget build(BuildContext context) {
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return AlertDialog(
      title: Text(widget.title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: _name,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.t.name,
            suffixIcon: widget.propose == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.casino_outlined),
                    tooltip: context.t.proposeAnotherName,
                    onPressed: _reroll,
                  ),
          ),
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 8),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event),
          title: Text(sameDay
              ? context.t.asOfToday
              : context.t.asOfDate(DateFormat.yMd(
                      Localizations.localeOf(context).toString())
                  .format(_asOf))),
          trailing: const Icon(Icons.edit_calendar_outlined),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _asOf,
              firstDate: DateTime(1990),
              lastDate: DateTime.now().add(const Duration(days: 1)),
              // The picker falls back to a text field (e.g. with screen
              // readers); the stock error doesn't say which format is
              // expected.
              errorFormatText: context.t.dateFormatError(
                  MaterialLocalizations.of(context).dateHelpText),
            );
            if (!mounted) return;
            if (picked != null) setState(() => _asOf = picked);
          },
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(context.t.create)),
      ],
    );
  }
}

/// Just the "as of" date, defaulting to today — used when moving a cat,
/// so historic moves land on their real date.
Future<DateTime?> askAsOfDate(BuildContext context, String title) {
  return showDialog<DateTime>(
    context: context,
    builder: (context) => _AsOfDialog(title: title),
  );
}

class _AsOfDialog extends StatefulWidget {
  final String title;
  const _AsOfDialog({required this.title});

  @override
  State<_AsOfDialog> createState() => _AsOfDialogState();
}

class _AsOfDialogState extends State<_AsOfDialog> {
  DateTime _asOf = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return AlertDialog(
      title: Text(widget.title),
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.event),
        title: Text(sameDay
            ? context.t.asOfToday
            : context.t.asOfDate(DateFormat.yMd(
                    Localizations.localeOf(context).toString())
                .format(_asOf))),
        trailing: const Icon(Icons.edit_calendar_outlined),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: _asOf,
            firstDate: DateTime(1990),
            lastDate: DateTime.now().add(const Duration(days: 1)),
            errorFormatText: context.t.dateFormatError(
                MaterialLocalizations.of(context).dateHelpText),
          );
          if (!mounted) return;
          if (picked != null) setState(() => _asOf = picked);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_asOf),
          child: Text(context.t.save),
        ),
      ],
    );
  }
}
