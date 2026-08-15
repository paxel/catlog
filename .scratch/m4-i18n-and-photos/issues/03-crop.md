# 03 — Crop at import and later

**What to build:** Import flow gains a skippable crop screen (before compression); Stray Cam skips it. Photo menu gains "Crop…" which appends the cropped copy as a new photo — the original stays, so one litter photo serves several cats.

**Blocked by:** None (parallel to i18n; strings join the ARB once 01 lands).

**Status:** done

- [x] Crop screen in import flow with accept-full-frame skip; pure Flutter, all platforms
- [x] Stray Cam bypasses the crop screen
- [x] "Crop…" in the photo menu appends a copy, original kept
- [x] Unit test: crop rect applied to synthetic image bytes
