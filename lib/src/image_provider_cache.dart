import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/painting.dart';

/// Stable ImageProvider per photo hash. A fresh MemoryImage on every
/// rebuild gets a new engine cache key: images re-decode constantly, and
/// an entry evicted while its decode is still in flight crashes with
/// "Bad state: Stream has been disposed" (#44). Hashes are
/// content-addressed, so entries never go stale; the LRU only bounds the
/// compressed bytes kept in memory.
final _providers = <String, MemoryImage>{};
const _maxEntries = 16;

MemoryImage? imageProviderFor(CatalogStore store, String hash) {
  final cached = _providers.remove(hash);
  if (cached != null) {
    _providers[hash] = cached; // re-insert to refresh LRU order
    return cached;
  }
  final bytes = store.imageBytes(hash);
  if (bytes == null) return null;
  final provider = MemoryImage(bytes);
  _providers[hash] = provider;
  while (_providers.length > _maxEntries) {
    _providers.remove(_providers.keys.first);
  }
  return provider;
}
