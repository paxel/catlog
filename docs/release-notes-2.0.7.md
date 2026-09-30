# Release notes 2.0.7

## Summary

Both stores carry 1.4.0, so this release brings a keeper everything from 2.0.0 to 2.0.7 in one update. The store frames were regenerated from the branch: every page on them changed since 1.3.3. Play is listed in en-US and de-DE; the App Store in English, with the German texts here for the locale to add once in App Store Connect.

- Play Kit — <https://claude.ai/artifact/P1GAvwB85NdLWJw3GWvGNB>
- App Store Kit — <https://claude.ai/artifact/8BKZPKM7QuXRhFwaUZDiZM>

<!-- store-kit
live_play: 1.4.0
live_appstore: 1.4.0
head: 2.0.7
sections: 2.0.7, 2.0.6, 2.0.5, 2.0.4, 2.0.3, 2.0.2, 2.0.1, 2.0.0
frames: regenerated
-->

## Play: release notes

<!-- block id=play_notes_en limit=500 lang=en title="Release notes, en-US" where="Production release" -->
```
Added
• A cat that died: a mourning band on its picture, the age it reached on its card
• Your own sound for each moment; a cat's voice for chore reminders

Changed
• Notes appear at the top of the screen, one at a time
• One plus per page fans out the ways to add
• Menus open where you touch; nothing slides up from below
• Video frames are picked while the video plays
• A shared folder carries a change within a minute

Fixed
• Conflicts, appointments, sounds, folder sync
```

<!-- block id=play_notes_de limit=500 lang=de title="Versionshinweise, de-DE" where="Production release" -->
```
Neu
• Eine verstorbene Katze: Trauerflor auf dem Bild, erreichtes Alter auf der Karte
• Eigener Klang je Moment; Katzenstimme für Aufgaben-Erinnerungen

Geändert
• Meldungen erscheinen oben, eine nach der anderen
• Ein Plus je Seite fächert die Wege auf
• Menüs öffnen am Finger; nichts fährt von unten herein
• Videobilder werden gewählt, während das Video läuft
• Ein geteilter Ordner trägt eine Änderung binnen einer Minute

Behoben
• Konflikte, Termine, Klänge, Ordnerabgleich
```

## App Store: What's New

<!-- block id=appstore_whatsnew_en limit=4000 lang=en title="What's New, English" where="Version information" -->
```
A cat that died: its photo wears a mourning band in every list, on the map and on its card, and the card and the report for the vet give the age it reached.

Notes now appear at the top of the screen, one at a time. Tap one for the details, swipe left for the next, swipe right to clear them. A note about something that failed stays until you deal with it, and a quick success answers with a green paw at the button you touched.

One plus on every page fans out the ways to add, each with its words. Menus open where you touch, and nothing slides up from the bottom any more.

Frames from a video are picked on a page that plays it: play, pause, and steps of one frame, one second or ten seconds.

Every moment has its own sound — a chore ticked, the day's chores done, an achievement, an adoption. Choose one of the cat sounds, a file of your own, or none. A chore's reminder can speak with a cat's voice instead of the standard notification sound.

A shared folder carries a change within a minute. If two of you changed the same thing, the conflict is settled on its own row: both values stand there with who wrote them and when, and a tap keeps one.

Chores, reminders and appointments share one row: the box ticks or finishes it, a tap opens whose it is, a hold edits it, the bin takes it off the list. A history row with a place opens the map on that spot, an achievement can be deleted by holding it, and the report for the vet is previewed as it will print.

Also fixed: an appointment could be saved with nobody to visit, moving in from another catalog did nothing with three catalogs or more, saving picked video frames could hang, turning the adoption confetti off silenced every other sound, and a sound chosen in one catalog did not apply to the others.
```

