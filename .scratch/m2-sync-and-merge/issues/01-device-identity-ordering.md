# 01 — Device identity and device-stable ordering

**What to build:** Every installation gets a device id; every entry records its origin `(device, dseq)`. The latest-wins tiebreak becomes (date, recorded, author, device, dseq) so all devices project identical state — the prerequisite for sync convergence. Existing databases migrate in place.

**Blocked by:** None — can start immediately.

**Status:** done

- [x] Device id generated once, stored in local settings
- [x] Entries carry origin device and per-device monotonic dseq; (device, dseq) unique
- [x] Projection ordering uses (date, recorded, author, device, dseq)
- [x] Migration backfills existing rows with the local device id and dseq = seq
- [x] Core tests: ordering determinism across two stores with interleaved entries, migration of a v1 database
