# cat(a)log

A local-first catalog for people fostering cats. Track Clowders (places cats
live), Cats with photos and dated field history, and produce shareable,
printable Cards — no server, no account, your data stays on your devices.

Built with Flutter for iPhone, iPad, Android, Linux, Windows, and macOS.

## Status

Early development — milestone M1 (local-only catalog with Cards) in progress.
See `CHANGELOG.md` and `.scratch/m1-local-catalog/` for the roadmap.

## Architecture

- `packages/catalog_core` — pure Dart. Append-only entry log over SQLite with
  a latest-wins projection; every change is dated, authored, and kept as
  history. See `docs/adr/0001-append-only-entries-latest-wins.md`.
- `lib/` — the Flutter app. UI only; all domain logic goes through the core.

Domain vocabulary lives in `CONTEXT.md`, decisions in `docs/adr/`.

## Development

```sh
# core tests
cd packages/catalog_core && dart test

# app analysis and widget tests
flutter analyze && flutter test

# run the desktop app
flutter run -d linux
```

## Translations

The app ships in 38 languages. Translations are machine-made; corrections
are very welcome — each language is one file under `lib/l10n/app_<code>.arb`,
so fixing a bad string is a one-line pull request.

## License

Dual-licensed under Apache-2.0 or MIT, at your option. See `LICENSE-APACHE`
and `LICENSE-MIT`.
