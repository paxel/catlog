# 04 — Auto hotspot for field sync (follow-up)

**What to build:** Android host starts a LocalOnlyHotspot; QR carries Wi-Fi credentials + pair code; joiner auto-joins (Android WifiNetworkSpecifier / iOS NEHotspotConfiguration) and syncs; teardown afterwards. iPhone can join but never host automatically (no iOS API).

**Blocked by:** 02 — QR pairing.

**Status:** ready-for-agent (deliberately deferred — native glue on both platforms)

- [ ] Android LocalOnlyHotspot host flow
- [ ] Auto-join on Android and iOS
- [ ] QR payload extended with Wi-Fi credentials
