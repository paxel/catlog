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

  test('the mail body drops framework frames and puts ours first', () {
    final body = [
      'cat(a)log 1.2.0+166',
      '',
      'Bad state: No element',
      '',
      '#0 Stream.first. (dart:async/stream.dart:1653)',
      '#1 _rootRun (dart:async/zone_root.dart:27)',
      '#2 _CustomZone.run (dart:async/zone.dart:810)',
      '#3 something (package:flutter/src/widgets/framework.dart:1)',
      '#4 _playCheer (package:catlog/src/celebration.dart:79)',
      '#5 tickChore (package:catalog_core/src/chores.dart:400)',
    ].join('\n');
    final mail = mailBody(body);
    expect(mail, isNot(contains('dart:async')));
    expect(mail, isNot(contains('zone')));
    final ours = mail.indexOf('celebration.dart');
    expect(ours, greaterThan(0));
    expect(mail.indexOf('catalog_core'), greaterThan(ours));
    expect(mail.indexOf('flutter/src'), greaterThan(mail.indexOf('catalog_core')));
    expect(mail, startsWith('cat(a)log 1.2.0+166'));
    expect(mailBody('x' * 3000).length, mailBodyLimit);
  });
}
