// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bosnian (`bs`).
class AppLocalizationsBs extends AppLocalizations {
  AppLocalizationsBs([String locale = 'bs']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Dobro došli u cat(a)log';

  @override
  String get welcomeBody =>
      'Odaberite sebi ime. Svaka promjena se bilježi pod tim imenom, da drugi vide ko je šta uradio.';

  @override
  String get yourName => 'Vaše ime';

  @override
  String get start => 'Počni';

  @override
  String get clowders => 'Clowderi';

  @override
  String get noClowdersYet =>
      'Još nema clowdera. Clowder je mjesto gdje mačke žive — tvoj udomiteljski dom, stan usvojitelja. Napravi prvi ispod.';

  @override
  String get strays => 'Lutalice';

  @override
  String get searchCats => 'Traži mačke';

  @override
  String get map => 'Mapa';

  @override
  String get sync => 'Sinhronizacija';

  @override
  String get fields => 'Polja';

  @override
  String get exportCsv => 'Izvezi CSV';

  @override
  String get aboutAndFeedback => 'O aplikaciji i utisci';

  @override
  String get newClowder => 'Novi clowder';

  @override
  String get name => 'Ime';

  @override
  String get cancel => 'Otkaži';

  @override
  String get create => 'Napravi';

  @override
  String get save => 'Sačuvaj';

  @override
  String get delete => 'Obriši';

  @override
  String get merge => 'Spoji';

  @override
  String get resolve => 'Odluči';

  @override
  String get open => 'Otvori';

  @override
  String csvSavedTo(String path) {
    return 'CSV sačuvan u $path';
  }

  @override
  String get renameClowder => 'Preimenuj clowder';

  @override
  String get rename => 'Preimenuj';

  @override
  String get timeline => 'Vremenska linija';

  @override
  String get mergeInto => 'Spoji sa…';

  @override
  String get deleteClowder => 'Obriši clowder';

  @override
  String get cats => 'Mačke';

  @override
  String get addCat => 'Dodaj mačku';

  @override
  String get newCat => 'Nova mačka';

  @override
  String deleteQuestion(String name) {
    return 'Obrisati $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder nestaje sa spiska.';

  @override
  String deleteClowderBody(int count) {
    return 'Njegove mačke ($count) se ne brišu — postaju lutalice. Prvo ih premjestite u drugi clowder ako to ne želite.';
  }

  @override
  String get card => 'Kartica';

  @override
  String get shareAsImage => 'Podijeli kao sliku';

  @override
  String get shareAsPdf => 'Podijeli kao PDF';

  @override
  String get print => 'Štampaj';

  @override
  String cardTitle(String name) {
    return 'Kartica — $name';
  }

  @override
  String get renameCat => 'Preimenuj mačku';

  @override
  String get seenHereNow => 'Viđena ovdje sada';

  @override
  String get deleteCat => 'Obriši mačku';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Lutalica — bez clowdera';

  @override
  String get stray => 'Lutalica';

  @override
  String get photos => 'Fotografije';

  @override
  String get addPhoto => 'Dodaj fotografiju';

  @override
  String get setAsProfileImage => 'Postavi kao profilnu';

  @override
  String get thisIsProfileImage => 'Ovo je profilna fotografija';

  @override
  String get deletePhoto => 'Obriši fotografiju';

  @override
  String get deletePhotoTitle => 'Obrisati fotografiju?';

  @override
  String get deletePhotoBody =>
      'Podaci fotografije se trajno brišu — nema povratka.';

  @override
  String get deleteCatBody =>
      'Mačka nestaje sa svih lista i njene fotografije se uklanjaju — ovdje i, nakon sljedeće sinhronizacije, kod tvojih pomagača.';

  @override
  String get sightingRecorded => 'Viđenje zabilježeno na vašoj poziciji.';

  @override
  String get noLocationAvailable =>
      'Lokacija nedostupna — umjesto toga dugo pritisnite mapu.';

  @override
  String get locationDeniedForever =>
      'Pristup lokaciji je blokiran. Dozvolite ga u postavkama sistema da biste koristili Stray Cam.';

  @override
  String get locationServiceOff =>
      'Lokacija je isključena na ovom uređaju. Uključite je u postavkama i pokušajte ponovo.';

  @override
  String get locationDenied =>
      'cat(a)log nema dozvolu za korištenje vaše lokacije. Pokušajte ponovo i dozvolite kad budete upitani.';

  @override
  String get locationNoFix =>
      'Vaša pozicija se trenutno ne može odrediti. Pokušajte ponovo na otvorenom — GPS treba čist pogled na nebo.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Broj čipa';

  @override
  String get starterRemarks => 'Napomene';

  @override
  String get captureFlier => 'Slikaj letak';

  @override
  String get addPhotosTo => 'Dodaj fotografije u…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotografija dodano u $name';
  }

  @override
  String get scanPrintedCode => 'Skeniraj štampani kod';

  @override
  String get chipScanHint =>
      'Skenira štampani QR/barkod sa kartice čipa ili veterinarskih papira — telefon ne može očitati čip u mački.';

  @override
  String get savingLabel => 'Spremanje…';

  @override
  String ownerOfCat(String name) {
    return 'Vlasnik od $name';
  }

  @override
  String get sortLabel => 'Sortiraj';

  @override
  String get viewAsTable => 'Prikaži kao tabelu';

  @override
  String get viewAsTiles => 'Prikaži kao pločice';

  @override
  String get matchCandidatesTitle => 'Mogući parovi';

  @override
  String get findDuplicates => 'Pronađi duplikate';

  @override
  String get noDuplicates => 'Trenutno nema mogućih duplikata.';

  @override
  String get similarName => 'Slično ime';

  @override
  String get sharePublicly => 'Podijeli javno…';

  @override
  String get privateNoShare =>
      'Ova mačka je označena kao privatna — privatni podaci nikad ne napuštaju vaš uređaj. Prvo uklonite oznaku da biste je javno podijelili.';

  @override
  String get pickFramesTitle => 'Odabir kadrova';

  @override
  String get suggestedFrames => 'Predloženi kadrovi';

  @override
  String get scrubFrames => 'Premotavanje videa';

  @override
  String get keepThisFrame => 'Zadrži ovaj kadar';

  @override
  String get fromVideo => 'Iz videa…';

  @override
  String get videoMobileOnly =>
      'Odabir kadrova iz videa radi u aplikaciji za telefon (Android i iPhone) — na ovom uređaju još ne.';

  @override
  String get shareWhitelistExplainer =>
      'Samo označena polja napuštaju katalog. Sve ostalo ostaje kod kuće.';

  @override
  String get exportShareFile => 'Izvezi datoteku za dijeljenje…';

  @override
  String get hostedLink => 'Hostovani link (URL učitane datoteke)';

  @override
  String get inlineQr => 'Ugrađeni QR (samo tekst, bez fotografija)';

  @override
  String get inlineTooBig =>
      'Previše podataka za ugrađeni kod — odznačite polja ili koristite hostovani link.';

  @override
  String get scanShareLabel => 'Skeniraj kod za dijeljenje';

  @override
  String get notAShareCode => 'Ovaj kod nije cat(a)log dijeljenje.';

  @override
  String get importShareTitle => 'Uvesti ovu mačku?';

  @override
  String shareSource(String url) {
    return 'Izvor: $url';
  }

  @override
  String get importLabel => 'Uvezi';

  @override
  String get strayAreaLabel => 'Moguće područje lutanja';

  @override
  String get prevPin => 'Prethodna oznaka';

  @override
  String get nextPin => 'Sljedeća oznaka';

  @override
  String get noMissingCats => 'Još nema nestalih mačaka s pozicijama letaka.';

  @override
  String get noMatchCandidates => 'Trenutno nema mogućih parova.';

  @override
  String sameIdField(String field) {
    return 'Isti $field';
  }

  @override
  String metersApart(String distance) {
    return 'Udaljeni $distance m';
  }

  @override
  String get addFlier => 'Dodaj letak';

  @override
  String get missingSinceLabel => 'Nestao od';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Izreži portret';

  @override
  String get statusOwner => 'Vlasnik';

  @override
  String get ocrUnavailable =>
      'Prepoznavanje teksta nije dostupno na ovom uređaju — upišite tekst letka sami.';

  @override
  String get displayFormat => 'Prikazano kao';

  @override
  String get displayPlain => 'Običan tekst';

  @override
  String get displayQr => 'QR kod';

  @override
  String get displayBarcode => 'Barkod';

  @override
  String get editLabel => 'Uredi';

  @override
  String get doneLabel => 'Gotovo';

  @override
  String get openSettings => 'Otvori postavke';

  @override
  String get notSaved => 'Nije sačuvano';

  @override
  String get birthdateInFuture => 'Datum rođenja ne može biti u budućnosti.';

  @override
  String get deceasedInFuture => 'Datum smrti ne može biti u budućnosti.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Datum smrti ne može biti prije datuma rođenja ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Datum rođenja ne može biti nakon datuma smrti ($date).';
  }

