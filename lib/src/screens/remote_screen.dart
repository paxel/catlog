import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../import_summary.dart';
import '../l10n.dart';
import '../sync/saf_folder.dart';

/// "Remote": sync through a shared folder (Nextcloud, Syncthing, a USB
/// stick) for devices that never meet.
class RemoteScreen extends StatefulWidget {
  final CatalogStore store;

  const RemoteScreen({super.key, required this.store});

  @override
  State<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends State<RemoteScreen> {
  String? _lastResult;
  bool _includePrivate = false;

  /// What the folder row shows: a path as it is, a granted tree by
  /// its folder name.
  String? _folderLabel;

  @override
  void initState() {
    super.initState();
    _describeFolder();
  }

  Future<void> _describeFolder() async {
    final setting = widget.store.localSetting('syncFolder');
    if (setting == null) return;
    final label = SafSyncFolder.isTree(setting)
        ? await SafSyncFolder.displayName(setting)
        : setting;
    if (mounted) setState(() => _folderLabel = label);
  }

  /// This catalog's subfolder inside the shared folder: one folder
  /// carries every catalog, each under its own name.
  String get _catalogDir =>
      catalogFolderName(widget.store.localSetting(catalogNameKey));

  /// A folder another catalog already uses, offered with one tap.
  String? get _lastFolder => widget.store.localSetting('syncFolderLast');

  void _use(String folder) {
    widget.store.setLocalSetting('syncFolder', folder);
    widget.store.setLocalSetting('syncFolderLast', folder);
    _folderLabel = null;
    _describeFolder();
    setState(() {});
  }

  /// Android: the system picker grants a tree, kept as its URI; a path
  /// picked by older versions keeps working where Android allows it.
  Future<void> _choose() async {
    final chosen = Platform.isAndroid
        ? await SafSyncFolder.pick()
        : await FilePicker.platform.getDirectoryPath();
    if (chosen != null && mounted && widget.store.isOpen) _use(chosen);
  }

  Future<void> _sync() async {
    final t = context.t;
    final folder = widget.store.localSetting('syncFolder')!;
    try {
      final before = widget.store.currentSeq();
      final result = await folderSyncIn(
          widget.store,
          SafSyncFolder.isTree(folder)
              ? SafSyncFolder(folder)
              : LocalSyncFolder(folder),
          includePrivate: _includePrivate,
          catalog: _catalogDir);
      final point = momentFor(widget.store,
          before: before,
          changed: result.applied.isNotEmpty,
          cause: MomentCause.sync,
          label: folder);
      if (mounted &&
          (result.applied.isNotEmpty || needsAttention(result.report))) {
        await showImportSummary(context, widget.store, result.applied,
            undo: point, report: result.report);
      }
      if (!mounted) return;
      setState(() => _lastResult = t.folderSynced('$result'));
    } on FileSystemException {
      setState(() => _lastResult = t.folderUnreachable);
    } catch (e) {
      setState(() => _lastResult = t.folderSyncFailed('$e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.syncChooserRemote)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.sharedFolderExplainer),
          const SizedBox(height: 12),
          SwitchListTile(
            value: _includePrivate,
            onChanged: (v) => setState(() => _includePrivate = v),
            secondary: Icon(
                _includePrivate ? Icons.lock_open : Icons.lock_outline),
            title: Text(t.includePrivate),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(height: 24),
          Row(children: [
            Expanded(
              child: Text(
                _folderLabel ??
                    widget.store.localSetting('syncFolder') ??
                    t.noFolderChosenYet,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: _choose,
              child: Text(t.choose),
            ),
          ]),
          // One folder for all catalogs: each keeps its own subfolder.
          if (widget.store.localSetting('syncFolder') != null)
            Text(t.folderCatalogHint(_catalogDir),
                style: Theme.of(context).textTheme.bodySmall),
          if (widget.store.localSetting('syncFolder') == null &&
              _lastFolder != null)
            TextButton(
              onPressed: () => _use(_lastFolder!),
              child: Text(t.useSameFolder),
            ),
          const SizedBox(height: 8),
          Text(t.folderHint, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: widget.store.localSetting('syncFolder') == null
                ? null
                : _sync,
            icon: const Icon(Icons.folder_copy_outlined),
            label: Text(t.syncFolderNow),
          ),
          if (_lastResult != null) ...[
            const SizedBox(height: 12),
            Text(_lastResult!),
          ],
        ],
      ),
    );
  }
}
