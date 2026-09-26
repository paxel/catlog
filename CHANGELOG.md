# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.5] - Unreleased

### Fixed
- Tile on the desk lays a real grid again: columns from the desk's width, rows sharing what is left above the dock. It used to start the second row below the tallest card, which pushed those cards off the desk, where egui pinned them and no hand could drag them back. No card is ever laid down past the desk's edge now, whichever way it was arranged.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
