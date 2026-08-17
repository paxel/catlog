import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';

const tileUserAgent = 'catlog/0.1 (+https://github.com/paxel/catlog)';

/// OSM tiles with a simple disk cache: once a tile was seen, it renders
/// offline forever (visited areas only — no bulk pre-download).
class DiskCachingTileProvider extends TileProvider {
  final Directory cacheDir;

  /// Memoized providers for cache hits. A fresh MemoryImage per request
  /// has no stable equality, so Flutter's image cache re-decoded every
  /// tile on every pan — memory climbed until Android killed the app.
  /// Same tile → same provider instance → real cache hits. Bounded:
  /// ~120 tiles ≈ a few MB of raw bytes.
  final _hits = <String, MemoryImage>{};

  DiskCachingTileProvider(this.cacheDir) {
    cacheDir.createSync(recursive: true);
  }

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final url = getTileUrl(coordinates, options);
    final file = File(
        '${cacheDir.path}/${coordinates.z}_${coordinates.x}_${coordinates.y}.png');
    // Cache hits load synchronously as MemoryImage — tiles are tiny,
    // and this is the one image pipeline that renders reliably both on
    // devices and under the widget-test clock (screenshot generator).
    if (file.existsSync()) {
      final key = file.path;
      final memoized = _hits.remove(key);
      if (memoized != null) {
        _hits[key] = memoized; // refresh LRU position
        return memoized;
      }
      final image = MemoryImage(file.readAsBytesSync());
      _hits[key] = image;
      if (_hits.length > 120) _hits.remove(_hits.keys.first);
      return image;
    }
    return _CachedTileImage(url, file);
  }
}

class _CachedTileImage extends ImageProvider<_CachedTileImage> {
  final String url;
  final File file;

  const _CachedTileImage(this.url, this.file);

  @override
  Future<_CachedTileImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(
          _CachedTileImage key, ImageDecoderCallback decode) =>
      OneFrameImageStreamCompleter(_load(decode));

  Future<ImageInfo> _load(ImageDecoderCallback decode) async {
    Uint8List bytes;
    if (file.existsSync()) {
      bytes = await file.readAsBytes();
    } else {
      final client = HttpClient()..userAgent = tileUserAgent;
      try {
        final req = await client.getUrl(Uri.parse(url));
        final res = await req.close();
        if (res.statusCode != 200) {
          throw NetworkImageLoadException(
              statusCode: res.statusCode, uri: Uri.parse(url));
        }
        final builder = BytesBuilder();
        await for (final chunk in res) {
          builder.add(chunk);
        }
        bytes = builder.takeBytes();
        await file.writeAsBytes(bytes);
      } finally {
        client.close(force: true);
      }
    }
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final codec = await decode(buffer);
    final frame = await codec.getNextFrame();
    return ImageInfo(image: frame.image);
  }

  @override
  bool operator ==(Object other) =>
      other is _CachedTileImage && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
