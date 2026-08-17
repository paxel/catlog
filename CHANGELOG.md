# Changelog

All notable changes to cat(a)log are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/).

## [0.1.2] - Unreleased

### Added

- The app can be installed via F-Droid from the project's own repository.
- Cats have a Breed field with common breeds as choices; own entries can
  be added.
- Tapping a cat photo opens it full-screen with zoom and swiping; the
  photo menu (profile, crop, mark, delete) moved to long-press.

### Changed

- Crop and Mark screens confirm with a labeled button ("Crop" / "Save")
  instead of a bare checkmark.

### Fixed

- The automatic backup keeps its `.catsync` name instead of being renamed
  to `.zip`, replaces the previous backup instead of piling up copies,
  and cleans up old `.zip` leftovers.
- A fresh install no longer overwrites the surviving backup with an
  empty one.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
