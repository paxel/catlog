// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Velkommen til cat(a)log';

  @override
  String get welcomeBody =>
      'Velg et navn til deg selv. Hver endring lagres under dette navnet, slik at andre ser hvem som gjorde hva.';

  @override
  String get yourName => 'Navnet ditt';

  @override
  String get start => 'Start';

  @override
  String get clowders => 'Clowdere';

  @override
  String get noClowdersYet =>
      'Ingen clowdere ennå.\nOpprett den første nedenfor.';

  @override
  String get strays => 'Hjemløse katter';

  @override
  String get searchCats => 'Søk etter katter';

  @override
  String get map => 'Kart';

  @override
  String get sync => 'Synkronisering';

  @override
  String get fields => 'Felter';

  @override
  String get exportCsv => 'Eksporter CSV';

  @override
  String get aboutAndFeedback => 'Om & tilbakemelding';

  @override
  String get newClowder => 'Ny clowder';

  @override
  String get name => 'Navn';

  @override
  String get cancel => 'Avbryt';

  @override
  String get create => 'Opprett';

  @override
  String get save => 'Lagre';

  @override
  String get delete => 'Slett';

  @override
  String get merge => 'Slå sammen';

  @override
  String get resolve => 'Avgjør';

  @override
  String get open => 'Åpne';

  @override
  String csvSavedTo(String path) {
    return 'CSV lagret i $path';
  }

  @override
  String get renameClowder => 'Gi clowderen nytt navn';

  @override
  String get rename => 'Gi nytt navn';

  @override
  String get timeline => 'Tidslinje';

  @override
  String get mergeInto => 'Slå sammen med…';

  @override
  String get deleteClowder => 'Slett clowder';

  @override
  String get cats => 'Katter';

  @override
  String get addCat => 'Legg til katt';

  @override
  String get newCat => 'Ny katt';

  @override
  String deleteQuestion(String name) {
    return 'Slette $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowderen forsvinner fra listen.';

  @override
  String deleteClowderBody(int count) {
    return 'Kattene dens ($count) slettes ikke — de blir hjemløse. Flytt dem først til en annen clowder hvis det ikke er meningen.';
  }

  @override
  String get card => 'Kort';

  @override
  String get shareAsImage => 'Del som bilde';

  @override
  String get shareAsPdf => 'Del som PDF';

  @override
  String get print => 'Skriv ut';

  @override
  String cardTitle(String name) {
    return 'Kort — $name';
  }

  @override
  String get renameCat => 'Gi katten nytt navn';

  @override
  String get seenHereNow => 'Sett her nå';

  @override
  String get deleteCat => 'Slett katt';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Hjemløs — ingen clowder';

  @override
  String get stray => 'Hjemløs';

  @override
  String get photos => 'Bilder';

  @override
  String get addPhoto => 'Legg til bilde';

  @override
  String get setAsProfileImage => 'Sett som profilbilde';

  @override
  String get thisIsProfileImage => 'Dette er profilbildet';

  @override
  String get deletePhoto => 'Slett bilde';

  @override
  String get deletePhotoTitle => 'Slette bildet?';

  @override
  String get deletePhotoBody =>
      'Bildedataene fjernes for alltid — det kan ikke angres.';

  @override
  String get deleteCatBody =>
      'Katten forsvinner fra alle lister. Bildene dens fjernes for alltid.';

  @override
  String get sightingRecorded => 'Observasjon registrert på posisjonen din.';

  @override
  String get noLocationAvailable =>
      'Ingen posisjon tilgjengelig — hold inne kartet i stedet.';

  @override
  String get moveTo => 'Flytt til';

  @override
  String get noClowderStrayOption => 'Ingen clowder — hjemløs / rømte';

  @override
  String timelineOf(String name) {
    return 'Tidslinje — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Angre denne endringen';

  @override
  String get revertSubtitle =>
      'Gjenoppretter forrige verdi som ny oppføring — historikken beholder begge.';

  @override
  String fieldCleared(String field) {
    return '$field tømt';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field tilbake til \"$value\"';
  }

  @override
  String get leftStray => 'Dro — hjemløs';

  @override
  String movedTo(String name) {
    return 'Flyttet til $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat kom';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat kom fra $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat dro til $place';
  }

  @override
  String get duplicateMergedIn => 'Duplikat slått sammen';

  @override
  String get asOfToday => 'Per i dag';

  @override
  String asOfDate(String date) {
    return 'Per $date';
  }

  @override
  String get value => 'Verdi';

  @override
  String get latitudeLongitude => 'breddegrad, lengdegrad';

  @override
  String get newField => 'Nytt felt';

  @override
  String get fieldType => 'Type';

  @override
  String get usedOn => 'Brukes til';

  @override
  String get forCats => 'katter';

  @override
  String get forClowders => 'clowdere';

  @override
  String get forBoth => 'begge';

  @override
  String get optionsOnePerLine => 'Alternativer (ett per linje)';

  @override
  String get renameField => 'Gi feltet nytt navn';

  @override
  String get noStraysRightNow => 'Ingen hjemløse katter akkurat nå.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Legg til hjemløs';

  @override
  String get newStray => 'Ny hjemløs';

  @override
  String get searchByNameHint => 'Søk etter katter på navn…';

  @override
  String get host => 'Vert';

  @override
  String get hostExplainer =>
      'Start her, og skriv deretter inn adresse og PIN på den andre enheten.';

  @override
  String get startHosting => 'Start som vert';

  @override
  String get stopHosting => 'Stopp som vert';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count økt(er) så langt';
  }

  @override
  String get join => 'Bli med';

  @override
  String get addressFromHost => 'Adresse (fra vertsenheten)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synkroniser nå';

  @override
  String get addressFormatHint => 'Adressen må se ut som 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synkronisert: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synkronisering mislyktes: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Siste synkronisering med $peer: $time';
  }

  @override
  String get sharedFolder => 'Delt mappe';

  @override
  String get sharedFolderExplainer =>
      'Synkroniser via en mappe som en skytjeneste eller USB-pinne bærer mellom enheter — for dem som ikke er på samme nettverk.';

  @override
  String get noFolderChosenYet => 'Ingen mappe valgt ennå';

  @override
  String get choose => 'Velg…';

  @override
  String get syncFolderNow => 'Synkroniser mappen nå';

  @override
  String folderSynced(String result) {
    return 'Mappe synkronisert: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Mappesynkronisering mislyktes: $error';
  }

  @override
  String get recordSightingHere => 'Registrer en observasjon her:';

  @override
  String get orPlaceClowderHere => 'Eller plasser en clowder her:';

  @override
  String trailOf(String name, int count) {
    return 'Rute: $name ($count observasjoner)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody => 'Endret to steder samtidig. Velg hva som stemmer:';

  @override
  String mergeThisInto(String kind) {
    return 'Slå sammen denne $kind med…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Ingen annen $kind å slå sammen med.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Slå sammen med $name?';
  }

  @override
  String mergeBody(String name) {
    return 'De to oppføringene blir én. $name beholder sine nåværende verdier; historikken til den andre legges til. Det kan ikke angres.';
  }

  @override
  String get kindCat => 'katt';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'felt';

  @override
  String get takePhoto => 'Ta bilde';

  @override
  String get chooseFromGallery => 'Velg fra galleriet';

  @override
  String get about => 'Om';

  @override
  String get aboutTagline =>
      'En lokal katalog for fosterkatter. Dataene dine blir på enhetene dine — ingen server, ingen konto.';

  @override
  String versionLabel(String version, String build) {
    return 'Versjon $version ($build)';
  }

  @override
  String get sourceCode => 'Kildekode';

  @override
  String get reportProblemOrIdea => 'Meld et problem eller en idé';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Skriv til utvikleren';

  @override
  String get buyCoffee => 'Spander en kaffe på utvikleren';

  @override
  String get coffeeSubtitle => 'Helt frivillig — appen er gratis';

  @override
  String get openSourceLicenses => 'Åpen kildekode-lisenser';

  @override
  String get machineTranslated =>
      'Oversettelsene er maskinelle — rettelser mottas med takk på GitHub.';

  @override
  String get unnamed => '(uten navn)';

  @override
  String get labelName => 'Navn';

  @override
  String get labelProfileImage => 'Profilbilde';

  @override
  String get labelPhoto => 'Bilde';

  @override
  String get starterGender => 'Kjønn';

  @override
  String get starterColor => 'Farge';

  @override
  String get starterNeutered => 'Kastrert';

  @override
  String get starterPregnant => 'Drektig';

  @override
  String get starterBirthdate => 'Fødselsdato';

  @override
  String get starterDeceased => 'Død';

  @override
  String get starterAddress => 'Adresse';

  @override
  String get starterResponsible => 'Ansvarlig person';

  @override
  String get starterPosition => 'Posisjon';

  @override
  String get valueYes => 'ja';

  @override
  String get valueNo => 'nei';

  @override
  String get valueFemale => 'hunn';

  @override
  String get valueMale => 'hann';

  @override
  String get valueUnknown => 'ukjent';

  @override
  String get cropTitle => 'Beskjær bilde';

  @override
  String get markTitle => 'Marker katten';

  @override
  String get useFullPhoto => 'Bruk hele bildet';

  @override
  String get dragToSelect => 'Dra et rektangel rundt katten';

  @override
  String get dragOverTheCat => 'Dra en ellipse over katten';

  @override
  String get cropPhoto => 'Beskjær…';

  @override
  String get markPhoto => 'Marker…';
}
