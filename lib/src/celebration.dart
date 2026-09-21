import 'dart:async';
import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'sounds.dart';

/// Adoption party: confetti when a cat moves into a forever-home
/// clowder — only on the device performing the move (sync arrivals
/// never celebrate; that would be Bob's phone exploding three days
/// later). Killable in Settings. The sound of each moment is its own
/// choice there, see `sounds.dart`.
bool celebrationsEnabled(CatalogStore store) =>
    store.localSetting('celebrations') != 'off';

void setCelebrationsEnabled(CatalogStore store, bool enabled) =>
    store.setLocalSetting('celebrations', enabled ? 'on' : 'off');

/// The moments the app makes a sound at: a tick, the day's chores
/// done, a ladder climbed, an adoption. Each ships with its own cat
/// sound until the keeper picks another or none.
enum Cheer { tick, dayDone, ladder, adoption }

/// The sound a [Cheer] ships with.
String cheerAsset(Cheer cheer) => presetAsset(defaultPreset(cheer));

/// Where the last touch landed, so the paw appears under the thumb.
Offset? lastTouch;

/// Remembers every touch; wraps the app once.
class TouchTracker extends StatelessWidget {
  final Widget child;

  const TouchTracker({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Listener(
    behavior: HitTestBehavior.translucent,
    onPointerDown: (e) => lastTouch = e.position,
    child: child,
  );
}

/// A quick local success the screen already shows — copied, recorded,
/// cleared: a green paw for half a second at the button that was
/// tapped, silent, and no note.
void paw(BuildContext context) {
  final overlay = Overlay.maybeOf(context);
  if (overlay == null) return;
  final at = lastTouch ?? MediaQuery.sizeOf(context).center(Offset.zero);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _PawOverlay(at: at, onDone: () => entry.remove()),
  );
  overlay.insert(entry);
}

class _PawOverlay extends StatefulWidget {
  final Offset at;
  final VoidCallback onDone;

  const _PawOverlay({required this.at, required this.onDone});

  @override
  State<_PawOverlay> createState() => _PawOverlayState();
}

class _PawOverlayState extends State<_PawOverlay>
    with SingleTickerProviderStateMixin {
  late final _controller =
      AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        )
        ..addStatusListener((s) {
          if (s == AnimationStatus.completed) widget.onDone();
        })
        ..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const size = 48.0;
    return Positioned(
      left: widget.at.dx - size / 2,
      top: widget.at.dy - size,
      child: IgnorePointer(
        child: FadeTransition(
          opacity: Tween(
            begin: 1.0,
            end: 0.0,
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn)),
          child: ScaleTransition(
            scale: Tween(begin: 0.6, end: 1.4).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOut),
            ),
            child: Icon(Icons.pets, size: size, color: Colors.green.shade600),
          ),
        ),
      ),
    );
  }
}

/// Call after a locally performed move; fires only for forever homes.
void maybeCelebrateAdoption(
  BuildContext context,
  CatalogStore store,
  String? destinationClowder,
) {
  if (destinationClowder == null) return;
  if (store.current(destinationClowder, 'f:status') != 'forever-home') return;
  celebrate(context, store, Cheer.adoption);
}

/// The moment's sound as chosen, and confetti when celebrations are
/// on: an adoption, a day of chores all done, an achievement.
void celebrate(BuildContext context, CatalogStore store, Cheer cheer) {
  playMoment(store, cheer);
  if (celebrationsEnabled(store)) _showConfetti(context);
}

/// The sound of a tick, as chosen; no confetti.
void tickSound(CatalogStore store) {
  playMoment(store, Cheer.tick);
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
  sub = events.listen(
    (_) => finish(),
    onError: (_) => finish(),
    onDone: finish,
  );
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
  late final AnimationController _c =
      AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 2500),
        )
        ..addStatusListener((s) {
          if (s == AnimationStatus.completed) widget.onDone();
        })
        ..forward();

  final List<_Particle> _particles = List.generate(
    120,
    (_) => _Particle(Random()),
  );

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
              center: Offset.zero,
              width: p.size,
              height: p.size * 0.6,
            ),
            paint,
          );
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
