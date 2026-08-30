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
  String get clowdersNeutral => 'Husstander';

  @override
  String get noClowdersYet =>
      'Ingen clowdere ennå. En clowder er et sted der katter bor — fosterhjemmet ditt, leiligheten til en adoptant. Opprett den første nedenfor.';

  @override
  String get noClowdersYetNeutral =>
      'Ingen husstander ennå. En husstand er et sted der kjæledyr bor — hjemmet ditt, et fosterhjem, leiligheten til en adoptant. Opprett den første nedenfor.';

  @override
  String get strays => 'Hjemløse katter';

  @override
  String get searchCats => 'Søk etter katter';

  @override
  String get searchCatsNeutral => 'Søk etter kjæledyr';

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
  String get newClowderNeutral => 'Ny husstand';

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
  String get renameClowderNeutral => 'Gi husstanden nytt navn';

  @override
  String get rename => 'Gi nytt navn';

  @override
  String get timeline => 'Tidslinje';

  @override
  String get mergeInto => 'Slå sammen med…';

  @override
  String get deleteClowder => 'Slett clowder';

  @override
  String get deleteClowderNeutral => 'Slett husstand';

  @override
  String get cats => 'Katter';

  @override
  String get catsNeutral => 'Kjæledyr';

  @override
  String get addCat => 'Legg til katt';

  @override
  String get addCatNeutral => 'Legg til kjæledyr';

  @override
  String get newCat => 'Ny katt';

  @override
  String get newCatNeutral => 'Nytt kjæledyr';

  @override
  String deleteQuestion(String name) {
    return 'Slette $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowderen forsvinner fra listen.';

  @override
  String get deleteClowderEmptyBodyNeutral =>
      'Husstanden forsvinner fra listen.';

  @override
  String deleteClowderBody(int count) {
    return 'Kattene dens ($count) slettes ikke — de blir hjemløse. Flytt dem først til en annen clowder hvis det ikke er meningen.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Kjæledyrene dens ($count) slettes ikke — de blir hjemløse. Flytt dem først til en annen husstand hvis det ikke er meningen.';
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
  String get renameCatNeutral => 'Gi kjæledyret nytt navn';

  @override
  String get seenHereNow => 'Sett her nå';

  @override
  String get deleteCat => 'Slett katt';

  @override
  String get deleteCatNeutral => 'Slett kjæledyr';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get clowderLabelNeutral => 'Husstand';

  @override
  String get strayNoClowder => 'Hjemløs — ingen clowder';

  @override
  String get strayNoClowderNeutral => 'Hjemløs — ingen husstand';

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
      'Katten forsvinner fra alle lister og bildene fjernes — her og, etter neste synkronisering, også på de andre enhetene.';

  @override
  String get deleteCatBodyNeutral =>
      'Kjæledyret forsvinner fra alle lister og bildene fjernes — her og, etter neste synkronisering, også på de andre enhetene.';

  @override
  String get sightingRecorded => 'Observasjon registrert på posisjonen din.';

  @override
  String get noLocationAvailable =>
      'Ingen posisjon tilgjengelig — hold inne kartet i stedet.';

  @override
  String get locationDeniedForever =>
      'Posisjonstilgang er blokkert. Tillat den i systeminnstillingene for å bruke Stray Cam.';

  @override
  String get locationServiceOff =>
      'Posisjon er slått av på denne enheten. Slå den på i innstillingene og prøv igjen.';

  @override
  String get locationDenied =>
      'cat(a)log har ikke tillatelse til å bruke posisjonen din. Prøv igjen og tillat det når du blir spurt.';

  @override
  String get locationNoFix =>
      'Posisjonen din kunne ikke bestemmes akkurat nå. Prøv igjen utendørs — GPS trenger fri sikt til himmelen.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Chipnummer';

  @override
  String get starterRemarks => 'Merknader';

  @override
  String get captureFlier => 'Fotografer oppslag';

  @override
  String get addPhotosTo => 'Legg til bilder i…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count bilde(r) lagt til i $name';
  }

  @override
  String get scanPrintedCode => 'Skann trykt kode';

  @override
  String get chipScanHint =>
      'Skanner den trykte QR/strekkoden fra chipkortet eller veterinærpapirer — telefonen kan ikke lese chipen i katten.';

  @override
  String get chipScanHintNeutral =>
      'Skanner den trykte QR/strekkoden fra chipkortet eller veterinærpapirer — telefonen kan ikke lese chipen i dyret.';

  @override
  String get savingLabel => 'Lagrer…';

  @override
  String ownerOfCat(String name) {
    return 'Eier av $name';
  }

  @override
  String get sortLabel => 'Sorter';

  @override
  String get viewAsTable => 'Vis som tabell';

  @override
  String get viewAsTiles => 'Vis som fliser';

  @override
  String get viewAsList => 'Vis som liste';

  @override
  String get ageLabel => 'Alder';

  @override
  String get catList => 'Katteliste';

  @override
  String get catListNeutral => 'Kjæledyrliste';

  @override
  String get matchCandidatesTitle => 'Mulige treff';

  @override
  String get findDuplicates => 'Finn duplikater';

  @override
  String get noDuplicates => 'Ingen mulige duplikater akkurat nå.';

  @override
  String get similarName => 'Lignende navn';

  @override
  String get sharePublicly => 'Del offentlig…';

  @override
  String get pickFramesTitle => 'Velg bilder';

  @override
  String get suggestedFrames => 'Foreslåtte bilder';

  @override
  String get scrubFrames => 'Spol i videoen';

  @override
  String get keepThisFrame => 'Behold dette bildet';

  @override
  String get fromVideo => 'Fra video…';

  @override
  String get videoMobileOnly =>
      'Å velge bilder fra video fungerer i telefonappen (Android og iPhone) — ikke på denne enheten ennå.';

  @override
  String get shareWhitelistExplainer =>
      'Velg hva som skal med i filen. Bare avmerkede felter tas med.';

  @override
  String get exportShareFile => 'Eksporter delingsfil…';

  @override
  String get hostedLink => 'Vertslenke (URL til den opplastede filen)';

  @override
  String get inlineQr => 'Innebygd QR (kun tekst, ingen bilder)';

  @override
  String get inlineTooBig =>
      'For mye data for en innebygd kode — fjern felter eller bruk en vertslenke.';

  @override
  String get scanShareLabel => 'Skann delingskode';

  @override
  String get notAShareCode => 'Denne koden er ikke en cat(a)log-deling.';

  @override
  String get importShareTitle => 'Importere denne katten?';

  @override
  String get importShareTitleNeutral => 'Importere dette kjæledyret?';

  @override
  String shareSource(String url) {
    return 'Kilde: $url';
  }

  @override
  String get importLabel => 'Importer';

  @override
  String get strayAreaLabel => 'Mulig streifområde';

  @override
  String get prevPin => 'Forrige nål';

  @override
  String get nextPin => 'Neste nål';

  @override
  String get noMissingCats =>
      'Ingen savnede katter med oppslagsposisjoner ennå.';

  @override
  String get noMissingCatsNeutral =>
      'Ingen savnede kjæledyr med oppslagsposisjoner ennå.';

  @override
  String get noMatchCandidates => 'Ingen mulige treff akkurat nå.';

  @override
  String sameIdField(String field) {
    return 'Samme $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m fra hverandre';
  }

  @override
  String get addFlier => 'Legg til oppslag';

  @override
  String get missingSinceLabel => 'Savnet siden';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Beskjær portrett';

  @override
  String get statusOwner => 'Eier';

  @override
  String get ocrUnavailable =>
      'Tekstgjenkjenning er ikke tilgjengelig på denne enheten — skriv inn oppslagsteksten selv.';

  @override
  String get displayFormat => 'Vises som';

  @override
  String get displayPlain => 'Ren tekst';

  @override
  String get displayQr => 'QR-kode';

  @override
  String get displayBarcode => 'Strekkode';

  @override
  String get editLabel => 'Rediger';

  @override
  String get doneLabel => 'Ferdig';

  @override
  String get openSettings => 'Åpne innstillinger';

  @override
  String get notSaved => 'Ikke lagret';

  @override
  String get birthdateInFuture => 'Fødselsdatoen kan ikke ligge i fremtiden.';

  @override
  String get deceasedInFuture => 'Dødsdatoen kan ikke ligge i fremtiden.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Dødsdatoen kan ikke ligge før fødselsdatoen ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Fødselsdatoen kan ikke ligge etter dødsdatoen ($date).';
  }

  @override
  String get malePregnant =>
      'Denne katten er registrert som hann — en hannkatt kan ikke være drektig. Sjekk kjønnet først.';

  @override
  String get malePregnantNeutral =>
      'Dette kjæledyret er registrert som hann — en hann kan ikke være drektig. Sjekk kjønnet først.';

  @override
  String fatherNotMale(String name) {
    return '$name er registrert som hunn og kan ikke være faren. Sjekk kjønnet først.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name er registrert som hann og kan ikke være moren. Sjekk kjønnet først.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name ble født $date — en forelder kan ikke være født etter kattungen sin.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name ble født $date — en forelder kan ikke være født etter ungen sin.';
  }

  @override
  String get genderFatherFemale =>
      'Denne katten er registrert som far til andre katter — faren kan ikke være hunn. Sjekk familien først.';

  @override
  String get genderFatherFemaleNeutral =>
      'Dette kjæledyret er registrert som far til andre kjæledyr — faren kan ikke være hunn. Sjekk familien først.';

  @override
  String get genderMotherMale =>
      'Denne katten er registrert som mor til andre katter — moren kan ikke være hann. Sjekk familien først.';

  @override
  String get genderMotherMaleNeutral =>
      'Dette kjæledyret er registrert som mor til andre kjæledyr — moren kan ikke være hann. Sjekk familien først.';

  @override
  String get moveTo => 'Flytt til';

  @override
  String get noClowderStrayOption => 'Ingen clowder — hjemløs / rømte';

  @override
  String get noClowderStrayOptionNeutral => 'Ingen husstand — hjemløs / rømte';

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
  String dateFormatError(String format) {
    return 'Feil format — bruk $format';
  }

  @override
  String get dateInFuture => 'Denne datoen kan ikke ligge i fremtiden.';

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
  String get forCatsNeutral => 'kjæledyr';

  @override
  String get forClowders => 'clowdere';

  @override
  String get forClowdersNeutral => 'husstander';

  @override
  String get forBoth => 'begge';

  @override
  String get optionsOnePerLine => 'Alternativer (ett per linje)';

  @override
  String get ownValue => 'Egen verdi';

  @override
  String get renameField => 'Gi feltet nytt navn';

  @override
  String get editOptions => 'Rediger alternativer…';

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
  String get searchByNameHintNeutral => 'Søk etter kjæledyr på navn…';

  @override
  String get host => 'Vert';

  @override
  String get hostExplainer =>
      'Start her, og skann deretter koden eller skriv den inn på den andre enheten.';

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
      'Begge enhetene bruker samme mappe (f.eks. i Dropbox eller på en USB-pinne). Hver synkronisering legger endringene dine der og henter den andres.';

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
  String get kindCatNeutral => 'kjæledyr';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindClowderNeutral => 'husstand';

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
  String get aboutTaglineNeutral =>
      'En lokal katalog for kjæledyrene du tar deg av. Dataene dine blir på enhetene dine — ingen server, ingen konto.';

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
  String get coffeeSubtitle =>
      'Appen forblir gratis. Selv om jeg ikke får kaffe :)';

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
  String get starterBreed => 'Rase';

  @override
  String get valueMixed => 'blanding';

  @override
  String get breedEuropeanShorthair => 'Europeisk korthår';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britisk korthår';

  @override
  String get breedNorwegianForestCat => 'Norsk skogkatt';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siameser';

  @override
  String get breedPersian => 'Perser';

  @override
  String get breedBengal => 'Bengal';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get starterEmail => 'E-post';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Oppslagslenke';

  @override
  String lookupUrlHelp(String token) {
    return 'Tjenestens side med $token der nummeret skal stå, f.eks. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Slå opp';

  @override
  String lookupFailed(String url) {
    return 'Ingen app kunne åpne $url. Kopier lenken inn i en nettleser.';
  }

  @override
  String get stepCat => 'Katt';

  @override
  String get stepCatNeutral => 'Kjæledyr';

  @override
  String get stepOwner => 'Eier';

  @override
  String get stepFace => 'Ansiktsbilde';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Sjekk og lagre';

  @override
  String get stepOwnerHint =>
      'Den som savner katten — det blir deres clowder, med kontakten fra oppslaget.';

  @override
  String get stepOwnerHintNeutral =>
      'Den som savner kjæledyret — det blir deres husstand, med kontakten fra oppslaget.';

  @override
  String get stepFaceHint =>
      'Klipp kattens ansikt ut av oppslaget; det blir profilbildet. Du kan hoppe over.';

  @override
  String get stepFaceHintNeutral =>
      'Klipp kjæledyrets ansikt ut av oppslaget; det blir profilbildet. Du kan hoppe over.';

  @override
  String get stepRegistryHint =>
      'Numre funnet på oppslaget. Avmerkede lagres hos katten og kan åpnes senere.';

  @override
  String get stepRegistryHintNeutral =>
      'Numre funnet på oppslaget. Avmerkede lagres hos kjæledyret og kan åpnes senere.';

  @override
  String get noRegistryLinks =>
      'Ingen registerlenker på dette oppslaget — om noen er oversett, meld gjerne en feil.';

  @override
  String get unknownServiceHint => 'Ukjent tjeneste';

  @override
  String get rememberService => 'Husk tjenesten';

  @override
  String get rememberServiceHint =>
      'Gi tjenesten et navn og pek på nummeret i lenken. Neste oppslag fyller seg selv.';

  @override
  String get noIdInLink => 'Denne lenken har ikke noe nummer appen kan lagre.';

  @override
  String get whichNumber => 'Hvilken del er nummeret?';

  @override
  String get cropAgain => 'Beskjær på nytt';

  @override
  String get noFaceYet => 'Ingen ansiktsbilde ennå — oppslagsbildet brukes.';

  @override
  String get backLabel => 'Tilbake';

  @override
  String get dangerButton => 'IKKE TRYKK.\nFARE';

  @override
  String get dangerThanks => 'Takk for at du bruker cat(a)log!';

  @override
  String get helpTitle => 'Hjelp';

  @override
  String get showTipsAgain => 'Vis tipsene igjen';

  @override
  String get helpHome =>
      'Oversikten over koloniene dine — en koloni er et sted der katter bor: hjemmet ditt, et fosterhjem, et internat. Trykk på et kort for å se kattene; hold inne for menyen. Knappen nede til høyre lager en koloni, og streiferkortet samler alle katter uten hjem. Navnet øverst er katalogen du er i — trykk for å bytte eller legge til en.';

  @override
  String get helpHomeNeutral =>
      'Oversikten over husstandene dine — en husstand er et sted der kjæledyr bor: hjemmet ditt, et fosterhjem, et internat. Trykk på et kort for å se kjæledyrene; hold inne for menyen. Knappen nede til høyre lager en husstand, og streiferkortet samler alle kjæledyr uten hjem. Navnet øverst er katalogen du er i — trykk for å bytte eller legge til en.';

  @override
  String get helpClowder =>
      'Alt om dette stedet: kattene, feltene (adresse, kontakt, type) og historikken. Siden åpnes skrivebeskyttet; blyanten slår på redigering, der du også kan legge til et felt. Hold inne et felt for å redigere det direkte, en katt for å flytte, skjule eller åpne den. En avtale lagt til her kan ta med flere av koloniens katter, for eksempel en kastreringstur: kryss av kattene som blir med, avslutt én gang, fjern krysset for dem som ikke ble behandlet.';

  @override
  String get helpClowderNeutral =>
      'Alt om dette stedet: kjæledyrene, feltene (adresse, kontakt, type) og historikken. Siden åpnes skrivebeskyttet; blyanten slår på redigering, der du også kan legge til et felt. Hold inne et felt for å redigere det direkte, et kjæledyr for å flytte, skjule eller åpne det. En avtale lagt til her kan ta med flere av husstandens kjæledyr, for eksempel en kastreringstur: kryss av kjæledyrene som blir med, avslutt én gang, fjern krysset for dem som ikke ble behandlet.';

  @override
  String get helpCat =>
      'Alt om denne katten: bilder, felter, familie, historikk. Siden er skrivebeskyttet til du trykker på blyanten. Langt trykk på et felt går rett til redigering; langt trykk på et bilde åpner menyen. Menyen øverst til høyre har resten: skjul, slå sammen, noter en observasjon, del katten. Privat settes når du redigerer et felt.';

  @override
  String get helpCatNeutral =>
      'Alt om dette kjæledyret: bilder, felter, familie, historikk. Siden er skrivebeskyttet til du trykker på blyanten. Langt trykk på et felt går rett til redigering; langt trykk på et bilde åpner menyen. Menyen øverst til høyre har resten: skjul, slå sammen, noter en observasjon, del kjæledyret. Privat settes når du redigerer et felt.';

  @override
  String get helpStrays =>
      'Katter uten hjem akkurat nå: funnet, rømt eller fra et oppslag. Kameraknappen registrerer en katt foran deg; oppslagsknappen gjør et savnet-oppslag om til en katt med eierens kontakt; skanneren leser en cat(a)log-kode fra oppslaget. Trykk på Stray Cam for et bilde; hold inne for å filme en video og beholde de beste rutene som bilder.';

  @override
  String get helpStraysNeutral =>
      'Kjæledyr uten hjem akkurat nå: funnet, rømt eller fra et oppslag. Kameraknappen registrerer et dyr foran deg; oppslagsknappen gjør et savnet-oppslag om til et kjæledyr med eierens kontakt; skanneren leser en cat(a)log-kode fra oppslaget. Trykk på Stray Cam for et bilde; hold inne for å filme en video og beholde de beste rutene som bilder.';

  @override
  String get helpMap =>
      'Alle katter og steder med posisjon. Søket finner katter, personer og steder — et ukjent navn slås opp i hele verden. Lagknappen tegner 500 m-sirklene rundt oppslagsstedene til en savnet katt og rundt det gamle hjemmet. Pilene går fra nål til nål, langt trykk noterer en observasjon.';

  @override
  String get helpMapNeutral =>
      'Alle kjæledyr og steder med posisjon. Søket finner kjæledyr, personer og steder — et ukjent navn slås opp i hele verden. Lagknappen tegner 500 m-sirklene rundt oppslagsstedene til et savnet kjæledyr og rundt det gamle hjemmet. Pilene går fra nål til nål, langt trykk noterer en observasjon.';

  @override
  String get helpCard =>
      'Kattens utskrivbare kort: velg øverst med brikkene hva som skal stå på det, del det så som bilde eller PDF. Numre kan skrives ut som QR eller strekkode, og en posisjon blir en QR som åpner et kart, pluss en kort Plus Code.';

  @override
  String get helpCardNeutral =>
      'Kjæledyrets utskrivbare kort: velg øverst med brikkene hva som skal stå på det, del det så som bilde eller PDF. Numre kan skrives ut som QR eller strekkode, og en posisjon blir en QR som åpner et kart, pluss en kort Plus Code.';

  @override
  String get helpSync =>
      'Slik når data andre folk: koble til direkte, bruk en mappe begge enheter ser, eller send en fil via en meldingsapp. Du bestemmer alltid hva som sendes — og mottatte .catsync-filer åpnes også her.';

  @override
  String get helpFields =>
      'Feltene katalogen din bruker. Gi dem nytt navn, endre valgene i et valgfelt, eller lag egne. Et id-felt kan peke på en tjeneste (et register), da blir nummeret trykkbart hos katten.';

  @override
  String get helpFieldsNeutral =>
      'Feltene katalogen din bruker. Gi dem nytt navn, endre valgene i et valgfelt, eller lag egne. Et id-felt kan peke på en tjeneste (et register), da blir nummeret trykkbart hos kjæledyret.';

  @override
  String get helpTimeline =>
      'Hver endring som er gjort, nyeste først: hvem som endret hva, når og til hvilken verdi. Enhver oppføring kan angres — det skriver en ny oppføring, ingenting slettes.';

  @override
  String get helpDuplicates =>
      'Katter eller kolonier som ser ut til å finnes to ganger — like numre eller svært like navn med samsvarende detaljer. Trykk på et par for å slå sammen; det kan ikke angres, derfor spørres det først.';

  @override
  String get helpDuplicatesNeutral =>
      'Kjæledyr eller husstander som ser ut til å finnes to ganger — like numre eller svært like navn med samsvarende detaljer. Trykk på et par for å slå sammen; det kan ikke angres, derfor spørres det først.';

  @override
  String get helpMatches =>
      'Katter som kan være samme dyr: samme nummer, eller en streifer sett innenfor søkeområdet til en savnet katt. Trykk på et par for å slå sammen, hold inne for å åpne den første katten og sammenligne.';

  @override
  String get helpMatchesNeutral =>
      'Kjæledyr som kan være samme dyr: samme nummer, eller en streifer sett innenfor søkeområdet til et savnet kjæledyr. Trykk på et par for å slå sammen, hold inne for å åpne det første kjæledyret og sammenligne.';

  @override
  String get helpFlier =>
      'Et fotografert oppslag blir en katt pluss eier. Steg for steg: kattens data, eierens kontakt, beskjæring av ansiktet til profilbildet, registernumre fra oppslaget, så en siste sjekk. Alt er forslag — rett det kameraet leste feil.';

  @override
  String get helpFlierNeutral =>
      'Et fotografert oppslag blir et kjæledyr pluss eier. Steg for steg: kjæledyrets data, eierens kontakt, beskjæring av ansiktet til profilbildet, registernumre fra oppslaget, så en siste sjekk. Alt er forslag — rett det kameraet leste feil.';

  @override
  String get archiveTitle => 'Arkiv';

  @override
  String get archiveExplainer =>
      'Døde katter og tomme kolonier som ingen har rørt på år, tar fortsatt plass — særlig bildene. Arkivering skriver dem til en fil du beholder, og sletter dem så herfra.';

  @override
  String get archiveExplainerNeutral =>
      'Døde kjæledyr og tomme husstander som ingen har rørt på år, tar fortsatt plass — særlig bildene. Arkivering skriver dem til en fil du beholder, og sletter dem så herfra.';

  @override
  String get archiveAction => 'Arkivér';

  @override
  String archiveSelected(int count) {
    return 'Arkivér $count oppføringer';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arkivere $count oppføringer?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names skrives til en fil og slettes deretter — på enheten din og på hver enhet du synkroniserer med. Importerer du filen, er alt tilbake; uten den er de borte.';
  }

  @override
  String archiveDone(int count) {
    return '$count oppføringer arkivert og slettet';
  }

  @override
  String archiveFailed(String error) {
    return 'Ingenting ble slettet: arkivfilen kunne ikke skrives ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Database $db, bilder $photos i $count filer';
  }

  @override
  String quietForYears(int years) {
    return 'Uendret i $years år';
  }

  @override
  String get nothingToArchive => 'Ingenting er gammelt nok til arkivering.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Siste endring $date · bilder $size';
  }

  @override
  String get helpArchive =>
      'Gamle data koster plass, særlig bildene som hver synkroniserte enhet drar med seg. Her velger du døde katter og tomme kolonier som har ligget stille i årevis, skriver dem til en fil du beholder, og sletter dem. Slettingen når alle du synkroniserer med; import av filen gjenoppretter alt.';

  @override
  String get helpArchiveNeutral =>
      'Gamle data koster plass, særlig bildene som hver synkroniserte enhet drar med seg. Her velger du døde kjæledyr og tomme husstander som har ligget stille i årevis, skriver dem til en fil du beholder, og sletter dem. Slettingen når alle du synkroniserer med; import av filen gjenoppretter alt.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Gjenopprette $count slettede oppføringer?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names er slettet i denne katalogen, og filen du nettopp importerte inneholder dem. Gjenoppretting henter dem tilbake her og på hver enhet du synkroniserer med.';
  }

  @override
  String get restoreAction => 'Gjenopprett';

  @override
  String get keepDeleted => 'Behold slettet';

  @override
  String get archiveNotSaved =>
      'Ingenting ble slettet: arkivet ble ikke lagret noe sted.';

  @override
  String get locateAddress => 'Finn adressen på kartet';

  @override
  String get addressLocated => 'Adresse funnet';

  @override
  String get addressNotFound =>
      'Fant ingen sted for denne adressen. Sjekk stavemåten, eller la feltet stå tomt.';

  @override
  String get starterPosition => 'Plassering';

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
  String get markTitleNeutral => 'Marker kjæledyret';

  @override
  String get applyCrop => 'Beskjær';

  @override
  String get useFullPhoto => 'Bruk hele bildet';

  @override
  String get dragToSelect => 'Dra et rektangel rundt katten';

  @override
  String get dragToSelectNeutral => 'Dra et rektangel rundt kjæledyret';

  @override
  String get dragOverTheCat => 'Dra en ellipse over katten';

  @override
  String get dragOverTheCatNeutral => 'Dra en ellipse over kjæledyret';

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
  String lastBackupFailed(String error) {
    return 'Siste automatiske sikkerhetskopi mislyktes: $error';
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
  String get typeUnitValue => 'Verdi med enhet';

  @override
  String get dimension => 'Størrelse';

  @override
  String get dimensionWeight => 'Vekt';

  @override
  String get dimensionLength => 'Lengde';

  @override
  String get dimensionVolume => 'Volum';

  @override
  String get dimensionTemperature => 'Temperatur';

  @override
  String get unitsLabel => 'Enheter';

  @override
  String get catalogHolds => 'Denne katalogen inneholder';

  @override
  String get modeCats => 'Katter';

  @override
  String get modePets => 'Kjæledyr';

  @override
  String get graphLabel => 'Graf';

  @override
  String get rangeWeek => 'Uke';

  @override
  String get rangeMonth => 'Måned';

  @override
  String get rangeYear => 'År';

  @override
  String get rangeAll => 'Alt';

  @override
  String get rangeCustom => 'Egendefinert…';

  @override
  String changeSince(String delta, String date) {
    return '$delta siden $date';
  }

  @override
  String get unitsAuto => 'Som i din region';

  @override
  String get unitsMetric => 'Metrisk (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperial (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Vekt';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Hvis det fortsatt feiler på iPhone/iPad: Innstillinger → Personvern og sikkerhet → Lokalt nettverk → tillat cat(a)log og prøv igjen.';

  @override
  String get includePrivate => 'Del private data';

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
  String get starterStatus => 'Type';

  @override
  String get statusFoster => 'Fosterhjem';

  @override
  String get statusForeverHome => 'Hjem';

  @override
  String get statusClinic => 'Klinikk';

  @override
  String get statusShelter => 'Dyrehjem';

  @override
  String get statusBarn => 'Låve';

  @override
  String get valueCat => 'Katt';

  @override
  String get valueDog => 'Hund';

  @override
  String get valueRabbit => 'Kanin';

  @override
  String get valueGuineaPig => 'Marsvin';

  @override
  String get valueHamster => 'Hamster';

  @override
  String get valueBird => 'Fugl';

  @override
  String get valueHorse => 'Hest';

  @override
  String get valueTortoise => 'Skilpadde';

  @override
  String get valueFerret => 'Ilder';

  @override
  String get otherOption => 'Annet…';

  @override
  String get celebrationsToggle => 'Feir adopsjoner';

  @override
  String get celebrationsSubtitle =>
      'Konfetti og jubel når en katt flytter til sitt hjem';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfetti og jubel når et kjæledyr flytter til sitt hjem';

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
  String get mapSearchHintNeutral => 'Søk kjæledyr, husstander, personer';

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
  String get kittensLabelNeutral => 'Unger';

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
  String toastBornNeutral(Object cat) {
    return '✨ Nyfødt: $cat ✨';
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
  String get syncChooserInPersonSub => 'Synkronisering via Wi-Fi';

  @override
  String get syncChooserRemote => 'På avstand';

  @override
  String get syncChooserRemoteSub => 'Synkronisering via mappe eller USB-pinne';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Eksport og import via sosiale medier';

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

  @override
  String get selectClowderHintNeutral => 'Velg en husstand til venstre';

  @override
  String get introTitle1 => 'Kattene dine, organisert';

  @override
  String get introTitle1Neutral => 'Kjæledyrene dine, organisert';

  @override
  String get introBody1 =>
      'Lag et kort for hver katt: bilde, kjønn, helse, alt du vil notere. Kattene grupperes etter hvor de bor — appen kaller et slikt sted en clowder.';

  @override
  String get introBody1Neutral =>
      'Lag et kort for hvert kjæledyr du tar deg av: bilde, kjønn, helse, alt du vil notere. Kjæledyrene grupperes etter hvor de bor — appen kaller et slikt sted en husstand.';

  @override
  String get introTitle2 => 'Virker uten internett';

  @override
  String get introBody2 =>
      'Alt lagres bare på telefonen din. Ingen konto, ingen sky. Ingenting lastes opp med mindre du deler det selv.';

  @override
  String get introTitle3 => 'Arbeid sammen';

  @override
  String get introBody3 =>
      'Alle bruker sin egen app, og dere utveksler data av og til: møtes og skann en kode, bruk en delt mappe, eller send én fil via messenger. Etterpå har alle den samme informasjonen.';

  @override
  String get introSkip => 'Hopp over';

  @override
  String get introNext => 'Neste';

  @override
  String get introDone => 'Sett i gang';

  @override
  String get introReplayTitle => 'Rask intro';

  @override
  String get spotHomeSync =>
      'Her synkroniserer du med kjentfolk. Du bestemmer hva du deler.';

  @override
  String get spotHomeStrays =>
      'Dette kortet samler alle streifere — katter uten hjem. Trykk for å se listen.';

  @override
  String get spotHomeStraysNeutral =>
      'Dette kortet samler alle streifere — kjæledyr uten hjem. Trykk for å se listen.';

  @override
  String get spotHomeMenu =>
      'I denne menyen: finn og slå sammen duplikater, eksporter CSV med mer.';

  @override
  String get spotCatEdit =>
      'Trykk på blyanten for å redigere katten. Tips: hold inne et felt for å redigere det direkte.';

  @override
  String get spotCatEditNeutral =>
      'Trykk på blyanten for å redigere kjæledyret. Tips: hold inne et felt for å redigere det direkte.';

  @override
  String get spotMapLayers =>
      'Leter du etter en savnet katt? Vis sirkler rundt stedene for oppslagene dens og rundt det gamle hjemmet.';

  @override
  String get spotMapLayersNeutral =>
      'Leter du etter et savnet kjæledyr? Vis sirkler rundt stedene for oppslagene og rundt det gamle hjemmet.';

  @override
  String get spotStraysFlier =>
      'Funnet et oppslag om en savnet katt? Fotografer det her — appen lagrer katt og kontakt for deg.';

  @override
  String get spotStraysFlierNeutral =>
      'Funnet et oppslag om et savnet kjæledyr? Fotografer det her — appen lagrer kjæledyr og kontakt for deg.';

  @override
  String get spotStraysScan =>
      'Noen oppslag har en cat(a)log-QR-kode. Skann den her og importer katten uten å taste.';

  @override
  String get spotStraysScanNeutral =>
      'Noen oppslag har en cat(a)log-QR-kode. Skann den her og importer kjæledyret uten å taste.';

  @override
  String get introTitle4 => 'Finn savnede katter';

  @override
  String get introTitle4Neutral => 'Finn savnede kjæledyr';

  @override
  String get introBody4 =>
      'Ser du et oppslag om en savnet katt? Fotografer det i appen: den lagrer katten, eierens kontakt og stedet. Dukker en lignende streifer opp senere, foreslår appen mulige treff.';

  @override
  String get introBody4Neutral =>
      'Ser du et oppslag om et savnet kjæledyr? Fotografer det i appen: den lagrer kjæledyret, eierens kontakt og stedet. Dukker en lignende streifer opp senere, foreslår appen mulige treff.';

  @override
  String get spotMapSearch =>
      'Skriv en katt, et sted eller en person for å hoppe dit på kartet.';

  @override
  String get spotMapSearchNeutral =>
      'Skriv et kjæledyr, et sted eller en person for å hoppe dit på kartet.';

  @override
  String get spotCardChips =>
      'Merk av hva som skal stå på det delbare kortet — resten holdes utenfor.';

  @override
  String get spotCatMenu =>
      'Her er flere handlinger: skjul katten, slå sammen duplikater eller noter en observasjon.';

  @override
  String get spotCatMenuNeutral =>
      'Her er flere handlinger: skjul kjæledyret, slå sammen duplikater eller noter en observasjon.';

  @override
  String get spotDone => 'Skjønner';

  @override
  String get spotReplayTitle => 'Nyhetstur';

  @override
  String get spotReplaySubtitle => 'Vis tipsene igjen på hver side';

  @override
  String get spotReplayDone => 'Tipsene vises igjen';

  @override
  String get searchNoResults => 'Ingen katt funnet med det navnet';

  @override
  String get searchNoResultsNeutral => 'Ingen kjæledyr funnet med det navnet';

  @override
  String get syncUnreachable =>
      'Fikk ikke kontakt med den andre enheten. Er begge på samme Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Fikk ikke tilgang til mappen. Finnes disken eller skymappen fortsatt?';

  @override
  String get crashTitle => 'Dette burde ikke ha skjedd';

  @override
  String get crashBody =>
      'cat(a)log støtte på en uventet feil. Dataene dine er trygge — alt lagres i det øyeblikket du endrer det. Start appen på nytt, og send rapporten hvis det gjentar seg, så det kan fikses.';

  @override
  String get crashRestart => 'Start appen på nytt';

  @override
  String get crashSendReport => 'Send rapport til utvikleren';

  @override
  String get crashLastRunBody =>
      'cat(a)log stoppet uventet sist — sannsynligvis gikk den tom for minne. Sende en kort rapport så det kan fikses?';

  @override
  String get catalogsTitle => 'Kataloger';

  @override
  String get newCatalog => 'Ny katalog';

  @override
  String get intoCatalog => 'Til katalog';

  @override
  String get catalogNameLabel => 'Navn på katalogen';

  @override
  String catalogNameTaken(String name) {
    return 'Det finnes allerede en katalog som heter $name. Velg et annet navn.';
  }

  @override
  String get manageCatalogs => 'Administrer kataloger';

  @override
  String get helpCatalogs =>
      'Hver katalog er sin egen verden: egne katter, kolonier, felt, bilder og synkroniseringspartnere. Berlin og Paris blandes aldri. Trykk på navnet øverst på hjemskjermen for å bytte, legge til eller gi nytt navn. Navnet ditt, språket og tipsene du har sett, deles av alle.';

  @override
  String get helpCatalogsNeutral =>
      'Hver katalog er sin egen verden: egne kjæledyr, husstander, felt, bilder og synkroniseringspartnere. Berlin og Paris blandes aldri. Trykk på navnet øverst på hjemskjermen for å bytte, legge til eller gi nytt navn. Navnet ditt, språket og tipsene du har sett, deles av alle.';

  @override
  String get spotHomeCatalog =>
      'Dette er katalogen du er i. Trykk på navnet for å bytte eller lage en ny.';

  @override
  String get deleteCatalog => 'Slett katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Alt i $name forsvinner: kattene, bildene, historikken. Først lagres en komplett fil der de automatiske sikkerhetskopiene havner — å importere den henter katalogen tilbake. Skriv navnet for å bekrefte.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Alt i $name forsvinner: kjæledyrene, bildene, historikken. Først lagres en komplett fil der de automatiske sikkerhetskopiene havner — å importere den henter katalogen tilbake. Skriv navnet for å bekrefte.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name er slettet. Filen ligger i $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Skriv $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Ingenting ble slettet: katalogfilen kunne ikke skrives ($error). Frigjør plass, eller prøv igjen senere.';
  }

  @override
  String get moveToCatalog => 'Flytt til en annen katalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count flyttet til $name';
  }

  @override
  String get chooseWhatToMove => 'Hva skal flyttes?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Skal noe flyttes til $name?';
  }

  @override
  String get undoThisImport => 'Angre denne importen';

  @override
  String undoImportBody(int count) {
    return 'De $count endringene denne importen brakte inn, fjernes. De skrives først til en fil, og å importere den henter dem tilbake. De du allerede har synkronisert med, beholder kopien sin — det kan ikke tas tilbake.';
  }

  @override
  String undoneImport(String where) {
    return 'Angret. Filen ligger i $where.';
  }

  @override
  String get goBackTitle => 'Gå tilbake';

  @override
  String get goBackToHere => 'Gå tilbake hit';

  @override
  String get momentImport => 'Før importen';

  @override
  String get momentSync => 'Før synkroniseringen';

  @override
  String get momentMerge => 'Før sammenslåingen';

  @override
  String get momentHardDelete => 'Før sletting av en forfatters data';

  @override
  String get momentArchive => 'Før arkiveringen';

  @override
  String get momentManual => 'Merket av deg';

  @override
  String get showOlderMoments => 'Vis eldre';

  @override
  String goBackBody(int count) {
    return 'Alt etter dette øyeblikket fjernes — $count endringer. Det skrives først til en fil, og å importere den henter alt tilbake; hvert nyere øyeblikk følger med. De du allerede har synkronisert med, beholder kopien sin — det kan ikke tas tilbake.';
  }

  @override
  String get nameThisMoment => 'Gi dette øyeblikket et navn';

  @override
  String get helpGoBack =>
      'Øyeblikkene da denne katalogen endret form: før hver import og hver synkronisering, før en sammenslåing, en arkivering eller en sletting — og hver gang du selv merket ett. Velger du ett, går katalogen tilbake til den tilstanden: alt etterpå skrives til en fil du beholder og fjernes så, og hvert nyere øyeblikk følger med. De du allerede har synkronisert med, beholder det de fikk.';

  @override
  String goBackFileFailed(String error) {
    return 'Ingenting ble fjernet: filen som tar vare på det, kunne ikke skrives ($error). Frigjør plass og prøv igjen.';
  }

  @override
  String get goBackChanged =>
      'Ingenting ble fjernet: katalogen endret seg mens filen ble lagret. Prøv igjen.';

  @override
  String get switchBeforeDeleting =>
      'Dette er katalogen du er i. Bytt til en annen, og slett den så.';

  @override
  String shareFileFailed(String error) {
    return 'Delingsfilen kunne ikke skrives ($error). Frigjør plass og prøv igjen.';
  }

  @override
  String get privateLabel => 'Privat';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Merk som privat';

  @override
  String get unmarkPrivate => 'Fjern privat merking';

  @override
  String get agenda => 'Påminnelser';

  @override
  String get reminderLabel => 'Påminnelse';

  @override
  String get agendaEmpty =>
      'Ingen avtaler planlagt. Planlegg nye her med plusset eller på siden til en katt eller clowder.';

  @override
  String get agendaEmptyNeutral =>
      'Ingen avtaler planlagt. Planlegg nye her med plusset eller på siden til et kjæledyr eller en husstand.';

  @override
  String get dueToday => 'i dag';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'om $count dager',
      one: 'om 1 dag',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dager forsinket',
      one: '1 dag forsinket',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Utført';

  @override
  String get repeatTitle => 'Igjen om…';

  @override
  String get noRepeatLabel => 'Ingen gjentakelse';

  @override
  String get unitDays => 'dager';

  @override
  String get unitWeeks => 'uker';

  @override
  String get unitMonths => 'måneder';

  @override
  String get unitYears => 'år';

  @override
  String ageYears(int years) {
    return '$years år';
  }

  @override
  String ageMonths(int months) {
    return '$months mnd';
  }

  @override
  String get changeDateLabel => 'Endre dato';

  @override
  String get removeReminderLabel => 'Fjern påminnelse';

  @override
  String get exportIcs => 'Eksporter kalenderfil';

  @override
  String get resyncCalendar => 'Synkroniser kalender på nytt';

  @override
  String icsSavedTo(String path) {
    return 'Kalenderfil lagret under $path';
  }

  @override
  String get calendarMirrorLabel => 'Speil til enhetens kalender';

  @override
  String get calendarMirrorSubtitle =>
      'Avtalene vises som heldagsavtaler i kalenderen. cat(a)log oppdaterer dem der ved hver start og etter hver endring. Påminnelser om avtalene styrer du i kalenderen.';

  @override
  String get syncPeerOlder =>
      'Den andre enheten kjører et eldre cat(a)log uten påminnelser. Oppdater cat(a)log der, og synkroniser igjen.';

  @override
  String get syncPeerNewer =>
      'Den andre enheten kjører et nyere cat(a)log. Oppdater cat(a)log på denne enheten, og synkroniser igjen.';

  @override
  String get bundleNewerError =>
      'Denne filen kommer fra et nyere cat(a)log. Oppdater cat(a)log på denne enheten for å importere den.';

  @override
  String get spotEar =>
      'Et lite katteøre i et hjørne betyr: hold inne for mer.';

  @override
  String get addReminder => 'Legg til påminnelse';

  @override
  String get plannedSection => 'Planlagt';

  @override
  String get reminderDialogHint =>
      'Avtalen vises i påminnelsene. Der kan du bekrefte eller forkaste den. Verdien overtas først når avtalen er bekreftet.';

  @override
  String get reminderFor => 'For';

  @override
  String get reminderField => 'Felt';

  @override
  String get dueDateLabel => 'Forfallsdato';

  @override
  String get pickCalendar => 'Hvilken kalender?';

  @override
  String get calendarPermissionDenied =>
      'Kalendertilgang er blokkert, så speilingen er slått av. Tillat den i systeminnstillingene, og slå speilingen på igjen.';

  @override
  String get calendarNotChosen =>
      'Ingen kalender valgt, så speilingen er slått av. Slå den på igjen, og velg en.';

  @override
  String get calendarGone =>
      'Den valgte kalenderen finnes ikke lenger, så speilingen er slått av. Slå den på igjen, og velg en annen.';

  @override
  String get noWritableCalendar =>
      'Fant ingen kalender. Logg inn på en kalenderkonto i systeminnstillingene, for eksempel Google, og prøv igjen.';

  @override
  String get spotHomeAgenda =>
      'Påminnelser: listen over planlagte avtaler — veterinær, medisin, kontroller.';

  @override
  String get spotAgendaAdd => 'Planlegg en ny avtale.';

  @override
  String get spotAgendaCalendar =>
      'Slå på speiling av cat(a)log-avtalene til en kalender du velger her.';

  @override
  String get helpAgenda =>
      'Påminnelsene viser de planlagte avtalene etter dato. Det finnes to slag: avtaler med et klokkeslett og påminnelser som gjelder for en dag. Oversette avtaler blir stående øverst. Trykk åpner katten eller clowderen. Haken bekrefter en avtale: Verdien skrives i feltet, og du kan straks planlegge den neste, for eksempel om tre måneder. Hold inne for å endre datoen eller slette avtalen. Bryteren øverst speiler avtalene til en kalender på telefonen din. Menyen eksporterer dem som kalenderfil. Et veterinærbesøk med flere katter er én avtale: kryss av kattene, Agendaen viser ett kort med navnene deres, og ved avslutning spørres det hvilke katter som ble behandlet — fjern krysset for de andre, de forblir planlagt.';

  @override
  String get helpAgendaNeutral =>
      'Påminnelsene viser de planlagte avtalene etter dato. Det finnes to slag: avtaler med et klokkeslett og påminnelser som gjelder for en dag. Oversette avtaler blir stående øverst. Trykk åpner kjæledyret eller husstanden. Haken bekrefter en avtale: Verdien skrives i feltet, og du kan straks planlegge den neste, for eksempel om tre måneder. Hold inne for å endre datoen eller slette avtalen. Bryteren øverst speiler avtalene til en kalender på telefonen din. Menyen eksporterer dem som kalenderfil. Et veterinærbesøk med flere kjæledyr er én avtale: kryss av kjæledyrene, Agendaen viser ett kort med navnene deres, og ved avslutning spørres det hvilke kjæledyr som ble behandlet — fjern krysset for de andre, de forblir planlagt.';

  @override
  String get calendarRowOff => 'Kalender: av';

  @override
  String calendarRowOn(String name) {
    return 'Kalender: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Planlegg en avtale for denne katten. Den vises i påminnelsene og bekreftes der.';

  @override
  String get spotAddReminderCatNeutral =>
      'Planlegg en avtale for dette kjæledyret. Den vises i påminnelsene og bekreftes der.';

  @override
  String get spotAddReminderClowder =>
      'Planlegg en avtale for denne clowderen. Den vises i påminnelsene og bekreftes der.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Planlegg en avtale for denne husstanden. Den vises i påminnelsene og bekreftes der.';

  @override
  String get readOnlyCalendar => 'skrivebeskyttet';

  @override
  String get appointmentLabel => 'Avtale';

  @override
  String get addAppointment => 'Legg til avtale';

  @override
  String get planChooserTitle => 'Avtale eller påminnelse?';

  @override
  String get planChooserAppointment =>
      'Avtale — et besøk på en dato og et tidspunkt, med notater';

  @override
  String get planChooserReminder =>
      'Påminnelse — en verdi som forfaller en dag';

  @override
  String get appointmentTitleLabel => 'Hva';

  @override
  String get notesLabel => 'Notater';

  @override
  String get timeLabel => 'Tidspunkt';

  @override
  String get allDayLabel => 'Hele dagen';

  @override
  String get alertLabel => 'Varsel';

  @override
  String get alertNone => 'Ingen';

  @override
  String get alertDayBefore => 'Dagen før';

  @override
  String get alertHourBefore => 'En time før';

  @override
  String get linkFieldLabel => 'Skriv i et felt når den er utført';

  @override
  String get noLinkedField => 'Ingen felt';

  @override
  String get outcomeTitle => 'Hvordan gikk det?';

  @override
  String get finishLabel => 'Avslutt';

  @override
  String get editLabelAppointment => 'Rediger avtale';

  @override
  String get deleteAppointment => 'Slett avtale';

  @override
  String get stepFlierText => 'Oppslagets tekst';

  @override
  String get qrFoundHint =>
      'En QR-kode ble funnet på oppslaget. Avkryssede koder leses for registernumre og lenker.';

  @override
  String get useCode => 'Bruk denne koden';

  @override
  String get qrNone => 'Ingen QR-kode funnet på bildet.';

  @override
  String qrFailed(String error) {
    return 'Lesing av QR-kode mislyktes: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$name-oppslag gjenkjent. Sjekk nedenfor hvilket felt hver linje går til.';
  }

  @override
  String get flierLayoutUnknown =>
      'Ukjent oppslagsoppsett. Tildel linjene til felt nedenfor; resten blir i merknadene.';

  @override
  String get targetRegistryNumber => 'Registernummer';

  @override
  String get targetLostPlace => 'Adresse (forsvunnet fra)';

  @override
  String get targetContact => 'Registerets kontakt';

  @override
  String get targetDrop => 'Forkast';

  @override
  String get existingCat => 'Eksisterende katt';

  @override
  String get existingCatNeutral => 'Eksisterende kjæledyr';

  @override
  String get existingClowder => 'Eksisterende gruppe';

  @override
  String get existingClowderNeutral => 'Eksisterende husstand';

  @override
  String get createNewInstead => 'Ingen — opprett ny';

  @override
  String overwritesValue(String value) {
    return 'Overskriver nåværende verdi \"$value\"';
  }

  @override
  String get abortScanTitle => 'Avbryte registreringen?';

  @override
  String get abortScanBody => 'Ingenting blir lagret.';

  @override
  String get abortScan => 'Avbryt';

  @override
  String get keepScanning => 'Fortsett';

  @override
  String get catsOnAppointment => 'Katter på denne avtalen';

  @override
  String get catsOnAppointmentNeutral => 'Kjæledyr på denne avtalen';

  @override
  String get noCatsHint => 'Ingen katt avkrysset — avtalen er koloniens egen.';

  @override
  String get noCatsHintNeutral =>
      'Ingen kjæledyr avkrysset — avtalen er husstandens egen.';

  @override
  String get pickCatsTitle => 'Hvilke katter blir med?';

  @override
  String get pickCatsTitleNeutral => 'Hvilke kjæledyr blir med?';

  @override
  String catsCount(int count) {
    return '$count katter';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count kjæledyr';
  }

  @override
  String get finishUntickHint =>
      'Fjern krysset for katter som ikke ble behandlet; de forblir planlagt.';

  @override
  String get finishUntickHintNeutral =>
      'Fjern krysset for kjæledyr som ikke ble behandlet; de forblir planlagt.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Slett avtalen for alle $count katter';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Slett avtalen for alle $count kjæledyr';
  }
}
