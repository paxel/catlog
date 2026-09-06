import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/celebration.dart';
import 'package:catlog/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The cheer: several clips, never the same twice in a row, and its
/// own switch beside the confetti.
void main() {
  setUpAll(useSystemSqlite);

  test('cheers rotate and never repeat back to back', () {
    final r = Random(1);
    var previous = pickCheer(random: r);
    final seen = <String>{previous};
    for (var i = 0; i < 200; i++) {
      final next = pickCheer(previous: previous, random: r);
      expect(next, isNot(previous));
      expect(cheerAssets, contains(next));
      seen.add(next);
      previous = next;
    }
    expect(seen.length, cheerAssets.length);
  });

  testWidgets('the sound switch sits under celebrations and follows it', (
    tester,
  ) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(store: store),
      ),
    );
    await tester.pumpAndSettle();
    expect(cheerEnabled(store), isTrue);
    final sound = find.widgetWithText(SwitchListTile, 'Cheer sound');
    expect(sound, findsOneWidget);
    await tester.tap(sound);
    await tester.pumpAndSettle();
    expect(cheerEnabled(store), isFalse);
    expect(celebrationsEnabled(store), isTrue);

    // Celebrations off: the sound switch is off and disabled with it.
    await tester.tap(
      find.widgetWithText(SwitchListTile, 'Celebrate adoptions'),
    );
    await tester.pumpAndSettle();
    expect(tester.widget<SwitchListTile>(sound).onChanged, isNull);
  });
}
