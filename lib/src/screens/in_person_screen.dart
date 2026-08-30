import 'dart:io';
import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../import_summary.dart';
import '../sync/hotspot.dart';
import '../l10n.dart';
import '../sync/lan.dart';
import 'scan_screen.dart';
import '../sync/tls.dart';

/// "In person": two devices in the same room sync over the local
/// network. Host shows a QR, joiner scans (or types the short code).
/// What shows depends on platform and network (forgiving-UX rule 5:
/// unavailable things get a one-line why, they never vanish silently).
class InPersonScreen extends StatefulWidget {
  final CatalogStore store;

  const InPersonScreen({super.key, required this.store});

  @override
  State<InPersonScreen> createState() => _InPersonScreenState();
}

class _InPersonScreenState extends State<InPersonScreen> {
  LanSyncHost? _host;
  String? _pairCode;

  /// The full-fingerprint code for the QR; [_pairCode] is the typed one.
  String? _pairCodeQr;

  /// Set while hosting over our own LocalOnlyHotspot: the QR then
  /// carries the hotspot credentials too (Android-to-Android only).
  String? _hotspotQr;
  int _sessions = 0;

  final TextEditingController _code = TextEditingController();
  bool _joining = false;

  /// A host is being started: a second tap waits, a pop stops it.
  bool _starting = false;
  String? _lastResult;

  /// Joiner's own outbound choice; never persisted (default public).
  bool _includePrivate = false;

  /// wifi/ethernet present — cellular alone hides hosting.
  bool? _onLocalNetwork;

  @override
  void initState() {
    super.initState();
    _pokeLocalNetwork();
    Connectivity().checkConnectivity().then((types) {
      if (mounted) {
        setState(() => _onLocalNetwork =
            types.contains(ConnectivityResult.wifi) ||
                types.contains(ConnectivityResult.ethernet));
      }
    });
  }

  /// iOS gates outgoing LAN connections behind the Local Network
  /// permission prompt — and blocks traffic until it is answered.
  Future<void> _pokeLocalNetwork() async {
    if (!Platform.isIOS) return;
    try {
      final socket =
          await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      socket.send([0], InternetAddress('224.0.0.251'), 5353);
      socket.close();
    } catch (_) {}
  }

  @override
  void dispose() {
    _host?.stop();
    if (_hotspotQr != null) stopHotspot();
    _code.dispose();
    super.dispose();
  }

