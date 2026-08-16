import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';

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
    setState(() {});
  }

  Future<void> _mergeField(FieldDef def) async {
    final sameType = widget.store
        .fieldDefs()
        .where((d) => d.type == def.type)
        .map((d) => EntityView(d.id, d.name))
        .toList();
    final merged = await showMergeDialog(
      context: context,
      store: widget.store,
      loserId: def.id,
      kindLabel: context.t.kindField,
      candidates: sameType,
      merge: widget.store.mergeField,
    );
    if (merged) setState(() {});
  }

  Future<void> _addField() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (context) => _NewFieldDialog(store: widget.store),
    );
    if (created == true) setState(() {});
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
              leading: Icon(widget.store.isPrivate(def.id)
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
                  if (v == 'merge') _mergeField(def);
                  if (v == 'private') {
                    setState(() => widget.store.setPrivate(
                        def.id, !widget.store.isPrivate(def.id)));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 'rename', child: Text(context.t.rename)),
                  PopupMenuItem(
                      value: 'private',
                      child: Text(widget.store.isPrivate(def.id)
                          ? context.t.unmarkPrivate
                          : context.t.markPrivate)),
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

class _NewFieldDialog extends StatefulWidget {
  final CatalogStore store;

  const _NewFieldDialog({required this.store});

  @override
  State<_NewFieldDialog> createState() => _NewFieldDialogState();
}

class _NewFieldDialogState extends State<_NewFieldDialog> {
  final _name = TextEditingController();
  final _options = TextEditingController();
  FieldType _type = FieldType.text;
  FieldScope _scope = FieldScope.cat;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _options.dispose();
    super.dispose();
  }

  void _create() {
    try {
      widget.store.defineField(
        _name.text,
        _type,
        scope: _scope,
        options: _options.text
            .split('\n')
            .map((o) => o.trim())
            .where((o) => o.isNotEmpty)
            .toList(),
      );
      Navigator.of(context).pop(true);
    } on ArgumentError catch (e) {
      setState(() => _error = e.message as String?);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.newField),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(
                labelText: context.t.name, errorText: _error),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<FieldType>(
            initialValue: _type,
            decoration: InputDecoration(labelText: context.t.fieldType),
            items: [
              for (final t in FieldType.values)
                DropdownMenuItem(value: t, child: Text(t.name)),
            ],
            onChanged: (t) => setState(() => _type = t ?? _type),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<FieldScope>(
            initialValue: _scope,
            decoration: InputDecoration(labelText: context.t.usedOn),
            items: [
              DropdownMenuItem(
                  value: FieldScope.cat, child: Text(context.t.forCats)),
              DropdownMenuItem(
                  value: FieldScope.clowder,
                  child: Text(context.t.forClowders)),
              DropdownMenuItem(
                  value: FieldScope.both, child: Text(context.t.forBoth)),
            ],
            onChanged: (s) => setState(() => _scope = s ?? _scope),
          ),
          if (_type == FieldType.choice) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _options,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: context.t.optionsOnePerLine,
                alignLabelWithHint: true,
              ),
            ),
          ],
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(onPressed: _create, child: Text(context.t.create)),
      ],
    );
  }
}
