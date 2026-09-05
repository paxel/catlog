# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.1.1] - 2026-09-05

### Added

- A "Conflicts (N)" entry in the main menu while fields changed in two
  places at once are still unsettled; it lists them and each one is
  resolved on the spot.
- A history button on a cat's or home's field once it has held two or
  more values (and has no graph): the values as a diary, newest first,
  with date and author. Reverting stays on the edit-mode timeline.
- Location fields you add yourself pin on the map, as a neutral pin
  with the field's name. Every location has a trail: tap a pin, or
  open the map from the field's row; the dots along the trail show
  date and author when tapped. Homes have trails too.

### Changed

- "Find address on the map" no longer writes silently: a dialog shows
  the place it found and asks whether to save the location and whether
  to replace the typed address with the found wording.
- Language, units, celebrations, notifications and the tutorial
  replays moved from the menu and the About page into a Settings page
  in the main menu.
- Each catalog has its own settings page, opened from its row in the
  catalog switcher: name, cats or pets, fields, authors and bans,
  archive, go back, delete. It works on that catalog whether or not you
  are in it. Those items left the menu, the About page and the top of
  the switcher.
- Deleting a catalog or a person's data asks you to type the word
  shown (DELETE, in your language) instead of the full name.
- Map pins point at their spot: a tip under the face sits on the exact
  coordinate, for cats, posters, homes and grouped pins alike.
- Tapping a home's pin on the map shows its trail, like a cat's; the
  home's page opens from the trail bar's Open button.
- After a sync or import, a full page shows what arrived instead of a
  sheet with "N other changes": new cats and homes, updated ones with
  their effective changes (value before, value now), conflicts to
  resolve on the spot, and what else came along (fields, merges,
  photos). Accept keeps it; Reject puts the catalog back as it was.
  In-person sync can be rejected too. A partner's deletion of a cat
  or home you have is listed under Deleted; "Keep mine" on a deleted
  or updated row keeps your version on this device without touching
  the partner's catalog, and it stays kept over later syncs. Cats and
  homes hidden on this device are not announced.

### Fixed

- Panning the map away from a still-loading tile no longer records a
  crash when the tile arrives.
- The pair code shown for an in-person sync wraps into short lines,
  each in its own colour, instead of running off the screen.
- The fur coat behind a page scrolls with the page instead of staying
  put under the moving content, and each page keeps its own position
  when you come back to it.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
