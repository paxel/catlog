import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void sync(CatalogStore from, CatalogStore to) => to.applyEntries(
    from.entriesSince(to.versionVector()),
    senderVector: from.versionVector());

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a, b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  test('hard delete leaves no entries or blobs; outbound stays clean', () {
    final cat = b.createCat('Poison');
    b.addImage(cat, CatalogStore.compressImage(jpeg(40, 40)));
    sync(b, a);
    for (final hash in a.missingBlobs()) {
      a.putBlob(hash, b.imageBytes(hash)!);
    }
    expect(a.cats(), isNotEmpty);

    final removed = a.hardDeleteAuthor('bob');
    expect(a.cats(), isEmpty);
    expect(removed, isNotEmpty);
    expect(a.imageBytes(removed.single), isNull);
    expect(
        a.entriesSince(const {}, includePrivate: true)
            .where((e) => e.author == 'bob'),
        isEmpty);
  });

  test('banned author is received-and-discarded, vector advances', () {
    a.ban(author: 'bob');
    final cat = b.createCat('Poison');
    sync(b, a);
    expect(a.cats(), isEmpty);
    // Vector still covers bob's device: nothing re-offered next time.
    expect(b.entriesSince(a.versionVector()), isEmpty);
    expect(cat, isNotEmpty);
  });

  test('banned blob hash blocks the bytes under any author', () {
    final bytes = CatalogStore.compressImage(jpeg(40, 40));
    final cat = b.createCat('Poison');
    final hash = b.addImage(cat, bytes);
    a.ban(blobHash: hash);
    sync(b, a);
    a.putBlob(hash, b.imageBytes(hash)!);
    expect(a.imageBytes(hash), isNull);
  });

  test('bans list and reverse', () {
    a.ban(author: 'bob', blobHash: 'deadbeef');
    expect(a.bans(), containsAll([('author', 'bob'), ('blob', 'deadbeef')]));
    a.unban(author: 'bob');
    expect(a.bans(), [('blob', 'deadbeef')]);
    a.unban(blobHash: 'deadbeef');
    expect(a.bans(), isEmpty);
  });
}
