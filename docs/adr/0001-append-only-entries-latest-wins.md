# Append-only entry log, latest-wins display, no primary device

The whole catalog is an append-only set of entries `(entity, field, value, date, author)`; a device's state is the union of all entries it has seen, and merging two devices is a set union that always succeeds. The displayed value of any field is the newest entry (deterministic tiebreak on timestamp, then author name), so every device converges to the same state without a privileged "main" device; concurrent edits surface as a conflict badge, and "resolving" one simply writes a new, newer entry. We chose this over a blocking pick-the-winner flow (stalls sync on human attention) and over a designated main device (offline main blocks everyone). Nothing is ever overwritten: renames, moves, adoptions all remain visible as the field's timeline.

## Consequences

- Deletion is a propagated marker, not a removal of entries; image deletion additionally drops the photo bytes everywhere.
- Cat merge is expressed on top of this model and is irreversible by design (survivor's current values win, both histories combine).
- Storage only grows, which is acceptable at the target scale (tens of cats, small groups); images are the only meaningful volume and are compressed on import.
