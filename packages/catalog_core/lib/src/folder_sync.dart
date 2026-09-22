import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'dart:io';
import 'dart:typed_data';

import 'bundle.dart';
import 'entry.dart';
import 'fields.dart';
import 'signing.dart';
import 'store.dart';

/// Outcome of one folder sync, for the summary line.
class FolderSyncResult {
  final int entriesIn;
  final int entriesOut;
  final int blobsIn;
  final int blobsOut;

  /// Photos the entries name that no device has put in the folder yet:
  /// the cloud client still copying, or a device that never synced
  /// since it added them.
  final int blobsMissing;

  /// The entries actually new to this store — the import summary's input.
  final List<Entry> applied;

  /// Devices still writing the whole-history file and no manifest: their
  /// app needs the update before they see this device's segments.
  final Set<String> lagging;

  /// Refused rows and the keys met (1.2.0).
  final ImportReport report;

  FolderSyncResult(this.entriesIn, this.entriesOut, this.blobsIn, this.blobsOut,
      {this.blobsMissing = 0,
      this.applied = const [],
      this.lagging = const {},
      ImportReport? report})
      : report = report ?? ImportReport();
}

/// The shared folder as the sync sees it: a `catlog-sync` root with
/// two subfolders, `blobs` and `keys`. Plain files on desktop; on
/// Android the document access the folder picker granted, where
/// nothing is a path. Every call may throw a [FileSystemException]
/// when the folder is gone.
abstract class SyncFolder {
  /// The file names directly in [dir] — `''` for the root, `blobs`,
  /// `keys`. An absent directory lists as empty.
  Future<List<String>> list(String dir);

  /// The file's bytes, or null when it is not there.
  Future<Uint8List?> read(String dir, String name);

  /// The files directly in [dir] with their sizes in bytes, in one
  /// pass: what the folder watch compares between rounds.
  Future<Map<String, int>> sizes(String dir);

  /// Writes [bytes] as [name] in [dir], replacing what was there.
  Future<void> write(String dir, String name, List<int> bytes);

  Future<void> delete(String dir, String name);

  /// Makes sure [dir] exists (`''` makes the root).
  Future<void> ensure(String dir);
}

/// The folder as plain files under `<path>/catlog-sync`.
class LocalSyncFolder implements SyncFolder {
  final String root;

  LocalSyncFolder(String folderPath) : root = '$folderPath/catlog-sync';

  Directory _dir(String dir) => Directory(dir.isEmpty ? root : '$root/$dir');

  @override
  Future<List<String>> list(String dir) async {
    final d = _dir(dir);
    if (!d.existsSync()) return const [];
    // Sorted: the order a directory is read in is the filesystem's own,
    // and it decides which key a device pins when two files claim it.
    // The Rust core sorts too, so both read one folder the same way.
    return [
      for (final f in d.listSync().whereType<File>()) f.uri.pathSegments.last
    ]..sort();
  }

  @override
  Future<Map<String, int>> sizes(String dir) async {
    final d = _dir(dir);
    if (!d.existsSync()) return const {};
    return {
      for (final f in d.listSync().whereType<File>())
        f.uri.pathSegments.last: f.lengthSync()
    };
  }

  @override
  Future<Uint8List?> read(String dir, String name) async {
    final f = File('${_dir(dir).path}/$name');
    return f.existsSync() ? f.readAsBytesSync() : null;
  }

  @override
  Future<void> write(String dir, String name, List<int> bytes) async {
    // Atomically, via temp + rename: a cloud client must never upload
    // half a file as the whole.
    final target = File('${_dir(dir).path}/$name');
    final tmp = File('${target.path}.tmp');
    tmp.writeAsBytesSync(bytes);
    tmp.renameSync(target.path);
  }

  @override
  Future<void> delete(String dir, String name) async {
    final f = File('${_dir(dir).path}/$name');
    if (f.existsSync()) f.deleteSync();
  }

