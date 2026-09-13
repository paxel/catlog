import 'dart:async';
import 'dart:convert';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';

import '../exclusive.dart';
import 'saf_folder.dart';

/// Watches the shared folder while the app is on screen: every five
/// minutes and on every resume it measures the other devices' files,
/// reads only the ones that grew, and either says that changes wait
/// (poll mode) or merges them on the spot (auto mode). Nothing runs
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

  /// Told after every merge the watcher ran itself (auto mode) or on a
  /// tap of the line; the UI shows the summary or a snackbar.
  /// [fromTap] tells a merge the keeper asked for (the line's tap) from
  /// one the watcher ran itself; the first shows the summary like the
  /// Sync button, the second one line.
  void Function(FolderSyncResult result, Moment? undo, bool fromTap)? onMerged;

  Timer? _timer;
  bool _busy = false;

  /// What waits in the folder (poll mode), null when nothing does.
  UnseenChanges? pending;

  SyncWatcher(this.store, {SyncFolder? Function(CatalogStore)? folderOf})
    : folderOf = folderOf ?? syncFolderOf;

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
    if (pending == null) return;
    pending = null;
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
      if (before == null) {
        // No baseline yet: the first round only takes the measure, so a
        // fresh device is not told about files it is about to import.
        store.setLocalSetting(syncSizesKey, jsonEncode(after));
        return;
      }
      final grown = grownFiles(before, after);
      if (grown.isEmpty) {
        _clear();
        return;
      }
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
        pending = unseen;
        notifyListeners();
      }
    } catch (_) {
      // Unreachable folder, half-written file: next round.
    } finally {
      _busy = false;
    }
  }

  /// Merges what the others wrote, as the Sync button does, and records
  /// the new baseline. Null when the folder failed.
  Future<FolderSyncResult?> merge({bool fromTap = false}) async {
    final folder = folderOf(store);
    if (folder == null || !store.isOpen) return null;
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
      pending = null;
      notifyListeners();
      onMerged?.call(result, point, fromTap);
      return result;
    });
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
