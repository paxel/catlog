import 'dart:async';

import 'package:catlog/src/exclusive.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs around every test file: a flow a test left running (a camera
/// that never returned) must not keep the next test's buttons busy —
/// a spinner that never stops is a pumpAndSettle that never settles.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUp(() => busyFlows.value = const {});
  await testMain();
}
