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
  // Choices are entries, not values: two entries can carry the same
  // value, and then there is nothing to pick — only the badge to clear.
  final same = {for (final e in candidates) e.value}.length <= 1;
  int? chosen = candidates.isEmpty ? null : candidates.first.seq;

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
            if (same) ...[
              Text(context.t.conflictSame(valueLabel(context.t, store, field,
                  candidates.firstOrNull?.value))),
            ] else ...[
              Text(context.t.conflictBody),
              const SizedBox(height: 8),
              RadioGroup<int?>(
                groupValue: chosen,
                onChanged: (v) => setState(() => chosen = v),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  for (final e in candidates)
                    RadioListTile<int?>(
                      value: e.seq,
                      title: Text(
                          valueLabel(context.t, store, field, e.value)),
                      subtitle: Text(
                          '${DateFormat.yMd(Localizations.localeOf(context).toString()).format(e.date.toLocal())}'
                          ' · ${e.author}'),
                    ),
                ]),
              ),
            ],
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
  final picked =
      candidates.where((e) => e.seq == chosen).firstOrNull?.value;
  final current = store.current(entity, field);
  if (!same && picked != current) store.append(entity, field, picked);
  store.resolveConflict(entity, field);
  return true;
}
