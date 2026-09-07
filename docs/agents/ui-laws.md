# UI laws

Rules every screen follows. Check a change against them before it lands;
a screen that breaks one is a bug, not a style choice.

## Gestures

- **Tap is the primary action.** On a list row it opens the thing; on a
  checkbox it ticks. A tap never opens a menu.
- **Long-press is the secondary action**: a menu, or the editor when
  there is only one thing to do. Every long-press never changes data by
  itself.
- **Every widget with a long-press wears the cat ear** (`WithCatEar` in
  `lib/src/widgets/cat_ear.dart`). No ear, no long-press; a long-press
  without an ear is undiscoverable and therefore wrong.
- A checkbox or switch is the only thing that toggles state; the row
  around it does not.

## Dialogs and pages

- A dialog has one question and at most two actions plus Cancel. More
  than that is a page.
- Text and buttons must be readable at the phone's default font size:
  buttons stacked full width or in one row of two, never a cramped row
  of four. The content scrolls if it does not fit; nothing shrinks to
  fit.
- Two sentences at most in a dialog body. Concrete nouns, no metaphors
  (see the plain-text rule in `CONTEXT.md`).
- Destructive actions (delete, end, hard delete) confirm once, in a
  dialog whose confirm button carries the verb and the error colour.
- An editor with several fields is a full-screen page with Save in the
  top bar; secondary state changes (pause, end) are rows at the bottom.

## Lists and sections

- A section that is rarely needed folds; the fold is remembered per
  device in a local setting (`fold:<id>` or `chips:<id>`), closed by
  default when there is already a choice.
- Rows show what the keeper needs to act, not the stored encoding:
  dates in the device format, values translated, keys never.

## Wording

- The UI speaks of people and keys, cats and homes; never of devices,
  entries, entities or hashes.
- Errors name the cause and the fix in one sentence each.
