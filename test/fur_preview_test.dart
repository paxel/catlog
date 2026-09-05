import 'dart:io';
import 'dart:ui' as ui;

import 'package:catlog/src/fur_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Renders every coat to a PNG for eyeballing. Run by hand:
///   flutter test test/fur_preview_test.dart --run-skipped
void main() {
  testWidgets('previews', (tester) async {
    tester.view.physicalSize = const Size(420, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    const out =
        '/tmp/claude-1000/-home-axel-data-development-catlog/0838f9df-7ab1-43ac-a1fa-c95ceff09db9/scratchpad';
    for (final pattern in FurPattern.values) {
      for (final dark in [false, if (pattern == FurPattern.tabby) true]) {
        activeFur = pattern;
        final theme = ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepOrange,
                brightness: dark ? Brightness.dark : Brightness.light),
            scaffoldBackgroundColor: Colors.transparent);
        await tester.pumpWidget(MaterialApp(
          theme: theme,
          darkTheme: theme,
          home: RepaintBoundary(
            child: FurBackground(
              child: Scaffold(
                appBar: AppBar(title: const Text('Clowders')),
                body: ListView(padding: const EdgeInsets.all(16), children: [
                  const Card(
                      child: ListTile(
                          title: Text('Sonnenhof'),
                          subtitle: Text('3 cats'))),
                  const Card(
                      child: ListTile(
                          title: Text('Strays'), subtitle: Text('2 cats'))),
                  const Text('Some body text on the pattern'),
                ]),
              ),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        final image = await tester.runAsync(() async {
          final boundary = tester
              .renderObject<RenderRepaintBoundary>(
                  find.byType(RepaintBoundary).first);
          return boundary.toImage();
        });
        final bytes = await tester.runAsync(
            () => image!.toByteData(format: ui.ImageByteFormat.png));
        File('$out/fur-${pattern.name}${dark ? '-dark' : ''}.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
      }
    }
  }, skip: true); // preview generator, flip to run by hand
}
