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

  /// `yes` while the entity is Private: it and all its entries stay off
  /// the wire unless a sync explicitly includes private data. The marker
  /// itself travels only in such syncs.
  static const private = r'$private';

  /// Field-definition properties.
  static const fieldType = 'type';
  static const fieldScope = 'scope';
  static const fieldOptions = 'options';

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
enum FieldType { text, yesNo, date, number, choice, location, cat }

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

  const FieldDef({
    required this.id,
    required this.slug,
    required this.name,
    required this.type,
    required this.scope,
    this.options = const [],
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
];

/// Starter Fields seeded on first launch as ordinary entries, so a card
/// can be filled without any configuration.
const starterFields = [
  (slug: 'gender', name: 'Gender', type: FieldType.choice, scope: FieldScope.cat, options: ['female', 'male', 'unknown']),
  (slug: 'color', name: 'Color', type: FieldType.text, scope: FieldScope.cat, options: <String>[]),
  (slug: 'breed', name: 'Breed', type: FieldType.choice, scope: FieldScope.cat, options: ['European Shorthair', 'Maine Coon', 'British Shorthair', 'Norwegian Forest Cat', 'Ragdoll', 'Siamese', 'Persian', 'Bengal', 'Sphynx', 'mixed']),
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
  (slug: 'position', name: 'Position', type: FieldType.location, scope: FieldScope.both, options: <String>[]),
];
