import 'dart:async';
import 'dart:convert';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';

import '../exclusive.dart';
import '../notes.dart';
import 'saf_folder.dart';

/// The folder link while the app is on screen. Every thirty seconds and
/// on every resume it reads the other devices' manifests and measures
/// the files of devices from before, reads only what is new, and either
/// puts a waiting note at the top (poll mode) or merges on the spot
/// (auto mode). A change of this device's own starts a five-second
/// gather; what landed in it goes to the folder in one write, and the
/// app going to the background writes what it has. Nothing runs behind
/// other apps or with the app closed.

/// Local settings, per catalog.
const syncWatchKey = 'syncWatch'; // '0' off; on once a folder is chosen
const syncAutoKey = 'syncAuto'; // '1' merges on its own
const syncPrivateKey = 'syncPrivate'; // '1' lets private values travel
const syncSizesKey = 'syncWatchSizes'; // JSON: legacy file → size at last sync
const syncManifestsKey = 'syncWatchManifests'; // JSON: device → state at last sync

const syncWatchEvery = Duration(seconds: 30);

/// How long a change waits for company before it goes to the folder.
const publishAfter = Duration(seconds: 5);

/// How long the folder may fail quietly before the note says so.
const outageAfter = Duration(minutes: 5);

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

/// Remembers the foreign manifests and the legacy files' sizes as they
/// are now: the baseline the next rounds compare against. Called after
/// every merge.
Future<void> recordSyncBaselines(
  CatalogStore store, {
  SyncFolder Function(CatalogStore)? folderOf,
}) async {
  final folder = (folderOf ?? syncFolderOf)(store);
  if (folder == null || !store.isOpen) return;
  final catalog = catalogDirOf(store);
  final sizes = await foreignFileSizes(folder, store.deviceId, catalog: catalog);
  final manifests =
      await foreignManifests(folder, store.deviceId, catalog: catalog);
  if (!store.isOpen) return;
  store.setLocalSetting(syncSizesKey, jsonEncode(sizes));
  store.setLocalSetting(syncManifestsKey, jsonEncode(manifests));
}

/// Forgets the baselines: a folder just chosen is measured afresh.
void resetSyncBaselines(CatalogStore store) {
  store.setLocalSetting(syncSizesKey, '{}');
  store.setLocalSetting(syncManifestsKey, '{}');
}

class SyncWatcher extends ChangeNotifier {
  final CatalogStore store;

  /// Builds the folder from the store's setting; tests hand in a memory
  /// folder instead.
  final SyncFolder? Function(CatalogStore) folderOf;

  /// Where the notes go; the app's queue unless a test hands in its own.
  final NoteQueue notes;

  /// The wall clock; tests hand in their own.
  final DateTime Function() clock;

  /// Told after every merge, whether the watcher ran it itself (auto
  /// mode) or the keeper tapped the waiting note; the app decides what
  /// to say. [fromTap] tells the two apart.
  void Function(FolderSyncResult result, Moment? undo, bool fromTap)? onMerged;

  /// Told when a merge the keeper tapped failed; the app adds the
  /// failed note. A round that finds the folder out of reach says
  /// nothing at first and tries again.
  void Function(Object error)? onFailed;

  /// Told once per session which devices still write the old layout
  /// and cannot see this device's changes until updated.
  void Function(Set<String> devices)? onLagging;

  Timer? _timer;
  Timer? _gather;
  bool _busy = false;

  /// The waiting note on screen, null when nothing waits.
  Note? _waiting;

  /// Whether changes wait in the folder (poll mode).
  bool get pending => _waiting != null;

  /// Photo files fetched on their own in a round; the pages redraw on
  /// their next build.
  bool photosArrived = false;

  /// The folder as it was when the keeper waved the note away: the
  /// note stays away until a writer moves past this.
  ({Map<String, int> sizes, Map<String, String> manifests})? _dismissedAt;
  ({Map<String, int> sizes, Map<String, String> manifests})? _last;

  /// Since when the folder has failed, null while it answers; the note
  /// is raised once per outage.
  DateTime? _failingSince;
  bool _outageNoted = false;
  Note? _outageNote;

  /// Devices already named as lagging this session.
  final _laggingNamed = <String>{};

  /// The note was swiped away: the changes stay in the folder, and the
  /// note comes back when more arrives.
  void _dismissed() {
    _dismissedAt = _last;
    _waiting = null;
    notifyListeners();
  }

  SyncWatcher(
    this.store, {
    SyncFolder? Function(CatalogStore)? folderOf,
    NoteQueue? notes,
    DateTime Function()? clock,
  }) : folderOf = folderOf ?? syncFolderOf,
       notes = notes ?? NoteQueue.instance,
       clock = clock ?? DateTime.now;

  bool get enabled => store.isOpen && syncWatchOn(store);

  /// Whether this device publishes its changes: a folder is chosen,
  /// whatever the switches say.
  bool get publishes =>
      store.isOpen && store.localSetting('syncFolder') != null;

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

  // ---------------------------------------------------------- publishing

  /// This device wrote something: it goes to the folder in a few
  /// seconds, together with whatever else lands until then.
  void changed() {
    if (!publishes) return;
    _gather?.cancel();
    _gather = Timer(publishAfter, publish);
  }

  /// Writes what the gather holds now — the app is going away.
  Future<void> flush() async {
    if (_gather == null) return;
    _gather?.cancel();
    _gather = null;
    await publish();
  }

