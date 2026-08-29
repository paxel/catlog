import 'dart:async';

import 'package:catlog/src/stray_cam.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

/// A fix that never arrives ends as "no fix" after the limit instead of
/// holding the flow — and its busy key — forever.
void main() {
  testWidgets('a position that never comes gives up after the limit',
      (tester) async {
    final never = Completer<Position>();
    PositionOutcome? outcome;
    positionWithin(() => never.future, limit: const Duration(seconds: 20))
        .then((o) => outcome = o);
    await tester.pump(const Duration(seconds: 24));
    expect(outcome, isNull);
    await tester.pump(const Duration(seconds: 2));
    expect(outcome?.failure, LocationFailure.noFix);
    expect(outcome?.pos, isNull);
  });

  testWidgets('a fix in time is returned', (tester) async {
    PositionOutcome? outcome;
    positionWithin(() async => Position(
          latitude: 48.1,
          longitude: 11.5,
          timestamp: DateTime.now(),
          accuracy: 5,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        )).then((o) => outcome = o);
    await tester.pump();
    expect(outcome?.pos, (48.1, 11.5));
  });
}
