import 'package:catalog_core/catalog_core.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

/// Localized display for a canonical Clowder status value, or null when
/// the value is free text the app does not recognize.
String? statusDisplay(AppLocalizations t, String value) => switch (value) {
  'foster' => t.statusFoster,
  'forever-home' => t.statusForeverHome,
  'clinic' => t.statusClinic,
  'shelter' => t.statusShelter,
  'barn' => t.statusBarn,
  'owner' => t.statusOwner,
  _ => null,
};

/// Display-time translation of starter Fields (ADR-0005): seeded names
/// and canonical values stay English in the data; the UI shows the
/// device language — unless the user renamed the field, then the typed
/// name wins everywhere, untranslated.
String fieldDefName(AppLocalizations t, FieldDef def) {
  final canonical = _canonicalName(def.slug);
  if (canonical != null && def.name == canonical) {
    return _translatedName(t, def.slug) ?? def.name;
  }
  return def.name;
}

/// A partial date in the device's format at its own precision: a day
/// as `14/05/2021`, a month as `May 2021`, a year as `2021` (#76).
String formatPartialDate(String locale, PartialDate date) {
  if (date.day != null) return DateFormat.yMd(locale).format(date.earliest);
  if (date.month != null) return DateFormat.yMMM(locale).format(date.earliest);
  return DateFormat.y(locale).format(date.earliest);
}

/// Localized rendering of a stored value for a starter field's canonical
/// values (yes/no, gender options). Everything else displays as stored.
String fieldValueDisplay(AppLocalizations t, FieldDef? def, String? value) {
  if (value == null) return '—';
  // Coordinates never face the user: positions live on the map.
  if (def?.type == FieldType.location) return t.onMapLabel;
  // Dates are stored ISO but read in the device's format — a year or a
  // month shows as such, never as an invented first day (#76).
  if (def?.type == FieldType.date) {
    final date = PartialDate.parse(value);
    if (date != null) return formatPartialDate(t.localeName, date);
  }
  if (def?.slug == 'breed') {
    return switch (value) {
      'European Shorthair' => t.breedEuropeanShorthair,
      'Maine Coon' => t.breedMaineCoon,
      'British Shorthair' => t.breedBritishShorthair,
      'Norwegian Forest Cat' => t.breedNorwegianForestCat,
      'Ragdoll' => t.breedRagdoll,
      'Siamese' => t.breedSiamese,
      'Persian' => t.breedPersian,
      'Bengal' => t.breedBengal,
      'Sphynx' => t.breedSphynx,
      'mixed' => t.valueMixed,
      _ => value,
    };
  }
  switch (value) {
    case 'yes':
      return t.valueYes;
    case 'no':
      return t.valueNo;
    case 'female':
      return def?.slug == 'gender' ? t.valueFemale : value;
    case 'male':
      return def?.slug == 'gender' ? t.valueMale : value;
    case 'unknown':
      return def?.slug == 'gender' ? t.valueUnknown : value;
    case 'cat':
      return def?.slug == 'species' ? t.valueCat : value;
  }
  if (def?.slug == 'status') {
    return statusDisplay(t, value) ?? value;
  }
  return value;
}

String? _canonicalName(String slug) {
  for (final f in starterFields) {
    if (f.slug == slug) return f.name;
  }
  return null;
}

String? _translatedName(AppLocalizations t, String slug) => switch (slug) {
  'gender' => t.starterGender,
  'color' => t.starterColor,
  'breed' => t.starterBreed,
  'chipid' => t.starterChipId,
  'neutered' => t.starterNeutered,
  'pregnant' => t.starterPregnant,
  'birthdate' => t.starterBirthdate,
  'deceased' => t.starterDeceased,
  'species' => t.starterSpecies,
  'mother' => t.starterMother,
  'father' => t.starterFather,
  'status' => t.starterStatus,
  'address' => t.starterAddress,
  'responsible' => t.starterResponsible,
  'email' => t.starterEmail,
  'phone' => t.starterPhone,
  'position' => t.starterPosition,
  'remarks' => t.starterRemarks,
  _ => null,
};

/// Human-readable label for a raw field key, resolving user Fields
/// through their definitions and mapping reserved keys.
String fieldLabel(AppLocalizations t, CatalogStore store, String key) {
  if (key == Keys.name) return t.labelName;
  if (key.startsWith(Keys.appointmentPrefix)) return t.appointmentLabel;
  if (key == Keys.clowder) return t.clowderLabel;
  if (key == Keys.profileImage) return t.labelProfileImage;
  if (key.startsWith(Keys.imagePrefix)) return t.labelPhoto;
  for (final def in store.fieldDefs()) {
    if (def.key == store.canonicalKey(key)) return fieldDefName(t, def);
  }
  return key;
}

/// Human-readable rendering of a raw entry value for a field key.
String valueLabel(
  AppLocalizations t,
  CatalogStore store,
  String key,
  String? value,
) {
  if (value == null) return '—';
  if (key == Keys.clowder) {
    return store.current(value, Keys.name) ?? value;
  }
  if (key.startsWith(Keys.appointmentPrefix)) {
    // The stored document is JSON; the timeline shows the visit, not
    // the encoding.
    final a = Appointment.fromJson(
      key.substring(Keys.appointmentPrefix.length),
      '',
      value,
    );
    if (a == null) return value;
    final when = a.time == null
        ? ''
        : ' ${a.time!.hour.toString().padLeft(2, '0')}:'
              '${a.time!.minute.toString().padLeft(2, '0')}';
    return '${a.title}$when${a.done ? ' ✓' : ''}';
  }
  if (key.startsWith(Keys.imagePrefix)) return value;
  if (key == Keys.profileImage) return '·';
  FieldDef? def;
  for (final d in store.fieldDefs()) {
    if (d.key == store.canonicalKey(key)) {
      def = d;
      break;
    }
  }
  if (def?.type == FieldType.cat) {
    return store.current(store.resolveEntity(value), Keys.name) ?? value;
  }
  return fieldValueDisplay(t, def, value);
}
