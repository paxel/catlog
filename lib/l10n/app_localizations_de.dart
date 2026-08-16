// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Willkommen bei cat(a)log';

  @override
  String get welcomeBody =>
      'Wähle einen Namen für dich. Jede Änderung wird unter diesem Namen gespeichert, damit andere sehen, wer was gemacht hat.';

  @override
  String get yourName => 'Dein Name';

  @override
  String get start => 'Los geht\'s';

  @override
  String get clowders => 'Clowder';

  @override
  String get noClowdersYet => 'Noch keine Clowder.\nLege unten den ersten an.';

  @override
  String get strays => 'Streuner';

  @override
  String get searchCats => 'Katzen suchen';

  @override
  String get map => 'Karte';

  @override
  String get sync => 'Sync';

  @override
  String get fields => 'Felder';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get aboutAndFeedback => 'Über & Feedback';

  @override
  String get newClowder => 'Neuer Clowder';

  @override
  String get name => 'Name';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get create => 'Anlegen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get merge => 'Zusammenführen';

  @override
  String get resolve => 'Klären';

  @override
  String get open => 'Öffnen';

  @override
  String csvSavedTo(String path) {
    return 'CSV gespeichert unter $path';
  }

  @override
  String get renameClowder => 'Clowder umbenennen';

  @override
  String get rename => 'Umbenennen';

  @override
  String get timeline => 'Verlauf';

  @override
  String get mergeInto => 'Zusammenführen mit…';

  @override
  String get deleteClowder => 'Clowder löschen';

  @override
  String get cats => 'Katzen';

  @override
  String get addCat => 'Katze hinzufügen';

  @override
  String get newCat => 'Neue Katze';

  @override
  String deleteQuestion(String name) {
    return '$name löschen?';
  }

  @override
  String get deleteClowderEmptyBody =>
      'Der Clowder verschwindet aus der Liste.';

  @override
  String deleteClowderBody(int count) {
    return 'Seine $count Katze(n) werden nicht gelöscht — sie werden zu Streunern. Verschiebe sie vorher in einen anderen Clowder, falls das nicht gewollt ist.';
  }

  @override
  String get card => 'Karte';

  @override
  String get shareAsImage => 'Als Bild teilen';

  @override
  String get shareAsPdf => 'Als PDF teilen';

  @override
  String get print => 'Drucken';

  @override
  String cardTitle(String name) {
    return 'Karteikarte — $name';
  }

  @override
  String get renameCat => 'Katze umbenennen';

  @override
  String get seenHereNow => 'Hier gesehen';

  @override
  String get deleteCat => 'Katze löschen';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Streuner — kein Clowder';

  @override
  String get stray => 'Streuner';

  @override
  String get photos => 'Fotos';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get setAsProfileImage => 'Als Profilbild festlegen';

  @override
  String get thisIsProfileImage => 'Das ist das Profilbild';

  @override
  String get deletePhoto => 'Foto löschen';

  @override
  String get deletePhotoTitle => 'Foto löschen?';

  @override
  String get deletePhotoBody =>
      'Die Fotodaten werden endgültig entfernt — das lässt sich nicht rückgängig machen.';

  @override
  String get deleteCatBody =>
      'Die Katze verschwindet aus allen Listen. Ihre Fotos werden endgültig entfernt.';

  @override
  String get sightingRecorded => 'Sichtung an deiner Position gespeichert.';

  @override
  String get noLocationAvailable =>
      'Kein Standort verfügbar — halte stattdessen die Karte gedrückt.';

  @override
  String get moveTo => 'Verschieben nach';

  @override
  String get noClowderStrayOption => 'Kein Clowder — Streuner / weggelaufen';

  @override
  String timelineOf(String name) {
    return 'Verlauf — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Diese Änderung zurücknehmen';

  @override
  String get revertSubtitle =>
      'Stellt den vorherigen Wert als neuen Eintrag wieder her — der Verlauf behält beides.';

  @override
  String fieldCleared(String field) {
    return '$field geleert';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field zurück auf \"$value\"';
  }

  @override
  String get leftStray => 'Weggelaufen — Streuner';

  @override
  String movedTo(String name) {
    return 'Umgezogen nach $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat ist eingezogen';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat kam aus $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat zog nach $place';
  }

  @override
  String get duplicateMergedIn => 'Duplikat wurde zusammengeführt';

  @override
  String get asOfToday => 'Stand: heute';

  @override
  String asOfDate(String date) {
    return 'Stand: $date';
  }

  @override
  String get value => 'Wert';

  @override
  String get latitudeLongitude => 'Breitengrad, Längengrad';

  @override
  String get newField => 'Neues Feld';

  @override
  String get fieldType => 'Typ';

  @override
  String get usedOn => 'Verwendet für';

  @override
  String get forCats => 'Katzen';

  @override
  String get forClowders => 'Clowder';

  @override
  String get forBoth => 'beide';

  @override
  String get optionsOnePerLine => 'Optionen (eine pro Zeile)';

  @override
  String get renameField => 'Feld umbenennen';

  @override
  String get noStraysRightNow => 'Gerade keine Streuner.';

  @override
  String get strayCam => 'Streuner-Cam';

  @override
  String get addStray => 'Streuner hinzufügen';

  @override
  String get newStray => 'Neuer Streuner';

  @override
  String get searchByNameHint => 'Katzen nach Name suchen…';

  @override
  String get host => 'Anbieten';

  @override
  String get hostExplainer =>
      'Hier starten, dann Adresse und PIN auf dem anderen Gerät eingeben.';

  @override
  String get startHosting => 'Sync anbieten';

  @override
  String get stopHosting => 'Anbieten beenden';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count Sitzung(en) bisher';
  }

  @override
  String get join => 'Beitreten';

  @override
  String get addressFromHost => 'Adresse (vom anbietenden Gerät)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Jetzt synchronisieren';

  @override
  String get addressFormatHint =>
      'Adresse muss so aussehen: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synchronisiert: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sync fehlgeschlagen: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Letzter Sync mit $peer: $time';
  }

  @override
  String get sharedFolder => 'Gemeinsamer Ordner';

  @override
  String get sharedFolderExplainer =>
      'Sync über einen Ordner, den ein Cloud-Laufwerk oder USB-Stick zwischen den Geräten trägt — für alle, die nicht im selben Netz sind.';

  @override
  String get noFolderChosenYet => 'Noch kein Ordner gewählt';

  @override
  String get choose => 'Auswählen…';

  @override
  String get syncFolderNow => 'Ordner jetzt synchronisieren';

  @override
  String folderSynced(String result) {
    return 'Ordner synchronisiert: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Ordner-Sync fehlgeschlagen: $error';
  }

  @override
  String get recordSightingHere => 'Hier eine Sichtung eintragen:';

  @override
  String get orPlaceClowderHere => 'Oder einen Clowder hierher setzen:';

  @override
  String trailOf(String name, int count) {
    return 'Route: $name ($count Sichtungen)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'An zwei Orten gleichzeitig geändert. Wähle, was stimmt:';

  @override
  String mergeThisInto(String kind) {
    return 'Diese(n) $kind zusammenführen mit…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Kein anderes Ziel ($kind) zum Zusammenführen.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Mit $name zusammenführen?';
  }

  @override
  String mergeBody(String name) {
    return 'Aus zwei Einträgen wird einer. $name behält die aktuellen Werte; der Verlauf des anderen wandert mit hinein. Das lässt sich nicht rückgängig machen.';
  }

  @override
  String get kindCat => 'Katze';

  @override
  String get kindClowder => 'Clowder';

  @override
  String get kindField => 'Feld';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String get about => 'Über';

  @override
  String get aboutTagline =>
      'Ein lokaler Katalog für Pflegekatzen. Deine Daten bleiben auf deinen Geräten — kein Server, kein Konto.';

  @override
  String versionLabel(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get sourceCode => 'Quellcode';

  @override
  String get reportProblemOrIdea => 'Problem oder Idee melden';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Dem Entwickler schreiben';

  @override
  String get buyCoffee => 'Dem Entwickler einen Kaffee spendieren';

  @override
  String get coffeeSubtitle => 'Völlig freiwillig — die App ist kostenlos';

  @override
  String get openSourceLicenses => 'Open-Source-Lizenzen';

  @override
  String get machineTranslated =>
      'Übersetzungen sind maschinell erstellt — Korrekturen sind auf GitHub willkommen.';

  @override
  String get unnamed => '(ohne Namen)';

  @override
  String get labelName => 'Name';

  @override
  String get labelProfileImage => 'Profilbild';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Geschlecht';

  @override
  String get starterColor => 'Farbe';

  @override
  String get starterNeutered => 'Kastriert';

  @override
  String get starterPregnant => 'Trächtig';

  @override
  String get starterBirthdate => 'Geburtsdatum';

  @override
  String get starterDeceased => 'Verstorben';

  @override
  String get starterAddress => 'Adresse';

  @override
  String get starterResponsible => 'Verantwortliche Person';

  @override
  String get starterPosition => 'Position';

  @override
  String get valueYes => 'ja';

  @override
  String get valueNo => 'nein';

  @override
  String get valueFemale => 'weiblich';

  @override
  String get valueMale => 'männlich';

  @override
  String get valueUnknown => 'unbekannt';

  @override
  String get cropTitle => 'Foto zuschneiden';

  @override
  String get markTitle => 'Katze markieren';

  @override
  String get useFullPhoto => 'Ganzes Foto verwenden';

  @override
  String get dragToSelect => 'Ziehe ein Rechteck um die Katze';

  @override
  String get dragOverTheCat => 'Ziehe eine Ellipse über die Katze';

  @override
  String get cropPhoto => 'Zuschneiden…';

  @override
  String get markPhoto => 'Markieren…';

  @override
  String get scanCode => 'Code scannen';

  @override
  String get orTypeCode => 'Oder Code eintippen';

  @override
  String get copyCode => 'Code kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get invalidCode => 'Dieser Code ist ungültig';

  @override
  String get hotspotHint =>
      'Kein gemeinsames WLAN? Hotspot auf einem Handy einschalten, das andere damit verbinden, dann hier anbieten.';

  @override
  String get byMessenger => 'Per Messenger';

  @override
  String get byMessengerExplainer =>
      'Schick deinen ganzen Katalog als eine Datei über WhatsApp, Signal oder Mail — die Gegenseite importiert sie.';

  @override
  String get shareBundle => 'Sync-Paket teilen…';

  @override
  String get importBundle => 'Sync-Paket importieren…';

  @override
  String bundleImported(String result) {
    return 'Paket importiert: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import fehlgeschlagen: $error';
  }

  @override
  String get pickOnMap => 'Auf Karte wählen';

  @override
  String get useMyLocation => 'Meinen Standort verwenden';

  @override
  String get language => 'Sprache';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Wenn es auf iPhone/iPad weiter scheitert: Einstellungen → Datenschutz & Sicherheit → Lokales Netzwerk → cat(a)log erlauben, dann erneut versuchen.';

  @override
  String get markPrivate => 'Als privat markieren';

  @override
  String get unmarkPrivate => 'Privat-Markierung entfernen';

  @override
  String get includePrivate => 'Private Daten einbeziehen';

  @override
  String get includePrivateExplainer =>
      'Private Katzen, Clowder und Felder werden mitgeteilt — nur einschalten, wenn du deine eigenen Geräte synchronisierst.';

  @override
  String get hideLabel => 'Auf diesem Gerät ausblenden';

  @override
  String get unhideLabel => 'Wieder anzeigen';

  @override
  String get showHiddenLabel => 'Ausgeblendetes anzeigen';

  @override
  String get stopShowingHidden => 'Ausgeblendetes wieder verbergen';

  @override
  String get starterSpecies => 'Tierart';

  @override
  String get starterStatus => 'Status';

  @override
  String get statusFoster => 'Pflegestelle';

  @override
  String get statusForeverHome => 'Für-immer-Zuhause';

  @override
  String get statusClinic => 'Klinik';

  @override
  String get statusShelter => 'Tierheim';

  @override
  String get statusBarn => 'Scheune';

  @override
  String get valueCat => 'Katze';

  @override
  String get otherOption => 'Anderes…';

  @override
  String get celebrationsToggle => 'Adoptionen feiern';

  @override
  String get celebrationsSubtitle =>
      'Konfetti und Jubel, wenn eine Katze in ihr Für-immer-Zuhause zieht';
}
