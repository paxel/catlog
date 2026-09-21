import 'package:catlog/src/widgets/add_fan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The plus that fans out: the ways appear with their words, the plus
/// reads minus while open, a pick runs and folds, the veil folds.
void main() {
  Widget page(List<String> picked) => MaterialApp(
        home: Scaffold(
          body: const SizedBox.expand(),
          floatingActionButton: AddFan(
            tooltip: 'Add',
            items: [
              FanItem(
                icon: Icons.add,
                label: 'New stray',
                onTap: () async => picked.add('new'),
              ),
              FanItem(
                icon: Icons.photo_camera,
                label: 'Take photo',
                onTap: () async => picked.add('camera'),
              ),
            ],
          ),
        ),
      );

  testWidgets('a tap fans the ways out and a pick runs one', (tester) async {
    final picked = <String>[];
    await tester.pumpWidget(page(picked));
    expect(find.text('New stray'), findsNothing);
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('New stray'), findsOneWidget);
    expect(find.text('Take photo'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    await tester.tap(find.text('Take photo'));
    await tester.pumpAndSettle();
    expect(picked, ['camera']);
    expect(find.text('New stray'), findsNothing);
    expect(find.byIcon(Icons.remove), findsNothing);
  });

  testWidgets('the minus and the veil fold it back', (tester) async {
    final picked = <String>[];
    await tester.pumpWidget(page(picked));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    expect(find.text('New stray'), findsNothing);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('New stray'), findsOneWidget);
    // A tap on the veil, away from the items.
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();
    expect(find.text('New stray'), findsNothing);
    expect(picked, isEmpty);
  });
}
