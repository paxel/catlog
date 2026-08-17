# Changelog

All notable changes to cat(a)log are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/).

## [0.1.2] - Unreleased

### Added

- Install and update via any F-Droid client: add
  `https://paxel.github.io/catlog/fdroid/repo` as a repository — every
  release lands there automatically. (Same signature as the GitHub APKs;
  a Play-installed app must be uninstalled first, and vice versa.)

### Changed

- Crop and Mark screens confirm with a labeled button ("Crop" / "Save")
  instead of a bare checkmark — next to "Use full photo" it was not
  obvious the checkmark applies the drawn rectangle.

### Fixed

- The automatic backup on Android keeps its `.catsync` name — Android
  used to rename it to `.zip`, which piled up copies in Downloads/catlog
  instead of replacing the previous backup and broke opening the file
  with the app. Old `.zip` leftovers are cleaned up with the next backup.
- A fresh install no longer writes a backup of the still-empty catalog,
  which could shadow the backup that survived an uninstall.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
