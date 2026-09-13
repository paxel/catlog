import 'dart:convert';

import 'folder_sync.dart';
import 'store.dart';

/// Watching the shared folder for what the others wrote, cheaply: a
/// device's file only grows, so a file bigger than at the last sync
/// may hold news. Only a grown file is read, and only to count the
/// entries this store does not hold yet.

/// The foreign device files with their sizes, keyed `<dir>/<name>`,
/// from the same directories [folderSyncIn] reads: the catalog's own
/// subfolder and the root.
Future<Map<String, int>> foreignFileSizes(
  SyncFolder folder,
  String deviceId, {
  String? catalog,
}) async {
  final readDirs = catalog == null ? [''] : [catalog, ''];
  final out = <String, int>{};
  for (final dir in readDirs) {
    final sizes = await folder.sizes(dir);
    for (final MapEntry(key: name, value: size) in sizes.entries) {
      if (!name.endsWith('.jsonl') && !name.endsWith('.jsonl2')) continue;
      if (name == '$deviceId.jsonl' || name == '$deviceId.jsonl2') continue;
      out['$dir/$name'] = size;
    }
  }
  return out;
}

/// The files that are new or bigger than in [before]. A smaller file
/// is a cloud client still writing, not news.
List<String> grownFiles(Map<String, int> before, Map<String, int> after) => [
      for (final MapEntry(key: file, value: size) in after.entries)
        if (size > (before[file] ?? 0)) file,
    ];

/// What a set of files holds that this store does not: how many
/// entries, and who wrote them.
class UnseenChanges {
  final int count;
  final Set<String> authors;

  const UnseenChanges(this.count, this.authors);

  bool get isEmpty => count == 0;
}

/// Reads [files] (as keyed by [foreignFileSizes]) and counts the entries
/// past this store's clock. Every device's file carries all it knows,
/// so the same entry in two files counts once. A file the cloud client
/// is still writing is skipped for this round.
Future<UnseenChanges> unseenChanges(
  CatalogStore store,
  SyncFolder folder,
  Iterable<String> files,
) async {
  final clock = store.versionVector();
  final seen = <(String, int)>{};
  final authors = <String>{};
  for (final file in files) {
    final slash = file.indexOf('/');
    final dir = file.substring(0, slash);
    final name = file.substring(slash + 1);
    try {
      final bytes = await folder.read(dir, name);
      if (bytes == null) continue;
      for (final line in const LineSplitter().convert(utf8.decode(bytes))) {
        if (line.trim().isEmpty) continue;
        final m = (jsonDecode(line) as Map).cast<String, dynamic>();
        final device = m['device'] as String;
        final dseq = m['dseq'] as int;
        if (device == store.deviceId) continue;
        if (dseq <= (clock[device] ?? 0)) continue;
        if (seen.add((device, dseq))) {
          final author = m['author'];
          // The app's own seed entries name nobody.
          if (author is String && author.isNotEmpty && author != seedAuthor) {
            authors.add(author);
          }
        }
      }
    } catch (_) {
      continue;
    }
  }
  return UnseenChanges(seen.length, authors);
}
