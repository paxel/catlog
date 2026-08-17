# Changelog

All notable changes to cat(a)log are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/).

## [0.1.3] - Unreleased

### Fixed

- No more crash when returning to the app after the system camera (or
  any other screen change) finished while the app was in the background.
- Stray Cam no longer loses the photo when Android closes the app behind
  the camera — the capture completes on the next start.
- Stray Cam creates the cat only once a photo was actually taken, so a
  canceled camera no longer leaves an empty stray behind.
- When location access is permanently blocked, Stray Cam explains it and
  offers to open the system settings instead of failing quietly.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
