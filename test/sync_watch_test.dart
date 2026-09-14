import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/sync/sync_watch.dart';
import 'package:catlog/src/sync/sync_watch_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

/// The folder watch in the app: the first round only takes the measure,
/// a later round with news raises the line (poll mode) or merges (auto
/// mode); the line names the writer and syncs on tap.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore anna, ben;
  late MemorySyncFolder folder;

  setUp(() {
    anna = CatalogStore.inMemory()..author = 'Anna';
    ben = CatalogStore.inMemory()..author = 'Ben';
    ben.setLocalSetting('syncFolder', 'memory');
    ben.setLocalSetting(catalogNameKey, 'Farm');
    folder = MemorySyncFolder();
  });

  tearDown(() {
    anna.close();
    ben.close();
  });

  SyncWatcher watcherFor(CatalogStore store) =>
      SyncWatcher(store, folderOf: (_) => folder);

  test('poll mode: measure first, then say what waits, merge on tap', () async {
    final watcher = watcherFor(ben);
    expect(watcher.enabled, isTrue);
    await watcher.check(); // baseline only, nothing waits
    expect(watcher.pending, isNull);
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isNotNull);
    expect(watcher.pending!.authors, {'Anna'});
    FolderSyncResult? merged;
    watcher.onMerged = (r, _, _) => merged = r;
    await watcher.merge();
    expect(merged, isNotNull);
    expect(merged!.applied, isNotEmpty);
    expect(watcher.pending, isNull);
    expect(ben.searchCats('Miezi'), hasLength(1));
    // Nothing new: the next round stays quiet.
    await watcher.check();
    expect(watcher.pending, isNull);
    // A manual sync takes the line down on the next round.
    anna.createCat('Wanderer');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isNotNull);
    await folderSyncIn(ben, folder, catalog: catalogFolderName('Farm'));
    await recordSyncSizes(ben, folderOf: (_) => folder);
    await watcher.check();
    expect(watcher.pending, isNull);
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
    expect(watcher.pending, isNull);
    expect(ben.searchCats('Miezi'), hasLength(1));
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
    expect(watcher.pending, isNull);
    watcher.dispose();
  });

  test('the switch off keeps the rounds quiet, on brings them back', () async {
    ben.setLocalSetting(syncWatchKey, '0');
    final watcher = watcherFor(ben);
    expect(watcher.enabled, isFalse);
    anna.createCat('Miezi');
    await folderSyncIn(anna, folder, catalog: catalogFolderName('Farm'));
    await watcher.check();
    expect(watcher.pending, isNull);
    ben.setLocalSetting(syncWatchKey, '1');
    ben.setLocalSetting(syncSizesKey, '{}');
    await watcher.check();
    expect(watcher.pending, isNotNull);
    watcher.dispose();
  });

  testWidgets('the line names the writer and the catalog, tap syncs', (
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
        builder: (context, child) =>
            SyncWatchLine(watcher: watcher, child: child!),
        home: const Scaffold(body: Text('page')),
      ),
    );
    expect(find.textContaining('Anna'), findsNothing);
    await watcher.check();
    await tester.pump();
    expect(
      find.text('Changes from Anna waiting in Farm. Tap to sync.'),
      findsOneWidget,
    );
    await tester.tap(find.textContaining('Anna'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Anna'), findsNothing);
    expect(find.text('page'), findsOneWidget);
    expect(ben.searchCats('Miezi'), hasLength(1));
  });
}
