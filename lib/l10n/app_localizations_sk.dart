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
  String get noClowdersYet => 'Zatiaľ žiadne clowdery.\nVytvorte prvý nižšie.';

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
      'Mačka zmizne zo všetkých zoznamov. Jej fotky sa nenávratne vymažú.';

  @override
  String get sightingRecorded => 'Pozorovanie zaznamenané na vašej pozícii.';

  @override
  String get noLocationAvailable =>
      'Poloha nie je k dispozícii — namiesto toho podržte prst na mape.';

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
  String get renameField => 'Premenovať pole';

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
  String get orPlaceClowderHere => 'Alebo sem umiestniť clowder:';

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
}
