import 'dart:typed_data';

import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/video_frames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// A player for the test: a clock that moves when told, no picture.
class _FakePlayer extends ChangeNotifier implements FramePlayer {
  @override
  final Duration duration;
  @override
  Duration position = Duration.zero;
  @override
  bool playing = false;
  @override
  double get fps => 30;
  final seeks = <Duration>[];

  _FakePlayer(this.duration);

  @override
  Widget build(BuildContext context) =>
      const SizedBox(width: 160, height: 90, child: ColoredBox(color: Colors.black));

  @override
  Future<void> seekTo(Duration at) async {
    position = at;
    seeks.add(at);
    notifyListeners();
  }

  @override
  Future<void> play() async {
    playing = true;
    notifyListeners();
  }

  @override
  Future<void> pause() async {
    playing = false;
    notifyListeners();
  }
}

Uint8List _jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void main() {
  Future<_FakePlayer> open(
    WidgetTester tester, {
    required Future<Uint8List?> Function(int) extractFrame,
    Future<Uint8List?> Function(int)? extractFull,
    void Function(List<Uint8List>?)? onResult,
  }) async {
    final player = _FakePlayer(const Duration(seconds: 30));
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () async {
            final result = await Navigator.of(context)
                .push<List<Uint8List>>(MaterialPageRoute(
              builder: (_) => VideoFramesScreen(
                player: player,
                extractFrame: extractFrame,
                extractFull: extractFull,
              ),
            ));
            onResult?.call(result);
          },
          child: const Text('go'),
        ),
      ),
    ));
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    return player;
  }

  testWidgets('the steps move the clock by a frame, a second, ten seconds',
      (tester) async {
    final player = await open(tester, extractFrame: (_) async => null);
    await tester.tap(find.byTooltip('One frame forward'));
    await tester.pumpAndSettle();
    expect(player.position, const Duration(microseconds: 33333));
    await tester.tap(find.byTooltip('One second forward'));
    await tester.pumpAndSettle();
    expect(player.position, const Duration(microseconds: 1033333));
    await tester.tap(find.byTooltip('Ten seconds forward'));
    await tester.pumpAndSettle();
    expect(player.position, const Duration(microseconds: 11033333));
    await tester.tap(find.byTooltip('Ten seconds back'));
    await tester.tap(find.byTooltip('One second back'));
    await tester.tap(find.byTooltip('One frame back'));
    await tester.pumpAndSettle();
    expect(player.position, Duration.zero);
    // Never before the start.
    await tester.tap(find.byTooltip('One frame back'));
    await tester.pumpAndSettle();
    expect(player.position, Duration.zero);
    expect(find.text('0:00.0 / 0:30.0'), findsOneWidget);
  });

  testWidgets('play and pause, and the slider seeks while the finger moves',
      (tester) async {
    final player = await open(tester, extractFrame: (_) async => null);
    await tester.tap(find.byTooltip('Play'));
    await tester.pumpAndSettle();
    expect(player.playing, isTrue);
    await tester.tap(find.byTooltip('Pause'));
    await tester.pumpAndSettle();
    expect(player.playing, isFalse);
    await tester.tap(find.byTooltip('Play'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(Slider), const Offset(120, 0));
    await tester.pumpAndSettle();
    // The drag paused the player and seeked it along the way.
    expect(player.playing, isFalse);
    expect(player.seeks, isNotEmpty);
    expect(player.position, greaterThan(Duration.zero));
  });

  testWidgets('kept frames line up, a tap lets one go, save pops them full',
      (tester) async {
    final small = _jpeg(64, 48);
    final big = _jpeg(256, 192);
    var fullCalls = 0;
    List<Uint8List>? result;
    final player = await open(
      tester,
      extractFrame: (_) async => small,
      extractFull: (_) async {
        fullCalls++;
        return big;
      },
      onResult: (r) => result = r,
    );
    expect(find.text('Kept frames appear here'), findsOneWidget);
    expect(find.byTooltip('Save'), findsOneWidget);
    await tester.tap(find.text('Keep this frame'));
    await tester.pumpAndSettle();
    await player.seekTo(const Duration(seconds: 2));
    await tester.tap(find.text('Keep this frame'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle), findsNWidgets(2));
    expect(find.text('Kept frames appear here'), findsNothing);
    // The second one goes again.
    await tester.tap(find.byTooltip('0:02.0'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    // Nothing full-size until save; then one per kept frame.
    expect(fullCalls, 0);
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(fullCalls, 1);
    expect(result, [big]);
  });
}
