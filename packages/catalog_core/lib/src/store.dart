import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:sqlite3/sqlite3.dart';

import 'entry.dart';
import 'fields.dart';

/// Author name stamped on entries the store seeds itself (starter Fields).
const seedAuthor = 'cat(a)log';

/// A Cat or Clowder as list rows want it: id plus current name.
class EntityView {
  final String id;
  final String name;
  const EntityView(this.id, this.name);
}

/// One arrival or departure in a Clowder's combined timeline.
class ClowderEvent {
  /// The underlying membership entry on the Cat.
  final Entry entry;
  final String catId;

  /// True: the cat arrived here. False: it left.
  final bool arrived;

  /// Where from (on arrival) or where to (on departure); null = Stray.
  final String? counterpart;

  const ClowderEvent(
      {required this.entry,
      required this.catId,
      required this.arrived,
      required this.counterpart});
}

/// The catalog: an append-only entry log over SQLite with a latest-wins
/// projection (ADR-0001). All reads and writes are synchronous.
///
/// Image bytes live outside the log in a content-addressed blob store —
/// a directory next to the database file, or memory for [inMemory] stores.
class CatalogStore {
  final Database _db;
  final _BlobStore _blobs;

  CatalogStore._(this._db, this._blobs);

  /// Opens an on-disk catalog, creating it if needed. Image blobs go to an
  /// `images` directory next to the database file.
  factory CatalogStore.open(String path) => _init(
        sqlite3.open(path),
        _FileBlobStore('${File(path).parent.path}/images'),
      );

  /// Opens a throwaway in-memory catalog (tests).
  factory CatalogStore.inMemory() =>
      _init(sqlite3.openInMemory(), _MemoryBlobStore());

  static CatalogStore _init(Database db, _BlobStore blobs) {
    db.execute('''
      PRAGMA journal_mode = WAL;
      CREATE TABLE IF NOT EXISTS entries (
        seq      INTEGER PRIMARY KEY AUTOINCREMENT,
        entity   TEXT NOT NULL,
        field    TEXT NOT NULL,
        value    TEXT,
        date     TEXT NOT NULL,
        author   TEXT NOT NULL,
        recorded TEXT NOT NULL
      );
      CREATE INDEX IF NOT EXISTS idx_entries_entity_field
        ON entries (entity, field);
      CREATE TABLE IF NOT EXISTS local_settings (
        key   TEXT PRIMARY KEY,
        value TEXT NOT NULL
      );
    ''');
    final store = CatalogStore._(db, blobs);
    store._seedStarterFields();
    return store;
  }

  void close() => _db.dispose();

  // ---------------------------------------------------------------- author

