# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [0.2.1] - Unreleased

### Added

- Photos can be shared into cat(a)log from any other app — Immich,
  Signal, a browser — single or a whole batch: pick the cat they belong
  to, or a new stray (Android).

### Changed

- Chip scanning is labeled "Scan printed code" and explains that the
  implanted chip itself can't be read by a phone.

### Fixed

- Cat and clowder pages refresh immediately after a revert on the
  timeline or photos extracted from a video — no reopening needed.
- Scrubbing through a video shows the frame at the current position
  right away, not only after keeping it.
- With 3-button navigation the system bar no longer floats over the
  app's bottom buttons.
- A chip barcode on the Card appears once: the code with its printed
  number, without the repeating fact row and caption (QR codes keep one
  caption line, they carry no readable number).

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
