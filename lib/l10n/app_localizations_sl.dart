// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Dobrodošli v cat(a)log';

  @override
  String get welcomeBody =>
      'Izberite si ime. Vsaka sprememba se zabeleži pod tem imenom, da drugi vidijo, kdo je kaj naredil.';

  @override
  String get yourName => 'Vaše ime';

  @override
  String get start => 'Začni';

  @override
  String get clowders => 'Clowdri';

  @override
  String get clowdersNeutral => 'Gospodinjstva';

  @override
  String get noClowdersYet =>
      'Še ni clowderjev. Clowder je kraj, kjer živijo mačke — tvoj začasni dom, stanovanje posvojitelja. Ustvari prvega spodaj.';

  @override
  String get noClowdersYetNeutral =>
      'Še ni gospodinjstev. Gospodinjstvo je kraj, kjer živijo ljubljenčki — tvoj dom, začasni dom, stanovanje posvojitelja. Ustvari prvega spodaj.';

  @override
  String get strays => 'Potepuške mačke';

  @override
  String get searchCats => 'Išči mačke';

  @override
  String get searchCatsNeutral => 'Išči ljubljenčke';

  @override
  String get map => 'Zemljevid';

  @override
  String get sync => 'Sinhronizacija';

  @override
  String get fields => 'Polja';

  @override
  String get exportCsv => 'Izvozi CSV';

  @override
  String get aboutAndFeedback => 'O aplikaciji in povratne informacije';

  @override
  String get settings => 'Nastavitve';

  @override
  String get newClowder => 'Nov clowder';

  @override
  String get newClowderNeutral => 'Novo gospodinjstvo';

  @override
  String get name => 'Ime';

  @override
  String get cancel => 'Prekliči';

  @override
  String get create => 'Ustvari';

  @override
  String get save => 'Shrani';

  @override
  String get delete => 'Izbriši';

  @override
  String get merge => 'Združi';

  @override
  String get resolve => 'Odloči';

  @override
  String get open => 'Odpri';

  @override
  String csvSavedTo(String path) {
    return 'CSV shranjen v $path';
  }

  @override
  String get renameClowder => 'Preimenuj clowder';

  @override
  String get renameClowderNeutral => 'Preimenuj gospodinjstvo';

  @override
  String get rename => 'Preimenuj';

  @override
  String get timeline => 'Časovnica';

  @override
  String get mergeInto => 'Združi z…';

  @override
  String get deleteClowder => 'Izbriši clowder';

  @override
  String get deleteClowderNeutral => 'Izbriši gospodinjstvo';

  @override
  String get cats => 'Mačke';

  @override
  String get catsNeutral => 'Ljubljenčki';

  @override
  String get addCat => 'Dodaj mačko';

  @override
  String get addCatNeutral => 'Dodaj ljubljenčka';

  @override
  String get newCat => 'Nova mačka';

  @override
  String get newCatNeutral => 'Nov ljubljenček';

  @override
  String deleteQuestion(String name) {
    return 'Izbrišem $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder izgine s seznama.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Gospodinjstvo izgine s seznama.';

  @override
  String deleteClowderBody(int count) {
    return 'Njegove mačke ($count) se ne izbrišejo — postanejo potepuške. Najprej jih premaknite v drug clowder, če tega ne želite.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Njegovi ljubljenčki ($count) se ne izbrišejo — postanejo potepuški. Najprej jih premaknite v drugo gospodinjstvo, če tega ne želite.';
  }

  @override
  String get card => 'Kartica';

  @override
  String get shareAsImage => 'Deli kot sliko';

  @override
  String get shareAsPdf => 'Deli kot PDF';

  @override
  String get print => 'Natisni';

  @override
  String cardTitle(String name) {
    return 'Kartica — $name';
  }

  @override
  String get renameCat => 'Preimenuj mačko';

  @override
  String get renameCatNeutral => 'Preimenuj ljubljenčka';

  @override
  String get seenHereNow => 'Videna tukaj zdaj';

  @override
  String get deleteCat => 'Izbriši mačko';

  @override
  String get deleteCatNeutral => 'Izbriši ljubljenčka';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get clowderLabelNeutral => 'Gospodinjstvo';

  @override
  String get strayNoClowder => 'Potepuška — brez clowdra';

  @override
  String get strayNoClowderNeutral => 'Potepuh — brez gospodinjstva';

  @override
  String get stray => 'Potepuška';

  @override
  String get photos => 'Fotografije';

  @override
  String get addPhoto => 'Dodaj fotografijo';

  @override
  String get setAsProfileImage => 'Nastavi kot profilno';

  @override
  String get thisIsProfileImage => 'To je profilna fotografija';

  @override
  String get deletePhoto => 'Izbriši fotografijo';

  @override
  String get deletePhotoTitle => 'Izbrišem fotografijo?';

  @override
  String get deletePhotoBody =>
      'Podatki fotografije se trajno izbrišejo — ni poti nazaj.';

  @override
  String get deleteCatBody =>
      'Mačka izgine z vseh seznamov in njene fotografije se odstranijo — tu in, po naslednji sinhronizaciji, tudi na drugih napravah.';

  @override
  String get deleteCatBodyNeutral =>
      'Ljubljenček izgine z vseh seznamov in njegove fotografije se odstranijo — tu in, po naslednji sinhronizaciji, tudi na drugih napravah.';

  @override
  String get sightingRecorded => 'Opažanje zabeleženo na vaši poziciji.';

  @override
  String get noLocationAvailable =>
      'Lokacija ni na voljo — namesto tega dolgo pritisnite zemljevid.';

  @override
  String get locationDeniedForever =>
      'Dostop do lokacije je blokiran. Dovolite ga v sistemskih nastavitvah za uporabo Stray Cam.';

  @override
  String get locationServiceOff =>
      'Lokacija je na tej napravi izklopljena. Vklopite jo v nastavitvah in poskusite znova.';

  @override
  String get locationDenied =>
      'cat(a)log nima dovoljenja za uporabo vaše lokacije. Poskusite znova in dovolite, ko boste vprašani.';

  @override
  String get locationNoFix =>
      'Vašega položaja trenutno ni bilo mogoče določiti. Poskusite znova na prostem — GPS potrebuje prost pogled na nebo.';

  @override
  String get ok => 'V redu';

  @override
  String get starterChipId => 'Številka čipa';

  @override
  String get starterRemarks => 'Opombe';

  @override
  String get captureFlier => 'Fotografiraj letak';

  @override
  String get addPhotosTo => 'Dodaj fotografije k…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotografij dodanih k $name';
  }

  @override
  String get scanPrintedCode => 'Skeniraj natisnjeno kodo';

  @override
  String get chipScanHint =>
      'Skenira natisnjeno kodo QR/črtno kodo s kartice čipa ali veterinarskih papirjev — čipa v mački telefon ne more prebrati.';

  @override
  String get chipScanHintNeutral =>
      'Skenira natisnjeno kodo QR/črtno kodo s kartice čipa ali veterinarskih papirjev — čipa v živali telefon ne more prebrati.';

  @override
  String get savingLabel => 'Shranjevanje…';

  @override
  String ownerOfCat(String name) {
    return 'Lastnik $name';
  }

  @override
  String get sortLabel => 'Razvrsti';

  @override
  String get viewAsTable => 'Prikaži kot tabelo';

  @override
  String get viewAsTiles => 'Prikaži kot ploščice';

  @override
  String get viewAsList => 'Prikaži kot seznam';

  @override
  String get ageLabel => 'Starost';

  @override
  String get catList => 'Seznam mačk';

  @override
  String get catListNeutral => 'Seznam ljubljenčkov';

  @override
  String get matchCandidatesTitle => 'Možna ujemanja';

  @override
  String get findDuplicates => 'Poišči dvojnike';

  @override
  String get noDuplicates => 'Trenutno ni možnih dvojnikov.';

  @override
  String get similarName => 'Podobno ime';

  @override
  String get sharePublicly => 'Deli javno…';

  @override
  String get pickFramesTitle => 'Izbira sličic';

  @override
  String get suggestedFrames => 'Predlagane sličice';

  @override
  String get scrubFrames => 'Premikanje po videu';

  @override
  String get keepThisFrame => 'Obdrži to sličico';

  @override
  String get fromVideo => 'Iz videa…';

  @override
  String get videoMobileOnly =>
      'Izbiranje sličic iz videa deluje v telefonski aplikaciji (Android in iPhone) — na tej napravi še ne.';

  @override
  String get shareWhitelistExplainer =>
      'Izberite, kaj gre v datoteko. Vključena so samo odkljukana polja.';

  @override
  String get exportShareFile => 'Izvozi datoteko za deljenje…';

  @override
  String get hostedLink => 'Gostovana povezava (URL naložene datoteke)';

  @override
  String get inlineQr => 'Vgrajeni QR (samo besedilo, brez fotografij)';

  @override
  String get inlineTooBig =>
      'Preveč podatkov za vgrajeno kodo — odstranite polja ali uporabite gostovano povezavo.';

  @override
  String get scanShareLabel => 'Skeniraj kodo za deljenje';

  @override
  String get notAShareCode => 'Ta koda ni deljenje cat(a)log.';

  @override
  String get importShareTitle => 'Uvozim to mačko?';

  @override
  String get importShareTitleNeutral => 'Uvozim tega ljubljenčka?';

  @override
  String shareSource(String url) {
    return 'Vir: $url';
  }

  @override
  String get importLabel => 'Uvozi';

  @override
  String get strayAreaLabel => 'Možno območje potepanja';

  @override
  String get prevPin => 'Prejšnja bucika';

  @override
  String get nextPin => 'Naslednja bucika';

  @override
  String get noMissingCats => 'Še ni pogrešanih mačk s položaji letakov.';

  @override
  String get noMissingCatsNeutral =>
      'Še ni pogrešanih ljubljenčkov s položaji letakov.';

  @override
  String get noMatchCandidates => 'Trenutno ni možnih ujemanj.';

  @override
  String sameIdField(String field) {
    return 'Enak $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m narazen';
  }

  @override
  String get addFlier => 'Dodaj letak';

  @override
  String get missingSinceLabel => 'Pogrešan od';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Obreži portret';

  @override
  String get statusOwner => 'Lastnik';

  @override
  String get ocrUnavailable =>
      'Prepoznavanje besedila na tej napravi ni na voljo — vnesite besedilo letaka sami.';

  @override
  String get displayFormat => 'Prikazano kot';

  @override
  String get displayPlain => 'Navadno besedilo';

  @override
  String get displayQr => 'Koda QR';

  @override
  String get displayBarcode => 'Črtna koda';

  @override
  String get editLabel => 'Uredi';

  @override
  String get doneLabel => 'Končano';

  @override
  String get openSettings => 'Odpri nastavitve';

  @override
  String get notSaved => 'Ni shranjeno';

  @override
  String get birthdateInFuture => 'Datum rojstva ne more biti v prihodnosti.';

  @override
  String get deceasedInFuture => 'Datum smrti ne more biti v prihodnosti.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Datum smrti ne more biti pred datumom rojstva ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Datum rojstva ne more biti po datumu smrti ($date).';
  }

  @override
  String get malePregnant =>
      'Ta mačka je zavedena kot samec — samec ne more biti breja. Najprej preverite spol.';

  @override
  String get malePregnantNeutral =>
      'Ta ljubljenček je zaveden kot samec — samec ne more biti brej. Najprej preverite spol.';

  @override
  String fatherNotMale(String name) {
    return '$name je zavedena kot samica in ne more biti oče. Najprej preverite spol.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name je zaveden kot samec in ne more biti mati. Najprej preverite spol.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name se je rodil $date — starš se ne more roditi za svojim mladičem.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name se je rodil $date — starš se ne more roditi za svojim mladičem.';
  }

  @override
  String get genderFatherFemale =>
      'Ta mačka je zavedena kot oče drugih mačk — oče ne more biti samica. Najprej preverite družino.';

  @override
  String get genderFatherFemaleNeutral =>
      'Ta ljubljenček je zaveden kot oče drugih ljubljenčkov — oče ne more biti samica. Najprej preverite družino.';

  @override
  String get genderMotherMale =>
      'Ta mačka je zavedena kot mati drugih mačk — mati ne more biti samec. Najprej preverite družino.';

  @override
  String get genderMotherMaleNeutral =>
      'Ta ljubljenček je zaveden kot mati drugih ljubljenčkov — mati ne more biti samec. Najprej preverite družino.';

  @override
  String get moveTo => 'Premakni v';

  @override
  String get noClowderStrayOption => 'Brez clowdra — potepuška / pobegnila';

  @override
  String get noClowderStrayOptionNeutral =>
      'Brez gospodinjstva — potepuh / pobegnil';

  @override
  String timelineOf(String name) {
    return 'Časovnica — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Razveljavi to spremembo';

  @override
  String get revertSubtitle =>
      'Obnovi prejšnjo vrednost kot nov zapis — zgodovina ohrani oboje.';

  @override
  String fieldCleared(String field) {
    return '$field izpraznjeno';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field nazaj na \"$value\"';
  }

  @override
  String get leftStray => 'Odšla — potepuška';

  @override
  String movedTo(String name) {
    return 'Premaknjena v $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat je prišla';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat je prišla iz $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat je odšla v $place';
  }

  @override
  String get duplicateMergedIn => 'Dvojnik združen';

  @override
  String get asOfToday => 'Z današnjim datumom';

  @override
  String asOfDate(String date) {
    return 'Z datumom $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Napačna oblika — uporabite $format';
  }

  @override
  String get dateInFuture => 'Ta datum ne more biti v prihodnosti.';

  @override
  String get value => 'Vrednost';

  @override
  String get latitudeLongitude => 'zemljepisna širina, dolžina';

  @override
  String get newField => 'Novo polje';

  @override
  String get fieldType => 'Vrsta';

  @override
  String get usedOn => 'Uporablja se za';

  @override
  String get forCats => 'mačke';

  @override
  String get forCatsNeutral => 'ljubljenčke';

  @override
  String get forClowders => 'clowdre';

  @override
  String get forClowdersNeutral => 'gospodinjstva';

  @override
  String get forBoth => 'oboje';

  @override
  String get optionsOnePerLine => 'Možnosti (ena na vrstico)';

  @override
  String get ownValue => 'Lastna vrednost';

  @override
  String get renameField => 'Preimenuj polje';

  @override
  String get editOptions => 'Uredi možnosti…';

  @override
  String get noStraysRightNow => 'Trenutno ni potepuških mačk.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Dodaj potepuško';

  @override
  String get newStray => 'Nova potepuška';

  @override
  String get searchByNameHint => 'Išči mačke po imenu…';

  @override
  String get searchByNameHintNeutral => 'Išči ljubljenčke po imenu…';

  @override
  String get host => 'Gostitelj';

  @override
  String get hostExplainer =>
      'Začnite tukaj, nato na drugi napravi skenirajte kodo ali jo vnesite.';

  @override
  String get startHosting => 'Začni gostiti';

  @override
  String get stopHosting => 'Nehaj gostiti';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Sej do zdaj: $count';
  }

  @override
  String get join => 'Pridruži se';

  @override
  String get addressFromHost => 'Naslov (z gostiteljske naprave)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sinhroniziraj zdaj';

  @override
  String get addressFormatHint =>
      'Naslov mora biti videti kot 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sinhronizirano: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sinhronizacija ni uspela: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Zadnja sinhronizacija z $peer: $time';
  }

  @override
  String get sharedFolder => 'Skupna mapa';

  @override
  String get sharedFolderExplainer =>
      'Obe napravi uporabljata isto mapo (npr. v Dropboxu ali na USB ključku). Vsaka sinhronizacija tja odloži vaše spremembe in prevzame spremembe druge strani.';

  @override
  String get noFolderChosenYet => 'Mapa še ni izbrana';

  @override
  String get choose => 'Izberi…';

  @override
  String get syncFolderNow => 'Sinhroniziraj mapo zdaj';

  @override
  String folderSynced(String result) {
    return 'Mapa sinhronizirana: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sinhronizacija mape ni uspela: $error';
  }

  @override
  String get recordSightingHere => 'Zabeleži opažanje tukaj:';

  @override
  String trailOf(String name, int count) {
    return 'Pot: $name ($count opažanj)';
  }

  @override
  String conflictOn(String field) {
    return 'Spor — $field';
  }

  @override
  String get conflictBody =>
      'Spremenjeno na dveh mestih hkrati. Izberite, kaj drži:';

  @override
  String mergeThisInto(String kind) {
    return 'Združi ta zapis ($kind) z…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Ni drugega zapisa ($kind) za združitev.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Združim z $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Dva zapisa postaneta eden. $name obdrži trenutne vrednosti; zgodovina drugega se pridruži. Ni poti nazaj.';
  }

  @override
  String get kindCat => 'mačka';

  @override
  String get kindCatNeutral => 'ljubljenček';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindClowderNeutral => 'gospodinjstvo';

  @override
  String get kindField => 'polje';

  @override
  String get takePhoto => 'Fotografiraj';

  @override
  String get chooseFromGallery => 'Izberi iz galerije';

  @override
  String get about => 'O aplikaciji';

  @override
  String get aboutTagline =>
      'Lokalni katalog za mačke v oskrbi. Vaši podatki ostanejo na vaših napravah — brez strežnika, brez računa.';

  @override
  String get aboutTaglineNeutral =>
      'Lokalni katalog za ljubljenčke, za katere skrbite. Vaši podatki ostanejo na vaših napravah — brez strežnika, brez računa.';

  @override
  String versionLabel(String version, String build) {
    return 'Različica $version ($build)';
  }

  @override
  String get sourceCode => 'Izvorna koda';

  @override
  String get reportProblemOrIdea => 'Prijavi težavo ali zamisel';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Piši razvijalcu';

  @override
  String get buyCoffee => 'Razvijalcu privošči kavo';

  @override
  String get coffeeSubtitle =>
      'Aplikacija ostaja brezplačna. Tudi če kave ne dobim :)';

  @override
  String get openSourceLicenses => 'Odprtokodne licence';

  @override
  String get machineTranslated =>
      'Prevodi so strojni — popravki so dobrodošli na GitHubu.';

  @override
  String get unnamed => '(brez imena)';

  @override
  String get labelName => 'Ime';

  @override
  String get labelProfileImage => 'Profilna fotografija';

  @override
  String get labelPhoto => 'Fotografija';

  @override
  String get starterGender => 'Spol';

  @override
  String get starterBreed => 'Pasma';

  @override
  String get valueMixed => 'mešanec';

  @override
  String get breedEuropeanShorthair => 'Evropska kratkodlaka';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britanska kratkodlaka';

  @override
  String get breedNorwegianForestCat => 'Norveška gozdna mačka';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamska';

  @override
  String get breedPersian => 'Perzijska';

  @override
  String get breedBengal => 'Bengalska';

  @override
  String get breedSphynx => 'Sfinks';

  @override
  String get starterColor => 'Barva';

  @override
  String get starterNeutered => 'Sterilizirana';

  @override
  String get starterPregnant => 'Breja';

  @override
  String get starterBirthdate => 'Datum rojstva';

  @override
  String get starterDeceased => 'Poginila';

  @override
  String get starterAddress => 'Naslov';

  @override
  String get starterResponsible => 'Odgovorna oseba';

  @override
  String get starterEmail => 'E-pošta';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Povezava za iskanje';

  @override
  String lookupUrlHelp(String token) {
    return 'Stran storitve z $token na mestu številke, npr. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Poišči';

  @override
  String lookupFailed(String url) {
    return 'Nobena aplikacija ni mogla odpreti $url. Kopirajte povezavo v brskalnik.';
  }

  @override
  String get stepCat => 'Mačka';

  @override
  String get stepCatNeutral => 'Ljubljenček';

  @override
  String get stepOwner => 'Lastnik';

  @override
  String get stepFace => 'Fotografija obraza';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Preveri in shrani';

  @override
  String get stepOwnerHint =>
      'Kdor pogreša mačko — iz tega nastane njegov clowder s kontaktom z letaka.';

  @override
  String get stepOwnerHintNeutral =>
      'Kdor pogreša ljubljenčka — iz tega nastane njegovo gospodinjstvo s kontaktom z letaka.';

  @override
  String get stepFaceHint =>
      'Izreži mačkin obraz z letaka; postane profilna slika. Lahko tudi preskočiš.';

  @override
  String get stepFaceHintNeutral =>
      'Izreži obraz ljubljenčka z letaka; postane profilna slika. Lahko tudi preskočiš.';

  @override
  String get stepRegistryHint =>
      'Številke, najdene na letaku. Odkljukane se shranijo pri mački in jih lahko pozneje odpreš.';

  @override
  String get stepRegistryHintNeutral =>
      'Številke, najdene na letaku. Odkljukane se shranijo pri ljubljenčku in jih lahko pozneje odpreš.';

  @override
  String get noRegistryLinks =>
      'Na tem letaku ni povezav do registrov — če je bila katera spregledana, prijavite napako.';

  @override
  String get unknownServiceHint => 'Neznana storitev';

  @override
  String get rememberService => 'Zapomni si storitev';

  @override
  String get rememberServiceHint =>
      'Poimenuj storitev in pokaži številko v povezavi. Naslednji letak se izpolni sam.';

  @override
  String get noIdInLink =>
      'Ta povezava ne vsebuje številke, ki bi jo aplikacija lahko shranila.';

  @override
  String get whichNumber => 'Kateri del je številka?';

  @override
  String get cropAgain => 'Znova izreži';

  @override
  String get noFaceYet =>
      'Fotografije obraza še ni — uporabi se fotografija letaka.';

  @override
  String get backLabel => 'Nazaj';

  @override
  String get dangerButton => 'NE PRITISKAJ.\nNEVARNOST';

  @override
  String get dangerThanks => 'Hvala, ker uporabljaš cat(a)log!';

  @override
  String get helpTitle => 'Pomoč';

  @override
  String get showTipsAgain => 'Znova pokaži nasvete';

  @override
  String get helpHome =>
      'Pregled tvojih kolonij — kolonija je kraj, kjer živijo mačke: tvoj dom, začasni dom, zavetišče. Tapni kartico za njene mačke; dolg pritisk odpre meni. Gumb spodaj desno ustvari kolonijo, kartica potepuhov pa zbira vse mačke brez doma. Ime na vrhu je katalog, v katerem si — tapni ga za preklop ali dodajanje.';

  @override
  String get helpHomeNeutral =>
      'Pregled tvojih gospodinjstev — gospodinjstvo je kraj, kjer živijo ljubljenčki: tvoj dom, začasni dom, zavetišče. Tapni kartico za njegove ljubljenčke; dolg pritisk odpre meni. Gumb spodaj desno ustvari gospodinjstvo, kartica potepuhov pa zbira vse ljubljenčke brez doma. Ime na vrhu je katalog, v katerem si — tapni ga za preklop ali dodajanje.';

  @override
  String get helpClowder =>
      'Vse o tem kraju: njegove mačke, polja (naslov, stik, vrsta) in zgodovina. Stran se odpre samo za branje; svinčnik vklopi urejanje, kjer lahko dodaš tudi novo polje. Dolg pritisk na polje ga uredi takoj, na mačko jo premakne, skrije ali odpre. Termin, dodan tukaj, lahko vzame več mačk kolonije, na primer na sterilizacijo: označi mačke, ki gredo zraven, zaključi enkrat, odznači neobravnavane.';

  @override
  String get helpClowderNeutral =>
      'Vse o tem kraju: njegovi ljubljenčki, polja (naslov, stik, vrsta) in zgodovina. Stran se odpre samo za branje; svinčnik vklopi urejanje, kjer lahko dodaš tudi novo polje. Dolg pritisk na polje ga uredi takoj, na ljubljenčka ga premakne, skrije ali odpre. Termin, dodan tukaj, lahko vzame več ljubljenčkov gospodinjstva, na primer na sterilizacijo: označi ljubljenčke, ki gredo zraven, zaključi enkrat, odznači neobravnavane.';

  @override
  String get helpCat =>
      'Vse o tej mački: fotografije, polja, družina, zgodovina. Stran je samo za branje, dokler se ne dotakneš svinčnika. Dolgo pridrži polje, da ga takoj urediš; dolgo pridrži fotografijo za njen meni. Meni zgoraj desno drži ostalo: skrij, združi, zabeleži opažanje, deli mačko. „Zasebno“ se nastavi ob urejanju polja.';

  @override
  String get helpCatNeutral =>
      'Vse o tem ljubljenčku: fotografije, polja, družina, zgodovina. Stran je samo za branje, dokler se ne dotakneš svinčnika. Dolgo pridrži polje, da ga takoj urediš; dolgo pridrži fotografijo za njen meni. Meni zgoraj desno drži ostalo: skrij, združi, zabeleži opažanje, deli ljubljenčka. „Zasebno“ se nastavi ob urejanju polja.';

  @override
  String get helpStrays =>
      'Mačke, ki zdaj nimajo doma: najdene, pobegle ali z letaka. Gumb s kamero zabeleži mačko pred tabo; gumb z letakom spremeni plakat v mačko s stikom lastnika; bralnik prebere kodo cat(a)log z letaka. Tapni Stray Cam za fotografijo; pridrži za snemanje videa in obdrži najboljše sličice kot fotografije.';

  @override
  String get helpStraysNeutral =>
      'Ljubljenčki, ki zdaj nimajo doma: najdeni, pobegli ali z letaka. Gumb s kamero zabeleži žival pred tabo; gumb z letakom spremeni plakat v ljubljenčka s stikom lastnika; bralnik prebere kodo cat(a)log z letaka. Tapni Stray Cam za fotografijo; pridrži za snemanje videa in obdrži najboljše sličice kot fotografije.';

  @override
  String get helpMap =>
      'Vse mačke in kraji s položajem. Iskanje najde mačke, ljudi in kraje — neznano ime poišče po vsem svetu. Gumb za sloje nariše kroge 500 m okoli krajev letakov pogrešane mačke in okoli doma, iz katerega je pobegnila. Puščici hodita od bucike do bucike, dolg pritisk na zemljevid zabeleži opažanje.';

  @override
  String get helpMapNeutral =>
      'Vsi ljubljenčki in kraji s položajem. Iskanje najde ljubljenčke, ljudi in kraje — neznano ime poišče po vsem svetu. Gumb za sloje nariše kroge 500 m okoli krajev letakov pogrešanega ljubljenčka in okoli doma, iz katerega je pobegnil. Puščici hodita od bucike do bucike, dolg pritisk na zemljevid zabeleži opažanje.';

  @override
  String get helpCard =>
      'Kartica mačke za tisk: zgoraj s čipi izbereš, kaj bo na njej, nato jo deliš kot sliko ali PDF. Številke se lahko natisnejo kot QR ali črtna koda, položaj pa postane QR, ki odpre zemljevid, plus kratek Plus Code.';

  @override
  String get helpCardNeutral =>
      'Kartica ljubljenčka za tisk: zgoraj s čipi izbereš, kaj bo na njej, nato jo deliš kot sliko ali PDF. Številke se lahko natisnejo kot QR ali črtna koda, položaj pa postane QR, ki odpre zemljevid, plus kratek Plus Code.';

  @override
  String get helpSync =>
      'Kako podatki pridejo do drugih: neposredna povezava, mapa, ki jo vidita obe napravi, ali datoteka prek sporočilnika. Vedno ti odločaš, kaj gre ven — prejete datoteke .catsync pa odpreš tudi tukaj.';

  @override
  String get helpFields =>
      'Polja, ki jih uporablja tvoj katalog. Preimenuj jih, spremeni možnosti izbirnega polja ali ustvari svoja. Polje z identifikatorjem lahko kaže na storitev (register), takrat je številka pri mački tapljiva.';

  @override
  String get helpFieldsNeutral =>
      'Polja, ki jih uporablja tvoj katalog. Preimenuj jih, spremeni možnosti izbirnega polja ali ustvari svoja. Polje z identifikatorjem lahko kaže na storitev (register), takrat je številka pri ljubljenčku tapljiva.';

  @override
  String get helpTimeline =>
      'Vsaka kdaj narejena sprememba, najnovejša zgoraj: kdo je kaj, kdaj in v katero vrednost spremenil. Vsak vnos je mogoče razveljaviti — to zapiše nov vnos, nič se nikoli ne izbriše.';

  @override
  String get helpDuplicates =>
      'Mačke ali kolonije, ki se zdijo podvojene — enake številke ali zelo podobna imena z ujemajočimi podrobnostmi. Tapni par za združitev; združitve ni mogoče razveljaviti, zato prej vpraša.';

  @override
  String get helpDuplicatesNeutral =>
      'Ljubljenčki ali gospodinjstva, ki se zdijo podvojeni — enake številke ali zelo podobna imena z ujemajočimi podrobnostmi. Tapni par za združitev; združitve ni mogoče razveljaviti, zato prej vpraša.';

  @override
  String get helpMatches =>
      'Mačke, ki bi lahko bile ista žival: enaka številka ali potepuh, viden na območju iskanja pogrešane mačke. Tapni par za združitev, z dolgim pritiskom odpreš prvo mačko za primerjavo.';

  @override
  String get helpMatchesNeutral =>
      'Ljubljenčki, ki bi lahko bili ista žival: enaka številka ali potepuh, viden na območju iskanja pogrešanega ljubljenčka. Tapni par za združitev, z dolgim pritiskom odpreš prvega ljubljenčka za primerjavo.';

  @override
  String get helpFlier =>
      'Fotografiran letak postane mačka in njen lastnik. Korak za korakom: podatki mačke, stik lastnika, izrez obraza za profilno sliko, številke registrov z letaka, nato končno preverjanje. Vse je predlog — popravi, kar je kamera napačno prebrala.';

  @override
  String get helpFlierNeutral =>
      'Fotografiran letak postane ljubljenček in njegov lastnik. Korak za korakom: podatki ljubljenčka, stik lastnika, izrez obraza za profilno sliko, številke registrov z letaka, nato končno preverjanje. Vse je predlog — popravi, kar je kamera napačno prebrala.';

  @override
  String get archiveTitle => 'Arhiv';

  @override
  String get archiveExplainer =>
      'Poginule mačke in prazne kolonije, ki se jih leta nihče ni dotaknil, še vedno zavzemajo prostor — predvsem njihove fotografije. Arhiviranje jih zapiše v datoteko, ki jo obdržiš, in jih nato izbriše od tod.';

  @override
  String get archiveExplainerNeutral =>
      'Poginuli ljubljenčki in prazna gospodinjstva, ki se jih leta nihče ni dotaknil, še vedno zavzemajo prostor — predvsem njihove fotografije. Arhiviranje jih zapiše v datoteko, ki jo obdržiš, in jih nato izbriše od tod.';

  @override
  String get archiveAction => 'Arhiviraj';

  @override
  String archiveSelected(int count) {
    return 'Arhiviraj $count vnosov';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arhiviram $count vnosov?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names bodo zapisani v datoteko in nato izbrisani — na tvoji napravi in na vsaki, s katero sinhroniziraš. Uvoz datoteke vse vrne; brez nje so izgubljeni.';
  }

  @override
  String archiveDone(int count) {
    return 'Arhiviranih in izbrisanih $count vnosov';
  }

  @override
  String archiveFailed(String error) {
    return 'Nič ni bilo izbrisano: datoteke arhiva ni bilo mogoče zapisati ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Zbirka $db, fotografije $photos v $count datotekah';
  }

  @override
  String quietForYears(int years) {
    return 'Brez sprememb $years let';
  }

  @override
  String get nothingToArchive => 'Nič ni dovolj staro za arhiviranje.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Zadnja sprememba $date · fotografije $size';
  }

  @override
  String get helpArchive =>
      'Stari podatki stanejo prostor, predvsem fotografije, ki jih nosi vsaka sinhronizirana naprava. Tu izbereš poginule mačke in prazne kolonije, ki leta mirujejo, jih zapišeš v datoteko, ki jo obdržiš, in jih izbrišeš. Izbris doseže vse, s katerimi sinhroniziraš; uvoz datoteke vse obnovi.';

  @override
  String get helpArchiveNeutral =>
      'Stari podatki stanejo prostor, predvsem fotografije, ki jih nosi vsaka sinhronizirana naprava. Tu izbereš poginule ljubljenčke in prazna gospodinjstva, ki leta mirujejo, jih zapišeš v datoteko, ki jo obdržiš, in jih izbrišeš. Izbris doseže vse, s katerimi sinhroniziraš; uvoz datoteke vse obnovi.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Obnovim $count izbrisanih vnosov?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names so v tem katalogu izbrisani, datoteka, ki si jo pravkar uvozil, pa jih vsebuje. Obnovitev jih vrne sem in na vsako napravo, s katero sinhroniziraš.';
  }

  @override
  String get restoreAction => 'Obnovi';

  @override
  String get keepDeleted => 'Naj ostanejo izbrisani';

  @override
  String get archiveNotSaved =>
      'Nič ni bilo izbrisano: arhiv ni bil nikamor shranjen.';

  @override
  String get locateAddress => 'Poišči naslov na zemljevidu';

  @override
  String get addressFoundTitle => 'Naslov najden';

  @override
  String get replaceAddressOption => 'Zamenjaj naslov s tem';

  @override
  String get addPositionOption => 'Shrani lokacijo';

  @override
  String get addressLocated => 'Naslov najden';

  @override
  String get addressNotFound =>
      'Za ta naslov ni bilo najdenega kraja. Preveri zapis ali pusti prazno.';

  @override
  String get starterPosition => 'Lokacija';

  @override
  String get valueYes => 'da';

  @override
  String get valueNo => 'ne';

  @override
  String get valueFemale => 'samica';

  @override
  String get valueMale => 'samec';

  @override
  String get valueUnknown => 'neznano';

  @override
  String get cropTitle => 'Obreži fotografijo';

  @override
  String get markTitle => 'Označi mačko';

  @override
  String get markTitleNeutral => 'Označi ljubljenčka';

  @override
  String get applyCrop => 'Obreži';

  @override
  String get useFullPhoto => 'Uporabi celo fotografijo';

  @override
  String get dragToSelect => 'Povleci pravokotnik okoli mačke';

  @override
  String get dragToSelectNeutral => 'Povleci pravokotnik okoli ljubljenčka';

  @override
  String get dragOverTheCat => 'Povleci elipso čez mačko';

  @override
  String get dragOverTheCatNeutral => 'Povleci elipso čez ljubljenčka';

  @override
  String get cropPhoto => 'Obreži…';

  @override
  String get markPhoto => 'Označi…';

  @override
  String get scanCode => 'Skeniraj kodo';

  @override
  String get orTypeCode => 'Ali vtipkaj kodo';

  @override
  String get copyCode => 'Kopiraj kodo';

  @override
  String get copied => 'Kopirano';

  @override
  String get invalidCode => 'Ta koda ni veljavna';

  @override
  String get hotspotHint =>
      'Ni skupnega Wi-Fija? Vklopi dostopno točko na enem telefonu, poveži drugega in gosti tukaj.';

  @override
  String get byMessenger => 'Prek messengerja';

  @override
  String get byMessengerExplainer =>
      'Pošlji cel katalog kot eno datoteko prek WhatsAppa, Signala ali pošte — druga stran ga uvozi.';

  @override
  String get shareBundle => 'Deli sinhronizacijski paket…';

  @override
  String get importBundle => 'Uvozi sinhronizacijski paket…';

  @override
  String bundleImported(String result) {
    return 'Paket uvožen: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Zadnje samodejno varnostno kopiranje ni uspelo: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Uvoz ni uspel: $error';
  }

  @override
  String get pickOnMap => 'Izberi na zemljevidu';

  @override
  String get useMyLocation => 'Uporabi mojo lokacijo';

  @override
  String get language => 'Jezik';

  @override
  String get typeUnitValue => 'Vrednost z enoto';

  @override
  String get dimension => 'Veličina';

  @override
  String get dimensionWeight => 'Teža';

  @override
  String get dimensionLength => 'Dolžina';

  @override
  String get dimensionVolume => 'Prostornina';

  @override
  String get dimensionTemperature => 'Temperatura';

  @override
  String get unitsLabel => 'Enote';

  @override
  String get catalogHolds => 'Ta katalog vsebuje';

  @override
  String get modeCats => 'Mačke';

  @override
  String get modePets => 'Ljubljenčki';

  @override
  String get graphLabel => 'Graf';

  @override
  String get rangeWeek => 'Teden';

  @override
  String get rangeMonth => 'Mesec';

  @override
  String get rangeYear => 'Leto';

  @override
  String get rangeAll => 'Vse';

  @override
  String get rangeCustom => 'Po meri…';

  @override
  String changeSince(String delta, String date) {
    return '$delta od $date';
  }

  @override
  String get unitsAuto => 'Kot v tvoji regiji';

  @override
  String get unitsMetric => 'Metrične (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperialne (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Teža';

  @override
  String get systemDefault => 'Sistemsko privzeto';

  @override
  String get iosLocalNetworkHint =>
      'Če na iPhonu/iPadu še vedno ne uspe: Nastavitve → Zasebnost in varnost → Lokalno omrežje → dovoli cat(a)log in poskusi znova.';

  @override
  String get includePrivate => 'Deli zasebne podatke';

  @override
  String get hideLabel => 'Skrij na tej napravi';

  @override
  String get unhideLabel => 'Znova prikaži';

  @override
  String get showHiddenLabel => 'Prikaži skrite';

  @override
  String get stopShowingHidden => 'Nehaj prikazovati skrite';

  @override
  String get starterSpecies => 'Vrsta';

  @override
  String get starterStatus => 'Vrsta';

  @override
  String get statusFoster => 'Začasni dom';

  @override
  String get statusForeverHome => 'Dom';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Zavetišče';

  @override
  String get statusBarn => 'Skedenj';

  @override
  String get valueCat => 'Mačka';

  @override
  String get valueDog => 'Pes';

  @override
  String get valueRabbit => 'Zajec';

  @override
  String get valueGuineaPig => 'Morski prašiček';

  @override
  String get valueHamster => 'Hrček';

  @override
  String get valueBird => 'Ptica';

  @override
  String get valueHorse => 'Konj';

  @override
  String get valueTortoise => 'Želva';

  @override
  String get valueFerret => 'Beli dihur';

  @override
  String get otherOption => 'Drugo…';

  @override
  String get celebrationsToggle => 'Praznuj posvojitve';

  @override
  String get celebrationsSubtitle =>
      'Konfeti in vzkliki, ko se mačka preseli v svoj dom';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfeti in vzkliki, ko se ljubljenček preseli v svoj dom';

  @override
  String get onMapLabel => 'Na zemljevidu';

  @override
  String get showOnMap => 'Pokaži na zemljevidu';

  @override
  String get searchPlaceHint => 'Išči kraj ali naslov';

  @override
  String get noPlacesFound => 'Ni najdenih krajev';

  @override
  String get mapSearchHint => 'Išči mačke, skupine, osebe';

  @override
  String get mapSearchHintNeutral => 'Išči ljubljenčke, gospodinjstva, osebe';

  @override
  String get proposeAnotherName => 'Predlagaj drugo ime';

  @override
  String get moderationTitle => 'Avtorji in prepovedi';

  @override
  String get moderationSubtitle => 'Trajno odstrani podatke osebe';

  @override
  String get authorsSection => 'Kdo je pisal v ta katalog';

  @override
  String get hardDeleteAction => 'Izbriši vse od tega avtorja';

  @override
  String hardDeleteWarning(Object name) {
    return 'Odstrani vsak vnos in fotografijo od $name s te naprave. Druge naprave obdržijo svoje. Ni mogoče razveljaviti.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Za potrditev vpiši $name';
  }

  @override
  String get alsoBan => 'Tudi prepovej — nikoli več ne sprejmi podatkov';

  @override
  String get bansSection => 'Prepovedi';

  @override
  String get unbanAction => 'Odstrani prepoved';

  @override
  String get deletedDone => 'Izbrisano.';

  @override
  String get syncSummaryTitle => 'Kaj je prispelo';

  @override
  String get summaryAdopted => 'Posvojene';

  @override
  String get summaryDeceased => 'Poginule';

  @override
  String get summaryEscaped => 'Pobegle';

  @override
  String get summaryNew => 'Novo';

  @override
  String get summaryConflicts => 'Konflikti za rešitev';

  @override
  String summaryOther(Object n) {
    return '…in še $n sprememb';
  }

  @override
  String get starterMother => 'Mati';

  @override
  String get starterFather => 'Oče';

  @override
  String get familySection => 'Družina';

  @override
  String get littermatesLabel => 'Iz istega legla';

  @override
  String get siblingsLabel => 'Sorojenci';

  @override
  String get kittensLabel => 'Mladiči';

  @override
  String get kittensLabelNeutral => 'Mladiči';

  @override
  String get toastSettingsTitle => 'Kaj naznaniti';

  @override
  String get toastSettingsSubtitle => 'Kratka sporočila po sinhronizaciji';

  @override
  String get toastKindAdoptions => 'Posvojitve';

  @override
  String get toastKindBirths => 'Rojstva';

  @override
  String get toastKindDeaths => 'Smrti';

  @override
  String get toastKindEscapes => 'Pobegi';

  @override
  String get toastKindMoves => 'Selitve';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat posvojena: $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nov mladiček: $cat ✨';
  }

  @override
  String toastBornNeutral(Object cat) {
    return '✨ Nov mladiček: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat je poginila';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat je pobegnila';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat se je preselila v $home';
  }

  @override
  String get notACatlogFile => 'To ni datoteka cat(a)log';

  @override
  String get nothingNewInBundle => 'Nič novega v datoteki — vse že imaš';

  @override
  String get syncChooserInPerson => 'V živo';

  @override
  String get syncChooserInPersonSub => 'Sinhronizacija prek Wi-Fi';

  @override
  String get syncChooserRemote => 'Na daljavo';

  @override
  String get syncChooserRemoteSub => 'Sinhronizacija prek mape ali USB ključka';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Izvoz in uvoz prek družbenih omrežij';

  @override
  String get connectToWifiFirst =>
      'Najprej se poveži z Wi-Fi — takrat se napravi najdeta';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) želi sinhronizirati';
  }

  @override
  String get trustBothWaysNote => 'Kataloga bosta izmenjana v obe smeri.';

  @override
  String get allowOnce => 'Dovoli';

  @override
  String get allowAlways => 'Vedno dovoli to napravo';

  @override
  String get declineAction => 'Zavrni';

  @override
  String get syncDeclined => 'Druga naprava je sinhronizacijo zavrnila';

  @override
  String get trustedDevicesSection => 'Vedno dovoljene naprave';

  @override
  String get removeTrust => 'Odstrani';

  @override
  String get hostWithoutWifi => 'Gosti brez Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Vzpostavi začasno neposredno povezavo z drugim telefonom (brez interneta). Uporablja jo samo cat(a)log in se po sinhronizaciji sama prekine.';

  @override
  String get hotspotAndroidOnly =>
      'Ta koda zahteva dva telefona Android — na iPhonu/iPadu uporabi skupni Wi-Fi';

  @override
  String get selectClowderHint => 'Izberi clowder na levi';

  @override
  String get selectClowderHintNeutral => 'Izberi gospodinjstvo na levi';

  @override
  String get introTitle1 => 'Vaše mačke, urejeno';

  @override
  String get introTitle1Neutral => 'Vaši ljubljenčki, urejeno';

  @override
  String get introBody1 =>
      'Za vsako mačko ustvarite kartico: fotografija, spol, zdravje, kar koli želite zabeležiti. Mačke so razvrščene po kraju, kjer živijo — aplikacija mu pravi kolonija (clowder).';

  @override
  String get introBody1Neutral =>
      'Za vsakega ljubljenčka, za katerega skrbite, ustvarite kartico: fotografija, spol, zdravje, kar koli želite zabeležiti. Ljubljenčki so razvrščeni po kraju, kjer živijo — aplikacija mu pravi gospodinjstvo.';

  @override
  String get introTitle2 => 'Deluje brez interneta';

  @override
  String get introBody2 =>
      'Vse se shranjuje samo v vaš telefon. Brez računa, brez oblaka. Nič se ne pošilja, dokler tega sami ne delite.';

  @override
  String get introTitle3 => 'Sodelujte';

  @override
  String get introBody3 =>
      'Vsak uporablja svojo aplikacijo in občasno izmenjate podatke: dobite se in skenirajte kodo, uporabite skupno mapo ali pošljite eno datoteko po messengerju. Potem imajo vsi enake podatke.';

  @override
  String get introSkip => 'Preskoči';

  @override
  String get introNext => 'Naprej';

  @override
  String get introDone => 'Gremo';

  @override
  String get introReplayTitle => 'Hiter uvod';

  @override
  String get spotHomeSync =>
      'Tu sinhronizirate s svojimi znanci. Vi odločate, kaj delite.';

  @override
  String get spotHomeStrays =>
      'Ta kartica zbira vse potepuhe — mačke brez doma. Tapnite za seznam.';

  @override
  String get spotHomeStraysNeutral =>
      'Ta kartica zbira vse potepuhe — ljubljenčke brez doma. Tapnite za seznam.';

  @override
  String get spotHomeMenu =>
      'V tem meniju: poiščite in združite dvojnike, izvozite CSV in več.';

  @override
  String get spotCatEdit =>
      'Tapnite svinčnik za urejanje mačke. Nasvet: dolg pritisk na polje ga uredi neposredno.';

  @override
  String get spotCatEditNeutral =>
      'Tapnite svinčnik za urejanje ljubljenčka. Nasvet: dolg pritisk na polje ga uredi neposredno.';

  @override
  String get spotMapLayers =>
      'Iščete pogrešano mačko? Prikažite kroge okoli krajev njenih letakov in okoli doma, iz katerega je pobegnila.';

  @override
  String get spotMapLayersNeutral =>
      'Iščete pogrešanega ljubljenčka? Prikažite kroge okoli krajev njegovih letakov in okoli doma, iz katerega je pobegnil.';

  @override
  String get spotStraysFlier =>
      'Letak o pogrešani mački? Fotografirajte ga tukaj — aplikacija shrani mačko in kontakt namesto vas.';

  @override
  String get spotStraysFlierNeutral =>
      'Letak o pogrešanem ljubljenčku? Fotografirajte ga tukaj — aplikacija shrani ljubljenčka in kontakt namesto vas.';

  @override
  String get spotStraysScan =>
      'Nekateri letaki nosijo cat(a)log kodo QR. Skenirajte jo tukaj in mačko uvozite brez tipkanja.';

  @override
  String get spotStraysScanNeutral =>
      'Nekateri letaki nosijo cat(a)log kodo QR. Skenirajte jo tukaj in ljubljenčka uvozite brez tipkanja.';

  @override
  String get introTitle4 => 'Poiščite pogrešane mačke';

  @override
  String get introTitle4Neutral => 'Poiščite pogrešane ljubljenčke';

  @override
  String get introBody4 =>
      'Vidite letak o pogrešani mački? Fotografirajte ga v aplikaciji: shrani mačko, lastnikov kontakt in kraj. Če se pozneje pojavi podoben potepuh, aplikacija predlaga možna ujemanja.';

  @override
  String get introBody4Neutral =>
      'Vidite letak o pogrešanem ljubljenčku? Fotografirajte ga v aplikaciji: shrani ljubljenčka, lastnikov kontakt in kraj. Če se pozneje pojavi podoben potepuh, aplikacija predlaga možna ujemanja.';

  @override
  String get spotMapSearch =>
      'Vpišite mačko, kraj ali osebo, da skočite tja na zemljevidu.';

  @override
  String get spotMapSearchNeutral =>
      'Vpišite ljubljenčka, kraj ali osebo, da skočite tja na zemljevidu.';

  @override
  String get spotCardChips =>
      'Odkljukajte, kaj naj bo na kartici za deljenje — ostalo ostane zunaj.';

  @override
  String get spotCatMenu =>
      'Tu je več dejanj: skrij mačko, združi dvojnike ali zabeleži opažanje.';

  @override
  String get spotCatMenuNeutral =>
      'Tu je več dejanj: skrij ljubljenčka, združi dvojnike ali zabeleži opažanje.';

  @override
  String get spotDone => 'Razumem';

  @override
  String get spotReplayTitle => 'Ogled novosti';

  @override
  String get spotReplaySubtitle => 'Znova pokaži namige na vsaki strani';

  @override
  String get spotReplayDone => 'Namigi se bodo znova prikazali';

  @override
  String get searchNoResults => 'Mačke s tem imenom ni mogoče najti';

  @override
  String get searchNoResultsNeutral =>
      'Ljubljenčka s tem imenom ni mogoče najti';

  @override
  String get syncUnreachable =>
      'Druge naprave ni mogoče doseči. Sta obe na istem Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Mape ni mogoče doseči. Ali disk ali oblačna mapa še obstaja?';

  @override
  String get crashTitle => 'To se ne bi smelo zgoditi';

  @override
  String get crashBody =>
      'cat(a)log je naletel na nepričakovano napako. Tvoji podatki so varni — vse se shrani v trenutku spremembe. Znova zaženi aplikacijo, in če se ponavlja, pošlji poročilo, da se lahko popravi.';

  @override
  String get crashRestart => 'Znova zaženi aplikacijo';

  @override
  String get crashSendReport => 'Pošlji poročilo razvijalcu';

  @override
  String get crashLastRunBody =>
      'cat(a)log se je prejšnjič nepričakovano ustavil — najverjetneje je zmanjkalo pomnilnika. Pošljemo kratko poročilo, da se popravi?';

  @override
  String get catalogsTitle => 'Katalogi';

  @override
  String get newCatalog => 'Nov katalog';

  @override
  String get intoCatalog => 'V katalog';

  @override
  String get catalogNameLabel => 'Ime kataloga';

  @override
  String catalogNameTaken(String name) {
    return 'Katalog z imenom $name že obstaja. Izberi drugo ime.';
  }

  @override
  String get manageCatalogs => 'Upravljanje katalogov';

  @override
  String get helpCatalogs =>
      'Vsak katalog je svet zase: svoje mačke, kolonije, polja, fotografije in partnerji za sinhronizacijo. Berlin in Pariz se nikoli ne pomešata. Tapni ime na vrhu domačega zaslona za preklop, dodajanje ali preimenovanje. Tvoje ime, jezik in že videni namigi so skupni vsem.';

  @override
  String get helpCatalogsNeutral =>
      'Vsak katalog je svet zase: svoji ljubljenčki, gospodinjstva, polja, fotografije in partnerji za sinhronizacijo. Berlin in Pariz se nikoli ne pomešata. Tapni ime na vrhu domačega zaslona za preklop, dodajanje ali preimenovanje. Tvoje ime, jezik in že videni namigi so skupni vsem.';

  @override
  String get spotHomeCatalog =>
      'To je katalog, v katerem si. Tapni ime za preklop ali za novega.';

  @override
  String get deleteCatalog => 'Izbriši katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Vse v katalogu $name izgine: mačke, fotografije, zgodovina. Najprej se shrani celotna datoteka tam, kamor gredo samodejne varnostne kopije — njen uvoz katalog vrne. Za potrditev vpiši ime.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Vse v katalogu $name izgine: ljubljenčki, fotografije, zgodovina. Najprej se shrani celotna datoteka tam, kamor gredo samodejne varnostne kopije — njen uvoz katalog vrne. Za potrditev vpiši ime.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name izbrisan. Datoteka je v $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Vpiši $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nič ni bilo izbrisano: datoteke kataloga ni bilo mogoče zapisati ($error). Sprosti prostor ali poskusi pozneje.';
  }

  @override
  String get moveToCatalog => 'Premakni v drug katalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count premaknjeno v $name';
  }

  @override
  String get chooseWhatToMove => 'Kaj naj se preseli?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Premakneš kaj v $name?';
  }

  @override
  String get undoThisImport => 'Razveljavi ta uvoz';

  @override
  String undoImportBody(int count) {
    return '$count sprememb iz tega uvoza bo odstranjenih. Najprej se zapišejo v datoteko, katere uvoz jih vrne. Tisti, s katerimi si že sinhroniziral, obdržijo svojo kopijo — tega ni mogoče preklicati.';
  }

  @override
  String undoneImport(String where) {
    return 'Razveljavljeno. Datoteka je v $where.';
  }

  @override
  String get goBackTitle => 'Nazaj na prejšnje stanje';

  @override
  String get goBackToHere => 'Nazaj sem';

  @override
  String get momentImport => 'Pred uvozom';

  @override
  String get momentSync => 'Pred sinhronizacijo';

  @override
  String get momentMerge => 'Pred združitvijo';

  @override
  String get momentHardDelete => 'Pred izbrisom podatkov enega avtorja';

  @override
  String get momentArchive => 'Pred arhiviranjem';

  @override
  String get momentManual => 'Označil si sam';

  @override
  String get showOlderMoments => 'Pokaži starejše';

  @override
  String goBackBody(int count) {
    return 'Vse po tem trenutku bo odstranjeno — $count sprememb. Najprej se zapiše v datoteko, katere uvoz vse vrne, in vsak novejši trenutek gre zraven. Tisti, s katerimi si že sinhroniziral, obdržijo kopijo — tega ni mogoče preklicati.';
  }

  @override
  String get nameThisMoment => 'Poimenuj ta trenutek';

  @override
  String get helpGoBack =>
      'Trenutki, ko je ta katalog spremenil obliko: pred vsakim uvozom in vsako sinhronizacijo, pred združitvijo, arhiviranjem ali brisanjem, in kadar koli si sam označil trenutek. Izbira enega vrne katalog v to stanje — vse za njim se zapiše v datoteko, ki jo obdržiš, in nato odstrani, vsak novejši trenutek pa gre zraven. Tisti, s katerimi si že sinhroniziral, obdržijo, kar so prejeli.';

  @override
  String goBackFileFailed(String error) {
    return 'Nič ni bilo odstranjeno: datoteke, ki to hrani, ni bilo mogoče zapisati ($error). Sprosti prostor in poskusi znova.';
  }

  @override
  String get goBackChanged =>
      'Nič ni bilo odstranjeno: katalog se je med shranjevanjem datoteke spremenil. Poskusi znova.';

  @override
  String get switchBeforeDeleting =>
      'To je katalog, v katerem si. Preklopi na drugega in ga nato izbriši.';

  @override
  String shareFileFailed(String error) {
    return 'Datoteke za deljenje ni bilo mogoče zapisati ($error). Sprosti prostor in poskusi znova.';
  }

  @override
  String get privateLabel => 'Zasebno';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Označi kot zasebno';

  @override
  String get unmarkPrivate => 'Odstrani zasebno oznako';

  @override
  String get agenda => 'Opomniki';

  @override
  String get reminderLabel => 'Opomnik';

  @override
  String get agendaEmpty =>
      'Ni načrtovanih terminov. Nove načrtuješ tukaj s plusom ali na strani mačke ali clowderja.';

  @override
  String get agendaEmptyNeutral =>
      'Ni načrtovanih terminov. Nove načrtuješ tukaj s plusom ali na strani ljubljenčka ali gospodinjstva.';

  @override
  String get dueToday => 'danes';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'čez $count dni',
      few: 'čez $count dni',
      two: 'čez $count dneva',
      one: 'čez $count dan',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dni zamude',
      few: '$count dni zamude',
      two: '$count dneva zamude',
      one: '$count dan zamude',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Opravljeno';

  @override
  String get repeatTitle => 'Znova čez…';

  @override
  String get noRepeatLabel => 'Brez ponavljanja';

  @override
  String get unitDays => 'dni';

  @override
  String get unitWeeks => 'tednov';

  @override
  String get unitMonths => 'mesecev';

  @override
  String get unitYears => 'let';

  @override
  String ageYears(int years) {
    return '$years l.';
  }

  @override
  String ageMonths(int months) {
    return '$months mes.';
  }

  @override
  String get changeDateLabel => 'Spremeni datum';

  @override
  String get removeReminderLabel => 'Odstrani opomnik';

  @override
  String get exportIcs => 'Izvozi koledarsko datoteko';

  @override
  String get resyncCalendar => 'Znova sinhroniziraj koledar';

  @override
  String icsSavedTo(String path) {
    return 'Koledarska datoteka shranjena v $path';
  }

  @override
  String get calendarMirrorLabel => 'Zrcali v koledar naprave';

  @override
  String get calendarMirrorSubtitle =>
      'Termini se v koledarju prikažejo kot celodnevni dogodki. cat(a)log jih tam posodobi ob vsakem zagonu in po vsaki spremembi. Opomnike na termine upravljaš v koledarju.';

  @override
  String get syncPeerOlder =>
      'Druga naprava ima starejši cat(a)log brez opomnikov. Posodobi cat(a)log tam in znova sinhroniziraj.';

  @override
  String get syncPeerNewer =>
      'Druga naprava ima novejši cat(a)log. Posodobi cat(a)log na tej napravi in znova sinhroniziraj.';

  @override
  String get syncPeerNoTls =>
      'Druga naprava ima cat(a)log pred 1.1.0, brez šifrirane sinhronizacije. Posodobi cat(a)log tam in sinhroniziraj znova.';

  @override
  String get syncWrongHost =>
      'Potrdilo se ne ujema s kodo za združitev — to ni naprava, s katere je koda prišla. Skeniraj ali vpiši kodo znova.';

  @override
  String get bundleNewerError =>
      'Ta datoteka prihaja iz novejšega cat(a)loga. Posodobi cat(a)log na tej napravi, da jo uvoziš.';

  @override
  String get spotEar => 'Majhno mačje uho v kotu pomeni: pridrži za več.';

  @override
  String get addReminder => 'Dodaj opomnik';

  @override
  String get plannedSection => 'Načrtovano';

  @override
  String get reminderDialogHint =>
      'Termin se prikaže med opomniki. Tam ga lahko potrdiš ali zavržeš. Vrednost se prevzame le, če je termin potrjen.';

  @override
  String get reminderFor => 'Za';

  @override
  String get reminderField => 'Polje';

  @override
  String get dueDateLabel => 'Rok';

  @override
  String get pickCalendar => 'Kateri koledar?';

  @override
  String get calendarPermissionDenied =>
      'Dostop do koledarja je blokiran, zato je zrcaljenje izklopljeno. Dovoli ga v sistemskih nastavitvah in znova vklopi zrcaljenje.';

  @override
  String get calendarNotChosen =>
      'Koledar ni izbran, zato je zrcaljenje izklopljeno. Znova ga vklopi in izberi enega.';

  @override
  String get calendarGone =>
      'Izbrani koledar ne obstaja več, zato je zrcaljenje izklopljeno. Znova ga vklopi in izberi drugega.';

  @override
  String get noWritableCalendar =>
      'Koledarja ni bilo mogoče najti. V sistemskih nastavitvah se prijavi v račun koledarja, na primer Google, in poskusi znova.';

  @override
  String get spotHomeAgenda =>
      'Opomniki: seznam načrtovanih terminov — veterinar, zdravila, pregledi.';

  @override
  String get spotAgendaAdd => 'Načrtuj nov termin.';

  @override
  String get spotAgendaCalendar =>
      'Tukaj vklopi zrcaljenje terminov cat(a)log v izbrani koledar.';

  @override
  String get helpAgenda =>
      'Opomniki prikazujejo načrtovane termine po datumu. Obstajata dve vrsti: termini z uro in opomniki, ki veljajo za dan. Zamujeni ostanejo na vrhu. Dotik odpre mačko ali clowder. Kljukica potrdi termin: vrednost se zapiše v polje in takoj lahko načrtuješ naslednjega, na primer čez tri mesece. Pridržanje spremeni datum ali izbriše termin. Stikalo na vrhu zrcali termine v koledar tvojega telefona. Meni jih izvozi kot koledarsko datoteko. Obisk veterinarja z več mačkami je en termin: označi mačke, Agenda pokaže eno kartico z njihovimi imeni, ob zaključku pa vpraša, katere mačke so bile obravnavane — odznači ostale, ostanejo načrtovane.';

  @override
  String get helpAgendaNeutral =>
      'Opomniki prikazujejo načrtovane termine po datumu. Obstajata dve vrsti: termini z uro in opomniki, ki veljajo za dan. Zamujeni ostanejo na vrhu. Dotik odpre ljubljenčka ali gospodinjstvo. Kljukica potrdi termin: vrednost se zapiše v polje in takoj lahko načrtuješ naslednjega, na primer čez tri mesece. Pridržanje spremeni datum ali izbriše termin. Stikalo na vrhu zrcali termine v koledar tvojega telefona. Meni jih izvozi kot koledarsko datoteko. Obisk veterinarja z več ljubljenčki je en termin: označi ljubljenčke, Agenda pokaže eno kartico z njihovimi imeni, ob zaključku pa vpraša, kateri ljubljenčki so bili obravnavani — odznači ostale, ostanejo načrtovani.';

  @override
  String get calendarRowOff => 'Koledar: izklopljen';

  @override
  String calendarRowOn(String name) {
    return 'Koledar: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Načrtuj termin za to mačko. Prikaže se med opomniki in se tam potrdi.';

  @override
  String get spotAddReminderCatNeutral =>
      'Načrtuj termin za tega ljubljenčka. Prikaže se med opomniki in se tam potrdi.';

  @override
  String get spotAddReminderClowder =>
      'Načrtuj termin za ta clowder. Prikaže se med opomniki in se tam potrdi.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Načrtuj termin za to gospodinjstvo. Prikaže se med opomniki in se tam potrdi.';

  @override
  String get readOnlyCalendar => 'samo za branje';

  @override
  String get appointmentLabel => 'Termin';

  @override
  String get addAppointment => 'Dodaj termin';

  @override
  String get planChooserTitle => 'Termin ali opomnik?';

  @override
  String get planChooserAppointment =>
      'Termin — obisk na datum in ob uri, z zapiski';

  @override
  String get planChooserReminder =>
      'Opomnik — vrednost, ki zapade na določen dan';

  @override
  String get appointmentTitleLabel => 'Kaj';

  @override
  String get notesLabel => 'Zapiski';

  @override
  String get timeLabel => 'Ura';

  @override
  String get allDayLabel => 'Ves dan';

  @override
  String get alertLabel => 'Opozorilo';

  @override
  String get alertNone => 'Brez';

  @override
  String get alertDayBefore => 'Dan prej';

  @override
  String get alertHourBefore => 'Uro prej';

  @override
  String get linkFieldLabel => 'Ob zaključku zapiši v polje';

  @override
  String get noLinkedField => 'Brez polja';

  @override
  String get outcomeTitle => 'Kako je šlo?';

  @override
  String get finishLabel => 'Zaključi';

  @override
  String get editLabelAppointment => 'Uredi termin';

  @override
  String get deleteAppointment => 'Izbriši termin';

  @override
  String get stepFlierText => 'Besedilo letaka';

  @override
  String get qrFoundHint =>
      'Na letaku je bila najdena koda QR. Označene kode se berejo za številke registra in povezave.';

  @override
  String get useCode => 'Uporabi to kodo';

  @override
  String get qrNone => 'Na fotografiji ni bila najdena koda QR.';

  @override
  String qrFailed(String error) {
    return 'Branje kode QR ni uspelo: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Prepoznan letak $name. Spodaj preveri, v katero polje gre vsaka vrstica.';
  }

  @override
  String get flierLayoutUnknown =>
      'Neznana postavitev letaka. Spodaj dodeli vrstice poljem; ostalo ostane v opombah.';

  @override
  String get targetRegistryNumber => 'Številka registra';

  @override
  String get targetLostPlace => 'Naslov (kraj izginotja)';

  @override
  String get targetContact => 'Kontakt registra';

  @override
  String get targetDrop => 'Zavrzi';

  @override
  String get existingCat => 'Obstoječa mačka';

  @override
  String get existingCatNeutral => 'Obstoječi ljubljenček';

  @override
  String get existingClowder => 'Obstoječa skupina';

  @override
  String get existingClowderNeutral => 'Obstoječe gospodinjstvo';

  @override
  String get createNewInstead => 'Brez — ustvari novo';

  @override
  String overwritesValue(String value) {
    return 'Prepiše trenutno vrednost \"$value\"';
  }

  @override
  String get abortScanTitle => 'Prekinem zajem?';

  @override
  String get abortScanBody => 'Nič ne bo shranjeno.';

  @override
  String get abortScan => 'Prekini';

  @override
  String get keepScanning => 'Nadaljuj';

  @override
  String get catsOnAppointment => 'Mačke na tem terminu';

  @override
  String get catsOnAppointmentNeutral => 'Ljubljenčki na tem terminu';

  @override
  String get noCatsHint =>
      'Nobena mačka ni označena — termin pripada koloniji sami.';

  @override
  String get noCatsHintNeutral =>
      'Noben ljubljenček ni označen — termin pripada gospodinjstvu samemu.';

  @override
  String get pickCatsTitle => 'Katere mačke gredo zraven?';

  @override
  String get pickCatsTitleNeutral => 'Kateri ljubljenčki gredo zraven?';

  @override
  String catsCount(int count) {
    return '$count mačk';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count ljubljenčkov';
  }

  @override
  String get finishUntickHint =>
      'Odznači mačke, ki niso bile obravnavane; ostanejo načrtovane.';

  @override
  String get finishUntickHintNeutral =>
      'Odznači ljubljenčke, ki niso bili obravnavani; ostanejo načrtovani.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Izbriši termin za vseh $count mačk';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Izbriši termin za vseh $count ljubljenčkov';
  }
}
