# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.0.7] - Unreleased

### Changed

- Stray Cam, the camera and gallery picker, the code scanner, "my
  location", printing, sharing and links run one at a time: a second
  press while one is still working does nothing, and the Stray Cam
  button shows a spinner meanwhile. A plugin error shows its message
  instead of a crash. The Strays help explains tap versus press-and-hold
  on Stray Cam.

### Security

- A photo name inside a shared file or from a sync partner can no
  longer point outside the catalog's image folder — reading or
  deleting a photo needs a real hash.

### Fixed

- Backups, shared files and archives with many photos no longer need
  twice the photos' size in memory while being written — the automatic
  backup on leaving the app could kill it on a phone with a big catalog.

- Pressing Stray Cam again while the GPS fix was still pending crashed
  the app on return from the camera ("Image picker is already active").
- Scrubbing through a filmed video on an iPad could end in "Stream has
  been disposed": the frame picker now keeps one image per frame and
  decodes a preview before showing it.
- Filming with Stray Cam (press and hold) killed the app on iPhones:
  the frame picker held a dozen full-size frames at once. It now works
  at preview size and fetches only the kept frames at photo size.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
