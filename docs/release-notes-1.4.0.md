# Release notes 1.4.0

A list of what was added, changed and fixed — not a tutorial. Play allows
500 characters per language, App Store and TestFlight 4000. The GitHub
release carries the changelog section as it is.

## Google Play — both languages, as the console wants them pasted

```
<en-US>
Added
• Duplicate a chore onto another cat or home from its editor

Changed
• Flier text page: one card per line, a swipe puts a line aside, Undo brings it back; links show in full
• Shared folder sync several times faster

Fixed
• No crash report after a battery saver closed the app in the background (Android 11 and newer)
</en-US>
<de-DE>
Neu
• Aufgabe aus ihrem Editor auf eine andere Katze oder Kolonie duplizieren

Geändert
• Aushang-Textseite: eine Karte je Zeile, Wischen legt eine Zeile beiseite, Rückgängig holt sie zurück; Links in voller Länge
• Ordner-Abgleich um ein Vielfaches schneller

Behoben
• Kein Absturzbericht mehr, wenn der Energiesparmodus die App im Hintergrund beendet hat (ab Android 11)
</de-DE>
```

## App Store / TestFlight — English

```
cat(a)log 1.4.0

Added
• Duplicate in a chore's editor: pick the cat or home the copy is for and a new editor opens with the same title, schedule, time and reminder, over the original — every kitten gets its feeding with one pick and one Save each

Changed
• The flier text page shows one card per line, the text as wide as the page, the target under it; the X or a swipe puts a line aside, Undo brings it back
• Links on the text and registry pages and in the remember-service dialog show in full
• Shared folder sync is several times faster: a round with nothing new takes a sixth of the time, a first import a little over half

Fixed
• A battery saver closing the app in the background no longer brings the crash report on the next start. On Android 11 and newer the app asks the system why it was ended and offers the report only after a crash, a freeze, or a memory kill while it was on screen; the report names the system's reason

What to test
Open a chore, tap Duplicate, pick another cat, Save, and check both cats carry the chore. Capture a flier, swipe a text line aside and undo it. Sync a shared folder twice and watch the second round finish at once. Leave the app in the background under a battery saver and start it again: no crash report.
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
