# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.2.3] - Unreleased

### Added
- A chore's history page: every due day with done when and by whom, missed, or still open; oldest first on request, shareable as text.
- A field's history can be read oldest first and shared as text, one line per value with date and author.
- The graph page shares its curve as a picture, caption and curve only, through the phone's share sheet.
- A title you earned can be worn next to your name, chosen in the catalog settings; partners see it on the author rows, and nobody can wear one in your name.
- Five coats in colour behind the pages, calico to tortoiseshell, one earned per full month of chores; a favourite coat can be pinned in Settings.
- Titles for chores done, Servant to Minister with the chore in brackets, and a new coat for every full month; the achievements page lists what was earned and nothing to chase.
- Looks grew: eye colour, a Features group for what never changes (tipped or tattooed ear, a missing eye or leg, no teeth, extra toes), more colours, patterns, fur, tail and ear types. A shared feature alone makes a match candidate.
- Thirty more cat breeds, Burmese and Abyssinian among them, named in every language; existing catalogs get them added.
- Android backs the catalogs up into the keeper's Google account, photos left out, and puts them back on a reinstall or a new phone.
- On iPhone the backup files show in the Files app under cat(a)log.
- A Backups page in Settings says what the phone backs up where, writes a copy on request, and on Android sends every copy to a folder of your choice too.
- Every value has a time of day: the editor's As of row picks date and time, and the history, the timeline and the graph show it.
- A wrong value can be corrected or removed from its history; hidden values show on request and can be restored.
- A done day in a chore's history can be corrected to another moment or removed.

### Changed
- Reverting a change removes it instead of writing the old value again.
- Android backups go to Documents/catlog instead of Downloads/catlog.

### Fixed
- Chore reminders work in the store build: the release build had stripped the notification plugin's inner workings, so the test button did nothing and the switch reported a missing permission; a broken plugin now reports itself instead of posing as a refusal.
- Restoring after a reinstall works on Android: the restore page opens the picker on the backup folder, and one grant lists every backup there.
- Two devices changing a choice field's option list at the same time get both lists merged instead of a conflict.
- Chores on a cat's or home's page are ordered like the agenda: due today by time, the rest and the paused ones behind a Coming up fold.
- Chore reminders of every catalog stay scheduled; opening another catalog used to cancel them.
- Chore reminders show with their own icon and a sound; a button sends a test reminder at once.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
