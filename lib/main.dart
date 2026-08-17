import 'dart:async';
import 'dart:io';
import 'dart:ui' show PlatformDispatcher;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'src/auto_backup.dart';
import 'src/crash_guard.dart';
import 'src/incoming_file.dart';
import 'src/l10n.dart';
import 'src/screens/author_setup_screen.dart';
import 'src/screens/home_shell.dart';
import 'src/screens/intro_screen.dart';
import 'src/screens/search_screen.dart';
import 'src/screens/sync_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main(List<String> args) async {
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
    initIncomingFiles(navigatorKey, store, args);
    await _restoreWindow(store);
    runApp(CatlogApp(store: store, diedLastRun: diedLastRun));
  }, (error, stack) {
    // Anything that escapes everything else still gets the friendly
    // screen instead of a silent death.
    PlatformDispatcher.instance.onError?.call(error, stack);
  });
}

bool get _isDesktop =>
    Platform.isLinux || Platform.isWindows || Platform.isMacOS;

/// Desktop opens the way it was left (spec: window geometry persists).
Future<void> _restoreWindow(CatalogStore store) async {
  if (!_isDesktop) return;
  await windowManager.ensureInitialized();
  final saved = store.localSetting('windowBounds')?.split(',');
  await windowManager.waitUntilReadyToShow(null, () async {
    if (saved != null && saved.length == 4) {
      final v = saved.map(double.tryParse).toList();
      if (!v.contains(null)) {
        await windowManager.setBounds(
            Rect.fromLTWH(v[0]!, v[1]!, v[2]!, v[3]!));
      }
    }
    await windowManager.show();
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
    with WidgetsBindingObserver, WindowListener {
  /// True only when the author was created THIS run: the intro is for
  /// fresh installs, never sprung on upgraders with a routine.
  bool _freshSetup = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_isDesktop) windowManager.addListener(this);
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
    if (_isDesktop) windowManager.removeListener(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _saveBounds() async {
    final b = await windowManager.getBounds();
    widget.store.setLocalSetting('windowBounds',
        '${b.left},${b.top},${b.width},${b.height}');
  }

  @override
  void onWindowResized() => _saveBounds();

  @override
  void onWindowMoved() => _saveBounds();

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
        // Desktop keyboard manners: Ctrl+F search, Ctrl+K sync,
        // Ctrl+B backup now, Esc back. Arrows/Enter come from Flutter's
        // default desktop focus traversal (cards are focusable).
        builder: (context, child) => CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyF, control: true):
                () => navigatorKey.currentState?.push(MaterialPageRoute(
                      builder: (_) => SearchScreen(store: widget.store),
                    )),
            const SingleActivator(LogicalKeyboardKey.keyK, control: true):
                () => navigatorKey.currentState?.push(MaterialPageRoute(
                      builder: (_) => SyncScreen(store: widget.store),
                    )),
            const SingleActivator(LogicalKeyboardKey.keyB, control: true):
                () => autoBackup(widget.store),
            const SingleActivator(LogicalKeyboardKey.escape): () =>
                navigatorKey.currentState?.maybePop(),
          },
          child: child ?? const SizedBox.shrink(),
        ),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          // Desktop gets desktop density and hover manners for free.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: widget.store.author == null
            ? AuthorSetupScreen(
                store: widget.store,
                onDone: () => setState(() => _freshSetup = true),
              )
            : _freshSetup &&
                    widget.store.localSetting('introSeen') == null
                ? IntroScreen(
                    store: widget.store,
                    onDone: () => setState(() {}),
                  )
                : HomeShell(store: widget.store),
      ),
    );
  }
}
