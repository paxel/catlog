import 'breeds.dart';
import 'fields.dart';
import 'match.dart';
import 'store.dart';

/// Looks (1.2.0): what an animal looks like, as tags in groups — size,
/// colours, marks, and per species fur, tail, ears, pattern, plumage.
/// Photos of a stray and of a pet at home are not comparable; tags are.
/// A cat's Looks live in the starter `looks` field as one line, e.g.
/// `size=medium; colours=black,white; fur=short`. Values are canonical
/// English keys; the UI translates them.
class LooksGroup {
  final String id;

  /// One value at most (size, fur) — or any number (colours, marks).
  final bool single;
  final List<String> values;

  const LooksGroup(this.id, {required this.single, required this.values});
}

const _size =
    LooksGroup('size', single: true, values: ['small', 'medium', 'large']);
const _furColours = LooksGroup('colours', single: false, values: [
  'black',
  'white',
  'grey',
  'brown',
  'ginger',
  'cream',
  'golden',
  'tan'
]);
const _plumage = LooksGroup('colours', single: false, values: [
  'green',
  'blue',
  'yellow',
  'red',
  'orange',
  'white',
  'grey',
  'black',
  'brown'
]);
const _furMarks = LooksGroup('marks', single: false, values: [
  'white bib',
  'white paws',
  'white tail tip',
  'blaze',
  'mask',
  'spots',
  'patches',
  'stripes',
  'scar',
  'notched ear',
  'ear tip',
  'collar'
]);
const _birdMarks = LooksGroup('marks',
    single: false,
    values: ['spots', 'stripes', 'patches', 'mask', 'collar', 'scar']);
const _fur = LooksGroup('fur',
    single: true, values: ['short', 'medium', 'long', 'hairless']);
const _tail = LooksGroup('tail',
    single: true, values: ['long', 'short', 'bobtail', 'none', 'curled']);
const _ears = LooksGroup('ears',
    single: true, values: ['upright', 'floppy', 'folded', 'rounded']);
const _catPattern = LooksGroup('pattern', single: true, values: [
  'solid',
  'tabby',
  'tortoiseshell',
  'calico',
  'colourpoint',
  'bicolour',
  'tuxedo'
]);
const _dogPattern = LooksGroup('pattern', single: true, values: [
  'solid',
  'brindle',
  'merle',
  'spotted',
  'patched',
  'tricolour',
  'sable'
]);
const _crest = LooksGroup('crest', single: true, values: ['yes', 'no']);
const _beak = LooksGroup('beak',
    single: true, values: ['black', 'grey', 'yellow', 'orange', 'red', 'pink']);
const _ring = LooksGroup('ring', single: true, values: ['yes', 'no']);

/// Species with fur, a tail and ears worth describing.
const _furred = {'cat', 'dog', 'rabbit', 'guinea pig', 'hamster'};

/// Every group id there is, in display order, with whether it takes one
/// value — the rule table reads this, whatever the species.
const looksGroupOrder = [
  'size',
  'colours',
  'pattern',
  'fur',
  'tail',
  'ears',
  'marks',
  'crest',
  'beak',
  'ring'
];
const _single = {
  'size',
  'pattern',
  'fur',
  'tail',
  'ears',
  'crest',
  'beak',
  'ring'
};

/// Whether [group] takes one value at most.
bool looksGroupIsSingle(String group) => _single.contains(group);

/// A species the app knows, or null for anything else.
String? knownSpecies(String? species) =>
    species != null && speciesPresets.contains(species) ? species : null;

/// The groups an animal of [species] is described with. Unknown species
/// get size and colours only — nothing that presumes fur or feathers.
List<LooksGroup> looksGroupsFor(String? species) {
  final known = knownSpecies(species);
  if (known == null) return const [_size, _furColours];
  if (known == 'bird') {
    return const [_size, _plumage, _birdMarks, _crest, _beak, _ring];
  }
  if (_furred.contains(known)) {
    return [
      _size,
      _furColours,
      if (known == 'cat') _catPattern,
      if (known == 'dog') _dogPattern,
      _fur,
      _tail,
      _ears,
      _furMarks,
    ];
  }
  return const [_size, _furColours, _furMarks];
}

/// The stored line as a map of group to chosen values. Tolerant: an
/// unknown group or value is kept, an empty line is an empty map.
Map<String, Set<String>> parseLooks(String? value) {
  final result = <String, Set<String>>{};
  if (value == null) return result;
  for (final part in value.split(';')) {
    final eq = part.indexOf('=');
    if (eq < 0) continue;
    final group = part.substring(0, eq).trim();
    if (group.isEmpty) continue;
    final values = {
      for (final v in part.substring(eq + 1).split(','))
        if (v.trim().isNotEmpty) v.trim(),
    };
    if (values.isNotEmpty) result[group] = values;
  }
  return result;
}

/// The map as the stored line, groups in display order; null when
/// nothing is chosen, so the field reads as empty.
String? encodeLooks(Map<String, Set<String>> looks) {
  final groups = [
    for (final g in looksGroupOrder)
      if (looks[g]?.isNotEmpty ?? false) g,
    for (final g in looks.keys)
      if (!looksGroupOrder.contains(g) && looks[g]!.isNotEmpty) g,
  ];
  if (groups.isEmpty) return null;
  return [
    for (final g in groups) '$g=${(looks[g]!.toList()..sort()).join(',')}',
  ].join('; ');
}

/// How two animals compare: [contradiction] when they cannot be one
/// animal; [agreeing] the groups (gender included) that say the same.
class LooksComparison {
  final bool contradiction;
  final List<String> agreeing;

  const LooksComparison(this.contradiction, this.agreeing);

