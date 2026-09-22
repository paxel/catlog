# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.2] - Unreleased

### Added
- A history row with a position carries a map icon: the map opens on that spot with the trail drawn and that value's dot marked.
- Typed fields in the value editor (remarks, numbers, unit values, ids) carry an X that empties them, so a fresh note starts blank without selecting and deleting the old one first.
- Holding a trail dot on the map opens its menu right there: the value's history, a correction where the field has an editor, and removal. Holding the map itself offers the strays for a sighting in a menu at the finger.

### Changed
- A reminder or appointment ticked today stays on the agenda for the day, box checked, like a chore. The tick asks nothing; a tap on the done reminder plans the next cycle, a tap on the done appointment reopens its outcome notes, the box unticks, the bin takes it off the list.
- Moving a cat is one dialog: the homes and "stray" as rows, the day at the foot for a historic move.
- Creating a catalog asks nothing about moving things in; "Move in from another catalog…" is a row on the catalog's settings page.
- The unit system is picked on the settings row itself, no dialog.
- Nothing slides in from the bottom any more. Every menu opens where the finger is: the photo menu, the cover picture's menu, the catalog switcher under the title, the map's menus. Help is a page of its own, and shared photos are placed on one page that lists cats, homes with "New cat here", a new stray, and a new home typed right there.
- History rows on the timeline, the field history and the chore log have the agenda shape: a tap corrects, the bin removes, a removed row shows the arrow that brings it back. A chore tick's day and time are corrected in one dialog.
- A chore tick in the history names its chore, and the day it counts for when that is not the day it was ticked.
- A button that says "take a picture" or "from the gallery" no longer asks which one it meant.

### Fixed
- The desk is usable with a real catalog. It used to ask the database for every value on every frame, and every such read scanned the whole log twice, so a catalog of a thousand cats took ten seconds per frame in the Cats view and half a minute on the agenda. The store now keeps what every read needs between writes, the views keep their rows until something changes, and the reminder check runs twice a minute instead of once a frame.
- The outcome notes of a finished appointment show in the history under the visit; they were stored but shown nowhere.
- On Linux the desk's menu entry shows the cat icon, on KDE as on GNOME. The entry names the icon by its theme name and a 256 pixel PNG sits where every desktop looks; 2.0.1 pointed the entry at an SVG file inside the Homebrew prefix, which drew nothing. The desk also keeps its own launcher entry, icon and `.catsync` file type current in the application menu on every start, so a Homebrew, tarball or AppImage install is in the menu with its icon after one start, and a moved binary heals its entry itself.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
