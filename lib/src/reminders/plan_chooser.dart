import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../hidden.dart';
import '../l10n.dart';
import 'appointment_dialog.dart';
import 'reminder_dialog.dart';

/// The one "+" behind both kinds of plan (#75): asks "Termin oder
/// Erinnerung?", then opens the matching dialog. Returns true when
/// something was added.
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
      ],
    ),
  );
  if (kind == null || !context.mounted) return false;
  if (kind == 'reminder') {
    return showAddReminder(context, store, entityId: entityId);
  }
  var entity = entityId;
  if (entity == null) {
    entity = await _pickEntity(context, store);
    if (entity == null || !context.mounted) return false;
  }
  final saved =
      await showAppointmentDialog(context, store, entityId: entity);
  return saved != null;
}

/// From the agenda there is no page to say whose appointment it is.
Future<String?> _pickEntity(BuildContext context, CatalogStore store) {
  final t = context.t;
  final entities = <EntityView>[...store.visibleCats(), ...store.visibleClowders()];
  return showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(t.reminderFor),
      children: [
        for (final e in entities)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(e.id),
            child: Text(e.name),
          ),
      ],
    ),
  );
}
