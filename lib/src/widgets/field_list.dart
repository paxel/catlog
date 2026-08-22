import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';
import '../l10n.dart';

/// The Field rows of a detail page, in both of its moods (#46):
/// read mode shows only filled fields, nicely formatted and inert;
/// edit mode shows every definition as a tap-to-edit tile. Conflicts
/// outrank the mode — their rows always show and always resolve on tap.
class FieldList extends StatelessWidget {
  final CatalogStore store;
  final String entityId;
  final List<FieldDef> defs;
  final bool editing;
  final void Function(FieldDef def) onEdit;
  final Future<void> Function(FieldDef def) onConflict;
  final void Function(FieldDef def) onHistory;
  final void Function(String value) onShowMap;

  /// Opens the registry page of an ID field that has a lookup URL.
  final void Function(FieldDef def, String value)? onLookup;

  /// Read-mode long-press on a row; null until a screen wires it (#49).
  final void Function(FieldDef def)? onReadLongPress;

  /// Shown as an "Add field" row at the end of the edit-mode list (#50).
  final VoidCallback? onAddField;

  const FieldList(
      {super.key,
      required this.store,
      required this.entityId,
      required this.defs,
      required this.editing,
      required this.onEdit,
      required this.onConflict,
      required this.onHistory,
      required this.onShowMap,
      this.onLookup,
      this.onReadLongPress,
      this.onAddField});

  bool _filled(FieldDef def) {
    final value = store.current(entityId, def.key);
    return value != null && value.isNotEmpty;
  }

  String _display(BuildContext context, FieldDef def) {
    final value = store.current(entityId, def.key);
    if (def.type == FieldType.cat && value != null) {
      return store.current(store.resolveEntity(value), Keys.name) ?? '?';
    }
    return fieldValueDisplay(context.t, def, value);
  }

  @override
  Widget build(BuildContext context) {
    final rows = editing
        ? defs
        : [
            for (final def in defs)
              if (_filled(def) || store.hasConflict(entityId, def.key)) def
          ];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      for (final def in rows)
        Builder(builder: (context) {
          final conflict = store.hasConflict(entityId, def.key);
          final value = store.current(entityId, def.key);
          final mapJump = def.type == FieldType.location && value != null;
          // An ID that belongs to a service opens there — the same
          // shape as the map jump on a location.
          final lookup = onLookup != null &&
              value != null &&
              lookupUrl(def, value) != null;
          return ListTile(
            title: Text(fieldDefName(context.t, def)),
            subtitle: Text(_display(context, def)),
            trailing: conflict
                ? const Icon(Icons.warning_amber, color: Colors.amber)
                : mapJump
                    ? IconButton(
                        icon: const Icon(Icons.map_outlined),
                        tooltip: context.t.showOnMap,
                        onPressed: () => onShowMap(value),
                      )
                    : lookup
                        ? IconButton(
                            icon: const Icon(Icons.open_in_new),
                            tooltip: context.t.lookUpId,
                            onPressed: () => onLookup!(def, value),
                          )
                    : editing
                        ? const Icon(Icons.edit_outlined)
                        : null,
            onTap: conflict
                ? () => onConflict(def)
                : editing
                    ? () => onEdit(def)
                    : null,
            onLongPress: editing
                ? () => onHistory(def)
                : onReadLongPress == null
                    ? null
                    : () => onReadLongPress!(def),
          );
        }),
      if (editing && onAddField != null)
        ListTile(
          leading: const Icon(Icons.add),
          title: Text(context.t.newField),
          onTap: onAddField,
        ),
    ]);
  }
}
