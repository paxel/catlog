# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.0.6] - Unreleased

### Added

- Date fields take a year or a month and year when the day is unknown
  — "2021" or "May 2021" is stored and shown as such, never as an
  invented first day. The flier wizard reads such dates from posters.
- A cat's age next to its birth date and in the strays list — "3 yrs
  5 mo", "3 yrs" for a bare birth year, frozen at death.
- The flier wizard can attach the poster to a cat or a clowder already
  in the catalog: pick them on the Cat page, and the poster's lines go
  where you assign them — clowder fields (address, phone, mail…) are
  in the dropdown too — with a note under any line that would
  overwrite a value.
- One cat list everywhere cats are listed — Strays, the cat search, a
  clowder's members via the list button on its page: list or table,
  sortable, with the cat fields you choose as columns, an Age column,
  and a text filter over names and values. The search now starts from
  all cats.
- "Find address on the map" under a clowder's address turns it into
  the clowder's position and names the place it found. The flier
  wizard's button now shows the found place too.

### Changed

- A stray's flier position shows on the map as a square pin with its
  face; sightings stay round. A cat known only from its poster is on
  the map now.
- "Show on map" from a cat's or clowder's page marks that spot with a
  highlighted pin. Cats of a clowder without a position pin at their
  own sightings. Cats sighted within 20 m of each other share one pin
  — one face, the name and "+2" — that opens the list of those cats.
- The card's QR code for a registry number (TASSO and the like) carries
  the registry's search link, so a phone camera opens the search;
  the caption still shows the number.
- The flier wizard's Flier text page offers "Drop" for any line, and a
  line sent to remarks arrives as its value alone — the poster's labels
  ("Geschlecht:") no longer fill the cat's and owner's remarks.
- Dates are typed — "14.05.2021", "05.2021" or "2021" — with the
  calendar behind an icon instead of a month grid filling the dialog.
  Reminders, appointments and "as of" dates use the same entry.

### Fixed

- The birth date printed on a TASSO poster fills the Birth date field
  instead of landing in remarks.
- Switching the catalog while the calendar mirror was still talking to
  the phone's calendar crashed the app ("database has already been
  closed").

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
