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
  String get clowdersNeutral => 'Haushalte';

  @override
  String get noClowdersYet =>
      'Noch keine Kolonien. Eine Kolonie ist ein Ort, an dem Katzen leben — deine Pflegestelle, die Wohnung eines Adoptanten. Lege unten die erste an.';

  @override
  String get noClowdersYetNeutral =>
      'Noch keine Haushalte. Ein Haushalt ist ein Ort, an dem Tiere leben — dein Zuhause, eine Pflegestelle, die Wohnung eines Adoptanten. Lege unten den ersten an.';

  @override
  String get strays => 'Streuner';

  @override
  String get searchCats => 'Katzen suchen';

  @override
  String get searchCatsNeutral => 'Tiere suchen';

  @override
  String get map => 'Karte';

  @override
  String get sync => 'Sync';

  @override
  String get fields => 'Felder';

  @override
  String get pickerColumns => 'Spalten';

  @override
  String get pickerCardFields => 'Auf der Karte';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get aboutAndFeedback => 'Über & Feedback';

  @override
  String get settings => 'Einstellungen';

  @override
  String get newClowder => 'Neue Kolonie';

  @override
  String get newClowderNeutral => 'Neuer Haushalt';

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
  String get renameClowderNeutral => 'Haushalt umbenennen';

  @override
  String get rename => 'Umbenennen';

  @override
  String get timeline => 'Verlauf';

  @override
  String get mergeInto => 'Zusammenführen mit…';

  @override
  String get deleteClowder => 'Kolonie löschen';

  @override
  String get deleteClowderNeutral => 'Haushalt löschen';

  @override
  String get cats => 'Katzen';

  @override
  String get catsNeutral => 'Tiere';

  @override
  String get addCat => 'Katze hinzufügen';

  @override
  String get addCatNeutral => 'Tier hinzufügen';

  @override
  String get newCat => 'Neue Katze';

  @override
  String get newCatNeutral => 'Neues Tier';

  @override
  String deleteQuestion(String name) {
    return '$name löschen?';
  }

  @override
  String get deleteClowderEmptyBody =>
      'Die Kolonie verschwindet aus der Liste.';

  @override
  String get deleteClowderEmptyBodyNeutral =>
      'Der Haushalt verschwindet aus der Liste.';

  @override
  String deleteClowderBody(int count) {
    return 'Ihre $count Katze(n) werden nicht gelöscht — sie werden zu Streunern. Verschiebe sie vorher in eine andere Kolonie, falls das nicht gewollt ist.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Seine $count Tier(e) werden nicht gelöscht — sie werden zu Streunern. Verschiebe sie vorher in einen anderen Haushalt, falls das nicht gewollt ist.';
  }

  @override
  String get card => 'Karte';

  @override
  String get shareAsImage => 'Als Bild teilen';

  @override
  String get sortOldestFirst => 'Älteste zuerst';

  @override
  String get sortNewestFirst => 'Neueste zuerst';

  @override
  String get shareAsText => 'Als Text teilen';

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
  String get renameCatNeutral => 'Tier umbenennen';

  @override
  String get seenHereNow => 'Hier gesehen';

  @override
  String get deleteCat => 'Katze löschen';

  @override
  String get deleteCatNeutral => 'Tier löschen';

  @override
  String get clowderLabel => 'Kolonie';

  @override
  String get clowderLabelNeutral => 'Haushalt';

  @override
  String get strayNoClowder => 'Streuner — keine Kolonie';

  @override
  String get strayNoClowderNeutral => 'Streuner — kein Haushalt';

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
      'Die Katze verschwindet aus allen Listen und ihre Fotos werden entfernt — hier und nach der nächsten Synchronisierung auch auf den anderen Geräten.';

  @override
  String get deleteCatBodyNeutral =>
      'Das Tier verschwindet aus allen Listen und seine Fotos werden entfernt — hier und nach der nächsten Synchronisierung auch auf den anderen Geräten.';

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
  String get captureFlier => 'Aushang erfassen';

  @override
  String get addPhotosTo => 'Fotos hinzufügen zu…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count Foto(s) zu $name hinzugefügt';
  }

  @override
  String get scanPrintedCode => 'Gedruckten Code scannen';

  @override
  String get chipScanHint =>
      'Scannt den gedruckten QR-/Barcode von Chipkarte oder Tierarztunterlagen — den Chip in der Katze kann ein Handy nicht lesen.';

  @override
  String get chipScanHintNeutral =>
      'Scannt den gedruckten QR-/Barcode von Chipkarte oder Tierarztunterlagen — den Chip im Tier kann ein Handy nicht lesen.';

  @override
  String get savingLabel => 'Speichern…';

  @override
  String ownerOfCat(String name) {
    return 'Besitzer von $name';
  }

  @override
  String get sortLabel => 'Sortieren';

  @override
  String get viewAsTable => 'Als Tabelle anzeigen';

  @override
  String get viewAsTiles => 'Als Kacheln anzeigen';

  @override
  String get viewAsList => 'Als Liste anzeigen';

  @override
  String get ageLabel => 'Alter';

  @override
  String get catList => 'Katzenliste';

  @override
  String get catListNeutral => 'Tierliste';

  @override
  String get matchCandidatesTitle => 'Mögliche Treffer';

  @override
  String get findDuplicates => 'Duplikate finden';

  @override
  String get noDuplicates => 'Gerade keine möglichen Duplikate.';

  @override
  String get similarName => 'Ähnlicher Name';

  @override
  String get sharePublicly => 'Öffentlich teilen…';

  @override
  String get pickFramesTitle => 'Bilder auswählen';

  @override
  String get suggestedFrames => 'Vorgeschlagene Bilder';

  @override
  String get scrubFrames => 'Durchs Video spulen';

  @override
  String get keepThisFrame => 'Dieses Bild behalten';

  @override
  String get fromVideo => 'Aus Video…';

  @override
  String addingPhotos(int done, int total) {
    return 'Foto $done von $total wird hinzugefügt…';
  }

  @override
  String get videoMobileOnly =>
      'Bilder aus einem Video gehen in der Telefon-App (Android und iPhone) — auf diesem Gerät noch nicht.';

  @override
  String get shareWhitelistExplainer =>
      'Wähle aus, was in die Datei kommt. Nur angehakte Felder sind enthalten.';

  @override
  String get exportShareFile => 'Teil-Datei exportieren…';

  @override
  String get hostedLink => 'Gehosteter Link (URL der hochgeladenen Datei)';

  @override
  String get inlineQr => 'Inline-QR (nur Text, keine Fotos)';

  @override
  String get inlineTooBig =>
      'Zu viele Daten für einen Inline-Code — Felder abwählen oder einen gehosteten Link verwenden.';

  @override
  String get scanShareLabel => 'Teil-Code scannen';

  @override
  String get notAShareCode => 'Dieser Code ist kein cat(a)log-Share.';

  @override
  String get importShareTitle => 'Diese Katze importieren?';

  @override
  String get importShareTitleNeutral => 'Dieses Tier importieren?';

  @override
  String shareSource(String url) {
    return 'Quelle: $url';
  }

  @override
  String get importLabel => 'Importieren';

  @override
  String get strayAreaLabel => 'Mögliches Streifgebiet';

  @override
  String get prevPin => 'Voriger Pin';

  @override
  String get nextPin => 'Nächster Pin';

  @override
  String get noMissingCats =>
      'Noch keine vermissten Katzen mit Aushang-Positionen.';

  @override
  String get noMissingCatsNeutral =>
      'Noch keine vermissten Tiere mit Aushang-Positionen.';

  @override
  String get noMatchCandidates => 'Gerade keine möglichen Treffer.';

  @override
  String sameIdField(String field) {
    return 'Gleiche $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m voneinander entfernt';
  }

  @override
  String get addFlier => 'Aushang hinzufügen';

  @override
  String get missingSinceLabel => 'Vermisst seit';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Porträt zuschneiden';

  @override
  String get statusOwner => 'Besitzer';

  @override
  String get ocrUnavailable =>
      'Texterkennung ist auf diesem Gerät nicht verfügbar — tippe den Aushangtext selbst ein.';

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
  String get malePregnantNeutral =>
      'Dieses Tier ist als männlich eingetragen — ein Männchen kann nicht trächtig sein. Prüfe zuerst das Geschlecht.';

  @override
  String fatherNotMale(String name) {
    return '$name ist als weiblich eingetragen und kann nicht der Vater sein. Prüfe zuerst das Geschlecht.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name ist als männlich eingetragen und kann nicht die Mutter sein. Prüfe zuerst das Geschlecht.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name wurde am $date geboren — ein Elternteil kann nicht nach seinem Jungen geboren sein.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name wurde am $date geboren — ein Elternteil kann nicht nach seinem Nachwuchs geboren sein.';
  }

  @override
  String get genderFatherFemale =>
      'Diese Katze ist als Vater anderer Katzen eingetragen — der Vater kann nicht weiblich sein. Prüfe zuerst die Familie.';

  @override
  String get genderFatherFemaleNeutral =>
      'Dieses Tier ist als Vater anderer Tiere eingetragen — der Vater kann nicht weiblich sein. Prüfe zuerst die Familie.';

  @override
  String get genderMotherMale =>
      'Diese Katze ist als Mutter anderer Katzen eingetragen — die Mutter kann nicht männlich sein. Prüfe zuerst die Familie.';

  @override
  String get genderMotherMaleNeutral =>
      'Dieses Tier ist als Mutter anderer Tiere eingetragen — die Mutter kann nicht männlich sein. Prüfe zuerst die Familie.';

  @override
  String get moveTo => 'Verschieben nach';

  @override
  String get noClowderStrayOption => 'Keine Kolonie — Streuner / weggelaufen';

  @override
  String get noClowderStrayOptionNeutral =>
      'Kein Haushalt — Streuner / weggelaufen';

  @override
  String timelineOf(String name) {
    return 'Verlauf — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

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
  String get dateInFuture => 'Dieses Datum kann nicht in der Zukunft liegen.';

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
  String get forCatsNeutral => 'Tiere';

  @override
  String get forClowders => 'Kolonien';

  @override
  String get forClowdersNeutral => 'Haushalte';

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
  String get searchByNameHintNeutral => 'Tiere nach Name suchen…';

  @override
  String get host => 'Anbieten';

  @override
  String get hostExplainer =>
      'Hier starten, dann den Code auf dem anderen Gerät scannen oder eingeben.';

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
      'Beide Geräte nutzen denselben Ordner (z. B. in Dropbox oder auf einem USB-Stick). Beim Synchronisieren landen deine Änderungen dort und die der anderen Seite kommen zu dir.';

  @override
  String get noFolderChosenYet => 'Noch kein Ordner gewählt';

  @override
  String get choose => 'Auswählen…';

  @override
  String get syncFolderNow => 'Ordner jetzt synchronisieren';

  @override
  String folderCatalogHint(Object name) {
    return 'Darin nutzt dieser Katalog den Ordner „$name“, sodass ein gemeinsamer Ordner alle deine Kataloge tragen kann.';
  }

  @override
  String get useSameFolder =>
      'Denselben Ordner wie die anderen Kataloge nutzen';

  @override
  String get folderHint =>
      'Jeder Ordner, den zwei Geräte gleich halten, reicht: ein Cloud-Laufwerk oder Syncthing für einen Ordner, der auf euren Telefonen bleibt. Syncthing ist kostenlos: auf jedem Telefon installieren, einen Ordner untereinander teilen und diesen Ordner hier auf jedem Gerät wählen.';

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
  String trailOfField(String name, String field, int count) {
    return 'Route: $name — $field ($count Werte)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Route: $name ($count Positionen)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'An zwei Orten gleichzeitig geändert. Wähle, was stimmt:';

  @override
  String privateMarker(Object field) {
    return '$field (privat)';
  }

  @override
  String conflictSame(Object value) {
    return 'Beide Änderungen sagen dasselbe: $value. Nichts zu wählen; Auflösen entfernt die Markierung.';
  }

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
  String get kindCatNeutral => 'Tier';

  @override
  String get kindClowder => 'Kolonie';

  @override
  String get kindClowderNeutral => 'Haushalt';

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
  String get aboutTaglineNeutral =>
      'Ein lokaler Katalog für die Tiere, um die du dich kümmerst. Deine Daten bleiben auf deinen Geräten — kein Server, kein Konto.';

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
  String get coffeeSubtitle =>
      'Die App bleibt kostenlos. Auch wenn ich keinen Kaffee krieg :)';

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
  String get breedAbyssinian => 'Abessinier';

  @override
  String get breedAmericanShorthair => 'Amerikanisch Kurzhaar';

  @override
  String get breedBalinese => 'Balinese';

  @override
  String get breedBirman => 'Heilige Birma';

  @override
  String get breedBombay => 'Bombay';

  @override
  String get breedBurmese => 'Burma';

  @override
  String get breedBurmilla => 'Burmilla';

  @override
  String get breedBritishLonghair => 'Britisch Langhaar';

  @override
  String get breedChartreux => 'Kartäuser';

  @override
  String get breedCornishRex => 'Cornish Rex';

  @override
  String get breedDevonRex => 'Devon Rex';

  @override
  String get breedEgyptianMau => 'Ägyptische Mau';

  @override
  String get breedExoticShorthair => 'Exotic Shorthair';

  @override
  String get breedHimalayan => 'Himalaya';

  @override
  String get breedKorat => 'Korat';

  @override
  String get breedManx => 'Manx';

  @override
  String get breedMunchkin => 'Munchkin';

  @override
  String get breedOcicat => 'Ocicat';

  @override
  String get breedOrientalShorthair => 'Orientalisch Kurzhaar';

  @override
  String get breedRagamuffin => 'Ragamuffin';

  @override
  String get breedRussianBlue => 'Russisch Blau';

  @override
  String get breedSavannah => 'Savannah';

  @override
  String get breedScottishFold => 'Scottish Fold';

  @override
  String get breedSelkirkRex => 'Selkirk Rex';

  @override
  String get breedSiberian => 'Sibirische Katze';

  @override
  String get breedSnowshoe => 'Snowshoe';

  @override
  String get breedSomali => 'Somali';

  @override
  String get breedTonkinese => 'Tonkinese';

  @override
  String get breedTurkishAngora => 'Türkisch Angora';

  @override
  String get breedTurkishVan => 'Türkisch Van';

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
  String get starterEmail => 'E-Mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Nachschlage-Link';

  @override
  String lookupUrlHelp(String token) {
    return 'Die Seite des Dienstes mit $token an der Stelle der Nummer, z. B. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Nachschlagen';

  @override
  String lookupFailed(String url) {
    return 'Keine App konnte $url öffnen. Kopiere den Link in einen Browser.';
  }

  @override
  String get stepCat => 'Katze';

  @override
  String get stepCatNeutral => 'Tier';

  @override
  String get stepOwner => 'Besitzer';

  @override
  String get stepFace => 'Profilbild';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Prüfen und speichern';

  @override
  String get stepOwnerHint =>
      'Wer die Katze vermisst — daraus wird deren Kolonie, mit dem Kontakt vom Aushang.';

  @override
  String get stepOwnerHintNeutral =>
      'Wer das Tier vermisst — daraus wird dessen Haushalt, mit dem Kontakt vom Aushang.';

  @override
  String get stepFaceHint =>
      'Schneide das Gesicht der Katze aus dem Aushang aus; es wird zum Profilbild. Kannst du auch überspringen.';

  @override
  String get stepFaceHintNeutral =>
      'Schneide das Gesicht des Tieres aus dem Aushang aus; es wird zum Profilbild. Kannst du auch überspringen.';

  @override
  String get stepRegistryHint =>
      'Nummern vom Aushang. Angehakte werden bei der Katze gespeichert und lassen sich später öffnen.';

  @override
  String get stepRegistryHintNeutral =>
      'Nummern vom Aushang. Angehakte werden beim Tier gespeichert und lassen sich später öffnen.';

  @override
  String get noRegistryLinks =>
      'Keine Register-Links auf diesem Aushang — falls sie übersehen wurden, bitte Bug melden.';

  @override
  String get unknownServiceHint => 'Unbekannter Dienst';

  @override
  String get rememberService => 'Dienst merken';

  @override
  String get rememberServiceHint =>
      'Benenne den Dienst und zeige auf die Nummer im Link. Der nächste Aushang füllt sich dann von selbst.';

  @override
  String get noIdInLink =>
      'In diesem Link steckt keine Nummer, die die App speichern könnte.';

  @override
  String get whichNumber => 'Welcher Teil ist die Nummer?';

  @override
  String get cropAgain => 'Neu zuschneiden';

  @override
  String get noFaceYet =>
      'Noch kein Profilbild — es wird das Aushang-Foto genommen.';

  @override
  String get backLabel => 'Zurück';

  @override
  String get dangerButton => 'NICHT DRÜCKEN.\nGEFAHR';

  @override
  String get dangerThanks => 'Danke, dass du cat(a)log benutzt!';

  @override
  String get helpTitle => 'Hilfe';

  @override
  String get showTipsAgain => 'Tipps nochmal zeigen';

  @override
  String get helpHome =>
      'Die Übersicht deiner Kolonien — eine Kolonie ist ein Ort, an dem Katzen leben: dein Zuhause, eine Pflegestelle, ein Tierheim. Tippe auf eine Karte, um ihre Katzen zu sehen; langes Drücken öffnet das Menü. Der Knopf unten rechts legt eine neue Kolonie an, und die Streuner-Karte sammelt alle Katzen ohne Zuhause. Der Name oben ist der Katalog, in dem du bist — antippen wechselt oder legt einen an.';

  @override
  String get helpHomeNeutral =>
      'Die Übersicht deiner Haushalte — ein Haushalt ist ein Ort, an dem Tiere leben: dein Zuhause, eine Pflegestelle, ein Tierheim. Tippe auf eine Karte, um seine Tiere zu sehen; langes Drücken öffnet das Menü. Der Knopf unten rechts legt einen neuen Haushalt an, und die Streuner-Karte sammelt alle Tiere ohne Zuhause. Der Name oben ist der Katalog, in dem du bist — antippen wechselt oder legt einen an.';

  @override
  String get helpClowder =>
      'Alles zu diesem Ort: seine Katzen, seine Felder (Adresse, Kontakt, Art) und seine Historie. Die Seite ist erst nur zum Lesen; der Stift schaltet das Bearbeiten ein, dort kannst du auch ein neues Feld anlegen. Ein Feld lange drücken bearbeitet es direkt, eine Katze lange drücken verschiebt, versteckt oder öffnet sie. Ein hier angelegter Termin kann mehrere Katzen der Kolonie mitnehmen — etwa eine Kastrationsfahrt: mitkommende Katzen anhaken, einmal abschließen, nicht behandelte abhaken. Die Uhr an einem Feld öffnet seinen Verlauf.';

  @override
  String get helpClowderNeutral =>
      'Alles zu diesem Ort: seine Tiere, seine Felder (Adresse, Kontakt, Art) und seine Historie. Die Seite ist erst nur zum Lesen; der Stift schaltet das Bearbeiten ein, dort kannst du auch ein neues Feld anlegen. Ein Feld lange drücken bearbeitet es direkt, ein Tier lange drücken verschiebt, versteckt oder öffnet es. Ein hier angelegter Termin kann mehrere Tiere des Haushalts mitnehmen — etwa eine Kastrationsfahrt: mitkommende Tiere anhaken, einmal abschließen, nicht behandelte abhaken. Die Uhr an einem Feld öffnet seinen Verlauf.';

  @override
  String get helpCat =>
      'Alles zu dieser Katze: Fotos, Felder, Familie, Historie. Die Seite ist nur zum Lesen, bis du den Stift antippst. Ein Feld lange drücken springt direkt in dessen Bearbeitung; ein Foto lange drücken öffnet sein Menü. Im Menü oben rechts steckt der Rest: ausblenden, zusammenführen, Sichtung eintragen, Katze teilen. Privat setzt du beim Bearbeiten eines Feldes. Die Uhr an einem Feld öffnet seinen Verlauf.';

  @override
  String get helpCatNeutral =>
      'Alles zu diesem Tier: Fotos, Felder, Familie, Historie. Die Seite ist nur zum Lesen, bis du den Stift antippst. Ein Feld lange drücken springt direkt in dessen Bearbeitung; ein Foto lange drücken öffnet sein Menü. Im Menü oben rechts steckt der Rest: ausblenden, zusammenführen, Sichtung eintragen, Tier teilen. Privat setzt du beim Bearbeiten eines Feldes. Die Uhr an einem Feld öffnet seinen Verlauf.';

  @override
  String get helpStrays =>
      'Katzen, die gerade kein Zuhause haben: Fundkatzen, entlaufene Katzen, Katzen von einem Aushang. Der Kamera-Knopf hält eine Katze fest, die vor dir sitzt; der Aushang-Knopf macht aus einem Vermisst-Plakat eine Katze samt Besitzer-Kontakt; der Scanner liest einen cat(a)log-Code vom Plakat. Tippen auf Stray Cam macht ein Foto; gedrückt halten filmt ein Video, aus dem du die besten Bilder als Fotos behältst.';

  @override
  String get helpStraysNeutral =>
      'Tiere, die gerade kein Zuhause haben: Fundtiere, entlaufene Tiere, Tiere von einem Aushang. Der Kamera-Knopf hält ein Tier fest, das vor dir sitzt; der Aushang-Knopf macht aus einem Vermisst-Plakat ein Tier samt Besitzer-Kontakt; der Scanner liest einen cat(a)log-Code vom Plakat. Tippen auf Stray Cam macht ein Foto; gedrückt halten filmt ein Video, aus dem du die besten Bilder als Fotos behältst.';

  @override
  String get helpMap =>
      'Alle Katzen und Orte mit Position. Die Suche findet Katzen, Personen und Orte — einen unbekannten Namen sucht sie weltweit. Der Ebenen-Knopf zeichnet die 500-m-Kreise um die Aushang-Orte einer vermissten Katze und um ihr altes Zuhause. Die Pfeile laufen von Pin zu Pin, langes Drücken auf die Karte trägt eine Sichtung ein. Jedes Ortsfeld erscheint als Pin auf der Karte; tippe auf einen Pin für seine Route.';

  @override
  String get helpMapNeutral =>
      'Alle Tiere und Orte mit Position. Die Suche findet Tiere, Personen und Orte — einen unbekannten Namen sucht sie weltweit. Der Ebenen-Knopf zeichnet die 500-m-Kreise um die Aushang-Orte eines vermissten Tieres und um sein altes Zuhause. Die Pfeile laufen von Pin zu Pin, langes Drücken auf die Karte trägt eine Sichtung ein. Jedes Ortsfeld erscheint als Pin auf der Karte; tippe auf einen Pin für seine Route.';

  @override
  String get helpCard =>
      'Die druckbare Karte dieser Katze: Oben wählst du mit den Chips aus, was daraufsteht, dann teilst du sie als Bild oder PDF. IDs können als QR-Code oder Barcode gedruckt werden, und aus einer Position wird ein QR-Code, der eine Karte öffnet, plus ein kurzer Plus Code.';

  @override
  String get helpCardNeutral =>
      'Die druckbare Karte dieses Tieres: Oben wählst du mit den Chips aus, was daraufsteht, dann teilst du sie als Bild oder PDF. IDs können als QR-Code oder Barcode gedruckt werden, und aus einer Position wird ein QR-Code, der eine Karte öffnet, plus ein kurzer Plus Code.';

  @override
  String get helpSync =>
      'So kommen Daten zu anderen Leuten: direkt verbinden, wenn ihr euch trefft, einen Ordner nutzen, den beide Geräte sehen, oder eine Datei per Messenger schicken. Du entscheidest immer, was rausgeht — und empfangene .catsync-Dateien öffnest du auch hier. Jeder Katalog signiert, was er schreibt, mit seinem eigenen Schlüssel; Partner sehen den Schlüsselcode neben deinem Namen. Der erste Schlüssel eines Partners wird aus einer Datei auf Vertrauen übernommen und gilt als getroffen, sobald ihr persönlich synchronisiert. Einträge unter einem bekannten Namen ohne passende Signatur werden abgewiesen und auf der Ankunftsseite aufgeführt.';

  @override
  String get helpFields =>
      'Die Felder, die dein Katalog benutzt. Benenne sie um, ändere die Auswahlmöglichkeiten eines Auswahlfeldes oder leg eigene an. ID-Felder können auf einen Dienst (ein Register) zeigen, dann lässt sich die Nummer bei der Katze antippen.';

  @override
  String get helpFieldsNeutral =>
      'Die Felder, die dein Katalog benutzt. Benenne sie um, ändere die Auswahlmöglichkeiten eines Auswahlfeldes oder leg eigene an. ID-Felder können auf einen Dienst (ein Register) zeigen, dann lässt sich die Nummer beim Tier antippen.';

  @override
  String get helpTimeline =>
      'Jede Änderung, neueste zuerst: wer wann was auf welchen Wert gesetzt hat. Tippen korrigiert einen Eintrag, Halten entfernt ihn oder stellt ihn wieder her; ein ausgeblendeter Eintrag bleibt im Protokoll und wird auf Wunsch angezeigt.';

  @override
  String get helpDuplicates =>
      'Katzen oder Kolonien, die zweimal dieselben zu sein scheinen — gleiche IDs oder sehr ähnliche Namen mit passenden Details. Tippe ein Paar an, um es zusammenzuführen; das lässt sich nicht rückgängig machen, deshalb wird vorher gefragt.';

  @override
  String get helpDuplicatesNeutral =>
      'Tiere oder Haushalte, die zweimal dieselben zu sein scheinen — gleiche IDs oder sehr ähnliche Namen mit passenden Details. Tippe ein Paar an, um es zusammenzuführen; das lässt sich nicht rückgängig machen, deshalb wird vorher gefragt.';

  @override
  String get helpMatches =>
      'Katzen, die dasselbe Tier sein könnten: gleiche ID oder ein Streuner, der im Suchgebiet einer vermissten Katze gesehen wurde. Tippe ein Paar an, um es zusammenzuführen, langes Drücken öffnet die erste Katze zum Vergleichen. Paare, deren Aussehen in mindestens zwei Merkmalen übereinstimmt und sich in keinem widerspricht, stehen ebenfalls in der Liste; die Chips zeigen welche. „Nicht dieselbe“ blendet ein Paar auf diesem Telefon aus, bis sich das Aussehen eines der Tiere ändert.';

  @override
  String get helpMatchesNeutral =>
      'Tiere, die dasselbe Tier sein könnten: gleiche ID oder ein Streuner, der im Suchgebiet eines vermissten Tieres gesehen wurde. Tippe ein Paar an, um es zusammenzuführen, langes Drücken öffnet das erste Tier zum Vergleichen. Paare, deren Aussehen in mindestens zwei Merkmalen übereinstimmt und sich in keinem widerspricht, stehen ebenfalls in der Liste; die Chips zeigen welche. „Nicht dieselbe“ blendet ein Paar auf diesem Telefon aus, bis sich das Aussehen eines der Tiere ändert.';

  @override
  String get helpFlier =>
      'Aus einem fotografierten Vermisst-Aushang wird eine Katze samt Besitzer. Schritt für Schritt: Daten der Katze, Kontakt des Besitzers, Gesicht ausschneiden fürs Profilbild, Register-Nummern vom Aushang, dann die letzte Kontrolle. Alles sind Vorschläge — korrigiere, was die Kamera falsch gelesen hat.';

  @override
  String get helpFlierNeutral =>
      'Aus einem fotografierten Vermisst-Aushang wird ein Tier samt Besitzer. Schritt für Schritt: Daten des Tieres, Kontakt des Besitzers, Gesicht ausschneiden fürs Profilbild, Register-Nummern vom Aushang, dann die letzte Kontrolle. Alles sind Vorschläge — korrigiere, was die Kamera falsch gelesen hat.';

  @override
  String get archiveTitle => 'Archiv';

  @override
  String get archiveExplainer =>
      'Verstorbene Katzen und leere Kolonien, die seit Jahren niemand angefasst hat, kosten trotzdem Platz — vor allem ihre Fotos. Beim Archivieren werden sie in eine Datei geschrieben, die du behältst, und danach hier gelöscht.';

  @override
  String get archiveExplainerNeutral =>
      'Verstorbene Tiere und leere Haushalte, die seit Jahren niemand angefasst hat, kosten trotzdem Platz — vor allem ihre Fotos. Beim Archivieren werden sie in eine Datei geschrieben, die du behältst, und danach hier gelöscht.';

  @override
  String get archiveAction => 'Archivieren';

  @override
  String archiveSelected(int count) {
    return '$count Einträge archivieren';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '$count Einträge archivieren?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names werden in eine Datei geschrieben und danach gelöscht — auf deinem Gerät und auf jedem Gerät, mit dem du synchronisierst. Die Datei zu importieren holt alles zurück; ohne sie sind sie weg.';
  }

  @override
  String archiveDone(int count) {
    return '$count Einträge archiviert und gelöscht';
  }

  @override
  String archiveFailed(String error) {
    return 'Es wurde nichts gelöscht: Die Archivdatei konnte nicht geschrieben werden ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Datenbank $db, Fotos $photos in $count Dateien';
  }

  @override
  String quietForYears(int years) {
    return 'Seit $years Jahren ruhig';
  }

  @override
  String get nothingToArchive => 'Nichts ist alt genug zum Archivieren.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Letzte Änderung $date · Fotos $size';
  }

  @override
  String get helpArchive =>
      'Alte Daten kosten Platz, vor allem die Fotos, die jedes synchronisierte Gerät mitschleppt. Hier wählst du verstorbene Katzen und leere Kolonien aus, die seit Jahren ruhig sind, schreibst sie in eine Datei, die du behältst, und löschst sie. Das Löschen erreicht alle, mit denen du synchronisierst; der Import der Datei stellt alles wieder her.';

  @override
  String get helpArchiveNeutral =>
      'Alte Daten kosten Platz, vor allem die Fotos, die jedes synchronisierte Gerät mitschleppt. Hier wählst du verstorbene Tiere und leere Haushalte aus, die seit Jahren ruhig sind, schreibst sie in eine Datei, die du behältst, und löschst sie. Das Löschen erreicht alle, mit denen du synchronisierst; der Import der Datei stellt alles wieder her.';

  @override
  String restoreDeletedTitle(int count) {
    return '$count gelöschte Einträge wiederherstellen?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names sind in diesem Katalog gelöscht, und die gerade importierte Datei enthält sie. Wiederherstellen holt sie hier und auf allen Geräten zurück, mit denen du synchronisierst.';
  }

  @override
  String get restoreAction => 'Wiederherstellen';

  @override
  String get keepDeleted => 'Gelöscht lassen';

  @override
  String get archiveNotSaved =>
      'Es wurde nichts gelöscht: Das Archiv wurde nirgendwo gespeichert.';

  @override
  String get locateAddress => 'Adresse auf der Karte suchen';

  @override
  String get addressFoundTitle => 'Adresse gefunden';

  @override
  String get replaceAddressOption => 'Adresse durch diese ersetzen';

  @override
  String get addPositionOption => 'Standort übernehmen';

  @override
  String get addressLocated => 'Adresse gefunden';

  @override
  String get addressNotFound =>
      'Zu dieser Adresse wurde kein Ort gefunden. Prüfe die Schreibweise oder lass das Feld leer.';

  @override
  String get starterPosition => 'Standort';

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
  String get markTitleNeutral => 'Tier markieren';

  @override
  String get applyCrop => 'Zuschneiden';

  @override
  String get useFullPhoto => 'Ganzes Foto verwenden';

  @override
  String get dragToSelect => 'Ziehe ein Rechteck um die Katze';

  @override
  String get dragToSelectNeutral => 'Ziehe ein Rechteck um das Tier';

  @override
  String get dragOverTheCat => 'Ziehe eine Ellipse über die Katze';

  @override
  String get dragOverTheCatNeutral => 'Ziehe eine Ellipse über das Tier';

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
  String get typeUnitValue => 'Messwert';

  @override
  String get dimension => 'Größe';

  @override
  String get dimensionWeight => 'Gewicht';

  @override
  String get dimensionLength => 'Länge';

  @override
  String get dimensionVolume => 'Volumen';

  @override
  String get dimensionTemperature => 'Temperatur';

  @override
  String get unitsLabel => 'Einheiten';

  @override
  String get catalogHolds => 'Dieser Katalog enthält';

  @override
  String get modeCats => 'Katzen';

  @override
  String get modePets => 'Tiere';

  @override
  String get graphLabel => 'Verlauf';

  @override
  String get fieldHistoryTooltip => 'Verlauf';

  @override
  String get rangeWeek => 'Woche';

  @override
  String get rangeMonth => 'Monat';

  @override
  String get rangeYear => 'Jahr';

  @override
  String get rangeAll => 'Alles';

  @override
  String get rangeCustom => 'Eigener…';

  @override
  String changeSince(String delta, String date) {
    return '$delta seit $date';
  }

  @override
  String get unitsAuto => 'Wie in deiner Region';

  @override
  String get unitsMetric => 'Metrisch (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperial (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Gewicht';

  @override
  String get starterLooks => 'Aussehen';

  @override
  String get looksGroupSize => 'Größe';

  @override
  String get looksGroupColours => 'Farben';

  @override
  String get looksGroupPattern => 'Muster';

  @override
  String get looksGroupFur => 'Fell';

  @override
  String get looksGroupTail => 'Schwanz';

  @override
  String get looksGroupEars => 'Ohren';

  @override
  String get looksGroupMarks => 'Kennzeichen';

  @override
  String get looksGroupCrest => 'Haube';

  @override
  String get looksGroupBeak => 'Schnabel';

  @override
  String get looksGroupRing => 'Fußring';

  @override
  String get looksValueSmall => 'Klein';

  @override
  String get looksValueMedium => 'Mittel';

  @override
  String get looksValueLarge => 'Groß';

  @override
  String get looksValueBlack => 'Schwarz';

  @override
  String get looksValueWhite => 'Weiß';

  @override
  String get looksValueGrey => 'Grau';

  @override
  String get looksValueBrown => 'Braun';

  @override
  String get looksValueGinger => 'Rot';

  @override
  String get looksValueCream => 'Creme';

  @override
  String get looksValueGolden => 'Golden';

  @override
  String get looksValueTan => 'Hellbraun';

  @override
  String get looksValueGreen => 'Grün';

  @override
  String get looksValueBlue => 'Blau';

  @override
  String get looksValueYellow => 'Gelb';

  @override
  String get looksValueRed => 'Rot';

  @override
  String get looksValueOrange => 'Orange';

  @override
  String get looksValuePink => 'Rosa';

  @override
  String get looksValueWhiteBib => 'Weißer Latz';

  @override
  String get looksValueWhitePaws => 'Weiße Pfoten';

  @override
  String get looksValueWhiteTailTip => 'Weiße Schwanzspitze';

  @override
  String get looksValueBlaze => 'Blesse';

  @override
  String get looksValueMask => 'Maske';

  @override
  String get looksValueSpots => 'Flecken';

  @override
  String get looksValuePatches => 'Platten';

  @override
  String get looksValueStripes => 'Streifen';

  @override
  String get looksValueScar => 'Narbe';

  @override
  String get looksValueNotchedEar => 'Ohrkerbe';

  @override
  String get looksValueEarTip => 'Ohrspitze';

  @override
  String get looksValueCollar => 'Halsband';

  @override
  String get looksValueShort => 'Kurz';

  @override
  String get looksValueLong => 'Lang';

  @override
  String get looksValueHairless => 'Haarlos';

  @override
  String get looksValueBobtail => 'Stummel';

  @override
  String get looksValueNone => 'Keiner';

  @override
  String get looksValueCurled => 'Geringelt';

  @override
  String get looksValueUpright => 'Stehend';

  @override
  String get looksValueFloppy => 'Hängend';

  @override
  String get looksValueFolded => 'Gefaltet';

  @override
  String get looksValueRounded => 'Rund';

  @override
  String get looksValueSolid => 'Einfarbig';

  @override
  String get looksValueTabby => 'Getigert';

  @override
  String get looksValueTortoiseshell => 'Schildpatt';

  @override
  String get looksValueCalico => 'Glückskatze';

  @override
  String get looksValueColourpoint => 'Point';

  @override
  String get looksValueBicolour => 'Zweifarbig';

  @override
  String get looksValueTuxedo => 'Smoking';

  @override
  String get looksValueBrindle => 'Gestromt';

  @override
  String get looksValueMerle => 'Merle';

  @override
  String get looksValueSpotted => 'Gepunktet';

  @override
  String get looksValuePatched => 'Gescheckt';

  @override
  String get looksValueTricolour => 'Dreifarbig';

  @override
  String get looksValueSable => 'Zobel';

  @override
  String get looksGroupEyes => 'Augen';

  @override
  String get looksGroupFeatures => 'Besonderheiten';

  @override
  String get looksValueAmber => 'Bernstein';

  @override
  String get looksValueCopper => 'Kupfer';

  @override
  String get looksValueOddEyed => 'Verschiedenfarbig';

  @override
  String get looksValueChocolate => 'Schokolade';

  @override
  String get looksValueLilac => 'Lilac';

  @override
  String get looksValueSilver => 'Silber';

  @override
  String get looksValueSmoke => 'Rauch';

  @override
  String get looksValueTicked => 'Getickt';

  @override
  String get looksValueVan => 'Van';

  @override
  String get looksValueCurly => 'Gelockt';

  @override
  String get looksValueWiry => 'Drahtig';

  @override
  String get looksValueKinked => 'Geknickt';

  @override
  String get looksValueCropped => 'Kupiert';

  @override
  String get looksValueTippedEar => 'Ohrspitze gekappt';

  @override
  String get looksValueEarTattoo => 'Ohrtätowierung';

  @override
  String get looksValueMissingEar => 'Fehlendes Ohr';

  @override
  String get looksValueMissingEye => 'Fehlendes Auge';

  @override
  String get looksValueCloudyEye => 'Trübes Auge';

  @override
  String get looksValueMissingFrontLeg => 'Fehlendes Vorderbein';

  @override
  String get looksValueMissingHindLeg => 'Fehlendes Hinterbein';

  @override
  String get looksValueNoTeeth => 'Keine Zähne';

  @override
  String get looksValueExtraToes => 'Zusätzliche Zehen';

  @override
  String get rejectMatch => 'Nicht dieselbe';

  @override
  String traitsAgree(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Merkmale stimmen überein',
      one: '1 Merkmal stimmt überein',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Wenn es auf iPhone/iPad weiter scheitert: Einstellungen → Datenschutz & Sicherheit → Lokales Netzwerk → cat(a)log erlauben, dann erneut versuchen.';

  @override
  String get includePrivate => 'Private Daten teilen';

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
  String get starterStatus => 'Art';

  @override
  String get statusFoster => 'Pflegestelle';

  @override
  String get statusForeverHome => 'Zuhause';

  @override
  String get statusClinic => 'Klinik';

  @override
  String get statusShelter => 'Tierheim';

  @override
  String get statusBarn => 'Scheune';

  @override
  String get valueCat => 'Katze';

  @override
  String get valueDog => 'Hund';

  @override
  String get valueRabbit => 'Kaninchen';

  @override
  String get valueGuineaPig => 'Meerschweinchen';

  @override
  String get valueHamster => 'Hamster';

  @override
  String get valueBird => 'Vogel';

  @override
  String get valueHorse => 'Pferd';

  @override
  String get valueTortoise => 'Schildkröte';

  @override
  String get valueFerret => 'Frettchen';

  @override
  String get otherOption => 'Anderes…';

  @override
  String get celebrationsToggle => 'Adoptionen feiern';

  @override
  String get celebrationsSubtitle =>
      'Konfetti und Jubel, wenn eine Katze in ihr Zuhause zieht';

  @override
  String get cheerToggle => 'Jubel-Ton';

  @override
  String get cheerSubtitle =>
      'Ein kurzer Jubel zum Konfetti, jedes Mal ein anderer';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfetti und Jubel, wenn ein Tier in sein Zuhause zieht';

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
  String get mapSearchHintNeutral => 'Tiere, Haushalte, Personen suchen';

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
  String get yourKey => 'Dein Schlüssel';

  @override
  String get yourTitle => 'Dein Titel';

  @override
  String get titleNone => 'Kein Titel';

  @override
  String keyLine(Object code) {
    return 'Schlüssel $code';
  }

  @override
  String get keyVerified => 'persönlich getroffen';

  @override
  String get keyFromFile => 'aus einer Datei, noch nicht getroffen';

  @override
  String get keyUnsigned => 'noch kein Schlüssel, Einträge unsigniert';

  @override
  String get summaryRefused => 'Abgewiesen';

  @override
  String refusedEntries(int count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge',
      one: '1 Eintrag',
    );
    return '$_temp0 abgewiesen: nicht mit dem für $name bekannten Schlüssel signiert';
  }

  @override
  String newKeyCallsItself(Object code, Object name) {
    return 'Ein neuer Schlüssel $code nennt sich $name. Frag nach, bevor du ihm vertraust.';
  }

  @override
  String keyChangedRefused(Object name) {
    return '$name hat einen anderen Schlüssel angeboten als den hier bekannten. Der bekannte bleibt, der neue wurde nicht übernommen.';
  }

  @override
  String metaNewKey(Object name, Object code, Object how) {
    return 'Neuer Schlüssel: $name · $code ($how)';
  }

  @override
  String hardDeleteWarningKey(Object name, Object key) {
    return 'Entfernt jeden Eintrag und jedes Foto, das $name unter Schlüssel $key geschrieben hat, aus diesem Katalog. Andere Geräte behalten ihre. Das kann nicht rückgängig gemacht werden.';
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
  String conflictsMenu(int n) {
    return 'Konflikte ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Du hast hier einen Konflikt gelöst, darum gibt es kein Ablehnen mehr: es würde auch das rückgängig machen.';

  @override
  String get arrivalIntro =>
      'Diese Änderungen sind bereits in deinem Katalog. Ablehnen stellt ihn wieder so her, wie er war.';

  @override
  String get summaryUpdated => 'Geändert';

  @override
  String get summaryDeleted => 'Gelöscht';

  @override
  String get keepMine => 'Meins behalten';

  @override
  String keptMine(String name) {
    return 'Deine Fassung von $name bleibt auf diesem Gerät.';
  }

  @override
  String get summaryMeta => 'Außerdem angekommen';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Änderungen',
      one: '1 Änderung',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Übernehmen';

  @override
  String get rejectArrival => 'Ablehnen';

  @override
  String get photoAdded => 'Foto hinzugekommen';

  @override
  String get photoNotReceived => 'Foto noch nicht empfangen';

  @override
  String get photoRemoved => 'Foto entfernt';

  @override
  String metaFieldAdded(String name) {
    return 'Neues Feld: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Feld geändert: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser in $survivor zusammengeführt';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Fotos',
      one: '1 Foto',
    );
    return '$_temp0';
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
  String get kittensLabelNeutral => 'Nachwuchs';

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
  String toastBornNeutral(Object cat) {
    return '✨ Neugeboren: $cat ✨';
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
  String get syncChooserInPersonSub => 'Sync via WLAN';

  @override
  String get syncChooserRemote => 'Entfernt';

  @override
  String get syncChooserRemoteSub => 'Sync via Ordner oder USB-Stick';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Ex- und Import via Social Media';

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
  String get selectClowderHintNeutral => 'Wähle links einen Haushalt';

  @override
  String get introTitle1 => 'Deine Katzen im Blick';

  @override
  String get introTitle1Neutral => 'Deine Tiere im Blick';

  @override
  String get introBody1 =>
      'Lege für jede Katze eine Karte an: Foto, Geschlecht, Gesundheit, alles was du festhalten willst. Katzen sind danach gruppiert, wo sie leben — so einen Ort nennt die App Kolonie.';

  @override
  String get introBody1Neutral =>
      'Lege für jedes Tier eine Karte an: Foto, Geschlecht, Gesundheit, alles was du festhalten willst. Tiere sind danach gruppiert, wo sie leben — so einen Ort nennt die App Haushalt.';

  @override
  String get introTitle2 => 'Funktioniert ohne Internet';

  @override
  String get introBody2 =>
      'Alles wird nur auf deinem Handy gespeichert. Kein Konto, keine Cloud. Nichts wird hochgeladen, außer du teilst es selbst.';

  @override
  String get introTitle3 => 'Zusammenarbeiten';

  @override
  String get introBody3 =>
      'Jeder nutzt die eigene App, und ab und zu tauscht ihr Daten aus: trefft euch und scannt einen Code, nutzt einen gemeinsamen Ordner oder schickt eine Datei per Messenger. Danach haben alle denselben Stand.';

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
      'Hier synchronisierst du mit deinen Bekannten. Du entscheidest, was du teilst.';

  @override
  String get spotHomeStrays =>
      'Diese Karte sammelt alle Streuner — Katzen ohne Zuhause. Antippen zeigt die Liste.';

  @override
  String get spotHomeStraysNeutral =>
      'Diese Karte sammelt alle Streuner — Tiere ohne Zuhause. Antippen zeigt die Liste.';

  @override
  String get spotHomeMenu =>
      'In diesem Menü: Einstellungen, doppelte Einträge finden und zusammenführen, CSV exportieren und mehr.';

  @override
  String get spotCatEdit =>
      'Tippe auf den Stift, um die Katze zu bearbeiten. Tipp: Ein Feld lange drücken bearbeitet es direkt.';

  @override
  String get spotCatEditNeutral =>
      'Tippe auf den Stift, um das Tier zu bearbeiten. Tipp: Ein Feld lange drücken bearbeitet es direkt.';

  @override
  String get spotMapLayers =>
      'Du suchst eine vermisste Katze? Blende Kreise um ihre Aushang-Orte und ihr altes Zuhause ein.';

  @override
  String get spotMapLayersNeutral =>
      'Du suchst ein vermisstes Tier? Blende Kreise um seine Aushang-Orte und sein altes Zuhause ein.';

  @override
  String get spotStraysFlier =>
      'Vermisst-Aushang entdeckt? Fotografiere ihn hier — die App speichert Katze und Kontakt für dich.';

  @override
  String get spotStraysFlierNeutral =>
      'Vermisst-Aushang entdeckt? Fotografiere ihn hier — die App speichert Tier und Kontakt für dich.';

  @override
  String get spotStraysScan =>
      'Manche Aushänge haben einen cat(a)log-QR-Code. Scanne ihn hier und importiere die Katze ohne Tippen.';

  @override
  String get spotStraysScanNeutral =>
      'Manche Aushänge haben einen cat(a)log-QR-Code. Scanne ihn hier und importiere das Tier ohne Tippen.';

  @override
  String get introTitle4 => 'Vermisste Katzen finden';

  @override
  String get introTitle4Neutral => 'Vermisste Tiere finden';

  @override
  String get introBody4 =>
      'Du siehst einen Vermisst-Aushang? Fotografiere ihn in der App: Sie speichert Katze, Besitzerkontakt und Ort. Taucht später ein ähnlicher Streuner auf, schlägt die App mögliche Treffer vor.';

  @override
  String get introBody4Neutral =>
      'Du siehst einen Vermisst-Aushang? Fotografiere ihn in der App: Sie speichert Tier, Besitzerkontakt und Ort. Taucht später ein ähnlicher Streuner auf, schlägt die App mögliche Treffer vor.';

  @override
  String get spotMapSearch =>
      'Gib hier eine Katze, einen Ort oder eine Person ein, um auf der Karte dorthin zu springen.';

  @override
  String get spotMapSearchNeutral =>
      'Gib hier ein Tier, einen Ort oder eine Person ein, um auf der Karte dorthin zu springen.';

  @override
  String get spotCardChips =>
      'Hake an, was auf der teilbaren Karte stehen soll — alles andere bleibt weg.';

  @override
  String get spotCatMenu =>
      'Hier gibt es mehr Aktionen: Katze ausblenden, Duplikate zusammenführen oder eine Sichtung eintragen.';

  @override
  String get spotCatMenuNeutral =>
      'Hier gibt es mehr Aktionen: Tier ausblenden, Duplikate zusammenführen oder eine Sichtung eintragen.';

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
  String get searchNoResultsNeutral => 'Kein Tier mit diesem Namen gefunden';

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

  @override
  String get catalogsTitle => 'Kataloge';

  @override
  String get newCatalog => 'Neuer Katalog';

  @override
  String get intoCatalog => 'In Katalog';

  @override
  String get catalogNameLabel => 'Name des Katalogs';

  @override
  String catalogNameTaken(String name) {
    return 'Einen Katalog namens $name gibt es schon. Wähle einen anderen Namen.';
  }

  @override
  String get manageCatalogs => 'Kataloge verwalten';

  @override
  String get restoreTitle => 'Sicherungen wiederherstellen';

  @override
  String get restoreIntro =>
      'Auf diesem Gerät liegen Sicherungen einer früheren Installation. Jede wird wieder ein Katalog.';

  @override
  String get restoreNone =>
      'Keine Sicherungen auf diesem Gerät gefunden. Wähle Dateien, um von anderswo wiederherzustellen.';

  @override
  String get restoreBackupsMenu => 'Sicherungen wiederherstellen…';

  @override
  String get restorePickFiles => 'Dateien wählen…';

  @override
  String restoreFileLine(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien',
      one: '1 Datei',
    );
    return '$_temp0, neueste $date';
  }

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Kataloge wiederhergestellt.',
      one: '1 Katalog wiederhergestellt.',
      zero: 'Nichts wiederhergestellt.',
    );
    return '$_temp0';
  }

  @override
  String get helpCatalogs =>
      'Ein Katalog ist eine Welt für sich: eigene Katzen, Kolonien, Felder, Fotos und Sync-Partner. Berlin und Paris vermischen sich nie. Tippe auf einen Katalog, um zu ihm zu wechseln. Das Zahnrad an einem Katalog öffnet seine Einstellungen: Name, Katzen oder Tiere, Felder, Autoren und Sperren, Archiv, Zurückgehen, Löschen. Dein Name, deine Sprache und die schon gesehenen Tipps gelten für alle.';

  @override
  String get helpCatalogsNeutral =>
      'Ein Katalog ist eine Welt für sich: eigene Tiere, Haushalte, Felder, Fotos und Sync-Partner. Berlin und Paris vermischen sich nie. Tippe auf einen Katalog, um zu ihm zu wechseln. Das Zahnrad an einem Katalog öffnet seine Einstellungen: Name, Katzen oder Tiere, Felder, Autoren und Sperren, Archiv, Zurückgehen, Löschen. Dein Name, deine Sprache und die schon gesehenen Tipps gelten für alle.';

  @override
  String get helpCatalogSettings =>
      'Alles, was nur zu diesem Katalog gehört: sein Name, ob er Katzen oder Tiere enthält, seine Felder, seine Autoren und Sperren, das Archiv und das Zurückgehen in der Zeit. Änderungen hier betreffen nur diesen Katalog — auch einen, in dem du gerade nicht bist. Löschen schreibt den Katalog zuerst in eine Datei. Dein Schlüssel ist der Code, den Partner neben deinem Namen sehen; er bleibt bei diesem Katalog.';

  @override
  String get spotHomeCatalog =>
      'Das ist der Katalog, in dem du bist. Tippe auf den Namen, um zu wechseln oder einen weiteren anzulegen.';

  @override
  String get deleteCatalog => 'Katalog löschen';

  @override
  String get catalogSettings => 'Katalog-Einstellungen';

  @override
  String deleteCatalogBody(String name) {
    return 'Alles in $name verschwindet: Katzen, Fotos, Verlauf. Vorher wird eine vollständige Datei dort gespeichert, wo auch die automatischen Sicherungen liegen — ihr Import holt den Katalog zurück.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Alles in $name verschwindet: Tiere, Fotos, Verlauf. Vorher wird eine vollständige Datei dort gespeichert, wo auch die automatischen Sicherungen liegen — ihr Import holt den Katalog zurück. Tippe den Namen ein, um zu bestätigen.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name gelöscht. Die Datei liegt in $where.';
  }

  @override
  String typeTheName(String name) {
    return '$name eintippen';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nichts wurde gelöscht: die Katalogdatei ließ sich nicht schreiben ($error). Schaff Platz oder versuch es später noch einmal.';
  }

  @override
  String get moveToCatalog => 'In einen anderen Katalog verschieben';

  @override
  String movedToCatalog(int count, String name) {
    return '$count nach $name verschoben';
  }

  @override
  String get chooseWhatToMove => 'Was soll mit?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Etwas nach $name verschieben?';
  }

  @override
  String get undoThisImport => 'Diesen Import rückgängig machen';

  @override
  String undoImportBody(int count) {
    return 'Die $count Änderung(en) aus diesem Import verschwinden. Vorher werden sie in eine Datei geschrieben; deren Import holt sie zurück. Wer schon synchronisiert hat, behält seine Kopie — das lässt sich nicht zurücknehmen.';
  }

  @override
  String undoneImport(String where) {
    return 'Rückgängig gemacht. Die Datei liegt in $where.';
  }

  @override
  String get goBackTitle => 'Zurück zu einem früheren Stand';

  @override
  String get goBackToHere => 'Hierher zurück';

  @override
  String get momentImport => 'Vor dem Import';

  @override
  String get momentSync => 'Vor dem Synchronisieren';

  @override
  String get momentMerge => 'Vor dem Zusammenführen';

  @override
  String get momentHardDelete => 'Vor dem Löschen der Daten einer Person';

  @override
  String get momentArchive => 'Vor dem Archivieren';

  @override
  String get momentManual => 'Von dir markiert';

  @override
  String get showOlderMoments => 'Ältere zeigen';

  @override
  String goBackBody(int count) {
    return 'Alles nach diesem Moment verschwindet — $count Änderung(en). Vorher wird alles in eine Datei geschrieben; deren Import holt es zurück. Jeder neuere Moment geht mit. Wer schon synchronisiert hat, behält seine Kopie — das lässt sich nicht zurücknehmen.';
  }

  @override
  String get nameThisMoment => 'Diesen Moment benennen';

  @override
  String get helpGoBack =>
      'Die Momente, in denen sich dieser Katalog stark verändert hat: vor jedem Import und jeder Synchronisation, vor einem Zusammenführen, einem Archivieren oder einem Löschen — und immer dann, wenn du selbst einen markiert hast. Wählst du einen aus, kehrt der Katalog dorthin zurück: Alles danach wird in eine Datei geschrieben, die du behältst, und dann entfernt; jeder neuere Moment geht mit. Wer schon synchronisiert hat, behält, was er bekommen hat.';

  @override
  String goBackFileFailed(String error) {
    return 'Es wurde nichts entfernt: die Datei, die es aufbewahrt, ließ sich nicht schreiben ($error). Schaff Platz und versuch es noch einmal.';
  }

  @override
  String get goBackChanged =>
      'Nichts wurde entfernt: Der Katalog hat sich geändert, während die Datei gespeichert wurde. Versuche es noch einmal.';

  @override
  String get switchBeforeDeleting =>
      'Das ist der Katalog, in dem du bist. Wechsle zu einem anderen, dann lösche ihn.';

  @override
  String shareFileFailed(String error) {
    return 'Die Teilen-Datei ließ sich nicht schreiben ($error). Schaff Platz und versuch es noch einmal.';
  }

  @override
  String get privateLabel => 'Privat';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Als privat markieren';

  @override
  String get unmarkPrivate => 'Privat-Markierung entfernen';

  @override
  String get agenda => 'Agenda';

  @override
  String get reminderLabel => 'Erinnerung';

  @override
  String get agendaEmpty =>
      'Keine Termine geplant. Neue Termine planst du hier mit dem Plus oder auf der Seite einer Katze oder Kolonie.';

  @override
  String get agendaEmptyNeutral =>
      'Keine Termine geplant. Neue Termine planst du hier mit dem Plus oder auf der Seite eines Tieres oder Haushalts.';

  @override
  String get dueToday => 'heute fällig';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'in $count Tagen',
      one: 'in 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage überfällig',
      one: '1 Tag überfällig',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Erledigt';

  @override
  String get repeatTitle => 'Wieder in…';

  @override
  String get noRepeatLabel => 'Keine Wiederholung';

  @override
  String get unitDays => 'Tagen';

  @override
  String get unitWeeks => 'Wochen';

  @override
  String get unitMonths => 'Monaten';

  @override
  String get unitYears => 'Jahren';

  @override
  String ageYears(int years) {
    return '$years J.';
  }

  @override
  String ageMonths(int months) {
    return '$months Mon.';
  }

  @override
  String get changeDateLabel => 'Datum ändern';

  @override
  String get removeReminderLabel => 'Erinnerung entfernen';

  @override
  String get exportIcs => 'Kalenderdatei exportieren';

  @override
  String get resyncCalendar => 'Kalender neu abgleichen';

  @override
  String icsSavedTo(String path) {
    return 'Kalenderdatei gespeichert unter $path';
  }

  @override
  String get calendarMirrorLabel => 'In Gerätekalender spiegeln';

  @override
  String get calendarMirrorSubtitle =>
      'Die Termine erscheinen als ganztägige Termine im Kalender. cat(a)log aktualisiert sie dort bei jedem Start und nach jeder Änderung. Erinnerungen an die Termine kannst du im Kalender verwalten.';

  @override
  String get syncPeerOlder =>
      'Das andere Gerät hat ein älteres cat(a)log ohne Erinnerungen. Dort cat(a)log aktualisieren und erneut synchronisieren.';

  @override
  String get syncPeerNewer =>
      'Das andere Gerät hat ein neueres cat(a)log. Auf diesem Gerät cat(a)log aktualisieren und erneut synchronisieren.';

  @override
  String get syncPeerNoTls =>
      'Das andere Gerät hat ein cat(a)log vor 1.1.0, ohne verschlüsselten Sync. Dort cat(a)log aktualisieren und erneut synchronisieren.';

  @override
  String get syncWrongHost =>
      'Das Zertifikat passt nicht zum Pair-Code — das ist nicht das Gerät, von dem der Code stammt. Code erneut scannen oder eintippen.';

  @override
  String get bundleNewerError =>
      'Diese Datei stammt aus einem neueren cat(a)log. Auf diesem Gerät cat(a)log aktualisieren, um sie zu importieren.';

  @override
  String get spotEar =>
      'Ein kleines Katzenohr in einer Ecke heißt: gedrückt halten für mehr.';

  @override
  String get addReminder => 'Erinnerung hinzufügen';

  @override
  String get plannedSection => 'Geplant';

  @override
  String get reminderDialogHint =>
      'Der Termin wird in der Agenda angezeigt. Dort kannst du ihn bestätigen oder verwerfen. Der Wert wird nur übernommen, wenn der Termin bestätigt wurde.';

  @override
  String get reminderFor => 'Für';

  @override
  String get reminderField => 'Feld';

  @override
  String get dueDateLabel => 'Fälligkeitsdatum';

  @override
  String get pickCalendar => 'Welcher Kalender?';

  @override
  String get calendarPermissionDenied =>
      'Der Kalenderzugriff ist blockiert, deshalb ist die Spiegelung aus. Erlaube ihn in den Systemeinstellungen und schalte die Spiegelung wieder ein.';

  @override
  String get calendarNotChosen =>
      'Kein Kalender gewählt, deshalb ist die Spiegelung aus. Schalte sie wieder ein und wähle einen.';

  @override
  String get calendarGone =>
      'Der gewählte Kalender existiert nicht mehr, deshalb ist die Spiegelung aus. Schalte sie wieder ein und wähle einen anderen.';

  @override
  String get noWritableCalendar =>
      'Kein Kalender gefunden. Melde dich in den Systemeinstellungen bei einem Kalenderkonto an, zum Beispiel Google, und versuche es erneut.';

  @override
  String get spotHomeAgenda =>
      'Agenda: die Liste der geplanten Termine — Tierarzt, Medikamente, Kontrollen.';

  @override
  String get spotAgendaAdd => 'Einen neuen Termin planen.';

  @override
  String get spotAgendaCalendar =>
      'Aktiviere hier die Spiegelung der cat(a)log-Termine in einen ausgesuchten Kalender.';

  @override
  String get spotAgendaToday =>
      'Die Aufgaben von heute: abhaken, wenn erledigt. Die Punkte zeigen die letzten sieben Tage.';

  @override
  String get helpAgenda =>
      'Die Agenda listet die geplanten Termine nach Datum. Es gibt zwei Arten: Termine mit Uhrzeit und Erinnerungen, die für einen Tag gelten. Verpasste Termine bleiben oben stehen. Tippen öffnet die Katze oder Kolonie. Der Haken bestätigt einen Termin: Der Wert wird ins Feld geschrieben, und du kannst gleich den nächsten Termin planen, zum Beispiel in drei Monaten. Gedrückt halten ändert das Datum oder löscht den Termin. Mit dem Schalter oben werden die Termine in einen Kalender deines Telefons gespiegelt. Über das Menü lassen sie sich als Kalenderdatei exportieren. Ein Tierarztbesuch mit mehreren Katzen ist ein Termin: Katzen darin anhaken, die Agenda zeigt eine Karte mit ihren Namen, und beim Abschließen wird gefragt, welche Katzen behandelt wurden — nicht behandelte abhaken, sie bleiben geplant. Aufgaben sind die wiederkehrenden Pflichten wie Füttern, Katzenklo oder Medizin. Sie stehen unter Heute mit Haken, Serie und den letzten sieben Tagen als Punkte; Demnächst zeigt die nächste Woche ohne die täglichen. Eine Aufgabe kann zur gewählten Uhrzeit per Benachrichtigung erinnern. Der Pokal öffnet die Erfolge.';

  @override
  String get helpAgendaNeutral =>
      'Die Agenda listet die geplanten Termine nach Datum. Es gibt zwei Arten: Termine mit Uhrzeit und Erinnerungen, die für einen Tag gelten. Verpasste Termine bleiben oben stehen. Tippen öffnet das Tier oder den Haushalt. Der Haken bestätigt einen Termin: Der Wert wird ins Feld geschrieben, und du kannst gleich den nächsten Termin planen, zum Beispiel in drei Monaten. Gedrückt halten ändert das Datum oder löscht den Termin. Mit dem Schalter oben werden die Termine in einen Kalender deines Telefons gespiegelt. Über das Menü lassen sie sich als Kalenderdatei exportieren. Ein Tierarztbesuch mit mehreren Tieren ist ein Termin: Tiere darin anhaken, die Agenda zeigt eine Karte mit ihren Namen, und beim Abschließen wird gefragt, welche Tiere behandelt wurden — nicht behandelte abhaken, sie bleiben geplant. Aufgaben sind die wiederkehrenden Pflichten wie Füttern, Katzenklo oder Medizin. Sie stehen unter Heute mit Haken, Serie und den letzten sieben Tagen als Punkte; Demnächst zeigt die nächste Woche ohne die täglichen. Eine Aufgabe kann zur gewählten Uhrzeit per Benachrichtigung erinnern. Der Pokal öffnet die Erfolge.';

  @override
  String get calendarRowOff => 'Kalender: aus';

  @override
  String calendarRowOn(String name) {
    return 'Kalender: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Einen Termin für diese Katze planen. Der Termin wird in der Agenda angezeigt und kann dort bestätigt werden.';

  @override
  String get spotAddReminderCatNeutral =>
      'Einen Termin für dieses Tier planen. Der Termin wird in der Agenda angezeigt und kann dort bestätigt werden.';

  @override
  String get spotAddReminderClowder =>
      'Einen Termin für diese Kolonie planen. Der Termin wird in der Agenda angezeigt und kann dort bestätigt werden.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Einen Termin für diesen Haushalt planen. Der Termin wird in der Agenda angezeigt und kann dort bestätigt werden.';

  @override
  String get readOnlyCalendar => 'nur lesen';

  @override
  String get appointmentLabel => 'Termin';

  @override
  String get addAppointment => 'Termin hinzufügen';

  @override
  String get planChooserTitle => 'Termin oder Erinnerung?';

  @override
  String get planChooserAppointment =>
      'Termin — ein Besuch an einem Datum mit Uhrzeit und Notizen';

  @override
  String get planChooserReminder =>
      'Erinnerung — ein Wert, der an einem Tag fällig wird';

  @override
  String get planChooserChore =>
      'Aufgabe — etwas, das wiederkehrt: Füttern, Tropfen, Katzenklo';

  @override
  String get newChore => 'Neue Aufgabe';

  @override
  String get choreEdit => 'Aufgabe bearbeiten';

  @override
  String get choreTitleLabel => 'Was';

  @override
  String get choreRepeatDaily => 'Täglich';

  @override
  String get choreRepeatEvery => 'Alle…';

  @override
  String get choreRepeatWeekdays => 'Wochentage';

  @override
  String choreEveryDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'alle $n Tage',
      one: 'jeden Tag',
    );
    return '$_temp0';
  }

  @override
  String choreEveryWeeks(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'alle $n Wochen',
      one: 'jede Woche',
    );
    return '$_temp0';
  }

  @override
  String choreEveryMonths(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'alle $n Monate',
      one: 'jeden Monat',
    );
    return '$_temp0';
  }

  @override
  String choreEveryYears(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'alle $n Jahre',
      one: 'jedes Jahr',
    );
    return '$_temp0';
  }

  @override
  String get choreNoTime => 'Egal wann am Tag';

  @override
  String get chorePause => 'Pausieren';

  @override
  String get chorePaused => 'Pausiert';

  @override
  String get choreResume => 'Fortsetzen';

  @override
  String get choreEnd => 'Aufgabe beenden';

  @override
  String get choreHistory => 'Verlauf';

  @override
  String choreDoneAt(Object when, Object who) {
    return 'erledigt $when · $who';
  }

  @override
  String get choreDoneEarly => 'früher';

  @override
  String get choreDoneLate => 'später';

  @override
  String get choreMissed => 'Verpasst';

  @override
  String get choreStillOpen => 'Noch offen';

  @override
  String get choreEndConfirm =>
      'Die Aufgabe verschwindet aus der Liste. Was abgehakt wurde, bleibt in der Historie.';

  @override
  String get todaySection => 'Heute';

  @override
  String get upcomingSection => 'Demnächst';

  @override
  String get allDoneToday => 'Heute: alles erledigt';

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Tage in Folge',
      one: '1 Tag in Folge',
    );
    return '$_temp0';
  }

  @override
  String choreDue(String date) {
    return 'Fällig $date';
  }

  @override
  String get remindMe => 'Erinnere mich';

  @override
  String remindNext(Object when) {
    return 'Nächste Erinnerung: $when';
  }

  @override
  String get remindNone => 'Keine Erinnerung geplant: nichts steht an.';

  @override
  String remindPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Erinnerungen auf diesem Telefon geplant',
      one: '1 Erinnerung auf diesem Telefon geplant',
      zero: 'Noch nichts auf diesem Telefon geplant',
    );
    return '$_temp0';
  }

  @override
  String get remindTest => 'Jetzt eine Test-Erinnerung senden';

  @override
  String get remindLateHint =>
      'Erinnerungen können ein paar Minuten später kommen; das Telefon bestimmt den genauen Moment.';

  @override
  String get remindPermissionDenied =>
      'Keine Berechtigung für Benachrichtigungen, die Erinnerung bleibt aus. Erlaube sie in den App-Einstellungen des Telefons und versuche es erneut.';

  @override
  String get batteryHint =>
      'Bleiben Erinnerungen aus, erlaube cat(a)log in den Akku-Einstellungen des Telefons, im Hintergrund zu laufen.';

  @override
  String get batterySettings => 'Akku-Einstellungen';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String get rankServant => 'Diener';

  @override
  String get rankButler => 'Butler';

  @override
  String get rankSteward => 'Verwalter';

  @override
  String get rankChancellor => 'Kanzler';

  @override
  String get rankMinister => 'Minister';

  @override
  String titleWithChore(Object title, Object chore) {
    return '$title ($chore)';
  }

  @override
  String get coatCalico => 'Glückskatze';

  @override
  String get coatCheetah => 'Gepard';

  @override
  String get coatTiger => 'Tiger';

  @override
  String get coatTabby => 'Getigert';

  @override
  String get coatPaws => 'Pfoten';

  @override
  String get coatRosettes => 'Rosetten';

  @override
  String get coatZebra => 'Zebra';

  @override
  String get coatSetting => 'Fell';

  @override
  String get coatRandom => 'Bei jedem Start ein anderes';

  @override
  String get coatSnowLeopard => 'Schneeleopard';

  @override
  String get coatSiamese => 'Siam-Abzeichen';

  @override
  String get coatLynx => 'Luchs';

  @override
  String get coatTortoiseshell => 'Schildpatt';

  @override
  String coatUnlocked(Object coat) {
    return 'Neues Fell: $coat';
  }

  @override
  String get coatUnlockedHow => 'Ein voller Monat Aufgaben, alle erledigt.';

  @override
  String get achievementsEmpty =>
      'Noch nichts verdient. Die Aufgaben kennen den Weg.';

  @override
  String get achievementMonth => 'Ein voller Monat';

  @override
  String get achievementYear => 'Ein volles Jahr';

  @override
  String get achievementDecade => 'Ein volles Jahrzehnt';

  @override
  String get achievementCentury => 'Ein volles Jahrhundert';

  @override
  String get achievementCenturyHint => 'Wir werden beide sehr stolz sein.';

  @override
  String achievementMaster(String title) {
    return '$title-Meister';
  }

  @override
  String achievementReached(int times, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times-mal erreicht',
      one: 'Einmal erreicht',
    );
    return '$_temp0, zuerst am $date';
  }

  @override
  String achievementNext(int n) {
    return 'Nächste Stufe bei $n';
  }

  @override
  String get achievementLocked => 'Noch nicht';

  @override
  String achievementUnlocked(String name) {
    return 'Erfolg: $name';
  }

  @override
  String get appointmentTitleLabel => 'Was';

  @override
  String get notesLabel => 'Notizen';

  @override
  String get timeLabel => 'Uhrzeit';

  @override
  String get allDayLabel => 'Ganztägig';

  @override
  String get alertLabel => 'Erinnerung';

  @override
  String get alertNone => 'Keine';

  @override
  String get alertDayBefore => 'Am Tag davor';

  @override
  String get alertHourBefore => 'Eine Stunde davor';

  @override
  String get linkFieldLabel => 'Beim Erledigen in ein Feld schreiben';

  @override
  String get noLinkedField => 'Kein Feld';

  @override
  String get outcomeTitle => 'Wie war es?';

  @override
  String get finishLabel => 'Erledigen';

  @override
  String get editLabelAppointment => 'Termin bearbeiten';

  @override
  String get deleteAppointment => 'Termin löschen';

  @override
  String get stepFlierText => 'Text des Aushangs';

  @override
  String get qrFoundHint =>
      'Auf dem Aushang wurde ein QR-Code gefunden. Angehakte Codes werden nach Registernummern und Links ausgelesen.';

  @override
  String get useCode => 'Diesen Code verwenden';

  @override
  String get qrNone => 'Kein QR-Code auf dem Foto gefunden.';

  @override
  String qrFailed(String error) {
    return 'QR-Code lesen fehlgeschlagen: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$name-Aushang erkannt. Prüfe unten, in welches Feld jede Zeile kommt.';
  }

  @override
  String get flierLayoutUnknown =>
      'Unbekanntes Aushang-Layout. Ordne die Zeilen unten Feldern zu; der Rest bleibt in den Bemerkungen.';

  @override
  String get targetRegistryNumber => 'Registernummer';

  @override
  String get targetLostPlace => 'Adresse (Verlustort)';

  @override
  String get targetContact => 'Kontakt des Registers';

  @override
  String get targetDrop => 'Verwerfen';

  @override
  String get existingCat => 'Vorhandene Katze';

  @override
  String get existingCatNeutral => 'Vorhandenes Tier';

  @override
  String get existingClowder => 'Vorhandene Kolonie';

  @override
  String get existingClowderNeutral => 'Vorhandener Haushalt';

  @override
  String get createNewInstead => 'Keine — neu anlegen';

  @override
  String overwritesValue(String value) {
    return 'Überschreibt aktuellen Wert \"$value\"';
  }

  @override
  String get abortScanTitle => 'Erfassung abbrechen?';

  @override
  String get abortScanBody => 'Es wird nichts gespeichert.';

  @override
  String get abortScan => 'Abbrechen';

  @override
  String get keepScanning => 'Weitermachen';

  @override
  String get catsOnAppointment => 'Katzen bei diesem Termin';

  @override
  String get catsOnAppointmentNeutral => 'Tiere bei diesem Termin';

  @override
  String get noCatsHint =>
      'Keine Katze angehakt — der Termin gehört der Kolonie selbst.';

  @override
  String get noCatsHintNeutral =>
      'Kein Tier angehakt — der Termin gehört dem Haushalt selbst.';

  @override
  String get pickCatsTitle => 'Welche Katzen kommen mit?';

  @override
  String get pickCatsTitleNeutral => 'Welche Tiere kommen mit?';

  @override
  String catsCount(int count) {
    return '$count Katzen';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count Tiere';
  }

  @override
  String get finishUntickHint =>
      'Hake die Katzen ab, die nicht behandelt wurden; sie bleiben geplant.';

  @override
  String get finishUntickHintNeutral =>
      'Hake die Tiere ab, die nicht behandelt wurden; sie bleiben geplant.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Termin für alle $count Katzen löschen';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Termin für alle $count Tiere löschen';
  }

  @override
  String get correctThisValue => 'Diesen Wert korrigieren';

  @override
  String get removeThisValue => 'Diesen Wert entfernen';

  @override
  String get restoreThisValue => 'Diesen Wert wiederherstellen';

  @override
  String get showRemovedValues => 'Entfernte Werte anzeigen';

  @override
  String get hideRemovedValues => 'Entfernte Werte ausblenden';

  @override
  String entryRemovedBy(Object who, Object when) {
    return 'Entfernt · $who · $when';
  }

  @override
  String entryReplacedBy(Object value, Object who, Object when) {
    return 'Ersetzt durch $value · $who · $when';
  }

  @override
  String get entryCorrection => 'Korrektur';

  @override
  String get restorePickFolder => 'Sicherungsordner wählen…';

  @override
  String get restoreAndroidHint =>
      'Die Sicherungen der vorherigen Installation liegen in Documents/catlog (bei älteren Versionen Downloads/catlog). Wähle diesen Ordner einmal; seine Sicherungen erscheinen hier.';

  @override
  String get backupsTitle => 'Sicherungen';

  @override
  String get backupsSubtitle => 'Wo deine Kataloge gesichert sind';

  @override
  String get backupsAndroidSystem =>
      'Google sichert die Kataloge dieser App mit deinem Konto, ohne Fotos. Nach einer Neuinstallation oder auf einem neuen Handy kommen sie von selbst zurück.';

  @override
  String get backupsAndroidFiles =>
      'Eine vollständige Kopie jedes Katalogs, mit Fotos, wird in Documents/catlog geschrieben, sobald du die App nach Änderungen verlässt.';

  @override
  String get backupsIosSystem =>
      'Das iCloud-Backup enthält diese App mit ihren Katalogen und Fotos, wie jede andere App auf diesem iPhone.';

  @override
  String get backupsIosFiles =>
      'Eine vollständige Kopie jedes Katalogs liegt in der Dateien-App unter cat(a)log. Von dort kann sie nach iCloud Drive, per AirDrop oder auf ein anderes Handy.';

  @override
  String get backupsDesktopFiles =>
      'Eine vollständige Kopie jedes Katalogs, mit Fotos, wird in deinen Downloads-Ordner geschrieben, sobald du die App nach Änderungen verlässt.';

  @override
  String backupsLast(Object date) {
    return 'Letzte Kopie: $date';
  }

  @override
  String get backupsNever => 'Noch keine Kopie geschrieben.';

  @override
  String get backupsNow => 'Jetzt sichern';

  @override
  String get backupsDone => 'Kopie geschrieben.';

  @override
  String backupsRestoredNote(Object date) {
    return 'Am $date aus der Google-Sicherung wiederhergestellt. Läuft cat(a)log noch auf dem alten Handy, gleiche einmal von dort ab und entferne die App dann dort.';
  }
}
