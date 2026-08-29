import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';

import 'entry.dart';
import 'fields.dart';
import 'store.dart';

/// Sync-by-messenger (ADR-0002 family): one file carries the sender's
/// full knowledge — entries plus the photos currently in use — through
/// WhatsApp, Signal, mail, anything that moves files. Importing runs
/// the same idempotent engine as every other transport, with the
/// bundle's own vector as causal context for conflict detection.
/// The bundle format this build writes and the highest it reads.
///
/// Format 2 (1.0.0, #74): entries carry the reminder flag and live in
/// `entries2.jsonl` beside a `format` marker file. Pre-1.0.0 readers
/// only look for `entries.jsonl`, so a v2 bundle imports as zero
/// entries there — a safe no-op instead of silently stripping the
/// flag and turning plans into facts. This reader still accepts the
/// old name for bundles written by pre-1.0.0 devices.
const bundleFormat = 2;

/// A bundle written by a newer app than this one reads.
class UnsupportedBundleFormat implements Exception {
  final int format;
  const UnsupportedBundleFormat(this.format);

  @override
  String toString() =>
      'Bundle format $format is newer than this app reads ($bundleFormat)';
}

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

/// Writes the bundle zip and returns its path. Private values and the
/// photos among them stay out unless [includePrivate] is set; what
/// identifies a cat or a clowder always travels.
String writeBundle(CatalogStore store, String path,
    {bool includePrivate = false}) {
  final entries =
      store.entriesSince(const {}, includePrivate: includePrivate);
  final jsonl = entries.map((e) => jsonEncode(e.toJson())).join('\n');
  final seen = <String>{};
  final hashes = <String>[];
  for (final entity in [...store.cats(), ...store.clowders()]) {
    for (final hash in store.images(entity.id)) {
      // A photo is a value like any other: withheld ones leave their
      // marker behind and their bytes at home.
      if (!includePrivate &&
          store.isFieldPrivate(entity.id, Keys.image(hash))) {
        continue;
      }
      if (seen.add(hash)) hashes.add(hash);
    }
  }
  writeZipStreaming(path, utf8.encode(jsonl),
      flagged: entries.any((e) => e.reminder),
      hashes: hashes,
      bytesOf: store.imageBytes);
  return path;
}

/// Writes a bundle zip one entry at a time: the entries deflated, each
/// photo copied as it is (a JPEG does not shrink), straight to the
/// file. The old way built the whole archive in memory and then a
/// second copy for the zip — two times every photo, on every automatic
/// backup; that is what killed the app on phones with many photos.
void writeZipStreaming(String path, List<int> jsonlBytes,
    {required bool flagged,
    required Iterable<String> hashes,
    required Uint8List? Function(String hash) bytesOf}) {
  // The encoder would create missing folders on its own; a bundle
  // belongs where the caller said and nowhere else, and callers rely on
  // "cannot be written" being an error (going back removes nothing).
  final parent = File(path).parent;
  if (!parent.existsSync()) {
    throw FileSystemException('No such directory', parent.path);
  }
  final encoder = ZipFileEncoder()..create(path);
  try {
    _addFormatAndEntries(encoder, jsonlBytes, flagged: flagged);
    for (final hash in hashes) {
      final bytes = bytesOf(hash);
      if (bytes == null) continue;
      encoder.addArchiveFile(
          ArchiveFile('blobs/$hash.jpg', bytes.length, bytes)
            ..compress = false);
    }
  } finally {
    encoder.closeSync();
  }
}

/// Writes a bundle of exactly [entries] plus the photos they mention.
///
/// Used by going back: the removed entries are written out before they
/// are deleted, so nothing is ever destroyed. The rows keep their
/// original (device, dseq) — this file comes home to the catalog it was
/// written from, where those numbers are what makes the restore exact
/// and a later deliberate re-import of the same material a no-op rather
/// than a doubled history.
String writeEntriesBundle(
    CatalogStore store, String path, List<Entry> entries) {
  final jsonl = entries.map((e) => jsonEncode(e.toJson())).join('\n');
  final seen = <String>{};
  final hashes = <String>[
    for (final e in entries)
      if (e.field.startsWith(Keys.imagePrefix) &&
          seen.add(e.field.substring(Keys.imagePrefix.length)))
        e.field.substring(Keys.imagePrefix.length)
  ];
  writeZipStreaming(path, utf8.encode(jsonl),
      flagged: entries.any((e) => e.reminder),
      hashes: hashes,
      bytesOf: store.imageBytes);
  return path;
}

/// A payload without a single flagged entry is byte-identical to the
/// pre-1.0.0 format, so it ships under the old name and stays
/// importable on 0.3.x. Only actual reminders force the v2 layout.
void _addFormatAndEntries(ZipFileEncoder encoder, List<int> jsonlBytes,
    {required bool flagged}) {
  if (!flagged) {
    encoder.addArchiveFile(
        ArchiveFile('entries.jsonl', jsonlBytes.length, jsonlBytes));
    return;
  }
  final format = utf8.encode('$bundleFormat');
  encoder.addArchiveFile(ArchiveFile('format', format.length, format));
  encoder.addArchiveFile(
      ArchiveFile('entries2.jsonl', jsonlBytes.length, jsonlBytes));
}

/// Imports a bundle file; unknown entries and missing photos land,
/// everything else is ignored.
BundleResult importBundle(CatalogStore store, String path) {
  // Read from the file as needed: a backup with hundreds of photos is
  // never in memory as a whole, let alone with every photo unpacked
  // beside it — that killed the app on restore.
  final input = InputFileStream(path);
  try {
    return _importArchive(store, ZipDecoder().decodeBuffer(input));
  } finally {
    input.close();
  }
}

/// Same import from in-memory bytes — QR share payloads never touch
/// disk (#40).
BundleResult importBundleBytes(CatalogStore store, List<int> zipBytes) =>
    _importArchive(store, ZipDecoder().decodeBytes(zipBytes));

BundleResult _importArchive(CatalogStore store, Archive archive) {
  final entries = <Entry>[];
  final blobFiles = <String, ArchiveFile>{};
  for (final file in archive.files) {
    if (!file.isFile) continue;
    if (file.name == 'format') {
      final declared = int.tryParse(
          utf8.decode(file.content as List<int>).trim());
      if (declared != null && declared > bundleFormat) {
        throw UnsupportedBundleFormat(declared);
      }
    } else if (file.name == 'entries2.jsonl' ||
        file.name == 'entries.jsonl') {
      for (final line in utf8.decode(file.content as List<int>).split('\n')) {
        if (line.trim().isEmpty) continue;
        entries.add(
            Entry.fromJson((jsonDecode(line) as Map).cast<String, dynamic>()));
      }
    } else if (file.name.startsWith('blobs/') && file.name.endsWith('.jpg')) {
      final hash = file.name.substring('blobs/'.length,
          file.name.length - '.jpg'.length);
      blobFiles[hash] = file;
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
  for (final MapEntry(key: hash, value: file) in blobFiles.entries) {
    // Anything the catalog knows of and does not hold — deleted photos
    // included, so an archive can be restored with its pictures. Each
    // photo is unpacked only now, stored, and let go before the next.
    if (!store.knowsImage(hash)) continue;
    if (store.imageBytes(hash) != null) continue;
    store.putBlob(hash, Uint8List.fromList(file.content as List<int>));
    file.clear();
    blobsIn++;
  }
  return BundleResult(imported, blobsIn, applied: applied);
}
