import 'dart:math' as math;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../field_labels.dart';
import '../l10n.dart';
import '../layout.dart';
import '../units.dart';
import '../widgets/date_entry.dart';

/// One value of a field's history as the graph draws it: the moment and
/// the number in the device's unit.
typedef GraphPoint = ({DateTime at, double value});

/// The ranges a graph can show; the last choice is kept per device.
enum GraphRange { week, month, year, all, custom }

const graphRangeKey = 'graphRange';
const graphRangeFromKey = 'graphRange:from';
const graphRangeToKey = 'graphRange:to';

/// The numeric history of [def] on [entityId], oldest first, in the
/// device's entry unit for a Unit Value. Non-numbers are skipped.
List<GraphPoint> graphPoints(
    CatalogStore store, String entityId, FieldDef def) {
  final points = <GraphPoint>[];
  for (final e in store.fieldHistory(entityId, def.key).reversed) {
    final raw = e.value == null ? null : double.tryParse(e.value!);
    if (raw == null) continue;
    final value = def.type == FieldType.unitValue
        ? fromBase(def.dimension ?? Dimension.weight, unitSystem.value, raw)
        : raw;
    points.add((at: e.date, value: value));
  }
  return points;
}

/// How many values of [def] on [entityId] a graph could draw.
int graphablePoints(CatalogStore store, String entityId, FieldDef def) =>
    def.type == FieldType.number || def.type == FieldType.unitValue
        ? graphPoints(store, entityId, def).length
        : 0;

/// The points inside [from]..[to] (both inclusive; null = open).
List<GraphPoint> pointsBetween(
        List<GraphPoint> points, DateTime? from, DateTime? to) =>
    [
      for (final p in points)
        if ((from == null || !p.at.isBefore(from)) &&
            (to == null || !p.at.isAfter(to)))
          p
    ];

/// A field's history as a curve (#97): range chips, the change since
/// the previous value, min, max and latest marked, the animal's
/// appointments as ticks under the time axis.
class FieldGraphScreen extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final FieldDef def;

  const FieldGraphScreen(
      {super.key,
      required this.store,
      required this.entityId,
      required this.def});

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
            DateTime.tryParse(store.localSetting(graphRangeFromKey) ?? ''),
            DateTime.tryParse(store.localSetting(graphRangeToKey) ?? '')
                ?.add(const Duration(days: 1)),
          ),
      };

  Future<void> _pick(GraphRange range) async {
    if (range == GraphRange.custom) {
      final from = await pickDay(context,
          initial: DateTime.tryParse(
                  store.localSetting(graphRangeFromKey) ?? '') ??
              DateTime.now().subtract(const Duration(days: 30)));
      if (from == null || !mounted) return;
      final to = await pickDay(context,
          initial:
              DateTime.tryParse(store.localSetting(graphRangeToKey) ?? '') ??
                  DateTime.now());
      if (to == null || !mounted) return;
      store.setLocalSetting(
          graphRangeFromKey, from.toIso8601String().substring(0, 10));
      store.setLocalSetting(
          graphRangeToKey, to.toIso8601String().substring(0, 10));
    }
    store.setLocalSetting(graphRangeKey, range.name);
    setState(() {});
  }

  String _unit() => widget.def.type == FieldType.unitValue
      ? entryUnit(widget.def.dimension ?? Dimension.weight, unitSystem.value)
      : '';

  String _number(double v) {
    final text = v.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');
    final unit = _unit();
    return unit.isEmpty ? text : '$text $unit';
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
        if ((from == null || !a.date.isBefore(from)) &&
            (to == null || !a.date.isAfter(to)))
          a.date
    ];
    final latest = all.isEmpty ? null : all.last;
    final previous = all.length < 2 ? null : all[all.length - 2];
    final current = store.current(widget.entityId, widget.def.key);
    return Scaffold(
      appBar: roomyAppBar(context,
          title: Text(fieldDefName(t, widget.def))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(fieldValueDisplay(t, widget.def, current),
            style: Theme.of(context).textTheme.headlineMedium),
        if (latest != null && previous != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              t.changeSince(
                  '${latest.value - previous.value >= 0 ? '+' : ''}'
                  '${_number(latest.value - previous.value)}',
                  DateFormat.yMd(locale).format(previous.at)),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: [
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
        ]),
        const SizedBox(height: 12),
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
            ),
          ),
        ),
        if (shown.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(t.searchNoResults,
                style: Theme.of(context).textTheme.bodySmall),
          ),
      ]),
    );
  }
}

/// The curve: time left to right, value bottom to top, min, max and the
/// latest point labelled, appointment ticks along the bottom.
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
  });

  @override
  void paint(Canvas canvas, Size size) {
    const left = 8.0, right = 8.0, top = 20.0, bottom = 28.0;
    final plot = Rect.fromLTRB(left, top, size.width - right, size.height - bottom);
    final textColor = labelStyle.color ?? Colors.black;
    final axis = Paint()
      ..color = textColor.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    canvas.drawLine(plot.bottomLeft, plot.bottomRight, axis);
    if (points.isEmpty || from == null) return;
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
    double x(DateTime d) =>
        plot.left + plot.width * d.difference(start).inMilliseconds / spanMs;
    double y(double v) => plot.bottom - plot.height * (v - lo) / (hi - lo);

    final tick = Paint()
      ..color = tickColor
      ..strokeWidth = 2;
    for (final a in appointments) {
      final ax = x(a);
      canvas.drawLine(Offset(ax, plot.bottom), Offset(ax, plot.bottom + 8), tick);
    }
    final line = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final o = Offset(x(points[i].at), y(points[i].value));
      if (i == 0) {
        path.moveTo(o.dx, o.dy);
      } else {
        path.lineTo(o.dx, o.dy);
      }
    }
    canvas.drawPath(path, line);

    final dot = Paint()..color = lineColor;
    void label(GraphPoint p, {required bool above}) {
      final o = Offset(x(p.at), y(p.value));
      canvas.drawCircle(o, 4, dot);
      final painter = TextPainter(
        text: TextSpan(
            text: format(p.value), style: labelStyle.copyWith(fontSize: 11)),
        textDirection: TextDirection.ltr,
      )..layout();
      final dx = (o.dx - painter.width / 2).clamp(plot.left, plot.right - painter.width);
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
    // First and last date under the axis.
    for (final (d, alignRight) in [(start, false), (to, true)]) {
      final painter = TextPainter(
        text: TextSpan(
            text: dateFormat(d), style: labelStyle.copyWith(fontSize: 10)),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
          canvas,
          Offset(alignRight ? plot.right - painter.width : plot.left,
              plot.bottom + 10));
    }
  }

  @override
  bool shouldRepaint(GraphPainter old) =>
      old.points != points || old.from != from || old.to != to;
}
