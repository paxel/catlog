import 'dart:convert';
import 'dart:io';
import 'dart:math';


import 'bundle.dart';
import 'entry.dart';
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
/// at least [inactiveFor].
List<ArchiveCandidate> archiveCandidates(CatalogStore store,
    {Duration inactiveFor = const Duration(days: 365 * 2),
    DateTime? now}) {
  final today = now ?? DateTime.now();
  final result = <ArchiveCandidate>[];
  // One pass over the log, not one per entity: these catalogs are big
  // by definition — that is why the feature exists.
  final newest = <String, DateTime>{};
  for (final e in store.entriesSince(const {}, includePrivate: true)) {
    final id = store.resolveEntity(e.entity);
    final known = newest[id];
    if (known == null || e.date.isAfter(known)) newest[id] = e.date;
  }

  void add(String id, String name, bool isCat) {
    final last = newest[store.resolveEntity(id)];
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

/// Writes the archive file: every entry of the chosen entities plus
/// their photos, and the Field definitions, so a re-import renders the
/// cards exactly as they were. Returns the path.
String writeArchive(CatalogStore store, String path,
    {required Set<String> entityIds}) {
  final wanted = {for (final id in entityIds) store.resolveEntity(id)};
  final defs = {for (final def in store.fieldDefs()) def.id};
  final entries = [
    for (final e in store.entriesSince(const {}, includePrivate: true))
      if (wanted.contains(store.resolveEntity(e.entity)) ||
          defs.contains(e.entity))
        e
  ];
  // Re-stamped under a fresh device id: a partial file must never carry
  // the original (device, dseq) rows, or the importer's version vector
  // would claim knowledge of everything else that device ever wrote and
  // a later real sync would skip it forever (same rule as flier_share).
  final device = '$archiveDevicePrefix${_randomId()}';
  var dseq = 0;
  final jsonl = entries.map((e) {
    dseq++;
    return jsonEncode(Entry(
      seq: -1,
      device: device,
      dseq: dseq,
      entity: e.entity,
      field: e.field,
      value: e.value,
      date: e.date,
      author: e.author,
      recorded: e.recorded,
    ).toJson());
  }).join('\n');
  final seen = <String>{};
  final hashes = <String>[
    for (final id in wanted)
      for (final hash in store.images(id))
        if (seen.add(hash)) hash
  ];
  // Streamed like every bundle: an archive of a big clowder must not
  // need twice its photos in memory (see writeZipStreaming).
  writeZipStreaming(path, utf8.encode(jsonl),
      flagged: false, hashes: hashes, bytesOf: store.imageBytes);
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

/// Entities that an archive file brought back but that are deleted in
/// this catalog. Deleting is stronger than any old entry, so restoring
/// them is a decision, never automatic.
///
/// Only entries from an archive file count. An ordinary sync also
/// carries entries about cats you deliberately deleted — a partner who
/// has not seen the deletion yet sends them every time — and asking
/// "restore?" on each of those would be nagging about a decision that
/// was already made.
List<String> restorableEntities(CatalogStore store, List<Entry> applied) {
  final ids = <String>{};
  for (final e in applied) {
    if (!e.device.startsWith(archiveDevicePrefix)) continue;
    final id = store.resolveEntity(e.entity);
    if (store.current(id, Keys.deleted) == 'true') ids.add(id);
  }
  return ids.toList();
}

/// Marks the device id of entries written into an archive file, so an
/// import can tell an archive coming home from an ordinary sync.
const archiveDevicePrefix = 'archive-';

final _random = Random.secure();

String _randomId() =>
    List.generate(8, (_) => _random.nextInt(16).toRadixString(16)).join();
