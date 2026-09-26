# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.5] - Unreleased

### Added
- Two more sounds to pick from for any moment, on the phone and the desk: Sonne miau and Sonne purr, a second cat's voice.
- A cat or a home can be renamed from its card on the desk: the pen beside the name on the title bar.
- A home's card chooses which Fields it shows, as a cat's card already did.
- A number measured more than once draws its course under the value on the card — the weight at a glance, without opening the history.
- An address can be searched when a place is set on the desk: type it, press Search, pick the match. The lookup runs only when asked, never while typing.
- Every free-text Field on the desk takes as many lines as the keeper writes, not only Remarks.
- Buttons on the desk's map for closer, further and pin by pin, beside the search and the stray areas it already had.
- Shift and drag on the desk's map draws a box and zooms into it; a plain drag still pans.
- A calendar on the desk's field editor: a date is picked from the month rather than spelled out, and can still be typed.
- A place on a card shows where it is: the coordinates with their Plus Code, a picture of the spot on the map and the code a phone reads to go there, in place of the words "On the map".

### Changed
- The history graph on the desk takes a time range — one month, six months, a year or everything — and the smoothed curve replaces the measured line instead of being drawn over it.
- The card's menu says Edit, because the page behind it is where a cat or a home is edited, and offers Timeline beside it: everything that ever happened to that one, in a window of its own instead of a fold at the foot of the page.
- The Mother and Father pickers on the desk offer only cats that could be one — a male cat is no longer offered as a mother and then refused. A cat whose gender is unknown is still offered.
- A card on the desk lists only the Fields the cat or the home actually has a value for, and every value is changed by the pen on its row, which opens the ordinary field editor — so a private mark and a date picker are there wherever the value is edited. A button under the rows fills in a Field that is still empty. A long value wraps over as many lines as it needs, and a card whose body outgrows the desk scrolls inside itself instead of growing past the edge. Every row is as wide as the card, so the stripes no longer stop halfway across, and the card's outline is visible against its own title bar.

### Fixed
- The desk's map zooms in as deep as the tiles go, and the wheel gathers before it steps a level, so a brush of the wheel no longer throws the view out to the whole world.
- A ticked chore in the desk's history names the chore — "Feed done" instead of "Chore done" — and no longer repeats the date the line beside it already carries.
- A Field's history on the desk reads as a diary: the day stands over what was written on it, and a long value wraps instead of stretching the window past both edges of the screen.
- Tile on the desk lays a real grid again: columns from the desk's width, rows sharing what is left above the dock. It used to start the second row below the tallest card, which pushed those cards off the desk, where egui pinned them and no hand could drag them back. No card is ever laid down past the desk's edge now, whichever way it was arranged.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
