/// Reserved field keys. User-defined fields are keyed `f:<slug>`.
abstract final class Keys {
  /// Entity kind: `cat`, `clowder`, or `fielddef`.
  static const type = r'$type';

  /// `true` when the entity is deleted (hidden everywhere).
  static const deleted = r'$deleted';

  /// Alias merge (see docs/adr and .scratch/m2-notes.md): set on the
  /// LOSER, value = survivor entity id. Reads resolve the chain.
  static const mergedInto = r'$mergedInto';

  /// Concurrent-edit flag for one field: `$conflict:<field>` with value
  /// `open` or `resolved`. An ordinary entry, so badges AND their
  /// resolution propagate to every device.
  static const conflictPrefix = r'$conflict:';

  static String conflict(String field) => '$conflictPrefix$field';

  /// Display name of a Cat, Clowder, or field definition.
  static const name = 'name';

  /// A Cat's Clowder membership; `null` value means Stray.
  static const clowder = 'clowder';

  /// A Cat's chosen profile image (content hash).
  static const profileImage = r'$profile';

  /// Per-image presence marker: `$image:<hash>`, value `added`/`deleted`.
  static const imagePrefix = r'$image:';

  /// `yes` while the entity is Private: every value it carries is
  /// private, and values added later start private too. The marker
  /// itself travels only in syncs that include private data.
  static const private = r'$private';

  /// Per-value privacy: `$private:<field>` with value `yes` or `no`.
  /// Privacy belongs to the value, not to the entity and not to the
  /// field definition — a clowder's phone number can stay home while
  /// its name travels. Never leaves the device.
  static const privatePrefix = r'$private:';

  /// The public trace of a withheld value: `$withheld:<field>` = `yes`
  /// tells a partner that a value exists here without carrying it, so
  /// the slot reads "redacted" instead of "empty". Travels in every
  /// sync; the value itself only travels in a private-included one.
  static const withheldPrefix = r'$withheld:';

  static String privateField(String field) => '$privatePrefix$field';

  static String withheld(String field) => '$withheldPrefix$field';

  /// An appointment on a cat or clowder (#75): `$appt:<id>` holds one
  /// small JSON document per appointment; later entries on the same key
  /// edit, finish or delete it.
  static const appointmentPrefix = r'$appt:';
  static String appointment(String id) => '$appointmentPrefix$id';

  /// Fields that carry no personal detail and hold the catalog together:
  /// without them a partner receives rows pointing at entities they have
  /// never heard of. Never private, on any entity.
  static bool isStructural(String field) =>
      field == type ||
      field == name ||
      field == clowder ||
      field == deleted ||
      field == mergedInto ||
      field == private ||
      field.startsWith(privatePrefix) ||
      field.startsWith(withheldPrefix) ||
      field.startsWith(conflictPrefix);

  /// Field-definition properties.
  static const fieldType = 'type';
  static const fieldScope = 'scope';
  static const fieldOptions = 'options';
  static const fieldIdDisplay = 'iddisplay';

  /// Lookup URL template of an ID field: the service's page with
  /// `{value}` where the identifier goes (see registry.dart).
  static const fieldLookupUrl = 'lookup';

  static String image(String hash) => '$imagePrefix$hash';
  static String userField(String slug) => 'f:$slug';
}

/// Entity kinds stored under [Keys.type].
abstract final class Kinds {
  static const cat = 'cat';
  static const clowder = 'clowder';
  static const fieldDef = 'fielddef';
}

/// The type of a user-defined Field (see CONTEXT.md: Field).
enum FieldType { text, yesNo, date, number, choice, location, cat, id }

/// What a position entry records: a live sighting, or where a
/// missing-cat flier hangs (#30). Flier positions never render as
/// sighting pins.
enum PositionKind { sighting, flier }

/// How an ID Field renders on the Card: plain text, QR, or 1D barcode.
enum IdDisplay { plain, qr, barcode }

