import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/stray_cam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

Uint8List _jpeg() =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: 4, height: 4)));

Future<BuildContext> _pumpHost(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const Scaffold(body: SizedBox()),
  ));
  return tester.element(find.byType(SizedBox));
}

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
  });

  tearDown(() => store.close());

  testWidgets('location denied: no cat, snackbar explains', (tester) async {
    final context = await _pumpHost(tester);
    final result = await strayCam(context, store,
        locate: () async => (pos: null, deniedForever: false),
        pickPhoto: (_) async => fail('camera must not open'));
    await tester.pump();
    expect(result, isNull);
    expect(store.cats(), isEmpty);
    expect(find.text('No location available — long-press the map instead.'),
        findsOneWidget);
  });

  testWidgets('permanently denied: settings dialog, no cat', (tester) async {
    final context = await _pumpHost(tester);
    var opened = false;
    String? result = 'sentinel';
    strayCam(context, store,
            locate: () async => (pos: null, deniedForever: true),
            pickPhoto: (_) async => fail('camera must not open'),
            openSettings: () async {
              opened = true;
              return true;
            })
        .then((r) => result = r);
    await tester.pumpAndSettle();
    expect(find.text('Open settings'), findsOneWidget);
    await tester.tap(find.text('Open settings'));
    await tester.pumpAndSettle();
    expect(opened, isTrue);
    expect(result, isNull);
    expect(store.cats(), isEmpty);
  });

  testWidgets('camera canceled or killed: no orphan cat', (tester) async {
    final context = await _pumpHost(tester);
    final result = await strayCam(context, store,
        locate: () async => (pos: (48.1, 11.5), deniedForever: false),
        pickPhoto: (_) async => null);
    expect(result, isNull);
    expect(store.cats(), isEmpty,
        reason: 'the cat must only exist once a photo arrived');
    expect(store.localSetting(strayCamPendingKey), isEmpty);
  });

  testWidgets('photo taken: cat with position and image', (tester) async {
    final context = await _pumpHost(tester);
    final result = await tester.runAsync(() => strayCam(context, store,
        locate: () async => (pos: (48.1, 11.5), deniedForever: false),
        pickPhoto: (_) async => _jpeg()));
    expect(result, isNotNull);
    final cat = store.cats().single;
    expect(store.positionOf(cat.id), (48.1, 11.5));
    expect(store.images(cat.id), isNotEmpty);
  });

  testWidgets('killed capture is completed from lost data on next start',
      (tester) async {
    store.setLocalSetting(strayCamPendingKey,
        '{"lat": 48.1, "lon": 11.5, "name": "Stray 2026-08-17"}');
    await tester.runAsync(() => recoverStrayCam(store,
        retrieve: () async =>
            LostDataResponse(file: XFile.fromData(_jpeg()))));
    final cat = store.cats().single;
    expect(cat.name, 'Stray 2026-08-17');
    expect(store.positionOf(cat.id), (48.1, 11.5));
    expect(store.images(cat.id), isNotEmpty);
    expect(store.localSetting(strayCamPendingKey), isEmpty);
  });

  testWidgets('failed retrieval keeps the parked capture for next start',
      (tester) async {
    store.setLocalSetting(strayCamPendingKey,
        '{"lat": 48.1, "lon": 11.5, "name": "Stray X"}');
    await tester.runAsync(() => recoverStrayCam(store,
        retrieve: () async => throw Exception('no channel')));
    expect(store.cats(), isEmpty);
    expect(store.localSetting(strayCamPendingKey), isNotEmpty,
        reason: 'a failed retrieval must not discard the capture');
  });

  testWidgets('no lost data: pending marker just clears', (tester) async {
    store.setLocalSetting(strayCamPendingKey,
        '{"lat": 48.1, "lon": 11.5, "name": "Stray X"}');
    await tester.runAsync(() => recoverStrayCam(store,
        retrieve: () async => LostDataResponse()));
    expect(store.cats(), isEmpty);
    expect(store.localSetting(strayCamPendingKey), isEmpty);
  });
}
