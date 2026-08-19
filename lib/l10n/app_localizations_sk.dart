// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Vitajte v cat(a)log';

  @override
  String get welcomeBody =>
      'Zvoľte si meno. Každá zmena sa ukladá pod týmto menom, aby ostatní videli, kto čo urobil.';

  @override
  String get yourName => 'Vaše meno';

  @override
  String get start => 'Začať';

  @override
  String get clowders => 'Clowdery';

  @override
  String get noClowdersYet =>
      'Zatiaľ žiadne clowdery. Clowder je miesto, kde mačky žijú — tvoja dočasná starostlivosť, byt osvojiteľa. Založ prvý nižšie.';

  @override
  String get strays => 'Túlavé mačky';

  @override
  String get searchCats => 'Hľadať mačky';

  @override
  String get map => 'Mapa';

  @override
  String get sync => 'Synchronizácia';

  @override
  String get fields => 'Polia';

  @override
  String get exportCsv => 'Exportovať CSV';

  @override
  String get aboutAndFeedback => 'O aplikácii a spätná väzba';

  @override
  String get newClowder => 'Nový clowder';

  @override
  String get name => 'Meno';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get create => 'Vytvoriť';

  @override
  String get save => 'Uložiť';

  @override
  String get delete => 'Vymazať';

  @override
  String get merge => 'Zlúčiť';

  @override
  String get resolve => 'Rozhodnúť';

  @override
  String get open => 'Otvoriť';

  @override
  String csvSavedTo(String path) {
    return 'CSV uložené do $path';
  }

  @override
  String get renameClowder => 'Premenovať clowder';

  @override
  String get rename => 'Premenovať';

  @override
  String get timeline => 'História';

  @override
  String get mergeInto => 'Zlúčiť s…';

  @override
  String get deleteClowder => 'Vymazať clowder';

  @override
  String get cats => 'Mačky';

  @override
  String get addCat => 'Pridať mačku';

  @override
  String get newCat => 'Nová mačka';

  @override
  String deleteQuestion(String name) {
    return 'Vymazať $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder zmizne zo zoznamu.';

  @override
  String deleteClowderBody(int count) {
    return 'Jeho mačky ($count) sa nevymažú — stanú sa túlavými. Ak to nechcete, najprv ich presuňte do iného clowderu.';
  }

  @override
  String get card => 'Karta';

  @override
  String get shareAsImage => 'Zdieľať ako obrázok';

  @override
  String get shareAsPdf => 'Zdieľať ako PDF';

  @override
  String get print => 'Tlačiť';

  @override
  String cardTitle(String name) {
    return 'Karta — $name';
  }

  @override
  String get renameCat => 'Premenovať mačku';

  @override
  String get seenHereNow => 'Práve videná tu';

  @override
  String get deleteCat => 'Vymazať mačku';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Túlavá — bez clowderu';

  @override
  String get stray => 'Túlavá';

  @override
  String get photos => 'Fotky';

  @override
  String get addPhoto => 'Pridať fotku';

  @override
  String get setAsProfileImage => 'Nastaviť ako profilovú';

  @override
  String get thisIsProfileImage => 'Toto je profilová fotka';

  @override
  String get deletePhoto => 'Vymazať fotku';

  @override
  String get deletePhotoTitle => 'Vymazať fotku?';

  @override
  String get deletePhotoBody =>
      'Dáta fotky sa nenávratne vymažú — nedá sa to vrátiť.';

  @override
  String get deleteCatBody =>
      'Mačka zmizne zo všetkých zoznamov a jej fotky sa odstránia — tu a po ďalšej synchronizácii aj u tvojich pomocníkov.';

  @override
  String get sightingRecorded => 'Pozorovanie zaznamenané na vašej pozícii.';

  @override
  String get noLocationAvailable =>
      'Poloha nie je k dispozícii — namiesto toho podržte prst na mape.';

  @override
  String get locationDeniedForever =>
      'Prístup k polohe je zablokovaný. Povoľte ho v nastaveniach systému, aby ste mohli používať Stray Cam.';

  @override
  String get locationServiceOff =>
      'Poloha je na tomto zariadení vypnutá. Zapnite ju v nastaveniach a skúste to znova.';

  @override
  String get locationDenied =>
      'cat(a)log nemá povolenie používať vašu polohu. Skúste to znova a povoľte ju, keď sa zobrazí otázka.';

  @override
  String get locationNoFix =>
      'Vašu polohu sa teraz nepodarilo zistiť. Skúste to znova vonku — GPS potrebuje voľný výhľad na oblohu.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Číslo čipu';

  @override
  String get starterRemarks => 'Poznámky';

  @override
  String get captureFlier => 'Odfotiť leták';

  @override
  String get matchCandidatesTitle => 'Možné zhody';

  @override
  String get noMatchCandidates => 'Momentálne žiadne možné zhody.';

  @override
  String sameIdField(String field) {
    return 'Rovnaké $field';
  }

  @override
  String metersApart(String distance) {
    return 'Vzdialené $distance m';
  }

  @override
  String get addFlier => 'Pridať leták';

  @override
  String get missingSinceLabel => 'Nezvestný od';

  @override
  String get phoneLabel => 'Telefón';

  @override
  String get cropPortrait => 'Orezať portrét';

  @override
  String get statusOwner => 'Majiteľ';

  @override
  String get ocrUnavailable =>
      'Rozpoznávanie textu nie je na tomto zariadení dostupné — napíšte text letáka ručne.';

  @override
  String get displayFormat => 'Zobraziť ako';

  @override
  String get displayPlain => 'Obyčajný text';

  @override
  String get displayQr => 'QR kód';

  @override
  String get displayBarcode => 'Čiarový kód';

  @override
  String get editLabel => 'Upraviť';

  @override
  String get doneLabel => 'Hotovo';

  @override
  String get openSettings => 'Otvoriť nastavenia';

  @override
  String get notSaved => 'Neuložené';

  @override
  String get birthdateInFuture => 'Dátum narodenia nemôže byť v budúcnosti.';

  @override
  String get deceasedInFuture => 'Dátum úmrtia nemôže byť v budúcnosti.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Dátum úmrtia nemôže byť pred dátumom narodenia ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Dátum narodenia nemôže byť po dátume úmrtia ($date).';
  }

  @override
  String get malePregnant =>
      'Táto mačka je vedená ako kocúr — kocúr nemôže byť gravidný. Najprv skontrolujte pohlavie.';

  @override
  String get moveTo => 'Presunúť do';

  @override
  String get noClowderStrayOption => 'Bez clowderu — túlavá / ušla';

  @override
  String timelineOf(String name) {
    return 'História — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Vrátiť túto zmenu';

  @override
  String get revertSubtitle =>
      'Obnoví predchádzajúcu hodnotu ako nový záznam — história zachová oboje.';

  @override
  String fieldCleared(String field) {
    return '$field vyprázdnené';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field späť na \"$value\"';
  }

  @override
  String get leftStray => 'Odišla — túlavá';

  @override
  String movedTo(String name) {
    return 'Presunutá do $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat prišla';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat prišla z $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat odišla do $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicitný záznam zlúčený';

  @override
  String get asOfToday => 'K dnešnému dňu';

  @override
  String asOfDate(String date) {
    return 'Ku dňu $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Nesprávny formát — použite $format';
  }

  @override
  String get value => 'Hodnota';

  @override
  String get latitudeLongitude => 'zemepisná šírka, dĺžka';

  @override
  String get newField => 'Nové pole';

  @override
  String get fieldType => 'Typ';

  @override
  String get usedOn => 'Použité pre';

  @override
  String get forCats => 'mačky';

  @override
  String get forClowders => 'clowdery';

  @override
  String get forBoth => 'oboje';

  @override
  String get optionsOnePerLine => 'Možnosti (jedna na riadok)';

  @override
  String get ownValue => 'Vlastná hodnota';

  @override
  String get renameField => 'Premenovať pole';

  @override
  String get editOptions => 'Upraviť možnosti…';

  @override
  String get noStraysRightNow => 'Momentálne žiadne túlavé mačky.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Pridať túlavú';

  @override
  String get newStray => 'Nová túlavá';

  @override
  String get searchByNameHint => 'Hľadať mačky podľa mena…';

  @override
  String get host => 'Hostiť';

  @override
  String get hostExplainer =>
      'Začnite tu a potom na druhom zariadení zadajte adresu a PIN.';

  @override
  String get startHosting => 'Spustiť hostenie';

  @override
  String get stopHosting => 'Zastaviť hostenie';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Doterajšie relácie: $count';
  }

  @override
  String get join => 'Pripojiť sa';

  @override
  String get addressFromHost => 'Adresa (z hostiteľského zariadenia)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synchronizovať teraz';

  @override
  String get addressFormatHint => 'Adresa musí vyzerať ako 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synchronizované: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synchronizácia zlyhala: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Posledná synchronizácia s $peer: $time';
  }

  @override
  String get sharedFolder => 'Zdieľaný priečinok';

  @override
  String get sharedFolderExplainer =>
      'Synchronizujte cez priečinok, ktorý medzi zariadeniami prenáša cloud alebo USB kľúč — pre tých, čo nie sú v rovnakej sieti.';

  @override
  String get noFolderChosenYet => 'Zatiaľ nie je vybraný priečinok';

  @override
  String get choose => 'Vybrať…';

  @override
  String get syncFolderNow => 'Synchronizovať priečinok teraz';

  @override
  String folderSynced(String result) {
    return 'Priečinok synchronizovaný: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Synchronizácia priečinka zlyhala: $error';
  }

  @override
  String get recordSightingHere => 'Zaznamenať pozorovanie tu:';

  @override
  String trailOf(String name, int count) {
    return 'Trasa: $name ($count pozorovaní)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'Zmenené na dvoch miestach naraz. Vyberte, čo platí:';

  @override
  String mergeThisInto(String kind) {
    return 'Zlúčiť tento záznam ($kind) s…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Žiadny iný záznam ($kind) na zlúčenie.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Zlúčiť s $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Z dvoch záznamov bude jeden. $name si ponechá aktuálne hodnoty; história druhého sa pripojí. Nedá sa to vrátiť.';
  }

  @override
  String get kindCat => 'mačka';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'pole';

  @override
  String get takePhoto => 'Odfotiť';

  @override
  String get chooseFromGallery => 'Vybrať z galérie';

  @override
  String get about => 'O aplikácii';

  @override
  String get aboutTagline =>
      'Lokálny katalóg mačiek v dočasnej starostlivosti. Vaše dáta zostávajú na vašich zariadeniach — žiadny server, žiadny účet.';

  @override
  String versionLabel(String version, String build) {
    return 'Verzia $version ($build)';
  }

  @override
  String get sourceCode => 'Zdrojový kód';

  @override
  String get reportProblemOrIdea => 'Nahlásiť problém alebo nápad';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Napísať vývojárovi';

  @override
  String get buyCoffee => 'Kúpiť vývojárovi kávu';

  @override
  String get coffeeSubtitle => 'Úplne dobrovoľné — aplikácia je zadarmo';

  @override
  String get openSourceLicenses => 'Open source licencie';

  @override
  String get machineTranslated =>
      'Preklady sú strojové — opravy vítané na GitHube.';

  @override
  String get unnamed => '(bez mena)';

  @override
  String get labelName => 'Meno';

  @override
  String get labelProfileImage => 'Profilová fotka';

  @override
  String get labelPhoto => 'Fotka';

  @override
  String get starterGender => 'Pohlavie';

  @override
  String get starterBreed => 'Plemeno';

  @override
  String get valueMixed => 'kríženec';

  @override
  String get breedEuropeanShorthair => 'Európska krátkosrstá';

  @override
  String get breedMaineCoon => 'Mainská mývalia';

  @override
  String get breedBritishShorthair => 'Britská krátkosrstá';

  @override
  String get breedNorwegianForestCat => 'Nórska lesná';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamská';

  @override
  String get breedPersian => 'Perzská';

  @override
  String get breedBengal => 'Bengálska';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get starterColor => 'Farba';

  @override
  String get starterNeutered => 'Kastrovaná';

  @override
  String get starterPregnant => 'Gravidná';

  @override
  String get starterBirthdate => 'Dátum narodenia';

  @override
  String get starterDeceased => 'Uhynula';

  @override
  String get starterAddress => 'Adresa';

  @override
  String get starterResponsible => 'Zodpovedná osoba';

  @override
  String get starterPosition => 'Pozícia';

  @override
  String get valueYes => 'áno';

  @override
  String get valueNo => 'nie';

  @override
  String get valueFemale => 'mačka';

  @override
  String get valueMale => 'kocúr';

  @override
  String get valueUnknown => 'neznáme';

  @override
  String get cropTitle => 'Orezať fotku';

  @override
  String get markTitle => 'Označiť mačku';

  @override
  String get applyCrop => 'Orezať';

  @override
  String get useFullPhoto => 'Použiť celú fotku';

  @override
  String get dragToSelect => 'Ťahom nakreslite obdĺžnik okolo mačky';

  @override
  String get dragOverTheCat => 'Ťahom nakreslite elipsu cez mačku';

  @override
  String get cropPhoto => 'Orezať…';

  @override
  String get markPhoto => 'Označiť…';

  @override
  String get scanCode => 'Naskenovať kód';

  @override
  String get orTypeCode => 'Alebo kód napíšte';

  @override
  String get copyCode => 'Kopírovať kód';

  @override
  String get copied => 'Skopírované';

  @override
  String get invalidCode => 'Tento kód nie je platný';

  @override
  String get hotspotHint =>
      'Žiadna spoločná Wi-Fi? Zapnite hotspot na jednom telefóne, druhý pripojte a hostite tu.';

  @override
  String get byMessenger => 'Cez messenger';

  @override
  String get byMessengerExplainer =>
      'Pošlite celý katalóg ako jeden súbor cez WhatsApp, Signal alebo mail — druhá strana ho importuje.';

  @override
  String get shareBundle => 'Zdieľať synchronizačný balík…';

  @override
  String get importBundle => 'Importovať synchronizačný balík…';

  @override
  String bundleImported(String result) {
    return 'Balík importovaný: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Posledná automatická záloha zlyhala: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import zlyhal: $error';
  }

  @override
  String get pickOnMap => 'Vybrať na mape';

  @override
  String get useMyLocation => 'Použiť moju polohu';

  @override
  String get language => 'Jazyk';

  @override
  String get systemDefault => 'Predvolený systém';

  @override
  String get iosLocalNetworkHint =>
      'Ak to na iPhone/iPade ďalej zlyháva: Nastavenia → Súkromie a bezpečnosť → Lokálna sieť → povoliť cat(a)log a skúsiť znova.';

  @override
  String get markPrivate => 'Označiť ako súkromné';

  @override
  String get unmarkPrivate => 'Odstrániť súkromné označenie';

  @override
  String get includePrivate => 'Zahrnúť súkromné údaje';

  @override
  String get includePrivateExplainer =>
      'Súkromné mačky, skupiny a polia sa zdieľajú tiež — zapínajte len pri synchronizácii vlastných zariadení.';

  @override
  String get hideLabel => 'Skryť na tomto zariadení';

  @override
  String get unhideLabel => 'Znova zobraziť';

  @override
  String get showHiddenLabel => 'Zobraziť skryté';

  @override
  String get stopShowingHidden => 'Prestať zobrazovať skryté';

  @override
  String get starterSpecies => 'Druh';

  @override
  String get starterStatus => 'Stav';

  @override
  String get statusFoster => 'Dočasná starostlivosť';

  @override
  String get statusForeverHome => 'Domov navždy';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Útulok';

  @override
  String get statusBarn => 'Stodola';

  @override
  String get valueCat => 'Mačka';

  @override
  String get otherOption => 'Iné…';

  @override
  String get celebrationsToggle => 'Oslavovať adopcie';

  @override
  String get celebrationsSubtitle =>
      'Konfety a jasot, keď sa mačka sťahuje do domova navždy';

  @override
  String get onMapLabel => 'Na mape';

  @override
  String get showOnMap => 'Zobraziť na mape';

  @override
  String get searchPlaceHint => 'Hľadať miesto alebo adresu';

  @override
  String get noPlacesFound => 'Žiadne miesta sa nenašli';

  @override
  String get mapSearchHint => 'Hľadať mačky, skupiny, osoby';

  @override
  String get proposeAnotherName => 'Navrhnúť iné meno';

  @override
  String get moderationTitle => 'Autori a zákazy';

  @override
  String get moderationSubtitle => 'Natrvalo odstrániť údaje osoby';

  @override
  String get authorsSection => 'Kto písal do katalógu';

  @override
  String get hardDeleteAction => 'Zmazať všetko od tohto autora';

  @override
  String hardDeleteWarning(Object name) {
    return 'Odstráni každý záznam a fotku od $name z tohto zariadenia. Ostatné zariadenia si svoje ponechajú. Nedá sa vrátiť.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Na potvrdenie napíšte $name';
  }

  @override
  String get alsoBan => 'Aj zakázať — už nikdy neprijímať údaje';

  @override
  String get bansSection => 'Zákazy';

  @override
  String get unbanAction => 'Zrušiť zákaz';

  @override
  String get deletedDone => 'Zmazané.';

  @override
  String get syncSummaryTitle => 'Čo prišlo';

  @override
  String get summaryAdopted => 'Adoptované';

  @override
  String get summaryDeceased => 'Uhynuté';

  @override
  String get summaryEscaped => 'Utečené';

  @override
  String get summaryNew => 'Nové';

  @override
  String get summaryConflicts => 'Konflikty na vyriešenie';

  @override
  String summaryOther(Object n) {
    return '…a $n ďalších zmien';
  }

  @override
  String get starterMother => 'Matka';

  @override
  String get starterFather => 'Otec';

  @override
  String get familySection => 'Rodina';

  @override
  String get littermatesLabel => 'Z jedného vrhu';

  @override
  String get siblingsLabel => 'Súrodenci';

  @override
  String get kittensLabel => 'Mačiatka';

  @override
  String get toastSettingsTitle => 'Čo oznamovať';

  @override
  String get toastSettingsSubtitle => 'Krátke správy po synchronizácii';

  @override
  String get toastKindAdoptions => 'Adopcie';

  @override
  String get toastKindBirths => 'Narodenia';

  @override
  String get toastKindDeaths => 'Úmrtia';

  @override
  String get toastKindEscapes => 'Úteky';

  @override
  String get toastKindMoves => 'Sťahovania';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptovaná do $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nové mačiatko: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat uhynula';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat utiekla';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat sa presťahovala do $home';
  }

  @override
  String get notACatlogFile => 'Toto nie je súbor cat(a)log';

  @override
  String get nothingNewInBundle => 'V súbore nič nové — všetko už máš';

  @override
  String get syncChooserInPerson => 'Osobne';

  @override
  String get syncChooserInPersonSub =>
      'Ste v jednej miestnosti — naskenuj kód, hotovo za pár sekúnd';

  @override
  String get syncChooserRemote => 'Na diaľku';

  @override
  String get syncChooserRemoteSub =>
      'Cez zdieľaný priečinok ako Dropbox alebo USB kľúč';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Pošli všetko ako jeden súbor ľubovoľným messengerom';

  @override
  String get connectToWifiFirst =>
      'Najprv sa pripoj k Wi-Fi — potom sa zariadenia nájdu';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) chce synchronizovať';
  }

  @override
  String get trustBothWaysNote => 'Katalógy sa vymenia oboma smermi.';

  @override
  String get allowOnce => 'Povoliť';

  @override
  String get allowAlways => 'Vždy povoliť toto zariadenie';

  @override
  String get declineAction => 'Odmietnuť';

  @override
  String get syncDeclined => 'Druhé zariadenie synchronizáciu odmietlo';

  @override
  String get trustedDevicesSection => 'Vždy povolené zariadenia';

  @override
  String get removeTrust => 'Odstrániť';

  @override
  String get hostWithoutWifi => 'Hostovať bez Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Vytvorí dočasné priame spojenie s druhým telefónom (bez internetu). Používa ho iba cat(a)log a po synchronizácii sa samo odpojí.';

  @override
  String get hotspotAndroidOnly =>
      'Tento kód vyžaduje dva telefóny s Androidom — na iPhone/iPade použi spoločnú Wi-Fi';

  @override
  String get selectClowderHint => 'Vyber clowder vľavo';

  @override
  String get introTitle1 => 'Mačky bývajú v clowderoch';

  @override
  String get introBody1 =>
      'Clowder je miesto, kde mačky žijú: tvoja dočasná starostlivosť, byt osvojiteľa, stodola vedľa. Každá mačka má kartu s fotkou, faktami a celým príbehom.';

  @override
  String get introTitle2 => 'Všetko zostáva u teba';

  @override
  String get introBody2 =>
      'Žiadny účet, žiadny cloud, žiadne sledovanie. Tvoje dáta žijú na tvojom zariadení.';

  @override
  String get introTitle3 => 'Zdieľaj s pomocníkmi';

  @override
  String get introBody3 =>
      'Naskenuj kód a dve zariadenia sa zosynchronizujú za sekundy, použi zdieľaný priečinok alebo pošli všetko ako jeden súbor.';

  @override
  String get introSkip => 'Preskočiť';

  @override
  String get introNext => 'Ďalej';

  @override
  String get introDone => 'Poďme na to';

  @override
  String get introReplayTitle => 'Rýchly úvod';

  @override
  String get spotHomeSync =>
      'Nové: synchronizácia teraz ponúka tri jasné cesty — a otázku dôvery, kým čokoľvek odtečie.';

  @override
  String get spotMapSearch =>
      'Nové: hľadaj tu mačky, clowdery a osoby — priamo na mape.';

  @override
  String get spotCardChips => 'Nové: pred zdieľaním vyber, čo bude na karte.';

  @override
  String get spotCatMenu =>
      'Nové: označ mačku ako súkromnú (nikdy neopustí zariadenie) alebo ju tu skry.';

  @override
  String get spotDone => 'Rozumiem';

  @override
  String get spotReplayTitle => 'Prehliadka noviniek';

  @override
  String get spotReplaySubtitle => 'Znova ukázať tipy na každej stránke';

  @override
  String get spotReplayDone => 'Tipy sa zobrazia znova';

  @override
  String get searchNoResults => 'Mačka s týmto menom sa nenašla';

  @override
  String get syncUnreachable =>
      'Druhé zariadenie je nedostupné. Sú obe na rovnakej Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Priečinok je nedostupný. Existuje ešte disk alebo cloudový priečinok?';

  @override
  String get crashTitle => 'Toto sa nemalo stať';

  @override
  String get crashBody =>
      'cat(a)log narazil na nečakanú chybu. Tvoje dáta sú v bezpečí — všetko sa ukladá hneď pri zmene. Reštartuj aplikáciu, a ak sa to opakuje, pošli hlásenie, aby sa to dalo opraviť.';

  @override
  String get crashRestart => 'Reštartovať aplikáciu';

  @override
  String get crashSendReport => 'Poslať hlásenie vývojárovi';

  @override
  String get crashLastRunBody =>
      'cat(a)log sa minule nečakane ukončil — najskôr došla pamäť. Poslať krátke hlásenie, aby sa to dalo opraviť?';
}
