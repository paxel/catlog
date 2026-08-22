import 'dart:io';
import 'dart:math';

import 'package:sqlite3/sqlite3.dart';

import 'store.dart';

/// One catalog on disk: a folder holding its database and its photos.
///
/// A catalog is self-contained — its own entries, photos, device id and
/// sync partners — so copying the folder copies the whole catalog. Its
/// display name lives inside it; the registry only caches the name for
/// listing.
class CatalogInfo {
  final String id;
  final String name;
  final Directory dir;

  const CatalogInfo({required this.id, required this.name, required this.dir});

  String get dbPath => '${dir.path}/catlog.db';

  /// Database plus photos, in bytes. Zero for a folder that is gone.
  int get sizeInBytes {
    if (!dir.existsSync()) return 0;
    var total = 0;
    for (final f in dir.listSync(recursive: true)) {
      if (f is File) {
        try {
          total += f.lengthSync();
        } catch (_) {}
      }
    }
    return total;
  }
}

/// Thrown when a name would collide with a catalog that already exists.
class DuplicateCatalogName implements Exception {
  final String name;
  const DuplicateCatalogName(this.name);

  @override
  String toString() => 'A catalog named "$name" already exists';
}

/// Thrown when the one-time move into the multi-catalog layout fails.
/// The old catalog is left where it was and stays openable.
class MigrationFailed implements Exception {
  final String reason;
  const MigrationFailed(this.reason);

  @override
  String toString() =>
      'Could not move the catalog into the new layout: $reason. '
      'Nothing was lost — the old catalog is untouched. Free some space, '
      'check that the app may write to its own folder, and start the app '
      'again.';
}

/// Every catalog on this device, and the settings that belong to the app
/// rather than to any one of them.
///
/// Layout under the root directory:
///
///     app.db                     registry + shared settings
///     catalogs/<id>/catlog.db    one catalog
///     catalogs/<id>/images/      its photos
class CatalogManager implements SharedSettings {
  final Directory root;
  final Database _db;

  CatalogManager._(this.root, this._db);

  /// The language chosen on this device, from the shared settings or —
  /// before the one-time move — from the single catalog that used to
  /// hold it. Read without opening a manager, because the name of the
  /// catalog the move creates has to be in that language.
  static String? savedLocale(String rootPath) {
    for (final (path, key) in [
      ('$rootPath/app.db', 'locale'),
      ('$rootPath/catlog.db', 'u:locale'),
    ]) {
      if (!File(path).existsSync()) continue;
      final db = sqlite3.open(path);
      try {
        final table = key == 'locale' ? 'settings' : 'local_settings';
        final rows =
            db.select('SELECT value FROM $table WHERE key = ?', [key]);
        if (rows.isNotEmpty) return rows.first['value'] as String;
      } catch (_) {
        // A database without the table is simply one that has no answer.
      } finally {
        db.dispose();
      }
    }
    return null;
  }

  /// Opens the manager, creating the layout if needed. An older
  /// single-catalog installation is moved in on the way, named
  /// [defaultName] — the word that used to be the home screen's title.
  factory CatalogManager.open(String rootPath,
      {String defaultName = 'Catalog'}) {
    final root = Directory(rootPath)..createSync(recursive: true);
    final db = sqlite3.open('${root.path}/app.db');
    db.execute('''
      PRAGMA journal_mode = WAL;
      CREATE TABLE IF NOT EXISTS catalogs (
        id      TEXT PRIMARY KEY,
        name    TEXT NOT NULL,
        created TEXT NOT NULL
      );
      CREATE TABLE IF NOT EXISTS settings (
        key   TEXT PRIMARY KEY,
        value TEXT NOT NULL
      );
    ''');
    final manager = CatalogManager._(root, db);
    manager._adopt(defaultName);
    return manager;
  }

  void close() => _db.dispose();

  Directory get _catalogsDir =>
      Directory('${root.path}/catalogs')..createSync(recursive: true);

  // ------------------------------------------------------------- registry

  List<CatalogInfo> catalogs() => [
        for (final r in _db.select(
            'SELECT id, name FROM catalogs ORDER BY created, name'))
          CatalogInfo(
            id: r['id'] as String,
            name: r['name'] as String,
            dir: Directory('${_catalogsDir.path}/${r['id']}'),
          )
      ];

  CatalogInfo? byId(String id) =>
      catalogs().where((c) => c.id == id).firstOrNull;

  /// The catalog to open on launch: the one last used, or the first.
  CatalogInfo get active {
    final all = catalogs();
    final wanted = get('activeCatalog');
    return all.where((c) => c.id == wanted).firstOrNull ?? all.first;
  }

  set active(CatalogInfo catalog) => set('activeCatalog', catalog.id);

  /// Opens a catalog's store, wired to the shared settings.
  CatalogStore openStore(CatalogInfo catalog) {
    catalog.dir.createSync(recursive: true);
    return CatalogStore.open(catalog.dbPath)..shared = this;
  }

  /// Creates an empty catalog. Names are unique so the switcher and the
  /// backup files stay unambiguous.
  CatalogInfo create(String name) {
    final clean = name.trim();
    if (clean.isEmpty) throw ArgumentError('A catalog needs a name');
    _requireFreeName(clean);
    final id = _newId();
    _db.execute(
      'INSERT INTO catalogs (id, name, created) VALUES (?, ?, ?)',
      [id, clean, DateTime.now().toUtc().toIso8601String()],
    );
    final info = CatalogInfo(
        id: id,
        name: clean,
        dir: Directory('${_catalogsDir.path}/$id')..createSync(recursive: true));
    // The name lives in the catalog too, so a copied folder is complete.
    final store = openStore(info);
    store.setLocalSetting(catalogNameKey, clean);
    store.close();
    return info;
  }

