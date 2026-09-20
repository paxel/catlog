# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.1] - Unreleased

### Changed
- Every view on the desk opens with its name as a headline under the bar; Agenda, Map and Vet no longer squeeze theirs into the toolbar.
- The desk's tips look and work like the phone's: one bubble with Skip and Next, Got it on a page's last, Skip ending that page's tips. A tip whose widget is not on screen shows the same bubble under the bar instead of a line under the menu. The intro asks whether the tips are wanted, with Start with the tips and Start without tips under the name, instead of a checkbox.

### Fixed
- On Linux the desk installed through Homebrew is in the application menu right after `brew install`, and its window shows the cat icon on Wayland; before, the menu entry had to be registered by hand and the window carried a generic icon. The `.deb` shows the icon on Wayland too. `catlog-install-icon --uninstall` takes the menu entry out again.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
