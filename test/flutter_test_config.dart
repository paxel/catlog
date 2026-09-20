import 'dart:async';

import 'package:catlog/src/exclusive.dart';
import 'package:catlog/src/notes.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs around every test file: a flow a test left running (a camera
/// that never returned) must not keep the next test's buttons busy —
/// a spinner that never stops is a pumpAndSettle that never settles.
/// The notes are app-wide too: a note one test left up must not be the
/// next test's finding.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUp(() {
    busyFlows.value = const {};
    NoteQueue.instance.clear();
  });
  // A finished note's dwell timer must not outlive the test that made it.
  tearDown(NoteQueue.instance.clear);
  await testMain();
}
