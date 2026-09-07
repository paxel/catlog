import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// The folder sync through a [SyncFolder] that is not a path: what
/// Android's document access gets. Same files, same outcome.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a;
  late CatalogStore b;
  late MemorySyncFolder folder;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
    folder = MemorySyncFolder();
  });

  tearDown(() {
    a.close();
    b.close();
  });

  test('two stores converge; keys travel; the layout is the known one',
      () async {
    final cat = a.createCat('Miezi');
    b.createCat('Wanderer');
    await folderSyncIn(a, folder);
    expect(folder.dirs.keys, containsAll(['', 'blobs', 'keys']));
    expect(folder.dirs['']!.keys, contains('${a.deviceId}.jsonl'));
    expect(folder.dirs['keys']!.keys, contains('${a.deviceId}.json'));

    final result = await folderSyncIn(b, folder);
    expect(result.report.newKeys.single.record.device, a.deviceId);
    expect(b.current(cat, 'name'), 'Miezi');
    await folderSyncIn(a, folder);
    expect(a.cats().length, 2);
    expect(a.pinnedKey(b.deviceId), isNotNull);
    // Own files only, nothing written under the other's name twice.
    expect(folder.dirs['']!.keys.where((n) => n.endsWith('.jsonl')).length, 2);
  });

  test('a forged line in a partner file is refused', () async {
    final cat = a.createCat('Miezi');
    await folderSyncIn(a, folder);
    await folderSyncIn(b, folder);
    final own = '${a.deviceId}.jsonl';
    final lines = utf8.decode(folder.dirs['']![own]!).split('\n');
    final last = (jsonDecode(lines.last) as Map).cast<String, dynamic>();
    lines.add(jsonEncode({...last, 'dseq': last['dseq'] + 1, 'value': 'x'}));
    await folder.write('', own, utf8.encode(lines.join('\n')));
    final again = await folderSyncIn(b, folder);
    expect(again.report.refused[('anna', a.deviceId)], 1);
    expect(b.current(cat, 'name'), 'Miezi');
  });

  test('photos go out, come in, and leave once deleted everywhere', () async {
    final cat = a.createCat('Miezi');
    final hash = a.addImage(cat, Uint8List.fromList(List<int>.filled(200, 7)));
    await folderSyncIn(a, folder);
    expect(folder.dirs['blobs']!.keys, contains('$hash.jpg'));
    final result = await folderSyncIn(b, folder);
    expect(result.blobsIn, 1);
    expect(b.imageBytes(hash), isNotNull);
    a.deleteImage(cat, hash);
    await folderSyncIn(a, folder);
    expect(folder.dirs['blobs']!.keys, isNot(contains('$hash.jpg')));
  });

  test('a half-written partner file is skipped this round', () async {
    a.createCat('Miezi');
    await folderSyncIn(a, folder);
    await folder.write('', 'broken.jsonl', utf8.encode('{"device": "x", '));
    final result = await folderSyncIn(b, folder);
    expect(result.entriesIn, greaterThan(0));
    expect(b.cats().single.name, 'Miezi');
  });
}
