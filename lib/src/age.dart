import 'package:catalog_core/catalog_core.dart';

import 'l10n.dart';

/// A cat's age from its birth date, as far as the date's precision
/// allows (#80): "3 yrs 5 mo" for a day or month, "3 yrs" for a bare
/// year, "5 mo" under a year. With a Deceased date the age is the one
/// reached then, marked "†". Null without a usable birth date.
String? ageDisplay(
  AppLocalizations t,
  CatalogStore store,
  String catId, {
  DateTime? today,
}) {
  final born = PartialDate.parse(
    store.current(catId, Keys.userField('birthdate')),
  );
  if (born == null) return null;
  final died = PartialDate.parse(
    store.current(catId, Keys.userField('deceased')),
  );
  final at = died?.latest ?? today ?? DateTime.now();
  final age = born.ageAt(at);
  if (age == null) return null;
  final parts = [
    if (age.years > 0 || age.months == null) t.ageYears(age.years),
    if (age.months != null && (age.months! > 0 || age.years == 0))
      t.ageMonths(age.months!),
  ];
  return died == null ? parts.join(' ') : '${parts.join(' ')} †';
}
