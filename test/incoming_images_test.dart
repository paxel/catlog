import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/incoming_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// Photos shared into the app land on the chosen cat — the Immich/
/// share-sheet route.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late Directory dir;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    dir = Directory.systemTemp.createTempSync('catlog_shared');
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  var frameSize = 8;
  String frame(String name) {
    // Distinct sizes: identical bytes would dedupe in the content-
    // addressed store.
    final f = File('${dir.path}/$name');
    f.writeAsBytesSync(Uint8List.fromList(
        img.encodeJpg(img.Image(width: frameSize++, height: 8))));
    return f.path;
  }

  testWidgets('shared photos join the chosen cat through compression',
      (tester) async {
    final cat = store.createCat('Sissi');
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(MaterialApp(
      navigatorKey: navigator,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: SizedBox()),
    ));

    await tester.runAsync(() => handleSharedImages(
          navigator,
          store,
          [frame('a.jpg'), frame('b.jpg'), '${dir.path}/missing.jpg'],
          chooseTarget: (_, _) async => cat,
        ));
    await tester.pumpAndSettle();

    // Both readable photos landed; the missing one was skipped quietly.
    expect(store.images(cat), hasLength(2));
    // The cat page opened for review.
    expect(find.text('Sissi'), findsWidgets);
  });

  testWidgets('declining the chooser imports nothing', (tester) async {
    store.createCat('Sissi');
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(MaterialApp(
      navigatorKey: navigator,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: SizedBox()),
    ));
    await tester.runAsync(() => handleSharedImages(
          navigator,
          store,
          [frame('a.jpg')],
          chooseTarget: (_, _) async => null,
        ));
    await tester.pumpAndSettle();
    expect(store.images(store.cats().single.id), isEmpty);
  });
}
