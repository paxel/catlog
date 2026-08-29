/// Pure-Dart catalog core for cat(a)log.
///
/// Owns the append-only entry log over SQLite (see ADR-0001) and the
/// latest-wins projection. The UI and future sync transports talk only
/// to [CatalogStore].
library;

export 'src/appointments.dart';
export 'src/archive.dart';
export 'src/bundle.dart';
export 'src/catalogs.dart';
export 'src/csv_export.dart';
export 'src/duplicates.dart';
export 'src/entry.dart';
export 'src/fields.dart';
export 'src/folder_sync.dart';
export 'src/flier_share.dart';
export 'src/ics.dart';
export 'src/match.dart';
export 'src/transfer.dart';
export 'src/pair_code.dart';
export 'src/partial_date.dart';
export 'src/registry.dart';
export 'src/savepoints.dart';
export 'src/sqlite_compat.dart';
export 'src/store.dart';
