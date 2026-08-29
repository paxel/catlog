import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:sqlite3/sqlite3.dart';

import 'entry.dart';
import 'fields.dart';
import 'registry.dart';

/// Author name stamped on entries the store seeds itself (starter Fields).
const seedAuthor = 'cat(a)log';

/// Settings that belong to the app rather than to one catalog. With
/// several catalogs on a device, these are answered by a shared store so
/// a second catalog is not a fresh install: you keep your name, your
/// language, and the tutorial tips you have already seen.
bool isSharedSetting(String key) =>
    key == 'locale' ||
    key == 'introSeen' ||
    key == 'celebrations' ||
    key == 'windowBounds' ||
    key.startsWith('spot:') ||
    key.startsWith('spot2:') ||
    key.startsWith('toast:');

/// Where shared settings live. A store without one keeps everything in
/// its own database — which is what a bare [CatalogStore.open] and every
/// in-memory store do, and must keep doing.
abstract class SharedSettings {
  String? get(String key);
  void set(String key, String value);
  void remove(String key);
  List<(String, String)> byPrefix(String prefix);
}

/// A Cat or Clowder as list rows want it: id plus current name.
class EntityView {
  final String id;
  final String name;
  const EntityView(this.id, this.name);
}

/// One live plan (#74): the newest — by append order — entry of an
/// (entity, field) pair is reminder-flagged with a value. See
/// [CatalogStore.activeReminders].
class ActiveReminder {
  /// Canonical entity id (`cat:…` or `clowder:…`).
  final String entity;

  /// Canonical field key.
  final String field;

  /// The plan's note — what is due.
  final String value;

  /// The flagged entry itself; [due] is its effective date.
  final Entry entry;

  const ActiveReminder(
      {required this.entity,
      required this.field,
      required this.value,
      required this.entry});

  /// Entry dates are stored as UTC instants; the due DAY is a local
  /// notion — without toLocal a midnight due date reads as the
  /// previous evening and every day comparison shifts by one.
  DateTime get due => entry.date.toLocal();
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

