# Spec: v0.2.0 — private sharing, moderation, and polish

Status: ready-for-agent

## Problem Statement

Fosterers now share one catalog with their group, but sharing is all-or-nothing:
private things (a home address, a personal cat, a whole clowder) go to everyone
or stay off the catalog entirely. Received data cannot be trimmed to what a
user cares about. Cards always show every field. Positions display as raw
coordinates. The map cannot jump anywhere. A malicious group member can inject
abusive images with no way to purge or keep them out. And several small rough
edges (lonely clowder cards, Germany-centered position picker, no adoption joy)
make daily use clunkier than it should be.

## Solution

Sharing gets a privacy gate: anything can be marked Private and then only
leaves the device when the sender explicitly includes privates in that sync.
Display gets personal: entities and fields can be Hidden locally without
touching the shared data. Cards get a share-time field picker. Moderation gets
teeth: hard delete purges an author's material physically, a local ban keeps it
from coming back. Plus: species field, clowder status with recognized values,
map/geocode search where each belongs, richer clowder cards, position-as-map-chip,
an import summary of the events that matter, adoption confetti, and
cross-type field merge.

## User Stories

1. As a fosterer, I want to mark a cat, clowder, or field definition as Private, so that it never leaves my device in a normal sync.
2. As a fosterer, I want every sync/share to default to "public only", so that I cannot leak private data by accident.
3. As a fosterer, I want an "include private" option on each sync/share, so that I can move my own private data to my own second device.
4. As a fosterer, I want the private marker to travel with a private-included sync, so that my tablet also treats that cat as private afterwards.
5. As a fosterer, I want to unmark Private, so that an entity can become shared later (it then flows in normal syncs).
6. As a fosterer, I want a lock indicator on private entities, so that I always know what is protected.
7. As a group member, I want an import preview where I can uncheck entities, so that things I don't care about are Hidden (not blocked) from my views.
8. As a group member, I want hidden entities and hidden field definitions to keep syncing through my device unchanged, so that the group's data stays complete and accurate.
9. As a group member, I want a "show hidden" toggle, so that I can inspect and unhide anything I hid.
10. As a group member, I want hidden fields filtered from cat pages, forms, cards, and the diary alike, so that hiding is consistent everywhere.
11. As a fosterer, I want a field checklist when creating a card, so that I control exactly what an adopter or vet sees.
12. As a fosterer, I want the card sheet to remember my last selection, so that repeat cards are one tap.
13. As a fosterer, I want a species field (default "cat", free values), so that the occasional dog or rabbit can live in the catalog.
14. As a fosterer, I want to give a clowder a status (foster, forever home, clinic/vet, shelter, barn — or my own words), so that the kind of place is visible at a glance.
15. As a fosterer, I want recognized statuses shown as colored chips on clowder cards and detail, so that I can scan my list quickly.
16. As a fosterer, I want clowder cards to show the number of cats and a row of their little face photos, so that the card tells me who lives there.
17. As a fosterer, I want a confetti-and-sound celebration when I move a cat into a forever-home clowder, so that adoptions feel like the win they are.
18. As a fosterer, I want the party only on the device doing the move, respecting silent mode, with a settings switch, so that it never becomes an annoyance.
19. As a fosterer, I want positions shown as a "show on map" chip instead of coordinates, so that locations are one tap away and never noise.
20. As a fosterer, I want position excluded from cards by default, so that addresses of homes don't leak onto shared images.
21. As a fosterer, I want the position picker to open at my current location (or the last region I picked), so that I don't start at a country-level map.
22. As a fosterer, I want an address/city/country search inside the position picker, so that I can jump near the spot before dropping the pin.
23. As a fosterer, I want a search box on the map that matches our own cats, clowders, and author names, so that I can jump to the clowder on another continent when I only remember the person.
24. As a fosterer, I want multiple search hits zoomed-to-fit with a pick list, so that ambiguous names still get me there.
25. As a group member, I want a summary after every sync/import (LAN, folder, bundle) listing adopted, deceased, escaped, new cats/clowders, and conflicts, so that I see the events that matter without reading the diary.
26. As a group member, I want "…and n other changes" linking to a filtered timeline, so that the summary stays short but nothing is unreachable.
27. As a fosterer, I want deceased cats rendered dimmed with a localized "Deceased" chip (no religious symbols), so that the state is visible respectfully worldwide.
28. As a fosterer, I want to merge fields of different types with the survivor's type winning, so that "Number of legs" and "Limbs" can become one field even if their types differ.
29. As a fosterer, I want values that don't fit the surviving type to render as their raw text, so that no data is lost or blocked by a merge.
30. As a group admin in fact if not in title, I want to hard-delete every entry and photo of one author/device from my store, so that abusive or illegal material is physically gone.
31. As a group member, I want a local ban list (authors/devices and photo hashes) applied on receive, so that purged material cannot come back through any transport.
32. As a group member, I want banned material to be received-and-discarded (sync bookkeeping advances), so that peers don't re-offer it forever.
33. As a group member, I want to review and reverse ban entries in settings, so that mistakes are recoverable.
34. As a privacy-conscious user, I want the privacy policy to name the one new network call (geocoding search in the picker), so that the local-first promise stays honest.
35. As a fosterer, I want a new cat's name prefilled with a proposal from a big bundled list (classics, ancient/mythic, funny), with a dice button to reroll, so that naming ten look-alike kittens is fun instead of a chore.
36. As a fosterer, I want proposals in my language's flavor (global core list plus a per-locale bonus list), so that German cats can be offered "Mauzi" too.
37. As a fosterer, I want proposed names to skip names already in my catalog, so that the group doesn't end up with two Lunas.
38. As a fosterer, I want map pins to show faces and places — cat photo rings (bug: Stray-Cam cats currently show a paw despite having a photo), a drawn cat-face silhouette only when a cat truly has no photo, and the clowder's photo in a distinct ring with a house silhouette only as placeholder — so that the map reads as who and where, not as symbols.
39. As a desktop/iPad user, I want a master-detail layout on wide screens (list on the left, selected clowder/cat on the right, no page pushing), so that the app feels like a desktop app instead of a stretched phone app.
40. As a desktop user, I want keyboard control — arrows/enter in lists, Ctrl+F to search, Esc to go back/close, shortcuts for sync and backup — so that I can work without the mouse.
41. As a desktop/iPad user, I want desktop density and pointer manners — compact rows, hover states, right-click context menus (cat: card / move / merge; clowder: open / status) — so that common actions are one click away.
42. As a desktop user, I want the window to remember its size and position, so that the app opens the way I left it.

