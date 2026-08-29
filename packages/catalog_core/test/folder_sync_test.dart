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

  test('two stores converge through the folder', () {
    final home = a.createClowder('Home');
    final cat = a.createCat('Miezi', clowderId: home);
    a.addImage(cat, CatalogStore.compressImage(jpeg(50, 50)));
    b.createCat('Wanderer');

    folderSync(a, dir.path); // a publishes
    folderSync(b, dir.path); // b imports a, publishes itself
    final second = folderSync(a, dir.path); // a imports b

    expect(second.entriesIn, greaterThan(0));
    expect(a.cats().length, 2);
    expect(b.cats().length, 2);
    expect(b.clowders().single.name, 'Home');
    expect(b.imageBytes(b.images(b.searchCats('Miezi').single.id).single),
        isNotNull);
  });

  test('only the own file is ever written', () {
    a.createCat('Miezi');
    folderSync(a, dir.path);
    folderSync(b, dir.path);
    // No reminder was ever used, so the file keeps the pre-1.0.0 name.
    final aFile = File('${dir.path}/catlog-sync/${a.deviceId}.jsonl');
    final before = aFile.readAsStringSync();
    folderSync(b, dir.path);
    expect(aFile.readAsStringSync(), before);
  });

  test('repeated sync is a no-op', () {
    a.createCat('Miezi');
    folderSync(a, dir.path);
    folderSync(b, dir.path);
    final again = folderSync(b, dir.path);
    expect(again.entriesIn, 0);
    expect(again.entriesOut, 0);
  });

  test('concurrent edits through the folder flag conflicts', () {
    final cat = a.createCat('Original');
    folderSync(a, dir.path);
    folderSync(b, dir.path);
    final catOnB = b.cats().single.id;

    a.append(cat, Keys.name, 'Axel Name');
    b.append(catOnB, Keys.name, 'Friend Name');
    folderSync(a, dir.path);
    folderSync(b, dir.path);
    folderSync(a, dir.path);

    expect(a.hasConflict(cat, Keys.name), isTrue);
    expect(b.hasConflict(catOnB, Keys.name), isTrue);
    expect(a.current(cat, Keys.name), b.current(catOnB, Keys.name));
  });

  test('deleted photos vanish from the folder once markers propagate', () {
    final cat = a.createCat('Miezi');
    final hash = a.addImage(cat, CatalogStore.compressImage(jpeg(40, 40)));
    folderSync(a, dir.path);
    final blob = File('${dir.path}/catlog-sync/blobs/$hash.jpg');
    expect(blob.existsSync(), isTrue);

    a.deleteImage(cat, hash);
    folderSync(a, dir.path);
    expect(blob.existsSync(), isFalse);
  });

  test('a half-written peer file is skipped, the whole one lands', () {
    a.createCat('Miezi');
    folderSync(a, dir.path);
    File('${dir.path}/partial.jsonl').writeAsStringSync(
        '{"device":"partial","dseq":1,"entity":"cat:x","field":"name","va');
    final result = folderSync(b, dir.path);
    expect(result.entriesIn, greaterThan(0));
    expect(b.cats().map((c) => c.name), contains('Miezi'));
  });
}
