import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Looks: the tag groups per species, the stored line, the rule table
/// that says when two animals cannot be one, and the candidates a
/// catalog yields from it.
void main() {
  setUpAll(useSystemSqlite);

  group('groups and encoding', () {
    test('groups follow the species; unknown gets size and colours', () {
      List<String> ids(String? s) =>
          looksGroupsFor(s).map((g) => g.id).toList();
      expect(ids('cat'), [
        'size',
        'colours',
        'eyes',
        'pattern',
        'fur',
        'tail',
        'ears',
        'marks',
        'features'
      ]);
      expect(ids('dog'), contains('pattern'));
      expect(ids('rabbit'), isNot(contains('pattern')));
      expect(ids('bird'),
          ['size', 'colours', 'marks', 'crest', 'beak', 'ring', 'features']);
      expect(ids('horse'), ['size', 'colours', 'marks', 'features']);
      expect(ids(null), ['size', 'colours', 'features']);
      expect(ids('dragon'), ['size', 'colours', 'features']);
      expect(looksGroupsFor('bird').firstWhere((g) => g.id == 'colours').values,
          contains('green'));
    });

    test('the line round-trips, sorted, empty as null', () {
      final looks = {
        'colours': {'white', 'black'},
        'size': {'medium'},
        'marks': {'white bib'},
      };
      final line = encodeLooks(looks);
      expect(line, 'size=medium; colours=black,white; marks=white bib');
      expect(parseLooks(line), looks);
      expect(encodeLooks({}), isNull);
      expect(encodeLooks({'size': {}}), isNull);
      expect(parseLooks(null), isEmpty);
      expect(parseLooks('garbage'), isEmpty);
      expect(parseLooks('fur=short;;=x;size='), {
        'fur': {'short'}
      });
    });
  });

  group('the rule table', () {
    LooksComparison cmp({
      String? sa = 'cat',
      String? sb = 'cat',
      String? ga,
      String? gb,
      Map<String, Set<String>> a = const {},
      Map<String, Set<String>> b = const {},
    }) =>
        compareLooks(
            speciesA: sa,
            speciesB: sb,
            genderA: ga,
            genderB: gb,
            looksA: a,
            looksB: b);

    test('species differing contradicts; unknown never does', () {
      expect(cmp(sa: 'cat', sb: 'dog').contradiction, isTrue);
      expect(cmp(sa: 'cat', sb: null).contradiction, isFalse);
      expect(cmp(sa: 'cat', sb: 'dragon').contradiction, isFalse);
      expect(cmp(sa: 'cat', sb: 'cat').agreeing, isEmpty,
          reason: 'species is a precondition, not an agreement');
    });

    test('a one-value group set on both with different values contradicts', () {
      expect(
          cmp(a: {
            'size': {'small'}
          }, b: {
            'size': {'large'}
          }).contradiction,
          isTrue);
      expect(
          cmp(a: {
            'size': {'small'}
          }, b: {
            'size': {'small'}
          }).agreeing,
          ['size']);
      // Set on one side only: neither.
      final one = cmp(a: {
        'size': {'small'}
      }, b: {
        'fur': {'long'}
      });
      expect(one.contradiction, isFalse);
      expect(one.agreeing, isEmpty);
    });

    test('a many-value group contradicts only when nothing is shared', () {
      final disjoint = cmp(a: {
        'colours': {'black'}
      }, b: {
        'colours': {'white', 'ginger'}
      });
      expect(disjoint.contradiction, isTrue);
      final overlap = cmp(a: {
        'colours': {'black', 'white'}
      }, b: {
        'colours': {'white'}
      });
      expect(overlap.contradiction, isFalse);
      expect(overlap.agreeing, ['colours']);
    });

    test('a shared feature weighs double and leads; absence never contradicts',
        () {
      final one = cmp(a: {
        'features': {'missing hind leg'}
      }, b: {
        'size': {'small'}
      });
      expect(one.contradiction, isFalse);
      expect(one.agreeing, isEmpty);
      final shared = cmp(
        a: {
          'size': {'small'},
          'features': {'missing hind leg', 'no teeth'}
        },
        b: {
          'size': {'small'},
          'features': {'no teeth'}
        },
      );
      expect(shared.agreeing, ['features', 'size']);
      expect(shared.agreements, 3);
      // One shared feature alone reaches the candidate threshold.
      expect(
          cmp(a: {
            'features': {'ear tattoo'}
          }, b: {
            'features': {'ear tattoo'}
          }).agreements,
          looksCandidateMinimum);
    });

    test('old ear marks read as features', () {
      final looks = parseLooks('marks=ear tip,white bib; size=small');
      expect(looks['features'], {'tipped ear'});
      expect(looks['marks'], {'white bib'});
      expect(parseLooks('marks=notched ear')['features'], {'notched ear'});
      expect(parseLooks('marks=notched ear').containsKey('marks'), isFalse);
    });

    test('gender is one more one-value group, unknown unset', () {
      expect(cmp(ga: 'female', gb: 'male').contradiction, isTrue);
      expect(cmp(ga: 'female', gb: 'unknown').agreeing, isEmpty);
      expect(cmp(ga: 'female', gb: 'unknown').contradiction, isFalse);
      expect(cmp(ga: 'male', gb: 'male').agreeing, ['gender']);
    });

    test('agreements list in display order, gender first', () {
      final c = cmp(
        ga: 'female',
        gb: 'female',
        a: {
          'marks': {'blaze'},
          'size': {'medium'},
          'fur': {'short'}
        },
        b: {
          'marks': {'blaze', 'spots'},
          'size': {'medium'},
          'fur': {'short'}
        },
      );
      expect(c.contradiction, isFalse);
      expect(c.agreeing, ['gender', 'size', 'fur', 'marks']);
    });
  });

  group('candidates in a catalog', () {
    late CatalogStore store;

    setUp(() => store = CatalogStore.inMemory()..author = 'anna');
    tearDown(() => store.close());

    String cat(String name,
        {String? home,
        String? looks,
        String? gender,
        String species = 'cat',
        (double, double)? at}) {
      final id = store.createCat(name, clowderId: home, species: species);
      if (looks != null) store.append(id, 'f:looks', looks);
      if (gender != null) store.append(id, 'f:gender', gender);
      if (at != null) store.recordPosition(id, at.$1, at.$2);
      return id;
    }

    test('the Looks field is seeded with its own type', () {
      final def = store.fieldDefs().firstWhere((d) => d.slug == 'looks');
      expect(def.type, FieldType.tags);
      expect(def.scope, FieldScope.cat);
    });

    test('two agreeing groups make a pair, one does not', () {
      final a = cat('Seen', looks: 'size=medium; fur=short');
      final b = cat('Lost', looks: 'size=medium; fur=short');
      cat('Other', looks: 'size=medium');
      final found = looksCandidates(store).single;
      expect({found.a, found.b}, {a, b});
      expect(found.agreeing, ['size', 'fur']);
    });

    test('a contradiction rules a pair out', () {
      cat('Seen', looks: 'size=medium; fur=short; colours=black');
      cat('Lost', looks: 'size=medium; fur=short; colours=white');
      expect(looksCandidates(store), isEmpty);
      cat('Dog', looks: 'size=medium; fur=short', species: 'dog');
      expect(looksCandidates(store), isEmpty);
    });

    test('housemates never pair; a stray against a home cat does', () {
      final home = store.createClowder('Müllers');
      cat('A', home: home, looks: 'size=small; fur=long');
      cat('B', home: home, looks: 'size=small; fur=long');
      expect(looksCandidates(store), isEmpty);
      cat('Stray', looks: 'size=small; fur=long');
      expect(looksCandidates(store), hasLength(2));
    });

    test('ranked by agreements, then distance, no distance last', () {
      final stray = cat('Stray',
          looks: 'size=small; fur=long; colours=black', at: (52.5, 13.4));
      final far = cat('Far',
          looks: 'size=small; fur=long; colours=black', at: (52.6, 13.4));
      final near = cat('Near',
          looks: 'size=small; fur=long; colours=black', at: (52.5001, 13.4));
      final nowhere =
          cat('Nowhere', looks: 'size=small; fur=long; colours=black');
      final weak = cat('Weak', looks: 'size=small; fur=long', at: (52.5, 13.4));
      final pairs = looksCandidates(store)
          .where((m) => m.a == stray || m.b == stray)
          .map((m) => m.a == stray ? m.b : m.a)
          .toList();
      expect(pairs, [near, far, nowhere, weak]);
    });

    test('the match list carries Looks pairs after ID and map pairs', () {
      final a = cat('Seen', looks: 'size=medium; fur=short');
      final b = cat('Lost', looks: 'size=medium; fur=short');
      store.append(a, 'f:chipid', '276 1');
      store.append(b, 'f:chipid', '2761');
      final c = cat('Third', looks: 'size=medium; fur=short');
      final all = matchCandidates(store);
      expect(all.first.reason, MatchReason.idExact);
      expect(all.where((m) => m.reason == MatchReason.looks).length, 2,
          reason: 'the ID pair is not listed twice');
      expect(all.last.agreeing, ['size', 'fur']);
      expect({all.last.a, all.last.b}, anyOf({a, c}, {b, c}));
    });

    test('a rejected pair stays away until a side changes', () {
      final a = cat('Seen', looks: 'size=medium; fur=short');
      final b = cat('Lost', looks: 'size=medium; fur=short');
      rejectLooksMatch(store, a, b);
      expect(isLooksRejected(store, b, a), isTrue);
      expect(looksCandidates(store), isEmpty);
      expect(looksCandidates(store, includeRejected: true), hasLength(1));
      store.append(b, 'f:looks', 'size=medium; fur=short; marks=blaze');
      expect(isLooksRejected(store, a, b), isFalse);
      expect(looksCandidates(store), hasLength(1));
    });
  });
}
