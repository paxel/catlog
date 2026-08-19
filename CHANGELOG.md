# Changelog

All notable changes to cat(a)log are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/).

## [0.1.4] - 2026-08-19

### Added

- Implausible starter-field values are refused with an explanation: birth or death dates in the future, death before birth, and pregnancy for a male cat.

### Fixed

- The month arrows in date fields no longer skip several months per tap.

- Android no longer offers cat(a)log when opening calendar links.
- Typing a date now shows the expected format when the input doesn't parse.
- Sharing photos, cards, sync bundles, and the CSV export works on iPad.
- Fixed an occasional crash while photos were still loading.
- Location features explain why no position is available (service off, permission denied, no GPS fix) and open the right settings screen.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