<!-- block id=appstore_whatsnew_de limit=4000 lang=de title="Neue Funktionen, Deutsch" where="Version information" -->
```
Eine verstorbene Katze: ihr Foto trägt einen Trauerflor in jeder Liste, auf der Karte und auf ihrer Karteikarte, und Karteikarte wie Bericht für den Tierarzt nennen das Alter, das sie erreicht hat.

Meldungen erscheinen jetzt oben am Bildschirmrand, eine nach der anderen. Tippen zeigt die Einzelheiten, ein Wisch nach links die nächste, ein Wisch nach rechts räumt sie weg. Eine Meldung über einen Fehlschlag bleibt stehen, bis du dich darum kümmerst, und ein kleiner Erfolg antwortet mit einer grünen Pfote an der Schaltfläche.

Ein Plus auf jeder Seite fächert die Wege zum Hinzufügen auf, jeder mit seinen Worten. Menüs öffnen dort, wo du tippst, und nichts fährt mehr von unten herein.

Videobilder werden auf einer Seite ausgewählt, die das Video abspielt: Abspielen, Pause und Schritte von einem Bild, einer Sekunde oder zehn Sekunden.

Jeder Moment hat seinen eigenen Klang — eine abgehakte Aufgabe, das Tagwerk, eine Auszeichnung, eine Vermittlung. Wählbar sind eine der Katzenstimmen, eine eigene Datei oder gar nichts. Die Erinnerung an eine Aufgabe kann mit Katzenstimme sprechen statt mit dem üblichen Benachrichtigungston.

Ein geteilter Ordner trägt eine Änderung binnen einer Minute weiter. Habt ihr beide dasselbe geändert, wird der Konflikt in seiner Zeile entschieden: beide Werte stehen da, mit wem und wann, und ein Tippen behält einen.

Aufgaben, Erinnerungen und Termine haben eine gemeinsame Zeile: das Kästchen hakt ab oder schließt ab, ein Tippen öffnet, zu wem es gehört, ein Halten bearbeitet, der Eimer nimmt es von der Liste. Eine Verlaufszeile mit Ort öffnet die Karte an dieser Stelle, eine Auszeichnung lässt sich durch Halten löschen, und der Bericht für den Tierarzt wird angezeigt, wie er gedruckt wird.

Außerdem behoben: ein Termin ließ sich ohne Besuchte speichern, „Aus einem anderen Katalog übernehmen“ tat bei drei Katalogen und mehr nichts, das Speichern ausgewählter Videobilder konnte hängen, das Ausschalten des Vermittlungskonfettis brachte alle anderen Klänge zum Schweigen, und ein in einem Katalog gewählter Klang galt nicht in den anderen.
```

## Tester notes

<!-- block id=tester_notes limit=4000 lang=en title="What to test" where="TestFlight test information · Play internal track" -->
```
What to test
• Tick a chore and listen; change its sound under Settings, Sounds, and tick again.
• Add a photo from a video: play, pause, step a frame, keep two frames, save.
• Mark a cat deceased and check the mourning band in the list and the age line on its card.
• Sync a shared folder between two devices, change the same value on both, and settle the conflict on its row.
• Watch the notes at the top: finish a sync, then make something fail (a folder that is gone), and check that the failure waits for you.

Known
• The desk app for Linux, Windows and macOS is a separate download from the project's release page; it opens the same catalogs and shared folders.
• The translations outside English and German are machine-made.
```

## Play: listing

The live text, verbatim. Changed only through an accepted edit below.

<!-- block id=play_title limit=30 lang=en title="Title" where="Main store listing" -->
```
cat(a)log
```

<!-- block id=play_short_en limit=80 lang=en title="Short description, en-US" where="Main store listing" -->
```
Shared memory of your animals: where each lives, what happened, who did what.
```

<!-- block id=play_short_de limit=80 lang=de title="Kurzbeschreibung, de-DE" where="Main store listing" -->
```
Gemeinsames Gedächtnis eurer Tiere: wo jedes lebt, was geschah, wer was tat.
```

