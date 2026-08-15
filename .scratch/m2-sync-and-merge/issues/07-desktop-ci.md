# 07 — Desktop builds in CI

**What to build:** Linux and Windows desktop bundles built in CI and attached to tag releases alongside the APKs, with a sane default window size. The PC becomes a first-class sync peer.

**Blocked by:** None (parallel to the rest).

**Status:** ready-for-agent

- [ ] CI job builds the Linux bundle (GTK deps installed on the runner) and zips it
- [ ] CI job builds the Windows bundle and zips it
- [ ] Release workflow attaches both to the GitHub Release
- [ ] Default window size set (e.g. 1100×750)
