import 'package:catlog/src/celebration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The paw: a quick local success shows a green paw at the tapped
/// button for half a second, then nothing — no note, no sound.
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
    expect((at - button).distance, lessThan(60));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byIcon(Icons.pets), findsNothing);
  });
}
