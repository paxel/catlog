# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.1.1] - Unreleased

### Changed

- "Find address on the map" no longer writes silently: a dialog shows
  the place it found and asks whether to save the location and whether
  to replace the typed address with the found wording.
- Language, units, celebrations, notifications and the tutorial
  replays moved from the menu and the About page into a Settings page
  in the main menu.
- Each catalog has its own settings page, opened from its row in the
  catalog switcher: name, cats or pets, fields, authors and bans,
  archive, go back, delete. It works on that catalog whether or not you
  are in it. Those items left the menu, the About page and the top of
  the switcher.

### Fixed

- Panning the map away from a still-loading tile no longer records a
  crash when the tile arrives.
- The fur coat behind a page scrolls with the page instead of staying
  put under the moving content, and each page keeps its own position
  when you come back to it.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
