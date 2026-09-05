# Older changes

Historical release notes for cat(a)log. The current version lives in [CHANGELOG.md](CHANGELOG.md).

## [1.1.2] - 2026-09-05

### Changed

- A found address reads the way its country writes addresses: street
  and number, then postcode and town ("Grimmaische Straße 12, 04109
  Leipzig"), number first where that is the custom. Towns and regions
  keep their full name.

### Fixed

- Deleting a catalog or a person's data asks one plain question
  instead of demanding a typed word, which the keyboard completed
  anyway.

- Photos picked from a video appear one by one as they are added,
  with a progress line, instead of all at once after a silent wait.

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

## [1.1.0] - 2026-08-31

### Added

- Pet mode: on the catalogs page, "This catalog holds: Cats / Pets".
  A pets catalog speaks of pets and households instead of cats and
  clowders, shows a paw for an animal without a photo, and proposes
  neutral names. The choice syncs with the catalog; nothing in the
  data changes. The neutral wording exists in all 38 languages.
- Species is a choice with presets — cat, dog, rabbit, guinea pig,
  hamster, bird, horse, tortoise, ferret, or your own word. In pet
  mode, adding an animal asks for it, starting from the one you picked
  last.
- Breed follows the species: a dog is offered dog breeds, a rabbit
  rabbit breeds, and a breed you type for one species is offered again
  for that species only. Cats keep the breed list as it is.
- A "unit value" field type: pick what it measures — weight, length,
  volume or temperature — and enter and read it in your units (metric
  or imperial, from your region or chosen under Units in the menu)
  while partners see theirs. Weight is ready on every animal.
- A graph for any number or unit-value field with two or more values:
  the icon on the field's row opens it — week, month, year, all or a
  range of your own, the change since the previous value, lowest,
  highest and latest marked, the animal's appointments as ticks.

### Changed

- The pages sit on a quiet fur coat instead of a plain surface: beige
  on beige (dark on dark at night), one of six patterns — cheetah,
  tiger, tabby, paw prints, leopard rosettes, zebra — picked anew each
  time the app opens.

- "Possible stray area" on the map is a dialog with an OK button
  instead of a sheet that could only be closed by tapping beside it.

### Fixed

- On iPhone and iPad, holding Stray Cam to film no longer closes the
  app: filming needs a microphone entry iOS insists on. The sound is
  thrown away; only the frames you pick are kept.
- Joining in-person sync without Wi-Fi says "Connect to a Wi-Fi first"
  right away, instead of a silent 25-second wait with the answer
  hidden below the fold.

### Security

- In-person sync runs over TLS: the host uses a certificate made once
  on the device, the pair code carries its fingerprint (all of it in
  the QR, the first part in the typed code), and the joiner accepts no
  other. Nobody on the same Wi-Fi reads what passes any more. Both
  devices need 1.1.0; an older partner is named as such.

## [1.0.7] - 2026-08-30

### Changed

- Stray Cam, the camera and gallery picker, the code scanner, "my
  location", printing, sharing and links run one at a time: a second
  press while one is still working does nothing, and the Stray Cam
  button shows a spinner meanwhile. A plugin error shows its message
  instead of a crash. The Strays help explains tap versus press-and-hold
  on Stray Cam.

### Security

- A shared file or a sync partner can no longer plant entries under
  this device's own id, which would have made partners skip its real
  changes.
- Registry lookup links open only web addresses; a template pointing at
  `sms:`, `tel:` or an app scheme is ignored.
- Imports, syncs and share downloads refuse files and photos far above
  the sizes the app writes, instead of unpacking them into memory.
- In-person sync listens on the Wi-Fi connection only, and an address
  that sends five wrong PINs is locked out for that session.
- "Always allow this device" now rests on a secret the host hands the
  device, not on the device's own name for itself; devices remembered
  by older versions are asked once more.
- Files on their way to a share sheet or the backup folder are written
  to a private, short-lived directory and deleted afterwards.
- The catalogs are excluded from Android and iCloud device backups, as
  the privacy text promises.
- A photo name inside a shared file or from a sync partner can no
  longer point outside the catalog's image folder — reading or
  deleting a photo needs a real hash.

### Fixed

- Backups, shared files and archives with many photos no longer need
  twice the photos' size in memory while being written — the automatic
  backup on leaving the app could kill it on a phone with a big catalog.
- Restoring or importing a file with many photos reads it photo by
  photo instead of unpacking everything into memory first.
- A sync partner that dropped the connection mid-transfer could crash
  the hosting device.
- A photo mentioned in the log that nobody holds any more no longer
  makes every sync between the devices fail; a problem while fetching
  photos no longer hides that the entries arrived.
- "Resync calendar" waits for a running mirror pass, and a pass cut
  off by a catalog switch removes the events it had just created —
  two more ways duplicates could appear.
- Going back to an earlier moment refuses if the catalog changed while
  its file was being saved, so nothing that arrived meanwhile is lost.
- Moving a cat or clowder to another catalog writes all of it or
  nothing on the receiving side.
- Folder sync skips a partner file a cloud client is still writing
  instead of stopping at it.
- A photo taken or shared while the catalog was switched away is
  dropped instead of crashing on the closed catalog; archiving checks
  the same before deleting.
- Two files opened in quick succession are imported one after the
  other instead of stacking two catalog dialogs.
- On the in-person sync page, a second tap on Host during startup does
  nothing, and backing out mid-start stops the server and hotspot.
- The card decodes its photo at card size; the image behind "share as
  picture" is released after use; the clowder card's PDF carries 240 px
  roster thumbnails instead of full photos.
- The flier wizard's thumbnails and the share preview are decoded at
  their display size.
- The map's tile folder is trimmed to 200 MB, oldest tiles first.
- A typed pair code pointing outside the local network is refused
  before anything is sent; a sync partner can only send photos the
  catalog mentions; an image whose header claims more than 40 million
  pixels is refused before decoding; map tiles are capped and cached
  only once they decoded.
- Files shared into the app get unique names and are deleted after the
  import.
- Photos of a switched-away catalog leave memory at once; a calendar
  that never answers releases the mirror after two minutes; the map
  and the celebration sound release what they hold.
- Two joiners at once are served one after the other; the automatic
  backup runs once per pause; imports, merges, the flier wizard's save
  and appointment groups land as one transaction; a photo file is
  written completely or not at all; the catalog list waits while a
  catalog is being written out for deletion.
- A location fix that never arrives gives up after 20 seconds with "no
  fix" instead of waiting for the rest of the session.
- An error from the phone's calendar during the mirror switched the app
  to the crash screen on every start; the mirror now turns itself off
  and shows the calendar's message.
- The crop screen after taking a photo decoded the full camera file
  twice; it now reads the size from the header and shows a screen-size
  preview.
- Clowder pins on the map decoded their photo at full size on every
  redraw.
- Photos shared into the app are read one at a time instead of all at
  once.
- "Stream has been disposed" while many photos were on screen (an iPad
  with a wide layout): a photo keeps the same image identity even after
  the small cache let it go.

- Pressing Stray Cam again while the GPS fix was still pending crashed
  the app on return from the camera ("Image picker is already active").
- Scrubbing through a filmed video on an iPad could end in "Stream has
  been disposed": the frame picker now keeps one image per frame and
  decodes a preview before showing it.
- Filming with Stray Cam (press and hold) killed the app on iPhones:
  the frame picker held a dozen full-size frames at once. It now works
  at preview size and fetches only the kept frames at photo size.

## [1.0.6] - 2026-08-29

### Added

- Date fields take a year or a month and year when the day is unknown
  — "2021" or "May 2021" is stored and shown as such, never as an
  invented first day. The flier wizard reads such dates from posters.
- A cat's age next to its birth date and in the strays list — "3 yrs
  5 mo", "3 yrs" for a bare birth year, frozen at death.
- The flier wizard can attach the poster to a cat or a clowder already
  in the catalog: pick them on the Cat page, and the poster's lines go
  where you assign them — clowder fields (address, phone, mail…) are
  in the dropdown too — with a note under any line that would
  overwrite a value.
- One cat list everywhere cats are listed — Strays, the cat search, a
  clowder's members via the list button on its page: list or table,
  sortable, with the cat fields you choose as columns, an Age column,
  and a text filter over names and values. The search now starts from
  all cats.
- A `.catsync` opened from a chat or a file manager asks which catalog
  it goes into before importing — any catalog, or a new one named
  from the file, so a cat you only want to look at stays out of your
  own data. Cancel leaves the file alone.
- "Find address on the map" under a clowder's address turns it into
  the clowder's position and names the place it found. The flier
  wizard's button now shows the found place too.

### Changed

- A stray's flier position shows on the map as a square pin with its
  face; sightings stay round. A cat known only from its poster is on
  the map now.
- "Show on map" from a cat's or clowder's page marks that spot with a
  highlighted pin. Cats of a clowder without a position pin at their
  own sightings. Cats sighted within 20 m of each other share one pin
  — one face, the name and "+2" — that opens the list of those cats.
- The card's QR code for a registry number (TASSO and the like) carries
  the registry's search link, so a phone camera opens the search;
  the caption still shows the number.
- The flier wizard's Flier text page offers "Drop" for any line, and a
  line sent to remarks arrives as its value alone — the poster's labels
  ("Geschlecht:") no longer fill the cat's and owner's remarks.
- The calendar mirror no longer recreates an event you deleted by hand
  in the phone's calendar; your edits there stay until the plan
  changes in the app or you resync.
- Dates are typed — "14.05.2021", "05.2021" or "2021" — with the
  calendar behind an icon instead of a month grid filling the dialog.
  Reminders, appointments and "as of" dates use the same entry.

### Fixed

- The calendar mirror wrote the same appointment into the phone's
  calendar again and again — two syncs running at once each created
  it. One sync runs at a time now, and events are written once and
  only updated when the plan changes. "Resync calendar" in the agenda
  menu removes every event cat(a)log wrote and writes the plans fresh
  — the way to clear the duplicates.

- The birth date printed on a TASSO poster fills the Birth date field
  instead of landing in remarks.
- Switching the catalog while the calendar mirror was still talking to
  the phone's calendar crashed the app ("database has already been
  closed").

## [1.0.5] - 2026-08-29

### Fixed

- Appointments in the phone's calendar were two hours late: the time
  entered is now written as local time.

## [1.0.4] - 2026-08-28

### Fixed

- The calendar mirror on Android found no calendar although the phone
  had several; the picker now lists them.

## [1.0.3] - 2026-08-28

### Added

- Appointments: a visit with date, time, what, and notes — several per
  cat or clowder. The "+" on the agenda and the alarm button on a cat's
  or clowder's page ask "Appointment or reminder?" first. Finishing an
  appointment asks how it went, keeps the notes on the cat's timeline,
  and can write a value into a field. Several cats can share one
  appointment — a fosterer's neutering run: tick the cats in it, the
  agenda shows one card with their names, and finishing asks which cats
  were treated; the unticked ones stay planned. The calendar mirror adds
  appointments as timed events with an alert of your choice — the day
  before, an hour before, or none; a shared appointment is one event.
  The calendar file from the agenda menu carries appointments too, timed
  and with their alarm.

### Changed

- Capturing a flier starts on a "Flier text" page: QR codes found on the
  poster are listed and can be unticked, and every recognized line shows
  the field it goes to and can be moved to another one before anything
  is filled in.
- TASSO posters are read by their layout: name, registry number,
  missing-since date, address, gender, breed, colour and neutered land in
  their fields, and the registry's hotline no longer becomes the owner's
  phone. Layouts come from a template file the app ships, so other
  registries can be added without a code change.
- A flier can be saved only from its last page; the back button asks
  before the scan is thrown away.

### Fixed

- Flier text printed in two columns no longer arrives as all labels
  followed by all values.
- A QR code that could not be read says so, with the reader's error,
  instead of looking like a poster without a code.

## [1.0.2] - 2026-08-26

### Changed

- The tips and the help page for the agenda, reminders and the
  calendar switch say plainly what each thing does.

### Fixed

- The calendar picker lists every calendar the phone has; read-only
  ones are shown greyed instead of the whole list being reported as
  empty.

## [1.0.1] - 2026-08-25

### Added

- "Add reminder" on cat and clowder pages and on the agenda: one
  dialog with field, due date, value and what a reminder is. Fields
  that state what a cat is — gender, breed, birth date, chip ID and
  the like — take no reminders.
- A "Planned" section on cat and clowder pages shows their live plans,
  with the same done, change-date and remove actions as the agenda —
  a plan on a field without a value is visible there too.

### Changed

- The reminder checkbox in the field editor is gone, and the "as of"
  date can no longer lie in the future — plans are made with Add
  reminder.
- The agenda has its own bell in the home bar on every screen size;
  Fields moved into the home menu.
- The calendar mirror is a visible switch at the top of the agenda. It
  asks which of the phone's calendars to use instead of creating a
  hidden local one, and says why when it cannot write — permission
  blocked, no calendar chosen, calendar gone.
- Tips introduce the agenda bell, Add reminder, the agenda's plus
  button and the calendar switch on first sight; the agenda has its own
  help page.

### Fixed

- Lists under a floating button scroll clear of it, so the last rows
  can be reached (Fields, Strays, Agenda).

## [1.0.0] - 2026-08-25

### Added

- Reminders: any field value can carry a future due date as a plan. A
  plan never becomes a fact — marking it done records the real
  treatment and can schedule the next cycle in days, weeks, months or
  years.
- Agenda: everything due across all cats and clowders in one dated
  list; overdue stays pinned on top until handled, and the agenda opens
  by itself when something is due within 3 days.
- Calendar: an opt-in mirror puts every due date into a cat(a)log
  calendar on the phone as an all-day event, and a calendar file
  (.ics) can be exported anywhere.
- A small cat ear in the corner marks everything that reacts to
  press-and-hold — cat tiles now open their menu on long-press too. A
  one-time tip explains the ear.

### Changed

- The map's buttons moved into one toolbar below the map: stray areas,
  my location, previous/next pin, and Stray Cam in one row — nothing
  covers the map anymore.
- Managing catalogs: tapping a catalog switches to it and stays on the
  screen, so several catalogs can be handled in one visit; the back
  button leaves.
- The sync format now carries reminders. Syncing and file exchange
  with 0.3.x devices keep working until the first reminder is used;
  from then on the other devices must update.

### Fixed

- The map no longer crashes ("Infinity or NaN toInt") when a search
  finds several hits on the same spot — and a map already stuck in
  that crash frees itself on the first open after this update.

## [0.3.3] - 2026-08-24

### Added

- Clowder card: a card icon on the clowder opens it as a card — its cats
  with their pictures on top, every detail selectable — shareable as an
  image or PDF and printable, like the cat card.

### Changed

- "Forever home" is now the plain word for home in every translation,
  instead of a literal word-for-word rendering.
- The support-the-developer note and a few capture-flier hints are
  reworded in all languages.

### Fixed

- The in-person sync host instructions now describe the actual flow —
  scan or type the code — instead of an address and PIN entry that no
  longer exists.
- While hosting an in-person sync, scanning and code entry are disabled,
  so a device can no longer sync with itself.
- The flier owner step said the owner becomes a card; it becomes a
  clowder.

## [0.3.2] - 2026-08-23

### Changed

- Privacy is set per value, in the field editor: a checkmark keeps that
  one value in this catalog. The lock at the end of a row shows what is
  private. Marking a whole cat or clowder private is gone.
- The sync screen and Share publicly name the catalog that is shared,
  and the three sync ways introduce themselves in one line each.

## [0.3.1] - 2026-08-23

### Changed

- Private now hides values, not cats and clowders. A private cat or
  clowder still reaches the people you sync with by name — what stays
  home is its address, its phone number, its photos. Single values can
  be kept back one at a time, with the lock beside the field, and a
  value someone kept back shows as withheld instead of as empty.

### Fixed

- Installing on Linux with Homebrew puts cat(a)log in the application
  menu, with its icon, and lets .catsync files open with it.
- What arrived after a sync or an import no longer counts the Fields
  themselves: an empty catalog arrives as nothing at all instead of as
  dozens of changes.
- A cat living in a private clowder arrives whole instead of vanishing:
  it used to reach the other device pointing at a clowder that was never
  sent, and then showed up on no screen at all.
- Sharing privately after sharing publicly reaches the other device.
  What was held back once used to stay unreachable for good, however
  often you shared again with private data included.

## [0.3.0] - 2026-08-22

### Added

- Several catalogs on one device. The home screen's title names the
  catalog you are in; tapping it switches, adds one, or renames one.
  Each catalog keeps its own cats, clowders, fields, photos and sync
  partners, while your name, your language and the tips you have seen
  are shared by all of them. Deleting a catalog writes a complete file
  where the automatic backups go before anything is removed, and asks
  you to type its name. Each catalog's automatic backup is its own file,
  named after the catalog.
- Moving a cat, a whole clowder with everything living in it, or a
  selection of strays into another catalog. What moves arrives with its
  whole history and its photos and is deleted where it came from, and
  creating a catalog offers to move something into it straight away.
- Undoing an import. The summary that appears after importing a file
  offers to take it back: what arrived is removed, written to a file
  first so importing that puts it back, and syncing with the same person
  again does not bring it straight back.
- A "Go back" list per catalog, in Manage catalogs: the moments the
  catalog changed shape, as sentences, newest first and grouped by
  month. Picking one returns the catalog to that state, and you can mark
  a moment yourself with a name. A moment is recorded before every
  import and every sync, before merging and before archiving — and a
  sync that finds nothing new records nothing.

### Changed

- On a tablet or a desktop window, the clowder table uses the whole
  width instead of being squeezed into the list column; opening a row
  shows the clowder over the table.
- Tutorial tips sit beside what they highlight instead of stretching
  across the screen, and no longer draw an arrow that pointed at empty
  space on tablets.

### Fixed

- On a tablet or a desktop window, Strays, Search, Find duplicates and
  Fields open beside the list of clowders instead of covering it.
- Long cat and clowder names are readable on a phone again: the title
  moved to its own line instead of being cut to a few letters by the
  buttons beside it.
- Entries written after deleting an author's data reach the people you
  sync with again, instead of being silently ignored as something they
  already had.

## [0.2.1] - 2026-08-20

### Added

- Photos can be shared into cat(a)log from any other app — Immich,
  Signal, a browser — single or a whole batch: pick the cat they belong
  to, or a new stray (Android).

- **Map, five wishes granted**: a my-location button; the map reopens
  where you left it; toggled stray areas show the missing cat's tappable
  face on every flier spot; searching an unknown name falls back to a
  place search ("Leipzig" now works, and the map zooms in on the found
  street or town instead of centering it in a country-wide view); and
  two arrows glide from pin to pin in nearest-neighbor order.

- **Archive old data** (About → Archive): deceased cats and empty
  clowders that have been quiet for years are written into a .catsync
  file you keep and then deleted — on your device and on every device
  you sync with. Importing the file brings them back. The page also
  shows what the catalog currently costs in database and photo space.
  Importing such a file into the catalog it came from asks whether the
  deleted entries should be restored — photos included.

- **Help on every page**: a "?" in the app bar explains what the page
  is for, what you can do there, and what tap and long-press do — plus a
  button that shows that page's tips again.

- **Flier scan is a wizard**: cat, owner, face crop, registry, and a
  final check — one step per page, so the profile picture and the
  poster's contact details no longer get skipped by accident. Phone and
  e-mail land in the owner's own fields, and the address can be turned
  into a position for the owner's card.

- Registry numbers from a poster: an ID field can carry a lookup link,
  so a Tasso number found on a flier is stored with the cat and opens
  the service in one tap. Links from other services are learned from
  the poster — name it once and the next flier fills itself.

- Clowders have Email and Phone fields — contacting the people behind a
  colony no longer means writing it into Remarks.

- The home a stray ran from counts as a search area of its own: its
  clowder's location gets the same 500 m circle on the map, and cats
  seen inside it turn up under possible matches.

- **Clowders as a table**: a toggle in the clowder overview switches
  between tiles and a sortable table — Name, Cats, and any clowder
  fields as columns of your choosing, strays pinned first; view, columns,
  and sorting are remembered per device.

### Changed

- Chip scanning is labeled "Scan printed code" and explains that the
  implanted chip itself can't be read by a phone.
- Dates display in the device's format everywhere (27.12.2010 instead
  of 2010-12-27).
