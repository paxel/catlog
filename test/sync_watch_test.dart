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
    await recordSyncSizes(ben, folderOf: (_) => folder);
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
    await recordSyncSizes(ben, folderOf: (_) => folder);
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
    ben.setLocalSetting(syncSizesKey, '{}');
    await watcher.check();
    expect(watcher.pending, isTrue);
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
