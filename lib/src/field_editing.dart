import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'field_labels.dart';
import 'l10n.dart';
import 'screens/position_picker_screen.dart';
import 'screens/scan_screen.dart';
import 'widgets/date_entry.dart';
import 'units.dart';

/// The outcome of editing a Field value: what to store and the effective
/// (possibly backdated) date.
class FieldEdit {
  final String? value;
  final DateTime date;

  /// The Privat checkmark: this value stays in the local catalog.
  final bool private;
  const FieldEdit(this.value, this.date, {this.private = false});
}

/// Type-aware editor dialog for a Field value. Returns null on cancel.
/// Every editor carries an "as of" date so entries can be backdated
/// ("spayed on 3 May", entered today).
Future<FieldEdit?> editFieldValue(
  BuildContext context,
  FieldDef def,
  String? current, {
  CatalogStore? store,
  String? excludeId,
}) {
  return showDialog<FieldEdit>(
    context: context,
    builder: (context) => _FieldEditDialog(
      def: def,
      current: current,
      store: store,
      excludeId: excludeId,
    ),
  );
}

/// A stored value as the editor shows it: a Unit Value in the device's
/// entry unit, everything else as stored.
String _entryText(FieldDef def, String? current) {
  if (def.type != FieldType.unitValue || current == null) return current ?? '';
  final base = double.tryParse(current);
  if (base == null) return current;
  final shown =
      fromBase(def.dimension ?? Dimension.weight, unitSystem.value, base);
  final rounded = (shown * 100).round() / 100;
  return rounded == rounded.roundToDouble()
      ? rounded.round().toString()
      : rounded.toString();
}

/// The state behind a [FieldValueInput]: what the user picked or typed,
/// resolved per field type into the value to store. Shared by the field
/// editor and the reminder dialog, so a plan's value is as well-formed
/// as a fact's.
class FieldValueController extends ChangeNotifier {
  final FieldDef def;
  final TextEditingController text;
  String? _choice;

  FieldValueController(this.def, {String? current})
    : text = TextEditingController(text: _entryText(def, current)),
      _choice = current {
    // For choice fields the text controller holds only off-list values;
    // a current value that IS an option belongs to the radios alone.
    if (def.type == FieldType.choice && def.options.contains(current)) {
      text.clear();
    }
    text.addListener(notifyListeners);
  }

  String? get choice => _choice;
  set choice(String? v) {
    _choice = v;
    notifyListeners();
  }

  /// The value to store, or null for "cleared".
  String? get value {
    switch (def.type) {
      case FieldType.choice:
        // Choice values are suggestions, not a closed list — a freely
        // typed value wins over the radio selection.
        final free = text.text.trim();
        return free.isNotEmpty ? free : _choice;
      case FieldType.yesNo:
      case FieldType.date:
      case FieldType.cat:
        return _choice;
      case FieldType.text:
      case FieldType.location:
      case FieldType.number:
      case FieldType.id:
        final v = text.text.trim();
        return v.isEmpty ? null : v;
      case FieldType.unitValue:
        // Typed in the device's unit, stored in the base unit (#96).
        final entered = parseEntry(text.text);
        if (entered == null) return null;
        return baseString(toBase(
            def.dimension ?? Dimension.weight, unitSystem.value, entered));
    }
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }
}

/// The type-aware input for one Field value: radios for choices, a
/// calendar for dates, a map picker for locations, a scanner for IDs.
class FieldValueInput extends StatefulWidget {
  final FieldValueController controller;

  /// Needed for cat-reference fields (picker of existing cats).
  final CatalogStore? store;

  /// The entity being edited — a cat never references itself.
  final String? excludeId;

  /// Typed inputs grab the focus — right in a dialog, wrong on a page
  /// that lists several of them.
  final bool autofocus;

  const FieldValueInput({
    super.key,
    required this.controller,
    this.store,
    this.excludeId,
    this.autofocus = true,
  });

  @override
  State<FieldValueInput> createState() => _FieldValueInputState();
}

class _FieldValueInputState extends State<FieldValueInput> {
  FieldValueController get c => widget.controller;
  FieldDef get def => c.def;