- The Messenger sync card says it also imports received .catsync files.
- The intro pages, the tips and the sharing explanations are written in
  plain language: what each screen does and what happens when you tap.

### Fixed

- Crash reports name the app version and build, the system and its
  version, the language and the time — the old ones left the version
  blank, so nobody could tell which build had crashed.
- Mother and Father print the linked cat's name on the card instead
  of an internal id; a link that no longer resolves is left off.
- "Share publicly" honors Private everywhere: a private cat refuses to
  export (with the reason), a private clowder and private fields stay
  out of the share file and QR.
- Merging from Match candidates or Find duplicates asks the same
  cannot-be-undone confirmation as every other merge.
- Match candidates no longer pair up cats living in the same clowder —
  geo matching considers strays and missing cats only.
- Cat and clowder pages refresh immediately after a revert on the
  timeline or photos extracted from a video — no reopening needed.
- Scrubbing through a video shows the frame at the current position
  right away, not only after keeping it.
- With 3-button navigation the system bar no longer floats over the
  app's bottom buttons.
- A chip barcode on the Card appears once: the code with its printed
  number, without the repeating fact row and caption (QR codes keep one
  caption line, they carry no readable number).

## [0.2.0] - 2026-08-19

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
- **Clowder type** (foster home, forever home, clinic, shelter, barn,
  owner — or your own words) shown as colored chips.
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
- **A short intro** on first start (skippable, replayable from About) —
  now with a missing-cats page — and small **what's-new spotlights** that
  point out each new feature once: the strays card, the edit pencil, the
  flier and share tools, the map overlay, and the duplicates finder.
