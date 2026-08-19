import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'entry.dart';
import 'store.dart';

/// Sync-by-messenger (ADR-0002 family): one file carries the sender's
/// full knowledge — entries plus the photos currently in use — through
/// WhatsApp, Signal, mail, anything that moves files. Importing runs
/// the same idempotent engine as every other transport, with the
/// bundle's own vector as causal context for conflict detection.
class BundleResult {
  final int entriesIn;
  final int blobsIn;

  /// The entries actually new to this store — the import summary's input.
  final List<Entry> applied;

  const BundleResult(this.entriesIn, this.blobsIn,
      {this.applied = const []});

  @override
  String toString() => '$entriesIn entries + $blobsIn photos in';
}

/// Writes the bundle zip and returns its path. Private entities and
/// their photos stay out unless [includePrivate] is set.
String writeBundle(CatalogStore store, String path,
    {bool includePrivate = false}) {
  final archive = Archive();
  final jsonl = store
      .entriesSince(const {}, includePrivate: includePrivate)
      .map((e) => jsonEncode(e.toJson()))
      .join('\n');
  final jsonlBytes = utf8.encode(jsonl);
  archive.addFile(ArchiveFile('entries.jsonl', jsonlBytes.length, jsonlBytes));
  final seen = <String>{};
  for (final entity in [...store.cats(), ...store.clowders()]) {
    if (!includePrivate && store.isPrivate(entity.id)) continue;
    for (final hash in store.images(entity.id)) {
      if (!seen.add(hash)) continue;
      final bytes = store.imageBytes(hash);
      if (bytes != null) {
        archive.addFile(ArchiveFile('blobs/$hash.jpg', bytes.length, bytes));
      }
    }
  }
  File(path).writeAsBytesSync(ZipEncoder().encode(archive)!);
  return path;
}

/// Imports a bundle file; unknown entries and missing photos land,
/// everything else is ignored.
BundleResult importBundle(CatalogStore store, String path) =>
    importBundleBytes(store, File(path).readAsBytesSync());

/// Same import from in-memory bytes — QR share payloads never touch
/// disk (#40).
BundleResult importBundleBytes(CatalogStore store, List<int> zipBytes) {
  final archive = ZipDecoder().decodeBytes(zipBytes);
  final entries = <Entry>[];
  final blobs = <String, List<int>>{};
  for (final file in archive.files) {
    if (!file.isFile) continue;
    if (file.name == 'entries.jsonl') {
      for (final line in utf8.decode(file.content as List<int>).split('\n')) {
        if (line.trim().isEmpty) continue;
        entries.add(
            Entry.fromJson((jsonDecode(line) as Map).cast<String, dynamic>()));
      }
    } else if (file.name.startsWith('blobs/') && file.name.endsWith('.jpg')) {
      final hash = file.name.substring('blobs/'.length,
          file.name.length - '.jpg'.length);
      blobs[hash] = file.content as List<int>;
    }
  }
  final writerVector = <String, int>{};
  for (final e in entries) {
    if (e.dseq > (writerVector[e.device] ?? 0)) {
      writerVector[e.device] = e.dseq;
    }
  }
  final applied = store.applyEntries(entries, senderVector: writerVector);
  final imported = applied.length;
  var blobsIn = 0;
  for (final hash in store.missingBlobs()) {
    final bytes = blobs[hash];
    if (bytes != null) {
      store.putBlob(hash, Uint8List.fromList(bytes));
      blobsIn++;
    }
  }
  return BundleResult(imported, blobsIn, applied: applied);
}