<!-- block id=play_full_en limit=4000 lang=en title="Full description, en-US" where="Main store listing · b i u br count" -->
```
<b>cat(a)log is the shared memory of a group of people who care for cats — or for any pets.</b> It answers, at any time and for every animal: who is this, where does it live right now, what has happened to it, and who did what, when.

It is built for how animal care actually works. Cats move: from the shelter to a foster home, from the foster home to an adopter, out of a garden and onto the street, back again. Several people keep the record: you, the person who covers your weekends, the neighbour who feeds the colony. Nobody has a server, and nothing must get lost.

<b>THE RECORD</b>
• <b>Every animal has a place.</b> Cats live in clowders — your home, a foster home, an adopter's flat, the barn behind the station. Moving one is a dated event, so the record knows where Miezi was in May and who has her now. An animal without a place is a stray, and the app treats it as one.
• <b>Every fact has a date and a name.</b> Neutered, vaccinated, weighed, moved, renamed: the app stores when it happened and who wrote it down, not just the current value. A cat's page reads like a diary. Nothing is ever overwritten; a mistake is corrected with a new entry, and the correction is visible too.
• <b>Weight and every other number get a graph.</b> Weight is built in, in your units — kilograms or pounds, as your region says — and any number you log, a temperature or a dose, is drawn over time: week, month, year, the change since last time, vet visits marked along the way.
• <b>Several people, one record, no server.</b> Each helper carries the whole catalog on their own device. Phones sync directly and encrypted over Wi-Fi, through a folder you already share (Nextcloud, Syncthing, a USB stick), or as a file through any messenger. If two people changed the same thing at once, both versions are shown and you decide.
• <b>One cat is one cat.</b> Chip numbers and registry numbers (TASSO and others, opened with one tap) identify an animal. Two entries that are the same cat are merged, and both histories survive. A stray seen inside the search area of a missing cat is offered as a possible match.

<b>WHAT THAT MEANS DAY TO DAY</b>
• <b>Fostering a litter:</b> which of the ten identical kittens is already neutered, which one went to the family in the next town, and when. One vet appointment for the whole litter — tick the cats that come along, and afterwards note who was treated.
• <b>Feeding a colony:</b> a new face at the feeding spot gets a photo and a position with one tap; when it turns up two streets away, the map draws its trail. Over months, the record shows who belongs to the colony and who was passing through.
• <b>A cat is missing:</b> photograph the poster you hang up, or one somebody else hung up. The app reads the poster, marks the spot, and draws the 500 m area where the cat probably roams. The next sighting inside that area lands on the right cat.
• <b>Your own pets:</b> switch a catalog to pets and it speaks of pets and households — dog, rabbit, horse, whatever lives with you, each with its own breeds. Chip number, vaccinations, vet visits, medication, weight — and appointments in an agenda your phone's calendar can mirror.

<b>ALSO</b>
• Your own fields — "flea treatment", "favourite food", a body temperature in °C or °F — behave like the built-in ones, history and graph included.
• Photos: crop one kitten out of a group picture, or circle it when they are too tangled to crop.
• A printable page per animal with photo and chip code, for the vet or the adopter.
• Runs offline. Android, iOS, Windows, macOS, Linux.
• 38 languages, right-to-left included.
• Free, open source (Apache-2.0 / MIT), no ads, no account, no tracking. Your data stays on your devices, in a format you can read and export.
```

