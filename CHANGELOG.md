# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.1.4] - Unreleased

### Added

- A fresh install offers to restore the catalogs of the install
  before it: the backups now also live in a folder that survives
  uninstalling, and after the name step the app lists them, one per
  catalog, all ticked. Every file of a catalog is imported, newest
  first, so an older one can still supply a missing photo. The same
  page sits in Manage catalogs as "Restore backups…", with a file
  picker for backups kept elsewhere.

### Fixed

- A photo whose bytes never arrived shows a grey tile saying "Photo
  not received yet" and the same in the viewer, instead of an empty
  square and a black page.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
