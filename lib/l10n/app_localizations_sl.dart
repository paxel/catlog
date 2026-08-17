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
  String get noClowdersYet => 'Še ni clowdrov.\nUstvarite prvega spodaj.';

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
      'Mačka izgine z vseh seznamov. Njene fotografije se trajno izbrišejo.';

  @override
  String get sightingRecorded => 'Opažanje zabeleženo na vaši poziciji.';

  @override
  String get noLocationAvailable =>
      'Lokacija ni na voljo — namesto tega dolgo pritisnite zemljevid.';

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
  String get renameField => 'Preimenuj polje';

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
      'Sinhronizirajte prek mape, ki jo oblak ali USB ključek prenaša med napravami — za tiste, ki niso v istem omrežju.';

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
  String get orPlaceClowderHere => 'Ali sem postavi clowder:';

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
  String get starterPosition => 'Položaj';

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
  String get applyCrop => 'Crop';

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
}
