import 'dart:convert';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Keys travel with the entries: in the bundle, in the shared folder.
/// A tampered file is refused where the key is known.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore a;
  late CatalogStore b;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-sign');
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
  });

  tearDown(() {
    a.close();
    b.close();
    dir.deleteSync(recursive: true);
  });

  test('a bundle carries the keys; the reader pins them', () {
    final cat = a.createCat('Miezi');
    final path = writeBundle(a, '${dir.path}/a.catsync.zip');
    final result = importBundle(b, path);
    expect(result.report.newKeys.single.record.device, a.deviceId);
    expect(b.pinnedKey(a.deviceId)!.trust, KeyTrust.tofu);
    expect(b.current(cat, 'name'), 'Miezi');
    // A bundle from before 1.2 carries no keys file and still imports.
    expect(importBundle(b, path).report.isEmpty, isTrue);
  });

  test('a hand-edited bundle line is refused once the key is known', () {
    final cat = a.createCat('Miezi');
    importBundle(b, writeBundle(a, '${dir.path}/first.zip'));
    // Anna's later change, forged: same row numbers, other value.
    a.append(cat, 'name', 'Minka');
    final lines = [
      for (final e in a.entriesSince(b.versionVector()))
        jsonEncode({...e.toJson(), 'value': 'Mauzi'})
    ];
    writeZipStreaming('${dir.path}/forged.zip', utf8.encode(lines.join('\n')),
        flagged: false, hashes: const [], bytesOf: (_) => null);
    final result = importBundle(b, '${dir.path}/forged.zip');
    expect(result.entriesIn, 0);
    expect(result.report.refused[('anna', a.deviceId)], 1);
    expect(b.current(cat, 'name'), 'Miezi');
    // The real one lands afterwards.
    importBundle(b, writeBundle(a, '${dir.path}/second.zip'));
    expect(b.current(cat, 'name'), 'Minka');
  });

  test('the shared folder publishes keys and learns the others\' first', () {
    final cat = a.createCat('Miezi');
    b.createCat('Wanderer');
    folderSync(a, dir.path);
    final keys = File('${dir.path}/catlog-sync/keys/${a.deviceId}.json');
    expect(keys.existsSync(), isTrue);
    final result = folderSync(b, dir.path);
    expect(result.report.newKeys.single.record.device, a.deviceId);
    expect(b.current(cat, 'name'), 'Miezi');
    // Anna's second round learns Bob's key from his file.
    expect(folderSync(a, dir.path).report.newKeys.single.record.device,
        b.deviceId);
    // A forged line in Anna's file is refused by Bob.
    final own = File('${dir.path}/catlog-sync/${a.deviceId}.jsonl');
    final rows = own.readAsLinesSync();
    // The file holds Bob's rows too by now: forge one of Anna's.
    final last = rows
        .map((l) => (jsonDecode(l) as Map).cast<String, dynamic>())
        .lastWhere((r) => r['device'] == a.deviceId);
    rows.add(jsonEncode({...last, 'dseq': last['dseq'] + 1, 'value': 'x'}));
    own.writeAsStringSync(rows.join('\n'));
    final again = folderSync(b, dir.path);
    expect(again.report.refused[('anna', a.deviceId)], 1);
    expect(again.entriesIn, 0);
  });

  test('a pre-1.2 folder without keys still syncs as unsigned', () {
    final root = Directory('${dir.path}/catlog-sync')..createSync();
    File('${root.path}/old-phone.jsonl').writeAsStringSync([
      jsonEncode({
        'device': 'old-phone',
        'dseq': 1,
        'entity': 'cat:old',
        'field': r'$type',
        'value': 'cat',
        'date': '2026-01-01T00:00:00.000000Z',
        'author': 'carla',
        'recorded': '2026-01-01T00:00:00.000000Z',
      }),
      jsonEncode({
        'device': 'old-phone',
        'dseq': 2,
        'entity': 'cat:old',
        'field': 'name',
        'value': 'Oldie',
        'date': '2026-01-01T00:00:00.000000Z',
        'author': 'carla',
        'recorded': '2026-01-01T00:00:00.000000Z',
      }),
    ].join('\n'));
    final result = folderSync(b, dir.path);
    expect(result.entriesIn, 2);
    expect(result.report.isEmpty, isTrue);
    expect(b.cats().single.name, 'Oldie');
  });
}
