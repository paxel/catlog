// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Bun venit în cat(a)log';

  @override
  String get welcomeBody =>
      'Alege-ți un nume. Fiecare modificare se înregistrează sub acest nume, ca ceilalți să vadă cine a făcut ce.';

  @override
  String get yourName => 'Numele tău';

  @override
  String get start => 'Începe';

  @override
  String get clowders => 'Clowdere';

  @override
  String get noClowdersYet =>
      'Încă nu există clowdere.\nCreează-l pe primul mai jos.';

  @override
  String get strays => 'Pisici fără stăpân';

  @override
  String get searchCats => 'Caută pisici';

  @override
  String get map => 'Hartă';

  @override
  String get sync => 'Sincronizare';

  @override
  String get fields => 'Câmpuri';

  @override
  String get exportCsv => 'Exportă CSV';

  @override
  String get aboutAndFeedback => 'Despre & feedback';

  @override
  String get newClowder => 'Clowder nou';

  @override
  String get name => 'Nume';

  @override
  String get cancel => 'Anulează';

  @override
  String get create => 'Creează';

  @override
  String get save => 'Salvează';

  @override
  String get delete => 'Șterge';

  @override
  String get merge => 'Îmbină';

  @override
  String get resolve => 'Decide';

  @override
  String get open => 'Deschide';

  @override
  String csvSavedTo(String path) {
    return 'CSV salvat în $path';
  }

  @override
  String get renameClowder => 'Redenumește clowderul';

  @override
  String get rename => 'Redenumește';

  @override
  String get timeline => 'Cronologie';

  @override
  String get mergeInto => 'Îmbină cu…';

  @override
  String get deleteClowder => 'Șterge clowderul';

  @override
  String get cats => 'Pisici';

  @override
  String get addCat => 'Adaugă pisică';

  @override
  String get newCat => 'Pisică nouă';

  @override
  String deleteQuestion(String name) {
    return 'Ștergi $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowderul dispare din listă.';

  @override
  String deleteClowderBody(int count) {
    return 'Cele $count pisici ale lui nu se șterg — devin fără stăpân. Mută-le întâi în alt clowder dacă nu asta vrei.';
  }

  @override
  String get card => 'Fișă';

  @override
  String get shareAsImage => 'Distribuie ca imagine';

  @override
  String get shareAsPdf => 'Distribuie ca PDF';

  @override
  String get print => 'Tipărește';

  @override
  String cardTitle(String name) {
    return 'Fișă — $name';
  }

  @override
  String get renameCat => 'Redenumește pisica';

  @override
  String get seenHereNow => 'Văzută aici acum';

  @override
  String get deleteCat => 'Șterge pisica';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Fără stăpân — fără clowder';

  @override
  String get stray => 'Fără stăpân';

  @override
  String get photos => 'Poze';

  @override
  String get addPhoto => 'Adaugă poză';

  @override
  String get setAsProfileImage => 'Setează ca poză de profil';

  @override
  String get thisIsProfileImage => 'Aceasta este poza de profil';

  @override
  String get deletePhoto => 'Șterge poza';

  @override
  String get deletePhotoTitle => 'Ștergi poza?';

  @override
  String get deletePhotoBody =>
      'Datele pozei se șterg definitiv — nu se poate anula.';

  @override
  String get deleteCatBody =>
      'Pisica dispare din toate listele. Pozele ei se șterg definitiv.';

  @override
  String get sightingRecorded => 'Observație înregistrată la poziția ta.';

  @override
  String get noLocationAvailable =>
      'Locație indisponibilă — apasă lung pe hartă în schimb.';

  @override
  String get locationDeniedForever =>
      'Location access is blocked. Allow it in the system settings to use Stray Cam.';

  @override
  String get openSettings => 'Open settings';

  @override
  String get moveTo => 'Mută în';

  @override
  String get noClowderStrayOption => 'Fără clowder — fără stăpân / a fugit';

  @override
  String timelineOf(String name) {
    return 'Cronologie — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Anulează această modificare';

  @override
  String get revertSubtitle =>
      'Restaurează valoarea anterioară ca înregistrare nouă — istoricul le păstrează pe ambele.';

  @override
  String fieldCleared(String field) {
    return '$field golit';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field înapoi la \"$value\"';
  }

  @override
  String get leftStray => 'A plecat — fără stăpân';

  @override
  String movedTo(String name) {
    return 'Mutată în $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat a sosit';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat a sosit din $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat a plecat în $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicat îmbinat';

  @override
  String get asOfToday => 'Cu data de azi';

  @override
  String asOfDate(String date) {
    return 'Cu data $date';
  }

  @override
  String get value => 'Valoare';

  @override
  String get latitudeLongitude => 'latitudine, longitudine';

  @override
  String get newField => 'Câmp nou';

  @override
  String get fieldType => 'Tip';

  @override
  String get usedOn => 'Folosit pentru';

  @override
  String get forCats => 'pisici';

  @override
  String get forClowders => 'clowdere';

  @override
  String get forBoth => 'ambele';

  @override
  String get optionsOnePerLine => 'Opțiuni (una pe linie)';

  @override
  String get ownValue => 'Own value';

  @override
  String get renameField => 'Redenumește câmpul';

  @override
  String get noStraysRightNow => 'Nicio pisică fără stăpân momentan.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Adaugă fără stăpân';

  @override
  String get newStray => 'Pisică fără stăpân nouă';

  @override
  String get searchByNameHint => 'Caută pisici după nume…';

  @override
  String get host => 'Găzduiește';

  @override
  String get hostExplainer =>
      'Începe aici, apoi introdu adresa și PIN-ul pe celălalt dispozitiv.';

  @override
  String get startHosting => 'Pornește găzduirea';

  @override
  String get stopHosting => 'Oprește găzduirea';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Sesiuni până acum: $count';
  }

  @override
  String get join => 'Alătură-te';

  @override
  String get addressFromHost => 'Adresa (de pe dispozitivul gazdă)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sincronizează acum';

  @override
  String get addressFormatHint =>
      'Adresa trebuie să arate ca 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sincronizat: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sincronizare eșuată: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Ultima sincronizare cu $peer: $time';
  }

  @override
  String get sharedFolder => 'Dosar partajat';

  @override
  String get sharedFolderExplainer =>
      'Sincronizează printr-un dosar purtat între dispozitive de un cloud sau un stick USB — pentru cei care nu sunt în aceeași rețea.';

  @override
  String get noFolderChosenYet => 'Niciun dosar ales încă';

  @override
  String get choose => 'Alege…';

  @override
  String get syncFolderNow => 'Sincronizează dosarul acum';

  @override
  String folderSynced(String result) {
    return 'Dosar sincronizat: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sincronizarea dosarului a eșuat: $error';
  }

  @override
  String get recordSightingHere => 'Înregistrează o observație aici:';

  @override
  String trailOf(String name, int count) {
    return 'Traseu: $name ($count observații)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflict — $field';
  }

  @override
  String get conflictBody =>
      'Modificat în două locuri deodată. Alege ce e adevărat:';

  @override
  String mergeThisInto(String kind) {
    return 'Îmbină acest $kind cu…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Niciun alt $kind cu care să îmbini.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Îmbini cu $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Cele două înregistrări devin una. $name își păstrează valorile actuale; istoricul celeilalte i se alătură. Nu se poate anula.';
  }

  @override
  String get kindCat => 'pisică';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'câmp';

  @override
  String get takePhoto => 'Fă o poză';

  @override
  String get chooseFromGallery => 'Alege din galerie';

  @override
  String get about => 'Despre';

  @override
  String get aboutTagline =>
      'Un catalog local pentru pisici în plasament. Datele tale rămân pe dispozitivele tale — fără server, fără cont.';

  @override
  String versionLabel(String version, String build) {
    return 'Versiunea $version ($build)';
  }

  @override
  String get sourceCode => 'Cod sursă';

  @override
  String get reportProblemOrIdea => 'Raportează o problemă sau o idee';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Scrie-i dezvoltatorului';

  @override
  String get buyCoffee => 'Fă-i cinste dezvoltatorului cu o cafea';

  @override
  String get coffeeSubtitle => 'Complet opțional — aplicația e gratuită';

  @override
  String get openSourceLicenses => 'Licențe open source';

  @override
  String get machineTranslated =>
      'Traducerile sunt automate — corecturile sunt binevenite pe GitHub.';

  @override
  String get unnamed => '(fără nume)';

  @override
  String get labelName => 'Nume';

  @override
  String get labelProfileImage => 'Poză de profil';

  @override
  String get labelPhoto => 'Poză';

  @override
  String get starterGender => 'Sex';

  @override
  String get starterBreed => 'Breed';

  @override
  String get valueMixed => 'mixed';

  @override
  String get starterColor => 'Culoare';

  @override
  String get starterNeutered => 'Sterilizată';

  @override
  String get starterPregnant => 'Gestantă';

  @override
  String get starterBirthdate => 'Data nașterii';

  @override
  String get starterDeceased => 'Decedată';

  @override
  String get starterAddress => 'Adresă';

  @override
  String get starterResponsible => 'Persoană responsabilă';

  @override
  String get starterPosition => 'Poziție';

  @override
  String get valueYes => 'da';

  @override
  String get valueNo => 'nu';

  @override
  String get valueFemale => 'femelă';

  @override
  String get valueMale => 'mascul';

  @override
  String get valueUnknown => 'necunoscut';

  @override
  String get cropTitle => 'Decupează poza';

  @override
  String get markTitle => 'Marchează pisica';

  @override
  String get applyCrop => 'Crop';

  @override
  String get useFullPhoto => 'Folosește toată poza';

  @override
  String get dragToSelect => 'Trage un dreptunghi în jurul pisicii';

  @override
  String get dragOverTheCat => 'Trage o elipsă peste pisică';

  @override
  String get cropPhoto => 'Decupează…';

  @override
  String get markPhoto => 'Marchează…';

  @override
  String get scanCode => 'Scanează codul';

  @override
  String get orTypeCode => 'Sau tastează codul';

  @override
  String get copyCode => 'Copiază codul';

  @override
  String get copied => 'Copiat';

  @override
  String get invalidCode => 'Codul nu este valid';

  @override
  String get hotspotHint =>
      'Fără Wi-Fi comun? Pornește hotspotul unui telefon, conectează-l pe celălalt și găzduiește aici.';

  @override
  String get byMessenger => 'Prin messenger';

  @override
  String get byMessengerExplainer =>
      'Trimite tot catalogul ca un singur fișier prin WhatsApp, Signal sau mail — cealaltă parte îl importă.';

  @override
  String get shareBundle => 'Partajează pachetul de sincronizare…';

  @override
  String get importBundle => 'Importă pachetul de sincronizare…';

  @override
  String bundleImported(String result) {
    return 'Pachet importat: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import eșuat: $error';
  }

  @override
  String get pickOnMap => 'Alege pe hartă';

  @override
  String get useMyLocation => 'Folosește locația mea';

  @override
  String get language => 'Limbă';

  @override
  String get systemDefault => 'Implicit sistem';

  @override
  String get iosLocalNetworkHint =>
      'Dacă tot eșuează pe iPhone/iPad: Configurări → Confidențialitate și securitate → Rețea locală → permite cat(a)log, apoi încearcă din nou.';

  @override
  String get crashTitle => 'Asta nu trebuia să se întâmple';

  @override
  String get crashBody =>
      'cat(a)log a întâlnit o eroare neașteptată. Datele tale sunt în siguranță — totul se salvează în momentul modificării. Repornește aplicația și, dacă se repetă, trimite raportul ca să poată fi reparat.';

  @override
  String get crashRestart => 'Repornește aplicația';

  @override
  String get crashSendReport => 'Trimite raport dezvoltatorului';

  @override
  String get crashLastRunBody =>
      'cat(a)log s-a oprit neașteptat data trecută — probabil a rămas fără memorie. Trimitem un raport scurt ca să fie reparat?';
}
