# 02 — QR + short-code pairing

**What to build:** Hosting immediately shows a QR and a 15-char Crockford-base32 code (IPv4+port+PIN packed) grouped as xxxxx_xxxxx_xxxxx with auto-inserted underscores on input; IPv6-only gets a longer flagged code. Joining scans (phones) or types/pastes; sync starts the moment the code decodes. Sync screen hints at using the system hotspot when no shared Wi-Fi exists.

**Blocked by:** None.

**Status:** done

- [x] Pair-code encode/decode in the core, round-trip tested (v4, v6, bad input)
- [x] Host: QR + grouped code + copy button, shown immediately on start
- [x] Join: camera scan on Android/iOS, code field with auto-grouping everywhere, auto-sync on decode
- [x] Hotspot hint text
