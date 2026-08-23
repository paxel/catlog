# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [0.3.1] - Unreleased

### Changed

- Private now hides values, not cats and clowders. A private cat or
  clowder still reaches the people you sync with by name — what stays
  home is its address, its phone number, its photos. Single values can
  be kept back one at a time, with the lock beside the field, and a
  value someone kept back shows as withheld instead of as empty.

### Fixed

- Installing on Linux with Homebrew puts cat(a)log in the application
  menu, with its icon, and lets .catsync files open with it.
- What arrived after a sync or an import no longer counts the Fields
  themselves: an empty catalog arrives as nothing at all instead of as
  dozens of changes.
- A cat living in a private clowder arrives whole instead of vanishing:
  it used to reach the other device pointing at a clowder that was never
  sent, and then showed up on no screen at all.
- Sharing privately after sharing publicly reaches the other device.
  What was held back once used to stay unreachable for good, however
  often you shared again with private data included.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
