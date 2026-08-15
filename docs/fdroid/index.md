# cat(a)log F-Droid repository

Get cat(a)log through the F-Droid app and receive updates automatically.

## Add the repository

1. Install [F-Droid](https://f-droid.org) if you don't have it.
2. In F-Droid: **Settings → Repositories → +** and enter:

   **Repository address:**
   ```
   https://paxel.github.io/catlog/fdroid/repo
   ```

   **Fingerprint:**
   ```
   2BC56445C8941E060DDD47E3B6D94BDB961D5C0B3854F754520FD181A4F858E8
   ```

   (Easiest on the phone: open this page and long-press-copy both.)

3. Pull down to refresh, search for **cat(a)log**, install.

Updates appear in F-Droid like for any other app whenever a new version is
released.

## Maintainer notes

The repo is generated with `fdroidserver` from the GitHub release APK
(arm64-v8a); working directory and signing keystore live in the private
backup folder. To publish a new version: drop the new APK into
`fdroid-work/repo/`, run `fdroid update`, copy `repo/` back to
`docs/fdroid/repo/`, commit.
