import 'dart:convert';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/notes.dart';
import 'package:catlog/src/sync/sync_watch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

/// The folder watch in the app: the first round only takes the measure,
/// a later round with news puts a waiting note up (poll mode) or merges
/// (auto mode); the note names the writer and syncs on tap.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore anna, ben;
  late MemorySyncFolder folder;
  late NoteQueue notes;

  setUp(() {
    anna = CatalogStore.inMemory()..author = 'Anna';
    ben = CatalogStore.inMemory()..author = 'Ben';
    ben.setLocalSetting('syncFolder', 'memory');
    ben.setLocalSetting(catalogNameKey, 'Farm');
    folder = MemorySyncFolder();
    notes = NoteQueue();
  });

  tearDown(() {
    anna.close();
    ben.close();
    notes.dispose();
  });

  SyncWatcher watcherFor(CatalogStore store) =>
      SyncWatcher(store, folderOf: (_) => folder, notes: notes);

  test('poll mode: measure first, then say what waits, merge on tap', () async {
    final watcher = watcherFor(ben);
    expect(watcher.enabled, isTrue);
    await watcher.check(); // baseline only, nothing waits
    expect(watcher.pending, isFalse);
    expect(notes.visible, isNull);
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isTrue);
    expect(notes.visible?.kind, NoteKind.waiting);
    FolderSyncResult? merged;
    watcher.onMerged = (r, _, _) => merged = r;
    await watcher.merge();
    expect(merged, isNotNull);
    expect(merged!.applied, isNotEmpty);
    expect(watcher.pending, isFalse);
    expect(notes.visible, isNull);
    expect(ben.searchCats('Miezi'), hasLength(1));
    // Nothing new: the next round stays quiet.
    await watcher.check();
    expect(watcher.pending, isFalse);
    // A manual sync takes the note down on the next round.
    anna.createCat('Wanderer');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isTrue);
    await folderSyncIn(ben, folder, catalog: catalogFolderName('Farm'));
    await recordSyncBaselines(ben, folderOf: (_) => folder);
    await watcher.check();
    expect(watcher.pending, isFalse);
    expect(notes.visible, isNull);
    watcher.dispose();
  });

  test('auto mode merges on its own and reports', () async {
    ben.setLocalSetting(syncAutoKey, '1');
    final watcher = watcherFor(ben);
    FolderSyncResult? merged;
    watcher.onMerged = (r, _, _) => merged = r;
    await watcher.check();
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(merged, isNotNull);
    expect(watcher.pending, isFalse);
    expect(ben.searchCats('Miezi'), hasLength(1));
    watcher.dispose();
  });

  test('a swiped-away note stays away until more arrives', () async {
    final watcher = watcherFor(ben);
    await watcher.check();
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isTrue);
    notes.next(); // swipe left
    expect(watcher.pending, isFalse);
    await watcher.check(); // nothing new: stays away
    expect(watcher.pending, isFalse);
    anna.createCat('Wanderer');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check(); // more arrived: back
    expect(watcher.pending, isTrue);
    notes.clearNews(); // swipe right takes it too
    expect(watcher.pending, isFalse);
    watcher.dispose();
  });

  test('a round fetches photo files that landed after the entries', () async {
    final watcher = watcherFor(ben);
    final cat = anna.createCat('Miezi');
    anna.addImage(cat, CatalogStore.compressImage(jpeg(30, 30)));
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    final blobs = folder.dirs['${catalogFolderName('Farm')}/blobs']!;
    final held = Map.of(blobs);
    blobs.clear();
    await folderSyncIn(ben, folder, catalog: catalogFolderName('Farm'));
    await recordSyncBaselines(ben, folderOf: (_) => folder);
    expect(ben.missingBlobs(), hasLength(1));
    await watcher.check();
    expect(ben.missingBlobs(), hasLength(1));
    blobs.addAll(held);
    await watcher.check(); // nothing grew, the photo comes anyway
    expect(ben.missingBlobs(), isEmpty);
    expect(watcher.photosArrived, isTrue);
    expect(watcher.pending, isFalse);
    watcher.dispose();
  });

  test('the switch off keeps the rounds quiet, on brings them back', () async {
    ben.setLocalSetting(syncWatchKey, '0');
    final watcher = watcherFor(ben);
    expect(watcher.enabled, isFalse);
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isFalse);
    ben.setLocalSetting(syncWatchKey, '1');
    resetSyncBaselines(ben);
    await watcher.check();
    expect(watcher.pending, isTrue);
    watcher.dispose();
  });

  test('a change goes to the folder after the gather, or on flush', () async {
    final watcher = watcherFor(ben);
    var published = 0;
    ben.onLocalChange = () {
      published++;
      watcher.changed();
    };
    ben.createCat('Miezi');
    expect(published, greaterThan(0));
    // Nothing yet: the gather is still open.
    expect(folder.dirs[catalogFolderName('Farm')]?.keys ?? const [], isEmpty);
    await watcher.flush();
    final files = folder.dirs[catalogFolderName('Farm')]!.keys;
    expect(files, contains(manifestName(ben.deviceId)));
    expect(files, contains(segmentName(ben.deviceId, 1)));
    // The other side reads it without a manual sync on ben's side.
    anna.setLocalSetting('syncFolder', 'memory');
    anna.setLocalSetting(catalogNameKey, 'Farm');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    expect(anna.searchCats('Miezi'), hasLength(1));
    watcher.dispose();
  });

  testWidgets('the gather closes on its own after five seconds', (
    tester,
  ) async {
    final watcher = watcherFor(ben);
    addTearDown(watcher.dispose);
    ben.onLocalChange = watcher.changed;
    ben.createCat('Miezi');
    await tester.pump(const Duration(seconds: 2));
    ben.createCat('Wanderer'); // company: the gather starts over
    await tester.pump(const Duration(seconds: 4));
    expect(folder.dirs[catalogFolderName('Farm')]?.keys ?? const [], isEmpty);
    await tester.pump(const Duration(seconds: 2));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    final manifest = FolderManifest.parse(
        folder.dirs[catalogFolderName('Farm')]![manifestName(ben.deviceId)])!;
    // Both cats in one write.
    expect(manifest.segments.single.$2, greaterThan(1));
  });

  test('a folder out of reach is named once, after a while', () async {
    var now = DateTime(2026, 3, 1, 9, 0);
    final watcher = SyncWatcher(
      ben,
      folderOf: (_) => _BrokenFolder(),
      notes: notes,
      clock: () => now,
    );
    resetSyncBaselines(ben);
    await watcher.check();
    expect(notes.visible, isNull); // quiet at first
    now = now.add(const Duration(minutes: 3));
    await watcher.check();
    expect(notes.visible, isNull);
    now = now.add(const Duration(minutes: 3));
    await watcher.check();
    expect(notes.visible?.kind, NoteKind.failed);
    now = now.add(const Duration(minutes: 3));
    await watcher.check();
    expect(notes.notes, hasLength(1)); // one note per outage
    watcher.dispose();
  });

  test('a device still writing the old layout is named once', () async {
    final watcher = watcherFor(ben);
    final named = <Set<String>>[];
    watcher.onLagging = named.add;
    final dir = catalogFolderName('Farm');
    await folder.ensure(dir);
    await folder.write(dir, 'old-phone.jsonl', utf8.encode(jsonEncode({
      'device': 'old-phone',
      'dseq': 1,
      'entity': 'cat:old',
      'field': r'$type',
      'value': 'cat',
      'date': '2026-01-01T00:00:00.000000Z',
      'author': 'carla',
      'recorded': '2026-01-01T00:00:00.000000Z',
    })));
    await watcher.merge();
    await watcher.merge();
    expect(named, [
      {'old-phone'}
    ]);
    watcher.dispose();
  });

  testWidgets('the note names the writer and the catalog, tap syncs', (
    tester,
  ) async {
    final watcher = watcherFor(ben);
    addTearDown(watcher.dispose);
    await watcher.check();
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => NoteStrip(
          queue: notes,
          busy: ValueNotifier(const {}),
          child: child!,
        ),
        home: const Scaffold(body: Text('page')),
      ),
    );
    expect(find.textContaining('Anna'), findsNothing);
    await watcher.check();
    await tester.pumpAndSettle();
    expect(
      find.text('Changes from Anna waiting in Farm. Tap to sync.'),
      findsOneWidget,
    );
    // A swipe left waves it away without a sync; the changes stay
    // unmerged.
    await tester.drag(find.textContaining('Anna'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(watcher.pending, isFalse);
    expect(find.textContaining('Anna'), findsNothing);
    expect(ben.searchCats('Miezi'), isEmpty);
    // More arrives: the note is back, and a tap merges.
    anna.createCat('Wanderer');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Anna'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Anna'), findsNothing);
    expect(find.text('page'), findsOneWidget);
    expect(ben.searchCats('Miezi'), hasLength(1));
  });
}

/// A folder that is not there: every call fails as a gone drive does.
class _BrokenFolder implements SyncFolder {
  Never _gone() => throw const FileSystemException('gone');

  @override
  Future<List<String>> list(String dir) async => _gone();
  @override
  Future<Uint8List?> read(String dir, String name) async => _gone();
  @override
  Future<Map<String, int>> sizes(String dir) async => _gone();
  @override
  Future<void> write(String dir, String name, List<int> bytes) async => _gone();
  @override
  Future<void> delete(String dir, String name) async => _gone();
  @override
  Future<void> ensure(String dir) async => _gone();
}
