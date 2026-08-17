// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Velkommen til cat(a)log';

  @override
  String get welcomeBody =>
      'Vælg et navn til dig selv. Hver ændring registreres under dette navn, så andre kan se, hvem der gjorde hvad.';

  @override
  String get yourName => 'Dit navn';

  @override
  String get start => 'Start';

  @override
  String get clowders => 'Clowdere';

  @override
  String get noClowdersYet =>
      'Ingen clowdere endnu.\nOpret den første nedenfor.';

  @override
  String get strays => 'Herreløse katte';

  @override
  String get searchCats => 'Søg katte';

  @override
  String get map => 'Kort';

  @override
  String get sync => 'Synkronisering';

  @override
  String get fields => 'Felter';

  @override
  String get exportCsv => 'Eksportér CSV';

  @override
  String get aboutAndFeedback => 'Om & feedback';

  @override
  String get newClowder => 'Ny clowder';

  @override
  String get name => 'Navn';

  @override
  String get cancel => 'Annullér';

  @override
  String get create => 'Opret';

  @override
  String get save => 'Gem';

  @override
  String get delete => 'Slet';

  @override
  String get merge => 'Flet';

  @override
  String get resolve => 'Afgør';

  @override
  String get open => 'Åbn';

  @override
  String csvSavedTo(String path) {
    return 'CSV gemt i $path';
  }

  @override
  String get renameClowder => 'Omdøb clowder';

  @override
  String get rename => 'Omdøb';

  @override
  String get timeline => 'Tidslinje';

  @override
  String get mergeInto => 'Flet med…';

  @override
  String get deleteClowder => 'Slet clowder';

  @override
  String get cats => 'Katte';

  @override
  String get addCat => 'Tilføj kat';

  @override
  String get newCat => 'Ny kat';

  @override
  String deleteQuestion(String name) {
    return 'Slet $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowderen forsvinder fra listen.';

  @override
  String deleteClowderBody(int count) {
    return 'Dens $count kat(te) slettes ikke — de bliver herreløse. Flyt dem først til en anden clowder, hvis det ikke er meningen.';
  }

  @override
  String get card => 'Kort';

  @override
  String get shareAsImage => 'Del som billede';

  @override
  String get shareAsPdf => 'Del som PDF';

  @override
  String get print => 'Udskriv';

  @override
  String cardTitle(String name) {
    return 'Kort — $name';
  }

  @override
  String get renameCat => 'Omdøb kat';

  @override
  String get seenHereNow => 'Set her nu';

  @override
  String get deleteCat => 'Slet kat';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Herreløs — ingen clowder';

  @override
  String get stray => 'Herreløs';

  @override
  String get photos => 'Fotos';

  @override
  String get addPhoto => 'Tilføj foto';

  @override
  String get setAsProfileImage => 'Angiv som profilbillede';

  @override
  String get thisIsProfileImage => 'Dette er profilbilledet';

  @override
  String get deletePhoto => 'Slet foto';

  @override
  String get deletePhotoTitle => 'Slet foto?';

  @override
  String get deletePhotoBody =>
      'Fotodata fjernes for altid — det kan ikke fortrydes.';

  @override
  String get deleteCatBody =>
      'Katten forsvinder fra alle lister. Dens fotos fjernes for altid.';

  @override
  String get sightingRecorded => 'Observation registreret på din position.';

  @override
  String get noLocationAvailable =>
      'Ingen placering tilgængelig — hold i stedet kortet nede.';

  @override
  String get moveTo => 'Flyt til';

  @override
  String get noClowderStrayOption => 'Ingen clowder — herreløs / løbet væk';

  @override
  String timelineOf(String name) {
    return 'Tidslinje — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Fortryd denne ændring';

  @override
  String get revertSubtitle =>
      'Gendanner den forrige værdi som ny post — historikken beholder begge.';

  @override
  String fieldCleared(String field) {
    return '$field ryddet';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field tilbage til \"$value\"';
  }

  @override
  String get leftStray => 'Gik — herreløs';

  @override
  String movedTo(String name) {
    return 'Flyttet til $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat ankom';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat ankom fra $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat tog til $place';
  }

  @override
  String get duplicateMergedIn => 'Dublet flettet ind';

  @override
  String get asOfToday => 'Pr. i dag';

  @override
  String asOfDate(String date) {
    return 'Pr. $date';
  }

  @override
  String get value => 'Værdi';

  @override
  String get latitudeLongitude => 'breddegrad, længdegrad';

  @override
  String get newField => 'Nyt felt';

  @override
  String get fieldType => 'Type';

  @override
  String get usedOn => 'Bruges til';

  @override
  String get forCats => 'katte';

  @override
  String get forClowders => 'clowdere';

  @override
  String get forBoth => 'begge';

  @override
  String get optionsOnePerLine => 'Muligheder (én pr. linje)';

  @override
  String get renameField => 'Omdøb felt';

  @override
  String get noStraysRightNow => 'Ingen herreløse katte lige nu.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Tilføj herreløs';

  @override
  String get newStray => 'Ny herreløs';

  @override
  String get searchByNameHint => 'Søg katte efter navn…';

  @override
  String get host => 'Vært';

  @override
  String get hostExplainer =>
      'Start her, og indtast derefter adresse og PIN på den anden enhed.';

  @override
  String get startHosting => 'Start som vært';

  @override
  String get stopHosting => 'Stop som vært';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count session(er) indtil nu';
  }

  @override
  String get join => 'Deltag';

  @override
  String get addressFromHost => 'Adresse (fra værtsenheden)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synkronisér nu';

  @override
  String get addressFormatHint => 'Adressen skal ligne 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synkroniseret: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synkronisering mislykkedes: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Sidste synkronisering med $peer: $time';
  }

  @override
  String get sharedFolder => 'Delt mappe';

  @override
  String get sharedFolderExplainer =>
      'Synkronisér via en mappe, som et clouddrev eller USB-stik bærer mellem enheder — for dem, der ikke er på samme netværk.';

  @override
  String get noFolderChosenYet => 'Ingen mappe valgt endnu';

  @override
  String get choose => 'Vælg…';

  @override
  String get syncFolderNow => 'Synkronisér mappe nu';

  @override
  String folderSynced(String result) {
    return 'Mappe synkroniseret: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Mappesynkronisering mislykkedes: $error';
  }

  @override
  String get recordSightingHere => 'Registrér en observation her:';

  @override
  String get orPlaceClowderHere => 'Eller placér en clowder her:';

  @override
  String trailOf(String name, int count) {
    return 'Rute: $name ($count observationer)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'Ændret to steder på én gang. Vælg, hvad der er sandt:';

  @override
  String mergeThisInto(String kind) {
    return 'Flet denne $kind med…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Ingen anden $kind at flette med.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Flet med $name?';
  }

  @override
  String mergeBody(String name) {
    return 'De to poster bliver til én. $name beholder sine nuværende værdier; den andens historik føjes til. Det kan ikke fortrydes.';
  }

  @override
  String get kindCat => 'kat';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'felt';

  @override
  String get takePhoto => 'Tag foto';

  @override
  String get chooseFromGallery => 'Vælg fra galleri';

  @override
  String get about => 'Om';

  @override
  String get aboutTagline =>
      'Et lokalt katalog over plejekatte. Dine data bliver på dine enheder — ingen server, ingen konto.';

  @override
  String versionLabel(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get sourceCode => 'Kildekode';

  @override
  String get reportProblemOrIdea => 'Meld et problem eller en idé';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Skriv til udvikleren';

  @override
  String get buyCoffee => 'Giv udvikleren en kop kaffe';

  @override
  String get coffeeSubtitle => 'Helt frivilligt — appen er gratis';

  @override
  String get openSourceLicenses => 'Open source-licenser';

  @override
  String get machineTranslated =>
      'Oversættelser er maskinelle — rettelser er velkomne på GitHub.';

  @override
  String get unnamed => '(uden navn)';

  @override
  String get labelName => 'Navn';

  @override
  String get labelProfileImage => 'Profilbillede';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Køn';

  @override
  String get starterBreed => 'Breed';

  @override
  String get valueMixed => 'mixed';

  @override
  String get starterColor => 'Farve';

  @override
  String get starterNeutered => 'Neutraliseret';

  @override
  String get starterPregnant => 'Drægtig';

  @override
  String get starterBirthdate => 'Fødselsdato';

  @override
  String get starterDeceased => 'Død';

  @override
  String get starterAddress => 'Adresse';

  @override
  String get starterResponsible => 'Ansvarlig person';

  @override
  String get starterPosition => 'Position';

  @override
  String get valueYes => 'ja';

  @override
  String get valueNo => 'nej';

  @override
  String get valueFemale => 'hun';

  @override
  String get valueMale => 'han';

  @override
  String get valueUnknown => 'ukendt';

  @override
  String get cropTitle => 'Beskær foto';

  @override
  String get markTitle => 'Markér katten';

  @override
  String get applyCrop => 'Crop';

  @override
  String get useFullPhoto => 'Brug hele fotoet';

  @override
  String get dragToSelect => 'Træk et rektangel rundt om katten';

  @override
  String get dragOverTheCat => 'Træk en ellipse over katten';

  @override
  String get cropPhoto => 'Beskær…';

  @override
  String get markPhoto => 'Markér…';

  @override
  String get scanCode => 'Scan kode';

  @override
  String get orTypeCode => 'Eller indtast koden';

  @override
  String get copyCode => 'Kopiér kode';

  @override
  String get copied => 'Kopieret';

  @override
  String get invalidCode => 'Den kode er ikke gyldig';

  @override
  String get hotspotHint =>
      'Intet fælles Wi-Fi? Tænd hotspot på én telefon, forbind den anden og vær vært her.';

  @override
  String get byMessenger => 'Via messenger';

  @override
  String get byMessengerExplainer =>
      'Send hele dit katalog som én fil via WhatsApp, Signal eller mail — den anden side importerer den.';

  @override
  String get shareBundle => 'Del synkroniseringspakke…';

  @override
  String get importBundle => 'Importér synkroniseringspakke…';

  @override
  String bundleImported(String result) {
    return 'Pakke importeret: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import mislykkedes: $error';
  }

  @override
  String get pickOnMap => 'Vælg på kortet';

  @override
  String get useMyLocation => 'Brug min placering';

  @override
  String get language => 'Sprog';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Hvis det bliver ved med at fejle på iPhone/iPad: Indstillinger → Anonymitet og sikkerhed → Lokalt netværk → tillad cat(a)log, og prøv igen.';

  @override
  String get crashTitle => 'Det burde ikke være sket';

  @override
  String get crashBody =>
      'cat(a)log stødte på en uventet fejl. Dine data er sikre — alt gemmes i samme øjeblik du ændrer det. Genstart appen, og sker det igen, så send rapporten, så det kan rettes.';

  @override
  String get crashRestart => 'Genstart appen';

  @override
  String get crashSendReport => 'Send rapport til udvikleren';

  @override
  String get crashLastRunBody =>
      'cat(a)log stoppede uventet sidste gang — sandsynligvis løb den tør for hukommelse. Send en kort rapport, så det kan rettes?';
}
