import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n.dart';
import '../reminders/appointment_dialog.dart';
import 'cat_ear.dart';
import 'reminder_card.dart' show ReminderCard;

/// One appointment as a card (#75): when, who, what, notes. The check
/// finishes it — the outcome notes are asked for first; long-press
/// edits or deletes. Shared by the agenda and the Planned section.
///
/// A vet run with several cats is one card: [members] are the group's
/// appointments, shown as name chips; finishing asks which cats were
/// treated, editing moves them all.
class AppointmentCard extends StatelessWidget {
  final CatalogStore store;
  final Appointment appointment;

  /// The group's open appointments, [appointment] among them. Defaults
  /// to the appointment alone.
  final List<Appointment>? members;
  final bool showEntity;

  /// True where the card stands for the whole run (the agenda): delete
  /// takes every member. On an entity's own page it takes only that
  /// entity's appointment — the cat leaves the run, the run stays.
  final bool wholeGroup;
  final VoidCallback onChanged;
  final VoidCallback? onOpen;

  /// Tapping a name chip opens that cat.
  final void Function(String entityId)? onOpenEntity;

  const AppointmentCard({
    super.key,
    required this.store,
    required this.appointment,
    required this.onChanged,
    this.members,
    this.showEntity = true,
    this.wholeGroup = false,
    this.onOpen,
    this.onOpenEntity,
  });

  List<Appointment> get _members => members ?? [appointment];

  String _nameOf(BuildContext context, String entity) =>
      store.current(entity, Keys.name) ?? context.t.unnamed;

  Future<void> _finish(BuildContext context) async {
    final members = _members;
    if (members.length == 1) {
      final outcome = await showDialog<String>(
        context: context,
        builder: (context) => _OutcomeDialog(initial: appointment.notes),
      );
      if (outcome == null) return;
      store.finishAppointment(appointment, notes: outcome);
    } else {
      final outcome = await showDialog<_GroupOutcome>(
        context: context,
        builder: (context) => _GroupOutcomeDialog(
          initial: appointment.notes,
          members: [for (final m in members) (m, _nameOf(context, m.entity))],
        ),
      );
      if (outcome == null) return;
      store.finishAppointments(
        members.where((m) => outcome.treated.contains(m.id)),
        notes: outcome.notes,
      );
    }
    onChanged();
  }

  Future<void> _menu(BuildContext context, Offset position) async {
    final t = context.t;
    final count = _members.length;
    final action = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem(value: 'edit', child: Text(t.editLabelAppointment)),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            wholeGroup && count > 1
                ? t.deleteAppointmentGroup(count)
                : t.deleteAppointment,
          ),
        ),
      ],
    );
    if (!context.mounted) return;
    if (action == 'edit') {
      final saved = await showAppointmentDialog(
        context,
        store,
        entityId: appointment.entity,
        existing: appointment,
      );
      if (saved != null) onChanged();
    }
    if (action == 'delete') {
      if (wholeGroup && count > 1) {
        store.deleteAppointmentGroup(appointment);
      } else {
        store.deleteAppointment(appointment);
      }
      onChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final a = appointment;
    final members = _members;
    final now = DateTime.now();
    final overdue = a.allDay
        ? DateUtils.dateOnly(a.date).isBefore(DateUtils.dateOnly(now))
        : a.start.isBefore(now);
    final locale = Localizations.localeOf(context).toString();
    final when = a.allDay
        ? DateFormat.yMd(locale).format(a.date)
        : '${DateFormat.yMd(locale).format(a.date)} '
              '${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay(hour: a.time!.hour, minute: a.time!.minute))}';
    // One cat: its name in the line. Several: chips below, one each.
    final who = showEntity && members.length == 1
        ? '${_nameOf(context, a.entity)} · '
        : '';
    final color = overdue ? Theme.of(context).colorScheme.error : null;
    return Card(
      child: GestureDetector(
        onLongPressStart: (d) => _menu(context, d.globalPosition),
        onSecondaryTapDown: (d) => _menu(context, d.globalPosition),
        child: WithCatEar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: onOpen,
                leading: const Icon(Icons.event),
                title: Text(
                  '${ReminderCard.relativeDue(context, a.date)} · $when',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$who${a.title}${a.notes.isEmpty ? '' : '\n${a.notes}'}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                isThreeLine: a.notes.isNotEmpty,
                trailing: IconButton(
                  icon: const Icon(Icons.check_circle_outline),
                  tooltip: t.finishLabel,
                  onPressed: () => _finish(context),
                ),
              ),
              if (members.length > 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      for (final m in members)
                        ActionChip(
                          label: Text(_nameOf(context, m.entity)),
                          visualDensity: VisualDensity.compact,
                          onPressed: onOpenEntity == null
                              ? null
                              : () => onOpenEntity!(m.entity),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "How did it go?" — the notes get their last edit before the visit
/// closes. Owns its controller so it outlives the closing animation.
class _OutcomeDialog extends StatefulWidget {
  final String initial;
  const _OutcomeDialog({required this.initial});

  @override
  State<_OutcomeDialog> createState() => _OutcomeDialogState();
}

class _OutcomeDialogState extends State<_OutcomeDialog> {
  late final _notes = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(t.outcomeTitle),
      content: TextField(
        controller: _notes,
        autofocus: true,
        minLines: 2,
        maxLines: 6,
        decoration: InputDecoration(labelText: t.notesLabel),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_notes.text.trim()),
          child: Text(t.finishLabel),
        ),
      ],
    );
  }
}

class _GroupOutcome {
  final String notes;
  final Set<String> treated;
  const _GroupOutcome(this.notes, this.treated);
}

/// "How did it go?" for a run: every cat ticked; the one sent home
/// untreated is unticked and stays planned on its own.
class _GroupOutcomeDialog extends StatefulWidget {
  final String initial;
  final List<(Appointment, String)> members;
  const _GroupOutcomeDialog({required this.initial, required this.members});

  @override
  State<_GroupOutcomeDialog> createState() => _GroupOutcomeDialogState();
}

class _GroupOutcomeDialogState extends State<_GroupOutcomeDialog> {
  late final _notes = TextEditingController(text: widget.initial);
  late final _treated = {for (final (m, _) in widget.members) m.id};

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(t.outcomeTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.finishUntickHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            for (final (m, name) in widget.members)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _treated.contains(m.id),
                title: Text(name),
                onChanged: (on) => setState(() {
                  if (on ?? false) {
                    _treated.add(m.id);
                  } else {
                    _treated.remove(m.id);
                  }
                }),
              ),
            TextField(
              controller: _notes,
              minLines: 2,
              maxLines: 6,
              decoration: InputDecoration(labelText: t.notesLabel),
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
          onPressed: _treated.isEmpty
              ? null
              : () =>
                    Navigator.of(context)
                        .pop(_GroupOutcome(_notes.text.trim(), _treated)),
          child: Text(t.finishLabel),
        ),
      ],
    );
  }
}
