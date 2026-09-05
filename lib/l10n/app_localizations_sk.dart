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
  String get clowdersNeutral => 'Domácnosti';

  @override
  String get noClowdersYet =>
      'Zatiaľ žiadne clowdery. Clowder je miesto, kde mačky žijú — tvoja dočasná starostlivosť, byt osvojiteľa. Založ prvý nižšie.';

  @override
  String get noClowdersYetNeutral =>
      'Zatiaľ žiadne domácnosti. Domácnosť je miesto, kde miláčikovia žijú — tvoj domov, dočasná starostlivosť, byt osvojiteľa. Založ prvú nižšie.';

  @override
  String get strays => 'Túlavé mačky';

  @override
  String get searchCats => 'Hľadať mačky';

  @override
  String get searchCatsNeutral => 'Hľadať miláčikov';

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
  String get newClowderNeutral => 'Nová domácnosť';

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
  String get renameClowderNeutral => 'Premenovať domácnosť';

  @override
  String get rename => 'Premenovať';

  @override
  String get timeline => 'História';

  @override
  String get mergeInto => 'Zlúčiť s…';

  @override
  String get deleteClowder => 'Vymazať clowder';

  @override
  String get deleteClowderNeutral => 'Vymazať domácnosť';

  @override
  String get cats => 'Mačky';

  @override
  String get catsNeutral => 'Miláčikovia';

  @override
  String get addCat => 'Pridať mačku';

  @override
  String get addCatNeutral => 'Pridať miláčika';

  @override
  String get newCat => 'Nová mačka';

  @override
  String get newCatNeutral => 'Nový miláčik';

  @override
  String deleteQuestion(String name) {
    return 'Vymazať $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder zmizne zo zoznamu.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Domácnosť zmizne zo zoznamu.';

  @override
  String deleteClowderBody(int count) {
    return 'Jeho mačky ($count) sa nevymažú — stanú sa túlavými. Ak to nechcete, najprv ich presuňte do iného clowderu.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Jej miláčikovia ($count) sa nevymažú — stanú sa túlavými. Ak to nechcete, najprv ich presuňte do inej domácnosti.';
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
  String get renameCatNeutral => 'Premenovať miláčika';

  @override
  String get seenHereNow => 'Práve videná tu';

  @override
  String get deleteCat => 'Vymazať mačku';

  @override
  String get deleteCatNeutral => 'Vymazať miláčika';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get clowderLabelNeutral => 'Domácnosť';

  @override
  String get strayNoClowder => 'Túlavá — bez clowderu';

  @override
  String get strayNoClowderNeutral => 'Túlavý — bez domácnosti';

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
      'Mačka zmizne zo všetkých zoznamov a jej fotky sa odstránia — tu aj, po ďalšej synchronizácii, na ostatných zariadeniach.';

  @override
  String get deleteCatBodyNeutral =>
      'Miláčik zmizne zo všetkých zoznamov a jeho fotky sa odstránia — tu aj, po ďalšej synchronizácii, na ostatných zariadeniach.';

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
  String get addPhotosTo => 'Pridať fotky k…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotiek pridaných k $name';
  }

  @override
  String get scanPrintedCode => 'Naskenovať vytlačený kód';

  @override
  String get chipScanHint =>
      'Naskenuje vytlačený QR/čiarový kód z karty čipu alebo veterinárnych dokladov — čip v mačke telefón prečítať nedokáže.';

  @override
  String get chipScanHintNeutral =>
      'Naskenuje vytlačený QR/čiarový kód z karty čipu alebo veterinárnych dokladov — čip vo zvierati telefón prečítať nedokáže.';

  @override
  String get savingLabel => 'Ukladá sa…';

  @override
  String ownerOfCat(String name) {
    return 'Majiteľ mačky $name';
  }

  @override
  String get sortLabel => 'Zoradiť';

  @override
  String get viewAsTable => 'Zobraziť ako tabuľku';

  @override
  String get viewAsTiles => 'Zobraziť ako dlaždice';

  @override
  String get viewAsList => 'Zobraziť ako zoznam';

  @override
  String get ageLabel => 'Vek';

  @override
  String get catList => 'Zoznam mačiek';

  @override
  String get catListNeutral => 'Zoznam miláčikov';

  @override
  String get matchCandidatesTitle => 'Možné zhody';

  @override
  String get findDuplicates => 'Nájsť duplicity';

  @override
  String get noDuplicates => 'Momentálne žiadne možné duplicity.';

  @override
  String get similarName => 'Podobné meno';

  @override
  String get sharePublicly => 'Zdieľať verejne…';

  @override
  String get pickFramesTitle => 'Výber snímok';

  @override
  String get suggestedFrames => 'Navrhované snímky';

  @override
  String get scrubFrames => 'Pretáčanie videa';

  @override
  String get keepThisFrame => 'Ponechať túto snímku';

  @override
  String get fromVideo => 'Z videa…';

  @override
  String get videoMobileOnly =>
      'Výber snímok z videa funguje v mobilnej aplikácii (Android a iPhone) — na tomto zariadení zatiaľ nie.';

  @override
  String get shareWhitelistExplainer =>
      'Vyberte, čo pôjde do súboru. Zahrnú sa len zaškrtnuté polia.';

  @override
  String get exportShareFile => 'Exportovať súbor zdieľania…';

  @override
  String get hostedLink => 'Hostovaný odkaz (URL nahraného súboru)';

  @override
  String get inlineQr => 'Vložené QR (len text, bez fotiek)';

  @override
  String get inlineTooBig =>
      'Priveľa dát pre vložený kód — odškrtnite polia alebo použite hostovaný odkaz.';

  @override
  String get scanShareLabel => 'Naskenovať kód zdieľania';

  @override
  String get notAShareCode => 'Tento kód nie je zdieľanie cat(a)log.';

  @override
  String get importShareTitle => 'Importovať túto mačku?';

  @override
  String get importShareTitleNeutral => 'Importovať tohto miláčika?';

  @override
  String shareSource(String url) {
    return 'Zdroj: $url';
  }

  @override
  String get importLabel => 'Importovať';

  @override
  String get strayAreaLabel => 'Možná oblasť túlania';

  @override
  String get prevPin => 'Predchádzajúci špendlík';

  @override
  String get nextPin => 'Ďalší špendlík';

  @override
  String get noMissingCats =>
      'Zatiaľ žiadne nezvestné mačky s pozíciami letákov.';

  @override
  String get noMissingCatsNeutral =>
      'Zatiaľ žiadni nezvestní miláčikovia s pozíciami letákov.';

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
  String get malePregnantNeutral =>
      'Tento miláčik je vedený ako samec — samec nemôže byť gravidný. Najprv skontrolujte pohlavie.';

  @override
  String fatherNotMale(String name) {
    return '$name je vedená ako mačka (samica) a nemôže byť otcom. Najprv skontrolujte pohlavie.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name je vedený ako kocúr a nemôže byť matkou. Najprv skontrolujte pohlavie.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name sa narodil $date — rodič sa nemôže narodiť po svojom mačati.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name sa narodil $date — rodič sa nemôže narodiť po svojom mláďati.';
  }

  @override
  String get genderFatherFemale =>
      'Táto mačka je vedená ako otec iných mačiek — otec nemôže byť samica. Najprv skontrolujte rodinu.';

  @override
  String get genderFatherFemaleNeutral =>
      'Tento miláčik je vedený ako otec iných miláčikov — otec nemôže byť samica. Najprv skontrolujte rodinu.';

  @override
  String get genderMotherMale =>
      'Táto mačka je vedená ako matka iných mačiek — matka nemôže byť samec. Najprv skontrolujte rodinu.';

  @override
  String get genderMotherMaleNeutral =>
      'Tento miláčik je vedený ako matka iných miláčikov — matka nemôže byť samec. Najprv skontrolujte rodinu.';

  @override
  String get moveTo => 'Presunúť do';

  @override
  String get noClowderStrayOption => 'Bez clowderu — túlavá / ušla';

  @override
  String get noClowderStrayOptionNeutral => 'Bez domácnosti — túlavý / ušiel';

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
  String get dateInFuture => 'Tento dátum nemôže byť v budúcnosti.';

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
  String get forCatsNeutral => 'miláčikov';

  @override
  String get forClowders => 'clowdery';

  @override
  String get forClowdersNeutral => 'domácnosti';

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
  String get searchByNameHintNeutral => 'Hľadať miláčikov podľa mena…';

  @override
  String get host => 'Hostiť';

  @override
  String get hostExplainer =>
      'Začnite tu a potom na druhom zariadení naskenujte kód alebo ho zadajte.';

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
      'Obe zariadenia používajú rovnaký priečinok (napr. v Dropboxe alebo na USB kľúči). Každá synchronizácia tam uloží vaše zmeny a prevezme zmeny druhej strany.';

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
  String get kindCatNeutral => 'miláčik';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindClowderNeutral => 'domácnosť';

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
  String get aboutTaglineNeutral =>
      'Lokálny katalóg miláčikov, o ktorých sa staráte. Vaše dáta zostávajú na vašich zariadeniach — žiadny server, žiadny účet.';

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
  String get coffeeSubtitle =>
      'Aplikácia zostane zadarmo. Aj keď kávu nedostanem :)';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefón';

  @override
  String get lookupUrlLabel => 'Odkaz na vyhľadanie';

  @override
  String lookupUrlHelp(String token) {
    return 'Stránka služby s $token na mieste čísla, napr. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Vyhľadať';

  @override
  String lookupFailed(String url) {
    return 'Žiadna aplikácia nedokázala otvoriť $url. Skopírujte odkaz do prehliadača.';
  }

  @override
  String get stepCat => 'Mačka';

  @override
  String get stepCatNeutral => 'Miláčik';

  @override
  String get stepOwner => 'Majiteľ';

  @override
  String get stepFace => 'Fotka tváre';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Skontrolovať a uložiť';

  @override
  String get stepOwnerHint =>
      'Kto mačku postráda — z toho vznikne jeho clowder s kontaktom z letáka.';

  @override
  String get stepOwnerHintNeutral =>
      'Kto miláčika postráda — z toho vznikne jeho domácnosť s kontaktom z letáka.';

  @override
  String get stepFaceHint =>
      'Vystrihnite z letáka mačaciu tvár; stane sa profilovou fotkou. Môžete preskočiť.';

  @override
  String get stepFaceHintNeutral =>
      'Vystrihnite z letáka tvár miláčika; stane sa profilovou fotkou. Môžete preskočiť.';

  @override
  String get stepRegistryHint =>
      'Čísla nájdené na letáku. Zaškrtnuté sa uložia k mačke a dajú sa neskôr otvoriť.';

  @override
  String get stepRegistryHintNeutral =>
      'Čísla nájdené na letáku. Zaškrtnuté sa uložia k miláčikovi a dajú sa neskôr otvoriť.';

  @override
  String get noRegistryLinks =>
      'Na tomto letáku nie sú odkazy na registre — ak boli prehliadnuté, nahláste prosím chybu.';

  @override
  String get unknownServiceHint => 'Neznáma služba';

  @override
  String get rememberService => 'Zapamätať službu';

  @override
  String get rememberServiceHint =>
      'Pomenujte službu a ukážte na číslo v odkaze. Ďalší leták sa vyplní sám.';

  @override
  String get noIdInLink =>
      'Tento odkaz neobsahuje číslo, ktoré by aplikácia mohla uložiť.';

  @override
  String get whichNumber => 'Ktorá časť je číslo?';

  @override
  String get cropAgain => 'Orezať znova';

  @override
  String get noFaceYet =>
      'Zatiaľ žiadna fotka tváre — použije sa fotka letáka.';

  @override
  String get backLabel => 'Späť';

  @override
  String get dangerButton => 'NETLAČIŤ.\nNEBEZPEČENSTVO';

  @override
  String get dangerThanks => 'Ďakujeme, že používate cat(a)log!';

  @override
  String get helpTitle => 'Pomocník';

  @override
  String get showTipsAgain => 'Zobraziť tipy znova';

  @override
  String get helpHome =>
      'Prehľad tvojich kolónií — kolónia je miesto, kde žijú mačky: tvoj domov, dočasná opatera, útulok. Ťukni na kartu a uvidíš jej mačky; podržaním otvoríš menu. Tlačidlo vpravo dole vytvorí kolóniu a karta túlavých zbiera všetky mačky bez domova. Názov hore je katalóg, v ktorom si — klepnutím prepneš alebo pridáš ďalší.';

  @override
  String get helpHomeNeutral =>
      'Prehľad tvojich domácností — domácnosť je miesto, kde žijú miláčikovia: tvoj domov, dočasná opatera, útulok. Ťukni na kartu a uvidíš jej miláčikov; podržaním otvoríš menu. Tlačidlo vpravo dole vytvorí domácnosť a karta túlavých zbiera všetkých miláčikov bez domova. Názov hore je katalóg, v ktorom si — klepnutím prepneš alebo pridáš ďalší.';

  @override
  String get helpClowder =>
      'Všetko o tomto mieste: jeho mačky, polia (adresa, kontakt, typ) a história. Stránka sa otvorí len na čítanie; ceruzka zapne úpravy, kde môžeš pridať aj nové pole. Podržanie poľa ho upraví hneď, podržanie mačky ju presunie, skryje alebo otvorí. Stretnutie pridané tu môže vziať viac mačiek kolónie, napríklad kastračný výjazd: zaškrtnite mačky, ktoré idú, dokončite raz, odškrtnite tie, ktoré neboli ošetrené.';

  @override
  String get helpClowderNeutral =>
      'Všetko o tomto mieste: jeho miláčikovia, polia (adresa, kontakt, typ) a história. Stránka sa otvorí len na čítanie; ceruzka zapne úpravy, kde môžeš pridať aj nové pole. Podržanie poľa ho upraví hneď, podržanie miláčika ho presunie, skryje alebo otvorí. Stretnutie pridané tu môže vziať viac miláčikov domácnosti, napríklad kastračný výjazd: zaškrtnite miláčikov, ktorí idú, dokončite raz, odškrtnite tých, ktorí neboli ošetrení.';

  @override
  String get helpCat =>
      'Všetko o tejto mačke: fotky, polia, rodina, história. Stránka je len na čítanie, kým neklepneš na ceruzku. Dlho podrž pole a hneď ho upravíš; dlho podrž fotku pre jej menu. Menu vpravo hore drží zvyšok: skryť, zlúčiť, zaznamenať spozorovanie, zdieľať mačku. „Súkromné“ sa nastavuje pri úprave poľa.';

  @override
  String get helpCatNeutral =>
      'Všetko o tomto miláčikovi: fotky, polia, rodina, história. Stránka je len na čítanie, kým neklepneš na ceruzku. Dlho podrž pole a hneď ho upravíš; dlho podrž fotku pre jej menu. Menu vpravo hore drží zvyšok: skryť, zlúčiť, zaznamenať spozorovanie, zdieľať miláčika. „Súkromné“ sa nastavuje pri úprave poľa.';

  @override
  String get helpStrays =>
      'Mačky, ktoré teraz nemajú domov: nájdené, ušlé alebo z letáka. Tlačidlo fotoaparátu zapíše mačku pred tebou; tlačidlo letáka premení plagát na mačku aj s kontaktom majiteľa; skener prečíta kód cat(a)log z plagátu. Ťuknutím na Stray Cam urobíš fotku; podržaním natočíš video a najlepšie snímky si necháš ako fotky.';

  @override
  String get helpStraysNeutral =>
      'Miláčikovia, ktorí teraz nemajú domov: nájdení, ušlí alebo z letáka. Tlačidlo fotoaparátu zapíše zviera pred tebou; tlačidlo letáka premení plagát na miláčika aj s kontaktom majiteľa; skener prečíta kód cat(a)log z plagátu. Ťuknutím na Stray Cam urobíš fotku; podržaním natočíš video a najlepšie snímky si necháš ako fotky.';

  @override
  String get helpMap =>
      'Všetky mačky a miesta s pozíciou. Hľadanie nájde mačky, ľudí aj miesta — neznáme meno hľadá po celom svete. Tlačidlo vrstiev nakreslí kruhy 500 m okolo miest letákov nezvestnej mačky a okolo domova, z ktorého ušla. Šípky idú od špendlíka k špendlíku, podržanie mapy zapíše pozorovanie.';

  @override
  String get helpMapNeutral =>
      'Všetci miláčikovia a miesta s pozíciou. Hľadanie nájde miláčikov, ľudí aj miesta — neznáme meno hľadá po celom svete. Tlačidlo vrstiev nakreslí kruhy 500 m okolo miest letákov nezvestného miláčika a okolo domova, z ktorého ušiel. Šípky idú od špendlíka k špendlíku, podržanie mapy zapíše pozorovanie.';

  @override
  String get helpCard =>
      'Tlačiteľná karta mačky: hore čipmi vyberieš, čo na nej bude, potom ju zdieľaš ako obrázok alebo PDF. Čísla sa dajú vytlačiť ako QR alebo čiarový kód a z pozície vznikne QR otvárajúci mapu plus krátky Plus Code.';

  @override
  String get helpCardNeutral =>
      'Tlačiteľná karta miláčika: hore čipmi vyberieš, čo na nej bude, potom ju zdieľaš ako obrázok alebo PDF. Čísla sa dajú vytlačiť ako QR alebo čiarový kód a z pozície vznikne QR otvárajúci mapu plus krátky Plus Code.';

  @override
  String get helpSync =>
      'Ako sa údaje dostanú k ďalším ľuďom: spojiť sa osobne, použiť priečinok, ktorý vidia obe zariadenia, alebo poslať súbor cez messenger. Vždy rozhoduješ ty, čo odíde — a prijaté súbory .catsync otvoríš tiež tu.';

  @override
  String get helpFields =>
      'Polia, ktoré tvoj katalóg používa. Premenuj ich, zmeň možnosti výberového poľa alebo pridaj vlastné. Pole s identifikátorom môže ukazovať na službu (register), potom sa dá číslo pri mačke ťuknúť.';

  @override
  String get helpFieldsNeutral =>
      'Polia, ktoré tvoj katalóg používa. Premenuj ich, zmeň možnosti výberového poľa alebo pridaj vlastné. Pole s identifikátorom môže ukazovať na službu (register), potom sa dá číslo pri miláčikovi ťuknúť.';

  @override
  String get helpTimeline =>
      'Každá kedy vykonaná zmena, najnovšia hore: kto čo kedy a na akú hodnotu zmenil. Každý záznam sa dá vrátiť — vznikne tým nový záznam, nič sa nikdy nemaže.';

  @override
  String get helpDuplicates =>
      'Mačky alebo kolónie, ktoré vyzerajú, že existujú dvakrát — rovnaké čísla alebo veľmi podobné mená so zhodnými detailmi. Ťukni na dvojicu a zlúč ju; zlúčenie sa nedá vrátiť, preto sa najprv pýta.';

  @override
  String get helpDuplicatesNeutral =>
      'Miláčikovia alebo domácnosti, ktoré vyzerajú, že existujú dvakrát — rovnaké čísla alebo veľmi podobné mená so zhodnými detailmi. Ťukni na dvojicu a zlúč ju; zlúčenie sa nedá vrátiť, preto sa najprv pýta.';

  @override
  String get helpMatches =>
      'Mačky, ktoré môžu byť to isté zviera: rovnaké číslo alebo túlavá mačka videná v oblasti hľadania nezvestnej mačky. Ťuknutím dvojicu zlúčiš, podržaním otvoríš prvú mačku na porovnanie.';

  @override
  String get helpMatchesNeutral =>
      'Miláčikovia, ktorí môžu byť to isté zviera: rovnaké číslo alebo túlavé zviera videné v oblasti hľadania nezvestného miláčika. Ťuknutím dvojicu zlúčiš, podržaním otvoríš prvého miláčika na porovnanie.';

  @override
  String get helpFlier =>
      'Z odfoteného letáka vznikne mačka aj majiteľ. Krok za krokom: údaje mačky, kontakt majiteľa, výrez tváre pre profilovku, čísla registrov z letáka a nakoniec kontrola. Všetko sú návrhy — oprav, čo fotoaparát prečítal zle.';

  @override
  String get helpFlierNeutral =>
      'Z odfoteného letáka vznikne miláčik aj majiteľ. Krok za krokom: údaje miláčika, kontakt majiteľa, výrez tváre pre profilovku, čísla registrov z letáka a nakoniec kontrola. Všetko sú návrhy — oprav, čo fotoaparát prečítal zle.';

  @override
  String get archiveTitle => 'Archív';

  @override
  String get archiveExplainer =>
      'Uhynuté mačky a prázdne kolónie, ktorých sa roky nikto nedotkol, stále zaberajú miesto — najmä ich fotky. Archivácia ich zapíše do súboru, ktorý si necháš, a potom ich odtiaľto zmaže.';

  @override
  String get archiveExplainerNeutral =>
      'Uhynutí miláčikovia a prázdne domácnosti, ktorých sa roky nikto nedotkol, stále zaberajú miesto — najmä ich fotky. Archivácia ich zapíše do súboru, ktorý si necháš, a potom ich odtiaľto zmaže.';

  @override
  String get archiveAction => 'Archivovať';

  @override
  String archiveSelected(int count) {
    return 'Archivovať $count položiek';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archivovať $count položiek?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names sa zapíšu do súboru a potom zmažú — na tvojom zariadení aj na každom, s ktorým synchronizuješ. Import súboru všetko vráti; bez neho sú preč.';
  }

  @override
  String archiveDone(int count) {
    return 'Archivovaných a zmazaných $count položiek';
  }

  @override
  String archiveFailed(String error) {
    return 'Nič sa nezmazalo: súbor archívu sa nepodarilo zapísať ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Databáza $db, fotky $photos v $count súboroch';
  }

  @override
  String quietForYears(int years) {
    return 'Bez zmeny $years rokov';
  }

  @override
  String get nothingToArchive => 'Nič nie je dosť staré na archiváciu.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Posledná zmena $date · fotky $size';
  }

  @override
  String get helpArchive =>
      'Staré dáta stoja miesto, najmä fotky, ktoré si nesie každé synchronizované zariadenie. Tu vyberieš uhynuté mačky a prázdne kolónie, ktoré sú roky bez zmeny, zapíšeš ich do súboru, ktorý si necháš, a zmažeš ich. Zmazanie dorazí ku všetkým, s ktorými synchronizuješ; import súboru všetko obnoví.';

  @override
  String get helpArchiveNeutral =>
      'Staré dáta stoja miesto, najmä fotky, ktoré si nesie každé synchronizované zariadenie. Tu vyberieš uhynutých miláčikov a prázdne domácnosti, ktoré sú roky bez zmeny, zapíšeš ich do súboru, ktorý si necháš, a zmažeš ich. Zmazanie dorazí ku všetkým, s ktorými synchronizuješ; import súboru všetko obnoví.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Obnoviť $count zmazaných položiek?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names sú v tomto katalógu zmazané a práve importovaný súbor ich obsahuje. Obnovenie ich vráti sem aj na každé zariadenie, s ktorým synchronizuješ.';
  }

  @override
  String get restoreAction => 'Obnoviť';

  @override
  String get keepDeleted => 'Nechať zmazané';

  @override
  String get archiveNotSaved => 'Nič sa nezmazalo: archív sa nikam neuložil.';

  @override
  String get locateAddress => 'Nájsť adresu na mape';

  @override
  String get addressFoundTitle => 'Adresa nájdená';

  @override
  String get replaceAddressOption => 'Nahradiť adresu touto';

  @override
  String get addPositionOption => 'Uložiť polohu';

  @override
  String get addressLocated => 'Adresa nájdená';

  @override
  String get addressNotFound =>
      'Pre túto adresu sa nenašlo miesto. Skontrolujte pravopis alebo pole nechajte prázdne.';

  @override
  String get starterPosition => 'Poloha';

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
  String get markTitleNeutral => 'Označiť miláčika';

  @override
  String get applyCrop => 'Orezať';

  @override
  String get useFullPhoto => 'Použiť celú fotku';

  @override
  String get dragToSelect => 'Ťahom nakreslite obdĺžnik okolo mačky';

  @override
  String get dragToSelectNeutral => 'Ťahom nakreslite obdĺžnik okolo miláčika';

  @override
  String get dragOverTheCat => 'Ťahom nakreslite elipsu cez mačku';

  @override
  String get dragOverTheCatNeutral => 'Ťahom nakreslite elipsu cez miláčika';

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
  String get typeUnitValue => 'Hodnota s jednotkou';

  @override
  String get dimension => 'Veličina';

  @override
  String get dimensionWeight => 'Hmotnosť';

  @override
  String get dimensionLength => 'Dĺžka';

  @override
  String get dimensionVolume => 'Objem';

  @override
  String get dimensionTemperature => 'Teplota';

  @override
  String get unitsLabel => 'Jednotky';

  @override
  String get catalogHolds => 'Tento katalóg obsahuje';

  @override
  String get modeCats => 'Mačky';

  @override
  String get modePets => 'Zvieratá';

  @override
  String get graphLabel => 'Graf';

  @override
  String get rangeWeek => 'Týždeň';

  @override
  String get rangeMonth => 'Mesiac';

  @override
  String get rangeYear => 'Rok';

  @override
  String get rangeAll => 'Všetko';

  @override
  String get rangeCustom => 'Vlastný…';

  @override
  String changeSince(String delta, String date) {
    return '$delta od $date';
  }

  @override
  String get unitsAuto => 'Podľa tvojej oblasti';

  @override
  String get unitsMetric => 'Metrické (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperiálne (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Hmotnosť';

  @override
  String get systemDefault => 'Predvolený systém';

  @override
  String get iosLocalNetworkHint =>
      'Ak to na iPhone/iPade ďalej zlyháva: Nastavenia → Súkromie a bezpečnosť → Lokálna sieť → povoliť cat(a)log a skúsiť znova.';

  @override
  String get includePrivate => 'Zdieľať súkromné údaje';

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
  String get starterStatus => 'Typ';

  @override
  String get statusFoster => 'Dočasná starostlivosť';

  @override
  String get statusForeverHome => 'Domov';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Útulok';

  @override
  String get statusBarn => 'Stodola';

  @override
  String get valueCat => 'Mačka';

  @override
  String get valueDog => 'Pes';

  @override
  String get valueRabbit => 'Králik';

  @override
  String get valueGuineaPig => 'Morča';

  @override
  String get valueHamster => 'Škrečok';

  @override
  String get valueBird => 'Vták';

  @override
  String get valueHorse => 'Kôň';

  @override
  String get valueTortoise => 'Korytnačka';

  @override
  String get valueFerret => 'Fretka';

  @override
  String get otherOption => 'Iné…';

  @override
  String get celebrationsToggle => 'Oslavovať adopcie';

  @override
  String get celebrationsSubtitle =>
      'Konfety a jasot, keď sa mačka sťahuje do svojho domova';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfety a jasot, keď sa miláčik sťahuje do svojho domova';

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
  String get mapSearchHintNeutral => 'Hľadať miláčikov, domácnosti, osoby';

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
  String get kittensLabelNeutral => 'Mláďatá';

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
  String toastBornNeutral(Object cat) {
    return '✨ Nové mláďa: $cat ✨';
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
  String get syncChooserInPersonSub => 'Synchronizácia cez Wi-Fi';

  @override
  String get syncChooserRemote => 'Na diaľku';

  @override
  String get syncChooserRemoteSub =>
      'Synchronizácia cez priečinok alebo USB kľúč';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Export a import cez sociálne siete';

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
  String get selectClowderHintNeutral => 'Vyber domácnosť vľavo';

  @override
  String get introTitle1 => 'Vaše mačky prehľadne';

  @override
  String get introTitle1Neutral => 'Vaši miláčikovia prehľadne';

  @override
  String get introBody1 =>
      'Založte každej mačke kartu: fotka, pohlavie, zdravie, čokoľvek chcete zaznamenať. Mačky sú zoskupené podľa miesta, kde žijú — aplikácia ho volá kolónia (clowder).';

  @override
  String get introBody1Neutral =>
      'Založte každému miláčikovi, o ktorého sa staráte, kartu: fotka, pohlavie, zdravie, čokoľvek chcete zaznamenať. Miláčikovia sú zoskupení podľa miesta, kde žijú — aplikácia ho volá domácnosť.';

  @override
  String get introTitle2 => 'Funguje bez internetu';

  @override
  String get introBody2 =>
      'Všetko sa ukladá len do vášho telefónu. Žiadne konto, žiadny cloud. Nič sa neodosiela, kým to sami nezdieľate.';

  @override
  String get introTitle3 => 'Spolupracujte';

  @override
  String get introBody3 =>
      'Každý používa svoju aplikáciu a z času na čas si vymeníte dáta: stretnite sa a naskenujte kód, použite zdieľaný priečinok alebo pošlite jeden súbor messengerom. Potom majú všetci rovnaké informácie.';

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
      'Tu synchronizujete so svojimi známymi. Vy rozhodujete, čo zdieľate.';

  @override
  String get spotHomeStrays =>
      'Táto karta zbiera všetky túlavé mačky — mačky bez domova. Ťuknutím zobrazíte zoznam.';

  @override
  String get spotHomeStraysNeutral =>
      'Táto karta zbiera všetkých túlavých — miláčikov bez domova. Ťuknutím zobrazíte zoznam.';

  @override
  String get spotHomeMenu =>
      'V tomto menu: hľadanie a zlučovanie duplicít, export CSV a ďalšie.';

  @override
  String get spotCatEdit =>
      'Ťuknite na ceruzku a mačku upravte. Tip: podržte pole a upravíte ho priamo.';

  @override
  String get spotCatEditNeutral =>
      'Ťuknite na ceruzku a miláčika upravte. Tip: podržte pole a upravíte ho priamo.';

  @override
  String get spotMapLayers =>
      'Hľadáte nezvestnú mačku? Zobrazte kruhy okolo miest jej letákov a okolo domova, z ktorého ušla.';

  @override
  String get spotMapLayersNeutral =>
      'Hľadáte nezvestného miláčika? Zobrazte kruhy okolo miest jeho letákov a okolo domova, z ktorého ušiel.';

  @override
  String get spotStraysFlier =>
      'Leták o nezvestnej mačke? Odfoťte ho tu — aplikácia uloží mačku aj kontakt za vás.';

  @override
  String get spotStraysFlierNeutral =>
      'Leták o nezvestnom miláčikovi? Odfoťte ho tu — aplikácia uloží miláčika aj kontakt za vás.';

  @override
  String get spotStraysScan =>
      'Niektoré letáky majú QR kód cat(a)log. Naskenujte ho tu a mačku importujte bez písania.';

  @override
  String get spotStraysScanNeutral =>
      'Niektoré letáky majú QR kód cat(a)log. Naskenujte ho tu a miláčika importujte bez písania.';

  @override
  String get introTitle4 => 'Hľadajte nezvestné mačky';

  @override
  String get introTitle4Neutral => 'Hľadajte nezvestných miláčikov';

  @override
  String get introBody4 =>
      'Vidíte leták s nezvestnou mačkou? Odfoťte ho v aplikácii: uloží mačku, kontakt majiteľa aj miesto. Ak sa neskôr objaví podobná túlavá mačka, aplikácia navrhne možné zhody.';

  @override
  String get introBody4Neutral =>
      'Vidíte leták s nezvestným miláčikom? Odfoťte ho v aplikácii: uloží miláčika, kontakt majiteľa aj miesto. Ak sa neskôr objaví podobné túlavé zviera, aplikácia navrhne možné zhody.';

  @override
  String get spotMapSearch =>
      'Napíšte mačku, miesto alebo osobu a skočte tam na mape.';

  @override
  String get spotMapSearchNeutral =>
      'Napíšte miláčika, miesto alebo osobu a skočte tam na mape.';

  @override
  String get spotCardChips =>
      'Zaškrtnite, čo má byť na zdieľanej karte — zvyšok na nej nebude.';

  @override
  String get spotCatMenu =>
      'Tu sú ďalšie akcie: skryť mačku, zlúčiť duplikáty alebo zaznamenať spozorovanie.';

  @override
  String get spotCatMenuNeutral =>
      'Tu sú ďalšie akcie: skryť miláčika, zlúčiť duplikáty alebo zaznamenať spozorovanie.';

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
  String get searchNoResultsNeutral => 'Miláčik s týmto menom sa nenašiel';

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

  @override
  String get catalogsTitle => 'Katalógy';

  @override
  String get newCatalog => 'Nový katalóg';

  @override
  String get intoCatalog => 'Do katalógu';

  @override
  String get catalogNameLabel => 'Názov katalógu';

  @override
  String catalogNameTaken(String name) {
    return 'Katalóg s názvom $name už existuje. Zvoľ iný názov.';
  }

  @override
  String get manageCatalogs => 'Spravovať katalógy';

  @override
  String get helpCatalogs =>
      'Každý katalóg je svet sám pre seba: vlastné mačky, kolónie, polia, fotky aj partneri synchronizácie. Berlín a Paríž sa nikdy nezmiešajú. Klepni na názov hore na domovskej obrazovke a prepni, pridaj alebo premenuj. Tvoje meno, jazyk a už videné tipy sú spoločné pre všetky.';

  @override
  String get helpCatalogsNeutral =>
      'Každý katalóg je svet sám pre seba: vlastní miláčikovia, domácnosti, polia, fotky aj partneri synchronizácie. Berlín a Paríž sa nikdy nezmiešajú. Klepni na názov hore na domovskej obrazovke a prepni, pridaj alebo premenuj. Tvoje meno, jazyk a už videné tipy sú spoločné pre všetky.';

  @override
  String get spotHomeCatalog =>
      'Toto je katalóg, v ktorom si. Klepni na názov pre prepnutie alebo vytvorenie ďalšieho.';

  @override
  String get deleteCatalog => 'Zmazať katalóg';

  @override
  String deleteCatalogBody(String name) {
    return 'Všetko v katalógu $name zmizne: mačky, fotky aj história. Najprv sa uloží úplný súbor tam, kam chodia automatické zálohy — jeho import katalóg vráti. Potvrď napísaním názvu.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Všetko v katalógu $name zmizne: miláčikovia, fotky aj história. Najprv sa uloží úplný súbor tam, kam chodia automatické zálohy — jeho import katalóg vráti. Potvrď napísaním názvu.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name zmazaný. Súbor je v $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Napíš $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nič sa nezmazalo: súbor katalógu sa nepodarilo zapísať ($error). Uvoľni miesto alebo to skús neskôr.';
  }

  @override
  String get moveToCatalog => 'Presunúť do iného katalógu';

  @override
  String movedToCatalog(int count, String name) {
    return '$count presunuté do $name';
  }

  @override
  String get chooseWhatToMove => 'Čo sa presunie?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Presunúť niečo do $name?';
  }

  @override
  String get undoThisImport => 'Vrátiť tento import';

  @override
  String undoImportBody(int count) {
    return '$count zmien z tohto importu zmizne. Najprv sa zapíšu do súboru, ktorého import ich vráti. Kto už synchronizoval, svoju kópiu si nechá — to sa vziať späť nedá.';
  }

  @override
  String undoneImport(String where) {
    return 'Vrátené. Súbor je v $where.';
  }

  @override
  String get goBackTitle => 'Vrátiť sa späť';

  @override
  String get goBackToHere => 'Vrátiť sa sem';

  @override
  String get momentImport => 'Pred importom';

  @override
  String get momentSync => 'Pred synchronizáciou';

  @override
  String get momentMerge => 'Pred zlúčením';

  @override
  String get momentHardDelete => 'Pred zmazaním údajov jedného autora';

  @override
  String get momentArchive => 'Pred archiváciou';

  @override
  String get momentManual => 'Označené tebou';

  @override
  String get showOlderMoments => 'Zobraziť staršie';

  @override
  String goBackBody(int count) {
    return 'Všetko po tomto okamihu zmizne — $count zmien. Najprv sa zapíše do súboru, ktorého import to vráti, a každý novší okamih ide s tým. Kto už synchronizoval, kópiu si nechá — to sa vziať späť nedá.';
  }

  @override
  String get nameThisMoment => 'Pomenuj tento okamih';

  @override
  String get helpGoBack =>
      'Okamihy, keď tento katalóg zmenil tvar: pred každým importom a každou synchronizáciou, pred zlúčením, archiváciou alebo mazaním, a vždy, keď si okamih označil sám. Výberom jedného sa katalóg vráti do toho stavu — všetko po ňom sa zapíše do súboru, ktorý si necháš, a potom sa odstráni; každý novší okamih ide s tým. Kto už synchronizoval, si ponechá, čo dostal.';

  @override
  String goBackFileFailed(String error) {
    return 'Nič sa neodstránilo: súbor, ktorý to uchová, sa nepodarilo zapísať ($error). Uvoľni miesto a skús to znova.';
  }

  @override
  String get goBackChanged =>
      'Nič nebolo odstránené: katalóg sa počas ukladania súboru zmenil. Skús to znova.';

  @override
  String get switchBeforeDeleting =>
      'Toto je katalóg, v ktorom si. Prepni na iný a potom ho zmaž.';

  @override
  String shareFileFailed(String error) {
    return 'Súbor na zdieľanie sa nepodarilo zapísať ($error). Uvoľni miesto a skús to znova.';
  }

  @override
  String get privateLabel => 'Súkromné';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalóg: $name';
  }

  @override
  String get markPrivate => 'Označiť ako súkromné';

  @override
  String get unmarkPrivate => 'Odstrániť súkromné označenie';

  @override
  String get agenda => 'Pripomienky';

  @override
  String get reminderLabel => 'Pripomienka';

  @override
  String get agendaEmpty =>
      'Žiadne termíny nie sú naplánované. Nové naplánuješ tu plusom alebo na stránke mačky či clowderu.';

  @override
  String get agendaEmptyNeutral =>
      'Žiadne termíny nie sú naplánované. Nové naplánuješ tu plusom alebo na stránke miláčika či domácnosti.';

  @override
  String get dueToday => 'dnes';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'o $count dní',
      few: 'o $count dni',
      one: 'o 1 deň',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dní po termíne',
      few: '$count dni po termíne',
      one: '1 deň po termíne',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Hotovo';

  @override
  String get repeatTitle => 'Znova o…';

  @override
  String get noRepeatLabel => 'Bez opakovania';

  @override
  String get unitDays => 'dní';

  @override
  String get unitWeeks => 'týždňov';

  @override
  String get unitMonths => 'mesiacov';

  @override
  String get unitYears => 'rokov';

  @override
  String ageYears(int years) {
    return '$years r.';
  }

  @override
  String ageMonths(int months) {
    return '$months mes.';
  }

  @override
  String get changeDateLabel => 'Zmeniť dátum';

  @override
  String get removeReminderLabel => 'Odstrániť pripomienku';

  @override
  String get exportIcs => 'Exportovať súbor kalendára';

  @override
  String get resyncCalendar => 'Znovu synchronizovať kalendár';

  @override
  String icsSavedTo(String path) {
    return 'Súbor kalendára uložený do $path';
  }

  @override
  String get calendarMirrorLabel => 'Zrkadliť do kalendára zariadenia';

  @override
  String get calendarMirrorSubtitle =>
      'Termíny sa v kalendári objavia ako celodenné udalosti. cat(a)log ich tam aktualizuje pri každom spustení a po každej zmene. Upozornenia na termíny spravuješ v kalendári.';

  @override
  String get syncPeerOlder =>
      'Druhé zariadenie má starší cat(a)log bez pripomienok. Aktualizuj tam cat(a)log a synchronizuj znova.';

  @override
  String get syncPeerNewer =>
      'Druhé zariadenie má novší cat(a)log. Aktualizuj cat(a)log na tomto zariadení a synchronizuj znova.';

  @override
  String get syncPeerNoTls =>
      'Druhé zariadenie má cat(a)log pred 1.1.0, bez šifrovanej synchronizácie. Aktualizuj tam cat(a)log a synchronizuj znova.';

  @override
  String get syncWrongHost =>
      'Certifikát nezodpovedá párovaciemu kódu — toto nie je zariadenie, z ktorého kód pochádza. Naskenuj alebo zadaj kód znova.';

  @override
  String get bundleNewerError =>
      'Tento súbor pochádza z novšieho cat(a)logu. Aktualizuj cat(a)log na tomto zariadení, aby sa dal importovať.';

  @override
  String get spotEar => 'Malé mačacie ucho v rohu znamená: podrž pre viac.';

  @override
  String get addReminder => 'Pridať pripomienku';

  @override
  String get plannedSection => 'Naplánované';

  @override
  String get reminderDialogHint =>
      'Termín sa zobrazí v pripomienkach. Tam ho môžeš potvrdiť alebo zahodiť. Hodnota sa prevezme, len ak bol termín potvrdený.';

  @override
  String get reminderFor => 'Pre';

  @override
  String get reminderField => 'Pole';

  @override
  String get dueDateLabel => 'Termín';

  @override
  String get pickCalendar => 'Ktorý kalendár?';

  @override
  String get calendarPermissionDenied =>
      'Prístup ku kalendáru je zablokovaný, takže zrkadlenie je vypnuté. Povoľ ho v nastaveniach systému a zrkadlenie znova zapni.';

  @override
  String get calendarNotChosen =>
      'Nie je vybraný žiadny kalendár, takže zrkadlenie je vypnuté. Znova ho zapni a nejaký vyber.';

  @override
  String get calendarGone =>
      'Vybraný kalendár už neexistuje, takže zrkadlenie je vypnuté. Znova ho zapni a vyber iný.';

  @override
  String get noWritableCalendar =>
      'Kalendár sa nenašiel. Prihlás sa v nastaveniach systému do účtu kalendára, napríklad Google, a skús to znova.';

  @override
  String get spotHomeAgenda =>
      'Pripomienky: zoznam naplánovaných termínov — veterinár, lieky, kontroly.';

  @override
  String get spotAgendaAdd => 'Naplánovať nový termín.';

  @override
  String get spotAgendaCalendar =>
      'Zapni tu zrkadlenie termínov cat(a)logu do vybraného kalendára.';

  @override
  String get helpAgenda =>
      'Pripomienky ukazujú naplánované termíny podľa dátumu. Sú dva druhy: termíny s hodinou a pripomienky, ktoré platia pre deň. Zmeškané ostávajú navrchu. Ťuknutie otvorí mačku alebo clowder. Fajka potvrdí termín: hodnota sa zapíše do poľa a hneď môžeš naplánovať ďalší, napríklad o tri mesiace. Podržanie zmení dátum alebo termín vymaže. Prepínač hore zrkadlí termíny do kalendára telefónu. Ponuka ich exportuje ako súbor kalendára. Návšteva veterinára s viacerými mačkami je jedno stretnutie: zaškrtnite mačky, Agenda ukáže jednu kartu s ich menami a pri dokončení sa opýta, ktoré mačky boli ošetrené — ostatné odškrtnite, zostanú naplánované.';

  @override
  String get helpAgendaNeutral =>
      'Pripomienky ukazujú naplánované termíny podľa dátumu. Sú dva druhy: termíny s hodinou a pripomienky, ktoré platia pre deň. Zmeškané ostávajú navrchu. Ťuknutie otvorí miláčika alebo domácnosť. Fajka potvrdí termín: hodnota sa zapíše do poľa a hneď môžeš naplánovať ďalší, napríklad o tri mesiace. Podržanie zmení dátum alebo termín vymaže. Prepínač hore zrkadlí termíny do kalendára telefónu. Ponuka ich exportuje ako súbor kalendára. Návšteva veterinára s viacerými miláčikmi je jedno stretnutie: zaškrtnite miláčikov, Agenda ukáže jednu kartu s ich menami a pri dokončení sa opýta, ktorí miláčikovia boli ošetrení — ostatných odškrtnite, zostanú naplánovaní.';

  @override
  String get calendarRowOff => 'Kalendár: vypnuté';

  @override
  String calendarRowOn(String name) {
    return 'Kalendár: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Naplánuj termín pre túto mačku. Zobrazí sa v pripomienkach a tam sa potvrdí.';

  @override
  String get spotAddReminderCatNeutral =>
      'Naplánuj termín pre tohto miláčika. Zobrazí sa v pripomienkach a tam sa potvrdí.';

  @override
  String get spotAddReminderClowder =>
      'Naplánuj termín pre tento clowder. Zobrazí sa v pripomienkach a tam sa potvrdí.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Naplánuj termín pre túto domácnosť. Zobrazí sa v pripomienkach a tam sa potvrdí.';

  @override
  String get readOnlyCalendar => 'len na čítanie';

  @override
  String get appointmentLabel => 'Termín';

  @override
  String get addAppointment => 'Pridať termín';

  @override
  String get planChooserTitle => 'Termín alebo pripomienka?';

  @override
  String get planChooserAppointment =>
      'Termín — návšteva v deň a hodinu, s poznámkami';

  @override
  String get planChooserReminder =>
      'Pripomienka — hodnota, ktorá je v určitý deň na rade';

  @override
  String get appointmentTitleLabel => 'Čo';

  @override
  String get notesLabel => 'Poznámky';

  @override
  String get timeLabel => 'Čas';

  @override
  String get allDayLabel => 'Celý deň';

  @override
  String get alertLabel => 'Upozornenie';

  @override
  String get alertNone => 'Žiadne';

  @override
  String get alertDayBefore => 'Deň vopred';

  @override
  String get alertHourBefore => 'Hodinu vopred';

  @override
  String get linkFieldLabel => 'Po dokončení zapísať do poľa';

  @override
  String get noLinkedField => 'Žiadne pole';

  @override
  String get outcomeTitle => 'Ako to dopadlo?';

  @override
  String get finishLabel => 'Dokončiť';

  @override
  String get editLabelAppointment => 'Upraviť termín';

  @override
  String get deleteAppointment => 'Vymazať termín';

  @override
  String get stepFlierText => 'Text letáku';

  @override
  String get qrFoundHint =>
      'Na letáku sa našiel QR kód. Zaškrtnuté kódy sa čítajú kvôli číslam registra a odkazom.';

  @override
  String get useCode => 'Použiť tento kód';

  @override
  String get qrNone => 'Na fotke sa nenašiel žiadny QR kód.';

  @override
  String qrFailed(String error) {
    return 'Čítanie QR kódu zlyhalo: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Rozpoznaný leták $name. Skontrolujte nižšie, do ktorého poľa každý riadok patrí.';
  }

  @override
  String get flierLayoutUnknown =>
      'Neznáme rozloženie letáku. Priraďte riadky poliam nižšie; zvyšok ostane v poznámkach.';

  @override
  String get targetRegistryNumber => 'Číslo registra';

  @override
  String get targetLostPlace => 'Adresa (miesto straty)';

  @override
  String get targetContact => 'Kontakt registra';

  @override
  String get targetDrop => 'Zahodiť';

  @override
  String get existingCat => 'Existujúca mačka';

  @override
  String get existingCatNeutral => 'Existujúci miláčik';

  @override
  String get existingClowder => 'Existujúca skupina';

  @override
  String get existingClowderNeutral => 'Existujúca domácnosť';

  @override
  String get createNewInstead => 'Žiadna — vytvoriť novú';

  @override
  String overwritesValue(String value) {
    return 'Prepíše aktuálnu hodnotu \"$value\"';
  }

  @override
  String get abortScanTitle => 'Prerušiť snímanie?';

  @override
  String get abortScanBody => 'Nič sa neuloží.';

  @override
  String get abortScan => 'Prerušiť';

  @override
  String get keepScanning => 'Pokračovať';

  @override
  String get catsOnAppointment => 'Mačky na tomto stretnutí';

  @override
  String get catsOnAppointmentNeutral => 'Miláčikovia na tomto stretnutí';

  @override
  String get noCatsHint =>
      'Žiadna mačka nie je zaškrtnutá — stretnutie patrí samotnej kolónii.';

  @override
  String get noCatsHintNeutral =>
      'Žiadny miláčik nie je zaškrtnutý — stretnutie patrí samotnej domácnosti.';

  @override
  String get pickCatsTitle => 'Ktoré mačky idú so sebou?';

  @override
  String get pickCatsTitleNeutral => 'Ktorí miláčikovia idú so sebou?';

  @override
  String catsCount(int count) {
    return '$count mačiek';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count miláčikov';
  }

  @override
  String get finishUntickHint =>
      'Odškrtnite mačky, ktoré neboli ošetrené; zostanú naplánované.';

  @override
  String get finishUntickHintNeutral =>
      'Odškrtnite miláčikov, ktorí neboli ošetrení; zostanú naplánovaní.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Zmazať stretnutie pre všetkých $count mačiek';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Zmazať stretnutie pre všetkých $count miláčikov';
  }
}
