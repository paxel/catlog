import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

/// Adoption party: confetti + a cheer when a cat moves into a
/// forever-home clowder — only on the device performing the move (sync
/// arrivals never celebrate; that would be Bob's phone exploding three
/// days later). Killable in About; the sound uses the ambient audio
/// category, so the platform silent switch mutes it.
bool celebrationsEnabled(CatalogStore store) =>
    store.localSetting('celebrations') != 'off';

void setCelebrationsEnabled(CatalogStore store, bool enabled) =>
    store.setLocalSetting('celebrations', enabled ? 'on' : 'off');

/// The cheer beside the confetti; off leaves the confetti alone.
bool cheerEnabled(CatalogStore store) =>
    store.localSetting('celebrationSound') != 'off';

void setCheerEnabled(CatalogStore store, bool enabled) =>
    store.setLocalSetting('celebrationSound', enabled ? 'on' : 'off');

/// The cheers, one picked at random per celebration so the hundredth
/// still surprises. cheer1–4 are CC BY 4.0 excerpts, credited on the
/// licences page; see assets/sounds/LICENSES.md.
const cheerAssets = [
  'sounds/party.wav',
  'sounds/cheer1.wav',
  'sounds/cheer2.wav',
  'sounds/cheer3.wav',
  'sounds/cheer4.wav',
];

/// One of [cheerAssets], never the same as [previous] twice in a row.
String pickCheer({String? previous, Random? random}) {
  final r = random ?? Random();
  final choices = [
    for (final a in cheerAssets)
      if (a != previous || cheerAssets.length == 1) a
  ];
  return choices[r.nextInt(choices.length)];
}

String? _lastCheer;

/// Call after a locally performed move; fires only for forever homes.
void maybeCelebrateAdoption(
    BuildContext context, CatalogStore store, String? destinationClowder) {
  if (destinationClowder == null) return;
  if (store.current(destinationClowder, 'f:status') != 'forever-home') return;
  celebrate(context, store);
}

/// Confetti and a cheer, when celebrations are on: an adoption, a day
/// of chores all done, an achievement.
void celebrate(BuildContext context, CatalogStore store) {
  if (!celebrationsEnabled(store)) return;
  if (cheerEnabled(store)) _playCheer();
  _showConfetti(context);
}

Future<void> _playCheer() async {
  final player = AudioPlayer();
  try {
    await player.setAudioContext(AudioContext(
      iOS: AudioContextIOS(category: AVAudioSessionCategory.ambient),
      android: const AudioContextAndroid(
        usageType: AndroidUsageType.game,
        audioFocus: AndroidAudioFocus.none,
      ),
    ));
    final cheer = pickCheer(previous: _lastCheer);
    _lastCheer = cheer;
    await player.play(AssetSource(cheer));
    // Released when the sound ends — or after a few seconds if the
    // platform never says so, or at once when the platform closes the
    // stream without an event.
    firstOrDone(player.onPlayerComplete, const Duration(seconds: 10))
        .whenComplete(player.dispose);
  } catch (_) {
    // No audio device or platform quirk — the confetti still flies.
    player.dispose();
  }
}

/// Completes on the first event of [events], when the stream closes
/// without one, or after [limit] — never with an error. `Stream.first`
/// alone throws "No element" on a stream that ends empty, which is what
/// a disposed audio player does.
Future<void> firstOrDone(Stream<void> events, Duration limit) {
  final done = Completer<void>();
  void finish() {
    if (!done.isCompleted) done.complete();
  }
  late final StreamSubscription<void> sub;
  sub = events.listen((_) => finish(), onError: (_) => finish(), onDone: finish);
  return done.future.timeout(limit, onTimeout: () {}).whenComplete(sub.cancel);
}

void _showConfetti(BuildContext context) {
  final overlay = Overlay.maybeOf(context);
  if (overlay == null) return;
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _ConfettiOverlay(onDone: () => entry.remove()),
  );
  overlay.insert(entry);
}

class _ConfettiOverlay extends StatefulWidget {
  final VoidCallback onDone;

  const _ConfettiOverlay({required this.onDone});

  @override
  State<_ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _Particle {
  final double x, drift, size, fall, spin;
  final Color color;
  final int shape;

  _Particle(Random r)
      : x = r.nextDouble(),
        drift = (r.nextDouble() - 0.5) * 0.3,
        size = 6 + r.nextDouble() * 8,
        fall = 0.7 + r.nextDouble() * 0.6,
        spin = (r.nextDouble() - 0.5) * 12,
        color = _palette[r.nextInt(_palette.length)],
        shape = r.nextInt(3);

  static const _palette = [
    Color(0xFFE91E63),
    Color(0xFFFFC107),
    Color(0xFF4CAF50),
    Color(0xFF42A5F5),
    Color(0xFFFF7043),
    Color(0xFFAB47BC),
  ];
}

class _ConfettiOverlayState extends State<_ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500))
    ..addStatusListener((s) {
      if (s == AnimationStatus.completed) widget.onDone();
    })
    ..forward();

  final List<_Particle> _particles =
      List.generate(120, (_) => _Particle(Random()));

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) => CustomPaint(
          size: MediaQuery.sizeOf(context),
          painter: _ConfettiPainter(_particles, _c.value),
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double t;

  _ConfettiPainter(this.particles, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final p in particles) {
      final progress = t * p.fall;
      if (progress > 1) continue;
      final x = (p.x + p.drift * t) * size.width;
      final y = progress * (size.height + 40) - 20;
      paint.color = p.color.withValues(alpha: 1 - t * t);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin * t);
      switch (p.shape) {
        case 0:
          canvas.drawRect(
              Rect.fromCenter(
                  center: Offset.zero, width: p.size, height: p.size * 0.6),
              paint);
        case 1:
          canvas.drawCircle(Offset.zero, p.size / 2, paint);
        default:
          final path = Path()
            ..moveTo(0, -p.size / 2)
            ..lineTo(p.size / 2, p.size / 2)
            ..lineTo(-p.size / 2, p.size / 2)
            ..close();
          canvas.drawPath(path, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}
