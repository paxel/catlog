import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'clowder_detail_screen.dart';
import 'fields_screen.dart';
import 'map_screen.dart';
import 'search_screen.dart';
import 'strays_screen.dart';
import 'sync_screen.dart';

/// Home screen: all Clowders.
class ClowderListScreen extends StatefulWidget {
  final CatalogStore store;

  const ClowderListScreen({super.key, required this.store});

  @override
  State<ClowderListScreen> createState() => _ClowderListScreenState();
}

class _ClowderListScreenState extends State<ClowderListScreen> {
  Future<void> _addClowder() async {
    final name = await _askForName(context);
    if (name == null || !mounted) return;
    final id = widget.store.createClowder(name);
    setState(() {});
    if (!mounted) return;
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ClowderDetailScreen(store: widget.store, clowderId: id),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final clowders = widget.store.clowders()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    final strays = widget.store.strays();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clowders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search cats',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SearchScreen(store: widget.store),
            )),
          ),
          IconButton(
            icon: const Icon(Icons.map_outlined),
            tooltip: 'Map',
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MapScreen(store: widget.store),
              ));
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync',
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SyncScreen(store: widget.store),
              ));
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Fields',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FieldsScreen(store: widget.store),
            )),
          ),
        ],
      ),
      body: ListView(
        children: [
          if (clowders.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Text('No clowders yet.\nCreate the first one below.',
                  textAlign: TextAlign.center),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.4,
            ),
            itemCount: clowders.length,
            itemBuilder: (context, i) {
              final clowder = clowders[i];
              return _ClowderCard(
                store: widget.store,
                clowder: clowder,
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ClowderDetailScreen(
                        store: widget.store, clowderId: clowder.id),
                  ));
                  setState(() {});
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Strays'),
            trailing: Text('${strays.length}'),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => StraysScreen(store: widget.store),
              ));
              setState(() {});
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addClowder,
        tooltip: 'New clowder',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// A Clowder as a card: faded photo of one of its cats as background,
/// name on top with a shadow for contrast.
class _ClowderCard extends StatelessWidget {
  final CatalogStore store;
  final EntityView clowder;
  final VoidCallback onTap;

  const _ClowderCard(
      {required this.store, required this.clowder, required this.onTap});

  /// Background: profile image of the first cat in the clowder that has one.
  Uint8List? _cover() {
    for (final cat in store.cats(clowderId: clowder.id)) {
      final hash = store.profileImage(cat.id);
      if (hash != null) {
        final bytes = store.imageBytes(hash);
        if (bytes != null) return bytes;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cover = _cover();
    final scheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      color: scheme.surfaceContainerHighest,
      child: InkWell(
        onTap: onTap,
        child: Stack(fit: StackFit.expand, children: [
          if (cover != null)
            Opacity(
              opacity: 0.55,
              child: Image.memory(cover, fit: BoxFit.cover),
            )
          else
            Center(
              child: Icon(Icons.pets,
                  size: 40, color: scheme.onSurfaceVariant.withValues(alpha: 0.4)),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                clowder.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: cover != null ? Colors.white : scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  shadows: cover != null
                      ? const [
                          Shadow(blurRadius: 6, color: Colors.black87),
                          Shadow(blurRadius: 2, color: Colors.black),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Future<String?> _askForName(BuildContext context) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('New clowder'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Name'),
        onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: const Text('Create'),
        ),
      ],
    ),
  ).then((name) => (name == null || name.isEmpty) ? null : name);
}
