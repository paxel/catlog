import 'dart:io';

import 'package:catlog/src/map/cached_tiles.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// A tile dropped mid-pan (#100): the listener leaves before the
/// download lands; the arriving image must not hit a disposed stream.
void main() {
  testWidgets('a tile abandoned mid-pan does not crash when it arrives',
      (tester) async {
    // flutter_test mocks HttpClient with a 400-for-everything stub;
    // this test runs a real localhost server instead.
    final overrides = HttpOverrides.current;
    HttpOverrides.global = null;
    addTearDown(() => HttpOverrides.global = overrides);
    final dir = Directory.systemTemp.createTempSync('catlog_tiles');
    addTearDown(() => dir.deleteSync(recursive: true));
    final png = img.encodePng(img.Image(width: 1, height: 1));
    await tester.runAsync(() async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((req) async {
        // The listener below leaves synchronously; even an instant
        // answer arrives after it is gone.
        req.response.headers.contentType = ContentType('image', 'png');
        req.response.add(png);
        await req.response.close();
      });
      final provider = DiskCachingTileProvider(dir);
      final image = provider.getImage(
          const TileCoordinates(1, 2, 3),
          TileLayer(
              urlTemplate: 'http://127.0.0.1:${server.port}/{z}/{x}/{y}.png'));
      // Straight to loadImage: in the app the image cache lets go of a
      // tile under pan pressure, and the stream stands alone like this.
      final completer = (image as dynamic).loadImage(
              image, PaintingBinding.instance.instantiateImageCodecWithSize)
          as ImageStreamCompleter;
      final listener = ImageStreamListener((_, _) {});
      completer.addListener(listener);
      // The map scrolled on: the tile widget is gone.
      completer.removeListener(listener);
      await Future<void>.delayed(const Duration(milliseconds: 800));
    });
    expect(tester.takeException(), isNull);
  });
}
