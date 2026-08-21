import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void sync(CatalogStore from, CatalogStore to) => to.applyEntries(
    from.entriesSince(to.versionVector()),
    senderVector: from.versionVector());

/// Going back to an earlier moment: exact, and never destructive —
/// what it removes is written out first.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-savepoints');
    Directory('${dir.path}/mine').createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  String keepAt(String name) => '${dir.path}/$name.catsync';

  SavePoint mark({String cause = SaveCause.manual, String? label}) {
    final id = store.addSavePoint(cause: cause, label: label);
    return savePointsOf(store).firstWhere((p) => p.id == id);
  }

  test('going back puts every field back as it was', () {
    final cat = store.createCat('Miezi');
    store.append(cat, Keys.userField('color'), 'black');
    final point = mark();
    store.append(cat, Keys.userField('color'), 'white');
    store.createCat('Mausi');

    revertTo(store, point, keepAt: keepAt('undo'));

    expect(store.current(cat, Keys.userField('color')), 'black');
    expect(store.cats().map((c) => c.name), ['Miezi']);
  });

  test('what it removes is written out first, photos included', () {
    final point = mark();
    final cat = store.createCat('Miezi');
    store.addImage(cat, jpeg(20, 20));

    final path = revertTo(store, point, keepAt: keepAt('undo'));
    expect(File(path).existsSync(), isTrue);
    expect(store.cats(), isEmpty);

    // The file brings everything back, photo and all.
    importBundle(store, path);
    expect(store.cats().map((c) => c.name), ['Miezi']);
    expect(store.imageBytes(store.images(cat).single), isNotNull);
  });

  test('photos nothing refers to any more are gone', () {
    final point = mark();
    final cat = store.createCat('Miezi');
    store.addImage(cat, jpeg(20, 20));
    final hash = store.images(cat).single;

    revertTo(store, point, keepAt: keepAt('undo'));
    expect(store.imageBytes(hash), isNull);
  });

  test('a photo something else still uses is kept', () {
    final one = store.createCat('Miezi');
    store.addImage(one, jpeg(20, 20));
    final hash = store.images(one).single;
    final point = mark();
    final two = store.createCat('Mausi');
    store.addImage(two, store.imageBytes(hash)!);

    revertTo(store, point, keepAt: keepAt('undo'));
    expect(store.imageBytes(hash), isNotNull);
  });

  test('moments newer than the one chosen go with it', () {
    final first = mark(label: 'first');
    store.createCat('Miezi');
    mark(label: 'second');
    store.createCat('Mausi');

    revertTo(store, first, keepAt: keepAt('undo'));
    expect(savePointsOf(store).map((p) => p.label), ['first']);
  });

  test('the numbers used before going back are never handed out again',
      () {
    final point = mark();
    store.createCat('Miezi');
    final high = store.versionVector()[store.deviceId]!;

    revertTo(store, point, keepAt: keepAt('undo'));
    expect(store.versionVector()[store.deviceId], greaterThanOrEqualTo(high));

    final cat = store.createCat('Mausi');
    final fresh = store
        .entriesSince(const {})
        .where((e) => e.entity == cat)
        .map((e) => e.dseq);
    expect(fresh.every((d) => d > high), isTrue);
  });

  test('an undone import is not pushed straight back by the same peer',
      () {
    Directory('${dir.path}/theirs').createSync();
    final peer = CatalogStore.open('${dir.path}/theirs/catlog.db')
      ..author = 'Kathrin';
    addTearDown(peer.close);
    final theirs = peer.createCat('Fremdling');

    final before = store.currentSeq();
    sync(peer, store);
    final point = store.addSavePoint(cause: SaveCause.import, seq: before);
    expect(store.current(theirs, Keys.name), 'Fremdling');

    revertTo(store, savePointsOf(store).firstWhere((p) => p.id == point),
        keepAt: keepAt('undo'));
    expect(store.current(theirs, Keys.name), isNull);

    sync(peer, store);
    expect(store.current(theirs, Keys.name), isNull,
        reason: 'undo must not be a fight with the network');
  });

  test('importing the same material on purpose brings it back', () {
    Directory('${dir.path}/theirs').createSync();
    final peer = CatalogStore.open('${dir.path}/theirs/catlog.db')
      ..author = 'Kathrin';
    addTearDown(peer.close);
    final theirs = peer.createCat('Fremdling');
    final bundle = writeBundle(peer, keepAt('theirs'));

    final before = store.currentSeq();
    importBundle(store, bundle);
    final id = store.addSavePoint(cause: SaveCause.import, seq: before);
    revertTo(store, savePointsOf(store).firstWhere((p) => p.id == id),
        keepAt: keepAt('undo'));
    expect(store.current(theirs, Keys.name), isNull);

    importBundle(store, bundle);
    expect(store.current(theirs, Keys.name), 'Fremdling');
  });

  test('re-importing does not double the history', () {
    final cat = store.createCat('Miezi');
    final point = mark();
    store.append(cat, Keys.userField('color'), 'black');
    final path = revertTo(store, point, keepAt: keepAt('undo'));
    importBundle(store, path);
    importBundle(store, path);

    final colour = store
        .entriesSince(const {})
        .where((e) => e.field == Keys.userField('color'));
    expect(colour, hasLength(1));
  });

  test('what would be removed can be seen before it is', () {
    final cat = store.createCat('Miezi');
    final point = mark();
    store.append(cat, Keys.userField('color'), 'black');
    final other = store.createCat('Mausi');

    expect(changedSince(store, point), unorderedEquals([cat, other]));
    expect(store.cats(), hasLength(2), reason: 'nothing removed yet');
  });

  test('a moment that cannot be written out removes nothing', () {
    final point = mark();
    store.createCat('Miezi');
    expect(
        () => revertTo(store, point,
            keepAt: '${dir.path}/nope/deeper/undo.catsync'),
        throwsA(isA<FileSystemException>()));
    expect(store.cats().map((c) => c.name), ['Miezi']);
  });

  test('private entries come back too', () {
    final cat = store.createCat('Miezi');
    store.setPrivate(cat, true);
    final point = mark();
    store.append(cat, Keys.userField('color'), 'black');

    final path = revertTo(store, point, keepAt: keepAt('undo'));
    importBundle(store, path);
    expect(store.current(cat, Keys.userField('color')), 'black');
    expect(store.isPrivate(cat), isTrue);
  });
}
