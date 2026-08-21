# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [0.3.0] - Unreleased

### Added

- Several catalogs on one device. The home screen's title names the
  catalog you are in; tapping it switches, adds one, or renames one.
  Each catalog keeps its own cats, clowders, fields, photos and sync
  partners, while your name, your language and the tips you have seen
  are shared by all of them. Deleting a catalog writes a complete file
  where the automatic backups go before anything is removed, and asks
  you to type its name. Each catalog's automatic backup is its own file,
  named after the catalog.

### Changed

- On a tablet or a desktop window, the clowder table uses the whole
  width instead of being squeezed into the list column; opening a row
  shows the clowder over the table.
- Tutorial tips sit beside what they highlight instead of stretching
  across the screen, and no longer draw an arrow that pointed at empty
  space on tablets.

### Fixed

- On a tablet or a desktop window, Strays, Search, Find duplicates and
  Fields open beside the list of clowders instead of covering it.
- Long cat and clowder names are readable on a phone again: the title
  moved to its own line instead of being cut to a few letters by the
  buttons beside it.
- Entries written after deleting an author's data reach the people you
  sync with again, instead of being silently ignored as something they
  already had.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
