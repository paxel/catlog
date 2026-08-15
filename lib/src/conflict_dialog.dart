import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'field_labels.dart';
import 'l10n.dart';

/// Two people changed [field] at the same time. Shows the competing
/// values with author and date; the user keeps the current one or
/// promotes the other — promotion is an ordinary new entry (ADR-0001).
/// Either way the badge clears. Returns true if anything changed.
Future<bool> showConflictDialog(BuildContext context, CatalogStore store,
    String entity, String field) async {
  final candidates = store.fieldHistory(entity, field).take(2).toList();
  String? chosen = candidates.isEmpty ? null : candidates.first.value;

  final result = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(context.t
            .conflictOn(fieldLabel(context.t, store, field))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.t.conflictBody),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: chosen,
              onChanged: (v) => setState(() => chosen = v),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                for (final e in candidates)
                  RadioListTile<String?>(
                    value: e.value,
                    title: Text(
                        valueLabel(context.t, store, field, e.value)),
                    subtitle: Text(
                        '${DateFormat.yMd(Localizations.localeOf(context).toString()).format(e.date.toLocal())}'
                        ' · ${e.author}'),
                  ),
              ]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.t.resolve),
          ),
        ],
      ),
    ),
  );

  if (result != true) return false;
  final current = store.current(entity, field);
  if (chosen != current) store.append(entity, field, chosen);
  store.resolveConflict(entity, field);
  return true;
}
