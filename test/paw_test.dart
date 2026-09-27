import 'package:catlog/src/celebration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The paw: a quick local success shows a green paw at the tapped
/// button for a moment, then nothing — no note, no sound. It goes into
/// the root overlay, so a paw asked for inside a dialog outlives the
/// dialog closing over it.
void main() {
  testWidgets('a tap that succeeds gets a paw under the thumb, briefly',
      (tester) async {
    await tester.pumpWidget(
      TouchTracker(
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(
                builder: (context) => FilledButton(
                  onPressed: () => paw(context),
                  child: const Text('Copy'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.byIcon(Icons.pets), findsNothing);
    await tester.tap(find.text('Copy'));
    await tester.pump();
    expect(find.byIcon(Icons.pets), findsOneWidget);
    // Under the thumb: at the button, not in a corner.
    final button = tester.getCenter(find.text('Copy'));
    final at = tester.getCenter(find.byIcon(Icons.pets));
    expect((at - button).distance, lessThan(120));
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.byIcon(Icons.pets), findsNothing);
  });

  testWidgets('a paw asked for inside a dialog outlives it', (tester) async {
    await tester.pumpWidget(
      TouchTracker(
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(
                builder: (context) => FilledButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (inner) => AlertDialog(
                      content: FilledButton(
                        onPressed: () {
                          paw(inner);
                          Navigator.of(inner).pop();
                        },
                        child: const Text('Copy'),
                      ),
                    ),
                  ),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pump();
    expect(find.byIcon(Icons.pets), findsOneWidget, reason: 'the paw stays');
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.byIcon(Icons.pets), findsNothing);
  });
}
