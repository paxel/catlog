import 'dart:math';

import 'fields.dart';
import 'store.dart';

/// Duplicate detection (#45): synced catalogs accumulate twins — the
/// same cat entered on two devices, a clowder spelled two ways. Two
/// tiers: deterministic matches (normalized-equal names, equal ID
/// values, same birthdate) and fuzzy name matches (small edit distance)
/// ranked by shared attributes. Resolution is the existing Merge.
enum DuplicateTier { exact, fuzzy }

class DuplicateCandidate {
  final String a;
  final String b;

  /// True for a cat pair, false for a clowder pair.
  final bool cats;
  final DuplicateTier tier;

  /// Field keys (or [Keys.name]) whose values agree.
  final List<String> matched;

  /// Shared-attribute score; ranks fuzzy pairs.
  final int score;

  const DuplicateCandidate(this.a, this.b,
      {required this.cats,
      required this.tier,
      required this.matched,
      required this.score});
}

/// Classic edit distance, for the fuzzy name tier.
int editDistance(String a, String b) {
  if (a == b) return 0;
  final prev = List<int>.generate(b.length + 1, (j) => j);
  final curr = List<int>.filled(b.length + 1, 0);
  for (var i = 1; i <= a.length; i++) {
    curr[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      curr[j] = min(min(curr[j - 1] + 1, prev[j] + 1), prev[j - 1] + cost);
    }
    prev.setAll(0, curr);
  }
  return prev[b.length];
}

String _norm(String s) => s.trim().toLowerCase();

List<DuplicateCandidate> duplicateCandidates(CatalogStore store) {
  final result = <DuplicateCandidate>[];
  final idDefs = [
    for (final def in store.fieldDefs())
      if (def.type == FieldType.id) def
  ];

  void scanPairs(List<EntityView> entities, {required bool cats}) {
    for (var i = 0; i < entities.length; i++) {
      for (var j = i + 1; j < entities.length; j++) {
        final a = entities[i], b = entities[j];
        final matched = <String>[];
        var exact = false;

        if (_norm(a.name) == _norm(b.name) && _norm(a.name).isNotEmpty) {
          matched.add(Keys.name);
          exact = true;
        }
        var score = 0;
        if (cats) {
          for (final def in idDefs) {
            final va = store.current(a.id, def.key);
            final vb = store.current(b.id, def.key);
            if (va != null &&
                vb != null &&
                normalizeId(va) == normalizeId(vb)) {
              matched.add(def.key);
              exact = true;
            }
          }
          // Shared attributes rank fuzzy pairs; birthdate weighs most
          // but alone is no duplicate signal — littermates share it.
          for (final slug in ['birthdate', 'gender', 'breed', 'color']) {
            final key = Keys.userField(slug);
            final va = store.current(a.id, key);
            final vb = store.current(b.id, key);
            if (va != null && va.isNotEmpty && va == vb) {
              matched.add(key);
              score += slug == 'birthdate' ? 2 : 1;
            }
          }
        }

        if (exact) {
          result.add(DuplicateCandidate(a.id, b.id,
              cats: cats,
              tier: DuplicateTier.exact,
              matched: matched,
              score: score));
          continue;
        }

        // Fuzzy: close names (typo distance) backed by at least one
        // shared attribute, so Max/Moritz neighbors don't flood the list.
        final distance = editDistance(_norm(a.name), _norm(b.name));
        if (_norm(a.name).length > 2 &&
            distance <= 2 &&
            (distance <= 1 || score >= 1)) {
          result.add(DuplicateCandidate(a.id, b.id,
              cats: cats,
              tier: DuplicateTier.fuzzy,
              matched: [Keys.name, ...matched],
              score: score));
        }
      }
    }
  }

  scanPairs(store.cats(), cats: true);
  scanPairs(store.clowders(), cats: false);
  result.sort((x, y) {
    if (x.tier != y.tier) {
      return x.tier == DuplicateTier.exact ? -1 : 1;
    }
    return y.score.compareTo(x.score);
  });
  return result;
}
