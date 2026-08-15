<p align="center">
  <img src="assets/icon/icon.png" width="128" alt="cat(a)log icon"/>
</p>

<h1 align="center">cat(a)log</h1>

<p align="center">
  <b>A local-first catalog for people fostering cats.</b><br/>
  Your data lives on your devices — no server, no account, no tracking.
</p>

---

Ten foster kittens that all look the same. Who is who? Who is already
neutered, who was spayed when, who moved to which adopter? cat(a)log keeps a
**card** for every cat — photo, gender, color, anything you define — and a
full **history** of every change: nothing is ever overwritten, every edit is
dated and signed with the name of the person who made it, and any mistake can
be reverted like a git commit.

- **Clowders** — a clowder (the actual English word for a group of cats) is a
  place cats live: a foster home, an adopter's flat, the old barn. Moving a
  cat between clowders *is* the adoption record.
- **Cards** — one screen per cat with photo and facts; share it as an image,
  export a PDF, print it for the vet's notice board.
- **Strays & map** — cats without a home live on an OpenStreetMap view with
  their movement trails. The Stray Cam registers a cat at your GPS position
  with a photo in one tap.
- **Sync without a server** — devices sync directly over your Wi-Fi (host
  shows address + PIN, other device joins), or through any shared folder a
  cloud drive or USB stick carries around. Every device converges to the same
  state; concurrent edits show a conflict badge and a human picks the truth —
  both versions stay in the history.
- **Duplicates merge** — two people registered the same cat, home, or field?
  Merge them; the survivor keeps its values, both histories combine.
- **Your fields** — track anything: add "flea treatment" as a date field and
  it works like the built-ins, timeline included.
- **38 languages** — including right-to-left Arabic, Farsi, and Hebrew.
  Translations are machine-made; corrections are one-line pull requests in
  [`lib/l10n/`](lib/l10n/).

## Screenshots

| Home | Cat | Card |
|---|---|---|
| ![Clowders](docs/screenshots/01-home.png) | ![Cat](docs/screenshots/03-cat.png) | ![Card](docs/screenshots/04-card.png) |

| Clowder | Timeline | Map |
|---|---|---|
| ![Clowder](docs/screenshots/02-clowder.png) | ![Timeline](docs/screenshots/05-timeline.png) | ![Map](docs/screenshots/06-map.png) |

*(Demo data — the cats in your catalog will be considerably fluffier.)*

## Install

| Platform | How |
|---|---|
| **Android** | APK from the [latest release](https://github.com/paxel/catlog/releases) (arm64 for modern phones) |
| **iPhone / iPad** | TestFlight (beta) — ask via an issue |
| **macOS** | `brew install --cask paxel/tap/catlog` — unsigned: right-click → Open on first launch |
| **Windows** | `scoop bucket add paxel https://github.com/paxel/scoop-bucket && scoop install catlog` |
| **Linux** | tar.gz (x86_64 / arm64) from the [latest release](https://github.com/paxel/catlog/releases) |

## How it works

Every change is an immutable entry `(entity, field, value, date, author)` in
an append-only log; a device's state is the union of all entries it has seen,
and the newest entry wins the display — deterministically, on every device.
Syncing is just exchanging missing entries, so it works over any transport
and never conflicts on the data level. Human conflicts (two people renamed
the same cat while apart) get a badge and a one-tap resolution that is itself
an ordinary history entry. The whole model lives in
[`packages/catalog_core`](packages/catalog_core) — pure Dart, no Flutter,
fully tested against in-memory SQLite. Decisions are documented in
[`docs/adr/`](docs/adr/), the domain vocabulary in [`CONTEXT.md`](CONTEXT.md).

## Development

```sh
# core tests (pure Dart)
cd packages/catalog_core && dart test

# app analysis and widget tests
flutter analyze && flutter test

# run the desktop app
flutter run -d linux

# regenerate the README screenshots
flutter test test/screenshots --run-skipped
```

Releases mirror the dedup-rs pipeline: `git tag v0.1.0 && git push --tags`
builds and publishes everything (see `docs/release-android.md`).

## License

Dual-licensed under Apache-2.0 or MIT, at your option. See `LICENSE-APACHE`
and `LICENSE-MIT`.
