import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n.dart';

/// Global crash guard (forgiving-UX rule 3: errors explain themselves).
///
/// Catches every uncaught Dart/Flutter error and replaces the framework's
/// grey/red death screen with a friendly one: what happened, a Restart
/// button, and a prefilled mail to the developer. A real out-of-memory
/// kill cannot be caught by anything in-process. On Android 11 and newer
/// the system remembers why the process died and is asked at the next
/// launch: a crash, a native crash, an ANR or a memory kill while on
/// screen get the offer of a report, a battery saver's or the user's
/// kill gets none. Older systems fall back to the running-marker: set at
/// startup, cleared on clean pause, dirty on the next launch means a
/// kill.
const crashMail = 'taum@tuta.io';

late Directory _supportDir;
void Function()? _restart;
String? _appVersion;

File get _crashFile => File('${_supportDir.path}/last_crash.txt');
File get _marker => File('${_supportDir.path}/running.marker');
File get _exitSeen => File('${_supportDir.path}/exit_seen.txt');

Future<void> initCrashGuard(Directory supportDir,
    {required void Function() restart, String? appVersion}) async {
  _supportDir = supportDir;
  _restart = restart;
  // A report without a version is a report nobody can act on, so the
  // version is fetched here rather than left to the caller.
  _appVersion = appVersion ?? await _versionFromPackage();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    _record(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    _record(error, stack);
    _showCrashScreen(error, stack);
    return true;
  };
  // In release builds, build errors render as a compact note instead of
  // a grey void.
  if (kReleaseMode) {
    ErrorWidget.builder = (details) => const Center(
          child: Icon(Icons.healing_outlined, size: 32),
        );
  }
}

/// True when the previous run died in a way worth a report. The system's
/// exit record decides where there is one; the marker decides otherwise.
/// Cleared by asking exactly once.
Future<bool> previousRunDied() async {
  final dirty = _marker.existsSync();
  if (dirty) _marker.deleteSync();
  final exit = await _lastExit();
  if (exit == null) return dirty;
  // Each record is asked about once; the same one on the next launch
  // means the run in between ended without a record, so nothing died.
  final seen = _exitSeen.existsSync() ? _exitSeen.readAsStringSync().trim() : '';
  if (seen == '${exit.timestamp}') return false;
  try {
    _exitSeen.writeAsStringSync('${exit.timestamp}');
  } catch (_) {}
  if (!exitDeservesReport(exit.reason, foreground: exit.foreground)) {
    return false;
  }
  if (!_crashFile.existsSync()) {
    try {
      _crashFile.writeAsStringSync('${crashReportHeader()}\n\n'
          'The system ended the app: ${exit.reason}'
          '${exit.foreground ? ' while on screen' : ' in the background'}.\n'
          '${exit.description}');
    } catch (_) {}
  }
  return true;
}

/// Whether an exit the system reports deserves a report: a crash, a
/// native crash, an ANR, or a memory kill while the app was on screen.
/// A memory kill in the background is Android's housekeeping.
bool exitDeservesReport(String reason, {required bool foreground}) =>
    switch (reason) {
      'crash' || 'native' || 'anr' => true,
      'low_memory' => foreground,
      _ => false,
    };

/// What the system remembers of the last exit.
class LastExit {
  final String reason;
  final bool foreground;
  final int timestamp;
  final String description;

  const LastExit(this.reason,
      {required this.foreground,
      required this.timestamp,
      required this.description});
}

/// Asks Android 11+ for the newest exit record; null elsewhere, on older
/// systems, without a record, or when the channel is not there.
Future<LastExit?> _lastExit() async {
  if (!Platform.isAndroid) return null;
  try {
    final info = await const MethodChannel('catlog/exit')
        .invokeMethod<Map<Object?, Object?>>('lastExit');
    if (info == null) return null;
    return LastExit(
      info['reason'] as String? ?? 'other',
      foreground: info['foreground'] as bool? ?? false,
      timestamp: (info['timestamp'] as num?)?.toInt() ?? 0,
      description: info['description'] as String? ?? '',
    );
  } catch (_) {
    return null;
  }
}

void markRunning() => _marker.writeAsStringSync('1');

void markCleanExit() {
  if (_marker.existsSync()) _marker.deleteSync();
}

Future<String?> _versionFromPackage() async {
  try {
    final info = await PackageInfo.fromPlatform();
    return '${info.version}+${info.buildNumber}';
  } catch (_) {
    return null;
  }
}

/// What every report must carry to be worth reading: which build, on
/// which system, in which language, and when.
String crashReportHeader({DateTime? at}) => [
      'cat(a)log ${_appVersion ?? 'version unknown'}',
      '${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      'locale ${Platform.localeName}',
      (at ?? DateTime.now()).toIso8601String(),
    ].join('\n');

void _record(Object error, StackTrace? stack) {
  try {
    _crashFile
        .writeAsStringSync('${crashReportHeader()}\n\n$error\n\n$stack');
  } catch (_) {}
}

String? lastCrashText() =>
    _crashFile.existsSync() ? _crashFile.readAsStringSync() : null;

void clearLastCrash() {
  if (_crashFile.existsSync()) _crashFile.deleteSync();
}

/// How much of the report fits into a `mailto:` body: mail apps cap the
/// URL around 2000 characters.
const mailBodyLimit = 1800;

/// The report as the mail carries it. The trace is thinned first: the
/// `dart:async` and zone frames say nothing about the app and crowd out
/// the frames that do, so they go, and the app's own frames move to the
/// top. Only then is the text cut to [limit].
String mailBody(String body, {int limit = mailBodyLimit}) {
  final lines = body.split('\n');
  final frame = RegExp(r'^#\d+\s');
  final head = <String>[];
  final own = <String>[];
  final other = <String>[];
  for (final line in lines) {
    if (!frame.hasMatch(line)) {
      head.add(line);
      continue;
    }
    if (line.contains('dart:async') || line.contains('zone')) continue;
    (line.contains('package:catlog') || line.contains('package:catalog_core')
            ? own
            : other)
        .add(line);
  }
  final text = [...head, ...own, ...other].join('\n');
  return text.length > limit ? text.substring(0, limit) : text;
}

Future<void> mailCrashReport(String body) async {
  final uri = Uri(
    scheme: 'mailto',
    path: crashMail,
    query: 'subject=${Uri.encodeComponent('cat(a)log crash report')}'
        '&body=${Uri.encodeComponent(mailBody(body))}',
  );
  try {
    await launchUrl(uri);
  } catch (_) {}
}

bool _crashScreenUp = false;

void _showCrashScreen(Object error, StackTrace? stack) {
  if (_crashScreenUp) return;
  _crashScreenUp = true;
  runApp(_CrashApp(error: error, stack: stack));
}

class _CrashApp extends StatelessWidget {
  final Object error;
  final StackTrace? stack;

  const _CrashApp({required this.error, this.stack});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: localeOverride.value,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Builder(
        builder: (context) {
          final t = context.t;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.healing_outlined, size: 64),
                    const SizedBox(height: 16),
                    Text(t.crashTitle,
                        style:
                            Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(t.crashBody, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 140),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          '$error',
                          style: const TextStyle(
                              fontFamily: 'monospace', fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: Text(t.crashRestart),
                      onPressed: () {
                        _crashScreenUp = false;
                        _restart?.call();
                      },
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.mail_outline),
                      label: Text(t.crashSendReport),
                      onPressed: () => mailCrashReport(lastCrashText() ??
                          '${crashReportHeader()}\n\n$error\n\n$stack'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
