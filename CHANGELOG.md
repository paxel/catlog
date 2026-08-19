# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [0.2.0] - Unreleased

### Added

- **Private cats, clowders, and fields**: marked private, they never leave
  your device unless you explicitly include private data in a sync — every
  sync asks, the default is always public-only.
- **A trust question before syncing**: the hosting device shows who wants
  to connect and asks Allow / Always allow / Decline before anything flows.
  Always-allowed devices are listed under About → Authors & bans.
- **Hide what you don't care about**: cats, clowders, and fields can be
  hidden on your device only — the data keeps syncing for everyone else,
  and "Show hidden" brings anything back.
- **Choose what's on a card**: tick photo, home, and fields before sharing;
  the position is never on a card unless you put it there.
- **Family**: mother and father can be set on every cat; the cat page shows
  littermates, siblings, and kittens, all tappable.
- **Clowder status** (foster home, forever home, clinic, shelter, barn —
  or your own words) shown as colored chips.
- **Adoption party**: moving a cat into a forever home throws confetti and
  a cheer (About page switch turns it off).
- **What arrived after a sync**: a summary lists adopted, deceased,
  escaped, and new animals plus conflicts to resolve — and little toasts
  announce adoptions and births (deaths, escapes, and moves can be enabled
  too).
- **Search on the map**: find cats, clowders, and people from your catalog;
  the position picker gained a place/address search and opens at your
  location instead of a country map.
- **Cat name proposals**: new cats arrive with a suggested name from a big
  list of classics, ancient names, and jokes — the dice rerolls; no name is
  proposed twice.
- **Remove a person's data for good**: About → Authors & bans deletes
  everything an author wrote from this device and can ban them and their
  photos from ever coming back — for the day someone poisons the catalog.
- **Received .catsync files open directly** in the import screen also on
  iPhone/iPad, Linux, and Windows (via Scoop) — no longer Android only.
- **Sync without any Wi-Fi** between two Android phones: one hosts a
  temporary hotspot, the other scans one QR code — connects, syncs, and
  disconnects by itself.
- **A real desktop layout**: wide windows (and iPad landscape) show the
  clowder list and details side by side; windows remember their size;
  Ctrl+F searches, Esc goes back, right-click opens context menus.
- **A short intro** on first start (skippable, replayable from About) and
  small **what's-new spotlights** that point out new features once.
- **Clowder cards show who lives there**: cat faces, a count, and the
  status chip.

- **ID fields**: a new field type for identifiers — typed or scanned with
  the camera (QR and barcodes), shown on the Card as plain text, QR code,
  or barcode as chosen at field creation. Cats start with a **Chip ID**
  field rendered as a barcode.

### Changed

- Cat and clowder pages open read-only showing only filled fields, nicely
  formatted; the pencil switches to the full edit view, and renaming lives
  there too. Clowders lead with their cat gallery, long-pressing a field
  jumps straight into editing it, and new fields can be created right on
  the page. Freshly created cats open in edit mode, ready to fill in.
- The sync page became three clear choices: **In person** (same room, QR),
  **Remote** (shared folder), **Messenger** (one file). Options that can't
  work right now say why instead of failing later.
- Positions show as "on the map" with a jump button — raw coordinates are
  gone from the app.
- Deceased cats appear dimmed with a small dated note instead of vanishing
  among the living.
- Map pins show faces and homes: photoless cats get a drawn cat silhouette
  and clowders show their own photo; the house icon is only a placeholder.
- Fields of different types can now be merged — the surviving field's type
  wins, old values stay readable.
- Error messages name the problem: "Couldn't reach the other device — are
  both on the same Wi-Fi?" instead of raw error codes.

### Fixed

- Clowder photos now travel through shared-folder and file syncs (they
  previously only arrived over direct Wi-Fi sync).
- The map's long-press sheet shows each stray's photo instead of a row of
  identical paw icons.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
