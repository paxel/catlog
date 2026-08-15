import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

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
      SnackBar(content: Text('No other $kindLabel to merge into.')),
    );
    return false;
  }

  final survivorId = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text('Merge this $kindLabel into…'),
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
      title: Text('Merge into $survivorName?'),
      content: Text(
          'The two records become one. $survivorName keeps its current '
          'values; the other record\'s history joins its timeline. '
          'This cannot be undone.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Merge'),
        ),
      ],
    ),
  );
  if (sure != true) return false;

  merge(loserId, survivorId);
  return true;
}
