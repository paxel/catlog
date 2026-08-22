# ADR-0009: Going back to an earlier moment

## Status

Accepted

## Context

Everything the catalog holds is an append-only log (ADR-0001), and every
transport merges by set union (ADR-0002). That makes sync safe and makes
mistakes permanent: an import that brought in the wrong file, a merge, an
archive-and-delete — each changes many things in one tap, and the only
undo was per entry, in one entity's timeline. A tester asked the obvious
question: "can I delete the imported stuff again?" The honest answer was
no.

Copying the catalog before each of those operations was the alternative
considered and rejected: photos are nearly all of the bytes, so a copy
per moment would force a judgement about when a moment is "worth it" —
and the moment nobody marked is the one they need.

## Decision

A moment worth returning to is the log's high-water mark at that time.
Recording one costs a row; the entries written after it *are* the change,
and removing them *is* the way back.

Going back removes every entry after the mark. Before removing anything
it writes those entries — with the photo bytes they reference — to an
ordinary `.catsync` file in the place automatic backups go, so importing
that file puts everything back. If the file cannot be written, nothing is
removed.

This is the **second exception to append-only**, after the hard delete of
ADR-0006, and it obeys the same rule: the numbers of removed entries stay
claimed in the discard vector (ADR-0008), so this device never re-issues
one and peers stop offering the removed rows back.

## Consequences

- The mark is stable because `entries.seq` is `AUTOINCREMENT`: SQLite
  never re-uses a number after a delete, so an old mark keeps meaning the
  same moment. This is load-bearing, not incidental.
- Every moment newer than the one chosen goes with it — they live in the
  part of the log that no longer exists.
- The escape file keeps the original `(device, dseq)` of each row. It is
  a homecoming file for the catalog it was written from: matching keys
  make the restore exact and make a later deliberate re-import of the
  same material a no-op instead of a doubled history. Importing it into a
  *different* catalog would tell that catalog it has seen those devices —
  don't.
- A revert is local. Peers who already synced keep what they received;
  that cannot be unsent, and the confirmation says so.
- Undoing an import is not a fight with the network: the discard marks
  stop the same peer pushing it straight back, while a deliberate
  re-import of the same file still works, because imports are applied per
  row rather than filtered by version vector.
- Reverting the deletion of a photo can restore a reference whose bytes
  were dropped when that deletion propagated. That is the ordinary
  missing-blob situation and peers heal it.
