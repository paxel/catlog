import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/celebration.dart';
import 'package:catlog/src/event_toasts.dart';
import 'package:catlog/src/screens/about_screen.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/fields_screen.dart';
import 'package:catlog/src/screens/moderation_screen.dart';
import 'package:catlog/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The screens that had no test at all. These check what a keeper can
/// see and do on each, not how it is built.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;
  late String cat, clowder;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-screens');
    Directory('${dir.path}/mine').createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
    clowder = store.createClowder('Hinterhof');
    cat = store.createCat('Miezi');
    store.moveCat(cat, clowder);
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<void> pump(WidgetTester tester, Widget screen,
      {Size size = const Size(400, 900)}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ));
    await tester.pumpAndSettle();
  }

  group('about', () {
    testWidgets('says what the app is', (tester) async {
      await pump(tester, AboutScreen(store: store),
          size: const Size(500, 2000));
      expect(find.textContaining('cat(a)log'), findsWidgets);
      // Catalog matters live with the catalog, not here.
      expect(find.text('Archive'), findsNothing);
      expect(find.text('Authors & bans'), findsNothing);
    });

    testWidgets('the red button thanks you, and says so nowhere else',
        (tester) async {
      await pump(tester, AboutScreen(store: store),
          size: const Size(500, 2000));
      expect(find.textContaining('DANGER'), findsOneWidget);
      await tester.tap(find.textContaining('DANGER'));
      await tester.pumpAndSettle();
      expect(find.textContaining('🤗'), findsOneWidget);
    });

  });

  group('settings', () {
    testWidgets('lists the app settings and keeps a switched setting',
        (tester) async {
      await pump(tester, SettingsScreen(store: store));
      for (final row in [
        'Language',
        'Units',
        'Celebrate adoptions',
        'What to announce',
        "What's new tour",
        'Quick intro',
      ]) {
        expect(find.text(row), findsOneWidget, reason: row);
      }
      expect(celebrationsEnabled(store), isTrue);
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(celebrationsEnabled(store), isFalse);
    });

    testWidgets('tips can be replayed from here', (tester) async {
      store.setLocalSetting('spot2:home', 'home-strays');
      await pump(tester, SettingsScreen(store: store));
      await tester.tap(find.text("What's new tour"));
      await tester.pumpAndSettle();
      expect(store.localSetting('spot2:home'), isNull);
    });
  });

  group('moderation', () {
    testWidgets('deletes one author on one device; a namesake elsewhere stays',
        (tester) async {
      store.author = 'Kathrin';
      store.createCat('Fremdling');
      store.author = 'Patrick';
      // Somebody else wearing the same name on another device.
      final impostor = CatalogStore.inMemory()..author = 'Kathrin';
      addTearDown(impostor.close);
      impostor.createCat('Impostor');
      store.applyEntries(impostor.entriesSince(const {}),
          senderVector: impostor.versionVector());

      await pump(tester, ModerationScreen(store: store));
      expect(find.text('Kathrin'), findsNWidgets(2));
      expect(find.text('Patrick'), findsOneWidget);

      // The row of Kathrin on the impostor's device.
      final prefix = impostor.deviceId.substring(0, 8);
      final row = find.byWidgetPredicate((w) =>
          w is ListTile &&
          (w.title as Text).data == 'Kathrin' &&
          ((w.subtitle as Text).data ?? '').contains(prefix));
      await tester.tap(find.descendant(
          of: row, matching: find.byIcon(Icons.delete_forever_outlined)));
      await tester.pumpAndSettle();
      // Deleting somebody's data asks once, plainly, and names the device.
      expect(find.byType(TextField), findsNothing);
      expect(find.textContaining(impostor.deviceId.substring(0, 8)),
          findsWidgets);
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();

      // Only that device's data went; the real Kathrin's cat is still here.
      expect(store.cats().map((c) => c.name), contains('Fremdling'));
      expect(store.cats().map((c) => c.name), isNot(contains('Impostor')));
      // The ban is on the device, never on the name.
      expect(store.bans(), contains(('device', impostor.deviceId)));
      expect(store.bans().where((b) => b.$1 == 'author'), isEmpty);
      // The bans list names the person behind the device.
      expect(find.textContaining('Kathrin · '), findsOneWidget);
    });

    testWidgets('your own name has no delete button', (tester) async {
      await pump(tester, ModerationScreen(store: store));
      final row = find.ancestor(
          of: find.text('Patrick'), matching: find.byType(ListTile));
      expect(
          find.descendant(of: row, matching: find.byIcon(Icons.delete_forever_outlined)),
          findsNothing);
    });
  });

  group('fields', () {
    testWidgets('shows the starter fields and adds one', (tester) async {
      await pump(tester, FieldsScreen(store: store));
      expect(find.text('Gender'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Ear notch');
      await tester.tap(find.widgetWithText(FilledButton, 'Create'));
      await tester.pumpAndSettle();

      expect(store.fieldDefs().map((d) => d.name), contains('Ear notch'));
    });
  });

  group('clowder', () {
    testWidgets('shows its cats and renames in edit mode', (tester) async {
      await pump(tester, ClowderDetailScreen(store: store, clowderId: clowder));
      expect(find.text('Miezi'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('card', () {
    testWidgets('prints the cat it belongs to', (tester) async {
      await pump(tester, CardScreen(store: store, catId: cat),
          size: const Size(500, 1200));
      expect(find.textContaining('Miezi'), findsWidgets);
    });
  });

  group('toast settings', () {
    testWidgets('every kind can be switched off', (tester) async {
      await pump(tester, ToastSettingsScreen(store: store));
      final switches = find.byType(SwitchListTile);
      expect(switches, findsWidgets);
      await tester.tap(switches.first);
      await tester.pumpAndSettle();
      expect(store.localSettingsByPrefix('toast:'), isNotEmpty);
    });
  });

  group('celebrations', () {
    test('can be switched off and back on', () {
      setCelebrationsEnabled(store, false);
      expect(store.localSetting('celebrations'), isNotNull);
      setCelebrationsEnabled(store, true);
    });
  });
}
