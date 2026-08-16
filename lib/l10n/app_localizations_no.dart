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

  @override
  String get scanCode => 'Skann kode';

  @override
  String get orTypeCode => 'Eller skriv koden';

  @override
  String get copyCode => 'Kopier kode';

  @override
  String get copied => 'Kopiert';

  @override
  String get invalidCode => 'Den koden er ikke gyldig';

  @override
  String get hotspotHint =>
      'Ingen felles Wi-Fi? Slå på hotspot på én telefon, koble til den andre og vær vert her.';

  @override
  String get byMessenger => 'Via messenger';

  @override
  String get byMessengerExplainer =>
      'Send hele katalogen som én fil via WhatsApp, Signal eller e-post — den andre siden importerer den.';

  @override
  String get shareBundle => 'Del synkpakke…';

  @override
  String get importBundle => 'Importer synkpakke…';

  @override
  String bundleImported(String result) {
    return 'Pakke importert: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import mislyktes: $error';
  }

  @override
  String get pickOnMap => 'Velg på kartet';

  @override
  String get useMyLocation => 'Bruk min posisjon';

  @override
  String get language => 'Språk';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Hvis det fortsatt feiler på iPhone/iPad: Innstillinger → Personvern og sikkerhet → Lokalt nettverk → tillat cat(a)log og prøv igjen.';

  @override
  String get markPrivate => 'Merk som privat';

  @override
  String get unmarkPrivate => 'Fjern privat merking';

  @override
  String get includePrivate => 'Ta med private data';

  @override
  String get includePrivateExplainer =>
      'Private katter, grupper og felt deles også — slå bare på når du synkroniserer dine egne enheter.';

  @override
  String get hideLabel => 'Skjul på denne enheten';

  @override
  String get unhideLabel => 'Vis igjen';

  @override
  String get showHiddenLabel => 'Vis skjulte';

  @override
  String get stopShowingHidden => 'Slutt å vise skjulte';

  @override
  String get starterSpecies => 'Art';

  @override
  String get starterStatus => 'Status';

  @override
  String get statusFoster => 'Fosterhjem';

  @override
  String get statusForeverHome => 'For-alltid-hjem';

  @override
  String get statusClinic => 'Klinikk';

  @override
  String get statusShelter => 'Dyrehjem';

  @override
  String get statusBarn => 'Låve';

  @override
  String get valueCat => 'Katt';

  @override
  String get otherOption => 'Annet…';

  @override
  String get celebrationsToggle => 'Feir adopsjoner';

  @override
  String get celebrationsSubtitle =>
      'Konfetti og jubel når en katt flytter til sitt for-alltid-hjem';

  @override
  String get onMapLabel => 'På kartet';

  @override
  String get showOnMap => 'Vis på kart';

  @override
  String get searchPlaceHint => 'Søk sted eller adresse';

  @override
  String get noPlacesFound => 'Ingen steder funnet';

  @override
  String get mapSearchHint => 'Søk katter, grupper, personer';

  @override
  String get proposeAnotherName => 'Foreslå et annet navn';

  @override
  String get moderationTitle => 'Forfattere & utestengelser';

  @override
  String get moderationSubtitle => 'Fjern en persons data for godt';

  @override
  String get authorsSection => 'Hvem har skrevet i katalogen';

  @override
  String get hardDeleteAction => 'Slett alt fra denne forfatteren';

  @override
  String hardDeleteWarning(Object name) {
    return 'Fjerner alle oppføringer og bilder fra $name på denne enheten. Andre enheter beholder sine. Kan ikke angres.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Skriv $name for å bekrefte';
  }

  @override
  String get alsoBan => 'Utesteng også — aldri motta data igjen';

  @override
  String get bansSection => 'Utestengelser';

  @override
  String get unbanAction => 'Fjern utestengelse';

  @override
  String get deletedDone => 'Slettet.';

  @override
  String get syncSummaryTitle => 'Hva som kom';

  @override
  String get summaryAdopted => 'Adoptert';

  @override
  String get summaryDeceased => 'Døde';

  @override
  String get summaryEscaped => 'Rømte';

  @override
  String get summaryNew => 'Nye';

  @override
  String get summaryConflicts => 'Konflikter å løse';

  @override
  String summaryOther(Object n) {
    return '…og $n andre endringer';
  }

  @override
  String get starterMother => 'Mor';

  @override
  String get starterFather => 'Far';

  @override
  String get familySection => 'Familie';

  @override
  String get littermatesLabel => 'Kullsøsken';

  @override
  String get siblingsLabel => 'Søsken';

  @override
  String get kittensLabel => 'Kattunger';

  @override
  String get toastSettingsTitle => 'Hva som meldes';

  @override
  String get toastSettingsSubtitle => 'Små meldinger etter en synkronisering';

  @override
  String get toastKindAdoptions => 'Adopsjoner';

  @override
  String get toastKindBirths => 'Fødsler';

  @override
  String get toastKindDeaths => 'Dødsfall';

  @override
  String get toastKindEscapes => 'Rømninger';

  @override
  String get toastKindMoves => 'Flyttinger';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptert av $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Ny kattunge: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat er død';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat har rømt';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat flyttet til $home';
  }

  @override
  String get notACatlogFile => 'Det er ikke en cat(a)log-fil';

  @override
  String get nothingNewInBundle =>
      'Ikke noe nytt i filen — du har alt allerede';

  @override
  String get syncChooserInPerson => 'Ansikt til ansikt';

  @override
  String get syncChooserInPersonSub =>
      'Dere er i samme rom — skann en kode, ferdig på sekunder';

  @override
  String get syncChooserRemote => 'På avstand';

  @override
  String get syncChooserRemoteSub =>
      'Via en delt mappe som Dropbox eller en USB-pinne';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Send alt som én fil gjennom hvilken som helst messenger';

  @override
  String get connectToWifiFirst =>
      'Koble til Wi-Fi først — da finner enhetene hverandre';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vil synkronisere';
  }

  @override
  String get trustBothWaysNote => 'Katalogene utveksles i begge retninger.';

  @override
  String get allowOnce => 'Tillat';

  @override
  String get allowAlways => 'Tillat alltid denne enheten';

  @override
  String get declineAction => 'Avslå';

  @override
  String get syncDeclined => 'Den andre enheten avslo synkroniseringen';

  @override
  String get trustedDevicesSection => 'Alltid tillatte enheter';

  @override
  String get removeTrust => 'Fjern';

  @override
  String get hostWithoutWifi => 'Vert uten Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Oppretter en midlertidig direkte forbindelse til den andre telefonen (uten internett). Bare cat(a)log bruker den, og den kobles fra av seg selv etter synkroniseringen.';

  @override
  String get hotspotAndroidOnly =>
      'Denne koden krever to Android-telefoner — bruk et delt Wi-Fi på iPhone/iPad';

  @override
  String get selectClowderHint => 'Velg en clowder til venstre';
}
