import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// "Merge into…" — the record on screen is the LOSER and folds into the
/// picked survivor, irreversibly (CONTEXT.md: Merge). Returns true if a
/// merge happened; the caller closes the loser's screen.
Future<bool> showMergeDialog({
  required BuildContext context,
  required CatalogStore store,
  required String loserId,
  required String kindLabel,
  required List<EntityView> candidates,
  required void Function(String loserId, String survivorId) merge,
}) async {
  final options = candidates.where((c) => c.id != loserId).toList();
  if (options.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.t.noOtherToMergeInto(kindLabel))),
    );
    return false;
  }

  final survivorId = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(context.t.mergeThisInto(kindLabel)),
      children: [
        for (final c in options)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(c.id),
            child: Text(c.name),
          ),
      ],
    ),
  );
  if (survivorId == null) return false;
  if (!context.mounted) return false;

  final survivorName =
      candidates.firstWhere((c) => c.id == survivorId).name;
  final sure = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.t.mergeIntoQuestion(survivorName)),
      content: Text(context.t.mergeBody(survivorName)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.t.merge),
        ),
      ],
    ),
  );
  if (sure != true) return false;

  merge(loserId, survivorId);
  return true;
}
