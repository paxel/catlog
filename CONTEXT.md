# cat(a)log

A local-first, multi-device catalog for people fostering cats. Small mutually-trusting groups (2–5 people) track cats, where they live, and how their attributes change over time — no central server.

## Language

**Clowder**:
A group of cats living at one place, with an address and a responsible person. Foster homes and adopters' homes are both Clowders.
_Avoid_: litter, home, placement, household, group

**Cat**:
An individual animal being tracked, with a name, images, and field values that change over time.

**Litter**:
Kittens born to the same mother in one birth. Not stored — derived: same Mother and same birth date. Never a housing group.

**Mother / Father**:
Starter Fields of type cat-reference linking a Cat to its parents. Family relations — littermates, siblings, kittens — are derived from Mother plus birth date; Father is display and navigation only.

**Stray**:
A Cat currently in no Clowder; tracked by map positions instead. A state, not a kind — any Cat becomes a Stray by leaving its Clowder (running away, Clowder deleted) and stops being one on a Move into a Clowder.

**Catalog**:
Everything one body of work holds: its Cats, Clowders, Fields, photos, sync partners and map position. A device can hold several, and nothing is shared between them — two cities stay apart. The app's own settings (author name, language, tips already seen) are shared by all of them. One Catalog is open at a time; its name is the title of the home screen.
_Avoid_: database, profile, workspace, account

**Moment**:
A point a Catalog can be returned to, recorded before anything that changes a lot at once — an import, a sync, a Merge, an Archive — or marked by hand with a name. It is a mark in the log, not a copy. Going back to one removes everything written after it, having written that to a file first.
_Avoid_: snapshot, save point, restore point, checkpoint

**Crop**:
Cutting one cat out of a photo. Happens in the import flow (skippable; Stray Cam skips it) or later from the photo menu; cropping later adds the cropped copy as a new photo, the original stays.

**Mark**:
A highlight (ellipse/arrow) baked into a copy of a photo to point at one cat when cropping cannot isolate it — an ordinary new photo, synced and printed like any other.

**Flier**:
A missing-cat poster captured into the catalog. Capturing one creates a Missing Cat plus its owner's Clowder, and the place it was photographed becomes a Flier Position on that cat.
_Avoid_: poster, notice, report

**Missing Cat**:
A Stray known only from a Flier — no sighting yet. Its history records leaving the owner's Clowder on the missing-since date; it stops being missing the ordinary way, by a Move or a Merge with a sighted cat.
_Avoid_: lost cat record, flier cat

**Flier Position**:
The place a Flier was photographed — where the poster hangs, not where the cat was seen. Never shown as a sighting pin; it only anchors the Possible Stray Area.

**Possible Stray Area**:
A toggleable map overlay for a Missing Cat: the union of 500 m circles around its Flier Positions, marking where the cat is likely to roam (three quarters of lost cats are found within 500 m).
_Avoid_: search radius, home range

**Stray Cam**:
One-tap capture of a new Stray: creates the Cat at the device's current position with a photo (system camera or picked from the device), no further input required.

**Merge**:
Combining two records of the same real thing — Cat, Clowder, or Field. The user picks the survivor; the survivor's current values win, the other record's history joins the survivor's timeline, the other record ceases to exist. Irreversible.

**Card**:
The presentation of one Cat — as a detail screen in the app, and as a shareable/printable export (image or PDF) with photo and current field values.

**Profile Image**:
The one image of a Cat shown in lists and on its Card; choosable, defaults to the first image.

**Field**:
A typed, user-defined attribute (text, yes/no, date, number, choice, location, ID) attachable to Cats and Clowders. Definitions are global to the catalog; values carry a date and an Author, and every change is kept as history.
_Avoid_: property, column, tag

**ID Field**:
A Field type holding an external identifier, entered by hand or camera scan and shown on the Card in a display format picked at field creation (plain, QR, or barcode). ID values match other records exactly or not at all — never fuzzily.
_Avoid_: code, reference number

**Chip ID**:
A starter ID Field on Cats for the 15-digit transponder number. The prime exact-match key between a Missing Cat and a found cat.
_Avoid_: microchip number, transponder

**Remarks**:
A starter multiline text Field on Cats and Clowders for free notes — including text read off a Flier.
_Avoid_: notes, comments, description

**Move**:
A change of a Cat's Clowder membership, recorded as a dated field change like any other. A Cat's movement history is the history of this field. Always within one Catalog.

**Transfer**:
Taking a Cat, or a Clowder with the Cats living in it, out of one Catalog and into another. Not a Move — it crosses Catalogs and re-stamps the entries under the destination's device, so the two Catalogs can never re-merge through a shared sync partner. The interface says "move to another catalog", because that is what a keeper sees; the model calls it a Transfer.

**Adoption**:
A Move into a Clowder whose Status is forever home. Not a stored status on the Cat — there is no "adopted" flag.
_Avoid_: adopted state, adoption record

**Author**:
The self-chosen name a device carries; every change is attributed to an Author. There are no accounts and no authentication.

**Status**:
A Clowder Field with suggested canonical values (foster, forever home, clinic/vet, shelter, barn, owner) the app recognizes for display and behavior (e.g. Adoption). Free text beyond the suggestions is allowed and stays an ordinary value.
_Avoid_: clowder type, category

**Private**:
A marker on a **value** — this cat's phone number, that clowder's address — keeping that value off the wire by default. Privacy is about doxing, not about hiding that a cat or a clowder exists: entity id, kind, name and Clowder membership always travel, so nothing a partner receives ever points at something they have never heard of. A withheld value leaves a `$withheld:<field>` trace behind, so the slot reads as redacted rather than empty, and the value itself arrives later if a private-included sync ever carries it. Marking a Cat or Clowder Private marks every value it carries and every value it gets while the mark is on; marking a Field definition Private marks that field on every entity. Every share/sync offers "public only" (default) or "include private"; the markers themselves travel only in private-included syncs. Trust is decided per handshake by the human, not by the system.
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
