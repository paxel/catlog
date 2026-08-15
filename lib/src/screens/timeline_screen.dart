import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';

/// The timeline of an entity: every change in date order with Author —
/// or, when [field] is given, the history of that one Field. Entries can
/// be reverted git-style: the previous value is appended as a new,
/// authored entry at the current time; nothing is ever deleted.
class TimelineScreen extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final String? field;

  const TimelineScreen(
      {super.key, required this.store, required this.entityId, this.field});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  CatalogStore get store => widget.store;

  void _entryMenu(Entry entry) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.undo),
            title: const Text('Revert this change'),
            subtitle: const Text(
                'Restores the previous value as a new entry — history keeps both.'),
            onTap: () {
              Navigator.of(sheetContext).pop();
              final restored = store.revertEntry(entry.seq);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(restored == null
                    ? '${fieldLabel(store, entry.field)} cleared'
                    : '${fieldLabel(store, entry.field)} back to '
                        '"${valueLabel(store, entry.field, restored)}"'),
              ));
            },
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(widget.entityId, Keys.name) ?? '(unnamed)';
    final entries = widget.field == null
        ? store.timeline(widget.entityId)
        : store.fieldHistory(widget.entityId, widget.field!);
    final visible =
        entries.where((e) => e.field != Keys.type).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.field == null
            ? 'Timeline — $name'
            : '${fieldLabel(store, widget.field!)} — $name'),
      ),
      body: ListView.builder(
        itemCount: visible.length,
        itemBuilder: (context, i) {
          final e = visible[i];
          final date = e.date.toLocal().toIso8601String().substring(0, 10);
          final revertable = CatalogStore.isRevertable(e.field);
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(
                '${fieldLabel(store, e.field)}: ${valueLabel(store, e.field, e.value)}'),
            subtitle: Text('$date · ${e.author}'),
            trailing: revertable ? const Icon(Icons.undo, size: 18) : null,
            onTap: revertable ? () => _entryMenu(e) : null,
          );
        },
      ),
    );
  }
}
