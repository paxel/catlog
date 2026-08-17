// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Dobro došli u cat(a)log';

  @override
  String get welcomeBody =>
      'Odaberite si ime. Svaka promjena bilježi se pod tim imenom, da drugi vide tko je što napravio.';

  @override
  String get yourName => 'Vaše ime';

  @override
  String get start => 'Počni';

  @override
  String get clowders => 'Clowderi';

  @override
  String get noClowdersYet => 'Još nema clowdera.\nStvorite prvi ispod.';

  @override
  String get strays => 'Lutalice';

  @override
  String get searchCats => 'Traži mačke';

  @override
  String get map => 'Karta';

  @override
  String get sync => 'Sinkronizacija';

  @override
  String get fields => 'Polja';

  @override
  String get exportCsv => 'Izvezi CSV';

  @override
  String get aboutAndFeedback => 'O aplikaciji i povratne informacije';

  @override
  String get newClowder => 'Novi clowder';

  @override
  String get name => 'Ime';

  @override
  String get cancel => 'Odustani';

  @override
  String get create => 'Stvori';

  @override
  String get save => 'Spremi';

  @override
  String get delete => 'Izbriši';

  @override
  String get merge => 'Spoji';

  @override
  String get resolve => 'Odluči';

  @override
  String get open => 'Otvori';

  @override
  String csvSavedTo(String path) {
    return 'CSV spremljen u $path';
  }

  @override
  String get renameClowder => 'Preimenuj clowder';

  @override
  String get rename => 'Preimenuj';

  @override
  String get timeline => 'Vremenska crta';

  @override
  String get mergeInto => 'Spoji s…';

  @override
  String get deleteClowder => 'Izbriši clowder';

  @override
  String get cats => 'Mačke';

  @override
  String get addCat => 'Dodaj mačku';

  @override
  String get newCat => 'Nova mačka';

  @override
  String deleteQuestion(String name) {
    return 'Izbrisati $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder nestaje s popisa.';

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
  String get print => 'Ispiši';

  @override
  String cardTitle(String name) {
    return 'Kartica — $name';
  }

  @override
  String get renameCat => 'Preimenuj mačku';

  @override
  String get seenHereNow => 'Viđena ovdje sada';

  @override
  String get deleteCat => 'Izbriši mačku';

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
  String get deletePhoto => 'Izbriši fotografiju';

  @override
  String get deletePhotoTitle => 'Izbrisati fotografiju?';

  @override
  String get deletePhotoBody =>
      'Podaci fotografije trajno se brišu — nema povratka.';

  @override
  String get deleteCatBody =>
      'Mačka nestaje sa svih popisa. Njezine fotografije trajno se brišu.';

  @override
  String get sightingRecorded => 'Viđenje zabilježeno na vašoj poziciji.';

  @override
  String get noLocationAvailable =>
      'Lokacija nedostupna — umjesto toga dugo pritisnite kartu.';

  @override
  String get moveTo => 'Premjesti u';

  @override
  String get noClowderStrayOption => 'Bez clowdera — lutalica / pobjegla';

  @override
  String timelineOf(String name) {
    return 'Vremenska crta — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Poništi ovu promjenu';

  @override
  String get revertSubtitle =>
      'Vraća prethodnu vrijednost kao novi zapis — povijest čuva oboje.';

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
  String get asOfToday => 'S današnjim datumom';

  @override
  String asOfDate(String date) {
    return 'S datumom $date';
  }

  @override
  String get value => 'Vrijednost';

  @override
  String get latitudeLongitude => 'zemljopisna širina, dužina';

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
  String get optionsOnePerLine => 'Opcije (jedna po retku)';

  @override
  String get renameField => 'Preimenuj polje';

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
  String get addressFromHost => 'Adresa (s uređaja domaćina)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sinkroniziraj sada';

  @override
  String get addressFormatHint =>
      'Adresa mora izgledati kao 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sinkronizirano: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sinkronizacija nije uspjela: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Zadnja sinkronizacija s $peer: $time';
  }

  @override
  String get sharedFolder => 'Dijeljena mapa';

  @override
  String get sharedFolderExplainer =>
      'Sinkronizirajte preko mape koju oblak ili USB stick prenosi među uređajima — za one koji nisu na istoj mreži.';

  @override
  String get noFolderChosenYet => 'Mapa još nije odabrana';

  @override
  String get choose => 'Odaberi…';

  @override
  String get syncFolderNow => 'Sinkroniziraj mapu sada';

  @override
  String folderSynced(String result) {
    return 'Mapa sinkronizirana: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sinkronizacija mape nije uspjela: $error';
  }

  @override
  String get recordSightingHere => 'Zabilježi viđenje ovdje:';

  @override
  String get orPlaceClowderHere => 'Ili ovdje postavi clowder:';

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
      'Promijenjeno na dva mjesta istodobno. Odaberite što je točno:';

  @override
  String mergeThisInto(String kind) {
    return 'Spoji ovaj zapis ($kind) s…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Nema drugog zapisa ($kind) za spajanje.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Spojiti s $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Dva zapisa postaju jedan. $name zadržava trenutne vrijednosti; povijest drugoga pridružuje se njegovoj. Nema povratka.';
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
  String get chooseFromGallery => 'Odaberi iz galerije';

  @override
  String get about => 'O aplikaciji';

  @override
  String get aboutTagline =>
      'Lokalni katalog za udomljene mačke. Vaši podaci ostaju na vašim uređajima — bez poslužitelja, bez računa.';

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
  String get writeTheDeveloper => 'Piši razvijatelju';

  @override
  String get buyCoffee => 'Časti razvijatelja kavom';

  @override
  String get coffeeSubtitle => 'Potpuno dobrovoljno — aplikacija je besplatna';

  @override
  String get openSourceLicenses => 'Licence otvorenog koda';

  @override
  String get machineTranslated =>
      'Prijevodi su strojni — ispravci su dobrodošli na GitHubu.';

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
  String get starterColor => 'Boja';

  @override
  String get starterNeutered => 'Kastrirana';

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
  String get starterPosition => 'Pozicija';

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
  String get useFullPhoto => 'Koristi cijelu fotografiju';

  @override
  String get dragToSelect => 'Povuci pravokutnik oko mačke';

  @override
  String get dragOverTheCat => 'Povuci elipsu preko mačke';

  @override
  String get cropPhoto => 'Izreži…';

  @override
  String get markPhoto => 'Označi…';

  @override
  String get scanCode => 'Skeniraj kod';

  @override
  String get orTypeCode => 'Ili upiši kod';

  @override
  String get copyCode => 'Kopiraj kod';

  @override
  String get copied => 'Kopirano';

  @override
  String get invalidCode => 'Taj kod nije valjan';

  @override
  String get hotspotHint =>
      'Nema zajedničkog Wi-Fija? Uključi hotspot na jednom telefonu, spoji drugi i budi domaćin ovdje.';

  @override
  String get byMessenger => 'Preko messengera';

  @override
  String get byMessengerExplainer =>
      'Pošalji cijeli katalog kao jednu datoteku preko WhatsAppa, Signala ili maila — druga strana je uvozi.';

  @override
  String get shareBundle => 'Podijeli paket sinkronizacije…';

  @override
  String get importBundle => 'Uvezi paket sinkronizacije…';

  @override
  String bundleImported(String result) {
    return 'Paket uvezen: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Uvoz nije uspio: $error';
  }

  @override
  String get pickOnMap => 'Odaberi na karti';

  @override
  String get useMyLocation => 'Koristi moju lokaciju';

  @override
  String get language => 'Jezik';

  @override
  String get systemDefault => 'Zadano sustavom';

  @override
  String get iosLocalNetworkHint =>
      'Ako i dalje ne uspijeva na iPhoneu/iPadu: Postavke → Privatnost i sigurnost → Lokalna mreža → dopusti cat(a)log pa pokušaj ponovno.';

  @override
  String get crashTitle => 'Ovo se nije smjelo dogoditi';

  @override
  String get crashBody =>
      'cat(a)log je naišao na neočekivanu grešku. Tvoji su podaci sigurni — sve se sprema čim se promijeni. Ponovno pokreni aplikaciju, a ako se ponavlja, pošalji izvještaj da se popravi.';

  @override
  String get crashRestart => 'Ponovno pokreni aplikaciju';

  @override
  String get crashSendReport => 'Pošalji izvještaj razvijatelju';

  @override
  String get crashLastRunBody =>
      'cat(a)log se prošli put neočekivano zaustavio — najvjerojatnije je ponestalo memorije. Poslati kratak izvještaj da se popravi?';
}
