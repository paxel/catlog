# 05 — Move & Stray

**What to build:** A fosterer Moves a Cat to another Clowder in two taps — adoption is exactly this — or records a Cat leaving with no destination, making it a Stray. A Strays list shows all Cats currently in no Clowder. Every Move appears in the Cat's timeline.

**Blocked by:** 03 — Fields + timeline.

**Status:** done

- [x] Move action: pick target Clowder; membership is an ordinary dated field change
- [x] "Left / ran away" action clears membership; Cat becomes a Stray
- [x] Strays list shows all Cats with no current Clowder
- [x] Moves and departures appear in the timeline with date and Author
- [x] Core tests cover membership transitions and Stray queries
