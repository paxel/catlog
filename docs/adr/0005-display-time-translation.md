# Starter fields translate at display time, never in the data

UI strings localize via Flutter gen_l10n (~36 languages, machine-translated, community-corrected; RTL for ar/fa/he comes from Flutter). But starter Field names ("Gender") and their canonical values ("female", "yes") are *entries* — synced data. Storing translations there would make mixed-language groups fight via latest-wins (German phone renames to "Geschlecht", French phone back to "Sexe").

Decision: seeded entries stay canonical English; the UI translates them at display time, keyed by the stable starter slug (`gender`, …) and canonical value strings — but only while the field's name is untouched. Once a user renames a field, the typed name wins everywhere, untranslated, because we cannot translate arbitrary user language and must not pretend to. User-defined fields and choice options always display as typed. Cards print in the viewing device's language.

Rejected: seeding in the first device's language — locks the catalog to whoever installed first and still mixes languages across a group.
