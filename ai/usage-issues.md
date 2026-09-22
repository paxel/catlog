# Usage issues: steps that carry no decision

Audit of 2026-09-21 over the phone (`lib/src`) and the desk
(`desktop/crates/catlog-gui/src`). The trigger was the clowder cover
picture: a row with a paragraph explaining what a cover is, a sheet
repeating the paragraph, and only then the choice between camera and
gallery. The fix, commit `ac1418a2`, put the two buttons on the row and
dropped the explanation. This file lists every other place with the same
shape, grouped by pattern, with the proposed change. Nothing here drops
a feature; every action keeps a way to reach it.

Status is kept per group. Groups not marked done are open.

## 0. The plus that fans out — phone (done 2026-09-21)

The answer to most of group 1 and to the plan chooser of group 4: a page
that adds in more than one way has one plus (`AddFan`) that fans the
ways out, each an icon with its words, over a veil; the plus reads minus
while open. Strays: New stray, Take photo, Choose from gallery, From
video, Flier from camera, Flier from gallery. Cat page: Take photo,
Choose from gallery, From video, Appointment, Reminder, Chore. Clowder
page: Add cat, Appointment, Reminder, Chore. Agenda: the three kinds of
plan. A page with one way keeps the labelled button. The map lost its
Stray Cam button. See the UI law in `docs/agents/ui-laws.md`.

## 1. Camera or gallery asked when the button already said which — phone (done 2026-09-21)

- Strays cover icon, `strays_screen.dart:130`: tap, sheet, camera or
  gallery. Proposal: the same cover row as on the clowder page above the
  strays list, camera and gallery as buttons, Remove on a long-press.
- Stray Cam, `stray_cam.dart:166`: the camera button opens a sheet
  asking camera or gallery. The docs call it one tap. Done through the
  fan: Take photo, Choose from gallery and From video are three items,
  each straight to its source.
- Flier capture, `flier_capture.dart:280`: the same sheet before the
  camera. Done through the fan on the strays list, Flier from camera
  and Flier from gallery. From a cat's page, where the wizard is in the
  overflow, the two choices are buttons on the capture page itself.
- Missing poster, `missing_poster_screen.dart:331`: a tile labelled
  gallery that then asks camera or gallery. Proposal: the tile opens the
  gallery; a second tile opens the camera on a phone.
- After a Stray Cam picture, `strays_screen.dart:65`: species (pet mode)
  and Looks were asked in dialogs before the page opened. Done: no
  prompts, the page opens in edit mode with species as a field, the
  last species picked as its value.

## 2. Text repeated one tap later (conflicts and in-person done 2026-09-21; the paragraphs stay)

- Conflicts, phone `conflicts_screen.dart:45` and `conflict_dialog.dart:34`,
  desk `conflicts.rs:22` and `:126`: the explanation on the page and the
  same sentence in the dialog, then two radios for two values the row
  already shows. Done: the row shows both values as two buttons; a tap
  resolves; the same value on both sides shows one Resolve button. The
  field badge on a page leads to the conflicts page. Desk the same, the
  arrival summary resolves on its own rows.
- In-person join, phone `in_person_screen.dart:396` and `:136`: the note
  on the page is the whole body of the allow dialog. Done, further than
  proposed: the dialog is gone. The host showed the code and the PIN,
  that was the decision. The always-allow trust that only skipped the
  dialog went with it, phone and desk.
- Sync and housekeeping explainers, phone `remote_screen.dart:140`,
  `messenger_screen.dart:81`, `in_person_screen.dart:417`,
  `backups_screen.dart:126-148`, `archive_screen.dart:141`; desk
  `sync_page.rs:41-113`, `housekeeping.rs:143`, `:205`: paragraphs above
  the buttons that are the page. Decided to keep them as they are.
- Sync chooser, phone `sync_screen.dart:44`: three cards with subtitles,
  each only pushing the real page. Decided to keep it: one page with
  everything on it was tried before and was too much.

## 3. Menus with one or two items (done 2026-09-21)

Phone:

- Cat tile in a clowder, `clowder_detail_screen.dart:615`: Open repeats
  the tap; Card is the only real item. Done: a hold opens the Card.