  int get agreements => agreeing.length;
}

/// The rule table. Species differing is a contradiction, an unknown
/// species never contradicts. A one-value group set on both sides with
/// different values contradicts; a many-value group contradicts only
/// when both sides are set and share nothing. A group set on one side
/// only is neither. Gender is one more one-value group, `unknown` unset.
LooksComparison compareLooks({
  required String? speciesA,
  required String? speciesB,
  required String? genderA,
  required String? genderB,
  required Map<String, Set<String>> looksA,
  required Map<String, Set<String>> looksB,
}) {
  final sa = knownSpecies(speciesA), sb = knownSpecies(speciesB);
  if (sa != null && sb != null && sa != sb) {
    return const LooksComparison(true, []);
  }
  final agreeing = <String>[];
  String? gender(String? g) =>
      g == null || g.isEmpty || g == 'unknown' ? null : g;
  final ga = gender(genderA), gb = gender(genderB);
  if (ga != null && gb != null) {
    if (ga != gb) return const LooksComparison(true, []);
    agreeing.add('gender');
  }
  final groups = [
    for (final g in looksGroupOrder)
      if (looksA.containsKey(g) && looksB.containsKey(g)) g,
  ];
  for (final g in groups) {
    final a = looksA[g]!, b = looksB[g]!;
    if (looksGroupIsSingle(g)) {
      if (a.first != b.first) return const LooksComparison(true, []);
      agreeing.add(g);
    } else {
      if (a.intersection(b).isEmpty) return const LooksComparison(true, []);
      agreeing.add(g);
    }
  }
  return LooksComparison(false, agreeing);
}

/// How many groups must agree before a pair is worth showing.
const looksCandidateMinimum = 2;

/// A pair the Looks say might be one animal.
class LooksMatch {
  final String a;
  final String b;
  final List<String> agreeing;

  /// Meters between their positions, when both have one.
  final double? distanceMeters;

  const LooksMatch(this.a, this.b, this.agreeing, {this.distanceMeters});

  int get agreements => agreeing.length;
}

String looksPairKey(String a, String b) =>
    a.compareTo(b) < 0 ? '$a|$b' : '$b|$a';

/// What a Reject remembers: the pair as it looked. A later change to
/// either animal's Looks, species or gender brings the pair back.
String looksSignature(CatalogStore store, String catId) => [
      store.current(catId, Keys.userField('species')) ?? '',
      store.current(catId, Keys.userField('gender')) ?? '',
      store.current(catId, Keys.userField('looks')) ?? '',
    ].join('');

String _rejectKey(String a, String b) => 'rejectedMatch:${looksPairKey(a, b)}';

String _pairSignature(CatalogStore store, String a, String b) {
  final first = a.compareTo(b) < 0 ? a : b;
  final second = first == a ? b : a;
  return '${looksSignature(store, first)}\n${looksSignature(store, second)}';
}

/// Remembers on this device that [a] and [b] are not one animal.
void rejectLooksMatch(CatalogStore store, String a, String b) =>
    store.setLocalSetting(_rejectKey(a, b), _pairSignature(store, a, b));

/// True while the pair was rejected and neither side changed since.
bool isLooksRejected(CatalogStore store, String a, String b) =>
    store.localSetting(_rejectKey(a, b)) == _pairSignature(store, a, b);

/// Pairs whose Looks agree in at least [looksCandidateMinimum] groups
/// with no contradiction, at least one of them a stray — housemates
/// that look alike are not lost-and-found candidates. Ranked by
/// agreements, then by distance, pairs without one last. Rejected
/// pairs are left out unless [includeRejected].
List<LooksMatch> looksCandidates(CatalogStore store,
    {bool includeRejected = false}) {
  final cats = store.cats();
  final species = <String, String?>{};
  final gender = <String, String?>{};
  final looks = <String, Map<String, Set<String>>>{};
  final stray = <String, bool>{};
  final position = <String, (double, double)?>{};
  for (final cat in cats) {
    species[cat.id] = store.current(cat.id, Keys.userField('species'));
    gender[cat.id] = store.current(cat.id, Keys.userField('gender'));
    looks[cat.id] = parseLooks(store.current(cat.id, Keys.userField('looks')));
    stray[cat.id] = store.current(cat.id, Keys.clowder) == null;
    position[cat.id] = store.positionOf(cat.id);
  }
  final result = <LooksMatch>[];
  for (var i = 0; i < cats.length; i++) {
    for (var j = i + 1; j < cats.length; j++) {
      final a = cats[i].id, b = cats[j].id;
      if (!stray[a]! && !stray[b]!) continue;
      if (looks[a]!.isEmpty || looks[b]!.isEmpty) continue;
      final c = compareLooks(
        speciesA: species[a],
        speciesB: species[b],
        genderA: gender[a],
        genderB: gender[b],
        looksA: looks[a]!,
        looksB: looks[b]!,
      );
      if (c.contradiction || c.agreements < looksCandidateMinimum) continue;
      if (!includeRejected && isLooksRejected(store, a, b)) continue;
      final pa = position[a], pb = position[b];
      final distance = pa == null || pb == null
          ? null
          : haversineMeters(pa.$1, pa.$2, pb.$1, pb.$2);
      result.add(LooksMatch(a, b, c.agreeing, distanceMeters: distance));
    }
  }
  result.sort((x, y) {
    final byCount = y.agreements.compareTo(x.agreements);
    if (byCount != 0) return byCount;
    final dx = x.distanceMeters, dy = y.distanceMeters;
    if (dx == null && dy == null) return 0;
    if (dx == null) return 1;
    if (dy == null) return -1;
    return dx.compareTo(dy);
  });
  return result;
}
