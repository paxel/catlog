// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Добре дошли в cat(a)log';

  @override
  String get welcomeBody =>
      'Изберете си име. Всяка промяна се записва под това име, за да виждат другите кой какво е направил.';

  @override
  String get yourName => 'Вашето име';

  @override
  String get start => 'Начало';

  @override
  String get clowders => 'Клаудери';

  @override
  String get noClowdersYet => 'Още няма клаудери.\nСъздайте първия по-долу.';

  @override
  String get strays => 'Бездомни котки';

  @override
  String get searchCats => 'Търсене на котки';

  @override
  String get map => 'Карта';

  @override
  String get sync => 'Синхронизация';

  @override
  String get fields => 'Полета';

  @override
  String get exportCsv => 'Експорт на CSV';

  @override
  String get aboutAndFeedback => 'Относно и обратна връзка';

  @override
  String get newClowder => 'Нов клаудер';

  @override
  String get name => 'Име';

  @override
  String get cancel => 'Отказ';

  @override
  String get create => 'Създай';

  @override
  String get save => 'Запази';

  @override
  String get delete => 'Изтрий';

  @override
  String get merge => 'Обедини';

  @override
  String get resolve => 'Реши';

  @override
  String get open => 'Отвори';

  @override
  String csvSavedTo(String path) {
    return 'CSV записан в $path';
  }

  @override
  String get renameClowder => 'Преименувай клаудера';

  @override
  String get rename => 'Преименувай';

  @override
  String get timeline => 'Хронология';

  @override
  String get mergeInto => 'Обедини с…';

  @override
  String get deleteClowder => 'Изтрий клаудера';

  @override
  String get cats => 'Котки';

  @override
  String get addCat => 'Добави котка';

  @override
  String get newCat => 'Нова котка';

  @override
  String deleteQuestion(String name) {
    return 'Изтриване на $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудерът изчезва от списъка.';

  @override
  String deleteClowderBody(int count) {
    return 'Неговите $count котки не се изтриват — стават бездомни. Първо ги преместете в друг клаудер, ако не искате това.';
  }

  @override
  String get card => 'Карта';

  @override
  String get shareAsImage => 'Сподели като изображение';

  @override
  String get shareAsPdf => 'Сподели като PDF';

  @override
  String get print => 'Печат';

  @override
  String cardTitle(String name) {
    return 'Карта — $name';
  }

  @override
  String get renameCat => 'Преименувай котката';

  @override
  String get seenHereNow => 'Видяна тук сега';

  @override
  String get deleteCat => 'Изтрий котката';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get strayNoClowder => 'Бездомна — без клаудер';

  @override
  String get stray => 'Бездомна';

  @override
  String get photos => 'Снимки';

  @override
  String get addPhoto => 'Добави снимка';

  @override
  String get setAsProfileImage => 'Задай като профилна снимка';

  @override
  String get thisIsProfileImage => 'Това е профилната снимка';

  @override
  String get deletePhoto => 'Изтрий снимката';

  @override
  String get deletePhotoTitle => 'Изтриване на снимката?';

  @override
  String get deletePhotoBody =>
      'Данните на снимката се изтриват завинаги — не може да се отмени.';

  @override
  String get deleteCatBody =>
      'Котката изчезва от всички списъци. Снимките ѝ се изтриват завинаги.';

  @override
  String get sightingRecorded => 'Забелязването е записано на вашата позиция.';

  @override
  String get noLocationAvailable =>
      'Няма местоположение — вместо това задръжте върху картата.';

  @override
  String get locationDeniedForever =>
      'Достъпът до местоположението е блокиран. Разрешете го в системните настройки, за да използвате Stray Cam.';

  @override
  String get openSettings => 'Отвори настройките';

  @override
  String get moveTo => 'Премести в';

  @override
  String get noClowderStrayOption => 'Без клаудер — бездомна / избяга';

  @override
  String timelineOf(String name) {
    return 'Хронология — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Отмени тази промяна';

  @override
  String get revertSubtitle =>
      'Възстановява предишната стойност като нов запис — хронологията пази и двете.';

  @override
  String fieldCleared(String field) {
    return '$field изчистено';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field върнато на \"$value\"';
  }

  @override
  String get leftStray => 'Напусна — бездомна';

  @override
  String movedTo(String name) {
    return 'Преместена в $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat пристигна';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat пристигна от $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat отиде в $place';
  }

  @override
  String get duplicateMergedIn => 'Дубликатът е обединен';

  @override
  String get asOfToday => 'Към днешна дата';

  @override
  String asOfDate(String date) {
    return 'Към $date';
  }

  @override
  String get value => 'Стойност';

  @override
  String get latitudeLongitude => 'ширина, дължина';

  @override
  String get newField => 'Ново поле';

  @override
  String get fieldType => 'Тип';

  @override
  String get usedOn => 'Използва се за';

  @override
  String get forCats => 'котки';

  @override
  String get forClowders => 'клаудери';

  @override
  String get forBoth => 'и двете';

  @override
  String get optionsOnePerLine => 'Опции (по една на ред)';

  @override
  String get ownValue => 'Собствена стойност';

  @override
  String get renameField => 'Преименувай полето';

  @override
  String get editOptions => 'Редактиране на опциите…';

  @override
  String get noStraysRightNow => 'В момента няма бездомни котки.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Добави бездомна';

  @override
  String get newStray => 'Нова бездомна';

  @override
  String get searchByNameHint => 'Търсене на котки по име…';

  @override
  String get host => 'Домакин';

  @override
  String get hostExplainer =>
      'Започнете тук, после въведете адреса и PIN на другото устройство.';

  @override
  String get startHosting => 'Стартирай домакинство';

  @override
  String get stopHosting => 'Спри домакинството';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Сесии досега: $count';
  }

  @override
  String get join => 'Присъединяване';

  @override
  String get addressFromHost => 'Адрес (от устройството домакин)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Синхронизирай сега';

  @override
  String get addressFormatHint =>
      'Адресът трябва да изглежда като 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Синхронизирано: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Неуспешна синхронизация: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Последна синхронизация с $peer: $time';
  }

  @override
  String get sharedFolder => 'Споделена папка';

  @override
  String get sharedFolderExplainer =>
      'Синхронизирайте през папка, която облак или флашка пренася между устройствата — за тези, които не са в една мрежа.';

  @override
  String get noFolderChosenYet => 'Още не е избрана папка';

  @override
  String get choose => 'Избери…';

  @override
  String get syncFolderNow => 'Синхронизирай папката сега';

  @override
  String folderSynced(String result) {
    return 'Папката е синхронизирана: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Неуспешна синхронизация на папката: $error';
  }

  @override
  String get recordSightingHere => 'Запиши забелязване тук:';

  @override
  String trailOf(String name, int count) {
    return 'Маршрут: $name ($count забелязвания)';
  }

  @override
  String conflictOn(String field) {
    return 'Конфликт — $field';
  }

  @override
  String get conflictBody =>
      'Променено на две места едновременно. Изберете кое е вярно:';

  @override
  String mergeThisInto(String kind) {
    return 'Обедини този запис ($kind) с…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Няма друг запис ($kind) за обединяване.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Обединяване с $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Двата записа стават един. $name запазва текущите си стойности; историята на другия се присъединява. Не може да се отмени.';
  }

  @override
  String get kindCat => 'котка';

  @override
  String get kindClowder => 'клаудер';

  @override
  String get kindField => 'поле';

  @override
  String get takePhoto => 'Направи снимка';

  @override
  String get chooseFromGallery => 'Избери от галерията';

  @override
  String get about => 'Относно';

  @override
  String get aboutTagline =>
      'Локален каталог за приемни котки. Данните ви остават на вашите устройства — без сървър, без акаунт.';

  @override
  String versionLabel(String version, String build) {
    return 'Версия $version ($build)';
  }

  @override
  String get sourceCode => 'Изходен код';

  @override
  String get reportProblemOrIdea => 'Съобщете за проблем или идея';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Пишете на разработчика';

  @override
  String get buyCoffee => 'Почерпете разработчика с кафе';

  @override
  String get coffeeSubtitle => 'Напълно доброволно — приложението е безплатно';

  @override
  String get openSourceLicenses => 'Лицензи с отворен код';

  @override
  String get machineTranslated =>
      'Преводите са машинни — поправки са добре дошли в GitHub.';

  @override
  String get unnamed => '(без име)';

  @override
  String get labelName => 'Име';

  @override
  String get labelProfileImage => 'Профилна снимка';

  @override
  String get labelPhoto => 'Снимка';

  @override
  String get starterGender => 'Пол';

  @override
  String get starterBreed => 'Порода';

  @override
  String get valueMixed => 'смесена';

  @override
  String get breedEuropeanShorthair => 'Европейска късокосместа';

  @override
  String get breedMaineCoon => 'Мейн куун';

  @override
  String get breedBritishShorthair => 'Британска късокосместа';

  @override
  String get breedNorwegianForestCat => 'Норвежка горска котка';

  @override
  String get breedRagdoll => 'Рагдол';

  @override
  String get breedSiamese => 'Сиамска';

  @override
  String get breedPersian => 'Персийска';

  @override
  String get breedBengal => 'Бенгалска';

  @override
  String get breedSphynx => 'Сфинкс';

  @override
  String get starterColor => 'Цвят';

  @override
  String get starterNeutered => 'Кастрирана';

  @override
  String get starterPregnant => 'Бременна';

  @override
  String get starterBirthdate => 'Дата на раждане';

  @override
  String get starterDeceased => 'Починала';

  @override
  String get starterAddress => 'Адрес';

  @override
  String get starterResponsible => 'Отговорно лице';

  @override
  String get starterPosition => 'Позиция';

  @override
  String get valueYes => 'да';

  @override
  String get valueNo => 'не';

  @override
  String get valueFemale => 'женска';

  @override
  String get valueMale => 'мъжка';

  @override
  String get valueUnknown => 'неизвестно';

  @override
  String get cropTitle => 'Изрежи снимката';

  @override
  String get markTitle => 'Маркирай котката';

  @override
  String get applyCrop => 'Изрязване';

  @override
  String get useFullPhoto => 'Използвай цялата снимка';

  @override
  String get dragToSelect => 'Очертай правоъгълник около котката';

  @override
  String get dragOverTheCat => 'Очертай елипса върху котката';

  @override
  String get cropPhoto => 'Изрежи…';

  @override
  String get markPhoto => 'Маркирай…';

  @override
  String get scanCode => 'Сканирай кода';

  @override
  String get orTypeCode => 'Или въведи кода';

  @override
  String get copyCode => 'Копирай кода';

  @override
  String get copied => 'Копирано';

  @override
  String get invalidCode => 'Този код не е валиден';

  @override
  String get hotspotHint =>
      'Няма общ Wi-Fi? Включи точката за достъп на единия телефон, свържи другия и стани домакин тук.';

  @override
  String get byMessenger => 'Чрез месинджър';

  @override
  String get byMessengerExplainer =>
      'Изпрати целия каталог като един файл през WhatsApp, Signal или поща — другата страна го импортира.';

  @override
  String get shareBundle => 'Сподели пакет за синхронизация…';

  @override
  String get importBundle => 'Импортирай пакет за синхронизация…';

  @override
  String bundleImported(String result) {
    return 'Пакетът е импортиран: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Последното автоматично архивиране се провали: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Импортът се провали: $error';
  }

  @override
  String get pickOnMap => 'Избери на картата';

  @override
  String get useMyLocation => 'Използвай моето местоположение';

  @override
  String get language => 'Език';

  @override
  String get systemDefault => 'Системен по подразбиране';

  @override
  String get iosLocalNetworkHint =>
      'Ако на iPhone/iPad продължава да не успява: Настройки → Поверителност и сигурност → Локална мрежа → разреши cat(a)log и опитай пак.';

  @override
  String get crashTitle => 'Това не биваше да се случва';

  @override
  String get crashBody =>
      'cat(a)log срещна неочаквана грешка. Данните ти са в безопасност — всичко се записва в момента на промяната. Рестартирай приложението и ако се повтаря, изпрати доклада, за да бъде поправено.';

  @override
  String get crashRestart => 'Рестартирай приложението';

  @override
  String get crashSendReport => 'Изпрати доклад на разработчика';

  @override
  String get crashLastRunBody =>
      'cat(a)log спря неочаквано миналия път — най-вероятно свърши паметта. Да изпратим ли кратък доклад, за да се поправи?';
}
