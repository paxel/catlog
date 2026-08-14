# 09 — iOS CI + TestFlight

**What to build:** Every push to the main branch produces an iOS build on GitHub Actions macOS runners, signed and uploaded to TestFlight, so the fosterer's iPhone receives the walking skeleton and every later slice without the developer owning a Mac (ADR-0003). Android side: a debug/release APK artifact from the same CI.

**Blocked by:** 01 — Walking skeleton.

**Status:** done (workflows in place; Apple secrets pending)

- [x] GitHub Actions workflow builds the Flutter iOS app on a macOS runner (ci.yml unsigned build; testflight.yml signed — first run pending push to GitHub)
- [ ] Signing configured against the paid Apple Developer account; secrets in repo settings — pending: needs the account owner, see docs/ci-ios-signing.md
- [ ] Successful builds upload to TestFlight; the fosterer is invited as tester — pending: blocked on the secrets above
- [x] Core test suite and analyzer run in CI on the Linux runner before any build
- [x] APK produced as a CI artifact for the Android device
