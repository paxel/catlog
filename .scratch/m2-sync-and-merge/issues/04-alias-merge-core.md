# 04 — Alias merge in the core (Cats, Clowders, Fields)

**What to build:** Merge per `.scratch/m2-notes.md`: `mergedInto` entry on the loser; reads resolve alias chains (cycles refused). Cats/Clowders: survivor re-asserts current values at merge time, loser fills gaps, id references resolve to the survivor (membership pointing at a merged clowder lands in the survivor). Fields: same-type only, values read across aliased keys. Irreversible. Write the ADR.

**Blocked by:** 01 — Device identity (stable ordering for re-assertion).

**Status:** ready-for-agent

- [ ] mergeCat / mergeClowder / mergeField with alias resolution in all read paths
- [ ] Survivor re-assertion for Cats and Clowders; latest-wins union for field values
- [ ] Same-type guard for field merges; cycle refusal; merged losers hidden from lists
- [ ] Offline-entry case: values recorded against the loser on another device land on the survivor after sync
- [ ] ADR written (alias merge, copy-merge rejected)
- [ ] Core tests cover all record kinds and the offline case
