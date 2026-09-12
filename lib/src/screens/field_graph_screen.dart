import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:share_plus/share_plus.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../layout.dart';
import '../share.dart';
import '../units.dart';
import '../widgets/date_entry.dart';

/// One value of a field's history as the graph draws it: the moment and
/// the number in the device's unit.
typedef GraphPoint = ({DateTime at, double value});

/// The ranges a graph can show; the last choice is kept per device.
enum GraphRange { week, month, year, all, custom }

const graphRangeKey = 'graphRange';

/// Remembered per device: the smoothed line and the trend line.
const graphSmoothKey = 'graphSmooth';
const graphTrendKey = 'graphTrend';

/// The smoothed line: a Gaussian-weighted average of the readings,
/// width one twelfth of the shown span, sampled evenly between the
/// first and the last reading. Irregular readings weigh alike; a
/// cluster of five weighings in a week does not drag a year's line.
List<GraphPoint> smoothCurve(
  List<GraphPoint> points,
  DateTime from,
  DateTime to, {
  int samples = 80,
}) {
  if (points.length < 2) return points;
  final spanMs = math.max(1, to.difference(from).inMilliseconds).toDouble();
  final sigma = spanMs / 12;
  final first = points.first.at.millisecondsSinceEpoch.toDouble();
  final last = points.last.at.millisecondsSinceEpoch.toDouble();
  final out = <GraphPoint>[];
  for (var i = 0; i <= samples; i++) {
    final t = first + (last - first) * i / samples;
    var weight = 0.0, sum = 0.0;
    for (final p in points) {
      final d = (p.at.millisecondsSinceEpoch - t) / sigma;
      final w = math.exp(-0.5 * d * d);
      weight += w;
      sum += w * p.value;
    }
    out.add((
      at: DateTime.fromMillisecondsSinceEpoch(t.round()),
      value: sum / weight,
    ));
  }
  return out;
}

/// The trend: a straight line fitted through the readings (least
/// squares), as the value at [from], the value at [to], and the change
/// per month. Null with fewer than two readings or no time span.
({double atFrom, double atTo, double perMonth})? trendLine(
  List<GraphPoint> points,
  DateTime from,
  DateTime to,
) {
  if (points.length < 2) return null;
  const day = 86400000.0;
  final origin = points.first.at.millisecondsSinceEpoch.toDouble();
  final xs = [
    for (final p in points) (p.at.millisecondsSinceEpoch - origin) / day,
  ];
  final ys = [for (final p in points) p.value];
  final n = xs.length;
  final mx = xs.reduce((a, b) => a + b) / n;
  final my = ys.reduce((a, b) => a + b) / n;
  var sxx = 0.0, sxy = 0.0;
  for (var i = 0; i < n; i++) {
    sxx += (xs[i] - mx) * (xs[i] - mx);
    sxy += (xs[i] - mx) * (ys[i] - my);
  }
  if (sxx == 0) return null;
  final slope = sxy / sxx;
  double at(DateTime d) =>
      my + slope * ((d.millisecondsSinceEpoch - origin) / day - mx);
  return (atFrom: at(from), atTo: at(to), perMonth: slope * 30.44);
}

const graphRangeFromKey = 'graphRange:from';
const graphRangeToKey = 'graphRange:to';

/// The numeric history of [def] on [entityId], oldest first, in the
/// device's entry unit for a Unit Value. Non-numbers are skipped.
List<GraphPoint> graphPoints(
  CatalogStore store,
  String entityId,
  FieldDef def,
) {
  final points = <GraphPoint>[];
  for (final e in store.fieldHistory(entityId, def.key).reversed) {
    final raw = e.value == null ? null : double.tryParse(e.value!);
    if (raw == null) continue;
    final value = def.type == FieldType.unitValue
        ? fromBase(def.unitDimension, unitSystem.value, raw)
        : raw;
    points.add((at: e.date, value: value));
  }
  return points;
}

bool _graphable(FieldDef def) =>
    def.type == FieldType.number || def.type == FieldType.unitValue;

/// How many values of [def] on [entityId] a graph could draw.
int graphablePoints(CatalogStore store, String entityId, FieldDef def) =>
    _graphable(def) ? graphPoints(store, entityId, def).length : 0;

