# 01 — Walking skeleton: app + catalog core + first Clowder

**What to build:** A fosterer installs the app, enters their Author name once, creates a Clowder with address and responsible person, and sees it in the Clowder list. The data survives restarts, and editing a Clowder value is recorded as a dated, authored change. Under the hood this establishes the whole architecture: a Flutter app (iOS/Android) talking only to a pure-Dart catalog core that owns an append-only entry log over SQLite with latest-wins projection (ADR-0001).

**Blocked by:** None — can start immediately.

**Status:** ready-for-agent

- [ ] First launch asks for an Author name; it is stamped on every entry thereafter
- [ ] Clowder can be created and edited; address and responsible person use the Field mechanism
- [ ] Clowder list shows all Clowders; data persists across app restarts
- [ ] Catalog core is pure Dart (no Flutter imports); UI reaches data only through its API
- [ ] Entries are append-only `(entity, field, value, date, author)`; edits never overwrite
- [ ] Displayed values come from the latest-wins projection with deterministic tiebreak
- [ ] Core behavior tests run against real in-memory SQLite (e.g. edit twice → latest shows, both in history)
- [ ] Repo is public with Apache-2.0/MIT dual license files
