# Changelog

All notable changes to cat(a)log are documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning: [SemVer](https://semver.org/).

## [2.0.7] - Unreleased

### Fixed
- Deleting a catalog takes the one the question names. Looking at another catalog on the Catalogs page could leave that one marked, and the delete from Settings then took it instead of the one it had asked about.
- "Move in from another catalog" works with three catalogs or more; it used to do nothing at all, throwing where nobody could see it.
- What arrives from a phone or a folder shows up at once: a sync wrote the entries but never told the views, so the cats, the dashboard, the agenda and the family tree went on showing the catalog as it was before it.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
