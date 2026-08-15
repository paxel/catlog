# 02 — Sync engine (transport-agnostic delta exchange)

**What to build:** The core can answer "what do you have?" (version vector: max dseq per device), hand over every entry a peer is missing, idempotently import foreign entries, and reconcile photo blobs by content hash. Two stores syncing in any order and direction converge to identical projections.

**Blocked by:** 01 — Device identity.

**Status:** done

- [x] Version vector export; entriesSince(vector); idempotent applyEntries (upsert on device+dseq)
- [x] Blob reconciliation: referenced-but-missing hashes listed, bytes transferable both ways
- [x] Deletions and image-delete markers propagate; blob bytes dropped on receipt of a delete that leaves no reference
- [x] Core tests: A↔B convergence, three-store A→B→C vs C→B→A identical state, repeated sync is a no-op
