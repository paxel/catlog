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
  String get noClowdersYet =>
      'Még nincs clowder. A clowder egy hely, ahol macskák élnek — az ideiglenes befogadód, egy örökbefogadó lakása. Hozd létre az elsőt lent.';

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
      'A macska eltűnik minden listáról, fotói törlődnek — itt és a következő szinkron után a többi eszközön is.';

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
  String get privateNoShare =>
      'Ez a macska privátként van megjelölve — a privát adatok sosem hagyják el az eszközét. Előbb vegye le a jelölést a nyilvános megosztáshoz.';

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
  String get genderFatherFemale =>
      'Ez a macska más macskák apjaként szerepel — az apa nem lehet nőstény. Először ellenőrizze a családot.';

  @override
  String get genderMotherMale =>
      'Ez a macska más macskák anyjaként szerepel — az anya nem lehet kandúr. Először ellenőrizze a családot.';

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
  String get stepOwner => 'Gazdi';

  @override
  String get stepFace => 'Arckép';

  @override
  String get stepRegistry => 'Nyilvántartás';

  @override
  String get stepReview => 'Ellenőrzés és mentés';

  @override
  String get stepOwnerHint =>
      'Aki keresi a macskát — ebből lesz az ő kártyája, a plakáton szereplő elérhetőséggel.';

  @override
  String get stepFaceHint =>
      'Vágd ki a macska arcát a plakátból; ez lesz a profilkép. Ki is hagyhatod.';

  @override
  String get stepRegistryHint =>
      'A plakáton talált számok. A bejelöltek a macskához mentődnek, és később megnyithatók.';

  @override
  String get noRegistryLinks =>
      'Nincs nyilvántartási link ezen a plakáton — itt nincs teendő.';

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
      'A kolóniáid áttekintése — a kolónia egy hely, ahol macskák élnek: az otthonod, egy ideiglenes befogadó, egy menhely. Koppints egy kártyára a macskáiért; hosszan nyomva jön a menü. A jobb alsó gomb új kolóniát hoz létre, a kóborlók kártyája pedig minden otthontalan macskát összegyűjt.';

  @override
  String get helpClowder =>
      'Minden erről a helyről: macskái, mezői (cím, elérhetőség, típus) és előzményei. Az oldal csak olvasható; a ceruza kapcsolja be a szerkesztést, ott új mezőt is felvehetsz. Egy mezőt hosszan nyomva rögtön szerkeszted, egy macskát hosszan nyomva átviszed, elrejted vagy megnyitod.';

  @override
  String get helpCat =>
      'Minden erről a macskáról: fotók, mezők, család, előzmények. Az oldal csak olvasható, amíg a ceruzára nem koppintasz. Egy mezőt hosszan nyomva egyből a szerkesztésébe ugorsz; egy fotót hosszan nyomva a menüje nyílik. A jobb felső menüben van a többi: priváttá tétel, elrejtés, összevonás, észlelés rögzítése, megosztás.';

  @override
  String get helpStrays =>
      'Macskák, akiknek most nincs otthonuk: talált, megszökött vagy plakátról származó állatok. A kamera gomb rögzíti az előtted ülő macskát; a plakát gomb egy eltűnt-plakátból macskát csinál a gazdi elérhetőségével; az olvasó beolvassa a plakáton lévő cat(a)log kódot.';

  @override
  String get helpMap =>
      'Minden macska és hely, aminek van pozíciója. A keresés macskát, embert és helyet talál — az ismeretlen nevet az egész világon keresi. A rétegek gomb megrajzolja az 500 m-es köröket egy eltűnt macska plakáthelyei és a régi otthona köré. A nyilak tűről tűre lépnek, hosszan nyomva a térképet észlelést rögzítesz.';

  @override
  String get helpCard =>
      'A macska nyomtatható kártyája: fent a chipekkel választod ki, mi kerüljön rá, aztán képként vagy PDF-ként osztod meg. A számok QR-ként vagy vonalkódként nyomtathatók, a pozícióból pedig térképet nyitó QR lesz, plusz egy rövid Plus Code.';

  @override
  String get helpSync =>
      'Így jutnak az adatok másokhoz: közvetlen kapcsolat, mindkét eszköz által látott mappa, vagy fájl küldése üzenetküldővel. Mindig te döntöd el, mi megy el — és a kapott .catsync fájlokat is itt nyitod meg.';

  @override
  String get helpFields =>
      'A katalógusod mezői. Nevezd át őket, változtasd a választómező lehetőségeit, vagy hozz létre sajátot. Egy azonosító mező mutathat egy szolgáltatásra (nyilvántartásra), így a szám a macskánál koppintható lesz.';

  @override
  String get helpTimeline =>
      'Minden valaha végzett változtatás, a legújabb elöl: ki mit mikor és milyen értékre módosított. Bármelyik bejegyzés visszavonható — ez új bejegyzést ír, semmi nem törlődik.';

  @override
  String get helpDuplicates =>
      'Macskák vagy kolóniák, amik kétszer szerepelnek — azonos azonosítók vagy nagyon hasonló nevek egyező részletekkel. Koppints egy párra az összevonáshoz; ez nem vonható vissza, ezért előbb rákérdez.';

  @override
  String get helpMatches =>
      'Macskák, amik ugyanaz az állat lehetnek: azonos azonosító, vagy egy kóborló, akit egy eltűnt macska keresési területén láttak. Koppints egy párra az összevonáshoz, hosszan nyomva megnyílik az első macska összehasonlításhoz.';

  @override
  String get helpFlier =>
      'Egy lefotózott plakátból macska lesz a gazdájával együtt. Lépésről lépésre: a macska adatai, a gazdi elérhetősége, arc kivágása a profilképhez, nyilvántartási számok a plakátról, végül egy ellenőrzés. Minden csak javaslat — javítsd ki, amit a kamera félreolvasott.';

  @override
  String get locateAddress => 'Cím keresése a térképen';

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
  String get markPrivate => 'Megjelölés privátként';

  @override
  String get unmarkPrivate => 'Privát jelölés eltávolítása';

  @override
  String get includePrivate => 'Privát adatok belefoglalása';

  @override
  String get includePrivateExplainer =>
      'Ezzel minden privátnak jelölt adat is elmegy. Akivel szinkronizálsz, látni fogja.';

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
  String get statusForeverHome => 'Örökbefogadó otthon';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Menhely';

  @override
  String get statusBarn => 'Pajta';

  @override
  String get valueCat => 'Macska';

  @override
  String get otherOption => 'Egyéb…';

  @override
  String get celebrationsToggle => 'Örökbefogadás ünneplése';

  @override
  String get celebrationsSubtitle =>
      'Konfetti és éljenzés, amikor egy macska örökbefogadó otthonba költözik';

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
  String summaryOther(Object n) {
    return '…és még $n változás';
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
  String get syncChooserInPersonSub =>
      'Egy szobában vagytok — kód beolvasása, kész másodpercek alatt';

  @override
  String get syncChooserRemote => 'Távolról';

  @override
  String get syncChooserRemoteSub =>
      'Megosztott mappán át, mint a Dropbox vagy egy pendrive';

  @override
  String get syncChooserMessenger => 'Üzenetküldő';

  @override
  String get syncChooserMessengerSub =>
      'Küldjön mindent egy fájlként bármely üzenetküldőn — és itt importálja a kapott .catsync fájlt';

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
  String get introTitle1 => 'Macskáid, rendben';

  @override
  String get introBody1 =>
      'Készíts kartont minden macskának: fotó, ivar, egészség, bármi, amit fel akarsz jegyezni. A macskák aszerint csoportosulnak, hol élnek — az app ezt a helyet kolóniának (clowder) hívja.';

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
  String get spotHomeMenu =>
      'Ebben a menüben: duplikátumok keresése és összevonása, CSV-export és több.';

  @override
  String get spotCatEdit =>
      'Koppints a ceruzára a macska szerkesztéséhez. Tipp: egy mező hosszú nyomása rögtön szerkeszti azt.';

  @override
  String get spotMapLayers =>
      'Eltűnt macskát keresel? Jeleníts meg köröket a plakátjai helyei és a régi otthona körül.';

  @override
  String get spotStraysFlier =>
      'Eltűnt macskás plakát? Fotózd le itt — az app elmenti a macskát és az elérhetőséget helyetted.';

  @override
  String get spotStraysScan =>
      'Némelyik plakáton cat(a)log QR-kód van. Olvasd be itt, és importáld a macskát gépelés nélkül.';

  @override
  String get introTitle4 => 'Eltűnt macskák megtalálása';

  @override
  String get introBody4 =>
      'Eltűnt macskát kereső plakátot látsz? Fotózd le az appban: elmenti a macskát, a gazda elérhetőségét és a helyet. Ha később hasonló kóbor bukkan fel, az app lehetséges egyezéseket javasol.';

  @override
  String get spotMapSearch =>
      'Írj be egy macskát, helyet vagy személyt, és a térkép odaugrik.';

  @override
  String get spotCardChips =>
      'Jelöld be, mi kerüljön a megosztható kártyára — a többi lemarad róla.';

  @override
  String get spotCatMenu =>
      'További műveletek itt: macska priváttá jelölése, elrejtése, duplikátumok összevonása vagy észlelés rögzítése.';

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
}
