import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/widgets/foldable_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Chips set once fold away: a header with the count, the chosen labels
/// in one line, the fold remembered on the device.
void main() {
  setUpAll(useSystemSqlite);

  Widget wrap(
    CatalogStore store,
    Set<String> selected,
    void Function(String) onToggle,
  ) => MaterialApp(
    home: Scaffold(
      body: FoldableChips(
        store: store,
        id: 'test',
        title: 'Columns',
        options: const [
          (key: 'a', label: 'Age'),
          (key: 'b', label: 'Breed'),
          (key: 'c', label: 'Colour'),
        ],
        selected: selected,
        onToggle: onToggle,
      ),
    ),
  );

  testWidgets('starts folded with a choice, open without one', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    await tester.pumpWidget(wrap(store, {'a', 'c'}, (_) {}));
    expect(find.text('2 / 3'), findsOneWidget);
    expect(find.text('Age, Colour'), findsOneWidget);
    expect(find.byType(FilterChip), findsNothing);

    await tester.pumpWidget(wrap(store, {}, (_) {}));
    expect(find.byType(FilterChip), findsNWidgets(3));
  });

  testWidgets('the header toggles, the choice works, the fold is kept', (
    tester,
  ) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    final toggled = <String>[];
    await tester.pumpWidget(wrap(store, {'a'}, toggled.add));
    await tester.tap(find.text('Columns'));
    await tester.pumpAndSettle();
    expect(find.byType(FilterChip), findsNWidgets(3));
    await tester.tap(find.text('Breed'));
    expect(toggled, ['b']);

    // Remembered: a fresh build of the same picker is open.
    await tester.pumpWidget(wrap(store, {'a', 'b'}, toggled.add));
    expect(find.byType(FilterChip), findsNWidgets(3));
    await tester.tap(find.text('Columns'));
    await tester.pumpAndSettle();
    expect(find.byType(FilterChip), findsNothing);
    expect(store.localSetting('chips:test'), 'closed');
  });
}
