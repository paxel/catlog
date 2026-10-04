# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.3.0] - Unreleased

### Changed
- Frames kept from a video — for a cat or a new stray — offer the crop step one after the other before they are stored, cut from the frame at the video's full size. A cat cut out of a 4K video keeps far more detail than when cropped later from the stored photo. "Use full photo" keeps a frame whole; Cancel drops only that frame.

### Changed
- When a flier gives no ran-away date, its "Missing since" tile says "Not found on the flier — today" with a warning sign, so a guessed day no longer looks like one that was read.

### Fixed
- A hand-made flier finds its ran-away date: a line saying "weggelaufen am", "entlaufen", "vermisst seit", "verschwunden seit", "missing since" or "lost on" gives the date on it or on the line right after it. Before, only the TASSO poster layout was read, and a hand-made flier's cat went missing today.
- A flier added to a cat you already have, with its home picked, dates the cat's move home and its running away to the flier's day, and shows the "Missing since" tile to check it. Before, both moves were dated the day the flier was added.
- Merging two cats no longer moves the merged cat back home. The most recent move of either cat, by its own date, decides where it is, so a flier's stray keeps its ran-away day when merged into the cat already in the catalog. On phone and desk.
- A flier reads more of the ways people write a date by hand: 03-10-2025, 03.10.25, "3. Oktober 2025", "Oct 3, 2025", and 3.10. without a year, which counts as the latest such day that has already passed.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
