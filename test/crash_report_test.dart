import 'dart:io';

import 'package:catlog/src/crash_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A crash report nobody can trace to a build is worthless: every
/// report names the version, the system and when it happened.
void main() {
  test('the report header carries build, system, locale and time', () {
    final header = crashReportHeader(at: DateTime.utc(2026, 8, 20, 12));
    final lines = header.split('\n');
    expect(lines, hasLength(4));
    expect(lines[0], startsWith('cat(a)log '));
    // Without a package context the version is unknown — but it says so
    // instead of leaving a blank where the version should be.
    expect(lines[0].trim(), isNot('cat(a)log'));
    expect(lines[1], contains(Platform.operatingSystem));
    expect(lines[1].length,
        greaterThan(Platform.operatingSystem.length + 1));
    expect(lines[2], startsWith('locale '));
    expect(lines[3], '2026-08-20T12:00:00.000Z');
  });

  group('the running marker', () {
    late Directory dir;

    setUp(() async {
      dir = Directory.systemTemp.createTempSync('catlog-crash');
      await initCrashGuard(dir, restart: () {});
    });

    tearDown(() => dir.deleteSync(recursive: true));

    test('a clean exit leaves nothing behind; a kill is noticed', () {
      markRunning();
      markCleanExit();
      expect(previousRunDied(), isFalse);

      markRunning();
      expect(previousRunDied(), isTrue,
          reason: 'a run that never paused cleanly was killed');
      expect(previousRunDied(), isFalse, reason: 'asked exactly once');
    });

    test('the last crash is readable once and can be cleared', () {
      expect(lastCrashText(), isNull);
      FlutterError.onError!(FlutterErrorDetails(
          exception: StateError('boom'), stack: StackTrace.current));
      final text = lastCrashText();
      expect(text, contains('boom'));
      expect(text, contains(Platform.operatingSystem));
      clearLastCrash();
      expect(lastCrashText(), isNull);
    });
  });
}
