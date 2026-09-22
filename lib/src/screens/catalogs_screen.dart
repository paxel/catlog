import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../help.dart';
import '../move_to_catalog.dart';
import '../l10n.dart';
import '../notes.dart';
import '../layout.dart';
import 'archive_screen.dart' show formatBytes;
import 'catalog_settings_screen.dart';
import 'restore_screen.dart';

/// Managing the catalogs on this device: which one you are in, adding
/// one, what each costs in space, and the way into each one's settings.
class CatalogsScreen extends StatefulWidget {
  final CatalogManager catalogs;

  /// The catalog currently open, looked up live: tapping a catalog
  /// switches without leaving this screen, so a captured store would
  /// be the closed one a moment later.
  final CatalogStore Function() storeOf;
  final void Function(CatalogInfo, {bool unwind}) onSwitch;

  /// Called whenever the list itself changed, so whoever shows the
  /// catalog's name can redraw it.
  final VoidCallback? onChanged;

  /// Where a deleted catalog's file is put. Injectable so a test can
  /// see what was written without a platform channel.
  final Future<String> Function(String path, String name)? saveTo;

  /// Removes a file from where the backups go — the old name after a
  /// rename. Injectable for the same reason.
  final Future<void> Function(String name)? removeSaved;

  const CatalogsScreen(
      {super.key,
      required this.catalogs,
      required this.storeOf,
      required this.onSwitch,
      this.onChanged,
      this.saveTo,
      this.removeSaved});

  @override
  State<CatalogsScreen> createState() => _CatalogsScreenState();
}

class _CatalogsScreenState extends State<CatalogsScreen> {
  CatalogStore get store => widget.storeOf();

  void _changed() {
    setState(() {});
    widget.onChanged?.call();
  }

  Future<void> _create() async {
    final name = await askCatalogName(context, context.t.newCatalog,
        taken: widget.catalogs.nameTaken);
    if (name == null || !mounted) return;
    try {
      final made = widget.catalogs.create(name);
      // The common reason for a new catalog is an existing clowder, so
      // the offer is here — and the same move stays available for ever
      // afterwards from a cat or a clowder.
      await _offerMoveInto(made);
      if (!mounted) return;
      widget.onSwitch(made, unwind: false);
      _changed();
      // A fresh catalog is set up in its settings: what it holds, its
      // fields — so the page opens right away. After a frame: the switch
      // reaches the live store lookup with the rebuild, not before.
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      await _openSettings(made);
    } on DuplicateCatalogName {
      // Checked in the dialog; a name taken meanwhile still lands here.
      if (mounted) noteFailed(context.t.catalogNameTaken(name));
    }
  }

  Future<void> _offerMoveInto(CatalogInfo made) async {
    final wants = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.moveIntoNewCatalog(made.name)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.t.cancel)),
          FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.t.moveToCatalog)),
        ],
      ),
    );
    if (wants != true || !mounted) return;
    final chosen = await pickWhatToMove(context, store);
    if (chosen == null || chosen.isEmpty || !mounted) return;
    final count =
        await moveInto(store, widget.catalogs, made, chosen);
    if (!mounted) return;
    noteDone(context.t.movedToCatalog(count, made.name));
  }

  /// The catalog's own page; the list redraws on return because a name
  /// may have changed or a catalog may be gone.
  Future<void> _openSettings(CatalogInfo catalog) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatalogSettingsScreen(
        catalogs: widget.catalogs,
        catalog: catalog,
        activeStore: widget.storeOf,
        onChanged: widget.onChanged,
        saveTo: widget.saveTo,
        removeSaved: widget.removeSaved,
      ),
    ));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final active = widget.catalogs.active;
    return Scaffold(
      appBar: roomyAppBar(context, title: Text(t.catalogsTitle), actions: [
        HelpButton(store: store, screenId: 'catalogs'),
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
              icon: const Icon(Icons.settings_outlined),
              tooltip: t.catalogSettings,
              onPressed: () => _openSettings(catalog),
            ),
            // Tap activates and stays — leaving is the back button's
            // job, so several catalogs can be handled in one visit.
            onTap: () {
              widget.onSwitch(catalog, unwind: false);
              _changed();
            },
          ),
        const Divider(height: 1),
        // Backups of an earlier install, or files kept anywhere else.
        ListTile(
          leading: const Icon(Icons.restore),
          title: Text(t.restoreBackupsMenu),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RestoreScreen(
              catalogs: widget.catalogs,
              skipWhenEmpty: false,
              onDone: (first) {
                Navigator.of(context).pop();
                if (first != null) widget.onSwitch(first, unwind: false);
                _changed();
              },
            ),
          )),
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
/// A name [taken] already is refused under the field, and the dialog
/// stays until a free one is typed.
Future<String?> askCatalogName(BuildContext context, String title,
    {String initial = '', bool Function(String name)? taken}) {
  final controller = TextEditingController(text: initial);
  String? error;
  return showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        void submit() {
          final value = controller.text.trim();
          if (value.isNotEmpty && taken != null && taken(value)) {
            setState(() => error = context.t.catalogNameTaken(value));
            return;
          }
          Navigator.of(context).pop(value);
        }

        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: context.t.catalogNameLabel,
              errorText: error,
            ),
            onChanged: (_) {
              if (error != null) setState(() => error = null);
            },
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.t.cancel)),
            FilledButton(onPressed: submit, child: Text(context.t.save)),
          ],
        );
      },
    ),
  ).then((value) => value == null || value.isEmpty ? null : value);
}

/// The switcher behind the home screen's title, dropped down from it:
/// the catalogs, and the way into managing them.
Future<void> showCatalogSwitcher(
  BuildContext context, {
  required Offset at,
  required CatalogManager catalogs,
  required CatalogStore Function() storeOf,
  required void Function(CatalogInfo, {bool unwind}) onSwitch,
  VoidCallback? onChanged,
}) async {
  final t = context.t;
  final active = catalogs.active;
  final all = catalogs.catalogs();
  final picked = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(at.dx, at.dy, at.dx, at.dy),
    items: [
      for (final catalog in all)
        PopupMenuItem(
          value: catalog.id,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(catalog.id == active.id
                ? Icons.folder_open
                : Icons.folder_outlined),
            selected: catalog.id == active.id,
            title: Text(catalog.name),
          ),
        ),
      const PopupMenuDivider(),
      PopupMenuItem(
        value: 'manage',
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.settings_outlined),
          title: Text(t.manageCatalogs),
        ),
      ),
    ],
  );
  if (picked == null || !context.mounted) return;
  if (picked == 'manage') {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatalogsScreen(
        catalogs: catalogs,
        storeOf: storeOf,
        onSwitch: onSwitch,
        onChanged: onChanged,
      ),
    ));
    // Going back in time, deleting, renaming — the pages behind the
    // manage screen change the world; the home must redraw it when the
    // keeper returns, not keep the old picture.
    onChanged?.call();
    return;
  }
  final catalog = all.where((c) => c.id == picked).firstOrNull;
  if (catalog == null) return;
  onSwitch(catalog);
  onChanged?.call();
}