  @override
  Widget build(BuildContext context) {
    switch (def.type) {
      case FieldType.yesNo:
      case FieldType.choice:
        // Breed follows the animal's species (#95): a dog is offered
        // dog breeds, the cat list stays the field's own.
        final species = def.slug == 'breed' && widget.excludeId != null
            ? widget.store?.current(widget.excludeId!, 'f:species')
            : null;
        final options = def.type == FieldType.yesNo
            ? const ['yes', 'no']
            : def.slug == 'breed'
                ? breedOptions(def, species)
                : def.options;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioGroup<String>(
              groupValue: c.choice,
              onChanged: (v) => setState(() {
                c.choice = v;
                c.text.clear();
              }),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final option in options)
                    RadioListTile<String>(
                      title: Text(fieldValueDisplay(context.t, def, option)),
                      value: option,
                    ),
                ],
              ),
            ),
            if (def.type == FieldType.choice)
              TextField(
                controller: c.text,
                decoration: InputDecoration(labelText: context.t.ownValue),
                onChanged: (v) => setState(() {
                  if (v.trim().isNotEmpty) c.choice = null;
                }),
              ),
          ],
        );
      case FieldType.date:
        // Birth and death dates can't lie in the future; other date
        // fields legitimately can (appointments, due dates).
        final pastOnly = def.slug == 'birthdate' || def.slug == 'deceased';
        final last = pastOnly ? DateUtils.dateOnly(DateTime.now()) : null;
        // Typed, at the precision known — a year alone is a value (#76);
        // the calendar sits behind the icon (#79).
        return DateEntryField(
          initial: PartialDate.parse(c.choice),
          allowPartial: true,
          lastDate: last,
          label: context.t.value,
          autofocus: widget.autofocus,
          onChanged: (d) => c.choice = d?.iso,
        );
      case FieldType.number:
        return TextField(
          controller: c.text,
          autofocus: widget.autofocus,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: context.t.value),
        );
      case FieldType.unitValue:
        return TextField(
          controller: c.text,
          autofocus: widget.autofocus,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: context.t.value,
            suffixText: entryUnit(
                def.dimension ?? Dimension.weight, unitSystem.value),
          ),
        );
      case FieldType.location:
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.location_pin),
          title: Text(c.text.text.isEmpty ? context.t.pickOnMap : c.text.text),
          trailing: const Icon(Icons.map_outlined),
          onTap: () async {
            final picked = await Navigator.of(context).push<String>(
              MaterialPageRoute(
                builder: (_) => PositionPickerScreen(
                  initial: c.text.text.isEmpty ? null : c.text.text,
                ),
              ),
            );
            if (!mounted) return;
            if (picked != null) setState(() => c.text.text = picked);
          },
        );
      case FieldType.text:
        // Remarks holds whole notes (OCR dumps included) — multiline.
        final multiline = def.slug == 'remarks';
        return TextField(
          controller: c.text,
          autofocus: widget.autofocus,
          minLines: multiline ? 3 : 1,
          maxLines: multiline ? 8 : 1,
          decoration: InputDecoration(labelText: context.t.value),
        );
      case FieldType.id:
        // Typed or scanned — QR and 1D barcodes both land here (#28).
        // "Scan" means the PRINTED code: a tester pointed the camera at
        // the cat, expecting to read the implanted transponder.
        return TextField(
          controller: c.text,
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            labelText: context.t.value,
            helperText: def.slug == 'chipid' ? context.t.chipScanHint : null,
            helperMaxLines: 3,
            suffixIcon: IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: context.t.scanPrintedCode,
              onPressed: () async {
                final value = await Navigator.of(context).push<String>(
                  MaterialPageRoute(builder: (_) => const ScanScreen()),
                );
                if (value != null && value.isNotEmpty) {
                  setState(() => c.text.text = value);
                }
              },
            ),
          ),
        );
      case FieldType.cat:
        final store = widget.store;
        if (store == null) return const SizedBox.shrink();
        final cats = [
          for (final cat in store.cats())
            if (store.resolveEntity(cat.id) !=
                store.resolveEntity(widget.excludeId ?? ''))
              cat,
        ];
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 320),
          child: RadioGroup<String>(
            groupValue: c.choice,
            onChanged: (v) => setState(() => c.choice = v),
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final cat in cats)
                  RadioListTile<String>(title: Text(cat.name), value: cat.id),
              ],
            ),
          ),
        );
    }
  }
}

class _FieldEditDialog extends StatefulWidget {
  final FieldDef def;
  final String? current;
  final CatalogStore? store;
  final String? excludeId;

  const _FieldEditDialog({
    required this.def,
    required this.current,
    this.store,
    this.excludeId,
  });

  @override
  State<_FieldEditDialog> createState() => _FieldEditDialogState();
}

class _FieldEditDialogState extends State<_FieldEditDialog> {
  late final FieldValueController _value = FieldValueController(
    widget.def,
    current: widget.current,
  );
  DateTime _asOf = DateTime.now();
  late bool _private =
      widget.store != null &&
      widget.excludeId != null &&
      widget.store!.isFieldPrivate(widget.excludeId!, widget.def.key);

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  Future<void> _pickAsOf() async {
    // "As of" is when something happened — never the future. Plans
    // are made in the reminder dialog; a forward-dated fact would
    // win the latest-wins ordering and pose as the current value.
    final picked = await pickDay(
      context,
      initial: _asOf,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (!mounted) return;
    if (picked != null) setState(() => _asOf = picked);
  }

  @override
  Widget build(BuildContext context) {
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return AlertDialog(
      title: Text(fieldDefName(context.t, widget.def)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FieldValueInput(
              controller: _value,
              store: widget.store,
              excludeId: widget.excludeId,
            ),
            const SizedBox(height: 8),
            if (widget.store != null && widget.excludeId != null)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _private,
                onChanged: (v) => setState(() => _private = v ?? false),
                title: Text(context.t.privateLabel),
                secondary: const Icon(Icons.lock_outline),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: Text(
                sameDay
                    ? context.t.asOfToday
                    : context.t.asOfDate(
                        DateFormat.yMd(
                          Localizations.localeOf(context).toString(),
                        ).format(_asOf),
                      ),
              ),
              trailing: const Icon(Icons.edit_calendar_outlined),
              onTap: _pickAsOf,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(context)
                  .pop(FieldEdit(_value.value, _asOf, private: _private)),
          child: Text(context.t.save),
        ),
      ],
    );
  }
}
