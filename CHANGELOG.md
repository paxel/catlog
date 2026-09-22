# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.2] - Unreleased

### Fixed
- On Linux the desk's menu entry shows the cat icon, on KDE as on GNOME. The entry names the icon by its theme name and a 256 pixel PNG sits where every desktop looks; 2.0.1 pointed the entry at an SVG file inside the Homebrew prefix, which drew nothing. The desk also keeps its own launcher entry, icon and `.catsync` file type current in the application menu on every start, so a Homebrew, tarball or AppImage install is in the menu with its icon after one start, and a moved binary heals its entry itself.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
