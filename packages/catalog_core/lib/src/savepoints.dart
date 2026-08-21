import 'bundle.dart';
import 'store.dart';

/// Going back to an earlier moment (ADR-0009).
///
/// The log is append-only, so a moment worth returning to is nothing
/// more than the log's high-water mark at that time: the entries after
/// it *are* the change, and removing them *is* the way back. A mark
/// costs one row, which is what makes taking one before every import
/// affordable and therefore unconditional.

/// Why a moment was recorded. The list turns these into sentences.
class SaveCause {
  static const import = 'import';
  static const sync = 'sync';
  static const merge = 'merge';
  static const hardDelete = 'hardDelete';
  static const archive = 'archive';
  static const manual = 'manual';
}

/// A moment the catalog can be returned to.
class SavePoint {
  final int id;
  final int seq;

  /// One of [SaveCause].
  final String cause;

  /// What it was about: the file imported, the person synced with, the
  /// name typed for a moment marked by hand.
  final String? label;
  final DateTime at;

  const SavePoint({
    required this.id,
    required this.seq,
    required this.cause,
    required this.label,
    required this.at,
  });
}

/// Every recorded moment, newest first.
List<SavePoint> savePointsOf(CatalogStore store) => [
      for (final row in store.savePoints())
        SavePoint(
            id: row.id,
            seq: row.seq,
            cause: row.cause,
            label: row.label,
            at: row.at)
    ];

/// What going back would remove, without removing it: the entities
/// touched after the moment, by canonical id.
List<String> changedSince(CatalogStore store, SavePoint point) {
  final ids = <String>{};
  for (final e in store.entriesAfter(point.seq)) {
    ids.add(store.resolveEntity(e.entity));
  }
  return ids.toList();
}

/// Returns the catalog to [point].
///
/// Everything written after it is written to [keepAt] first — photos
/// included — and only then removed, so going back never destroys
/// anything: importing that file puts it all back. Every moment newer
/// than this one goes with it, which is inherent: those moments are up
/// in the part of the log that no longer exists.
///
/// If the file cannot be written, nothing is removed.
String revertTo(CatalogStore store, SavePoint point,
    {required String keepAt}) {
  final removed = store.entriesAfter(point.seq);
  writeEntriesBundle(store, keepAt, removed);
  store.removeEntriesAfter(point.seq);
  return keepAt;
}
