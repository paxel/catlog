# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.4.0] - Unreleased

### Changed
- Shared folder sync is several times faster: a round skips the entries it already holds before checking them, and the lookups behind private and merged values are asked once instead of once per entry. A round with nothing new takes a sixth of the time, a first import a little over half.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
