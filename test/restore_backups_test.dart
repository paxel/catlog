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

  test('files group by catalog, newest first, go-back files left out', () {
    touch('catlog-berlin.catsync', DateTime(2026, 9, 1));
    touch('catlog-berlin.catsync.zip', DateTime(2026, 9, 3));
    touch('catlog-paris.catsync', DateTime(2026, 9, 2));
    touch('catlog-undone-2026-09-05-10-00-00.catsync', DateTime(2026, 9, 6));
    final sets = backupsIn(folder);
    expect(sets.map((s) => s.name), ['Paris', 'Berlin']);
    expect(sets.last.files, hasLength(1));
    expect(backupsIn(Directory('${root.path}/nowhere')), isEmpty);
  });

  test('a catalog comes back from all its files, photo from the older one', () {
    // The install before: a catalog with a cat and a photo...
    final old = CatalogStore.inMemory()..author = 'anna';
    final cat = old.createCat('Miezi');
    final hash = old.addImage(
      cat,
      CatalogStore.compressImage(
        Uint8List.fromList(img.encodeJpg(img.Image(width: 40, height: 40))),
      ),
    );
    final older = '${folder.path}/catlog-hinterhof.catsync.1';
    writeBundle(old, older, includePrivate: true);
    File(older).setLastModifiedSync(DateTime(2026, 9, 1));
    // ...and a later backup written after the photo bytes were gone.
    old.append(cat, 'f:color', 'grey');
    old.deleteImage(cat, hash);
    old.append(cat, Keys.image(hash), 'added');
    final newer = '${folder.path}/catlog-hinterhof.catsync';
    writeBundle(old, newer, includePrivate: true);
    File(newer).setLastModifiedSync(DateTime(2026, 9, 5));
    File(older).renameSync('${folder.path}/catlog-hinterhof-old.catsync');
    File('${folder.path}/catlog-hinterhof-old.catsync')
        .setLastModifiedSync(DateTime(2026, 9, 1));
    old.close();

    final sets = backupsIn(folder);
    expect(
      sets.map((s) => s.name),
      containsAll(['Hinterhof', 'Hinterhof Old']),
    );
    final made = restoreBackupSet(
      catalogs,
      sets.firstWhere((s) => s.name == 'Hinterhof'),
    );
    expect(made.name, 'Hinterhof');
    final store = catalogs.openStore(made);
    expect(store.cats().map((c) => c.name), ['Miezi']);
    expect(store.current(cat, 'f:color'), 'grey');
    store.close();
  });

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
}
