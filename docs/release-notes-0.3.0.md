# Release notes 0.3.0

A list of what was added, changed and fixed — not a tutorial. Play allows
500 characters per language, App Store and TestFlight 4000.

## Google Play — both languages, as the console wants them pasted

```
<en-US>
Added
• Multiple catalogs on one device
• Moving cats, clowders and strays between catalogs
• Undo for an import
• A list of earlier states per catalog to go back to
• One automatic backup file per catalog

Fixed
• Long names cut off on phones
• Tablet layout of the clowder overview
• Clowder table squeezed into the list column on tablets
• Tutorial tips pointing at nothing on tablets
</en-US>
<de-DE>
Neu
• Mehrere Kataloge auf einem Gerät
• Katzen, Kolonien und Streuner zwischen Katalogen verschieben
• Import rückgängig machen
• Liste früherer Stände pro Katalog
• Eine eigene Sicherungsdatei je Katalog

Behoben
• Lange Namen am Telefon abgeschnitten
• Tablet-Layout der Kolonienübersicht
• Kolonien-Tabelle in die Listenspalte gequetscht
• Tipps, die auf Tablets ins Leere zeigten
</de-DE>
```

## App Store / TestFlight — English

```
cat(a)log 0.3.0

Added
• Support for multiple catalogs on one device
• Switching, creating and renaming catalogs from the home screen's title
• Deleting a catalog, with a full export written first
• Moving a cat, a clowder with its cats, or several strays to another catalog
• Undo for an import, from the summary that follows it
• A list of earlier states per catalog, with a way back to any of them
• Marking an earlier state yourself, with a name
• One automatic backup file per catalog
• Storage used, per catalog

Changed
• The clowder table uses the full width on tablets and desktop
• Tutorial tips sit next to what they highlight; the arrow is gone

Fixed
• Long cat and clowder names cut off on phones
• Tablet layout of the clowder overview: Strays, Search, Find duplicates and Fields covered the list
• Entries written after deleting an author's data not reaching synced devices

What to test
A second catalog, moving a clowder into it, switching between the two. Import a file and undo it, then sync and check it stays undone. The Go back list.
```

## App Store / TestFlight — Deutsch

```
cat(a)log 0.3.0

Neu
• Unterstützung für mehrere Kataloge auf einem Gerät
• Kataloge wechseln, anlegen und umbenennen über den Titel des Startbildschirms
• Kataloge löschen, mit vorher geschriebenem vollständigem Export
• Katze, Kolonie samt Katzen oder mehrere Streuner in einen anderen Katalog verschieben
• Import rückgängig machen, aus der Übersicht danach
• Liste früherer Stände pro Katalog, mit Weg zurück zu jedem davon
• Einen Stand selbst markieren, mit Namen
• Eine eigene automatische Sicherungsdatei je Katalog
• Belegter Speicher je Katalog

Geändert
• Die Kolonien-Tabelle nutzt auf Tablet und Desktop die volle Breite
• Tipps stehen neben dem, was sie hervorheben; der Pfeil ist weg

Behoben
• Lange Katzen- und Koloniennamen am Telefon abgeschnitten
• Tablet-Layout der Kolonienübersicht: Streuner, Suche, Duplikate und Felder verdeckten die Liste
• Einträge nach dem Löschen der Daten einer Person erreichten synchronisierte Geräte nicht

Was testen
Ein zweiter Katalog, eine Kolonie hineinverschieben, zwischen beiden wechseln. Eine Datei importieren und rückgängig machen, dann synchronisieren und prüfen, ob es rückgängig bleibt. Die Liste „Zurück".
```
