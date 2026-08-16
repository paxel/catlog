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
        device   TEXT NOT NULL,
        dseq     INTEGER NOT NULL,
        entity   TEXT NOT NULL,
        field    TEXT NOT NULL,
        value    TEXT,
        date     TEXT NOT NULL,
        author   TEXT NOT NULL,
        recorded TEXT NOT NULL
      );
      CREATE TABLE IF NOT EXISTS local_settings (
        key   TEXT PRIMARY KEY,
        value TEXT NOT NULL
      );
    ''');
    final store = CatalogStore._(db, blobs);
    store._ensureDeviceId();
    store._migrateV1();
    store._normalizeTimestamps();
    db.execute('''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_entries_device_dseq
        ON entries (device, dseq);
      CREATE INDEX IF NOT EXISTS idx_entries_entity_field
        ON entries (entity, field);
    ''');
    store._seedStarterFields();
    return store;
  }

  /// This installation's stable device id (ADR-0002); created once.
  String get deviceId {
    final rows = _db
        .select('SELECT value FROM local_settings WHERE key = ?', ['device']);
    return rows.first['value'] as String;
  }

  void _ensureDeviceId() {
    _db.execute(
      'INSERT OR IGNORE INTO local_settings (key, value) VALUES (?, ?)',
      ['device', _uuid()],
    );
  }

  /// Timestamps are compared as strings in SQL, so they MUST have fixed
  /// precision: Dart's toIso8601String emits 3 fraction digits when the
  /// microseconds are zero and 6 otherwise — and "…858Z" string-sorts
  /// after "…858233Z" ('Z' > '2'). Always store 6 fraction digits.
  static String _iso(DateTime d) {
    final s = d.toUtc().toIso8601String();
    return s.length == 24 ? '${s.substring(0, 23)}000Z' : s;
  }

  /// Repairs rows written with 3-digit fractions (idempotent).
  void _normalizeTimestamps() {
    _db.execute(
        "UPDATE entries SET date = substr(date, 1, 23) || '000Z' "
        'WHERE length(date) = 24');
    _db.execute(
        "UPDATE entries SET recorded = substr(recorded, 1, 23) || '000Z' "
        'WHERE length(recorded) = 24');
  }

  /// Upgrades a pre-sync (M1) database: entries lacked (device, dseq).
  /// Existing rows are claimed by this device with dseq = seq — correct,
  /// because M1 databases were single-device by construction.
  void _migrateV1() {
    final cols = _db
        .select('PRAGMA table_info(entries)')
        .map((r) => r['name'] as String)
        .toSet();
    if (cols.contains('device')) return;
    _db.execute("ALTER TABLE entries ADD COLUMN device TEXT NOT NULL DEFAULT ''");
    _db.execute('ALTER TABLE entries ADD COLUMN dseq INTEGER NOT NULL DEFAULT 0');
    _db.execute(
        'UPDATE entries SET device = ?, dseq = seq', [deviceId]);
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

  /// Device-local, never-synced key/value setting (last sync peer,
  /// folder paths, …).
  String? localSetting(String key) {
    final rows = _db
        .select('SELECT value FROM local_settings WHERE key = ?', ['u:$key']);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  void setLocalSetting(String key, String value) => _db.execute(
        'INSERT INTO local_settings (key, value) VALUES (?, ?) '
        'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
        ['u:$key', value],
      );

  // ------------------------------------------- hidden (display filter)

  /// Hidden is a per-device display filter: hidden Cats, Clowders, and
  /// field definitions keep syncing unchanged — they are only not shown.

  bool isHidden(String id) =>
      localSetting('hidden:${resolveEntity(id)}') == '1';

  void setHidden(String id, bool hidden) {
    final key = 'u:hidden:${resolveEntity(id)}';
    if (hidden) {
      _db.execute(
        'INSERT INTO local_settings (key, value) VALUES (?, ?) '
        'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
        [key, '1'],
      );
    } else {
      _db.execute('DELETE FROM local_settings WHERE key = ?', [key]);
    }
  }

  /// Canonical ids of Cats and Clowders an author whose name matches
  /// [query] (case-insensitive substring) has written entries for —
  /// "I only remember the person" search.
  List<String> entitiesTouchedBy(String query) {
    final rows = _db.select(
      "SELECT DISTINCT entity FROM entries WHERE author LIKE ? AND "
      "(entity LIKE 'cat:%' OR entity LIKE 'clowder:%')",
      ['%$query%'],
    );
    final seen = <String>{};
    return [
      for (final r in rows)
        if (seen.add(resolveEntity(r['entity'] as String)))
          resolveEntity(r['entity'] as String)
    ];
  }

  /// Canonical ids currently hidden on this device.
  List<String> hiddenIds() => [
        for (final r in _db.select(
            "SELECT key FROM local_settings WHERE key LIKE 'u:hidden:%' "
            "AND value = '1'"))
          (r['key'] as String).substring('u:hidden:'.length)
      ];

  // ------------------------------------------------------------------- log

  /// Appends one immutable fact. [date] is the effective (backdatable)
  /// date and defaults to now. Uses the configured [author] unless [as]
  /// overrides it (seeding).
  void append(String entity, String field, String? value,
      {DateTime? date, String? as}) {
    final by = as ?? author;
    if (by == null) throw StateError('No author configured');
    final now = DateTime.now().toUtc();
    final device = deviceId;
    final next = _db.select(
      'SELECT COALESCE(MAX(dseq), 0) + 1 AS n FROM entries WHERE device = ?',
      [device],
    ).first['n'] as int;
    _db.execute(
      'INSERT INTO entries (device, dseq, entity, field, value, date, author, recorded) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        device,
        next,
        entity,
        field,
        value,
        _iso(date ?? now),
        by,
        _iso(now),
      ],
    );
  }

  Entry _entry(Row r) => Entry(
        seq: r['seq'] as int,
        device: r['device'] as String,
        dseq: r['dseq'] as int,
        entity: r['entity'] as String,
        field: r['field'] as String,
        value: r['value'] as String?,
        date: DateTime.parse(r['date'] as String),
        author: r['author'] as String,
        recorded: DateTime.parse(r['recorded'] as String),
      );

  /// Deterministic latest-wins ordering (ADR-0001): effective date, then
  /// recording time, then author, then origin device and its counter —
  /// device-stable, so every synced device projects identical state.
  static const _latest =
      'ORDER BY date DESC, recorded DESC, author DESC, device DESC, dseq DESC';

  // ------------------------------------------------------- alias (merge)

  /// Raw loser → survivor map from the latest $mergedInto entries.
  /// Built with plain SQL — never through the alias-aware readers.
  Map<String, String> _mergeTargets() {
    final rows = _db.select(
      'SELECT * FROM entries WHERE field = ? $_latest',
      [Keys.mergedInto],
    );
    final map = <String, String>{};
    for (final r in rows) {
      map.putIfAbsent(r['entity'] as String, () => r['value'] as String);
    }
    return map;
  }

  /// Canonical id: follows the merge chain (cycle-safe).
  String resolveEntity(String id) {
    final targets = _mergeTargets();
    var current = id;
    final seen = <String>{};
    while (targets.containsKey(current) && seen.add(current)) {
      current = targets[current]!;
    }
    return current;
  }

  /// The alias group of a canonical id: itself plus every loser whose
  /// chain resolves to it. Used for Cats and Clowders (value union);
  /// field definitions read survivor-only properties instead.
  List<String> _group(String id) {
    final targets = _mergeTargets();
    if (targets.isEmpty) return [id];
    String resolve(String x) {
      final seen = <String>{};
      while (targets.containsKey(x) && seen.add(x)) {
        x = targets[x]!;
      }
      return x;
    }

    final canonical = resolve(id);
    return [
      canonical,
      for (final loser in targets.keys)
        if (resolve(loser) == canonical) loser
    ];
  }

  /// All keys a field key answers for: itself plus the keys of field
  /// definitions merged into its definition.
  List<String> _keysFor(String field) {
    if (!field.startsWith('f:')) return [field];
    final defId = 'fielddef:${field.substring(2)}';
    return [
      for (final id in _group(defId)) 'f:${id.substring('fielddef:'.length)}'
    ];
  }

  /// Display key for a raw stored field key: loser keys map to the
  /// survivor's key.
  String canonicalKey(String field) {
    if (!field.startsWith('f:')) return field;
    final resolved = resolveEntity('fielddef:${field.substring(2)}');
    return 'f:${resolved.substring('fielddef:'.length)}';
  }

  String _placeholders(int n) => List.filled(n, '?').join(', ');

  bool _unionKind(String entity) =>
      entity.startsWith('cat:') || entity.startsWith('clowder:');

  /// Current value of one field, or null if never set or last set to null.
  /// Cat/Clowder reads unite the alias group; field keys unite aliased
  /// definitions; Clowder membership values resolve to the survivor.
  String? current(String entity, String field) {
    final entities = _unionKind(entity) ? _group(entity) : [entity];
    final keys = _keysFor(field);
    final rows = _db.select(
      'SELECT * FROM entries WHERE entity IN (${_placeholders(entities.length)}) '
      'AND field IN (${_placeholders(keys.length)}) $_latest LIMIT 1',
      [...entities, ...keys],
    );
    if (rows.isEmpty) return null;
    final value = rows.first['value'] as String?;
    if (field == Keys.clowder && value != null) return resolveEntity(value);
    return value;
  }

  /// Current value of every field of an entity, loser field keys shown
  /// under the survivor's key.
  Map<String, String?> currentFields(String entity) {
    final entities = _unionKind(entity) ? _group(entity) : [entity];
    final rows = _db.select(
      'SELECT field, value FROM entries '
      'WHERE entity IN (${_placeholders(entities.length)}) $_latest',
      entities,
    );
    final result = <String, String?>{};
    for (final r in rows) {
      result.putIfAbsent(
          canonicalKey(r['field'] as String), () => r['value'] as String?);
    }
    return result;
  }

  /// Every entry of an entity (including merged-in losers), newest
  /// effective date first.
  List<Entry> timeline(String entity) {
    final entities = _unionKind(entity) ? _group(entity) : [entity];
    return _dedupe(_db
        .select(
          'SELECT * FROM entries '
          'WHERE entity IN (${_placeholders(entities.length)}) $_latest',
          entities,
        )
        .map(_entry));
  }

  /// Collapses re-asserted copies (identical fact, different device/dseq)
  /// so unmark-private and merge re-assertions never double diary rows.
  List<Entry> _dedupe(Iterable<Entry> rows) {
    final seen = <String>{};
    return [
      for (final e in rows)
        if (seen.add(
            '${e.entity} ${e.field} ${e.value} '
            '${_iso(e.date)} ${e.author} ${_iso(e.recorded)}'))
          e
    ];
  }

  /// Every entry of one field of an entity, newest effective date first.
  List<Entry> fieldHistory(String entity, String field) {
    final entities = _unionKind(entity) ? _group(entity) : [entity];
    final keys = _keysFor(field);
    return _dedupe(_db
        .select(
          'SELECT * FROM entries '
          'WHERE entity IN (${_placeholders(entities.length)}) '
          'AND field IN (${_placeholders(keys.length)}) $_latest',
          [...entities, ...keys],
        )
        .map(_entry));
  }

  bool isDeleted(String entity) => current(entity, Keys.deleted) == 'true';

  /// True when [field] may be reverted from the history UI. Structural
  /// markers and photo entries are not revertable (photo bytes are gone
  /// for good once deleted).
  static bool isRevertable(String field) =>
      field != Keys.type &&
      field != Keys.deleted &&
      field != Keys.mergedInto &&
      !field.startsWith(Keys.conflictPrefix) &&
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
      'AND (date, recorded, author, device, dseq) < (?, ?, ?, ?, ?) '
      '$_latest LIMIT 1',
      [
        entry.entity,
        entry.field,
        _iso(entry.date),
        _iso(entry.recorded),
        entry.author,
        entry.device,
        entry.dseq,
      ],
    );
    final restored =
        prev.isEmpty ? null : prev.first['value'] as String?;
    append(entry.entity, entry.field, restored);
    return restored;
  }

  /// Ids of all non-deleted, non-merged entities of a kind, oldest first.
  List<String> _entitiesOf(String kind) {
    final merged = _mergeTargets();
    final rows = _db.select(
      'SELECT DISTINCT entity FROM entries WHERE field = ? AND value = ? '
      'ORDER BY seq',
      [Keys.type, kind],
    );
    return [
      for (final r in rows)
        if (!merged.containsKey(r['entity'] as String) &&
            !isDeleted(r['entity'] as String))
          r['entity'] as String
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
    append(id, 'f:species', 'cat', date: date);
    if (clowderId != null) append(id, Keys.clowder, clowderId, date: date);
    return id;
  }

  /// Cats currently in [clowderId], or every Cat when null. Membership
  /// pointing at a merged Clowder counts for the survivor.
  List<EntityView> cats({String? clowderId}) {
    final target = clowderId == null ? null : resolveEntity(clowderId);
    return [
      for (final id in _entitiesOf(Kinds.cat))
        if (target == null || current(id, Keys.clowder) == target) _view(id)
    ];
  }

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
    final target = resolveEntity(clowderId);
    final events = <ClowderEvent>[];
    final rows = _db.select(
      'SELECT DISTINCT entity FROM entries WHERE field = ?',
      [Keys.clowder],
    );
    final merged = _mergeTargets();
    for (final r in rows) {
      final catId = r['entity'] as String;
      if (merged.containsKey(catId)) continue; // counted via survivor
      final history = fieldHistory(catId, Keys.clowder).reversed;
      String? prev;
      for (final e in history) {
        final value = e.value == null ? null : resolveEntity(e.value!);
        if (value == target && prev != target) {
          events.add(ClowderEvent(
              entry: e, catId: catId, arrived: true, counterpart: prev));
        } else if (prev == target && value != target) {
          events.add(ClowderEvent(
              entry: e, catId: catId, arrived: false, counterpart: value));
        }
        prev = value;
      }
    }
    events.sort((a, b) => b.entry.date.compareTo(a.entry.date));
    return events;
  }

  /// The key of the built-in Position starter field ("lat,lon").
  static const positionKey = 'f:position';

  /// An entity's current position, parsed from the Position field.
  (double, double)? positionOf(String entityId) =>
      parsePosition(current(entityId, positionKey));

  /// Parses a "lat,lon" value; null for absent or malformed input.
  static (double, double)? parsePosition(String? value) {
    if (value == null) return null;
    final parts = value.split(',');
    if (parts.length != 2) return null;
    final lat = double.tryParse(parts[0].trim());
    final lon = double.tryParse(parts[1].trim());
    if (lat == null || lon == null) return null;
    if (lat < -90 || lat > 90 || lon < -180 || lon > 180) return null;
    return (lat, lon);
  }

  /// Records a position sighting at the current (or given) date.
  void recordPosition(String entityId, double lat, double lon,
          {DateTime? date}) =>
      append(entityId, positionKey, '$lat,$lon', date: date);

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

  /// Pure function: cuts a fractional rectangle (0..1 coordinates) out
  /// of a photo — the Crop operation (CONTEXT.md). CPU-heavy, use
  /// Isolate.run from UI code.
  static Uint8List cropImage(
      Uint8List bytes, double x, double y, double w, double h) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw const FormatException('Not a decodable image');
    final px = (x.clamp(0.0, 1.0) * decoded.width).round();
    final py = (y.clamp(0.0, 1.0) * decoded.height).round();
    final pw = (w.clamp(0.0, 1.0) * decoded.width).round();
    final ph = (h.clamp(0.0, 1.0) * decoded.height).round();
    if (pw < 8 || ph < 8) {
      throw ArgumentError('Crop rectangle too small');
    }
    final cropped = img.copyCrop(decoded,
        x: px,
        y: py,
        width: pw.clamp(1, decoded.width - px),
        height: ph.clamp(1, decoded.height - py));
    return Uint8List.fromList(img.encodeJpg(cropped, quality: 85));
  }

  /// Pure function: bakes a highlight ellipse into a copy of a photo —
  /// the Mark operation (CONTEXT.md). Center/radii in 0..1 fractions.
  static Uint8List markImage(
      Uint8List bytes, double cx, double cy, double rx, double ry) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw const FormatException('Not a decodable image');
    final centerX = cx * decoded.width;
    final centerY = cy * decoded.height;
    final radiusX = (rx * decoded.width).abs();
    final radiusY = (ry * decoded.height).abs();
    if (radiusX < 4 || radiusY < 4) {
      throw ArgumentError('Mark ellipse too small');
    }
    final thickness =
        (decoded.width > decoded.height ? decoded.width : decoded.height) ~/
                150 +
            3;
    // White casing under an orange stroke keeps the mark visible on any
    // background, including printed cards.
    const segments = 90;
    for (var pass = 0; pass < 2; pass++) {
      final color = pass == 0
          ? img.ColorRgb8(255, 255, 255)
          : img.ColorRgb8(230, 90, 40);
      final t = pass == 0 ? thickness + 4 : thickness;
      for (var i = 0; i < segments; i++) {
        final a1 = 2 * pi * i / segments;
        final a2 = 2 * pi * (i + 1) / segments;
        img.drawLine(
          decoded,
          x1: (centerX + radiusX * cos(a1)).round(),
          y1: (centerY + radiusY * sin(a1)).round(),
          x2: (centerX + radiusX * cos(a2)).round(),
          y2: (centerY + radiusY * sin(a2)).round(),
          color: color,
          thickness: t.toDouble(),
          antialias: true,
        );
      }
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

  /// Content hashes of a Cat's images (merged-in losers included),
  /// oldest first, deleted ones excluded.
  List<String> images(String catId) {
    final entities = _group(catId);
    final rows = _db.select(
      'SELECT DISTINCT field FROM entries '
      'WHERE entity IN (${_placeholders(entities.length)}) AND field LIKE ? '
      'ORDER BY seq',
      [...entities, '${Keys.imagePrefix}%'],
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

  // ------------------------------------------------------------------ sync

  /// What this store has seen: max dseq per known device (ADR-0002).
  Map<String, int> versionVector() => {
        for (final r in _db.select(
            'SELECT device, MAX(dseq) AS m FROM entries GROUP BY device'))
          r['device'] as String: r['m'] as int
      };

  /// Every entry a peer with [vector] is missing, ordered (device, dseq).
  ///
  /// Defaults to public-only: Private entities, their entries, entries of
  /// Private field definitions, and all $private markers are stripped —
  /// forgetting the flag can never leak. Own-device consumers (backup,
  /// history scans) pass [includePrivate] true.
  List<Entry> entriesSince(Map<String, int> vector,
      {bool includePrivate = false}) {
    final private = includePrivate ? const <String>{} : _privateEntities();
    final all = _db
        .select('SELECT * FROM entries ORDER BY device, dseq')
        .map(_entry);
    return [
      for (final e in all)
        if (e.dseq > (vector[e.device] ?? 0) &&
            (includePrivate || !_isPrivateEntry(e, private)))
          e
    ];
  }

  /// Canonical ids of every entity whose latest $private marker is `yes`.
  Set<String> _privateEntities() {
    final rows = _db.select(
      'SELECT * FROM entries WHERE field = ? $_latest',
      [Keys.private],
    );
    final latest = <String, String?>{};
    for (final r in rows) {
      latest.putIfAbsent(r['entity'] as String, () => r['value'] as String?);
    }
    return {
      for (final e in latest.entries)
        if (e.value == 'yes') resolveEntity(e.key)
    };
  }

  bool _isPrivateEntry(Entry e, Set<String> private) {
    if (e.field == Keys.private) return true;
    if (private.isEmpty) return false;
    if (private.contains(resolveEntity(e.entity))) return true;
    if (e.field.startsWith('f:')) {
      return private
          .contains(resolveEntity('fielddef:${e.field.substring(2)}'));
    }
    return false;
  }

  /// True when the entity carries a Private marker.
  bool isPrivate(String id) =>
      current(resolveEntity(id), Keys.private) == 'yes';

  /// Marks or unmarks an entity (Cat, Clowder, field definition) Private.
  ///
  /// Unmarking re-asserts the entity's whole history under fresh
  /// (device, dseq) rows: peers' version vectors advanced past the
  /// withheld originals while the entity was private, so only new rows
  /// reach them (same trick as merge re-assertion).
  void setPrivate(String id, bool private, {DateTime? date}) {
    final canonical = resolveEntity(id);
    append(canonical, Keys.private, private ? 'yes' : 'no', date: date);
    if (!private) _reassertGroup(canonical);
  }

  void _reassertGroup(String canonical) {
    final entities = _group(canonical);
    var where =
        'entity IN (${_placeholders(entities.length)})';
    final args = <Object?>[...entities];
    if (canonical.startsWith('fielddef:')) {
      final keys = _keysFor('f:${canonical.substring('fielddef:'.length)}');
      where += ' OR field IN (${_placeholders(keys.length)})';
      args.addAll(keys);
    }
    final rows = _db
        .select(
            'SELECT * FROM entries WHERE ($where) AND field != ? '
            'ORDER BY device, dseq',
            [...args, Keys.private])
        .map(_entry)
        .toList();
    final device = deviceId;
    var next = _db.select(
      'SELECT COALESCE(MAX(dseq), 0) + 1 AS n FROM entries WHERE device = ?',
      [device],
    ).first['n'] as int;
    for (final e in rows) {
      _db.execute(
        'INSERT INTO entries (device, dseq, entity, field, value, date, author, recorded) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          device,
          next++,
          e.entity,
          e.field,
          e.value,
          _iso(e.date),
          e.author,
          _iso(e.recorded),
        ],
      );
    }
  }

  /// Imports foreign entries idempotently — (device, dseq) already seen
  /// are ignored. Returns the entries that were actually new. Image
  /// bytes whose last reference died with this import are dropped.
  ///
  /// [senderVector] enables conflict detection: if the sender had NOT
  /// seen our current entry for a field it changed (its vector does not
  /// cover that entry), the edits were concurrent — the field is flagged
  /// in the device-local conflicts table when the values differ. With
  /// the vector absent, no conflicts are flagged.
  List<Entry> applyEntries(List<Entry> entries,
      {Map<String, int>? senderVector}) {
    // Snapshot the pre-import winner of every field this batch touches.
    final touched = <(String, String)>{
      for (final e in entries) (e.entity, e.field)
    };
    final pre = <(String, String), Entry?>{};
    if (senderVector != null) {
      for (final t in touched) {
        final rows = _db.select(
          'SELECT * FROM entries WHERE entity = ? AND field = ? $_latest LIMIT 1',
          [t.$1, t.$2],
        );
        pre[t] = rows.isEmpty ? null : _entry(rows.first);
      }
    }
    final imported = <Entry>[];
    for (final e in entries) {
      _db.execute(
        'INSERT OR IGNORE INTO entries '
        '(device, dseq, entity, field, value, date, author, recorded) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          e.device,
          e.dseq,
          e.entity,
          e.field,
          e.value,
          _iso(e.date),
          e.author,
          _iso(e.recorded),
        ],
      );
      if (_db.updatedRows > 0) imported.add(e);
    }
    // Propagated image deletions: drop bytes with no live reference left.
    for (final e in imported) {
      if (e.field.startsWith(Keys.imagePrefix) && e.value == 'deleted') {
        final hash = e.field.substring(Keys.imagePrefix.length);
        if (!_imageReferenced(hash)) _blobs.remove(hash);
      }
    }
    // Concurrent-edit detection (see doc comment above). The flag is an
    // ordinary entry — it syncs, so every device shows the badge, and a
    // resolution on any device clears it everywhere.
    if (senderVector != null) {
      for (final e in imported) {
        if (!isRevertable(e.field)) continue;
        final before = pre[(e.entity, e.field)];
        if (before == null) continue; // field was new here
        if (e.value == before.value) continue; // same value, no fight
        final senderSawIt =
            (senderVector[before.device] ?? 0) >= before.dseq;
        if (!senderSawIt && !hasConflict(e.entity, e.field)) {
          append(e.entity, Keys.conflict(e.field), 'open',
              as: author ?? 'cat(a)log');
        }
      }
    }
    return imported;
  }

  // ----------------------------------------------------------------- merge

  /// Merges two Cats: [loserId] folds into [survivorId], irreversibly
  /// (see CONTEXT.md: Merge). The survivor re-asserts its current values
  /// so they win the combined projection; loser values fill only gaps.
  void mergeCat(String loserId, String survivorId, {DateTime? date}) =>
      _merge(loserId, survivorId, 'cat:', date);

  /// Merges two Clowders; membership pointing at the loser resolves to
  /// the survivor — including entries still syncing in from elsewhere.
  void mergeClowder(String loserId, String survivorId, {DateTime? date}) =>
      _merge(loserId, survivorId, 'clowder:', date);

  /// Merges two Field definitions of the SAME type; values recorded
  /// under either key read as the survivor's field from now on.
  void mergeField(String loserDefId, String survivorDefId, {DateTime? date}) {
    final lt = current(loserDefId, Keys.fieldType);
    final st = current(survivorDefId, Keys.fieldType);
    if (lt == null || st == null) {
      throw ArgumentError('Not field definitions: $loserDefId, $survivorDefId');
    }
    if (lt != st) {
      throw ArgumentError('Cannot merge $lt field into $st field');
    }
    _merge(loserDefId, survivorDefId, 'fielddef:', date, reassert: false);
  }

  void _merge(String loserId, String survivorId, String prefix, DateTime? date,
      {bool reassert = true}) {
    if (!loserId.startsWith(prefix) || !survivorId.startsWith(prefix)) {
      throw ArgumentError('Merge partners must both be ${prefix}entities');
    }
    if (loserId == survivorId) {
      throw ArgumentError('Cannot merge an entity into itself');
    }
    if (resolveEntity(survivorId) == loserId ||
        _mergeTargets().containsKey(loserId)) {
      throw ArgumentError('Merge would create a cycle or re-merge a loser');
    }
    if (reassert) {
      // Survivor-wins: re-assert survivor values that the loser's newer
      // entries would otherwise override in the combined projection.
      final survivorFields = currentFields(survivorId);
      final loserFields = currentFields(loserId);
      for (final key in survivorFields.keys) {
        if (key == Keys.type || key == Keys.deleted) continue;
        if (key.startsWith(Keys.imagePrefix)) continue;
        if (!loserFields.containsKey(key)) continue;
        if (loserFields[key] == survivorFields[key]) continue;
        append(survivorId, key, survivorFields[key], date: date);
      }
    }
    append(loserId, Keys.mergedInto, survivorId, date: date);
  }

  // ------------------------------------------------------------- conflicts

  /// Fields with unresolved concurrent edits, as (entity, field) pairs.
  List<(String, String)> conflicts() {
    final rows = _db.select(
      'SELECT DISTINCT entity, field FROM entries WHERE field LIKE ?',
      ['${Keys.conflictPrefix}%'],
    );
    return [
      for (final r in rows)
        if (current(r['entity'] as String, r['field'] as String) == 'open')
          (
            r['entity'] as String,
            (r['field'] as String).substring(Keys.conflictPrefix.length)
          )
    ];
  }

  bool hasConflict(String entity, String field) =>
      current(entity, Keys.conflict(field)) == 'open';

  /// Clears a conflict flag — after the user viewed it, kept the current
  /// value, or promoted the other one (promotion itself is an ordinary
  /// [append]). The resolution syncs like any entry.
  void resolveConflict(String entity, String field) =>
      append(entity, Keys.conflict(field), 'resolved');

  /// Content hashes referenced as added somewhere but missing locally.
  List<String> missingBlobs() {
    final rows = _db.select(
      'SELECT DISTINCT field FROM entries WHERE field LIKE ?',
      ['${Keys.imagePrefix}%'],
    );
    final missing = <String>{};
    for (final r in rows) {
      final hash = (r['field'] as String).substring(Keys.imagePrefix.length);
      if (_imageReferenced(hash) && _blobs.get(hash) == null) {
        missing.add(hash);
      }
    }
    return missing.toList();
  }

  /// Stores a blob received from a peer; verifies the content hash.
  void putBlob(String hash, Uint8List bytes) {
    if (sha256.convert(bytes).toString() != hash) {
      throw ArgumentError('Blob content does not match hash $hash');
    }
    _blobs.put(hash, bytes);
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
