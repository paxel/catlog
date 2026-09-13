import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/cover_picture.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// A place's cover picture: set, replaced, removed; offered on the
/// home's page in edit mode.
void main() {
  setUpAll(useSystemSqlite);

  Uint8List jpeg(int shade) => Uint8List.fromList(
    img.encodeJpg(
      img.Image(width: 64, height: 64)..clear(img.ColorRgb8(shade, shade, 0)),
    ),
  );

  test('set, replace and remove a cover', () async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final home = store.createClowder('Home');
    expect(coverHash(store, home), isNull);
    final first = await setCover(store, home, jpeg(10));
    expect(coverHash(store, home), first);
    final second = await setCover(store, home, jpeg(200));
    expect(coverHash(store, home), second);
    expect(store.images(home), [second]);
    removeCover(store, home);
    expect(coverHash(store, home), isNull);
    // Strays hang theirs on the pseudo entity.
    await setCover(store, straysEntity, jpeg(50));
    expect(coverHash(store, straysEntity), isNotNull);
  });

  testWidgets('the home page offers the cover row in edit mode', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final home = store.createClowder('Home');
    tester.view.physicalSize = const Size(1000, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ClowderDetailScreen(store: store, clowderId: home),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Cover picture…'), findsNothing);
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    expect(find.text('Cover picture…'), findsOneWidget);
  });
}
