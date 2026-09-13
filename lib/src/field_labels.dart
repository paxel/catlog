import 'package:catalog_core/catalog_core.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import 'value_words.dart';
import 'units.dart';
import 'looks_labels.dart';
import 'plus_code.dart';

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
  // A number reads with the device's decimal mark.
  if (def?.type == FieldType.number) {
    final n = double.tryParse(value.replaceAll(',', '.'));
    if (n != null) return formatNumber(t.localeName, n, 6);
  }
  // A Unit Value is stored in the base unit and read in the device's.
  if (def?.type == FieldType.unitValue) {
    return formatUnitValue(
        t.localeName, def!.unitDimension, value);
  }
  // Looks read as group: values, in the device language.
  if (def?.type == FieldType.tags) return looksDisplay(t, value);
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
      'Abyssinian' => t.breedAbyssinian,
      'American Shorthair' => t.breedAmericanShorthair,
      'Balinese' => t.breedBalinese,
      'Birman' => t.breedBirman,
      'Bombay' => t.breedBombay,
      'Burmese' => t.breedBurmese,
      'Burmilla' => t.breedBurmilla,
      'British Longhair' => t.breedBritishLonghair,
      'Chartreux' => t.breedChartreux,
      'Cornish Rex' => t.breedCornishRex,
      'Devon Rex' => t.breedDevonRex,
      'Egyptian Mau' => t.breedEgyptianMau,
      'Exotic Shorthair' => t.breedExoticShorthair,
      'Himalayan' => t.breedHimalayan,
      'Korat' => t.breedKorat,
      'Manx' => t.breedManx,
      'Munchkin' => t.breedMunchkin,
      'Ocicat' => t.breedOcicat,
      'Oriental Shorthair' => t.breedOrientalShorthair,
      'Ragamuffin' => t.breedRagamuffin,
      'Russian Blue' => t.breedRussianBlue,
      'Savannah' => t.breedSavannah,
      'Scottish Fold' => t.breedScottishFold,
      'Selkirk Rex' => t.breedSelkirkRex,
      'Siberian' => t.breedSiberian,
      'Snowshoe' => t.breedSnowshoe,
      'Somali' => t.breedSomali,
      'Tonkinese' => t.breedTonkinese,
      'Turkish Angora' => t.breedTurkishAngora,
      'Turkish Van' => t.breedTurkishVan,
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
  }
  if (def?.slug == 'species') return speciesDisplay(t, value);
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
  'weight' => t.starterWeight,
  'looks' => t.starterLooks,
  _ => null,
};

/// Human-readable label for a raw field key, resolving user Fields
/// through their definitions and mapping reserved keys.
String fieldLabel(AppLocalizations t, CatalogStore store, String key) {
  if (key == Keys.name) return t.labelName;
  // Privacy bookkeeping reads as the field it belongs to, marked.
  if (key == Keys.private) return t.privateLabel;
  if (key.startsWith(Keys.privatePrefix)) {
    return t.privateMarker(
        fieldLabel(t, store, key.substring(Keys.privatePrefix.length)));
  }
  if (key.startsWith(Keys.withheldPrefix)) {
    return t.privateMarker(
        fieldLabel(t, store, key.substring(Keys.withheldPrefix.length)));
  }
  if (key.startsWith(Keys.appointmentPrefix)) return t.appointmentLabel;
  if (key.startsWith(Keys.chorePrefix)) {
    return key.substring(Keys.chorePrefix.length).contains('@')
        ? t.choreTickLabel
        : t.choreLabel;
  }
  if (key == Keys.personTitle) return t.titleLabel;
  if (key == Keys.deleted) return t.deletedLabel;
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
  // Documents and codes speak in the app's words; an unknown document
  // reads as key and value lines rather than one line of JSON.
  if (storedValueWords(t, key, value) case final words?) return words;
  if (documentWords(value) case final lines?) return lines;
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
  // History, arrivals and conflicts need the position itself, not a
  // "see the map": coordinates and the plus code, readable anywhere.
  if (def?.type == FieldType.location || key == CatalogStore.positionKey) {
    if (CatalogStore.parsePosition(value) case final pos?) {
      return '${pos.$1.toStringAsFixed(5)}, ${pos.$2.toStringAsFixed(5)}'
          ' · ${encodePlusCode(pos.$1, pos.$2)}';
    }
  }
  return fieldValueDisplay(t, def, value);
}

/// Localized name of a Unit Value's dimension.
String dimensionName(AppLocalizations t, Dimension d) => switch (d) {
      Dimension.weight => t.dimensionWeight,
      Dimension.length => t.dimensionLength,
      Dimension.volume => t.dimensionVolume,
      Dimension.temperature => t.dimensionTemperature,
    };

/// Localized display of a species preset; anything else as typed.
String speciesDisplay(AppLocalizations t, String value) => switch (value) {
      'cat' => t.valueCat,
      'dog' => t.valueDog,
      'rabbit' => t.valueRabbit,
      'guinea pig' => t.valueGuineaPig,
      'hamster' => t.valueHamster,
      'bird' => t.valueBird,
      'horse' => t.valueHorse,
      'tortoise' => t.valueTortoise,
      'ferret' => t.valueFerret,
      _ => value,
    };
