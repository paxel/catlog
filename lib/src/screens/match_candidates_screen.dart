import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../help.dart';
import '../field_labels.dart';
import '../l10n.dart';
import '../looks_labels.dart';
import '../merge_dialogs.dart';
import '../widgets/cat_avatar.dart';
import '../widgets/cat_ear.dart';
import 'cat_detail_screen.dart';

/// Possible same-cat pairs (#33): exact ID matches first, then cats
/// whose positions fall inside the 500 m stray area, then pairs whose
/// Looks agree (1.2.0). Confirming a pair is the existing Merge — the
/// survivor is normally the sighted cat. A Looks pair can be rejected;
/// this phone forgets it until either animal's Looks change.
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

  void _reject(MatchCandidate candidate) {
    rejectLooksMatch(store, candidate.a, candidate.b);
    setState(() {});
  }

  Widget _subtitle(MatchCandidate c) {
    final t = context.t;
    switch (c.reason) {
      case MatchReason.idExact:
        return Text(t.sameIdField(fieldDefName(t, c.idField!)));
      case MatchReason.geoDate:
        return Text(t.metersApart(c.distanceMeters!.round().toString()));
      case MatchReason.looks:
        // Weighted like the ranking: a shared feature counts double.
        final line = t.traitsAgree(
            c.agreeing.fold(0, (n, g) => n + looksGroupWeight(g)));
        final apart = c.distanceMeters == null
            ? line
            : '$line · ${t.metersApart(c.distanceMeters!.round().toString())}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(apart),
            Wrap(spacing: 4, children: [
              for (final g in c.agreeing)
                Chip(
                  label: Text(g == 'gender'
                      ? t.starterGender
                      : looksGroupLabel(t, g)),
                  visualDensity: VisualDensity.compact,
                  backgroundColor: Colors.green.shade100,
                  side: BorderSide.none,
                  padding: EdgeInsets.zero,
                ),
            ]),
          ],
        );
    }
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
                  subtitle: _subtitle(c),
                  trailing: c.reason == MatchReason.looks
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: t.rejectMatch,
                            onPressed: () => _reject(c),
                          ),
                          const Icon(Icons.merge_type),
                        ])
                      : const Icon(Icons.merge_type),
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
