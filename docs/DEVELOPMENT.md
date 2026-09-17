# Development

One Flutter codebase for Android, iOS, Linux, Windows, and macOS.

## Architecture

- `packages/catalog_core` — pure Dart, no Flutter. The append-only entry
  log over SQLite: every change is an immutable entry
  `(entity, field, value, date, author)`; a device's state is the union of
  all entries it has seen; the newest entry wins the display,
  deterministically on every device. Sync is a delta exchange of missing
  entries plus content-addressed photo blobs, over two transports (LAN
  HTTP, shared folder). Conflicts, merges (alias-based), and reverts are
  all ordinary entries.
- `lib/` — the Flutter app. UI only; all domain logic goes through the
  core's API.
- Decisions: `docs/adr/`. Domain vocabulary: `CONTEXT.md`. Both are kept
  current — read them before changing the model.

## Commands

```sh
# core tests (pure Dart, in-memory SQLite)
cd packages/catalog_core && dart test

# app analysis and widget tests
flutter analyze --fatal-infos && flutter test

# the Rust desktop app (see desktop/README.md for its gates)
cd desktop && cargo run --bin catlog

# regenerate the README screenshots (demo catalog, real fonts)
flutter test test/screenshots --run-skipped
```

## Translations

38 ARB files under `lib/l10n/`, machine-translated. `gen_l10n` runs on
build; the untranslated-messages report must stay empty. Starter field
names translate at display time (ADR-0005) — never store translations in
the data.

## Releases

Tag-driven, mirroring the dedup-rs pipeline: `git tag v2.0.0 && git push
--tags` (or the Actions "Run workflow" button with publish ticked) runs the
full gate, checks the tag against the pubspec and the Cargo versions, builds
signed Android APKs, the Rust desktop for Linux (tar.gz, .deb and AppImage,
x86_64 + arm64), a Windows zip, and unsigned macOS dmgs (both arches),
creates the GitHub Release with the CHANGELOG section as notes, and pushes
the Homebrew cask (macOS app), the Homebrew formula (Linux tarballs) and the
Scoop manifest to `paxel/homebrew-tap` and `paxel/scoop-bucket`. The
templates and packing scripts live under `desktop/packaging/`.

A dry run is the same button with publish left off: every artifact is
built and uploaded to the workflow run, nothing is released or pushed:

```sh
gh workflow run release.yml --ref release/2.0.0 -f tag=v2.0.0 -f publish=false
```

Required repository secrets: `ANDROID_KEYSTORE_BASE64`,
`ANDROID_KEYSTORE_PASSWORD`, `CHANNEL_PAT`, and (for TestFlight) the six
Apple secrets in `docs/ci-ios-signing.md`. Keystore backup notes:
`docs/release-android.md`.
