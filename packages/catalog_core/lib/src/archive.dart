import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';

import 'fields.dart';
import 'store.dart';

/// Archiving (#53): long-running catalogs accumulate dead weight —
/// deceased cats and clowders nobody lives in any more, and above all
/// their photos, which every synced device carries forever.
///
/// The deal is export-then-delete: the selection is written to an
/// ordinary `.catsync` file the user keeps, then deleted through the
/// normal delete path, which propagates to every synced device.
/// Re-importing the file restores everything.
class ArchiveCandidate {
  final String id;
  final String name;
  final bool isCat;

  /// Newest entry date of the entity — how long it has been quiet.
  final DateTime lastChange;

  /// Bytes its photos occupy.
  final int photoBytes;

  const ArchiveCandidate({
    required this.id,
    required this.name,
    required this.isCat,
    required this.lastChange,
    required this.photoBytes,
  });
}

/// Cats recorded as deceased and clowders without any cat, quiet for
/// at least [inactiveFor]. Private entities are never offered — they
/// are nobody else's business, including this sweep's.
List<ArchiveCandidate> archiveCandidates(CatalogStore store,
    {Duration inactiveFor = const Duration(days: 365 * 2),
    DateTime? now}) {
  final today = now ?? DateTime.now();
  final result = <ArchiveCandidate>[];

  void add(String id, String name, bool isCat) {
    if (store.isPrivate(id)) return;
    final last = _lastChange(store, id);
    if (last == null || today.difference(last) < inactiveFor) return;
    var bytes = 0;
    for (final hash in store.images(id)) {
      bytes += store.imageBytes(hash)?.length ?? 0;
    }
    result.add(ArchiveCandidate(
        id: id,
        name: name,
        isCat: isCat,
        lastChange: last,
        photoBytes: bytes));
  }

  for (final cat in store.cats()) {
    final deceased = store.current(cat.id, Keys.userField('deceased'));
    if (deceased == null || deceased.isEmpty) continue;
    add(cat.id, cat.name, true);
  }
  for (final clowder in store.clowders()) {
    if (store.cats(clowderId: clowder.id).isNotEmpty) continue;
    add(clowder.id, clowder.name, false);
  }
  result.sort((a, b) => a.lastChange.compareTo(b.lastChange));
  return result;
}

DateTime? _lastChange(CatalogStore store, String id) {
  DateTime? last;
  for (final e in store.entriesSince(const {}, includePrivate: true)) {
    if (store.resolveEntity(e.entity) != store.resolveEntity(id)) continue;
    if (last == null || e.date.isAfter(last)) last = e.date;
  }
  return last;
}

/// Writes the archive file: every entry of the chosen entities plus
/// their photos, and the Field definitions, so a re-import renders the
/// cards exactly as they were. Returns the path.
String writeArchive(CatalogStore store, String path,
    {required Set<String> entityIds}) {
  final wanted = {for (final id in entityIds) store.resolveEntity(id)};
  final defs = {for (final def in store.fieldDefs()) def.id};
  final archive = Archive();
  final entries = [
    for (final e in store.entriesSince(const {}, includePrivate: true))
      if (wanted.contains(store.resolveEntity(e.entity)) ||
          defs.contains(e.entity))
        e
  ];
  final jsonl = entries.map((e) => jsonEncode(e.toJson())).join('\n');
  final bytes = utf8.encode(jsonl);
  archive.addFile(ArchiveFile('entries.jsonl', bytes.length, bytes));
  final seen = <String>{};
  for (final id in wanted) {
    for (final hash in store.images(id)) {
      if (!seen.add(hash)) continue;
      final blob = store.imageBytes(hash);
      if (blob != null) {
        archive.addFile(ArchiveFile('blobs/$hash.jpg', blob.length, blob));
      }
    }
  }
  File(path).writeAsBytesSync(ZipEncoder().encode(archive)!);
  return path;
}

/// Deletes what was just archived. Ordinary deletion: it reaches every
/// device you sync with, and the photo bytes go with it. Call only
/// after [writeArchive] succeeded — the file is the only way back.
void deleteArchived(CatalogStore store, Set<String> entityIds,
    {DateTime? date}) {
  for (final id in entityIds) {
    final canonical = store.resolveEntity(id);
    if (store.current(canonical, Keys.type) == Kinds.clowder) {
      store.deleteClowder(canonical, date: date);
    } else {
      store.deleteCat(canonical, date: date);
    }
  }
}
