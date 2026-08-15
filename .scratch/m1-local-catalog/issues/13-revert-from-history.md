# 13 — Revert a change from the history

**What to build:** Like git revert: tapping an entry in a timeline or field history offers "Revert this change", which appends the previous value as a new entry at the current time, authored by the reverter. Nothing is deleted — the mistake and its undo both stay in history. Works for Cats and Clowders alike; structural markers and photo entries are excluded (deleted photo bytes are gone for good).

**Blocked by:** 03 — Fields + timeline.

**Status:** done

- [x] Revert action on revertable entries in timeline and field history
- [x] Revert appends the pre-change value (or clears, for a field's first entry) at the current time
- [x] Membership entries revertable — "undo the move"
- [x] `$type`, `$deleted`, and photo entries excluded
- [x] Core tests: rename revert, move revert, first-entry revert, exclusion