  /// The device's Author name; null until first-launch setup stored one.
  /// Device-local: lives outside the entry log and is never synced.
  String? get author {
    final rows =
        _db.select('SELECT value FROM local_settings WHERE key = ?', ['author']);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  set author(String? name) {
    if (name == null || name.trim().isEmpty) {
      throw ArgumentError('Author name must not be empty');
    }
    _db.execute(
      'INSERT INTO local_settings (key, value) VALUES (?, ?) '
      'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
      ['author', name.trim()],
    );
  }

  // ------------------------------------------------------------------- log

  /// Appends one immutable fact. [date] is the effective (backdatable)
  /// date and defaults to now. Uses the configured [author] unless [as]
  /// overrides it (seeding).
  void append(String entity, String field, String? value,
      {DateTime? date, String? as}) {
    final by = as ?? author;
    if (by == null) throw StateError('No author configured');
    final now = DateTime.now().toUtc();
    _db.execute(
      'INSERT INTO entries (entity, field, value, date, author, recorded) '
      'VALUES (?, ?, ?, ?, ?, ?)',
      [
        entity,
        field,
        value,
        (date?.toUtc() ?? now).toIso8601String(),
        by,
        now.toIso8601String(),
      ],
    );
  }

  Entry _entry(Row r) => Entry(
        seq: r['seq'] as int,
        entity: r['entity'] as String,
        field: r['field'] as String,
        value: r['value'] as String?,
        date: DateTime.parse(r['date'] as String),
        author: r['author'] as String,
        recorded: DateTime.parse(r['recorded'] as String),
      );

  /// Deterministic latest-wins ordering (ADR-0001): effective date, then
  /// recording time, then author name, then local sequence.
  static const _latest =
      'ORDER BY date DESC, recorded DESC, author DESC, seq DESC';

  /// Current value of one field, or null if never set or last set to null.
  String? current(String entity, String field) {
    final rows = _db.select(
      'SELECT * FROM entries WHERE entity = ? AND field = ? $_latest LIMIT 1',
      [entity, field],
    );
    return rows.isEmpty ? null : rows.first['value'] as String?;
  }

  /// Current value of every field of an entity.
  Map<String, String?> currentFields(String entity) {
    final rows = _db.select(
      'SELECT field, value FROM entries WHERE entity = ? $_latest',
      [entity],
    );
    final result = <String, String?>{};
    for (final r in rows) {
      result.putIfAbsent(r['field'] as String, () => r['value'] as String?);
    }
    return result;
  }

  /// Every entry of an entity, newest effective date first.
  List<Entry> timeline(String entity) => _db
      .select('SELECT * FROM entries WHERE entity = ? $_latest', [entity])
      .map(_entry)
      .toList();

  /// Every entry of one field of an entity, newest effective date first.
  List<Entry> fieldHistory(String entity, String field) => _db
      .select(
        'SELECT * FROM entries WHERE entity = ? AND field = ? $_latest',
        [entity, field],
      )
      .map(_entry)
      .toList();

  bool isDeleted(String entity) => current(entity, Keys.deleted) == 'true';

  /// True when [field] may be reverted from the history UI. Structural
  /// markers and photo entries are not revertable (photo bytes are gone
  /// for good once deleted).
  static bool isRevertable(String field) =>
      field != Keys.type &&
      field != Keys.deleted &&
      !field.startsWith(Keys.imagePrefix);

  /// Reverts one entry, git-style: appends the value that was current
  /// just before it — for its (entity, field) — as a NEW entry at the
  /// current time. Nothing is deleted; both the change and its undo
  /// stay in history. Returns the value that was restored.
  String? revertEntry(int seq) {
    final rows =
        _db.select('SELECT * FROM entries WHERE seq = ?', [seq]);
    if (rows.isEmpty) throw ArgumentError('No entry with seq $seq');
    final entry = _entry(rows.first);
    if (!isRevertable(entry.field)) {
      throw ArgumentError('Field ${entry.field} cannot be reverted');
    }
    // Predecessor: the latest entry for the same (entity, field) that
    // sorts strictly before the reverted one in projection order.
    final prev = _db.select(
      'SELECT * FROM entries WHERE entity = ? AND field = ? '
      'AND (date, recorded, author, seq) < (?, ?, ?, ?) $_latest LIMIT 1',
      [
        entry.entity,
        entry.field,
        entry.date.toIso8601String(),
        entry.recorded.toIso8601String(),
        entry.author,
        entry.seq,
      ],
    );
    final restored =
        prev.isEmpty ? null : prev.first['value'] as String?;
    append(entry.entity, entry.field, restored);
    return restored;
  }

  /// Ids of all non-deleted entities of a kind, oldest first.
  List<String> _entitiesOf(String kind) {
    final rows = _db.select(
      'SELECT DISTINCT entity FROM entries WHERE field = ? AND value = ? '
      'ORDER BY seq',
      [Keys.type, kind],
    );
    return [
      for (final r in rows)
        if (!isDeleted(r['entity'] as String)) r['entity'] as String
    ];
  }

  EntityView _view(String id) =>
      EntityView(id, current(id, Keys.name) ?? '(unnamed)');

  // -------------------------------------------------------------- clowders

  /// Creates a Clowder and returns its entity id.
  String createClowder(String name, {DateTime? date}) {
    final id = 'clowder:${_uuid()}';
    append(id, Keys.type, Kinds.clowder, date: date);
    append(id, Keys.name, name, date: date);
    return id;
  }

  /// All Clowders, creation order.
  List<EntityView> clowders() =>
      _entitiesOf(Kinds.clowder).map(_view).toList();

  // ------------------------------------------------------------------ cats

  /// Creates a Cat inside a Clowder and returns its entity id.
  String createCat(String name, {String? clowderId, DateTime? date}) {
    final id = 'cat:${_uuid()}';
    append(id, Keys.type, Kinds.cat, date: date);
    append(id, Keys.name, name, date: date);
    if (clowderId != null) append(id, Keys.clowder, clowderId, date: date);
    return id;
  }

  /// Cats currently in [clowderId], or every Cat when null.
  List<EntityView> cats({String? clowderId}) => [
        for (final id in _entitiesOf(Kinds.cat))
          if (clowderId == null || current(id, Keys.clowder) == clowderId)
            _view(id)
      ];

  /// Moves a Cat into a Clowder — adoption is exactly this — or, with
  /// null, records it leaving with no destination: the Cat becomes a
  /// Stray. Just an ordinary dated field change (see CONTEXT.md: Move).
  void moveCat(String catId, String? clowderId, {DateTime? date}) =>
      append(catId, Keys.clowder, clowderId, date: date);

  /// Cats currently in no Clowder (see CONTEXT.md: Stray).
  List<EntityView> strays() => [
        for (final id in _entitiesOf(Kinds.cat))
          if (current(id, Keys.clowder) == null) _view(id)
      ];

  /// A Cat arriving in or leaving a Clowder, derived from the Cat's
  /// membership history for one Clowder's combined timeline. [entry] is
  /// the underlying membership entry (revertable like any other).
  /// [counterpart] is where the cat came from / went to — a Clowder id,
  /// or null for Stray.
  List<ClowderEvent> clowderOccupancy(String clowderId) {
    final events = <ClowderEvent>[];
    final rows = _db.select(
      'SELECT DISTINCT entity FROM entries WHERE field = ?',
      [Keys.clowder],
    );
    for (final r in rows) {
      final catId = r['entity'] as String;
      final history = fieldHistory(catId, Keys.clowder).reversed;
      String? prev;
      for (final e in history) {
        if (e.value == clowderId && prev != clowderId) {
          events.add(ClowderEvent(
              entry: e, catId: catId, arrived: true, counterpart: prev));
        } else if (prev == clowderId && e.value != clowderId) {
          events.add(ClowderEvent(
              entry: e, catId: catId, arrived: false, counterpart: e.value));
        }
        prev = e.value;
      }
    }
    events.sort((a, b) => b.entry.date.compareTo(a.entry.date));
    return events;
  }

  /// Cats whose current name contains [query], case-insensitive —
  /// across all Clowders and Strays. Deleted Cats never appear.
  List<EntityView> searchCats(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return [
      for (final view in cats())
        if (view.name.toLowerCase().contains(q)) view
    ];
  }

  // ---------------------------------------------------------------- images

  /// Longest edge an imported photo keeps; larger photos are scaled down.
  /// 2560 px prints sharp on a Card and stays cheap to sync.
  static const maxImageEdge = 2560;

  /// Pure function: re-encodes a photo as JPEG, scaled to [maxImageEdge].
  /// CPU-heavy — call through `Isolate.run` from UI code.
  static Uint8List compressImage(Uint8List bytes) {
    var decoded = img.decodeImage(bytes);
    if (decoded == null) throw const FormatException('Not a decodable image');
    decoded = img.bakeOrientation(decoded);
    final edge = max(decoded.width, decoded.height);
    if (edge > maxImageEdge) {
      final scale = maxImageEdge / edge;
      decoded = img.copyResize(
        decoded,
        width: (decoded.width * scale).round(),
        height: (decoded.height * scale).round(),
        interpolation: img.Interpolation.average,
      );
    }
    return Uint8List.fromList(img.encodeJpg(decoded, quality: 85));
  }

  /// Stores an already-compressed JPEG for a Cat, content-addressed by
  /// SHA-256, and records it in the log. Returns the content hash.
  String addImage(String catId, Uint8List jpegBytes, {DateTime? date}) {
    final hash = sha256.convert(jpegBytes).toString();
    _blobs.put(hash, jpegBytes);
    append(catId, Keys.image(hash), 'added', date: date);
    return hash;
  }

  /// Content hashes of a Cat's images, oldest first, deleted ones excluded.
  List<String> images(String catId) {
    final rows = _db.select(
      'SELECT DISTINCT field FROM entries WHERE entity = ? AND field LIKE ? '
      'ORDER BY seq',
      [catId, '${Keys.imagePrefix}%'],
    );
    return [
      for (final r in rows)
        if (current(catId, r['field'] as String) == 'added')
          (r['field'] as String).substring(Keys.imagePrefix.length)
    ];
  }

  /// The stored bytes for a content hash, or null if unknown.
  Uint8List? imageBytes(String hash) => _blobs.get(hash);

  /// Marks [hash] as the Cat's Profile Image.
  void setProfileImage(String catId, String hash, {DateTime? date}) =>
      append(catId, Keys.profileImage, hash, date: date);

  /// The Cat's Profile Image: the chosen one, defaulting to the first
  /// (stable — it does not change as photos are added).
  String? profileImage(String catId) {
    final chosen = current(catId, Keys.profileImage);
    final all = images(catId);
    if (chosen != null && all.contains(chosen)) return chosen;
    return all.isEmpty ? null : all.first;
  }

  // --------------------------------------------------------------- deletes

  /// True while any entity still shows [hash] as an added image.
  bool _imageReferenced(String hash) {
    final rows = _db.select(
      'SELECT DISTINCT entity FROM entries WHERE field = ?',
      [Keys.image(hash)],
    );
    return rows.any((r) =>
        current(r['entity'] as String, Keys.image(hash)) == 'added');
  }

  /// Deletes one photo of a Cat: a marker entry propagates the deletion
  /// (ADR-0001), and the bytes are dropped once no Cat references the
  /// hash anymore. The photo's data is really gone.
  void deleteImage(String catId, String hash, {DateTime? date}) {
    append(catId, Keys.image(hash), 'deleted', date: date);
    if (!_imageReferenced(hash)) _blobs.remove(hash);
  }

  /// Deletes a Cat: hidden from every list and search, its photos'
  /// bytes dropped. The log entries stay (they are tiny and sync needs
  /// the markers).
  void deleteCat(String catId, {DateTime? date}) {
    for (final hash in images(catId)) {
      deleteImage(catId, hash, date: date);
    }
    append(catId, Keys.deleted, 'true', date: date);
  }

  /// Deletes a Clowder. Its current Cats are not deleted with it — they
  /// fall out as Strays (see CONTEXT.md: Stray).
  void deleteClowder(String clowderId, {DateTime? date}) {
    for (final cat in cats(clowderId: clowderId)) {
      moveCat(cat.id, null, date: date);
    }
    append(clowderId, Keys.deleted, 'true', date: date);
  }

  // ------------------------------------------------------------ field defs

  /// All global Field definitions, optionally filtered by where they apply.
  List<FieldDef> fieldDefs({FieldScope? scope}) {
    final defs = <FieldDef>[];
    for (final id in _entitiesOf(Kinds.fieldDef)) {
      final fields = currentFields(id);
      final def = FieldDef(
        id: id,
        slug: id.substring('fielddef:'.length),
        name: fields[Keys.name] ?? '(unnamed)',
        type: FieldType.values.asNameMap()[fields[Keys.fieldType]] ??
            FieldType.text,
        scope: FieldScope.values.asNameMap()[fields[Keys.fieldScope]] ??
            FieldScope.both,
        options: (fields[Keys.fieldOptions] ?? '')
            .split('\n')
            .where((o) => o.isNotEmpty)
            .toList(),
      );
      if (scope == null || def.scope == scope || def.scope == FieldScope.both) {
        defs.add(def);
      }
    }
    return defs;
  }

  /// Creates a new global Field definition and returns its entity id.
  /// The definition is itself entries — dated, authored, and synced like
  /// everything else. Throws if a Field with the same slug exists.
  String defineField(String name, FieldType type,
      {FieldScope scope = FieldScope.both,
      List<String> options = const [],
      DateTime? date}) {
    final slug = slugify(name);
    if (slug.isEmpty) throw ArgumentError('Field name must not be empty');
    final id = 'fielddef:$slug';
    if (current(id, Keys.type) != null) {
      throw ArgumentError('A field named "$name" already exists');
    }
    append(id, Keys.type, Kinds.fieldDef, date: date);
    append(id, Keys.name, name, date: date);
    append(id, Keys.fieldType, type.name, date: date);
    append(id, Keys.fieldScope, scope.name, date: date);
    if (options.isNotEmpty) {
      append(id, Keys.fieldOptions, options.join('\n'), date: date);
    }
    return id;
  }

  /// Renames a Field definition (typo fixes). The slug — and with it the
  /// key values are stored under — never changes, so existing entries
  /// stay attached; only the display name moves, with full history.
  void renameField(String fieldDefId, String newName, {DateTime? date}) {
    if (current(fieldDefId, Keys.type) != Kinds.fieldDef) {
      throw ArgumentError('Not a field definition: $fieldDefId');
    }
    append(fieldDefId, Keys.name, newName, date: date);
  }

  /// Lowercase, alphanumeric-and-dash form of a Field name.
  static String slugify(String name) => name
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');

  void _seedStarterFields() {
    for (final f in starterFields) {
      final id = 'fielddef:${f.slug}';
      if (current(id, Keys.type) != null) continue;
      append(id, Keys.type, Kinds.fieldDef, as: seedAuthor);
      append(id, Keys.name, f.name, as: seedAuthor);
      append(id, Keys.fieldType, f.type.name, as: seedAuthor);
      append(id, Keys.fieldScope, f.scope.name, as: seedAuthor);
      if (f.options.isNotEmpty) {
        append(id, Keys.fieldOptions, f.options.join('\n'), as: seedAuthor);
      }
    }
  }

  // ------------------------------------------------------------------ misc

  static final Random _random = Random.secure();

  static String _uuid() {
    final b = List.generate(16, (_) => _random.nextInt(256));
    b[6] = (b[6] & 0x0f) | 0x40;
    b[8] = (b[8] & 0x3f) | 0x80;
    final h = b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
    return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-'
        '${h.substring(16, 20)}-${h.substring(20)}';
  }
}

/// Content-addressed storage for image bytes, keyed by SHA-256 hash.
abstract interface class _BlobStore {
  void put(String hash, Uint8List bytes);
  Uint8List? get(String hash);
  void remove(String hash);
}

class _FileBlobStore implements _BlobStore {
  final Directory _dir;

  _FileBlobStore(String path) : _dir = Directory(path) {
    _dir.createSync(recursive: true);
  }

  File _file(String hash) => File('${_dir.path}/$hash.jpg');

  @override
  void put(String hash, Uint8List bytes) {
    final f = _file(hash);
    if (!f.existsSync()) f.writeAsBytesSync(bytes);
  }

  @override
  Uint8List? get(String hash) {
    final f = _file(hash);
    return f.existsSync() ? f.readAsBytesSync() : null;
  }

  @override
  void remove(String hash) {
    final f = _file(hash);
    if (f.existsSync()) f.deleteSync();
  }
}

class _MemoryBlobStore implements _BlobStore {
  final _blobs = <String, Uint8List>{};

  @override
  void put(String hash, Uint8List bytes) => _blobs[hash] = bytes;

  @override
  Uint8List? get(String hash) => _blobs[hash];

  @override
  void remove(String hash) => _blobs.remove(hash);
}
