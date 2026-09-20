import 'dart:async';
import 'dart:convert';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';

import '../exclusive.dart';
import '../notes.dart';
import 'saf_folder.dart';

/// Watches the shared folder while the app is on screen: every five
/// minutes and on every resume it measures the other devices' files,
/// reads only the ones that grew, and either puts a waiting note at the
/// top (poll mode) or merges them on the spot (auto mode). Nothing runs
/// behind other apps or with the app closed.

/// Local settings, per catalog.
const syncWatchKey = 'syncWatch'; // '0' off; on once a folder is chosen
const syncAutoKey = 'syncAuto'; // '1' merges on its own
const syncPrivateKey = 'syncPrivate'; // '1' lets private values travel
const syncSizesKey = 'syncWatchSizes'; // JSON: file → size at last sync

const syncWatchEvery = Duration(minutes: 5);

/// The folder this catalog syncs through, or null without one.
SyncFolder? syncFolderOf(CatalogStore store) {
  final path = store.localSetting('syncFolder');
  if (path == null) return null;
  return SafSyncFolder.isTree(path)
      ? SafSyncFolder(path)
      : LocalSyncFolder(path);
}

/// This catalog's subfolder inside the shared folder.
String catalogDirOf(CatalogStore store) =>
    catalogFolderName(store.localSetting(catalogNameKey));

bool syncWatchOn(CatalogStore store) =>
    store.localSetting('syncFolder') != null &&
    store.localSetting(syncWatchKey) != '0';

bool syncAutoOn(CatalogStore store) => store.localSetting(syncAutoKey) == '1';

/// Remembers the foreign files' sizes as they are now: the baseline the
/// next rounds compare against. Called after every merge.
Future<void> recordSyncSizes(
  CatalogStore store, {
  SyncFolder Function(CatalogStore)? folderOf,
}) async {
  final folder = (folderOf ?? syncFolderOf)(store);
  if (folder == null || !store.isOpen) return;
  final sizes = await foreignFileSizes(
    folder,
    store.deviceId,
    catalog: catalogDirOf(store),
  );
  if (store.isOpen) store.setLocalSetting(syncSizesKey, jsonEncode(sizes));
}

class SyncWatcher extends ChangeNotifier {
  final CatalogStore store;

  /// Builds the folder from the store's setting; tests hand in a memory
  /// folder instead.
  final SyncFolder? Function(CatalogStore) folderOf;

  /// Where the waiting note goes; the app's queue unless a test hands
  /// in its own.
  final NoteQueue notes;

  /// Told after every merge, whether the watcher ran it itself (auto
  /// mode) or the keeper tapped the waiting note; the app adds the
  /// finished note. [fromTap] tells the two apart.
  void Function(FolderSyncResult result, Moment? undo, bool fromTap)? onMerged;

  /// Told when a merge the keeper tapped failed; the app adds the
  /// failed note. A round that finds the folder out of reach says
  /// nothing and tries again later.
  void Function(Object error)? onFailed;

  Timer? _timer;
  bool _busy = false;

  /// The waiting note on screen, null when nothing waits.
  Note? _waiting;

  /// Whether changes wait in the folder (poll mode).
  bool get pending => _waiting != null;

  /// Photo files fetched on their own in a round; the pages redraw on
  /// their next build.
  bool photosArrived = false;

  /// The folder as it was when the keeper waved the line away: the
  /// line stays away until a file grows past this.
  Map<String, int>? _dismissedAt;
  Map<String, int>? _lastSizes;

  /// The note was swiped away: the changes stay in the folder, and the
  /// note comes back when more arrives.
  void _dismissed() {
    _dismissedAt = _lastSizes;
    _waiting = null;
    notifyListeners();
  }

  SyncWatcher(
    this.store, {
    SyncFolder? Function(CatalogStore)? folderOf,
    NoteQueue? notes,
  }) : folderOf = folderOf ?? syncFolderOf,
       notes = notes ?? NoteQueue.instance;

  bool get enabled => store.isOpen && syncWatchOn(store);

  /// Arms the rounds; each round checks the switch itself, so a folder
  /// chosen or a switch flipped later takes effect within one tick.
  void start() {
    stop();
    if (!store.isOpen) return;
    _timer = Timer.periodic(syncWatchEvery, (_) => check());
    check();
  }

