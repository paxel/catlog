import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'field_labels.dart';
import 'l10n.dart';

/// Two people changed a field at the same time. The choice sits on the
/// row itself: one button per value, with who and when; a tap keeps
/// that one. Keeping the other is an ordinary new entry (ADR-0001);
/// either way the badge clears. Two entries with the same value have
/// nothing to pick, only the badge to clear.
List<Entry> conflictCandidates(
        CatalogStore store, String entity, String field) =>
    store.fieldHistory(entity, field).take(2).toList();

/// Both entries carry the same value: nothing to pick.
bool conflictSame(List<Entry> candidates) =>
    {for (final e in candidates) e.value}.length <= 1;

/// Writes the decision: the kept value when it differs from what
/// stands, then the badge cleared.
void resolveConflictWith(
    CatalogStore store, String entity, String field, Entry? kept) {
  final candidates = conflictCandidates(store, entity, field);
  final current = store.current(entity, field);
  if (!conflictSame(candidates) && kept != null && kept.value != current) {
    store.append(entity, field, kept.value);
  }
  store.resolveConflict(entity, field);
}

/// The buttons under a conflict's row.
class ConflictChoice extends StatelessWidget {
  final CatalogStore store;
  final String entity;
  final String field;
  final VoidCallback onResolved;

  const ConflictChoice({
    super.key,
    required this.store,
    required this.entity,
    required this.field,
    required this.onResolved,
  });

  void _keep(Entry? kept) {
    resolveConflictWith(store, entity, field, kept);
    onResolved();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final candidates = conflictCandidates(store, entity, field);
    if (conflictSame(candidates)) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.conflictSame(
                valueLabel(t, store, field, candidates.firstOrNull?.value))),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => _keep(null),
              child: Text(t.resolve),
            ),
          ],
        ),
      );
    }
    final locale = Localizations.localeOf(context).toString();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final e in candidates) ...[
            OutlinedButton(
              onPressed: () => _keep(e),
              child: Column(
                children: [
                  Text(valueLabel(t, store, field, e.value)),
                  Text(
                    '${DateFormat.yMd(locale).format(e.date.toLocal())} · ${e.author}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
