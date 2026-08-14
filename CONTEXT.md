# cat(a)log

A local-first, multi-device catalog for people fostering cats. Small mutually-trusting groups (2–5 people) track cats, where they live, and how their attributes change over time — no central server.

## Language

**Clowder**:
A group of cats living at one place, with an address and a responsible person. Foster homes and adopters' homes are both Clowders.
_Avoid_: litter, home, placement, household, group

**Cat**:
An individual animal being tracked, with a name, images, and field values that change over time.

**Litter**:
Kittens born to the same mother in one birth. Reserved for a possible future "born together" link between Cats — never a housing group.

**Stray**:
A Cat currently in no Clowder; tracked by map positions instead. A state, not a kind — any Cat becomes a Stray by leaving its Clowder (running away, Clowder deleted) and stops being one on a Move into a Clowder.

**Stray Cam**:
One-tap capture of a new Stray: creates the Cat at the device's current position with a photo (system camera or picked from the device), no further input required.

**Merge**:
Combining two Cat records of the same real cat. The user picks the survivor; the survivor's current values win, the other record's history joins the survivor's timeline, the other record ceases to exist. Irreversible.

**Card**:
The presentation of one Cat — as a detail screen in the app, and as a shareable/printable export (image or PDF) with photo and current field values.

**Profile Image**:
The one image of a Cat shown in lists and on its Card; choosable, defaults to the first image.

**Field**:
A typed, user-defined attribute (text, yes/no, date, number, choice, location) attachable to Cats and Clowders. Definitions are global to the catalog; values carry a date and an Author, and every change is kept as history.
_Avoid_: property, column, tag

**Move**:
A change of a Cat's Clowder membership, recorded as a dated field change like any other. A Cat's movement history is the history of this field.

**Adoption**:
A Move into an adopter's Clowder. Not a stored status — there is no "adopted" flag.
_Avoid_: adopted state, adoption record

**Author**:
The self-chosen name a device carries; every change is attributed to an Author. There are no accounts and no authentication.
