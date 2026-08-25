import 'package:flutter/material.dart';

/// The long-press affordance: a small cat ear peeking out of the top
/// end corner. Every surface that reacts to press-and-hold wears one —
/// the ear means exactly "hold for more", nothing else. Taught once by
/// a spotlight on the home screen.
class CatEarBadge extends StatelessWidget {
  final double size;

  /// True when the badge sits in the top START corner (only where the
  /// end corner is taken, e.g. by the profile star on photo tiles).
  final bool atStart;

  const CatEarBadge({super.key, this.size = 14, this.atStart = false});

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return IgnorePointer(
      child: CustomPaint(
        size: Size.square(size),
        painter: _EarPainter(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.6),
          // The triangle hugs the outer corner of whichever side it
          // sits on.
          flip: atStart ^ rtl,
        ),
      ),
    );
  }
}

/// Wraps [child] so it wears the ear in its top end corner.
class WithCatEar extends StatelessWidget {
  final Widget child;

  const WithCatEar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      const PositionedDirectional(top: 0, end: 0, child: CatEarBadge()),
    ]);
  }
}

class _EarPainter extends CustomPainter {
  final Color color;
  final bool flip;

  const _EarPainter({required this.color, required this.flip});

  @override
  void paint(Canvas canvas, Size size) {
    // A corner triangle with a small notch at the tip, so it reads as
    // an ear rather than a folded page.
    final w = size.width;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, w)
      ..lineTo(w * 0.55, w * 0.55)
      ..lineTo(w * 0.35, w * 0.35)
      ..close();
    if (flip) {
      canvas.translate(w, 0);
      canvas.scale(-1, 1);
    }
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_EarPainter old) =>
      old.color != color || old.flip != flip;
}
