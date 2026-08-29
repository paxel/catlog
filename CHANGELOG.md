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
- "Find address on the map" under a clowder's address turns it into
  the clowder's position and names the place it found. The flier
  wizard's button now shows the found place too.

### Changed

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

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