  /// Puts this device's changes in the folder. Under the sync key so
  /// the activity line shows it and no merge runs at the same time; a
  /// merge already running takes the changes along, a busy folder
  /// tries again with the next change.
  Future<void> publish() async {
    _gather = null;
    if (!publishes) return;
    final folder = folderOf(store);
    if (folder == null) return;
    try {
      final done = await runExclusive<bool>('folderSync', () async {
        await publishOwn(
          store,
          folder,
          includePrivate: store.localSetting(syncPrivateKey) == '1',
          catalog: catalogDirOf(store),
        );
        return true;
      });
      if (done == true) _answered();
    } catch (_) {
      _failed();
    }
  }

  // --------------------------------------------------------------- rounds

  Map<String, int>? _recordedSizes() {
    final raw = store.localSetting(syncSizesKey);
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as Map).cast<String, int>();
    } catch (_) {
      return null;
    }
  }

  Map<String, String>? _recordedManifests() {
    final raw = store.localSetting(syncManifestsKey);
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as Map).cast<String, String>();
    } catch (_) {
      return null;
    }
  }

  /// One round: read the manifests, measure the legacy files, read what
  /// is new, then say or merge. A folder out of reach is left for the
  /// next round — and named after a while.
  Future<void> check() async {
    if (_busy || !enabled) return;
    final folder = folderOf(store);
    if (folder == null) return;
    _busy = true;
    try {
      final catalog = catalogDirOf(store);
      final sizesBefore = _recordedSizes();
      final manifestsBefore = _recordedManifests();
      final sizes =
          await foreignFileSizes(folder, store.deviceId, catalog: catalog);
      final manifests =
          await foreignManifests(folder, store.deviceId, catalog: catalog);
      if (!store.isOpen) return;
      _answered();
      // Photo files land after the entry files: fetch what is there
      // now, no decision needed, the entries were taken already.
      if (store.missingBlobs().isNotEmpty) {
        final got = await fetchMissingBlobs(store, folder, catalog: catalog);
        if (!store.isOpen) return;
        if (got > 0) photosArrived = true;
      }
      if (sizesBefore == null || manifestsBefore == null) {
        // No baseline yet: the first round only takes the measure, so a
        // fresh device is not told about files it is about to import.
        store.setLocalSetting(syncSizesKey, jsonEncode(sizes));
        store.setLocalSetting(syncManifestsKey, jsonEncode(manifests));
        return;
      }
      _last = (sizes: sizes, manifests: manifests);
      final grown = grownFiles(sizesBefore, sizes);
      final moved = changedManifests(manifestsBefore, manifests);
      if (grown.isEmpty && moved.isEmpty) {
        _clear();
        return;
      }
      // Waved away and nothing new since: keep quiet.
      final dismissed = _dismissedAt;
      if (dismissed != null &&
          grownFiles(dismissed.sizes, sizes).isEmpty &&
          changedManifests(dismissed.manifests, manifests).isEmpty) {
        return;
      }
      _dismissedAt = null;
      final unseen =
          await unseenChanges(store, folder, grown, devices: moved);
      if (!store.isOpen) return;
      if (unseen.isEmpty) {
        // Moved on only by absorbing what this device wrote: move on.
        store.setLocalSetting(syncSizesKey, jsonEncode(sizes));
        store.setLocalSetting(syncManifestsKey, jsonEncode(manifests));
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
      _failed();
    } finally {
      _busy = false;
    }
  }

  /// The folder answered: an outage, if there was one, is over. The
  /// note it raised stays until dismissed, as every failure does.
  void _answered() {
    _failingSince = null;
    _outageNoted = false;
    _outageNote = null;
  }

  /// The folder did not answer. Quiet at first; past [outageAfter] one
  /// failed note, and no second one for the same outage.
  void _failed() {
    final now = clock();
    _failingSince ??= now;
    if (_outageNoted || now.difference(_failingSince!) < outageAfter) return;
    _outageNoted = true;
    final since = _failingSince!;
    _outageNote = Note.failed(
      (t) => t.noteFolderUnreachable(_clockText(since)),
      detail: store.localSetting('syncFolder'),
    );
    notes.add(_outageNote!);
  }

  static String _clockText(DateTime at) =>
      '${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}';

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

  /// Merges what the others wrote, as the Sync button does, publishes
  /// this device's own, and records the new baselines. Null when the
  /// folder failed; a tapped merge that fails is told to [onFailed].
  Future<FolderSyncResult?> merge({bool fromTap = false}) async {
    final folder = folderOf(store);
    if (folder == null || !store.isOpen) return null;
    _clear();
    try {
      final result = await _merge(folder, fromTap);
      if (result != null) _answered();
      return result;
    } catch (e) {
      if (fromTap) onFailed?.call(e);
      _failed();
      return null;
    } finally {
      if (store.isOpen) notifyListeners();
    }
  }

  Future<FolderSyncResult?> _merge(SyncFolder folder, bool fromTap) {
    return runExclusive<FolderSyncResult>('folderSync', () async {
      _gather?.cancel();
      _gather = null;
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
      await recordSyncBaselines(store, folderOf: (s) => folder);
      final lagging = result.lagging.difference(_laggingNamed);
      if (lagging.isNotEmpty) {
        _laggingNamed.addAll(lagging);
        onLagging?.call(lagging);
      }
      onMerged?.call(result, point, fromTap);
      return result;
    });
  }

  @override
  void dispose() {
    stop();
    _gather?.cancel();
    _gather = null;
    _clear();
    super.dispose();
  }
}
