import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'hidden.dart';
import 'image_import.dart';
import 'l10n.dart';
import 'layout.dart';
import 'notes.dart';
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
    noteFailed(context.t.notACatlogFile);
    return;
  }
  final name = store.current(catId, Keys.name) ?? context.t.unnamed;
  noteDone(context.t.photosAddedTo('$added', name));
  // Fire and forget — the handler must not block until the page pops.
  unawaited(navigator.currentState?.push(MaterialPageRoute(
    builder: (_) => CatDetailScreen(store: store, catId: catId),
  )));
}

/// The target chooser, a page: every cat with its face, a new stray,
/// a new cat in any of the homes, or a new home typed right there.
Future<String?> chooseIncomingTarget(
    BuildContext context, CatalogStore store) async {
  final picked = await Navigator.of(context).push<_Target>(
    MaterialPageRoute(builder: (_) => _TargetScreen(store: store)),
  );
  if (picked == null || !context.mounted) return null;
  if (picked.catId case final id?) return id;
  var home = picked.homeId;
  if (picked.newHomeName case final name?) {
    home = store.createClowder(name);
  }
  final locale = Localizations.localeOf(context);
  final fallback = context.t.newStray;
  final name = await proposeCatName(store, locale) ?? fallback;
  return store.createCat(name, clowderId: home);
}

/// What the page picked: an existing cat, or a new cat — stray, in a
/// home, or in a home yet to be made.
class _Target {
  final String? catId;
  final String? homeId;
  final String? newHomeName;
  const _Target({this.catId, this.homeId, this.newHomeName});
}

class _TargetScreen extends StatefulWidget {
  final CatalogStore store;
  const _TargetScreen({required this.store});

  @override
  State<_TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<_TargetScreen> {
  final _newHome = TextEditingController();

  @override
  void dispose() {
    _newHome.dispose();
    super.dispose();
  }

  void _pick(_Target target) => Navigator.of(context).pop(target);

  void _newHomeSubmit() {
    final name = _newHome.text.trim();
    if (name.isEmpty) return;
    _pick(_Target(newHomeName: name));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final store = widget.store;
    final cats = store.visibleCats()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    final homes = store.clowders()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return Scaffold(
      appBar: roomyAppBar(context, title: Text(t.addPhotosTo)),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.add),
          title: Text(t.newStray),
          onTap: () => _pick(const _Target()),
        ),
        for (final cat in cats)
          ListTile(
            leading: CatAvatar(store: store, catId: cat.id, size: 40),
            title: Text(cat.name),
            onTap: () => _pick(_Target(catId: cat.id)),
          ),
        for (final home in homes)
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text(home.name),
            subtitle: Text(t.newCatHere),
            onTap: () => _pick(_Target(homeId: home.id)),
          ),
        // A new home, typed right here: no dialog behind a row.
        ListTile(
          leading: const Icon(Icons.add_home_outlined),
          title: TextField(
            controller: _newHome,
            decoration: InputDecoration(labelText: t.newClowder),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _newHomeSubmit(),
          ),
          trailing: TextButton(
            onPressed: _newHome.text.trim().isEmpty ? null : _newHomeSubmit,
            child: Text(t.save),
          ),
        ),
      ]),
    );
  }
}
