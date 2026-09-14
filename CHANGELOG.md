# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.3.4] - Unreleased

### Changed
- The line about waiting changes can be swiped away or closed with its X; it comes back when more arrives.

### Fixed
- Photos no longer carry the camera's metadata, so where a picture was taken does not travel to the shared folder; the photos already stored are rewritten without it at the next start. Android alters such files when another app reads them, which is why photos with a location never arrived on a second phone through the folder.
- The Sync button on the shared folder page shows a moving bar and "Syncing with the folder…" until the round is done.
- Photo files that reach the shared folder after the entries are fetched by the next round of the folder watch, without a tap; the sync result says how many photos are not in the folder yet, and why each one that is there could not be taken.
- The line at the top says "Syncing with the folder…" with a progress bar while a tapped sync runs, instead of staying silent until it is done.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