  /// The human trust gate: allow once, always allow this device, or
  /// decline. Include-private for the host's outbound lives here too.
  Future<JoinDecision> _onJoinRequest(
      String author, String deviceInfo) async {
    final parts = deviceInfo.split('|');
    final deviceName = parts.first;
    // A remembered device never gets here: the host checks its secret
    // first. Everything else is the keeper's call.
    if (!mounted) return const JoinDecision(false, false);
    var includePrivate = false;
    // 'once' / 'always' / null (decline)
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(context.t.trustQuestion(author, deviceName)),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(context.t.trustBothWaysNote),
            CheckboxListTile(
              value: includePrivate,
              onChanged: (v) =>
                  setDialogState(() => includePrivate = v ?? false),
              title: Text(context.t.includePrivate),
              contentPadding: EdgeInsets.zero,
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.t.declineAction),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop('always'),
              child: Text(context.t.allowAlways),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop('once'),
              child: Text(context.t.allowOnce),
            ),
          ],
        ),
      ),
    );
    if (choice == null) return const JoinDecision(false, false);
    return JoinDecision(true, includePrivate, remember: choice == 'always');
  }

  Future<void> _toggleHost() async {
    if (_starting) return;
    if (_host != null) {
      await _host!.stop();
      if (_hotspotQr != null) await stopHotspot();
      setState(() {
        _host = null;
        _pairCode = null;
        _pairCodeQr = null;
        _hotspotQr = null;
      });
      return;
    }
    final pin = (Random.secure().nextInt(900000) + 100000).toString();
    _starting = true;
    try {
      final identity = await tlsIdentity(widget.store);
      if (!mounted) return;
      final host = LanSyncHost(widget.store, pin,
          identity: identity,
          onJoinRequest: _onJoinRequest, onSession: (applied) {
        if (!mounted) return;
        setState(() => _sessions++);
        if (applied.isNotEmpty) {
          showImportSummary(context, widget.store, applied);
        }
      });
      final address = await host.start();
      if (!mounted) {
        // Backed out while binding: nothing may keep serving.
        await host.stop();
        return;
      }
      setState(() {
        _host = host;
        // The QR carries the whole fingerprint, the typed code its
        // first bytes (#92).
        _pairCodeQr = encodePairCode(address, host.port, pin,
            fingerprint: host.fingerprint);
        _pairCode = encodePairCode(address, host.port, pin,
            fingerprint: host.fingerprint, typed: true);
        _sessions = 0;
      });
    } finally {
      _starting = false;
    }
  }

  /// Android without shared Wi-Fi: our own hotspot carries the sync.
  Future<void> _hostViaHotspot() async {
    if (_starting) return;
    _starting = true;
    try {
      final info = await startHotspot();
      if (!mounted) {
        await stopHotspot();
        return;
      }
      final pin = (Random.secure().nextInt(900000) + 100000).toString();
      final identity = await tlsIdentity(widget.store);
      if (!mounted) {
        await stopHotspot();
        return;
      }
      final host = LanSyncHost(widget.store, pin,
          identity: identity,
          onJoinRequest: _onJoinRequest, onSession: (applied) {
        if (!mounted) return;
        setState(() => _sessions++);
        if (applied.isNotEmpty) {
          showImportSummary(context, widget.store, applied);
        }
      });
      await host.start();
      if (!mounted) {
        await host.stop();
        await stopHotspot();
        return;
      }
      final pairCode = encodePairCode(info.ip, host.port, pin,
          fingerprint: host.fingerprint);
      setState(() {
        _host = host;
        _pairCodeQr = pairCode;
        _pairCode = encodePairCode(info.ip, host.port, pin,
            fingerprint: host.fingerprint, typed: true);
        _hotspotQr = hotspotQrPayload(info, pairCode);
        _sessions = 0;
      });
    } catch (e) {
      if (mounted) {
        setState(
            () => _lastResult = context.t.syncFailed('$e'));
      }
    } finally {
      _starting = false;
    }
  }

  /// One scan on the joiner: low-key consent, app-scoped join, sync,
  /// automatic disconnect.
  Future<void> _joinHotspotFlow(
      ({String ssid, String pass, String pairCode}) info) async {
    if (!Platform.isAndroid) {
      setState(() => _lastResult = context.t.hotspotAndroidOnly);
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.hostWithoutWifi),
        content: Text(context.t.hotspotJoinNote),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.t.allowOnce),
          ),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _joining = true);
    try {
      final joined = await joinHotspot(info.ssid, info.pass);
      if (!joined) {
        if (mounted) {
          setState(
              () => _lastResult = context.t.syncFailed('hotspot'));
        }
        return;
      }
      await _joinWith(info.pairCode);
    } finally {
      await leaveHotspot();
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _joinWith(String raw) async {
    final info = decodePairCode(raw);
    // A code pointing outside the local network is not a pair code —
    // nothing is sent anywhere.
    if (info == null || !isPrivateHost(info.host)) {
      setState(() => _lastResult = context.t.invalidCode);
      return;
    }
    // A code without a fingerprint comes from a version before TLS.
    if (info.fingerprint == null) {
      setState(() => _lastResult = context.t.syncPeerOlder);
      return;
    }
    setState(() {
      _joining = true;
      _lastResult = null;
    });
    try {
      final result = await lanSync(
          widget.store, info.host, info.port, info.pin,
          fingerprint: info.fingerprint!, includePrivate: _includePrivate);
      if (!mounted || !widget.store.isOpen) return;
      widget.store.setLocalSetting(
          'lastSync:${info.host}', DateTime.now().toIso8601String());
      setState(() => _lastResult = context.t.syncedResult('$result'));
      if (mounted && result.applied.isNotEmpty) {
        await showImportSummary(context, widget.store, result.applied);
      }
    } on SyncException catch (e) {
      if (mounted) {
        setState(() => _lastResult = switch (e.message) {
              'declined' => context.t.syncDeclined,
              'peer-older' => context.t.syncPeerOlder,
              'peer-newer' => context.t.syncPeerNewer,
              _ => context.t.syncFailed(e.message),
            });
      }
    } on SocketException {
      if (mounted) {
        final hint =
            Platform.isIOS ? '\n${context.t.iosLocalNetworkHint}' : '';
        setState(
            () => _lastResult = '${context.t.syncUnreachable}$hint');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _lastResult = context.t.syncFailed('$e'));
      }
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _scan() async {
    final value = await Navigator.of(context)
        .push<String>(MaterialPageRoute(builder: (_) => const ScanScreen()));
    if (value == null) return;
    final hotspot = parseHotspotQr(value);
    if (hotspot != null) {
      await _joinHotspotFlow(hotspot);
      return;
    }
    _code.text = value;
    await _joinWith(value);
  }

  bool get _canScan => Platform.isAndroid || Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final onNet = _onLocalNetwork;
    // iPhone/iPad without Wi-Fi: nothing works — say so instead of
    // hiding silently or producing timeout error tickets.
    final iosOffline = Platform.isIOS && onNet == false;
    final canHost = onNet != false;
    return Scaffold(
      appBar: AppBar(title: Text(t.syncChooserInPerson)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.trustBothWaysNote,
              style: Theme.of(context).textTheme.bodySmall),
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
          if (iosOffline) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.wifi_off),
              title: Text(t.connectToWifiFirst),
            ),
          ] else ...[
            Text(t.host, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(t.hostExplainer),
            const SizedBox(height: 8),
            if (canHost)
              FilledButton.icon(
                onPressed: _toggleHost,
                icon: Icon(
                    _host == null ? Icons.wifi_tethering : Icons.stop),
                label:
                    Text(_host == null ? t.startHosting : t.stopHosting),
              )
            else if (Platform.isAndroid)
              FilledButton.icon(
                onPressed: _host == null ? _hostViaHotspot : _toggleHost,
                icon: Icon(_host == null
                    ? Icons.wifi_tethering
                    : Icons.stop),
                label: Text(
                    _host == null ? t.hostWithoutWifi : t.stopHosting),
              )
            else
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.wifi_off),
                title: Text(t.connectToWifiFirst),
              ),
            if (_pairCode != null) ...[
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    QrImageView(
                      data: _hotspotQr ?? _pairCodeQr ?? _pairCode!,
                      size: 220,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                onPressed: (_joining || _host != null) ? null : _scan,
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(t.scanCode),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _code,
              // Joining our own host would sync the device with itself.
              enabled: _host == null,
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
                            child: CircularProgressIndicator(
                                strokeWidth: 2)),
                      )
                    : IconButton(
                        icon: const Icon(Icons.sync),
                        tooltip: t.syncNow,
                        onPressed: _host != null
                            ? null
                            : () => _joinWith(_code.text),
                      ),
              ),
              inputFormatters: [PairCodeFormatter()],
              autocorrect: false,
              onChanged: (v) {
                if (!_joining && decodePairCode(v) != null) _joinWith(v);
              },
            ),
          ],
          if (_lastResult != null) ...[
            const SizedBox(height: 12),
            Text(_lastResult!),
          ],
        ],
      ),
    );
  }
}

/// Groups typed pair codes as xxxxx_xxxxx_xxxxx while typing.
class PairCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text
        .toLowerCase()
        .replaceAll(RegExp('[^0-9a-z]'), '');
    final buffer = StringBuffer();
    for (var i = 0; i < raw.length && i < 15; i++) {
      if (i == 5 || i == 10) buffer.write('_');
      buffer.write(raw[i]);
    }
    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
