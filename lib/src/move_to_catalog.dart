import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// The catalogs this device holds, once the app has opened them. Null in
/// tests and anywhere a store is built directly.
CatalogManager? catalogManager;

/// What a screen needs to show and change the catalog it is in: the
/// manager, the way to switch, and the way to say the list changed.
/// These three always travel together, so they travel as one.
class CatalogSwitching {
  final CatalogManager catalogs;
  final void Function(CatalogInfo) onSwitch;
  final VoidCallback? onChanged;

  const CatalogSwitching(
      {required this.catalogs, required this.onSwitch, this.onChanged});

  /// The catalog currently open.
  CatalogInfo get active => catalogs.active;
}

/// True when there is somewhere else to move things to.
bool get canMoveBetweenCatalogs =>
    (catalogManager?.catalogs().length ?? 0) > 1;

/// Asks which cats and clowders should move. Returns the chosen ids, or
/// null when the picker was dismissed.
Future<Set<String>?> pickWhatToMove(BuildContext context, CatalogStore from,
    {bool clowders = true, bool strays = true}) {
  final options = <({String id, String name, bool isClowder})>[
    if (clowders)
      for (final c in from.clowders())
        (id: c.id, name: c.name, isClowder: true),
    if (strays)
      for (final cat in from.cats(clowderId: null))
        (id: cat.id, name: cat.name, isClowder: false),
  ];
  if (options.isEmpty) return Future.value(null);
  final chosen = <String>{};
  return showDialog<Set<String>>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(context.t.chooseWhatToMove),
        content: SizedBox(
          width: 360,
          child: ListView(shrinkWrap: true, children: [
            for (final option in options)
              CheckboxListTile(
                value: chosen.contains(option.id),
                secondary: Icon(option.isClowder
                    ? Icons.home_outlined
                    : Icons.pets_outlined),
                title: Text(option.name),
                onChanged: (on) => setState(() {
                  if (on == true) {
                    chosen.add(option.id);
                  } else {
                    chosen.remove(option.id);
                  }
                }),
              ),
          ]),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.t.cancel)),
          FilledButton(
            onPressed: chosen.isEmpty
                ? null
                : () => Navigator.of(context).pop({...chosen}),
            child: Text(context.t.moveToCatalog),
          ),
        ],
      ),
    ),
  );
}

/// Moves [ids] into [into] without asking which catalog — used right
/// after creating one, where the destination is already decided.
Future<int> moveInto(CatalogStore from, CatalogManager catalogs,
    CatalogInfo into, Set<String> ids) async {
  final to = catalogs.openStore(into);
  try {
    return transferEntities(from, to, ids).moved.length;
  } finally {
    to.close();
  }
}

/// Offers the other catalogs and moves [ids] into the chosen one.
///
/// Returns the catalog moved into, or null when nothing was moved. What
/// moves is gone from here afterwards, so callers on a detail page pop
/// back to the list.
Future<CatalogInfo?> moveToAnotherCatalog(
    BuildContext context, CatalogStore from, Set<String> ids,
    {CatalogManager? manager}) async {
  final catalogs = manager ?? catalogManager;
  if (catalogs == null || ids.isEmpty) return null;
  final here = catalogs.active.id;
  final others = catalogs.catalogs().where((c) => c.id != here).toList();
  if (others.isEmpty) return null;

  final chosen = await showDialog<CatalogInfo>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(context.t.moveToCatalog),
      children: [
        for (final catalog in others)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(catalog),
            child: Row(children: [
              const Icon(Icons.folder_outlined),
              const SizedBox(width: 12),
              Expanded(child: Text(catalog.name)),
            ]),
          ),
      ],
    ),
  );
  if (chosen == null) return null;

  final to = catalogs.openStore(chosen);
  try {
    final result = transferEntities(from, to, ids);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(context.t
              .movedToCatalog(result.moved.length, chosen.name))));
    }
    return chosen;
  } finally {
    to.close();
  }
}
