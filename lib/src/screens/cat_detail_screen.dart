import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_editing.dart';
import '../image_import.dart';
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
        ]),
      ),
    );
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
              trailing: const Icon(Icons.edit_outlined),
              onTap: () => _editField(def),
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
