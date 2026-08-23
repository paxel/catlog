import 'dart:convert';
import 'dart:io';

import 'entry.dart';
import 'fields.dart';
import 'store.dart';

/// Outcome of one folder sync, for the summary line.
class FolderSyncResult {
  final int entriesIn;
  final int entriesOut;
  final int blobsIn;
  final int blobsOut;

  /// The entries actually new to this store — the import summary's input.
  final List<Entry> applied;

  const FolderSyncResult(
      this.entriesIn, this.entriesOut, this.blobsIn, this.blobsOut,
      {this.applied = const []});

  @override
  String toString() =>
      '$entriesIn entries + $blobsIn photos in, '
      '$entriesOut entries + $blobsOut photos out';
}

/// Syncs through a shared folder on any file-sync service (ADR-0002):
/// this device appends to `catlog-sync/<deviceId>.jsonl` and copies photo
/// blobs to `catlog-sync/blobs/`; every other device's file is imported
/// read-only through the same idempotent engine as LAN sync. Each file
/// carries its writer's full knowledge, so any pair of devices sharing
/// the folder converges without meeting.
FolderSyncResult folderSync(CatalogStore store, String folderPath,
    {bool includePrivate = false}) {
  final root = Directory('$folderPath/catlog-sync');
  final blobDir = Directory('${root.path}/blobs');
  root.createSync(recursive: true);
  blobDir.createSync(recursive: true);

  // ---- read every foreign device's file (never write them)
  var entriesIn = 0;
  final applied = <Entry>[];
  for (final file in root.listSync().whereType<File>()) {
    if (!file.path.endsWith('.jsonl')) continue;
    final name = file.uri.pathSegments.last;
    if (name == '${store.deviceId}.jsonl') continue;
    final foreign = <Entry>[];
    for (final line in file.readAsLinesSync()) {
      if (line.trim().isEmpty) continue;
      foreign.add(
          Entry.fromJson((jsonDecode(line) as Map).cast<String, dynamic>()));
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
        store.applyEntries(fresh, senderVector: writerVector);
    applied.addAll(imported);
    entriesIn += imported.length;
  }

  // ---- write own file: full knowledge, atomically via temp + rename
  final own = File('${root.path}/${store.deviceId}.jsonl');
  final previousLines = own.existsSync() ? own.readAsLinesSync().length : 0;
  final all = store.entriesSince(const {}, includePrivate: includePrivate);
  final tmp = File('${own.path}.tmp');
  tmp.writeAsStringSync(
      all.map((e) => jsonEncode(e.toJson())).join('\n'));
  tmp.renameSync(own.path);
  final entriesOut =
      all.length > previousLines ? all.length - previousLines : 0;

  // ---- blobs: fetch missing, publish local ones, clean dead ones
  var blobsIn = 0, blobsOut = 0;
  for (final hash in store.missingBlobs()) {
    final f = File('${blobDir.path}/$hash.jpg');
    if (f.existsSync()) {
      store.putBlob(hash, f.readAsBytesSync());
      blobsIn++;
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
    final f = File('${blobDir.path}/$hash.jpg');
    if (!f.existsSync()) {
      final bytes = store.imageBytes(hash);
      if (bytes != null) {
        f.writeAsBytesSync(bytes);
        blobsOut++;
      }
    }
  }
  // Remove folder blobs that no non-deleted cat references anymore —
  // deletions propagate through the entry files, the bytes follow.
  for (final f in blobDir.listSync().whereType<File>()) {
    final name = f.uri.pathSegments.last;
    if (!name.endsWith('.jpg')) continue;
    final hash = name.substring(0, name.length - 4);
    if (!live.contains(hash) && _knownDeleted(store, hash)) {
      f.deleteSync();
    }
  }

  return FolderSyncResult(entriesIn, entriesOut, blobsIn, blobsOut,
      applied: applied);
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