  @override
  String get malePregnant =>
      'Ova mačka je zavedena kao mužjak — mužjak ne može biti gravidan. Prvo provjerite spol.';

  @override
  String fatherNotMale(String name) {
    return '$name je zavedena kao ženka i ne može biti otac. Prvo provjerite spol.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name je zaveden kao mužjak i ne može biti majka. Prvo provjerite spol.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name je rođen $date — roditelj ne može biti rođen poslije svog mladunca.';
  }

  @override
  String get genderFatherFemale =>
      'Ova mačka je zavedena kao otac drugih mačaka — otac ne može biti ženka. Prvo provjerite porodicu.';

  @override
  String get genderMotherMale =>
      'Ova mačka je zavedena kao majka drugih mačaka — majka ne može biti mužjak. Prvo provjerite porodicu.';

  @override
  String get moveTo => 'Premjesti u';

  @override
  String get noClowderStrayOption => 'Bez clowdera — lutalica / pobjegla';

  @override
  String timelineOf(String name) {
    return 'Vremenska linija — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Poništi ovu promjenu';

  @override
  String get revertSubtitle =>
      'Vraća prethodnu vrijednost kao novi zapis — historija čuva oboje.';

  @override
  String fieldCleared(String field) {
    return '$field ispražnjeno';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field vraćeno na \"$value\"';
  }

  @override
  String get leftStray => 'Otišla — lutalica';

  @override
  String movedTo(String name) {
    return 'Premještena u $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat je stigla';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat je stigla iz $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat je otišla u $place';
  }

  @override
  String get duplicateMergedIn => 'Duplikat spojen';

  @override
  String get asOfToday => 'Sa današnjim datumom';

  @override
  String asOfDate(String date) {
    return 'Sa datumom $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Pogrešan format — koristite $format';
  }

  @override
  String get value => 'Vrijednost';

  @override
  String get latitudeLongitude => 'geografska širina, dužina';

  @override
  String get newField => 'Novo polje';

  @override
  String get fieldType => 'Vrsta';

  @override
  String get usedOn => 'Koristi se za';

  @override
  String get forCats => 'mačke';

  @override
  String get forClowders => 'clowdere';

  @override
  String get forBoth => 'oboje';

  @override
  String get optionsOnePerLine => 'Opcije (jedna po redu)';

  @override
  String get ownValue => 'Vlastita vrijednost';

  @override
  String get renameField => 'Preimenuj polje';

  @override
  String get editOptions => 'Uredi opcije…';

  @override
  String get noStraysRightNow => 'Trenutno nema lutalica.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Dodaj lutalicu';

  @override
  String get newStray => 'Nova lutalica';

  @override
  String get searchByNameHint => 'Traži mačke po imenu…';

  @override
  String get host => 'Domaćin';

  @override
  String get hostExplainer =>
      'Počnite ovdje, zatim unesite adresu i PIN na drugom uređaju.';

  @override
  String get startHosting => 'Pokreni domaćinstvo';

  @override
  String get stopHosting => 'Zaustavi domaćinstvo';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Dosad sesija: $count';
  }

