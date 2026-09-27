# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.6] - Unreleased

### Added
- A Family view on the desk, beside the other views: every cat with kin as its face and its name, grouped by the month it was born in, oldest at the top, a line drawn between a kitten and its mother or father, and the cats whose birth day nobody wrote down last under a question mark. A face opens that cat.
- The agenda is a list beside a calendar now, not three tabs: the plans on the left, a month or a week on the right. The week lays the day out hour by hour with an all-day band above it and a line across the time it is; the month gives every day a cell with its all-day things first and the timed ones under them, recurring chores on every day they are due. Back, forward, Today and a month picker steer it, and an entry opens the cat or the home it belongs to.
- A preview on the desk's document pages: the Card as the picture it becomes, updating as values are ticked on and off, and what will be printed on the missing poster and the vet report.
- The vet report on the phone is previewed as it will print, the way the missing poster already was.
- Marking several rows and moving them into another home in one go, from either table.
- A card on the desk is made taller or shorter by dragging its bottom edge, and keeps that height.
- A home's card can lay every pet living in it on the desk at once and tile them.

### Fixed
- The card copied as a picture wraps its values instead of running them off the right edge on one line, and the sheet is as tall as what it holds instead of half a page of white.
- The red line of text at the top of a view is gone: what the app has to say is a note at the top of the window, which goes by itself when it only says a job is done, and stays with a × when something failed.
- Copying a card, a photo or a graph answers with a green paw at the pointer instead of a word in the corner — and the phone's paw appears at last: it went into whatever overlay was nearest, so a paw asked for inside a dialog vanished with the dialog.
- The timeline opens at once: it used to walk the whole log again on every frame, which made it unusable on a real catalog.
- The desk's graph offers the phone's ranges — week, month, year, all and a custom from/to — and writes them under the phone's own setting, so a catalog opened on either shows what was picked on the other.
- The home a cat is in now is named plainly in the Move dialog; it used to carry a tick this font has not, which drew as an empty box.

### Changed
- The page behind Edit is cut into tabs — Fields, Photos, Plans and Family, and Fields, Cats and Plans for a home — instead of one long scroll. The tab last used comes back with the next page.
- Every dialog on the desk confirms on the right, with Cancel beside it.
- The value editor reads as a dialog now: room around its content, the value, the date it counts from and the private mark kept apart.
- Checkboxes on the desk are squares that cross themselves off, instead of a tick too small to recognise.
- Marking rows in the Cats or Clowders table is worth something now: the marked rows carry a menu — open them all on the desk, move them into another home or another catalog, hide or show them, export them into one file, delete them after one question — and a tick on a marked row speaks for every marked row.
- A card's rows are separated by a hairline instead of alternating colours, and the body's scrollbar floats over them, so the card is one shape from the title bar down.
- Stack lays the pile in the cascade's order: the card highest up is furthest back.
- The card's menu says "Move to another home" instead of "Move to", and no longer offers "Seen here now" — a desk has no here.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
