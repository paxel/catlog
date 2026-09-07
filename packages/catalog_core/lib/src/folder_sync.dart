import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'bundle.dart';
import 'entry.dart';
import 'fields.dart';
import 'signing.dart';
import 'store.dart';

/// Outcome of one folder sync, for the summary line.
class FolderSyncResult {
  final int entriesIn;
  final int entriesOut;
  final int blobsIn;
  final int blobsOut;

  /// The entries actually new to this store — the import summary's input.
  final List<Entry> applied;

  /// Refused rows and the keys met (1.2.0).
  final ImportReport report;

  FolderSyncResult(this.entriesIn, this.entriesOut, this.blobsIn, this.blobsOut,
      {this.applied = const [], ImportReport? report})
      : report = report ?? ImportReport();

  @override
  String toString() => '$entriesIn entries + $blobsIn photos in, '
      '$entriesOut entries + $blobsOut photos out';
}

/// The shared folder as the sync sees it: a `catlog-sync` root with
/// two subfolders, `blobs` and `keys`. Plain files on desktop; on
/// Android the document access the folder picker granted, where
/// nothing is a path. Every call may throw a [FileSystemException]
/// when the folder is gone.
abstract class SyncFolder {
  /// The file names directly in [dir] — `''` for the root, `blobs`,
  /// `keys`. An absent directory lists as empty.
  Future<List<String>> list(String dir);

  /// The file's bytes, or null when it is not there.
  Future<Uint8List?> read(String dir, String name);

  /// Writes [bytes] as [name] in [dir], replacing what was there.
  Future<void> write(String dir, String name, List<int> bytes);

  Future<void> delete(String dir, String name);

  /// Makes sure [dir] exists (`''` makes the root).
  Future<void> ensure(String dir);
}

/// The folder as plain files under `<path>/catlog-sync`.
class LocalSyncFolder implements SyncFolder {
  final String root;

  LocalSyncFolder(String folderPath) : root = '$folderPath/catlog-sync';

  Directory _dir(String dir) => Directory(dir.isEmpty ? root : '$root/$dir');

  @override
  Future<List<String>> list(String dir) async {
    final d = _dir(dir);
    if (!d.existsSync()) return const [];
    return [
      for (final f in d.listSync().whereType<File>()) f.uri.pathSegments.last
    ];
  }

  @override
  Future<Uint8List?> read(String dir, String name) async {
    final f = File('${_dir(dir).path}/$name');
    return f.existsSync() ? f.readAsBytesSync() : null;
  }

  @override
  Future<void> write(String dir, String name, List<int> bytes) async {
    // Atomically, via temp + rename: a cloud client must never upload
    // half a file as the whole.
    final target = File('${_dir(dir).path}/$name');
    final tmp = File('${target.path}.tmp');
    tmp.writeAsBytesSync(bytes);
    tmp.renameSync(target.path);
  }

  @override
  Future<void> delete(String dir, String name) async {
    final f = File('${_dir(dir).path}/$name');
    if (f.existsSync()) f.deleteSync();
  }

  @override
  Future<void> ensure(String dir) async =>
      _dir(dir).createSync(recursive: true);
}

/// A folder in memory: tests, and a picture of what the sync writes.
class MemorySyncFolder implements SyncFolder {
  final Map<String, Map<String, Uint8List>> dirs = {};

  @override
  Future<List<String>> list(String dir) async =>
      dirs[dir]?.keys.toList() ?? const [];

  @override
  Future<Uint8List?> read(String dir, String name) async => dirs[dir]?[name];

  @override
  Future<void> write(String dir, String name, List<int> bytes) async =>
      dirs.putIfAbsent(dir, () => {})[name] = Uint8List.fromList(bytes);

  @override
  Future<void> delete(String dir, String name) async => dirs[dir]?.remove(name);

  @override
  Future<void> ensure(String dir) async => dirs.putIfAbsent(dir, () => {});
}

/// Syncs through a shared folder on any file-sync service (ADR-0002):
/// this device appends to `catlog-sync/<deviceId>.jsonl` and copies photo
/// blobs to `catlog-sync/blobs/`; every other device's file is imported
/// read-only through the same idempotent engine as LAN sync. Each file
/// carries its writer's full knowledge, so any pair of devices sharing
/// the folder converges without meeting.
Future<FolderSyncResult> folderSync(CatalogStore store, String folderPath,
        {bool includePrivate = false}) =>
    folderSyncIn(store, LocalSyncFolder(folderPath),
        includePrivate: includePrivate);

