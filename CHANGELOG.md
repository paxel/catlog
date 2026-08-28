# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.0.3] - Unreleased

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

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