/// Canonical form for matching ID values: matching is exact after
/// normalization (trim, case-fold, strip spaces and hyphens) — never
/// fuzzy (#28).
String normalizeId(String value) =>
    value.trim().toLowerCase().replaceAll(RegExp(r'[\s-]+'), '');

/// Where a Field is offered in the UI. Values are still stored uniformly.
enum FieldScope { cat, clowder, both }

/// A global, typed Field definition — itself projected from entries.
class FieldDef {
  final String id; // entity id: fielddef:<slug>
  final String slug;
  final String name;
  final FieldType type;
  final FieldScope scope;
  final List<String> options; // for FieldType.choice
  final IdDisplay idDisplay; // for FieldType.id

  /// Where this ID can be looked up, as a URL template with `{value}`.
  /// Null for fields that belong to no service.
  final String? lookupUrl; // for FieldType.id

  const FieldDef({
    required this.id,
    required this.slug,
    required this.name,
    required this.type,
    required this.scope,
    this.options = const [],
    this.idDisplay = IdDisplay.plain,
    this.lookupUrl,
  });

  /// The key under which values of this Field live on Cats/Clowders.
  String get key => Keys.userField(slug);
}

/// Canonical Clowder status values the app recognizes (chips, adoption
/// trigger). Free text beyond these stays an ordinary value.
const clowderStatusKeys = [
  'foster',
  'forever-home',
  'clinic',
  'shelter',
  'barn',
  'owner',
];

/// Starter Fields seeded on first launch as ordinary entries, so a card
/// can be filled without any configuration.
const starterFields = [
  (slug: 'gender', name: 'Gender', type: FieldType.choice, scope: FieldScope.cat, options: ['female', 'male', 'unknown']),
  (slug: 'color', name: 'Color', type: FieldType.text, scope: FieldScope.cat, options: <String>[]),
  (slug: 'breed', name: 'Breed', type: FieldType.choice, scope: FieldScope.cat, options: ['European Shorthair', 'Maine Coon', 'British Shorthair', 'Norwegian Forest Cat', 'Ragdoll', 'Siamese', 'Persian', 'Bengal', 'Sphynx', 'mixed']),
  (slug: 'chipid', name: 'Chip ID', type: FieldType.id, scope: FieldScope.cat, options: <String>[]),
  (slug: 'neutered', name: 'Neutered', type: FieldType.yesNo, scope: FieldScope.cat, options: <String>[]),
  (slug: 'pregnant', name: 'Pregnant', type: FieldType.yesNo, scope: FieldScope.cat, options: <String>[]),
  (slug: 'birthdate', name: 'Birth date', type: FieldType.date, scope: FieldScope.cat, options: <String>[]),
  (slug: 'deceased', name: 'Deceased', type: FieldType.date, scope: FieldScope.cat, options: <String>[]),
  (slug: 'species', name: 'Species', type: FieldType.text, scope: FieldScope.cat, options: <String>[]),
  (slug: 'mother', name: 'Mother', type: FieldType.cat, scope: FieldScope.cat, options: <String>[]),
  (slug: 'father', name: 'Father', type: FieldType.cat, scope: FieldScope.cat, options: <String>[]),
  (slug: 'status', name: 'Status', type: FieldType.choice, scope: FieldScope.clowder, options: clowderStatusKeys),
  (slug: 'address', name: 'Address', type: FieldType.text, scope: FieldScope.clowder, options: <String>[]),
  (slug: 'responsible', name: 'Responsible person', type: FieldType.text, scope: FieldScope.clowder, options: <String>[]),
  (slug: 'email', name: 'Email', type: FieldType.text, scope: FieldScope.clowder, options: <String>[]),
  (slug: 'phone', name: 'Phone', type: FieldType.text, scope: FieldScope.clowder, options: <String>[]),
  (slug: 'position', name: 'Position', type: FieldType.location, scope: FieldScope.both, options: <String>[]),
  (slug: 'remarks', name: 'Remarks', type: FieldType.text, scope: FieldScope.both, options: <String>[]),
];
