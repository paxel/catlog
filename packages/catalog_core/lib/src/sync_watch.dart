import 'dart:convert';

import 'folder_sync.dart';
import 'store.dart';

/// Watching the shared folder for what the others wrote, cheaply. A
/// device with a manifest (ADR-0010) is judged by it: a manifest this
/// store has not caught up with may hold news, and only the unread
/// lines of its segments are counted. A device from before writes one
/// file that only grows, so a file bigger than at the last sync may
/// hold news; only a grown file is read.

/// The whole-history files of foreign devices without a manifest, with
/// their sizes, keyed `<dir>/<name>`, from the same directories
/// [folderSyncIn] reads: the catalog's own subfolder and the root.
Future<Map<String, int>> foreignFileSizes(
  SyncFolder folder,
  String deviceId, {
  String? catalog,
}) async {
  final readDirs = catalog == null ? [''] : [catalog, ''];
  final out = <String, int>{};
  for (final dir in readDirs) {
    final sizes = await folder.sizes(dir);
    final manifests = {
      for (final name in sizes.keys)
        if (name.endsWith('.manifest'))
          name.substring(0, name.length - '.manifest'.length)
    };
    for (final MapEntry(key: name, value: size) in sizes.entries) {
      if (!name.endsWith('.jsonl') && !name.endsWith('.jsonl2')) continue;
      final device = name.substring(0, name.lastIndexOf('.'));
      if (device == deviceId || manifests.contains(device)) continue;
      out['$dir/$name'] = size;
    }
  }
  return out;
}

/// What the foreign manifests say this store has not read: per device,
/// its generation and the lines it announces — the watch compares this
/// between rounds, since a rewritten segment may not grow. Keyed
/// `<dir>/<device>`, valued `<generation>:<lines>`.
Future<Map<String, String>> foreignManifests(
  SyncFolder folder,
  String deviceId, {
  String? catalog,
}) async {
  final readDirs = catalog == null ? [''] : [catalog, ''];
  final out = <String, String>{};
  for (final dir in readDirs) {
    for (final name in await folder.list(dir)) {
      if (!name.endsWith('.manifest')) continue;
      final device = name.substring(0, name.length - '.manifest'.length);
      if (device == deviceId) continue;
      final manifest = FolderManifest.parse(await folder.read(dir, name));
      if (manifest == null) continue;
      out['$dir/$device'] = '${manifest.generation}:${manifest.lines}';
    }
  }
  return out;
}

/// The manifests that differ from [before]: new, moved on, or rewritten.
List<String> changedManifests(
        Map<String, String> before, Map<String, String> after) =>
    [
      for (final MapEntry(key: device, value: state) in after.entries)
        if (before[device] != state) device,
    ];

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

/// Reads [files] (whole-history files as keyed by [foreignFileSizes])
/// and the unread lines of the manifests in [devices] (as keyed by
/// [foreignManifests]), and counts the entries past this store's clock.
/// Every device's files carry all it knows, so the same entry in two
/// places counts once. A file the cloud client is still writing is
/// skipped for this round.
Future<UnseenChanges> unseenChanges(
  CatalogStore store,
  SyncFolder folder,
  Iterable<String> files, {
  Iterable<String> devices = const [],
}) async {
  final clock = store.versionVector();
  final seen = <(String, int)>{};
  final authors = <String>{};
  void count(Iterable<String> lines) {
    for (final line in lines) {
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
  }

  for (final file in files) {
    final slash = file.indexOf('/');
    final dir = file.substring(0, slash);
    final name = file.substring(slash + 1);
    try {
      final bytes = await folder.read(dir, name);
      if (bytes == null) continue;
      count(const LineSplitter().convert(utf8.decode(bytes)));
    } catch (_) {
      continue;
    }
  }
  for (final key in devices) {
    final slash = key.indexOf('/');
    final dir = key.substring(0, slash);
    final device = key.substring(slash + 1);
    try {
      final manifest =
          FolderManifest.parse(await folder.read(dir, manifestName(device)));
      if (manifest == null) continue;
      final lines = await unreadLines(store, folder, dir, device, manifest);
      if (lines != null) count(lines);
    } catch (_) {
      continue;
    }
  }
  return UnseenChanges(seen.length, authors);
}
