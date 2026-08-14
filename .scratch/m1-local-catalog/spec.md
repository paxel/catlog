# Spec: M1 — Local-only catalog with Cards

Status: ready-for-agent

## Problem Statement

A fosterer cares for ten cats that look very similar. She needs to keep track of who is who and what happened to each cat — gender, color, neutered, pregnant, medical dates — and produce presentable cards with a photo and the key facts, for adopters, vets, and notice boards. Today the options are paper, memory, or a spreadsheet; none of them handles photos well, none produces nice cards, and none keeps a history of what changed when.

## Solution

A Flutter app (iPhone first, Android alongside) holding a local catalog of Clowders and Cats. Every value a user enters is a dated, authored entry in an append-only log; the app always shows the latest value, and the full timeline of any field is one tap away. Each Cat has photos and a Card: a detail screen that exports as a shareable image or PDF and prints. No network, no account, no server — the device is self-sufficient. This milestone delivers the daily tool; sync between devices arrives in M2 on top of the same data model.

## User Stories

1. As a fosterer, I want to set my Author name once on first launch, so that every change I make is attributed to me when others later see the data.
2. As a fosterer, I want to create a Clowder with an address and a responsible person, so that I can represent my foster home.
3. As a fosterer, I want to edit a Clowder's values, so that a change of responsible person or address is recorded with its date.
4. As a fosterer, I want to add a Cat to a Clowder with a name and a photo, so that a new arrival is captured in under a minute.
5. As a fosterer, I want to add multiple photos to a Cat over time, so that I can tell look-alike cats apart and show their growth.
6. As a fosterer, I want the first photo to be the Cat's Profile Image automatically, so that lists stay visually stable.
7. As a fosterer, I want to pick a different Profile Image explicitly, so that the best photo represents the cat.
8. As a fosterer, I want photos compressed automatically on import, so that the catalog stays small without me thinking about it.
9. As a fosterer, I want a starter set of Fields (gender, color, neutered, pregnant, birth date, deceased) available immediately, so that I can fill cards without configuration.
10. As a fosterer, I want to define my own global Field with a type (text, yes/no, date, number, choice, location), so that I can track things the developers never thought of, like flea treatments.
11. As a fosterer, I want to set a Field value on a Cat, so that the card shows current facts.
12. As a fosterer, I want to backdate an entry (e.g. "spayed on 3 May"), so that the timeline reflects reality, not data-entry day.
13. As a fosterer, I want every change kept as history with date and Author, so that nothing is ever silently lost.
14. As a fosterer, I want to see a Cat's timeline — all field changes in date order, so that I can answer "when was she spayed, when did she move".
15. As a fosterer, I want to see a single Field's history for a Cat, so that I can trace one attribute, like weight over time.
16. As a fosterer, I want to see the Cats of a Clowder as a grid of Profile Images with names, so that I recognize each cat at a glance.
17. As a fosterer, I want to search Cats by name across all Clowders, so that I find one of ten look-alikes quickly.
18. As a fosterer, I want to Move a Cat to another Clowder, so that adoption is one action and appears in the timeline.
19. As a fosterer, I want to record a Cat leaving with no destination, so that a run-away is honestly tracked as a Stray.
20. As a fosterer, I want to see a list of Strays (Cats currently in no Clowder), so that they don't vanish just because no map exists yet.
21. As a fosterer, I want to view a Cat's Card with photo and current field values, so that all key facts sit on one screen.
22. As a fosterer, I want to export a Card as an image, so that I can send it to a potential adopter in a messenger.
23. As a fosterer, I want to export a Card as a PDF and print it, so that I can pin it at the vet or on a notice board.
24. As a fosterer, I want to delete a photo so that its data is really gone, so that a bad or accidental shot doesn't linger.
25. As a fosterer, I want to delete a Cat, so that a mistaken record doesn't pollute my lists.
26. As a fosterer, I want to delete a Clowder whose Cats fall out as Strays, so that I can wind down a location without losing its cats.
27. As a fosterer, I want to record a death as a dated field, so that the cat's story stays complete instead of being deleted.
28. As a fosterer, I want the app to work with no network, account, or server, so that my data stays mine and the tool costs nothing to run.
29. As the developer, I want the iOS build produced by CI and delivered via TestFlight, so that the fosterer's iPhone gets updates without me owning a Mac.
30. As a future contributor, I want the repo public under Apache-2.0/MIT dual license, so that others can use and extend the tool.

