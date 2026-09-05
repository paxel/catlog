import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/import_summary.dart';
import 'package:catlog/src/pet_mode.dart';
import 'package:flutter_test/flutter_test.dart';

/// The review of an import: what is new, what changed and how — read
/// against the catalog as it is now, never the raw entry list.
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

  void share(CatalogStore from, CatalogStore to) => to.applyEntries(
      from.entriesSince(to.versionVector()),
      senderVector: from.versionVector());

  List<Entry> receive(CatalogStore from, CatalogStore to) => to.applyEntries(
      from.entriesSince(to.versionVector()),
      senderVector: from.versionVector());

  test('new cats and homes are new; known ones list their changes', () {
    final cat = a.createCat('Miezi');
    final home = a.createClowder('Webers');
    a.append(home, 'f:status', 'forever-home');
    share(a, b);

    final runner = b.createCat('Runner', clowderId: home);
    b.moveCat(cat, home);
    b.append(cat, 'f:color', 'black');
    b.append(cat, 'f:color', 'grey');

    final review = reviewImport(a, receive(b, a));
    expect(review.newCats, [runner]);
    expect(review.newClowders, isEmpty);
    expect(review.updated.map((u) => u.id), [cat]);
    final miezi = review.updated.single;
    // Two entries on one field are one effective change: nothing → grey.
    final color = miezi.changes.singleWhere((c) => c.field == 'f:color');
    expect(color.before, isNull);
    expect(color.after, 'grey');
    // Moving into a forever home tags the row as an adoption.
    expect(miezi.tags, {tagAdopted});
    expect(review.conflicts, isEmpty);
  });

  test('an entry that lost to a newer local value is not a change', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'white', date: DateTime.utc(2025, 1, 1));
    share(a, b);
    // Bob backdates his entry: it loses to what Anna already has.
    b.append(cat, 'f:color', 'black', date: DateTime.utc(2024, 1, 1));

    final review = reviewImport(a, receive(b, a));
    expect(a.current(cat, 'f:color'), 'white');
    expect(review.updated, isEmpty, reason: 'nothing visible changed');
    expect(review.isEmpty, isTrue);
  });

  test('escape, death and a photo read as what they are', () {
    final home = a.createClowder('Home');
    final cat = a.createCat('Miezi', clowderId: home);
    final old = a.createCat('Oldtimer', clowderId: home);
    share(a, b);

    b.append(cat, Keys.clowder, null);
    b.append(old, 'f:deceased', '2026-02-02');
    b.append(old, '${Keys.imagePrefix}abc', 'added');

    final review = reviewImport(a, receive(b, a));
    final byId = {for (final u in review.updated) u.id: u};
    expect(byId[cat]!.tags, {tagEscaped});
    expect(byId[old]!.tags, {tagDeceased});
    expect(byId[old]!.changes.where((c) => c.isPhoto), hasLength(1));
    expect(review.meta.map((m) => m.kind), contains(MetaKind.photos));
  });

  test('an empty catalog arrives as nothing at all', () {
    final review = reviewImport(a, receive(b, a));
    expect(review.isEmpty, isTrue);
  });

  test('field definitions and the mode are meta, not news', () {
    share(a, b);
    b.defineField('Chip colour', FieldType.text);
    setPetMode(b, true);

    final review = reviewImport(a, receive(b, a));
    expect(review.newOnes, isEmpty);
    expect(review.updated, isEmpty);
    expect(review.meta.map((m) => m.kind),
        containsAll([MetaKind.fieldAdded, MetaKind.mode]));
  });

  test('a concurrent edit is listed as a conflict', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'white', date: DateTime.utc(2025, 1, 1));
    share(a, b);
    a.append(cat, 'f:color', 'black', date: DateTime.utc(2026, 1, 1));
    b.append(cat, 'f:color', 'grey', date: DateTime.utc(2026, 1, 2));

    final review = reviewImport(a, receive(b, a));
    expect(review.conflicts, [(cat, 'f:color')]);
    expect(a.hasConflict(cat, 'f:color'), isTrue);
  });
}
