# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.1] - Unreleased

### Changed
- Every sound has its own setting, on the phone and the desk: a chore ticked, the day's chores done, a ladder climbed, an adoption, each with a list to pick from under Settings, Sounds. The pick is heard as it is made; None is a choice, and so is a sound file of your own. The one Cheer sound switch is gone; a device that had it off stays silent until a moment gets its own sound.
- A clowder's cover picture is one row with the camera and the gallery as buttons, on the phone; the desk's row says what it is beside its button. The explanation and the sheet in between are gone. The strays list leads with the same row for its own picture instead of an icon in the bar.
- One plus on every page that adds in more than one way, fanning the ways out with their words: on the strays list New stray, Take photo, Choose from gallery, From video, Flier from camera and Flier from gallery; on a cat's page Take photo, Choose from gallery, From video, Appointment, Reminder and Chore, fanned out already when a fresh cat's page opens; on a clowder's page Add cat, Appointment, Reminder and Chore; on the agenda the three kinds of plan. The Stray Cam, flier and Add reminder icons in the bars are gone, as is the "Appointment or reminder?" dialog. A Stray Cam picture opens the page in edit mode straight away, species a field on it; the Looks question before the page is gone.
- Every plan editor starts with whose it is, a For field preset from the page it was opened on and changeable; from the agenda it starts with the cat or clowder looked at last. The dialog asking whose came first is gone, also before a duplicated chore.
- The map's Stray Cam button is gone; a stray is added from the strays list.
- A conflict is settled on its row: the two values are buttons with who and when, a tap keeps one. On the conflicts page, on the arrival page, and on the desk's conflicts and arrival views alike; a field's conflict badge leads to the conflicts page. The dialog that asked again is gone, and so is its explanation.
- The agenda's three rows share one shape: the box on the left ticks a chore, marks a reminder done or finishes an appointment, tap opens whose it is, a hold edits it, and a bin on the right removes a reminder or deletes an appointment. The long-press menus on the reminder and appointment cards are gone.
- On a clowder's page a hold on a cat opens its Card straight away; the two-item menu is gone. The agenda's export and its calendar resync are icons in the bar instead of a one-item menu.
- Desk: one menu under cat(a)log holds Settings and Quit in place of File and Edit; the language is picked on Settings only. Merge is a button beside New cat on a clowder's page. A row's menu holds only what a click does not do already, and every row with a menu shows a ⋮ at its end, the chore row included, so the right-click is not the only way in.
- Hosting an in-person sync no longer asks whether the phone that just scanned the code may join: the code and the PIN off the screen are the answer. Always-allowed devices, their list under Authors and the question on the desk are gone with it; the Include private switch stays the one setting a join reads.
- A button that already says camera opens the camera: the flier capture, and the missing poster's picture tiles, which now come as a gallery tile and a camera tile. The flier capture from a cat's page offers the two as buttons on its page.
- Every view on the desk opens with its name as a headline under the bar; Agenda, Map and Vet no longer squeeze theirs into the toolbar.
- The desk's tips look and work like the phone's: one bubble with Skip and Next, Got it on a page's last, Skip ending that page's tips. A tip whose widget is not on screen shows the same bubble under the bar instead of a line under the menu. The intro asks whether the tips are wanted, with Start with the tips and Start without tips under the name, instead of a checkbox.

### Fixed
- On Linux the desk installed through Homebrew is in the application menu right after `brew install`, and its window shows the cat icon on Wayland; before, the menu entry had to be registered by hand and the window carried a generic icon. The `.deb` shows the icon on Wayland too. `catlog-install-icon --uninstall` takes the menu entry out again.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