<!-- block id=play_full_de limit=4000 lang=de title="Vollständige Beschreibung, de-DE" where="Main store listing · b i u br count" -->
```
<b>cat(a)log ist das gemeinsame Gedächtnis einer Gruppe von Menschen, die sich um Katzen kümmern — oder um andere Haustiere.</b> Es beantwortet jederzeit und für jedes Tier: Wer ist das, wo lebt es gerade, was ist mit ihm passiert, und wer hat wann was gemacht.

Es ist für die Wirklichkeit der Tierhilfe gebaut. Katzen ziehen um: aus dem Tierheim in die Pflegestelle, von der Pflegestelle zu den Adoptanten, aus dem Garten auf die Straße und wieder zurück. Mehrere Leute führen die Aufzeichnungen: du, wer dich am Wochenende vertritt, die Nachbarin, die die Kolonie füttert. Niemand hat einen Server, und nichts darf verloren gehen.

<b>DIE AUFZEICHNUNG</b>
• <b>Jedes Tier hat einen Ort.</b> Katzen leben in Kolonien — dein Zuhause, eine Pflegestelle, die Wohnung der Adoptanten. Ein Umzug ist ein datiertes Ereignis, darum weiß die Aufzeichnung, wo Miezi im Mai war und wer sie jetzt hat. Ein Tier ohne Ort ist ein Streuner, und die App behandelt es so.
• <b>Jede Tatsache hat Datum und Namen.</b> Kastriert, geimpft, gewogen, umgezogen, umbenannt: die App speichert, wann es passiert ist und wer es eingetragen hat, nicht nur den aktuellen Wert. Die Seite einer Katze liest sich wie ein Tagebuch. Nichts wird je überschrieben; ein Fehler wird mit einem neuen Eintrag korrigiert, und auch die Korrektur bleibt sichtbar.
• <b>Gewicht und jede andere Zahl bekommen ein Diagramm.</b> Gewicht ist eingebaut, in deinen Einheiten — Kilogramm oder Pfund — und jede Zahl, die du festhältst, wird über die Zeit gezeichnet: Woche, Monat, Jahr, Änderung seit dem letzten Mal.
• <b>Mehrere Leute, eine Aufzeichnung, kein Server.</b> Jede Helferin trägt den ganzen Katalog auf dem eigenen Gerät. Handys gleichen sich direkt und verschlüsselt über WLAN ab, über einen Ordner, den ihr ohnehin teilt (Nextcloud, Syncthing, USB-Stick), oder als Datei über jeden Messenger. Haben zwei Leute gleichzeitig dasselbe geändert, zeigt die App beide Versionen, und ihr entscheidet.
• <b>Eine Katze ist eine Katze.</b> Chipnummern und Registernummern (TASSO und andere, mit einem Tipp geöffnet) identifizieren ein Tier. Zwei Einträge, die dieselbe Katze sind, werden zusammengeführt, und beide Geschichten bleiben erhalten.

<b>WAS DAS IM ALLTAG HEISST</b>
• <b>Einen Wurf in Pflege:</b> welches der zehn gleich aussehenden Kitten ist schon kastriert, welches ist zur Familie im Nachbarort gezogen, und wann. Ein Tierarzttermin für den ganzen Wurf — die Katzen anhaken, die mitkommen, und hinterher festhalten, wer behandelt wurde.
• <b>Eine Kolonie füttern:</b> ein neues Gesicht am Futterplatz bekommt mit einem Tipp Foto und Position; taucht es zwei Straßen weiter wieder auf, zeichnet die Karte seinen Weg. Über Monate zeigt die Aufzeichnung, wer zur Kolonie gehört und wer nur durchkam.
• <b>Eine Katze wird vermisst:</b> fotografiere den Aushang, den du aufhängst, oder einen, den jemand anders aufgehängt hat. Die App liest den Aushang, merkt sich den Ort und zeichnet das 500-m-Gebiet, in dem die Katze wahrscheinlich unterwegs ist. Die nächste Sichtung in diesem Gebiet landet bei der richtigen Katze.
• <b>Die eigenen Tiere:</b> stelle einen Katalog auf Tiere um, und er spricht von Tieren und Haushalten — Hund, Kaninchen, Pferd, was bei dir lebt. Chipnummer, Impfungen, Tierarztbesuche, Medikamente — und Termine in einer Agenda, die der Kalender des Handys spiegeln kann.

<b>AUSSERDEM</b>
• Eigene Felder — „Flohbehandlung“, „Lieblingsfutter“, eine Temperatur — verhalten sich wie die eingebauten, Geschichte und Verlauf inklusive.
• Fotos: ein Kitten aus dem Gruppenbild ausschneiden oder einkreisen, wenn sie zu verknäult sind.
• Eine druckbare Seite pro Tier mit Foto und Chipcode, für den Tierarzt oder die Adoptanten.
• Funktioniert offline. Android, iOS, Windows, macOS, Linux.
• 38 Sprachen, auch von rechts nach links.
• Kostenlos, quelloffen (Apache-2.0 / MIT), ohne Werbung, ohne Konto, ohne Tracking. Deine Daten bleiben auf deinen Geräten, in einem Format, das du lesen und exportieren kannst.
```

## App Store: listing

The live text, verbatim; the German blocks are new, for the locale to add once.

<!-- block id=appstore_name limit=30 lang=en title="Name" where="App information" -->
```
cat(a)log
```

<!-- block id=appstore_subtitle_en limit=30 lang=en title="Subtitle, English" where="App information" -->
```
Shared memory for animal care
```

<!-- block id=appstore_subtitle_de limit=30 lang=de title="Untertitel, Deutsch" where="App information" -->
```
Gedächtnis für die Tierpflege
```

