import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// The one field-creation dialog: used by the Fields screen and by the
/// detail pages' edit mode (#46). Returns true when a field was created.
Future<bool> showNewFieldDialog(BuildContext context, CatalogStore store,
    {FieldScope initialScope = FieldScope.cat}) async {
  final created = await showDialog<bool>(
    context: context,
    builder: (context) =>
        _NewFieldDialog(store: store, initialScope: initialScope),
  );
  return created == true;
}

class _NewFieldDialog extends StatefulWidget {
  final CatalogStore store;
  final FieldScope initialScope;

  const _NewFieldDialog({required this.store, required this.initialScope});

  @override
  State<_NewFieldDialog> createState() => _NewFieldDialogState();
}

class _NewFieldDialogState extends State<_NewFieldDialog> {
  final _name = TextEditingController();
  final _options = TextEditingController();
  final _lookup = TextEditingController();
  FieldType _type = FieldType.text;
  late FieldScope _scope = widget.initialScope;
  IdDisplay _idDisplay = IdDisplay.plain;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _options.dispose();
    _lookup.dispose();
    super.dispose();
  }

  void _create() {
    try {
      widget.store.defineField(
        _name.text,
        _type,
        scope: _scope,
        idDisplay: _idDisplay,
        lookupUrl: _lookup.text.trim(),
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
          if (_type == FieldType.id) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<IdDisplay>(
              initialValue: _idDisplay,
              decoration:
                  InputDecoration(labelText: context.t.displayFormat),
              items: [
                DropdownMenuItem(
                    value: IdDisplay.plain,
                    child: Text(context.t.displayPlain)),
                DropdownMenuItem(
                    value: IdDisplay.qr, child: Text(context.t.displayQr)),
                DropdownMenuItem(
                    value: IdDisplay.barcode,
                    child: Text(context.t.displayBarcode)),
              ],
              onChanged: (d) => setState(() => _idDisplay = d ?? _idDisplay),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lookup,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: context.t.lookupUrlLabel,
                helperText: context.t.lookupUrlHelp(lookupPlaceholder),
                helperMaxLines: 3,
              ),
            ),
            // The known services fill name and template in one tap;
            // every other registry is learned from a scanned flier.
            Wrap(spacing: 8, children: [
              for (final preset in registryPresets)
                ActionChip(
                  label: Text(preset.name),
                  onPressed: () => setState(() {
                    if (_name.text.trim().isEmpty) _name.text = preset.name;
                    _lookup.text = preset.template;
                  }),
                ),
            ]),
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
