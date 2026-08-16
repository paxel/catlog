import 'package:catalog_core/catalog_core.dart';

import '../l10n/app_localizations.dart';

/// Localized display for a canonical Clowder status value, or null when
/// the value is free text the app does not recognize.
String? statusDisplay(AppLocalizations t, String value) => switch (value) {
      'foster' => t.statusFoster,
      'forever-home' => t.statusForeverHome,
      'clinic' => t.statusClinic,
      'shelter' => t.statusShelter,
      'barn' => t.statusBarn,
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

/// Localized rendering of a stored value for a starter field's canonical
/// values (yes/no, gender options). Everything else displays as stored.
String fieldValueDisplay(AppLocalizations t, FieldDef? def, String? value) {
  if (value == null) return '—';
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
      'neutered' => t.starterNeutered,
      'pregnant' => t.starterPregnant,
      'birthdate' => t.starterBirthdate,
      'deceased' => t.starterDeceased,
      'species' => t.starterSpecies,
      'status' => t.starterStatus,
      'address' => t.starterAddress,
      'responsible' => t.starterResponsible,
      'position' => t.starterPosition,
      _ => null,
    };

/// Human-readable label for a raw field key, resolving user Fields
/// through their definitions and mapping reserved keys.
String fieldLabel(AppLocalizations t, CatalogStore store, String key) {
  if (key == Keys.name) return t.labelName;
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
    AppLocalizations t, CatalogStore store, String key, String? value) {
  if (value == null) return '—';
  if (key == Keys.clowder) {
    return store.current(value, Keys.name) ?? value;
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
  return fieldValueDisplay(t, def, value);
}