  /// Set by the catalog manager when several catalogs share a device.
  /// Null everywhere else, and the store works exactly as before.
  SharedSettings? shared;

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
        recorded TEXT NOT NULL,
        reminder INTEGER NOT NULL DEFAULT 0
      );
      CREATE TABLE IF NOT EXISTS local_settings (
        key   TEXT PRIMARY KEY,
        value TEXT NOT NULL
      );
      CREATE TABLE IF NOT EXISTS moments (
        id    INTEGER PRIMARY KEY AUTOINCREMENT,
        seq   INTEGER NOT NULL,
        cause TEXT NOT NULL,
        label TEXT,
        at    TEXT NOT NULL
      );
    ''');
    final store = CatalogStore._(db, blobs);
    store._ensureDeviceId();
    store._migrateV1();
    store._migrateReminder();
    store._normalizeTimestamps();
    db.execute('''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_entries_device_dseq
        ON entries (device, dseq);
      CREATE INDEX IF NOT EXISTS idx_entries_entity_field
        ON entries (entity, field);
    ''');
    store._seedStarterFields();
    store._migrateValuePrivacy();
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

  /// Adds the reminder flag (#74) to a pre-1.0.0 database; existing
  /// rows are facts, so the DEFAULT 0 backfill is the correct history.
  void _migrateReminder() {
    final cols = _db
        .select('PRAGMA table_info(entries)')
        .map((r) => r['name'] as String)
        .toSet();
    if (cols.contains('reminder')) return;
    _db.execute(
        'ALTER TABLE entries ADD COLUMN reminder INTEGER NOT NULL DEFAULT 0');
  }

  /// A fresh id for an appointment key (#75).
  String newAppointmentId() => _uuid();

  /// Runs [body] as one SQLite transaction: all of its writes land, or
  /// none do — a kill halfway through a move or a merge must not leave
  /// half a cat.
  T transaction<T>(T Function() body) {
    _db.execute('BEGIN');
    try {
      final result = body();
      _db.execute('COMMIT');
      return result;
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  bool _closed = false;

  /// False once [close] ran — work that outlived its catalog (a slow
  /// platform call answering after a switch) must not touch it (#89).
  bool get isOpen => !_closed;

  void close() {
    _closed = true;
    _db.dispose();
  }

  // ---------------------------------------------------------------- author

  /// The device's Author name; null until first-launch setup stored one.
  /// Device-local: lives outside the entry log and is never synced.
  String? get author {
    // One name for the whole app once catalogs are shared, falling back
    // to this catalog's own so a migrated catalog can still write before
    // its name has been copied across.
    final name = shared?.get('author');
    if (name != null && name.isNotEmpty) return name;
    final rows =
        _db.select('SELECT value FROM local_settings WHERE key = ?', ['author']);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  set author(String? name) {
    if (name == null || name.trim().isEmpty) {
      throw ArgumentError('Author name must not be empty');
    }
    shared?.set('author', name.trim());
    _db.execute(
      'INSERT INTO local_settings (key, value) VALUES (?, ?) '
      'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
      ['author', name.trim()],
    );
  }

  /// Device-local, never-synced key/value setting (last sync peer,
  /// folder paths, …).
  String? localSetting(String key) {
    final s = shared;
    if (s != null && isSharedSetting(key)) return s.get(key);
    final rows = _db
        .select('SELECT value FROM local_settings WHERE key = ?', ['u:$key']);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  void setLocalSetting(String key, String value) {
    final s = shared;
    if (s != null && isSharedSetting(key)) {
      s.set(key, value);
      return;
    }
    _db.execute(
      'INSERT INTO local_settings (key, value) VALUES (?, ?) '
      'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
      ['u:$key', value],
    );
  }

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

  /// All local settings under a prefix, as (suffix, value) —
  /// e.g. the always-allowed sync devices under 'trust:'.
  List<(String, String)> localSettingsByPrefix(String prefix) {
    final s = shared;
    if (s != null && isSharedSetting(prefix)) return s.byPrefix(prefix);
    return [
      for (final r in _db.select(
          "SELECT key, value FROM local_settings WHERE key LIKE ?",
          ['u:$prefix%']))
        (
          (r['key'] as String).substring('u:'.length + prefix.length),
          r['value'] as String
        )
    ];
  }

  /// Every device-local setting as (key, value), without the internal
  /// prefix — used when a catalog hands its app-level settings over to
  /// a shared store.
  List<(String, String)> allLocalSettings() => [
        for (final r in _db.select(
            "SELECT key, value FROM local_settings WHERE key LIKE 'u:%'"))
          (
            (r['key'] as String).substring('u:'.length),
            r['value'] as String
          )
      ];

  void removeLocalSetting(String key) {
    final s = shared;
    if (s != null && isSharedSetting(key)) {
      s.remove(key);
      return;
    }
    _db.execute('DELETE FROM local_settings WHERE key = ?', ['u:$key']);
  }

  /// Canonical ids currently hidden on this device.
  List<String> hiddenIds() => [
        for (final r in _db.select(
            "SELECT key FROM local_settings WHERE key LIKE 'u:hidden:%' "
            "AND value = '1'"))
          (r['key'] as String).substring('u:hidden:'.length)
      ];

  // -------------------------------- moderation (ADR-0006, local only)

  /// Authors and devices with their entry counts, for the moderation UI.
  List<({String author, String device, int count})> authorsOverview() => [
        for (final r in _db.select(
            'SELECT author, device, COUNT(*) AS n FROM entries '
            'GROUP BY author, device ORDER BY author, device'))
          (
            author: r['author'] as String,
            device: r['device'] as String,
            count: r['n'] as int
          )
      ];

  /// Physically deletes every entry (and orphaned photo bytes) of one
  /// author — optionally narrowed to one device. THE append-only
  /// exception (ADR-0006): for abusive or illegal material only.
  /// Returns the blob hashes that were removed, so callers can ban them.
  List<String> hardDeleteAuthor(String author, {String? device}) {
    final where =
        device == null ? 'author = ?' : 'author = ? AND device = ?';
    final args = device == null ? [author] : [author, device];
    final touched = <String>{
      for (final r in _db.select(
          "SELECT DISTINCT field FROM entries WHERE $where AND field LIKE ?",
          [...args, '${Keys.imagePrefix}%']))
        (r['field'] as String).substring(Keys.imagePrefix.length)
    };
    _removeEntries(where, args);
    final removedBlobs = <String>[];
    for (final hash in touched) {
      if (!_imageReferenced(hash) && _blobs.get(hash) != null) {
        _blobs.remove(hash);
        removedBlobs.add(hash);
      }
    }
    return removedBlobs;
  }

  /// The local ban list: banned material is received and discarded on
  /// every transport — sync bookkeeping still advances (see
  /// [versionVector]), so peers stop re-offering it. Never synced.
  void ban({String? author, String? device, String? blobHash}) {
    if (author != null) setLocalSetting('ban:author:$author', '1');
    if (device != null) setLocalSetting('ban:device:$device', '1');
    if (blobHash != null) setLocalSetting('ban:blob:$blobHash', '1');
  }

  void unban({String? author, String? device, String? blobHash}) {
    for (final key in [
      if (author != null) 'u:ban:author:$author',
      if (device != null) 'u:ban:device:$device',
      if (blobHash != null) 'u:ban:blob:$blobHash',
    ]) {
      _db.execute('DELETE FROM local_settings WHERE key = ?', [key]);
    }
  }

  /// All ban entries as (kind, value) — kind is author/device/blob.
  List<(String, String)> bans() => [
        for (final r in _db.select(
            "SELECT key FROM local_settings WHERE key LIKE 'u:ban:%'"))
          (
            (r['key'] as String).split(':')[2],
            (r['key'] as String).split(':').sublist(3).join(':')
          )
      ];

  bool _isBannedEntry(Entry e) =>
      localSetting('ban:author:${e.author}') == '1' ||
      localSetting('ban:device:${e.device}') == '1' ||
      (e.field.startsWith(Keys.imagePrefix) &&
          localSetting(
                  'ban:blob:${e.field.substring(Keys.imagePrefix.length)}') ==
              '1');

  /// Records that dseqs up to [dseq] of [device] were seen-and-discarded,
  /// so the merged version vector advances past banned rows.
  void _recordDiscarded(String device, int dseq) {
    final key = 'banvector:$device';
    final current = int.tryParse(localSetting(key) ?? '') ?? 0;
    if (dseq > current) setLocalSetting(key, '$dseq');
  }

  Map<String, int> _discardedVector() => {
        for (final r in _db.select(
            "SELECT key, value FROM local_settings "
            "WHERE key LIKE 'u:banvector:%'"))
          (r['key'] as String).substring('u:banvector:'.length):
              int.tryParse(r['value'] as String) ?? 0
      };

  // ------------------------------------------------------------------- log

  /// The next sequence number for [device]: one above the high-water
  /// mark, which counts physically removed entries as well as surviving
  /// ones. A number is never issued twice — peers keep removed entries
  /// under their old numbers, and an entry re-using one would be ignored
  /// by everyone who already synced.
  int _nextDseq(String device) {
    final highest = _db.select(
      'SELECT COALESCE(MAX(dseq), 0) AS n FROM entries WHERE device = ?',
      [device],
    ).first['n'] as int;
    final removed = _discardedVector()[device] ?? 0;
    return (highest > removed ? highest : removed) + 1;
  }

  /// Appends one immutable fact. [date] is the effective (backdatable)
  /// date and defaults to now. Uses the configured [author] unless [as]
  /// overrides it (seeding).
  void append(String entity, String field, String? value,
      {DateTime? date, String? as, bool reminder = false}) {
    final by = as ?? author;
    if (by == null) throw StateError('No author configured');
    final now = DateTime.now().toUtc();
    final device = deviceId;
    final next = _nextDseq(device);
    _db.execute(
      'INSERT INTO entries (device, dseq, entity, field, value, date, author, recorded, reminder) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        device,
        next,
        entity,
        field,
        value,
        _iso(date ?? now),
        by,
        _iso(now),
        reminder ? 1 : 0,
      ],
    );
    // A value written while this entity (or its field) is private needs
    // its public trace right away, or a partner sees an empty slot
    // instead of a redacted one.
    if (!Keys.isStructural(field) &&
        isFieldPrivate(entity, field) &&
        current(entity, Keys.withheld(field)) != 'yes') {
      append(entity, Keys.withheld(field), 'yes', date: date, as: as);
    }
  }

  /// Takes entries from another catalog as this device's own: the same
  /// facts, authors and dates, under fresh numbers of this device.
  ///
  /// Keeping the original (device, dseq) would be a lie with teeth: a
  /// partner both catalogs sync with would later push that device's
  /// newer entries straight into this one, and the two catalogs the
  /// keeper separated would quietly merge again.
  void adoptEntries(Iterable<Entry> entries) {
    final device = deviceId;
    var next = _nextDseq(device);
    for (final e in entries) {
      _db.execute(
        'INSERT INTO entries (device, dseq, entity, field, value, date, author, recorded, reminder) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          device,
          next++,
          e.entity,
          e.field,
          e.value,
          _iso(e.date),
          e.author,
          _iso(e.recorded),
          e.reminder ? 1 : 0,
        ],
      );
    }
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
        reminder: (r['reminder'] as int? ?? 0) != 0,
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
      'AND field IN (${_placeholders(keys.length)}) '
      'AND reminder = 0 $_latest LIMIT 1',
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
      'WHERE entity IN (${_placeholders(entities.length)}) '
      'AND reminder = 0 $_latest',
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

  /// Whether any entry ever carried the reminder flag (#74). While
  /// false, every outgoing payload is byte-identical to the pre-1.0.0
  /// format, so exports and sync stay compatible with 0.3.x peers.
  /// Practically monotonic — even a cancelled plan is a flagged row —
  /// flipping back only when going back removes the flagged entries.
  bool hasReminders() => _db
      .select('SELECT 1 FROM entries WHERE reminder = 1 LIMIT 1')
      .isNotEmpty;

  /// The live plans (#74): for every (entity, field) pair whose newest
  /// entry — by APPEND order — is reminder-flagged with a value, one
  /// [ActiveReminder]. Ordered by due date, earliest first.
  ///
  /// Retirement deliberately uses append order (recorded, author,
  /// device, dseq), NOT the effective-date `_latest` ordering: a
  /// done-fact recorded today must retire a plan whose due date lies
  /// years ahead — under `_latest` the plan's future date would win
  /// forever. Any later-appended entry on the field retires the plan:
  /// an unflagged fact (done), a new flagged entry (rescheduled), or a
  /// flagged null (cancelled).
  List<ActiveReminder> activeReminders() {
    final rows = _db.select(
      'SELECT * FROM entries '
      'ORDER BY recorded DESC, author DESC, device DESC, dseq DESC',
    );
    final newest = <(String, String), Entry>{};
    for (final r in rows) {
      final e = _entry(r);
      if (!_unionKind(e.entity)) continue;
      final key = (resolveEntity(e.entity), canonicalKey(e.field));
      newest.putIfAbsent(key, () => e);
    }
    final result = <ActiveReminder>[
      for (final MapEntry(key: (String entity, String field), value: Entry e)
          in newest.entries)
        if (e.reminder && e.value != null && !isDeleted(entity))
          ActiveReminder(
              entity: entity, field: field, value: e.value!, entry: e)
    ];
    result.sort((a, b) => a.due.compareTo(b.due));
    return result;
  }

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
      'AND reminder = 0 '
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

  /// The Clowder a Stray last lived in — the home it ran from. Null for
  /// a Cat that never had one. Only the newest membership counts: a Cat
  /// runs from where it was last, not from every home it ever had.
  String? formerClowder(String catId) {
    for (final e in fieldHistory(catId, Keys.clowder)) {
      if (e.value != null) return resolveEntity(e.value!);
    }
    return null;
  }

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

  /// An entity's current position, parsed from the Position field —
  /// any kind, fliers included.
  (double, double)? positionOf(String entityId) =>
      parsePosition(current(entityId, positionKey));

  /// The latest SIGHTING position — flier positions never become
  /// sighting pins (#30). Null for off-map strays.
  (double, double)? sightingPositionOf(String entityId) {
    for (final e in fieldHistory(entityId, positionKey)) {
      if (parsePositionKind(e.value ?? '') != PositionKind.sighting) {
        continue;
      }
      final pos = parsePosition(e.value);
      if (pos != null) return pos;
    }
    return null;
  }

  /// All flier positions ever recorded on the entity, newest first.
  List<(double, double)> flierPositions(String entityId) => [
        for (final e in fieldHistory(entityId, positionKey))
          if (parsePositionKind(e.value ?? '') == PositionKind.flier)
            if (parsePosition(e.value) case final pos?) pos
      ];

  /// The kind marker of a position value; plain "lat,lon" is a sighting.
  /// Flier positions are stored as "lat,lon@flier" — older versions
  /// fail to parse the suffix and simply ignore such entries.
  static PositionKind parsePositionKind(String value) =>
      value.endsWith('@${PositionKind.flier.name}')
          ? PositionKind.flier
          : PositionKind.sighting;

  /// Parses a "lat,lon" value (with or without a "@kind" suffix);
  /// null for absent or malformed input.
  static (double, double)? parsePosition(String? value) {
    if (value == null) return null;
    final at = value.indexOf('@');
    if (at >= 0) value = value.substring(0, at);
    final parts = value.split(',');
    if (parts.length != 2) return null;
    final lat = double.tryParse(parts[0].trim());
    final lon = double.tryParse(parts[1].trim());
    if (lat == null || lon == null) return null;
    if (lat < -90 || lat > 90 || lon < -180 || lon > 180) return null;
    return (lat, lon);
  }

  /// Records a position at the current (or given) date; sightings are
  /// stored plain, other kinds carry their marker.
  void recordPosition(String entityId, double lat, double lon,
          {PositionKind kind = PositionKind.sighting, DateTime? date}) =>
      append(
          entityId,
          positionKey,
          kind == PositionKind.sighting
              ? '$lat,$lon'
              : '$lat,$lon@${kind.name}',
          date: date);

  /// Cats whose current name or Remarks contain [query],
  /// case-insensitive — across all Clowders and Strays. Deleted Cats
  /// never appear.
  List<EntityView> searchCats(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return [
      for (final view in cats())
        if (view.name.toLowerCase().contains(q) ||
            (current(view.id, Keys.userField('remarks')) ?? '')
                .toLowerCase()
                .contains(q))
          view
    ];
  }

  // ---------------------------------------------------------------- images

  /// Longest edge an imported photo keeps; larger photos are scaled down.
  /// 2560 px prints sharp on a Card and stays cheap to sync.
  static const maxImageEdge = 2560;

  /// More pixels than this and an image is refused before it is
  /// decoded: a small file claiming 30000×30000 would otherwise ask for
  /// gigabytes. Read from the header alone.
  static const maxImagePixels = 40 * 1000 * 1000;

  /// True when [bytes] declare more than [maxImagePixels] in their
  /// header; false for anything decodable within bounds, and for bytes
  /// no decoder recognises (those fail later, cheaply).
  static bool imageTooLarge(Uint8List bytes) {
    try {
      final info = img.findDecoderForData(bytes)?.startDecode(bytes);
      if (info == null) return false;
      return info.width * info.height > maxImagePixels;
    } catch (_) {
      // Not even a readable header: nothing here to decode big.
      return false;
    }
  }

  /// Pure function: re-encodes a photo as JPEG, scaled to [maxImageEdge].
  /// CPU-heavy — call through `Isolate.run` from UI code.
  static Uint8List compressImage(Uint8List bytes) {
    if (imageTooLarge(bytes)) {
      throw const FormatException('Image too large');
    }
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

  /// What this catalog costs on the device: the database, and the photo
  /// blobs beside it. Photos are what grows — an entry row is bytes,
  /// a photo is hundreds of kilobytes.
  ({int dbBytes, int photoBytes, int photoCount, int entries}) storageUsage() {
    final pages = _db.select('PRAGMA page_count').first.values.first as int;
    final pageSize = _db.select('PRAGMA page_size').first.values.first as int;
    final rows =
        _db.select('SELECT COUNT(*) AS c FROM entries').first['c'] as int;
    final (photoBytes, photoCount) = _blobs.usage();
    return (
      dbBytes: pages * pageSize,
      photoBytes: photoBytes,
      photoCount: photoCount,
      entries: rows,
    );
  }

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

  // ------------------------------------------------------------ moments

  /// The log's high-water mark right now. A moment the catalog can be
  /// returned to is nothing more than this number: everything written
  /// after it is what going back removes.
  ///
  /// Load-bearing: `entries.seq` is AUTOINCREMENT, so SQLite never
  /// re-uses a number after a delete and an old mark keeps meaning the
  /// same moment.
  int currentSeq() =>
      _db.select('SELECT COALESCE(MAX(seq), 0) AS n FROM entries')
          .first['n'] as int;

  /// Records a moment. [seq] defaults to now; callers that only know
  /// afterwards whether anything happened pass the mark they took
  /// before — an operation that changed nothing records nothing.
  int addMoment(
      {required String cause, String? label, int? seq, DateTime? at}) {
    // Never above the log itself: entries can be removed physically, so
    // a mark taken earlier could otherwise point past the end and sort
    // as the newest moment for ever.
    final now = currentSeq();
    final mark = seq == null || seq > now ? now : seq;
    _db.execute(
      'INSERT INTO moments (seq, cause, label, at) VALUES (?, ?, ?, ?)',
      [mark, cause, label, _iso(at ?? DateTime.now())],
    );
    return _db.lastInsertRowId;
  }

  /// Every recorded moment, newest first.
  List<({int id, int seq, String cause, String? label, DateTime at})>
      moments() => [
            for (final r in _db.select(
                'SELECT id, seq, cause, label, at FROM moments '
                'ORDER BY seq DESC, id DESC'))
              (
                id: r['id'] as int,
                seq: r['seq'] as int,
                cause: r['cause'] as String,
                label: r['label'] as String?,
                at: DateTime.parse(r['at'] as String),
              )
          ];

  void removeMoment(int id) =>
      _db.execute('DELETE FROM moments WHERE id = ?', [id]);

  /// Everything written after [seq], raw: private entries and markers
  /// included, nothing filtered. Going back has to be able to put the
  /// catalog back exactly as it was.
  List<Entry> entriesAfter(int seq) => [
        for (final r
            in _db.select('SELECT * FROM entries WHERE seq > ? ORDER BY seq',
                [seq]))
          _entry(r)
      ];

  /// Physically removes everything written after [seq] and forgets the
  /// moments that lived up there. THE second append-only exception
  /// (ADR-0009), after hard delete. The caller writes the removed
  /// entries out first — this does not.
  ///
  /// The removed numbers stay claimed (see [_nextDseq]), which also
  /// stops a partner pushing an undone import straight back.
  void removeEntriesAfter(int seq) {
    final touched = <String>{
      for (final r in _db.select(
          'SELECT DISTINCT field FROM entries WHERE seq > ? AND field LIKE ?',
          [seq, '${Keys.imagePrefix}%']))
        (r['field'] as String).substring(Keys.imagePrefix.length)
    };
    _removeEntries('seq > ?', [seq], also: [
      ('DELETE FROM moments WHERE seq > ?', [seq])
    ]);
    for (final hash in touched) {
      if (!_imageReferenced(hash)) _blobs.remove(hash);
    }
  }

  /// Physically removes the entries matching [where] and keeps their
  /// numbers claimed, in one transaction.
  ///
  /// The claim has to land with the deletion, not after it: a crash in
  /// between would free a number a peer already holds, which is exactly
  /// the corruption ADR-0008 exists to prevent.
  void _removeEntries(String where, List<Object?> args,
      {List<(String, List<Object?>)> also = const []}) {
    final removed = _db.select(
        'SELECT device, MAX(dseq) AS m FROM entries WHERE $where '
        'GROUP BY device',
        args);
    _db.execute('BEGIN');
    try {
      _db.execute('DELETE FROM entries WHERE $where', args);
      for (final (sql, sqlArgs) in also) {
        _db.execute(sql, sqlArgs);
      }
      for (final r in removed) {
        _recordDiscarded(r['device'] as String, r['m'] as int);
      }
      _db.execute('COMMIT');
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  // ------------------------------------------------------------------ sync

  /// What this store has seen: max dseq per known device (ADR-0002).
  /// Includes dseqs of banned entries that were received-and-discarded,
  /// so peers stop re-offering banned material.
  Map<String, int> versionVector() {
    final vector = {
      for (final r in _db.select(
          'SELECT device, MAX(dseq) AS m FROM entries GROUP BY device'))
        r['device'] as String: r['m'] as int
    };
    for (final e in _discardedVector().entries) {
      if (e.value > (vector[e.key] ?? 0)) vector[e.key] = e.value;
    }
    return vector;
  }

  /// Every entry a peer with [vector] is missing, ordered (device, dseq).
  ///
  /// Defaults to public-only: private VALUES stay home, and so do the
  /// markers that say which values are private. What identifies an
  /// entity — its kind, its name, its Clowder membership — always
  /// travels, so a partner never receives a row pointing at something
  /// they have never heard of. Each withheld value leaves its
  /// `$withheld:<field>` marker behind, so the slot reads as redacted
  /// rather than empty.
  ///
  /// With [includePrivate] the private values come too, and they come
  /// regardless of [vector]: a peer that saw only the stub is past their
  /// numbers for good, and `applyEntries` ignores what it already holds.
  List<Entry> entriesSince(Map<String, int> vector,
      {bool includePrivate = false}) {
    final all = _db
        .select('SELECT * FROM entries ORDER BY device, dseq')
        .map(_entry);
    final result = <Entry>[];
    for (final e in all) {
      final fresh = e.dseq > (vector[e.device] ?? 0);
      final private = _isPrivateValue(e);
      if (includePrivate) {
        if (fresh || private) result.add(e);
        continue;
      }
      if (!fresh) continue;
      // Which values are private is nobody else's business either.
      if (e.field == Keys.private ||
          e.field.startsWith(Keys.privatePrefix)) {
        continue;
      }
      if (!private) result.add(e);
    }
    return result;
  }

  bool _isPrivateValue(Entry e) =>
      isFieldPrivate(e.entity, e.field);

  /// True when this entity's value for [field] stays home.
  ///
  /// The per-value marker decides, and a Private field definition covers
  /// that field on every entity. An entity's own Private mark has no
  /// effect of its own — the conversion at open turned old marks into
  /// per-value ones, and there the entity mark's story ends. Structural
  /// fields are never private, and a field definition's own properties
  /// never are: they describe the field, not a cat.
  bool isFieldPrivate(String id, String field) {
    if (Keys.isStructural(field)) return false;
    // Rows can carry a key that was merged away; the marker lives under
    // the surviving key. Without this, history written under the old
    // key would slip past the marker.
    final key = canonicalKey(field);
    final entity = resolveEntity(id);
    if (current(entity, Keys.type) == Kinds.fieldDef) return false;
    final marker = current(entity, Keys.privateField(key));
    if (marker != null) return marker == 'yes';
    if (key.startsWith('f:')) {
      final def = resolveEntity('fielddef:${key.substring(2)}');
      if (current(def, Keys.private) == 'yes') return true;
    }
    return false;
  }

  /// True when a partner knows a value exists here but was not given it.
  bool isWithheld(String id, String field) {
    final key = canonicalKey(field);
    final entity = resolveEntity(id);
    return current(entity, Keys.withheld(key)) == 'yes' &&
        current(entity, key) == null;
  }

  /// Marks or unmarks one value private. Unmarking re-asserts the value
  /// under fresh numbers, because peers moved past the originals while
  /// they were withheld.
  void setFieldPrivate(String id, String field, bool private,
      {DateTime? date}) =>
      _setFieldPrivate(id, field, private, date: date, reassert: !private);

  void _setFieldPrivate(String id, String field, bool private,
      {DateTime? date, required bool reassert}) {
    if (Keys.isStructural(field)) {
      throw StateError('$field identifies the entity and is never private');
    }
    final entity = resolveEntity(id);
    append(entity, Keys.privateField(field), private ? 'yes' : 'no',
        date: date);
    append(entity, Keys.withheld(field), private ? 'yes' : 'no', date: date);
    if (reassert) _reassertField(entity, field);
  }

  /// Gives every value of an entity marked Private under the old rule
  /// its own marker and its public trace, so a partner sees redacted
  /// slots instead of empty ones. Runs once per catalog.
  void _migrateValuePrivacy() {
    if (localSetting('privacyValuesMigrated') == '1') return;
    for (final r in _db.select(
        'SELECT DISTINCT entity FROM entries WHERE field = ?',
        [Keys.private])) {
      final entity = resolveEntity(r['entity'] as String);
      if (!isPrivate(entity)) continue;
      if (current(entity, Keys.type) == Kinds.fieldDef) continue;
      for (final field in valueFields(entity)) {
        if (current(entity, Keys.privateField(field)) != null) continue;
        append(entity, Keys.privateField(field), 'yes', as: seedAuthor);
        append(entity, Keys.withheld(field), 'yes', as: seedAuthor);
      }
    }
    setLocalSetting('privacyValuesMigrated', '1');
  }

  /// Canonical ids of every entity that holds a value for [field] —
  /// where a definition's privacy has to leave its public trace.
  List<String> entitiesWithValueFor(String field) {
    final keys = _keysFor(field);
    return {
      for (final r in _db.select(
          'SELECT DISTINCT entity FROM entries WHERE field IN '
          '(${_placeholders(keys.length)})',
          keys))
        resolveEntity(r['entity'] as String)
    }.toList();
  }

  /// Every field this entity carries a value for, private or not.
  List<String> valueFields(String id) {
    final entity = resolveEntity(id);
    return [
      for (final r in _db.select(
          'SELECT DISTINCT field FROM entries WHERE entity IN '
          '(${_placeholders(_group(entity).length)})',
          _group(entity)))
        if (!Keys.isStructural(r['field'] as String)) r['field'] as String
    ];
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
    // The entity switch is a shortcut for marking what it carries: every
    // value it has now, and — through the marker above — every value it
    // gets while the switch is on. A field definition is not marked
    // value by value: its mark means "this field is private on every
    // cat", which `isFieldPrivate` reads directly.
    if (current(canonical, Keys.type) == Kinds.fieldDef) {
      // A definition's mark covers that field everywhere, so the values
      // need no marks of their own — only the public trace that says a
      // value is there, on every entity that has one.
      final field = canonicalKey('f:${canonical.substring('fielddef:'.length)}');
      for (final entity in entitiesWithValueFor(field)) {
        if (current(entity, Keys.withheld(field)) == (private ? 'yes' : 'no')) {
          continue;
        }
        append(entity, Keys.withheld(field), private ? 'yes' : 'no',
            date: date);
      }
    } else {
      for (final field in valueFields(canonical)) {
        final marker = current(canonical, Keys.privateField(field));
        if (marker == (private ? 'yes' : 'no')) continue;
        // Unmarking re-asserts the whole entity once, below.
        _setFieldPrivate(canonical, field, private,
            date: date, reassert: false);
      }
    }
    if (!private) _reassertGroup(canonical);
  }

  /// Re-asserts one field's history under fresh numbers of this device,
  /// so a value that was withheld while private reaches peers whose
  /// version vectors already moved past the originals.
  void _reassertField(String canonical, String field) {
    final entities = _group(canonical);
    final rows = _db
        .select(
            'SELECT * FROM entries WHERE entity IN '
            '(${_placeholders(entities.length)}) AND field = ? '
            'ORDER BY device, dseq',
            [...entities, field])
        .map(_entry)
        .toList();
    final device = deviceId;
    var next = _nextDseq(device);
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
    var next = _nextDseq(device);
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
    return transaction(() {
    // Snapshot the pre-import winner of every field this batch touches.
    final touched = <(String, String)>{
      for (final e in entries) (e.entity, e.field)
    };
    final pre = <(String, String), Entry?>{};
    if (senderVector != null) {
      for (final t in touched) {
        // reminder = 0: a plan must not pose as the pre-import winner,
        // or a fact arriving over it would flag a bogus conflict.
        final rows = _db.select(
          'SELECT * FROM entries WHERE entity = ? AND field = ? '
          'AND reminder = 0 $_latest LIMIT 1',
          [t.$1, t.$2],
        );
        pre[t] = rows.isEmpty ? null : _entry(rows.first);
      }
    }
    final imported = <Entry>[];
    final self = deviceId;
    final ownMax = versionVector()[self] ?? 0;
    for (final e in entries) {
      // Rows under this device's own id come back only from its own
      // go-back files, and those never reach past the counter. One
      // beyond it is forged — applied, it would let partners' version
      // vectors skip this device's real, not yet synced entries for
      // good.
      if (e.device == self && e.dseq > ownMax) continue;
      if (_isBannedEntry(e)) {
        _recordDiscarded(e.device, e.dseq);
        continue;
      }
      _db.execute(
        'INSERT OR IGNORE INTO entries '
        '(device, dseq, entity, field, value, date, author, recorded, reminder) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          e.device,
          e.dseq,
          e.entity,
          e.field,
          e.value,
          _iso(e.date),
          e.author,
          _iso(e.recorded),
          e.reminder ? 1 : 0,
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
    // Value types may differ: the survivor's type wins, values are
    // strings on the wire, and non-conforming ones render raw.
    _merge(loserDefId, survivorDefId, 'fielddef:', date, reassert: false);
  }

  void _merge(String loserId, String survivorId, String prefix, DateTime? date,
      {bool reassert = true}) {
    return transaction(() {
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
      // Snapshot the pair's live plans first: a fact re-assertion below
      // is a newer append and would retire a plan on the same field
      // (#74) — those plans are re-asserted afterwards, so they stay
      // the newest append.
      final pairPlans = [
        for (final r in activeReminders())
          if (resolveEntity(r.entity) == resolveEntity(survivorId) ||
              resolveEntity(r.entity) == loserId)
            r
      ];
      final reasserted = <String>{};
      for (final key in survivorFields.keys) {
        if (key == Keys.type || key == Keys.deleted) continue;
        if (key.startsWith(Keys.imagePrefix)) continue;
        if (!loserFields.containsKey(key)) continue;
        if (loserFields[key] == survivorFields[key]) continue;
        append(survivorId, key, survivorFields[key], date: date);
        reasserted.add(key);
      }
      for (final r in pairPlans) {
        if (!reasserted.contains(r.field)) continue;
        append(survivorId, r.field, r.value,
            date: r.entry.date, reminder: true);
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
  /// True when this catalog has ever heard of the image, even if it is
  /// currently deleted — an archive file carries the bytes of deleted
  /// photos so a restore can bring them back.
  bool knowsImage(String hash) => _db.select(
        'SELECT 1 FROM entries WHERE field = ? LIMIT 1',
        [Keys.image(hash)],
      ).isNotEmpty;

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
    // A photo nobody could decode within bounds is not stored — the
    // viewer would decode whatever arrives.
    if (imageTooLarge(bytes)) return;
    if (sha256.convert(bytes).toString() != hash) {
      throw ArgumentError('Blob content does not match hash $hash');
    }
    // Banned photo bytes are dropped silently — received and discarded.
    if (localSetting('ban:blob:$hash') == '1') return;
    _blobs.put(hash, bytes);
  }

  // ---------------------------------------------------------------- family

  /// Family relations, all derived from the Mother reference plus birth
  /// date (CONTEXT.md): littermates share mother AND birth date,
  /// siblings share only the mother, kittens name this cat as mother.
  /// Father is display/navigation only.
  ({
    String? mother,
    String? father,
    List<String> littermates,
    List<String> siblings,
    List<String> kittens
  }) family(String catId) {
    final id = resolveEntity(catId);
    String? ref(String entity, String field) {
      final v = current(entity, field);
      return v == null ? null : resolveEntity(v);
    }

    final mother = ref(id, 'f:mother');
    final father = ref(id, 'f:father');
    final birth = current(id, 'f:birthdate');
    final littermates = <String>[];
    final siblings = <String>[];
    final kittens = <String>[];
    for (final c in cats()) {
      final cid = resolveEntity(c.id);
      if (cid == id) continue;
      final m = ref(cid, 'f:mother');
      // Kittens name this cat as mother OR father — dads see their
      // litter too.
      if (m == id || ref(cid, 'f:father') == id) {
        kittens.add(cid);
        continue;
      }
      if (mother != null && m == mother) {
        if (birth != null && current(cid, 'f:birthdate') == birth) {
          littermates.add(cid);
        } else {
          siblings.add(cid);
        }
      }
    }
    return (
      mother: mother,
      father: father,
      littermates: littermates,
      siblings: siblings,
      kittens: kittens
    );
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

  /// Undoes a deletion: the entity is visible again, and its photos
  /// come back for every blob still present (an archive import brings
  /// the bytes with it). Ordinary entries, so the restore syncs like
  /// the deletion did.
  void restoreEntity(String id, {DateTime? date}) {
    final entity = resolveEntity(id);
    append(entity, Keys.deleted, null, date: date);
    for (final field in currentFields(entity).entries) {
      if (!field.key.startsWith(Keys.imagePrefix)) continue;
      if (field.value != 'deleted') continue;
      final hash = field.key.substring(Keys.imagePrefix.length);
      if (_blobs.get(hash) != null) {
        append(entity, field.key, 'added', date: date);
      }
    }
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
        idDisplay: IdDisplay.values.asNameMap()[fields[Keys.fieldIdDisplay]] ??
            IdDisplay.plain,
        lookupUrl: fields[Keys.fieldLookupUrl],
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
      IdDisplay idDisplay = IdDisplay.plain,
      String? lookupUrl,
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
    if (type == FieldType.id && idDisplay != IdDisplay.plain) {
      append(id, Keys.fieldIdDisplay, idDisplay.name, date: date);
    }
    if (type == FieldType.id && lookupUrl != null && lookupUrl.isNotEmpty) {
      append(id, Keys.fieldLookupUrl, lookupUrl, date: date);
    }
    return id;
  }

  /// Points an ID Field at a service: a URL template with `{value}`,
  /// or null/empty to detach it again. Recorded history like any other
  /// change.
  void setFieldLookupUrl(String fieldDefId, String? template,
      {DateTime? date}) {
    if (current(fieldDefId, Keys.type) != Kinds.fieldDef) {
      throw ArgumentError('Not a field definition: $fieldDefId');
    }
    if (template != null && template.isNotEmpty && !isWebLookup(template)) {
      throw ArgumentError('A lookup link must start with http:// or https://');
    }
    append(fieldDefId, Keys.fieldLookupUrl,
        (template == null || template.isEmpty) ? null : template,
        date: date);
  }

  /// Replaces a choice Field's option list. Values already stored that
  /// fall outside the new list keep displaying as text (same rule as
  /// merge); the change is recorded history like any other.
  void setFieldOptions(String fieldDefId, List<String> options,
      {DateTime? date}) {
    if (current(fieldDefId, Keys.type) != Kinds.fieldDef) {
      throw ArgumentError('Not a field definition: $fieldDefId');
    }
    append(fieldDefId, Keys.fieldOptions, options.join('\n'), date: date);
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
      // Chip IDs are transponder numbers — the Card shows them scannable.
      if (f.type == FieldType.id) {
        append(id, Keys.fieldIdDisplay, IdDisplay.barcode.name,
            as: seedAuthor);
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

  /// Bytes and file count currently stored — the About page's size line.
  (int bytes, int count) usage();
}

class _FileBlobStore implements _BlobStore {
  final Directory _dir;

  _FileBlobStore(String path) : _dir = Directory(path) {
    _dir.createSync(recursive: true);
  }

  /// A blob name is its SHA-256, nothing else: a hash arriving from a
  /// bundle or a sync peer ("../../x") must never leave this directory.
  /// Anything else is treated as a blob that does not exist — never an
  /// error, so a hostile entry cannot abort an import either.
  static final _hex64 = RegExp(r'^[0-9a-f]{64}$');

  File? _file(String hash) =>
      _hex64.hasMatch(hash) ? File('${_dir.path}/$hash.jpg') : null;

  @override
  void put(String hash, Uint8List bytes) {
    final f = _file(hash);
    if (f == null || f.existsSync()) return;
    // Written beside, then renamed: a kill mid-write leaves a stray
    // .tmp, never a truncated photo that counts as present.
    final tmp = File('${f.path}.tmp');
    tmp.writeAsBytesSync(bytes, flush: true);
    tmp.renameSync(f.path);
  }

  @override
  Uint8List? get(String hash) {
    final f = _file(hash);
    return f != null && f.existsSync() ? f.readAsBytesSync() : null;
  }

  @override
  (int, int) usage() {
    var bytes = 0, count = 0;
    for (final f in _dir.listSync()) {
      if (f is File) {
        bytes += f.lengthSync();
        count++;
      }
    }
    return (bytes, count);
  }

  @override
  void remove(String hash) {
    final f = _file(hash);
    if (f != null && f.existsSync()) f.deleteSync();
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

  @override
  (int, int) usage() {
    var bytes = 0;
    for (final b in _blobs.values) {
      bytes += b.length;
    }
    return (bytes, _blobs.length);
  }
}
