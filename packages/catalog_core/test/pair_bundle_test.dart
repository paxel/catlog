import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void main() {
  setUpAll(useSystemSqlite);

  group('pair code', () {
    test('IPv4 round trip, 15 chars grouped', () {
      final code = encodePairCode('192.168.0.12', 38472, '582931');
      expect(code.replaceAll('_', '').length, 15);
      expect(code.split('_').map((g) => g.length), everyElement(5));
      final info = decodePairCode(code)!;
      expect(info.host, '192.168.0.12');
      expect(info.port, 38472);
      expect(info.pin, '582931');
    });

    test('typing forgiveness: case, separators, confusables', () {
      final code = encodePairCode('10.0.0.1', 1234, '000042');
      final sloppy = code
          .toUpperCase()
          .replaceAll('_', ' ')
          .replaceAll('1', 'l')
          .replaceAll('0', 'O');
      final info = decodePairCode(sloppy)!;
      expect(info.host, '10.0.0.1');
      expect(info.pin, '000042');
    });

    test('IPv6 round trip uses the long form code', () {
      final code = encodePairCode('fe80::1c2d:3e4f:5a6b:7c8d', 40000, '123456');
      expect(code.replaceAll('_', '').length, 34);
      final info = decodePairCode(code)!;
      expect(info.port, 40000);
      expect(InternetAddress(info.host).rawAddress.length, 16);
    });

    test('garbage is rejected, not crashed on', () {
      expect(decodePairCode('hello kitty'), isNull);
      expect(decodePairCode(''), isNull);
      expect(decodePairCode('zzzzz_zzzzz'), isNull);
    });
  });

  group('bundle', () {
    test('two stores converge through a bundle file', () {
      final dir = Directory.systemTemp.createTempSync('catlog_bundle');
      addTearDown(() => dir.deleteSync(recursive: true));
      final a = CatalogStore.inMemory()..author = 'axel';
      final b = CatalogStore.inMemory()..author = 'friend';
      addTearDown(a.close);
      addTearDown(b.close);

      final home = a.createClowder('Home');
      final cat = a.createCat('Miezi', clowderId: home);
      a.addImage(cat, CatalogStore.compressImage(jpeg(40, 40)));

      final path = writeBundle(a, '${dir.path}/a.catsync');
      final result = importBundle(b, path);
      expect(result.entriesIn, greaterThan(0));
      expect(result.blobsIn, 1);
      expect(b.cats().single.name, 'Miezi');
      expect(b.imageBytes(b.images(b.cats().single.id).single), isNotNull);

      // Re-import is a no-op.
      final again = importBundle(b, path);
      expect(again.entriesIn, 0);
    });

    test('concurrent edits through bundles flag a conflict', () {
      final dir = Directory.systemTemp.createTempSync('catlog_bundle2');
      addTearDown(() => dir.deleteSync(recursive: true));
      final a = CatalogStore.inMemory()..author = 'axel';
      final b = CatalogStore.inMemory()..author = 'friend';
      addTearDown(a.close);
      addTearDown(b.close);

      final cat = a.createCat('Original');
      importBundle(b, writeBundle(a, '${dir.path}/1.catsync'));
      a.append(cat, Keys.name, 'Axel Name');
      b.append(b.cats().single.id, Keys.name, 'Friend Name');
      importBundle(a, writeBundle(b, '${dir.path}/2.catsync'));

      expect(a.hasConflict(cat, Keys.name), isTrue);
    });
  });
}