  @override
  Future<void> ensure(String dir) async =>
      _dir(dir).createSync(recursive: true);
}

/// A folder in memory: tests, and a picture of what the sync writes.
class MemorySyncFolder implements SyncFolder {
  final Map<String, Map<String, Uint8List>> dirs = {};

  @override
  Future<List<String>> list(String dir) async {
    final names = dirs[dir]?.keys.toList() ?? <String>[];
    return names..sort();
  }

  @override
  Future<Map<String, int>> sizes(String dir) async => {
        for (final MapEntry(key: name, value: bytes)
            in (dirs[dir] ?? const {}).entries)
          name: bytes.length
      };

  @override
  Future<Uint8List?> read(String dir, String name) async => dirs[dir]?[name];

  @override
  Future<void> write(String dir, String name, List<int> bytes) async =>
      dirs.putIfAbsent(dir, () => {})[name] = Uint8List.fromList(bytes);

  @override
  Future<void> delete(String dir, String name) async => dirs[dir]?.remove(name);

  @override
  Future<void> ensure(String dir) async => dirs.putIfAbsent(dir, () => {});
}

/// The subfolder a catalog uses inside a shared folder, from its name:
/// `leipzig`, so one folder can carry every catalog and partners find
/// each other by the name they agreed on. A name the file system
/// cannot carry, or an empty one, gets a short fingerprint instead.
String catalogFolderName(String? catalogName) {
  final name = (catalogName ?? '').trim();
  final safe = name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  final faithful = safe == name.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
  if (safe.isEmpty) return 'catalog-${_fingerprint(name)}';
  return faithful ? safe : '$safe-${_fingerprint(name)}';
}

