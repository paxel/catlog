import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../field_labels.dart';
import '../l10n.dart';
import 'cat_ear.dart';
import 'date_entry.dart';

/// One live plan as a card (#74): relative and absolute date, who, what;
/// done records the fact and offers the next cycle; long-press changes
/// the date or removes the plan. Shared by the agenda and the Planned
/// section of cat and clowder pages, so both behave alike.
///
/// [showEntity] is false on an entity's own page. [onChanged] fires
/// after any write — the host refreshes and runs the calendar mirror.
class ReminderCard extends StatelessWidget {
  final CatalogStore store;
  final ActiveReminder reminder;
  final bool showEntity;
  final VoidCallback onChanged;

  /// Tap on the card; null on the entity's own page.
  final VoidCallback? onOpen;

  const ReminderCard(
      {super.key,
      required this.store,
      required this.reminder,
      required this.onChanged,
      this.showEntity = true,
      this.onOpen});

  static String relativeDue(BuildContext context, DateTime due) {
    final today = DateUtils.dateOnly(DateTime.now());
    final day = DateUtils.dateOnly(due);
    final days = day.difference(today).inDays;
    if (days == 0) return context.t.dueToday;
    if (days > 0) return context.t.dueInDays(days);
    return context.t.overdueByDays(-days);
  }

  Future<void> _markDone(BuildContext context) async {
    final r = reminder;
    store.append(r.entity, r.field, r.value);
    onChanged();
    final again = await showDialog<DateTime>(
      context: context,
      builder: (context) => const _RepeatDialog(),
    );
    if (again != null) {
      store.append(r.entity, r.field, r.value, date: again, reminder: true);
      onChanged();
    }
  }

  Future<void> _changeDate(BuildContext context) async {
    final r = reminder;
    final picked = await pickDay(context, initial: r.due);
    if (picked == null) return;
    store.append(r.entity, r.field, r.value, date: picked, reminder: true);
    onChanged();
  }

  void _cancel() {
    store.append(reminder.entity, reminder.field, null, reminder: true);
    onChanged();
  }

  Future<void> _menu(BuildContext context, Offset position) async {
    final action = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
            value: 'date', child: Text(context.t.changeDateLabel)),
        PopupMenuItem(
            value: 'remove', child: Text(context.t.removeReminderLabel)),
      ],
    );
    if (!context.mounted) return;
    if (action == 'date') await _changeDate(context);
    if (action == 'remove') _cancel();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final r = reminder;
    final overdue =
        DateUtils.dateOnly(r.due).isBefore(DateUtils.dateOnly(DateTime.now()));
    final defs = {for (final def in store.fieldDefs()) def.key: def};
    final def = defs[r.field];
    final fieldName = def == null ? r.field : fieldDefName(t, def);
    final who = showEntity
        ? '${store.current(r.entity, Keys.name) ?? t.unnamed} · '
        : '';
    final dateFormat =
        DateFormat.yMd(Localizations.localeOf(context).toString());
    final color = overdue ? Theme.of(context).colorScheme.error : null;
    return Card(
      child: GestureDetector(
        onLongPressStart: (d) => _menu(context, d.globalPosition),
        onSecondaryTapDown: (d) => _menu(context, d.globalPosition),
        child: WithCatEar(
            child: ListTile(
          onTap: onOpen,
          title: Text(
              '${relativeDue(context, r.due)} · ${dateFormat.format(r.due)}',
              style:
                  TextStyle(color: color, fontWeight: FontWeight.bold)),
          subtitle: Text('$who$fieldName\n${r.value}',
              maxLines: 2, overflow: TextOverflow.ellipsis),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: t.markDone,
            onPressed: () => _markDone(context),
          ),
        )),
      ),
    );
  }
}

/// Number + unit for the next cycle; pops the computed date, or null
/// for no repeat.
class _RepeatDialog extends StatefulWidget {
  const _RepeatDialog();

  @override
  State<_RepeatDialog> createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<_RepeatDialog> {
  final _count = TextEditingController(text: '3');
  String _unit = 'months';

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }

  DateTime? _next() {
    final n = int.tryParse(_count.text.trim());
    if (n == null || n <= 0) return null;
    final now = DateTime.now();
    return switch (_unit) {
      'days' => now.add(Duration(days: n)),
      'weeks' => now.add(Duration(days: 7 * n)),
      'months' => DateTime(now.year, now.month + n, now.day),
      _ => DateTime(now.year + n, now.month, now.day),
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final units = {
      'days': t.unitDays,
      'weeks': t.unitWeeks,
      'months': t.unitMonths,
      'years': t.unitYears,
    };
    return AlertDialog(
      title: Text(t.repeatTitle),
      content: Row(children: [
        SizedBox(
          width: 64,
          child: TextField(
            controller: _count,
            autofocus: true,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButton<String>(
            value: _unit,
            isExpanded: true,
            items: [
              for (final MapEntry(:key, :value) in units.entries)
                DropdownMenuItem(value: key, child: Text(value)),
            ],
            onChanged: (v) => setState(() => _unit = v ?? _unit),
          ),
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.noRepeatLabel),
        ),
        FilledButton(
          onPressed: _next() == null
              ? null
              : () => Navigator.of(context).pop(_next()),
          child: Text(t.save),
        ),
      ],
    );
  }
}
