# Spec: M2 — Sync, conflicts, merge

Status: ready-for-agent

## Problem Statement

The fosterer's iPhone and the developer's Android each hold a catalog, but they cannot talk to each other. Two people caring for the same cats end up with diverging data and no way to combine it — the exact spreadsheet problem the app was built to kill. Duplicates (same cat, same clowder, same field created twice) have no remedy, and concurrent edits are invisible.

## Solution

Devices sync directly over the local network: one device hosts, the other joins with a short code shown on screen. Sync is a delta exchange of missing entries and photos per ADR-0002 — order-independent, always converging, no server. Where two people changed the same field concurrently, the app shows a conflict badge; one tap shows both values and lets anyone promote the loser — as a new history entry, never rewriting the past (ADR-0001). Duplicates of any kind — Cats, Clowders, Fields — are merged alias-style per the parked design in `.scratch/m2-notes.md`. Desktop (Linux/Windows) builds ship from CI so the PC becomes a real device in the mesh.

## User Stories

1. As a fosterer, I want to sync my phone with my friend's phone over the house Wi-Fi, so that we both see all cats without any cloud.
2. As a fosterer, I want to start a sync by typing a short code shown on the other device, so that pairing needs no account or setup.
3. As a fosterer, I want sync to transfer only what the other device is missing, so that it is fast even with many photos.
4. As a fosterer, I want photos to arrive with the data, so that cards look right on every device.
5. As a fosterer, I want deletions and merges to propagate, so that a cleaned-up catalog stays clean everywhere.
6. As a fosterer, I want a badge where two people changed the same thing at the same time, so that silent overwrites never happen.
7. As a fosterer, I want to see both conflicting values with author and date and promote one, so that the truth is a human decision recorded in history.
8. As a fosterer, I want to merge two records of the same cat, so that duplicate registrations collapse into one full history.
9. As a fosterer, I want to merge duplicate clowders and duplicate fields (Number of legs / Limbs), so that vocabulary stays clean after syncing with someone else.
10. As a fosterer, I want every device to end up with identical data regardless of sync order, so that there is no "main" device (ADR-0001).
11. As a user of the PC app, I want Linux and Windows builds from CI, so that the desktop is a first-class sync peer.
12. As a fosterer, I want to see when the last sync with a device happened, so that I know how fresh my data is.

## Implementation Decisions

- **Device identity**: each installation gets a random device id at first open, stored in local settings. Entries gain `(device, dseq)` — the origin device and its per-device monotonic counter. `(device, dseq)` is unique; imports are idempotent upserts on that key.
- **Deterministic ordering fix**: the latest-wins tiebreak becomes (date, recorded, author, device, dseq) — device-stable, so every device projects identical state. The local autoincrement `seq` remains only as a local handle (revert, UI).
- **Migration**: existing databases get the two columns backfilled with the local device id and `dseq = seq`.
- **Sync engine (core, transport-agnostic)**: version vector = max dseq per known device. Protocol: exchange vectors → send entries above the peer's vector → exchange referenced-but-missing blob hashes → transfer blobs. Both directions in one session.
- **Conflict detection at import**: when an imported entry competes for a field where the local latest came from a different author and neither supersedes the other trivially (import does not simply extend the top), the field is flagged in a device-local (unsynced) conflicts table. The badge clears when someone views and confirms/promotes. Promotion appends an ordinary entry.
- **LAN transport**: host opens an HTTP server (dart:io) on a random port and shows `ip:port` plus a 6-digit PIN; joiner enters both (mDNS autodiscovery may fill the address when it works). The PIN authenticates the session as a shared-secret header. Trusted-group threat model: the PIN prevents accidents, not attackers on the LAN.
- **Merge (alias)**: per `.scratch/m2-notes.md` — `mergedInto` entry on the loser; reads resolve alias chains (cycle-refusing); survivor re-asserts its current values at merge time for Cats and Clowders; field merges same-type only; irreversible.
- **Merge UI**: from a Cat/Clowder/Field, "Merge into…" picks the survivor from a list; confirm dialog spells out irreversibility.
- **Desktop**: CI builds Linux and Windows bundles as artifacts on tag releases; minimal polish only (sane default window size).
- iOS local-network permission strings added; transports degrade gracefully when the platform denies sockets.

## Testing Decisions

- Core seam only, as in M1: two (or three) in-memory stores syncing through the engine's API directly — no network in tests. Convergence assertions: same projection on every store regardless of sync order (A→B→C vs C→B→A).
- Conflict tests: concurrent edits on two stores, sync, badge present, promote, badge cleared, third device converges.
- Merge tests: alias resolution across sync (merge on A, values entered on B pre-sync land on the survivor after sync); field merge value union; cycle refusal.
- Transport gets one thin integration test over localhost HTTP; everything else stays at the engine seam.
- Widget smoke tests: sync screen host/join flow (mocked engine), conflict badge and promote dialog, merge dialog.

## Out of Scope

- Cloud-folder transport (M3).
- Map, Stray Cam, trails, CSV (M3).
- Encryption of sync traffic (LAN, trusted group; revisit with the cloud transport).
- Automatic/background sync — sync is a user action in M2.
- Undoing a merge.

## Further Notes

- ADR for the alias merge to be written during implementation (per m2-notes).
- The sync engine API is the seam the M3 folder transport reuses unchanged.
