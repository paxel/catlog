# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.0.7] - Unreleased

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

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
