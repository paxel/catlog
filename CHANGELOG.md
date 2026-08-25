# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.0.0] - Unreleased

### Added

- Reminders: any field value can carry a future due date as a plan. A
  plan never becomes a fact — marking it done records the real
  treatment and can schedule the next cycle in days, weeks, months or
  years.
- Agenda: everything due across all cats and clowders in one dated
  list; overdue stays pinned on top until handled, and the agenda opens
  by itself when something is due within 3 days.
- Calendar: an opt-in mirror puts every due date into a cat(a)log
  calendar on the phone as an all-day event, and a calendar file
  (.ics) can be exported anywhere.
- A small cat ear in the corner marks everything that reacts to
  press-and-hold — cat tiles now open their menu on long-press too. A
  one-time tip explains the ear.

### Changed

- The map's buttons moved into one toolbar below the map: stray areas,
  my location, previous/next pin, and Stray Cam in one row — nothing
  covers the map anymore.
- Managing catalogs: tapping a catalog switches to it and stays on the
  screen, so several catalogs can be handled in one visit; the back
  button leaves.
- The sync format now carries reminders. Syncing and file exchange
  with 0.3.x devices keep working until the first reminder is used;
  from then on the other devices must update.

### Fixed

- The map no longer crashes ("Infinity or NaN toInt") when a search
  finds several hits on the same spot — and a map already stuck in
  that crash frees itself on the first open after this update.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