String _fingerprint(String value) {
  var hash = 0x811c9dc5;
  for (final unit in value.runes) {
    hash = (hash ^ unit) & 0xffffffff;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}

/// Syncs through a shared folder on any file-sync service (ADR-0002):
/// this device appends to its segments under `catlog-sync/` and copies
/// photo blobs to `catlog-sync/blobs/`; every other device's files are
/// imported read-only through the same idempotent engine as LAN sync.
/// Each device's segments together carry its writer's full knowledge,
/// so any pair of devices sharing the folder converges without meeting.
/// With [catalog] the files live in `catlog-sync/<catalog>/` instead, so
/// one folder carries several catalogs (1.2.2); the root is still read,
/// for partners from before. The segment layout is ADR-0010.
Future<FolderSyncResult> folderSync(CatalogStore store, String folderPath,
        {bool includePrivate = false, String? catalog}) =>
    folderSyncIn(store, LocalSyncFolder(folderPath),
        includePrivate: includePrivate, catalog: catalog);

/// Android's media scanner shows every picture it finds on shared
/// storage in the phone's gallery, the photo blobs of the shared
/// folder included. An empty `.nomedia` in the folder's root hides it
/// and everything below from the scanner; other systems ignore the
/// file. Written once, on the first sync that finds it missing.
Future<void> hideFromGallery(SyncFolder folder) async {
  await folder.ensure('');
  if (await folder.read('', '.nomedia') == null) {
    await folder.write('', '.nomedia', const []);
  }
}

/// Fetches the photos the entries name and this store lacks, as far as
/// the folder has them. Part of every sync round, and run on its own
/// by the folder watch: a cloud client copies photo files after the
/// entry files, so a round can end with entries in and photos still on
/// the way. Returns how many came in.
Future<int> fetchMissingBlobs(CatalogStore store, SyncFolder folder,
    {String? catalog, Set<String>? blobNames}) async {
  final blobDir = catalog == null ? 'blobs' : '$catalog/blobs';
  final missing = store.missingBlobs();
  if (missing.isEmpty) return 0;
  final names = blobNames ?? (await folder.list(blobDir)).toSet();
  // Partners from before keep their photos at the root.
  final legacyBlobs =
      catalog == null ? const <String>{} : (await folder.list('blobs')).toSet();
  var blobsIn = 0;
  for (final hash in missing) {
    final here = names.contains('$hash.jpg');
    if (!here && !legacyBlobs.contains('$hash.jpg')) continue;
    try {
      final bytes = await folder.read(here ? blobDir : 'blobs', '$hash.jpg');
      if (bytes == null || CatalogStore.imageTooLarge(bytes)) continue;
      // A file that is not the photo it is named after is left alone:
      // the writer's next round may replace it.
      if (sha256.convert(bytes).toString() != hash) continue;
      store.putBlob(hash, bytes);
      if (store.imageBytes(hash) == null) continue;
      blobsIn++;
    } catch (_) {
      // Truncated by a cloud client mid-upload: not this photo, not
      // this time.
    }
  }
  return blobsIn;
}

/// The same sync through any [SyncFolder].
Future<FolderSyncResult> folderSyncIn(CatalogStore store, SyncFolder folder,
    {bool includePrivate = false, String? catalog, DateTime? now}) async {
  // Where this catalog's files go, and where partners' files are looked
  // for: the catalog's own subfolder, plus the root for writers from
  // before subfolders existed.
  String own(String dir) =>
      catalog == null ? dir : (dir.isEmpty ? catalog : '$catalog/$dir');
  final readDirs = catalog == null ? [''] : [catalog, ''];
  await hideFromGallery(folder);
  await folder.ensure(own(''));
  await folder.ensure(own('blobs'));
  await folder.ensure(own('keys'));

  // ---- keys first (1.2.0): every device publishes the keys it holds
  // under `keys/<deviceId>.json`; what the others published is learned
  // before their entries are judged. A reader from before looks only
  // at the root and never sees the folder.
  final report = ImportReport();
  final foreignKeys = <KeyRecord>[];
  for (final base in readDirs) {
    final keyDir = base.isEmpty ? 'keys' : '$base/keys';
    for (final name in await folder.list(keyDir)) {
      if (!name.endsWith('.json') || name == '${store.deviceId}.json') {
        continue;
      }
      try {
        final bytes = await folder.read(keyDir, name);
        if (bytes != null) foreignKeys.addAll(parseKeys(utf8.decode(bytes)));
      } catch (_) {
        // Half-written by the cloud client: next round.
      }
    }
  }
  store.learnKeys(foreignKeys, report: report);
  final ownKeysJson =
      jsonEncode([for (final k in store.keyRecords()) k.toJson()]);
  final ownKeysName = '${store.deviceId}.json';
  final previousKeys = await folder.read(own('keys'), ownKeysName);
  if (previousKeys == null || utf8.decode(previousKeys) != ownKeysJson) {
    await folder.write(own('keys'), ownKeysName, utf8.encode(ownKeysJson));
  }

  // ---- read every foreign device's files (never write them)
  final (applied, lagging) = await _readForeign(store, folder, readDirs,
      report: report, now: now ?? DateTime.now());

  // ---- write own changes: segments and manifest
  final entriesOut = await publishOwn(store, folder,
      includePrivate: includePrivate, catalog: catalog);

  // ---- blobs: fetch missing, publish local ones, clean dead ones
  var blobsOut = 0;
  final blobDir = own('blobs');
  final blobNames = (await folder.list(blobDir)).toSet();
  final blobsIn =
      await fetchMissingBlobs(store, folder, catalog: catalog, blobNames: blobNames);
  final live = <String>{};
  for (final entity in [...store.cats(), ...store.clowders()]) {
    for (final hash in store.images(entity.id)) {
      if (!includePrivate &&
          store.isFieldPrivate(entity.id, Keys.image(hash))) {
        continue;
      }
      live.add(hash);
    }
  }
  for (final hash in live) {
    if (blobNames.contains('$hash.jpg')) continue;
    final bytes = store.imageBytes(hash);
    if (bytes != null) {
      await folder.write(blobDir, '$hash.jpg', bytes);
      blobsOut++;
    }
  }
  // Remove folder blobs that no non-deleted cat references anymore —
  // deletions propagate through the entry files, the bytes follow.
  for (final name in blobNames) {
    if (!name.endsWith('.jpg')) continue;
    final hash = name.substring(0, name.length - 4);
    if (!live.contains(hash) && _knownDeleted(store, hash)) {
      await folder.delete(blobDir, name);
    }
  }

  return FolderSyncResult(applied.length, entriesOut, blobsIn, blobsOut,
      blobsMissing: store.missingBlobs().length,
      applied: applied,
      lagging: lagging,
      report: report);
}

/// A device's history in the folder is a run of segments (ADR-0010):
/// `<device>.<n>.seg`, one entry per line, appended to until one passes
/// [segmentCap] and the next is opened. A full segment never changes
/// again, so a tick travels as one small file, not the whole history.
/// The manifest beside them, `<device>.manifest`, says what the writer
/// knows and which segments exist — the reader's map and the writer's
/// causal context for conflicts.
const segmentCap = 64 * 1024;

/// The manifest's format; a reader refuses a higher one.
const manifestFormat = 1;

String manifestName(String device) => '$device.manifest';
String segmentName(String device, int n) => '$device.$n.seg';

/// What a device says about its segments.
class FolderManifest {
  final int format;

  /// Moves on whenever the segments were rewritten from the start — the
  /// history shrank, the private switch changed; a reader forgets its
  /// line counts and reads afresh.
  final int generation;

  /// The writer's own count of history shrinks, so it knows whether the
  /// segments still match its store.
  final int history;

  /// Whether private values are in the segments.
  final bool private;

  /// The writer's full version vector, removed numbers included.
  final Map<String, int> vector;

  /// Segment names with the line count each held when the manifest
  /// was written, in order.
  final List<(String name, int lines)> segments;

  const FolderManifest({
    this.format = manifestFormat,
    required this.generation,
    this.history = 0,
    required this.private,
    required this.vector,
    required this.segments,
  });

  int get lines => segments.fold(0, (sum, s) => sum + s.$2);

  Map<String, dynamic> toJson() => {
        'format': format,
        'generation': generation,
        'history': history,
        'private': private,
        'vector': vector,
        'segments': [
          for (final (name, lines) in segments) {'name': name, 'lines': lines}
        ],
      };

  static FolderManifest? parse(List<int>? bytes) {
    if (bytes == null) return null;
    try {
      final m = (jsonDecode(utf8.decode(bytes)) as Map).cast<String, dynamic>();
      final format = m['format'] as int;
      if (format > manifestFormat) return null;
      return FolderManifest(
        format: format,
        generation: m['generation'] as int,
        history: (m['history'] as int?) ?? 0,
        private: m['private'] == true,
        vector: (m['vector'] as Map).cast<String, int>(),
        segments: [
          for (final s in (m['segments'] as List).cast<Map>())
            (s['name'] as String, s['lines'] as int)
        ],
      );
    } catch (_) {
      return null;
    }
  }
}

/// The device ids a directory holds files for, from any of the names a
/// device writes: segments, manifest, the whole-history file.
Set<String> _devicesIn(Iterable<String> names) => {
      for (final name in names)
        if (name.endsWith('.manifest'))
          name.substring(0, name.length - '.manifest'.length)
        else if (name.endsWith('.jsonl2'))
          name.substring(0, name.length - '.jsonl2'.length)
        else if (name.endsWith('.jsonl'))
          name.substring(0, name.length - '.jsonl'.length)
        else if (name.endsWith('.seg') && name.indexOf('.') > 0)
          name.substring(0, name.indexOf('.')),
    };

List<Entry> _decodeLines(Iterable<String> lines) => [
      for (final line in lines)
        if (line.trim().isNotEmpty)
          Entry.fromJson((jsonDecode(line) as Map).cast<String, dynamic>())
    ];

List<String> _splitLines(List<int> bytes) =>
    const LineSplitter().convert(utf8.decode(bytes));

/// What this store remembers of a writer's segments: the generation it
/// read and how many lines of each segment it took. Kept per catalog
/// directory in a local setting, never synced.
String _readStateKey(String dir, String device) => 'folderRead:$dir/$device';

({int generation, Map<String, int> lines}) _readState(
    CatalogStore store, String dir, String device) {
  final raw = store.localSetting(_readStateKey(dir, device));
  if (raw != null) {
    try {
      final m = (jsonDecode(raw) as Map).cast<String, dynamic>();
      return (
        generation: m['generation'] as int,
        lines: (m['lines'] as Map).cast<String, int>(),
      );
    } catch (_) {
      // A damaged memory reads as none: the segments are read whole.
    }
  }
  return (generation: -1, lines: const {});
}

void _saveReadState(CatalogStore store, String dir, String device,
        FolderManifest manifest) =>
    store.setLocalSetting(
        _readStateKey(dir, device),
        jsonEncode({
          'generation': manifest.generation,
          'lines': {for (final (name, lines) in manifest.segments) name: lines},
        }));

/// The lines of a writer's segments this store has not read yet, by the
/// manifest and the remembered state — or null when a segment the
/// manifest names is not there yet or shorter than announced: the
/// cloud client is still delivering, the whole device waits a round.
Future<List<String>?> unreadLines(
  CatalogStore store,
  SyncFolder folder,
  String dir,
  String device,
  FolderManifest manifest,
) async {
  var state = _readState(store, dir, device);
  if (state.generation != manifest.generation) {
    state = (generation: manifest.generation, lines: const {});
  }
  final fresh = <String>[];
  for (final (name, announced) in manifest.segments) {
    final have = state.lines[name] ?? 0;
    if (announced <= have) continue;
    final bytes = await folder.read(dir, name);
    if (bytes == null) return null;
    final lines = _splitLines(bytes);
    if (lines.length < announced) return null;
    fresh.addAll(lines.sublist(have, announced));
  }
  return fresh;
}

/// A whole-history file nobody has written to for this long belongs to
/// an install that is gone — a phone set up fresh leaves its old files
/// behind — not to a phone waiting for its update.
const staleAfter = Duration(days: 7);

/// Whether [mine] knows every entry [theirs] announces.
bool _covers(Map<String, int> mine, Map<String, int> theirs) =>
    theirs.entries.every((e) => (mine[e.key] ?? 0) >= e.value);

/// Reads every foreign device's files in [readDirs] and applies what is
/// new. A device with a manifest is read by its segments, from where
/// this store left off; one without is read by its whole-history file
/// as before, and named in the returned set as lagging. A file gone
/// quiet for [staleAfter] whose entries this store all holds is an
/// install that is gone: its files are removed, nobody is named.
Future<(List<Entry> applied, Set<String> lagging)> _readForeign(
  CatalogStore store,
  SyncFolder folder,
  List<String> readDirs, {
  required ImportReport report,
  required DateTime now,
}) async {
  final applied = <Entry>[];
  final lagging = <String>{};
  // A value this device only ever received as withheld sits below the
  // watermark for good; without this it could never arrive, however
  // often the writer shares with private included. The question costs
  // queries, so it is asked once per field, and not at all when nothing
  // here was ever withheld.
  final anyWithheld = store.hasWithheld();
  final withheld = <(String, String), bool>{};
  bool withheldHere(Entry e) =>
      anyWithheld &&
      withheld.putIfAbsent(
          (e.entity, e.field), () => store.isWithheld(e.entity, e.field));

  void apply(List<Entry> foreign, Map<String, int> writerVector) {
    // Only what this device has not seen. A writer's files still hold
    // everything it ever knew, including entries this device has
    // deliberately removed — going back on an import would otherwise be
    // undone by the next folder sync. The delta is what the other
    // transport does; here it has to be taken.
    final mine = store.versionVector();
    final fresh = [
      for (final e in foreign)
        if (e.dseq > (mine[e.device] ?? 0) || withheldHere(e)) e
    ];
    applied.addAll(
        store.applyEntries(fresh, senderVector: writerVector, report: report));
  }

  for (final dir in readDirs) {
    final names = await folder.list(dir);
    final withManifest = <String>{};
    for (final name in names) {
      if (!name.endsWith('.manifest')) continue;
      final device = name.substring(0, name.length - '.manifest'.length);
      if (device == store.deviceId) continue;
      // The name alone says the device writes manifests: one still on
      // its way from the cloud client is no device on the old layout.
      withManifest.add(device);
      final manifest = FolderManifest.parse(await folder.read(dir, name));
      if (manifest == null) continue; // half-written, or a newer format
      final List<String>? lines;
      final List<Entry> foreign;
      try {
        lines = await unreadLines(store, folder, dir, device, manifest);
        if (lines == null) continue; // still on its way: next round
        foreign = _decodeLines(lines);
      } catch (_) {
        continue; // a damaged segment: skipped this round, whole later
      }
      // The manifest's vector is the writer's knowledge — the causal
      // context for conflict detection, whatever a single segment holds.
      apply(foreign, manifest.vector);
      _saveReadState(store, dir, device, manifest);
    }
    // Devices from before the segments (ADR-0010) still write one file
    // with all they know: `.jsonl2` carries the reminder flag (#74),
    // plain `.jsonl` is what pre-1.0.0 devices write. Read whole, as
    // they always were.
    for (final name in names) {
      if (!name.endsWith('.jsonl') && !name.endsWith('.jsonl2')) continue;
      final device = name.substring(0, name.lastIndexOf('.'));
      if (device == store.deviceId || withManifest.contains(device)) continue;
      lagging.add(device);
      final List<Entry> foreign;
      try {
        final bytes = await folder.read(dir, name);
        if (bytes == null) continue;
        foreign = _decodeLines(_splitLines(bytes));
      } catch (_) {
        // A file the cloud client is still writing, or a damaged one:
        // skipped for this round, the others still land.
        continue;
      }
      // The writer's knowledge is exactly what its file contains.
      final writerVector = <String, int>{};
      DateTime? newest;
      for (final e in foreign) {
        if (e.dseq > (writerVector[e.device] ?? 0)) {
          writerVector[e.device] = e.dseq;
        }
        if (newest == null || e.recorded.isAfter(newest)) newest = e.recorded;
      }
      apply(foreign, writerVector);
      final quiet =
          newest == null || now.difference(newest) >= staleAfter;
      if (quiet && _covers(store.versionVector(), writerVector)) {
        // Gone, and everything it knew is here: its files go, and the
        // live devices stop keeping their frozen files for it.
        final keyDir = dir.isEmpty ? 'keys' : '$dir/keys';
        try {
          await folder.delete(dir, name);
          await folder.delete(keyDir, '$device.json');
          lagging.remove(device);
        } catch (_) {
          // The cloud client holds the file this round: next round.
        }
      }
    }
  }
  return (applied, lagging);
}

/// Writes this device's changes to the folder: what is new since the
/// manifest goes to the last segment, or to a fresh one once the last
/// passed [segmentCap]; the manifest follows. The segments are rewritten
/// from the start only when the history shrank (going back, hard delete)
/// or the private switch changed — then the generation moves on. Returns
/// how many entries went out.
///
/// The whole-history file of before stays frozen beside the segments
/// until every other device in the folder has a manifest, so a phone
/// not yet updated keeps what it had; then it goes.
Future<int> publishOwn(CatalogStore store, SyncFolder folder,
    {bool includePrivate = false, String? catalog}) async {
  final dir = catalog ?? '';
  final device = store.deviceId;
  await folder.ensure(dir);
  final names = await folder.list(dir);
  final previous =
      FolderManifest.parse(await folder.read(dir, manifestName(device)));
  final history = store.historyGeneration;

  Future<void> writeManifest(int generation, List<(String, int)> segments) =>
      folder.write(
          dir,
          manifestName(device),
          utf8.encode(jsonEncode(FolderManifest(
            generation: generation,
            history: history,
            private: includePrivate,
            vector: store.versionVector(),
            segments: segments,
          ).toJson())));

  var out = 0;
  if (previous == null ||
      previous.format != manifestFormat ||
      previous.private != includePrivate ||
      previous.history != history) {
    // From the start: every segment of before goes, the history is cut
    // into fresh ones.
    for (final name in names) {
      if (name.startsWith('$device.') && name.endsWith('.seg')) {
        await folder.delete(dir, name);
      }
    }
    final all = store.entriesSince(const {}, includePrivate: includePrivate);
    final segments = <(String, int)>[];
    var n = 0;
    var buffer = <String>[];
    var size = 0;
    Future<void> flush() async {
      if (buffer.isEmpty) return;
      n++;
      final name = segmentName(device, n);
      await folder.write(dir, name, utf8.encode(buffer.join('\n')));
      segments.add((name, buffer.length));
      buffer = [];
      size = 0;
    }

    for (final e in all) {
      final line = jsonEncode(e.toJson());
      buffer.add(line);
      size += line.length + 1;
      if (size >= segmentCap) await flush();
    }
    await flush();
    await writeManifest((previous?.generation ?? 0) + 1, segments);
    out = all.length;
  } else {
    // Only what the manifest does not know yet. Private rows below the
    // vector went out already: the private switch is unchanged.
    final fresh = [
      for (final e in store.entriesSince(previous.vector,
          includePrivate: includePrivate))
        if (e.dseq > (previous.vector[e.device] ?? 0)) e
    ];
    if (fresh.isNotEmpty) {
      final segments = List.of(previous.segments);
      var lines = [for (final e in fresh) jsonEncode(e.toJson())];
      List<int>? tail;
      String? tailName;
      if (segments.isNotEmpty) {
        tailName = segments.last.$1;
        tail = await folder.read(dir, tailName);
        if (tail == null || tail.length >= segmentCap) tail = null;
      }
      if (tail != null) {
        // The segment is read back rather than appended to: the folder
        // knows no append, and a segment is small by design.
        final held = _splitLines(tail);
        await folder.write(
            dir, tailName!, utf8.encode([...held, ...lines].join('\n')));
        segments[segments.length - 1] = (tailName, held.length + lines.length);
      } else {
        final n = segments.length + 1;
        final name = segmentName(device, n);
        await folder.write(dir, name, utf8.encode(lines.join('\n')));
        segments.add((name, lines.length));
      }
      await writeManifest(previous.generation, segments);
      out = fresh.length;
    }
  }

  // The frozen whole-history file: gone once nobody needs it.
  final others = _devicesIn(names)..remove(device);
  final keyDir = dir.isEmpty ? 'keys' : '$dir/keys';
  for (final name in await folder.list(keyDir)) {
    if (name.endsWith('.json')) {
      others.add(name.substring(0, name.length - '.json'.length));
    }
  }
  others.remove(device);
  final manifests = {
    for (final name in names)
      if (name.endsWith('.manifest'))
        name.substring(0, name.length - '.manifest'.length)
  };
  if (others.every(manifests.contains)) {
    await folder.delete(dir, '$device.jsonl');
    await folder.delete(dir, '$device.jsonl2');
  }
  // A catalog that moved into its subfolder leaves no stale root file.
  if (catalog != null) {
    await folder.delete('', '$device.jsonl');
    await folder.delete('', '$device.jsonl2');
  }
  return out;
}

/// True when this store has seen a deletion marker for [hash] and no
/// live reference remains — only then is removing the shared bytes safe.
bool _knownDeleted(CatalogStore store, String hash) {
  final history = store.entriesSince(const {}, includePrivate: true);
  var sawMarker = false;
  for (final e in history) {
    if (e.field == Keys.image(hash) && e.value == 'deleted') {
      sawMarker = true;
      break;
    }
  }
  return sawMarker;
}
