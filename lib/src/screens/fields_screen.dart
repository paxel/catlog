import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

/// All global Field definitions, and a dialog to create new ones.
class FieldsScreen extends StatefulWidget {
  final CatalogStore store;

  const FieldsScreen({super.key, required this.store});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Fields')),
      body: ListView(
        children: [
          for (final def in defs)
            ListTile(
              leading: const Icon(Icons.label_outline),
              title: Text(def.name),
              subtitle: Text([
                def.type.name,
                'for ${def.scope.name}',
                if (def.options.isNotEmpty) def.options.join(', '),
              ].join(' · ')),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addField,
        icon: const Icon(Icons.add),
        label: const Text('New field'),
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
      title: const Text('New field'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: _name,
            autofocus: true,
            decoration:
                InputDecoration(labelText: 'Name', errorText: _error),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<FieldType>(
            initialValue: _type,
            decoration: const InputDecoration(labelText: 'Type'),
            items: [
              for (final t in FieldType.values)
                DropdownMenuItem(value: t, child: Text(t.name)),
            ],
            onChanged: (t) => setState(() => _type = t ?? _type),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<FieldScope>(
            initialValue: _scope,
            decoration: const InputDecoration(labelText: 'Used on'),
            items: const [
              DropdownMenuItem(
                  value: FieldScope.cat, child: Text('cats')),
              DropdownMenuItem(
                  value: FieldScope.clowder, child: Text('clowders')),
              DropdownMenuItem(
                  value: FieldScope.both, child: Text('both')),
            ],
            onChanged: (s) => setState(() => _scope = s ?? _scope),
          ),
          if (_type == FieldType.choice) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _options,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Options (one per line)',
                alignLabelWithHint: true,
              ),
            ),
          ],
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _create, child: const Text('Create')),
      ],
    );
  }
}
