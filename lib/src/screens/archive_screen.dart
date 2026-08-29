import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../help.dart';
import '../l10n.dart';
import '../share.dart';
import '../private_temp.dart';

/// Human-readable byte size, kept short: 12 MB, not 12,345,678 bytes.
String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).round()} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

/// "Archive…" (#53): quiet, deceased, empty entries are written to a
/// `.catsync` file the user keeps, then deleted. Manual only — the app
/// never sweeps anything away on its own.
class ArchiveScreen extends StatefulWidget {
  final CatalogStore store;

  /// Test seam for the file destination; production uses a temp file
  /// handed to the share sheet.
  final Future<String?> Function(String suggestedName)? saveTo;

  const ArchiveScreen({super.key, required this.store, this.saveTo});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  CatalogStore get store => widget.store;

  /// Quiet-for threshold in years; the list follows it.
  int _years = 2;
  final _selected = <String>{};
  bool _working = false;

  /// Computed when the data or the threshold changes, not on every
  /// checkbox tap — the scan walks the whole log.
  List<ArchiveCandidate>? _cache;

  List<ArchiveCandidate> _candidates() => _cache ??= archiveCandidates(store,
      inactiveFor: Duration(days: 365 * _years));

  Future<void> _archive() async {
    if (_selected.isEmpty || _working) return;
    final t = context.t;
    final candidates = _candidates();
    final names = [
      for (final c in candidates)
        if (_selected.contains(c.id)) c.name
    ];
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.archiveConfirmTitle(names.length)),
        content: Text(t.archiveConfirmBody(names.join(', '))),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.cancel)),
          FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.archiveAction)),
        ],
      ),
    );
    if (sure != true || !mounted) return;
    setState(() => _working = true);
    final stamp = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final name = 'catlog-archive-$stamp.catsync';
    try {
      if (widget.saveTo != null) {
        final chosen = await widget.saveTo!(name);
        if (chosen == null) {
          if (mounted) setState(() => _working = false);
          return;
        }
        writeArchive(store, chosen, entityIds: {..._selected});
      } else {
        final result = await withPrivateFile(name, (tmp) async {
          writeArchive(store, tmp, entityIds: {..._selected});
          if (!mounted) return null;
          return shareFiles(
              context, [XFile(tmp, mimeType: 'application/zip')]);
        });
        // The temp file is not a safe place: unless the share really
        // went somewhere, nothing may be deleted.
        if (result?.status != ShareResultStatus.success) {
          if (!mounted) return;
          setState(() => _working = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(t.archiveNotSaved)));
          return;
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _working = false);
      // Nothing was deleted — say so, and why the export failed.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.archiveFailed('$e'))));
      return;
    }
    // Only now, with the file written, does anything get deleted — and
    // only into the catalog that is still open.
    if (!store.isOpen) return;
    final before = store.currentSeq();
    deleteArchived(store, {..._selected});
    momentFor(store,
        before: before, changed: true, cause: MomentCause.archive);
    if (!mounted) return;
    setState(() {
      _selected.clear();
      _working = false;
      _cache = null;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(t.archiveDone(names.length))));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final usage = store.storageUsage();
    final candidates = _candidates();
    return Scaffold(
      appBar: AppBar(title: Text(t.archiveTitle), actions: [
        HelpButton(store: store, screenId: 'archive'),
      ]),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(t.archiveExplainer,
              style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: Text(t.storageLine(formatBytes(usage.dbBytes),
              formatBytes(usage.photoBytes), usage.photoCount)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(spacing: 8, children: [
            for (final years in [1, 2, 5])
              ChoiceChip(
                label: Text(t.quietForYears(years)),
                selected: _years == years,
                onSelected: (_) => setState(() {
                  _years = years;
                  _selected.clear();
                  _cache = null;
                }),
              ),
          ]),
        ),
        const Divider(),
        if (candidates.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(t.nothingToArchive),
          ),
        for (final c in candidates)
          CheckboxListTile(
            value: _selected.contains(c.id),
            onChanged: (on) => setState(() {
              if (on == true) {
                _selected.add(c.id);
              } else {
                _selected.remove(c.id);
              }
            }),
            secondary:
                Icon(c.isCat ? Icons.pets : Icons.home_outlined),
            title: Text(c.name),
            subtitle: Text(t.archiveCandidateLine(
                DateFormat.yMd(Localizations.localeOf(context).toString())
                    .format(c.lastChange),
                formatBytes(c.photoBytes))),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton.icon(
            icon: _working
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.inventory_2_outlined),
            label: Text(t.archiveSelected(_selected.length)),
            onPressed: _selected.isEmpty || _working ? null : _archive,
          ),
        ),
        const SizedBox(height: 24),
      ]),
    );
  }
}
