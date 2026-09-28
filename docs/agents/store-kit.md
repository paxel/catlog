# Store kit: this repo's facts

Read by the global `store-kit` skill. Everything here is a fact about this
app; the method lives in the skill.

## Ids

| What | Value |
|---|---|
| Android package | `io.github.paxel.catlog` |
| iOS bundle id | `io.github.paxel.catlog` |
| App Store id | `6801824418` |
| Play page | <https://play.google.com/store/apps/details?id=io.github.paxel.catlog> |
| App Store page | <https://apps.apple.com/us/app/cat-a-log/id6801824418> |

## Locales

Play: en-US (default), de-DE. App Store: en-US; a German locale is added once
in App Store Connect, after which both stores take both languages.

## Version

`pubspec.yaml`, `version: X.Y.Z+B`. `B` is the Play versionCode and the
TestFlight build number. The tag pipeline (`.github/workflows/release.yml`,
`testflight.yml`) builds `catlog-X.Y.Z-android-playstore.aab`, uploads it to
Play's internal track, and uploads the iOS build to TestFlight.

## Changelog

`CHANGELOG.md` holds the current version; older sections sit in
`OLDER_CHANGES.md`, newest first. The release to describe is every section
after the live version.

## Screenshots

Generator: `test/screenshots/screenshots_test.dart`, run alone with
`flutter test test/screenshots --run-skipped --concurrency=1`. It renders a
demo catalog (five homes, ten cats, three authors, dated relative to today)
with real fonts and pre-downloaded tiles, and writes:

| Set | Folder | Size |
|---|---|---|
| README | `docs/screenshots/` | 820 × 1660 |
| Play phone | `docs/screenshots/play/play-NN-name.png` | 1080 × 1920 |
| Play tablet | `docs/screenshots/tablet/tablet10-NN-name.png` | 1440 × 2560 |
| App Store iPhone 6.9″ | `docs/screenshots/appstore/iphone-NN-name.png` | 1320 × 2868 |
| App Store iPad 13″ | `docs/screenshots/appstore/ipad-NN-name.png` | 2064 × 2752 |

The twelve frames, in store order:

| NN | name | Page |
|---|---|---|
| 01 | home | Home: clowders with cover pictures, favourite first |
| 02 | clowder | A clowder |
| 03 | cat | A cat |
| 04 | card | The printable card |
| 05 | timeline | The timeline |
| 06 | map | The map with trails |
| 07 | graph | Weight graph, smoothed, with trend |
| 08 | agenda | The agenda with chores |
| 09 | poster | The missing poster with preview |
| 10 | report | The vet report |
| 11 | sync | Shared folder: changes waiting |
| 12 | strays | The strays |

The poster preview needs `pdftoppm` on the box. The generator lags the UI
whenever nobody runs it; read it against the changelog before trusting it.

## Glossary

English term in the store text, and the `lib/l10n/app_de.arb` key whose value
the German must use. The check reads this table.

| English      | arb key            |
|--------------|--------------------|
| clowder      | `kindClowder`      |
| stray        | `stray`            |
| chore        | `choreLabel`       |
| appointment  | `appointmentLabel` |
| reminder     | `reminderLabel`    |
| Stray Cam    | `strayCam`         |
| card         | `card`             |
| agenda       | `agenda`           |
| timeline     | `timeline`         |
| vet report   | `vetReportTitle`   |

Keys that do not exist in the ARB are skipped by the check; fix the table
when a key is renamed.

## Out of the store texts

The desk app (`desktop/`) is not sold in either store. Desk-only changelog
entries stay out of every phone text; the listing names the desk platforms in
its platform line and nowhere else.
