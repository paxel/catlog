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
  String get clowders => 'Kolonien';

  @override
  String get noClowdersYet =>
      'Noch keine Kolonien. Eine Kolonie ist ein Ort, an dem Katzen leben — deine Pflegestelle, die Wohnung eines Adoptanten. Lege unten die erste an.';

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
  String get newClowder => 'Neue Kolonie';

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
  String get renameClowder => 'Kolonie umbenennen';

  @override
  String get rename => 'Umbenennen';

  @override
  String get timeline => 'Verlauf';

  @override
  String get mergeInto => 'Zusammenführen mit…';

  @override
  String get deleteClowder => 'Kolonie löschen';

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
      'Die Kolonie verschwindet aus der Liste.';

  @override
  String deleteClowderBody(int count) {
    return 'Ihre $count Katze(n) werden nicht gelöscht — sie werden zu Streunern. Verschiebe sie vorher in eine andere Kolonie, falls das nicht gewollt ist.';
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
  String get clowderLabel => 'Kolonie';

  @override
  String get strayNoClowder => 'Streuner — keine Kolonie';

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
      'Die Katze verschwindet aus allen Listen und ihre Fotos werden entfernt — hier und nach der nächsten Synchronisierung auch bei deinen Helfern.';

  @override
  String get sightingRecorded => 'Sichtung an deiner Position gespeichert.';

  @override
  String get noLocationAvailable =>
      'Kein Standort verfügbar — halte stattdessen die Karte gedrückt.';

  @override
  String get locationDeniedForever =>
      'Der Standortzugriff ist blockiert. Erlaube ihn in den Systemeinstellungen, um die Streuner-Cam zu nutzen.';

  @override
  String get locationServiceOff =>
      'Der Standort ist auf diesem Gerät ausgeschaltet. Schalte ihn in den Einstellungen ein und versuche es erneut.';

  @override
  String get locationDenied =>
      'cat(a)log darf deinen Standort nicht verwenden. Versuche es erneut und erlaube es, wenn du gefragt wirst.';

  @override
  String get locationNoFix =>
      'Deine Position konnte gerade nicht bestimmt werden. Versuche es im Freien erneut — GPS braucht freie Sicht zum Himmel.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Chip-Nummer';

  @override
  String get starterRemarks => 'Bemerkungen';

  @override
  String get displayFormat => 'Angezeigt als';

  @override
  String get displayPlain => 'Klartext';

  @override
  String get displayQr => 'QR-Code';

  @override
  String get displayBarcode => 'Barcode';

  @override
  String get editLabel => 'Bearbeiten';

  @override
  String get doneLabel => 'Fertig';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get notSaved => 'Nicht gespeichert';

  @override
  String get birthdateInFuture =>
      'Das Geburtsdatum kann nicht in der Zukunft liegen.';

  @override
  String get deceasedInFuture =>
      'Das Todesdatum kann nicht in der Zukunft liegen.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Das Todesdatum kann nicht vor dem Geburtsdatum ($date) liegen.';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Das Geburtsdatum kann nicht nach dem Todesdatum ($date) liegen.';
  }

  @override
  String get malePregnant =>
      'Diese Katze ist als männlich eingetragen — ein Kater kann nicht trächtig sein. Prüfe zuerst das Geschlecht.';

  @override
  String get moveTo => 'Verschieben nach';

  @override
  String get noClowderStrayOption => 'Keine Kolonie — Streuner / weggelaufen';

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
  String dateFormatError(String format) {
    return 'Falsches Format — bitte $format verwenden';
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
  String get forClowders => 'Kolonien';

  @override
  String get forBoth => 'beide';

  @override
  String get optionsOnePerLine => 'Optionen (eine pro Zeile)';

  @override
  String get ownValue => 'Eigener Wert';

  @override
  String get renameField => 'Feld umbenennen';

  @override
  String get editOptions => 'Optionen bearbeiten…';

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
  String get kindClowder => 'Kolonie';

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
  String get starterBreed => 'Rasse';

  @override
  String get valueMixed => 'Mischling';

  @override
  String get breedEuropeanShorthair => 'Europäisch Kurzhaar';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britisch Kurzhaar';

  @override
  String get breedNorwegianForestCat => 'Norwegische Waldkatze';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamkatze';

  @override
  String get breedPersian => 'Perserkatze';

  @override
  String get breedBengal => 'Bengalkatze';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get applyCrop => 'Zuschneiden';

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
  String lastBackupFailed(String error) {
    return 'Letztes automatisches Backup fehlgeschlagen: $error';
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
      'Private Katzen, Kolonien und Felder werden mitgeteilt — nur einschalten, wenn du deine eigenen Geräte synchronisierst.';

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

  @override
  String get onMapLabel => 'Auf der Karte';

  @override
  String get showOnMap => 'Auf Karte zeigen';

  @override
  String get searchPlaceHint => 'Ort oder Adresse suchen';

  @override
  String get noPlacesFound => 'Keine Orte gefunden';

  @override
  String get mapSearchHint => 'Katzen, Kolonien, Personen suchen';

  @override
  String get proposeAnotherName => 'Anderen Namen vorschlagen';

  @override
  String get moderationTitle => 'Autoren & Sperren';

  @override
  String get moderationSubtitle => 'Daten einer Person endgültig entfernen';

  @override
  String get authorsSection => 'Wer in diesen Katalog geschrieben hat';

  @override
  String get hardDeleteAction => 'Alles von dieser Person löschen';

  @override
  String hardDeleteWarning(Object name) {
    return 'Entfernt jeden Eintrag und jedes Foto von $name von diesem Gerät. Andere Geräte behalten ihre Kopie. Das kann nicht rückgängig gemacht werden.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Zum Bestätigen $name eintippen';
  }

  @override
  String get alsoBan => 'Auch sperren — nie wieder Daten annehmen';

  @override
  String get bansSection => 'Sperren';

  @override
  String get unbanAction => 'Sperre aufheben';

  @override
  String get deletedDone => 'Gelöscht.';

  @override
  String get syncSummaryTitle => 'Was angekommen ist';

  @override
  String get summaryAdopted => 'Adoptiert';

  @override
  String get summaryDeceased => 'Verstorben';

  @override
  String get summaryEscaped => 'Entlaufen';

  @override
  String get summaryNew => 'Neu';

  @override
  String get summaryConflicts => 'Zu klärende Konflikte';

  @override
  String summaryOther(Object n) {
    return '…und $n weitere Änderungen';
  }

  @override
  String get starterMother => 'Mutter';

  @override
  String get starterFather => 'Vater';

  @override
  String get familySection => 'Familie';

  @override
  String get littermatesLabel => 'Wurfgeschwister';

  @override
  String get siblingsLabel => 'Geschwister';

  @override
  String get kittensLabel => 'Kitten';

  @override
  String get toastSettingsTitle => 'Was gemeldet wird';

  @override
  String get toastSettingsSubtitle =>
      'Kleine Meldungen nach einer Synchronisierung';

  @override
  String get toastKindAdoptions => 'Adoptionen';

  @override
  String get toastKindBirths => 'Geburten';

  @override
  String get toastKindDeaths => 'Todesfälle';

  @override
  String get toastKindEscapes => 'Ausbrüche';

  @override
  String get toastKindMoves => 'Umzüge';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptiert von $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Neues Kitten: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat ist gestorben';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat ist entlaufen';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat ist umgezogen zu $home';
  }

  @override
  String get notACatlogFile => 'Das ist keine cat(a)log-Datei';

  @override
  String get nothingNewInBundle =>
      'Nichts Neues in der Datei — du hast schon alles';

  @override
  String get syncChooserInPerson => 'Persönlich';

  @override
  String get syncChooserInPersonSub =>
      'Ihr seid im selben Raum — Code scannen, in Sekunden fertig';

  @override
  String get syncChooserRemote => 'Entfernt';

  @override
  String get syncChooserRemoteSub =>
      'Über einen geteilten Ordner wie Dropbox oder einen USB-Stick';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Alles als eine Datei über einen beliebigen Messenger senden';

  @override
  String get connectToWifiFirst =>
      'Verbinde dich zuerst mit einem WLAN — dann finden sich die Geräte';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) möchte synchronisieren';
  }

  @override
  String get trustBothWaysNote =>
      'Eure Kataloge werden in beide Richtungen ausgetauscht.';

  @override
  String get allowOnce => 'Erlauben';

  @override
  String get allowAlways => 'Dieses Gerät immer erlauben';

  @override
  String get declineAction => 'Ablehnen';

  @override
  String get syncDeclined =>
      'Das andere Gerät hat die Synchronisierung abgelehnt';

  @override
  String get trustedDevicesSection => 'Immer erlaubte Geräte';

  @override
  String get removeTrust => 'Entfernen';

  @override
  String get hostWithoutWifi => 'Ohne WLAN hosten';

  @override
  String get hotspotJoinNote =>
      'Stellt eine vorübergehende Direktverbindung zum anderen Handy her (ohne Internet). Nur cat(a)log nutzt sie, nach der Synchronisierung trennt sie sich von selbst.';

  @override
  String get hotspotAndroidOnly =>
      'Dieser Code braucht zwei Android-Handys — auf iPhone/iPad stattdessen ein gemeinsames WLAN nutzen';

  @override
  String get selectClowderHint => 'Wähle links eine Kolonie';

  @override
  String get introTitle1 => 'Katzen wohnen in Kolonien';

  @override
  String get introBody1 =>
      'Eine Kolonie ist ein Ort, an dem Katzen leben: deine Pflegestelle, die Wohnung eines Adoptanten, die Scheune nebenan. Jede Katze bekommt eine Karte mit Foto, Fakten und ihrer ganzen Geschichte.';

  @override
  String get introTitle2 => 'Alles bleibt bei dir';

  @override
  String get introBody2 =>
      'Kein Konto, keine Cloud, kein Tracking. Deine Daten leben auf deinem Gerät und gehen nur dorthin, wohin du sie schickst.';

  @override
  String get introTitle3 => 'Teile mit deinen Helfern';

  @override
  String get introBody3 =>
      'Scanne einen Code und zwei Geräte sind in Sekunden synchron, nutze einen geteilten Ordner oder schicke alles als eine Datei. Alle haben am Ende denselben Katalog.';

  @override
  String get introSkip => 'Überspringen';

  @override
  String get introNext => 'Weiter';

  @override
  String get introDone => 'Los geht\'s';

  @override
  String get introReplayTitle => 'Kurze Einführung';

  @override
  String get spotHomeSync =>
      'Neu: Synchronisieren bietet drei klare Wege — und eine Vertrauensfrage, bevor etwas fließt.';

  @override
  String get spotMapSearch =>
      'Neu: Suche hier nach Katzen, Kolonien und Personen — direkt auf der Karte.';

  @override
  String get spotCardChips =>
      'Neu: Wähle vor dem Teilen aus, was auf der Karte steht.';

  @override
  String get spotCatMenu =>
      'Neu: Markiere eine Katze hier als privat (verlässt nie dein Gerät) oder blende sie aus.';

  @override
  String get spotDone => 'Verstanden';

  @override
  String get spotReplayTitle => 'Was-ist-neu-Tour';

  @override
  String get spotReplaySubtitle => 'Hinweise auf jeder Seite erneut zeigen';

  @override
  String get spotReplayDone => 'Die Hinweise erscheinen wieder';

  @override
  String get searchNoResults => 'Keine Katze mit diesem Namen gefunden';

  @override
  String get syncUnreachable =>
      'Das andere Gerät ist nicht erreichbar. Sind beide im selben WLAN?';

  @override
  String get folderUnreachable =>
      'Der Ordner ist nicht erreichbar. Ist das Laufwerk oder der Cloud-Ordner noch da?';

  @override
  String get crashTitle => 'Das hätte nicht passieren dürfen';

  @override
  String get crashBody =>
      'cat(a)log ist auf einen unerwarteten Fehler gestoßen. Deine Daten sind sicher — alles wird sofort beim Ändern gespeichert. Starte die App neu, und wenn es wieder passiert, schick den Bericht, damit es behoben werden kann.';

  @override
  String get crashRestart => 'App neu starten';

  @override
  String get crashSendReport => 'Bericht an den Entwickler senden';

  @override
  String get crashLastRunBody =>
      'cat(a)log wurde beim letzten Mal unerwartet beendet — vermutlich ging der Speicher aus. Kurzen Bericht senden, damit es behoben werden kann?';
}
