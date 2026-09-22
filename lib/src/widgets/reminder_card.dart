import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../celebration.dart';
import '../field_labels.dart';
import '../l10n.dart';
import '../reminders/done_today.dart';
import 'cat_ear.dart';
import 'date_entry.dart';

/// One live plan as a card (#74), the shape every row of the agenda
/// has: the box on the left ticks it done, tap opens whose it is,
/// long-press changes the date, the bin on the right removes it.
/// Ticked today it stays for the day, box checked and faded, like a
/// chore: tap offers the next cycle, the box unticks, the bin takes it
/// off the list. Shared by the agenda and the Planned section of cat
/// and clowder pages, so both behave alike.
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

  /// The tick records the fact; a paw, nothing to answer.
  void _markDone(BuildContext context) {
    final r = reminder;
    store.append(r.entity, r.field, r.value);
    paw(context);
    onChanged();
  }

  /// The box unticked again: the fact goes, the plan is live again.
  void _undo() {
    store.removeEntry(reminder.doneBy!.seq);
    onChanged();
  }

  /// A tap on the done card: the same plan again, in a while.
  Future<void> _repeat(BuildContext context) async {
    final r = reminder;
    final again = await showDialog<DateTime>(
      context: context,
      builder: (context) => const _RepeatDialog(),
    );
    if (again == null) return;
    store.append(r.entity, r.field, r.value, date: again, reminder: true);
    onChanged();
  }

  void _takeOff() {
    takeOffList(store, reminderListKey(reminder));
    onChanged();
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
    if (r.doneBy case final fact?) {
      final faded = Theme.of(context).disabledColor;
      return Card(
        child: ListTile(
          onTap: () => _repeat(context),
          leading: Tooltip(
            message: t.markDone,
            child: Checkbox(value: true, onChanged: (_) => _undo()),
          ),
          title: Text(
            '${t.doneLabel} · ${dateFormat.format(fact.date.toLocal())}',
            style: TextStyle(
                color: faded, decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text('$who$fieldName\n${r.value}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: faded)),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: t.takeOffList,
            onPressed: _takeOff,
          ),
        ),
      );
    }
    return Card(
      child: WithCatEar(
        child: ListTile(
          onTap: onOpen,
          onLongPress: () => _changeDate(context),
          leading: Tooltip(
            message: t.markDone,
            child: Checkbox(
              value: false,
              onChanged: (_) => _markDone(context),
            ),
          ),
          title: Text(
              '${relativeDue(context, r.due)} · ${dateFormat.format(r.due)}',
              style:
                  TextStyle(color: color, fontWeight: FontWeight.bold)),
          subtitle: Text('$who$fieldName\n${r.value}',
              maxLines: 2, overflow: TextOverflow.ellipsis),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: t.removeReminderLabel,
            onPressed: _cancel,
          ),
        ),
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