<!-- block id=appstore_promo_en limit=170 lang=en title="Promotional text, English" where="Changeable without a build" -->
```
Which animal is this, where does it live now, what happened, who did what and when — one record, kept by everyone who cares. Cats first, any pet welcome.
```

<!-- block id=appstore_promo_de limit=170 lang=de title="Werbetext, Deutsch" where="Changeable without a build" -->
```
Welches Tier ist das, wo lebt es jetzt, was ist passiert, wer hat wann was gemacht — eine Aufzeichnung für alle, die sich kümmern. Katzen zuerst, jedes Tier willkommen.
```

<!-- block id=appstore_keywords_en limit=100 lang=en title="Keywords, English" where="Comma separated, no spaces" -->
```
cat,pet,foster,rescue,stray,colony,lost cat,missing,adoption,shelter,vet,microchip,weight,offline
```

<!-- block id=appstore_keywords_de limit=100 lang=de title="Schlüsselwörter, Deutsch" where="Comma separated, no spaces" -->
```
Katze,Haustier,Pflegestelle,Tierschutz,Streuner,Kolonie,vermisst,Adoption,Tierheim,Tierarzt,Chip
```

<!-- block id=appstore_desc_en limit=4000 lang=en title="Description, English" where="Plain text" -->
```
cat(a)log is the shared memory of a group of people who care for cats — or for any pets. It answers, at any time and for every animal: who is this, where does it live right now, what has happened to it, and who did what, when.

It is built for how animal care actually works. Cats move: from the shelter to a foster home, from the foster home to an adopter, out of a garden and onto the street, back again. Several people keep the record: you, the person who covers your weekends, the neighbour who feeds the colony. Nobody has a server, and nothing must get lost.

THE RECORD
• Every animal has a place. Cats live in clowders — your home, a foster home, an adopter's flat, the barn behind the station. Moving one is a dated event, so the record knows where Miezi was in May and who has her now. An animal without a place is a stray, and the app treats it as one.
• Every fact has a date and a name. Neutered, vaccinated, weighed, moved, renamed: the app stores when it happened and who wrote it down, not just the current value. A cat's page reads like a diary. Nothing is ever overwritten; a mistake is corrected with a new entry, and the correction is visible too.
• Weight and every other number get a graph. Weight is built in, in your units — kilograms or pounds, as your region says — and any number you log, a temperature or a dose, is drawn over time: week, month, year, the change since last time, vet visits marked along the way.
• Several people, one record, no server. Each helper carries the whole catalog on their own device. Phones sync directly and encrypted over Wi-Fi, through a folder you already share (Nextcloud, Syncthing, a USB stick), or as a file through any messenger. If two people changed the same thing at once, both versions are shown and you decide.
• One cat is one cat. Chip numbers and registry numbers (TASSO and others, opened with one tap) identify an animal. Two entries that are the same cat are merged, and both histories survive. A stray seen inside the search area of a missing cat is offered as a possible match.

WHAT THAT MEANS DAY TO DAY
• Fostering a litter: which of the ten identical kittens is already neutered, which one went to the family in the next town, and when. One vet appointment for the whole litter — tick the cats that come along, and afterwards note who was treated.
• Feeding a colony: a new face at the feeding spot gets a photo and a position with one tap; when it turns up two streets away, the map draws its trail. Over months, the record shows who belongs to the colony and who was passing through.
• A cat is missing: photograph the poster you hang up, or one somebody else hung up. The app reads the poster, marks the spot, and draws the 500 m area where the cat probably roams. The next sighting inside that area lands on the right cat.
• Your own pets: switch a catalog to pets and it speaks of pets and households — dog, rabbit, horse, whatever lives with you, each with its own breeds. Chip number, vaccinations, vet visits, medication, weight — and appointments in an agenda your phone's calendar can mirror.

ALSO
• Your own fields — "flea treatment", "favourite food", a body temperature in °C or °F — behave like the built-in ones, history and graph included.
• Photos: crop one kitten out of a group picture, or circle it when they are too tangled to crop.
• A printable page per animal with photo and chip code, for the vet or the adopter.
• Runs offline.
• 38 languages, right-to-left included.
• Free, open source (Apache-2.0 / MIT), no ads, no account, no tracking. Your data stays on your devices, in a format you can read and export.
```

