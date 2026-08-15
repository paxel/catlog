# 03 — Sync bundle via messenger

**What to build:** "Share bundle" exports one file (all entries + current photos, zipped) through the share sheet — WhatsApp, Signal, mail. "Import bundle" on the other device merges it through the same idempotent engine as every transport. Cross-city sync with no server.

**Blocked by:** None.

**Status:** done

- [x] Core: bundle write/read (zip: entries.jsonl + blobs), import idempotent, conflicts detected via the writer vector
- [x] Share via share sheet; import via file picker
- [x] Round-trip core test: two stores converge through a bundle file
