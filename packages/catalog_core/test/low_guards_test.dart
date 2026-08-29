import 'dart:typed_data';

import 'package:archive/archive.dart' show getCrc32;
import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Small guards: pair codes stay on the local network, and an image
/// whose header claims a wall of pixels is refused before decoding.
void main() {
  setUpAll(useSystemSqlite);

  test('only local-network addresses are pair-code hosts', () {
    expect(isPrivateHost('192.168.1.20'), isTrue);
    expect(isPrivateHost('10.0.0.5'), isTrue);
    expect(isPrivateHost('172.16.4.4'), isTrue);
    expect(isPrivateHost('169.254.1.1'), isTrue);
    expect(isPrivateHost('127.0.0.1'), isTrue);
    expect(isPrivateHost('8.8.8.8'), isFalse);
    expect(isPrivateHost('172.32.0.1'), isFalse);
    expect(isPrivateHost('not.an.ip'), isFalse);
  });

  test('a header claiming 30000x30000 is too large, a real photo is not',
      () {
    // PNG signature + IHDR declaring 30000x30000, no pixel data.
    final ihdr = [
      73, 72, 68, 82, // IHDR
      0, 0, 0x75, 0x30, 0, 0, 0x75, 0x30, // 30000 x 30000
      8, 6, 0, 0, 0, // bit depth, colour type, ...
    ];
    final crc = getCrc32(ihdr);
    final huge = Uint8List.fromList([
      137, 80, 78, 71, 13, 10, 26, 10, // signature
      0, 0, 0, 13, ...ihdr,
      (crc >> 24) & 0xff, (crc >> 16) & 0xff, (crc >> 8) & 0xff, crc & 0xff,
      0, 0, 0, 0, 73, 69, 78, 68, 0xae, 0x42, 0x60, 0x82, // IEND
    ]);
    expect(CatalogStore.imageTooLarge(huge), isTrue);
    expect(() => CatalogStore.compressImage(huge), throwsFormatException);
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    store.putBlob('a' * 64, huge);
    expect(store.imageBytes('a' * 64), isNull);
    expect(CatalogStore.imageTooLarge(Uint8List.fromList([1, 2, 3])),
        isFalse);
  });
}