<!-- block id=appstore_desc_de limit=4000 lang=de title="Beschreibung, Deutsch" where="Plain text" -->
```
cat(a)log ist das gemeinsame Gedächtnis einer Gruppe von Menschen, die sich um Katzen kümmern — oder um andere Haustiere. Es beantwortet jederzeit und für jedes Tier: Wer ist das, wo lebt es gerade, was ist mit ihm passiert, und wer hat wann was gemacht.

Es ist für die Wirklichkeit der Tierhilfe gebaut. Katzen ziehen um: aus dem Tierheim in die Pflegestelle, von der Pflegestelle zu den Adoptanten, aus dem Garten auf die Straße und wieder zurück. Mehrere Leute führen die Aufzeichnungen: du, wer dich am Wochenende vertritt, die Nachbarin, die die Kolonie füttert. Niemand hat einen Server, und nichts darf verloren gehen.

DIE AUFZEICHNUNG
• Jedes Tier hat einen Ort. Katzen leben in Kolonien — dein Zuhause, eine Pflegestelle, die Wohnung der Adoptanten. Ein Umzug ist ein datiertes Ereignis, darum weiß die Aufzeichnung, wo Miezi im Mai war und wer sie jetzt hat. Ein Tier ohne Ort ist ein Streuner, und die App behandelt es so.
• Jede Tatsache hat Datum und Namen. Kastriert, geimpft, gewogen, umgezogen, umbenannt: die App speichert, wann es passiert ist und wer es eingetragen hat, nicht nur den aktuellen Wert. Die Seite einer Katze liest sich wie ein Tagebuch. Nichts wird je überschrieben; ein Fehler wird mit einem neuen Eintrag korrigiert, und auch die Korrektur bleibt sichtbar.
• Gewicht und jede andere Zahl bekommen ein Diagramm. Gewicht ist eingebaut, in deinen Einheiten — Kilogramm oder Pfund — und jede Zahl, die du festhältst, wird über die Zeit gezeichnet: Woche, Monat, Jahr, Änderung seit dem letzten Mal.
• Mehrere Leute, eine Aufzeichnung, kein Server. Jede Helferin trägt den ganzen Katalog auf dem eigenen Gerät. Handys gleichen sich direkt und verschlüsselt über WLAN ab, über einen Ordner, den ihr ohnehin teilt (Nextcloud, Syncthing, USB-Stick), oder als Datei über jeden Messenger. Haben zwei Leute gleichzeitig dasselbe geändert, zeigt die App beide Versionen, und ihr entscheidet.
• Eine Katze ist eine Katze. Chipnummern und Registernummern (TASSO und andere, mit einem Tipp geöffnet) identifizieren ein Tier. Zwei Einträge, die dieselbe Katze sind, werden zusammengeführt, und beide Geschichten bleiben erhalten.

WAS DAS IM ALLTAG HEISST
• Einen Wurf in Pflege: welches der zehn gleich aussehenden Kitten ist schon kastriert, welches ist zur Familie im Nachbarort gezogen, und wann. Ein Tierarzttermin für den ganzen Wurf — die Katzen anhaken, die mitkommen, und hinterher festhalten, wer behandelt wurde.
• Eine Kolonie füttern: ein neues Gesicht am Futterplatz bekommt mit einem Tipp Foto und Position; taucht es zwei Straßen weiter wieder auf, zeichnet die Karte seinen Weg. Über Monate zeigt die Aufzeichnung, wer zur Kolonie gehört und wer nur durchkam.
• Eine Katze wird vermisst: fotografiere den Aushang, den du aufhängst, oder einen, den jemand anders aufgehängt hat. Die App liest den Aushang, merkt sich den Ort und zeichnet das 500-m-Gebiet, in dem die Katze wahrscheinlich unterwegs ist. Die nächste Sichtung in diesem Gebiet landet bei der richtigen Katze.
• Die eigenen Tiere: stelle einen Katalog auf Tiere um, und er spricht von Tieren und Haushalten — Hund, Kaninchen, Pferd, was bei dir lebt. Chipnummer, Impfungen, Tierarztbesuche, Medikamente — und Termine in einer Agenda, die der Kalender des Handys spiegeln kann.

AUSSERDEM
• Eigene Felder — „Flohbehandlung“, „Lieblingsfutter“, eine Temperatur — verhalten sich wie die eingebauten, Geschichte und Verlauf inklusive.
• Fotos: ein Kitten aus dem Gruppenbild ausschneiden oder einkreisen, wenn sie zu verknäult sind.
• Eine druckbare Seite pro Tier mit Foto und Chipcode, für den Tierarzt oder die Adoptanten.
• Funktioniert offline.
• 38 Sprachen, auch von rechts nach links.
• Kostenlos, quelloffen (Apache-2.0 / MIT), ohne Werbung, ohne Konto, ohne Tracking. Deine Daten bleiben auf deinen Geräten, in einem Format, das du lesen und exportieren kannst.
```

