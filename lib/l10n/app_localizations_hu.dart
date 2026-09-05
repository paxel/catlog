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
  String get clowdersNeutral => 'Háztartások';

  @override
  String get noClowdersYet =>
      'Még nincs clowder. A clowder egy hely, ahol macskák élnek — az ideiglenes befogadód, egy örökbefogadó lakása. Hozd létre az elsőt lent.';

  @override
  String get noClowdersYetNeutral =>
      'Még nincs háztartás. A háztartás egy hely, ahol kisállatok élnek — az otthonod, egy ideiglenes befogadó, egy örökbefogadó lakása. Hozd létre az elsőt lent.';

  @override
  String get strays => 'Kóbor macskák';

  @override
  String get searchCats => 'Macskák keresése';

  @override
  String get searchCatsNeutral => 'Kisállatok keresése';

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
  String get settings => 'Beállítások';

  @override
  String get newClowder => 'Új clowder';

  @override
  String get newClowderNeutral => 'Új háztartás';

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
  String get renameClowderNeutral => 'Háztartás átnevezése';

  @override
  String get rename => 'Átnevezés';

  @override
  String get timeline => 'Idővonal';

  @override
  String get mergeInto => 'Egyesítés ezzel…';

  @override
  String get deleteClowder => 'Clowder törlése';

  @override
  String get deleteClowderNeutral => 'Háztartás törlése';

  @override
  String get cats => 'Macskák';

  @override
  String get catsNeutral => 'Kisállatok';

  @override
  String get addCat => 'Macska hozzáadása';

  @override
  String get addCatNeutral => 'Kisállat hozzáadása';

  @override
  String get newCat => 'Új macska';

  @override
  String get newCatNeutral => 'Új kisállat';

  @override
  String deleteQuestion(String name) {
    return 'Törlöd: $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'A clowder eltűnik a listáról.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'A háztartás eltűnik a listáról.';

  @override
  String deleteClowderBody(int count) {
    return 'A benne lévő $count macska nem törlődik — kóborrá válnak. Előbb helyezd át őket másik clowderbe, ha nem ezt szeretnéd.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'A benne lévő $count kisállat nem törlődik — kóborrá válnak. Előbb helyezd át őket másik háztartásba, ha nem ezt szeretnéd.';
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
  String get renameCatNeutral => 'Kisállat átnevezése';

  @override
  String get seenHereNow => 'Most itt látták';

  @override
  String get deleteCat => 'Macska törlése';

  @override
  String get deleteCatNeutral => 'Kisállat törlése';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get clowderLabelNeutral => 'Háztartás';

  @override
  String get strayNoClowder => 'Kóbor — nincs clowder';

  @override
  String get strayNoClowderNeutral => 'Kóbor — nincs háztartás';

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
      'A macska eltűnik minden listáról, fotói törlődnek — itt és a következő szinkron után a többi eszközön is.';

  @override
  String get deleteCatBodyNeutral =>
      'A kisállat eltűnik minden listáról, fotói törlődnek — itt és a következő szinkron után a többi eszközön is.';

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
  String get starterChipId => 'Chipszám';

  @override
  String get starterRemarks => 'Megjegyzések';

  @override
  String get captureFlier => 'Plakát lefotózása';

  @override
  String get addPhotosTo => 'Fotók hozzáadása ehhez…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotó hozzáadva ehhez: $name';
  }

  @override
  String get scanPrintedCode => 'Nyomtatott kód beolvasása';

  @override
  String get chipScanHint =>
      'A chipkártyán vagy állatorvosi papírokon lévő nyomtatott QR-/vonalkódot olvassa be — a macskában lévő chipet a telefon nem tudja leolvasni.';

  @override
  String get chipScanHintNeutral =>
      'A chipkártyán vagy állatorvosi papírokon lévő nyomtatott QR-/vonalkódot olvassa be — az állatban lévő chipet a telefon nem tudja leolvasni.';

  @override
  String get savingLabel => 'Mentés…';

  @override
  String ownerOfCat(String name) {
    return '$name gazdája';
  }

  @override
  String get sortLabel => 'Rendezés';

  @override
  String get viewAsTable => 'Táblázatként';

  @override
  String get viewAsTiles => 'Csempeként';

  @override
  String get viewAsList => 'Megjelenítés listaként';

  @override
  String get ageLabel => 'Kor';

  @override
  String get catList => 'Macskalista';

  @override
  String get catListNeutral => 'Kisállatlista';

  @override
  String get matchCandidatesTitle => 'Lehetséges egyezések';

  @override
  String get findDuplicates => 'Duplikátumok keresése';

  @override
  String get noDuplicates => 'Jelenleg nincs lehetséges duplikátum.';

  @override
  String get similarName => 'Hasonló név';

  @override
  String get sharePublicly => 'Nyilvános megosztás…';

  @override
  String get pickFramesTitle => 'Képkockák kiválasztása';

  @override
  String get suggestedFrames => 'Javasolt képkockák';

  @override
  String get scrubFrames => 'Videó léptetése';

  @override
  String get keepThisFrame => 'Képkocka megtartása';

  @override
  String get fromVideo => 'Videóból…';

  @override
  String get videoMobileOnly =>
      'A videóból való képkocka-kiemelés a telefonos alkalmazásban működik (Android és iPhone) — ezen az eszközön még nem.';

  @override
  String get shareWhitelistExplainer =>
      'Válaszd ki, mi kerüljön a fájlba. Csak a bejelölt mezők kerülnek bele.';

  @override
  String get exportShareFile => 'Megosztási fájl exportálása…';

  @override
  String get hostedLink => 'Tárolt link (a feltöltött fájl URL-je)';

  @override
  String get inlineQr => 'Beágyazott QR (csak szöveg, fotók nélkül)';

  @override
  String get inlineTooBig =>
      'Túl sok adat a beágyazott kódhoz — vegyen ki mezőket, vagy használjon tárolt linket.';

  @override
  String get scanShareLabel => 'Megosztási kód beolvasása';

  @override
  String get notAShareCode => 'Ez a kód nem cat(a)log-megosztás.';

  @override
  String get importShareTitle => 'Importálja ezt a macskát?';

  @override
  String get importShareTitleNeutral => 'Importálja ezt a kisállatot?';

  @override
  String shareSource(String url) {
    return 'Forrás: $url';
  }

  @override
  String get importLabel => 'Importálás';

  @override
  String get strayAreaLabel => 'Lehetséges kóborlási terület';

  @override
  String get prevPin => 'Előző tű';

  @override
  String get nextPin => 'Következő tű';

  @override
  String get noMissingCats => 'Még nincs eltűnt macska plakátpozícióval.';

  @override
  String get noMissingCatsNeutral =>
      'Még nincs eltűnt kisállat plakátpozícióval.';

  @override
  String get noMatchCandidates => 'Jelenleg nincs lehetséges egyezés.';

  @override
  String sameIdField(String field) {
    return 'Azonos $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m-re egymástól';
  }

  @override
  String get addFlier => 'Plakát hozzáadása';

  @override
  String get missingSinceLabel => 'Eltűnt ekkortól';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Portré kivágása';

  @override
  String get statusOwner => 'Gazda';

  @override
  String get ocrUnavailable =>
      'A szövegfelismerés ezen az eszközön nem érhető el — írja be a plakát szövegét kézzel.';

  @override
  String get displayFormat => 'Megjelenítés';

  @override
  String get displayPlain => 'Egyszerű szöveg';

  @override
  String get displayQr => 'QR-kód';

  @override
  String get displayBarcode => 'Vonalkód';

  @override
  String get editLabel => 'Szerkesztés';

  @override
  String get doneLabel => 'Kész';

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
  String get malePregnantNeutral =>
      'Ez a kisállat hímként van nyilvántartva — hím nem lehet vemhes. Először ellenőrizze az ivart.';

  @override
  String fatherNotMale(String name) {
    return '$name nőstényként van nyilvántartva, így nem lehet az apa. Először ellenőrizze az ivart.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name kandúrként van nyilvántartva, így nem lehet az anya. Először ellenőrizze az ivart.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name $date született — a szülő nem születhet a kölyke után.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name $date született — a szülő nem születhet a kölyke után.';
  }

  @override
  String get genderFatherFemale =>
      'Ez a macska más macskák apjaként szerepel — az apa nem lehet nőstény. Először ellenőrizze a családot.';

  @override
  String get genderFatherFemaleNeutral =>
      'Ez a kisállat más kisállatok apjaként szerepel — az apa nem lehet nőstény. Először ellenőrizze a családot.';

  @override
  String get genderMotherMale =>
      'Ez a macska más macskák anyjaként szerepel — az anya nem lehet kandúr. Először ellenőrizze a családot.';

  @override
  String get genderMotherMaleNeutral =>
      'Ez a kisállat más kisállatok anyjaként szerepel — az anya nem lehet hím. Először ellenőrizze a családot.';

  @override
  String get moveTo => 'Áthelyezés ide';

  @override
  String get noClowderStrayOption => 'Nincs clowder — kóbor / elszökött';

  @override
  String get noClowderStrayOptionNeutral =>
      'Nincs háztartás — kóbor / elszökött';

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
  String get dateInFuture => 'Ez a dátum nem lehet a jövőben.';

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
  String get forCatsNeutral => 'kisállatokhoz';

  @override
  String get forClowders => 'clowderekhez';

  @override
  String get forClowdersNeutral => 'háztartásokhoz';

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
  String get searchByNameHintNeutral => 'Kisállatok keresése név szerint…';

  @override
  String get host => 'Kiszolgáló';

  @override
  String get hostExplainer =>
      'Kezdd itt, majd olvasd be a kódot vagy írd be a másik eszközön.';

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
      'Mindkét eszköz ugyanazt a mappát használja (pl. Dropboxban vagy pendrive-on). Minden szinkron odaírja a te változásaidat és átveszi a másikét.';

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
  String trailOfField(String name, String field, int count) {
    return 'Nyom: $name — $field ($count érték)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Nyom: $name ($count pozíció)';
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
  String get kindCatNeutral => 'kisállat';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindClowderNeutral => 'háztartás';

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
  String get aboutTaglineNeutral =>
      'Helyi katalógus a gondozott kisállataidhoz. Adataid az eszközeiden maradnak — se szerver, se fiók.';

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
  String get coffeeSubtitle =>
      'Az app ingyenes marad. Akkor is, ha nem kapok kávét :)';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Kereső hivatkozás';

  @override
  String lookupUrlHelp(String token) {
    return 'A szolgáltatás oldala $token helyén a számmal, pl. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Megnézés';

  @override
  String lookupFailed(String url) {
    return 'Egyetlen alkalmazás sem tudta megnyitni ezt: $url. Másold a linket egy böngészőbe.';
  }

  @override
  String get stepCat => 'Macska';

  @override
  String get stepCatNeutral => 'Kisállat';

  @override
  String get stepOwner => 'Gazdi';

  @override
  String get stepFace => 'Arckép';

  @override
  String get stepRegistry => 'Nyilvántartás';

  @override
  String get stepReview => 'Ellenőrzés és mentés';

  @override
  String get stepOwnerHint =>
      'Aki keresi a macskát — ebből lesz az ő clowdere, a plakáton szereplő elérhetőséggel.';

  @override
  String get stepOwnerHintNeutral =>
      'Aki keresi a kisállatot — ebből lesz az ő háztartása, a plakáton szereplő elérhetőséggel.';

  @override
  String get stepFaceHint =>
      'Vágd ki a macska arcát a plakátból; ez lesz a profilkép. Ki is hagyhatod.';

  @override
  String get stepFaceHintNeutral =>
      'Vágd ki a kisállat arcát a plakátból; ez lesz a profilkép. Ki is hagyhatod.';

  @override
  String get stepRegistryHint =>
      'A plakáton talált számok. A bejelöltek a macskához mentődnek, és később megnyithatók.';

  @override
  String get stepRegistryHintNeutral =>
      'A plakáton talált számok. A bejelöltek a kisállathoz mentődnek, és később megnyithatók.';

  @override
  String get noRegistryLinks =>
      'Nincs nyilvántartási link ezen a plakáton — ha valamelyik kimaradt, kérjük, jelezd hibaként.';

  @override
  String get unknownServiceHint => 'Ismeretlen szolgáltatás';

  @override
  String get rememberService => 'Szolgáltatás megjegyzése';

  @override
  String get rememberServiceHint =>
      'Nevezd el a szolgáltatást, és mutass rá a számra a linkben. A következő plakát magától kitöltődik.';

  @override
  String get noIdInLink =>
      'Ebben a linkben nincs olyan szám, amit az app elmenthetne.';

  @override
  String get whichNumber => 'Melyik rész a szám?';

  @override
  String get cropAgain => 'Új vágás';

  @override
  String get noFaceYet => 'Még nincs arckép — a plakát fotója lesz használva.';

  @override
  String get backLabel => 'Vissza';

  @override
  String get dangerButton => 'NE NYOMD MEG.\nVESZÉLY';

  @override
  String get dangerThanks => 'Köszönjük, hogy a cat(a)logot használod!';

  @override
  String get helpTitle => 'Súgó';

  @override
  String get showTipsAgain => 'Tippek újra';

  @override
  String get helpHome =>
      'A kolóniáid áttekintése — a kolónia egy hely, ahol macskák élnek: az otthonod, egy ideiglenes befogadó, egy menhely. Koppints egy kártyára a macskáiért; hosszan nyomva jön a menü. A jobb alsó gomb új kolóniát hoz létre, a kóborlók kártyája pedig minden otthontalan macskát összegyűjt. A fenti név a katalógus, amelyben vagy — koppints rá a váltáshoz vagy új létrehozásához.';

  @override
  String get helpHomeNeutral =>
      'A háztartásaid áttekintése — a háztartás egy hely, ahol kisállatok élnek: az otthonod, egy ideiglenes befogadó, egy menhely. Koppints egy kártyára a kisállataiért; hosszan nyomva jön a menü. A jobb alsó gomb új háztartást hoz létre, a kóborlók kártyája pedig minden otthontalan kisállatot összegyűjt. A fenti név a katalógus, amelyben vagy — koppints rá a váltáshoz vagy új létrehozásához.';

  @override
  String get helpClowder =>
      'Minden erről a helyről: macskái, mezői (cím, elérhetőség, típus) és előzményei. Az oldal csak olvasható; a ceruza kapcsolja be a szerkesztést, ott új mezőt is felvehetsz. Egy mezőt hosszan nyomva rögtön szerkeszted, egy macskát hosszan nyomva átviszed, elrejted vagy megnyitod. Az itt hozzáadott időpont a kolónia több macskáját is viheti, például egy ivartalanítási útra: jelöld be a macskákat, amelyek jönnek, fejezd be egyszer, vedd ki a jelölést a nem kezelteknél. A mező melletti óra megnyitja az előzményeit.';

  @override
  String get helpClowderNeutral =>
      'Minden erről a helyről: kisállatai, mezői (cím, elérhetőség, típus) és előzményei. Az oldal csak olvasható; a ceruza kapcsolja be a szerkesztést, ott új mezőt is felvehetsz. Egy mezőt hosszan nyomva rögtön szerkeszted, egy kisállatot hosszan nyomva átviszed, elrejted vagy megnyitod. Az itt hozzáadott időpont a háztartás több kisállatát is viheti, például egy ivartalanítási útra: jelöld be a kisállatokat, amelyek jönnek, fejezd be egyszer, vedd ki a jelölést a nem kezelteknél. A mező melletti óra megnyitja az előzményeit.';

  @override
  String get helpCat =>
      'Minden erről a macskáról: fotók, mezők, család, előzmények. Az oldal csak olvasható, amíg a ceruzára nem koppintasz. Egy mező hosszú nyomása rögtön a szerkesztésébe visz; egy fotó hosszú nyomása a menüjét nyitja. A jobb felső menüben van a többi: elrejtés, összevonás, észlelés rögzítése, a macska megosztása. A Privát a mező szerkesztésekor állítható. A mező melletti óra megnyitja az előzményeit.';

  @override
  String get helpCatNeutral =>
      'Minden erről a kisállatról: fotók, mezők, család, előzmények. Az oldal csak olvasható, amíg a ceruzára nem koppintasz. Egy mező hosszú nyomása rögtön a szerkesztésébe visz; egy fotó hosszú nyomása a menüjét nyitja. A jobb felső menüben van a többi: elrejtés, összevonás, észlelés rögzítése, a kisállat megosztása. A Privát a mező szerkesztésekor állítható. A mező melletti óra megnyitja az előzményeit.';

  @override
  String get helpStrays =>
      'Macskák, akiknek most nincs otthonuk: talált, megszökött vagy plakátról származó állatok. A kamera gomb rögzíti az előtted ülő macskát; a plakát gomb egy eltűnt-plakátból macskát csinál a gazdi elérhetőségével; az olvasó beolvassa a plakáton lévő cat(a)log kódot. Koppints a Stray Camre egy fotóhoz; tartsd lenyomva videóhoz, és a legjobb képkockákat fotóként megtarthatod.';

  @override
  String get helpStraysNeutral =>
      'Kisállatok, akiknek most nincs otthonuk: talált, megszökött vagy plakátról származó állatok. A kamera gomb rögzíti az előtted lévő állatot; a plakát gomb egy eltűnt-plakátból kisállatot csinál a gazdi elérhetőségével; az olvasó beolvassa a plakáton lévő cat(a)log kódot. Koppints a Stray Camre egy fotóhoz; tartsd lenyomva videóhoz, és a legjobb képkockákat fotóként megtarthatod.';

  @override
  String get helpMap =>
      'Minden macska és hely, aminek van pozíciója. A keresés macskát, embert és helyet talál — az ismeretlen nevet az egész világon keresi. A rétegek gomb megrajzolja az 500 m-es köröket egy eltűnt macska plakáthelyei és a régi otthona köré. A nyilak tűről tűre lépnek, hosszan nyomva a térképet észlelést rögzítesz. Minden helymező gombostű a térképen; koppints egy gombostűre a nyomvonalához.';

  @override
  String get helpMapNeutral =>
      'Minden kisállat és hely, aminek van pozíciója. A keresés kisállatot, embert és helyet talál — az ismeretlen nevet az egész világon keresi. A rétegek gomb megrajzolja az 500 m-es köröket egy eltűnt kisállat plakáthelyei és a régi otthona köré. A nyilak tűről tűre lépnek, hosszan nyomva a térképet észlelést rögzítesz. Minden helymező gombostű a térképen; koppints egy gombostűre a nyomvonalához.';

  @override
  String get helpCard =>
      'A macska nyomtatható kártyája: fent a chipekkel választod ki, mi kerüljön rá, aztán képként vagy PDF-ként osztod meg. A számok QR-ként vagy vonalkódként nyomtathatók, a pozícióból pedig térképet nyitó QR lesz, plusz egy rövid Plus Code.';

  @override
  String get helpCardNeutral =>
      'A kisállat nyomtatható kártyája: fent a chipekkel választod ki, mi kerüljön rá, aztán képként vagy PDF-ként osztod meg. A számok QR-ként vagy vonalkódként nyomtathatók, a pozícióból pedig térképet nyitó QR lesz, plusz egy rövid Plus Code.';

  @override
  String get helpSync =>
      'Így jutnak az adatok másokhoz: közvetlen kapcsolat, mindkét eszköz által látott mappa, vagy fájl küldése üzenetküldővel. Mindig te döntöd el, mi megy el — és a kapott .catsync fájlokat is itt nyitod meg.';

  @override
  String get helpFields =>
      'A katalógusod mezői. Nevezd át őket, változtasd a választómező lehetőségeit, vagy hozz létre sajátot. Egy azonosító mező mutathat egy szolgáltatásra (nyilvántartásra), így a szám a macskánál koppintható lesz.';

  @override
  String get helpFieldsNeutral =>
      'A katalógusod mezői. Nevezd át őket, változtasd a választómező lehetőségeit, vagy hozz létre sajátot. Egy azonosító mező mutathat egy szolgáltatásra (nyilvántartásra), így a szám a kisállatnál koppintható lesz.';

  @override
  String get helpTimeline =>
      'Minden valaha végzett változtatás, a legújabb elöl: ki mit mikor és milyen értékre módosított. Bármelyik bejegyzés visszavonható — ez új bejegyzést ír, semmi nem törlődik.';

  @override
  String get helpDuplicates =>
      'Macskák vagy kolóniák, amik kétszer szerepelnek — azonos azonosítók vagy nagyon hasonló nevek egyező részletekkel. Koppints egy párra az összevonáshoz; ez nem vonható vissza, ezért előbb rákérdez.';

  @override
  String get helpDuplicatesNeutral =>
      'Kisállatok vagy háztartások, amik kétszer szerepelnek — azonos azonosítók vagy nagyon hasonló nevek egyező részletekkel. Koppints egy párra az összevonáshoz; ez nem vonható vissza, ezért előbb rákérdez.';

  @override
  String get helpMatches =>
      'Macskák, amik ugyanaz az állat lehetnek: azonos azonosító, vagy egy kóborló, akit egy eltűnt macska keresési területén láttak. Koppints egy párra az összevonáshoz, hosszan nyomva megnyílik az első macska összehasonlításhoz.';

  @override
  String get helpMatchesNeutral =>
      'Kisállatok, amik ugyanaz az állat lehetnek: azonos azonosító, vagy egy kóborló, akit egy eltűnt kisállat keresési területén láttak. Koppints egy párra az összevonáshoz, hosszan nyomva megnyílik az első kisállat összehasonlításhoz.';

  @override
  String get helpFlier =>
      'Egy lefotózott plakátból macska lesz a gazdájával együtt. Lépésről lépésre: a macska adatai, a gazdi elérhetősége, arc kivágása a profilképhez, nyilvántartási számok a plakátról, végül egy ellenőrzés. Minden csak javaslat — javítsd ki, amit a kamera félreolvasott.';

  @override
  String get helpFlierNeutral =>
      'Egy lefotózott plakátból kisállat lesz a gazdájával együtt. Lépésről lépésre: a kisállat adatai, a gazdi elérhetősége, arc kivágása a profilképhez, nyilvántartási számok a plakátról, végül egy ellenőrzés. Minden csak javaslat — javítsd ki, amit a kamera félreolvasott.';

  @override
  String get archiveTitle => 'Archívum';

  @override
  String get archiveExplainer =>
      'Az elhunyt macskák és üres kolóniák, amikhez évek óta senki nem nyúlt, továbbra is helyet foglalnak — főleg a fotóik. Az archiválás fájlba írja őket, amit megtartasz, majd innen törli őket.';

  @override
  String get archiveExplainerNeutral =>
      'Az elhunyt kisállatok és üres háztartások, amikhez évek óta senki nem nyúlt, továbbra is helyet foglalnak — főleg a fotóik. Az archiválás fájlba írja őket, amit megtartasz, majd innen törli őket.';

  @override
  String get archiveAction => 'Archiválás';

  @override
  String archiveSelected(int count) {
    return '$count tétel archiválása';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archiválsz $count tételt?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names fájlba kerülnek, majd törlődnek — a te eszközödön és minden eszközön, amivel szinkronizálsz. A fájl importálása mindent visszahoz; nélküle elvesznek.';
  }

  @override
  String archiveDone(int count) {
    return '$count tétel archiválva és törölve';
  }

  @override
  String archiveFailed(String error) {
    return 'Semmi sem törlődött: az archívumfájlt nem sikerült megírni ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Adatbázis $db, fotók $photos $count fájlban';
  }

  @override
  String quietForYears(int years) {
    return '$years éve változatlan';
  }

  @override
  String get nothingToArchive => 'Semmi nem elég régi az archiváláshoz.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Utolsó változás $date · fotók $size';
  }

  @override
  String get helpArchive =>
      'A régi adat helyet foglal, főleg a fotók, amiket minden szinkronizált eszköz cipel. Itt kiválasztod az évek óta változatlan elhunyt macskákat és üres kolóniákat, fájlba írod őket, amit megtartasz, és törlöd őket. A törlés mindenkihez eljut, akivel szinkronizálsz; a fájl importálása mindent visszaállít.';

  @override
  String get helpArchiveNeutral =>
      'A régi adat helyet foglal, főleg a fotók, amiket minden szinkronizált eszköz cipel. Itt kiválasztod az évek óta változatlan elhunyt kisállatokat és üres háztartásokat, fájlba írod őket, amit megtartasz, és törlöd őket. A törlés mindenkihez eljut, akivel szinkronizálsz; a fájl importálása mindent visszaállít.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Visszaállítasz $count törölt tételt?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names törölve vannak ebben a katalógusban, és az imént importált fájl tartalmazza őket. A visszaállítás ide és minden szinkronizált eszközre visszahozza őket.';
  }

  @override
  String get restoreAction => 'Visszaállítás';

  @override
  String get keepDeleted => 'Maradjon törölve';

  @override
  String get archiveNotSaved =>
      'Semmi sem törlődött: az archívum sehová nem lett mentve.';

  @override
  String get locateAddress => 'Cím keresése a térképen';

  @override
  String get addressFoundTitle => 'Cím megtalálva';

  @override
  String get replaceAddressOption => 'A cím cseréje erre';

  @override
  String get addPositionOption => 'Hely mentése';

  @override
  String get addressLocated => 'Cím megtalálva';

  @override
  String get addressNotFound =>
      'Ehhez a címhez nem található hely. Ellenőrizd a helyesírást, vagy hagyd üresen.';

  @override
  String get starterPosition => 'Hely';

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
  String get markTitleNeutral => 'Kisállat megjelölése';

  @override
  String get applyCrop => 'Kivágás';

  @override
  String get useFullPhoto => 'Teljes fotó használata';

  @override
  String get dragToSelect => 'Húzz téglalapot a macska köré';

  @override
  String get dragToSelectNeutral => 'Húzz téglalapot a kisállat köré';

  @override
  String get dragOverTheCat => 'Húzz ellipszist a macskára';

  @override
  String get dragOverTheCatNeutral => 'Húzz ellipszist a kisállatra';

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
  String get typeUnitValue => 'Mértékegységes érték';

  @override
  String get dimension => 'Mennyiség';

  @override
  String get dimensionWeight => 'Súly';

  @override
  String get dimensionLength => 'Hossz';

  @override
  String get dimensionVolume => 'Térfogat';

  @override
  String get dimensionTemperature => 'Hőmérséklet';

  @override
  String get unitsLabel => 'Mértékegységek';

  @override
  String get catalogHolds => 'Ez a katalógus';

  @override
  String get modeCats => 'Macskák';

  @override
  String get modePets => 'Kedvencek';

  @override
  String get graphLabel => 'Grafikon';

  @override
  String get fieldHistoryTooltip => 'Előzmények';

  @override
  String get rangeWeek => 'Hét';

  @override
  String get rangeMonth => 'Hónap';

  @override
  String get rangeYear => 'Év';

  @override
  String get rangeAll => 'Mind';

  @override
  String get rangeCustom => 'Egyéni…';

  @override
  String changeSince(String delta, String date) {
    return '$delta $date óta';
  }

  @override
  String get unitsAuto => 'Ahogy a régiódban';

  @override
  String get unitsMetric => 'Metrikus (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Angolszász (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Súly';

  @override
  String get systemDefault => 'Rendszer alapértelmezés';

  @override
  String get iosLocalNetworkHint =>
      'Ha iPhone-on/iPaden továbbra sem megy: Beállítások → Adatvédelem és biztonság → Helyi hálózat → engedélyezd a cat(a)log-ot, majd próbáld újra.';

  @override
  String get includePrivate => 'Privát adatok megosztása';

  @override
  String get hideLabel => 'Elrejtés ezen az eszközön';

  @override
  String get unhideLabel => 'Újra megjelenítés';

  @override
  String get showHiddenLabel => 'Rejtettek megjelenítése';

  @override
  String get stopShowingHidden => 'Rejtettek elrejtése újra';

  @override
  String get starterSpecies => 'Faj';

  @override
  String get starterStatus => 'Típus';

  @override
  String get statusFoster => 'Ideiglenes befogadó';

  @override
  String get statusForeverHome => 'Otthon';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Menhely';

  @override
  String get statusBarn => 'Pajta';

  @override
  String get valueCat => 'Macska';

  @override
  String get valueDog => 'Kutya';

  @override
  String get valueRabbit => 'Nyúl';

  @override
  String get valueGuineaPig => 'Tengerimalac';

  @override
  String get valueHamster => 'Hörcsög';

  @override
  String get valueBird => 'Madár';

  @override
  String get valueHorse => 'Ló';

  @override
  String get valueTortoise => 'Teknős';

  @override
  String get valueFerret => 'Vadászgörény';

  @override
  String get otherOption => 'Egyéb…';

  @override
  String get celebrationsToggle => 'Örökbefogadás ünneplése';

  @override
  String get celebrationsSubtitle =>
      'Konfetti és éljenzés, amikor egy macska az otthonába költözik';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfetti és éljenzés, amikor egy kisállat az otthonába költözik';

  @override
  String get onMapLabel => 'A térképen';

  @override
  String get showOnMap => 'Mutasd a térképen';

  @override
  String get searchPlaceHint => 'Hely vagy cím keresése';

  @override
  String get noPlacesFound => 'Nincs találat';

  @override
  String get mapSearchHint => 'Macskák, csoportok, személyek keresése';

  @override
  String get mapSearchHintNeutral =>
      'Kisállatok, háztartások, személyek keresése';

  @override
  String get proposeAnotherName => 'Másik név javaslata';

  @override
  String get moderationTitle => 'Szerzők és tiltások';

  @override
  String get moderationSubtitle =>
      'Egy személy adatainak végleges eltávolítása';

  @override
  String get authorsSection => 'Ki írt ebbe a katalógusba';

  @override
  String get hardDeleteAction => 'Minden törlése ettől a szerzőtől';

  @override
  String hardDeleteWarning(Object name) {
    return 'Eltávolítja $name minden bejegyzését és fotóját erről az eszközről. A többi eszköz megtartja a magáét. Nem vonható vissza.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Megerősítéshez írd be: $name';
  }

  @override
  String get alsoBan => 'Tiltás is — soha többé ne fogadj tőle adatot';

  @override
  String get bansSection => 'Tiltások';

  @override
  String get unbanAction => 'Tiltás feloldása';

  @override
  String get deletedDone => 'Törölve.';

  @override
  String get syncSummaryTitle => 'Mi érkezett';

  @override
  String get summaryAdopted => 'Örökbefogadva';

  @override
  String get summaryDeceased => 'Elhunyt';

  @override
  String get summaryEscaped => 'Megszökött';

  @override
  String get summaryNew => 'Új';

  @override
  String get summaryConflicts => 'Feloldandó ütközések';

  @override
  String conflictsMenu(int n) {
    return 'Ütközések ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Itt feloldottál egy ütközést, ezért az Elutasítás nem elérhető: azt is visszavonná.';

  @override
  String get arrivalIntro =>
      'Ezek a változások már a katalógusodban vannak. Az Elutasítás visszaállítja a korábbi állapotot.';

  @override
  String get summaryUpdated => 'Módosítva';

  @override
  String get summaryDeleted => 'Törölve';

  @override
  String get keepMine => 'Az enyém marad';

  @override
  String keptMine(String name) {
    return 'A te $name-változatod marad ezen az eszközön.';
  }

  @override
  String get summaryMeta => 'Érkezett még';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n változás',
      one: '1 változás',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Elfogadás';

  @override
  String get rejectArrival => 'Elutasítás';

  @override
  String get photoAdded => 'Fotó hozzáadva';

  @override
  String get photoRemoved => 'Fotó eltávolítva';

  @override
  String metaFieldAdded(String name) {
    return 'Új mező: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Mező módosítva: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser összevonva ezzel: $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n fotó',
      one: '1 fotó',
    );
    return '$_temp0';
  }

  @override
  String get starterMother => 'Anya';

  @override
  String get starterFather => 'Apa';

  @override
  String get familySection => 'Család';

  @override
  String get littermatesLabel => 'Alomtestvérek';

  @override
  String get siblingsLabel => 'Testvérek';

  @override
  String get kittensLabel => 'Kiscicák';

  @override
  String get kittensLabelNeutral => 'Kölykök';

  @override
  String get toastSettingsTitle => 'Mit jelentsen be';

  @override
  String get toastSettingsSubtitle => 'Kis üzenetek szinkronizálás után';

  @override
  String get toastKindAdoptions => 'Örökbefogadások';

  @override
  String get toastKindBirths => 'Születések';

  @override
  String get toastKindDeaths => 'Elhalálozások';

  @override
  String get toastKindEscapes => 'Szökések';

  @override
  String get toastKindMoves => 'Költözések';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat örökbefogadva: $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Új kiscica: $cat ✨';
  }

  @override
  String toastBornNeutral(Object cat) {
    return '✨ Újszülött: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat elpusztult';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat megszökött';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat átköltözött: $home';
  }

  @override
  String get notACatlogFile => 'Ez nem cat(a)log-fájl';

  @override
  String get nothingNewInBundle => 'Semmi új a fájlban — már mindened megvan';

  @override
  String get syncChooserInPerson => 'Személyesen';

  @override
  String get syncChooserInPersonSub => 'Szinkronizálás Wi-Fi-n';

  @override
  String get syncChooserRemote => 'Távolról';

  @override
  String get syncChooserRemoteSub => 'Szinkronizálás mappán vagy USB-n át';

  @override
  String get syncChooserMessenger => 'Üzenetküldő';

  @override
  String get syncChooserMessengerSub => 'Export és import közösségi médián át';

  @override
  String get connectToWifiFirst =>
      'Előbb csatlakozz Wi-Fi-hez — akkor a készülékek megtalálják egymást';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) szinkronizálni szeretne';
  }

  @override
  String get trustBothWaysNote =>
      'A katalógusok mindkét irányban kicserélődnek.';

  @override
  String get allowOnce => 'Engedélyez';

  @override
  String get allowAlways => 'Mindig engedélyezd ezt a készüléket';

  @override
  String get declineAction => 'Elutasít';

  @override
  String get syncDeclined => 'A másik készülék elutasította a szinkronizálást';

  @override
  String get trustedDevicesSection => 'Mindig engedélyezett készülékek';

  @override
  String get removeTrust => 'Eltávolítás';

  @override
  String get hostWithoutWifi => 'Hosztolás Wi-Fi nélkül';

  @override
  String get hotspotJoinNote =>
      'Ideiglenes közvetlen kapcsolatot létesít a másik telefonnal (internet nélkül). Csak a cat(a)log használja, és a szinkronizálás után magától bontja.';

  @override
  String get hotspotAndroidOnly =>
      'Ehhez a kódhoz két Android telefon kell — iPhone-on/iPaden használj közös Wi-Fi-t';

  @override
  String get selectClowderHint => 'Válassz egy clowdert balra';

  @override
  String get selectClowderHintNeutral => 'Válassz egy háztartást balra';

  @override
  String get introTitle1 => 'Macskáid, rendben';

  @override
  String get introTitle1Neutral => 'Kisállataid, rendben';

  @override
  String get introBody1 =>
      'Készíts kartont minden macskának: fotó, ivar, egészség, bármi, amit fel akarsz jegyezni. A macskák aszerint csoportosulnak, hol élnek — az app ezt a helyet kolóniának (clowder) hívja.';

  @override
  String get introBody1Neutral =>
      'Készíts kartont minden gondozott kisállatnak: fotó, ivar, egészség, bármi, amit fel akarsz jegyezni. A kisállatok aszerint csoportosulnak, hol élnek — az app ezt a helyet háztartásnak hívja.';

  @override
  String get introTitle2 => 'Internet nélkül működik';

  @override
  String get introBody2 =>
      'Minden csak a telefonodra mentődik. Nincs fiók, nincs felhő. Semmi sem kerül fel sehova, hacsak te magad meg nem osztod.';

  @override
  String get introTitle3 => 'Dolgozzatok együtt';

  @override
  String get introBody3 =>
      'Mindenki a saját appját használja, és időnként adatot cseréltek: találkozzatok és olvassatok be egy kódot, használjatok közös mappát, vagy küldjetek egy fájlt messengeren. Utána mindenkinél ugyanaz az információ.';

  @override
  String get introSkip => 'Kihagyás';

  @override
  String get introNext => 'Tovább';

  @override
  String get introDone => 'Vágjunk bele';

  @override
  String get introReplayTitle => 'Gyors bemutató';

  @override
  String get spotHomeSync =>
      'Itt szinkronizálsz az ismerőseiddel. Te döntöd el, mit osztasz meg.';

  @override
  String get spotHomeStrays =>
      'Ez a kártya gyűjti az összes kóborlót — az otthontalan macskákat. Koppints a listához.';

  @override
  String get spotHomeStraysNeutral =>
      'Ez a kártya gyűjti az összes kóborlót — az otthontalan kisállatokat. Koppints a listához.';

  @override
  String get spotHomeMenu =>
      'Ebben a menüben: beállítások, ismétlődések keresése és összevonása, CSV-exportálás és több.';

  @override
  String get spotCatEdit =>
      'Koppints a ceruzára a macska szerkesztéséhez. Tipp: egy mező hosszú nyomása rögtön szerkeszti azt.';

  @override
  String get spotCatEditNeutral =>
      'Koppints a ceruzára a kisállat szerkesztéséhez. Tipp: egy mező hosszú nyomása rögtön szerkeszti azt.';

  @override
  String get spotMapLayers =>
      'Eltűnt macskát keresel? Jeleníts meg köröket a plakátjai helyei és a régi otthona körül.';

  @override
  String get spotMapLayersNeutral =>
      'Eltűnt kisállatot keresel? Jeleníts meg köröket a plakátjai helyei és a régi otthona körül.';

  @override
  String get spotStraysFlier =>
      'Eltűnt macskás plakát? Fotózd le itt — az app elmenti a macskát és az elérhetőséget helyetted.';

  @override
  String get spotStraysFlierNeutral =>
      'Eltűnt kisállatos plakát? Fotózd le itt — az app elmenti a kisállatot és az elérhetőséget helyetted.';

  @override
  String get spotStraysScan =>
      'Némelyik plakáton cat(a)log QR-kód van. Olvasd be itt, és importáld a macskát gépelés nélkül.';

  @override
  String get spotStraysScanNeutral =>
      'Némelyik plakáton cat(a)log QR-kód van. Olvasd be itt, és importáld a kisállatot gépelés nélkül.';

  @override
  String get introTitle4 => 'Eltűnt macskák megtalálása';

  @override
  String get introTitle4Neutral => 'Eltűnt kisállatok megtalálása';

  @override
  String get introBody4 =>
      'Eltűnt macskát kereső plakátot látsz? Fotózd le az appban: elmenti a macskát, a gazda elérhetőségét és a helyet. Ha később hasonló kóbor bukkan fel, az app lehetséges egyezéseket javasol.';

  @override
  String get introBody4Neutral =>
      'Eltűnt kisállatot kereső plakátot látsz? Fotózd le az appban: elmenti a kisállatot, a gazda elérhetőségét és a helyet. Ha később hasonló kóbor bukkan fel, az app lehetséges egyezéseket javasol.';

  @override
  String get spotMapSearch =>
      'Írj be egy macskát, helyet vagy személyt, és a térkép odaugrik.';

  @override
  String get spotMapSearchNeutral =>
      'Írj be egy kisállatot, helyet vagy személyt, és a térkép odaugrik.';

  @override
  String get spotCardChips =>
      'Jelöld be, mi kerüljön a megosztható kártyára — a többi lemarad róla.';

  @override
  String get spotCatMenu =>
      'Itt több művelet van: a macska elrejtése, duplikátumok összevonása vagy észlelés rögzítése.';

  @override
  String get spotCatMenuNeutral =>
      'Itt több művelet van: a kisállat elrejtése, duplikátumok összevonása vagy észlelés rögzítése.';

  @override
  String get spotDone => 'Értem';

  @override
  String get spotReplayTitle => 'Újdonság-túra';

  @override
  String get spotReplaySubtitle => 'Tippek újbóli megjelenítése minden oldalon';

  @override
  String get spotReplayDone => 'A tippek újra megjelennek';

  @override
  String get searchNoResults => 'Nincs ilyen nevű macska';

  @override
  String get searchNoResultsNeutral => 'Nincs ilyen nevű kisállat';

  @override
  String get syncUnreachable =>
      'A másik készülék nem érhető el. Mindkettő ugyanazon a Wi-Fi-n van?';

  @override
  String get folderUnreachable =>
      'A mappa nem érhető el. Megvan még a meghajtó vagy a felhőmappa?';

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

  @override
  String get catalogsTitle => 'Katalógusok';

  @override
  String get newCatalog => 'Új katalógus';

  @override
  String get intoCatalog => 'Katalógusba';

  @override
  String get catalogNameLabel => 'A katalógus neve';

  @override
  String catalogNameTaken(String name) {
    return 'Már van $name nevű katalógus. Válassz másik nevet.';
  }

  @override
  String get manageCatalogs => 'Katalógusok kezelése';

  @override
  String get helpCatalogs =>
      'Egy katalógus önálló világ: saját macskák, kolóniák, mezők, fotók és szinkronpartnerek. Berlin és Párizs soha nem keveredik. Koppints egy katalógusra, hogy átválts rá. A katalógus fogaskereke megnyitja a beállításait: név, macskák vagy kedvencek, mezők, szerzők és tiltások, archívum, visszalépés, törlés. A neved, a nyelved és a már látott tippek mindegyikre közösek.';

  @override
  String get helpCatalogsNeutral =>
      'Egy katalógus önálló világ: saját kedvencek, háztartások, mezők, fotók és szinkronpartnerek. Berlin és Párizs soha nem keveredik. Koppints egy katalógusra, hogy átválts rá. A katalógus fogaskereke megnyitja a beállításait: név, macskák vagy kedvencek, mezők, szerzők és tiltások, archívum, visszalépés, törlés. A neved, a nyelved és a már látott tippek mindegyikre közösek.';

  @override
  String get helpCatalogSettings =>
      'Minden, ami csak ehhez a katalógushoz tartozik: a neve, hogy macskákat vagy kedvenceket tartalmaz, a mezői, a szerzői és tiltásai, az archívum és az időben visszalépés. Az itteni változások csak ezt a katalógust érintik — akkor is, ha épp nem ebben vagy. A törlés először fájlba írja a katalógust.';

  @override
  String get spotHomeCatalog =>
      'Ez az a katalógus, amelyben vagy. Koppints a névre a váltáshoz vagy új létrehozásához.';

  @override
  String get deleteCatalog => 'Katalógus törlése';

  @override
  String get catalogSettings => 'Katalógus beállításai';

  @override
  String deleteCatalogBody(String name) {
    return 'Minden eltűnik a(z) $name katalógusból: a macskák, a fotók, az előzmények. Előbb teljes fájl készül oda, ahova az automatikus mentések kerülnek — annak importálása visszahozza. Írd be a megjelenített szót a megerősítéshez.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Minden eltűnik a(z) $name katalógusból: a kisállatok, a fotók, az előzmények. Előbb teljes fájl készül oda, ahova az automatikus mentések kerülnek — annak importálása visszahozza. Írd be a nevet a megerősítéshez.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name törölve. A fájl itt van: $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Írd be: $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Semmi sem törlődött: a katalógusfájlt nem sikerült kiírni ($error). Szabadíts fel helyet, vagy próbáld később.';
  }

  @override
  String get moveToCatalog => 'Áthelyezés másik katalógusba';

  @override
  String movedToCatalog(int count, String name) {
    return '$count áthelyezve ide: $name';
  }

  @override
  String get chooseWhatToMove => 'Mi költözzön?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Áthelyezel valamit ide: $name?';
  }

  @override
  String get undoThisImport => 'Az importálás visszavonása';

  @override
  String undoImportBody(int count) {
    return 'Az importálás hozta $count változás eltűnik. Előbb fájlba kerülnek, annak importálása visszahozza őket. Akikkel már szinkronizáltál, megtartják a másolatukat — azt nem lehet visszavonni.';
  }

  @override
  String undoneImport(String where) {
    return 'Visszavonva. A fájl itt van: $where.';
  }

  @override
  String get goBackTitle => 'Vissza egy korábbi állapotra';

  @override
  String get goBackToHere => 'Vissza ide';

  @override
  String get momentImport => 'Importálás előtt';

  @override
  String get momentSync => 'Szinkronizálás előtt';

  @override
  String get momentMerge => 'Összevonás előtt';

  @override
  String get momentHardDelete => 'Egy szerző adatainak törlése előtt';

  @override
  String get momentArchive => 'Archiválás előtt';

  @override
  String get momentManual => 'Te jelölted meg';

  @override
  String get showOlderMoments => 'Régebbiek mutatása';

  @override
  String goBackBody(int count) {
    return 'Minden eltűnik e pillanat után — $count változás. Előbb fájlba kerül, annak importálása mindent visszahoz, és minden újabb pillanat vele megy. Akikkel már szinkronizáltál, megtartják a másolatukat — azt nem lehet visszavonni.';
  }

  @override
  String get nameThisMoment => 'Nevezd el ezt a pillanatot';

  @override
  String get helpGoBack =>
      'Azok a pillanatok, amikor ez a katalógus alakot váltott: minden importálás és szinkronizálás előtt, összevonás, archiválás vagy törlés előtt, és mindig, amikor te magad jelöltél meg egyet. Egyet választva a katalógus visszatér abba az állapotba — minden utána következő fájlba kerül, amit megtartasz, majd eltűnik, és minden újabb pillanat vele megy. Akikkel már szinkronizáltál, megtartják, amit kaptak.';

  @override
  String goBackFileFailed(String error) {
    return 'Semmi sem tűnt el: a fájl, ami megőrzi, nem volt kiírható ($error). Szabadíts fel helyet, és próbáld újra.';
  }

  @override
  String get goBackChanged =>
      'Semmi nem lett eltávolítva: a katalógus megváltozott a fájl mentése közben. Próbáld újra.';

  @override
  String get switchBeforeDeleting =>
      'Ez az a katalógus, amelyben vagy. Válts egy másikra, aztán töröld.';

  @override
  String shareFileFailed(String error) {
    return 'A megosztási fájlt nem sikerült kiírni ($error). Szabadíts fel helyet, és próbáld újra.';
  }

  @override
  String get privateLabel => 'Privát';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalógus: $name';
  }

  @override
  String get markPrivate => 'Megjelölés privátként';

  @override
  String get unmarkPrivate => 'Privát jelölés eltávolítása';

  @override
  String get agenda => 'Teendők';

  @override
  String get reminderLabel => 'Emlékeztető';

  @override
  String get agendaEmpty =>
      'Nincs tervezett időpont. Újat itt a plusszal, vagy egy macska vagy clowder oldalán tervezhetsz.';

  @override
  String get agendaEmptyNeutral =>
      'Nincs tervezett időpont. Újat itt a plusszal, vagy egy kisállat vagy háztartás oldalán tervezhetsz.';

  @override
  String get dueToday => 'ma esedékes';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nap múlva',
      one: '1 nap múlva',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count napja lejárt',
      one: '1 napja lejárt',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Kész';

  @override
  String get repeatTitle => 'Újra ennyi idő múlva…';

  @override
  String get noRepeatLabel => 'Nincs ismétlés';

  @override
  String get unitDays => 'nap';

  @override
  String get unitWeeks => 'hét';

  @override
  String get unitMonths => 'hónap';

  @override
  String get unitYears => 'év';

  @override
  String ageYears(int years) {
    return '$years év';
  }

  @override
  String ageMonths(int months) {
    return '$months hó';
  }

  @override
  String get changeDateLabel => 'Dátum módosítása';

  @override
  String get removeReminderLabel => 'Emlékeztető eltávolítása';

  @override
  String get exportIcs => 'Naptárfájl exportálása';

  @override
  String get resyncCalendar => 'Naptár újraszinkronizálása';

  @override
  String icsSavedTo(String path) {
    return 'A naptárfájl ide került: $path';
  }

  @override
  String get calendarMirrorLabel => 'Tükrözés az eszköz naptárába';

  @override
  String get calendarMirrorSubtitle =>
      'Az időpontok egész napos eseményként jelennek meg a naptárban. A cat(a)log minden indításkor és minden változás után frissíti őket ott. Az időpontok emlékeztetőit a naptárban kezelheted.';

  @override
  String get syncPeerOlder =>
      'A másik eszközön régebbi, emlékeztetők nélküli cat(a)log fut. Frissítsd ott a cat(a)logot, és szinkronizálj újra.';

  @override
  String get syncPeerNewer =>
      'A másik eszközön újabb cat(a)log fut. Frissítsd a cat(a)logot ezen az eszközön, és szinkronizálj újra.';

  @override
  String get syncPeerNoTls =>
      'A másik eszközön 1.1.0 előtti cat(a)log fut, titkosított szinkron nélkül. Frissítsd ott a cat(a)logot, majd szinkronizálj újra.';

  @override
  String get syncWrongHost =>
      'A tanúsítvány nem illik a párosító kódhoz — ez nem az az eszköz, ahonnan a kód származik. Olvasd be vagy írd be újra a kódot.';

  @override
  String get bundleNewerError =>
      'Ez a fájl újabb cat(a)logból származik. Az importáláshoz frissítsd a cat(a)logot ezen az eszközön.';

  @override
  String get spotEar =>
      'Egy kis macskafül a sarokban azt jelenti: tartsd nyomva a többiért.';

  @override
  String get addReminder => 'Emlékeztető hozzáadása';

  @override
  String get plannedSection => 'Tervezett';

  @override
  String get reminderDialogHint =>
      'Az időpont a teendők között jelenik meg. Ott hagyhatod jóvá vagy vetheted el. Az érték csak akkor kerül átvételre, ha az időpontot jóváhagytad.';

  @override
  String get reminderFor => 'Kinek';

  @override
  String get reminderField => 'Mező';

  @override
  String get dueDateLabel => 'Határidő';

  @override
  String get pickCalendar => 'Melyik naptár?';

  @override
  String get calendarPermissionDenied =>
      'A naptárhoz való hozzáférés le van tiltva, ezért a tükrözés ki van kapcsolva. Engedélyezd a rendszerbeállításokban, majd kapcsold be újra a tükrözést.';

  @override
  String get calendarNotChosen =>
      'Nincs kiválasztott naptár, ezért a tükrözés ki van kapcsolva. Kapcsold be újra, és válassz egyet.';

  @override
  String get calendarGone =>
      'A kiválasztott naptár már nem létezik, ezért a tükrözés ki van kapcsolva. Kapcsold be újra, és válassz másikat.';

  @override
  String get noWritableCalendar =>
      'Nem található naptár. Jelentkezz be egy naptárfiókba a rendszerbeállításokban, például Google, és próbáld újra.';

  @override
  String get spotHomeAgenda =>
      'Teendők: a tervezett időpontok listája — állatorvos, gyógyszer, ellenőrzés.';

  @override
  String get spotAgendaAdd => 'Új időpont tervezése.';

  @override
  String get spotAgendaCalendar =>
      'Itt kapcsold be a cat(a)log időpontjainak tükrözését egy általad választott naptárba.';

  @override
  String get helpAgenda =>
      'A teendők a tervezett időpontokat dátum szerint listázzák. Két fajta van: időpontok órával, és emlékeztetők, amelyek egy napra szólnak. Az elmulasztottak felül maradnak. A koppintás megnyitja a macskát vagy a clowdert. A pipa jóváhagy egy időpontot: az érték a mezőbe kerül, és rögtön tervezheted a következőt, például három hónap múlva. A nyomva tartás módosítja a dátumot vagy törli az időpontot. A felső kapcsoló a telefonod egy naptárába tükrözi az időpontokat. A menü naptárfájlként exportálja őket. Egy állatorvosi út több macskával egyetlen időpont: jelöld be a macskákat, a Napirend egy kártyát mutat a nevükkel, és befejezéskor megkérdezi, mely macskákat kezelték — a többinél vedd ki a jelölést, tervezve maradnak.';

  @override
  String get helpAgendaNeutral =>
      'A teendők a tervezett időpontokat dátum szerint listázzák. Két fajta van: időpontok órával, és emlékeztetők, amelyek egy napra szólnak. Az elmulasztottak felül maradnak. A koppintás megnyitja a kisállatot vagy a háztartást. A pipa jóváhagy egy időpontot: az érték a mezőbe kerül, és rögtön tervezheted a következőt, például három hónap múlva. A nyomva tartás módosítja a dátumot vagy törli az időpontot. A felső kapcsoló a telefonod egy naptárába tükrözi az időpontokat. A menü naptárfájlként exportálja őket. Egy állatorvosi út több kisállattal egyetlen időpont: jelöld be a kisállatokat, a Napirend egy kártyát mutat a nevükkel, és befejezéskor megkérdezi, mely kisállatokat kezelték — a többinél vedd ki a jelölést, tervezve maradnak.';

  @override
  String get calendarRowOff => 'Naptár: ki';

  @override
  String calendarRowOn(String name) {
    return 'Naptár: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Tervezz időpontot ennek a macskának. A teendők között jelenik meg, és ott hagyható jóvá.';

  @override
  String get spotAddReminderCatNeutral =>
      'Tervezz időpontot ennek a kisállatnak. A teendők között jelenik meg, és ott hagyható jóvá.';

  @override
  String get spotAddReminderClowder =>
      'Tervezz időpontot ennek a clowdernek. A teendők között jelenik meg, és ott hagyható jóvá.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Tervezz időpontot ennek a háztartásnak. A teendők között jelenik meg, és ott hagyható jóvá.';

  @override
  String get readOnlyCalendar => 'csak olvasható';

  @override
  String get appointmentLabel => 'Időpont';

  @override
  String get addAppointment => 'Időpont hozzáadása';

  @override
  String get planChooserTitle => 'Időpont vagy emlékeztető?';

  @override
  String get planChooserAppointment =>
      'Időpont — látogatás egy dátumon és időben, jegyzetekkel';

  @override
  String get planChooserReminder =>
      'Emlékeztető — egy érték, amely egy napon esedékes lesz';

  @override
  String get appointmentTitleLabel => 'Mi';

  @override
  String get notesLabel => 'Jegyzetek';

  @override
  String get timeLabel => 'Idő';

  @override
  String get allDayLabel => 'Egész nap';

  @override
  String get alertLabel => 'Riasztás';

  @override
  String get alertNone => 'Nincs';

  @override
  String get alertDayBefore => 'Előző nap';

  @override
  String get alertHourBefore => 'Egy órával előtte';

  @override
  String get linkFieldLabel => 'Befejezéskor mezőbe írás';

  @override
  String get noLinkedField => 'Nincs mező';

  @override
  String get outcomeTitle => 'Hogy ment?';

  @override
  String get finishLabel => 'Befejezés';

  @override
  String get editLabelAppointment => 'Időpont szerkesztése';

  @override
  String get deleteAppointment => 'Időpont törlése';

  @override
  String get stepFlierText => 'A plakát szövege';

  @override
  String get qrFoundHint =>
      'A plakáton QR-kód található. A bejelölt kódokból nyilvántartási számokat és linkeket olvasunk ki.';

  @override
  String get useCode => 'Ezt a kódot használja';

  @override
  String get qrNone => 'Nem található QR-kód a fotón.';

  @override
  String qrFailed(String error) {
    return 'A QR-kód olvasása nem sikerült: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$name plakát felismerve. Ellenőrizze lent, melyik mezőbe kerül az egyes sorok.';
  }

  @override
  String get flierLayoutUnknown =>
      'Ismeretlen plakátelrendezés. Rendelje a sorokat mezőkhöz lent; a többi a megjegyzésekben marad.';

  @override
  String get targetRegistryNumber => 'Nyilvántartási szám';

  @override
  String get targetLostPlace => 'Cím (elveszett itt)';

  @override
  String get targetContact => 'A nyilvántartás elérhetősége';

  @override
  String get targetDrop => 'Elvetés';

  @override
  String get existingCat => 'Meglévő macska';

  @override
  String get existingCatNeutral => 'Meglévő kisállat';

  @override
  String get existingClowder => 'Meglévő csoport';

  @override
  String get existingClowderNeutral => 'Meglévő háztartás';

  @override
  String get createNewInstead => 'Nincs — új létrehozása';

  @override
  String overwritesValue(String value) {
    return 'Felülírja a jelenlegi értéket: \"$value\"';
  }

  @override
  String get abortScanTitle => 'Megszakítja a felvételt?';

  @override
  String get abortScanBody => 'Semmi nem lesz mentve.';

  @override
  String get abortScan => 'Megszakítás';

  @override
  String get keepScanning => 'Folytatás';

  @override
  String get catsOnAppointment => 'Macskák ezen az időponton';

  @override
  String get catsOnAppointmentNeutral => 'Kisállatok ezen az időponton';

  @override
  String get noCatsHint =>
      'Nincs macska bejelölve — az időpont magáé a kolóniáé.';

  @override
  String get noCatsHintNeutral =>
      'Nincs kisállat bejelölve — az időpont magáé a háztartásé.';

  @override
  String get pickCatsTitle => 'Melyik macskák jönnek?';

  @override
  String get pickCatsTitleNeutral => 'Melyik kisállatok jönnek?';

  @override
  String catsCount(int count) {
    return '$count macska';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count kisállat';
  }

  @override
  String get finishUntickHint =>
      'Vedd ki a jelölést azoknál a macskáknál, amelyeket nem kezeltek; tervezve maradnak.';

  @override
  String get finishUntickHintNeutral =>
      'Vedd ki a jelölést azoknál a kisállatoknál, amelyeket nem kezeltek; tervezve maradnak.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Időpont törlése mind a $count macskánál';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Időpont törlése mind a $count kisállatnál';
  }
}
