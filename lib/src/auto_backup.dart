import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'private_temp.dart';
import 'sync/saf_folder.dart';

/// Uninstall-proof safety net: whenever the app goes to the background
/// and the catalog changed, a full sync bundle lands in a location the
/// system owns — Android: Documents/catlog (MediaStore, survives
/// uninstall), desktop: the user's Downloads folder. Restoring is the
/// ordinary "import sync bundle" button.
/// Local setting holding the last auto-backup failure; empty after a
/// successful run. Shown on the Sync screen.
const backupErrorKey = 'lastBackupError';

/// Local setting: when the last automatic copy was written (ISO 8601).
const backupAtKey = 'lastBackupAt';

/// Shared setting: the tree URI of a folder every copy also goes to —
/// Google Drive, Dropbox, Nextcloud, whatever the picker offered. Set
/// on the Backups page; Android only.
const backupFolderKey = 'backupFolder';

/// Puts [path] as [name] into the chosen folder's `catlog-backups`.
Future<void> copyToBackupFolder(String tree, String path, String name) =>
    SafSyncFolder(tree, root: 'catlog-backups')
        .write('', name, File(path).readAsBytesSync());

/// The marker Android's backup agent leaves after it restored the app's
/// files (see CatlogBackupAgent.kt); holds the moment as ISO 8601.
const restoredMarkerName = 'restored-from-backup';

/// When Android put this install's files back from the Google backup,
/// or null when that never happened here.
Future<DateTime?> restoredFromBackupAt() async {
  if (!Platform.isAndroid) return null;
  try {
    final dir = await getApplicationSupportDirectory();
    final marker = File('${dir.path}/$restoredMarkerName');
    if (!marker.existsSync()) return null;
    return DateTime.tryParse(marker.readAsStringSync().trim());
  } catch (_) {
    return null;
  }
}

/// The file a catalog's backup is written to. One per catalog, named
/// after it, so using one catalog cannot overwrite another's safety net
/// and a folder of these files still says which city is which.
String backupFileName(String? catalogName) {
  final name = (catalogName ?? '').trim();
  if (name.isEmpty) return 'catlog-backup.catsync';
  final safe = name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  // Two catalogs must never share a file. A name the file system cannot
  // carry — 北京, Москва — or one that only differs in punctuation gets
  // a short fingerprint of the real name, so "Cats!" and "Cats?" stay
  // apart and a Chinese name is not silently the shared fallback.
  final faithful =
      safe == name.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
  if (safe.isEmpty) return 'catlog-${_fingerprint(name)}.catsync';
  return faithful
      ? 'catlog-$safe.catsync'
      : 'catlog-$safe-${_fingerprint(name)}.catsync';
}

/// Short, stable fingerprint of a name (FNV-1a). Stable across launches,
/// which a Dart hashCode is not promised to be.
String _fingerprint(String value) {
  var hash = 0x811c9dc5;
  for (final unit in value.runes) {
    hash = (hash ^ unit) & 0xffffffff;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}

/// The folder a fresh install looks in for the backups of the install
/// before it. Desktop: the Downloads folder the backups go to; iOS:
/// Documents. Android has none: the MediaStore rows in Documents/catlog
/// survive an uninstall, but the next install owns none of them and
/// may not list them — the restore page asks for the folder instead
/// (see RestoreChannel). Null where the platform offers none.
Future<Directory?> backupFolder() async {
  try {
    if (Platform.isAndroid) return null;
    if (Platform.isIOS) return await getApplicationDocumentsDirectory();
    return await getDownloadsDirectory();
  } catch (_) {
    return null;
  }
}

/// Removes a file from where the backups go — after a rename, the file
/// under the old name is no longer anybody's backup.
Future<void> removeBesideBackups(String name) async {
  try {
    if (Platform.isAndroid) {
      await const MethodChannel('catlog/backup')
          .invokeMethod('deleteFromDocuments', {'name': name});
      return;
    }
    final dir = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getDownloadsDirectory();
    if (dir == null) return;
    final file = File('${dir.path}/$name');
    if (file.existsSync()) file.deleteSync();
  } catch (_) {
    // A leftover file is untidy, never a failure worth stopping for.
  }
}

/// Puts a file where the automatic backups go, and says where that was
/// in words the reader can act on. Android uses a MediaStore insert into
/// Documents/catlog so the file survives an uninstall; desktop uses the
/// Downloads folder; iOS has no folder that survives an uninstall, so
/// the app's Documents directory — visible in Files — is the best there
/// is.
Future<String> saveBesideBackups(String path, String name) async {
  if (Platform.isAndroid) {
    await const MethodChannel('catlog/backup')
        .invokeMethod('saveToDocuments', {'path': path, 'name': name});
    return 'Documents/catlog/$name';
  }
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    final downloads = await getDownloadsDirectory();
    if (downloads == null) throw const FileSystemException('No Downloads folder');
    final to = '${downloads.path}/$name';
    File(path).copySync(to);
    return to;
  }
  final docs = await getApplicationDocumentsDirectory();
  final to = '${docs.path}/$name';
  File(path).copySync(to);
  return to;
}

Future<void>? _inFlight;

/// One backup at a time: Android fires "inactive" and "paused" back to
/// back, and both would pass the vector check before either wrote it.
/// [force] writes even when nothing changed — the Back up now button.
Future<void> autoBackup(CatalogStore store,
    {Future<String> Function(String path, String name)? save,
    Future<void> Function(String tree, String path, String name)? copy,
    bool force = false}) {
  final running = _inFlight;
  if (running != null) return running;
  final run =
      _autoBackup(store, save: save, copy: copy, force: force).whenComplete(() {
    _inFlight = null;
  });
  _inFlight = run;
  return run;
}

Future<void> _autoBackup(CatalogStore store,
    {Future<String> Function(String path, String name)? save,
    Future<void> Function(String tree, String path, String name)? copy,
    bool force = false}) async {
  try {
    // Only when something actually changed since the last backup.
    final vector = store.versionVector().toString();
    if (!force && store.localSetting('lastBackupVector') == vector) return;

    // A catalog without cats and clowders backs up nothing worth keeping —
    // and a fresh install must not shadow the pre-uninstall backup the
    // user is about to restore. (Seeded starter Fields alone don't count.)
    if (store.cats().isEmpty && store.clowders().isEmpty) return;

    // Own-device safety net: the backup always carries Private data too
    // — so the staging file is private and short-lived.
    final name = backupFileName(store.localSetting(catalogNameKey));
    await withPrivateFile(name, (path) async {
      writeBundle(store, path, includePrivate: true);
      await (save ?? saveBesideBackups)(path, name);
      // And the chosen folder, when there is one: the same file again.
      final tree = store.localSetting(backupFolderKey);
      if (tree != null && tree.isNotEmpty) {
        await (copy ?? copyToBackupFolder)(tree, path, name);
      }
    });
    store.setLocalSetting('lastBackupVector', vector);
    store.setLocalSetting(backupAtKey, DateTime.now().toIso8601String());
    store.setLocalSetting(backupErrorKey, '');
  } catch (e) {
    // A failed background backup must never crash the app; the next
    // pause tries again. Recorded so the failure is discoverable.
    debugPrint('autoBackup failed: $e');
    try {
      store.setLocalSetting(backupErrorKey, e.toString());
    } catch (_) {}
  }
}
