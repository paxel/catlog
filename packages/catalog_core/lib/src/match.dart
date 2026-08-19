import 'dart:math';

import 'fields.dart';
import 'store.dart';

/// 75% of lost cats are found within 500 m of home (Huang et al.,
/// PMC5789300) — the one radius used for circles (#31) and candidate
/// search (#33). No knob.
const strayAreaRadiusMeters = 500.0;

/// Why two cats might be the same animal.
enum MatchReason { idExact, geoDate }

/// A candidate pair, deterministic and offline — confirmation is the
/// existing Merge, nothing here changes data (#33).
class MatchCandidate {
  final String a;
  final String b;
  final MatchReason reason;

  /// The ID field both share, for [MatchReason.idExact].
  final FieldDef? idField;

  /// Meters between the closest positions, for [MatchReason.geoDate].
  final double? distanceMeters;

  const MatchCandidate(this.a, this.b, this.reason,
      {this.idField, this.distanceMeters});
}

/// Great-circle distance in meters.
double haversineMeters(
    double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  final dLat = _rad(lat2 - lat1);
  final dLon = _rad(lon2 - lon1);
  final h = pow(sin(dLat / 2), 2) +
      cos(_rad(lat1)) * cos(_rad(lat2)) * pow(sin(dLon / 2), 2);
  return 2 * r * asin(sqrt(h.toDouble()));
}

double _rad(double deg) => deg * pi / 180;

String _pairKey(String a, String b) =>
    a.compareTo(b) < 0 ? '$a|$b' : '$b|$a';

/// All match candidates in the catalog, ID-exact first, then geo pairs
/// sorted by distance. Never fuzzy: IDs match exactly after
/// normalization; geo pairs need positions within [strayAreaRadiusMeters].
List<MatchCandidate> matchCandidates(CatalogStore store) {
  final seen = <String>{};
  final result = <MatchCandidate>[];
  final cats = store.cats();

  // ID-exact: same ID field definition, normalized-equal values.
  for (final def in store.fieldDefs()) {
    if (def.type != FieldType.id) continue;
    final byValue = <String, List<String>>{};
    for (final cat in cats) {
      final value = store.current(cat.id, def.key);
      if (value == null || value.isEmpty) continue;
      byValue.putIfAbsent(normalizeId(value), () => []).add(cat.id);
    }
    for (final ids in byValue.values) {
      for (var i = 0; i < ids.length; i++) {
        for (var j = i + 1; j < ids.length; j++) {
          if (seen.add(_pairKey(ids[i], ids[j]))) {
            result.add(MatchCandidate(ids[i], ids[j], MatchReason.idExact,
                idField: def));
          }
        }
      }
    }
  }

  // Geo: a missing cat's flier circles catch strays sighted inside;
  // stray sightings within the radius of each other pair up too.
  final positions = <String, List<(double, double)>>{};
  final fliers = <String, List<(double, double)>>{};
  for (final cat in cats) {
    final sightings = <(double, double)>[
      for (final e in store.fieldHistory(cat.id, CatalogStore.positionKey))
        if (CatalogStore.parsePositionKind(e.value ?? '') ==
            PositionKind.sighting)
          if (CatalogStore.parsePosition(e.value) case final pos?) pos
    ];
    positions[cat.id] = sightings;
    fliers[cat.id] = store.flierPositions(cat.id);
  }
  final geo = <MatchCandidate>[];
  for (var i = 0; i < cats.length; i++) {
    for (var j = i + 1; j < cats.length; j++) {
      final a = cats[i].id, b = cats[j].id;
      if (seen.contains(_pairKey(a, b))) continue;
      double? best;
      void check(List<(double, double)> xs, List<(double, double)> ys) {
        for (final x in xs) {
          for (final y in ys) {
            final d = haversineMeters(x.$1, x.$2, y.$1, y.$2);
            if (d <= strayAreaRadiusMeters && (best == null || d < best!)) {
              best = d;
            }
          }
        }
      }

      // Flier circle of one against sightings of the other, both ways,
      // and sighting against sighting for stray↔stray.
      check(fliers[a]!, positions[b]!);
      check(fliers[b]!, positions[a]!);
      check(positions[a]!, positions[b]!);
      if (best != null) {
        seen.add(_pairKey(a, b));
        geo.add(MatchCandidate(a, b, MatchReason.geoDate,
            distanceMeters: best));
      }
    }
  }
  geo.sort((x, y) => x.distanceMeters!.compareTo(y.distanceMeters!));
  return [...result, ...geo];
}
