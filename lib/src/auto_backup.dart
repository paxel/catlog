import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Uninstall-proof safety net: whenever the app goes to the background
/// and the catalog changed, a full sync bundle lands in a location the
/// system owns — Android: Downloads/catlog (MediaStore, survives
/// uninstall), desktop: the user's Downloads folder. Restoring is the
/// ordinary "import sync bundle" button.
/// Local setting holding the last auto-backup failure; empty after a
/// successful run. Shown on the Sync screen.
const backupErrorKey = 'lastBackupError';

/// Puts a file where the automatic backups go, and says where that was
/// in words the reader can act on. Android uses a MediaStore insert into
/// Downloads/catlog so the file survives an uninstall; desktop uses the
/// Downloads folder; iOS has no folder that survives an uninstall, so
/// the app's Documents directory — visible in Files — is the best there
/// is.
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

/// Removes a file from where the backups go — after a rename, the file
/// under the old name is no longer anybody's backup.
Future<void> removeBesideBackups(String name) async {
  try {
    if (Platform.isAndroid) {
      await const MethodChannel('catlog/backup')
          .invokeMethod('deleteFromDownloads', {'name': name});
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

Future<String> saveBesideBackups(String path, String name) async {
  if (Platform.isAndroid) {
    await const MethodChannel('catlog/backup')
        .invokeMethod('saveToDownloads', {'path': path, 'name': name});
    return 'Downloads/catlog/$name';
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

Future<void> autoBackup(CatalogStore store) async {
  try {
    // Only when something actually changed since the last backup.
    final vector = store.versionVector().toString();
    if (store.localSetting('lastBackupVector') == vector) return;

    // A catalog without cats and clowders backs up nothing worth keeping —
    // and a fresh install must not shadow the pre-uninstall backup the
    // user is about to restore. (Seeded starter Fields alone don't count.)
    if (store.cats().isEmpty && store.clowders().isEmpty) return;

    final tmp = await getTemporaryDirectory();
    // Own-device safety net: the backup always carries Private data too.
    final name = backupFileName(store.localSetting(catalogNameKey));
    final path =
        writeBundle(store, '${tmp.path}/$name', includePrivate: true);
    await saveBesideBackups(path, name);
    store.setLocalSetting('lastBackupVector', vector);
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
