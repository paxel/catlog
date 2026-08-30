import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/in_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catlog/src/sync/tls.dart';
import 'tls_fixture.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Syncing with somebody in the room: the page has to explain both
/// sides before anything is connected.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-inperson');
    Directory('${dir.path}/mine').createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: InPersonScreen(store: store),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('the page opens with something to do on it', (tester) async {
    await pump(tester);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
    final tappable = find.byWidgetPredicate((w) =>
        w is ButtonStyleButton || w is ListTile || w is IconButton);
    expect(tappable, findsWidgets);
  });

  testWidgets('private data is left out unless you say otherwise',
      (tester) async {
    await pump(tester);
    final switches = find.byType(SwitchListTile);
    if (switches.evaluate().isNotEmpty) {
      final tile = tester.widget<SwitchListTile>(switches.first);
      expect(tile.value, isFalse,
          reason: 'Private stays home until the keeper decides otherwise');
    }
  });

  testWidgets('nothing is connected until asked', (tester) async {
    await pump(tester);
    expect(store.moments(), isEmpty);
  });

  testWidgets('tapping Host twice starts one host', (tester) async {
    // A ready identity: generating one takes seconds the test clock
    // does not have.
    final identity = testIdentity();
    store.setLocalSetting(tlsCertKey, identity.certPem);
    store.setLocalSetting(tlsKeyKey, identity.keyPem);
    await pump(tester);
    final host = find.text('Start hosting');
    // Hosting needs a LAN interface; a machine without one shows no
    // button and has nothing to test here.
    if (host.evaluate().isEmpty) return;
    await tester.tap(host);
    await tester.tap(host);
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    // The connectivity plugin is absent under test; nothing else may
    // throw, and a second host must not appear.
    final thrown = tester.takeException();
    expect(thrown, anyOf(isNull, isA<MissingPluginException>()));
    expect(find.byType(QrImageView).evaluate().length, lessThanOrEqualTo(1));
    expect(find.text('Start hosting').evaluate().length +
        find.byType(QrImageView).evaluate().length, 1);
  });
}
