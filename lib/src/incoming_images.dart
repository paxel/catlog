import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'hidden.dart';
import 'image_import.dart';
import 'l10n.dart';
import 'name_proposals.dart';
import 'screens/cat_detail_screen.dart';
import 'widgets/cat_avatar.dart';

/// Photos shared INTO the app from anywhere (Immich, Signal, a browser):
/// the user picks which cat they belong to — or a new stray — and the
/// photos join through the ordinary compression path.
Future<void> handleSharedImages(GlobalKey<NavigatorState> navigator,
    CatalogStore store, List<String> paths,
    {Future<String?> Function(BuildContext, CatalogStore)?
        chooseTarget}) async {
  // The first frame may not be up yet on a cold start — poll like the
  // .catsync import does.
  BuildContext? context;
  for (var i = 0; i < 40 && context == null; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    context = navigator.currentContext;
  }
  if (context == null || !context.mounted) return;

  final bytesList = <Uint8List>[];
  for (final path in paths) {
    try {
      bytesList.add(await File(path).readAsBytes());
    } catch (_) {
      // One unreadable share must not sink the rest.
    }
  }
  if (bytesList.isEmpty || !context.mounted) return;

  final catId =
      await (chooseTarget ?? _chooseCat)(context, store);
  if (catId == null || !context.mounted) return;

  var added = 0;
  for (final bytes in bytesList) {
    try {
      await addCompressedImage(store, catId, bytes);
      added++;
    } catch (_) {
      // Not a decodable image — skip, count only real photos.
    }
  }
  if (!context.mounted) return;
  if (added == 0) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(context.t.notACatlogFile)));
    return;
  }
  final name = store.current(catId, Keys.name) ?? context.t.unnamed;
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
      content: Text(context.t.photosAddedTo('$added', name))));
  // Fire and forget — the handler must not block until the page pops.
  unawaited(navigator.currentState?.push(MaterialPageRoute(
    builder: (_) => CatDetailScreen(store: store, catId: catId),
  )));
}

/// The target chooser: every cat with its face, plus "new stray".
Future<String?> _chooseCat(
    BuildContext context, CatalogStore store) async {
  const newStrayMarker = r'$new';
  final cats = store.visibleCats()
    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  final picked = await showModalBottomSheet<String>(
    context: context,
    builder: (context) => SafeArea(
      child: ListView(shrinkWrap: true, children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(context.t.addPhotosTo,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: Text(context.t.newStray),
          onTap: () => Navigator.of(context).pop(newStrayMarker),
        ),
        for (final cat in cats)
          ListTile(
            leading: CatAvatar(store: store, catId: cat.id, size: 40),
            title: Text(cat.name),
            onTap: () => Navigator.of(context).pop(cat.id),
          ),
      ]),
    ),
  );
  if (picked == null) return null;
  if (picked != newStrayMarker) return picked;
  if (!context.mounted) return null;
  final locale = Localizations.localeOf(context);
  final fallback = context.t.newStray;
  final name = await proposeCatName(store, locale) ?? fallback;
  return store.createCat(name);
}
