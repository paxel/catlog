import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../conflict_dialog.dart';
import '../field_labels.dart';
import '../l10n.dart';

/// Every field in the catalog that two people changed at once and
/// nobody has settled yet. Reached from the home menu while there is
/// one; each row settles with the same dialog the field itself offers.
class ConflictsScreen extends StatefulWidget {
  final CatalogStore store;

  const ConflictsScreen({super.key, required this.store});

  @override
  State<ConflictsScreen> createState() => _ConflictsScreenState();
}

class _ConflictsScreenState extends State<ConflictsScreen> {
  CatalogStore get store => widget.store;

  Future<void> _resolve(String entity, String field) async {
    await showConflictDialog(context, store, entity, field);
    if (!mounted) return;
    // The last one settled: nothing left to show here.
    if (store.conflicts().isEmpty) {
      Navigator.of(context).pop();
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.summaryConflicts)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(t.conflictBody),
          ),
          for (final (entity, field) in store.conflicts())
            ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.amber),
              title: Text(
                '${store.current(entity, Keys.name) ?? t.unnamed} — ${fieldLabel(t, store, field)}',
              ),
              subtitle: Text(
                [
                  for (final e in store.fieldHistory(entity, field).take(2))
                    '${valueLabel(t, store, field, e.value)} (${e.author})',
                ].join(' · '),
              ),
              onTap: () => _resolve(entity, field),
            ),
        ],
      ),
    );
  }
}
