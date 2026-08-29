import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/incoming_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The copy the platform made of a shared file is deleted once it was
/// read; a desktop launch argument is not ours to delete.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('a delivered file is imported and then removed',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog-incoming');
    addTearDown(() => dir.deleteSync(recursive: true));
    final source = CatalogStore.inMemory()..author = 'a';
    addTearDown(source.close);
    source.createCat('Miezi');
    final path = writeBundle(source, '${dir.path}/incoming-1.catsync');
    final store = CatalogStore.inMemory()..author = 'b';
    addTearDown(store.close);
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(MaterialApp(
      navigatorKey: navigator,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: SizedBox()),
    ));
    // The import shows its summary sheet and waits; close it, then the
    // file goes.
    late Future<void> done;
    await tester.runAsync(() async {
      done = importIncomingFile(navigator, () => store, path,
          deleteAfter: true);
      await Future<void>.delayed(const Duration(milliseconds: 1500));
    });
    await tester.pumpAndSettle();
    expect(store.cats().map((c) => c.name), contains('Miezi'));
    navigator.currentState!.pop();
    await tester.runAsync(() => done);
    await tester.pumpAndSettle();
    expect(File(path).existsSync(), isFalse);

    // Nothing new in it: no sheet, and a keeper's own file stays.
    final kept = writeBundle(source, '${dir.path}/mine.catsync');
    await tester.runAsync(() => importIncomingFile(
        navigator, () => store, kept, deleteAfter: false));
    await tester.pumpAndSettle();
    expect(File(kept).existsSync(), isTrue);
  });
}
