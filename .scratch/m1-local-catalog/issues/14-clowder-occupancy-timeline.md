# 14 — Combined clowder timeline (who lived here when)

**What to build:** A Clowder's timeline weaves in the arrivals and departures of Cats — "Miezi arrived from A", "Miezi left to Adopter" — derived at read time from the Cats' membership histories (membership lives on the Cat, never duplicated into the Clowder). Cat timelines show the same moves in readable form ("Moved to X", "Left — stray"). Occupancy rows are backed by the real membership entries, so revert works on them too.

**Blocked by:** 13 — Revert from history.

**Status:** done

- [x] Clowder timeline shows arrivals/departures with counterpart (from/to clowder, or stray)
- [x] Derived at read time from cat membership history — no data duplication
- [x] Cat timeline renders membership entries as "Moved to X" / "Left — stray"
- [x] Occupancy rows revertable (they are ordinary membership entries)
- [x] Core tests: arrival/departure derivation, clowder-delete fallout as departure to stray