  void rename(String id, String name) {
    final clean = name.trim();
    if (clean.isEmpty) throw ArgumentError('A catalog needs a name');
    final current = byId(id);
    if (current == null) return;
    if (current.name != clean) _requireFreeName(clean);
    _db.execute('UPDATE catalogs SET name = ? WHERE id = ?', [clean, id]);
    final store = openStore(current);
    store.setLocalSetting(catalogNameKey, clean);
    store.close();
  }

  /// Removes a catalog and everything in it. The caller writes the
  /// keepsake bundle first — this is the point of no return.
  ///
  /// The catalog currently open is refused: its database is held open by
  /// the app, and deleting the folder underneath it would leave every
  /// cat added afterwards writing into a file that no longer exists.
  /// Switch to another catalog first.
  void delete(String id) {
    final info = byId(id);
    if (info == null) return;
    if (catalogs().length == 1) {
      throw StateError('The last catalog cannot be deleted');
    }
    if (active.id == id) {
      throw StateError('Switch to another catalog before deleting this one');
    }
    // Files first: if they cannot go, the catalog stays listed and the
    // keeper is told, rather than a folder nobody can reach any more.
    if (info.dir.existsSync()) info.dir.deleteSync(recursive: true);
    _db.execute('DELETE FROM catalogs WHERE id = ?', [id]);
  }

  void _requireFreeName(String name) {
    final taken = catalogs()
        .any((c) => c.name.toLowerCase() == name.toLowerCase());
    if (taken) throw DuplicateCatalogName(name);
  }

  // ------------------------------------------------------ shared settings

  @override
  String? get(String key) {
    final rows =
        _db.select('SELECT value FROM settings WHERE key = ?', [key]);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  @override
  void set(String key, String value) => _db.execute(
        'INSERT INTO settings (key, value) VALUES (?, ?) '
        'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
        [key, value],
      );

  @override
  void remove(String key) =>
      _db.execute('DELETE FROM settings WHERE key = ?', [key]);

  @override
  List<(String, String)> byPrefix(String prefix) => [
        for (final r in _db.select(
            'SELECT key, value FROM settings WHERE key LIKE ?',
            ['$prefix%']))
          (
            (r['key'] as String).substring(prefix.length),
            r['value'] as String
          )
      ];

  // ------------------------------------------------------------ migration

  /// Moves a pre-catalogs installation — `catlog.db` and `images/` in
  /// the root — into the new layout, and copies the settings that are
  /// now shared out of it. Does nothing once a catalog is registered.
  void _adopt(String defaultName) {
    if (catalogs().isNotEmpty) return;
    final oldDb = File('${root.path}/catlog.db');
    if (!oldDb.existsSync()) {
      create(defaultName);
      return;
    }
    _checkpoint(oldDb);
    final id = _newId();
    final dir = Directory('${_catalogsDir.path}/$id');
    var committed = false;
    try {
      dir.createSync(recursive: true);
      // Copy first, verify, and only then remove the original: an
      // interrupted move must leave a catalog that still opens.
      oldDb.copySync('${dir.path}/catlog.db');
      final oldImages = Directory('${root.path}/images');
      if (oldImages.existsSync()) {
        _copyDir(oldImages, Directory('${dir.path}/images'));
      }
      final moved = CatalogStore.open('${dir.path}/catlog.db');
      final name = moved.localSetting(catalogNameKey) ?? defaultName;
      moved.setLocalSetting(catalogNameKey, name);
      _liftSharedSettings(moved);
      moved.close();
      _db.execute(
        'INSERT INTO catalogs (id, name, created) VALUES (?, ?, ?)',
        [id, name, DateTime.now().toUtc().toIso8601String()],
      );
      // Past this line the copy is the catalog: tidying up the old
      // location must never be able to take it away again, so failures
      // from here on leave litter rather than a hole.
      committed = true;
      oldDb.deleteSync();
      for (final side in ['-wal', '-shm']) {
        try {
          final f = File('${oldDb.path}$side');
          if (f.existsSync()) f.deleteSync();
        } catch (_) {}
      }
      try {
        if (oldImages.existsSync()) oldImages.deleteSync(recursive: true);
      } catch (_) {}
    } catch (e) {
      if (committed) return;
      // Leave nothing half-moved: the original stays where it was and
      // the next launch tries again.
      try {
        if (dir.existsSync()) dir.deleteSync(recursive: true);
      } catch (_) {}
      _db.execute('DELETE FROM catalogs WHERE id = ?', [id]);
      throw MigrationFailed('$e');
    }
  }

  /// Folds the write-ahead log back into the database so the side files
  /// carry nothing that would be lost by moving the database alone.
  void _checkpoint(File db) {
    final handle = sqlite3.open(db.path);
    try {
      handle.execute('PRAGMA wal_checkpoint(TRUNCATE)');
    } finally {
      handle.dispose();
    }
  }

  /// Copies the settings that belong to the app out of the catalog that
  /// used to be the only one, so nothing is asked for twice.
  void _liftSharedSettings(CatalogStore from) {
    final author = from.author;
    if (author != null && author.isNotEmpty && get('author') == null) {
      set('author', author);
    }
    for (final (key, value) in from.allLocalSettings()) {
      if (isSharedSetting(key) && get(key) == null) set(key, value);
    }
  }

  void _copyDir(Directory from, Directory to) {
    to.createSync(recursive: true);
    for (final f in from.listSync()) {
      if (f is File) f.copySync('${to.path}/${f.uri.pathSegments.last}');
    }
  }

  static final _random = Random.secure();

  String _newId() => List.generate(
      16, (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}

/// Where a catalog keeps its own display name.
const catalogNameKey = 'catalogName';
