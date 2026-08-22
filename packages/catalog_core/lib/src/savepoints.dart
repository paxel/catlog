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
class MomentCause {
  static const import = 'import';
  static const sync = 'sync';
  static const merge = 'merge';
  static const hardDelete = 'hardDelete';
  static const archive = 'archive';
  static const manual = 'manual';
}

/// A moment the catalog can be returned to.
class Moment {
  final int id;
  final int seq;

  /// One of [MomentCause].
  final String cause;

  /// What it was about: the file imported, the person synced with, the
  /// name typed for a moment marked by hand.
  final String? label;
  final DateTime at;

  const Moment({
    required this.id,
    required this.seq,
    required this.cause,
    required this.label,
    required this.at,
  });
}

/// Every recorded moment, newest first.
List<Moment> momentsOf(CatalogStore store) => [
      for (final row in store.moments())
        Moment(
            id: row.id,
            seq: row.seq,
            cause: row.cause,
            label: row.label,
            at: row.at)
    ];

/// What going back would remove, without removing it: the entities
/// touched after the moment, by canonical id.
List<String> changedSince(CatalogStore store, Moment point) {
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
String revertTo(CatalogStore store, Moment point,
    {required String keepAt}) {
  writeGoBackFile(store, point, keepAt);
  applyGoBack(store, point);
  return keepAt;
}

/// Writes everything [point] would remove — photos included — without
/// removing any of it. Split from [applyGoBack] so a caller can put the
/// file somewhere the keeper can reach before anything is destroyed: a
/// file that never arrived must not cost the entries it was to hold.
String writeGoBackFile(CatalogStore store, Moment point, String path) =>
    writeEntriesBundle(store, path, store.entriesAfter(point.seq));

/// Removes everything after [point]. Only ever after [writeGoBackFile]
/// has succeeded.
void applyGoBack(CatalogStore store, Moment point) =>
    store.removeEntriesAfter(point.seq);

/// Records the moment before a change that has already happened, given
/// the mark taken before it. Nothing applied means no moment: a folder
/// sync that finds nothing new must not fill the list.
Moment? momentFor(CatalogStore store,
    {required int before,
    required bool changed,
    required String cause,
    String? label}) {
  if (!changed) return null;
  final id = store.addMoment(cause: cause, label: label, seq: before);
  return momentsOf(store).firstWhere((m) => m.id == id);
}

/// Imports a bundle and records the moment before it, when something
/// arrived.
({BundleResult result, Moment? moment}) importWithMoment(
    CatalogStore store, String path,
    {String cause = MomentCause.import, String? label}) {
  final before = store.currentSeq();
  final result = importBundle(store, path);
  return (
    result: result,
    moment: momentFor(store,
        before: before,
        changed: result.applied.isNotEmpty,
        cause: cause,
        label: label),
  );
}
