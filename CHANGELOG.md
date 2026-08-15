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
- Cats: create inside a Clowder with name and photo, multiple photos per Cat,
  automatic compression on import (2560 px long edge), content-addressed image
  storage, Profile Image (defaults to the first photo, choosable), Clowder
  view as a grid of cat faces.
- Typed Field editing on Cats and Clowders (text, yes/no, date, number,
  choice) with backdating ("as of" date on every edit), full timeline per Cat
  and Clowder, and per-Field history via long-press.
- User-defined global Fields: create your own Field with name, type, scope
  (cats/clowders/both), and options for choice fields — usable immediately,
  no app update needed.
- Move & Stray: move a Cat to another Clowder (adoption) or record it leaving
  with no destination; Strays list on the home screen; every Move appears in
  the timeline.
- Cards: one screen with photo, name, and current facts per Cat — share as
  image, export as PDF (A5), or print directly.
- Deletes: photos (data really gone once no Cat shows them), Cats (hidden
  everywhere, photos dropped), and Clowders (their Cats fall out as Strays).
- Search: find a Cat by name (case-insensitive) across all Clowders and
  Strays, with face, name, and current location in the results.
- CI: GitHub Actions pipeline — analyze + tests on Linux, release APK
  artifact, unsigned iOS build; separate TestFlight workflow (signed build
  and upload) ready for the Apple credentials.
- Android release signing (own upload keystore, debug fallback for local
  builds) and a tag-driven Release workflow attaching signed per-ABI and
  universal APKs to GitHub Releases.
- Home screen shows Clowders as photo cards (two per row, sorted by name,
  faded cat photo background, shadowed name).
- Strays can be created directly from the Strays screen.
- Field definitions can be renamed (typo fixes); values and history stay
  attached, the rename itself is recorded history.
- Revert from history, git-style: any regular change (rename, field value,
  move) can be reverted; the previous value is appended as a new entry at
  the current time and both change and undo remain visible.
- Clowder timelines show which Cat lived there when: arrivals and
  departures ("Miezi arrived from A", "left to Adopter") derived from the
  Cats' membership histories; Cat timelines render moves readably too.
