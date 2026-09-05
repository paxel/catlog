import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../auto_backup.dart';
import '../help.dart';
import '../l10n.dart';
import '../pet_mode.dart';
import 'archive_screen.dart';
import 'catalogs_screen.dart' show askCatalogName;
import 'fields_screen.dart';
import 'go_back_screen.dart';
import 'moderation_screen.dart';

/// Everything that belongs to one catalog alone, on one page reached
/// from its row in the switcher: name, what it holds, its fields, its
/// authors and bans, the archive, going back, and deleting it.
///
/// The page works on the catalog it was opened for, whether or not
/// that is the one you are in — banning someone from five catalogs is
/// five visits, not five switches. A catalog that is not open gets its
/// own store for as long as the page is on screen.
class CatalogSettingsScreen extends StatefulWidget {
  final CatalogManager catalogs;
  final CatalogInfo catalog;

  /// The store of the catalog currently open, looked up live.
  final CatalogStore Function() activeStore;

  /// Called after a change the switcher or the home title should show:
  /// a rename, a deletion.
  final VoidCallback? onChanged;

  /// Where a deleted catalog's file is put. Injectable so a test can
  /// see what was written without a platform channel.
  final Future<String> Function(String path, String name)? saveTo;

  /// Removes a file from where the backups go — the old name after a
  /// rename. Injectable for the same reason.
  final Future<void> Function(String name)? removeSaved;

  const CatalogSettingsScreen({
    super.key,
    required this.catalogs,
    required this.catalog,
    required this.activeStore,
    this.onChanged,
    this.saveTo,
    this.removeSaved,
  });

  @override
  State<CatalogSettingsScreen> createState() => _CatalogSettingsScreenState();
}

class _CatalogSettingsScreenState extends State<CatalogSettingsScreen> {
  late final CatalogStore _store;

  /// The store was opened here and is closed here; the open catalog's
  /// store belongs to the app.
  late final bool _ownStore;

  /// The catalog is being written out before deletion; taps wait.
  bool _deleting = false;

  /// The catalog is gone and its store closed: nothing here may touch
  /// the database again while the page slides away.
  bool _closed = false;

  bool get _isActive => widget.catalog.id == widget.catalogs.active.id;

  CatalogInfo get _catalog =>
      widget.catalogs.byId(widget.catalog.id) ?? widget.catalog;

  @override
  void initState() {
    super.initState();
    _ownStore = !_isActive;
    _store = _ownStore
        ? widget.catalogs.openStore(widget.catalog)
        : widget.activeStore();
  }

  @override
  void dispose() {
    if (_ownStore && !_closed) _store.close();
    super.dispose();
  }

  void _changed() {
    setState(() {});
    widget.onChanged?.call();
  }

