import 'dart:math';

import 'package:flutter/material.dart';

/// A quiet fur pattern behind every page (#99): beige on beige, one of
/// six coats picked anew each time the app opens. The scaffolds are
/// transparent; this widget paints the ground they sit on.
enum FurPattern { cheetah, tiger, tabby, paws, rosettes, zebra }

/// The coat of this launch. Assignable so screenshots and tests are
/// deterministic.
FurPattern activeFur =
    FurPattern.values[Random().nextInt(FurPattern.values.length)];

/// The two tones of the coat: a warm ground and marks barely darker —
/// fur, not wallpaper.
({Color base, Color mark}) furTones(Brightness brightness) =>
    brightness == Brightness.dark
        ? (base: const Color(0xFF17130E), mark: const Color(0xFF221C14))
        : (base: const Color(0xFFF7F0E3), mark: const Color(0xFFEADDC6));

class FurBackground extends StatelessWidget {
  final Widget child;

  const FurBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tones = furTones(Theme.of(context).brightness);
    return CustomPaint(
      painter: FurPainter(
          pattern: activeFur, base: tones.base, mark: tones.mark),
      child: child,
    );
  }
}

/// Draws one coat, deterministic for its inputs.
class FurPainter extends CustomPainter {
  final FurPattern pattern;
  final Color base;
  final Color mark;

  const FurPainter(
      {required this.pattern, required this.base, required this.mark});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = base);
    final paint = Paint()..color = mark;
    // Stripes cover far more ground than spots — halfway to the base
    // keeps them fur, not wallpaper.
    final faint = Paint()..color = Color.lerp(base, mark, 0.4)!;
    final r = Random(7);
    switch (pattern) {
      case FurPattern.cheetah:
        _cheetah(canvas, size, paint, r);
      case FurPattern.tiger:
        _stripes(canvas, size, faint, r, width: 26, gap: 78, wave: 22);
      case FurPattern.tabby:
        _stripes(canvas, size, faint, r, width: 10, gap: 44, wave: 30);
      case FurPattern.paws:
        _paws(canvas, size, paint, r);
      case FurPattern.rosettes:
        _rosettes(canvas, size, paint, r);
      case FurPattern.zebra:
        _zebra(canvas, size, faint, r);
    }
  }

  /// Solid spots, the cheetah's coat.
  void _cheetah(Canvas canvas, Size size, Paint paint, Random r) {
    final count = (size.width * size.height / 9000).round();
    for (var i = 0; i < count; i++) {
      final c = Offset(
          r.nextDouble() * size.width, r.nextDouble() * size.height);
      final w = 8 + r.nextDouble() * 10;
      final h = w * (0.75 + r.nextDouble() * 0.4);
      canvas.save();
      canvas.translate(c.dx, c.dy);
      canvas.rotate(r.nextDouble() * pi);
      canvas.drawOval(
          Rect.fromCenter(center: Offset.zero, width: w, height: h), paint);
      canvas.restore();
    }
  }

  /// Vertical wavy bands: broad for the tiger, thin and dense for the
  /// tabby.
  void _stripes(Canvas canvas, Size size, Paint paint, Random r,
      {required double width, required double gap, required double wave}) {
    for (var x = -wave; x < size.width + gap; x += gap) {
      final drift = r.nextDouble() * wave - wave / 2;
      final path = Path()..moveTo(x + drift, -10);
      for (var y = 0.0; y <= size.height + 40; y += 40) {
        path.quadraticBezierTo(
            x + drift + (r.nextDouble() * wave * 2 - wave),
            y + 20,
            x + drift + (r.nextDouble() * wave - wave / 2),
            y + 40);
      }
      canvas.drawPath(
          path,
          Paint()
            ..color = paint.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = width * (0.7 + r.nextDouble() * 0.6)
            ..strokeCap = StrokeCap.round);
    }
  }

  /// A pad and four toes, scattered and turned.
  void _paws(Canvas canvas, Size size, Paint paint, Random r) {
    final count = (size.width * size.height / 26000).round();
    for (var i = 0; i < count; i++) {
      canvas.save();
      canvas.translate(
          r.nextDouble() * size.width, r.nextDouble() * size.height);
      canvas.rotate(r.nextDouble() * 2 * pi);
      final s = 0.8 + r.nextDouble() * 0.6;
      canvas.scale(s, s);
      canvas.drawOval(
          Rect.fromCenter(center: const Offset(0, 8), width: 22, height: 18),
          paint);
      for (final (dx, dy) in const [
        (-11.0, -6.0),
        (-4.0, -11.0),
        (4.0, -11.0),
        (11.0, -6.0)
      ]) {
        canvas.drawOval(
            Rect.fromCenter(
                center: Offset(dx, dy), width: 7.5, height: 9), paint);
      }
      canvas.restore();
    }
  }

  /// Broken rings — the leopard among the house cats.
  void _rosettes(Canvas canvas, Size size, Paint paint, Random r) {
    final count = (size.width * size.height / 16000).round();
    for (var i = 0; i < count; i++) {
      final c = Offset(
          r.nextDouble() * size.width, r.nextDouble() * size.height);
      final radius = 10 + r.nextDouble() * 6;
      final blobs = 3 + r.nextInt(3);
      final start = r.nextDouble() * 2 * pi;
      for (var b = 0; b < blobs; b++) {
        final a = start + b * 2 * pi / blobs + r.nextDouble() * 0.5;
        canvas.drawOval(
            Rect.fromCenter(
                center: c + Offset(cos(a), sin(a)) * radius,
                width: 7 + r.nextDouble() * 4,
                height: 5 + r.nextDouble() * 3),
            paint);
      }
    }
  }

  /// Bold diagonal waves, the wildest of the mix.
  void _zebra(Canvas canvas, Size size, Paint paint, Random r) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.35);
    final span = size.width + size.height;
    _stripes(canvas, Size(span, span * 1.2), paint, r,
        width: 20, gap: 64, wave: 26);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FurPainter old) =>
      old.pattern != pattern || old.base != base || old.mark != mark;
}