/// Whether a graph has anything to draw — two numbers — decided on
/// every field row of a page, so it stops at the second one instead
/// of converting the whole history.
bool hasGraph(CatalogStore store, String entityId, FieldDef def) {
  if (!_graphable(def)) return false;
  var numbers = 0;
  for (final e in store.fieldHistory(entityId, def.key)) {
    if (e.value != null &&
        double.tryParse(e.value!) != null &&
        ++numbers >= 2) {
      return true;
    }
  }
  return false;
}

/// Whether [at] lies inside [from]..[to] (both inclusive; null = open).
bool inRange(DateTime at, DateTime? from, DateTime? to) =>
    (from == null || !at.isBefore(from)) && (to == null || !at.isAfter(to));

/// The points inside [from]..[to].
List<GraphPoint> pointsBetween(
  List<GraphPoint> points,
  DateTime? from,
  DateTime? to,
) => [
  for (final p in points)
    if (inRange(p.at, from, to)) p,
];

/// Where the time axis gets a tick between [from] and [to]: days over a
/// week or two, weeks over a season, months over a year or two, years
/// beyond — never more than eight, so the labels keep their room.
List<DateTime> timeTicks(DateTime from, DateTime to) {
  final days = to.difference(from).inDays;
  final ticks = <DateTime>[];
  DateTime next(DateTime d) {
    if (days <= 14) return DateTime(d.year, d.month, d.day + 1);
    if (days <= 120) return DateTime(d.year, d.month, d.day + 7);
    if (days <= 730) return DateTime(d.year, d.month + 1, 1);
    return DateTime(d.year + 1, 1, 1);
  }

  DateTime first() {
    if (days <= 14) return DateTime(from.year, from.month, from.day + 1);
    if (days <= 120) {
      // The next Monday.
      final day = DateTime(from.year, from.month, from.day + 1);
      return DateTime(day.year, day.month, day.day + (8 - day.weekday) % 7);
    }
    if (days <= 730) return DateTime(from.year, from.month + 1, 1);
    return DateTime(from.year + 1, 1, 1);
  }

  for (var d = first(); !d.isAfter(to); d = next(d)) {
    if (d.isAfter(from)) ticks.add(d);
  }
  if (ticks.length <= 8) return ticks;
  final stride = (ticks.length / 8).ceil();
  return [for (var i = 0; i < ticks.length; i += stride) ticks[i]];
}

/// Round values between [lo] and [hi] for the value axis: a step of
/// 1, 2 or 5 times a power of ten, about four steps across.
List<double> valueTicks(double lo, double hi) {
  if (hi <= lo) return const [];
  final raw = (hi - lo) / 4;
  final magnitude = math.pow(10, (math.log(raw) / math.ln10).floor());
  // The round step whose count comes closest to four.
  final step = [1, 2, 5, 10]
      .map((m) => m * magnitude)
      .reduce(
        (a, b) =>
            ((hi - lo) / a - 4).abs() <= ((hi - lo) / b - 4).abs() ? a : b,
      );
  final ticks = <double>[];
  for (var v = (lo / step).ceil() * step; v <= hi + step * 1e-9; v += step) {
    ticks.add(double.parse(v.toStringAsFixed(6)));
  }
  return ticks;
}

/// A field's history as a curve (#97): range chips, the change since
/// the previous value, min, max and latest marked, the animal's
/// appointments as ticks under the time axis.
class FieldGraphScreen extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final FieldDef def;

  const FieldGraphScreen({
    super.key,
    required this.store,
    required this.entityId,
    required this.def,
  });

  @override
  State<FieldGraphScreen> createState() => _FieldGraphScreenState();
}

class _FieldGraphScreenState extends State<FieldGraphScreen> {
  CatalogStore get store => widget.store;

  GraphRange get _range =>
      GraphRange.values.asNameMap()[store.localSetting(graphRangeKey)] ??
      GraphRange.all;

  (DateTime?, DateTime?) _bounds(DateTime now) => switch (_range) {
    GraphRange.week => (now.subtract(const Duration(days: 7)), null),
    GraphRange.month => (DateTime(now.year, now.month - 1, now.day), null),
    GraphRange.year => (DateTime(now.year - 1, now.month, now.day), null),
    GraphRange.all => (null, null),
    GraphRange.custom => (
      _storedDay(graphRangeFromKey),
      _storedDay(graphRangeToKey)?.add(const Duration(days: 1)),
    ),
  };

  bool get _smooth => store.localSetting(graphSmoothKey) == 'yes';
  bool get _trend => store.localSetting(graphTrendKey) == 'yes';

