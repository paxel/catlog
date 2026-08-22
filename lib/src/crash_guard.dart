import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n.dart';

/// Global crash guard (forgiving-UX rule 3: errors explain themselves).
///
/// Catches every uncaught Dart/Flutter error and replaces the framework's
/// grey/red death screen with a friendly one: what happened, a Restart
/// button, and a prefilled mail to the developer. A real out-of-memory
/// kill cannot be caught by anything in-process — the running-marker
/// covers it: set at startup, cleared on clean pause; found dirty on the
/// next launch, the app offers to send a report.
const crashMail = 'taum@tuta.io';

late Directory _supportDir;
void Function()? _restart;
String? _appVersion;

File get _crashFile => File('${_supportDir.path}/last_crash.txt');
File get _marker => File('${_supportDir.path}/running.marker');

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

/// True when the previous run died without a clean pause — an OOM kill
/// or native crash. Cleared by asking exactly once.
bool previousRunDied() {
  final dirty = _marker.existsSync();
  if (dirty) _marker.deleteSync();
  return dirty;
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

Future<void> mailCrashReport(String body) async {
  final uri = Uri(
    scheme: 'mailto',
    path: crashMail,
    query: 'subject=${Uri.encodeComponent('cat(a)log crash report')}'
        '&body=${Uri.encodeComponent(body.length > 1800 ? body.substring(0, 1800) : body)}',
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