  @override
  String get join => 'Pridruži se';

  @override
  String get addressFromHost => 'Adresa (sa uređaja domaćina)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sinhronizuj sada';

  @override
  String get addressFormatHint =>
      'Adresa mora izgledati kao 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sinhronizovano: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sinhronizacija nije uspjela: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Zadnja sinhronizacija sa $peer: $time';
  }

  @override
  String get sharedFolder => 'Dijeljena fascikla';

  @override
  String get sharedFolderExplainer =>
      'Sinhronizujte preko fascikle koju oblak ili USB prenosi između uređaja — za one koji nisu na istoj mreži.';

  @override
  String get noFolderChosenYet => 'Fascikla još nije izabrana';

  @override
  String get choose => 'Izaberi…';

  @override
  String get syncFolderNow => 'Sinhronizuj fasciklu sada';

  @override
  String folderSynced(String result) {
    return 'Fascikla sinhronizovana: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sinhronizacija fascikle nije uspjela: $error';
  }

  @override
  String get recordSightingHere => 'Zabilježi viđenje ovdje:';

  @override
  String trailOf(String name, int count) {
    return 'Ruta: $name ($count viđenja)';
  }

  @override
  String conflictOn(String field) {
    return 'Sukob — $field';
  }

  @override
  String get conflictBody =>
      'Promijenjeno na dva mjesta istovremeno. Odaberite šta je tačno:';

  @override
  String mergeThisInto(String kind) {
    return 'Spoji ovaj zapis ($kind) sa…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Nema drugog zapisa ($kind) za spajanje.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Spojiti sa $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Dva zapisa postaju jedan. $name zadržava trenutne vrijednosti; historija drugog se pridružuje. Nema povratka.';
  }

  @override
  String get kindCat => 'mačka';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'polje';

  @override
  String get takePhoto => 'Snimi fotografiju';

  @override
  String get chooseFromGallery => 'Izaberi iz galerije';

  @override
  String get about => 'O aplikaciji';

  @override
  String get aboutTagline =>
      'Lokalni katalog za mačke na udomljavanju. Vaši podaci ostaju na vašim uređajima — bez servera, bez naloga.';

  @override
  String versionLabel(String version, String build) {
    return 'Verzija $version ($build)';
  }

  @override
  String get sourceCode => 'Izvorni kod';

  @override
  String get reportProblemOrIdea => 'Prijavi problem ili ideju';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Piši programeru';

  @override
  String get buyCoffee => 'Časti programera kafom';

  @override
  String get coffeeSubtitle => 'Potpuno dobrovoljno — aplikacija je besplatna';

  @override
  String get openSourceLicenses => 'Licence otvorenog koda';

  @override
  String get machineTranslated =>
      'Prijevodi su mašinski — ispravke su dobrodošle na GitHubu.';

  @override
  String get unnamed => '(bez imena)';

  @override
  String get labelName => 'Ime';

  @override
  String get labelProfileImage => 'Profilna fotografija';

  @override
  String get labelPhoto => 'Fotografija';

  @override
  String get starterGender => 'Spol';

  @override
  String get starterBreed => 'Rasa';

  @override
  String get valueMixed => 'mješanac';

  @override
  String get breedEuropeanShorthair => 'Evropska kratkodlaka';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britanska kratkodlaka';

  @override
  String get breedNorwegianForestCat => 'Norveška šumska mačka';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Sijamska';

  @override
  String get breedPersian => 'Perzijska';

  @override
  String get breedBengal => 'Bengalska';

  @override
  String get breedSphynx => 'Sfinks';

  @override
  String get starterColor => 'Boja';

  @override
  String get starterNeutered => 'Sterilisana';

  @override
  String get starterPregnant => 'Skotna';

  @override
  String get starterBirthdate => 'Datum rođenja';

  @override
  String get starterDeceased => 'Uginula';

  @override
  String get starterAddress => 'Adresa';

  @override
  String get starterResponsible => 'Odgovorna osoba';

  @override
  String get starterPosition => 'Lokacija';

  @override
  String get valueYes => 'da';

  @override
  String get valueNo => 'ne';

  @override
  String get valueFemale => 'ženka';

  @override
  String get valueMale => 'mužjak';

  @override
  String get valueUnknown => 'nepoznato';

  @override
  String get cropTitle => 'Izreži fotografiju';

  @override
  String get markTitle => 'Označi mačku';

  @override
  String get applyCrop => 'Izreži';

  @override
  String get useFullPhoto => 'Koristi cijelu fotografiju';

  @override
  String get dragToSelect => 'Povuci pravougaonik oko mačke';

  @override
  String get dragOverTheCat => 'Povuci elipsu preko mačke';

  @override
  String get cropPhoto => 'Izreži…';

  @override
  String get markPhoto => 'Označi…';

  @override
  String get scanCode => 'Skeniraj kod';

  @override
  String get orTypeCode => 'Ili ukucaj kod';

  @override
  String get copyCode => 'Kopiraj kod';

  @override
  String get copied => 'Kopirano';

  @override
  String get invalidCode => 'Taj kod nije važeći';

  @override
  String get hotspotHint =>
      'Nema zajedničkog Wi-Fi-ja? Uključi hotspot na jednom telefonu, poveži drugi i budi domaćin ovdje.';

  @override
  String get byMessenger => 'Preko messengera';

  @override
  String get byMessengerExplainer =>
      'Pošalji cijeli katalog kao jednu datoteku preko WhatsAppa, Signala ili maila — druga strana ga uvozi.';

  @override
  String get shareBundle => 'Podijeli paket sinhronizacije…';

  @override
  String get importBundle => 'Uvezi paket sinhronizacije…';

  @override
  String bundleImported(String result) {
    return 'Paket uvezen: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Posljednja automatska sigurnosna kopija nije uspjela: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Uvoz nije uspio: $error';
  }

  @override
  String get pickOnMap => 'Odaberi na mapi';

  @override
  String get useMyLocation => 'Koristi moju lokaciju';

  @override
  String get language => 'Jezik';

  @override
  String get systemDefault => 'Zadano sistemom';

  @override
  String get iosLocalNetworkHint =>
      'Ako i dalje ne uspijeva na iPhoneu/iPadu: Postavke → Privatnost i sigurnost → Lokalna mreža → dozvoli cat(a)log pa pokušaj ponovo.';

  @override
  String get markPrivate => 'Označi kao privatno';

  @override
  String get unmarkPrivate => 'Ukloni privatnu oznaku';

  @override
  String get includePrivate => 'Uključi privatne podatke';

  @override
  String get includePrivateExplainer =>
      'Privatne mačke, grupe i polja se također dijele — uključi samo pri sinkronizaciji vlastitih uređaja.';

  @override
  String get hideLabel => 'Sakrij na ovom uređaju';

  @override
  String get unhideLabel => 'Prikaži ponovo';

  @override
  String get showHiddenLabel => 'Prikaži skriveno';

  @override
  String get stopShowingHidden => 'Prestani prikazivati skriveno';

  @override
  String get starterSpecies => 'Vrsta';

  @override
  String get starterStatus => 'Vrsta';

  @override
  String get statusFoster => 'Udomiteljski dom';

  @override
  String get statusForeverHome => 'Trajni dom';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Sklonište';

  @override
  String get statusBarn => 'Štala';

  @override
  String get valueCat => 'Mačka';

  @override
  String get otherOption => 'Drugo…';

  @override
  String get celebrationsToggle => 'Slavi udomljavanja';

  @override
  String get celebrationsSubtitle =>
      'Konfeti i klicanje kada mačka pređe u trajni dom';

  @override
  String get onMapLabel => 'Na karti';

  @override
  String get showOnMap => 'Prikaži na karti';

  @override
  String get searchPlaceHint => 'Traži mjesto ili adresu';

  @override
  String get noPlacesFound => 'Nema pronađenih mjesta';

  @override
  String get mapSearchHint => 'Traži mačke, grupe, osobe';

  @override
  String get proposeAnotherName => 'Predloži drugo ime';

  @override
  String get moderationTitle => 'Autori i zabrane';

  @override
  String get moderationSubtitle => 'Trajno ukloni podatke osobe';

  @override
  String get authorsSection => 'Ko je pisao u ovaj katalog';

  @override
  String get hardDeleteAction => 'Obriši sve od ovog autora';

  @override
  String hardDeleteWarning(Object name) {
    return 'Uklanja svaki unos i fotografiju od $name s ovog uređaja. Drugi uređaji zadržavaju svoje. Ne može se poništiti.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Upiši $name za potvrdu';
  }

  @override
  String get alsoBan => 'Također zabrani — nikad više ne prihvataj podatke';

  @override
  String get bansSection => 'Zabrane';

  @override
  String get unbanAction => 'Ukloni zabranu';

  @override
  String get deletedDone => 'Obrisano.';

  @override
  String get syncSummaryTitle => 'Šta je stiglo';

  @override
  String get summaryAdopted => 'Udomljene';

  @override
  String get summaryDeceased => 'Uginule';

  @override
  String get summaryEscaped => 'Pobjegle';

  @override
  String get summaryNew => 'Novo';

  @override
  String get summaryConflicts => 'Konflikti za rješavanje';

  @override
  String summaryOther(Object n) {
    return '…i još $n promjena';
  }

  @override
  String get starterMother => 'Majka';

  @override
  String get starterFather => 'Otac';

  @override
  String get familySection => 'Porodica';

  @override
  String get littermatesLabel => 'Iz istog legla';

  @override
  String get siblingsLabel => 'Braća i sestre';

  @override
  String get kittensLabel => 'Mačići';

  @override
  String get toastSettingsTitle => 'Šta najaviti';

  @override
  String get toastSettingsSubtitle => 'Male poruke nakon sinhronizacije';

  @override
  String get toastKindAdoptions => 'Udomljavanja';

  @override
  String get toastKindBirths => 'Rođenja';

  @override
  String get toastKindDeaths => 'Smrti';

  @override
  String get toastKindEscapes => 'Bjekstva';

  @override
  String get toastKindMoves => 'Selidbe';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat udomljena kod $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Novo mače: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat je uginula';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat je pobjegla';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat se preselila u $home';
  }

  @override
  String get notACatlogFile => 'Ovo nije cat(a)log datoteka';

  @override
  String get nothingNewInBundle => 'Ništa novo u datoteci — već imaš sve';

  @override
  String get syncChooserInPerson => 'Uživo';

  @override
  String get syncChooserInPersonSub =>
      'U istoj ste prostoriji — skeniraj kod, gotovo za sekunde';

  @override
  String get syncChooserRemote => 'Na daljinu';

  @override
  String get syncChooserRemoteSub =>
      'Preko dijeljene fascikle poput Dropboxa ili USB sticka';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Pošaljite sve kao jednu datoteku putem bilo kojeg messengera — i uvezite primljenu .catsync datoteku ovdje';

  @override
  String get connectToWifiFirst =>
      'Prvo se poveži na Wi-Fi — tada se uređaji pronalaze';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) želi sinhronizaciju';
  }

  @override
  String get trustBothWaysNote => 'Katalozi će se razmijeniti u oba smjera.';

  @override
  String get allowOnce => 'Dozvoli';

  @override
  String get allowAlways => 'Uvijek dozvoli ovaj uređaj';

  @override
  String get declineAction => 'Odbij';

  @override
  String get syncDeclined => 'Drugi uređaj je odbio sinhronizaciju';

  @override
  String get trustedDevicesSection => 'Uvijek dozvoljeni uređaji';

  @override
  String get removeTrust => 'Ukloni';

  @override
  String get hostWithoutWifi => 'Hostuj bez Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Uspostavlja privremenu direktnu vezu s drugim telefonom (bez interneta). Koristi je samo cat(a)log i sama se prekida nakon sinhronizacije.';

  @override
  String get hotspotAndroidOnly =>
      'Ovaj kod zahtijeva dva Android telefona — na iPhone/iPad koristi zajednički Wi-Fi';

  @override
  String get selectClowderHint => 'Odaberi clowder lijevo';

  @override
  String get introTitle1 => 'Mačke žive u clowderima';

  @override
  String get introBody1 =>
      'Clowder je mjesto gdje mačke žive: tvoj udomiteljski dom, stan usvojitelja, štala u komšiluku. Svaka mačka ima kartu sa slikom, činjenicama i cijelom pričom.';

  @override
  String get introTitle2 => 'Sve ostaje kod tebe';

  @override
  String get introBody2 =>
      'Bez naloga, bez oblaka, bez praćenja. Tvoji podaci žive na tvom uređaju.';

  @override
  String get introTitle3 => 'Dijeli sa pomagačima';

  @override
  String get introBody3 =>
      'Skeniraj kod i dva uređaja se sinhronizuju za sekunde, koristi dijeljenu fasciklu ili pošalji sve kao jednu datoteku.';

  @override
  String get introSkip => 'Preskoči';

  @override
  String get introNext => 'Dalje';

  @override
  String get introDone => 'Krenimo';

  @override
  String get introReplayTitle => 'Kratki uvod';

  @override
  String get spotHomeSync =>
      'Novo: sinhronizacija sada nudi tri jasna načina — i pitanje povjerenja prije nego išta krene.';

  @override
  String get spotHomeStrays =>
      'Novo: lutalice imaju svoju karticu ovdje gore — broj, lica, dodirni za otvaranje.';

  @override
  String get spotHomeMenu =>
      'Novo: ovaj meni pronalazi duple mačke i kolonije i spaja ih.';

  @override
  String get spotCatEdit =>
      'Novo: stranica je samo za čitanje — olovka prebacuje na uređivanje, dugi pritisak na polje uređuje ga direktno.';

  @override
  String get spotMapLayers =>
      'Novo: prikaži krugove pretrage od 500 m oko mjesta letaka nestale mačke.';

  @override
  String get spotStraysFlier =>
      'Novo: slikaj letak nestale mačke — postaje mačka, vlasnik i kontakt.';

  @override
  String get spotStraysScan =>
      'Novo: skeniraj cat(a)log kod s letka i uvezi mačku direktno.';

  @override
  String get introTitle4 => 'Nestale mačke';

  @override
  String get introBody4 =>
      'Slikaj letak i nestala mačka ulazi u katalog s kontaktom vlasnika. Viđenja, krugovi pretrage i prijedlozi parova pomažu da se vrati kući.';

  @override
  String get spotMapSearch =>
      'Novo: traži mačke, grupe i osobe ovdje — direktno na karti.';

  @override
  String get spotCardChips =>
      'Novo: odaberi šta se vidi na karti prije dijeljenja.';

  @override
  String get spotCatMenu =>
      'Novo: označi mačku kao privatnu (nikad ne napušta uređaj) ili je sakrij ovdje.';

  @override
  String get spotDone => 'Jasno';

  @override
  String get spotReplayTitle => 'Tura kroz novosti';

  @override
  String get spotReplaySubtitle => 'Ponovo prikaži savjete na svakoj stranici';

  @override
  String get spotReplayDone => 'Savjeti će se ponovo prikazati';

  @override
  String get searchNoResults => 'Nije pronađena mačka s tim imenom';

  @override
  String get syncUnreachable =>
      'Drugi uređaj nije dostupan. Jesu li oba na istom Wi-Fi-ju?';

  @override
  String get folderUnreachable =>
      'Fascikla nije dostupna. Postoji li još disk ili cloud fascikla?';

  @override
  String get crashTitle => 'Ovo se nije smjelo desiti';

  @override
  String get crashBody =>
      'cat(a)log je naišao na neočekivanu grešku. Tvoji podaci su sigurni — sve se snima čim se promijeni. Restartuj aplikaciju, a ako se ponavlja, pošalji izvještaj da se popravi.';

  @override
  String get crashRestart => 'Restartuj aplikaciju';

  @override
  String get crashSendReport => 'Pošalji izvještaj programeru';

  @override
  String get crashLastRunBody =>
      'cat(a)log se prošli put neočekivano zaustavio — najvjerovatnije je nestalo memorije. Poslati kratak izvještaj da se popravi?';
}
