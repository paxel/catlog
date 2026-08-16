// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Добредојдовте во cat(a)log';

  @override
  String get welcomeBody =>
      'Изберете си име. Секоја промена се запишува под тоа име, за другите да видат кој што направил.';

  @override
  String get yourName => 'Вашето име';

  @override
  String get start => 'Почни';

  @override
  String get clowders => 'Клаудери';

  @override
  String get noClowdersYet =>
      'Сè уште нема клаудери.\nСоздадете го првиот подолу.';

  @override
  String get strays => 'Скитници';

  @override
  String get searchCats => 'Барај мачки';

  @override
  String get map => 'Мапа';

  @override
  String get sync => 'Синхронизација';

  @override
  String get fields => 'Полиња';

  @override
  String get exportCsv => 'Извези CSV';

  @override
  String get aboutAndFeedback => 'За апликацијата и повратни информации';

  @override
  String get newClowder => 'Нов клаудер';

  @override
  String get name => 'Име';

  @override
  String get cancel => 'Откажи';

  @override
  String get create => 'Создај';

  @override
  String get save => 'Зачувај';

  @override
  String get delete => 'Избриши';

  @override
  String get merge => 'Спои';

  @override
  String get resolve => 'Одлучи';

  @override
  String get open => 'Отвори';

  @override
  String csvSavedTo(String path) {
    return 'CSV зачуван во $path';
  }

  @override
  String get renameClowder => 'Преименувај клаудер';

  @override
  String get rename => 'Преименувај';

  @override
  String get timeline => 'Времеплов';

  @override
  String get mergeInto => 'Спои со…';

  @override
  String get deleteClowder => 'Избриши клаудер';

  @override
  String get cats => 'Мачки';

  @override
  String get addCat => 'Додај мачка';

  @override
  String get newCat => 'Нова мачка';

  @override
  String deleteQuestion(String name) {
    return 'Да се избрише $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудерот исчезнува од списокот.';

  @override
  String deleteClowderBody(int count) {
    return 'Неговите мачки ($count) не се бришат — стануваат скитници. Прво преместете ги во друг клаудер ако не го сакате тоа.';
  }

  @override
  String get card => 'Картичка';

  @override
  String get shareAsImage => 'Сподели како слика';

  @override
  String get shareAsPdf => 'Сподели како PDF';

  @override
  String get print => 'Печати';

  @override
  String cardTitle(String name) {
    return 'Картичка — $name';
  }

  @override
  String get renameCat => 'Преименувај мачка';

  @override
  String get seenHereNow => 'Видена тука сега';

  @override
  String get deleteCat => 'Избриши мачка';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get strayNoClowder => 'Скитница — без клаудер';

  @override
  String get stray => 'Скитница';

  @override
  String get photos => 'Фотографии';

  @override
  String get addPhoto => 'Додај фотографија';

  @override
  String get setAsProfileImage => 'Постави како профилна';

  @override
  String get thisIsProfileImage => 'Ова е профилната фотографија';

  @override
  String get deletePhoto => 'Избриши фотографија';

  @override
  String get deletePhotoTitle => 'Да се избрише фотографијата?';

  @override
  String get deletePhotoBody =>
      'Податоците на фотографијата се бришат засекогаш — не може да се врати.';

  @override
  String get deleteCatBody =>
      'Мачката исчезнува од сите списоци. Нејзините фотографии се бришат засекогаш.';

  @override
  String get sightingRecorded => 'Видувањето е запишано на вашата позиција.';

  @override
  String get noLocationAvailable =>
      'Нема локација — наместо тоа задржете на мапата.';

  @override
  String get moveTo => 'Премести во';

  @override
  String get noClowderStrayOption => 'Без клаудер — скитница / избега';

  @override
  String timelineOf(String name) {
    return 'Времеплов — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Поништи ја оваа промена';

  @override
  String get revertSubtitle =>
      'Ја враќа претходната вредност како нов запис — историјата ги чува двете.';

  @override
  String fieldCleared(String field) {
    return '$field испразнето';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field вратено на \"$value\"';
  }

  @override
  String get leftStray => 'Замина — скитница';

  @override
  String movedTo(String name) {
    return 'Преместена во $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat пристигна';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat пристигна од $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat замина во $place';
  }

  @override
  String get duplicateMergedIn => 'Дупликатот е споен';

  @override
  String get asOfToday => 'Со денешен датум';

  @override
  String asOfDate(String date) {
    return 'Со датум $date';
  }

  @override
  String get value => 'Вредност';

  @override
  String get latitudeLongitude => 'географска ширина, должина';

  @override
  String get newField => 'Ново поле';

  @override
  String get fieldType => 'Тип';

  @override
  String get usedOn => 'Се користи за';

  @override
  String get forCats => 'мачки';

  @override
  String get forClowders => 'клаудери';

  @override
  String get forBoth => 'двете';

  @override
  String get optionsOnePerLine => 'Опции (по една во ред)';

  @override
  String get renameField => 'Преименувај поле';

  @override
  String get noStraysRightNow => 'Моментално нема скитници.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Додај скитница';

  @override
  String get newStray => 'Нова скитница';

  @override
  String get searchByNameHint => 'Барај мачки по име…';

  @override
  String get host => 'Домаќин';

  @override
  String get hostExplainer =>
      'Почнете тука, потоа внесете ја адресата и PIN-от на другиот уред.';

  @override
  String get startHosting => 'Започни домаќинство';

  @override
  String get stopHosting => 'Запри домаќинство';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Сесии досега: $count';
  }

  @override
  String get join => 'Приклучи се';

  @override
  String get addressFromHost => 'Адреса (од уредот домаќин)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Синхронизирај сега';

  @override
  String get addressFormatHint =>
      'Адресата треба да изгледа како 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Синхронизирано: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Синхронизацијата не успеа: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Последна синхронизација со $peer: $time';
  }

  @override
  String get sharedFolder => 'Заедничка папка';

  @override
  String get sharedFolderExplainer =>
      'Синхронизирајте преку папка што облак или USB ја пренесува меѓу уредите — за оние што не се на иста мрежа.';

  @override
  String get noFolderChosenYet => 'Сè уште не е избрана папка';

  @override
  String get choose => 'Избери…';

  @override
  String get syncFolderNow => 'Синхронизирај папка сега';

  @override
  String folderSynced(String result) {
    return 'Папката е синхронизирана: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Синхронизацијата на папката не успеа: $error';
  }

  @override
  String get recordSightingHere => 'Запиши видување тука:';

  @override
  String get orPlaceClowderHere => 'Или постави клаудер тука:';

  @override
  String trailOf(String name, int count) {
    return 'Патека: $name ($count видувања)';
  }

  @override
  String conflictOn(String field) {
    return 'Конфликт — $field';
  }

  @override
  String get conflictBody =>
      'Променето на две места истовремено. Изберете што е точно:';

  @override
  String mergeThisInto(String kind) {
    return 'Спои го овој запис ($kind) со…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Нема друг запис ($kind) за спојување.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Да се спои со $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Двата записа стануваат еден. $name ги задржува тековните вредности; историјата на другиот се приклучува. Не може да се врати.';
  }

  @override
  String get kindCat => 'мачка';

  @override
  String get kindClowder => 'клаудер';

  @override
  String get kindField => 'поле';

  @override
  String get takePhoto => 'Фотографирај';

  @override
  String get chooseFromGallery => 'Избери од галерија';

  @override
  String get about => 'За апликацијата';

  @override
  String get aboutTagline =>
      'Локален каталог за мачки на грижа. Вашите податоци остануваат на вашите уреди — без сервер, без сметка.';

  @override
  String versionLabel(String version, String build) {
    return 'Верзија $version ($build)';
  }

  @override
  String get sourceCode => 'Изворен код';

  @override
  String get reportProblemOrIdea => 'Пријави проблем или идеја';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Пиши му на развивачот';

  @override
  String get buyCoffee => 'Части го развивачот кафе';

  @override
  String get coffeeSubtitle => 'Целосно доброволно — апликацијата е бесплатна';

  @override
  String get openSourceLicenses => 'Лиценци со отворен код';

  @override
  String get machineTranslated =>
      'Преводите се машински — исправките се добредојдени на GitHub.';

  @override
  String get unnamed => '(без име)';

  @override
  String get labelName => 'Име';

  @override
  String get labelProfileImage => 'Профилна фотографија';

  @override
  String get labelPhoto => 'Фотографија';

  @override
  String get starterGender => 'Пол';

  @override
  String get starterColor => 'Боја';

  @override
  String get starterNeutered => 'Стерилизирана';

  @override
  String get starterPregnant => 'Бремена';

  @override
  String get starterBirthdate => 'Датум на раѓање';

  @override
  String get starterDeceased => 'Почината';

  @override
  String get starterAddress => 'Адреса';

  @override
  String get starterResponsible => 'Одговорно лице';

  @override
  String get starterPosition => 'Позиција';

  @override
  String get valueYes => 'да';

  @override
  String get valueNo => 'не';

  @override
  String get valueFemale => 'женка';

  @override
  String get valueMale => 'мажјак';

  @override
  String get valueUnknown => 'непознато';

  @override
  String get cropTitle => 'Исечи ја фотографијата';

  @override
  String get markTitle => 'Означи ја мачката';

  @override
  String get useFullPhoto => 'Користи ја целата фотографија';

  @override
  String get dragToSelect => 'Повлечи правоаголник околу мачката';

  @override
  String get dragOverTheCat => 'Повлечи елипса врз мачката';

  @override
  String get cropPhoto => 'Исечи…';

  @override
  String get markPhoto => 'Означи…';

  @override
  String get scanCode => 'Скенирај код';

  @override
  String get orTypeCode => 'Или внеси го кодот';

  @override
  String get copyCode => 'Копирај код';

  @override
  String get copied => 'Копирано';

  @override
  String get invalidCode => 'Тој код не е валиден';

  @override
  String get hotspotHint =>
      'Нема заедничко Wi-Fi? Вклучи хотспот на едниот телефон, поврзи го другиот и биди домаќин тука.';

  @override
  String get byMessenger => 'Преку месинџер';

  @override
  String get byMessengerExplainer =>
      'Испрати го целиот каталог како една датотека преку WhatsApp, Signal или пошта — другата страна го увезува.';

  @override
  String get shareBundle => 'Сподели пакет за синхронизација…';

  @override
  String get importBundle => 'Увези пакет за синхронизација…';

  @override
  String bundleImported(String result) {
    return 'Пакетот е увезен: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Увозот не успеа: $error';
  }

  @override
  String get pickOnMap => 'Избери на мапа';

  @override
  String get useMyLocation => 'Користи ја мојата локација';

  @override
  String get language => 'Јазик';

  @override
  String get systemDefault => 'Системски стандард';

  @override
  String get iosLocalNetworkHint =>
      'Ако и понатаму не успева на iPhone/iPad: Поставки → Приватност и безбедност → Локална мрежа → дозволи cat(a)log и обиди се пак.';

  @override
  String get markPrivate => 'Означи како приватно';

  @override
  String get unmarkPrivate => 'Отстрани приватна ознака';

  @override
  String get includePrivate => 'Вклучи приватни податоци';

  @override
  String get includePrivateExplainer =>
      'Приватните мачки, групи и полиња исто така се споделуваат — вклучете само при синхронизација на сопствените уреди.';

  @override
  String get hideLabel => 'Сокриј на овој уред';

  @override
  String get unhideLabel => 'Прикажи повторно';

  @override
  String get showHiddenLabel => 'Прикажи скриени';

  @override
  String get stopShowingHidden => 'Престани да прикажуваш скриени';

  @override
  String get starterSpecies => 'Вид';

  @override
  String get starterStatus => 'Статус';

  @override
  String get statusFoster => 'Згрижувачки дом';

  @override
  String get statusForeverHome => 'Постојан дом';

  @override
  String get statusClinic => 'Клиника';

  @override
  String get statusShelter => 'Прифатилиште';

  @override
  String get statusBarn => 'Штала';

  @override
  String get valueCat => 'Мачка';

  @override
  String get otherOption => 'Друго…';

  @override
  String get celebrationsToggle => 'Прославувај посвојувања';

  @override
  String get celebrationsSubtitle =>
      'Конфети и радост кога мачка се сели во постојан дом';

  @override
  String get onMapLabel => 'На картата';

  @override
  String get showOnMap => 'Прикажи на картата';

  @override
  String get searchPlaceHint => 'Барај место или адреса';

  @override
  String get noPlacesFound => 'Не се најдени места';

  @override
  String get mapSearchHint => 'Барај мачки, групи, луѓе';

  @override
  String get proposeAnotherName => 'Предложи друго име';

  @override
  String get moderationTitle => 'Автори и забрани';

  @override
  String get moderationSubtitle => 'Трајно отстрани податоци на личност';

  @override
  String get authorsSection => 'Кој пишувал во каталогот';

  @override
  String get hardDeleteAction => 'Избриши сè од овој автор';

  @override
  String hardDeleteWarning(Object name) {
    return 'Ги отстранува сите записи и фотографии од $name од овој уред. Другите уреди ги задржуваат своите. Не може да се врати.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Внеси $name за потврда';
  }

  @override
  String get alsoBan => 'Исто така забрани — никогаш повеќе податоци';

  @override
  String get bansSection => 'Забрани';

  @override
  String get unbanAction => 'Отстрани забрана';

  @override
  String get deletedDone => 'Избришано.';

  @override
  String get syncSummaryTitle => 'Што пристигна';

  @override
  String get summaryAdopted => 'Посвоени';

  @override
  String get summaryDeceased => 'Починати';

  @override
  String get summaryEscaped => 'Избегани';

  @override
  String get summaryNew => 'Нови';

  @override
  String get summaryConflicts => 'Конфликти за решавање';

  @override
  String summaryOther(Object n) {
    return '…и уште $n промени';
  }

  @override
  String get starterMother => 'Мајка';

  @override
  String get starterFather => 'Татко';

  @override
  String get familySection => 'Семејство';

  @override
  String get littermatesLabel => 'Од исто легло';

  @override
  String get siblingsLabel => 'Браќа и сестри';

  @override
  String get kittensLabel => 'Мачиња';

  @override
  String get toastSettingsTitle => 'Што да се објавува';

  @override
  String get toastSettingsSubtitle => 'Мали пораки по синхронизација';

  @override
  String get toastKindAdoptions => 'Посвојувања';

  @override
  String get toastKindBirths => 'Раѓања';

  @override
  String get toastKindDeaths => 'Смртни случаи';

  @override
  String get toastKindEscapes => 'Бегства';

  @override
  String get toastKindMoves => 'Преселби';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat посвоена од $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Ново маче: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat почина';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat избега';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat се пресели во $home';
  }

  @override
  String get notACatlogFile => 'Ова не е cat(a)log датотека';

  @override
  String get nothingNewInBundle => 'Ништо ново во датотеката — веќе имаш сè';

  @override
  String get syncChooserInPerson => 'Во живо';

  @override
  String get syncChooserInPersonSub =>
      'Во иста просторија сте — скенирај код, готово за секунди';

  @override
  String get syncChooserRemote => 'Од далечина';

  @override
  String get syncChooserRemoteSub =>
      'Преку споделена папка како Dropbox или USB';

  @override
  String get syncChooserMessenger => 'Месинџер';

  @override
  String get syncChooserMessengerSub =>
      'Испрати сè како една датотека преку кој било месинџер';

  @override
  String get connectToWifiFirst =>
      'Прво поврзи се на Wi-Fi — тогаш уредите се наоѓаат';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) сака да синхронизира';
  }

  @override
  String get trustBothWaysNote => 'Каталозите ќе се разменат во двете насоки.';

  @override
  String get allowOnce => 'Дозволи';

  @override
  String get allowAlways => 'Секогаш дозволи го овој уред';

  @override
  String get declineAction => 'Одбиј';

  @override
  String get syncDeclined => 'Другиот уред ја одби синхронизацијата';

  @override
  String get trustedDevicesSection => 'Секогаш дозволени уреди';

  @override
  String get removeTrust => 'Отстрани';

  @override
  String get hostWithoutWifi => 'Хостирај без Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Создава привремена директна врска со другиот телефон (без интернет). Само cat(a)log ја користи и сама се прекинува по синхронизацијата.';

  @override
  String get hotspotAndroidOnly =>
      'Овој код бара два Android телефони — на iPhone/iPad користи заедничка Wi-Fi';
}
