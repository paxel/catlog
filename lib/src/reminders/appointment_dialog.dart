import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../field_editing.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import 'reminder_dialog.dart' show plannable;

/// Creating or editing an appointment (#75): what the keeper leaves the
/// vet's desk with — date, time if any, what, notes, an alert, and
/// optionally a field that gets a value when it is done. Returns the
/// saved appointment, null on cancel.
Future<Appointment?> showAppointmentDialog(
    BuildContext context, CatalogStore store,
    {required String entityId, Appointment? existing}) {
  return showDialog<Appointment>(
    context: context,
    builder: (context) => _AppointmentDialog(
        store: store, entityId: entityId, existing: existing),
  );
}

class _AppointmentDialog extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final Appointment? existing;

  const _AppointmentDialog(
      {required this.store, required this.entityId, this.existing});

  @override
  State<_AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<_AppointmentDialog> {
  CatalogStore get store => widget.store;

  late final _title =
      TextEditingController(text: widget.existing?.title ?? '');
  late final _notes =
      TextEditingController(text: widget.existing?.notes ?? '');
  late DateTime _date = widget.existing?.date ??
      DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)));
  late TimeOfDay? _time = widget.existing?.time == null
      ? null
      : TimeOfDay(
          hour: widget.existing!.time!.hour,
          minute: widget.existing!.time!.minute);
  late AppointmentAlert _alert =
      widget.existing?.alert ?? AppointmentAlert.dayBefore;
  FieldDef? _linked;
  FieldValueController? _linkedValue;

  @override
  void initState() {
    super.initState();
    final key = widget.existing?.linkedField;
    if (key != null) {
      final def = _defs.where((d) => d.key == key).firstOrNull;
      if (def != null) {
        _linked = def;
        _linkedValue =
            FieldValueController(def, current: widget.existing?.linkedValue);
      }
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    _linkedValue?.dispose();
    super.dispose();
  }

  FieldScope get _scope =>
      widget.entityId.startsWith('cat:') ? FieldScope.cat : FieldScope.clowder;

  List<FieldDef> get _defs => [
        for (final def in store.visibleFieldDefs(scope: _scope))
          if (plannable(def)) def
      ];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      errorFormatText: context.t
          .dateFormatError(MaterialLocalizations.of(context).dateHelpText),
    );
    if (picked != null && mounted) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null && mounted) setState(() => _time = picked);
  }

  void _pickLinked(FieldDef? def) {
    setState(() {
      _linked = def;
      _linkedValue?.dispose();
      _linkedValue = def == null ? null : FieldValueController(def);
    });
  }

  bool get _complete => _title.text.trim().isNotEmpty;

  void _save() {
    final draft = Appointment(
      id: widget.existing?.id ?? '',
      entity: widget.entityId,
      date: _date,
      time: _time == null ? null : (hour: _time!.hour, minute: _time!.minute),
      title: _title.text.trim(),
      notes: _notes.text.trim(),
      linkedField: _linked?.key,
      linkedValue: _linked == null ? null : _linkedValue?.value,
      alert: _alert,
      done: widget.existing?.done ?? false,
    );
    final saved = widget.existing == null
        ? store.createAppointment(draft)
        : (store..updateAppointment(draft), draft).$2;
    Navigator.of(context).pop(saved);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final alerts = {
      AppointmentAlert.none: t.alertNone,
      AppointmentAlert.dayBefore: t.alertDayBefore,
      AppointmentAlert.hourBefore: t.alertHourBefore,
    };
    return AlertDialog(
      title: Text(widget.existing == null
          ? t.addAppointment
          : t.editLabelAppointment),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: _title,
            autofocus: widget.existing == null,
            decoration: InputDecoration(labelText: t.appointmentTitleLabel),
            onChanged: (_) => setState(() {}),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event),
            title: Text(DateFormat.yMd(locale).format(_date)),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: _pickDate,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text(_time == null
                ? t.allDayLabel
                : MaterialLocalizations.of(context).formatTimeOfDay(_time!)),
            subtitle: Text(t.timeLabel),
            trailing: _time == null
                ? const Icon(Icons.add)
                : IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: t.allDayLabel,
                    onPressed: () => setState(() => _time = null),
                  ),
            onTap: _pickTime,
          ),
          TextField(
            controller: _notes,
            minLines: 2,
            maxLines: 6,
            decoration: InputDecoration(labelText: t.notesLabel),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<AppointmentAlert>(
            initialValue: _alert,
            decoration: InputDecoration(labelText: t.alertLabel),
            items: [
              for (final MapEntry(:key, :value) in alerts.entries)
                DropdownMenuItem(value: key, child: Text(value)),
            ],
            onChanged: (v) => setState(() => _alert = v ?? _alert),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String?>(
            initialValue: _linked?.key,
            decoration: InputDecoration(labelText: t.linkFieldLabel),
            items: [
              DropdownMenuItem<String?>(
                  value: null, child: Text(t.noLinkedField)),
              for (final def in _defs)
                DropdownMenuItem<String?>(
                    value: def.key, child: Text(fieldDefName(t, def))),
            ],
            onChanged: (key) => _pickLinked(
                key == null ? null : _defs.firstWhere((d) => d.key == key)),
          ),
          if (_linkedValue != null) ...[
            const SizedBox(height: 8),
            ListenableBuilder(
              listenable: _linkedValue!,
              builder: (context, _) => FieldValueInput(
                  controller: _linkedValue!,
                  store: store,
                  excludeId: widget.entityId),
            ),
          ],
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: _complete ? _save : null,
          child: Text(t.save),
        ),
      ],
    );
  }
}
