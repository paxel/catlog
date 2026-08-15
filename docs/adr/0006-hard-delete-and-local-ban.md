# ADR-0006: Hard delete and local-only ban as the append-only exception

## Status

Accepted

## Context

The store is append-only (ADR-0001): nothing is ever physically removed,
corrections are new entries. This breaks down when a group member injects
abusive or illegal material (worst case CSAM): tombstoning is not enough —
the material must not remain on disk and must not be passed on to peers.
At the same time the sync protocol re-offers anything a peer is missing,
so removal without a re-import guard is futile.

A propagated (synced) ban was considered and rejected: a ban that travels
lets any group member trigger content deletion on everyone else's device,
which is a worse weapon than the attack it defends against.

## Decision

1. **Hard delete**: a local operation that physically deletes all entries
   and blobs attributed to one Author/device from the store and disk. It
   is the sole exception to append-only history.
2. **Ban list**: a local, per-device list of Authors/devices and blob
   hashes. Banned material arriving via any transport is received and
   discarded — version-vector bookkeeping still advances, so peers do not
   re-offer it forever. Entries on the list are individually reversible.
3. **No propagation**: bans and hard deletes never sync. Group-wide
   removal happens by humans telling each other, each acting locally.

## Consequences

- Outbound is automatically clean after a hard delete: what does not
  exist cannot be synced.
- A banned author's later entries vanish silently on receive; the group
  must coordinate socially, the app does not do it for them.
- This is removal tooling, not detection: the app does not scan content
  and makes no legal guarantee.