## Edits

One per changed listing line; the block above stays live until an edit is accepted.

<!-- edit block=play_full_en status=rejected -->
Changelog 2.0.2 Added (the mourning band) and 2.0.7 Changed (the age reached on the card): a cat that died is treated with care, and the listing says nothing about it. One line under ALSO, after the photos.
```
• Photos: crop one kitten out of a group picture, or circle it when they are too tangled to crop.
```
```
• Photos: crop one kitten out of a group picture, or circle it when they are too tangled to crop.
• A cat that died keeps its place: its picture wears a mourning band, and its card gives the age it reached.
```

<!-- edit block=play_full_de status=rejected -->
Same edit, German.
```
• Fotos: ein Kitten aus dem Gruppenbild ausschneiden oder einkreisen, wenn sie zu verknäult sind.
```
```
• Fotos: ein Kitten aus dem Gruppenbild ausschneiden oder einkreisen, wenn sie zu verknäult sind.
• Eine verstorbene Katze behält ihren Platz: ihr Bild trägt einen Trauerflor, und ihre Karte nennt das erreichte Alter.
```

<!-- edit block=appstore_desc_en status=rejected -->
Same edit, App Store description.
```
• Photos: crop one kitten out of a group picture, or circle it when they are too tangled to crop.
```
```
• Photos: crop one kitten out of a group picture, or circle it when they are too tangled to crop.
• A cat that died keeps its place: its picture wears a mourning band, and its card gives the age it reached.
```

<!-- edit block=appstore_desc_de status=rejected -->
Same edit, App Store description, German.
```
• Fotos: ein Kitten aus dem Gruppenbild ausschneiden oder einkreisen, wenn sie zu verknäult sind.
```
```
• Fotos: ein Kitten aus dem Gruppenbild ausschneiden oder einkreisen, wenn sie zu verknäult sind.
• Eine verstorbene Katze behält ihren Platz: ihr Bild trägt einen Trauerflor, und ihre Karte nennt das erreichte Alter.
```

## Screenshots: Play

Regenerated from the branch by `flutter test test/screenshots --run-skipped --concurrency=1`. Phone 1080 × 1920, 10-inch tablet 1440 × 2560, 2 to 8 each; the first three carry the listing. Feature graphic: `assets/icon/store/play-feature-1024x500.png`.

| # | Files | Size | What is on it |
|---|---|---|---|
| 1 | `play/play-01-home.png · tablet/tablet10-01-home.png` | 1080 × 1920 · 1440 × 2560 | Home: clowders with cover pictures, favourite first |
| 2 | `play/play-02-clowder.png · tablet/tablet10-02-clowder.png` | 1080 × 1920 · 1440 × 2560 | A clowder with its cats and what is planned |
| 3 | `play/play-03-cat.png · tablet/tablet10-03-cat.png` | 1080 × 1920 · 1440 × 2560 | A cat: photo, what is coming up, the fields |
| 4 | `play/play-04-card.png · tablet/tablet10-04-card.png` | 1080 × 1920 · 1440 × 2560 | The printable card, with the age beside the birth date |
| 5 | `play/play-05-timeline.png · tablet/tablet10-05-timeline.png` | 1080 × 1920 · 1440 × 2560 | The timeline of one cat |
| 6 | `play/play-06-map.png · tablet/tablet10-06-map.png` | 1080 × 1920 · 1440 × 2560 | The map with homes, strays and a trail |
| 7 | `play/play-07-graph.png · tablet/tablet10-07-graph.png` | 1080 × 1920 · 1440 × 2560 | Weight graph, smoothed, with trend |
| 8 | `play/play-08-agenda.png · tablet/tablet10-08-agenda.png` | 1080 × 1920 · 1440 × 2560 | The agenda: today and coming up |
| 9 | `play/play-09-poster.png · tablet/tablet10-09-poster.png` | 1080 × 1920 · 1440 × 2560 | The missing poster |
| 10 | `play/play-10-report.png · tablet/tablet10-10-report.png` | 1080 × 1920 · 1440 × 2560 | The report for the vet |
| 11 | `play/play-11-sync.png · tablet/tablet10-11-sync.png` | 1080 × 1920 · 1440 × 2560 | A shared folder: the note that changes wait |
| 12 | `play/play-12-strays.png · tablet/tablet10-12-strays.png` | 1080 × 1920 · 1440 × 2560 | The strays |