  void _toggle(String key, bool on) {
    store.setLocalSetting(key, on ? 'yes' : 'no');
    setState(() {});
  }

  /// A day kept on this device under [key], or null.
  DateTime? _storedDay(String key) =>
      DateTime.tryParse(store.localSetting(key) ?? '');

  Future<void> _pick(GraphRange range) async {
    if (range == GraphRange.custom) {
      final from = await pickDay(
        context,
        initial:
            _storedDay(graphRangeFromKey) ??
            DateTime.now().subtract(const Duration(days: 30)),
      );
      if (from == null || !mounted) return;
      final to = await pickDay(
        context,
        initial: _storedDay(graphRangeToKey) ?? DateTime.now(),
      );
      if (to == null || !mounted) return;
      store.setLocalSetting(
        graphRangeFromKey,
        from.toIso8601String().substring(0, 10),
      );
      store.setLocalSetting(
        graphRangeToKey,
        to.toIso8601String().substring(0, 10),
      );
    }
    store.setLocalSetting(graphRangeKey, range.name);
    setState(() {});
  }

  String _unit() => widget.def.type == FieldType.unitValue
      ? entryUnit(widget.def.unitDimension, unitSystem.value)
      : '';

  String _number(double v) {
    final text = formatDecimal(v, 2);
    final unit = _unit();
    return unit.isEmpty ? text : '$text $unit';
  }

  /// The part of the page that goes into the picture: caption and
  /// curve, no range chips, no bars — what a messenger should show.
  final _pictureKey = GlobalKey();

  /// The picture as PNG, three device pixels per logical one.
  Future<Uint8List> pictureAsPng() async {
    final boundary =
        _pictureKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data!.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  }

