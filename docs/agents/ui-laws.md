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
- **Swipe belongs to the notes at the top and nothing else.** Swipe left
  shows the next note, swipe right clears the news and leaves the
  failures; a failure goes only by swipe left or tap. No list row, card
  or page swipes.

## Announcements

- Everything the app has to say goes to the top of the screen, under
  the status bar: one note at a time, the page pushed down below it.
  Nothing ever appears at the bottom, where the gestures and the
  keyboard live — a snackbar is a bug.
- A note says only that a job finished, failed or waits; the tap opens
  the details. Values never go into a note.
- A quick local success the screen already shows (copied, recorded)
  gets a silent paw at the tapped button, no note.
- A failure's tap opens a dialog with cause, fix and the full text,
  Close and Report; the page it belongs to is a line inside, not a
  third button.
- An answer to a form field (name taken, not a code) is that field's
  own error text, red, under the field.

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
- On the phone, a page that adds in more than one way has one plus
  that fans the ways out (`AddFan`), each way an icon with its words;
  the plus reads minus while open. A page with one way says the way on
  its button. The ways to add are never in a menu or a sheet.
- On the desk every view opens with its name as a headline under the
  view bar, drawn in one place for all six; a view draws no title of
  its own, only its toolbar and content below the headline.

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
