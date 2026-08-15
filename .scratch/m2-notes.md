# M2 design notes (decided during M1, build in M2)

## Merge = alias, unified for Cats, Clowders, and Field definitions

Decided 2026-08-15. Duplicates happen for all three (two people register
the same cat, the same foster home, or "Number of legs" vs "Limbs").
One mechanism covers them:

- Merging appends `mergedInto = <survivor id>` on the loser. Nothing is
  copied or rewritten; the alias is an ordinary synced entry.
- Reads resolve aliases (chains followed; merge refuses cycles):
  - **Field defs**: values are read across all aliased keys; definition
    properties (name, type, options) come from the survivor only.
  - **Clowders**: membership entries pointing at the loser id resolve to
    the survivor — offline devices syncing old moves land correctly.
  - **Cats**: value/timeline union of both entity ids.
- **Survivor-wins for Cats and Clowders**: the merge operation re-asserts
  the survivor's current values as fresh entries at merge time, so
  latest-wins across the union shows the survivor's values; loser values
  fill only fields the survivor never had. Field *values* on cats skip
  this — there, plain latest-wins across aliased keys is the wanted
  behavior (same rule as any concurrent edit, conflict badge included).
- Field merges are **same-type only**; change the type or rename first
  otherwise. Choice options: survivor's list wins, aliased values that
  are no longer options still display as text.
- Irreversible, like cat Merge in CONTEXT.md. History keeps true authors
  and dates on both sides.

Write the ADR when this is implemented (it will qualify: hard to
reverse, surprising, real trade-off vs copy-based merge — copy was
rejected for fake history and offline-sync resurrection).

## Rest of M2 scope (from milestones)

- LAN device-to-device sync (delta exchange per ADR-0002)
- Conflict badges + one-tap promote
- Desktop (Linux/Windows/macOS) polish
