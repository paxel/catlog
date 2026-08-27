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
      'Mačka nestaje sa svih lista i njene fotografije se uklanjaju — ovdje i, nakon sljedeće sinhronizacije, i na drugim uređajima.';

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
      'Odaberite šta ide u fajl. Uključena su samo označena polja.';

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
      'Počnite ovdje, zatim skenirajte kod ili ga unesite na drugom uređaju.';

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
      'Oba uređaja koriste isti folder (npr. u Dropboxu ili na USB sticku). Svaka sinhronizacija tamo ostavlja vaše promjene i preuzima tuđe.';

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
  String get coffeeSubtitle =>
      'Aplikacija ostaje besplatna. Čak i ako ne dobijem kafu :)';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Link za provjeru';

  @override
  String lookupUrlHelp(String token) {
    return 'Stranica servisa s $token na mjestu broja, npr. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Provjeri';

  @override
  String lookupFailed(String url) {
    return 'Nijedna aplikacija nije mogla otvoriti $url. Kopirajte link u preglednik.';
  }

  @override
  String get stepCat => 'Mačka';

  @override
  String get stepOwner => 'Vlasnik';

  @override
  String get stepFace => 'Fotografija njuške';

  @override
  String get stepRegistry => 'Registar';

  @override
  String get stepReview => 'Provjeri i sačuvaj';

  @override
  String get stepOwnerHint =>
      'Ko traži mačku — od toga nastaje njegov clowder s kontaktom s letka.';

  @override
  String get stepFaceHint =>
      'Izreži njušku mačke s letka; postaje profilna slika. Možeš i preskočiti.';

  @override
  String get stepRegistryHint =>
      'Brojevi pronađeni na letku. Označeni se čuvaju uz mačku i mogu se kasnije otvoriti.';

  @override
  String get noRegistryLinks =>
      'Na ovom letku nema linkova registara — ako su previđeni, prijavite bug.';

  @override
  String get unknownServiceHint => 'Nepoznata usluga';

  @override
  String get rememberService => 'Zapamti uslugu';

  @override
  String get rememberServiceHint =>
      'Imenuj uslugu i pokaži broj u linku. Sljedeći letak popunit će se sam.';

  @override
  String get noIdInLink =>
      'Ovaj link ne sadrži broj koji bi aplikacija mogla sačuvati.';

  @override
  String get whichNumber => 'Koji dio je broj?';

  @override
  String get cropAgain => 'Ponovo izreži';

  @override
  String get noFaceYet =>
      'Još nema fotografije njuške — koristi se fotografija letka.';

  @override
  String get backLabel => 'Nazad';

  @override
  String get dangerButton => 'NE PRITISKAJ.\nOPASNOST';

  @override
  String get dangerThanks => 'Hvala što koristiš cat(a)log!';

  @override
  String get helpTitle => 'Pomoć';

  @override
  String get showTipsAgain => 'Prikaži savjete ponovo';

  @override
  String get helpHome =>
      'Pregled tvojih kolonija — kolonija je mjesto gdje žive mačke: tvoj dom, udomiteljska kuća, sklonište. Dodirni karticu za njezine mačke; dugi pritisak otvara izbornik. Gumb dolje desno stvara koloniju, a kartica lutalica skuplja sve mačke bez doma. Ime na vrhu je katalog u kojem si — dodirni ga da promijeniš ili dodaš novi.';

  @override
  String get helpClowder =>
      'Sve o ovom mjestu: njegove mačke, polja (adresa, kontakt, vrsta) i historija. Stranica se otvara samo za čitanje; olovka uključuje uređivanje, gdje možeš dodati i novo polje. Dugi pritisak na polje uređuje ga odmah, na mačku je premješta, skriva ili otvara. Termin dodan ovdje može povesti više mačaka kolonije, na primjer na kastraciju: označi mačke koje idu, završi jednom, odznači one koje nisu tretirane.';

  @override
  String get helpCat =>
      'Sve o ovoj mački: fotografije, polja, porodica, historija. Stranica je samo za čitanje dok ne dodirneš olovku. Dugo pritisni polje da ga odmah urediš; dugo pritisni fotografiju za njen meni. Meni gore desno drži ostalo: sakrij, spoji, zabilježi viđenje, podijeli mačku. „Privatno“ se postavlja pri uređivanju polja.';

  @override
  String get helpStrays =>
      'Mačke koje trenutno nemaju dom: pronađene, pobjegle ili s letka. Gumb s kamerom bilježi mačku pred tobom; gumb s letkom pretvara plakat u mačku s kontaktom vlasnika; skener čita cat(a)log kod s plakata.';

  @override
  String get helpMap =>
      'Sve mačke i mjesta s pozicijom. Pretraga nalazi mačke, osobe i mjesta — nepoznato ime traži se u cijelom svijetu. Gumb slojeva crta krugove od 500 m oko mjesta letaka nestale mačke i oko doma iz kojeg je pobjegla. Strelice idu od igle do igle, dugi pritisak na mapu bilježi viđenje.';

  @override
  String get helpCard =>
      'Kartica mačke za ispis: gore čipovima biraš što je na njoj, zatim je dijeliš kao sliku ili PDF. Brojevi se mogu ispisati kao QR ili barkod, a pozicija postaje QR koji otvara mapu, uz kratki Plus Code.';

  @override
  String get helpSync =>
      'Kako podaci dolaze do drugih: izravno povezivanje, mapa koju vide oba uređaja, ili datoteka poslana messengerom. Uvijek ti odlučuješ što odlazi — a primljene .catsync datoteke otvaraju se također ovdje.';

  @override
  String get helpFields =>
      'Polja koja tvoj katalog koristi. Preimenuj ih, promijeni mogućnosti polja s izborom ili dodaj vlastita. Polje s identifikatorom može pokazivati na servis (registar), pa broj kod mačke postaje dodirljiv.';

  @override
  String get helpTimeline =>
      'Svaka ikad napravljena promjena, najnovija prva: tko je što, kada i u koju vrijednost promijenio. Svaki se unos može vratiti — to piše novi unos, ništa se nikad ne briše.';

  @override
  String get helpDuplicates =>
      'Mačke ili kolonije koje izgledaju kao isti unos dvaput — isti brojevi ili vrlo slična imena s podudarnim detaljima. Dodirni par za spajanje; spajanje se ne može poništiti pa se prvo pita.';

  @override
  String get helpMatches =>
      'Mačke koje bi mogle biti ista životinja: isti broj ili lutalica viđena unutar područja pretrage nestale mačke. Dodirni par za spajanje, dugim pritiskom otvori prvu mačku za usporedbu.';

  @override
  String get helpFlier =>
      'Fotografirani letak postaje mačka i njezin vlasnik. Korak po korak: podaci mačke, kontakt vlasnika, izrezivanje njuške za profilnu sliku, brojevi registara s letka, pa završna provjera. Sve su to prijedlozi — ispravi ono što je kamera krivo pročitala.';

  @override
  String get archiveTitle => 'Arhiva';

  @override
  String get archiveExplainer =>
      'Uginule mačke i prazne kolonije koje niko nije dirao godinama i dalje zauzimaju prostor — najviše njihove fotografije. Arhiviranje ih upisuje u fajl koji zadržiš i zatim ih briše odavde.';

  @override
  String get archiveAction => 'Arhiviraj';

  @override
  String archiveSelected(int count) {
    return 'Arhiviraj $count unosa';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arhivirati $count unosa?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names će biti upisani u fajl i zatim izbrisani — na tvom uređaju i na svakom s kojim sinhronizuješ. Uvoz fajla vraća sve; bez njega su izgubljeni.';
  }

  @override
  String archiveDone(int count) {
    return 'Arhivirano i izbrisano $count unosa';
  }

  @override
  String archiveFailed(String error) {
    return 'Ništa nije izbrisano: fajl arhive nije bilo moguće zapisati ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Baza $db, fotografije $photos u $count fajlova';
  }

  @override
  String quietForYears(int years) {
    return 'Bez promjena $years godina';
  }

  @override
  String get nothingToArchive => 'Ništa nije dovoljno staro za arhiviranje.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Zadnja promjena $date · fotografije $size';
  }

  @override
  String get helpArchive =>
      'Stari podaci troše prostor, najviše fotografije koje nosi svaki sinhronizovani uređaj. Ovdje biraš uginule mačke i prazne kolonije koje godinama miruju, upisuješ ih u fajl koji zadržiš i brišeš ih. Brisanje stiže do svih s kojima sinhronizuješ; uvoz fajla vraća sve.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Vratiti $count izbrisanih unosa?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names su izbrisani u ovom katalogu, a fajl koji si upravo uvezao ih sadrži. Vraćanje ih vraća ovdje i na svaki uređaj s kojim sinhronizuješ.';
  }

  @override
  String get restoreAction => 'Vrati';

  @override
  String get keepDeleted => 'Ostavi izbrisano';

  @override
  String get archiveNotSaved =>
      'Ništa nije izbrisano: arhiva nije nigdje sačuvana.';

  @override
  String get locateAddress => 'Pronađi adresu na karti';

  @override
  String get addressLocated => 'Adresa pronađena';

  @override
  String get addressNotFound =>
      'Za ovu adresu nije pronađeno mjesto. Provjeri pravopis ili ostavi prazno.';

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
  String get includePrivate => 'Podijeli privatne podatke';

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
  String get statusForeverHome => 'Dom';

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
      'Konfeti i klicanje kada mačka pređe u svoj dom';

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
  String get syncChooserInPersonSub => 'Sinkronizacija putem Wi-Fi';

  @override
  String get syncChooserRemote => 'Na daljinu';

  @override
  String get syncChooserRemoteSub =>
      'Sinkronizacija putem foldera ili USB sticka';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Izvoz i uvoz putem društvenih mreža';

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
  String get introTitle1 => 'Vaše mačke, pregledno';

  @override
  String get introBody1 =>
      'Napravite karticu za svaku mačku: fotografija, spol, zdravlje, šta god želite zabilježiti. Mačke su grupisane po mjestu gdje žive — aplikacija ga zove kolonija (clowder).';

  @override
  String get introTitle2 => 'Radi bez interneta';

  @override
  String get introBody2 =>
      'Sve se čuva samo na vašem telefonu. Bez naloga, bez oblaka. Ništa se ne šalje dok sami ne podijelite.';

  @override
  String get introTitle3 => 'Radite zajedno';

  @override
  String get introBody3 =>
      'Svako koristi svoju aplikaciju i povremeno razmjenjujete podatke: nađite se i skenirajte kod, koristite zajednički folder ili pošaljite jedan fajl messengerom. Poslije toga svi imaju iste podatke.';

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
      'Ovdje sinhronizujete s poznanicima. Vi odlučujete šta dijelite.';

  @override
  String get spotHomeStrays =>
      'Ova kartica skuplja sve lutalice — mačke bez doma. Dodirnite za listu.';

  @override
  String get spotHomeMenu =>
      'U ovom meniju: pronađite i spojite duplikate, izvezite CSV i više.';

  @override
  String get spotCatEdit =>
      'Dodirnite olovku da uredite mačku. Savjet: dugi pritisak na polje uređuje ga direktno.';

  @override
  String get spotMapLayers =>
      'Tražite nestalu mačku? Prikažite krugove oko mjesta njenih letaka i oko doma iz kojeg je pobjegla.';

  @override
  String get spotStraysFlier =>
      'Letak o nestaloj mački? Fotografišite ga ovdje — aplikacija čuva mačku i kontakt za vas.';

  @override
  String get spotStraysScan =>
      'Neki letci nose cat(a)log QR kod. Skenirajte ga ovdje i uvezite mačku bez kucanja.';

  @override
  String get introTitle4 => 'Pronađite nestale mačke';

  @override
  String get introBody4 =>
      'Vidite letak o nestaloj mački? Fotografišite ga u aplikaciji: čuva mačku, kontakt vlasnika i mjesto. Pojavi li se kasnije slična lutalica, aplikacija predlaže moguće parove.';

  @override
  String get spotMapSearch =>
      'Upišite mačku, mjesto ili osobu da skočite tamo na karti.';

  @override
  String get spotCardChips =>
      'Označite šta treba biti na kartici za dijeljenje — ostalo ostaje van nje.';

  @override
  String get spotCatMenu =>
      'Ovdje ima još radnji: sakrij mačku, spoji duplikate ili zabilježi viđenje.';

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

  @override
  String get catalogsTitle => 'Katalozi';

  @override
  String get newCatalog => 'Novi katalog';

  @override
  String get catalogNameLabel => 'Naziv kataloga';

  @override
  String catalogNameTaken(String name) {
    return 'Katalog pod nazivom $name već postoji. Odaberi drugo ime.';
  }

  @override
  String get manageCatalogs => 'Upravljanje katalozima';

  @override
  String get helpCatalogs =>
      'Svaki katalog je svijet za sebe: vlastite mačke, kolonije, polja, fotografije i partneri za sinkronizaciju. Berlin i Pariz se nikada ne miješaju. Dodirni ime na vrhu početnog ekrana da promijeniš, dodaš ili preimenuješ. Tvoje ime, jezik i već viđeni savjeti zajednički su svima.';

  @override
  String get spotHomeCatalog =>
      'Ovo je katalog u kojem si. Dodirni ime da promijeniš ili napraviš novi.';

  @override
  String get deleteCatalog => 'Obriši katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Sve u $name nestaje: mačke, fotografije, historija. Prvo se snima potpuna datoteka tamo gdje idu automatske sigurnosne kopije — njen uvoz vraća katalog. Upiši ime za potvrdu.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name je obrisan. Datoteka je u $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Upiši $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Ništa nije obrisano: datoteka kataloga nije mogla biti zapisana ($error). Oslobodi prostor ili pokušaj kasnije.';
  }

  @override
  String get moveToCatalog => 'Premjesti u drugi katalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count premješteno u $name';
  }

  @override
  String get chooseWhatToMove => 'Šta se premješta?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Premjestiti nešto u $name?';
  }

  @override
  String get undoThisImport => 'Poništi ovaj uvoz';

  @override
  String undoImportBody(int count) {
    return '$count promjena iz ovog uvoza se uklanja. Prvo se upisuju u datoteku, čiji ih uvoz vraća. Oni s kojima si već sinkronizirao zadržavaju svoju kopiju — to se ne može povući.';
  }

  @override
  String undoneImport(String where) {
    return 'Poništeno. Datoteka je u $where.';
  }

  @override
  String get goBackTitle => 'Vrati se nazad';

  @override
  String get goBackToHere => 'Vrati se ovdje';

  @override
  String get momentImport => 'Prije uvoza';

  @override
  String get momentSync => 'Prije sinkronizacije';

  @override
  String get momentMerge => 'Prije spajanja';

  @override
  String get momentHardDelete => 'Prije brisanja podataka jednog autora';

  @override
  String get momentArchive => 'Prije arhiviranja';

  @override
  String get momentManual => 'Označio si sam';

  @override
  String get showOlderMoments => 'Prikaži starije';

  @override
  String goBackBody(int count) {
    return 'Sve poslije ovog trenutka se uklanja — $count promjena. Prvo se upisuje u datoteku, čiji ga uvoz vraća, a svaki noviji trenutak odlazi s njim. Oni s kojima si već sinkronizirao zadržavaju kopiju — to se ne može povući.';
  }

  @override
  String get nameThisMoment => 'Imenuj ovaj trenutak';

  @override
  String get helpGoBack =>
      'Trenuci u kojima se ovaj katalog jako promijenio: prije svakog uvoza i svake sinkronizacije, prije spajanja, arhiviranja ili brisanja, i kad god si sam označio trenutak. Odabir jednog vraća katalog u to stanje — sve poslije njega upisuje se u datoteku koju zadržavaš i onda uklanja, a svaki noviji trenutak odlazi s tim. Oni s kojima si već sinkronizirao zadržavaju ono što su dobili.';

  @override
  String goBackFileFailed(String error) {
    return 'Ništa nije uklonjeno: datoteka koja to čuva nije mogla biti zapisana ($error). Oslobodi prostor i pokušaj ponovo.';
  }

  @override
  String get switchBeforeDeleting =>
      'Ovo je katalog u kojem si. Prebaci se na drugi, pa ga obriši.';

  @override
  String shareFileFailed(String error) {
    return 'Datoteka za dijeljenje nije mogla biti zapisana ($error). Oslobodi prostor i pokušaj ponovo.';
  }

  @override
  String get privateLabel => 'Privatno';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Označi kao privatno';

  @override
  String get unmarkPrivate => 'Ukloni privatnu oznaku';

  @override
  String get agenda => 'Podsjetnici';

  @override
  String get reminderLabel => 'Podsjetnik';

  @override
  String get agendaEmpty =>
      'Nema planiranih termina. Nove planiraš ovdje plusom ili na stranici mačke ili clowdera.';

  @override
  String get dueToday => 'danas';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'za $count dana',
      few: 'za $count dana',
      one: 'za $count dan',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dana kašnjenja',
      few: '$count dana kašnjenja',
      one: '$count dan kašnjenja',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Obavljeno';

  @override
  String get repeatTitle => 'Ponovo za…';

  @override
  String get noRepeatLabel => 'Bez ponavljanja';

  @override
  String get unitDays => 'dana';

  @override
  String get unitWeeks => 'sedmica';

  @override
  String get unitMonths => 'mjeseci';

  @override
  String get unitYears => 'godina';

  @override
  String get changeDateLabel => 'Promijeni datum';

  @override
  String get removeReminderLabel => 'Ukloni podsjetnik';

  @override
  String get exportIcs => 'Izvezi kalendarski fajl';

  @override
  String icsSavedTo(String path) {
    return 'Kalendarski fajl sačuvan u $path';
  }

  @override
  String get calendarMirrorLabel => 'Zrcali u kalendar uređaja';

  @override
  String get calendarMirrorSubtitle =>
      'Termini se u kalendaru pojavljuju kao cjelodnevni događaji. cat(a)log ih tamo ažurira pri svakom pokretanju i nakon svake promjene. Podsjetnike na termine upravljaš u kalendaru.';

  @override
  String get syncPeerOlder =>
      'Drugi uređaj ima stariji cat(a)log bez podsjetnika. Ažuriraj cat(a)log tamo i sinhroniziraj ponovo.';

  @override
  String get syncPeerNewer =>
      'Drugi uređaj ima noviji cat(a)log. Ažuriraj cat(a)log na ovom uređaju i sinhroniziraj ponovo.';

  @override
  String get bundleNewerError =>
      'Ovaj fajl dolazi iz novijeg cat(a)loga. Ažuriraj cat(a)log na ovom uređaju da ga uvezeš.';

  @override
  String get spotEar => 'Malo mačje uho u uglu znači: drži pritisnuto za više.';

  @override
  String get addReminder => 'Dodaj podsjetnik';

  @override
  String get plannedSection => 'Planirano';

  @override
  String get reminderDialogHint =>
      'Termin se prikazuje u podsjetnicima. Tamo ga možeš potvrditi ili odbaciti. Vrijednost se preuzima samo ako je termin potvrđen.';

  @override
  String get reminderFor => 'Za';

  @override
  String get reminderField => 'Polje';

  @override
  String get dueDateLabel => 'Rok';

  @override
  String get pickCalendar => 'Koji kalendar?';

  @override
  String get calendarPermissionDenied =>
      'Pristup kalendaru je blokiran, pa je zrcaljenje isključeno. Dozvoli ga u postavkama sistema i ponovo uključi zrcaljenje.';

  @override
  String get calendarNotChosen =>
      'Nije odabran kalendar, pa je zrcaljenje isključeno. Uključi ga ponovo i odaberi jedan.';

  @override
  String get calendarGone =>
      'Odabrani kalendar više ne postoji, pa je zrcaljenje isključeno. Uključi ga ponovo i odaberi drugi.';

  @override
  String get noWritableCalendar =>
      'Kalendar nije pronađen. Prijavi se u postavkama sistema na račun kalendara, na primjer Google, i pokušaj ponovo.';

  @override
  String get spotHomeAgenda =>
      'Podsjetnici: spisak planiranih termina — veterinar, lijekovi, kontrole.';

  @override
  String get spotAgendaAdd => 'Planiraj novi termin.';

  @override
  String get spotAgendaCalendar =>
      'Uključi ovdje zrcaljenje cat(a)log termina u odabrani kalendar.';

  @override
  String get helpAgenda =>
      'Podsjetnici prikazuju planirane termine po datumu. Postoje dvije vrste: termini s vremenom i podsjetnici koji važe za dan. Propušteni ostaju na vrhu. Dodir otvara mačku ili clowder. Kvačica potvrđuje termin: vrijednost se upisuje u polje i odmah možeš planirati sljedeći, na primjer za tri mjeseca. Držanje mijenja datum ili briše termin. Prekidač na vrhu zrcali termine u kalendar tvog telefona. Meni ih izvozi kao kalendarski fajl. Odlazak veterinaru s više mačaka je jedan termin: označi mačke, Agenda prikazuje jednu karticu s njihovim imenima, a pri završetku pita koje su mačke tretirane — odznači ostale, ostaju planirane.';

  @override
  String get calendarRowOff => 'Kalendar: isključen';

  @override
  String calendarRowOn(String name) {
    return 'Kalendar: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Planiraj termin za ovu mačku. Prikazuje se u podsjetnicima i tamo se potvrđuje.';

  @override
  String get spotAddReminderClowder =>
      'Planiraj termin za ovaj clowder. Prikazuje se u podsjetnicima i tamo se potvrđuje.';

  @override
  String get readOnlyCalendar => 'samo za čitanje';

  @override
  String get appointmentLabel => 'Termin';

  @override
  String get addAppointment => 'Dodaj termin';

  @override
  String get planChooserTitle => 'Termin ili podsjetnik?';

  @override
  String get planChooserAppointment =>
      'Termin — posjeta na datum i vrijeme, s bilješkama';

  @override
  String get planChooserReminder =>
      'Podsjetnik — vrijednost koja dospijeva na određeni dan';

  @override
  String get appointmentTitleLabel => 'Šta';

  @override
  String get notesLabel => 'Bilješke';

  @override
  String get timeLabel => 'Vrijeme';

  @override
  String get allDayLabel => 'Cijeli dan';

  @override
  String get alertLabel => 'Upozorenje';

  @override
  String get alertNone => 'Nema';

  @override
  String get alertDayBefore => 'Dan prije';

  @override
  String get alertHourBefore => 'Sat prije';

  @override
  String get linkFieldLabel => 'Po završetku upiši u polje';

  @override
  String get noLinkedField => 'Nema polja';

  @override
  String get outcomeTitle => 'Kako je prošlo?';

  @override
  String get finishLabel => 'Završi';

  @override
  String get editLabelAppointment => 'Uredi termin';

  @override
  String get deleteAppointment => 'Obriši termin';

  @override
  String get stepFlierText => 'Tekst letka';

  @override
  String get qrFoundHint =>
      'Na letku je pronađen QR kod. Označeni kodovi se čitaju radi brojeva registra i linkova.';

  @override
  String get useCode => 'Koristi ovaj kod';

  @override
  String get qrNone => 'Na fotografiji nije pronađen QR kod.';

  @override
  String qrFailed(String error) {
    return 'Čitanje QR koda nije uspjelo: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Prepoznat letak $name. Provjeri dolje u koje polje ide svaki red.';
  }

  @override
  String get flierLayoutUnknown =>
      'Nepoznat raspored letka. Dodijeli redove poljima dolje; ostalo ostaje u napomenama.';

  @override
  String get targetRegistryNumber => 'Broj u registru';

  @override
  String get targetLostPlace => 'Adresa (mjesto nestanka)';

  @override
  String get targetContact => 'Kontakt registra';

  @override
  String get abortScanTitle => 'Prekinuti snimanje?';

  @override
  String get abortScanBody => 'Ništa neće biti sačuvano.';

  @override
  String get abortScan => 'Prekini';

  @override
  String get keepScanning => 'Nastavi';

  @override
  String get catsOnAppointment => 'Mačke na ovom terminu';

  @override
  String get noCatsHint =>
      'Nijedna mačka nije označena — termin pripada samoj koloniji.';

  @override
  String get pickCatsTitle => 'Koje mačke idu?';

  @override
  String catsCount(int count) {
    return '$count mačaka';
  }

  @override
  String get finishUntickHint =>
      'Odznači mačke koje nisu tretirane; ostaju planirane.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Obriši termin za svih $count mačaka';
  }
}
