# Spec: M3 — Cloud-folder sync, map, Stray Cam, CSV

Status: ready-for-agent

## Problem Statement

Sync works only when devices meet on one network; geographically separated helpers drift apart. Strays are a list, not a map — but their whole point is *where* they are and how they move. And data locked in the app cannot reach the closed shelter software world.

## Solution

A second sync transport: a shared folder on any file-sync service the group already runs (pCloud, Drive, Dropbox, Syncthing folder, USB stick). Each device appends its own export file; reading the others' files is a normal sync import — same engine as LAN (ADR-0002). Strays appear on an OpenStreetMap map with their latest position; the Stray Cam registers a cat at the current GPS position with a photo in one tap; a cat's positions connect into a movement trail. Cats export as CSV for everything else.

## User Stories

1. As a fosterer, I want to sync through a shared cloud folder, so that my friend across town and I stay current without meeting.
2. As a fosterer, I want the app to write only its own file in that folder, so that two devices never corrupt each other's data.
3. As a fosterer, I want photos to travel through the folder too, so that cards are complete everywhere.
4. As a fosterer, I want to see all Strays as pins on a map, so that I know where the colony is.
5. As a fosterer, I want Clowders as pins too, so that the map shows the whole operation.
6. As a fosterer, I want the Stray Cam: one tap creates a Stray at my current position with a photo, so that field registration takes seconds.
7. As a fosterer, I want to record a new sighting of a Stray at my position or a dropped pin, so that its movements accumulate.
8. As a fosterer, I want a Stray's movement trail on the map, so that I can see where it roams.
9. As a fosterer, I want to export all cats as CSV, so that shelters with other software can take the data.
10. As a fosterer, I want the map to work with cached tiles when offline in the field, so that rural spots do not blind me.

## Implementation Decisions

- **Folder transport**: user picks a directory (desktop: native picker; Android: SAF directory grant; iOS: documents/iCloud folder — degrade to unsupported message if the platform refuses persistent access). Layout: `catlog-sync/<deviceId>.jsonl` (that device's full entry log, appended), `catlog-sync/blobs/<hash>.jpg`. Sync = write own file + blobs, read all foreign files through the same idempotent import as LAN. Vector state makes re-reads cheap; files are append-only so partial writes cannot corrupt foreign data.
- **Position is a Field**: starter Field `position` (type location, scope both) added by migration — Stray sightings and Clowder locations are ordinary dated entries; the timeline mechanism already handles "when was it where".
- **Map**: flutter_map with OSM tiles, attribution shown, tile cache on disk for offline viewing of visited areas. Pins: Strays (latest position) and Clowders; tap → cat/clowder. Trail: polyline through a cat's position history, dated.
- **Stray Cam**: geolocator for GPS (permission flows per platform), then the existing create-with-photo flow, position entry appended automatically. Reachable from map and Strays screen.
- **Sightings**: on a cat, "seen here now" (GPS) or long-press on the map to drop a pin for it.
- **CSV export**: all non-deleted cats × (name, clowder, all field slugs with current values, deceased, position, image count); share sheet via the existing export path. UTF-8, comma, RFC-quoted.
- iOS/Android location + camera permission strings; map denied-permission states degrade to view-only.

## Testing Decisions

- Folder transport at the engine seam with a temp directory standing in for the cloud folder: two stores, folder round-trip, convergence; foreign-file-only reads (never writes); blob transfer.
- Position/sighting logic and CSV serialization as plain core tests (CSV quoting, field column stability).
- Map and Stray Cam UI: widget smoke tests with fake position provider; GPS/camera flows verified manually on device (same policy as card printing in M1).

## Out of Scope

- Encryption of the folder contents (open item from M1 grilling; revisit before recommending hostile-cloud use).
- Automatic background sync of the folder — manual action, like LAN.
- Geocoding addresses to coordinates (no server dependency; positions are GPS or pin-drop).
- Offline tile pre-download of arbitrary regions.

## Further Notes

- The folder transport must not require the cloud vendor's SDK — it is plain files, which is what keeps it vendor-neutral and cheap (ADR-0002).