- Reminder card, `reminder_card.dart:70`, and appointment card,
  `appointment_card.dart:79`: two items each. Done: the chore row's
  shape for all three, box on the left, hold edits, bin on the right.
- Agenda overflow, `agenda_screen.dart:327`: one item most of the time.
  Done: export and resync as bar icons.

Desk:

- File holds only Quit, `app.rs:1255`; Edit holds only Settings,
  `app.rs:1260`. Done: one menu under cat(a)log with both.
- View, Language is three clicks and repeats the Settings combo,
  `app.rs:1273`. Done: Settings only.
- Clowder page Actions holds one item, `pages.rs:115`. Done: Merge as a
  button beside New cat.
- Context menus whose items repeat the click: field rows `pages.rs:437`
  and `cards.rs:680`, cats table `cats_table.rs:590`, clowders table
  `clowders_table.rs:333`, history `history.rs:123`, vet Finish
  `vet.rs:212`. Done: each menu keeps only what has no other way, and a
  ⋮ at the row's end opens the same menu (`icons::more`).
- Chore row, `chores.rs:60`: four actions behind a right-click, nothing
  visible. Done: the ⋮ after the week dots.

## 4. Steps with no decision in them — phone

- Move a cat to another clowder, `cat_detail_screen.dart:121`: clowder
  dialog, then an "as of today" dialog, then the date picker. Proposal:
  the clowder list with a date field at its foot, today by default.
- Plan chooser, `plan_chooser.dart:13`: a dialog for the kind, a dialog
  for the cat, then the editor. Done: the kinds fan out of the plus; the
  cat or clowder is the editor's first field, preset from the page,
  from the agenda the one looked at last.
- Chore from the agenda, `chore_dialog.dart:28`, and duplicate chore,
  `:169`: an entity dialog, then a second editor on top of the first.
  Done: the entity is a field in the editor, the copy's too.
- "Move into the new catalog?", `catalogs_screen.dart:82`: a yes or no
  gate before a picker that has Cancel. Proposal: no gate.
- History rows, `timeline_screen.dart`, `field_history_screen.dart`,
  `chore_history_screen.dart`: a one-item sheet on removed rows, two
  items otherwise, then a date dialog and a time dialog. Done
  2026-09-22: the agenda shape — tap corrects, the bin removes, the
  arrow restores; a tick's day and time in one dialog. A row with a
  position leads to the map, its dot marked.
- Shared photo, `incoming_images.dart`: sheet, sheet, name dialog. Done
  2026-09-22: one page listing cats and homes flat, a new home typed
  there.
- Units, `units_dialog.dart:9`: three radios in a dialog. Proposal: a
  segmented button on the row, as Cats and Pets already is.
- Reminder done, `reminder_card.dart:43`: every tick opens a repeat
  dialog whose dismiss button reads "No repeat". Proposal: the tick is
  done; repeat is a chip on the card, or a note offering it for three
  seconds.

## 5. Desk only

- Map sighting, `map_page.rs:334`: right-click, a row, a combo reading
  "Cats", then the pick. Proposal: the right-click opens the cat list.
- Map pin, `map_page.rs:318`: two clicks to open. Proposal: one click
  opens; the trail shows on hover or a small button.
- Restore, `app.rs:1348`: menu only, absent from the Backups page.
  Proposal: a Restore button on Backups.
- Duplicates, `duplicates_page.rs:70`: the row names both, then two
  radios, then the confirm. Proposal: a Keep button on each side of the
  row; the confirm stays.
- Chore End confirm, `app.rs:1455`: the confirmation says nothing is
  lost. Proposal: no confirm.
- Arrival summary, Conflicts, `summary.rs:118`: the summary lists the
  conflicts, a button opens the conflicts page, which opens the dialog.
  Proposal: resolve buttons in the summary rows.

## 6. Text-only dialogs — phone

- `plausibility.dart:172`, `stray_cam.dart:89` when there is no settings
  action, the help sheet without tips `help.dart:89`. Proposal: a note at
  the top instead of a dialog with OK.

## Left alone, on purpose

Every destructive confirmation (delete, archive, go back, hard delete,
merge), the share-import preview, the four-item photo menu, the Danger
button on About. Each carries a decision or guards something that cannot
be undone.
