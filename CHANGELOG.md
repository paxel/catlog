# Changelog

All notable changes to cat(a)log are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/).

## [0.1.3] - 2026-08-18

### Added

- The option list of a choice field (e.g. Breed) can be edited from the
  Fields screen.

### Changed

- The map no longer rotates on a two-finger twist; north stays up.

### Fixed

- No more crash when returning to the app after the system camera (or
  any other screen change) finished while the app was in the background.
- Stray Cam no longer loses the photo when Android closes the app behind
  the camera — the capture completes on the next start.
- Stray Cam creates the cat only once a photo was actually taken, so a
  canceled camera no longer leaves an empty stray behind.
- When location access is permanently blocked, Stray Cam explains it and
  offers to open the system settings instead of failing quietly.
- Opening a `.catsync` file now actually imports it — 0.1.2 only made
  the app appear in the chooser.
- Breed choices display in the device language (e.g. "Europäisch
  Kurzhaar" on German devices).
- A failed automatic backup is shown on the Sync screen instead of
  disappearing silently.
- Each Sync-screen section shows its own result — a folder sync no
  longer reports under the QR section.
- Swiping through the full-screen gallery no longer flickers.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
