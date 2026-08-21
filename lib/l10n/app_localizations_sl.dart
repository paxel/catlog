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
  String get noClowdersYet =>
      'Še ni clowderjev. Clowder je kraj, kjer živijo mačke — tvoj začasni dom, stanovanje posvojitelja. Ustvari prvega spodaj.';

  @override
  String get strays => 'Potepuške mačke';

  @override
  String get searchCats => 'Išči mačke';

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
  String get newClowder => 'Nov clowder';

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
  String get rename => 'Preimenuj';

  @override
  String get timeline => 'Časovnica';

  @override
  String get mergeInto => 'Združi z…';

  @override
  String get deleteClowder => 'Izbriši clowder';

  @override
  String get cats => 'Mačke';

  @override
  String get addCat => 'Dodaj mačko';

  @override
  String get newCat => 'Nova mačka';

  @override
  String deleteQuestion(String name) {
    return 'Izbrišem $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder izgine s seznama.';

  @override
  String deleteClowderBody(int count) {
    return 'Njegove mačke ($count) se ne izbrišejo — postanejo potepuške. Najprej jih premaknite v drug clowder, če tega ne želite.';
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
  String get seenHereNow => 'Videna tukaj zdaj';

  @override
  String get deleteCat => 'Izbriši mačko';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Potepuška — brez clowdra';

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
  String get privateNoShare =>
      'Ta mačka je označena kot zasebna — zasebni podatki nikoli ne zapustijo vaše naprave. Najprej odstranite oznako za javno deljenje.';

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
  String get genderFatherFemale =>
      'Ta mačka je zavedena kot oče drugih mačk — oče ne more biti samica. Najprej preverite družino.';

  @override
  String get genderMotherMale =>
      'Ta mačka je zavedena kot mati drugih mačk — mati ne more biti samec. Najprej preverite družino.';

  @override
  String get moveTo => 'Premakni v';

  @override
  String get noClowderStrayOption => 'Brez clowdra — potepuška / pobegnila';

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
  String get forClowders => 'clowdre';

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
  String get host => 'Gostitelj';

  @override
  String get hostExplainer =>
      'Začnite tukaj, nato na drugi napravi vnesite naslov in PIN.';

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
  String get kindClowder => 'clowder';

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
  String get coffeeSubtitle => 'Povsem prostovoljno — aplikacija je brezplačna';

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
  String get stepOwner => 'Lastnik';

  @override
  String get stepFace => 'Fotografija obraza';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Preveri in shrani';

  @override
  String get stepOwnerHint =>
      'Kdor pogreša mačko — iz tega nastane njegova kartica s kontaktom z letaka.';

  @override
  String get stepFaceHint =>
      'Izreži mačkin obraz z letaka; postane profilna slika. Lahko tudi preskočiš.';

  @override
  String get stepRegistryHint =>
      'Številke, najdene na letaku. Odkljukane se shranijo pri mački in jih lahko pozneje odpreš.';

  @override
  String get noRegistryLinks =>
      'Na tem letaku ni povezav do registrov — tu ni dela.';

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
      'Pregled tvojih kolonij — kolonija je kraj, kjer živijo mačke: tvoj dom, začasni dom, zavetišče. Tapni kartico za njene mačke; dolg pritisk odpre meni. Gumb spodaj desno ustvari kolonijo, kartica potepuhov pa zbira vse mačke brez doma.';

  @override
  String get helpClowder =>
      'Vse o tem kraju: njegove mačke, polja (naslov, stik, vrsta) in zgodovina. Stran se odpre samo za branje; svinčnik vklopi urejanje, kjer lahko dodaš tudi novo polje. Dolg pritisk na polje ga uredi takoj, na mačko jo premakne, skrije ali odpre.';

  @override
  String get helpCat =>
      'Vse o tej mački: fotografije, polja, družina, zgodovina. Stran je samo za branje, dokler ne tapneš svinčnika. Dolg pritisk na polje te pelje naravnost v urejanje; na fotografijo odpre njen meni. Meni zgoraj desno ima ostalo: zasebno, skrij, združi, zabeleži opažanje, deli.';

  @override
  String get helpStrays =>
      'Mačke, ki zdaj nimajo doma: najdene, pobegle ali z letaka. Gumb s kamero zabeleži mačko pred tabo; gumb z letakom spremeni plakat v mačko s stikom lastnika; bralnik prebere kodo cat(a)log z letaka.';

  @override
  String get helpMap =>
      'Vse mačke in kraji s položajem. Iskanje najde mačke, ljudi in kraje — neznano ime poišče po vsem svetu. Gumb za sloje nariše kroge 500 m okoli krajev letakov pogrešane mačke in okoli doma, iz katerega je pobegnila. Puščici hodita od bucike do bucike, dolg pritisk na zemljevid zabeleži opažanje.';

  @override
  String get helpCard =>
      'Kartica mačke za tisk: zgoraj s čipi izbereš, kaj bo na njej, nato jo deliš kot sliko ali PDF. Številke se lahko natisnejo kot QR ali črtna koda, položaj pa postane QR, ki odpre zemljevid, plus kratek Plus Code.';

  @override
  String get helpSync =>
      'Kako podatki pridejo do drugih: neposredna povezava, mapa, ki jo vidita obe napravi, ali datoteka prek sporočilnika. Vedno ti odločaš, kaj gre ven — prejete datoteke .catsync pa odpreš tudi tukaj.';

  @override
  String get helpFields =>
      'Polja, ki jih uporablja tvoj katalog. Preimenuj jih, spremeni možnosti izbirnega polja ali ustvari svoja. Polje z identifikatorjem lahko kaže na storitev (register), takrat je številka pri mački tapljiva.';

  @override
  String get helpTimeline =>
      'Vsaka kdaj narejena sprememba, najnovejša zgoraj: kdo je kaj, kdaj in v katero vrednost spremenil. Vsak vnos je mogoče razveljaviti — to zapiše nov vnos, nič se nikoli ne izbriše.';

  @override
  String get helpDuplicates =>
      'Mačke ali kolonije, ki se zdijo podvojene — enake številke ali zelo podobna imena z ujemajočimi podrobnostmi. Tapni par za združitev; združitve ni mogoče razveljaviti, zato prej vpraša.';

  @override
  String get helpMatches =>
      'Mačke, ki bi lahko bile ista žival: enaka številka ali potepuh, viden na območju iskanja pogrešane mačke. Tapni par za združitev, z dolgim pritiskom odpreš prvo mačko za primerjavo.';

  @override
  String get helpFlier =>
      'Fotografiran letak postane mačka in njen lastnik. Korak za korakom: podatki mačke, stik lastnika, izrez obraza za profilno sliko, številke registrov z letaka, nato končno preverjanje. Vse je predlog — popravi, kar je kamera napačno prebrala.';

  @override
  String get archiveTitle => 'Arhiv';

  @override
  String get archiveExplainer =>
      'Poginule mačke in prazne kolonije, ki se jih leta nihče ni dotaknil, še vedno zavzemajo prostor — predvsem njihove fotografije. Arhiviranje jih zapiše v datoteko, ki jo obdržiš, in jih nato izbriše od tod.';

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
  String get applyCrop => 'Obreži';

  @override
  String get useFullPhoto => 'Uporabi celo fotografijo';

  @override
  String get dragToSelect => 'Povleci pravokotnik okoli mačke';

  @override
  String get dragOverTheCat => 'Povleci elipso čez mačko';

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
  String get systemDefault => 'Sistemsko privzeto';

  @override
  String get iosLocalNetworkHint =>
      'Če na iPhonu/iPadu še vedno ne uspe: Nastavitve → Zasebnost in varnost → Lokalno omrežje → dovoli cat(a)log in poskusi znova.';

  @override
  String get markPrivate => 'Označi kot zasebno';

  @override
  String get unmarkPrivate => 'Odstrani zasebno oznako';

  @override
  String get includePrivate => 'Vključi zasebne podatke';

  @override
  String get includePrivateExplainer =>
      'S tem se pošlje tudi vse, kar ste označili kot zasebno. Oseba, s katero sinhronizirate, bo to videla.';

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
  String get statusForeverHome => 'Dom za vedno';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Zavetišče';

  @override
  String get statusBarn => 'Skedenj';

  @override
  String get valueCat => 'Mačka';

  @override
  String get otherOption => 'Drugo…';

  @override
  String get celebrationsToggle => 'Praznuj posvojitve';

  @override
  String get celebrationsSubtitle =>
      'Konfeti in vzkliki, ko se mačka preseli v dom za vedno';

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
  String get syncChooserInPersonSub =>
      'Sta v istem prostoru — skeniraj kodo, končano v sekundah';

  @override
  String get syncChooserRemote => 'Na daljavo';

  @override
  String get syncChooserRemoteSub =>
      'Prek deljene mape, kot je Dropbox ali USB ključek';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Pošljite vse kot eno datoteko prek katerega koli messengerja — in tu uvozite prejeto datoteko .catsync';

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
  String get introTitle1 => 'Vaše mačke, urejeno';

  @override
  String get introBody1 =>
      'Za vsako mačko ustvarite kartico: fotografija, spol, zdravje, kar koli želite zabeležiti. Mačke so razvrščene po kraju, kjer živijo — aplikacija mu pravi kolonija (clowder).';

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
  String get spotHomeMenu =>
      'V tem meniju: poiščite in združite dvojnike, izvozite CSV in več.';

  @override
  String get spotCatEdit =>
      'Tapnite svinčnik za urejanje mačke. Nasvet: dolg pritisk na polje ga uredi neposredno.';

  @override
  String get spotMapLayers =>
      'Iščete pogrešano mačko? Prikažite kroge okoli krajev njenih letakov in okoli doma, iz katerega je pobegnila.';

  @override
  String get spotStraysFlier =>
      'Letak o pogrešani mački? Fotografirajte ga tukaj — aplikacija shrani mačko in kontakt namesto vas.';

  @override
  String get spotStraysScan =>
      'Nekateri letaki nosijo cat(a)log kodo QR. Skenirajte jo tukaj in mačko uvozite brez tipkanja.';

  @override
  String get introTitle4 => 'Poiščite pogrešane mačke';

  @override
  String get introBody4 =>
      'Vidite letak o pogrešani mački? Fotografirajte ga v aplikaciji: shrani mačko, lastnikov kontakt in kraj. Če se pozneje pojavi podoben potepuh, aplikacija predlaga možna ujemanja.';

  @override
  String get spotMapSearch =>
      'Vpišite mačko, kraj ali osebo, da skočite tja na zemljevidu.';

  @override
  String get spotCardChips =>
      'Odkljukajte, kaj naj bo na kartici za deljenje — ostalo ostane zunaj.';

  @override
  String get spotCatMenu =>
      'Več dejanj tukaj: označite mačko kot zasebno, jo skrijte, združite dvojnike ali zabeležite opažanje.';

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
  String get spotHomeCatalog =>
      'To je katalog, v katerem si. Tapni ime za preklop ali za novega.';

  @override
  String get deleteCatalog => 'Izbriši katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Vse v katalogu $name izgine: mačke, fotografije, zgodovina. Najprej se shrani celotna datoteka tam, kamor gredo samodejne varnostne kopije — njen uvoz katalog vrne. Za potrditev vpiši ime.';
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
}
