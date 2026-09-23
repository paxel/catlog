import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'l10n.dart';

/// What the frame picker needs of a player: the picture, the clock,
/// seeking and playing. The real one wraps the video player; a test
/// brings its own.
abstract class FramePlayer implements Listenable {
  Duration get duration;
  Duration get position;
  bool get playing;

  /// Frames per second, for the one-frame step; 30 when the clip does
  /// not say.
  double get fps;

  /// The picture, at the clip's aspect ratio.
  Widget build(BuildContext context);
  Future<void> seekTo(Duration at);
  Future<void> play();
  Future<void> pause();
}

/// Frame picker (#41), a page of its own: the video plays, pauses and
/// seeks under the finger, steps by a frame, a second or ten, and "Keep
/// this frame" grabs the exact frame at the player's position. The
/// kept frames line up at the bottom and become ordinary photos; the
/// video itself is never stored. Pops the kept frames as JPEG bytes.
class VideoFramesScreen extends StatefulWidget {
  final FramePlayer player;

  /// Extracts the frame at a position, at preview size — what the
  /// strip at the bottom shows; null when extraction fails.
  final Future<Uint8List?> Function(int ms) extractFrame;

  /// Extracts the frame at full photo size — asked only for the frames
  /// the keeper keeps, when the picker closes. A dozen full-size
  /// frames in memory at once killed the app on iPhones. Null uses
  /// [extractFrame].
  final Future<Uint8List?> Function(int ms)? extractFull;

  const VideoFramesScreen({
    super.key,
    required this.player,
    required this.extractFrame,
    this.extractFull,
  });

  @override
  State<VideoFramesScreen> createState() => _VideoFramesScreenState();
}

class _VideoFramesScreenState extends State<VideoFramesScreen> {
  /// The kept frames by position, at preview size.
  final _kept = <int, Uint8List>{};

  /// One provider per frame, kept for the screen's life: a fresh
  /// `MemoryImage` on every rebuild is a new stream, and a decode that
  /// finishes after its widget was swapped throws (#44).
  final _tiles = <int, ImageProvider>{};

  /// The slider's own position while the finger is on it.
  double? _drag;
  DateTime _lastSeek = DateTime.fromMillisecondsSinceEpoch(0);
  bool _busy = false;
  bool _grabbing = false;

  FramePlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    player.addListener(_changed);
  }

  @override
  void dispose() {
    player.removeListener(_changed);
    super.dispose();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  ImageProvider _tile(int ms) =>
      _tiles[ms] ??= ResizeImage(MemoryImage(_kept[ms]!), width: 320);

  Duration get _frame =>
      Duration(microseconds: (1000000 / player.fps).round());

  /// A step: the player pauses and moves; the picture follows.
  Future<void> _step(Duration by) async {
    await player.pause();
    var at = player.position + by;
    if (at < Duration.zero) at = Duration.zero;
    if (at > player.duration) at = player.duration;
    await player.seekTo(at);
  }

  Future<void> _togglePlay() =>
      player.playing ? player.pause() : player.play();

  /// The slider seeks as the finger moves, a few times a frame at most;
  /// the finger's rest lands exactly.
  Future<void> _scrub(double ms, {bool settle = false}) async {
    final now = DateTime.now();
    if (!settle && now.difference(_lastSeek).inMilliseconds < 60) return;
    _lastSeek = now;
    await player.seekTo(Duration(milliseconds: ms.round()));
  }

  Future<void> _keep() async {
    if (_grabbing) return;
    await player.pause();
    final ms = player.position.inMilliseconds;
    setState(() => _grabbing = true);
    final bytes = await widget.extractFrame(ms);
    if (!mounted) return;
    setState(() {
      _grabbing = false;
      if (bytes != null) _kept[ms] = bytes;
    });
  }

  /// The kept frames at photo size, one at a time, then out.
  Future<void> _keepAndClose() async {
    setState(() => _busy = true);
    final full = widget.extractFull ?? widget.extractFrame;
    final kept = <Uint8List>[];
    for (final ms in _kept.keys.toList()..sort()) {
      kept.add(await full(ms) ?? _kept[ms]!);
    }
    if (!mounted) return;
    Navigator.of(context).pop(kept);
  }

  String _clock(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    final tenths = (d.inMilliseconds % 1000) ~/ 100;
    return '$m:${s.toString().padLeft(2, '0')}.$tenths';
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final total = player.duration.inMilliseconds.toDouble();
    final shown = (_drag ?? player.position.inMilliseconds.toDouble())
        .clamp(0.0, total);
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
          : Column(children: [
              Expanded(child: Center(child: player.build(context))),
              Slider(
                value: shown,
                max: total,
                onChangeStart: (_) => player.pause(),
                onChanged: (v) {
                  setState(() => _drag = v);
                  _scrub(v);
                },
                onChangeEnd: (v) {
                  setState(() => _drag = null);
                  _scrub(v, settle: true);
                },
              ),
              Text(
                '${_clock(Duration(milliseconds: shown.round()))} / '
                '${_clock(player.duration)}',
                key: const ValueKey('clock'),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _StepButton(
                  icon: Icons.fast_rewind,
                  tooltip: t.secondBack,
                  onStep: () => _step(const Duration(seconds: -1)),
                ),
                _StepButton(
                  icon: Icons.navigate_before,
                  tooltip: t.frameBack,
                  onStep: () => _step(-_frame),
                ),
                IconButton.filled(
                  iconSize: 36,
                  icon: Icon(player.playing ? Icons.pause : Icons.play_arrow),
                  tooltip: player.playing ? t.pause : t.play,
                  onPressed: _togglePlay,
                ),
                _StepButton(
                  icon: Icons.navigate_next,
                  tooltip: t.frameForward,
                  onStep: () => _step(_frame),
                ),
                _StepButton(
                  icon: Icons.fast_forward,
                  tooltip: t.secondForward,
                  onStep: () => _step(const Duration(seconds: 1)),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _StepButton(
                  icon: Icons.replay_10,
                  tooltip: t.tenSecondsBack,
                  onStep: () => _step(const Duration(seconds: -10)),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  icon: const Icon(Icons.add_a_photo),
                  label: Text(t.keepThisFrame),
                  onPressed: _grabbing ? null : _keep,
                ),
                const SizedBox(width: 8),
                _StepButton(
                  icon: Icons.forward_10,
                  tooltip: t.tenSecondsForward,
                  onStep: () => _step(const Duration(seconds: 10)),
                ),
              ]),
              const SizedBox(height: 8),
              // The kept frames, oldest first; a tap lets one go.
              SizedBox(
                height: 96,
                child: _kept.isEmpty
                    ? Center(
                        child: Text(t.keptFrames,
                            style: Theme.of(context).textTheme.bodySmall))
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: [
                          for (final ms in _kept.keys.toList()..sort())
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () => setState(() => _kept.remove(ms)),
                                child: Tooltip(
                                  message: _clock(Duration(milliseconds: ms)),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      // A fixed frame: the tile has its
                                      // place before the picture decodes.
                                      child: Image(
                                        image: _tile(ms),
                                        width: 128,
                                        height: 96,
                                        fit: BoxFit.cover,
                                        gaplessPlayback: true,
                                      ),
                                    ),
                                    const Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Icon(Icons.check_circle,
                                          color: Colors.white),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
              const SizedBox(height: 8),
            ]),
    );
  }
}

/// A step that repeats while held: one tap, one step; a hold, a run.
class _StepButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onStep;

  const _StepButton(
      {required this.icon, required this.tooltip, required this.onStep});

  @override
  State<_StepButton> createState() => _StepButtonState();
}

class _StepButtonState extends State<_StepButton> {
  Timer? _run;

  @override
  void dispose() {
    _run?.cancel();
    super.dispose();
  }

  void _stop() {
    _run?.cancel();
    _run = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        widget.onStep();
        _run = Timer.periodic(
            const Duration(milliseconds: 150), (_) => widget.onStep());
      },
      onLongPressEnd: (_) => _stop(),
      onLongPressCancel: _stop,
      child: IconButton(
        iconSize: 32,
        icon: Icon(widget.icon),
        tooltip: widget.tooltip,
        onPressed: widget.onStep,
      ),
    );
  }
}
