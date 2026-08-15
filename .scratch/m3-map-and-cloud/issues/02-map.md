# 02 — Map with Stray and Clowder pins

**What to build:** An OpenStreetMap map (flutter_map, attribution, disk tile cache) showing every Stray at its latest position and every Clowder with a position; tapping a pin opens the cat/clowder. Position is a starter Field (location, both scopes) added by migration — sightings and clowder locations are ordinary dated entries.

**Blocked by:** None (M1 base).

**Status:** ready-for-agent

- [ ] `position` starter field seeded for existing and new databases
- [ ] Map screen with OSM tiles, attribution, tile cache for offline viewing of visited areas
- [ ] Stray pins (latest position) and Clowder pins; tap opens detail
- [ ] Clowder position settable via "use my location" or long-press pin-drop
- [ ] Core tests: latest-position query; widget smoke test with injected positions
