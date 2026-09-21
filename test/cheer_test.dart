import 'dart:io';
import 'dart:async';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/celebration.dart';
import 'package:catlog/src/screens/settings_screen.dart';
import 'package:catlog/src/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The sounds: one shipped clip per moment, a choice per moment on the
/// Settings page with none among them, and the old single switch
/// honoured.
void main() {
  setUpAll(useSystemSqlite);

  test('every moment has its own cat sound, shipped with the app', () {
    final assets = {for (final c in Cheer.values) cheerAsset(c)};
    expect(assets.length, Cheer.values.length, reason: 'no two alike');
    for (final asset in assets) {
      expect(File('assets/$asset').existsSync(), isTrue, reason: asset);
    }
    expect(cheerAsset(Cheer.tick), 'sounds/tick.wav');
    expect(cheerAsset(Cheer.adoption), 'sounds/party.wav');
  });

  test('a moment keeps its choice: none, a preset, an own file', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    expect(soundFor(store, Cheer.tick), isA<PresetSound>());
    expect((soundFor(store, Cheer.tick) as PresetSound).preset, Preset.meow);
    setSound(store, Cheer.tick, const NoSound());
    expect(soundFor(store, Cheer.tick), isA<NoSound>());
    expect(soundFor(store, Cheer.dayDone), isA<PresetSound>());
    setSound(store, Cheer.dayDone, const PresetSound(Preset.party));
    expect(
      (soundFor(store, Cheer.dayDone) as PresetSound).preset,
      Preset.party,
    );
    setSound(store, Cheer.ladder, const OwnSound('/tmp/own.mp3'));
    expect((soundFor(store, Cheer.ladder) as OwnSound).path, '/tmp/own.mp3');
    // A value from a later release the app does not know falls back.
    store.setLocalSetting(soundKey(Cheer.adoption), 'trumpet');
    expect(
      (soundFor(store, Cheer.adoption) as PresetSound).preset,
      Preset.party,
    );
  });

  test('a device that had the cheers off stays silent', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.setLocalSetting('celebrationSound', 'off');
    for (final moment in Cheer.values) {
      expect(soundFor(store, moment), isA<NoSound>(), reason: moment.name);
    }
    // Until a moment gets its own choice.
    setSound(store, Cheer.tick, const PresetSound(Preset.purr));
    expect(soundFor(store, Cheer.tick), isA<PresetSound>());
    expect(soundFor(store, Cheer.ladder), isA<NoSound>());
  });

  testWidgets('every moment has a row on Settings and none is a choice', (
    tester,
  ) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    tester.view.physicalSize = const Size(1000, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(store: store),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Sounds'), findsOneWidget);
    expect(find.text('Chore done'), findsOneWidget);
    expect(find.text('Today: all done'), findsOneWidget);
    expect(find.text('Adoptions'), findsOneWidget);
    // The tick row shows its meow; its dialog offers none, the four
    // shipped sounds and an own file.
    expect(find.text('Meow'), findsOneWidget);
    await tester.tap(find.text('Chore done'));
    await tester.pumpAndSettle();
    expect(find.byType(SoundDialog), findsOneWidget);
    // Purr: once on the day-done row behind, once in the list.
    expect(find.text('Purr'), findsNWidgets(2));
    expect(find.text('Own sound…'), findsOneWidget);
    await tester.tap(find.text('None'));
    await tester.pumpAndSettle();
    expect(soundFor(store, Cheer.tick), isA<NoSound>());
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(SoundDialog), findsNothing);
    // The row says so now; the other moments keep their sounds.
    expect(find.text('None'), findsOneWidget);
    expect(find.text('Purr'), findsOneWidget);
    expect(soundFor(store, Cheer.dayDone), isA<PresetSound>());
  });

  test('firstOrDone never throws: event, empty stream, silence', () async {
    await firstOrDone(Stream<void>.value(null), const Duration(seconds: 1));
    await firstOrDone(const Stream<void>.empty(), const Duration(seconds: 1));
    final sw = Stopwatch()..start();
    await firstOrDone(
      StreamController<void>().stream,
      const Duration(milliseconds: 50),
    );
    expect(sw.elapsedMilliseconds, greaterThanOrEqualTo(40));
  });
}
