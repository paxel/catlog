import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void sync(CatalogStore from, CatalogStore to) => to.applyEntries(
    from.entriesSince(to.versionVector()),
    senderVector: from.versionVector());

/// A device's entry sequence numbers must only ever grow. Peers hold
/// removed entries under their old numbers, so re-issuing one would make
/// the new entry invisible to everyone who already synced.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a, b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  int highestOwn(CatalogStore s) => s.versionVector()[s.deviceId] ?? 0;

  test('removing own entries does not lower the version vector', () {
    a.createCat('Miezi');
    final before = highestOwn(a);
    a.author = 'anna the second';
    a.hardDeleteAuthor('anna');
    expect(highestOwn(a), greaterThanOrEqualTo(before));
  });

  Set<int> ownDseqs(CatalogStore s) => s
      .entriesSince(const {})
      .where((e) => e.device == s.deviceId)
      .map((e) => e.dseq)
      .toSet();

  test('the next entry after a removal takes an unused number', () {
    a.createCat('Miezi');
    final before = highestOwn(a);
    a.author = 'anna the second';
    final survivors = ownDseqs(a);
    a.hardDeleteAuthor('anna');
    final cat = a.createCat('Mausi');
    final fresh = ownDseqs(a).difference(survivors);
    expect(fresh, isNotEmpty);
    expect(fresh.every((d) => d > before), isTrue,
        reason: 'reused $fresh, all should be above $before');
    expect(a.current(cat, Keys.name), 'Mausi');
  });

  test('a peer that already synced still receives what is written after '
      'a removal', () {
    a.createCat('Miezi');
    sync(a, b);
    a.author = 'anna the second';
    a.hardDeleteAuthor('anna');
    final cat = a.createCat('Mausi');
    sync(a, b);
    expect(b.current(cat, Keys.name), 'Mausi');
  });

  test('numbers keep growing across many removals', () {
    final everUsed = ownDseqs(a);
    for (var i = 0; i < 3; i++) {
      a.author = 'anna $i';
      final cat = a.createCat('Cat $i');
      a.append(cat, Keys.userField('color'), 'black');
      final fresh = ownDseqs(a).difference(everUsed);
      expect(fresh, isNotEmpty);
      expect(everUsed.intersection(fresh), isEmpty,
          reason: 'round $i re-used a number');
      everUsed.addAll(fresh);
      a.hardDeleteAuthor('anna $i');
    }
  });
}
