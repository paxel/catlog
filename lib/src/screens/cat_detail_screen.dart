import 'dart:isolate';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../conflict_dialog.dart';
import '../field_editing.dart';
import '../field_labels.dart';
import '../image_import.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../name_date_dialog.dart';
import '../stray_cam.dart';
import 'card_screen.dart';
import 'photo_edit_screen.dart';
import 'timeline_screen.dart';

/// One Cat: membership, Fields, photo gallery, timeline access.
class CatDetailScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  /// Opens the photo picker right away — used when a Cat was just created,
  /// so name + photo happen in one flow.
  final bool promptPhoto;

  const CatDetailScreen(
      {super.key,
      required this.store,
      required this.catId,
      this.promptPhoto = false});

  @override
  State<CatDetailScreen> createState() => _CatDetailScreenState();
}

// Sentinel for "no clowder" in the move dialog, where null means canceled.
const _strayMarker = '\$stray';

class _CatDetailScreenState extends State<CatDetailScreen> {
  CatalogStore get store => widget.store;
  String get id => widget.catId;

  @override
  void initState() {
    super.initState();
    if (widget.promptPhoto) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _addPhoto());
    }
  }

  Future<void> _rename() async {
    final current = store.current(id, Keys.name) ?? '';
    final name = await _askForText(context, context.t.renameCat, current);
    if (name == null || name.isEmpty || name == current) return;
    store.append(id, Keys.name, name);
    setState(() {});
  }

  Future<void> _addPhoto() async {
    final hash = await pickAndAddImage(context, store, id);
    if (hash != null) setState(() {});
  }

  Future<void> _move() async {
    final currentClowder = store.current(id, Keys.clowder);
    final clowders = store.clowders();
    final target = await showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.t.moveTo),
        children: [
          for (final c in clowders)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(c.id),
              child: Row(children: [
                if (c.id == currentClowder)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.check, size: 18),
                  ),
                Expanded(child: Text(c.name)),
              ]),
            ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(_strayMarker),
            child: Row(children: [
              const Icon(Icons.explore, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(context.t.noClowderStrayOption)),
            ]),
          ),
        ],
      ),
    );
    if (target == null) return; // dialog dismissed
    final destination = target == _strayMarker ? null : target;
    if (destination == currentClowder) return;
    if (!mounted) return;
    // Historic moves happen: the date is askable, defaulting to today.
    final asOf = await askAsOfDate(context, context.t.moveTo);
    if (asOf == null) return;
    store.moveCat(id, destination, date: asOf);
    setState(() {});
  }

  Future<void> _editField(FieldDef def) async {
    final edit =
        await editFieldValue(context, def, store.current(id, def.key));
    if (edit == null) return;
    store.append(id, def.key, edit.value, date: edit.date);
    setState(() {});
  }

  void _openTimeline({String? field}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) =>
          TimelineScreen(store: store, entityId: id, field: field),
    ));
  }

  void _imageMenu(String hash) {
    final isProfile = store.profileImage(id) == hash;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.star),
            title: Text(isProfile
                ? context.t.thisIsProfileImage
                : context.t.setAsProfileImage),
            enabled: !isProfile,
            onTap: () {
              store.setProfileImage(id, hash);
              Navigator.of(context).pop();
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(Icons.crop),
            title: Text(context.t.cropPhoto),
            onTap: () {
              Navigator.of(context).pop();
              _editPhoto(hash, PhotoEditMode.crop);
            },
          ),
          ListTile(
            leading: const Icon(Icons.circle_outlined),
            title: Text(context.t.markPhoto),
            onTap: () {
              Navigator.of(context).pop();
              _editPhoto(hash, PhotoEditMode.mark);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: Text(context.t.deletePhoto),
            onTap: () async {
              Navigator.of(context).pop();
              final sure = await _confirm(context,
                  context.t.deletePhotoTitle, context.t.deletePhotoBody);
              if (sure && mounted) {
                store.deleteImage(id, hash);
                setState(() {});
              }
            },
          ),
        ]),
      ),
    );
  }

  /// Crop or mark an existing photo: the edited copy joins as a NEW
  /// photo; the original stays (one litter photo can serve many cats).
  Future<void> _editPhoto(String hash, PhotoEditMode mode) async {
    final bytes = store.imageBytes(hash);
    if (bytes == null) return;
    final edited = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => PhotoEditScreen(bytes: bytes, mode: mode),
      ),
    );
    if (edited == null) return;
    final compressed =
        await Isolate.run(() => CatalogStore.compressImage(edited));
    store.addImage(id, compressed);
    setState(() {});
  }

  Future<void> _deleteCat() async {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final sure = await _confirm(
        context, context.t.deleteQuestion(name), context.t.deleteCatBody);
    if (!sure || !mounted) return;
    store.deleteCat(id);
    Navigator.of(context).pop();
  }

  Future<void> _seenHere() async {
    final ok = await seenHereNow(store, id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? context.t.sightingRecorded
          : context.t.noLocationAvailable),
    ));
    setState(() {});
  }

  Future<void> _mergeCat() async {
    final merged = await showMergeDialog(
      context: context,
      store: store,
      loserId: id,
      kindLabel: context.t.kindCat,
      candidates: store.cats(),
      merge: store.mergeCat,
    );
    if (merged && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final images = store.images(id);
    final profile = store.profileImage(id);
    final defs = store.visibleFieldDefs(scope: FieldScope.cat);
    final clowderId = store.current(id, Keys.clowder);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              icon: const Icon(Icons.badge_outlined),
              tooltip: context.t.card,
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CardScreen(store: store, catId: id),
                  ))),
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: context.t.rename,
              onPressed: _rename),
          IconButton(
              icon: const Icon(Icons.history),
              tooltip: context.t.timeline,
              onPressed: _openTimeline),
          if (store.isPrivate(id))
            Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'delete') _deleteCat();
              if (v == 'merge') _mergeCat();
              if (v == 'seen') _seenHere();
              if (v == 'private') {
                setState(() =>
                    store.setPrivate(id, !store.isPrivate(id)));
              }
              if (v == 'hide') {
                final wasHidden = store.isHidden(id);
                store.setHidden(id, !wasHidden);
                if (wasHidden || showHidden.value) {
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 'seen', child: Text(context.t.seenHereNow)),
              PopupMenuItem(
                  value: 'private',
                  child: Text(store.isPrivate(id)
                      ? context.t.unmarkPrivate
                      : context.t.markPrivate)),
              PopupMenuItem(
                  value: 'hide',
                  child: Text(store.isHidden(id)
                      ? context.t.unhideLabel
                      : context.t.hideLabel)),
              PopupMenuItem(
                  value: 'merge', child: Text(context.t.mergeInto)),
              PopupMenuItem(
                  value: 'delete', child: Text(context.t.deleteCat)),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(clowderId == null ? Icons.explore : Icons.home),
            title: Text(context.t.clowderLabel),
            subtitle: Text(clowderId == null
                ? context.t.strayNoClowder
                : store.current(clowderId, Keys.name) ?? context.t.unnamed),
            trailing: const Icon(Icons.drive_file_move_outline),
            onTap: _move,
            onLongPress: () => _openTimeline(field: Keys.clowder),
          ),
          const Divider(),
          for (final def in defs)
            ListTile(
              title: Text(fieldDefName(context.t, def)),
              subtitle: Text(fieldValueDisplay(
                  context.t, def, store.current(id, def.key))),
              trailing: store.hasConflict(id, def.key)
                  ? const Icon(Icons.warning_amber, color: Colors.amber)
                  : const Icon(Icons.edit_outlined),
              onTap: store.hasConflict(id, def.key)
                  ? () async {
                      await showConflictDialog(context, store, id, def.key);
                      setState(() {});
                    }
                  : () => _editField(def),
              onLongPress: () => _openTimeline(field: def.key),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(context.t.photos,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 160,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, i) {
              final hash = images[i];
              final bytes = store.imageBytes(hash);
              return GestureDetector(
                onTap: () => _imageMenu(hash),
                child: Stack(fit: StackFit.expand, children: [
                  if (bytes != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(bytes, fit: BoxFit.cover),
                    ),
                  if (hash == profile)
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.star, color: Colors.amber),
                      ),
                    ),
                ]),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPhoto,
        tooltip: context.t.addPhoto,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

Future<bool> _confirm(
    BuildContext context, String title, String message) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.t.delete),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<String?> _askForText(
    BuildContext context, String title, String? initial) {
  final controller = TextEditingController(text: initial ?? '');
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(context.t.save),
        ),
      ],
    ),
  );
}
