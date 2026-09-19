# Release notes 1.4.0

A list of what was added, changed and fixed — not a tutorial. Play allows
500 characters per language, App Store and TestFlight 4000. The GitHub
release carries the changelog section as it is. The store texts cover
1.3.4 too: 1.3.3 was the last version in both stores. The same texts sit
on the Play Kit and App Store Kit pages on claude.ai, with live counts.

## Google Play — both languages, as the console wants them pasted

```
<en-US>
Added
• Duplicate a chore onto another cat or home from its editor

Changed
• Flier text page: one card per line, swipe a line aside, Undo brings it back
• Shared folder sync several times faster, with a progress bar; the waiting-changes line can be swiped away

Fixed
• Photos lose the camera's metadata, so pictures with a location reach the other phone through the folder
• No crash report after a battery saver closed the app in the background (Android 11+)
</en-US>
<de-DE>
Neu
• Aufgabe aus ihrem Editor auf eine andere Katze oder Kolonie duplizieren

Geändert
• Aushang-Textseite: eine Karte je Zeile, Zeile wegwischen, Rückgängig holt sie zurück
• Ordner-Abgleich um ein Vielfaches schneller, mit Fortschrittsbalken; die Zeile mit wartenden Änderungen lässt sich wegwischen

Behoben
• Fotos verlieren die Kamera-Metadaten, damit Bilder mit Ort über den Ordner ankommen
• Kein Absturzbericht, wenn der Energiesparmodus die App beendet hat (ab Android 11)
</de-DE>
```

## App Store / TestFlight — English (What's New, since 1.3.3)

```
Duplicate in a chore's editor: pick the cat or home the copy is for and a new editor opens with the same title, schedule, time and reminder, over the original — every kitten gets its feeding with one pick and one Save each.

The flier text page shows one card per line, the text as wide as the page, the target under it; the X or a swipe puts a line aside, Undo brings it back. Links on the text and registry pages and in the remember-service dialog show in full.

Shared folder sync is several times faster: a round with nothing new takes a sixth of the time, a first import a little over half. The Sync button shows a moving bar until the round is done, and the line about waiting changes can be swiped away; it comes back when more arrives.

Photos no longer carry the camera's metadata, so where a picture was taken does not travel to the shared folder, and pictures with a location now reach the other phone through it. Photo files that reach the folder after the entries are fetched by the next round of the folder watch, and the sync result says how many photos are not in the folder yet.

A battery saver closing the app in the background no longer brings the crash report on the next start; the report comes only after a real crash, a freeze, or a memory kill while the app was on screen.
```

## App Store / TestFlight — Deutsch

```
cat(a)log 1.4.0

Neu
• Duplizieren im Editor einer Aufgabe: Katze oder Kolonie für die Kopie wählen, und ein neuer Editor öffnet sich mit demselben Titel, Zeitplan, Uhrzeit und Erinnerung über dem Original — jedes Kätzchen bekommt seine Fütterung mit einer Wahl und einem Speichern

Geändert
• Die Aushang-Textseite zeigt eine Karte je Zeile, den Text so breit wie die Seite, das Ziel darunter; das X oder ein Wischen legt eine Zeile beiseite, Rückgängig holt sie zurück
• Links auf der Text- und der Registerseite und im Dialog „Dienst merken" erscheinen in voller Länge
• Der Abgleich über den gemeinsamen Ordner ist um ein Vielfaches schneller: eine Runde ohne Neues braucht ein Sechstel der Zeit, ein erster Import gut die Hälfte

Behoben
• Beendet der Energiesparmodus die App im Hintergrund, kommt beim nächsten Start kein Absturzbericht mehr. Ab Android 11 fragt die App das System, warum sie beendet wurde, und bietet den Bericht nur nach einem Absturz, einem Einfrieren oder einem Speicher-Abbruch auf dem Bildschirm an; der Bericht nennt den Grund des Systems

Was testen
Eine Aufgabe öffnen, Duplizieren antippen, eine andere Katze wählen, Speichern, und prüfen, ob beide Katzen die Aufgabe tragen. Einen Aushang erfassen, eine Textzeile wegwischen und zurückholen. Einen gemeinsamen Ordner zweimal abgleichen und sehen, dass die zweite Runde sofort fertig ist. Die App im Hintergrund vom Energiesparmodus beenden lassen und neu starten: kein Absturzbericht.
```
