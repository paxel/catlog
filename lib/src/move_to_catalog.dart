import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// The catalogs this device holds, once the app has opened them. Null in
/// tests and anywhere a store is built directly.
CatalogManager? catalogManager;

/// True when there is somewhere else to move things to.
bool get canMoveBetweenCatalogs =>
    (catalogManager?.catalogs().length ?? 0) > 1;

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
    final result = moveEntities(from, to, ids);
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
