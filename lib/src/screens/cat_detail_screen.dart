import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../conflict_dialog.dart';
import '../field_editing.dart';
import '../image_import.dart';
import '../merge_dialogs.dart';
import '../stray_cam.dart';
import 'card_screen.dart';
import 'timeline_screen.dart';

/// One Cat: name and photo gallery. Fields and timeline arrive with
/// later tickets.
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
    final name = await _askForText(context, 'Rename cat', current);
    if (name == null || name.isEmpty || name == current) return;
    store.append(id, Keys.name, name);
    setState(() {});
  }

  Future<void> _addPhoto() async {
    final hash = await pickAndAddImage(context, store, id);
    if (hash != null) setState(() {});
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
                ? 'This is the profile image'
                : 'Set as profile image'),
            enabled: !isProfile,
            onTap: () {
              store.setProfileImage(id, hash);
              Navigator.of(context).pop();
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete photo'),
            onTap: () async {
              Navigator.of(context).pop();
              final sure = await _confirm(
                  context,
                  'Delete photo?',
                  'The photo data is removed for good — this cannot '
                      'be undone.');
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

  Future<void> _seenHere() async {
    final ok = await seenHereNow(store, id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? 'Sighting recorded at your position.'
          : 'No location available — long-press the map instead.'),
    ));
    setState(() {});
  }

  Future<void> _mergeCat() async {
    final merged = await showMergeDialog(
      context: context,
      store: store,
      loserId: id,
      kindLabel: 'cat',
      candidates: store.cats(),
      merge: store.mergeCat,
    );
    if (merged && mounted) Navigator.of(context).pop();
  }

  Future<void> _deleteCat() async {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final sure = await _confirm(
        context,
        'Delete $name?',
        'The cat disappears from all lists. Its photos are removed '
            'for good.');
    if (!sure || !mounted) return;
    store.deleteCat(id);
    Navigator.of(context).pop();
  }

  Future<void> _move() async {
    final currentClowder = store.current(id, Keys.clowder);
    final clowders = store.clowders();
    final target = await showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Move to'),
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
            child: const Row(children: [
              Icon(Icons.explore, size: 18),
              SizedBox(width: 8),
              Expanded(child: Text('No clowder — stray / ran away')),
            ]),
          ),
        ],
      ),
    );
    if (target == null) return; // dialog dismissed
    final destination = target == _strayMarker ? null : target;
    if (destination == currentClowder) return;
    store.moveCat(id, destination);
    setState(() {});
  }

  Future<void> _editField(FieldDef def) async {
    final edit = await editFieldValue(context, def, store.current(id, def.key));
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

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final images = store.images(id);
    final profile = store.profileImage(id);
    final defs = store.fieldDefs(scope: FieldScope.cat);
    final clowderId = store.current(id, Keys.clowder);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              icon: const Icon(Icons.badge_outlined),
              tooltip: 'Card',
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CardScreen(store: store, catId: id),
              ))),
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Rename',
              onPressed: _rename),
          IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'Timeline',
              onPressed: _openTimeline),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'delete') _deleteCat();
              if (v == 'merge') _mergeCat();
              if (v == 'seen') _seenHere();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'seen', child: Text('Seen here now')),
              PopupMenuItem(value: 'merge', child: Text('Merge into…')),
              PopupMenuItem(value: 'delete', child: Text('Delete cat')),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(clowderId == null ? Icons.explore : Icons.home),
            title: const Text('Clowder'),
            subtitle: Text(clowderId == null
                ? 'Stray — no clowder'
                : store.current(clowderId, Keys.name) ?? '(unnamed)'),
            trailing: const Icon(Icons.drive_file_move_outline),
            onTap: _move,
            onLongPress: () => _openTimeline(field: Keys.clowder),
          ),
          const Divider(),
          for (final def in defs)
            ListTile(
              title: Text(def.name),
              subtitle: Text(store.current(id, def.key) ?? '—'),
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
            child: Text('Photos',
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
        tooltip: 'Add photo',
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
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
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
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
