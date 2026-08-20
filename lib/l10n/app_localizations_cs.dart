// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Vítejte v cat(a)log';

  @override
  String get welcomeBody =>
      'Zvolte si jméno. Každá změna se ukládá pod tímto jménem, aby ostatní viděli, kdo co udělal.';

  @override
  String get yourName => 'Vaše jméno';

  @override
  String get start => 'Začít';

  @override
  String get clowders => 'Clowdery';

  @override
  String get noClowdersYet =>
      'Zatím žádné clowdery. Clowder je místo, kde kočky žijí — tvoje dočasná péče, byt osvojitele. Založ první níže.';

  @override
  String get strays => 'Toulavé kočky';

  @override
  String get searchCats => 'Hledat kočky';

  @override
  String get map => 'Mapa';

  @override
  String get sync => 'Synchronizace';

  @override
  String get fields => 'Pole';

  @override
  String get exportCsv => 'Exportovat CSV';

  @override
  String get aboutAndFeedback => 'O aplikaci a zpětná vazba';

  @override
  String get newClowder => 'Nový clowder';

  @override
  String get name => 'Jméno';

  @override
  String get cancel => 'Zrušit';

  @override
  String get create => 'Vytvořit';

  @override
  String get save => 'Uložit';

  @override
  String get delete => 'Smazat';

  @override
  String get merge => 'Sloučit';

  @override
  String get resolve => 'Rozhodnout';

  @override
  String get open => 'Otevřít';

  @override
  String csvSavedTo(String path) {
    return 'CSV uloženo do $path';
  }

  @override
  String get renameClowder => 'Přejmenovat clowder';

  @override
  String get rename => 'Přejmenovat';

  @override
  String get timeline => 'Historie';

  @override
  String get mergeInto => 'Sloučit s…';

  @override
  String get deleteClowder => 'Smazat clowder';

  @override
  String get cats => 'Kočky';

  @override
  String get addCat => 'Přidat kočku';

  @override
  String get newCat => 'Nová kočka';

  @override
  String deleteQuestion(String name) {
    return 'Smazat $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder zmizí ze seznamu.';

  @override
  String deleteClowderBody(int count) {
    return 'Jeho kočky ($count) se nesmažou — stanou se toulavými. Pokud to nechcete, přesuňte je nejdřív do jiného clowderu.';
  }

  @override
  String get card => 'Karta';

  @override
  String get shareAsImage => 'Sdílet jako obrázek';

  @override
  String get shareAsPdf => 'Sdílet jako PDF';

  @override
  String get print => 'Tisk';

  @override
  String cardTitle(String name) {
    return 'Karta — $name';
  }

  @override
  String get renameCat => 'Přejmenovat kočku';

  @override
  String get seenHereNow => 'Právě viděna zde';

  @override
  String get deleteCat => 'Smazat kočku';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Toulavá — bez clowderu';

  @override
  String get stray => 'Toulavá';

  @override
  String get photos => 'Fotky';

  @override
  String get addPhoto => 'Přidat fotku';

  @override
  String get setAsProfileImage => 'Nastavit jako profilovou fotku';

  @override
  String get thisIsProfileImage => 'Toto je profilová fotka';

  @override
  String get deletePhoto => 'Smazat fotku';

  @override
  String get deletePhotoTitle => 'Smazat fotku?';

  @override
  String get deletePhotoBody =>
      'Data fotky se nenávratně smažou — nelze vzít zpět.';

  @override
  String get deleteCatBody =>
      'Kočka zmizí ze všech seznamů a její fotky se odstraní — tady i, po příští synchronizaci, na ostatních zařízeních.';

  @override
  String get sightingRecorded => 'Pozorování zaznamenáno na vaší pozici.';

  @override
  String get noLocationAvailable =>
      'Poloha není k dispozici — místo toho podržte prst na mapě.';

  @override
  String get locationDeniedForever =>
      'Přístup k poloze je zablokován. Povolte ho v nastavení systému, abyste mohli používat Stray Cam.';

  @override
  String get locationServiceOff =>
      'Poloha je na tomto zařízení vypnutá. Zapněte ji v nastavení a zkuste to znovu.';

  @override
  String get locationDenied =>
      'cat(a)log nemá oprávnění používat vaši polohu. Zkuste to znovu a na dotaz ji povolte.';

  @override
  String get locationNoFix =>
      'Vaši polohu se teď nepodařilo zjistit. Zkuste to znovu venku — GPS potřebuje volný výhled na oblohu.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Číslo čipu';

  @override
  String get starterRemarks => 'Poznámky';

  @override
  String get captureFlier => 'Vyfotit leták';

  @override
  String get addPhotosTo => 'Přidat fotky k…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotek přidáno k $name';
  }

  @override
  String get scanPrintedCode => 'Naskenovat vytištěný kód';

  @override
  String get chipScanHint =>
      'Naskenuje vytištěný QR/čárový kód z karty čipu nebo veterinárních dokladů — čip v kočce telefon přečíst neumí.';

  @override
  String get savingLabel => 'Ukládání…';

  @override
  String ownerOfCat(String name) {
    return 'Majitel kočky $name';
  }

  @override
  String get sortLabel => 'Řazení';

  @override
  String get viewAsTable => 'Zobrazit jako tabulku';

  @override
  String get viewAsTiles => 'Zobrazit jako dlaždice';

  @override
  String get matchCandidatesTitle => 'Možné shody';

  @override
  String get findDuplicates => 'Najít duplicity';

  @override
  String get noDuplicates => 'Momentálně žádné možné duplicity.';

  @override
  String get similarName => 'Podobné jméno';

  @override
  String get sharePublicly => 'Sdílet veřejně…';

  @override
  String get privateNoShare =>
      'Tato kočka je označena jako soukromá — soukromá data nikdy neopouštějí vaše zařízení. Nejdřív označení zrušte, pak ji lze sdílet veřejně.';

  @override
  String get pickFramesTitle => 'Výběr snímků';

  @override
  String get suggestedFrames => 'Navržené snímky';

  @override
  String get scrubFrames => 'Posouvání videa';

  @override
  String get keepThisFrame => 'Ponechat tento snímek';

  @override
  String get fromVideo => 'Z videa…';

  @override
  String get videoMobileOnly =>
      'Výběr snímků z videa funguje v mobilní aplikaci (Android a iPhone) — na tomto zařízení zatím ne.';

  @override
  String get shareWhitelistExplainer =>
      'Vyberte, co půjde do souboru. Zahrnou se jen zaškrtnutá pole.';

  @override
  String get exportShareFile => 'Exportovat soubor sdílení…';

  @override
  String get hostedLink => 'Hostovaný odkaz (URL nahraného souboru)';

  @override
  String get inlineQr => 'Vložené QR (jen text, bez fotek)';

  @override
  String get inlineTooBig =>
      'Příliš mnoho dat pro vložený kód — odškrtněte pole nebo použijte hostovaný odkaz.';

  @override
  String get scanShareLabel => 'Naskenovat kód sdílení';

  @override
  String get notAShareCode => 'Tento kód není sdílení cat(a)log.';

  @override
  String get importShareTitle => 'Importovat tuto kočku?';

  @override
  String shareSource(String url) {
    return 'Zdroj: $url';
  }

  @override
  String get importLabel => 'Importovat';

  @override
  String get strayAreaLabel => 'Možná oblast toulání';

  @override
  String get prevPin => 'Předchozí špendlík';

  @override
  String get nextPin => 'Další špendlík';

  @override
  String get noMissingCats =>
      'Zatím žádné pohřešované kočky s pozicemi letáků.';

  @override
  String get noMatchCandidates => 'Momentálně žádné možné shody.';

  @override
  String sameIdField(String field) {
    return 'Stejné $field';
  }

  @override
  String metersApart(String distance) {
    return 'Vzdálenost $distance m';
  }

  @override
  String get addFlier => 'Přidat leták';

  @override
  String get missingSinceLabel => 'Pohřešován od';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Oříznout portrét';

  @override
  String get statusOwner => 'Majitel';

  @override
  String get ocrUnavailable =>
      'Rozpoznávání textu není na tomto zařízení dostupné — napište text letáku ručně.';

  @override
  String get displayFormat => 'Zobrazit jako';

  @override
  String get displayPlain => 'Prostý text';

  @override
  String get displayQr => 'QR kód';

  @override
  String get displayBarcode => 'Čárový kód';

  @override
  String get editLabel => 'Upravit';

  @override
  String get doneLabel => 'Hotovo';

  @override
  String get openSettings => 'Otevřít nastavení';

  @override
  String get notSaved => 'Neuloženo';

  @override
  String get birthdateInFuture => 'Datum narození nemůže být v budoucnosti.';

  @override
  String get deceasedInFuture => 'Datum úmrtí nemůže být v budoucnosti.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Datum úmrtí nemůže být před datem narození ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Datum narození nemůže být po datu úmrtí ($date).';
  }

  @override
  String get malePregnant =>
      'Tato kočka je vedena jako kocour — kocour nemůže být březí. Nejdřív zkontrolujte pohlaví.';

  @override
  String fatherNotMale(String name) {
    return '$name je vedena jako kočka (samice) a nemůže být otcem. Nejdřív zkontrolujte pohlaví.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name je veden jako kocour a nemůže být matkou. Nejdřív zkontrolujte pohlaví.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name se narodil $date — rodič se nemůže narodit po svém koťeti.';
  }

  @override
  String get genderFatherFemale =>
      'Tato kočka je vedena jako otec jiných koček — otec nemůže být samice. Nejdřív zkontrolujte rodinu.';

  @override
  String get genderMotherMale =>
      'Tato kočka je vedena jako matka jiných koček — matka nemůže být samec. Nejdřív zkontrolujte rodinu.';

  @override
  String get moveTo => 'Přesunout do';

  @override
  String get noClowderStrayOption => 'Bez clowderu — toulavá / utekla';

  @override
  String timelineOf(String name) {
    return 'Historie — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Vrátit tuto změnu';

  @override
  String get revertSubtitle =>
      'Obnoví předchozí hodnotu jako nový záznam — historie zachová obojí.';

  @override
  String fieldCleared(String field) {
    return '$field vymazáno';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field zpět na \"$value\"';
  }

  @override
  String get leftStray => 'Odešla — toulavá';

  @override
  String movedTo(String name) {
    return 'Přesunuta do $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat přišla';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat přišla z $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat odešla do $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicitní záznam sloučen';

  @override
  String get asOfToday => 'K dnešnímu dni';

  @override
  String asOfDate(String date) {
    return 'Ke dni $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Špatný formát — použijte $format';
  }

  @override
  String get value => 'Hodnota';

  @override
  String get latitudeLongitude => 'zeměpisná šířka, délka';

  @override
  String get newField => 'Nové pole';

  @override
  String get fieldType => 'Typ';

  @override
  String get usedOn => 'Použito pro';

  @override
  String get forCats => 'kočky';

  @override
  String get forClowders => 'clowdery';

  @override
  String get forBoth => 'obojí';

  @override
  String get optionsOnePerLine => 'Možnosti (jedna na řádek)';

  @override
  String get ownValue => 'Vlastní hodnota';

  @override
  String get renameField => 'Přejmenovat pole';

  @override
  String get editOptions => 'Upravit možnosti…';

  @override
  String get noStraysRightNow => 'Momentálně žádné toulavé kočky.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Přidat toulavou';

  @override
  String get newStray => 'Nová toulavá';

  @override
  String get searchByNameHint => 'Hledat kočky podle jména…';

  @override
  String get host => 'Hostovat';

  @override
  String get hostExplainer =>
      'Začněte zde a pak na druhém zařízení zadejte adresu a PIN.';

  @override
  String get startHosting => 'Spustit hostování';

  @override
  String get stopHosting => 'Zastavit hostování';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Dosud relací: $count';
  }

  @override
  String get join => 'Připojit se';

  @override
  String get addressFromHost => 'Adresa (z hostujícího zařízení)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synchronizovat teď';

  @override
  String get addressFormatHint => 'Adresa musí vypadat jako 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synchronizováno: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synchronizace selhala: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Poslední synchronizace s $peer: $time';
  }

  @override
  String get sharedFolder => 'Sdílená složka';

  @override
  String get sharedFolderExplainer =>
      'Obě zařízení používají stejnou složku (např. v Dropboxu nebo na flashce). Každá synchronizace tam uloží vaše změny a převezme změny druhé strany.';

  @override
  String get noFolderChosenYet => 'Zatím nevybrána žádná složka';

  @override
  String get choose => 'Vybrat…';

  @override
  String get syncFolderNow => 'Synchronizovat složku teď';

  @override
  String folderSynced(String result) {
    return 'Složka synchronizována: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Synchronizace složky selhala: $error';
  }

  @override
  String get recordSightingHere => 'Zaznamenat pozorování zde:';

  @override
  String trailOf(String name, int count) {
    return 'Trasa: $name (pozorování: $count)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'Změněno na dvou místech zároveň. Vyberte, co platí:';

  @override
  String mergeThisInto(String kind) {
    return 'Sloučit tento záznam ($kind) s…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Žádný jiný záznam ($kind) ke sloučení.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Sloučit s $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Ze dvou záznamů bude jeden. $name si ponechá aktuální hodnoty; historie druhého se připojí. Nelze vzít zpět.';
  }

  @override
  String get kindCat => 'kočka';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'pole';

  @override
  String get takePhoto => 'Vyfotit';

  @override
  String get chooseFromGallery => 'Vybrat z galerie';

  @override
  String get about => 'O aplikaci';

  @override
  String get aboutTagline =>
      'Lokální katalog koček v dočasné péči. Vaše data zůstávají na vašich zařízeních — žádný server, žádný účet.';

  @override
  String versionLabel(String version, String build) {
    return 'Verze $version ($build)';
  }

  @override
  String get sourceCode => 'Zdrojový kód';

  @override
  String get reportProblemOrIdea => 'Nahlásit problém nebo nápad';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Napsat vývojáři';

  @override
  String get buyCoffee => 'Koupit vývojáři kávu';

  @override
  String get coffeeSubtitle => 'Zcela dobrovolné — aplikace je zdarma';

  @override
  String get openSourceLicenses => 'Open source licence';

  @override
  String get machineTranslated =>
      'Překlady jsou strojové — opravy vítány na GitHubu.';

  @override
  String get unnamed => '(beze jména)';

  @override
  String get labelName => 'Jméno';

  @override
  String get labelProfileImage => 'Profilová fotka';

  @override
  String get labelPhoto => 'Fotka';

  @override
  String get starterGender => 'Pohlaví';

  @override
  String get starterBreed => 'Plemeno';

  @override
  String get valueMixed => 'kříženec';

  @override
  String get breedEuropeanShorthair => 'Evropská krátkosrstá';

  @override
  String get breedMaineCoon => 'Mainská mývalí';

  @override
  String get breedBritishShorthair => 'Britská krátkosrstá';

  @override
  String get breedNorwegianForestCat => 'Norská lesní';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamská';

  @override
  String get breedPersian => 'Perská';

  @override
  String get breedBengal => 'Bengálská';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get starterColor => 'Barva';

  @override
  String get starterNeutered => 'Kastrovaná';

  @override
  String get starterPregnant => 'Březí';

  @override
  String get starterBirthdate => 'Datum narození';

  @override
  String get starterDeceased => 'Uhynula';

  @override
  String get starterAddress => 'Adresa';

  @override
  String get starterResponsible => 'Odpovědná osoba';

  @override
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Odkaz pro vyhledání';

  @override
  String lookupUrlHelp(String token) {
    return 'Stránka služby s $token na místě čísla, např. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Vyhledat';

  @override
  String lookupFailed(String url) {
    return 'Žádná aplikace nedokázala otevřít $url. Zkopírujte odkaz do prohlížeče.';
  }

  @override
  String get stepCat => 'Kočka';

  @override
  String get stepOwner => 'Majitel';

  @override
  String get stepFace => 'Foto obličeje';

  @override
  String get stepRegistry => 'Registr';

  @override
  String get stepReview => 'Zkontrolovat a uložit';

  @override
  String get stepOwnerHint =>
      'Kdo kočku postrádá — z toho vznikne jeho karta s kontaktem z letáku.';

  @override
  String get stepFaceHint =>
      'Vyřízněte z letáku kočičí obličej; stane se profilovou fotkou. Můžete přeskočit.';

  @override
  String get stepRegistryHint =>
      'Čísla nalezená na letáku. Zaškrtnutá se uloží ke kočce a lze je později otevřít.';

  @override
  String get noRegistryLinks =>
      'Na tomto letáku nejsou odkazy na registry — tady není co dělat.';

  @override
  String get unknownServiceHint => 'Neznámá služba';

  @override
  String get rememberService => 'Zapamatovat službu';

  @override
  String get rememberServiceHint =>
      'Pojmenujte službu a ukažte na číslo v odkazu. Další leták se vyplní sám.';

  @override
  String get noIdInLink =>
      'V tomto odkazu není číslo, které by aplikace mohla uložit.';

  @override
  String get whichNumber => 'Která část je číslo?';

  @override
  String get cropAgain => 'Oříznout znovu';

  @override
  String get noFaceYet =>
      'Zatím žádná fotka obličeje — použije se foto letáku.';

  @override
  String get backLabel => 'Zpět';

  @override
  String get dangerButton => 'NEMAČKAT.\nNEBEZPEČÍ';

  @override
  String get dangerThanks => 'Děkujeme, že používáte cat(a)log!';

  @override
  String get locateAddress => 'Najít adresu na mapě';

  @override
  String get addressLocated => 'Adresa nalezena';

  @override
  String get addressNotFound =>
      'K této adrese se nenašlo žádné místo. Zkontrolujte pravopis nebo pole nechte prázdné.';

  @override
  String get starterPosition => 'Poloha';

  @override
  String get valueYes => 'ano';

  @override
  String get valueNo => 'ne';

  @override
  String get valueFemale => 'kočka';

  @override
  String get valueMale => 'kocour';

  @override
  String get valueUnknown => 'neznámé';

  @override
  String get cropTitle => 'Oříznout fotku';

  @override
  String get markTitle => 'Označit kočku';

  @override
  String get applyCrop => 'Oříznout';

  @override
  String get useFullPhoto => 'Použít celou fotku';

  @override
  String get dragToSelect => 'Tažením nakreslete obdélník kolem kočky';

  @override
  String get dragOverTheCat => 'Tažením nakreslete elipsu přes kočku';

  @override
  String get cropPhoto => 'Oříznout…';

  @override
  String get markPhoto => 'Označit…';

  @override
  String get scanCode => 'Naskenovat kód';

  @override
  String get orTypeCode => 'Nebo kód napište';

  @override
  String get copyCode => 'Kopírovat kód';

  @override
  String get copied => 'Zkopírováno';

  @override
  String get invalidCode => 'Tento kód není platný';

  @override
  String get hotspotHint =>
      'Žádná společná Wi-Fi? Zapněte hotspot na jednom telefonu, druhý připojte a hostujte zde.';

  @override
  String get byMessenger => 'Přes messenger';

  @override
  String get byMessengerExplainer =>
      'Pošlete celý katalog jako jeden soubor přes WhatsApp, Signal nebo mail — druhá strana ho importuje.';

  @override
  String get shareBundle => 'Sdílet synchronizační balíček…';

  @override
  String get importBundle => 'Importovat synchronizační balíček…';

  @override
  String bundleImported(String result) {
    return 'Balíček importován: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Poslední automatická záloha selhala: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import selhal: $error';
  }

  @override
  String get pickOnMap => 'Vybrat na mapě';

  @override
  String get useMyLocation => 'Použít moji polohu';

  @override
  String get language => 'Jazyk';

  @override
  String get systemDefault => 'Výchozí systému';

  @override
  String get iosLocalNetworkHint =>
      'Pokud to na iPhonu/iPadu dál selhává: Nastavení → Soukromí a zabezpečení → Místní síť → povolit cat(a)log a zkusit znovu.';

  @override
  String get markPrivate => 'Označit jako soukromé';

  @override
  String get unmarkPrivate => 'Odebrat soukromé označení';

  @override
  String get includePrivate => 'Zahrnout soukromá data';

  @override
  String get includePrivateExplainer =>
      'Tímto se pošle i vše, co jste označili jako soukromé. Ten, s kým synchronizujete, to uvidí.';

  @override
  String get hideLabel => 'Skrýt na tomto zařízení';

  @override
  String get unhideLabel => 'Znovu zobrazit';

  @override
  String get showHiddenLabel => 'Zobrazit skryté';

  @override
  String get stopShowingHidden => 'Přestat zobrazovat skryté';

  @override
  String get starterSpecies => 'Druh';

  @override
  String get starterStatus => 'Typ';

  @override
  String get statusFoster => 'Dočasná péče';

  @override
  String get statusForeverHome => 'Domov navždy';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Útulek';

  @override
  String get statusBarn => 'Stodola';

  @override
  String get valueCat => 'Kočka';

  @override
  String get otherOption => 'Jiné…';

  @override
  String get celebrationsToggle => 'Slavit adopce';

  @override
  String get celebrationsSubtitle =>
      'Konfety a jásot, když se kočka stěhuje do domova navždy';

  @override
  String get onMapLabel => 'Na mapě';

  @override
  String get showOnMap => 'Zobrazit na mapě';

  @override
  String get searchPlaceHint => 'Hledat místo nebo adresu';

  @override
  String get noPlacesFound => 'Žádná místa nenalezena';

  @override
  String get mapSearchHint => 'Hledat kočky, skupiny, osoby';

  @override
  String get proposeAnotherName => 'Navrhnout jiné jméno';

  @override
  String get moderationTitle => 'Autoři a zákazy';

  @override
  String get moderationSubtitle => 'Trvale odstranit data osoby';

  @override
  String get authorsSection => 'Kdo do katalogu psal';

  @override
  String get hardDeleteAction => 'Smazat vše od tohoto autora';

  @override
  String hardDeleteWarning(Object name) {
    return 'Odstraní každý záznam a fotku od $name z tohoto zařízení. Ostatní zařízení si své ponechají. Nelze vrátit zpět.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Pro potvrzení napište $name';
  }

  @override
  String get alsoBan => 'Také zakázat — už nikdy nepřijímat data';

  @override
  String get bansSection => 'Zákazy';

  @override
  String get unbanAction => 'Zrušit zákaz';

  @override
  String get deletedDone => 'Smazáno.';

  @override
  String get syncSummaryTitle => 'Co dorazilo';

  @override
  String get summaryAdopted => 'Adoptované';

  @override
  String get summaryDeceased => 'Uhynulé';

  @override
  String get summaryEscaped => 'Utečené';

  @override
  String get summaryNew => 'Nové';

  @override
  String get summaryConflicts => 'Konflikty k vyřešení';

  @override
  String summaryOther(Object n) {
    return '…a $n dalších změn';
  }

  @override
  String get starterMother => 'Matka';

  @override
  String get starterFather => 'Otec';

  @override
  String get familySection => 'Rodina';

  @override
  String get littermatesLabel => 'Z jednoho vrhu';

  @override
  String get siblingsLabel => 'Sourozenci';

  @override
  String get kittensLabel => 'Koťata';

  @override
  String get toastSettingsTitle => 'Co oznamovat';

  @override
  String get toastSettingsSubtitle => 'Krátké zprávy po synchronizaci';

  @override
  String get toastKindAdoptions => 'Adopce';

  @override
  String get toastKindBirths => 'Narození';

  @override
  String get toastKindDeaths => 'Úmrtí';

  @override
  String get toastKindEscapes => 'Útěky';

  @override
  String get toastKindMoves => 'Stěhování';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptována do $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nové kotě: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat uhynula';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat utekla';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat se přestěhovala do $home';
  }

  @override
  String get notACatlogFile => 'To není soubor cat(a)log';

  @override
  String get nothingNewInBundle => 'V souboru nic nového — všechno už máš';

  @override
  String get syncChooserInPerson => 'Osobně';

  @override
  String get syncChooserInPersonSub =>
      'Jste ve stejné místnosti — naskenuj kód, hotovo za pár vteřin';

  @override
  String get syncChooserRemote => 'Na dálku';

  @override
  String get syncChooserRemoteSub =>
      'Přes sdílenou složku jako Dropbox nebo USB disk';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Pošlete vše jako jeden soubor přes libovolný messenger — a přijatý soubor .catsync importujte zde';

  @override
  String get connectToWifiFirst =>
      'Nejprve se připoj k Wi-Fi — pak se zařízení najdou';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) chce synchronizovat';
  }

  @override
  String get trustBothWaysNote => 'Katalogy se vymění oběma směry.';

  @override
  String get allowOnce => 'Povolit';

  @override
  String get allowAlways => 'Vždy povolit toto zařízení';

  @override
  String get declineAction => 'Odmítnout';

  @override
  String get syncDeclined => 'Druhé zařízení synchronizaci odmítlo';

  @override
  String get trustedDevicesSection => 'Vždy povolená zařízení';

  @override
  String get removeTrust => 'Odebrat';

  @override
  String get hostWithoutWifi => 'Hostovat bez Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Naváže dočasné přímé spojení s druhým telefonem (bez internetu). Používá ho jen cat(a)log a po synchronizaci se samo odpojí.';

  @override
  String get hotspotAndroidOnly =>
      'Tento kód vyžaduje dva telefony s Androidem — na iPhonu/iPadu použij společnou Wi-Fi';

  @override
  String get selectClowderHint => 'Vyber clowder vlevo';

  @override
  String get introTitle1 => 'Vaše kočky přehledně';

  @override
  String get introBody1 =>
      'Založte každé kočce kartu: fotka, pohlaví, zdraví, cokoli chcete zaznamenat. Kočky jsou seskupené podle místa, kde žijí — aplikace mu říká kolonie (clowder).';

  @override
  String get introTitle2 => 'Funguje bez internetu';

  @override
  String get introBody2 =>
      'Vše se ukládá jen do vašeho telefonu. Žádný účet, žádný cloud. Nic se neodesílá, dokud to sami nesdílíte.';

  @override
  String get introTitle3 => 'Spolupráce';

  @override
  String get introBody3 =>
      'Každý používá svou aplikaci a čas od času si vyměníte data: sejděte se a naskenujte kód, použijte sdílenou složku nebo pošlete jeden soubor messengerem. Potom mají všichni stejné informace.';

  @override
  String get introSkip => 'Přeskočit';

  @override
  String get introNext => 'Dále';

  @override
  String get introDone => 'Jdeme na to';

  @override
  String get introReplayTitle => 'Rychlý úvod';

  @override
  String get spotHomeSync =>
      'Tady synchronizujete se svými známými. Vy rozhodujete, co sdílíte.';

  @override
  String get spotHomeStrays =>
      'Tato karta sbírá všechny toulavé kočky — kočky bez domova. Klepnutím zobrazíte seznam.';

  @override
  String get spotHomeMenu =>
      'V tomto menu: hledání a slučování duplicit, export CSV a další.';

  @override
  String get spotCatEdit =>
      'Klepněte na tužku a kočku upravte. Tip: podržte pole a upravíte ho rovnou.';

  @override
  String get spotMapLayers =>
      'Hledáte pohřešovanou kočku? Zobrazte kruhy kolem míst jejích letáků a kolem domova, ze kterého utekla.';

  @override
  String get spotStraysFlier =>
      'Leták s pohřešovanou kočkou? Vyfoťte ho tady — aplikace uloží kočku i kontakt za vás.';

  @override
  String get spotStraysScan =>
      'Některé letáky mají QR kód cat(a)log. Naskenujte ho tady a kočku importujte bez psaní.';

  @override
  String get introTitle4 => 'Hledání pohřešovaných koček';

  @override
  String get introBody4 =>
      'Vidíte leták s pohřešovanou kočkou? Vyfoťte ho v aplikaci: uloží kočku, kontakt na majitele i místo. Objeví-li se později podobná toulavá kočka, aplikace navrhne možné shody.';

  @override
  String get spotMapSearch =>
      'Napište kočku, místo nebo osobu a skočte tam na mapě.';

  @override
  String get spotCardChips =>
      'Zaškrtněte, co má být na sdílené kartě — zbytek na ní nebude.';

  @override
  String get spotCatMenu =>
      'Další akce jsou tady: označit kočku jako soukromou, skrýt ji, sloučit duplicity nebo zapsat pozorování.';

  @override
  String get spotDone => 'Rozumím';

  @override
  String get spotReplayTitle => 'Prohlídka novinek';

  @override
  String get spotReplaySubtitle => 'Znovu ukázat tipy na každé stránce';

  @override
  String get spotReplayDone => 'Tipy se znovu zobrazí';

  @override
  String get searchNoResults => 'Kočka s tímto jménem nenalezena';

  @override
  String get syncUnreachable =>
      'Druhé zařízení není dosažitelné. Jsou obě na stejné Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Složka není dosažitelná. Existuje ještě disk nebo cloudová složka?';

  @override
  String get crashTitle => 'Tohle se nemělo stát';

  @override
  String get crashBody =>
      'cat(a)log narazil na nečekanou chybu. Tvá data jsou v bezpečí — vše se ukládá hned při změně. Restartuj aplikaci, a pokud se to opakuje, pošli hlášení, ať se to dá opravit.';

  @override
  String get crashRestart => 'Restartovat aplikaci';

  @override
  String get crashSendReport => 'Poslat hlášení vývojáři';

  @override
  String get crashLastRunBody =>
      'cat(a)log se minule nečekaně ukončil — nejspíš došla paměť. Poslat krátké hlášení, aby se to dalo opravit?';
}
