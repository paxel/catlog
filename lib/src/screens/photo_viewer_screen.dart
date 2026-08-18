import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Full-screen gallery: swipe through a cat's photos, pinch to zoom.
/// Tap on a thumbnail lands here; the action menu stays on long-press.
class PhotoViewerScreen extends StatefulWidget {
  final CatalogStore store;
  final List<String> hashes;
  final int initialIndex;

  /// Used in shared photos' file names.
  final String name;

  const PhotoViewerScreen(
      {super.key,
      required this.store,
      required this.hashes,
      required this.initialIndex,
      required this.name});

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late final PageController _pages =
      PageController(initialPage: widget.initialIndex);
  late int _current = widget.initialIndex;

  /// Bytes per hash, fetched once: a fresh Uint8List on every rebuild
  /// would give MemoryImage a new cache key — the image re-decodes and
  /// the page flickers on every swipe (the counter rebuild).
  final _bytes = <String, Uint8List?>{};

  Uint8List? _bytesFor(String hash) =>
      _bytes.putIfAbsent(hash, () => widget.store.imageBytes(hash));

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_current + 1} / ${widget.hashes.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              final bytes = _bytesFor(widget.hashes[_current]);
              if (bytes == null) return;
              Share.shareXFiles([
                XFile.fromData(bytes,
                    mimeType: 'image/jpeg',
                    name: '${widget.name}-${_current + 1}.jpg'),
              ]);
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pages,
        itemCount: widget.hashes.length,
        onPageChanged: (i) => setState(() => _current = i),
        itemBuilder: (context, i) {
          final bytes = _bytesFor(widget.hashes[i]);
          if (bytes == null) return const SizedBox.shrink();
          return InteractiveViewer(
            maxScale: 8,
            child: Center(
                child: Image.memory(bytes,
                    fit: BoxFit.contain, gaplessPlayback: true)),
          );
        },
      ),
    );
  }
}
