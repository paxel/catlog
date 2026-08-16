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
  String get noClowdersYet => 'Još nema clowdera.\nNapravite prvi ispod.';

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
      'Mačka nestaje sa svih spiskova. Njene fotografije se trajno brišu.';

  @override
  String get sightingRecorded => 'Viđenje zabilježeno na vašoj poziciji.';

  @override
  String get noLocationAvailable =>
      'Lokacija nedostupna — umjesto toga dugo pritisnite mapu.';

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
  String get starterStatus => 'Status';

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
}
