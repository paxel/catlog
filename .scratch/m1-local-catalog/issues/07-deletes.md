# 07 — Deletes

**What to build:** A fosterer deletes a bad photo and its data is really gone; deletes a mistaken Cat so it vanishes from all lists; deletes a Clowder (e.g. the owner died) and its Cats fall out as Strays rather than disappearing. Deletion is a propagated marker entry per ADR-0001, ready for M2 sync.

**Blocked by:** 05 — Move & Stray.

**Status:** ready-for-agent

- [ ] Photo delete removes the image bytes and hides it everywhere; marker entry recorded
- [ ] Cat delete hides the Cat from all lists and searches; its photo bytes are dropped
- [ ] Clowder delete turns its current Cats into Strays, then removes the Clowder
- [ ] No hard removal of log entries other than image bytes
- [ ] Core tests cover all three deletes including clowder-delete → Strays
