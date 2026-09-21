import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../chores/chore_dialog.dart';
import 'appointment_dialog.dart';
import 'reminder_dialog.dart';

/// The one "+" behind every kind of plan (#75, chores in 1.2.0): asks
/// which, then opens the matching dialog. Returns true when something
/// was added.
Future<bool> showPlanChooser(BuildContext context, CatalogStore store,
    {String? entityId}) async {
  final t = context.t;
  final kind = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(t.planChooserTitle),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop('appointment'),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event),
            title: Text(t.planChooserAppointment),
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop('reminder'),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.alarm),
            title: Text(t.planChooserReminder),
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop('chore'),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.checklist),
            title: Text(t.planChooserChore),
          ),
        ),
      ],
    ),
  );
  if (kind == null || !context.mounted) return false;
  if (kind == 'chore') {
    return await showChoreDialog(context, store, entityId: entityId) != null;
  }
  if (kind == 'reminder') {
    return showAddReminder(context, store, entityId: entityId);
  }
  final saved =
      await showAppointmentDialog(context, store, entityId: entityId);
  return saved != null;
}
