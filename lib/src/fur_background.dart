import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A quiet fur pattern behind every page (#99): beige on beige, one of
/// six coats picked anew each time the app opens. The scaffolds are
/// transparent; this widget paints the ground they sit on.
enum FurPattern { cheetah, tiger, tabby, paws, rosettes, zebra }

/// The coat of this launch. Assignable so screenshots and tests are
/// deterministic.
FurPattern activeFur =
    FurPattern.values[Random().nextInt(FurPattern.values.length)];

/// Where the coat currently sits: follows the scrolling of the page on
/// top, so the fur moves with the content instead of showing through it
/// like dirt on the glass. Registered as a navigator observer so a page
/// coming back keeps its own position.
final furScroll = FurScroll();

/// The two tones of the coat: a warm ground and marks barely darker —
/// fur, not wallpaper.
({Color base, Color mark}) furTones(Brightness brightness) =>
    brightness == Brightness.dark
        ? (base: const Color(0xFF17130E), mark: const Color(0xFF221C14))
        : (base: const Color(0xFFF7F0E3), mark: const Color(0xFFEADDC6));

/// Remembers the vertical scroll offset of every page route and exposes
/// the current page's one. Dialogs, sheets and horizontal rows are
/// ignored: the coat belongs to the page.
class FurScroll extends NavigatorObserver {
  /// Pixels the coat is shifted up by.
  final offset = ValueNotifier<double>(0);
  final _offsets = <Route<dynamic>, double>{};

  /// Feed to a [NotificationListener] above the navigator. Never
  /// swallows the notification.
  bool onNotification(Notification notification) {
    switch (notification) {
      case ScrollNotification(:final metrics, :final context, :final depth):
        return _track(metrics, context, depth);
      case ScrollMetricsNotification(
          :final metrics,
          :final context,
          :final depth
        ):
        return _track(metrics, context, depth);
    }
    return false;
  }

  /// Only the page's outermost scrollable counts: a list or text field
  /// nested inside it (depth > 0) scrolls on its own.
  bool _track(ScrollMetrics metrics, BuildContext? context, int depth) {
    if (depth != 0 || metrics.axis != Axis.vertical || context == null) {
      return false;
    }
    final route = ModalRoute.of(context);
    if (route is! PageRoute) return false;
    _offsets[route] = metrics.pixels;
    if (route.isCurrent) offset.value = metrics.pixels;
    return false;
  }

  /// Shows [route]'s position if it is the page now on top.
  void _show(Route<dynamic>? route) {
    if (route is PageRoute && route.isCurrent) {
      offset.value = _offsets[route] ?? 0;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _show(route);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _offsets.remove(route);
    _show(previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _offsets.remove(route);
    _show(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _offsets.remove(oldRoute);
    _show(newRoute);
  }
}

class FurBackground extends StatelessWidget {
  final Widget child;

  const FurBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tones = furTones(Theme.of(context).brightness);
    return NotificationListener<Notification>(
      onNotification: furScroll.onNotification,
      child: CustomPaint(
        painter: FurPainter(
            pattern: activeFur,
            base: tones.base,
            mark: tones.mark,
            scroll: furScroll.offset),
        child: child,
      ),
    );
  }
}

/// Draws one coat. The marks live on an endless plane in fixed cells,
/// each cell seeded by its coordinates, so the same spot is always at
/// the same place however far the page has scrolled.
class FurPainter extends CustomPainter {
  final FurPattern pattern;
  final Color base;
  final Color mark;

  /// Vertical scroll offset the coat is shifted by; repaints on change.
  final ValueListenable<double> scroll;

  FurPainter(
      {required this.pattern,
      required this.base,
      required this.mark,
      required this.scroll})
      : super(repaint: scroll);

  static const _cell = 320.0;
  static const _segment = 40.0;
  static const _tilt = 0.35;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = base);
    final paint = Paint()..color = mark;
    // Stripes cover far more ground than spots — halfway to the base
    // keeps them fur, not wallpaper.
    final faint = Paint()..color = Color.lerp(base, mark, 0.4)!;
    final offset = scroll.value;
    final region = Rect.fromLTWH(0, offset, size.width, size.height);
    canvas.save();
    canvas.translate(0, -offset);
    switch (pattern) {
      case FurPattern.cheetah:
        _cheetah(canvas, region, paint);
      case FurPattern.tiger:
        _stripes(canvas, region, faint, width: 26, gap: 78, wave: 22);
      case FurPattern.tabby:
        _stripes(canvas, region, faint, width: 10, gap: 44, wave: 30);
      case FurPattern.paws:
        _paws(canvas, region, paint);
      case FurPattern.rosettes:
        _rosettes(canvas, region, paint);
      case FurPattern.zebra:
        _zebra(canvas, size, region, faint);
    }
    canvas.restore();
  }

  /// A seed that is the same for the same cell on every launch.
  static int _seed(int i, int j) => i * 73856093 ^ j * 19349663 ^ 7;

  /// Runs [draw] for every mark whose cell touches [region], with the
  /// canvas moved to the mark. One mark per [density] square pixels.
  void _scatter(Canvas canvas, Rect region, double density,
      void Function(Canvas canvas, Random r) draw) {
    final perCell = (_cell * _cell / density).round();
    final grown = region.inflate(32);
    for (var cy = (grown.top / _cell).floor();
        cy <= (grown.bottom / _cell).floor();
        cy++) {
      for (var cx = (grown.left / _cell).floor();
          cx <= (grown.right / _cell).floor();
          cx++) {
        final r = Random(_seed(cx, cy));
        for (var i = 0; i < perCell; i++) {
          canvas.save();
          canvas.translate(cx * _cell + r.nextDouble() * _cell,
              cy * _cell + r.nextDouble() * _cell);
          draw(canvas, r);
          canvas.restore();
        }
      }
    }
  }

  /// Solid spots, the cheetah's coat.
  void _cheetah(Canvas canvas, Rect region, Paint paint) {
    _scatter(canvas, region, 9000, (canvas, r) {
      final w = 8 + r.nextDouble() * 10;
      final h = w * (0.75 + r.nextDouble() * 0.4);
      canvas.rotate(r.nextDouble() * pi);
      canvas.drawOval(
          Rect.fromCenter(center: Offset.zero, width: w, height: h), paint);
    });
  }

  /// Vertical wavy bands covering [region]: broad for the tiger, thin
  /// and dense for the tabby. Every node of a band is seeded by band and
  /// height, so the bands continue seamlessly wherever the page is.
  void _stripes(Canvas canvas, Rect region, Paint paint,
      {required double width, required double gap, required double wave}) {
    final first = (region.top / _segment).floor() - 1;
    final last = (region.bottom / _segment).ceil() + 1;
    for (var i = ((region.left - wave) / gap).floor() - 1;
        i * gap < region.right + wave + gap;
        i++) {
      final band = Random(_seed(i, 1 << 30));
      final x = i * gap + band.nextDouble() * wave - wave / 2;
      final stroke = width * (0.7 + band.nextDouble() * 0.6);
      double node(int j) =>
          x + Random(_seed(i, j)).nextDouble() * wave - wave / 2;
      final path = Path()..moveTo(node(first), first * _segment);
      for (var j = first; j < last; j++) {
        final r = Random(_seed(i, j))..nextDouble();
        path.quadraticBezierTo(x + (r.nextDouble() * wave * 2 - wave),
            j * _segment + _segment / 2, node(j + 1), (j + 1) * _segment);
      }
      canvas.drawPath(
          path,
          Paint()
            ..color = paint.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = stroke
            ..strokeCap = StrokeCap.round);
    }
  }

  /// A pad and four toes, scattered and turned.
  void _paws(Canvas canvas, Rect region, Paint paint) {
    _scatter(canvas, region, 26000, (canvas, r) {
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
    });
  }

  /// Broken rings — the leopard among the house cats.
  void _rosettes(Canvas canvas, Rect region, Paint paint) {
    _scatter(canvas, region, 16000, (canvas, r) {
      final radius = 10 + r.nextDouble() * 6;
      final blobs = 3 + r.nextInt(3);
      final start = r.nextDouble() * 2 * pi;
      for (var b = 0; b < blobs; b++) {
        final a = start + b * 2 * pi / blobs + r.nextDouble() * 0.5;
        canvas.drawOval(
            Rect.fromCenter(
                center: Offset(cos(a), sin(a)) * radius,
                width: 7 + r.nextDouble() * 4,
                height: 5 + r.nextDouble() * 3),
            paint);
      }
    });
  }

  /// Bold diagonal waves, the wildest of the mix: the tiger's bands
  /// turned about a fixed point of the plane, painted over whatever part
  /// of that turned plane shows through [region].
  void _zebra(Canvas canvas, Size size, Rect region, Paint paint) {
    final turn = Matrix4.translationValues(size.width / 2, size.height / 2, 0)
      ..rotateZ(_tilt);
    final seen = MatrixUtils.transformRect(Matrix4.inverted(turn), region);
    canvas.save();
    canvas.transform(turn.storage);
    _stripes(canvas, seen, paint, width: 20, gap: 64, wave: 26);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FurPainter old) =>
      old.pattern != pattern || old.base != base || old.mark != mark;
}
