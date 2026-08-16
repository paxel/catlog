import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'field_labels.dart';
import 'l10n.dart';
import 'screens/position_picker_screen.dart';

/// The outcome of editing a Field value: what to store and the effective
/// (possibly backdated) date.
class FieldEdit {
  final String? value;
  final DateTime date;
  const FieldEdit(this.value, this.date);
}

/// Type-aware editor dialog for a Field value. Returns null on cancel.
/// Every editor carries an "as of" date so entries can be backdated
/// ("spayed on 3 May", entered today).
Future<FieldEdit?> editFieldValue(
    BuildContext context, FieldDef def, String? current,
    {CatalogStore? store, String? excludeId}) {
  return showDialog<FieldEdit>(
    context: context,
    builder: (context) => _FieldEditDialog(
        def: def, current: current, store: store, excludeId: excludeId),
  );
}

class _FieldEditDialog extends StatefulWidget {
  final FieldDef def;
  final String? current;

  /// Needed for cat-reference fields (picker of existing cats).
  final CatalogStore? store;

  /// The entity being edited — a cat never references itself.
  final String? excludeId;

  const _FieldEditDialog(
      {required this.def, required this.current, this.store, this.excludeId});

  @override
  State<_FieldEditDialog> createState() => _FieldEditDialogState();
}

class _FieldEditDialogState extends State<_FieldEditDialog> {
  late final TextEditingController _text =
      TextEditingController(text: widget.current ?? '');
  String? _choice;
  DateTime _asOf = DateTime.now();

  FieldDef get def => widget.def;

  @override
  void initState() {
    super.initState();
    _choice = widget.current;
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _submit(String? value) =>
      Navigator.of(context).pop(FieldEdit(value, _asOf));

  Future<void> _pickAsOf() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _asOf,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _asOf = picked);
  }

  Widget _input() {
    switch (def.type) {
      case FieldType.yesNo:
      case FieldType.choice:
        final options =
            def.type == FieldType.yesNo ? const ['yes', 'no'] : def.options;
        return Column(mainAxisSize: MainAxisSize.min, children: [
          RadioGroup<String>(
            groupValue: _choice,
            onChanged: (v) => setState(() {
              _choice = v;
              _text.clear();
            }),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              for (final option in options)
                RadioListTile<String>(
                    title: Text(
                        fieldValueDisplay(context.t, def, option)),
                    value: option),
            ]),
          ),
          if (def.type == FieldType.choice)
            TextField(
              controller: _text,
              decoration:
                  InputDecoration(labelText: context.t.otherOption),
              onChanged: (v) => setState(() {
                if (v.trim().isNotEmpty) _choice = null;
              }),
            ),
        ]);
      case FieldType.date:
        return CalendarDatePicker(
          initialDate: DateTime.tryParse(widget.current ?? '') ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onDateChanged: (d) =>
              _choice = d.toIso8601String().substring(0, 10),
        );
      case FieldType.number:
        return TextField(
          controller: _text,
          autofocus: true,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: context.t.value),
        );
      case FieldType.location:
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.location_pin),
          title: Text(_text.text.isEmpty
              ? context.t.pickOnMap
              : _text.text),
          trailing: const Icon(Icons.map_outlined),
          onTap: () async {
            final picked = await Navigator.of(context).push<String>(
              MaterialPageRoute(
                builder: (_) => PositionPickerScreen(
                    initial:
                        _text.text.isEmpty ? null : _text.text),
              ),
            );
            if (picked != null) setState(() => _text.text = picked);
          },
        );
      case FieldType.text:
        return TextField(
          controller: _text,
          autofocus: true,
          decoration: InputDecoration(labelText: context.t.value),
        );
      case FieldType.cat:
        final store = widget.store;
        if (store == null) return const SizedBox.shrink();
        final cats = [
          for (final c in store.cats())
            if (store.resolveEntity(c.id) !=
                store.resolveEntity(widget.excludeId ?? ''))
              c
        ];
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 320),
          child: RadioGroup<String>(
            groupValue: _choice,
            onChanged: (v) => setState(() => _choice = v),
            child: ListView(shrinkWrap: true, children: [
              for (final c in cats)
                RadioListTile<String>(title: Text(c.name), value: c.id),
            ]),
          ),
        );
    }
  }

  String? _result() {
    switch (def.type) {
      case FieldType.yesNo:
      case FieldType.date:
      case FieldType.cat:
        return _choice;
      case FieldType.choice:
        final other = _text.text.trim();
        return other.isNotEmpty ? other : _choice;
      case FieldType.text:
      case FieldType.location:
      case FieldType.number:
        final v = _text.text.trim();
        return v.isEmpty ? null : v;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return AlertDialog(
      title: Text(fieldDefName(context.t, def)),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _input(),
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
            onTap: _pickAsOf,
          ),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => _submit(_result()),
          child: Text(context.t.save),
        ),
      ],
    );
  }
}
