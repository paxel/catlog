import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../field_labels.dart';
import '../l10n.dart';

/// The values a field has held, newest first: facts only. Cleared
/// values, plans (reminder entries) and bookkeeping are left out; a
/// revert shows as the value it brought back, on its date.
List<Entry> valueHistory(CatalogStore store, String entityId, String field) => [
  for (final e in store.fieldHistory(entityId, field))
    if (!e.reminder && e.value != null) e,
];

/// Whether the field has a history worth a page: two values or more.
bool hasValueHistory(CatalogStore store, String entityId, String field) =>
    valueHistory(store, entityId, field).length >= 2;

/// A field's values over time as a diary — for remarks kept as notes,
/// a status that changed hands, anything without a curve. Read-only:
/// reverting lives on the edit-mode timeline.
class FieldHistoryScreen extends StatelessWidget {
  final CatalogStore store;
  final String entityId;
  final FieldDef def;

  const FieldHistoryScreen({
    super.key,
    required this.store,
    required this.entityId,
    required this.def,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final name = store.current(entityId, Keys.name) ?? t.unnamed;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.fieldHistoryOf(fieldDefName(t, def), name))),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final e in valueHistory(store, entityId, def.key))
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueLabel(t, store, def.key, e.value),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${DateFormat.yMd(locale).format(e.date.toLocal())} · ${e.author}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
