import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../import_summary.dart';
import '../l10n.dart';
import '../share.dart';

/// "Messenger": the whole catalog as one .catsync file through WhatsApp,
/// Signal, mail — anything that moves files.
class MessengerScreen extends StatefulWidget {
  final CatalogStore store;

  const MessengerScreen({super.key, required this.store});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  String? _lastResult;
  bool _includePrivate = false;

  Future<void> _shareBundle() async {
    final t = context.t;
    try {
      final dir = await getTemporaryDirectory();
      final stamp = DateTime.now().toIso8601String().substring(0, 10);
      final path = writeBundle(
          widget.store, '${dir.path}/catlog-$stamp.catsync',
          includePrivate: _includePrivate);
      if (!mounted) return;
      // iPads need the popover anchor or the share throws (#43).
      await shareFiles(context, [XFile(path, mimeType: 'application/zip')]);
    } catch (e) {
      if (!mounted) return;
      setState(() => _lastResult = t.syncFailed('$e'));
    }
  }

  Future<void> _importBundle() async {
    final t = context.t;
    final picked = await FilePicker.platform.pickFiles();
    final path = picked?.files.single.path;
    if (path == null) return;
    try {
      final imported = importWithMoment(widget.store, path,
          label: path.split(Platform.pathSeparator).last);
      final result = imported.result;
      setState(() => _lastResult = t.bundleImported('$result'));
      if (mounted && result.applied.isNotEmpty) {
        await showImportSummary(context, widget.store, result.applied,
            undo: imported.moment);
      }
    } on UnsupportedBundleFormat {
      setState(() => _lastResult = t.bundleNewerError);
    } catch (e) {
      setState(() => _lastResult = t.notACatlogFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.syncChooserMessenger)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.byMessengerExplainer),
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
          FilledButton.icon(
            onPressed: _shareBundle,
            icon: const Icon(Icons.ios_share),
            label: Text(t.shareBundle),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _importBundle,
            icon: const Icon(Icons.download),
            label: Text(t.importBundle),
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
