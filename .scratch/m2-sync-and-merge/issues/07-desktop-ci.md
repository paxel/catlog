# 07 — Desktop builds in CI

**What to build:** Linux and Windows desktop bundles built in CI and attached to tag releases alongside the APKs, with a sane default window size. The PC becomes a first-class sync peer.

**Blocked by:** None (parallel to the rest).

**Status:** done

- [x] CI job builds the Linux bundle (GTK deps installed on the runner) and zips it
- [x] CI job builds the Windows bundle and zips it
- [x] Release workflow attaches both to the GitHub Release
- [x] Default window size: Flutter template default of 1280×720 kept — already sane
