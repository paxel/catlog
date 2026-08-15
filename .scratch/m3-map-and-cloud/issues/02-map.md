# 02 — Map with Stray and Clowder pins

**What to build:** An OpenStreetMap map (flutter_map, attribution, disk tile cache) showing every Stray at its latest position and every Clowder with a position; tapping a pin opens the cat/clowder. Position is a starter Field (location, both scopes) added by migration — sightings and clowder locations are ordinary dated entries.

**Blocked by:** None (M1 base).

**Status:** done

- [x] `position` starter field seeded for existing and new databases
- [x] Map screen with OSM tiles, attribution, tile cache for offline viewing of visited areas
- [x] Stray pins (latest position) and Clowder pins; tap opens detail
- [x] Clowder position settable via long-press pin-drop ("use my location" lands with ticket 03's GPS)
- [x] Core tests: latest-position query; widget smoke test with injected positions
