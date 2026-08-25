import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../help.dart';
import '../field_labels.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../widgets/cat_avatar.dart';
import '../widgets/cat_ear.dart';
import 'cat_detail_screen.dart';

/// Possible same-cat pairs (#33): exact ID matches first, then cats
/// whose positions fall inside the 500 m stray area. Confirming a pair
/// is the existing Merge — the survivor is normally the sighted cat.
class MatchCandidatesScreen extends StatefulWidget {
  final CatalogStore store;

  const MatchCandidatesScreen({super.key, required this.store});

  @override
  State<MatchCandidatesScreen> createState() =>
      _MatchCandidatesScreenState();
}

class _MatchCandidatesScreenState extends State<MatchCandidatesScreen> {
  CatalogStore get store => widget.store;

  /// Species filter: null = all.
  String? _species;

  String _name(String id) =>
      store.current(id, Keys.name) ?? context.t.unnamed;

  String? _speciesOf(String id) =>
      store.current(id, Keys.userField('species'));

  Future<void> _confirm(MatchCandidate candidate) async {
    // Survivor picks — normally the sighted cat; both offered. The
    // shared dialog carries the cannot-be-undone warning.
    final merged = await confirmPairMerge(
      context: context,
      store: store,
      a: candidate.a,
      b: candidate.b,
      lead: (id) => CatAvatar(store: store, catId: id, size: 32),
      merge: store.mergeCat,
    );
    if (merged && mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final all = matchCandidates(store);
    final species = {
      for (final c in all) ...[?_speciesOf(c.a), ?_speciesOf(c.b)]
    }.toList()
      ..sort();
    final candidates = _species == null
        ? all
        : [
            for (final c in all)
              if (_speciesOf(c.a) == _species ||
                  _speciesOf(c.b) == _species)
                c
          ];
    return Scaffold(
      appBar: AppBar(title: Text(t.matchCandidatesTitle), actions: [
        HelpButton(store: store, screenId: 'matches'),
      ]),
      body: candidates.isEmpty
          ? Center(child: Text(t.noMatchCandidates))
          : ListView(children: [
              if (species.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Wrap(spacing: 8, children: [
                    for (final s in species)
                      FilterChip(
                        label: Text(s),
                        selected: _species == s,
                        onSelected: (on) =>
                            setState(() => _species = on ? s : null),
                      ),
                  ]),
                ),
              for (final c in candidates)
                WithCatEar(
                    child: ListTile(
                  leading: SizedBox(
                    width: 64,
                    child: Row(children: [
                      CatAvatar(store: store, catId: c.a, size: 30),
                      const SizedBox(width: 4),
                      CatAvatar(store: store, catId: c.b, size: 30),
                    ]),
                  ),
                  title: Text('${_name(c.a)} · ${_name(c.b)}'),
                  subtitle: Text(c.reason == MatchReason.idExact
                      ? t.sameIdField(
                          fieldDefName(t, c.idField!))
                      : t.metersApart(
                          c.distanceMeters!.round().toString())),
                  trailing: const Icon(Icons.merge_type),
                  onTap: () => _confirm(c),
                  onLongPress: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        CatDetailScreen(store: store, catId: c.a),
                  )),
                )),
            ]),
    );
  }
}
