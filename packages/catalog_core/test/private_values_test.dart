import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Two-way sync with per-side privacy choice, as the transports do it.
void sync(CatalogStore a, CatalogStore b,
    {bool aPrivate = false, bool bPrivate = false}) {
  final va = a.versionVector();
  final vb = b.versionVector();
  b.applyEntries(a.entriesSince(vb, includePrivate: aPrivate),
      senderVector: va);
  a.applyEntries(b.entriesSince(va, includePrivate: bPrivate),
      senderVector: vb);
}

/// Privacy is a property of a value, not of an entity: ids, types and
/// names always travel, so nothing a partner receives can point at
/// something they have never heard of.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a, b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'ben';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  test('a private clowder travels by name, its fields do not', () {
    final home = a.createClowder('Holbeinstr 15');
    a.append(home, 'f:address', 'holbeinstr 15');
    a.append(home, 'f:phone', '0177 806235');
    a.setPrivate(home, true);

    sync(a, b);

    expect(b.clowders().map((c) => c.id), contains(home));
    expect(b.current(home, Keys.name), 'Holbeinstr 15');
    expect(b.current(home, 'f:address'), isNull);
    expect(b.current(home, 'f:phone'), isNull);
    // The partner knows a value is there without learning it.
    expect(b.isWithheld(home, 'f:address'), isTrue);
    expect(b.isWithheld(home, 'f:phone'), isTrue);
    // And the plaintext is nowhere in what was received.
    final received = b.entriesSince(const {}, includePrivate: true);
    expect(received.map((e) => e.value), isNot(contains('0177 806235')));
  });

  test('a public cat in a private clowder lands in that clowder', () {
    final home = a.createClowder('Hideout');
    a.append(home, 'f:address', 'somewhere');
    a.setPrivate(home, true);
    final cat = a.createCat('Herr Sonnenschein', clowderId: home);

    sync(a, b);

    // The ghost: before per-value privacy the cat arrived pointing at a
    // clowder that was never sent, so it showed up on no screen at all.
    expect(b.cats().map((c) => c.id), contains(cat));
    expect(b.current(cat, Keys.clowder), home);
    expect(b.clowders().map((c) => c.id), contains(home));
    expect(b.current(home, 'f:address'), isNull);
  });

  test('sharing with private on later fills the withheld values', () {
    final home = a.createClowder('Holbeinstr 15');
    a.append(home, 'f:phone', '0177 806235');
    a.setFieldPrivate(home, 'f:phone', true);

    sync(a, b);
    expect(b.current(home, 'f:phone'), isNull);

    // Ordinary traffic afterwards, so every version vector moves past
    // the withheld row — this is what used to make it unreachable.
    a.append(home, 'f:address', 'holbeinstr 15');
    sync(a, b);
    expect(b.current(home, 'f:address'), 'holbeinstr 15');

    sync(a, b, aPrivate: true);
    expect(b.current(home, 'f:phone'), '0177 806235');
    expect(b.isWithheld(home, 'f:phone'), isFalse);
  });

  test('a value marked private after sharing is withheld from then on', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:chipid', '276095610098639');
    sync(a, b);
    expect(b.current(cat, 'f:chipid'), '276095610098639');

    // Already delivered stays delivered — but the next value does not.
    a.setFieldPrivate(cat, 'f:chipid', true);
    a.append(cat, 'f:chipid', '999999999999999');
    sync(a, b);

    // What a partner already holds stays theirs — the newer value simply
    // never arrives, and the marker says one exists.
    expect(b.current(cat, 'f:chipid'), '276095610098639');
    expect(b.current(cat, Keys.withheld('f:chipid')), 'yes');
  });

  test('an old entity mark becomes value marks when the catalog opens', () {
    final dir = Directory.systemTemp.createTempSync('catlog-privacy');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = '${dir.path}/catlog.db';

    final old = CatalogStore.open(path)..author = 'anna';
    final home = old.createClowder('Holbeinstr 15');
    old.append(home, 'f:phone', '0177 806235');
    // The old rule, written the old way: the entity marker alone.
    old.append(home, Keys.private, 'yes');
    old.setLocalSetting('privacyValuesMigrated', '0');
    old.close();

    final migrated = CatalogStore.open(path)..author = 'anna';
    addTearDown(migrated.close);
    expect(migrated.current(home, Keys.privateField('f:phone')), 'yes');
    expect(migrated.current(home, Keys.withheld('f:phone')), 'yes');
    // And the keeper is told once that the name travels now.
    expect(migrated.privacyMeaningChanged(), contains(home));
    migrated.privacyChangeSeen();
    expect(migrated.privacyMeaningChanged(), isEmpty);
  });

  test('marking an entity private marks the values it has', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'schwarz');
    a.setPrivate(cat, true);

    expect(a.isFieldPrivate(cat, 'f:color'), isTrue);
    // The name is never private: without it a partner sees a nameless row.
    expect(a.isFieldPrivate(cat, Keys.name), isFalse);

    sync(a, b);
    expect(b.current(cat, Keys.name), 'Miezi');
    expect(b.current(cat, 'f:color'), isNull);
  });
}
