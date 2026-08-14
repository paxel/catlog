import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

/// One Clowder: name plus its Field values (address, responsible person, …).
class ClowderDetailScreen extends StatefulWidget {
  final CatalogStore store;
  final String clowderId;

  const ClowderDetailScreen(
      {super.key, required this.store, required this.clowderId});

  @override
  State<ClowderDetailScreen> createState() => _ClowderDetailScreenState();
}

class _ClowderDetailScreenState extends State<ClowderDetailScreen> {
  CatalogStore get store => widget.store;
  String get id => widget.clowderId;

  Future<void> _edit(String title, String field, String? initial) async {
    final value = await _askForText(context, title, initial);
    if (value == null || value == (initial ?? '')) return;
    store.append(id, field, value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final defs = store.fieldDefs(scope: FieldScope.clowder);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Rename',
            onPressed: () => _edit('Rename clowder', Keys.name, name),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final def in defs)
            ListTile(
              title: Text(def.name),
              subtitle: Text(store.current(id, def.key) ?? '—'),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () =>
                  _edit(def.name, def.key, store.current(id, def.key)),
            ),
        ],
      ),
    );
  }
}

Future<String?> _askForText(
    BuildContext context, String title, String? initial) {
  final controller = TextEditingController(text: initial ?? '');
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
