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
  String get noClowdersYet => 'Zatím žádné clowdery.\nVytvořte první níže.';

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
      'Kočka zmizí ze všech seznamů. Její fotky se nenávratně smažou.';

  @override
  String get sightingRecorded => 'Pozorování zaznamenáno na vaší pozici.';

  @override
  String get noLocationAvailable =>
      'Poloha není k dispozici — místo toho podržte prst na mapě.';

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
  String get renameField => 'Přejmenovat pole';

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
      'Synchronizace přes složku, kterou mezi zařízeními přenáší cloud nebo flashka — pro ty, kdo nejsou na stejné síti.';

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
  String get orPlaceClowderHere => 'Nebo sem umístit clowder:';

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
  String get starterPosition => 'Pozice';

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
      'Soukromé kočky, skupiny a pole se sdílejí také — zapínejte jen při synchronizaci vlastních zařízení.';

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
  String get starterStatus => 'Stav';

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
      'Pošli vše jako jeden soubor libovolným messengerem';

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
  String get introTitle1 => 'Kočky bydlí v clowderech';

  @override
  String get introBody1 =>
      'Clowder je místo, kde kočky žijí: tvoje dočasná péče, byt osvojitele, stodola odvedle. Každá kočka má kartu s fotkou, fakty a celým příběhem.';

  @override
  String get introTitle2 => 'Všechno zůstává u tebe';

  @override
  String get introBody2 =>
      'Žádný účet, žádný cloud, žádné sledování. Tvá data žijí na tvém zařízení.';

  @override
  String get introTitle3 => 'Sdílej s pomocníky';

  @override
  String get introBody3 =>
      'Naskenuj kód a dvě zařízení se sesynchronizují během vteřin, použij sdílenou složku nebo pošli vše jako jeden soubor.';

  @override
  String get introSkip => 'Přeskočit';

  @override
  String get introNext => 'Dále';

  @override
  String get introDone => 'Jdeme na to';

  @override
  String get introReplayTitle => 'Rychlý úvod';
}
