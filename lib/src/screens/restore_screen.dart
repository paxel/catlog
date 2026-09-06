import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auto_backup.dart';
import '../l10n.dart';
import '../restore_backups.dart';

/// Backups from the install before this one, offered on a fresh start
/// (#102) and from Manage catalogs. Lists what the backup folder holds,
/// one row per catalog, all ticked; Restore brings each back as its own
/// catalog. "Pick files…" adds backups kept elsewhere.
class RestoreScreen extends StatefulWidget {
  final CatalogManager catalogs;

  /// Where to look; defaults to the platform's backup folder.
  final Future<Directory?> Function() folder;

  /// Called when the screen is done, with the first restored catalog or
  /// null when nothing was restored.
  final void Function(CatalogInfo? first) onDone;

  /// On a fresh start an empty folder means nothing to ask: done at once.
  /// From Manage catalogs the empty list is shown, with the picker.
  final bool skipWhenEmpty;

  const RestoreScreen({
    super.key,
    required this.catalogs,
    required this.onDone,
    this.folder = backupFolder,
    this.skipWhenEmpty = true,
  });

  @override
  State<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends State<RestoreScreen> {
  List<BackupSet>? _sets;
  final _files = <File>[];
  final _selected = <int>{};
  bool _restoring = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final folder = await widget.folder();
    if (!mounted) return;
    if (folder != null && folder.existsSync()) {
      _files.addAll(folder.listSync().whereType<File>());
    }
    _regroup();
    if (_sets!.isEmpty && widget.skipWhenEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.onDone(null));
    }
  }

  void _regroup() {
    final sets = findBackups(_files);
    setState(() {
      _sets = sets;
      _selected
        ..clear()
        ..addAll(List.generate(sets.length, (i) => i));
    });
  }

  Future<void> _pickFiles() async {
    final picked = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (picked == null || !mounted) return;
    for (final f in picked.files) {
      if (f.path != null) _files.add(File(f.path!));
    }
    _regroup();
  }

  Future<void> _restore() async {
    setState(() => _restoring = true);
    CatalogInfo? first;
    var count = 0;
    for (final (i, set) in _sets!.indexed) {
      if (!_selected.contains(i)) continue;
      final made = restoreBackupSet(widget.catalogs, set);
      first ??= made;
      count++;
    }
    if (!mounted) return;
    setState(() => _restoring = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.t.restoreDone(count))));
    widget.onDone(first);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final sets = _sets;
    final locale = Localizations.localeOf(context).toString();
    return Scaffold(
      appBar: AppBar(title: Text(t.restoreTitle)),
      body: sets == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Text(sets.isEmpty ? t.restoreNone : t.restoreIntro),
                ),
                for (final (i, set) in sets.indexed)
                  CheckboxListTile(
                    value: _selected.contains(i),
                    onChanged: _restoring
                        ? null
                        : (v) => setState(
                            () => v == true
                                ? _selected.add(i)
                                : _selected.remove(i),
                          ),
                    title: Text(set.name),
                    subtitle: Text(
                      t.restoreFileLine(
                        set.files.length,
                        DateFormat.yMd(locale).format(set.newest.toLocal()),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      icon: const Icon(Icons.folder_open),
                      label: Text(t.restorePickFiles),
                      onPressed: _restoring ? null : _pickFiles,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _restoring ? null : () => widget.onDone(null),
                  child: Text(t.introSkip),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  icon: _restoring
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.restore),
                  label: Text(t.restoreAction),
                  onPressed: _restoring || _selected.isEmpty ? null : _restore,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
