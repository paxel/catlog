import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/restore_backups.dart';
import 'package:catlog/src/screens/restore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// After a reinstall the backups of the install before come back as
/// catalogs: grouped by name, every file imported newest first.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late Directory folder;
  late CatalogManager catalogs;

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-restore');
    folder = Directory('${root.path}/media/backups')
      ..createSync(recursive: true);
    catalogs = CatalogManager.open('${root.path}/app', defaultName: 'Berlin');
  });

  tearDown(() {
    catalogs.close();
    root.deleteSync(recursive: true);
  });

  File touch(String name, DateTime at) {
    final f = File('${folder.path}/$name')..writeAsStringSync('x');
    f.setLastModifiedSync(at);
    return f;
  }

  test('MediaStore copies of a reinstall share the stem', () {
    expect(backupStem('catlog-berlin (1).catsync'), 'berlin');
    expect(backupStem('catlog-berlin (2).catsync.zip'), 'berlin');
    expect(backupStem('catlog-berlin.catsync'), 'berlin');
  });

  test('file names read as catalog names', () {
    expect(catalogNameFromFile('catlog-berlin-nord.catsync'), 'Berlin Nord');
    expect(catalogNameFromFile('catlog-cats-1a2b3c4d.catsync'), 'Cats');
    expect(catalogNameFromFile('catlog-backup.catsync'), 'Backup');
    expect(
      isRestorableBackup('catlog-undone-2026-09-05-10-00-00.catsync'),
      isFalse,
    );
    expect(isRestorableBackup('notes.txt'), isFalse);
  });

  test('files group by stem, newest first, go-back files left out', () {
    touch('catlog-berlin.catsync', DateTime(2026, 9, 1));
    // MediaStore renamed earlier releases' files: still Berlin's.
    touch('catlog-berlin.catsync.zip', DateTime(2026, 9, 3));
    touch('catlog-paris.catsync', DateTime(2026, 9, 2));
    // "Cats" and "Cats!" share a label, never a catalog.
    touch('catlog-cats.catsync', DateTime(2026, 8, 1));
    touch('catlog-cats-1a2b3c4d.catsync', DateTime(2026, 8, 2));
    touch('catlog-undone-2026-09-05-10-00-00.catsync', DateTime(2026, 9, 6));
    final sets = backupsIn(folder);
    expect(sets.map((s) => s.name), ['Berlin', 'Paris', 'Cats', 'Cats']);
    expect(sets.first.files.map((f) => f.uri.pathSegments.last), [
      'catlog-berlin.catsync.zip',
      'catlog-berlin.catsync',
    ]);
    expect(backupsIn(Directory('${root.path}/nowhere')), isEmpty);
  });

  test(
    'a catalog comes back from all its files; the older one fills a photo',
    () {
      // The install before: a catalog with a cat and a photo...
      final old = CatalogStore.inMemory()..author = 'anna';
      final cat = old.createCat('Miezi');
      final hash = old.addImage(
        cat,
        CatalogStore.compressImage(
          Uint8List.fromList(img.encodeJpg(img.Image(width: 40, height: 40))),
        ),
      );
      final older = '${folder.path}/catlog-hinterhof.catsync.zip';
      writeBundle(old, older, includePrivate: true);
      File(older).setLastModifiedSync(DateTime(2026, 9, 1));
      // ...and a later backup written after the bytes were lost: the entry
      // still says "added", the bundle has no bytes to carry.
      old.append(cat, 'f:color', 'grey');
      old.deleteImage(cat, hash);
      old.append(cat, Keys.image(hash), 'added');
      final newer = '${folder.path}/catlog-hinterhof.catsync';
      writeBundle(old, newer, includePrivate: true);
      File(newer).setLastModifiedSync(DateTime(2026, 9, 5));
      old.close();

      final set = backupsIn(folder).single;
      expect(set.files, hasLength(2));
      final made = restoreBackupSet(catalogs, set);
      expect(made.name, 'Hinterhof');
      final store = catalogs.openStore(made);
      expect(store.cats().map((c) => c.name), ['Miezi']);
      expect(store.current(cat, 'f:color'), 'grey');
      expect(
        store.imageBytes(hash),
        isNotNull,
        reason: 'the older file carried the bytes',
      );
      store.close();
    },
  );

  test('a taken name gets a number', () {
    touch('catlog-berlin.catsync', DateTime(2026, 9, 1));
    final made = restoreBackupSet(catalogs, backupsIn(folder).single);
    expect(made.name, 'Berlin (2)');
  });

  testWidgets('the screen lists, restores what is ticked, and reports', (
    tester,
  ) async {
    final old = CatalogStore.inMemory()..author = 'anna';
    old.createCat('Miezi');
    writeBundle(
      old,
      '${folder.path}/catlog-paris.catsync',
      includePrivate: true,
    );
    old.createClowder('Rue');
    writeBundle(
      old,
      '${folder.path}/catlog-lyon.catsync',
      includePrivate: true,
    );
    old.close();

    CatalogInfo? first;
    var done = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RestoreScreen(
          catalogs: catalogs,
          folder: () async => folder,
          onDone: (f) {
            first = f;
            done++;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Paris'), findsOneWidget);
    expect(find.text('Lyon'), findsOneWidget);
    expect(find.textContaining('1 file'), findsNWidgets(2));

    // Lyon stays out.
    await tester.tap(find.text('Lyon'));
    await tester.pump();
    await tester.tap(find.text('Restore'));
    await tester.pumpAndSettle();

    expect(done, 1);
    expect(first!.name, 'Paris');
    expect(catalogs.catalogs().map((c) => c.name), ['Berlin', 'Paris']);
    expect(find.text('1 catalog restored.'), findsOneWidget);
  });

  testWidgets('an empty folder on a fresh start is done at once', (
    tester,
  ) async {
    var done = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RestoreScreen(
          catalogs: catalogs,
          folder: () async => Directory('${root.path}/empty'),
          onDone: (_) => done++,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(done, 1);
  });

  testWidgets('with a folder picker the empty page stays and lists the pick', (
    tester,
  ) async {
    final old = CatalogStore.inMemory()..author = 'anna';
    old.createCat('Miezi');
    writeBundle(
      old,
      '${folder.path}/catlog-paris (1).catsync',
      includePrivate: true,
    );
    old.close();
    var done = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RestoreScreen(
          catalogs: catalogs,
          folder: () async => null,
          pickFolder: () async => folder.listSync().whereType<File>().toList(),
          onDone: (_) => done++,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(done, 0);
    expect(find.textContaining('Documents/catlog'), findsOneWidget);
    await tester.tap(find.text('Choose backup folder…'));
    await tester.pumpAndSettle();
    expect(find.text('Paris'), findsOneWidget);
    await tester.tap(find.text('Restore'));
    await tester.pumpAndSettle();
    expect(catalogs.catalogs().map((c) => c.name), ['Berlin', 'Paris']);
  });
}