## Implementation Decisions

- **Private (wire-level)**: a `$private` marker entry per entity. Core exposes
  entry-listing for sync in two modes: public-only (default; private entities,
  their entries, and their blobs are stripped) and include-private. All three
  transports (LAN, folder, bundle) surface the choice at share/sync start;
  receiving side needs no changes. The marker syncs only in include-private
  mode. Unmarking writes a normal countermanding entry.
- **Folder sync nuance**: a device's folder export is written in one chosen
  mode; the default folder-share stays public-only, with include-private as an
  explicit per-folder setting.
- **Hidden (display-level)**: local settings (existing local_settings store),
  never on the wire — hidden entity ids and hidden field slugs. A single
  filtering point in the app layer feeds all views (lists, detail, forms, card
  defaults, diary/timeline, map). Import preview writes to the same hidden
  lists. "Show hidden" is a transient view toggle plus a settings page for
  unhiding.
- **Card composer**: share-time bottom sheet listing photo/name/fields with
  checkboxes; initial state = last selection (a local setting), first time =
  all non-hidden fields; position field unchecked by default always.
- **Species**: new starter field `species` (text, cat scope, default value
  "cat" on creation), translated like other starter fields per ADR-0005.
- **Clowder status**: new starter field `status` (choice-with-suggestions,
  clowder scope) with canonical keys `foster`, `forever_home`, `clinic`,
  `shelter`, `barn`, localized display values, free text allowed. Recognition
  maps a stored value to a canonical key only on exact match of a canonical
  value in any supported language; recognized keys drive chip color/icon and
  the adoption trigger.
- **Adoption trigger**: a Move into a clowder whose current status resolves to
  `forever_home` fires the celebration on the acting device only (no trigger
  from applyEntries). Confetti overlay + bundled sound asset; respects platform
  silent mode; settings toggle.
