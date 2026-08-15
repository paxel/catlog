import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../stray_cam.dart';
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
  Future<void> _addStray() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.newStray),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: context.t.name),
          onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.t.cancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pop(controller.text.trim()),
            child: Text(context.t.create),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty || !mounted) return;
    final catId = widget.store.createCat(name);
    setState(() {});
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatDetailScreen(
          store: widget.store, catId: catId, promptPhoto: true),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final strays = widget.store.strays();
    return Scaffold(
      appBar: AppBar(title: Text(context.t.strays)),
      floatingActionButton:
          Column(mainAxisSize: MainAxisSize.min, children: [
        FloatingActionButton.extended(
          heroTag: 'strayCam',
          onPressed: () async {
            final catId = await strayCam(context, widget.store);
            if (catId != null && context.mounted) {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    CatDetailScreen(store: widget.store, catId: catId),
              ));
            }
            setState(() {});
          },
          icon: const Icon(Icons.photo_camera),
          label: Text(context.t.strayCam),
        ),
        const SizedBox(height: 12),
        FloatingActionButton.extended(
          heroTag: 'addStray',
          onPressed: _addStray,
          icon: const Icon(Icons.add),
          label: Text(context.t.addStray),
        ),
      ]),
      body: strays.isEmpty
          ? Center(child: Text(context.t.noStraysRightNow))
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