  Future<void> _rename() async {
    final catalog = _catalog;
    final name = await askCatalogName(
      context,
      context.t.rename,
      initial: catalog.name,
    );
    if (name == null || !mounted) return;
    try {
      final before = backupFileName(catalog.name);
      widget.catalogs.rename(catalog.id, name);
      final after = backupFileName(name);
      if (after != before) {
        // The file under the old name stops being anybody's backup, so
        // the catalog must earn a new one at the next pause rather than
        // sit there with none.
        _store.removeLocalSetting('lastBackupVector');
        await (widget.removeSaved ?? removeBesideBackups)(before);
      }
      _changed();
    } on DuplicateCatalogName {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.catalogNameTaken(name))));
    }
  }

  /// The choice is the catalog's; the app's words follow only the
  /// catalog you are in.
  void _setPets(bool pets) {
    if (_isActive) {
      setPetMode(_store, pets);
    } else {
      writePetMode(_store, pets);
    }
    _changed();
  }

  /// Deleting a catalog is the only action in the app that destroys a
  /// photo library, so it writes the catalog out first and asks for the
  /// name in full.
  Future<void> _delete() async {
    final t = context.t;
    final catalog = _catalog;
    if (_isActive) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.switchBeforeDeleting)));
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _DeleteCatalogDialog(catalog: catalog),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _deleting = true);
    try {
      final tmp = Directory.systemTemp.createTempSync('catlog-export');
      final name = backupFileName(catalog.name);
      final file = writeBundle(
        _store,
        '${tmp.path}/$name',
        includePrivate: true,
      );
      final save = widget.saveTo ?? saveBesideBackups;
      final where = await save(file, name);
      tmp.deleteSync(recursive: true);
      // The database closes before its folder goes: an open file keeps
      // the folder alive on some systems, and nothing on this page reads
      // the store from here on.
      if (_ownStore) _store.close();
      _closed = true;
      widget.catalogs.delete(catalog.id);
      widget.onChanged?.call();
      if (!mounted) return;
      // The page's catalog is gone; the switcher shows what is left and
      // where the file went.
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(t.catalogDeleted(catalog.name, where))),
      );
    } catch (e) {
      if (!mounted) return;
      // Nothing was deleted: the file has to exist before the catalog
      // stops existing.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.catalogExportFailed('$e'))));
    } finally {
      if (mounted && !_closed) setState(() => _deleting = false);
    }
  }

  Future<void> _push(Widget screen) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final catalog = _catalog;
    if (_closed) return Scaffold(appBar: AppBar(title: Text(catalog.name)));
    final usage = _store.storageUsage();
    final danger = Theme.of(context).colorScheme.error;
    return Scaffold(
      appBar: AppBar(title: Text(catalog.name), actions: [
        HelpButton(store: _store, screenId: 'catalogSettings'),
      ]),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.drive_file_rename_outline),
            title: Text(t.name),
            subtitle: Text(catalog.name),
            onTap: _deleting ? null : _rename,
          ),
          // What the catalog holds — its own choice, synced with it.
          ListTile(
            leading: const Icon(Icons.pets),
            title: Text(t.catalogHolds),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SegmentedButton<bool>(
                segments: [
                  ButtonSegment(value: false, label: Text(t.modeCats)),
                  ButtonSegment(value: true, label: Text(t.modePets)),
                ],
                selected: {isPetMode(_store)},
                onSelectionChanged: (s) => _setPets(s.first),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title: Text(t.fields),
            onTap: () => _push(FieldsScreen(store: _store)),
          ),
          ListTile(
            leading: const Icon(Icons.person_off_outlined),
            title: Text(t.moderationTitle),
            subtitle: Text(t.moderationSubtitle),
            onTap: () => _push(ModerationScreen(store: _store)),
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: Text(t.archiveTitle),
            subtitle: Text(
              t.storageLine(
                formatBytes(usage.dbBytes),
                formatBytes(usage.photoBytes),
                usage.photoCount,
              ),
            ),
            onTap: () => _push(ArchiveScreen(store: _store)),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(t.goBackTitle),
            onTap: () => _push(GoBackScreen(store: _store)),
          ),
          // The last catalog has nowhere to leave you; the one you are in
          // has its database open. Only the first hides the row — a
          // feature that simply vanishes teaches nothing, so the second
          // stays and says what to do instead.
          if (widget.catalogs.catalogs().length > 1)
            ListTile(
              leading: Icon(Icons.delete_outline, color: danger),
              title: Text(t.deleteCatalog, style: TextStyle(color: danger)),
              onTap: _deleting ? null : _delete,
            ),
        ],
      ),
    );
  }
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(t.deleteCatalogBody(widget.catalog.name)),
          const SizedBox(height: 12),
          TextField(
            controller: _typed,
            autofocus: true,
            decoration: InputDecoration(
              labelText: t.typeTheName(widget.catalog.name),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: matches ? () => Navigator.of(context).pop(true) : null,
          child: Text(t.delete),
        ),
      ],
    );
  }
}
