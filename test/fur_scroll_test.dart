import 'package:catlog/src/fur_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The coat scrolls with the page it sits under and remembers where
/// each page was; dialogs and sideways rows leave it alone.
void main() {
  tearDown(() {
    activeFur = FurPattern.cheetah;
    furScroll.offset.value = 0;
  });

  Widget app(Widget home) => MaterialApp(
    navigatorObservers: [furScroll],
    theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
    builder: (context, child) => FurBackground(child: child!),
    home: home,
  );

  Widget page(String title, {Axis axis = Axis.vertical}) => Scaffold(
    body: ListView.builder(
      scrollDirection: axis,
      itemExtent: 100,
      itemCount: 50,
      itemBuilder: (_, i) => Text('$title $i'),
    ),
  );

  testWidgets('the coat follows the page scroll', (tester) async {
    await tester.pumpWidget(app(page('home')));
    await tester.pumpAndSettle();
    expect(furScroll.offset.value, 0);

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    final list = tester.state<ScrollableState>(find.byType(Scrollable));
    expect(list.position.pixels, greaterThan(0));
    expect(furScroll.offset.value, list.position.pixels);
  });

  testWidgets('a new page starts at the top, the old one keeps its place', (
    tester,
  ) async {
    await tester.pumpWidget(app(page('home')));
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    final scrolled = furScroll.offset.value;
    expect(scrolled, greaterThan(0));

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.push(MaterialPageRoute(builder: (_) => page('detail')));
    await tester.pumpAndSettle();
    expect(furScroll.offset.value, 0);

    navigator.pop();
    await tester.pumpAndSettle();
    expect(furScroll.offset.value, scrolled);
  });

  testWidgets('lists nested inside the page do not move the coat', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        Scaffold(
          body: ListView.builder(
            itemExtent: 100,
            itemCount: 50,
            itemBuilder: (_, i) => ListView(
              children: [for (var k = 0; k < 10; k++) Text('inner $i $k')],
            ),
          ),
        ),
      ),
    );
    // A drag lands on the inner lists, so move the page programmatically.
    final outer = tester.state<ScrollableState>(find.byType(Scrollable).first);
    outer.position.jumpTo(300);
    await tester.pumpAndSettle();
    expect(outer.position.pixels, 300);
    expect(furScroll.offset.value, 300);

    await tester.drag(find.text('inner 4 0'), const Offset(0, -50));
    await tester.pumpAndSettle();
    expect(furScroll.offset.value, 300);
  });

  testWidgets('dialogs and sideways rows do not move the coat', (tester) async {
    await tester.pumpWidget(app(page('home', axis: Axis.horizontal)));
    await tester.drag(find.byType(ListView), const Offset(-300, 0));
    await tester.pumpAndSettle();
    expect(furScroll.offset.value, 0);

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    showDialog<void>(
      context: navigator.context,
      builder: (_) => Dialog(child: SizedBox(height: 200, child: page('d'))),
    );
    await tester.pumpAndSettle();
    await tester.drag(find.text('d 0'), const Offset(0, -150));
    await tester.pumpAndSettle();
    expect(furScroll.offset.value, 0);
  });
}
