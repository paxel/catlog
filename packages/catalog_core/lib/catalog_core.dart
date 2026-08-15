/// Pure-Dart catalog core for cat(a)log.
///
/// Owns the append-only entry log over SQLite (see ADR-0001) and the
/// latest-wins projection. The UI and future sync transports talk only
/// to [CatalogStore].
library;

export 'src/entry.dart';
export 'src/fields.dart';
export 'src/folder_sync.dart';
export 'src/sqlite_compat.dart';
export 'src/store.dart';
