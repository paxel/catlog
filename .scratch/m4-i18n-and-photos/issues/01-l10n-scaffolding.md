# 01 — l10n scaffolding, English + German, display-time starter translation

**What to build:** gen_l10n wired up; every hardcoded UI string extracted to ARB; English and German complete. Starter field names and canonical values (yes/no, gender options) translate at display time per ADR-0005 — renamed fields show as typed. Dates format per locale. RTL smoke-tested.

**Blocked by:** None.

**Status:** done

- [x] l10n.yaml + app_en.arb as the template; no hardcoded user-facing strings left in lib/
- [x] German ARB complete
- [x] Starter names/values translated at display time only while un-renamed
- [x] Dates via intl per locale
- [x] Widget tests under de; ar RTL check lands with ticket 02 (needs the ar ARB)
