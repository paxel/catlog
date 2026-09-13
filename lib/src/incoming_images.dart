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
import 'video_frames_io.dart';
import 'widgets/cat_avatar.dart';

/// Photos and videos shared INTO the app from anywhere (Immich, Signal,
/// a browser): the user picks which cat they belong to — or a new
/// stray, or a new cat in a home — and the photos join through the
/// ordinary compression path; a video (a path ending in `.video`) goes
/// through the frame picker first.
Future<void> handleSharedImages(GlobalKey<NavigatorState> navigator,
    CatalogStore store, List<String> paths,
    {Future<String?> Function(BuildContext, CatalogStore)? chooseTarget,
    Future<List<Uint8List>?> Function(BuildContext, String)?
        extractFrames}) async {
  // The first frame may not be up yet on a cold start — poll like the
  // .catsync import does.
  BuildContext? context;
  for (var i = 0; i < 40 && context == null; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    context = navigator.currentContext;
  }
  if (context == null || !context.mounted) return;

  if (paths.isEmpty) return;
  final catId =
      await (chooseTarget ?? chooseIncomingTarget)(context, store);
  if (catId == null || !context.mounted) return;

  var added = 0;
  // One photo in memory at a time: thirty shared camera files read up
  // front were 150 MB before the first one was even compressed.
  for (final path in paths) {
    try {
      if (path.endsWith('.video')) {
        if (!context.mounted) return;
        final frames =
            await (extractFrames ?? framesFromVideoFile)(context, path);
        if (frames != null) added += await addFrames(store, catId, frames);
        continue;
      }
      final bytes = await File(path).readAsBytes();
      if (await addCompressedImage(store, catId, bytes) != null) added++;
    } catch (_) {
      // Unreadable or not a photo — skip, count only real photos; one
      // bad share must not sink the rest.
    }
  }
  if (!context.mounted || !store.isOpen) return;
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

/// The target chooser: every cat with its face, plus "new stray" and
/// "new cat in…", which asks for the home first — one of the list, or
/// a new one by name.
Future<String?> chooseIncomingTarget(
    BuildContext context, CatalogStore store) async {
  const newStrayMarker = r'$new';
  const newInHomeMarker = r'$newInHome';
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
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: Text(context.t.newCatIn),
          onTap: () => Navigator.of(context).pop(newInHomeMarker),
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
  if (picked != newStrayMarker && picked != newInHomeMarker) return picked;
  if (!context.mounted) return null;
  String? home;
  if (picked == newInHomeMarker) {
    home = await _chooseHome(context, store);
    if (home == null || !context.mounted) return null;
  }
  final locale = Localizations.localeOf(context);
  final fallback = context.t.newStray;
  final name = await proposeCatName(store, locale) ?? fallback;
  return store.createCat(name, clowderId: home);
}

/// The home a new cat goes into: one of the list, or a new one typed.
Future<String?> _chooseHome(BuildContext context, CatalogStore store) async {
  const newMarker = r'$newHome';
  final homes = store.clowders()
    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  final picked = await showModalBottomSheet<String>(
    context: context,
    builder: (context) => SafeArea(
      child: ListView(shrinkWrap: true, children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(context.t.newCatIn,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        ListTile(
          leading: const Icon(Icons.add_home_outlined),
          title: Text(context.t.newClowder),
          onTap: () => Navigator.of(context).pop(newMarker),
        ),
        for (final home in homes)
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text(home.name),
            onTap: () => Navigator.of(context).pop(home.id),
          ),
      ]),
    ),
  );
  if (picked == null) return null;
  if (picked != newMarker) return picked;
  if (!context.mounted) return null;
  final name = await showDialog<String>(
    context: context,
    builder: (context) => const _NameDialog(),
  );
  if (name == null || name.isEmpty) return null;
  return store.createClowder(name);
}

/// Asks for a new home's name; owns its controller for the dialog's
/// whole life, closing animation included.
class _NameDialog extends StatefulWidget {
  const _NameDialog();

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(context.t.newClowder),
        content: TextField(
          controller: _controller,
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
            onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
            child: Text(context.t.save),
          ),
        ],
      );
}
