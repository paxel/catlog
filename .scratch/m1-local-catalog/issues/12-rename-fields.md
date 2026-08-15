# 12 — Rename Field definitions

**What to build:** A fosterer fixes a typo in a Field's name. The rename changes only the display name — the internal key stays, so all stored values and history remain attached, and the rename itself is a dated, authored history entry.

**Blocked by:** 04 — User-defined Fields.

**Status:** done

- [x] Tap a field on the Fields screen to rename it
- [x] Values stored under the field survive the rename (key/slug unchanged)
- [x] Rename is an ordinary entry: visible in the definition's history
- [x] Core tests cover rename semantics and non-definition rejection
