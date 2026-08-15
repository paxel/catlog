# 05 — CSV export

**What to build:** Export all non-deleted Cats as CSV via the share sheet: name, clowder, every field slug with current value, position, image count. UTF-8, comma-separated, RFC 4180 quoting — importable by spreadsheets and shelter software.

**Blocked by:** None (M1 base).

**Status:** ready-for-agent

- [ ] CSV of all cats with stable column order (built-ins first, then field slugs alphabetically)
- [ ] RFC 4180 quoting; UTF-8
- [ ] Share via the platform share sheet from the home screen menu
- [ ] Core tests: serialization, quoting edge cases (commas, quotes, newlines in values)