  /// Nothing waits any more: a manual sync took it, or the folder moved
  /// on without news.
  void _clear() {
    final note = _waiting;
    if (note == null) return;
    _waiting = null;
    notes.remove(note);
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Map<String, int>? _recorded() {
    final raw = store.localSetting(syncSizesKey);
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as Map).cast<String, int>();
    } catch (_) {
      return null;
    }
  }

  /// One round: measure, read what grew, then say or merge. A folder
  /// out of reach is left for the next round.
  Future<void> check() async {
    if (_busy || !enabled) return;
    final folder = folderOf(store);
    if (folder == null) return;
    _busy = true;
    try {
      final before = _recorded();
      final after = await foreignFileSizes(
        folder,
        store.deviceId,
        catalog: catalogDirOf(store),
      );
      if (!store.isOpen) return;
      // Photo files land after the entry files: fetch what is there
      // now, no decision needed, the entries were taken already.
      if (store.missingBlobs().isNotEmpty) {
        final got = await fetchMissingBlobs(
          store,
          folder,
          catalog: catalogDirOf(store),
        );
        if (!store.isOpen) return;
        if (got > 0) photosArrived = true;
      }
      if (before == null) {
        // No baseline yet: the first round only takes the measure, so a
        // fresh device is not told about files it is about to import.
        store.setLocalSetting(syncSizesKey, jsonEncode(after));
        return;
      }
      _lastSizes = after;
      final grown = grownFiles(before, after);
      if (grown.isEmpty) {
        _clear();
        return;
      }
      // Waved away and nothing new since: keep quiet.
      final dismissed = _dismissedAt;
      if (dismissed != null && grownFiles(dismissed, after).isEmpty) return;
      _dismissedAt = null;
      final unseen = await unseenChanges(store, folder, grown);
      if (!store.isOpen) return;
      if (unseen.isEmpty) {
        // Grew only by absorbing what this device wrote: move on.
        store.setLocalSetting(syncSizesKey, jsonEncode(after));
        _clear();
        return;
      }
      if (syncAutoOn(store)) {
        _busy = false;
        await merge();
      } else {
        announce(unseen);
      }
    } catch (_) {
      // Unreachable folder, half-written file: next round.
    } finally {
      _busy = false;
    }
  }

  /// Puts the waiting note up: who wrote, which catalog, tap to merge.
  void announce(UnseenChanges unseen) {
    final note = Note.waiting(
      (t) => t.syncChangesWaiting(
        unseen.authors.isEmpty
            ? t.syncAnotherDevice
            : unseen.authors.join(', '),
        store.localSetting(catalogNameKey) ?? t.appTitle,
      ),
      onTap: () => merge(fromTap: true),
      onGone: _dismissed,
    );
    _waiting = note;
    notes.add(note);
    notifyListeners();
  }

  /// Merges what the others wrote, as the Sync button does, and records
  /// the new baseline. Null when the folder failed; a tapped merge that
  /// fails is told to [onFailed].
  Future<FolderSyncResult?> merge({bool fromTap = false}) async {
    final folder = folderOf(store);
    if (folder == null || !store.isOpen) return null;
    _clear();
    try {
      return await _merge(folder, fromTap);
    } catch (e) {
      if (fromTap) onFailed?.call(e);
      return null;
    } finally {
      if (store.isOpen) notifyListeners();
    }
  }

  Future<FolderSyncResult?> _merge(SyncFolder folder, bool fromTap) {
    return runExclusive<FolderSyncResult>('folderSync', () async {
      final before = store.currentSeq();
      final result = await folderSyncIn(
        store,
        folder,
        includePrivate: store.localSetting(syncPrivateKey) == '1',
        catalog: catalogDirOf(store),
      );
      if (!store.isOpen) return null;
      final point = momentFor(
        store,
        before: before,
        changed: result.applied.isNotEmpty,
        cause: MomentCause.sync,
        label: store.localSetting('syncFolder'),
      );
      await recordSyncSizes(store, folderOf: (s) => folder);
      onMerged?.call(result, point, fromTap);
      return result;
    });
  }

  @override
  void dispose() {
    stop();
    _clear();
    super.dispose();
  }
}
