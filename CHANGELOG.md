# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.3.0] - Unreleased

### Changed
- Frames kept from a video — for a cat or a new stray — offer the crop step one after the other before they are stored, cut from the frame at the video's full size. A cat cut out of a 4K video keeps far more detail than when cropped later from the stored photo. "Use full photo" keeps a frame whole; Cancel drops only that frame.

### Fixed
- A flier reads more of the ways people write a date by hand: 03-10-2025, 03.10.25, "3. Oktober 2025", "Oct 3, 2025", and 3.10. without a year, which counts as the latest such day that has already passed.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
