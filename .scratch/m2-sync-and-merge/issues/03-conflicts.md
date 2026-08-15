# 03 — Conflict badges and promote

**What to build:** When sync imports an entry competing with a local latest from a different author, the field gets a device-local conflict flag. The UI badges the field on Cat/Clowder screens; tapping shows both values with author and date; promoting one appends it as a new entry (ADR-0001) and clears the flag. Dismissing without promoting also clears it.

**Blocked by:** 02 — Sync engine.

**Status:** done

- [x] Conflict detection at import time; flags in a local, unsynced table
- [x] Badge on affected field tiles; conflict dialog shows both candidates with author/date
- [x] Promote appends an ordinary entry; view/dismiss clears the badge
- [x] Core tests: concurrent edit → flag; promote → new entry, flag cleared; third device converges
- [x] Widget test: badge shown, promote flow
