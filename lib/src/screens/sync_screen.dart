import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../sync/lan.dart';

/// Device-to-device sync over the local network: one side hosts and
/// shows address + PIN, the other joins. No server, no account
/// (ADR-0002).
class SyncScreen extends StatefulWidget {
  final CatalogStore store;

  const SyncScreen({super.key, required this.store});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  LanSyncHost? _host;
  String? _hostAddress;
  String _pin = '';
  int _sessions = 0;

  late final TextEditingController _address = TextEditingController(
      text: widget.store.localSetting('lastPeerAddress') ?? '');
  final TextEditingController _joinPin = TextEditingController();
  bool _joining = false;
  String? _lastResult;

  @override
  void dispose() {
    _host?.stop();
    _address.dispose();
    _joinPin.dispose();
    super.dispose();
  }

  Future<void> _toggleHost() async {
    if (_host != null) {
      await _host!.stop();
      setState(() => _host = null);
      return;
    }
    _pin = (Random.secure().nextInt(900000) + 100000).toString();
    final host = LanSyncHost(widget.store, _pin, onSession: () {
      if (mounted) setState(() => _sessions++);
    });
    final address = await host.start();
    setState(() {
      _host = host;
      _hostAddress = '$address:${host.port}';
      _sessions = 0;
    });
  }

  Future<void> _join() async {
    final t = context.t;
    final parts = _address.text.trim().split(':');
    if (parts.length != 2 || int.tryParse(parts[1]) == null) {
      setState(() => _lastResult = t.addressFormatHint);
      return;
    }
    setState(() {
      _joining = true;
      _lastResult = null;
    });
    try {
      final result = await lanSync(widget.store, parts[0],
          int.parse(parts[1]), _joinPin.text.trim());
      widget.store
        ..setLocalSetting('lastPeerAddress', _address.text.trim())
        ..setLocalSetting('lastSync:${parts[0]}',
            DateTime.now().toIso8601String());
      setState(() => _lastResult = t.syncedResult('$result'));
    } catch (e) {
      setState(() => _lastResult = t.syncFailed('$e'));
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastPeer = widget.store.localSetting('lastPeerAddress');
    final lastSync = lastPeer == null
        ? null
        : widget.store.localSetting('lastSync:${lastPeer.split(':').first}');
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.sync)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.host, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(t.hostExplainer),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _toggleHost,
            icon: Icon(_host == null ? Icons.wifi_tethering : Icons.stop),
            label: Text(_host == null ? t.startHosting : t.stopHosting),
          ),
          if (_host != null) ...[
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Text(_hostAddress!,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(t.pinLabel(_pin),
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(t.sessionsSoFar(_sessions)),
                ]),
              ),
            ),
          ],
          const Divider(height: 40),
          Text(t.join, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _address,
            decoration: InputDecoration(
              labelText: t.addressFromHost,
              hintText: '192.168.0.12:38472',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _joinPin,
            decoration: InputDecoration(
              labelText: t.pin,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _joining ? null : _join,
            icon: _joining
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.sync),
            label: Text(t.syncNow),
          ),
          if (_lastResult != null) ...[
            const SizedBox(height: 12),
            Text(_lastResult!),
          ],
          if (lastSync != null) ...[
            const SizedBox(height: 12),
            Text(t.lastSyncWith(lastPeer!.split(':').first,
                lastSync.substring(0, 16).replaceFirst('T', ' '))),
          ],
          const Divider(height: 40),
          Text(t.sharedFolder,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(t.sharedFolderExplainer),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: Text(
                widget.store.localSetting('syncFolder') ??
                    t.noFolderChosenYet,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () async {
                final path = await FilePicker.platform.getDirectoryPath();
                if (path != null) {
                  widget.store.setLocalSetting('syncFolder', path);
                  setState(() {});
                }
              },
              child: Text(t.choose),
            ),
          ]),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: widget.store.localSetting('syncFolder') == null
                ? null
                : _folderSync,
            icon: const Icon(Icons.folder_copy_outlined),
            label: Text(t.syncFolderNow),
          ),
        ],
      ),
    );
  }

  Future<void> _folderSync() async {
    final t = context.t;
    final folder = widget.store.localSetting('syncFolder')!;
    try {
      final result = folderSync(widget.store, folder);
      setState(() => _lastResult = t.folderSynced('$result'));
    } catch (e) {
      setState(() => _lastResult = t.folderSyncFailed('$e'));
    }
  }
}
