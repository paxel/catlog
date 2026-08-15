import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

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
    final parts = _address.text.trim().split(':');
    if (parts.length != 2 || int.tryParse(parts[1]) == null) {
      setState(() => _lastResult = 'Address must look like 192.168.0.12:38472');
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
      setState(() => _lastResult = 'Synced: $result');
    } catch (e) {
      setState(() => _lastResult = 'Sync failed: $e');
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
    return Scaffold(
      appBar: AppBar(title: const Text('Sync')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Host', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const Text('Start here, then enter the address and PIN on the '
              'other device.'),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _toggleHost,
            icon: Icon(_host == null ? Icons.wifi_tethering : Icons.stop),
            label: Text(_host == null ? 'Start hosting' : 'Stop hosting'),
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
                  Text('PIN: $_pin',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('$_sessions session(s) so far'),
                ]),
              ),
            ),
          ],
          const Divider(height: 40),
          Text('Join', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _address,
            decoration: const InputDecoration(
              labelText: 'Address (from the hosting device)',
              hintText: '192.168.0.12:38472',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _joinPin,
            decoration: const InputDecoration(
              labelText: 'PIN',
              border: OutlineInputBorder(),
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
            label: const Text('Sync now'),
          ),
          if (_lastResult != null) ...[
            const SizedBox(height: 12),
            Text(_lastResult!),
          ],
          if (lastSync != null) ...[
            const SizedBox(height: 12),
            Text('Last sync with ${lastPeer!.split(':').first}: '
                '${lastSync.substring(0, 16).replaceFirst('T', ' ')}'),
          ],
        ],
      ),
    );
  }
}
