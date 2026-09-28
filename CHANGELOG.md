# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.7] - Unreleased

### Fixed
- "Move to another catalog" on marked rows moves the rows that were marked. It used to offer whole homes and strays instead, so moving five cats out of a home meant moving the home. A cat whose home stays behind arrives as a stray rather than in a home that is not there.
- A phone that syncs but records nothing for a week is no longer treated as an install that is gone: its warning stays and the whole-history file it reads is kept, instead of being cut off for good. Only a file nobody has written to for a week counts as gone, and a folder that cannot say when a file was written — an Android shared folder — keeps everyone.
- The mother or father already written down stays on the picker's list even after that cat's gender is corrected, so the relation can be changed instead of only cancelled.
- Opening a cat while the desk shows homes only puts the card on the desk and lets the filter go, instead of swallowing the click until the filter is found and turned off. A face in the dock brings its card back the same way, and Tile arranges the cards in sight and leaves the hidden ones where they lie.
- A paused chore is off the agenda's calendar; the month grid used to print it on every day while the list filed it under Paused.
- A note that follows a failure is drawn as news again and fades by itself; later notes used to inherit the red ground and the close button of the failure before them.
- A moment's sound, the confetti switch and the reminder's voice are the device's own: they are the same in every catalog on phone and desk, and an own sound picked in one catalog no longer replaces another's file behind its back. A choice made before this release is read where it was made.
- Turning the chore reminder's cat sound off is no longer undone by ticking a chore in another catalog.
- Deleting an achievement takes it off the list: it is waved off at the tier shown, so a ladder that climbed through a sync no longer comes straight back, and one that was never recorded goes too.
- Deleting an empty catalog says there was nothing to back up instead of naming a keepsake file that was never written.
- Saving picked video frames no longer hangs on a spinner when a full-size frame cannot be read; the picked picture is kept instead.
- Pulling a tiled card's bottom edge changes that card's height instead of snapping it back to the tile's row, so a card no longer shrinks with every pull and the cards beside it keep theirs.
- The vet report's preview follows every change again: a new date range, the patient summary switch and a row taken out all redraw it, not only the field chips. Drawing it no longer greys out Share and Print.
- An appointment can no longer be saved with nobody to visit; Save stays grey until a cat or a home is picked.
- Turning the adoption confetti off no longer silences the tick, the day's chores, the ladder and the adoption sounds as well. A device that had the switch off before the moments had their own sounds keeps its silence: it is read once as the choice for every moment.
- A marked home is highlighted in the Clowders table again; the row was marked but looked like any other.
- Moving marked cats that are not all in the same home now starts with nothing ticked, and any choice — the street included — can be saved. The street used to look ticked and Save stayed grey.
- Marked rows stay in the catalog they were marked in. They used to survive a switch, and a bulk action — a delete above all — would then be aimed at cats the new catalog has never heard of.
- The plus on a wide screen fans its ways out under itself again: in the two-pane layout they were drawn a pane's width to the left, over the list.
- Deleting a catalog takes the one the question names. Looking at another catalog on the Catalogs page could leave that one marked, and the delete from Settings then took it instead of the one it had asked about.
- "Move in from another catalog" works with three catalogs or more; it used to do nothing at all, throwing where nobody could see it.
- Settling a conflict in the window that lists what arrived leaves the window open, with the conflicts still to settle in it. It used to close on the first choice.
- What arrives from a phone or a folder shows up at once: a sync wrote the entries but never told the views, so the cats, the dashboard, the agenda and the family tree went on showing the catalog as it was before it.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