## Implementation Decisions

- One Flutter/Dart codebase; M1 targets iOS (primary, the fosterer's device) and Android (developer's device). Desktop targets compile but are not polished in M1.
- All domain logic lives in a **catalog core**: a pure Dart module with no Flutter imports, owning the append-only entry log over SQLite (per ADR-0001). The UI talks only to its API; M2 sync will plug into the same API.
- The unit of data is the entry `(entity, field, value, date, author)`. Entries are never updated or removed; deletion is a propagated marker entry. Image deletion additionally erases the photo bytes.
- Displayed state is a projection: newest entry per (entity, field) wins, deterministic tiebreak (timestamp, then author name), per ADR-0001. Single device in M1 means conflicts cannot yet occur, but the projection rule ships now so M2 changes nothing.
- Field definitions are themselves entries (global, typed: text, yes/no, date, number, choice, location). The starter set is seeded on first launch as ordinary entries.
- Clowder membership is an ordinary field on the Cat; Move, Adoption, and Stray fall out of it. Clowder attributes (address, responsible person) use the same Field mechanism.
- Images are stored as files next to the database, content-addressed, compressed on import to 2560 px long edge; entries reference images by content hash. Profile Image is a field defaulting to the first image.
- Author name is a device-level setting captured on first launch, stamped on every entry.
- Card export renders the detail view to a shareable image and a PDF via the platform share/print sheets.
- Entry timestamps and the log layout must already satisfy the delta-sync contract of ADR-0002 (per-device log identity, ordered entries), even though no transport ships in M1.
- iOS builds run on GitHub Actions macOS runners and distribute through TestFlight under the paid Apple Developer account (per ADR-0003).

## Testing Decisions

- Tests assert external behavior at the catalog core API against a real in-memory SQLite database — never implementation details, never mocks of the store. Example shape: "rename a cat twice → latest name shows, both renames appear in the timeline with dates and authors."
- Coverage at this seam: entry append and projection (latest-wins, tiebreak), field definitions and types, backdating, timelines, membership/Move/Stray transitions, deletes (including clowder-delete → strays, image marker), starter-set seeding, search.
- Flutter widget smoke tests only for the main flows: create clowder, add cat with photo, edit field, open card. No pixel/golden tests.
- Card image/PDF/print output is verified manually — judged by eye, brittle to automate.
- Greenfield repo: no prior art; these tests establish the house style.

## Out of Scope

- Any sync: LAN device-to-device, cloud folder, delta protocol (M2/M3 — but the data model must not preclude them).
- Conflict badges and promote-to-current UI (impossible on a single device; M2).
- Cat Merge (M2).
- Map, movement trails, Stray Cam, geocoding (M3).
- CSV / closed-software export (backlog).
- Encryption of stored or synced data (open item).
- Litter as a "born together" link (reserved term, unscheduled).
- Field definition editing/deduplication (Color vs. Colour cleanup) beyond creating fields.
- In-app purchases, donations, App Store publication (TestFlight only for now).

## Further Notes

- Vocabulary in UI and code follows `CONTEXT.md` (Clowder, Cat, Stray, Move, Card, Field, Author, Profile Image). The word "litter" must not appear as a housing group anywhere.
- ADRs 0001–0003 bind this spec: append-only/latest-wins model, serverless sync trajectory, Flutter with CI-built iOS.
- Deferred open items tracked from grilling: cloud-file encryption, field-def duplicates, tombstoned-image garbage collection, export formats for shelter software.
