import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

/// Photos leave the phone without camera metadata: the strip drops the
/// Exif segment and nothing else, the stored photos are rewritten once,
/// and a partner receives the clean bytes.
Uint8List withExif() {
  final im = img.Image(width: 8, height: 6);
  im.exif.imageIfd['Make'] = 'cam';
  im.exif.gpsIfd[0x0001] = img.IfdValueAscii('N');
  return Uint8List.fromList(img.encodeJpg(im));
}

bool hasApp1(Uint8List b) {
  for (var i = 2; i + 3 < b.length && b[i] == 0xFF; i++) {
    if (b[i + 1] == 0xE1) return true;
    if (b[i + 1] == 0xDA) break;
    i += 1 + ((b[i + 2] << 8) | b[i + 3]);
  }
  return false;
}

void main() {
  setUpAll(useSystemSqlite);

  test('the strip drops the Exif segment and keeps the picture', () {
    final raw = withExif();
    expect(hasApp1(raw), isTrue);
    final clean = stripJpegMetadata(raw);
    expect(hasApp1(clean), isFalse);
    expect(clean.length, lessThan(raw.length));
    expect(img.decodeJpg(clean)!.width, 8);
    // Nothing to drop: the same object comes back.
    expect(identical(stripJpegMetadata(clean), clean), isTrue);
    expect(hasJpegMetadata(raw), isTrue);
    expect(hasJpegMetadata(clean), isFalse);
    // Not a JPEG: untouched.
    final other = Uint8List.fromList([1, 2, 3, 4, 5]);
    expect(identical(stripJpegMetadata(other), other), isTrue);
  });

  test('compressed photos come out without metadata', () {
    expect(hasJpegMetadata(CatalogStore.compressImage(withExif())), isFalse);
  });

  test('stored photos are rewritten once, the profile follows', () {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    final old = store.addImage(cat, withExif());
    store.setProfileImage(cat, old);
    expect(stripPhotoLocations(store), 1);
    final now = store.images(cat);
    expect(now, hasLength(1));
    expect(now.single, isNot(old));
    expect(hasJpegMetadata(store.imageBytes(now.single)!), isFalse);
    expect(store.profileImage(cat), now.single);
    expect(store.imageBytes(old), isNull);
    // Nothing left to do.
    expect(stripPhotoLocations(store), 0);
  });

  test('a partner through the folder gets the clean photo', () async {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'ben';
    addTearDown(a.close);
    addTearDown(b.close);
    final cat = a.createCat('Miezi');
    a.addImage(cat, withExif());
    stripPhotoLocations(a);
    final folder = MemorySyncFolder();
    await folderSyncIn(a, folder, catalog: 'farm');
    final r = await folderSyncIn(b, folder, catalog: 'farm');
    expect(r.blobsIn, 1);
    expect(r.blobsMissing, 0);
    expect(hasJpegMetadata(b.imageBytes(b.images(cat).single)!), isFalse);
  });
}
