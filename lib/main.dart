import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'src/auto_backup.dart';
import 'src/l10n.dart';
import 'src/screens/author_setup_screen.dart';
import 'src/screens/clowder_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final store = CatalogStore.open('${dir.path}/catlog.db');
  final saved = store.localSetting('locale');
  if (saved != null && saved.isNotEmpty) {
    localeOverride.value = Locale(saved);
  }
  runApp(CatlogApp(store: store));
}

class CatlogApp extends StatefulWidget {
  final CatalogStore store;

  const CatlogApp({super.key, required this.store});

  @override
  State<CatlogApp> createState() => _CatlogAppState();
}

class _CatlogAppState extends State<CatlogApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Leaving the app: drop an uninstall-proof backup if data changed.
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      autoBackup(widget.store);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: localeOverride,
      builder: (context, locale, _) => MaterialApp(
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
