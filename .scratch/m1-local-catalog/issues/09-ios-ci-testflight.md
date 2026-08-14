# 09 — iOS CI + TestFlight

**What to build:** Every push to the main branch produces an iOS build on GitHub Actions macOS runners, signed and uploaded to TestFlight, so the fosterer's iPhone receives the walking skeleton and every later slice without the developer owning a Mac (ADR-0003). Android side: a debug/release APK artifact from the same CI.

**Blocked by:** 01 — Walking skeleton.

**Status:** ready-for-agent

- [ ] GitHub Actions workflow builds the Flutter iOS app on a macOS runner
- [ ] Signing configured against the paid Apple Developer account; secrets in repo settings
- [ ] Successful builds upload to TestFlight; the fosterer is invited as tester
- [ ] Core test suite and analyzer run in CI on the Linux runner before any build
- [ ] APK produced as a CI artifact for the Android device
