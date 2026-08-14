import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'src/screens/author_setup_screen.dart';
import 'src/screens/clowder_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final store = CatalogStore.open('${dir.path}/catlog.db');
  runApp(CatlogApp(store: store));
}

class CatlogApp extends StatefulWidget {
  final CatalogStore store;

  const CatlogApp({super.key, required this.store});

  @override
  State<CatlogApp> createState() => _CatlogAppState();
}

class _CatlogAppState extends State<CatlogApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cat(a)log',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: widget.store.author == null
          ? AuthorSetupScreen(
              store: widget.store,
              onDone: () => setState(() {}),
            )
          : ClowderListScreen(store: widget.store),
    );
  }
}
