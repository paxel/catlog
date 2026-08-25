import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/spotlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The seen-tracking is per item, so features added later in the same
/// version still get their tour — the 0.2.0 version-mark bug.
void main() {
  final items = spotlightManifest['cat']!;

  test('nothing seen: everything due, manifest order', () {
    expect(dueSpotlights('', items).map((i) => i.id),
        ['cat-edit', 'cat-menu', 'cat-reminder']);
  });

  test('partially seen: only the new item is due', () {
    expect(dueSpotlights('cat-menu', items).map((i) => i.id),
        ['cat-edit', 'cat-reminder']);
  });

  test('all seen: nothing due', () {
    expect(
        dueSpotlights('cat-edit,cat-menu,cat-reminder', items), isEmpty);
  });

  test('every manifest item id has a unique anchor id', () {
    final ids = [
      for (final list in spotlightManifest.values)
        for (final item in list) item.id
    ];
    expect(ids.toSet().length, ids.length);
  });

  group('tip placement', () {
    const phone = Size(360, 800);
    const tablet = Size(1024, 768);

    test('on a phone the tip spans the width, as it always did', () {
      final p = tipPlacement(const Rect.fromLTWH(8, 8, 48, 48), phone);
      expect(p.left, tipMargin);
      expect(p.width, phone.width - 2 * tipMargin);
    });

    test('on a tablet the tip is capped and sits under what it points at',
        () {
      const target = Rect.fromLTWH(600, 8, 48, 48);
      final p = tipPlacement(target, tablet);
      expect(p.width, tipMaxWidth);
      expect(p.left + p.width / 2, closeTo(target.center.dx, 1));
    });

    test('a tip near an edge stays on screen', () {
      for (final target in [
        const Rect.fromLTWH(0, 8, 48, 48),
        const Rect.fromLTWH(970, 8, 48, 48),
      ]) {
        final p = tipPlacement(target, tablet);
        expect(p.left, greaterThanOrEqualTo(tipMargin));
        expect(p.left + p.width,
            lessThanOrEqualTo(tablet.width - tipMargin));
      }
    });

    test('a target in the top half is explained below it, and the other '
        'way round', () {
      final top = tipPlacement(const Rect.fromLTWH(8, 8, 48, 48), phone);
      expect(top.top, isNotNull);
      expect(top.bottom, isNull);
      final bottom =
          tipPlacement(const Rect.fromLTWH(8, 700, 48, 48), phone);
      expect(bottom.top, isNull);
      expect(bottom.bottom, isNotNull);
    });

    test('the tip never covers what it highlights', () {
      const target = Rect.fromLTWH(600, 8, 48, 48);
      final p = tipPlacement(target, tablet);
      expect(p.top, greaterThan(target.bottom));
    });
  });

  testWidgets('a tip carries no arrow and stays beside the highlight on a '
      'tablet', (tester) async {
    tester.view.physicalSize = const Size(1024, 768);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    const target = Rect.fromLTWH(940, 8, 48, 48);

    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SpotlightTip(
          target: target, text: 'Tap here to sync', isLast: true),
    ));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.arrow_upward), findsNothing);
    expect(find.byIcon(Icons.arrow_downward), findsNothing);
    final card = tester.getRect(find.byType(Card).first);
    expect(card.width, lessThanOrEqualTo(tipMaxWidth));
    expect(card.right, lessThanOrEqualTo(1024 - tipMargin));
    expect(card.center.dx, greaterThan(600),
        reason: 'the tip belongs beside the highlight, not at the far edge');
    expect(card.top, greaterThan(target.bottom));
  });
}
