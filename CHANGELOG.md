# Changelog

All notable changes to cat(a)log are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/).

## [0.1.0] - Unreleased

Milestone M1: local-only catalog with Cards.

### Added

- Walking skeleton: Flutter app (Android, iOS, Linux, Windows, macOS) with a
  pure-Dart catalog core — append-only entry log over SQLite, latest-wins
  projection, dated and authored history for every change.
- First-launch Author setup; every entry is attributed to the device's Author.
- Clowders: create, rename, list; address and responsible person as ordinary
  Field values with history.
- Starter Field definitions seeded on first launch (gender, color, neutered,
  pregnant, birth date, deceased, address, responsible person).
