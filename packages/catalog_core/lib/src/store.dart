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
