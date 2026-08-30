import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/import_summary.dart';
import 'package:catlog/src/pet_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(useSystemSqlite);

  test('classifier sorts a sync into fosterer events', () {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);

    // Shared baseline: one cat, one forever home.
    final cat = a.createCat('Miezi');
    final home = a.createClowder('Webers');
    a.append(home, 'f:status', 'forever-home');
    b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());

    // Bob: adoption, a death, an escape, a new cat, a plain change.
    final escapee = b.createCat('Runner', clowderId: home);
    b.moveCat(cat, home);
    b.append(escapee, Keys.clowder, null);
    final gone = b.createCat('Oldtimer');
    b.append(gone, 'f:deceased', '2026-01-01');
    b.append(cat, 'f:color', 'black');

    final applied = a.applyEntries(b.entriesSince(a.versionVector()),
        senderVector: b.versionVector());
    final summary = classifyImport(a, applied);

    expect(summary.adopted, [cat]);
    expect(summary.newCats.toSet(), {escapee, gone});
    // The new cats' own membership/death rows fold into "new".
    expect(summary.escaped, isEmpty);
    expect(summary.deceased, isEmpty);
    expect(summary.other, greaterThan(0));
  });

  test('escape and death of known cats are reported', () {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);

    final home = a.createClowder('Home');
    final cat = a.createCat('Miezi', clowderId: home);
    final old = a.createCat('Oldtimer', clowderId: home);
    b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());

    b.append(cat, Keys.clowder, null);
    b.append(old, 'f:deceased', '2026-02-02');

    final applied = a.applyEntries(b.entriesSince(a.versionVector()),
        senderVector: b.versionVector());
    final summary = classifyImport(a, applied);
    expect(summary.escaped, [cat]);
    expect(summary.deceased, [old]);
  });

  test('an empty catalog arrives as nothing at all', () {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);

    // Both catalogs carry the same starter Fields, written on their own
    // device: every definition row is news to the other side and used to
    // be counted as one more change.
    final applied = b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());
    expect(applied, isNotEmpty);

    final summary = classifyImport(b, applied);
    expect(summary.other, 0);
    expect(summary.isEmpty, isTrue);
  });

  test('the pet-mode switch is configuration, not a change to report', () {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);
    addTearDown(() => petMode.value = false);
    b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());
    setPetMode(b, true);
    final applied = a.applyEntries(b.entriesSince(a.versionVector()),
        senderVector: b.versionVector());
    expect(applied, isNotEmpty);
    final summary = classifyImport(a, applied);
    expect(summary.other, 0);
    expect(summary.isEmpty, isTrue);
  });
}
