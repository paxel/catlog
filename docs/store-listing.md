# Store listing kit

What each store actually requires, plus ready texts. Screenshots are the
only asset that needs real devices/emulators.

## Texts (both stores)

**Name**: cat(a)log

**Short description** (Play, ≤80 chars):
> Foster cats, organized: cards, history, map — local-first, no account.

**Full description**:
> cat(a)log is for people fostering cats. Keep every cat's card — photo,
> gender, neutered, anything you define — with a full history of every
> change: when spayed, when moved, when adopted. Share printable cards
> with adopters and vets. See strays on a map and follow their movements.
>
> Your data stays yours: everything lives on your device. Sync happens
> directly between your devices on your Wi-Fi, or through a folder on a
> cloud drive you already use. No server, no account, no tracking. Free
> and open source (Apache-2.0/MIT).

**Privacy policy URL**: publish `docs/privacy-policy.md` — simplest:
enable GitHub Pages on the repo, the file becomes
`https://paxel.github.io/catlog/privacy-policy`. Both stores require this
URL even for no-data apps.

## Google Play checklist

- [ ] $25 one-time registration, identity verification
- [ ] Store listing: texts above, app icon (have), 2–8 phone screenshots,
      feature graphic 1024×500 (can be generated from the icon artwork)
- [ ] Data safety form: "no data collected, no data shared" throughout
- [ ] Content rating questionnaire (IARC): everyone
- [ ] New personal accounts: closed test with 12+ testers for 14 days
      before production access — the real gate, plan for it
- [ ] AAB upload (`flutter build appbundle`), Play App Signing enrollment

## Apple App Store checklist

- [ ] App Store Connect app record (exists once TestFlight is set up)
- [ ] Screenshots: 6.7" iPhone set required (6.5"/5.5" optional now),
      iPad set if iPad is claimed — simulator screenshots are fine
- [ ] Description (above), keywords (cat, foster, rescue, adoption,
      offline), support URL (GitHub), privacy policy URL
- [ ] App Privacy questionnaire: "Data not collected"
- [ ] Age rating 4+
- [ ] IMPORTANT: remove/disable the external donation link on the iOS
      build (already hidden on iOS) — tips there must use In-App Purchase
- [ ] Review notes: mention local-network permission is for direct
      device-to-device sync

## Screenshots plan

Fill the catalog with 3–4 demo cats (good photos), then capture: clowder
grid, cat card, timeline, map with trail, sync screen. Android: emulator
or Pixel + `flutter screenshot`. iOS: Simulator on the GitHub runner or
any borrowed Mac; fastlane snapshot automates it later if ever needed.

## No marketing needed

Store search + F-Droid/IzzyOnDroid listings + the GitHub README are
enough for an app like this. A one-page GitHub Pages site (icon, three
screenshots, store badges) is the most that is worth doing.
