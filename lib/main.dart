import 'dart:async';
import 'dart:ui' show PlatformDispatcher;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'src/auto_backup.dart';
import 'src/crash_guard.dart';
import 'src/stray_cam.dart';
import 'src/l10n.dart';
import 'src/screens/author_setup_screen.dart';
import 'src/screens/clowder_list_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationSupportDirectory();
    final store = CatalogStore.open('${dir.path}/catlog.db');
    final saved = store.localSetting('locale');
    if (saved != null && saved.isNotEmpty) {
      localeOverride.value = Locale(saved);
    }
    await initCrashGuard(dir,
        restart: () => runApp(CatlogApp(store: store)));
    // Read the marker BEFORE re-arming it: dirty means the last run was
    // killed without a clean pause (out-of-memory, native crash).
    final diedLastRun = previousRunDied();
    markRunning();
    // A Stray Cam capture the OS killed mid-camera completes here.
    unawaited(recoverStrayCam(store));
    runApp(CatlogApp(store: store, diedLastRun: diedLastRun));
  }, (error, stack) {
    // Anything that escapes everything else still gets the friendly
    // screen instead of a silent death.
    PlatformDispatcher.instance.onError?.call(error, stack);
  });
}

class CatlogApp extends StatefulWidget {
  final CatalogStore store;

  /// True when the previous run ended in an unclean kill — offer to
  /// send a report once.
  final bool diedLastRun;

  const CatlogApp(
      {super.key, required this.store, this.diedLastRun = false});

  @override
  State<CatlogApp> createState() => _CatlogAppState();
}

class _CatlogAppState extends State<CatlogApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.diedLastRun) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _offerCrashReport());
    }
  }

  Future<void> _offerCrashReport() async {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;
    final t = context.t;
    final send = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.crashTitle),
        content: Text(t.crashLastRunBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.crashSendReport),
          ),
        ],
      ),
    );
    if (send == true) {
      await mailCrashReport(lastCrashText() ??
          'cat(a)log was killed without a crash log '
              '(most likely out of memory).');
    }
    clearLastCrash();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Leaving the app: drop an uninstall-proof backup if data changed,
    // and mark the exit clean so the next launch doesn't cry crash.
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      autoBackup(widget.store);
      markCleanExit();
    }
    if (state == AppLifecycleState.resumed) {
      markRunning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: localeOverride,
      builder: (context, locale, _) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'cat(a)log',
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: widget.store.author == null
            ? AuthorSetupScreen(
                store: widget.store,
                onDone: () => setState(() {}),
              )
            : ClowderListScreen(store: widget.store),
      ),
    );
  }
}
