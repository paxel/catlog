// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Üdv a cat(a)logban';

  @override
  String get welcomeBody =>
      'Válassz magadnak nevet. Minden változtatás ezen a néven kerül rögzítésre, így mások látják, ki mit csinált.';

  @override
  String get yourName => 'A neved';

  @override
  String get start => 'Kezdés';

  @override
  String get clowders => 'Clowderek';

  @override
  String get noClowdersYet => 'Még nincs clowder.\nHozd létre az elsőt alább.';

  @override
  String get strays => 'Kóbor macskák';

  @override
  String get searchCats => 'Macskák keresése';

  @override
  String get map => 'Térkép';

  @override
  String get sync => 'Szinkronizálás';

  @override
  String get fields => 'Mezők';

  @override
  String get exportCsv => 'CSV exportálása';

  @override
  String get aboutAndFeedback => 'Névjegy és visszajelzés';

  @override
  String get newClowder => 'Új clowder';

  @override
  String get name => 'Név';

  @override
  String get cancel => 'Mégse';

  @override
  String get create => 'Létrehozás';

  @override
  String get save => 'Mentés';

  @override
  String get delete => 'Törlés';

  @override
  String get merge => 'Egyesítés';

  @override
  String get resolve => 'Döntés';

  @override
  String get open => 'Megnyitás';

  @override
  String csvSavedTo(String path) {
    return 'CSV mentve ide: $path';
  }

  @override
  String get renameClowder => 'Clowder átnevezése';

  @override
  String get rename => 'Átnevezés';

  @override
  String get timeline => 'Idővonal';

  @override
  String get mergeInto => 'Egyesítés ezzel…';

  @override
  String get deleteClowder => 'Clowder törlése';

  @override
  String get cats => 'Macskák';

  @override
  String get addCat => 'Macska hozzáadása';

  @override
  String get newCat => 'Új macska';

  @override
  String deleteQuestion(String name) {
    return 'Törlöd: $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'A clowder eltűnik a listáról.';

  @override
  String deleteClowderBody(int count) {
    return 'A benne lévő $count macska nem törlődik — kóborrá válnak. Előbb helyezd át őket másik clowderbe, ha nem ezt szeretnéd.';
  }

  @override
  String get card => 'Kartoték';

  @override
  String get shareAsImage => 'Megosztás képként';

  @override
  String get shareAsPdf => 'Megosztás PDF-ként';

  @override
  String get print => 'Nyomtatás';

  @override
  String cardTitle(String name) {
    return 'Kartoték — $name';
  }

  @override
  String get renameCat => 'Macska átnevezése';

  @override
  String get seenHereNow => 'Most itt látták';

  @override
  String get deleteCat => 'Macska törlése';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Kóbor — nincs clowder';

  @override
  String get stray => 'Kóbor';

  @override
  String get photos => 'Fotók';

  @override
  String get addPhoto => 'Fotó hozzáadása';

  @override
  String get setAsProfileImage => 'Beállítás profilképnek';

  @override
  String get thisIsProfileImage => 'Ez a profilkép';

  @override
  String get deletePhoto => 'Fotó törlése';

  @override
  String get deletePhotoTitle => 'Törlöd a fotót?';

  @override
  String get deletePhotoBody =>
      'A fotó adatai végleg törlődnek — nem vonható vissza.';

  @override
  String get deleteCatBody =>
      'A macska eltűnik minden listáról. Fotói végleg törlődnek.';

  @override
  String get sightingRecorded => 'Észlelés rögzítve a pozíciódnál.';

  @override
  String get noLocationAvailable =>
      'Nincs helyadat — helyette nyomd hosszan a térképet.';

  @override
  String get locationDeniedForever =>
      'A helyhozzáférés le van tiltva. Engedélyezze a rendszerbeállításokban a Stray Cam használatához.';

  @override
  String get locationServiceOff =>
      'A helymeghatározás ki van kapcsolva ezen az eszközön. Kapcsolja be a beállításokban, és próbálja újra.';

  @override
  String get locationDenied =>
      'A cat(a)log nem használhatja a tartózkodási helyét. Próbálja újra, és engedélyezze, amikor a rendszer rákérdez.';

  @override
  String get locationNoFix =>
      'A pozícióját most nem sikerült meghatározni. Próbálja újra a szabadban — a GPS-nek szabad rálátás kell az égboltra.';

  @override
  String get ok => 'OK';

  @override
  String get openSettings => 'Beállítások megnyitása';

  @override
  String get notSaved => 'Nincs mentve';

  @override
  String get birthdateInFuture => 'A születési dátum nem lehet a jövőben.';

  @override
  String get deceasedInFuture => 'Az elhalálozás dátuma nem lehet a jövőben.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Az elhalálozás dátuma nem lehet a születési dátum ($date) előtt.';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'A születési dátum nem lehet az elhalálozás dátuma ($date) után.';
  }

  @override
  String get malePregnant =>
      'Ez a macska kandúrként van nyilvántartva — kandúr nem lehet vemhes. Először ellenőrizze az ivart.';

  @override
  String get moveTo => 'Áthelyezés ide';

  @override
  String get noClowderStrayOption => 'Nincs clowder — kóbor / elszökött';

  @override
  String timelineOf(String name) {
    return 'Idővonal — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Változtatás visszavonása';

  @override
  String get revertSubtitle =>
      'Az előző értéket új bejegyzésként állítja vissza — az előzmények mindkettőt megőrzik.';

  @override
  String fieldCleared(String field) {
    return '$field kiürítve';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field vissza erre: \"$value\"';
  }

  @override
  String get leftStray => 'Elment — kóbor';

  @override
  String movedTo(String name) {
    return 'Áthelyezve ide: $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat megérkezett';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat innen jött: $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat ide ment: $place';
  }

  @override
  String get duplicateMergedIn => 'Duplikátum egyesítve';

  @override
  String get asOfToday => 'Mai dátummal';

  @override
  String asOfDate(String date) {
    return 'Dátum: $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Hibás formátum — használja: $format';
  }

  @override
  String get value => 'Érték';

  @override
  String get latitudeLongitude => 'szélesség, hosszúság';

  @override
  String get newField => 'Új mező';

  @override
  String get fieldType => 'Típus';

  @override
  String get usedOn => 'Használat';

  @override
  String get forCats => 'macskákhoz';

  @override
  String get forClowders => 'clowderekhez';

  @override
  String get forBoth => 'mindkettőhöz';

  @override
  String get optionsOnePerLine => 'Lehetőségek (soronként egy)';

  @override
  String get ownValue => 'Saját érték';

  @override
  String get renameField => 'Mező átnevezése';

  @override
  String get editOptions => 'Lehetőségek szerkesztése…';

  @override
  String get noStraysRightNow => 'Most nincs kóbor macska.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Kóbor hozzáadása';

  @override
  String get newStray => 'Új kóbor';

  @override
  String get searchByNameHint => 'Macskák keresése név szerint…';

  @override
  String get host => 'Kiszolgáló';

  @override
  String get hostExplainer =>
      'Kezdd itt, majd írd be a címet és a PIN-t a másik eszközön.';

  @override
  String get startHosting => 'Kiszolgálás indítása';

  @override
  String get stopHosting => 'Kiszolgálás leállítása';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Eddigi munkamenetek: $count';
  }

  @override
  String get join => 'Csatlakozás';

  @override
  String get addressFromHost => 'Cím (a kiszolgáló eszközről)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Szinkronizálás most';

  @override
  String get addressFormatHint =>
      'A címnek így kell kinéznie: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Szinkronizálva: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sikertelen szinkronizálás: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Utolsó szinkronizálás ezzel: $peer: $time';
  }

  @override
  String get sharedFolder => 'Megosztott mappa';

  @override
  String get sharedFolderExplainer =>
      'Szinkronizálás olyan mappán át, amelyet felhő vagy pendrive visz az eszközök között — azoknak, akik nincsenek egy hálózaton.';

  @override
  String get noFolderChosenYet => 'Még nincs mappa kiválasztva';

  @override
  String get choose => 'Kiválasztás…';

  @override
  String get syncFolderNow => 'Mappa szinkronizálása most';

  @override
  String folderSynced(String result) {
    return 'Mappa szinkronizálva: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Mappa szinkronizálása sikertelen: $error';
  }

  @override
  String get recordSightingHere => 'Észlelés rögzítése itt:';

  @override
  String trailOf(String name, int count) {
    return 'Útvonal: $name ($count észlelés)';
  }

  @override
  String conflictOn(String field) {
    return 'Ütközés — $field';
  }

  @override
  String get conflictBody =>
      'Két helyen módosították egyszerre. Válaszd ki, mi igaz:';

  @override
  String mergeThisInto(String kind) {
    return 'E(z) $kind egyesítése ezzel…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Nincs másik $kind az egyesítéshez.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Egyesíted ezzel: $name?';
  }

  @override
  String mergeBody(String name) {
    return 'A két bejegyzésből egy lesz. $name megtartja jelenlegi értékeit; a másik előzményei hozzá csatlakoznak. Nem vonható vissza.';
  }

  @override
  String get kindCat => 'macska';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'mező';

  @override
  String get takePhoto => 'Fotó készítése';

  @override
  String get chooseFromGallery => 'Választás a galériából';

  @override
  String get about => 'Névjegy';

  @override
  String get aboutTagline =>
      'Helyi katalógus ideiglenesen befogadott macskákhoz. Adataid az eszközeiden maradnak — se szerver, se fiók.';

  @override
  String versionLabel(String version, String build) {
    return 'Verzió: $version ($build)';
  }

  @override
  String get sourceCode => 'Forráskód';

  @override
  String get reportProblemOrIdea => 'Hiba vagy ötlet bejelentése';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Írj a fejlesztőnek';

  @override
  String get buyCoffee => 'Hívd meg a fejlesztőt egy kávéra';

  @override
  String get coffeeSubtitle => 'Teljesen önkéntes — az app ingyenes';

  @override
  String get openSourceLicenses => 'Nyílt forráskódú licencek';

  @override
  String get machineTranslated =>
      'A fordítások gépiek — a javításokat szívesen fogadjuk GitHubon.';

  @override
  String get unnamed => '(névtelen)';

  @override
  String get labelName => 'Név';

  @override
  String get labelProfileImage => 'Profilkép';

  @override
  String get labelPhoto => 'Fotó';

  @override
  String get starterGender => 'Ivar';

  @override
  String get starterBreed => 'Fajta';

  @override
  String get valueMixed => 'keverék';

  @override
  String get breedEuropeanShorthair => 'Európai rövidszőrű';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Brit rövidszőrű';

  @override
  String get breedNorwegianForestCat => 'Norvég erdei macska';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Sziámi';

  @override
  String get breedPersian => 'Perzsa';

  @override
  String get breedBengal => 'Bengáli';

  @override
  String get breedSphynx => 'Szfinx';

  @override
  String get starterColor => 'Szín';

  @override
  String get starterNeutered => 'Ivartalanított';

  @override
  String get starterPregnant => 'Vemhes';

  @override
  String get starterBirthdate => 'Születési dátum';

  @override
  String get starterDeceased => 'Elhunyt';

  @override
  String get starterAddress => 'Cím';

  @override
  String get starterResponsible => 'Felelős személy';

  @override
  String get starterPosition => 'Pozíció';

  @override
  String get valueYes => 'igen';

  @override
  String get valueNo => 'nem';

  @override
  String get valueFemale => 'nőstény';

  @override
  String get valueMale => 'kandúr';

  @override
  String get valueUnknown => 'ismeretlen';

  @override
  String get cropTitle => 'Fotó körbevágása';

  @override
  String get markTitle => 'Macska megjelölése';

  @override
  String get applyCrop => 'Kivágás';

  @override
  String get useFullPhoto => 'Teljes fotó használata';

  @override
  String get dragToSelect => 'Húzz téglalapot a macska köré';

  @override
  String get dragOverTheCat => 'Húzz ellipszist a macskára';

  @override
  String get cropPhoto => 'Körbevágás…';

  @override
  String get markPhoto => 'Megjelölés…';

  @override
  String get scanCode => 'Kód beolvasása';

  @override
  String get orTypeCode => 'Vagy írd be a kódot';

  @override
  String get copyCode => 'Kód másolása';

  @override
  String get copied => 'Másolva';

  @override
  String get invalidCode => 'Ez a kód érvénytelen';

  @override
  String get hotspotHint =>
      'Nincs közös Wi-Fi? Kapcsold be az egyik telefon hotspotját, csatlakoztasd a másikat, majd itt legyél kiszolgáló.';

  @override
  String get byMessenger => 'Üzenetküldővel';

  @override
  String get byMessengerExplainer =>
      'Küldd el az egész katalógust egy fájlként WhatsAppon, Signalon vagy mailben — a másik oldal importálja.';

  @override
  String get shareBundle => 'Szinkroncsomag megosztása…';

  @override
  String get importBundle => 'Szinkroncsomag importálása…';

  @override
  String bundleImported(String result) {
    return 'Csomag importálva: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Az utolsó automatikus biztonsági mentés sikertelen: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Importálás sikertelen: $error';
  }

  @override
  String get pickOnMap => 'Kiválasztás térképen';

  @override
  String get useMyLocation => 'Saját helyzetem használata';

  @override
  String get language => 'Nyelv';

  @override
  String get systemDefault => 'Rendszer alapértelmezés';

  @override
  String get iosLocalNetworkHint =>
      'Ha iPhone-on/iPaden továbbra sem megy: Beállítások → Adatvédelem és biztonság → Helyi hálózat → engedélyezd a cat(a)log-ot, majd próbáld újra.';

  @override
  String get crashTitle => 'Ennek nem lett volna szabad megtörténnie';

  @override
  String get crashBody =>
      'A cat(a)log váratlan hibába ütközött. Az adataid biztonságban vannak — minden a módosítás pillanatában mentődik. Indítsd újra az appot, és ha ismétlődik, küldd el a jelentést, hogy javítható legyen.';

  @override
  String get crashRestart => 'App újraindítása';

  @override
  String get crashSendReport => 'Jelentés küldése a fejlesztőnek';

  @override
  String get crashLastRunBody =>
      'A cat(a)log legutóbb váratlanul leállt — valószínűleg elfogyott a memória. Küldjünk rövid jelentést, hogy javítható legyen?';
}
