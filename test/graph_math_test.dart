import 'package:catlog/src/screens/field_graph_screen.dart';
import 'package:flutter_test/flutter_test.dart';

/// The smoothed line and the trend line: a flat series stays flat, a
/// straight climb comes back exactly, and the change per month reads.
void main() {
  final from = DateTime(2026, 1, 1);
  final to = DateTime(2026, 7, 1);

  test('a flat series smooths to itself', () {
    final points = [
      for (var m = 1; m <= 6; m++) (at: DateTime(2026, m, 1), value: 4.0),
    ];
    final curve = smoothCurve(points, from, to, samples: 10);
    expect(curve.length, 11);
    for (final p in curve) {
      expect(p.value, closeTo(4.0, 1e-9));
    }
  });

  test('smoothing flattens a zigzag but keeps the level', () {
    final points = [
      for (var d = 0; d < 30; d++)
        (at: from.add(Duration(days: d)), value: d.isEven ? 4.0 : 4.4),
    ];
    final curve = smoothCurve(points, from, from.add(const Duration(days: 30)));
    final values = curve.map((p) => p.value).toList();
    final spread =
        values.reduce((a, b) => a > b ? a : b) -
        values.reduce((a, b) => a < b ? a : b);
    expect(spread, lessThan(0.1));
    expect(values.first, closeTo(4.2, 0.1));
  });

  test('the trend of a straight climb is the climb', () {
    // 100 g every 10 days: 304.4 g a month.
    final points = [
      for (var i = 0; i < 6; i++)
        (at: from.add(Duration(days: 10 * i)), value: 4.0 + 0.1 * i),
    ];
    final fit = trendLine(points, from, from.add(const Duration(days: 50)))!;
    expect(fit.atFrom, closeTo(4.0, 1e-9));
    expect(fit.atTo, closeTo(4.5, 1e-9));
    expect(fit.perMonth, closeTo(0.3044, 1e-6));
  });

  test('no trend from one reading or one moment', () {
    expect(trendLine([(at: from, value: 4.0)], from, to), isNull);
    expect(
      trendLine([(at: from, value: 4.0), (at: from, value: 4.2)], from, to),
      isNull,
    );
  });
}
