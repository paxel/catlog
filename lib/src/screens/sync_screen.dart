import 'dart:io';
import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n.dart';
import '../sync/lan.dart';
import 'scan_screen.dart';

/// Device-to-device sync: hosting shows a QR plus a short typable code,
/// joining scans or types it and syncs immediately (ADR-0002). Plus the
/// shared-folder transport and sync-by-messenger bundles.
class SyncScreen extends StatefulWidget {
  final CatalogStore store;

  const SyncScreen({super.key, required this.store});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  LanSyncHost? _host;
  String? _pairCode;
  int _sessions = 0;

  final TextEditingController _code = TextEditingController();
  bool _joining = false;
  String? _lastResult;

  @override
  void initState() {
    super.initState();
    _pokeLocalNetwork();
  }

  /// iOS gates outgoing LAN connections behind the Local Network
  /// permission prompt — and blocks traffic until it is answered.
  /// Poking the network when the sync screen opens surfaces the prompt
  /// BEFORE the user scans a code, so the first join doesn't time out.
  Future<void> _pokeLocalNetwork() async {
    if (!Platform.isIOS) return;
    try {
      final socket =
          await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      socket.send([0], InternetAddress('224.0.0.251'), 5353);
      socket.close();
    } catch (_) {
      // Best effort — the prompt either appeared or was long answered.
    }
  }

  @override
  void dispose() {
    _host?.stop();
    _code.dispose();
    super.dispose();
  }

  Future<void> _toggleHost() async {
    if (_host != null) {
      await _host!.stop();
      setState(() {
        _host = null;
        _pairCode = null;
      });
      return;
    }
    final pin = (Random.secure().nextInt(900000) + 100000).toString();
    final host = LanSyncHost(widget.store, pin, onSession: () {
      if (mounted) setState(() => _sessions++);
    });
    final address = await host.start();
    if (!mounted) return;
    setState(() {
      _host = host;
      _pairCode = encodePairCode(address, host.port, pin);
      _sessions = 0;
    });
  }

  Future<void> _joinWith(String raw) async {
    final info = decodePairCode(raw);
    if (info == null) {
      setState(() => _lastResult = context.t.invalidCode);
      return;
    }
    setState(() {
      _joining = true;
      _lastResult = null;
    });
    try {
      final result =
          await lanSync(widget.store, info.host, info.port, info.pin);
      widget.store.setLocalSetting(
          'lastSync:${info.host}', DateTime.now().toIso8601String());
      if (!mounted) return;
      setState(() => _lastResult = context.t.syncedResult('$result'));
    } catch (e) {
      if (mounted) {
        final hint =
            Platform.isIOS ? '\n${context.t.iosLocalNetworkHint}' : '';
        setState(() => _lastResult = context.t.syncFailed('$e$hint'));
      }
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _scan() async {
    final value = await Navigator.of(context)
        .push<String>(MaterialPageRoute(builder: (_) => const ScanScreen()));
    if (value != null) {
      _code.text = value;
      await _joinWith(value);
    }
  }

  Future<void> _shareBundle() async {
    final t = context.t;
    try {
      final dir = await getTemporaryDirectory();
      final stamp = DateTime.now().toIso8601String().substring(0, 10);
      final path = writeBundle(widget.store, '${dir.path}/catlog-$stamp.catsync');
      await Share.shareXFiles([XFile(path, mimeType: 'application/zip')]);
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
      final result = importBundle(widget.store, path);
      if (!mounted) return;
      setState(() => _lastResult = t.bundleImported('$result'));
    } catch (e) {
      if (!mounted) return;
      setState(() => _lastResult = t.bundleImportFailed('$e'));
    }
  }

  bool get _canScan => Platform.isAndroid || Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.sync)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.host, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(t.hostExplainer),
          const SizedBox(height: 4),
          Text(t.hotspotHint,
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _toggleHost,
            icon: Icon(_host == null ? Icons.wifi_tethering : Icons.stop),
            label: Text(_host == null ? t.startHosting : t.stopHosting),
          ),
          if (_pairCode != null) ...[
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  QrImageView(
                    data: _pairCode!,
                    size: 220,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SelectableText(
                      _pairCode!,
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      tooltip: t.copyCode,
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: _pairCode!));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.copied)));
                        }
                      },
                    ),
                  ]),
                  Text(t.sessionsSoFar(_sessions)),
                ]),
              ),
            ),
          ],
          const Divider(height: 40),
          Text(t.join, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (_canScan) ...[
            FilledButton.icon(
              onPressed: _joining ? null : _scan,
              icon: const Icon(Icons.qr_code_scanner),
              label: Text(t.scanCode),
            ),
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _code,
            decoration: InputDecoration(
              labelText: t.orTypeCode,
              hintText: 'xxxxx_xxxxx_xxxxx',
              border: const OutlineInputBorder(),
              suffixIcon: _joining
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(strokeWidth: 2)),
                    )
                  : IconButton(
                      icon: const Icon(Icons.sync),
                      tooltip: t.syncNow,
                      onPressed: () => _joinWith(_code.text),
                    ),
            ),
            inputFormatters: [_PairCodeFormatter()],
            autocorrect: false,
            onChanged: (v) {
              // The moment a complete, valid code is in: go.
              if (!_joining && decodePairCode(v) != null) _joinWith(v);
            },
          ),
          if (_lastResult != null) ...[
            const SizedBox(height: 12),
            Text(_lastResult!),
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
                  if (!mounted) return;
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
          const Divider(height: 40),
          Text(t.byMessenger,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(t.byMessengerExplainer),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _shareBundle,
                icon: const Icon(Icons.ios_share),
                label: Text(t.shareBundle),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _importBundle,
                icon: const Icon(Icons.download),
                label: Text(t.importBundle),
              ),
            ),
          ]),
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

/// Lowercases and regroups the pairing code as the user types:
/// underscores appear by themselves every five characters.
class _PairCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text
        .toLowerCase()
        .replaceAll(RegExp(r'[^0-9a-z]'), '');
    final grouped = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      if (i > 0 && i % 5 == 0) grouped.write('_');
      grouped.write(raw[i]);
    }
    final text = grouped.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
