import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Stable ImageProvider per photo hash. A fresh MemoryImage on every
/// rebuild gets a new engine cache key: images re-decode constantly, and
/// an entry evicted while its decode is still in flight crashes with
/// "Bad state: Stream has been disposed" (#44). Two things keep the key
/// stable: this LRU hands out the same provider while it holds it, and
/// [CatalogImage] compares by hash, so a provider recreated after an
/// eviction is still the same key to the engine — the LRU only bounds
/// the compressed bytes kept in memory, never the identity.
final _providers = <String, CatalogImage>{};
const _maxEntries = 64;
const _maxBytes = 24 << 20;
var _bytesHeld = 0;

CatalogImage? imageProviderFor(CatalogStore store, String hash) {
  final cached = _providers.remove(hash);
  if (cached != null) {
    _providers[hash] = cached; // re-insert to refresh LRU order
    return cached;
  }
  final bytes = store.imageBytes(hash);
  if (bytes == null) return null;
  final provider = CatalogImage(hash, bytes);
  _providers[hash] = provider;
  _bytesHeld += bytes.length;
  while (_providers.length > _maxEntries ||
      (_bytesHeld > _maxBytes && _providers.length > 1)) {
    final evicted = _providers.remove(_providers.keys.first)!;
    _bytesHeld -= evicted.bytes.length;
  }
  return provider;
}

/// A photo by its content hash: equal whenever the hash is, whatever
/// instance holds the bytes.
@immutable
class CatalogImage extends ImageProvider<CatalogImage> {
  final String hash;
  final Uint8List bytes;

  const CatalogImage(this.hash, this.bytes);

  @override
  Future<CatalogImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<CatalogImage>(this);

  @override
  ImageStreamCompleter loadImage(
          CatalogImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(
        codec: _decode(decode),
        scale: 1.0,
        debugLabel: 'CatalogImage($hash)',
      );

  Future<ui.Codec> _decode(ImageDecoderCallback decode) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    return decode(buffer);
  }

  @override
  bool operator ==(Object other) =>
      other is CatalogImage && other.hash == hash;

  @override
  int get hashCode => hash.hashCode;

  @override
  String toString() => 'CatalogImage($hash)';
}
