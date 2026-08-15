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

**Crop**:
Cutting one cat out of a photo. Happens in the import flow (skippable; Stray Cam skips it) or later from the photo menu; cropping later adds the cropped copy as a new photo, the original stays.

**Mark**:
A highlight (ellipse/arrow) baked into a copy of a photo to point at one cat when cropping cannot isolate it — an ordinary new photo, synced and printed like any other.

**Stray Cam**:
One-tap capture of a new Stray: creates the Cat at the device's current position with a photo (system camera or picked from the device), no further input required.

**Merge**:
Combining two records of the same real thing — Cat, Clowder, or Field. The user picks the survivor; the survivor's current values win, the other record's history joins the survivor's timeline, the other record ceases to exist. Irreversible.

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
A Move into a Clowder whose Status is forever home. Not a stored status on the Cat — there is no "adopted" flag.
_Avoid_: adopted state, adoption record

**Author**:
The self-chosen name a device carries; every change is attributed to an Author. There are no accounts and no authentication.

**Status**:
A Clowder Field with suggested canonical values (foster, forever home, clinic/vet, shelter, barn) the app recognizes for display and behavior (e.g. Adoption). Free text beyond the suggestions is allowed and stays an ordinary value.
_Avoid_: clowder type, category

**Private**:
A per-entity marker (Cat, Clowder, or Field definition) that keeps the entity and all its entries off the wire by default. Every share/sync offers "public only" (default) or "include private"; the marker travels only in private-included syncs, so receiving own devices withhold it too. Trust is decided per handshake by the human, not by the system.
_Avoid_: hidden (that's display-only), secret

**Hidden**:
A per-device display filter on an entity or Field definition. Hidden things are received, stored, and synced onward unchanged — they are only not shown. A "show hidden" toggle reveals them. Never leaves the device.
_Avoid_: blocked, private (that's wire-level)

**Deceased**:
A Cat whose deceased date Field is set. Rendered subdued (dimmed photo, localized "Deceased" chip — no religious symbols) and listed in the import summary.

**Species**:
A starter Field on Cats, default "cat", free values (dog, rabbit, …). The only concession to other animals — entities, Clowders, and the app's cat-themed language stay unchanged.

**Ban**:
A local, per-device list of Authors/devices and blob hashes whose material is dropped on receive (received and discarded — sync bookkeeping still advances). Never propagates to other devices. Reversible per entry.
_Avoid_: block (import filter sense), report

**Hard Delete**:
Physical removal of all entries and blobs of one Author/device from the local store — the sole exception to append-only history, for malicious or illegal content. Usually paired with a Ban so the material cannot return.
