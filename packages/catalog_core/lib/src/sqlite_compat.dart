import 'dart:ffi';

import 'package:sqlite3/open.dart';

/// On desktop Linux the sqlite3 package expects `libsqlite3.so`, but plain
/// distro installs often ship only `libsqlite3.so.0` (the `.so` symlink comes
/// with the -dev package). Registers a loader that accepts either.
///
/// Call once before the first [CatalogStore] on pure-Dart Linux (tests,
/// CLI). Flutter apps bundle sqlite3 via sqlite3_flutter_libs instead and
/// must not call this.
void useSystemSqlite() {
  open.overrideFor(OperatingSystem.linux, () {
    try {
      return DynamicLibrary.open('libsqlite3.so');
    } on ArgumentError {
      return DynamicLibrary.open('libsqlite3.so.0');
    }
  });
}
