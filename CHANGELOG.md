# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.2.2] - Unreleased

### Added
- A chore's gap can be days, weeks, months or years: a vaccine every year, not every 365 days.

### Changed
- One shared folder carries all catalogs: each uses a subfolder named after it, and the folder page explains Syncthing for a folder without a cloud.
- A paused chore stays in sight everywhere, greyed and without its box, until resumed or ended.
- Today's chores are sorted by time, those without a time first; ticked ones grey out.

### Fixed
- Folder sync on Android works in any folder the picker grants, cloud folders included.
- Conflicts are raised only on fields a keeper can judge; two entries with the same value say so instead of showing two chosen boxes.
- History, arrivals and conflicts show a position as coordinates and plus code; privacy markers read as the field's name.
- A paused chore reads "Paused" on the cat's page, not "Pause"; End wears the bin icon.
- Choosing "Every…" for a new chore no longer crashes the editor.
- Ticking the day's last chore on a cat's or home's page celebrates too.
- The cheer clips are loud enough to hear on a phone speaker.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