/// The same sync through any [SyncFolder].
Future<FolderSyncResult> folderSyncIn(CatalogStore store, SyncFolder folder,
    {bool includePrivate = false}) async {
  await folder.ensure('');
  await folder.ensure('blobs');
  await folder.ensure('keys');

  // ---- keys first (1.2.0): every device publishes the keys it holds
  // under `keys/<deviceId>.json`; what the others published is learned
  // before their entries are judged. A reader from before looks only
  // at the root and never sees the folder.
  final report = ImportReport();
  final foreignKeys = <KeyRecord>[];
  for (final name in await folder.list('keys')) {
    if (!name.endsWith('.json') || name == '${store.deviceId}.json') continue;
    try {
      final bytes = await folder.read('keys', name);
      if (bytes != null) foreignKeys.addAll(parseKeys(utf8.decode(bytes)));
    } catch (_) {
      // Half-written by the cloud client: next round.
    }
  }
  store.learnKeys(foreignKeys, report: report);
  final ownKeysJson =
      jsonEncode([for (final k in store.keyRecords()) k.toJson()]);
  final ownKeysName = '${store.deviceId}.json';
  final previousKeys = await folder.read('keys', ownKeysName);
  if (previousKeys == null || utf8.decode(previousKeys) != ownKeysJson) {
    await folder.write('keys', ownKeysName, utf8.encode(ownKeysJson));
  }

  // ---- read every foreign device's file (never write them)
  //
  // `.jsonl2` carries the reminder flag (#74); plain `.jsonl` is what
  // pre-1.0.0 devices write — still importable, flag-free by
  // definition. Own output is `.jsonl2` only: a pre-1.0.0 reader skips
  // it (it only reads `.jsonl`), which stops it from silently
  // stripping flags and turning plans into facts. It stops receiving
  // from this device until updated — the legacy own-file is removed
  // below so it at least does not read stale data as current.
  var entriesIn = 0;
  final applied = <Entry>[];
  for (final name in await folder.list('')) {
    if (!name.endsWith('.jsonl') && !name.endsWith('.jsonl2')) continue;
    if (name == '${store.deviceId}.jsonl' ||
        name == '${store.deviceId}.jsonl2') {
      continue;
    }
    final foreign = <Entry>[];
    try {
      final bytes = await folder.read('', name);
      if (bytes == null) continue;
      for (final line in const LineSplitter().convert(utf8.decode(bytes))) {
        if (line.trim().isEmpty) continue;
        foreign.add(
            Entry.fromJson((jsonDecode(line) as Map).cast<String, dynamic>()));
      }
    } catch (_) {
      // A file the cloud client is still writing, or a damaged one: it
      // is skipped for this round, the others still land. Next round
      // finds it whole.
      continue;
    }
    // The writer's knowledge is exactly what its file contains — that
    // vector is the causal context for conflict detection.
    final writerVector = <String, int>{};
    for (final e in foreign) {
      if (e.dseq > (writerVector[e.device] ?? 0)) {
        writerVector[e.device] = e.dseq;
      }
    }
    // Only what this device has not seen. A file in a shared folder
    // still holds everything its writer ever knew, including entries
    // this device has deliberately removed — going back on an import
    // would otherwise be undone by the next folder sync. The delta is
    // what the other transport does; here it has to be taken.
    final mine = store.versionVector();
    final fresh = [
      for (final e in foreign)
        // A value this device only ever received as withheld sits below
        // the watermark for good; without this it could never arrive,
        // however often the writer shares with private included.
        if (e.dseq > (mine[e.device] ?? 0) ||
            store.isWithheld(e.entity, e.field))
          e
    ];
    final imported =
        store.applyEntries(fresh, senderVector: writerVector, report: report);
    applied.addAll(imported);
    entriesIn += imported.length;
  }

  // ---- write own file: full knowledge
  //
  // A payload with no flagged entry is byte-identical to the old
  // format and keeps the `.jsonl` name, so 0.3.x devices in the folder
  // keep receiving until the first reminder is used. The other name
  // must not linger as a stale data source.
  final all = store.entriesSince(const {}, includePrivate: includePrivate);
  final flagged = all.any((e) => e.reminder);
  final ownName = '${store.deviceId}.jsonl${flagged ? '2' : ''}';
  final staleName = '${store.deviceId}.jsonl${flagged ? '' : '2'}';
  final previous = await folder.read('', ownName);
  final previousLines = previous == null
      ? 0
      : const LineSplitter().convert(utf8.decode(previous)).length;
  await folder.write('', ownName,
      utf8.encode(all.map((e) => jsonEncode(e.toJson())).join('\n')));
  await folder.delete('', staleName);
  final entriesOut =
      all.length > previousLines ? all.length - previousLines : 0;

  // ---- blobs: fetch missing, publish local ones, clean dead ones
  var blobsIn = 0, blobsOut = 0;
  final blobNames = (await folder.list('blobs')).toSet();
  for (final hash in store.missingBlobs()) {
    if (!blobNames.contains('$hash.jpg')) continue;
    try {
      final bytes = await folder.read('blobs', '$hash.jpg');
      if (bytes == null) continue;
      store.putBlob(hash, bytes);
      blobsIn++;
    } catch (_) {
      // Truncated by a cloud client mid-upload: not this photo, not
      // this time.
    }
  }
  final live = <String>{};
  for (final entity in [...store.cats(), ...store.clowders()]) {
    for (final hash in store.images(entity.id)) {
      if (!includePrivate &&
          store.isFieldPrivate(entity.id, Keys.image(hash))) {
        continue;
      }
      live.add(hash);
    }
  }
  for (final hash in live) {
    if (blobNames.contains('$hash.jpg')) continue;
    final bytes = store.imageBytes(hash);
    if (bytes != null) {
      await folder.write('blobs', '$hash.jpg', bytes);
      blobsOut++;
    }
  }
  // Remove folder blobs that no non-deleted cat references anymore —
  // deletions propagate through the entry files, the bytes follow.
  for (final name in blobNames) {
    if (!name.endsWith('.jpg')) continue;
    final hash = name.substring(0, name.length - 4);
    if (!live.contains(hash) && _knownDeleted(store, hash)) {
      await folder.delete('blobs', name);
    }
  }

  return FolderSyncResult(entriesIn, entriesOut, blobsIn, blobsOut,
      applied: applied, report: report);
}

/// True when this store has seen a deletion marker for [hash] and no
/// live reference remains — only then is removing the shared bytes safe.
bool _knownDeleted(CatalogStore store, String hash) {
  final history = store.entriesSince(const {}, includePrivate: true);
  var sawMarker = false;
  for (final e in history) {
    if (e.field == Keys.image(hash) && e.value == 'deleted') {
      sawMarker = true;
      break;
    }
  }
  return sawMarker;
}
