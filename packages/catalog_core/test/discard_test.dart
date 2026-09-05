import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Keeping your own version of something a partner changed: the arrived
/// entries go, stay gone over the next sync, and the partner's catalog
/// is not touched.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a;
  late CatalogStore b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  List<Entry> receive(CatalogStore from, CatalogStore to) =>
      to.applyEntries(from.entriesSince(to.versionVector()),
          senderVector: from.versionVector());

  test('a partner\'s deletion can be kept out, for good', () {
    final cat = a.createCat('Miezi');
    receive(a, b);
    b.deleteCat(cat);

    final applied = receive(b, a);
    expect(a.current(cat, Keys.deleted), 'true');

    a.discardEntries(applied.where((e) => a.resolveEntity(e.entity) == cat));
    expect(a.current(cat, Keys.deleted), isNull);
    expect(a.cats().map((c) => c.name), ['Miezi']);

    // The next sync brings nothing back: the numbers count as seen.
    expect(receive(b, a), isEmpty);
    expect(a.cats().map((c) => c.name), ['Miezi']);
    // And Bob's catalog is not argued with.
    expect(receive(a, b), isEmpty);
    expect(b.current(cat, Keys.deleted), 'true');
  });

  test('keeping your value clears the conflict the arrival raised', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'white', date: DateTime.utc(2025, 1, 1));
    receive(a, b);
    a.append(cat, 'f:color', 'black', date: DateTime.utc(2026, 1, 1));
    b.append(cat, 'f:color', 'grey', date: DateTime.utc(2026, 1, 2));

    final applied = receive(b, a);
    expect(a.current(cat, 'f:color'), 'grey');
    expect(a.hasConflict(cat, 'f:color'), isTrue);

    a.discardEntries(applied);
    expect(a.current(cat, 'f:color'), 'black');
    expect(a.hasConflict(cat, 'f:color'), isFalse);
    expect(receive(b, a), isEmpty);
    expect(a.current(cat, 'f:color'), 'black');
    expect(b.current(cat, 'f:color'), 'grey');
  });

  test('a later edit by the partner still arrives', () {
    final cat = a.createCat('Miezi');
    receive(a, b);
    b.append(cat, 'f:color', 'grey');
    a.discardEntries(receive(b, a));
    expect(a.current(cat, 'f:color'), isNull);

    b.append(cat, 'f:color', 'black');
    final later = receive(b, a);
    expect(later, hasLength(1));
    expect(a.current(cat, 'f:color'), 'black');
  });
}
