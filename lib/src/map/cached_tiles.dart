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

  /// Disk cap: the oldest tiles go when the folder grows past it —
  /// months of browsing a city otherwise pile up hundreds of MB that
  /// count against the app and are never trimmed.
  final int maxBytes;

  DiskCachingTileProvider(this.cacheDir, {this.maxBytes = 200 << 20}) {
    cacheDir.createSync(recursive: true);
    trimTileCache(cacheDir, maxBytes);
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

/// The largest tile response kept: OSM tiles are well under 100 KB.
const maxTileBytes = 2 << 20;

/// Deletes the least recently modified tiles until [dir] holds at most
/// [maxBytes]. Synchronous and cheap: one directory listing.
void trimTileCache(Directory dir, int maxBytes) {
  final files = <(File, FileStat)>[];
  var total = 0;
  for (final f in dir.listSync().whereType<File>()) {
    final stat = f.statSync();
    files.add((f, stat));
    total += stat.size;
  }
  if (total <= maxBytes) return;
  files.sort((a, b) => a.$2.modified.compareTo(b.$2.modified));
  for (final (f, stat) in files) {
    if (total <= maxBytes) break;
    try {
      f.deleteSync();
      total -= stat.size;
    } catch (_) {}
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
          // A tile is tens of KB; anything bigger is not a tile.
          if (builder.length > maxTileBytes) {
            throw NetworkImageLoadException(
                statusCode: HttpStatus.requestEntityTooLarge,
                uri: Uri.parse(url));
          }
        }
        bytes = builder.takeBytes();
      } finally {
        client.close(force: true);
      }
    }
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final codec = await decode(buffer);
    final frame = await codec.getNextFrame();
    // Cached only once it decoded: a bad answer is not kept for good.
    if (!file.existsSync()) await file.writeAsBytes(bytes);
    return ImageInfo(image: frame.image);
  }

  @override
  bool operator ==(Object other) =>
      other is _CachedTileImage && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
