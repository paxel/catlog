import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../auto_backup.dart';
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

  /// Where a deleted catalog's file is put. Injectable so a test can
  /// see what was written without a platform channel.
  final Future<String> Function(String path, String name)? saveTo;

  const CatalogsScreen(
      {super.key,
      required this.catalogs,
      required this.store,
      required this.onSwitch,
      this.onChanged,
      this.saveTo});

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

  /// Deleting a catalog is the only action in the app that destroys a
  /// photo library, so it writes the catalog out first and asks for the
  /// name in full.
  Future<void> _delete(CatalogInfo catalog) async {
    final t = context.t;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _DeleteCatalogDialog(catalog: catalog),
    );
    if (confirmed != true || !mounted) return;
    try {
      final store = widget.catalogs.openStore(catalog);
      final tmp = Directory.systemTemp.createTempSync('catlog-export');
      final file = writeBundle(
          store, '${tmp.path}/${_fileName(catalog.name)}',
          includePrivate: true);
      store.close();
      final save = widget.saveTo ?? saveBesideBackups;
      final where = await save(file, _fileName(catalog.name));
      tmp.deleteSync(recursive: true);
      final wasActive = widget.catalogs.active.id == catalog.id;
      widget.catalogs.delete(catalog.id);
      if (wasActive) widget.onSwitch(widget.catalogs.active);
      _changed();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(t.catalogDeleted(catalog.name, where))));
    } catch (e) {
      if (!mounted) return;
      // Nothing was deleted: the file has to exist before the catalog
      // stops existing.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.catalogExportFailed('$e'))));
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
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                icon: const Icon(Icons.drive_file_rename_outline),
                tooltip: t.rename,
                onPressed: () => _rename(catalog),
              ),
              // The last catalog has nowhere to leave you.
              if (widget.catalogs.catalogs().length > 1)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: t.deleteCatalog,
                  onPressed: () => _delete(catalog),
                ),
            ]),
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

/// The file a catalog is written to before it is deleted.
String _fileName(String catalogName) {
  final safe = catalogName
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
  return 'catlog-${safe.isEmpty ? 'catalog' : safe}.catsync';
}

/// Deleting asks for the catalog's name in full: the export makes the
/// deletion recoverable, not painless, and every catalog is one tap
/// away from every other in the switcher.
class _DeleteCatalogDialog extends StatefulWidget {
  final CatalogInfo catalog;

  const _DeleteCatalogDialog({required this.catalog});

  @override
  State<_DeleteCatalogDialog> createState() => _DeleteCatalogDialogState();
}

class _DeleteCatalogDialogState extends State<_DeleteCatalogDialog> {
  final _typed = TextEditingController();

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final matches = _typed.text.trim() == widget.catalog.name;
    return AlertDialog(
      title: Text(t.deleteCatalog),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(t.deleteCatalogBody(widget.catalog.name)),
        const SizedBox(height: 12),
        TextField(
          controller: _typed,
          autofocus: true,
          decoration: InputDecoration(
              labelText: t.typeTheName(widget.catalog.name)),
          onChanged: (_) => setState(() {}),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel)),
        FilledButton(
          onPressed: matches ? () => Navigator.of(context).pop(true) : null,
          child: Text(t.delete),
        ),
      ],
    );
  }
}
