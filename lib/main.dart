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
import 'src/stray_cam.dart';
import 'src/hidden.dart';
import 'src/l10n.dart';
import 'src/move_to_catalog.dart';
import 'src/screens/author_setup_screen.dart';
import 'src/screens/home_shell.dart';
import 'src/screens/intro_screen.dart';
import 'src/screens/cat_list_screen.dart';
import 'src/screens/sync_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

/// The catalog everything writes to right now. A file or photo shared
/// into the app lands in the catalog on screen, not in the one that
/// happened to be open when the app started.
CatalogStore? activeStore;

Future<void> main(List<String> args) async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationSupportDirectory();
    // The language decides what the catalog carried over from an older
    // version is called, so it is read before the catalogs are opened.
    final saved = CatalogManager.savedLocale(dir.path);
    if (saved != null && saved.isNotEmpty) {
      localeOverride.value = Locale(saved);
    }
    final texts = await _texts();
    // Armed before the catalogs are opened: the one-time move into the
    // multi-catalog layout can fail, and a failure at launch has to
    // reach the keeper instead of dying in a zone with nothing to catch
    // it. Restart then tries the move again, which is exactly what the
    // message tells them to do.
    await initCrashGuard(dir,
        restart: () => unawaited(_openAndRun(dir, texts, args)));
    // Read the marker BEFORE re-arming it: dirty means the last run was
    // killed without a clean pause (out-of-memory, native crash).
    final diedLastRun = previousRunDied();
    markRunning();
    await _openAndRun(dir, texts, args, diedLastRun: diedLastRun);
  }, (error, stack) {
    // Anything that escapes everything else still gets the friendly
    // screen instead of a silent death.
    PlatformDispatcher.instance.onError?.call(error, stack);
  });
}

/// Opens the catalogs and starts the app. Separate from [main] because
/// the crash screen's Restart runs it again — after a failed migration
/// that is a real retry, not a button that does nothing.
Future<void> _openAndRun(
    Directory dir, AppLocalizations texts, List<String> args,
    {bool diedLastRun = false}) async {
  final catalogs =
      CatalogManager.open(dir.path, defaultName: texts.clowders);
  final store = catalogs.openStore(catalogs.active);
  activeStore = store;
  catalogManager = catalogs;
  // A Stray Cam capture the OS killed mid-camera completes here.
  unawaited(recoverStrayCam(store));
  initIncomingFiles(navigatorKey, () => activeStore ?? store, args);
  await _restoreWindow(store);
  runApp(CatlogApp(
      store: store, catalogs: catalogs, diedLastRun: diedLastRun));
}

/// The texts in the language the app will run in, before there is a
/// widget tree to read them from.
Future<AppLocalizations> _texts() async {
  final locale = localeOverride.value ??
      basicLocaleListResolution(PlatformDispatcher.instance.locales.toList(),
          AppLocalizations.supportedLocales);
  return AppLocalizations.delegate.load(locale);
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

  /// Every catalog on this device, and the settings they share. Null in
  /// widget tests, which build a store directly; the app always has one.
  final CatalogManager? catalogs;

  /// True when the previous run ended in an unclean kill — offer to
  /// send a report once.
  final bool diedLastRun;

  const CatlogApp(
      {super.key,
      required this.store,
      this.catalogs,
      this.diedLastRun = false});

  @override
  State<CatlogApp> createState() => _CatlogAppState();
}

class _CatlogAppState extends State<CatlogApp>
    with WidgetsBindingObserver, WindowListener {
  /// The catalog currently open. Switching catalogs closes this one and
  /// opens another, so it lives in state rather than in the widget.
  late CatalogStore _store = widget.store;

  /// Switches the app to another catalog: the new one becomes what
  /// everything writes to, and the app returns to the list.
  ///
  /// Every page still open belongs to the catalog being left — the
  /// switcher itself is usually one of them — so the stack is unwound
  /// to the home screen and the old catalog is closed only once those
  /// pages are gone. Closing it any earlier leaves them reading from a
  /// database that is no longer open.
  ///
  /// The manage screen passes [unwind] false to stay open: it reads
  /// the store through a live lookup, so it is the one page a switch
  /// cannot strand on a closed database.
  void _switchCatalog(CatalogInfo to, {bool unwind = true}) {
    final manager = widget.catalogs;
    if (manager == null || to.id == manager.active.id) return;
    final next = manager.openStore(to);
    final previous = _store;
    manager.active = to;
    setState(() => _store = next);
    activeStore = next;
    if (unwind) {
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => previous.close());
  }

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
          '${crashReportHeader()}\n\n'
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
    _store.setLocalSetting('windowBounds',
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
      autoBackup(_store);
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
        // Edge-to-edge (Android 15 enforces it): the 3-button nav bar
        // floats over the app and swallowed bottom buttons. Inset the
        // whole app above it; AppBars keep handling the top themselves.
        builder: (context, child) => ColoredBox(
          // Paint the strip behind the system nav bar in app surface
          // color instead of raw black.
          color: Theme.of(context).colorScheme.surface,
          child: SafeArea(
          top: false,
          child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyF, control: true):
                () => navigatorKey.currentState?.push(MaterialPageRoute(
                      builder: (context) => CatListScreen(
                          store: _store,
                          title: context.t.cats,
                          source: (s) => s.visibleCats(),
                          autofocusFilter: true),
                    )),
            const SingleActivator(LogicalKeyboardKey.keyK, control: true):
                () => navigatorKey.currentState?.push(MaterialPageRoute(
                      builder: (_) => SyncScreen(store: _store),
                    )),
            const SingleActivator(LogicalKeyboardKey.keyB, control: true):
                () => autoBackup(_store),
            const SingleActivator(LogicalKeyboardKey.escape): () =>
                navigatorKey.currentState?.maybePop(),
          },
          child: child ?? const SizedBox.shrink(),
          ),
          ),
        ),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          // Desktop gets desktop density and hover manners for free.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _store.author == null
            ? AuthorSetupScreen(
                store: _store,
                onDone: () => setState(() => _freshSetup = true),
              )
            : _freshSetup &&
                    _store.localSetting('introSeen') == null
                ? IntroScreen(
                    store: _store,
                    onDone: () => setState(() {}),
                  )
                : HomeShell(
                    store: _store,
                    switching: widget.catalogs == null
                        ? null
                        : CatalogSwitching(
                            catalogs: widget.catalogs!,
                            onSwitch: _switchCatalog,
                            onChanged: () => setState(() {}),
                          ),
                  ),
      ),
    );
  }
}
