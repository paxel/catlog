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
    final path = writeBundle(store, '${tmp.path}/catlog-backup.catsync',
        includePrivate: true);
    await saveBesideBackups(path, 'catlog-backup.catsync');
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
