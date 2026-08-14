# Android release signing & tagged releases

## Keystore

The upload keystore lives OUTSIDE the repo at `~/keys/catlog-upload.jks`
(alias `catlog`). **Back it up somewhere safe** (password manager +
offline copy): losing it means every user must uninstall/reinstall, and
an F-Droid/IzzyOnDroid listing would break.

Local release builds read `android/key.properties` (gitignored). Without
that file, release builds fall back to debug signing so `flutter run
--release` works for anyone cloning the repo.

## Repository secrets (GitHub → Settings → Secrets → Actions)

| Secret                      | Content                              |
| --------------------------- | ------------------------------------ |
| `ANDROID_KEYSTORE_BASE64`   | `base64 -w0 ~/keys/catlog-upload.jks` (already at `~/keys/catlog-upload.jks.base64`) |
| `ANDROID_KEYSTORE_PASSWORD` | the keystore/key password            |

## Releasing

```sh
git tag v0.1.0
git push origin v0.1.0
```

The `Release` workflow builds signed per-ABI APKs plus a universal one
and attaches them to a GitHub Release with generated notes. The same tag
also triggers the TestFlight workflow for iOS once its secrets exist.

## Distribution channels

- **GitHub Releases** — immediate, source of truth.
- **IzzyOnDroid** — submit once the first release exists; they pull the
  arm64 APK from GitHub Releases (fits their ~30 MB limit; the universal
  APK does not).
- **Official F-Droid** — later: needs fastlane metadata and an
  fdroiddata merge request; slow but highest trust.
- **Google Play** — deliberately skipped for now (12-tester/14-day
  closed-test gate for new individual accounts).
