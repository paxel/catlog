import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../widgets/cat_avatar.dart';
import 'cat_detail_screen.dart';

/// Cats currently in no Clowder. The map view arrives with milestone M3;
/// until then this list keeps Strays visible.
class StraysScreen extends StatefulWidget {
  final CatalogStore store;

  const StraysScreen({super.key, required this.store});

  @override
  State<StraysScreen> createState() => _StraysScreenState();
}

class _StraysScreenState extends State<StraysScreen> {
  @override
  Widget build(BuildContext context) {
    final strays = widget.store.strays();
    return Scaffold(
      appBar: AppBar(title: const Text('Strays')),
      body: strays.isEmpty
          ? const Center(child: Text('No strays right now.'))
          : ListView.builder(
              itemCount: strays.length,
              itemBuilder: (context, i) {
                final cat = strays[i];
                return ListTile(
                  leading: CatAvatar(
                      store: widget.store, catId: cat.id, size: 40),
                  title: Text(cat.name),
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CatDetailScreen(
                          store: widget.store, catId: cat.id),
                    ));
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}
