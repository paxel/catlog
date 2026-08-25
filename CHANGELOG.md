# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.0.1] - Unreleased

### Added

- "Add reminder" on cat and clowder pages and on the agenda: one
  dialog with field, due date, value and what a reminder is. Fields
  that state what a cat is — gender, breed, birth date, chip ID and
  the like — take no reminders.
- A "Planned" section on cat and clowder pages shows their live plans,
  with the same done, change-date and remove actions as the agenda —
  a plan on a field without a value is visible there too.

### Changed

- The reminder checkbox in the field editor is gone, and the "as of"
  date can no longer lie in the future — plans are made with Add
  reminder.
- The agenda has its own bell in the home bar on every screen size;
  Fields moved into the home menu.
- The calendar mirror is a visible switch at the top of the agenda. It
  asks which of the phone's calendars to use instead of creating a
  hidden local one, and says why when it cannot write — permission
  blocked, no calendar chosen, calendar gone.
- Tips introduce the agenda bell, Add reminder, the agenda's plus
  button and the calendar switch on first sight; the agenda has its own
  help page.

### Fixed

- Lists under a floating button scroll clear of it, so the last rows
  can be reached (Fields, Strays, Agenda).

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
