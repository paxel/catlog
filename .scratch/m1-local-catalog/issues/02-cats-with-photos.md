# 02 — Cats with photos

**What to build:** A fosterer adds a Cat to a Clowder with a name and a photo in under a minute, adds more photos over time, and sees the Clowder as a grid of cat faces with names. Photos are compressed on import; the first photo becomes the Profile Image automatically and can be swapped later.

**Blocked by:** 01 — Walking skeleton.

**Status:** ready-for-agent

- [ ] Cat can be created inside a Clowder with name and photo (camera or picked)
- [ ] Multiple photos per Cat; images compressed to 2560 px long edge on import
- [ ] Images stored content-addressed, referenced from entries by hash
- [ ] Profile Image defaults to the first photo; user can pick a different one
- [ ] Clowder view shows a grid of Profile Images with names
- [ ] Core tests cover image reference entries and profile-image defaulting/override
