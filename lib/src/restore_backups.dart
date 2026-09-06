import 'dart:io';

import 'package:catalog_core/catalog_core.dart';

/// Restoring after a reinstall (#102): the backups the install before
/// left behind, grouped by catalog, and the way to bring each back.

/// One catalog's backup files, newest first.
class BackupSet {
  final String name;
  final List<File> files;

  const BackupSet(this.name, this.files);

  DateTime get newest => files.first.lastModifiedSync();
}

/// The part of a backup file name that identifies its catalog:
/// `catlog-berlin-nord.catsync` → `berlin-nord`. Older releases' files
/// came back from MediaStore as `.catsync.zip`; same stem.
String backupStem(String fileName) {
  var stem = fileName;
  if (stem.endsWith('.zip')) stem = stem.substring(0, stem.length - 4);
  if (stem.endsWith('.catsync')) stem = stem.substring(0, stem.length - 8);
  if (stem.startsWith('catlog-')) stem = stem.substring(7);
  return stem;
}

/// The catalog name a backup file name stands for:
/// `catlog-berlin-nord.catsync` reads "Berlin Nord". A fingerprint suffix
/// (names the file system could not carry) is dropped for the label; the
/// unnamed fallback reads "Backup".
String catalogNameFromFile(String fileName) {
  final stem = backupStem(fileName).replaceFirst(RegExp(r'-[0-9a-f]{8}$'), '');
  if (stem.isEmpty || stem == 'backup') return 'Backup';
  return stem
      .split('-')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

/// Whether a file is a catalog backup worth offering: a `.catsync` (or a
/// `.catsync.zip`, as MediaStore renamed them in earlier releases) written
/// by the app, not a go-back file — those hold what was removed, not a
/// catalog.
bool isRestorableBackup(String fileName) =>
    (fileName.endsWith('.catsync') || fileName.endsWith('.catsync.zip')) &&
    fileName.startsWith('catlog-') &&
    !fileName.startsWith('catlog-undone-');

/// Groups [files] into catalogs by their exact file stem — "Cats" and
/// "Cats!" stay two catalogs even though their labels read alike — each
/// set newest first, the sets by their newest file. Every file of a
/// catalog is kept: an older one may still carry photo bytes the newest
/// lacks.
List<BackupSet> findBackups(Iterable<File> files) {
  final byStem = <String, List<File>>{};
  for (final f in files) {
    final name = f.uri.pathSegments.last;
    if (!isRestorableBackup(name)) continue;
    byStem.putIfAbsent(backupStem(name), () => []).add(f);
  }
  final sets = [
    for (final MapEntry(key: stem, value: list) in byStem.entries)
      BackupSet(
        catalogNameFromFile('catlog-$stem.catsync'),
        list..sort(
          (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()),
        ),
      ),
  ]..sort((a, b) => b.newest.compareTo(a.newest));
  return sets;
}

/// The backups in [folder], grouped. Empty when the folder is missing.
List<BackupSet> backupsIn(Directory? folder) =>
    folder == null || !folder.existsSync()
    ? const []
    : findBackups(folder.listSync().whereType<File>());

/// Brings one catalog back: a new catalog under the set's name (numbered
/// when the name is taken), every file imported newest first. Importing
/// is idempotent, so the older files add only what the newest lacks. A
/// file that will not read is skipped; the rest still lands.
CatalogInfo restoreBackupSet(CatalogManager catalogs, BackupSet set) {
  CatalogInfo? made;
  for (var n = 1; made == null; n++) {
    final name = n == 1 ? set.name : '${set.name} ($n)';
    try {
      made = catalogs.create(name);
    } on DuplicateCatalogName {
      continue;
    }
  }
  final store = catalogs.openStore(made);
  try {
    for (final file in set.files) {
      try {
        importBundle(store, file.path);
      } catch (_) {
        // A damaged or foreign file: the others still count.
      }
    }
  } finally {
    store.close();
  }
  return made;
}
