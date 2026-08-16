import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../conflict_dialog.dart';
import '../field_editing.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../name_date_dialog.dart';
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

  Future<void> _rename() async {
    final current = store.current(id, Keys.name) ?? '';
    final name =
        await _askForText(context, context.t.renameClowder, current);
    if (name == null || name.isEmpty || name == current) return;
    store.append(id, Keys.name, name);
    setState(() {});
  }

  Future<void> _addCat() async {
    final result = await askNameAndDate(context, context.t.newCat);
    if (result == null || !mounted) return;
    final catId =
        store.createCat(result.name, clowderId: id, date: result.date);
    setState(() {});
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) =>
          CatDetailScreen(store: store, catId: catId, promptPhoto: true),
    ));
    setState(() {});
  }

  Future<void> _mergeClowder() async {
    final merged = await showMergeDialog(
      context: context,
      store: store,
      loserId: id,
      kindLabel: context.t.kindClowder,
      candidates: store.clowders(),
      merge: store.mergeClowder,
    );
    if (merged && mounted) Navigator.of(context).pop();
  }

  Future<void> _deleteClowder() async {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final count = store.cats(clowderId: id).length;
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.deleteQuestion(name)),
        content: Text(count == 0
            ? context.t.deleteClowderEmptyBody
            : context.t.deleteClowderBody(count)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.t.delete),
          ),
        ],
      ),
    );
    if (sure != true || !mounted) return;
    store.deleteClowder(id);
    Navigator.of(context).pop();
  }

  Future<void> _openCat(String catId) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatDetailScreen(store: store, catId: catId),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final defs = store.visibleFieldDefs(scope: FieldScope.clowder);
    final cats = store.visibleCats(clowderId: id);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: context.t.rename,
            onPressed: _rename,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: context.t.timeline,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TimelineScreen(store: store, entityId: id),
            )),
          ),
          if (store.isPrivate(id))
            Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'delete') _deleteClowder();
              if (v == 'merge') _mergeClowder();
              if (v == 'private') {
                setState(() =>
                    store.setPrivate(id, !store.isPrivate(id)));
              }
              if (v == 'hide') {
                final wasHidden = store.isHidden(id);
                store.setHidden(id, !wasHidden);
                if (wasHidden || showHidden.value) {
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 'private',
                  child: Text(store.isPrivate(id)
                      ? context.t.unmarkPrivate
                      : context.t.markPrivate)),
              PopupMenuItem(
                  value: 'hide',
                  child: Text(store.isHidden(id)
                      ? context.t.unhideLabel
                      : context.t.hideLabel)),
              PopupMenuItem(
                  value: 'merge', child: Text(context.t.mergeInto)),
              PopupMenuItem(
                  value: 'delete', child: Text(context.t.deleteClowder)),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final def in defs)
            ListTile(
              title: Text(fieldDefName(context.t, def)),
              subtitle: Text(fieldValueDisplay(
                  context.t, def, store.current(id, def.key))),
              trailing: store.hasConflict(id, def.key)
                  ? const Icon(Icons.warning_amber, color: Colors.amber)
                  : const Icon(Icons.edit_outlined),
              onTap: () async {
                if (store.hasConflict(id, def.key)) {
                  await showConflictDialog(context, store, id, def.key);
                  setState(() {});
                  return;
                }
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
            child: Text(context.t.cats,
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
                      child:
                          CatAvatar(store: store, catId: cat.id, size: 96),
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
        label: Text(context.t.addCat),
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
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(context.t.save),
        ),
      ],
    ),
  );
}
