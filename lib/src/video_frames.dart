import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'l10n.dart';

/// Sharpness of a frame: variance of a Laplacian over the grayscale
/// image — blur flattens edges, so sharp frames score higher (#41).
/// Downscaled first; the score only ranks, absolute values mean nothing.
double sharpnessScore(Uint8List jpegBytes) {
  var decoded = img.decodeImage(jpegBytes);
  if (decoded == null) return 0;
  decoded = img.copyResize(decoded, width: 160);
  final gray = img.grayscale(decoded);
  final w = gray.width, h = gray.height;
  final lum = List.generate(
      h, (y) => List.generate(w, (x) => gray.getPixel(x, y).r.toDouble()));
  var sum = 0.0, sumSq = 0.0;
  final n = (w - 2) * (h - 2);
  if (n <= 0) return 0;
  for (var y = 1; y < h - 1; y++) {
    for (var x = 1; x < w - 1; x++) {
      final lap = lum[y][x - 1] +
          lum[y][x + 1] +
          lum[y - 1][x] +
          lum[y + 1][x] -
          4 * lum[y][x];
      sum += lap;
      sumSq += lap * lap;
    }
  }
  final mean = sum / n;
  return sumSq / n - mean * mean;
}

/// Picks the [keep] sharpest frames, at most one per second of video,
/// so the suggestions spread over the clip instead of clustering.
List<int> suggestFrameIndexes(List<(int, Uint8List)> frames,
    {int keep = 4}) {
  final scored = [
    for (var i = 0; i < frames.length; i++)
      (i, frames[i].$1, sharpnessScore(frames[i].$2))
  ]..sort((a, b) => b.$3.compareTo(a.$3));
  final picked = <int>[];
  final usedSeconds = <int>{};
  for (final (i, ms, _) in scored) {
    if (picked.length >= keep) break;
    if (usedSeconds.add(ms ~/ 1000)) picked.add(i);
  }
  picked.sort();
  return picked;
}

/// Frame picker (#41): auto-suggested sharp frames plus a manual
/// scrubber; the kept frames become ordinary photos, the video itself
/// is never stored. Pops the kept frames as JPEG bytes.
class VideoFramesScreen extends StatefulWidget {
  /// Total clip length.
  final Duration duration;

  /// Extracts the frame at a position, at preview size — what the
  /// picker holds and shows; null when extraction fails.
  final Future<Uint8List?> Function(int ms) extractFrame;

  /// Extracts the frame at full photo size — asked only for the frames
  /// the keeper keeps, when the picker closes. A dozen full-size
  /// frames in memory at once killed the app on iPhones. Null uses
  /// [extractFrame].
  final Future<Uint8List?> Function(int ms)? extractFull;

  /// How many positions the auto pass samples across the clip.
  final int samples;

  const VideoFramesScreen(
      {super.key,
      required this.duration,
      required this.extractFrame,
      this.extractFull,
      this.samples = 12});

  @override
  State<VideoFramesScreen> createState() => _VideoFramesScreenState();
}

class _VideoFramesScreenState extends State<VideoFramesScreen> {
  /// All extracted frames by position, suggestions and scrubbed grabs.
  final _frames = <int, Uint8List>{};
  final _kept = <int>{};
  double _scrub = 0;
  Uint8List? _preview;
  int? _previewMs;
  bool _busy = true;

  @override
  void initState() {
    super.initState();
    _autoSuggest();
  }

  Future<void> _autoSuggest() async {
    final total = widget.duration.inMilliseconds;
    final sampled = <(int, Uint8List)>[];
    for (var i = 0; i < widget.samples; i++) {
      final ms = (total * (i + 1)) ~/ (widget.samples + 1);
      final bytes = await widget.extractFrame(ms);
      if (bytes != null) sampled.add((ms, bytes));
    }
    if (!mounted) return;
    final picks = suggestFrameIndexes(sampled);
    setState(() {
      for (final i in picks) {
        _frames[sampled[i].$1] = sampled[i].$2;
      }
      _busy = false;
    });
  }

  /// Live preview while scrubbing: extracting every drag tick is too
  /// heavy, so the frame loads when the finger settles.
  /// The kept frames at photo size, one at a time, then out.
  Future<void> _keepAndClose() async {
    setState(() => _busy = true);
    final full = widget.extractFull ?? widget.extractFrame;
    final kept = <Uint8List>[];
    for (final ms in _kept.toList()..sort()) {
      kept.add(await full(ms) ?? _frames[ms]!);
    }
    if (!mounted) return;
    Navigator.of(context).pop(kept);
  }

  Future<void> _previewAtScrub() async {
    final ms = _scrub.round();
    final bytes = await widget.extractFrame(ms);
    if (bytes != null && mounted) {
      setState(() {
        _preview = bytes;
        _previewMs = ms;
      });
    }
  }

  Future<void> _grabAtScrub() async {
    final ms = _scrub.round();
    final bytes =
        _previewMs == ms ? _preview : await widget.extractFrame(ms);
    if (bytes != null && mounted) {
      setState(() {
        _frames[ms] = bytes;
        _kept.add(ms);
        _preview = bytes;
        _previewMs = ms;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final positions = _frames.keys.toList()..sort();
    return Scaffold(
      appBar: AppBar(title: Text(t.pickFramesTitle), actions: [
        IconButton(
          icon: const Icon(Icons.check),
          tooltip: t.save,
          onPressed: _kept.isEmpty || _busy ? null : _keepAndClose,
        ),
      ]),
      body: _busy
          ? const Center(child: CircularProgressIndicator())
          : ListView(padding: const EdgeInsets.all(16), children: [
              Text(t.suggestedFrames,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  for (final ms in positions)
                    GestureDetector(
                      onTap: () => setState(() {
                        if (!_kept.remove(ms)) _kept.add(ms);
                      }),
                      child: Stack(fit: StackFit.expand, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(_frames[ms]!,
                              fit: BoxFit.cover,
                              // Decoded at tile size, not photo size.
                              cacheWidth: 320,
                              gaplessPlayback: true),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              _kept.contains(ms)
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ),
                ],
              ),
              const Divider(height: 32),
              Text(t.scrubFrames,
                  style: Theme.of(context).textTheme.titleMedium),
              if (_preview != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(_preview!,
                        key: const ValueKey('scrub-preview'),
                        gaplessPlayback: true,
                        cacheHeight: 320,
                        height: 160,
                        fit: BoxFit.contain),
                  ),
                ),
              Slider(
                value: _scrub.clamp(
                    0, widget.duration.inMilliseconds.toDouble()),
                max: widget.duration.inMilliseconds.toDouble(),
                onChanged: (v) => setState(() => _scrub = v),
                onChangeEnd: (_) => _previewAtScrub(),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.add_a_photo),
                label: Text(t.keepThisFrame),
                onPressed: _grabAtScrub,
              ),
            ]),
    );
  }
}
