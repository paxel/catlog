import 'dart:async';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/exclusive.dart';
import 'package:catlog/src/stray_cam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// One flow at a time (#91): a second Stray Cam press during a slow
/// fix opens no second camera; a cancelled capture leaves nothing
/// parked; a plugin's "already active" is swallowed, other errors are
/// shown.
void main() {
  setUpAll(useSystemSqlite);

  Future<BuildContext> pump(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (c) {
              context = c;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    return context;
  }

  Uint8List jpeg() =>
      Uint8List.fromList(img.encodeJpg(img.Image(width: 40, height: 40)));

  testWidgets('two presses during a slow fix open one camera', (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final context = await pump(tester);
    final fix = Completer<PositionOutcome>();
    var cameras = 0;
    Future<String?> press() => strayCam(
      context,
      store,
      locate: () => fix.future,
      pickPhoto: (_) async {
        cameras++;
        return jpeg();
      },
    );
    // Everything runs under runAsync: the photo is compressed in a real
    // isolate, which a fake-async zone never hears back from.
    await tester.runAsync(() async {
      final first = press();
      final second = press();
      expect(isBusy('strayCam'), isTrue);
      fix.complete((pos: (48.1, 11.5), failure: null));
      await first;
      await second;
    });
    expect(cameras, 1);
    expect(store.cats(), hasLength(1));
    expect(isBusy('strayCam'), isFalse);
  });

  testWidgets('a cancelled capture parks nothing', (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final context = await pump(tester);
    await tester.runAsync(
      () => strayCam(
        context,
        store,
        locate: () async => (pos: (48.1, 11.5), failure: null),
        pickPhoto: (_) async => null,
      ),
    );
    expect(store.localSetting(strayCamPendingKey), anyOf(isNull, isEmpty));
    expect(store.cats(), isEmpty);
  });

  testWidgets('a plugin error ends the flow with its message, '
      '"already active" silently', (tester) async {
    final context = await pump(tester);
    final result = await runExclusive<int>(
      'x',
      () async => throw PlatformException(code: 'boom', message: 'Boom'),
      context: context,
    );
    await tester.pump();
    expect(result, isNull);
    expect(find.text('Boom'), findsOneWidget);
    expect(isBusy('x'), isFalse);
    await runExclusive<int>(
      'y',
      () async => throw PlatformException(code: 'already_active'),
      context: context,
    );
    await tester.pump();
    expect(find.text('already_active'), findsNothing);
  });
}