- **Position display**: the location field renders as a pin chip ("Show on
  map") opening the map centered on the value. No coordinate text anywhere in
  normal UI.
- **Position picker**: initial camera = device GPS if permitted, else last
  picked region (local setting), else world. Adds a geocode search field
  querying Nominatim (proper User-Agent, result list, tap = jump; no reverse
  geocoding). HTTP client injectable for tests. Privacy policy gains one line.
- **Map search**: local index over cat names, clowder names, and author names
  (authors resolved to the entities they authored entries for). Hits with a
  position: single hit = center+zoom, multiple = zoom-to-fit + pick list.
  Hidden entities excluded unless "show hidden" is active.
- **Clowder card**: occupancy count + up to N mini profile-photo circles +
  status chip; same header treatment on clowder detail.
- **Import summary**: applyEntries (all transports) returns the applied delta;
  the app classifies it into adopted (move into forever_home), deceased
  (deceased field set), escaped (membership ended without a new clowder), new
  cats/clowders, conflicts, rest-count. Sheet shown when the delta is
  non-empty; "other changes" opens the timeline filtered to the sync's entries.
- **Deceased rendering**: profile images desaturated/dimmed in lists, detail,
  and map; localized "Deceased <date>" chip. No symbols.
- **Cross-type field merge**: the same-type guard stays for entity kinds
  (cat/clowder/field) but drops the value-type equality requirement for
  field-to-field merges; survivor's definition (type, options) wins; values are
  strings on the wire and render raw when they don't parse under the survivor
  type.
- **Hard delete**: store operation deleting all entries attributed to an
  author (optionally scoped to author+device) plus blobs referenced only by
  those entries; runs in a transaction; sole append-only exception per
  ADR-0006. UI: settings → authors list → delete-all flow with a typed
  confirmation.
- **Ban list**: local table of banned authors/devices and banned blob hashes.
  applyEntries drops matching entries after recording vector progress;
  blob receive drops matching hashes. Hard-delete flow offers "also ban".
  Settings page lists and reverses ban entries. Never synced (ADR-0006).
- **No propagation of bans**, no content scanning, no detection claims — the
  docs say "removal tooling", nothing more.
- **Name proposal**: bundled offline name lists — one global core (classics,
  ancient/mythic, funny; ~1000 entries) plus small per-locale bonus lists
  merged by the active locale. New-cat form prefills a random proposal not
  already used in the catalog; dice button rerolls; typing overwrites. No
  network, no ARB round-trip (plain asset lists, not translations).
- **Map pins**: fix the Stray-Cam photo lookup so every cat with a photo shows
  its face ring; photoless cats get a drawn cat-face silhouette placeholder;
  clowder pins show the clowder photo in a visually distinct ring with a house
  silhouette only as placeholder.
- **Desktop layout**: width-based, not platform-based — one breakpoint
  (~840dp) switches to master-detail (clowders/cats list pane + detail pane;
  map and timeline stay full-bleed). iPad landscape gets it for free. Keyboard
  bindings and right-click context menus activate on desktop platforms and
  pointer-equipped tablets; density switches with the breakpoint. Window
  size/position persisted as a local setting on desktop. No native menu bar,
  no tray — in-app affordances only, one codebase, no platform forks.

## Testing Decisions

- Same seams as 0.1.0 — no new ones: core behavior tested against the public
  store/sync API in the pure Dart package; screens tested as widget tests.
  The one addition inside the existing seam: the picker's geocode client takes
  an injectable HTTP client so tests stub Nominatim.
- Good tests assert external behavior: what a public-only sync emits vs. an
  include-private sync; what a receiver stores when a ban matches; what
  applyEntries reports as the delta; what the summary classifier derives —
  never internal table shapes.
- Core: private stripping across all three transports' entry paths, marker
  travel in include-private mode, unmark-and-flow, ban receive-and-discard
  with vector advance, hard delete leaves no entries/blobs and outbound stays
  clean, cross-type merge with raw-value rendering, summary classification
  (adopted/deceased/escaped/new/conflict), status canonical-key resolution
  across locales.
- Widget: card composer sheet selection + persistence, hidden filtering on
  list/detail/diary, import summary sheet, clowder card occupancy row, position
  chip navigation, picker search flow with stubbed geocoder, confetti trigger
  gating (acting device only, toggle off).
- Prior art: existing store tests for sync/merge/conflicts; existing screen
  widget tests and the screenshot harness.

## Out of Scope

- Trust/identity system, paired-device model, ban propagation (rejected —
  worse weapon than the attack).
- Person/owner entity; author names stay plain strings.
- Reverse geocoding / address display for positions.
- Species-specific UI, terminology, or starter-field sets beyond the one field.
- Import blocking (receive-refusal); hiding is the only filter.
- Content detection/scanning of any kind.
- Celebration for non-adoption events.

## Further Notes

- Decisions were grilled one-by-one; glossary terms (Private, Hidden, Status,
  Deceased, Species, Ban, Hard Delete, updated Adoption) are in CONTEXT.md;
  the append-only exception is ADR-0006.
- All new user-facing strings need the full 38-language ARB round, including
  the five canonical status values (which double as recognition keys via
  their localized forms).
- Changelog: 0.2.0 section per the changelog skill — entries relative to
  0.1.0, so privacy/hiding/moderation land under Added, picker-start and
  position-display land under Changed/Fixed as appropriate.
