# ADR-0010: Segmented folder files

## Status

Accepted

## Context

Shared-folder sync (ADR-0002) had every device rewrite one file with its
whole history on every round, and every reader parse each foreign file
whole before applying the version-vector delta. The file-sync services
underneath move files, not lines: Syncthing sends any file under 128 kB
whole on every change, and a catalog's file is a few tens of kilobytes.
So a single chore tick shipped the whole history, once per round, to
every partner.

That was bearable while a round was a tap or a five-minute timer. Two
keepers working one checklist need a tick on the other phone within a
minute, which means publishing seconds after the change and looking at
the folder every half minute — and shipping the whole history that often
is not bearable.

A "today" file merged into the full file after a day was considered: it
makes both files travel once a day and needs every device to handle the
merge moment. Appending to the single file was considered: below 128 kB
Syncthing sends it whole anyway, so nothing is won until the history is
large.

## Decision

A device's history in the folder is a run of **segments**,
`<device>.<n>.seg`, one entry per line in the JSON Lines format the
whole-history file used. The device appends to the highest-numbered
segment and opens the next once the current one passes a size cap
(64 kB, about two hundred entries). A full segment never changes again,
so it never travels again. Segments are never merged.

Beside them the device writes a **manifest**, `<device>.manifest`: the
format version, its full version vector (the discard vector of ADR-0008
included, so removed numbers stay claimed), the segments in order with
the line count each held, and a `generation`.

A reader keeps, per writer, the generation it read and the lines it took
from each segment. A round reads the manifest, then only the segments
whose announced count is past what it took, from that line on. The
manifest's vector is the writer's causal context for conflict flagging
(ADR-0001); a single segment never is. A segment the manifest announces
that is missing or shorter than announced is a delivery in progress: the
writer's files are left for the next round.

History shrinks only by going back (ADR-0009), hard delete (ADR-0006)
and "keep mine". Then the device rewrites all its segments from the
start and bumps the manifest's `generation`; a reader that sees a new
generation forgets its line counts for that writer and reads afresh. The
exact held-set dedup in the store keeps that cheap and safe.

Segments and manifests wear names a reader from before ignores. An
updated device leaves its whole-history file frozen in the folder until
every other device in the folder has a manifest, then deletes it; until
then it names the devices still writing the old layout, so the group
knows who needs the update. Devices without a manifest are still read by
their whole-history file, as before.

The Dart core and the desktop core implement the same layout, names,
manifest fields and generation rule, and both sort directory listings
the same way.

## Consequences

- A tick travels as one small file change: the open segment and the
  manifest. Full segments never travel again.
- Reading is proportional to what is new, not to the history.
- The manifest answers "is this folder state complete?" that the size
  baseline of the folder watch only approximated: an announced segment
  that is not there yet is not read as an empty history.
- A folder holds one file per segment per device; the number grows with
  the history, slowly.
- A mixed-version folder is one-directional for a while: updated devices
  read old ones, old devices see nothing new from updated ones until they
  update. The frozen legacy file keeps what they had.
