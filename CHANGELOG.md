# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [1.1.3] - Unreleased

### Fixed

- Map pins stay on their spot while zooming: the tip was anchored a
  pin's height below the coordinate and slid over the map.
- Deleting an author's data acts on that author on that one device,
  and the ban is on the device. Before, every author with the same
  name on any device was deleted and the name was banned, so anyone
  could take a name and get its owner wiped. The bans list shows the
  names a banned device wrote under.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
