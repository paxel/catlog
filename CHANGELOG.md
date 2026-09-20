# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.1] - Unreleased

### Fixed
- On Linux the desk installed through Homebrew is in the application menu right after `brew install`, and its window shows the cat icon on Wayland; before, the menu entry had to be registered by hand and the window carried a generic icon. The `.deb` shows the icon on Wayland too. `catlog-install-icon --uninstall` takes the menu entry out again.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
