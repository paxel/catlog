import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'clowder_detail_screen.dart';
import 'fields_screen.dart';

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
    final clowders = widget.store.clowders();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clowders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Fields',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FieldsScreen(store: widget.store),
            )),
          ),
        ],
      ),
      body: clowders.isEmpty
          ? const Center(
              child: Text('No clowders yet.\nCreate the first one below.',
                  textAlign: TextAlign.center),
            )
          : ListView.builder(
              itemCount: clowders.length,
              itemBuilder: (context, i) {
                final clowder = clowders[i];
                return ListTile(
                  leading: const Icon(Icons.home),
                  title: Text(clowder.name),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addClowder,
        tooltip: 'New clowder',
        child: const Icon(Icons.add),
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
