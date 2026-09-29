# Desktop strings

The phone app's `lib/l10n/app_*.arb` files are the single source of every
string the desktop shows. The few strings only a desktop needs, such as the
menu bar, live here as `desktop_<locale>.arb` and are merged over the phone
files at build time by `catlog-l10n`. A locale without a desktop file, or
without a key, falls back to English.
