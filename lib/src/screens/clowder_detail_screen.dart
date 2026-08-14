import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_editing.dart';
import '../widgets/cat_avatar.dart';
import 'cat_detail_screen.dart';
import 'timeline_screen.dart';

/// One Clowder: name, its Field values (address, responsible person, …),
/// and the Cats currently living there as a grid of faces.
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

  Future<void> _addCat() async {
    final name = await _askForText(context, 'New cat', null);
    if (name == null || name.isEmpty || !mounted) return;
    final catId = store.createCat(name, clowderId: id);
    setState(() {});
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatDetailScreen(
          store: store, catId: catId, promptPhoto: true),
    ));
    setState(() {});
  }

  Future<void> _openCat(String catId) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatDetailScreen(store: store, catId: catId),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final defs = store.fieldDefs(scope: FieldScope.clowder);
    final cats = store.cats(clowderId: id);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Rename',
            onPressed: () => _edit('Rename clowder', Keys.name, name),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Timeline',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TimelineScreen(store: store, entityId: id),
            )),
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
              onTap: () async {
                final edit = await editFieldValue(
                    context, def, store.current(id, def.key));
                if (edit == null) return;
                store.append(id, def.key, edit.value, date: edit.date);
                setState(() {});
              },
              onLongPress: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => TimelineScreen(
                    store: store, entityId: id, field: def.key),
              )),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Cats',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: cats.length,
            itemBuilder: (context, i) {
              final cat = cats[i];
              return InkWell(
                onTap: () => _openCat(cat.id),
                borderRadius: BorderRadius.circular(12),
                child: Column(children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CatAvatar(
                          store: store, catId: cat.id, size: 96),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(cat.name,
                        overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                ]),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCat,
        icon: const Icon(Icons.add),
        label: const Text('Add cat'),
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
