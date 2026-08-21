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
      'Ingen clowdere endnu. En clowder er et sted, hvor katte bor — dit plejehjem, en adoptants lejlighed. Opret den første nedenfor.';

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
      'Katten forsvinder fra alle lister, og dens fotos fjernes — her og, efter næste synkronisering, også på de andre enheder.';

  @override
  String get sightingRecorded => 'Observation registreret på din position.';

  @override
  String get noLocationAvailable =>
      'Ingen placering tilgængelig — hold i stedet kortet nede.';

  @override
  String get locationDeniedForever =>
      'Adgang til placering er blokeret. Tillad den i systemindstillingerne for at bruge Stray Cam.';

  @override
  String get locationServiceOff =>
      'Placering er slået fra på denne enhed. Slå den til i indstillingerne og prøv igen.';

  @override
  String get locationDenied =>
      'cat(a)log har ikke tilladelse til at bruge din placering. Prøv igen og tillad det, når du bliver spurgt.';

  @override
  String get locationNoFix =>
      'Din position kunne ikke bestemmes lige nu. Prøv igen udendørs — GPS kræver frit udsyn til himlen.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Chipnummer';

  @override
  String get starterRemarks => 'Bemærkninger';

  @override
  String get captureFlier => 'Fotografér opslag';

  @override
  String get addPhotosTo => 'Føj fotos til…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foto(s) føjet til $name';
  }

  @override
  String get scanPrintedCode => 'Scan trykt kode';

  @override
  String get chipScanHint =>
      'Scanner den trykte QR/stregkode fra chipkortet eller dyrlægepapirer — telefonen kan ikke læse chippen i katten.';

  @override
  String get savingLabel => 'Gemmer…';

  @override
  String ownerOfCat(String name) {
    return 'Ejer af $name';
  }

  @override
  String get sortLabel => 'Sortér';

  @override
  String get viewAsTable => 'Vis som tabel';

  @override
  String get viewAsTiles => 'Vis som fliser';

  @override
  String get matchCandidatesTitle => 'Mulige match';

  @override
  String get findDuplicates => 'Find dubletter';

  @override
  String get noDuplicates => 'Ingen mulige dubletter lige nu.';

  @override
  String get similarName => 'Lignende navn';

  @override
  String get sharePublicly => 'Del offentligt…';

  @override
  String get privateNoShare =>
      'Denne kat er markeret som privat — private data forlader aldrig din enhed. Fjern markeringen først for at dele den offentligt.';

  @override
  String get pickFramesTitle => 'Vælg billeder';

  @override
  String get suggestedFrames => 'Foreslåede billeder';

  @override
  String get scrubFrames => 'Spol i videoen';

  @override
  String get keepThisFrame => 'Behold dette billede';

  @override
  String get fromVideo => 'Fra video…';

  @override
  String get videoMobileOnly =>
      'Billeder fra video virker i telefon-appen (Android og iPhone) — endnu ikke på denne enhed.';

  @override
  String get shareWhitelistExplainer =>
      'Vælg, hvad der kommer i filen. Kun markerede felter medtages.';

  @override
  String get exportShareFile => 'Eksportér delingsfil…';

  @override
  String get hostedLink => 'Hostet link (URL til den uploadede fil)';

  @override
  String get inlineQr => 'Indlejret QR (kun tekst, ingen fotos)';

  @override
  String get inlineTooBig =>
      'For mange data til en indlejret kode — fravælg felter eller brug et hostet link.';

  @override
  String get scanShareLabel => 'Scan delingskode';

  @override
  String get notAShareCode => 'Denne kode er ikke en cat(a)log-deling.';

  @override
  String get importShareTitle => 'Importér denne kat?';

  @override
  String shareSource(String url) {
    return 'Kilde: $url';
  }

  @override
  String get importLabel => 'Importér';

  @override
  String get strayAreaLabel => 'Muligt strejfområde';

  @override
  String get prevPin => 'Forrige nål';

  @override
  String get nextPin => 'Næste nål';

  @override
  String get noMissingCats =>
      'Ingen savnede katte med opslagspositioner endnu.';

  @override
  String get noMatchCandidates => 'Ingen mulige match lige nu.';

  @override
  String sameIdField(String field) {
    return 'Samme $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m fra hinanden';
  }

  @override
  String get addFlier => 'Tilføj opslag';

  @override
  String get missingSinceLabel => 'Savnet siden';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Beskær portræt';

  @override
  String get statusOwner => 'Ejer';

  @override
  String get ocrUnavailable =>
      'Tekstgenkendelse er ikke tilgængelig på denne enhed — skriv selv opslagets tekst.';

  @override
  String get displayFormat => 'Vises som';

  @override
  String get displayPlain => 'Almindelig tekst';

  @override
  String get displayQr => 'QR-kode';

  @override
  String get displayBarcode => 'Stregkode';

  @override
  String get editLabel => 'Rediger';

  @override
  String get doneLabel => 'Færdig';

  @override
  String get openSettings => 'Åbn indstillinger';

  @override
  String get notSaved => 'Ikke gemt';

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
    return 'Fødselsdatoen kan ikke ligge efter dødsdatoen ($date).';
  }

  @override
  String get malePregnant =>
      'Denne kat er registreret som han — en hankat kan ikke være drægtig. Tjek kønnet først.';

  @override
  String fatherNotMale(String name) {
    return '$name er registreret som hun og kan ikke være faren. Tjek kønnet først.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name er registreret som han og kan ikke være moren. Tjek kønnet først.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name er født $date — en forælder kan ikke være født efter sin killing.';
  }

  @override
  String get genderFatherFemale =>
      'Denne kat er registreret som far til andre katte — faren kan ikke være hun. Tjek familien først.';

  @override
  String get genderMotherMale =>
      'Denne kat er registreret som mor til andre katte — moren kan ikke være han. Tjek familien først.';

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
  String dateFormatError(String format) {
    return 'Forkert format — brug $format';
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
  String get ownValue => 'Egen værdi';

  @override
  String get renameField => 'Omdøb felt';

  @override
  String get editOptions => 'Redigér valgmuligheder…';

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
      'Begge enheder bruger samme mappe (fx i Dropbox eller på et USB-stik). Hver synkronisering lægger dine ændringer der og henter den andens.';

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
  String get starterBreed => 'Race';

  @override
  String get valueMixed => 'blanding';

  @override
  String get breedEuropeanShorthair => 'Europæisk korthår';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britisk korthår';

  @override
  String get breedNorwegianForestCat => 'Norsk skovkat';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Opslagslink';

  @override
  String lookupUrlHelp(String token) {
    return 'Tjenestens side med $token der hvor nummeret står, fx https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Slå op';

  @override
  String lookupFailed(String url) {
    return 'Ingen app kunne åbne $url. Kopiér linket ind i en browser.';
  }

  @override
  String get stepCat => 'Kat';

  @override
  String get stepOwner => 'Ejer';

  @override
  String get stepFace => 'Ansigtsfoto';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Tjek og gem';

  @override
  String get stepOwnerHint =>
      'Den, der savner katten — det bliver deres kort, med kontakten fra opslaget.';

  @override
  String get stepFaceHint =>
      'Klip kattens ansigt ud af opslaget; det bliver profilbilledet. Du kan springe over.';

  @override
  String get stepRegistryHint =>
      'Numre fundet på opslaget. De markerede gemmes ved katten og kan åbnes senere.';

  @override
  String get noRegistryLinks =>
      'Ingen registerlinks på dette opslag — intet at gøre her.';

  @override
  String get unknownServiceHint => 'Ukendt tjeneste';

  @override
  String get rememberService => 'Husk tjenesten';

  @override
  String get rememberServiceHint =>
      'Giv tjenesten et navn, og peg på nummeret i linket. Næste opslag udfylder sig selv.';

  @override
  String get noIdInLink =>
      'Dette link indeholder intet nummer, appen kan gemme.';

  @override
  String get whichNumber => 'Hvilken del er nummeret?';

  @override
  String get cropAgain => 'Beskær igen';

  @override
  String get noFaceYet => 'Endnu intet ansigtsfoto — opslagets foto bruges.';

  @override
  String get backLabel => 'Tilbage';

  @override
  String get dangerButton => 'TRYK IKKE.\nFARE';

  @override
  String get dangerThanks => 'Tak fordi du bruger cat(a)log!';

  @override
  String get helpTitle => 'Hjælp';

  @override
  String get showTipsAgain => 'Vis tips igen';

  @override
  String get helpHome =>
      'Oversigten over dine kolonier — en koloni er et sted, hvor katte bor: dit hjem, en plejefamilie, et internat. Tryk på et kort for at se dets katte; hold nede for menuen. Knappen nederst til højre laver en ny koloni, og strejferkortet samler alle katte uden hjem.';

  @override
  String get helpClowder =>
      'Alt om dette sted: dets katte, dets felter (adresse, kontakt, type) og dets historik. Siden åbner skrivebeskyttet; blyanten slår redigering til, hvor du også kan tilføje et felt. Hold et felt nede for at redigere det direkte, en kat for at flytte, skjule eller åbne den.';

  @override
  String get helpCat =>
      'Alt om denne kat: fotos, felter, familie, historik. Siden er skrivebeskyttet, indtil du trykker på blyanten. Hold et felt nede for at redigere det direkte; et foto for dets menu. Menuen øverst til højre har resten: markér privat, skjul, flet, notér observation, del.';

  @override
  String get helpStrays =>
      'Katte uden hjem lige nu: fundne, undslupne eller fra et opslag. Kameraknappen registrerer en kat foran dig; opslagsknappen laver et savnet-opslag om til en kat med ejerens kontakt; scanneren læser en cat(a)log-kode fra opslaget.';

  @override
  String get helpMap =>
      'Alle katte og steder med en position. Søgningen finder katte, personer og steder — et ukendt navn slås op i hele verden. Lagknappen tegner 500 m-cirklerne omkring en savnet kats opslagssteder og omkring dens tidligere hjem. Pilene går fra nål til nål, langt tryk noterer en observation.';

  @override
  String get helpCard =>
      'Kattens kort til print: vælg øverst med chipsene, hvad der står på det, og del det som billede eller PDF. Numre kan printes som QR eller stregkode, og en position bliver til en QR, der åbner et kort, plus en kort Plus Code.';

  @override
  String get helpSync =>
      'Sådan når data frem til andre: forbind direkte, brug en mappe begge enheder ser, eller send en fil via en messenger. Du bestemmer altid, hvad der sendes — og modtagne .catsync-filer åbnes også her.';

  @override
  String get helpFields =>
      'De felter, dit katalog bruger. Omdøb dem, ændr valgmulighederne i et valgfelt, eller lav dine egne. Et id-felt kan pege på en tjeneste (et register), så bliver nummeret trykbart ved katten.';

  @override
  String get helpTimeline =>
      'Hver eneste ændring, nyeste først: hvem der ændrede hvad, hvornår og til hvilken værdi. Enhver post kan fortrydes — det skriver en ny post, intet slettes nogensinde.';

  @override
  String get helpDuplicates =>
      'Katte eller kolonier, der ser ud til at findes to gange — ens numre eller meget lignende navne med matchende detaljer. Tryk på et par for at flette; fletning kan ikke fortrydes, derfor spørges der først.';

  @override
  String get helpMatches =>
      'Katte, der kan være samme dyr: samme nummer, eller en strejfer set inde i en savnet kats søgeområde. Tryk på et par for at flette, hold nede for at åbne den første kat og sammenligne.';

  @override
  String get helpFlier =>
      'Et fotograferet opslag bliver til en kat plus ejer. Trin for trin: kattens data, ejerens kontakt, beskæring af ansigtet til profilbilledet, registernumre fra opslaget og til sidst et tjek. Alt er forslag — ret det, kameraet læste forkert.';

  @override
  String get archiveTitle => 'Arkiv';

  @override
  String get archiveExplainer =>
      'Afdøde katte og tomme kolonier, som ingen har rørt i årevis, fylder stadig — især deres fotos. Arkivering skriver dem til en fil, du gemmer, og sletter dem derefter her.';

  @override
  String get archiveAction => 'Arkivér';

  @override
  String archiveSelected(int count) {
    return 'Arkivér $count poster';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arkivér $count poster?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names skrives til en fil og slettes derefter — på din enhed og på alle enheder, du synkroniserer med. Importerer du filen, er alt tilbage; uden den er de væk.';
  }

  @override
  String archiveDone(int count) {
    return '$count poster arkiveret og slettet';
  }

  @override
  String archiveFailed(String error) {
    return 'Intet blev slettet: arkivfilen kunne ikke skrives ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Database $db, fotos $photos i $count filer';
  }

  @override
  String quietForYears(int years) {
    return 'Uden ændringer i $years år';
  }

  @override
  String get nothingToArchive => 'Intet er gammelt nok til at arkivere.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Sidste ændring $date · fotos $size';
  }

  @override
  String get helpArchive =>
      'Gamle data fylder, især billederne, som hver synkroniseret enhed slæber rundt på. Her vælger du afdøde katte og tomme kolonier, der har ligget stille i årevis, skriver dem til en fil, du gemmer, og sletter dem. Sletningen når alle, du synkroniserer med; import af filen gendanner alt.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Gendan $count slettede poster?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names er slettet i dette katalog, og filen du lige importerede indeholder dem. Gendannelse henter dem tilbage her og på alle enheder, du synkroniserer med.';
  }

  @override
  String get restoreAction => 'Gendan';

  @override
  String get keepDeleted => 'Behold slettet';

  @override
  String get archiveNotSaved =>
      'Intet blev slettet: arkivet blev ikke gemt nogen steder.';

  @override
  String get locateAddress => 'Find adressen på kortet';

  @override
  String get addressLocated => 'Adresse fundet';

  @override
  String get addressNotFound =>
      'Der blev ikke fundet noget sted for denne adresse. Tjek stavningen, eller lad feltet stå tomt.';

  @override
  String get starterPosition => 'Placering';

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
  String get applyCrop => 'Beskær';

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
  String lastBackupFailed(String error) {
    return 'Seneste automatiske backup mislykkedes: $error';
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
  String get markPrivate => 'Markér som privat';

  @override
  String get unmarkPrivate => 'Fjern privat markering';

  @override
  String get includePrivate => 'Medtag private data';

  @override
  String get includePrivateExplainer =>
      'Dette sender også alt, du har markeret som privat. Den, du synkroniserer med, vil se det.';

  @override
  String get hideLabel => 'Skjul på denne enhed';

  @override
  String get unhideLabel => 'Vis igen';

  @override
  String get showHiddenLabel => 'Vis skjulte';

  @override
  String get stopShowingHidden => 'Stop med at vise skjulte';

  @override
  String get starterSpecies => 'Art';

  @override
  String get starterStatus => 'Type';

  @override
  String get statusFoster => 'Plejehjem';

  @override
  String get statusForeverHome => 'For-evigt-hjem';

  @override
  String get statusClinic => 'Klinik';

  @override
  String get statusShelter => 'Internat';

  @override
  String get statusBarn => 'Lade';

  @override
  String get valueCat => 'Kat';

  @override
  String get otherOption => 'Andet…';

  @override
  String get celebrationsToggle => 'Fejr adoptioner';

  @override
  String get celebrationsSubtitle =>
      'Konfetti og jubel, når en kat flytter til sit for-evigt-hjem';

  @override
  String get onMapLabel => 'På kortet';

  @override
  String get showOnMap => 'Vis på kort';

  @override
  String get searchPlaceHint => 'Søg sted eller adresse';

  @override
  String get noPlacesFound => 'Ingen steder fundet';

  @override
  String get mapSearchHint => 'Søg katte, grupper, personer';

  @override
  String get proposeAnotherName => 'Foreslå et andet navn';

  @override
  String get moderationTitle => 'Forfattere & udelukkelser';

  @override
  String get moderationSubtitle => 'Fjern en persons data for altid';

  @override
  String get authorsSection => 'Hvem har skrevet i kataloget';

  @override
  String get hardDeleteAction => 'Slet alt fra denne forfatter';

  @override
  String hardDeleteWarning(Object name) {
    return 'Fjerner alle poster og fotos fra $name på denne enhed. Andre enheder beholder deres. Kan ikke fortrydes.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Skriv $name for at bekræfte';
  }

  @override
  String get alsoBan => 'Udeluk også — modtag aldrig data igen';

  @override
  String get bansSection => 'Udelukkelser';

  @override
  String get unbanAction => 'Fjern udelukkelse';

  @override
  String get deletedDone => 'Slettet.';

  @override
  String get syncSummaryTitle => 'Hvad der kom';

  @override
  String get summaryAdopted => 'Adopteret';

  @override
  String get summaryDeceased => 'Afdøde';

  @override
  String get summaryEscaped => 'Bortløbne';

  @override
  String get summaryNew => 'Nye';

  @override
  String get summaryConflicts => 'Konflikter at løse';

  @override
  String summaryOther(Object n) {
    return '…og $n andre ændringer';
  }

  @override
  String get starterMother => 'Mor';

  @override
  String get starterFather => 'Far';

  @override
  String get familySection => 'Familie';

  @override
  String get littermatesLabel => 'Kuldsøskende';

  @override
  String get siblingsLabel => 'Søskende';

  @override
  String get kittensLabel => 'Killinger';

  @override
  String get toastSettingsTitle => 'Hvad der meldes';

  @override
  String get toastSettingsSubtitle => 'Små beskeder efter en synkronisering';

  @override
  String get toastKindAdoptions => 'Adoptioner';

  @override
  String get toastKindBirths => 'Fødsler';

  @override
  String get toastKindDeaths => 'Dødsfald';

  @override
  String get toastKindEscapes => 'Flugter';

  @override
  String get toastKindMoves => 'Flytninger';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adopteret af $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Ny killing: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat er død';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat er stukket af';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat er flyttet til $home';
  }

  @override
  String get notACatlogFile => 'Det er ikke en cat(a)log-fil';

  @override
  String get nothingNewInBundle => 'Intet nyt i filen — du har allerede alt';

  @override
  String get syncChooserInPerson => 'Personligt';

  @override
  String get syncChooserInPersonSub =>
      'I er i samme rum — scan en kode, færdig på sekunder';

  @override
  String get syncChooserRemote => 'På afstand';

  @override
  String get syncChooserRemoteSub =>
      'Via en delt mappe som Dropbox eller et USB-stik';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Send alt som én fil gennem enhver messenger — og importér en modtaget .catsync-fil her';

  @override
  String get connectToWifiFirst =>
      'Forbind til Wi-Fi først — så kan enhederne finde hinanden';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vil synkronisere';
  }

  @override
  String get trustBothWaysNote =>
      'Jeres kataloger udveksles i begge retninger.';

  @override
  String get allowOnce => 'Tillad';

  @override
  String get allowAlways => 'Tillad altid denne enhed';

  @override
  String get declineAction => 'Afvis';

  @override
  String get syncDeclined => 'Den anden enhed afviste synkroniseringen';

  @override
  String get trustedDevicesSection => 'Altid tilladte enheder';

  @override
  String get removeTrust => 'Fjern';

  @override
  String get hostWithoutWifi => 'Vær vært uden Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Opretter en midlertidig direkte forbindelse til den anden telefon (uden internet). Kun cat(a)log bruger den, og den afbrydes selv efter synkroniseringen.';

  @override
  String get hotspotAndroidOnly =>
      'Denne kode kræver to Android-telefoner — brug et fælles Wi-Fi på iPhone/iPad';

  @override
  String get selectClowderHint => 'Vælg en clowder til venstre';

  @override
  String get introTitle1 => 'Dine katte, organiseret';

  @override
  String get introBody1 =>
      'Opret et kort for hver kat: foto, køn, helbred, alt du vil notere. Kattene grupperes efter hvor de bor — appen kalder sådan et sted en clowder.';

  @override
  String get introTitle2 => 'Virker uden internet';

  @override
  String get introBody2 =>
      'Alt gemmes kun på din telefon. Ingen konto, ingen sky. Intet uploades, medmindre du selv deler det.';

  @override
  String get introTitle3 => 'Arbejd sammen';

  @override
  String get introBody3 =>
      'Alle bruger deres egen app, og I udveksler data af og til: mødes og scan en kode, brug en delt mappe, eller send én fil via messenger. Bagefter har alle de samme oplysninger.';

  @override
  String get introSkip => 'Spring over';

  @override
  String get introNext => 'Næste';

  @override
  String get introDone => 'Kom i gang';

  @override
  String get introReplayTitle => 'Hurtig intro';

  @override
  String get spotHomeSync =>
      'Her synkroniserer du med dine bekendte. Du bestemmer, hvad du deler.';

  @override
  String get spotHomeStrays =>
      'Dette kort samler alle strejfere — katte uden hjem. Tryk for at se listen.';

  @override
  String get spotHomeMenu =>
      'I denne menu: find og flet dubletter, eksportér CSV med mere.';

  @override
  String get spotCatEdit =>
      'Tryk på blyanten for at redigere katten. Tip: hold et felt nede for at redigere det direkte.';

  @override
  String get spotMapLayers =>
      'Leder du efter en savnet kat? Vis cirkler omkring stederne for dens opslag og omkring dens tidligere hjem.';

  @override
  String get spotStraysFlier =>
      'Fundet et opslag om en savnet kat? Fotografér det her — appen gemmer kat og kontakt for dig.';

  @override
  String get spotStraysScan =>
      'Nogle opslag har en cat(a)log-QR-kode. Scan den her og importér katten uden at taste.';

  @override
  String get introTitle4 => 'Find savnede katte';

  @override
  String get introBody4 =>
      'Ser du et opslag om en savnet kat? Fotografér det i appen: den gemmer katten, ejerens kontakt og stedet. Dukker en lignende strejfer op senere, foreslår appen mulige match.';

  @override
  String get spotMapSearch =>
      'Skriv en kat, et sted eller en person for at hoppe derhen på kortet.';

  @override
  String get spotCardChips =>
      'Markér, hvad der skal stå på det delbare kort — resten holdes ude.';

  @override
  String get spotCatMenu =>
      'Flere handlinger her: markér katten som privat, skjul den, flet dubletter eller notér en observation.';

  @override
  String get spotDone => 'Forstået';

  @override
  String get spotReplayTitle => 'Nyheds-rundtur';

  @override
  String get spotReplaySubtitle => 'Vis tips igen på hver side';

  @override
  String get spotReplayDone => 'Tipsene vises igen';

  @override
  String get searchNoResults => 'Ingen kat fundet med det navn';

  @override
  String get syncUnreachable =>
      'Kunne ikke nå den anden enhed. Er begge på samme Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Kunne ikke nå mappen. Findes drevet eller cloud-mappen stadig?';

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

  @override
  String get catalogsTitle => 'Kataloger';

  @override
  String get newCatalog => 'Nyt katalog';

  @override
  String get catalogNameLabel => 'Katalogets navn';

  @override
  String catalogNameTaken(String name) {
    return 'Der findes allerede et katalog, der hedder $name. Vælg et andet navn.';
  }

  @override
  String get manageCatalogs => 'Administrer kataloger';

  @override
  String get helpCatalogs =>
      'Hvert katalog er sin egen verden: egne katte, kolonier, felter, fotos og synkroniseringspartnere. Berlin og Paris blandes aldrig. Tryk på navnet øverst på hjemmeskærmen for at skifte, tilføje eller omdøbe. Dit navn, dit sprog og de tips, du har set, deles af alle.';

  @override
  String get spotHomeCatalog =>
      'Det er kataloget, du er i. Tryk på navnet for at skifte eller oprette et nyt.';

  @override
  String get deleteCatalog => 'Slet katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Alt i $name forsvinder: katte, fotos, historik. Først gemmes en komplet fil dér, hvor de automatiske sikkerhedskopier ligger — import af den henter kataloget tilbage. Skriv navnet for at bekræfte.';
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
    return 'Intet blev slettet: katalogfilen kunne ikke skrives ($error). Frigør plads, eller prøv igen senere.';
  }

  @override
  String get moveToCatalog => 'Flyt til et andet katalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count flyttet til $name';
  }

  @override
  String get chooseWhatToMove => 'Hvad skal flyttes?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Skal noget flyttes til $name?';
  }
}
