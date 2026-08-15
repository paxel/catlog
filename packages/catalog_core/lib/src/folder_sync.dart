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

  const FolderSyncResult(
      this.entriesIn, this.entriesOut, this.blobsIn, this.blobsOut);

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
FolderSyncResult folderSync(CatalogStore store, String folderPath) {
  final root = Directory('$folderPath/catlog-sync');
  final blobDir = Directory('${root.path}/blobs');
  root.createSync(recursive: true);
  blobDir.createSync(recursive: true);

  // ---- read every foreign device's file (never write them)
  var entriesIn = 0;
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
    entriesIn += store
        .applyEntries(foreign, senderVector: writerVector)
        .length;
  }

  // ---- write own file: full knowledge, atomically via temp + rename
  final own = File('${root.path}/${store.deviceId}.jsonl');
  final previousLines = own.existsSync() ? own.readAsLinesSync().length : 0;
  final all = store.entriesSince(const {});
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
  for (final cat in store.cats()) {
    live.addAll(store.images(cat.id));
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

  return FolderSyncResult(entriesIn, entriesOut, blobsIn, blobsOut);
}

/// True when this store has seen a deletion marker for [hash] and no
/// live reference remains — only then is removing the shared bytes safe.
bool _knownDeleted(CatalogStore store, String hash) {
  final history = store.entriesSince(const {});
  var sawMarker = false;
  for (final e in history) {
    if (e.field == Keys.image(hash) && e.value == 'deleted') {
      sawMarker = true;
      break;
    }
  }
  return sawMarker;
}
