# ADR-0008: Entry sequence numbers are monotonic per device, forever

## Status

Accepted

## Context

Every entry carries `(device, dseq)`: the device that wrote it and that
device's own sequence number. Sync is a delta exchange over version
vectors (ADR-0002) — a peer says "I have up to dseq N of device D" and
receives everything above it — and the pair is the unique key an import
deduplicates on.

The store allocated the next number as one above the highest surviving
row for the device. That is correct only while nothing is ever removed,
which is exactly what the append-only rule promises (ADR-0001). Hard
delete already broke it (ADR-0006): after removing the rows of an Author
whose name this device used to write under, the next entry is issued a
number a peer already holds with different content. The peer keeps its
copy, ignores the new entry as a duplicate, and the two catalogs silently
disagree for ever. Reverting to an earlier state — which physically
removes entries by design — would make the same failure routine rather
than rare.

## Decision

A device's sequence numbers only ever increase. The next number is one
above the device's **high-water mark**: the highest surviving row *or*
the highest number recorded as removed, whichever is greater. Any
operation that physically deletes entries records the highest number it
removed per device in the discard vector, which the version vector
already includes.

## Consequences

- Removing entries never lowers what this device claims to have seen, so
  peers stop offering the removed rows back — the re-import guard
  ADR-0006 asked for now applies to every physical removal, not only to
  banned material.
- Numbers may have gaps. Nothing reads them as a count; they are only
  ever compared.
- The high-water mark is device-local state. A catalog restored from a
  bundle rebuilds it from the entries it holds, which is safe: a restore
  brings numbers back rather than removing them.
