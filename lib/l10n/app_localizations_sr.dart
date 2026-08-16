// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Добродошли у cat(a)log';

  @override
  String get welcomeBody =>
      'Изаберите себи име. Свака промена се бележи под тим именом, да други виде ко је шта урадио.';

  @override
  String get yourName => 'Ваше име';

  @override
  String get start => 'Почни';

  @override
  String get clowders => 'Клаудери';

  @override
  String get noClowdersYet => 'Још нема клаудера.\nНаправите први испод.';

  @override
  String get strays => 'Луталице';

  @override
  String get searchCats => 'Тражи мачке';

  @override
  String get map => 'Мапа';

  @override
  String get sync => 'Синхронизација';

  @override
  String get fields => 'Поља';

  @override
  String get exportCsv => 'Извези CSV';

  @override
  String get aboutAndFeedback => 'О апликацији и утисци';

  @override
  String get newClowder => 'Нови клаудер';

  @override
  String get name => 'Име';

  @override
  String get cancel => 'Откажи';

  @override
  String get create => 'Направи';

  @override
  String get save => 'Сачувај';

  @override
  String get delete => 'Обриши';

  @override
  String get merge => 'Споји';

  @override
  String get resolve => 'Одлучи';

  @override
  String get open => 'Отвори';

  @override
  String csvSavedTo(String path) {
    return 'CSV сачуван у $path';
  }

  @override
  String get renameClowder => 'Преименуј клаудер';

  @override
  String get rename => 'Преименуј';

  @override
  String get timeline => 'Временска линија';

  @override
  String get mergeInto => 'Споји са…';

  @override
  String get deleteClowder => 'Обриши клаудер';

  @override
  String get cats => 'Мачке';

  @override
  String get addCat => 'Додај мачку';

  @override
  String get newCat => 'Нова мачка';

  @override
  String deleteQuestion(String name) {
    return 'Обрисати $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудер нестаје са списка.';

  @override
  String deleteClowderBody(int count) {
    return 'Његове мачке ($count) се не бришу — постају луталице. Прво их преместите у други клаудер ако то не желите.';
  }

  @override
  String get card => 'Картица';

  @override
  String get shareAsImage => 'Подели као слику';

  @override
  String get shareAsPdf => 'Подели као PDF';

  @override
  String get print => 'Штампај';

  @override
  String cardTitle(String name) {
    return 'Картица — $name';
  }

  @override
  String get renameCat => 'Преименуј мачку';

  @override
  String get seenHereNow => 'Виђена овде сада';

  @override
  String get deleteCat => 'Обриши мачку';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get strayNoClowder => 'Луталица — без клаудера';

  @override
  String get stray => 'Луталица';

  @override
  String get photos => 'Фотографије';

  @override
  String get addPhoto => 'Додај фотографију';

  @override
  String get setAsProfileImage => 'Постави као профилну';

  @override
  String get thisIsProfileImage => 'Ово је профилна фотографија';

  @override
  String get deletePhoto => 'Обриши фотографију';

  @override
  String get deletePhotoTitle => 'Обрисати фотографију?';

  @override
  String get deletePhotoBody =>
      'Подаци фотографије се трајно бришу — нема повратка.';

  @override
  String get deleteCatBody =>
      'Мачка нестаје са свих спискова. Њене фотографије се трајно бришу.';

  @override
  String get sightingRecorded => 'Виђење забележено на вашој позицији.';

  @override
  String get noLocationAvailable =>
      'Локација недоступна — уместо тога дуго притисните мапу.';

  @override
  String get moveTo => 'Премести у';

  @override
  String get noClowderStrayOption => 'Без клаудера — луталица / побегла';

  @override
  String timelineOf(String name) {
    return 'Временска линија — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Поништи ову промену';

  @override
  String get revertSubtitle =>
      'Враћа претходну вредност као нови запис — историја чува обоје.';

  @override
  String fieldCleared(String field) {
    return '$field испражњено';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field враћено на \"$value\"';
  }

  @override
  String get leftStray => 'Отишла — луталица';

  @override
  String movedTo(String name) {
    return 'Премештена у $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat је стигла';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat је стигла из $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat је отишла у $place';
  }

  @override
  String get duplicateMergedIn => 'Дупликат спојен';

  @override
  String get asOfToday => 'Са данашњим датумом';

  @override
  String asOfDate(String date) {
    return 'Са датумом $date';
  }

  @override
  String get value => 'Вредност';

  @override
  String get latitudeLongitude => 'географска ширина, дужина';

  @override
  String get newField => 'Ново поље';

  @override
  String get fieldType => 'Врста';

  @override
  String get usedOn => 'Користи се за';

  @override
  String get forCats => 'мачке';

  @override
  String get forClowders => 'клаудере';

  @override
  String get forBoth => 'обоје';

  @override
  String get optionsOnePerLine => 'Опције (једна по реду)';

  @override
  String get renameField => 'Преименуј поље';

  @override
  String get noStraysRightNow => 'Тренутно нема луталица.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Додај луталицу';

  @override
  String get newStray => 'Нова луталица';

  @override
  String get searchByNameHint => 'Тражи мачке по имену…';

  @override
  String get host => 'Домаћин';

  @override
  String get hostExplainer =>
      'Почните овде, затим унесите адресу и PIN на другом уређају.';

  @override
  String get startHosting => 'Покрени домаћинство';

  @override
  String get stopHosting => 'Заустави домаћинство';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Досад сесија: $count';
  }

  @override
  String get join => 'Придружи се';

  @override
  String get addressFromHost => 'Адреса (са уређаја домаћина)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Синхронизуј сада';

  @override
  String get addressFormatHint =>
      'Адреса мора изгледати као 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Синхронизовано: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Синхронизација није успела: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Последња синхронизација са $peer: $time';
  }

  @override
  String get sharedFolder => 'Дељена фасцикла';

  @override
  String get sharedFolderExplainer =>
      'Синхронизујте преко фасцикле коју облак или USB преноси између уређаја — за оне који нису на истој мрежи.';

  @override
  String get noFolderChosenYet => 'Фасцикла још није изабрана';

  @override
  String get choose => 'Изабери…';

  @override
  String get syncFolderNow => 'Синхронизуј фасциклу сада';

  @override
  String folderSynced(String result) {
    return 'Фасцикла синхронизована: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Синхронизација фасцикле није успела: $error';
  }

  @override
  String get recordSightingHere => 'Забележи виђење овде:';

  @override
  String get orPlaceClowderHere => 'Или овде постави клаудер:';

  @override
  String trailOf(String name, int count) {
    return 'Рута: $name ($count виђења)';
  }

  @override
  String conflictOn(String field) {
    return 'Сукоб — $field';
  }

  @override
  String get conflictBody =>
      'Промењено на два места истовремено. Изаберите шта је тачно:';

  @override
  String mergeThisInto(String kind) {
    return 'Споји овај запис ($kind) са…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Нема другог записа ($kind) за спајање.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Спојити са $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Два записа постају један. $name задржава тренутне вредности; историја другог се придружује. Нема повратка.';
  }

  @override
  String get kindCat => 'мачка';

  @override
  String get kindClowder => 'клаудер';

  @override
  String get kindField => 'поље';

  @override
  String get takePhoto => 'Сними фотографију';

  @override
  String get chooseFromGallery => 'Изабери из галерије';

  @override
  String get about => 'О апликацији';

  @override
  String get aboutTagline =>
      'Локални каталог за мачке на хранитељству. Ваши подаци остају на вашим уређајима — без сервера, без налога.';

  @override
  String versionLabel(String version, String build) {
    return 'Верзија $version ($build)';
  }

  @override
  String get sourceCode => 'Изворни код';

  @override
  String get reportProblemOrIdea => 'Пријави проблем или идеју';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Пиши програмеру';

  @override
  String get buyCoffee => 'Части програмера кафом';

  @override
  String get coffeeSubtitle => 'Потпуно добровољно — апликација је бесплатна';

  @override
  String get openSourceLicenses => 'Лиценце отвореног кода';

  @override
  String get machineTranslated =>
      'Преводи су машински — исправке су добродошле на GitHub-у.';

  @override
  String get unnamed => '(без имена)';

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
  String get starterNeutered => 'Стерилисана';

  @override
  String get starterPregnant => 'Скотна';

  @override
  String get starterBirthdate => 'Датум рођења';

  @override
  String get starterDeceased => 'Угинула';

  @override
  String get starterAddress => 'Адреса';

  @override
  String get starterResponsible => 'Одговорна особа';

  @override
  String get starterPosition => 'Позиција';

  @override
  String get valueYes => 'да';

  @override
  String get valueNo => 'не';

  @override
  String get valueFemale => 'женка';

  @override
  String get valueMale => 'мужјак';

  @override
  String get valueUnknown => 'непознато';

  @override
  String get cropTitle => 'Изрежи фотографију';

  @override
  String get markTitle => 'Означи мачку';

  @override
  String get useFullPhoto => 'Користи целу фотографију';

  @override
  String get dragToSelect => 'Превуци правоугаоник око мачке';

  @override
  String get dragOverTheCat => 'Превуци елипсу преко мачке';

  @override
  String get cropPhoto => 'Изрежи…';

  @override
  String get markPhoto => 'Означи…';

  @override
  String get scanCode => 'Скенирај код';

  @override
  String get orTypeCode => 'Или укуцај код';

  @override
  String get copyCode => 'Копирај код';

  @override
  String get copied => 'Копирано';

  @override
  String get invalidCode => 'Тај код није важећи';

  @override
  String get hotspotHint =>
      'Нема заједничког Wi-Fi-ја? Укључи хотспот на једном телефону, повежи други и буди домаћин овде.';

  @override
  String get byMessenger => 'Преко месинџера';

  @override
  String get byMessengerExplainer =>
      'Пошаљи цео каталог као једну датотеку преко WhatsApp-а, Signal-а или поште — друга страна га увози.';

  @override
  String get shareBundle => 'Подели пакет синхронизације…';

  @override
  String get importBundle => 'Увези пакет синхронизације…';

  @override
  String bundleImported(String result) {
    return 'Пакет увезен: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Увоз није успео: $error';
  }

  @override
  String get pickOnMap => 'Изабери на мапи';

  @override
  String get useMyLocation => 'Користи моју локацију';

  @override
  String get language => 'Језик';

  @override
  String get systemDefault => 'Системски подразумевано';

  @override
  String get iosLocalNetworkHint =>
      'Ако и даље не успева на iPhone/iPad-у: Подешавања → Приватност и безбедност → Локална мрежа → дозволи cat(a)log па покушај поново.';

  @override
  String get markPrivate => 'Означи као приватно';

  @override
  String get unmarkPrivate => 'Уклони приватну ознаку';

  @override
  String get includePrivate => 'Укључи приватне податке';

  @override
  String get includePrivateExplainer =>
      'Приватне мачке, групе и поља се такође деле — укључите само при синхронизацији сопствених уређаја.';

  @override
  String get hideLabel => 'Сакриј на овом уређају';

  @override
  String get unhideLabel => 'Прикажи поново';

  @override
  String get showHiddenLabel => 'Прикажи скривене';

  @override
  String get stopShowingHidden => 'Престани да приказујеш скривене';

  @override
  String get starterSpecies => 'Врста';

  @override
  String get starterStatus => 'Статус';

  @override
  String get statusFoster => 'Хранитељски дом';

  @override
  String get statusForeverHome => 'Трајни дом';

  @override
  String get statusClinic => 'Клиника';

  @override
  String get statusShelter => 'Склониште';

  @override
  String get statusBarn => 'Штала';

  @override
  String get valueCat => 'Мачка';

  @override
  String get otherOption => 'Друго…';

  @override
  String get celebrationsToggle => 'Прослави усвајања';

  @override
  String get celebrationsSubtitle =>
      'Конфете и клицање када се мачка сели у трајни дом';

  @override
  String get onMapLabel => 'На карти';

  @override
  String get showOnMap => 'Прикажи на карти';

  @override
  String get searchPlaceHint => 'Тражи место или адресу';

  @override
  String get noPlacesFound => 'Нема пронађених места';

  @override
  String get mapSearchHint => 'Тражи мачке, групе, особе';

  @override
  String get proposeAnotherName => 'Предложи друго име';

  @override
  String get moderationTitle => 'Аутори и забране';

  @override
  String get moderationSubtitle => 'Трајно уклони податке особе';

  @override
  String get authorsSection => 'Ко је писао у овај каталог';

  @override
  String get hardDeleteAction => 'Обриши све од овог аутора';

  @override
  String hardDeleteWarning(Object name) {
    return 'Уклања сваки унос и фотографију од $name са овог уређаја. Други уређаји задржавају своје. Не може се опозвати.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Упиши $name за потврду';
  }

  @override
  String get alsoBan => 'Такође забрани — никад више не прихватај податке';

  @override
  String get bansSection => 'Забране';

  @override
  String get unbanAction => 'Уклони забрану';

  @override
  String get deletedDone => 'Обрисано.';

  @override
  String get syncSummaryTitle => 'Шта је стигло';

  @override
  String get summaryAdopted => 'Удомљене';

  @override
  String get summaryDeceased => 'Угинуле';

  @override
  String get summaryEscaped => 'Побегле';

  @override
  String get summaryNew => 'Ново';

  @override
  String get summaryConflicts => 'Конфликти за решавање';

  @override
  String summaryOther(Object n) {
    return '…и још $n промена';
  }
}
