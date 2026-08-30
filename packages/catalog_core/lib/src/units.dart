// Unit Values (#96): a number kept in the app's base unit, shown in the
// device's unit. Storage never changes with the device; only display
// and entry do.

/// What a Unit Value measures, with its base unit.
enum Dimension {
  weight('g'),
  length('cm'),
  volume('ml'),
  temperature('°C');

  final String baseUnit;
  const Dimension(this.baseUnit);
}

/// The device's side: metric (kg, cm, ml, °C) or imperial (lb, in,
/// fl oz, °F).
enum UnitSystem { metric, imperial }

/// The unit a keeper types in for [d] on a [s] device.
String entryUnit(Dimension d, UnitSystem s) => switch ((d, s)) {
      (Dimension.weight, UnitSystem.metric) => 'kg',
      (Dimension.weight, UnitSystem.imperial) => 'lb',
      (Dimension.length, UnitSystem.metric) => 'cm',
      (Dimension.length, UnitSystem.imperial) => 'in',
      (Dimension.volume, UnitSystem.metric) => 'ml',
      (Dimension.volume, UnitSystem.imperial) => 'fl oz',
      (Dimension.temperature, UnitSystem.metric) => '°C',
      (Dimension.temperature, UnitSystem.imperial) => '°F',
    };

const _gPerLb = 453.59237;
const _cmPerIn = 2.54;
const _mlPerFlOz = 29.5735295625;

/// A typed value in [entryUnit] as the stored base amount.
double toBase(Dimension d, UnitSystem s, double entry) => switch ((d, s)) {
      (Dimension.weight, UnitSystem.metric) => entry * 1000,
      (Dimension.weight, UnitSystem.imperial) => entry * _gPerLb,
      (Dimension.length, UnitSystem.metric) => entry,
      (Dimension.length, UnitSystem.imperial) => entry * _cmPerIn,
      (Dimension.volume, UnitSystem.metric) => entry,
      (Dimension.volume, UnitSystem.imperial) => entry * _mlPerFlOz,
      (Dimension.temperature, UnitSystem.metric) => entry,
      (Dimension.temperature, UnitSystem.imperial) => (entry - 32) * 5 / 9,
    };

/// The stored base amount in [entryUnit].
double fromBase(Dimension d, UnitSystem s, double base) => switch ((d, s)) {
      (Dimension.weight, UnitSystem.metric) => base / 1000,
      (Dimension.weight, UnitSystem.imperial) => base / _gPerLb,
      (Dimension.length, UnitSystem.metric) => base,
      (Dimension.length, UnitSystem.imperial) => base / _cmPerIn,
      (Dimension.volume, UnitSystem.metric) => base,
      (Dimension.volume, UnitSystem.imperial) => base / _mlPerFlOz,
      (Dimension.temperature, UnitSystem.metric) => base,
      (Dimension.temperature, UnitSystem.imperial) => base * 9 / 5 + 32,
    };

/// The stored form of a base amount: at most one decimal, no trailing
/// zeros — "4250", "4263.6".
String baseString(double base) {
  final rounded = (base * 10).round() / 10;
  if (rounded == rounded.roundToDouble()) return rounded.round().toString();
  return rounded.toStringAsFixed(1);
}

/// A typed number, comma or point — null when it is not one.
double? parseEntry(String text) =>
    double.tryParse(text.trim().replaceAll(',', '.'));

/// How to show a stored amount: the number, its unit, and how many
/// decimals read well — "4.25 kg", "980 g", "9.4 lb", "1.2 m".
({double amount, String unit, int decimals}) displayParts(
    Dimension d, UnitSystem s, double base) {
  switch ((d, s)) {
    case (Dimension.weight, UnitSystem.metric):
      return base >= 1000
          ? (amount: base / 1000, unit: 'kg', decimals: 2)
          : (amount: base, unit: 'g', decimals: 0);
    case (Dimension.weight, UnitSystem.imperial):
      return (amount: base / _gPerLb, unit: 'lb', decimals: 1);
    case (Dimension.length, UnitSystem.metric):
      return base >= 100
          ? (amount: base / 100, unit: 'm', decimals: 2)
          : (amount: base, unit: 'cm', decimals: 1);
    case (Dimension.length, UnitSystem.imperial):
      return (amount: base / _cmPerIn, unit: 'in', decimals: 1);
    case (Dimension.volume, UnitSystem.metric):
      return base >= 1000
          ? (amount: base / 1000, unit: 'l', decimals: 2)
          : (amount: base, unit: 'ml', decimals: 0);
    case (Dimension.volume, UnitSystem.imperial):
      return (amount: base / _mlPerFlOz, unit: 'fl oz', decimals: 1);
    case (Dimension.temperature, UnitSystem.metric):
      return (amount: base, unit: '°C', decimals: 1);
    case (Dimension.temperature, UnitSystem.imperial):
      return (amount: base * 9 / 5 + 32, unit: '°F', decimals: 1);
  }
}

/// Plain display with a point as decimal separator; the app formats
/// per locale on top of [displayParts].
String formatBase(Dimension d, UnitSystem s, String? stored) {
  final base = stored == null ? null : double.tryParse(stored);
  if (base == null) return stored ?? '';
  final p = displayParts(d, s, base);
  var text = p.amount.toStringAsFixed(p.decimals);
  if (p.decimals > 0) {
    text = text.replaceFirst(RegExp(r'\.?0+$'), '');
  }
  return '$text ${p.unit}';
}
