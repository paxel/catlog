# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.1.0] - Unreleased

### Security

- In-person sync runs over TLS: the host uses a certificate made once
  on the device, the pair code carries its fingerprint (all of it in
  the QR, the first part in the typed code), and the joiner accepts no
  other. Nobody on the same Wi-Fi reads what passes any more. Both
  devices need 1.1.0; an older partner is named as such.

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

- "Possible stray area" on the map is a dialog with an OK button
  instead of a sheet that could only be closed by tapping beside it.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
