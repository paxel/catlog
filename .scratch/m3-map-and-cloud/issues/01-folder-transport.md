# 01 — Cloud-folder sync transport

**What to build:** Sync through any shared folder (pCloud/Drive/Dropbox mount, USB stick): each device appends its own `catlog-sync/<deviceId>.jsonl` and copies blobs to `catlog-sync/blobs/`; syncing reads every foreign file through the same idempotent import as LAN. Never writes a foreign file. Folder picked once per device (desktop picker; Android SAF; iOS if the platform allows persistent access, else a clear unsupported message).

**Blocked by:** M2-02 — Sync engine.

**Status:** done (core; folder picker UI follows with the sync screen wiring)

- [x] Own-file append + blob copy; foreign files read-only
- [x] Import via the engine's vector, so re-syncs are cheap and idempotent
- [ ] Folder selection persisted per device; sync action with result summary
- [x] Core tests: two stores round-trip through a temp directory, convergence, no foreign writes
