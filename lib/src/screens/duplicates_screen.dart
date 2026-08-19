import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../widgets/cat_avatar.dart';

/// "Find duplicates" (#45): likely twins among cats and clowders —
/// exact matches first, fuzzy name matches ranked by shared attributes.
/// Tapping a pair resolves it through the existing Merge.
class DuplicatesScreen extends StatefulWidget {
  final CatalogStore store;

  const DuplicatesScreen({super.key, required this.store});

  @override
  State<DuplicatesScreen> createState() => _DuplicatesScreenState();
}

class _DuplicatesScreenState extends State<DuplicatesScreen> {
  CatalogStore get store => widget.store;

  String _name(String id) =>
      store.current(id, Keys.name) ?? context.t.unnamed;

  String _reason(BuildContext context, DuplicateCandidate c) {
    final t = context.t;
    if (c.tier == DuplicateTier.fuzzy) return t.similarName;
    final key = c.matched.first;
    if (key == Keys.name) return t.sameIdField(t.labelName);
    final def = store.fieldDefs().where((d) => d.key == key).firstOrNull;
    return t.sameIdField(def == null ? key : fieldDefName(t, def));
  }

  Future<void> _confirm(DuplicateCandidate candidate) async {
    final survivor = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.t.mergeInto),
        children: [
          for (final id in [candidate.a, candidate.b])
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(id),
              child: Row(children: [
                if (candidate.cats)
                  CatAvatar(store: store, catId: id, size: 32)
                else
                  const Icon(Icons.home_outlined),
                const SizedBox(width: 8),
                Expanded(child: Text(_name(id))),
              ]),
            ),
        ],
      ),
    );
    if (survivor == null || !mounted) return;
    final loser = survivor == candidate.a ? candidate.b : candidate.a;
    if (candidate.cats) {
      store.mergeCat(loser, survivor);
    } else {
      store.mergeClowder(loser, survivor);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final candidates = duplicateCandidates(store);
    return Scaffold(
      appBar: AppBar(title: Text(t.findDuplicates)),
      body: candidates.isEmpty
          ? Center(child: Text(t.noDuplicates))
          : ListView(children: [
              for (final c in candidates)
                ListTile(
                  leading: c.cats
                      ? SizedBox(
                          width: 64,
                          child: Row(children: [
                            CatAvatar(store: store, catId: c.a, size: 30),
                            const SizedBox(width: 4),
                            CatAvatar(store: store, catId: c.b, size: 30),
                          ]),
                        )
                      : const Icon(Icons.home_outlined),
                  title: Text('${_name(c.a)} · ${_name(c.b)}'),
                  subtitle: Text(_reason(context, c)),
                  trailing: const Icon(Icons.merge_type),
                  onTap: () => _confirm(c),
                ),
            ]),
    );
  }
}
