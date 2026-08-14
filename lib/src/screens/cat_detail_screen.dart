import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../image_import.dart';

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

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final images = store.images(id);
    final profile = store.profileImage(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Rename',
              onPressed: _rename),
        ],
      ),
      body: GridView.builder(
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
