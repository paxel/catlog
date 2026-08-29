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
  String get dateInFuture => 'Toto datum nemůže být v budoucnosti.';

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
      'Začněte zde a pak na druhém zařízení naskenujte kód nebo ho zadejte.';

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
  String get coffeeSubtitle =>
      'Aplikace zůstane zdarma. I když kávu nedostanu :)';

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
      'Kdo kočku postrádá — z toho vznikne jeho clowder s kontaktem z letáku.';

  @override
  String get stepFaceHint =>
      'Vyřízněte z letáku kočičí obličej; stane se profilovou fotkou. Můžete přeskočit.';

  @override
  String get stepRegistryHint =>
      'Čísla nalezená na letáku. Zaškrtnutá se uloží ke kočce a lze je později otevřít.';

  @override
  String get noRegistryLinks =>
      'Na tomto letáku nejsou odkazy na registry — pokud byly přehlédnuty, nahlaste prosím chybu.';

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
  String get helpTitle => 'Nápověda';

  @override
  String get showTipsAgain => 'Zobrazit tipy znovu';

  @override
  String get helpHome =>
      'Přehled vašich kolonií — kolonie je místo, kde žijí kočky: váš domov, dočaska, útulek. Klepnutím na kartu zobrazíte její kočky; podržením otevřete menu. Tlačítko vpravo dole založí kolonii a karta toulavých sbírá všechny kočky bez domova. Název nahoře je katalog, ve kterém jsi — klepnutím přepneš nebo přidáš další.';

  @override
  String get helpClowder =>
      'Vše o tomto místě: jeho kočky, pole (adresa, kontakt, typ) a historie. Stránka se otevře jen ke čtení; tužka zapne úpravy, kde můžete přidat i nové pole. Podržením pole ho upravíte rovnou, podržením kočky ji přesunete, skryjete nebo otevřete. Schůzka přidaná zde může vzít více koček kolonie, například kastrační výjezd: zaškrtněte kočky, které jedou, dokončete jednou, odškrtněte ty, které nebyly ošetřeny.';

  @override
  String get helpCat =>
      'Vše o této kočce: fotky, pole, rodina, historie. Stránka je jen pro čtení, dokud neklepneš na tužku. Dlouze podrž pole a rovnou ho upravíš; dlouze podrž fotku pro její menu. Menu vpravo nahoře drží zbytek: skrýt, sloučit, zaznamenat spatření, sdílet kočku. „Soukromé“ se nastavuje při úpravě pole.';

  @override
  String get helpStrays =>
      'Kočky, které teď nemají domov: nalezené, utečené nebo z letáku. Tlačítko fotoaparátu zapíše kočku, která sedí před vámi; tlačítko letáku promění plakát v kočku i s kontaktem majitele; skener přečte kód cat(a)log z plakátu.';

  @override
  String get helpMap =>
      'Všechny kočky a místa s pozicí. Hledání najde kočky, lidi i místa — neznámé jméno hledá po celém světě. Tlačítko vrstev nakreslí kruhy 500 m kolem míst letáků pohřešované kočky a kolem domova, ze kterého utekla. Šipky vedou od špendlíku ke špendlíku, podržením mapy zapíšete pozorování.';

  @override
  String get helpCard =>
      'Tisknutelná karta kočky: nahoře čipy vyberete, co na ní bude, pak ji sdílíte jako obrázek nebo PDF. Čísla lze vytisknout jako QR nebo čárový kód a z pozice vznikne QR otevírající mapu plus krátký Plus Code.';

  @override
  String get helpSync =>
      'Jak se data dostanou k dalším lidem: spojit se osobně, použít složku, kterou vidí obě zařízení, nebo poslat soubor přes messenger. Vždy rozhodujete vy, co odejde — a přijaté soubory .catsync otevřete také zde.';

  @override
  String get helpFields =>
      'Pole, která váš katalog používá. Přejmenujte je, změňte možnosti výběrového pole nebo přidejte vlastní. Pole s identifikátorem může ukazovat na službu (registr), pak jde číslo u kočky klepnout.';

  @override
  String get helpTimeline =>
      'Každá provedená změna, nejnovější nahoře: kdo co kdy a na jakou hodnotu změnil. Každý záznam lze vrátit — vznikne tím nový záznam, nic se nikdy nemaže.';

  @override
  String get helpDuplicates =>
      'Kočky nebo kolonie, které vypadají, že existují dvakrát — stejná čísla nebo velmi podobná jména se souhlasícími údaji. Klepnutím na dvojici ji sloučíte; sloučení nelze vzít zpět, proto se ptá předem.';

  @override
  String get helpMatches =>
      'Kočky, které mohou být totéž zvíře: stejné číslo, nebo toulavá kočka viděná v oblasti hledání pohřešované kočky. Klepnutím dvojici sloučíte, podržením otevřete první kočku k porovnání.';

  @override
  String get helpFlier =>
      'Z vyfoceného letáku vznikne kočka i majitel. Krok za krokem: údaje kočky, kontakt majitele, výřez obličeje pro profilovku, čísla registrů z letáku a nakonec kontrola. Vše jsou návrhy — opravte, co fotoaparát přečetl špatně.';

  @override
  String get archiveTitle => 'Archiv';

  @override
  String get archiveExplainer =>
      'Zemřelé kočky a prázdné kolonie, kterých se roky nikdo nedotkl, stále zabírají místo — hlavně jejich fotky. Archivace je zapíše do souboru, který si necháte, a pak je odsud smaže.';

  @override
  String get archiveAction => 'Archivovat';

  @override
  String archiveSelected(int count) {
    return 'Archivovat $count položek';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archivovat $count položek?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names budou zapsány do souboru a poté smazány — na vašem zařízení i na každém, se kterým synchronizujete. Import souboru vše vrátí; bez něj jsou pryč.';
  }

  @override
  String archiveDone(int count) {
    return 'Archivováno a smazáno $count položek';
  }

  @override
  String archiveFailed(String error) {
    return 'Nic nebylo smazáno: soubor archivu se nepodařilo zapsat ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Databáze $db, fotky $photos v $count souborech';
  }

  @override
  String quietForYears(int years) {
    return 'Beze změny $years let';
  }

  @override
  String get nothingToArchive => 'Nic není dost staré na archivaci.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Poslední změna $date · fotky $size';
  }

  @override
  String get helpArchive =>
      'Stará data stojí místo, hlavně fotky, které si nese každé synchronizované zařízení. Tady vyberete zemřelé kočky a prázdné kolonie, které jsou roky beze změny, zapíšete je do souboru, který si necháte, a smažete je. Smazání dorazí ke všem, s nimiž synchronizujete; import souboru vše obnoví.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Obnovit $count smazaných položek?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names jsou v tomto katalogu smazané a právě importovaný soubor je obsahuje. Obnovení je vrátí sem i na každé zařízení, se kterým synchronizujete.';
  }

  @override
  String get restoreAction => 'Obnovit';

  @override
  String get keepDeleted => 'Nechat smazané';

  @override
  String get archiveNotSaved =>
      'Nic nebylo smazáno: archiv nebyl nikam uložen.';

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
  String get includePrivate => 'Sdílet soukromá data';

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
  String get statusForeverHome => 'Domov';

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
      'Konfety a jásot, když se kočka stěhuje do svého domova';

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
  String get syncChooserInPersonSub => 'Synchronizace přes Wi-Fi';

  @override
  String get syncChooserRemote => 'Na dálku';

  @override
  String get syncChooserRemoteSub => 'Synchronizace přes složku nebo USB disk';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Export a import přes sociální sítě';

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
      'Tady jsou další akce: skrýt kočku, sloučit duplicity nebo zaznamenat spatření.';

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

  @override
  String get catalogsTitle => 'Katalogy';

  @override
  String get newCatalog => 'Nový katalog';

  @override
  String get catalogNameLabel => 'Název katalogu';

  @override
  String catalogNameTaken(String name) {
    return 'Katalog s názvem $name už existuje. Zvol jiný název.';
  }

  @override
  String get manageCatalogs => 'Správa katalogů';

  @override
  String get helpCatalogs =>
      'Každý katalog je svět sám pro sebe: vlastní kočky, kolonie, pole, fotky i partneři synchronizace. Berlín a Paříž se nikdy nesmíchají. Klepni na název nahoře na domovské obrazovce a přepni, přidej nebo přejmenuj. Tvoje jméno, jazyk a už viděné tipy jsou společné všem.';

  @override
  String get spotHomeCatalog =>
      'Tohle je katalog, ve kterém jsi. Klepni na název pro přepnutí nebo vytvoření dalšího.';

  @override
  String get deleteCatalog => 'Smazat katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Všechno v $name zmizí: kočky, fotky i historie. Nejdřív se uloží úplný soubor tam, kam chodí automatické zálohy — jeho import katalog vrátí. Potvrď napsáním názvu.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name smazán. Soubor je v $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Napiš $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nic se nesmazalo: soubor katalogu se nepodařilo zapsat ($error). Uvolni místo nebo to zkus později.';
  }

  @override
  String get moveToCatalog => 'Přesunout do jiného katalogu';

  @override
  String movedToCatalog(int count, String name) {
    return '$count přesunuto do $name';
  }

  @override
  String get chooseWhatToMove => 'Co se má přesunout?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Přesunout něco do $name?';
  }

  @override
  String get undoThisImport => 'Vrátit tento import';

  @override
  String undoImportBody(int count) {
    return '$count změn z tohoto importu zmizí. Nejdřív se zapíšou do souboru, jehož import je vrátí. Kdo už synchronizoval, svou kopii si nechá — to vzít zpět nejde.';
  }

  @override
  String undoneImport(String where) {
    return 'Vráceno. Soubor je v $where.';
  }

  @override
  String get goBackTitle => 'Vrátit se zpět';

  @override
  String get goBackToHere => 'Vrátit se sem';

  @override
  String get momentImport => 'Před importem';

  @override
  String get momentSync => 'Před synchronizací';

  @override
  String get momentMerge => 'Před sloučením';

  @override
  String get momentHardDelete => 'Před smazáním dat jednoho autora';

  @override
  String get momentArchive => 'Před archivací';

  @override
  String get momentManual => 'Označeno tebou';

  @override
  String get showOlderMoments => 'Zobrazit starší';

  @override
  String goBackBody(int count) {
    return 'Všechno po tomto okamžiku zmizí — $count změn. Nejdřív se zapíše do souboru, jehož import to vrátí, a každý novější okamžik jde s tím. Kdo už synchronizoval, kopii si nechá — to vzít zpět nejde.';
  }

  @override
  String get nameThisMoment => 'Pojmenuj tento okamžik';

  @override
  String get helpGoBack =>
      'Okamžiky, kdy tento katalog výrazně změnil tvar: před každým importem a každou synchronizací, před sloučením, archivací nebo mazáním, a kdykoli sis okamžik označil sám. Výběrem jednoho se katalog vrátí do toho stavu — všechno po něm se zapíše do souboru, který si necháš, a pak se odstraní; každý novější okamžik jde s tím. Kdo už synchronizoval, si ponechá, co dostal.';

  @override
  String goBackFileFailed(String error) {
    return 'Nic se neodstranilo: soubor, který to uchová, se nepodařilo zapsat ($error). Uvolni místo a zkus to znovu.';
  }

  @override
  String get switchBeforeDeleting =>
      'Tohle je katalog, ve kterém jsi. Přepni na jiný a pak ho smaž.';

  @override
  String shareFileFailed(String error) {
    return 'Soubor ke sdílení se nepodařilo zapsat ($error). Uvolni místo a zkus to znovu.';
  }

  @override
  String get privateLabel => 'Soukromé';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Označit jako soukromé';

  @override
  String get unmarkPrivate => 'Odebrat soukromé označení';

  @override
  String get agenda => 'Připomínky';

  @override
  String get reminderLabel => 'Připomínka';

  @override
  String get agendaEmpty =>
      'Žádné termíny nejsou naplánované. Nové naplánuješ tady plusem nebo na stránce kočky či clowderu.';

  @override
  String get dueToday => 'dnes';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'za $count dní',
      few: 'za $count dny',
      one: 'za 1 den',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dní po termínu',
      few: '$count dny po termínu',
      one: '1 den po termínu',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Hotovo';

  @override
  String get repeatTitle => 'Znovu za…';

  @override
  String get noRepeatLabel => 'Bez opakování';

  @override
  String get unitDays => 'dní';

  @override
  String get unitWeeks => 'týdnů';

  @override
  String get unitMonths => 'měsíců';

  @override
  String get unitYears => 'let';

  @override
  String ageYears(int years) {
    return '$years r.';
  }

  @override
  String ageMonths(int months) {
    return '$months měs.';
  }

  @override
  String get changeDateLabel => 'Změnit datum';

  @override
  String get removeReminderLabel => 'Odebrat připomínku';

  @override
  String get exportIcs => 'Exportovat soubor kalendáře';

  @override
  String icsSavedTo(String path) {
    return 'Soubor kalendáře uložen do $path';
  }

  @override
  String get calendarMirrorLabel => 'Zrcadlit do kalendáře zařízení';

  @override
  String get calendarMirrorSubtitle =>
      'Termíny se v kalendáři objeví jako celodenní události. cat(a)log je tam aktualizuje při každém spuštění a po každé změně. Upozornění na termíny spravuješ v kalendáři.';

  @override
  String get syncPeerOlder =>
      'Druhé zařízení má starší cat(a)log bez připomínek. Aktualizuj tam cat(a)log a synchronizuj znovu.';

  @override
  String get syncPeerNewer =>
      'Druhé zařízení má novější cat(a)log. Aktualizuj cat(a)log na tomto zařízení a synchronizuj znovu.';

  @override
  String get bundleNewerError =>
      'Tento soubor pochází z novějšího cat(a)logu. Aktualizuj cat(a)log na tomto zařízení, aby šel importovat.';

  @override
  String get spotEar => 'Malé kočičí ucho v rohu znamená: podrž pro víc.';

  @override
  String get addReminder => 'Přidat připomínku';

  @override
  String get plannedSection => 'Naplánováno';

  @override
  String get reminderDialogHint =>
      'Termín se zobrazí v připomínkách. Tam ho můžeš potvrdit nebo zahodit. Hodnota se převezme jen tehdy, když byl termín potvrzen.';

  @override
  String get reminderFor => 'Pro';

  @override
  String get reminderField => 'Pole';

  @override
  String get dueDateLabel => 'Termín';

  @override
  String get pickCalendar => 'Který kalendář?';

  @override
  String get calendarPermissionDenied =>
      'Přístup ke kalendáři je zablokovaný, takže zrcadlení je vypnuté. Povol ho v nastavení systému a zrcadlení znovu zapni.';

  @override
  String get calendarNotChosen =>
      'Není vybraný žádný kalendář, takže zrcadlení je vypnuté. Znovu ho zapni a nějaký vyber.';

  @override
  String get calendarGone =>
      'Vybraný kalendář už neexistuje, takže zrcadlení je vypnuté. Znovu ho zapni a vyber jiný.';

  @override
  String get noWritableCalendar =>
      'Kalendář nenalezen. Přihlas se v nastavení systému k účtu kalendáře, třeba Google, a zkus to znovu.';

  @override
  String get spotHomeAgenda =>
      'Připomínky: seznam naplánovaných termínů — veterinář, léky, kontroly.';

  @override
  String get spotAgendaAdd => 'Naplánovat nový termín.';

  @override
  String get spotAgendaCalendar =>
      'Zapni tady zrcadlení termínů cat(a)logu do vybraného kalendáře.';

  @override
  String get helpAgenda =>
      'Připomínky ukazují naplánované termíny podle data. Jsou dva druhy: termíny s hodinou a připomínky, které platí pro den. Zmeškané zůstávají nahoře. Klepnutí otevře kočku nebo clowder. Fajfka potvrdí termín: hodnota se zapíše do pole a hned můžeš naplánovat další, třeba za tři měsíce. Podržení změní datum nebo termín smaže. Přepínač nahoře zrcadlí termíny do kalendáře telefonu. Nabídka je exportuje jako soubor kalendáře. Návštěva veterináře s více kočkami je jedna schůzka: zaškrtněte kočky, Agenda ukáže jednu kartu s jejich jmény a při dokončení se zeptá, které kočky byly ošetřeny — ostatní odškrtněte, zůstanou naplánované.';

  @override
  String get calendarRowOff => 'Kalendář: vypnuto';

  @override
  String calendarRowOn(String name) {
    return 'Kalendář: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Naplánuj termín pro tuto kočku. Zobrazí se v připomínkách a tam se potvrdí.';

  @override
  String get spotAddReminderClowder =>
      'Naplánuj termín pro tento clowder. Zobrazí se v připomínkách a tam se potvrdí.';

  @override
  String get readOnlyCalendar => 'jen ke čtení';

  @override
  String get appointmentLabel => 'Termín';

  @override
  String get addAppointment => 'Přidat termín';

  @override
  String get planChooserTitle => 'Termín, nebo připomínka?';

  @override
  String get planChooserAppointment =>
      'Termín — návštěva v den a hodinu, s poznámkami';

  @override
  String get planChooserReminder =>
      'Připomínka — hodnota, která je v určitý den na řadě';

  @override
  String get appointmentTitleLabel => 'Co';

  @override
  String get notesLabel => 'Poznámky';

  @override
  String get timeLabel => 'Čas';

  @override
  String get allDayLabel => 'Celý den';

  @override
  String get alertLabel => 'Upozornění';

  @override
  String get alertNone => 'Žádné';

  @override
  String get alertDayBefore => 'Den předem';

  @override
  String get alertHourBefore => 'Hodinu předem';

  @override
  String get linkFieldLabel => 'Po dokončení zapsat do pole';

  @override
  String get noLinkedField => 'Žádné pole';

  @override
  String get outcomeTitle => 'Jak to dopadlo?';

  @override
  String get finishLabel => 'Dokončit';

  @override
  String get editLabelAppointment => 'Upravit termín';

  @override
  String get deleteAppointment => 'Smazat termín';

  @override
  String get stepFlierText => 'Text letáku';

  @override
  String get qrFoundHint =>
      'Na letáku byl nalezen QR kód. Zaškrtnuté kódy se čtou kvůli číslům registru a odkazům.';

  @override
  String get useCode => 'Použít tento kód';

  @override
  String get qrNone => 'Na fotce nebyl nalezen žádný QR kód.';

  @override
  String qrFailed(String error) {
    return 'Čtení QR kódu selhalo: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Rozpoznán leták $name. Zkontrolujte níže, do kterého pole každý řádek patří.';
  }

  @override
  String get flierLayoutUnknown =>
      'Neznámé rozvržení letáku. Přiřaďte řádky polím níže; zbytek zůstane v poznámkách.';

  @override
  String get targetRegistryNumber => 'Číslo registru';

  @override
  String get targetLostPlace => 'Adresa (místo ztráty)';

  @override
  String get targetContact => 'Kontakt registru';

  @override
  String get targetDrop => 'Zahodit';

  @override
  String get abortScanTitle => 'Přerušit snímání?';

  @override
  String get abortScanBody => 'Nic se neuloží.';

  @override
  String get abortScan => 'Přerušit';

  @override
  String get keepScanning => 'Pokračovat';

  @override
  String get catsOnAppointment => 'Kočky na této schůzce';

  @override
  String get noCatsHint =>
      'Žádná kočka nezaškrtnuta — schůzka patří samotné kolonii.';

  @override
  String get pickCatsTitle => 'Které kočky jedou s sebou?';

  @override
  String catsCount(int count) {
    return '$count koček';
  }

  @override
  String get finishUntickHint =>
      'Odškrtněte kočky, které nebyly ošetřeny; zůstanou naplánované.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Smazat schůzku pro všech $count koček';
  }
}
