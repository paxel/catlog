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
      'Die Katze verschwindet aus allen Listen und ihre Fotos werden entfernt — hier und nach der nächsten Synchronisierung auch auf den anderen Geräten.';

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
  String get privateNoShare =>
      'Diese Katze ist als privat markiert — private Daten verlassen dein Gerät nie. Hebe die Markierung auf, um sie öffentlich zu teilen.';

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
  String get genderFatherFemale =>
      'Diese Katze ist als Vater anderer Katzen eingetragen — der Vater kann nicht weiblich sein. Prüfe zuerst die Familie.';

  @override
  String get genderMotherMale =>
      'Diese Katze ist als Mutter anderer Katzen eingetragen — die Mutter kann nicht männlich sein. Prüfe zuerst die Familie.';

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
      'Beide Geräte nutzen denselben Ordner (z. B. in Dropbox oder auf einem USB-Stick). Beim Synchronisieren landen deine Änderungen dort und die der anderen Seite kommen zu dir.';

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
  String get stepOwner => 'Besitzer';

  @override
  String get stepFace => 'Profilbild';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Prüfen und speichern';

  @override
  String get stepOwnerHint =>
      'Wer die Katze vermisst — daraus wird deren Karte, mit dem Kontakt vom Aushang.';

  @override
  String get stepFaceHint =>
      'Schneide das Gesicht der Katze aus dem Aushang aus; es wird zum Profilbild. Kannst du auch überspringen.';

  @override
  String get stepRegistryHint =>
      'Nummern vom Aushang. Angehakte werden bei der Katze gespeichert und lassen sich später öffnen.';

  @override
  String get noRegistryLinks =>
      'Keine Register-Links auf diesem Aushang — hier ist nichts zu tun.';

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
      'Die Übersicht deiner Kolonien — eine Kolonie ist ein Ort, an dem Katzen leben: dein Zuhause, eine Pflegestelle, ein Tierheim. Tippe auf eine Karte, um ihre Katzen zu sehen; langes Drücken öffnet das Menü. Der Knopf unten rechts legt eine neue Kolonie an, und die Streuner-Karte sammelt alle Katzen ohne Zuhause.';

  @override
  String get helpClowder =>
      'Alles zu diesem Ort: seine Katzen, seine Felder (Adresse, Kontakt, Art) und seine Historie. Die Seite ist erst nur zum Lesen; der Stift schaltet das Bearbeiten ein, dort kannst du auch ein neues Feld anlegen. Ein Feld lange drücken bearbeitet es direkt, eine Katze lange drücken verschiebt, versteckt oder öffnet sie.';

  @override
  String get helpCat =>
      'Alles zu dieser Katze: Fotos, Felder, Familie, Historie. Die Seite ist nur zum Lesen, bis du den Stift antippst. Ein Feld lange drücken springt direkt in dessen Bearbeitung; ein Foto lange drücken öffnet sein Menü. Im Menü oben rechts steckt der Rest: privat markieren, ausblenden, zusammenführen, Sichtung eintragen, Katze teilen.';

  @override
  String get helpStrays =>
      'Katzen, die gerade kein Zuhause haben: Fundkatzen, entlaufene Katzen, Katzen von einem Aushang. Der Kamera-Knopf hält eine Katze fest, die vor dir sitzt; der Aushang-Knopf macht aus einem Vermisst-Plakat eine Katze samt Besitzer-Kontakt; der Scanner liest einen cat(a)log-Code vom Plakat.';

  @override
  String get helpMap =>
      'Alle Katzen und Orte mit Position. Die Suche findet Katzen, Personen und Orte — einen unbekannten Namen sucht sie weltweit. Der Ebenen-Knopf zeichnet die 500-m-Kreise um die Aushang-Orte einer vermissten Katze und um ihr altes Zuhause. Die Pfeile laufen von Pin zu Pin, langes Drücken auf die Karte trägt eine Sichtung ein.';

  @override
  String get helpCard =>
      'Die druckbare Karte dieser Katze: Oben wählst du mit den Chips aus, was daraufsteht, dann teilst du sie als Bild oder PDF. IDs können als QR-Code oder Barcode gedruckt werden, und aus einer Position wird ein QR-Code, der eine Karte öffnet, plus ein kurzer Plus Code.';

  @override
  String get helpSync =>
      'So kommen Daten zu anderen Leuten: direkt verbinden, wenn ihr euch trefft, einen Ordner nutzen, den beide Geräte sehen, oder eine Datei per Messenger schicken. Du entscheidest immer, was rausgeht — und empfangene .catsync-Dateien öffnest du auch hier.';

  @override
  String get helpFields =>
      'Die Felder, die dein Katalog benutzt. Benenne sie um, ändere die Auswahlmöglichkeiten eines Auswahlfeldes oder leg eigene an. ID-Felder können auf einen Dienst (ein Register) zeigen, dann lässt sich die Nummer bei der Katze antippen.';

  @override
  String get helpTimeline =>
      'Jede jemals gemachte Änderung, neueste zuerst: wer wann was auf welchen Wert geändert hat. Jeder Eintrag lässt sich zurücknehmen — das schreibt einen neuen Eintrag, gelöscht wird nie etwas.';

  @override
  String get helpDuplicates =>
      'Katzen oder Kolonien, die zweimal dieselben zu sein scheinen — gleiche IDs oder sehr ähnliche Namen mit passenden Details. Tippe ein Paar an, um es zusammenzuführen; das lässt sich nicht rückgängig machen, deshalb wird vorher gefragt.';

  @override
  String get helpMatches =>
      'Katzen, die dasselbe Tier sein könnten: gleiche ID oder ein Streuner, der im Suchgebiet einer vermissten Katze gesehen wurde. Tippe ein Paar an, um es zusammenzuführen, langes Drücken öffnet die erste Katze zum Vergleichen.';

  @override
  String get helpFlier =>
      'Aus einem fotografierten Vermisst-Aushang wird eine Katze samt Besitzer. Schritt für Schritt: Daten der Katze, Kontakt des Besitzers, Gesicht ausschneiden fürs Profilbild, Register-Nummern vom Aushang, dann die letzte Kontrolle. Alles sind Vorschläge — korrigiere, was die Kamera falsch gelesen hat.';

  @override
  String get locateAddress => 'Adresse auf der Karte suchen';

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
      'Damit wird auch alles gesendet, was du als privat markiert hast. Wer mit dir synchronisiert, sieht es dann.';

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
      'Alles als eine Datei über einen Messenger senden — und eine empfangene .catsync-Datei hier importieren';

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
  String get introTitle1 => 'Deine Katzen im Blick';

  @override
  String get introBody1 =>
      'Lege für jede Katze eine Karte an: Foto, Geschlecht, Gesundheit, alles was du festhalten willst. Katzen sind danach gruppiert, wo sie leben — so einen Ort nennt die App Kolonie.';

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
  String get spotHomeMenu =>
      'In diesem Menü: doppelte Einträge finden und zusammenführen, CSV exportieren und mehr.';

  @override
  String get spotCatEdit =>
      'Tippe auf den Stift, um die Katze zu bearbeiten. Tipp: Ein Feld lange drücken bearbeitet es direkt.';

  @override
  String get spotMapLayers =>
      'Du suchst eine vermisste Katze? Blende Kreise um ihre Aushang-Orte und ihr altes Zuhause ein.';

  @override
  String get spotStraysFlier =>
      'Vermisst-Aushang entdeckt? Fotografiere ihn hier — die App speichert Katze und Kontakt für dich.';

  @override
  String get spotStraysScan =>
      'Manche Aushänge haben einen cat(a)log-QR-Code. Scanne ihn hier und importiere die Katze ohne Tippen.';

  @override
  String get introTitle4 => 'Vermisste Katzen finden';

  @override
  String get introBody4 =>
      'Du siehst einen Vermisst-Aushang? Fotografiere ihn in der App: Sie speichert Katze, Besitzerkontakt und Ort. Taucht später ein ähnlicher Streuner auf, schlägt die App mögliche Treffer vor.';

  @override
  String get spotMapSearch =>
      'Gib hier eine Katze, einen Ort oder eine Person ein, um auf der Karte dorthin zu springen.';

  @override
  String get spotCardChips =>
      'Hake an, was auf der teilbaren Karte stehen soll — alles andere bleibt weg.';

  @override
  String get spotCatMenu =>
      'Hier gibt es mehr Aktionen: Katze privat markieren, ausblenden, Duplikate zusammenführen oder eine Sichtung eintragen.';

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
