import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Uninstall-proof safety net: whenever the app goes to the background
/// and the catalog changed, a full sync bundle lands in a location the
/// system owns — Android: Downloads/catlog (MediaStore, survives
/// uninstall), desktop: the user's Downloads folder. Restoring is the
/// ordinary "import sync bundle" button.
Future<void> autoBackup(CatalogStore store) async {
  try {
    // Only when something actually changed since the last backup.
    final vector = store.versionVector().toString();
    if (store.localSetting('lastBackupVector') == vector) return;

    final tmp = await getTemporaryDirectory();
    // Own-device safety net: the backup always carries Private data too.
    final path = writeBundle(store, '${tmp.path}/catlog-backup.catsync',
        includePrivate: true);

    if (Platform.isAndroid) {
      // Tiny platform channel instead of a plugin: MediaStore insert
      // into Downloads/catlog (see MainActivity.kt).
      await const MethodChannel('catlog/backup').invokeMethod(
          'saveToDownloads',
          {'path': path, 'name': 'catlog-backup.catsync'});
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      final downloads = await getDownloadsDirectory();
      if (downloads == null) return;
      File(path).copySync('${downloads.path}/catlog-backup.catsync');
    } else {
      // iOS: no system folder survives uninstall; the app's Documents
      // directory is at least visible in the Files app.
      final docs = await getApplicationDocumentsDirectory();
      File(path).copySync('${docs.path}/catlog-backup.catsync');
    }
    store.setLocalSetting('lastBackupVector', vector);
  } catch (_) {
    // A failed background backup must never crash the app; the next
    // pause tries again.
  }
}