  Future<void> _share() async {
    final png = await pictureAsPng();
    if (!mounted) return;
    final name = store.current(widget.entityId, Keys.name) ?? 'cat';
    final field = fieldDefName(context.t, widget.def);
    await shareFiles(context, [
      XFile.fromData(png, mimeType: 'image/png', name: '$name $field.png'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final all = graphPoints(store, widget.entityId, widget.def);
    final (from, to) = _bounds(DateTime.now());
    final shown = pointsBetween(all, from, to);
    final appointments = [
      for (final a in store.appointmentsOf(widget.entityId, includeDone: true))
        if (inRange(a.date, from, to)) a.date,
    ];
    final latest = all.isEmpty ? null : all.last;
    final previous = all.length < 2 ? null : all[all.length - 2];
    final current = store.current(widget.entityId, widget.def.key);
    final name = store.current(widget.entityId, Keys.name) ?? t.unnamed;
    return Scaffold(
      appBar: roomyAppBar(
        context,
        title: Text(fieldDefName(t, widget.def)),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            tooltip: t.shareAsImage,
            onPressed: _share,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            fieldValueDisplay(t, widget.def, current),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (latest != null && previous != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                t.changeSince(
                  '${latest.value - previous.value >= 0 ? '+' : ''}'
                  '${_number(latest.value - previous.value)}',
                  DateFormat.yMd(locale).add_Hm().format(previous.at.toLocal()),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final (range, label) in [
                (GraphRange.week, t.rangeWeek),
                (GraphRange.month, t.rangeMonth),
                (GraphRange.year, t.rangeYear),
                (GraphRange.all, t.rangeAll),
                (GraphRange.custom, t.rangeCustom),
              ])
                ChoiceChip(
                  label: Text(label),
                  selected: _range == range,
                  onSelected: (_) => _pick(range),
                ),
              FilterChip(
                label: Text(t.graphSmoothed),
                selected: _smooth,
                onSelected: (on) => _toggle(graphSmoothKey, on),
              ),
              FilterChip(
                label: Text(t.graphTrend),
                selected: _trend,
                onSelected: (on) => _toggle(graphTrendKey, on),
              ),
            ],
          ),
          if (_trend)
            if (trendLine(
                  shown,
                  from ?? (shown.isEmpty ? DateTime.now() : shown.first.at),
                  to ?? DateTime.now(),
                )
                case final fit?)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  t.trendPerMonth(
                    '${fit.perMonth >= 0 ? '+' : ''}${_number(fit.perMonth)}',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          const SizedBox(height: 12),
          RepaintBoundary(
            key: _pictureKey,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '$name · ${fieldDefName(t, widget.def)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 260,
                    child: CustomPaint(
                      key: const ValueKey('field-graph'),
                      painter: GraphPainter(
                        points: shown,
                        from: from ?? (shown.isEmpty ? null : shown.first.at),
                        to: to ?? DateTime.now(),
                        appointments: appointments,
                        lineColor: Theme.of(context).colorScheme.primary,
                        // The painter draws its own text: it must carry the app's
                        // font, or it falls back to the engine's box glyphs.
                        labelStyle: Theme.of(context).textTheme.bodySmall!,
                        tickColor: Theme.of(context).colorScheme.tertiary,
                        format: _number,
                        dateFormat: (d) => DateFormat.MMMd(locale).format(d),
                        smooth: _smooth,
                        trend: _trend,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                t.searchNoResults,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}

/// The curve: time left to right with adaptive date ticks, value bottom
/// to top with round numbers and faint lines, min, max and the latest
/// point labelled, appointment ticks along the bottom.
class GraphPainter extends CustomPainter {
  final List<GraphPoint> points;
  final DateTime? from;
  final DateTime to;
  final List<DateTime> appointments;
  final Color lineColor;
  final TextStyle labelStyle;
  final Color tickColor;
  final String Function(double) format;
  final String Function(DateTime) dateFormat;

  /// The smoothed line instead of the reading-to-reading line; the
  /// readings stay as dots with a thin stem to the line.
  final bool smooth;

  /// A dashed straight line fitted through the readings.
  final bool trend;

  GraphPainter({
    required this.points,
    required this.from,
    required this.to,
    required this.appointments,
    required this.lineColor,
    required this.labelStyle,
    required this.tickColor,
    required this.format,
    required this.dateFormat,
    this.smooth = false,
    this.trend = false,
  });

  TextPainter _text(String s, double size) => TextPainter(
    text: TextSpan(
      text: s,
      style: labelStyle.copyWith(fontSize: size),
    ),
    textDirection: TextDirection.ltr,
  )..layout();

  @override
  void paint(Canvas canvas, Size size) {
    const right = 8.0, top = 20.0, bottom = 28.0;
    final textColor = labelStyle.color ?? Colors.black;
    final axis = Paint()
      ..color = textColor.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    if (points.isEmpty || from == null) {
      canvas.drawLine(
        Offset(8, size.height - bottom),
        Offset(size.width - right, size.height - bottom),
        axis,
      );
      return;
    }
    final start = from!;
    final spanMs = math.max(1, to.difference(start).inMilliseconds);
    var lo = points.map((p) => p.value).reduce(math.min);
    var hi = points.map((p) => p.value).reduce(math.max);
    if (hi == lo) {
      lo -= 1;
      hi += 1;
    }
    final pad = (hi - lo) * 0.1;
    lo -= pad;
    hi += pad;
    // The value axis: round numbers in the display unit down the left,
    // faint lines across; the axis takes the room its widest label
    // needs.
    final values = valueTicks(lo, hi);
    final valueLabels = [for (final v in values) _text(format(v), 10)];
    final left = valueLabels.isEmpty
        ? 8.0
        : valueLabels.map((t) => t.width).reduce(math.max) + 12;
    final plot = Rect.fromLTRB(
      left,
      top,
      size.width - right,
      size.height - bottom,
    );
    canvas.drawLine(plot.bottomLeft, plot.bottomRight, axis);
    double x(DateTime d) =>
        plot.left + plot.width * d.difference(start).inMilliseconds / spanMs;
    double y(double v) => plot.bottom - plot.height * (v - lo) / (hi - lo);
    final grid = Paint()
      ..color = textColor.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (var i = 0; i < values.length; i++) {
      final gy = y(values[i]);
      canvas.drawLine(Offset(plot.left, gy), Offset(plot.right, gy), grid);
      valueLabels[i].paint(
        canvas,
        Offset(
          plot.left - valueLabels[i].width - 6,
          gy - valueLabels[i].height / 2,
        ),
      );
    }
    // The time axis: adaptive ticks with their dates.
    final dates = timeTicks(start, to);
    var lastLabelRight = plot.left - 1;
    for (final d in dates) {
      final tx = x(d);
      canvas.drawLine(
        Offset(tx, plot.bottom),
        Offset(tx, plot.bottom + 4),
        axis,
      );
      final label = _text(dateFormat(d), 10);
      final dx = (tx - label.width / 2).clamp(
        plot.left,
        plot.right - label.width,
      );
      if (dx > lastLabelRight + 6) {
        label.paint(canvas, Offset(dx, plot.bottom + 10));
        lastLabelRight = dx + label.width;
      }
    }

    final tick = Paint()
      ..color = tickColor
      ..strokeWidth = 2;
    for (final a in appointments) {
      final ax = x(a);
      canvas.drawLine(
        Offset(ax, plot.bottom),
        Offset(ax, plot.bottom + 8),
        tick,
      );
    }
    final line = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    Path pathOf(List<GraphPoint> pts) {
      final path = Path();
      for (var i = 0; i < pts.length; i++) {
        final o = Offset(x(pts[i].at), y(pts[i].value));
        if (i == 0) {
          path.moveTo(o.dx, o.dy);
        } else {
          path.lineTo(o.dx, o.dy);
        }
      }
      return path;
    }

    if (smooth && points.length >= 2) {
      // The smooth line carries the shape; each reading hangs on it by
      // a thin stem, so the scatter stays visible without the zigzag.
      final curve = smoothCurve(points, start, to);
      final stem = Paint()
        ..color = lineColor.withValues(alpha: 0.45)
        ..strokeWidth = 1;
      double curveAt(DateTime at) {
        final t = at.millisecondsSinceEpoch;
        for (var i = 1; i < curve.length; i++) {
          final a = curve[i - 1].at.millisecondsSinceEpoch;
          final b = curve[i].at.millisecondsSinceEpoch;
          if (t <= b) {
            final f = b == a ? 0.0 : (t - a) / (b - a);
            return curve[i - 1].value +
                (curve[i].value - curve[i - 1].value) * f;
          }
        }
        return curve.last.value;
      }

      for (final p in points) {
        final px = x(p.at);
        canvas.drawLine(
          Offset(px, y(p.value)),
          Offset(px, y(curveAt(p.at))),
          stem,
        );
      }
      canvas.drawPath(pathOf(curve), line..strokeWidth = 2.5);
      line.strokeWidth = 2;
    } else {
      canvas.drawPath(pathOf(points), line);
    }
    if (trend) {
      if (trendLine(points, start, to) case final fit?) {
        final dash = Paint()
          ..color = textColor.withValues(alpha: 0.6)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;
        final a = Offset(x(start), y(fit.atFrom.clamp(lo, hi)));
        final b = Offset(x(to), y(fit.atTo.clamp(lo, hi)));
        final total = (b - a).distance;
        const on = 8.0, off = 5.0;
        var d = 0.0;
        while (d < total) {
          final s0 = a + (b - a) * (d / total);
          final s1 = a + (b - a) * (math.min(d + on, total) / total);
          canvas.drawLine(s0, s1, dash);
          d += on + off;
        }
      }
    }

    final dot = Paint()..color = lineColor;
    if (smooth) {
      for (final p in points) {
        canvas.drawCircle(Offset(x(p.at), y(p.value)), 2.5, dot);
      }
    }
    void label(GraphPoint p, {required bool above}) {
      final o = Offset(x(p.at), y(p.value));
      canvas.drawCircle(o, 4, dot);
      final painter = _text(format(p.value), 11);
      final dx = (o.dx - painter.width / 2).clamp(
        plot.left,
        plot.right - painter.width,
      );
      final dy = above ? o.dy - painter.height - 6 : o.dy + 6;
      painter.paint(canvas, Offset(dx, dy));
    }

    final minP = points.reduce((a, b) => a.value <= b.value ? a : b);
    final maxP = points.reduce((a, b) => a.value >= b.value ? a : b);
    label(maxP, above: true);
    if (!identical(minP, maxP)) label(minP, above: false);
    final last = points.last;
    if (!identical(last, minP) && !identical(last, maxP)) {
      label(last, above: last.value < (lo + hi) / 2);
    }
    // The window's edges, when no tick label sits there already.
    if (dates.isEmpty || x(dates.first) - plot.left > 60) {
      _text(
        dateFormat(start),
        10,
      ).paint(canvas, Offset(plot.left, plot.bottom + 10));
    }
    if (dates.isEmpty || plot.right - x(dates.last) > 60) {
      final painter = _text(dateFormat(to), 10);
      painter.paint(
        canvas,
        Offset(plot.right - painter.width, plot.bottom + 10),
      );
    }
  }

  @override
  bool shouldRepaint(GraphPainter old) =>
      old.points != points || old.from != from || old.to != to;
}
