import 'dart:io';

/// A file with catalog data on its way to a share sheet or a backup
/// folder lives in a directory only this process may read
/// (`createTempSync` makes it 0700 — the shared /tmp on Linux is
/// world-readable) and is gone when [body] returns, success or not.
Future<T> withPrivateFile<T>(
    String name, Future<T> Function(String path) body) async {
  final dir = Directory.systemTemp.createTempSync('catlog-');
  try {
    return await body('${dir.path}/$name');
  } finally {
    try {
      dir.deleteSync(recursive: true);
    } catch (_) {
      // Already gone, or on a filesystem that refuses: nothing to do.
    }
  }
}
