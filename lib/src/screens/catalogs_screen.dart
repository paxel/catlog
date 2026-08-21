import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../help.dart';
import '../l10n.dart';
import '../layout.dart';
import 'archive_screen.dart' show formatBytes;

/// Managing the catalogs on this device: which one you are in, adding
/// one, renaming one, and what each costs in space.
class CatalogsScreen extends StatefulWidget {
  final CatalogManager catalogs;

  /// The catalog currently open — the help button reads its settings.
  final CatalogStore store;
  final void Function(CatalogInfo) onSwitch;

  /// Called whenever the list itself changed, so whoever shows the
  /// catalog's name can redraw it.
  final VoidCallback? onChanged;

  const CatalogsScreen(
      {super.key,
      required this.catalogs,
      required this.store,
      required this.onSwitch,
      this.onChanged});

  @override
  State<CatalogsScreen> createState() => _CatalogsScreenState();
}

class _CatalogsScreenState extends State<CatalogsScreen> {
  void _changed() {
    setState(() {});
    widget.onChanged?.call();
  }

  Future<void> _create() async {
    final name = await askCatalogName(context, context.t.newCatalog);
    if (name == null || !mounted) return;
    try {
      final made = widget.catalogs.create(name);
      widget.onSwitch(made);
      _changed();
    } on DuplicateCatalogName {
      if (mounted) _sayTaken(name);
    }
  }

  Future<void> _rename(CatalogInfo catalog) async {
    final name = await askCatalogName(context, context.t.rename,
        initial: catalog.name);
    if (name == null || !mounted) return;
    try {
      widget.catalogs.rename(catalog.id, name);
      _changed();
    } on DuplicateCatalogName {
      if (mounted) _sayTaken(name);
    }
  }

  void _sayTaken(String name) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.t.catalogNameTaken(name))));

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final active = widget.catalogs.active;
    return Scaffold(
      appBar: roomyAppBar(context, title: Text(t.catalogsTitle), actions: [
        HelpButton(store: widget.store, screenId: 'catalogs'),
      ]),
      body: ListView(children: [
        for (final catalog in widget.catalogs.catalogs())
          ListTile(
            leading: Icon(catalog.id == active.id
                ? Icons.folder_open
                : Icons.folder_outlined),
            selected: catalog.id == active.id,
            title: Text(catalog.name),
            subtitle: Text(formatBytes(catalog.sizeInBytes)),
            trailing: IconButton(
              icon: const Icon(Icons.drive_file_rename_outline),
              tooltip: t.rename,
              onPressed: () => _rename(catalog),
            ),
            onTap: () {
              widget.onSwitch(catalog);
              _changed();
            },
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _create,
        tooltip: t.newCatalog,
        child: const Icon(Icons.create_new_folder_outlined),
      ),
    );
  }
}

/// Asks for a catalog name. Returns null when the dialog is dismissed.
Future<String?> askCatalogName(BuildContext context, String title,
    {String initial = ''}) {
  final controller = TextEditingController(text: initial);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration:
            InputDecoration(labelText: context.t.catalogNameLabel),
        onSubmitted: (value) => Navigator.of(context).pop(value.trim()),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.t.cancel)),
        FilledButton(
          onPressed: () =>
              Navigator.of(context).pop(controller.text.trim()),
          child: Text(context.t.save),
        ),
      ],
    ),
  ).then((value) => value == null || value.isEmpty ? null : value);
}

/// The switcher behind the home screen's title: the catalogs, and the
/// way into managing them.
Future<void> showCatalogSwitcher(
  BuildContext context, {
  required CatalogManager catalogs,
  required CatalogStore store,
  required void Function(CatalogInfo) onSwitch,
  VoidCallback? onChanged,
}) async {
  final t = context.t;
  final active = catalogs.active;
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheet) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (final catalog in catalogs.catalogs())
          ListTile(
            leading: Icon(catalog.id == active.id
                ? Icons.folder_open
                : Icons.folder_outlined),
            selected: catalog.id == active.id,
            title: Text(catalog.name),
            onTap: () {
              Navigator.of(sheet).pop();
              onSwitch(catalog);
              onChanged?.call();
            },
          ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: Text(t.manageCatalogs),
          onTap: () {
            Navigator.of(sheet).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CatalogsScreen(
                catalogs: catalogs,
                store: store,
                onSwitch: onSwitch,
                onChanged: onChanged,
              ),
            ));
          },
        ),
      ]),
    ),
  );
}
