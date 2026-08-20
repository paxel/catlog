# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [0.2.1] - 2026-08-20

### Added

- Photos can be shared into cat(a)log from any other app — Immich,
  Signal, a browser — single or a whole batch: pick the cat they belong
  to, or a new stray (Android).

- **Map, five wishes granted**: a my-location button; the map reopens
  where you left it; toggled stray areas show the missing cat's tappable
  face on every flier spot; searching an unknown name falls back to a
  place search ("Leipzig" now works, and the map zooms in on the found
  street or town instead of centering it in a country-wide view); and
  two arrows glide from pin to pin in nearest-neighbor order.

- **Archive old data** (About → Archive): deceased cats and empty
  clowders that have been quiet for years are written into a .catsync
  file you keep and then deleted — on your device and on every device
  you sync with. Importing the file brings them back. The page also
  shows what the catalog currently costs in database and photo space.
  Importing such a file into the catalog it came from asks whether the
  deleted entries should be restored — photos included.

- **Help on every page**: a "?" in the app bar explains what the page
  is for, what you can do there, and what tap and long-press do — plus a
  button that shows that page's tips again.

- **Flier scan is a wizard**: cat, owner, face crop, registry, and a
  final check — one step per page, so the profile picture and the
  poster's contact details no longer get skipped by accident. Phone and
  e-mail land in the owner's own fields, and the address can be turned
  into a position for the owner's card.

- Registry numbers from a poster: an ID field can carry a lookup link,
  so a Tasso number found on a flier is stored with the cat and opens
  the service in one tap. Links from other services are learned from
  the poster — name it once and the next flier fills itself.

- Clowders have Email and Phone fields — contacting the people behind a
  colony no longer means writing it into Remarks.

- The home a stray ran from counts as a search area of its own: its
  clowder's location gets the same 500 m circle on the map, and cats
  seen inside it turn up under possible matches.

- **Clowders as a table**: a toggle in the clowder overview switches
  between tiles and a sortable table — Name, Cats, and any clowder
  fields as columns of your choosing, strays pinned first; view, columns,
  and sorting are remembered per device.

### Changed

- Chip scanning is labeled "Scan printed code" and explains that the
  implanted chip itself can't be read by a phone.
- Dates display in the device's format everywhere (27.12.2010 instead
  of 2010-12-27).
- The Messenger sync card says it also imports received .catsync files.
- The intro pages, the tips and the sharing explanations are written in
  plain language: what each screen does and what happens when you tap.

### Fixed

- Mother and Father print the linked cat's name on the card instead
  of an internal id; a link that no longer resolves is left off.
- "Share publicly" honors Private everywhere: a private cat refuses to
  export (with the reason), a private clowder and private fields stay
  out of the share file and QR.
- Merging from Match candidates or Find duplicates asks the same
  cannot-be-undone confirmation as every other merge.
- Match candidates no longer pair up cats living in the same clowder —
  geo matching considers strays and missing cats only.
- Cat and clowder pages refresh immediately after a revert on the
  timeline or photos extracted from a video — no reopening needed.
- Scrubbing through a video shows the frame at the current position
  right away, not only after keeping it.
- With 3-button navigation the system bar no longer floats over the
  app's bottom buttons.
- A chip barcode on the Card appears once: the code with its printed
  number, without the repeating fact row and caption (QR codes keep one
  caption line, they carry no readable number).

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
