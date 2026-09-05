import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';
import '../l10n.dart';
import 'cat_ear.dart';
import '../age.dart';
import '../screens/field_graph_screen.dart';
import '../screens/field_history_screen.dart';

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
  final void Function(FieldDef def, String value) onShowMap;

  /// Opens the registry page of an ID field that has a lookup URL.
  final void Function(FieldDef def, String value)? onLookup;

  /// Read-mode long-press on a row; null until a screen wires it (#49).
  final void Function(FieldDef def)? onReadLongPress;

  /// Opens the graph of a number or Unit Value field (#97); shown only
  /// once the history holds two values — one number is not a curve.
  final void Function(FieldDef def)? onGraph;

  /// Opens the value history of a field in read mode: a diary of what
  /// it held, for fields with two values or more and no graph.
  final void Function(FieldDef def)? onValueHistory;

  /// Shown as an "Add field" row at the end of the edit-mode list (#50).
  final VoidCallback? onAddField;

  /// Turns the Address value into a Position on request (#81); the
  /// button sits under the address row. Null where there is no address.
  final VoidCallback? onLocate;

  /// What the last locate found — the place name, or why nothing.
  final String? locateNote;
  final bool locating;

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
      this.onGraph,
      this.onValueHistory,
      this.onAddField,
      this.onLocate,
      this.locateNote,
      this.locating = false});

  bool _filled(FieldDef def) {
    final value = store.current(entityId, def.key);
    return value != null && value.isNotEmpty;
  }

  String _display(BuildContext context, FieldDef def) {
    // A value the sender kept private: the lock says it all, the value
    // line stays empty.
    if (store.isWithheld(entityId, def.key)) return '';
    final value = store.current(entityId, def.key);
    if (def.type == FieldType.cat && value != null) {
      return store.current(store.resolveEntity(value), Keys.name) ?? '?';
    }
    final display = fieldValueDisplay(context.t, def, value);
    // The birth date answers "how old" right there (#80).
    if (def.slug == 'birthdate' && value != null) {
      final age = ageDisplay(context.t, store, entityId);
      if (age != null) return '$display · $age';
    }
    return display;
  }

  @override
  Widget build(BuildContext context) {
    final rows = editing
        ? defs
        : [
            for (final def in defs)
              if (_filled(def) ||
                  store.isWithheld(entityId, def.key) ||
                  store.hasConflict(entityId, def.key))
                def
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
          final graph = onGraph != null &&
              !editing &&
              hasGraph(store, entityId, def);
          final history = onValueHistory != null &&
              !editing &&
              !graph &&
              hasValueHistory(store, entityId, def.key);
          // Read mode marks a private value with a lock at the end of
          // the row — your own and one a partner kept back look alike.
          // Edit mode shows no lock; the field editor's checkmark is
          // where Private is set.
          final lock = !editing &&
              (store.isFieldPrivate(entityId, def.key) ||
                  store.isWithheld(entityId, def.key));
          final action = conflict
              ? const Icon(Icons.warning_amber, color: Colors.amber)
              : mapJump
                  ? IconButton(
                      icon: const Icon(Icons.map_outlined),
                      tooltip: context.t.showOnMap,
                      onPressed: () => onShowMap(def, value),
                    )
                  : lookup
                      ? IconButton(
                          icon: const Icon(Icons.open_in_new),
                          tooltip: context.t.lookUpId,
                          onPressed: () => onLookup!(def, value),
                        )
                  : graph
                      ? IconButton(
                          icon: const Icon(Icons.show_chart),
                          tooltip: context.t.graphLabel,
                          onPressed: () => onGraph!(def),
                        )
                  : history
                      ? IconButton(
                          icon: const Icon(Icons.history),
                          tooltip: context.t.fieldHistoryTooltip,
                          onPressed: () => onValueHistory!(def),
                        )
                  : editing
                      ? const Icon(Icons.edit_outlined)
                      : null;
          final hasHold =
              editing || onReadLongPress != null;
          final tile = ListTile(
            title: Text(fieldDefName(context.t, def)),
            subtitle: Text(_display(context, def)),
            trailing: lock
                ? Row(mainAxisSize: MainAxisSize.min, children: [
                    ?action,
                    const Icon(Icons.lock, size: 20),
                  ])
                : action,
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
          final row = hasHold ? WithCatEar(child: tile) : tile;
          // The address row carries the locate button beneath it (#81).
          if (def.slug == 'address' && onLocate != null && value != null) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              row,
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(children: [
                  TextButton.icon(
                    icon: locating
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.add_location_alt_outlined),
                    label: Text(context.t.locateAddress),
                    onPressed: locating ? null : onLocate,
                  ),
                  if (locateNote != null)
                    Expanded(
                      child: Text(
                        locateNote!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ]),
              ),
            ]);
          }
          return row;
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
