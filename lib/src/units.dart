import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// The device's unit system (#96): `auto` follows the region of the
/// device locale (the US, Liberia and Myanmar count in pounds), or the
/// keeper picks one. Device-local, never synced — the catalog stores
/// base units, every device shows its own.
final ValueNotifier<UnitSystem> unitSystem = ValueNotifier(UnitSystem.metric);

const unitsSettingKey = 'units';

UnitSystem unitSystemFor(String? setting, Locale locale) {
  switch (setting) {
    case 'metric':
      return UnitSystem.metric;
    case 'imperial':
      return UnitSystem.imperial;
    default:
      return const {'US', 'LR', 'MM'}.contains(locale.countryCode)
          ? UnitSystem.imperial
          : UnitSystem.metric;
  }
}

/// Applies the stored preference for [locale]; called at start and
/// after the keeper changes either.
void applyUnitSystem(CatalogStore store, Locale locale) {
  unitSystem.value = unitSystemFor(store.localSetting(unitsSettingKey), locale);
}

/// A stored base amount in the device's unit, formatted for [locale]:
/// "4,25 kg" in German, "9.4 lb" on an imperial device.
String formatUnitValue(String locale, Dimension d, String? stored) {
  final base = stored == null ? null : double.tryParse(stored);
  if (base == null) return stored ?? '';
  final p = displayParts(d, unitSystem.value, base);
  final number = NumberFormat.decimalPatternDigits(
    locale: locale,
    decimalDigits: p.decimals,
  ).format(p.amount);
  return '$number ${p.unit}';
}
