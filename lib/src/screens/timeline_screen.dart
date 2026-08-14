import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';

/// The timeline of an entity: every change in date order with Author —
/// or, when [field] is given, the history of that one Field.
class TimelineScreen extends StatelessWidget {
  final CatalogStore store;
  final String entityId;
  final String? field;

  const TimelineScreen(
      {super.key, required this.store, required this.entityId, this.field});

  @override
  Widget build(BuildContext context) {
    final name = store.current(entityId, Keys.name) ?? '(unnamed)';
    final entries = field == null
        ? store.timeline(entityId)
        : store.fieldHistory(entityId, field!);
    final visible = entries
        .where((e) => e.field != Keys.type)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(field == null
            ? 'Timeline — $name'
            : '${fieldLabel(store, field!)} — $name'),
      ),
      body: ListView.builder(
        itemCount: visible.length,
        itemBuilder: (context, i) {
          final e = visible[i];
          final date = e.date.toLocal().toIso8601String().substring(0, 10);
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(
                '${fieldLabel(store, e.field)}: ${valueLabel(store, e.field, e.value)}'),
            subtitle: Text('$date · ${e.author}'),
          );
        },
      ),
    );
  }
}