## Screenshots: App Store

Regenerated with the Play set. iPhone 6.9″ 1320 × 2868, iPad 13″ 2064 × 2752, up to 10 each; the first three show in search.

| # | Files | Size | What is on it |
|---|---|---|---|
| 1 | `appstore/iphone-01-home.png · appstore/ipad-01-home.png` | 1320 × 2868 · 2064 × 2752 | Home: clowders with cover pictures, favourite first |
| 2 | `appstore/iphone-02-clowder.png · appstore/ipad-02-clowder.png` | 1320 × 2868 · 2064 × 2752 | A clowder with its cats and what is planned |
| 3 | `appstore/iphone-03-cat.png · appstore/ipad-03-cat.png` | 1320 × 2868 · 2064 × 2752 | A cat: photo, what is coming up, the fields |
| 4 | `appstore/iphone-04-card.png · appstore/ipad-04-card.png` | 1320 × 2868 · 2064 × 2752 | The printable card, with the age beside the birth date |
| 5 | `appstore/iphone-05-timeline.png · appstore/ipad-05-timeline.png` | 1320 × 2868 · 2064 × 2752 | The timeline of one cat |
| 6 | `appstore/iphone-06-map.png · appstore/ipad-06-map.png` | 1320 × 2868 · 2064 × 2752 | The map with homes, strays and a trail |
| 7 | `appstore/iphone-07-graph.png · appstore/ipad-07-graph.png` | 1320 × 2868 · 2064 × 2752 | Weight graph, smoothed, with trend |
| 8 | `appstore/iphone-08-agenda.png · appstore/ipad-08-agenda.png` | 1320 × 2868 · 2064 × 2752 | The agenda: today and coming up |
| 9 | `appstore/iphone-09-poster.png · appstore/ipad-09-poster.png` | 1320 × 2868 · 2064 × 2752 | The missing poster |
| 10 | `appstore/iphone-10-report.png · appstore/ipad-10-report.png` | 1320 × 2868 · 2064 × 2752 | The report for the vet |
| 11 | `appstore/iphone-11-sync.png · appstore/ipad-11-sync.png` | 1320 × 2868 · 2064 × 2752 | A shared folder: the note that changes wait |
| 12 | `appstore/iphone-12-strays.png · appstore/ipad-12-strays.png` | 1320 × 2868 · 2064 × 2752 | The strays |

## Play Console, in order

1. Store listing: the icon from `assets/icon/store/play-icon-512.png` and the feature graphic; the new phone and tablet screenshots; the full description only if the edit was accepted.
2. Release, Production, Create new release. Add from library: the 2.0.7 bundle (versionCode 39) the tag pipeline already put on Internal testing.
3. Release notes: en-US and de-DE from above, inside the language tags the console shows.
4. Next, then review. Start rollout to Production ships; Save alone parks a draft.
5. Rollout 100 %.

## App Store Connect, in order

1. My Apps, cat(a)log, the 2.0.7 version under iOS App (create it with + if the page still shows 1.4.0).
2. Previews and Screenshots: replace with the new iPhone and iPad sets.
3. What's New from above. Description only if the edit was accepted; Promotional Text, Keywords, Support URL and Privacy Policy URL stay.
4. German: add the locale under App Information, Localizations, then paste the German blocks.
5. Build: pick 2.0.7 (39) from TestFlight.
6. App Review notes: "Local-network permission is used for direct device-to-device sync; there is no server."
7. Save, Add for Review, Submit.
