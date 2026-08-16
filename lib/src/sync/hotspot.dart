import 'dart:convert';

import 'package:flutter/services.dart';

/// Android-to-Android one-scan sync without any shared Wi-Fi: the host
/// starts a LocalOnlyHotspot (no internet, app-scoped on the joiner,
/// torn down right after the session — see #18). The QR carries the
/// hotspot credentials plus the ordinary pair code.
const _channel = MethodChannel('catlog/hotspot');

const hotspotQrPrefix = 'CATHS:';

class HotspotInfo {
  final String ssid;
  final String pass;
  final String ip;

  const HotspotInfo(this.ssid, this.pass, this.ip);
}

Future<HotspotInfo> startHotspot() async {
  final map = (await _channel.invokeMethod<Map>('startHotspot'))!;
  return HotspotInfo(
      map['ssid'] as String, map['pass'] as String, map['ip'] as String);
}

Future<void> stopHotspot() => _channel.invokeMethod('stopHotspot');

Future<bool> joinHotspot(String ssid, String pass) async =>
    await _channel.invokeMethod<bool>(
        'joinHotspot', {'ssid': ssid, 'pass': pass}) ??
    false;

Future<void> leaveHotspot() => _channel.invokeMethod('leaveHotspot');

String hotspotQrPayload(HotspotInfo info, String pairCode) =>
    '$hotspotQrPrefix${jsonEncode({
      's': info.ssid,
      'p': info.pass,
      'c': pairCode,
    })}';

({String ssid, String pass, String pairCode})? parseHotspotQr(String raw) {
  if (!raw.startsWith(hotspotQrPrefix)) return null;
  try {
    final map = jsonDecode(raw.substring(hotspotQrPrefix.length)) as Map;
    return (
      ssid: map['s'] as String,
      pass: map['p'] as String,
      pairCode: map['c'] as String
    );
  } catch (_) {
    return null;
  }
}
