# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.0] - Unreleased

### Added
- The desktop app is new, written in Rust: a master-detail window with a menu bar over the same Catalogs, shared folders and `.catsync` bundles the phones use. Clowders, Cats and Strays with their Fields, photos with crop and mark, chores with the agenda and desktop reminders, appointments and Vet Runs, the map with sightings and stray areas, the sync pages with the watch line and the conflicts page, duplicates with Merge and Transfer, Moments with going back, automatic backups with restore, archiving, the authors page with bans, the Card, the missing poster with its QR code and the report for the vet as PDFs, flier capture from an image file, achievements with the cheers, tips, help and settings. Linux ships as tar.gz, .deb and AppImage, Windows as a zip through Scoop, macOS as a dmg through the Homebrew cask.

### Removed
- The Flutter desktop targets. Their data stays where it was; the new app keeps its own data under the same app id in a `v2` folder.

### Added
- Duplicate in a chore's editor: pick the cat or home the copy is for and a new editor opens with the same title, schedule, time and reminder, over the original, so every kitten gets its feeding with one pick and one Save each.

### Fixed
- A battery saver closing the app in the background no longer brings the crash report on the next start. On Android 11 and newer the app asks the system why it was ended and offers the report only after a crash, a freeze, or a memory kill while it was on screen; the report names the system's reason.

### Changed
- The flier text page shows one card per line, the text as wide as the page, the target under it; the X or a swipe puts a line aside, Undo brings it back. Links on the text and registry pages and in the remember-service dialog show in full.
- Shared folder sync is several times faster: a round skips the entries it already holds before checking them, and the lookups behind private and merged values are asked once instead of once per entry. A round with nothing new takes a sixth of the time, a first import a little over half.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