- **Clowder cards show who lives there**: cat faces, a count, and the
  type as a small label on the card's edge.

- **ID fields**: a new field type for identifiers — typed, or scanned
  from a PRINTED QR/barcode (chip card, vet papers; the implanted chip
  itself can't be read by a phone). Shown on the Card as plain text, QR
  code, or barcode as chosen at field creation. Cats start with a
  **Chip ID** field rendered as a barcode.

- **Remarks**: a multiline notes field on every cat and clowder; search
  finds cats by their remarks too.
- **Flier capture**: photograph a missing-cat flier and it becomes an
  owner clowder plus a missing cat that went stray on the flier's date —
  with the flier photo as provenance, an optional cropped portrait as the
  face, the location as a flier position, and scanned or recognized text
  prefilling chip ID, phone, and remarks (text recognition on Android and
  iOS, Latin-script text only; editable everywhere). "Add flier" on a cat appends further fliers.
- **Match candidates**: a screen listing cats that might be the same
  animal — exact chip/ID matches first, then cats seen within 500 m of a
  flier or of each other, filterable by species. Confirming a pair is the
  familiar merge, with the survivor of your choice.
- **Find duplicates**: a scan for likely twins among cats and clowders —
  same or nearly-same names, equal chip IDs — resolved pair by pair
  through the familiar merge.
- **Photos from video** (Android/iPhone): pick a video — or long-press
  Stray Cam to film one — and keep the good frames as ordinary photos.
  The app suggests the sharpest frames, a scrubber grabs any moment, and
  the video itself is never stored. No frame kept, no cat.
- **Share publicly for fliers**: export one cat with only the fields you
  tick as an ordinary sync file, print a QR of its hosted link (or a tiny
  text-only inline QR that needs no hosting) — a finder scans it with
  cat(a)log, sees a preview with the source, and imports the cat and its
  owner's contact with one tap. Partial imports are safe: a later real
  sync still delivers everything that stayed home, and references to cats
  not included simply wait until they arrive.
- **Possible stray area**: toggle a 500 m circle overlay around a missing
  cat's flier positions on the map — the radius most lost cats are found
  within.
- Positions now know their kind: live sightings versus flier locations.
  Flier positions never appear as sighting pins, and a stray without any
  sighting is valid — it lives in lists and search, just not on the map.

- Plausibility now also guards the family: a female father or male
  mother, a parent born after its kitten, and gender changes that
  contradict recorded parenthood are refused with the reason.

- Cards show a scannable geo QR plus the printable Plus Code for a cat's
  location — any phone's camera opens it in its maps app.

### Changed

- The "Position" starter field is now labeled **Location**.
- Saving a captured flier shows a spinner, a nameless owner is named
  after the cat ("Owner of Minka"), and the owner card carries the
  flier's text and phone itself.

- Cat and clowder pages open read-only showing only filled fields, nicely
  formatted; the pencil switches to the full edit view, and renaming lives
  there too. Clowders lead with their cat gallery, long-pressing a field
  jumps straight into editing it, and new fields can be created right on
  the page. Freshly created cats open in edit mode, ready to fill in.
- Strays appear as their own card first in the clowder grid — cover
  photo, count, and faces — instead of a button below the list; the stray
  list shows gender and color and sorts by name, gender, or color.
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

## [0.1.4] - 2026-08-19

### Added

- Implausible starter-field values are refused with an explanation: birth or death dates in the future, death before birth, and pregnancy for a male cat.

### Fixed

- The month arrows in date fields no longer skip several months per tap.
- Android no longer offers cat(a)log when opening calendar links.
- Typing a date now shows the expected format when the input doesn't parse.
- Sharing photos, cards, sync bundles, and the CSV export works on iPad.
- Fixed an occasional crash while photos were still loading.
- Location features explain why no position is available (service off, permission denied, no GPS fix) and open the right settings screen.

## [0.1.3] - 2026-08-18

### Added

- The option list of a choice field (e.g. Breed) can be edited from the
  Fields screen.

### Changed

- The map no longer rotates on a two-finger twist; north stays up.

### Fixed

- No more crash when returning to the app after the system camera (or
  any other screen change) finished while the app was in the background.
- Stray Cam no longer loses the photo when Android closes the app behind
  the camera — the capture completes on the next start.
- Stray Cam creates the cat only once a photo was actually taken, so a
  canceled camera no longer leaves an empty stray behind.
- When location access is permanently blocked, Stray Cam explains it and
  offers to open the system settings instead of failing quietly.
- Opening a `.catsync` file now actually imports it — 0.1.2 only made
  the app appear in the chooser.
- Breed choices display in the device language (e.g. "Europäisch
  Kurzhaar" on German devices).
- A failed automatic backup is shown on the Sync screen instead of
  disappearing silently.
- Each Sync-screen section shows its own result — a folder sync no
  longer reports under the QR section.
- Swiping through the full-screen gallery no longer flickers.

## [0.1.2] - 2026-08-17

### Added

- The app can be installed via F-Droid from the project's own repository.
- Cats have a Breed field with common breeds as choices.
- Choice fields accept a freely typed value besides the preset options.
- Tapping a cat photo opens it full-screen with zoom and swiping; the
  photo menu (profile, crop, mark, delete) moved to long-press.
- Photos can be shared or saved from the full-screen view.
- Android offers cat(a)log when opening a `.catsync` file from a
  messenger or file app.

### Changed

- Crop and Mark screens confirm with a labeled button ("Crop" / "Save")
  instead of a bare checkmark.

### Removed

- Placing an existing clowder from the map's long-press menu — a
  clowder's position is set via its Position field.

### Fixed

- The automatic backup keeps its `.catsync` name instead of being renamed
  to `.zip`, replaces the previous backup instead of piling up copies,
  and cleans up old `.zip` leftovers.
- A fresh install no longer overwrites the surviving backup with an
  empty one.

## [0.1.1] - 2026-08-17

### Added

- Crashes show a friendly restart-and-report screen instead of the app
  simply vanishing.

### Fixed

- The map no longer force-closes (out of memory) after adding a stray or
  zooming: tile providers are reused and cat avatars downscaled.

## [0.1.0] - 2026-08-15

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
- App icon: a Karteikarte with a cat face — generated for Android
  (including adaptive), iOS, Windows, and macOS from assets/icon/icon.svg.
- Device-to-device sync over the local network: host shows address + PIN,
  joiner syncs two ways (entries and photos, delta only) — no server, no
  account; every device converges to identical state.
- Conflict handling: concurrent edits of the same field are detected at
  sync (causally, via version vectors), badged amber, and resolved by
  choosing a value — the choice is a new history entry, nothing is lost.
- Merge for duplicates of all kinds — Cats, Clowders, Fields (same type):
  pick the survivor, the other record folds in alias-style with full
  history; late-syncing edits against the merged record land on the
  survivor.
- Desktop: Linux and Windows bundles built in CI and attached to releases.
- iOS permission strings for camera, photo library, and local network.
- Shared-folder sync: any cloud-drive or USB folder carries the catalog
  between devices that never meet — each device writes only its own file.
- Map (OpenStreetMap): Strays and Clowders as pins, offline cache of
  visited tiles, long-press to place a clowder or record a sighting.
- Stray Cam: one tap registers a stray at the current GPS position with a
  photo; "seen here now" records sightings of any cat.
- Movement trails: tap a stray's pin to see its dated positions connected
  on the map.
- CSV export of all cats via the share sheet (RFC 4180).
- About & feedback screen: version, source link, GitHub issues, mail,
  open-source licenses, and a donation link (hidden on iOS per App Store
  rules).
- 38 languages, machine-translated (corrections welcome on GitHub), with
  right-to-left support for Arabic, Farsi, and Hebrew; starter Field names
  and values translate per device language while the data stays canonical
  (ADR-0005); dates follow the device locale.
- Crop: a skippable crop step when importing photos (Stray Cam skips it),
  and "Crop…" on any photo — the cropped copy joins as a new photo, the
  original stays, so one litter photo serves several cats.
- Mark: drag an ellipse over one cat and a highlight is baked into a copy
  — for tangled kittens no crop can separate; prints like any photo.
- Desktop installs via Homebrew (`brew install --cask paxel/tap/catlog`,
  macOS dmg per architecture) and Scoop (`scoop install catlog`, Windows);
  Linux tar.gz for x86_64 and arm64 on every release.

- Pairing for device sync: hosting shows a QR code and a short typable
  code (auto-grouped, forgiving of case and look-alike characters);
  joining scans or types it and syncs immediately — no more IP + PIN
  fields. Hint for using a phone hotspot when there is no shared Wi-Fi.
- Sync by messenger: send the whole catalog as one file through WhatsApp,
  Signal, or mail; the other side imports it — cross-city sync, still no
  server.
- Position fields open a map picker (tap the spot or use GPS) instead of
  asking for coordinates.
- Creating clowders, cats, and strays and moving cats now ask "as of"
  which date — records that are years old carry their real dates.
- In-app language picker (all 38 languages, by native name).
- Donation link points to ko-fi.com/paxel7.
- Automatic uninstall-proof backup: leaving the app writes the full
  catalog as a sync bundle to Downloads/catlog (Android) or the Downloads
  folder (desktop) whenever something changed; restore via "Import sync
  bundle". Uninstalling the app can no longer lose your cats.

### Fixed

- Deterministic ordering could disagree between devices when a timestamp
  had exactly zero microseconds (variable-precision ISO strings compare
  wrongly); timestamps now store fixed precision, existing databases are
  repaired on open.
