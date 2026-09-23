import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore a, b;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog_folder');
    a = CatalogStore.inMemory()..author = 'axel';
    b = CatalogStore.inMemory()..author = 'friend';
  });

  tearDown(() {
    a.close();
    b.close();
    dir.deleteSync(recursive: true);
  });

  test('two stores converge through the folder', () async {
    final home = a.createClowder('Home');
    final cat = a.createCat('Miezi', clowderId: home);
    a.addImage(cat, CatalogStore.compressImage(jpeg(50, 50)));
    b.createCat('Wanderer');

    await folderSync(a, dir.path); // a publishes
    await folderSync(b, dir.path); // b imports a, publishes itself
    final second = await folderSync(a, dir.path); // a imports b

    expect(second.entriesIn, greaterThan(0));
    expect(a.cats().length, 2);
    expect(b.cats().length, 2);
    expect(b.clowders().single.name, 'Home');
    expect(b.imageBytes(b.images(b.searchCats('Miezi').single.id).single),
        isNotNull);
  });

  test('only the own files are ever written', () async {
    a.createCat('Miezi');
    await folderSync(a, dir.path);
    await folderSync(b, dir.path);
    final root = '${dir.path}/catlog-sync';
    final segment = File('$root/${segmentName(a.deviceId, 1)}');
    final manifest = File('$root/${manifestName(a.deviceId)}');
    final before = (segment.readAsStringSync(), manifest.readAsStringSync());
    await folderSync(b, dir.path);
    expect((segment.readAsStringSync(), manifest.readAsStringSync()), before);
  });

  test('a change appends to the segment; the manifest moves with it',
      () async {
    a.createCat('Miezi');
    await folderSync(a, dir.path);
    final root = '${dir.path}/catlog-sync';
    final segment = File('$root/${segmentName(a.deviceId, 1)}');
    final linesBefore = segment.readAsLinesSync();
    final manifestBefore = FolderManifest.parse(
        File('$root/${manifestName(a.deviceId)}').readAsBytesSync())!;
    a.createCat('Wanderer');
    final result = await folderSync(a, dir.path);
    final linesAfter = segment.readAsLinesSync();
    final manifestAfter = FolderManifest.parse(
        File('$root/${manifestName(a.deviceId)}').readAsBytesSync())!;
    // The old lines are untouched, the new ones sit after them.
    expect(linesAfter.sublist(0, linesBefore.length), linesBefore);
    expect(linesAfter.length, greaterThan(linesBefore.length));
    expect(result.entriesOut, linesAfter.length - linesBefore.length);
    expect(manifestAfter.generation, manifestBefore.generation);
    expect(manifestAfter.segments.single.$2, linesAfter.length);
    expect(manifestAfter.vector[a.deviceId],
        greaterThan(manifestBefore.vector[a.deviceId]!));
    // A reader takes only the new lines and holds both cats.
    await folderSync(b, dir.path);
    expect(b.cats().map((c) => c.name), containsAll(['Miezi', 'Wanderer']));
  });

  test('a full segment is closed and never written again', () async {
    // Enough entries to pass the cap: each line is a few hundred bytes.
    for (var i = 0; i < 400; i++) {
      a.createCat('Cat $i');
    }
    await folderSync(a, dir.path);
    final root = '${dir.path}/catlog-sync';
    final manifest = FolderManifest.parse(
        File('$root/${manifestName(a.deviceId)}').readAsBytesSync())!;
    expect(manifest.segments.length, greaterThan(1));
    final first = File('$root/${manifest.segments.first.$1}');
    final frozen = first.readAsStringSync();
    a.createCat('One more');
    await folderSync(a, dir.path);
    expect(first.readAsStringSync(), frozen);
    await folderSync(b, dir.path);
    expect(b.cats().length, 401);
  });

  test('a shrunk history is rewritten under a new generation', () async {
    final cat = a.createCat('Miezi');
    await folderSync(a, dir.path);
    await folderSync(b, dir.path);
    final mark = a.currentSeq();
    a.append(cat, 'f:color', 'grey');
    await folderSync(a, dir.path);
    await folderSync(b, dir.path);
    expect(b.current(b.cats().single.id, 'f:color'), 'grey');
    final root = '${dir.path}/catlog-sync';
    final before = FolderManifest.parse(
        File('$root/${manifestName(a.deviceId)}').readAsBytesSync())!;
    // Going back removes the colour on a: the folder must follow.
    a.removeEntriesAfter(mark);
    await folderSync(a, dir.path);
    final after = FolderManifest.parse(
        File('$root/${manifestName(a.deviceId)}').readAsBytesSync())!;
    expect(after.generation, greaterThan(before.generation));
    expect(after.lines, lessThan(before.lines));
    // b reads the new generation from the start and applies nothing
    // wrong; its own copy of the colour stays, as ADR-0009 says.
    final again = await folderSync(b, dir.path);
    expect(again.entriesIn, 0);
    expect(b.cats().single.name, 'Miezi');
  });

  test('a segment the manifest announces but the folder lacks waits',
      () async {
    final folder = MemorySyncFolder();
    a.createCat('Miezi');
    await folderSyncIn(a, folder);
    // The manifest arrived ahead of its segment, as a cloud client may
    // deliver them.
    final segment = folder.dirs['']!.remove(segmentName(a.deviceId, 1))!;
    var result = await folderSyncIn(b, folder);
    expect(result.entriesIn, 0);
    expect(b.cats(), isEmpty);
    folder.dirs['']![segmentName(a.deviceId, 1)] = segment;
    result = await folderSyncIn(b, folder);
    expect(result.entriesIn, greaterThan(0));
    expect(b.cats().single.name, 'Miezi');
  });

  test('the whole-history file stays frozen until everyone has a manifest',
      () async {
    final folder = MemorySyncFolder();
    a.createCat('Miezi');
    // a wrote the old layout once; an old phone is in the folder too.
    final legacy = utf8.encode(
        a.entriesSince(const {}).map((e) => jsonEncode(e.toJson())).join('\n'));
    await folder.write('', '${a.deviceId}.jsonl2', legacy);
    await folder.ensure('keys');
    await folder.write('', 'old-phone.jsonl', utf8.encode(jsonEncode({
      'device': 'old-phone',
      'dseq': 1,
      'entity': 'cat:old',
      'field': r'$type',
      'value': 'cat',
      'date': '2026-01-01T00:00:00.000000Z',
      'author': 'carla',
      'recorded': '2026-01-01T00:00:00.000000Z',
    })));
    // Written yesterday: a phone that still needs its update.
    final now = DateTime.utc(2026, 1, 2);
    final result = await folderSyncIn(a, folder, now: now);
    expect(result.lagging, {'old-phone'});
    expect(folder.dirs['']!.keys, contains('${a.deviceId}.jsonl2'));
    expect(utf8.decode(folder.dirs['']!['${a.deviceId}.jsonl2']!),
        utf8.decode(legacy));
    // The old phone updates and writes a manifest: the frozen file goes.
    await folder.write('', manifestName('old-phone'), utf8.encode(jsonEncode(
        FolderManifest(generation: 0, private: false, vector: const {}, segments: const [])
            .toJson())));
    final later = await folderSyncIn(a, folder, now: now);
    expect(later.lagging, isEmpty);
    expect(folder.dirs['']!.keys, isNot(contains('${a.deviceId}.jsonl2')));
  });

  test('an install gone quiet for a week is not named, its file left alone',
      () async {
    final folder = MemorySyncFolder();
    a.createCat('Miezi');
    await folder.ensure('keys');
    await folder.write('', 'old-install.jsonl2', utf8.encode(jsonEncode({
      'device': 'old-install',
      'dseq': 1,
      'entity': 'clowder:gone',
      'field': r'$type',
      'value': 'clowder',
      'date': '2026-01-01T00:00:00.000000Z',
      'author': 'carla',
      'recorded': '2026-01-01T00:00:00.000000Z',
      'reminder': false,
    })));
    await folder.write('keys', 'old-install.json', utf8.encode('[]'));
    // A week on: what it knew is here, nobody is named, its files stay
    // where they are, and this device keeps no frozen file for it.
    final result =
        await folderSyncIn(a, folder, now: DateTime.utc(2026, 1, 9));
    expect(result.lagging, isEmpty);
    expect(a.versionVector()['old-install'], 1);
    expect(folder.dirs['']!.keys, contains('old-install.jsonl2'));
    expect(folder.dirs['keys']!.keys, contains('old-install.json'));
    expect(folder.dirs['']!.keys, isNot(contains('${a.deviceId}.jsonl2')));
    // A half-written manifest is a device on the new layout, not an old
    // one: nobody named, nothing read by its old file.
    await folder.write('', 'fresh.jsonl2', utf8.encode(''));
    await folder.write('', manifestName('fresh'), utf8.encode('{'));
    final again =
        await folderSyncIn(a, folder, now: DateTime.utc(2026, 1, 9));
    expect(again.lagging, isEmpty);
    expect(folder.dirs['']!.keys, contains('fresh.jsonl2'));
  });

  test('repeated sync is a no-op', () async {
    a.createCat('Miezi');
    await folderSync(a, dir.path);
    await folderSync(b, dir.path);
    final again = await folderSync(b, dir.path);
    expect(again.entriesIn, 0);
    expect(again.entriesOut, 0);
  });

  test('concurrent edits through the folder flag conflicts', () async {
    final cat = a.createCat('Original');
    await folderSync(a, dir.path);
    await folderSync(b, dir.path);
    final catOnB = b.cats().single.id;

    a.append(cat, Keys.name, 'Axel Name');
    b.append(catOnB, Keys.name, 'Friend Name');
    await folderSync(a, dir.path);
    await folderSync(b, dir.path);
    await folderSync(a, dir.path);

    expect(a.hasConflict(cat, Keys.name), isTrue);
    expect(b.hasConflict(catOnB, Keys.name), isTrue);
    expect(a.current(cat, Keys.name), b.current(catOnB, Keys.name));
  });

  test('deleted photos vanish from the folder once markers propagate', () async {
    final cat = a.createCat('Miezi');
    final hash = a.addImage(cat, CatalogStore.compressImage(jpeg(40, 40)));
    await folderSync(a, dir.path);
    final blob = File('${dir.path}/catlog-sync/blobs/$hash.jpg');
    expect(blob.existsSync(), isTrue);

    a.deleteImage(cat, hash);
    await folderSync(a, dir.path);
    expect(blob.existsSync(), isFalse);
  });

  test('a half-written peer file is skipped, the whole one lands', () async {
    a.createCat('Miezi');
    await folderSync(a, dir.path);
    File('${dir.path}/partial.jsonl').writeAsStringSync(
        '{"device":"partial","dseq":1,"entity":"cat:x","field":"name","va');
    final result = await folderSync(b, dir.path);
    expect(result.entriesIn, greaterThan(0));
    expect(b.cats().map((c) => c.name), contains('Miezi'));
  });
}
