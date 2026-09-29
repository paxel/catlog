import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../help.dart';
import '../conflict_choice.dart';
import '../field_labels.dart';
import '../l10n.dart';

/// Every field in the catalog that two people changed at once and
/// nobody has settled yet. Reached from the home menu while there is
/// one, and from a field's badge; each row carries its two values as
/// buttons, a tap settles it.
class ConflictsScreen extends StatefulWidget {
  final CatalogStore store;

  const ConflictsScreen({super.key, required this.store});

  @override
  State<ConflictsScreen> createState() => _ConflictsScreenState();
}

class _ConflictsScreenState extends State<ConflictsScreen> {
  CatalogStore get store => widget.store;

  void _resolved() {
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
      appBar: AppBar(
        title: Text(t.summaryConflicts),
        actions: [HelpButton(store: widget.store, screenId: 'conflicts')],
      ),
      body: ListView(
        children: [
          for (final (entity, field) in store.conflicts()) ...[
            ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.amber),
              title: Text(
                '${store.current(entity, Keys.name) ?? t.unnamed} — ${fieldLabel(t, store, field)}',
              ),
            ),
            ConflictChoice(
              store: store,
              entity: entity,
              field: field,
              onResolved: _resolved,
            ),
          ],
        ],
      ),
    );
  }
}
