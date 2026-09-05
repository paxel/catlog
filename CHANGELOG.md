# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.1.2] - Unreleased

### Changed

- A found address reads the way its country writes addresses: street
  and number, then postcode and town ("Grimmaische Straße 12, 04109
  Leipzig"), number first where that is the custom. Towns and regions
  keep their full name.

### Fixed

- Photos picked from a video appear one by one as they are added,
  with a progress line, instead of all at once after a silent wait.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
