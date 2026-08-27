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
/// optionally a field that gets a value when it is done. Several cats
/// can come along (a fosterer's neutering run): each gets its own
/// appointment, grouped so the agenda shows one card and an edit moves
/// them all. Returns the saved appointment (the first of a group), null
/// on cancel.
Future<Appointment?> showAppointmentDialog(
  BuildContext context,
  CatalogStore store, {
  required String entityId,
  Appointment? existing,
}) {
  return showDialog<Appointment>(
    context: context,
    builder: (context) => _AppointmentDialog(
      store: store,
      entityId: entityId,
      existing: existing,
    ),
  );
}

class _AppointmentDialog extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final Appointment? existing;

  const _AppointmentDialog({
    required this.store,
    required this.entityId,
    this.existing,
  });

  @override
  State<_AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<_AppointmentDialog> {
  CatalogStore get store => widget.store;

  late final _title = TextEditingController(text: widget.existing?.title ?? '');
  late final _notes = TextEditingController(text: widget.existing?.notes ?? '');
  late DateTime _date =
      widget.existing?.date ??
      DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)));
  late TimeOfDay? _time = widget.existing?.time == null
      ? null
      : TimeOfDay(
          hour: widget.existing!.time!.hour,
          minute: widget.existing!.time!.minute,
        );
  late AppointmentAlert _alert =
      widget.existing?.alert ?? AppointmentAlert.dayBefore;
  FieldDef? _linked;
  FieldValueController? _linkedValue;

  /// Cats offered as chips, in order, and which of them are ticked.
  /// From a clowder page its cats, pre-ticked; from a cat page or the
  /// agenda the one entity; when editing, the group's members.
  final _offered = <String>[];
  final _ticked = <String>{};

  /// Members of the group being edited: they cannot be unticked here —
  /// a cat leaves a run by deleting its own appointment on its page.
  final _members = <String>{};

  bool get _fromClowder => widget.entityId.startsWith('clowder:');

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      for (final m in store.groupOf(existing)) {
        _offered.add(m.entity);
        _members.add(m.entity);
      }
      _ticked.addAll(_members);
    } else if (_fromClowder) {
      for (final c in store.visibleCats(clowderId: widget.entityId)) {
        _offered.add(c.id);
      }
      _ticked.addAll(_offered);
    } else {
      _offered.add(widget.entityId);
      _ticked.add(widget.entityId);
    }
    final key = existing?.linkedField;
    if (key != null) {
      final def = _defs.where((d) => d.key == key).firstOrNull;
      if (def != null) {
        _linked = def;
        _linkedValue = FieldValueController(
          def,
          current: existing?.linkedValue,
        );
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

  /// The entities the appointment is for: the ticked cats, or — from a
  /// clowder page with none ticked — the clowder itself (a house visit).
  List<String> get _entities {
    final cats = [
      for (final id in _offered)
        if (_ticked.contains(id)) id,
    ];
    if (cats.isNotEmpty) return cats;
    return [widget.entityId];
  }

  FieldScope get _scope =>
      _entities.first.startsWith('cat:') ? FieldScope.cat : FieldScope.clowder;

  List<FieldDef> get _defs => [
    for (final def in store.visibleFieldDefs(scope: _scope))
      if (plannable(def)) def,
  ];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      errorFormatText: context.t.dateFormatError(
        MaterialLocalizations.of(context).dateHelpText,
      ),
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

  /// Offers every visible cat not yet on the list; the picked ones
  /// arrive ticked.
  Future<void> _addCats() async {
    final candidates = [
      for (final c in store.visibleCats())
        if (!_offered.contains(c.id)) c,
    ];
    final picked = await showDialog<Set<String>>(
      context: context,
      builder: (context) => _CatPicker(candidates: candidates),
    );
    if (picked == null || picked.isEmpty || !mounted) return;
    setState(() {
      // A clowder's linked-field scope may flip to cat: drop a clowder
      // field that no longer applies.
      _offered.addAll(picked);
      _ticked.addAll(picked);
      if (_linked != null && !_defs.any((d) => d.key == _linked!.key)) {
        _pickLinked(null);
      }
    });
  }

  void _toggle(String id, bool on) {
    setState(() {
      if (on) {
        _ticked.add(id);
      } else {
        _ticked.remove(id);
      }
      if (_linked != null && !_defs.any((d) => d.key == _linked!.key)) {
        _pickLinked(null);
      }
    });
  }

  bool get _complete => _title.text.trim().isNotEmpty;

  void _save() {
    final existing = widget.existing;
    final draft = Appointment(
      id: existing?.id ?? '',
      entity: existing?.entity ?? _entities.first,
      date: _date,
      time: _time == null ? null : (hour: _time!.hour, minute: _time!.minute),
      title: _title.text.trim(),
      notes: _notes.text.trim(),
      linkedField: _linked?.key,
      linkedValue: _linked == null ? null : _linkedValue?.value,
      alert: _alert,
      done: existing?.done ?? false,
      group: existing?.group,
    );
    Appointment saved;
    if (existing == null) {
      saved = store.createAppointments(draft, _entities).first;
    } else {
      store.updateAppointmentGroup(draft);
      final newcomers = [
        for (final id in _entities)
          if (!_members.contains(id)) id,
      ];
      saved = newcomers.isEmpty
          ? draft
          : store
                .groupOf(store.addToAppointmentGroup(draft, newcomers).first)
                .firstWhere((m) => m.id == draft.id, orElse: () => draft);
    }
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
    final showCats =
        _offered.any((id) => id.startsWith('cat:')) || _fromClowder;
    return AlertDialog(
      title: Text(
        widget.existing == null ? t.addAppointment : t.editLabelAppointment,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _title,
              autofocus: widget.existing == null,
              decoration: InputDecoration(labelText: t.appointmentTitleLabel),
              onChanged: (_) => setState(() {}),
            ),
            if (showCats) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.catsOnAppointment,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  for (final id in _offered)
                    if (id.startsWith('cat:'))
                      FilterChip(
                        label: Text(store.current(id, Keys.name) ?? t.unnamed),
                        selected: _ticked.contains(id),
                        // Group members stay; leaving is done on the cat.
                        onSelected: _members.contains(id)
                            ? null
                            : (on) => _toggle(id, on),
                      ),
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 18),
                    label: Text(t.addCat),
                    onPressed: _addCats,
                  ),
                ],
              ),
              if (_fromClowder && !_entities.first.startsWith('cat:'))
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    t.noCatsHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
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
              title: Text(
                _time == null
                    ? t.allDayLabel
                    : MaterialLocalizations.of(context).formatTimeOfDay(_time!),
              ),
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
              // Keyed on the scope: cat fields and clowder fields are
              // different lists, and the widget must rebuild between them.
              key: ValueKey(_scope),
              initialValue: _linked?.key,
              decoration: InputDecoration(labelText: t.linkFieldLabel),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(t.noLinkedField),
                ),
                for (final def in _defs)
                  DropdownMenuItem<String?>(
                    value: def.key,
                    child: Text(fieldDefName(t, def)),
                  ),
              ],
              onChanged: (key) => _pickLinked(
                key == null ? null : _defs.firstWhere((d) => d.key == key),
              ),
            ),
            if (_linkedValue != null) ...[
              const SizedBox(height: 8),
              ListenableBuilder(
                listenable: _linkedValue!,
                builder: (context, _) => FieldValueInput(
                  controller: _linkedValue!,
                  store: store,
                  excludeId: _entities.first,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(onPressed: _complete ? _save : null, child: Text(t.save)),
      ],
    );
  }
}

/// Ticks the cats that come along too. Returns the picked ids, null
/// on cancel.
class _CatPicker extends StatefulWidget {
  final List<EntityView> candidates;
  const _CatPicker({required this.candidates});

  @override
  State<_CatPicker> createState() => _CatPickerState();
}

class _CatPickerState extends State<_CatPicker> {
  final _picked = <String>{};

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(t.pickCatsTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final c in widget.candidates)
              CheckboxListTile(
                value: _picked.contains(c.id),
                title: Text(c.name),
                onChanged: (on) => setState(() {
                  if (on ?? false) {
                    _picked.add(c.id);
                  } else {
                    _picked.remove(c.id);
                  }
                }),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_picked),
          child: Text(t.addCat),
        ),
      ],
    );
  }
}
