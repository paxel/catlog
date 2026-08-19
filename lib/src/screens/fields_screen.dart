import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../new_field_dialog.dart';

/// All global Field definitions, and a dialog to create new ones.
class FieldsScreen extends StatefulWidget {
  final CatalogStore store;

  const FieldsScreen({super.key, required this.store});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  Future<void> _renameField(FieldDef def) async {
    final controller = TextEditingController(text: def.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.renameField),
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
            child: Text(context.t.save),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty || name == def.name) return;
    widget.store.renameField(def.id, name);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _editOptions(FieldDef def) async {
    final controller =
        TextEditingController(text: def.options.join('\n'));
    final text = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.editOptions),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 8,
          decoration:
              InputDecoration(labelText: context.t.optionsOnePerLine),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(context.t.save),
          ),
        ],
      ),
    );
    if (text == null) return;
    final options = text
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    if (options.isEmpty) return;
    widget.store.setFieldOptions(def.id, options);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _mergeField(FieldDef def) async {
    final candidates = widget.store
        .fieldDefs()
        .map((d) => EntityView(d.id, d.name))
        .toList();
    final merged = await showMergeDialog(
      context: context,
      store: widget.store,
      loserId: def.id,
      kindLabel: context.t.kindField,
      candidates: candidates,
      merge: widget.store.mergeField,
    );
    if (!mounted) return;
    if (merged) setState(() {});
  }

  Future<void> _addField() async {
    final created = await showNewFieldDialog(context, widget.store);
    if (!mounted) return;
    if (created) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final defs = widget.store.fieldDefs();
    String scopeName(FieldScope s) => switch (s) {
          FieldScope.cat => context.t.forCats,
          FieldScope.clowder => context.t.forClowders,
          FieldScope.both => context.t.forBoth,
        };
    return Scaffold(
      appBar: AppBar(title: Text(context.t.fields)),
      body: ListView(
        children: [
          for (final def in defs)
            ListTile(
              leading: Icon(widget.store.isHidden(def.id)
                  ? Icons.visibility_off_outlined
                  : widget.store.isPrivate(def.id)
                      ? Icons.lock
                      : Icons.label_outline),
              title: Text(fieldDefName(context.t, def)),
              subtitle: Text([
                def.type.name,
                scopeName(def.scope),
                if (def.options.isNotEmpty) def.options.join(', '),
              ].join(' · ')),
              trailing: PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'rename') _renameField(def);
                  if (v == 'options') _editOptions(def);
                  if (v == 'merge') _mergeField(def);
                  if (v == 'private') {
                    setState(() => widget.store.setPrivate(
                        def.id, !widget.store.isPrivate(def.id)));
                  }
                  if (v == 'hide') {
                    setState(() => widget.store.setHidden(
                        def.id, !widget.store.isHidden(def.id)));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 'rename', child: Text(context.t.rename)),
                  if (def.type == FieldType.choice)
                    PopupMenuItem(
                        value: 'options',
                        child: Text(context.t.editOptions)),
                  PopupMenuItem(
                      value: 'private',
                      child: Text(widget.store.isPrivate(def.id)
                          ? context.t.unmarkPrivate
                          : context.t.markPrivate)),
                  PopupMenuItem(
                      value: 'hide',
                      child: Text(widget.store.isHidden(def.id)
                          ? context.t.unhideLabel
                          : context.t.hideLabel)),
                  PopupMenuItem(
                      value: 'merge', child: Text(context.t.mergeInto)),
                ],
              ),
              onTap: () => _renameField(def),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addField,
        icon: const Icon(Icons.add),
        label: Text(context.t.newField),
      ),
    );
  }
}
