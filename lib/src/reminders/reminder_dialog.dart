import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../field_editing.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../widgets/date_entry.dart';

/// Starter fields that state what a cat *is* — nothing to plan there.
/// Plans belong to what happens or changes: status, neutered,
/// pregnant, remarks, contact details, and every user-defined field.
const _identityFields = {
  'gender',
  'species',
  'breed',
  'color',
  'birthdate',
  'deceased',
  'chipid',
  'mother',
  'father',
  'position',
};

/// Whether a plan can be made on [def].
bool plannable(FieldDef def) =>
    def.type != FieldType.location &&
    def.type != FieldType.cat &&
    !_identityFields.contains(def.slug);

/// The one way to make a plan (#74, 1.0.1): who (unless the page
/// already says), which field, when, and a type-aware value — plus the
/// sentence that says what a plan is. Returns true when one was added.
Future<bool> showAddReminder(BuildContext context, CatalogStore store,
    {String? entityId}) async {
  final added = await showDialog<bool>(
    context: context,
    builder: (context) => _ReminderDialog(store: store, entityId: entityId),
  );
  return added == true;
}

class _ReminderDialog extends StatefulWidget {
  final CatalogStore store;
  final String? entityId;

  const _ReminderDialog({required this.store, this.entityId});

  @override
  State<_ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  CatalogStore get store => widget.store;

  late String? _entity = widget.entityId;
  FieldDef? _def;
  FieldValueController? _value;
  final _noValue = ValueNotifier<int>(0);
  DateTime _due = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    _value?.dispose();
    _noValue.dispose();
    super.dispose();
  }

  FieldScope? get _scope {
    final e = _entity;
    if (e == null) return null;
    return e.startsWith('cat:') ? FieldScope.cat : FieldScope.clowder;
  }

  List<FieldDef> get _defs => _scope == null
      ? const []
      : [
          for (final def in store.visibleFieldDefs(scope: _scope))
            if (plannable(def)) def
        ];

  void _pickField(FieldDef? def) {
    setState(() {
      _def = def;
      _value?.dispose();
      _value = def == null ? null : FieldValueController(def);
    });
  }

  Future<void> _pickDue() async {
    final picked = await pickDay(context, initial: _due);
    if (picked != null && mounted) setState(() => _due = picked);
  }

  bool get _complete =>
      _entity != null && _def != null && (_value?.value ?? '').isNotEmpty;

  void _save() {
    store.append(_entity!, _def!.key, _value!.value, date: _due, reminder: true);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final entities = <EntityView>[
      ...store.visibleCats(),
      ...store.visibleClowders(),
    ];
    return AlertDialog(
      title: Text(t.addReminder),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(t.reminderDialogHint,
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          if (widget.entityId == null)
            DropdownButtonFormField<String>(
              initialValue: _entity,
              decoration: InputDecoration(labelText: t.reminderFor),
              items: [
                for (final e in entities)
                  DropdownMenuItem(value: e.id, child: Text(e.name)),
              ],
              onChanged: (v) {
                setState(() => _entity = v);
                _pickField(null);
              },
            ),
          DropdownButtonFormField<String>(
            initialValue: _def?.key,
            decoration: InputDecoration(labelText: t.reminderField),
            items: [
              for (final def in _defs)
                DropdownMenuItem(
                    value: def.key, child: Text(fieldDefName(t, def))),
            ],
            onChanged: (key) => _pickField(
                key == null ? null : _defs.firstWhere((d) => d.key == key)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.alarm),
            title: Text(t.dueDateLabel),
            subtitle: Text(DateFormat.yMd(
                    Localizations.localeOf(context).toString())
                .format(_due)),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: _pickDue,
          ),
          if (_value != null) ...[
            const SizedBox(height: 8),
            ListenableBuilder(
              listenable: _value!,
              builder: (context, _) => FieldValueInput(
                  controller: _value!, store: store, excludeId: _entity),
            ),
          ],
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.cancel),
        ),
        ListenableBuilder(
          listenable: _value ?? _noValue,
          builder: (context, _) => FilledButton(
            onPressed: _complete ? _save : null,
            child: Text(t.save),
          ),
        ),
      ],
    );
  }
}
