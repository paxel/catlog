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

  testWidgets('the ways line up under the plus in a pane of its own',
      (tester) async {
    // The right-hand pane of the wide layout: its own Navigator, its own
    // Overlay, and a window far wider than it.
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final picked = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              const SizedBox(width: 600, child: ColoredBox(color: Colors.grey)),
              Expanded(
                child: Navigator(
                  onGenerateRoute: (_) => MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                      body: const SizedBox.expand(),
                      floatingActionButton: AddFan(
                        tooltip: 'Add',
                        items: [
                          FanItem(
                            icon: Icons.add,
                            label: 'New stray',
                            onTap: () async => picked.add('new'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final plus = tester.getRect(find.byType(FloatingActionButton));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    final way = tester.getRect(find.text('New stray'));
    expect(
      way.right,
      lessThanOrEqualTo(plus.right + 1),
      reason: 'the ways hang off the plus, not off the window',
    );
    expect(
      way.right,
      greaterThan(plus.left - 300),
      reason: 'and not a pane away from it',
    );
  });

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
