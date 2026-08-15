# 06 — LAN transport and sync screen

**What to build:** Sync screen: "Host" shows this device's address and a 6-digit PIN; "Join" takes address + PIN and runs a full two-way sync (entries then blobs) over HTTP on the local network. Progress and result (entries in/out, photos in/out) shown; last-sync time per peer remembered.

**Blocked by:** 02 — Sync engine.

**Status:** ready-for-agent

- [ ] HTTP host on a random port, endpoints gated by the PIN header
- [ ] Join flow: address+PIN entry, two-way delta sync, blob transfer
- [ ] Result summary and per-peer last-sync timestamp
- [ ] iOS local-network permission strings; graceful failure messages
- [ ] Localhost integration test of a full two-store sync over the transport
