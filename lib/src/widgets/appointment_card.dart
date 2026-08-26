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
class AppointmentCard extends StatelessWidget {
  final CatalogStore store;
  final Appointment appointment;
  final bool showEntity;
  final VoidCallback onChanged;
  final VoidCallback? onOpen;

  const AppointmentCard(
      {super.key,
      required this.store,
      required this.appointment,
      required this.onChanged,
      this.showEntity = true,
      this.onOpen});

  Future<void> _finish(BuildContext context) async {
    final outcome = await showDialog<String>(
      context: context,
      builder: (context) => _OutcomeDialog(initial: appointment.notes),
    );
    if (outcome == null) return;
    store.finishAppointment(appointment, notes: outcome);
    onChanged();
  }

  Future<void> _menu(BuildContext context, Offset position) async {
    final t = context.t;
    final action = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(value: 'edit', child: Text(t.editLabelAppointment)),
        PopupMenuItem(value: 'delete', child: Text(t.deleteAppointment)),
      ],
    );
    if (!context.mounted) return;
    if (action == 'edit') {
      final saved = await showAppointmentDialog(context, store,
          entityId: appointment.entity, existing: appointment);
      if (saved != null) onChanged();
    }
    if (action == 'delete') {
      store.deleteAppointment(appointment);
      onChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final a = appointment;
    final now = DateTime.now();
    final overdue = a.allDay
        ? DateUtils.dateOnly(a.date).isBefore(DateUtils.dateOnly(now))
        : a.start.isBefore(now);
    final locale = Localizations.localeOf(context).toString();
    final when = a.allDay
        ? DateFormat.yMd(locale).format(a.date)
        : '${DateFormat.yMd(locale).format(a.date)} '
            '${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay(hour: a.time!.hour, minute: a.time!.minute))}';
    final who = showEntity
        ? '${store.current(a.entity, Keys.name) ?? t.unnamed} · '
        : '';
    final color = overdue ? Theme.of(context).colorScheme.error : null;
    return Card(
      child: GestureDetector(
        onLongPressStart: (d) => _menu(context, d.globalPosition),
        onSecondaryTapDown: (d) => _menu(context, d.globalPosition),
        child: WithCatEar(
            child: ListTile(
          onTap: onOpen,
          leading: const Icon(Icons.event),
          title: Text(
              '${ReminderCard.relativeDue(context, a.date)} · $when',
              style:
                  TextStyle(color: color, fontWeight: FontWeight.bold)),
          subtitle: Text(
              '$who${a.title}${a.notes.isEmpty ? '' : '\n${a.notes}'}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          isThreeLine: a.notes.isNotEmpty,
          trailing: IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: t.finishLabel,
            onPressed: () => _finish(context),
          ),
        )),
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
