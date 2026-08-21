// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Welkom bij cat(a)log';

  @override
  String get welcomeBody =>
      'Kies een naam voor jezelf. Elke wijziging wordt onder deze naam vastgelegd, zodat anderen zien wie wat deed.';

  @override
  String get yourName => 'Je naam';

  @override
  String get start => 'Beginnen';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet =>
      'Nog geen clowders. Een clowder is een plek waar katten wonen — jouw opvang, de flat van een adoptant. Maak de eerste hieronder.';

  @override
  String get strays => 'Zwerfkatten';

  @override
  String get searchCats => 'Katten zoeken';

  @override
  String get map => 'Kaart';

  @override
  String get sync => 'Synchroniseren';

  @override
  String get fields => 'Velden';

  @override
  String get exportCsv => 'CSV exporteren';

  @override
  String get aboutAndFeedback => 'Over & feedback';

  @override
  String get newClowder => 'Nieuwe clowder';

  @override
  String get name => 'Naam';

  @override
  String get cancel => 'Annuleren';

  @override
  String get create => 'Aanmaken';

  @override
  String get save => 'Opslaan';

  @override
  String get delete => 'Verwijderen';

  @override
  String get merge => 'Samenvoegen';

  @override
  String get resolve => 'Oplossen';

  @override
  String get open => 'Openen';

  @override
  String csvSavedTo(String path) {
    return 'CSV opgeslagen in $path';
  }

  @override
  String get renameClowder => 'Clowder hernoemen';

  @override
  String get rename => 'Hernoemen';

  @override
  String get timeline => 'Tijdlijn';

  @override
  String get mergeInto => 'Samenvoegen met…';

  @override
  String get deleteClowder => 'Clowder verwijderen';

  @override
  String get cats => 'Katten';

  @override
  String get addCat => 'Kat toevoegen';

  @override
  String get newCat => 'Nieuwe kat';

  @override
  String deleteQuestion(String name) {
    return '$name verwijderen?';
  }

  @override
  String get deleteClowderEmptyBody => 'De clowder verdwijnt uit de lijst.';

  @override
  String deleteClowderBody(int count) {
    return 'Zijn $count kat(ten) worden niet verwijderd — ze worden zwerfkatten. Verplaats ze eerst naar een andere clowder als dat niet de bedoeling is.';
  }

  @override
  String get card => 'Kaart';

  @override
  String get shareAsImage => 'Delen als afbeelding';

  @override
  String get shareAsPdf => 'Delen als PDF';

  @override
  String get print => 'Afdrukken';

  @override
  String cardTitle(String name) {
    return 'Kaart — $name';
  }

  @override
  String get renameCat => 'Kat hernoemen';

  @override
  String get seenHereNow => 'Hier gezien';

  @override
  String get deleteCat => 'Kat verwijderen';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Zwerfkat — geen clowder';

  @override
  String get stray => 'Zwerfkat';

  @override
  String get photos => 'Foto\'s';

  @override
  String get addPhoto => 'Foto toevoegen';

  @override
  String get setAsProfileImage => 'Instellen als profielfoto';

  @override
  String get thisIsProfileImage => 'Dit is de profielfoto';

  @override
  String get deletePhoto => 'Foto verwijderen';

  @override
  String get deletePhotoTitle => 'Foto verwijderen?';

  @override
  String get deletePhotoBody =>
      'De fotogegevens worden definitief verwijderd — dit kan niet ongedaan worden gemaakt.';

  @override
  String get deleteCatBody =>
      'De kat verdwijnt uit alle lijsten en de foto\'s worden verwijderd — hier en, na de volgende synchronisatie, ook op de andere apparaten.';

  @override
  String get sightingRecorded => 'Waarneming vastgelegd op je positie.';

  @override
  String get noLocationAvailable =>
      'Geen locatie beschikbaar — houd in plaats daarvan de kaart ingedrukt.';

  @override
  String get locationDeniedForever =>
      'Locatietoegang is geblokkeerd. Sta het toe in de systeeminstellingen om Stray Cam te gebruiken.';

  @override
  String get locationServiceOff =>
      'Locatie staat uit op dit apparaat. Zet hem aan in de instellingen en probeer het opnieuw.';

  @override
  String get locationDenied =>
      'cat(a)log heeft geen toestemming om je locatie te gebruiken. Probeer het opnieuw en sta het toe wanneer erom wordt gevraagd.';

  @override
  String get locationNoFix =>
      'Je positie kon nu niet worden bepaald. Probeer het buiten opnieuw — GPS heeft vrij zicht op de hemel nodig.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Chipnummer';

  @override
  String get starterRemarks => 'Opmerkingen';

  @override
  String get captureFlier => 'Poster fotograferen';

  @override
  String get addPhotosTo => 'Foto\'s toevoegen aan…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foto(\'s) toegevoegd aan $name';
  }

  @override
  String get scanPrintedCode => 'Gedrukte code scannen';

  @override
  String get chipScanHint =>
      'Scant de gedrukte QR/streepjescode van de chipkaart of dierenartspapieren — de chip in de kat kan een telefoon niet lezen.';

  @override
  String get savingLabel => 'Opslaan…';

  @override
  String ownerOfCat(String name) {
    return 'Eigenaar van $name';
  }

  @override
  String get sortLabel => 'Sorteren';

  @override
  String get viewAsTable => 'Als tabel tonen';

  @override
  String get viewAsTiles => 'Als tegels tonen';

  @override
  String get matchCandidatesTitle => 'Mogelijke matches';

  @override
  String get findDuplicates => 'Duplicaten zoeken';

  @override
  String get noDuplicates => 'Momenteel geen mogelijke duplicaten.';

  @override
  String get similarName => 'Vergelijkbare naam';

  @override
  String get sharePublicly => 'Openbaar delen…';

  @override
  String get privateNoShare =>
      'Deze kat is gemarkeerd als privé — privégegevens verlaten je apparaat nooit. Verwijder eerst de markering om openbaar te delen.';

  @override
  String get pickFramesTitle => 'Frames kiezen';

  @override
  String get suggestedFrames => 'Voorgestelde frames';

  @override
  String get scrubFrames => 'Door de video spoelen';

  @override
  String get keepThisFrame => 'Dit frame bewaren';

  @override
  String get fromVideo => 'Uit video…';

  @override
  String get videoMobileOnly =>
      'Frames uit een video kiezen werkt in de telefoon-app (Android en iPhone) — nog niet op dit apparaat.';

  @override
  String get shareWhitelistExplainer =>
      'Kies wat er in het bestand komt. Alleen aangevinkte velden gaan mee.';

  @override
  String get exportShareFile => 'Deelbestand exporteren…';

  @override
  String get hostedLink => 'Gehoste link (URL van het geüploade bestand)';

  @override
  String get inlineQr => 'Ingesloten QR (alleen tekst, geen foto\'s)';

  @override
  String get inlineTooBig =>
      'Te veel gegevens voor een ingesloten code — vink velden uit of gebruik een gehoste link.';

  @override
  String get scanShareLabel => 'Deelcode scannen';

  @override
  String get notAShareCode => 'Die code is geen cat(a)log-share.';

  @override
  String get importShareTitle => 'Deze kat importeren?';

  @override
  String shareSource(String url) {
    return 'Bron: $url';
  }

  @override
  String get importLabel => 'Importeren';

  @override
  String get strayAreaLabel => 'Mogelijk zwerfgebied';

  @override
  String get prevPin => 'Vorige speld';

  @override
  String get nextPin => 'Volgende speld';

  @override
  String get noMissingCats => 'Nog geen vermiste katten met posterposities.';

  @override
  String get noMatchCandidates => 'Momenteel geen mogelijke matches.';

  @override
  String sameIdField(String field) {
    return 'Zelfde $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m van elkaar';
  }

  @override
  String get addFlier => 'Poster toevoegen';

  @override
  String get missingSinceLabel => 'Vermist sinds';

  @override
  String get phoneLabel => 'Telefoon';

  @override
  String get cropPortrait => 'Portret bijsnijden';

  @override
  String get statusOwner => 'Eigenaar';

  @override
  String get ocrUnavailable =>
      'Tekstherkenning is niet beschikbaar op dit apparaat — typ de postertekst zelf.';

  @override
  String get displayFormat => 'Weergegeven als';

  @override
  String get displayPlain => 'Platte tekst';

  @override
  String get displayQr => 'QR-code';

  @override
  String get displayBarcode => 'Streepjescode';

  @override
  String get editLabel => 'Bewerken';

  @override
  String get doneLabel => 'Klaar';

  @override
  String get openSettings => 'Instellingen openen';

  @override
  String get notSaved => 'Niet opgeslagen';

  @override
  String get birthdateInFuture =>
      'De geboortedatum kan niet in de toekomst liggen.';

  @override
  String get deceasedInFuture =>
      'De sterfdatum kan niet in de toekomst liggen.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'De sterfdatum kan niet vóór de geboortedatum ($date) liggen.';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'De geboortedatum kan niet na de sterfdatum ($date) liggen.';
  }

  @override
  String get malePregnant =>
      'Deze kat staat geregistreerd als mannetje — een kater kan niet drachtig zijn. Controleer eerst het geslacht.';

  @override
  String fatherNotMale(String name) {
    return '$name staat geregistreerd als vrouwtje en kan niet de vader zijn. Controleer eerst het geslacht.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name staat geregistreerd als mannetje en kan niet de moeder zijn. Controleer eerst het geslacht.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name is geboren op $date — een ouder kan niet na zijn kitten geboren zijn.';
  }

  @override
  String get genderFatherFemale =>
      'Deze kat staat geregistreerd als vader van andere katten — de vader kan geen vrouwtje zijn. Controleer eerst de familie.';

  @override
  String get genderMotherMale =>
      'Deze kat staat geregistreerd als moeder van andere katten — de moeder kan geen mannetje zijn. Controleer eerst de familie.';

  @override
  String get moveTo => 'Verplaatsen naar';

  @override
  String get noClowderStrayOption => 'Geen clowder — zwerfkat / weggelopen';

  @override
  String timelineOf(String name) {
    return 'Tijdlijn — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Deze wijziging terugdraaien';

  @override
  String get revertSubtitle =>
      'Zet de vorige waarde terug als nieuwe invoer — de tijdlijn bewaart beide.';

  @override
  String fieldCleared(String field) {
    return '$field leeggemaakt';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field terug naar \"$value\"';
  }

  @override
  String get leftStray => 'Vertrokken — zwerfkat';

  @override
  String movedTo(String name) {
    return 'Verhuisd naar $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat is aangekomen';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat kwam van $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat vertrok naar $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicaat samengevoegd';

  @override
  String get asOfToday => 'Per vandaag';

  @override
  String asOfDate(String date) {
    return 'Per $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Verkeerd formaat — gebruik $format';
  }

  @override
  String get value => 'Waarde';

  @override
  String get latitudeLongitude => 'breedtegraad, lengtegraad';

  @override
  String get newField => 'Nieuw veld';

  @override
  String get fieldType => 'Type';

  @override
  String get usedOn => 'Gebruikt voor';

  @override
  String get forCats => 'katten';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'beide';

  @override
  String get optionsOnePerLine => 'Opties (één per regel)';

  @override
  String get ownValue => 'Eigen waarde';

  @override
  String get renameField => 'Veld hernoemen';

  @override
  String get editOptions => 'Opties bewerken…';

  @override
  String get noStraysRightNow => 'Momenteel geen zwerfkatten.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Zwerfkat toevoegen';

  @override
  String get newStray => 'Nieuwe zwerfkat';

  @override
  String get searchByNameHint => 'Katten op naam zoeken…';

  @override
  String get host => 'Hosten';

  @override
  String get hostExplainer =>
      'Begin hier en voer daarna het adres en de PIN op het andere apparaat in.';

  @override
  String get startHosting => 'Beginnen met hosten';

  @override
  String get stopHosting => 'Stoppen met hosten';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count sessie(s) tot nu toe';
  }

  @override
  String get join => 'Deelnemen';

  @override
  String get addressFromHost => 'Adres (van het hostende apparaat)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Nu synchroniseren';

  @override
  String get addressFormatHint =>
      'Het adres moet er zo uitzien: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Gesynchroniseerd: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synchronisatie mislukt: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Laatste synchronisatie met $peer: $time';
  }

  @override
  String get sharedFolder => 'Gedeelde map';

  @override
  String get sharedFolderExplainer =>
      'Beide apparaten gebruiken dezelfde map (bijvoorbeeld in Dropbox of op een USB-stick). Elke synchronisatie zet jouw wijzigingen daar neer en haalt die van de ander op.';

  @override
  String get noFolderChosenYet => 'Nog geen map gekozen';

  @override
  String get choose => 'Kiezen…';

  @override
  String get syncFolderNow => 'Map nu synchroniseren';

  @override
  String folderSynced(String result) {
    return 'Map gesynchroniseerd: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Map synchroniseren mislukt: $error';
  }

  @override
  String get recordSightingHere => 'Hier een waarneming vastleggen:';

  @override
  String trailOf(String name, int count) {
    return 'Route: $name ($count waarnemingen)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflict — $field';
  }

  @override
  String get conflictBody =>
      'Op twee plekken tegelijk gewijzigd. Kies wat waar is:';

  @override
  String mergeThisInto(String kind) {
    return 'Deze $kind samenvoegen met…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Geen andere $kind om mee samen te voegen.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Samenvoegen met $name?';
  }

  @override
  String mergeBody(String name) {
    return 'De twee records worden één. $name behoudt de huidige waarden; de geschiedenis van de ander komt erbij. Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get kindCat => 'kat';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'veld';

  @override
  String get takePhoto => 'Foto maken';

  @override
  String get chooseFromGallery => 'Kiezen uit galerij';

  @override
  String get about => 'Over';

  @override
  String get aboutTagline =>
      'Een lokale catalogus voor opvangkatten. Je gegevens blijven op je apparaten — geen server, geen account.';

  @override
  String versionLabel(String version, String build) {
    return 'Versie $version ($build)';
  }

  @override
  String get sourceCode => 'Broncode';

  @override
  String get reportProblemOrIdea => 'Probleem of idee melden';

  @override
  String get githubIssues => 'GitHub-issues';

  @override
  String get writeTheDeveloper => 'De ontwikkelaar schrijven';

  @override
  String get buyCoffee => 'Trakteer de ontwikkelaar op koffie';

  @override
  String get coffeeSubtitle => 'Geheel vrijblijvend — de app is gratis';

  @override
  String get openSourceLicenses => 'Opensourcelicenties';

  @override
  String get machineTranslated =>
      'Vertalingen zijn machinaal — verbeteringen zijn welkom op GitHub.';

  @override
  String get unnamed => '(naamloos)';

  @override
  String get labelName => 'Naam';

  @override
  String get labelProfileImage => 'Profielfoto';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Geslacht';

  @override
  String get starterBreed => 'Ras';

  @override
  String get valueMixed => 'gemengd';

  @override
  String get breedEuropeanShorthair => 'Europese korthaar';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britse korthaar';

  @override
  String get breedNorwegianForestCat => 'Noorse boskat';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamees';

  @override
  String get breedPersian => 'Pers';

  @override
  String get breedBengal => 'Bengaal';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get starterColor => 'Kleur';

  @override
  String get starterNeutered => 'Gecastreerd';

  @override
  String get starterPregnant => 'Drachtig';

  @override
  String get starterBirthdate => 'Geboortedatum';

  @override
  String get starterDeceased => 'Overleden';

  @override
  String get starterAddress => 'Adres';

  @override
  String get starterResponsible => 'Verantwoordelijke';

  @override
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefoon';

  @override
  String get lookupUrlLabel => 'Opzoeklink';

  @override
  String lookupUrlHelp(String token) {
    return 'De pagina van de dienst met $token op de plek van het nummer, bv. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Opzoeken';

  @override
  String lookupFailed(String url) {
    return 'Geen app kon $url openen. Kopieer de link naar een browser.';
  }

  @override
  String get stepCat => 'Kat';

  @override
  String get stepOwner => 'Eigenaar';

  @override
  String get stepFace => 'Gezichtsfoto';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Controleren en opslaan';

  @override
  String get stepOwnerHint =>
      'Wie de kat mist — dit wordt hun kaart, met het contact van de poster.';

  @override
  String get stepFaceHint =>
      'Knip het gezicht van de kat uit de poster; het wordt de profielfoto. Overslaan mag.';

  @override
  String get stepRegistryHint =>
      'Nummers van de poster. Aangevinkte worden bij de kat opgeslagen en later te openen.';

  @override
  String get noRegistryLinks =>
      'Geen registerlinks op deze poster — hier is niets te doen.';

  @override
  String get unknownServiceHint => 'Onbekende dienst';

  @override
  String get rememberService => 'Dienst onthouden';

  @override
  String get rememberServiceHint =>
      'Geef de dienst een naam en wijs het nummer in de link aan. De volgende poster vult zichzelf.';

  @override
  String get noIdInLink =>
      'In deze link zit geen nummer dat de app kan opslaan.';

  @override
  String get whichNumber => 'Welk deel is het nummer?';

  @override
  String get cropAgain => 'Opnieuw bijsnijden';

  @override
  String get noFaceYet =>
      'Nog geen gezichtsfoto — de posterfoto wordt gebruikt.';

  @override
  String get backLabel => 'Terug';

  @override
  String get dangerButton => 'NIET DRUKKEN.\nGEVAAR';

  @override
  String get dangerThanks => 'Bedankt dat je cat(a)log gebruikt!';

  @override
  String get helpTitle => 'Help';

  @override
  String get showTipsAgain => 'Tips opnieuw tonen';

  @override
  String get helpHome =>
      'Het overzicht van je kolonies — een kolonie is een plek waar katten wonen: je huis, een opvanggezin, een asiel. Tik op een kaart voor haar katten; houd ingedrukt voor het menu. De knop rechtsonder maakt een nieuwe kolonie, en de zwerverskaart verzamelt alle katten zonder thuis.';

  @override
  String get helpClowder =>
      'Alles over deze plek: haar katten, haar velden (adres, contact, type) en haar geschiedenis. De pagina opent alleen-lezen; het potlood zet bewerken aan, daar kun je ook een veld toevoegen. Houd een veld ingedrukt om het direct te bewerken, een kat om te verplaatsen, verbergen of openen.';

  @override
  String get helpCat =>
      'Alles over deze kat: foto\'s, velden, familie, geschiedenis. De pagina is alleen-lezen tot je op het potlood tikt. Houd een veld ingedrukt om het meteen te bewerken; een foto voor haar menu. Het menu rechtsboven heeft de rest: privé markeren, verbergen, samenvoegen, waarneming vastleggen, delen.';

  @override
  String get helpStrays =>
      'Katten die nu geen thuis hebben: gevonden, ontsnapt of van een poster. De cameraknop legt een kat vast die voor je zit; de posterknop maakt van een vermist-poster een kat met het contact van de eigenaar; de scanner leest een cat(a)log-code van de poster.';

  @override
  String get helpMap =>
      'Alle katten en plekken met een positie. Zoeken vindt katten, personen en plaatsen — een onbekende naam wordt wereldwijd opgezocht. De lagenknop tekent de 500 m-cirkels rond de posterplekken van een vermiste kat en rond haar vorige thuis. De pijlen lopen van pin naar pin, lang drukken legt een waarneming vast.';

  @override
  String get helpCard =>
      'De printbare kaart van deze kat: kies bovenaan met de chips wat erop komt, deel hem daarna als afbeelding of pdf. Nummers kunnen als QR of streepjescode gedrukt worden, en een positie wordt een QR die een kaart opent, plus een korte Plus Code.';

  @override
  String get helpSync =>
      'Zo komen gegevens bij anderen: direct verbinden, een map gebruiken die beide apparaten zien, of een bestand via een messenger sturen. Jij bepaalt altijd wat weggaat — en ontvangen .catsync-bestanden open je hier ook.';

  @override
  String get helpFields =>
      'De velden die je catalogus gebruikt. Hernoem ze, wijzig de opties van een keuzeveld of maak eigen velden. Een nummerveld kan naar een dienst (een register) wijzen; dan is het nummer bij de kat aantikbaar.';

  @override
  String get helpTimeline =>
      'Elke wijziging ooit, nieuwste eerst: wie wat wanneer in welke waarde veranderde. Elke regel kan teruggedraaid worden — dat schrijft een nieuwe regel, er wordt nooit iets gewist.';

  @override
  String get helpDuplicates =>
      'Katten of kolonies die dubbel lijken te bestaan — gelijke nummers of erg gelijkende namen met kloppende details. Tik op een paar om samen te voegen; dat kan niet ongedaan gemaakt worden, dus er wordt eerst gevraagd.';

  @override
  String get helpMatches =>
      'Katten die hetzelfde dier kunnen zijn: hetzelfde nummer, of een zwerver gezien binnen het zoekgebied van een vermiste kat. Tik op een paar om samen te voegen, houd ingedrukt om de eerste kat te openen en te vergelijken.';

  @override
  String get helpFlier =>
      'Een gefotografeerde poster wordt een kat plus eigenaar. Stap voor stap: gegevens van de kat, contact van de eigenaar, gezicht bijsnijden voor de profielfoto, registernummers van de poster, dan een laatste controle. Alles is een suggestie — corrigeer wat de camera verkeerd las.';

  @override
  String get archiveTitle => 'Archief';

  @override
  String get archiveExplainer =>
      'Overleden katten en lege kolonies waar jaren niemand naar omkeek kosten nog steeds ruimte — vooral hun foto\'s. Archiveren schrijft ze naar een bestand dat jij bewaart en verwijdert ze daarna hier.';

  @override
  String get archiveAction => 'Archiveren';

  @override
  String archiveSelected(int count) {
    return '$count items archiveren';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '$count items archiveren?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names worden naar een bestand geschreven en daarna verwijderd — op jouw apparaat en op elk apparaat waarmee je synchroniseert. Het bestand importeren haalt alles terug; zonder dat bestand zijn ze weg.';
  }

  @override
  String archiveDone(int count) {
    return '$count items gearchiveerd en verwijderd';
  }

  @override
  String archiveFailed(String error) {
    return 'Er is niets verwijderd: het archiefbestand kon niet geschreven worden ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Database $db, foto\'s $photos in $count bestanden';
  }

  @override
  String quietForYears(int years) {
    return 'Al $years jaar stil';
  }

  @override
  String get nothingToArchive => 'Niets oud genoeg om te archiveren.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Laatste wijziging $date · foto\'s $size';
  }

  @override
  String get helpArchive =>
      'Oude gegevens kosten ruimte, vooral de foto\'s die elk gesynchroniseerd apparaat meesleept. Hier kies je overleden katten en lege kolonies die al jaren stil zijn, schrijf je ze naar een bestand dat je bewaart, en verwijder je ze. De verwijdering bereikt iedereen met wie je synchroniseert; het bestand importeren zet alles terug.';

  @override
  String restoreDeletedTitle(int count) {
    return '$count verwijderde items herstellen?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names zijn in deze catalogus verwijderd, en het zojuist geïmporteerde bestand bevat ze. Herstellen brengt ze hier terug en op elk apparaat waarmee je synchroniseert.';
  }

  @override
  String get restoreAction => 'Herstellen';

  @override
  String get keepDeleted => 'Verwijderd laten';

  @override
  String get archiveNotSaved =>
      'Er is niets verwijderd: het archief is nergens opgeslagen.';

  @override
  String get locateAddress => 'Adres op de kaart zoeken';

  @override
  String get addressLocated => 'Adres gevonden';

  @override
  String get addressNotFound =>
      'Geen plek gevonden voor dit adres. Controleer de spelling of laat het leeg.';

  @override
  String get starterPosition => 'Locatie';

  @override
  String get valueYes => 'ja';

  @override
  String get valueNo => 'nee';

  @override
  String get valueFemale => 'poes';

  @override
  String get valueMale => 'kater';

  @override
  String get valueUnknown => 'onbekend';

  @override
  String get cropTitle => 'Foto bijsnijden';

  @override
  String get markTitle => 'Kat markeren';

  @override
  String get applyCrop => 'Bijsnijden';

  @override
  String get useFullPhoto => 'Hele foto gebruiken';

  @override
  String get dragToSelect => 'Sleep een rechthoek om de kat';

  @override
  String get dragOverTheCat => 'Sleep een ellips over de kat';

  @override
  String get cropPhoto => 'Bijsnijden…';

  @override
  String get markPhoto => 'Markeren…';

  @override
  String get scanCode => 'Code scannen';

  @override
  String get orTypeCode => 'Of typ de code';

  @override
  String get copyCode => 'Code kopiëren';

  @override
  String get copied => 'Gekopieerd';

  @override
  String get invalidCode => 'Die code is ongeldig';

  @override
  String get hotspotHint =>
      'Geen gedeelde wifi? Zet de hotspot van één telefoon aan, verbind de andere en host hier.';

  @override
  String get byMessenger => 'Via messenger';

  @override
  String get byMessengerExplainer =>
      'Stuur je hele catalogus als één bestand via WhatsApp, Signal of mail — de andere kant importeert hem.';

  @override
  String get shareBundle => 'Syncpakket delen…';

  @override
  String get importBundle => 'Syncpakket importeren…';

  @override
  String bundleImported(String result) {
    return 'Pakket geïmporteerd: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Laatste automatische back-up mislukt: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import mislukt: $error';
  }

  @override
  String get pickOnMap => 'Kies op de kaart';

  @override
  String get useMyLocation => 'Mijn locatie gebruiken';

  @override
  String get language => 'Taal';

  @override
  String get systemDefault => 'Systeemstandaard';

  @override
  String get iosLocalNetworkHint =>
      'Blijft het mislukken op iPhone/iPad: Instellingen → Privacy en beveiliging → Lokaal netwerk → cat(a)log toestaan en opnieuw proberen.';

  @override
  String get markPrivate => 'Markeren als privé';

  @override
  String get unmarkPrivate => 'Privémarkering verwijderen';

  @override
  String get includePrivate => 'Privégegevens meenemen';

  @override
  String get includePrivateExplainer =>
      'Dit verstuurt ook alles wat je privé hebt gemarkeerd. Degene met wie je synchroniseert ziet het dan.';

  @override
  String get hideLabel => 'Verbergen op dit apparaat';

  @override
  String get unhideLabel => 'Opnieuw tonen';

  @override
  String get showHiddenLabel => 'Verborgen items tonen';

  @override
  String get stopShowingHidden => 'Verborgen items weer verbergen';

  @override
  String get starterSpecies => 'Soort';

  @override
  String get starterStatus => 'Type';

  @override
  String get statusFoster => 'Opvanggezin';

  @override
  String get statusForeverHome => 'Voor-altijd-thuis';

  @override
  String get statusClinic => 'Kliniek';

  @override
  String get statusShelter => 'Asiel';

  @override
  String get statusBarn => 'Schuur';

  @override
  String get valueCat => 'Kat';

  @override
  String get otherOption => 'Anders…';

  @override
  String get celebrationsToggle => 'Adopties vieren';

  @override
  String get celebrationsSubtitle =>
      'Confetti en gejuich wanneer een kat naar zijn voor-altijd-thuis verhuist';

  @override
  String get onMapLabel => 'Op de kaart';

  @override
  String get showOnMap => 'Toon op kaart';

  @override
  String get searchPlaceHint => 'Zoek plaats of adres';

  @override
  String get noPlacesFound => 'Geen plaatsen gevonden';

  @override
  String get mapSearchHint => 'Zoek katten, clowders, personen';

  @override
  String get proposeAnotherName => 'Stel een andere naam voor';

  @override
  String get moderationTitle => 'Auteurs & blokkades';

  @override
  String get moderationSubtitle =>
      'Gegevens van een persoon voorgoed verwijderen';

  @override
  String get authorsSection => 'Wie in deze catalogus schreef';

  @override
  String get hardDeleteAction => 'Alles van deze auteur verwijderen';

  @override
  String hardDeleteWarning(Object name) {
    return 'Verwijdert elke invoer en foto van $name van dit apparaat. Andere apparaten houden de hunne. Kan niet ongedaan worden gemaakt.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Typ $name om te bevestigen';
  }

  @override
  String get alsoBan => 'Ook blokkeren — nooit meer gegevens accepteren';

  @override
  String get bansSection => 'Blokkades';

  @override
  String get unbanAction => 'Blokkade opheffen';

  @override
  String get deletedDone => 'Verwijderd.';

  @override
  String get syncSummaryTitle => 'Wat er binnenkwam';

  @override
  String get summaryAdopted => 'Geadopteerd';

  @override
  String get summaryDeceased => 'Overleden';

  @override
  String get summaryEscaped => 'Ontsnapt';

  @override
  String get summaryNew => 'Nieuw';

  @override
  String get summaryConflicts => 'Op te lossen conflicten';

  @override
  String summaryOther(Object n) {
    return '…en $n andere wijzigingen';
  }

  @override
  String get starterMother => 'Moeder';

  @override
  String get starterFather => 'Vader';

  @override
  String get familySection => 'Familie';

  @override
  String get littermatesLabel => 'Nestgenoten';

  @override
  String get siblingsLabel => 'Broers en zussen';

  @override
  String get kittensLabel => 'Kittens';

  @override
  String get toastSettingsTitle => 'Wat te melden';

  @override
  String get toastSettingsSubtitle => 'Kleine berichtjes na een synchronisatie';

  @override
  String get toastKindAdoptions => 'Adopties';

  @override
  String get toastKindBirths => 'Geboortes';

  @override
  String get toastKindDeaths => 'Overlijdens';

  @override
  String get toastKindEscapes => 'Ontsnappingen';

  @override
  String get toastKindMoves => 'Verhuizingen';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat geadopteerd door $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nieuwe kitten: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat is overleden';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat is ontsnapt';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat is verhuisd naar $home';
  }

  @override
  String get notACatlogFile => 'Dat is geen cat(a)log-bestand';

  @override
  String get nothingNewInBundle =>
      'Niets nieuws in dat bestand — je hebt alles al';

  @override
  String get syncChooserInPerson => 'In dezelfde kamer';

  @override
  String get syncChooserInPersonSub =>
      'Jullie zijn in dezelfde ruimte — scan een code, klaar in seconden';

  @override
  String get syncChooserRemote => 'Op afstand';

  @override
  String get syncChooserRemoteSub =>
      'Via een gedeelde map zoals Dropbox of een USB-stick';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Verstuur alles als één bestand via elke messenger — en importeer hier een ontvangen .catsync-bestand';

  @override
  String get connectToWifiFirst =>
      'Maak eerst verbinding met wifi — dan vinden de apparaten elkaar';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) wil synchroniseren';
  }

  @override
  String get trustBothWaysNote =>
      'Jullie catalogi worden in beide richtingen uitgewisseld.';

  @override
  String get allowOnce => 'Toestaan';

  @override
  String get allowAlways => 'Dit apparaat altijd toestaan';

  @override
  String get declineAction => 'Weigeren';

  @override
  String get syncDeclined => 'Het andere apparaat weigerde de synchronisatie';

  @override
  String get trustedDevicesSection => 'Altijd toegestane apparaten';

  @override
  String get removeTrust => 'Verwijderen';

  @override
  String get hostWithoutWifi => 'Hosten zonder wifi';

  @override
  String get hotspotJoinNote =>
      'Maakt een tijdelijke directe verbinding met de andere telefoon (zonder internet). Alleen cat(a)log gebruikt hem en hij verbreekt zichzelf na de synchronisatie.';

  @override
  String get hotspotAndroidOnly =>
      'Deze code vereist twee Android-telefoons — gebruik op iPhone/iPad een gedeelde wifi';

  @override
  String get selectClowderHint => 'Kies links een clowder';

  @override
  String get introTitle1 => 'Je katten, overzichtelijk';

  @override
  String get introBody1 =>
      'Maak voor elke kat een kaart: foto, geslacht, gezondheid, alles wat je wilt vastleggen. Katten zijn gegroepeerd naar waar ze wonen — de app noemt zo\'n plek een clowder.';

  @override
  String get introTitle2 => 'Werkt zonder internet';

  @override
  String get introBody2 =>
      'Alles wordt alleen op je telefoon opgeslagen. Geen account, geen cloud. Er wordt niets geüpload tenzij je het zelf deelt.';

  @override
  String get introTitle3 => 'Samenwerken';

  @override
  String get introBody3 =>
      'Iedereen gebruikt zijn eigen app en jullie wisselen af en toe gegevens uit: spreek af en scan een code, gebruik een gedeelde map of stuur één bestand via een messenger. Daarna heeft iedereen dezelfde informatie.';

  @override
  String get introSkip => 'Overslaan';

  @override
  String get introNext => 'Volgende';

  @override
  String get introDone => 'Aan de slag';

  @override
  String get introReplayTitle => 'Korte intro';

  @override
  String get spotHomeSync =>
      'Hier synchroniseer je met je bekenden. Jij bepaalt wat je deelt.';

  @override
  String get spotHomeStrays =>
      'Deze kaart verzamelt alle zwervers — katten zonder thuis. Tik erop voor de lijst.';

  @override
  String get spotHomeMenu =>
      'In dit menu: dubbele items vinden en samenvoegen, CSV exporteren en meer.';

  @override
  String get spotCatEdit =>
      'Tik op het potlood om deze kat te bewerken. Tip: houd een veld lang ingedrukt om het direct te bewerken.';

  @override
  String get spotMapLayers =>
      'Zoek je een vermiste kat? Toon cirkels rond de plekken van haar posters en rond haar vorige thuis.';

  @override
  String get spotStraysFlier =>
      'Poster van een vermiste kat gevonden? Fotografeer hem hier — de app bewaart kat en contact voor je.';

  @override
  String get spotStraysScan =>
      'Sommige posters hebben een cat(a)log-QR-code. Scan hem hier en importeer de kat zonder typen.';

  @override
  String get introTitle4 => 'Vermiste katten vinden';

  @override
  String get introBody4 =>
      'Zie je een poster van een vermiste kat? Fotografeer hem in de app: die bewaart de kat, het contact van de eigenaar en de plek. Duikt later een vergelijkbare zwerver op, dan stelt de app mogelijke matches voor.';

  @override
  String get spotMapSearch =>
      'Typ een kat, plaats of persoon om er op de kaart naartoe te springen.';

  @override
  String get spotCardChips =>
      'Vink aan wat op de deelbare kaart moet staan — de rest blijft eraf.';

  @override
  String get spotCatMenu =>
      'Meer acties staan hier: de kat privé markeren, verbergen, duplicaten samenvoegen of een waarneming vastleggen.';

  @override
  String get spotDone => 'Begrepen';

  @override
  String get spotReplayTitle => 'Wat-is-nieuw-tour';

  @override
  String get spotReplaySubtitle => 'Tips opnieuw tonen op elke pagina';

  @override
  String get spotReplayDone => 'De tips worden opnieuw getoond';

  @override
  String get searchNoResults => 'Geen kat gevonden met die naam';

  @override
  String get syncUnreachable =>
      'Kon het andere apparaat niet bereiken. Zitten beide op dezelfde wifi?';

  @override
  String get folderUnreachable =>
      'Kon de map niet bereiken. Bestaat de schijf of cloudmap nog?';

  @override
  String get crashTitle => 'Dit had niet mogen gebeuren';

  @override
  String get crashBody =>
      'cat(a)log liep tegen een onverwachte fout aan. Je gegevens zijn veilig — alles wordt opgeslagen op het moment dat je het wijzigt. Herstart de app en stuur bij herhaling het rapport, zodat het gemaakt kan worden.';

  @override
  String get crashRestart => 'App herstarten';

  @override
  String get crashSendReport => 'Rapport naar de ontwikkelaar sturen';

  @override
  String get crashLastRunBody =>
      'cat(a)log stopte de vorige keer onverwacht — waarschijnlijk was het geheugen op. Kort rapport sturen zodat het gemaakt kan worden?';

  @override
  String get catalogsTitle => 'Catalogi';

  @override
  String get newCatalog => 'Nieuwe catalogus';

  @override
  String get catalogNameLabel => 'Naam van de catalogus';

  @override
  String catalogNameTaken(String name) {
    return 'Er is al een catalogus met de naam $name. Kies een andere naam.';
  }

  @override
  String get manageCatalogs => 'Catalogi beheren';

  @override
  String get helpCatalogs =>
      'Elke catalogus is een eigen wereld: eigen katten, kolonies, velden, foto’s en synchronisatiepartners. Berlijn en Parijs lopen nooit door elkaar. Tik op de naam bovenaan het startscherm om te wisselen, er een toe te voegen of te hernoemen. Je naam, je taal en de al geziene tips gelden voor allemaal.';

  @override
  String get spotHomeCatalog =>
      'Dit is de catalogus waarin je zit. Tik op de naam om te wisselen of er een te maken.';

  @override
  String get deleteCatalog => 'Catalogus verwijderen';

  @override
  String deleteCatalogBody(String name) {
    return 'Alles in $name verdwijnt: de katten, de foto’s, de geschiedenis. Eerst wordt een volledig bestand opgeslagen waar de automatische back-ups komen; dat importeren haalt de catalogus terug. Typ de naam om te bevestigen.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name verwijderd. Het bestand staat in $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Typ $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Er is niets verwijderd: het catalogusbestand kon niet worden weggeschreven ($error). Maak ruimte vrij of probeer het later.';
  }

  @override
  String get moveToCatalog => 'Naar een andere catalogus verplaatsen';

  @override
  String movedToCatalog(int count, String name) {
    return '$count verplaatst naar $name';
  }

  @override
  String get chooseWhatToMove => 'Wat verhuist er mee?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Iets naar $name verplaatsen?';
  }
}
