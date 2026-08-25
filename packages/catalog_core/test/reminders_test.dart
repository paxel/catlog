import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

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

  DateTime inDays(int days) => DateTime.now().add(Duration(days: days));

  test('a flagged entry never becomes the current value', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', '2024-05-01');
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(365), reminder: true);
    expect(a.current(cat, 'f:vaccine'), '2024-05-01');
    expect(a.currentFields(cat)['f:vaccine'], '2024-05-01');
  });

  test('a flagged entry stays a plan even after its date passes', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:checkup', 'look after her',
        date: DateTime.now().subtract(const Duration(days: 3)),
        reminder: true);
    expect(a.current(cat, 'f:checkup'), isNull);
  });

  test('active reminders list plans ordered by due date', () {
    final cat = a.createCat('Miezi');
    final home = a.createClowder('Hof');
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    a.append(home, 'f:checkup', 'site visit', date: inDays(5), reminder: true);
    final active = a.activeReminders();
    expect(active.map((r) => r.value).toList(), ['site visit', 'refresh']);
    expect(active.first.entity, home);
    expect(active.last.entity, cat);
  });

  test('a done fact recorded today retires a plan dated years ahead', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh',
        date: inDays(3 * 365), reminder: true);
    expect(a.activeReminders(), hasLength(1));
    a.append(cat, 'f:vaccine', 'done 2026');
    expect(a.activeReminders(), isEmpty);
    expect(a.current(cat, 'f:vaccine'), 'done 2026');
  });

  test('a new flagged entry reschedules; a flagged null cancels', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:meds', 'worming', date: inDays(10), reminder: true);
    a.append(cat, 'f:meds', 'worming', date: inDays(20), reminder: true);
    final active = a.activeReminders();
    expect(active, hasLength(1));
    expect(active.single.due.day, inDays(20).day);
    a.append(cat, 'f:meds', null, reminder: true);
    expect(a.activeReminders(), isEmpty);
    expect(a.current(cat, 'f:meds'), isNull);
  });

  test('a pre-1.0.0 database gains the reminder column on open', () {
    final dir = Directory.systemTemp.createTempSync('catlog_remcol');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = '${dir.path}/old.db';
    // A 0.3.x database: entries table without the reminder column.
    final raw = sqlite3.open(path);
    raw.execute('''
      CREATE TABLE entries (
        seq      INTEGER PRIMARY KEY AUTOINCREMENT,
        device   TEXT NOT NULL,
        dseq     INTEGER NOT NULL,
        entity   TEXT NOT NULL,
        field    TEXT NOT NULL,
        value    TEXT,
        date     TEXT NOT NULL,
        author   TEXT NOT NULL,
        recorded TEXT NOT NULL
      );
      CREATE TABLE local_settings (key TEXT PRIMARY KEY, value TEXT NOT NULL);
      INSERT INTO local_settings (key, value) VALUES ('device', 'dev-old');
      INSERT INTO entries (device, dseq, entity, field, value, date, author, recorded)
      VALUES ('dev-old', 1, 'cat:x', '\$type', 'cat', '2026-01-01T00:00:00.000000Z', 'axel', '2026-01-01T00:00:00.000000Z'),
             ('dev-old', 2, 'cat:x', 'name', 'Miezi', '2026-01-01T00:00:00.000000Z', 'axel', '2026-01-01T00:00:00.000000Z');
    ''');
    raw.dispose();
    final migrated = CatalogStore.open(path);
    addTearDown(migrated.close);
    migrated.author = 'axel';
    // Backfilled rows are facts; nothing became a plan.
    expect(migrated.current('cat:x', 'name'), 'Miezi');
    expect(migrated.activeReminders(), isEmpty);
    migrated.append('cat:x', 'f:vaccine', 'refresh',
        date: DateTime.now().add(const Duration(days: 30)), reminder: true);
    expect(migrated.activeReminders(), hasLength(1));
  });

  test('merge keeps the survivor plan a fact re-assertion would retire',
      () {
    final keep = a.createCat('Keep');
    final lose = a.createCat('Lose');
    // Both hold differing facts on the field, so the merge re-asserts
    // the survivor's — a newer append that would retire the plan.
    a.append(keep, 'f:vaccine', 'done 2025');
    a.append(lose, 'f:vaccine', 'done 2024');
    a.append(keep, 'f:vaccine', 'refresh', date: inDays(90), reminder: true);
    a.mergeCat(lose, keep);
    expect(a.current(keep, 'f:vaccine'), 'done 2025');
    final active = a.activeReminders();
    expect(active, hasLength(1));
    expect(active.single.value, 'refresh');
    expect(active.single.entity, keep);
  });

  test('retirement follows the merge survivor', () {
    final keep = a.createCat('Keep');
    final lose = a.createCat('Lose');
    a.append(lose, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    a.mergeCat(lose, keep);
    final active = a.activeReminders();
    expect(active, hasLength(1));
    expect(active.single.entity, keep);
    a.append(keep, 'f:vaccine', 'done');
    expect(a.activeReminders(), isEmpty);
  });

  test('plans on a deleted cat drop out of the agenda', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    a.deleteCat(cat);
    expect(a.activeReminders(), isEmpty);
  });

  test('the flag survives sync and applies on the peer', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());
    expect(b.current(cat, 'f:vaccine'), isNull);
    expect(b.activeReminders(), hasLength(1));
    expect(b.activeReminders().single.value, 'refresh');
  });

  test('a plan does not flag a bogus conflict against an arriving fact',
      () {
    final cat = a.createCat('Miezi');
    b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());
    final vector = a.versionVector();
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    b.append(cat, 'f:vaccine', 'done');
    a.applyEntries(b.entriesSince(vector), senderVector: b.versionVector());
    expect(a.hasConflict(cat, 'f:vaccine'), isFalse);
    expect(a.current(cat, 'f:vaccine'), 'done');
  });

  test('legacy JSON without the flag imports as a fact', () {
    final e = Entry.fromJson({
      'device': 'dev-a',
      'dseq': 1,
      'entity': 'cat:x',
      'field': 'name',
      'value': 'Miezi',
      'date': DateTime.now().toIso8601String(),
      'author': 'anna',
      'recorded': DateTime.now().toIso8601String(),
    });
    expect(e.reminder, isFalse);
  });

  test('privacy withholds a flagged value from a public sync', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:meds', 'secret plan', date: inDays(5), reminder: true);
    a.setFieldPrivate(cat, 'f:meds', true);
    b.applyEntries(a.entriesSince(const {}),
        senderVector: a.versionVector());
    expect(b.activeReminders(), isEmpty);
  });

  test('a flag-free catalog exports the pre-1.0.0 bundle layout', () {
    expect(a.hasReminders(), isFalse);
    a.createCat('Miezi');
    final dir = Directory.systemTemp.createTempSync('catlog-compat');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = writeBundle(a, '${dir.path}/b.zip');
    final names = {
      for (final f
          in ZipDecoder().decodeBytes(File(path).readAsBytesSync()).files)
        if (f.isFile) f.name
    };
    // Exactly what a 0.3.x reader expects — no format file, old name.
    expect(names, contains('entries.jsonl'));
    expect(names, isNot(contains('format')));
    expect(names, isNot(contains('entries2.jsonl')));
    importBundle(b, path);
    expect(b.cats().single.name, 'Miezi');

    // The first reminder flips the layout.
    a.append(a.cats().single.id, 'f:vaccine', 'refresh',
        date: inDays(30), reminder: true);
    expect(a.hasReminders(), isTrue);
    final path2 = writeBundle(a, '${dir.path}/b2.zip');
    final names2 = {
      for (final f in ZipDecoder()
          .decodeBytes(File(path2).readAsBytesSync())
          .files)
        if (f.isFile) f.name
    };
    expect(names2, contains('format'));
    expect(names2, contains('entries2.jsonl'));
    expect(names2, isNot(contains('entries.jsonl')));
  });

  test('a bundle round-trips the flag and refuses a newer format', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    final dir = Directory.systemTemp.createTempSync('catlog-reminder');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = writeBundle(a, '${dir.path}/b.zip');
    importBundle(b, path);
    expect(b.activeReminders(), hasLength(1));
    expect(b.current(cat, 'f:vaccine'), isNull);

    final raw = File(path).readAsBytesSync();
    final tampered = _withFormat(raw, '99');
    expect(() => importBundleBytes(b, tampered),
        throwsA(isA<UnsupportedBundleFormat>()));
  });

  test('folder sync moves the flag and leaves no legacy own-file', () {
    final dir = Directory.systemTemp.createTempSync('catlog-folder');
    addTearDown(() => dir.deleteSync(recursive: true));
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh', date: inDays(30), reminder: true);
    // A stale pre-1.0.0 own-file must disappear on the next sync.
    final root = Directory('${dir.path}/catlog-sync')
      ..createSync(recursive: true);
    File('${root.path}/${a.deviceId}.jsonl').writeAsStringSync('');
    folderSync(a, dir.path);
    expect(File('${root.path}/${a.deviceId}.jsonl').existsSync(), isFalse);
    expect(
        File('${root.path}/${a.deviceId}.jsonl2').existsSync(), isTrue);
    folderSync(b, dir.path);
    expect(b.activeReminders(), hasLength(1));
    expect(b.current(cat, 'f:vaccine'), isNull);
  });

  test('reverting a fact restores the previous fact, never a plan', () {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'first');
    a.append(cat, 'f:vaccine', 'planned', date: inDays(30), reminder: true);
    a.append(cat, 'f:vaccine', 'second');
    final latest = a
        .fieldHistory(cat, 'f:vaccine')
        .firstWhere((e) => e.value == 'second');
    a.revertEntry(latest.seq);
    expect(a.current(cat, 'f:vaccine'), 'first');
  });

  test('ics export writes one all-day event per plan', () {
    final ics = writeIcs([
      IcsEvent(
          uid: 'catlog-cat-x-f-vaccine@catlog',
          date: DateTime(2029, 5, 4),
          summary: 'Miezi — Impfung',
          description: 'Auffrischung, mit Umlauten öäü'),
    ], stamp: DateTime.utc(2026, 8, 25, 12));
    expect(ics, contains('BEGIN:VCALENDAR'));
    expect(ics, contains('DTSTART;VALUE=DATE:20290504'));
    expect(ics, contains('DTEND;VALUE=DATE:20290505'));
    expect(ics, contains('SUMMARY:Miezi — Impfung'));
    expect(ics, contains('UID:catlog-cat-x-f-vaccine@catlog'));
    expect(ics, isNot(contains('VALARM')));
    // Every content line stays within the 75-octet fold limit.
    for (final line in ics.split('\r\n')) {
      expect(utf8.encode(line).length, lessThanOrEqualTo(75));
    }
  });
}

/// Rewrites the bundle's `format` file to [version].
List<int> _withFormat(List<int> zipBytes, String version) {
  final archive = ZipDecoder().decodeBytes(zipBytes);
  final out = Archive();
  for (final f in archive.files) {
    if (!f.isFile) continue;
    if (f.name == 'format') continue;
    out.addFile(ArchiveFile(
        f.name, (f.content as List<int>).length, f.content));
  }
  final v = utf8.encode(version);
  out.addFile(ArchiveFile('format', v.length, v));
  return ZipEncoder().encode(out)!;
}
