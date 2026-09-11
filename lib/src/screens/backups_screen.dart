import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auto_backup.dart';
import '../l10n.dart';
import '../sync/saf_folder.dart';

/// Where the catalogs are kept safe, in the reader's own terms: what the
/// phone backs up by itself (Google's app backup on Android, iCloud
/// Backup on iPhone), where the full `.catsync` copies land, when the
/// last one was written, the last failure, and a button to write one
/// now. Restoring stays in Manage catalogs.
class BackupsScreen extends StatefulWidget {
  final CatalogStore store;

  /// Where a copy goes; the platform's place by default. Tests inject.
  final Future<String> Function(String path, String name)? save;

  /// The platform the page speaks for; the running one by default.
  final String? platform;

  /// Opens the folder picker for the copies; the system one by default.
  final Future<String?> Function()? pickFolder;

  /// A folder's name for the row; the system's answer by default.
  final Future<String> Function(String tree)? folderName;

  const BackupsScreen({
    super.key,
    required this.store,
    this.save,
    this.platform,
    this.pickFolder,
    this.folderName,
  });

  @override
  State<BackupsScreen> createState() => _BackupsScreenState();
}

class _BackupsScreenState extends State<BackupsScreen> {
  CatalogStore get store => widget.store;
  bool _busy = false;
  DateTime? _restored;
  String? _folderLabel;

  String get _platform =>
      widget.platform ??
      (Platform.isAndroid
          ? 'android'
          : Platform.isIOS
          ? 'ios'
          : 'desktop');

  @override
  void initState() {
    super.initState();
    restoredFromBackupAt().then((at) {
      if (mounted) setState(() => _restored = at);
    });
    _nameFolder();
  }

  Future<void> _nameFolder() async {
    final tree = store.localSetting(backupFolderKey);
    if (tree == null || tree.isEmpty) {
      if (mounted) setState(() => _folderLabel = null);
      return;
    }
    final name = await (widget.folderName ?? SafSyncFolder.displayName)(tree);
    if (mounted) setState(() => _folderLabel = name);
  }

  Future<void> _pickFolder() async {
    final tree = await (widget.pickFolder ?? SafSyncFolder.pick)();
    if (tree == null || !mounted) return;
    store.setLocalSetting(backupFolderKey, tree);
    await _nameFolder();
  }

  void _forgetFolder() {
    store.setLocalSetting(backupFolderKey, '');
    setState(() => _folderLabel = null);
  }

  Future<void> _backupNow() async {
    setState(() => _busy = true);
    await autoBackup(store, save: widget.save, force: true);
    if (!mounted) return;
    setState(() => _busy = false);
    final error = store.localSetting(backupErrorKey);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error == null || error.isEmpty
              ? context.t.backupsDone
              : context.t.lastBackupFailed(error),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    String when(DateTime d) =>
        DateFormat.yMd(locale).add_Hm().format(d.toLocal());
    final last = DateTime.tryParse(store.localSetting(backupAtKey) ?? '');
    final error = store.localSetting(backupErrorKey);
    final (system, files) = switch (_platform) {
      'android' => (t.backupsAndroidSystem, t.backupsAndroidFiles),
      'ios' => (t.backupsIosSystem, t.backupsIosFiles),
      _ => (null, t.backupsDesktopFiles),
    };
    return Scaffold(
      appBar: AppBar(title: Text(t.backupsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (system != null) ...[Text(system), const SizedBox(height: 12)],
          Text(files),
          const SizedBox(height: 16),
          Text(
            last == null ? t.backupsNever : t.backupsLast(when(last)),
            style: theme.textTheme.titleMedium,
          ),
          if (error != null && error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                t.lastBackupFailed(error),
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          if (_restored case final at?)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(t.backupsRestoredNote(when(at))),
            ),
          if (_platform == 'android') ...[
            const SizedBox(height: 24),
            Text(t.backupsFolderHint),
            const SizedBox(height: 8),
            if (_folderLabel case final label?)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.folder_shared_outlined),
                title: Text(t.backupsFolderIs(label)),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: t.backupsFolderRemove,
                  onPressed: _forgetFolder,
                ),
                onTap: _pickFolder,
              )
            else
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.folder_open),
                  label: Text(t.backupsFolderPick),
                  onPressed: _pickFolder,
                ),
              ),
          ],
          const SizedBox(height: 16),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FilledButton.icon(
              icon: _busy
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(t.backupsNow),
              onPressed: _busy ? null : _backupNow,
            ),
          ),
        ],
      ),
    );
  }
}
