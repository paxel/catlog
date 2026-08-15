# 01 — l10n scaffolding, English + German, display-time starter translation

**What to build:** gen_l10n wired up; every hardcoded UI string extracted to ARB; English and German complete. Starter field names and canonical values (yes/no, gender options) translate at display time per ADR-0005 — renamed fields show as typed. Dates format per locale. RTL smoke-tested.

**Blocked by:** None.

**Status:** ready-for-agent

- [ ] l10n.yaml + app_en.arb as the template; no hardcoded user-facing strings left in lib/
- [ ] German ARB complete
- [ ] Starter names/values translated at display time only while un-renamed
- [ ] Dates via intl per locale
- [ ] Widget tests under de and ar (RTL) locales
