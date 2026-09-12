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
  String get clowdersNeutral => 'Домаћинства';

  @override
  String get noClowdersYet =>
      'Још нема клаудера. Клаудер је место где мачке живе — твој хранитељски дом, стан усвојитеља. Направи први испод.';

  @override
  String get noClowdersYetNeutral =>
      'Још нема домаћинстава. Домаћинство је место где љубимци живе — твој дом, хранитељски дом, стан усвојитеља. Направи прво испод.';

  @override
  String get strays => 'Луталице';

  @override
  String get searchCats => 'Тражи мачке';

  @override
  String get searchCatsNeutral => 'Тражи љубимце';

  @override
  String get map => 'Мапа';

  @override
  String get sync => 'Синхронизација';

  @override
  String get fields => 'Поља';

  @override
  String get pickerColumns => 'Колоне';

  @override
  String get pickerCardFields => 'На картици';

  @override
  String get exportCsv => 'Извези CSV';

  @override
  String get aboutAndFeedback => 'О апликацији и утисци';

  @override
  String get settings => 'Подешавања';

  @override
  String get newClowder => 'Нови клаудер';

  @override
  String get newClowderNeutral => 'Ново домаћинство';

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
  String get renameClowderNeutral => 'Преименуј домаћинство';

  @override
  String get rename => 'Преименуј';

  @override
  String get timeline => 'Временска линија';

  @override
  String get mergeInto => 'Споји са…';

  @override
  String get deleteClowder => 'Обриши клаудер';

  @override
  String get deleteClowderNeutral => 'Обриши домаћинство';

  @override
  String get cats => 'Мачке';

  @override
  String get catsNeutral => 'Љубимци';

  @override
  String get addCat => 'Додај мачку';

  @override
  String get addCatNeutral => 'Додај љубимца';

  @override
  String get newCat => 'Нова мачка';

  @override
  String get newCatNeutral => 'Нови љубимац';

  @override
  String deleteQuestion(String name) {
    return 'Обрисати $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудер нестаје са списка.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Домаћинство нестаје са списка.';

  @override
  String deleteClowderBody(int count) {
    return 'Његове мачке ($count) се не бришу — постају луталице. Прво их преместите у други клаудер ако то не желите.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Његови љубимци ($count) се не бришу — постају луталице. Прво их преместите у друго домаћинство ако то не желите.';
  }

  @override
  String get card => 'Картица';

  @override
  String get shareAsImage => 'Подели као слику';

  @override
  String get sortOldestFirst => 'Најстарије прво';

  @override
  String get sortNewestFirst => 'Најновије прво';

  @override
  String get shareAsText => 'Подели као текст';

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
  String get renameCatNeutral => 'Преименуј љубимца';

  @override
  String get seenHereNow => 'Виђена овде сада';

  @override
  String get deleteCat => 'Обриши мачку';

  @override
  String get deleteCatNeutral => 'Обриши љубимца';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get clowderLabelNeutral => 'Домаћинство';

  @override
  String get strayNoClowder => 'Луталица — без клаудера';

  @override
  String get strayNoClowderNeutral => 'Луталица — без домаћинства';

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
      'Мачка нестаје са свих листа и њене фотографије се уклањају — овде и, после следеће синхронизације, и на другим уређајима.';

  @override
  String get deleteCatBodyNeutral =>
      'Љубимац нестаје са свих листа и његове фотографије се уклањају — овде и, после следеће синхронизације, и на другим уређајима.';

  @override
  String get sightingRecorded => 'Виђење забележено на вашој позицији.';

  @override
  String get noLocationAvailable =>
      'Локација недоступна — уместо тога дуго притисните мапу.';

  @override
  String get locationDeniedForever =>
      'Pristup lokaciji je blokiran. Dozvolite ga u sistemskim podešavanjima da biste koristili Stray Cam.';

  @override
  String get locationServiceOff =>
      'Локација је искључена на овом уређају. Укључите је у подешавањима и покушајте поново.';

  @override
  String get locationDenied =>
      'cat(a)log нема дозволу да користи вашу локацију. Покушајте поново и дозволите када будете упитани.';

  @override
  String get locationNoFix =>
      'Ваша позиција тренутно не може да се одреди. Покушајте поново на отвореном — GPS-у треба чист поглед на небо.';

  @override
  String get ok => 'У реду';

  @override
  String get starterChipId => 'Број чипа';

  @override
  String get starterRemarks => 'Напомене';

  @override
  String get captureFlier => 'Сликај оглас';

  @override
  String get addPhotosTo => 'Додај фотографије у…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count фотографија додато у $name';
  }

  @override
  String get scanPrintedCode => 'Скенирај штампани код';

  @override
  String get chipScanHint =>
      'Скенира штампани QR/бар-код са картице чипа или ветеринарских папира — чип у мачки телефон не може да очита.';

  @override
  String get chipScanHintNeutral =>
      'Скенира штампани QR/бар-код са картице чипа или ветеринарских папира — чип у животињи телефон не може да очита.';

  @override
  String get savingLabel => 'Чување…';

  @override
  String ownerOfCat(String name) {
    return 'Власник од $name';
  }

  @override
  String get sortLabel => 'Сортирај';

  @override
  String get viewAsTable => 'Прикажи као табелу';

  @override
  String get viewAsTiles => 'Прикажи као плочице';

  @override
  String get viewAsList => 'Прикажи као листу';

  @override
  String get ageLabel => 'Старост';

  @override
  String get catList => 'Листа мачака';

  @override
  String get catListNeutral => 'Листа љубимаца';

  @override
  String get matchCandidatesTitle => 'Могући парови';

  @override
  String get findDuplicates => 'Пронађи дупликате';

  @override
  String get noDuplicates => 'Тренутно нема могућих дупликата.';

  @override
  String get similarName => 'Слично име';

  @override
  String get sharePublicly => 'Подели јавно…';

  @override
  String get pickFramesTitle => 'Избор кадрова';

  @override
  String get suggestedFrames => 'Предложени кадрови';

  @override
  String get scrubFrames => 'Премотавање видеа';

  @override
  String get keepThisFrame => 'Задржи овај кадар';

  @override
  String get fromVideo => 'Из видеа…';

  @override
  String addingPhotos(int done, int total) {
    return 'Додавање фотографије $done од $total…';
  }

  @override
  String get videoMobileOnly =>
      'Избор кадрова из видеа ради у апликацији за телефон (Android и iPhone) — на овом уређају још не.';

  @override
  String get shareWhitelistExplainer =>
      'Одаберите шта иде у датотеку. Укључена су само означена поља.';

  @override
  String get exportShareFile => 'Извези датотеку за дељење…';

  @override
  String get hostedLink => 'Хостована веза (URL отпремљене датотеке)';

  @override
  String get inlineQr => 'Уграђени QR (само текст, без фотографија)';

  @override
  String get inlineTooBig =>
      'Превише података за уграђени код — уклоните поља или користите хостовану везу.';

  @override
  String get scanShareLabel => 'Скенирај код за дељење';

  @override
  String get notAShareCode => 'Тај код није cat(a)log дељење.';

  @override
  String get importShareTitle => 'Увести ову мачку?';

  @override
  String get importShareTitleNeutral => 'Увести овог љубимца?';

  @override
  String shareSource(String url) {
    return 'Извор: $url';
  }

  @override
  String get importLabel => 'Увези';

  @override
  String get strayAreaLabel => 'Могућа зона лутања';

  @override
  String get prevPin => 'Претходна игла';

  @override
  String get nextPin => 'Следећа игла';

  @override
  String get noMissingCats => 'Још нема несталих мачака са позицијама огласа.';

  @override
  String get noMissingCatsNeutral =>
      'Још нема несталих љубимаца са позицијама огласа.';

  @override
  String get noMatchCandidates => 'Тренутно нема могућих парова.';

  @override
  String sameIdField(String field) {
    return 'Исти $field';
  }

  @override
  String metersApart(String distance) {
    return 'Удаљени $distance м';
  }

  @override
  String get addFlier => 'Додај оглас';

  @override
  String get missingSinceLabel => 'Нестао од';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get cropPortrait => 'Исеци портрет';

  @override
  String get statusOwner => 'Власник';

  @override
  String get ocrUnavailable =>
      'Препознавање текста није доступно на овом уређају — унесите текст огласа сами.';

  @override
  String get displayFormat => 'Приказано као';

  @override
  String get displayPlain => 'Обичан текст';

  @override
  String get displayQr => 'QR код';

  @override
  String get displayBarcode => 'Бар-код';

  @override
  String get editLabel => 'Уреди';

  @override
  String get doneLabel => 'Готово';

  @override
  String get openSettings => 'Otvori podešavanja';

  @override
  String get notSaved => 'Није сачувано';

  @override
  String get birthdateInFuture => 'Датум рођења не може бити у будућности.';

  @override
  String get deceasedInFuture => 'Датум смрти не може бити у будућности.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Датум смрти не може бити пре датума рођења ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Датум рођења не може бити после датума смрти ($date).';
  }

  @override
  String get malePregnant =>
      'Ова мачка је уписана као мужјак — мужјак не може бити гравидан. Прво проверите пол.';

  @override
  String get malePregnantNeutral =>
      'Овај љубимац је уписан као мужјак — мужјак не може бити гравидан. Прво проверите пол.';

  @override
  String fatherNotMale(String name) {
    return '$name је уписана као женка и не може бити отац. Прво проверите пол.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name је уписан као мужјак и не може бити мајка. Прво проверите пол.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name је рођен $date — родитељ не може бити рођен после свог младунца.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name је рођен $date — родитељ не може бити рођен после свог младунца.';
  }

  @override
  String get genderFatherFemale =>
      'Ова мачка је уписана као отац других мачака — отац не може бити женка. Прво проверите породицу.';

  @override
  String get genderFatherFemaleNeutral =>
      'Овај љубимац је уписан као отац других љубимаца — отац не може бити женка. Прво проверите породицу.';

  @override
  String get genderMotherMale =>
      'Ова мачка је уписана као мајка других мачака — мајка не може бити мужјак. Прво проверите породицу.';

  @override
  String get genderMotherMaleNeutral =>
      'Овај љубимац је уписан као мајка других љубимаца — мајка не може бити мужјак. Прво проверите породицу.';

  @override
  String get moveTo => 'Премести у';

  @override
  String get noClowderStrayOption => 'Без клаудера — луталица / побегла';

  @override
  String get noClowderStrayOptionNeutral =>
      'Без домаћинства — луталица / побегао';

  @override
  String timelineOf(String name) {
    return 'Временска линија — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

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
  String dateFormatError(String format) {
    return 'Погрешан формат — користите $format';
  }

  @override
  String get dateInFuture => 'Овај датум не може бити у будућности.';

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
  String get forCatsNeutral => 'љубимце';

  @override
  String get forClowders => 'клаудере';

  @override
  String get forClowdersNeutral => 'домаћинства';

  @override
  String get forBoth => 'обоје';

  @override
  String get optionsOnePerLine => 'Опције (једна по реду)';

  @override
  String get ownValue => 'Sopstvena vrednost';

  @override
  String get renameField => 'Преименуј поље';

  @override
  String get editOptions => 'Uredi opcije…';

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
  String get searchByNameHintNeutral => 'Тражи љубимце по имену…';

  @override
  String get host => 'Домаћин';

  @override
  String get hostExplainer =>
      'Почните овде, затим скенирајте код или га унесите на другом уређају.';

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
      'Оба уређаја користе исту фасциклу (нпр. у Nextcloud-у или на USB стику). Свака синхронизација тамо оставља ваше промене и преузима туђе.';

  @override
  String get noFolderChosenYet => 'Фасцикла још није изабрана';

  @override
  String get choose => 'Изабери…';

  @override
  String get syncFolderNow => 'Синхронизуј фасциклу сада';

  @override
  String folderCatalogHint(Object name) {
    return 'Унутра овај каталог користи фасциклу „$name“, па једна дељена фасцикла може да носи све ваше каталоге.';
  }

  @override
  String get useSameFolder => 'Користи исту фасциклу као други каталози';

  @override
  String get folderHint =>
      'Довољна је свака фасцикла коју два уређаја држе истом: диск у облаку или Syncthing за фасциклу која остаје на вашим телефонима. Syncthing је бесплатан: инсталирајте га на сваки телефон, поделите једну фасциклу међу њима и изаберите ту фасциклу овде на сваком уређају.';

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
  String trailOf(String name, int count) {
    return 'Рута: $name ($count виђења)';
  }

  @override
  String trailOfField(String name, String field, int count) {
    return 'Траг: $name — $field ($count вредности)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Траг: $name ($count позиција)';
  }

  @override
  String conflictOn(String field) {
    return 'Сукоб — $field';
  }

  @override
  String get conflictBody =>
      'Промењено на два места истовремено. Изаберите шта је тачно:';

  @override
  String privateMarker(Object field) {
    return '$field (приватно)';
  }

  @override
  String conflictSame(Object value) {
    return 'Обе измене кажу исто: $value. Нема шта да се бира; „Реши“ склања ознаку.';
  }

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
  String get kindCatNeutral => 'љубимац';

  @override
  String get kindClowder => 'клаудер';

  @override
  String get kindClowderNeutral => 'домаћинство';

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
  String get aboutTaglineNeutral =>
      'Локални каталог за љубимце о којима бринете. Ваши подаци остају на вашим уређајима — без сервера, без налога.';

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
  String get coffeeSubtitle =>
      'Апликација остаје бесплатна. Чак и ако не добијем кафу :)';

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
  String get starterBreed => 'Rasa';

  @override
  String get valueMixed => 'mešanac';

  @override
  String get breedEuropeanShorthair => 'Evropska kratkodlaka';

  @override
  String get breedMaineCoon => 'Mejn kun';

  @override
  String get breedBritishShorthair => 'Britanska kratkodlaka';

  @override
  String get breedNorwegianForestCat => 'Norveška šumska mačka';

  @override
  String get breedRagdoll => 'Regdol';

  @override
  String get breedSiamese => 'Sijamska';

  @override
  String get breedPersian => 'Persijska';

  @override
  String get breedBengal => 'Bengalska';

  @override
  String get breedSphynx => 'Sfinks';

  @override
  String get breedAbyssinian => 'Абисинска';

  @override
  String get breedAmericanShorthair => 'Америчка краткодлака';

  @override
  String get breedBalinese => 'Балинезијска';

  @override
  String get breedBirman => 'Бирманска';

  @override
  String get breedBombay => 'Бомбајска';

  @override
  String get breedBurmese => 'Бурманска';

  @override
  String get breedBurmilla => 'Бурмила';

  @override
  String get breedBritishLonghair => 'Британска дугодлака';

  @override
  String get breedChartreux => 'Шартрез';

  @override
  String get breedCornishRex => 'Корниш рекс';

  @override
  String get breedDevonRex => 'Девон рекс';

  @override
  String get breedEgyptianMau => 'Египатска мау';

  @override
  String get breedExoticShorthair => 'Егзотична краткодлака';

  @override
  String get breedHimalayan => 'Хималајска';

  @override
  String get breedKorat => 'Корат';

  @override
  String get breedManx => 'Манкс';

  @override
  String get breedMunchkin => 'Манчкин';

  @override
  String get breedOcicat => 'Оцикет';

  @override
  String get breedOrientalShorthair => 'Оријентална краткодлака';

  @override
  String get breedRagamuffin => 'Рагамафин';

  @override
  String get breedRussianBlue => 'Руска плава';

  @override
  String get breedSavannah => 'Савана';

  @override
  String get breedScottishFold => 'Шкотска клемпава';

  @override
  String get breedSelkirkRex => 'Селкирк рекс';

  @override
  String get breedSiberian => 'Сибирска';

  @override
  String get breedSnowshoe => 'Сноушу';

  @override
  String get breedSomali => 'Сомалијска';

  @override
  String get breedTonkinese => 'Тонкинска';

  @override
  String get breedTurkishAngora => 'Турска ангора';

  @override
  String get breedTurkishVan => 'Турска ван';

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
  String get starterEmail => 'Имејл';

  @override
  String get starterPhone => 'Телефон';

  @override
  String get lookupUrlLabel => 'Веза за проверу';

  @override
  String lookupUrlHelp(String token) {
    return 'Страница сервиса са $token на месту броја, нпр. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Провери';

  @override
  String lookupFailed(String url) {
    return 'Ниједна апликација није могла да отвори $url. Копирајте везу у прегледач.';
  }

  @override
  String get stepCat => 'Мачка';

  @override
  String get stepCatNeutral => 'Љубимац';

  @override
  String get stepOwner => 'Власник';

  @override
  String get stepFace => 'Фотографија њушке';

  @override
  String get stepRegistry => 'Регистар';

  @override
  String get stepReview => 'Провери и сачувај';

  @override
  String get stepOwnerHint =>
      'Ко тражи мачку — од тога настаје његов клаудер са контактом са огласа.';

  @override
  String get stepOwnerHintNeutral =>
      'Ко тражи љубимца — од тога настаје његово домаћинство са контактом са огласа.';

  @override
  String get stepFaceHint =>
      'Исеци њушку мачке са огласа; постаје профилна слика. Можеш и да прескочиш.';

  @override
  String get stepFaceHintNeutral =>
      'Исеци њушку љубимца са огласа; постаје профилна слика. Можеш и да прескочиш.';

  @override
  String get stepRegistryHint =>
      'Бројеви пронађени на огласу. Означени се чувају уз мачку и могу се касније отворити.';

  @override
  String get stepRegistryHintNeutral =>
      'Бројеви пронађени на огласу. Означени се чувају уз љубимца и могу се касније отворити.';

  @override
  String get noRegistryLinks =>
      'На овом огласу нема веза ка регистрима — ако је нека превиђена, пријавите грешку.';

  @override
  String get unknownServiceHint => 'Непозната услуга';

  @override
  String get rememberService => 'Запамти услугу';

  @override
  String get rememberServiceHint =>
      'Именуј услугу и покажи број у вези. Следећи оглас попуниће се сам.';

  @override
  String get noIdInLink =>
      'Ова веза не садржи број који би апликација могла да сачува.';

  @override
  String get whichNumber => 'Који део је број?';

  @override
  String get cropAgain => 'Исеци поново';

  @override
  String get noFaceYet =>
      'Још нема фотографије њушке — користи се фотографија огласа.';

  @override
  String get backLabel => 'Назад';

  @override
  String get dangerButton => 'НЕ ПРИТИСКАЈ.\nОПАСНОСТ';

  @override
  String get dangerThanks => 'Хвала што користиш cat(a)log!';

  @override
  String get helpTitle => 'Помоћ';

  @override
  String get showTipsAgain => 'Прикажи савете поново';

  @override
  String get helpHome =>
      'Преглед твојих колонија — колонија је место где живе мачке: твој дом, привремени смештај, склониште. Додирни картицу за њене мачке; дуги притисак отвара мени. Дугме доле десно прави колонију, а картица луталица скупља све мачке без дома. Име на врху је каталог у ком си — додирни га да промениш или додаш нови.';

  @override
  String get helpHomeNeutral =>
      'Преглед твојих домаћинстава — домаћинство је место где живе љубимци: твој дом, привремени смештај, склониште. Додирни картицу за његове љубимце; дуги притисак отвара мени. Дугме доле десно прави домаћинство, а картица луталица скупља све љубимце без дома. Име на врху је каталог у ком си — додирни га да промениш или додаш нови.';

  @override
  String get helpClowder =>
      'Све о овом месту: његове мачке, поља (адреса, контакт, врста) и историја. Страница се отвара само за читање; оловка укључује уређивање, где можеш додати и ново поље. Дуги притисак на поље уређује га одмах, на мачку је премешта, скрива или отвара. Термин додат овде може да поведе више мачака колоније, на пример на стерилизацију: означи мачке које иду, заврши једном, одзначи оне које нису третиране. Сат уз поље отвара његову историју.';

  @override
  String get helpClowderNeutral =>
      'Све о овом месту: његови љубимци, поља (адреса, контакт, врста) и историја. Страница се отвара само за читање; оловка укључује уређивање, где можеш додати и ново поље. Дуги притисак на поље уређује га одмах, на љубимца га премешта, скрива или отвара. Термин додат овде може да поведе више љубимаца домаћинства, на пример на стерилизацију: означи љубимце који иду, заврши једном, одзначи оне који нису третирани. Сат уз поље отвара његову историју.';

  @override
  String get helpCat =>
      'Све о овој мачки: фотографије, поља, породица, историја. Страница је само за читање док не додирнеш оловку. Дуго притисни поље да га одмах уредиш; дуго притисни фотографију за њен мени. Мени горе десно држи остало: сакриј, споји, забележи виђење, подели мачку. „Приватно“ се поставља при уређивању поља. Сат уз поље отвара његову историју.';

  @override
  String get helpCatNeutral =>
      'Све о овом љубимцу: фотографије, поља, породица, историја. Страница је само за читање док не додирнеш оловку. Дуго притисни поље да га одмах уредиш; дуго притисни фотографију за њен мени. Мени горе десно држи остало: сакриј, споји, забележи виђење, подели љубимца. „Приватно“ се поставља при уређивању поља. Сат уз поље отвара његову историју.';

  @override
  String get helpStrays =>
      'Мачке које тренутно немају дом: пронађене, побегле или са огласа. Дугме са камером бележи мачку испред тебе; дугме са огласом претвара плакат у мачку са контактом власника; скенер чита cat(a)log код са плаката. Додирни Stray Cam за фотографију; задржи да снимиш видео и задржиш најбоље кадрове као фотографије.';

  @override
  String get helpStraysNeutral =>
      'Љубимци који тренутно немају дом: пронађени, побегли или са огласа. Дугме са камером бележи животињу испред тебе; дугме са огласом претвара плакат у љубимца са контактом власника; скенер чита cat(a)log код са плаката. Додирни Stray Cam за фотографију; задржи да снимиш видео и задржиш најбоље кадрове као фотографије.';

  @override
  String get helpMap =>
      'Све мачке и места са позицијом. Претрага налази мачке, особе и места — непознато име тражи се у целом свету. Дугме слојева црта кругове од 500 м око места огласа нестале мачке и око дома из којег је побегла. Стрелице иду од чиоде до чиоде, дуги притисак на карту бележи виђење. Свако поље за место је чиода на мапи; додирните чиоду за њен траг.';

  @override
  String get helpMapNeutral =>
      'Сви љубимци и места са позицијом. Претрага налази љубимце, особе и места — непознато име тражи се у целом свету. Дугме слојева црта кругове од 500 м око места огласа несталог љубимца и око дома из којег је побегао. Стрелице иду од чиоде до чиоде, дуги притисак на карту бележи виђење. Свако поље за место је чиода на мапи; додирните чиоду за њен траг.';

  @override
  String get helpCard =>
      'Картица мачке за штампу: горе чиповима бираш шта је на њој, затим је делиш као слику или PDF. Бројеви се могу штампати као QR или баркод, а позиција постаје QR који отвара карту, уз кратак Plus Code.';

  @override
  String get helpCardNeutral =>
      'Картица љубимца за штампу: горе чиповима бираш шта је на њој, затим је делиш као слику или PDF. Бројеви се могу штампати као QR или баркод, а позиција постаје QR који отвара карту, уз кратак Plus Code.';

  @override
  String get helpSync =>
      'Како подаци стижу до других: директно повезивање, фасцикла коју виде оба уређаја, или датотека послата месинџером. Увек ти одлучујеш шта одлази — а примљене .catsync датотеке отварају се такође овде. Сваки каталог потписује оно што пише својим кључем; партнери виде код кључа поред вашег имена. Први кључ партнера прихвата се на поверење из датотеке и важи као потврђен кад синхронизујете лично. Уноси под познатим именом без исправног потписа се одбијају и наводе на страници приспећа.';

  @override
  String get helpFields =>
      'Поља која твој каталог користи. Преименуј их, промени могућности поља са избором или додај своја. Поље са идентификатором може показивати на сервис (регистар), па број код мачке постаје додирљив.';

  @override
  String get helpFieldsNeutral =>
      'Поља која твој каталог користи. Преименуј их, промени могућности поља са избором или додај своја. Поље са идентификатором може показивати на сервис (регистар), па број код љубимца постаје додирљив.';

  @override
  String get helpTimeline =>
      'Свака измена, најновија прва: ко, када и на коју вредност. Додирните унос да га исправите, задржите да га уклоните или вратите; скривени унос остаје у дневнику и приказује се на захтев.';

  @override
  String get helpDuplicates =>
      'Мачке или колоније које изгледају као исти унос двапут — исти бројеви или врло слична имена са подударним детаљима. Додирни пар за спајање; спајање се не може поништити па се прво пита.';

  @override
  String get helpDuplicatesNeutral =>
      'Љубимци или домаћинства који изгледају као исти унос двапут — исти бројеви или врло слична имена са подударним детаљима. Додирни пар за спајање; спајање се не може поништити па се прво пита.';

  @override
  String get helpMatches =>
      'Мачке које би могле бити иста животиња: исти број или луталица виђена унутар подручја претраге нестале мачке. Додирни пар за спајање, дугим притиском отвори прву мачку за поређење. На листи су и парови чији се изглед слаже у бар два обележја без противречности; чипови показују која. „Није исто“ скрива пар на овом телефону док се изглед једне од животиња не промени.';

  @override
  String get helpMatchesNeutral =>
      'Љубимци који би могли бити иста животиња: исти број или луталица виђена унутар подручја претраге несталог љубимца. Додирни пар за спајање, дугим притиском отвори првог љубимца за поређење. На листи су и парови чији се изглед слаже у бар два обележја без противречности; чипови показују која. „Није исто“ скрива пар на овом телефону док се изглед једне од животиња не промени.';

  @override
  String get helpFlier =>
      'Фотографисани оглас постаје мачка и њен власник. Корак по корак: подаци мачке, контакт власника, исецање њушке за профилну слику, бројеви регистара са огласа, па завршна провера. Све су то предлози — исправи оно што је камера погрешно прочитала.';

  @override
  String get helpFlierNeutral =>
      'Фотографисани оглас постаје љубимац и његов власник. Корак по корак: подаци љубимца, контакт власника, исецање њушке за профилну слику, бројеви регистара са огласа, па завршна провера. Све су то предлози — исправи оно што је камера погрешно прочитала.';

  @override
  String get archiveTitle => 'Архива';

  @override
  String get archiveExplainer =>
      'Угинуле мачке и празне колоније које нико није дирао годинама и даље заузимају простор — највише њихове фотографије. Архивирање их уписује у датотеку коју задржиш и затим их брише одавде.';

  @override
  String get archiveExplainerNeutral =>
      'Угинули љубимци и празна домаћинства које нико није дирао годинама и даље заузимају простор — највише њихове фотографије. Архивирање их уписује у датотеку коју задржиш и затим их брише одавде.';

  @override
  String get archiveAction => 'Архивирај';

  @override
  String archiveSelected(int count) {
    return 'Архивирај $count уноса';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Архивирати $count уноса?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names биће уписани у датотеку и затим избрисани — на твом уређају и на сваком с којим синхронизујеш. Увоз датотеке враћа све; без ње су изгубљени.';
  }

  @override
  String archiveDone(int count) {
    return 'Архивирано и избрисано $count уноса';
  }

  @override
  String archiveFailed(String error) {
    return 'Ништа није избрисано: датотеку архиве није било могуће записати ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'База $db, фотографије $photos у $count датотека';
  }

  @override
  String quietForYears(int years) {
    return 'Без промена $years година';
  }

  @override
  String get nothingToArchive => 'Ништа није довољно старо за архивирање.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Последња промена $date · фотографије $size';
  }

  @override
  String get helpArchive =>
      'Стари подаци троше простор, највише фотографије које носи сваки синхронизовани уређај. Овде бираш угинуле мачке и празне колоније које годинама мирују, уписујеш их у датотеку коју задржиш и бришеш их. Брисање стиже до свих с којима синхронизујеш; увоз датотеке враћа све.';

  @override
  String get helpArchiveNeutral =>
      'Стари подаци троше простор, највише фотографије које носи сваки синхронизовани уређај. Овде бираш угинуле љубимце и празна домаћинства која годинама мирују, уписујеш их у датотеку коју задржиш и бришеш их. Брисање стиже до свих с којима синхронизујеш; увоз датотеке враћа све.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Вратити $count избрисаних уноса?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names су избрисани у овом каталогу, а датотека коју си управо увезао их садржи. Враћање их враћа овде и на сваки уређај с којим синхронизујеш.';
  }

  @override
  String get restoreAction => 'Врати';

  @override
  String get keepDeleted => 'Остави избрисано';

  @override
  String get archiveNotSaved =>
      'Ништа није избрисано: архива нигде није сачувана.';

  @override
  String get locateAddress => 'Пронађи адресу на карти';

  @override
  String get addressFoundTitle => 'Адреса пронађена';

  @override
  String get replaceAddressOption => 'Замени адресу овом';

  @override
  String get addPositionOption => 'Сачувај локацију';

  @override
  String get addressLocated => 'Адреса пронађена';

  @override
  String get addressNotFound =>
      'За ову адресу није пронађено место. Провери правопис или остави празно.';

  @override
  String get starterPosition => 'Локација';

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
  String get markTitleNeutral => 'Означи љубимца';

  @override
  String get applyCrop => 'Isecite';

  @override
  String get useFullPhoto => 'Користи целу фотографију';

  @override
  String get dragToSelect => 'Превуци правоугаоник око мачке';

  @override
  String get dragToSelectNeutral => 'Превуци правоугаоник око љубимца';

  @override
  String get dragOverTheCat => 'Превуци елипсу преко мачке';

  @override
  String get dragOverTheCatNeutral => 'Превуци елипсу преко љубимца';

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
  String lastBackupFailed(String error) {
    return 'Poslednja automatska rezervna kopija nije uspela: $error';
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
  String get typeUnitValue => 'Вредност са јединицом';

  @override
  String get dimension => 'Величина';

  @override
  String get dimensionWeight => 'Тежина';

  @override
  String get dimensionLength => 'Дужина';

  @override
  String get dimensionVolume => 'Запремина';

  @override
  String get dimensionTemperature => 'Температура';

  @override
  String get unitsLabel => 'Јединице';

  @override
  String get catalogHolds => 'Овај каталог садржи';

  @override
  String get modeCats => 'Мачке';

  @override
  String get modePets => 'Љубимци';

  @override
  String get graphLabel => 'График';

  @override
  String get fieldHistoryTooltip => 'Историја';

  @override
  String get rangeWeek => 'Недеља';

  @override
  String get rangeMonth => 'Месец';

  @override
  String get rangeYear => 'Година';

  @override
  String get rangeAll => 'Све';

  @override
  String get rangeCustom => 'Прилагођено…';

  @override
  String changeSince(String delta, String date) {
    return '$delta од $date';
  }

  @override
  String get unitsAuto => 'Као у твом региону';

  @override
  String get unitsMetric => 'Метричке (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Империјалне (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Тежина';

  @override
  String get starterLooks => 'Изглед';

  @override
  String get looksGroupSize => 'Величина';

  @override
  String get looksGroupColours => 'Боје';

  @override
  String get looksGroupPattern => 'Шара';

  @override
  String get looksGroupFur => 'Крзно';

  @override
  String get looksGroupTail => 'Реп';

  @override
  String get looksGroupEars => 'Уши';

  @override
  String get looksGroupMarks => 'Обележја';

  @override
  String get looksGroupCrest => 'Ћуба';

  @override
  String get looksGroupBeak => 'Кљун';

  @override
  String get looksGroupRing => 'Прстен';

  @override
  String get looksValueSmall => 'Мали';

  @override
  String get looksValueMedium => 'Средњи';

  @override
  String get looksValueLarge => 'Велики';

  @override
  String get looksValueBlack => 'Црна';

  @override
  String get looksValueWhite => 'Бела';

  @override
  String get looksValueGrey => 'Сива';

  @override
  String get looksValueBrown => 'Смеђа';

  @override
  String get looksValueGinger => 'Риђа';

  @override
  String get looksValueCream => 'Крем';

  @override
  String get looksValueGolden => 'Златна';

  @override
  String get looksValueTan => 'Светлосмеђа';

  @override
  String get looksValueGreen => 'Зелена';

  @override
  String get looksValueBlue => 'Плава';

  @override
  String get looksValueYellow => 'Жута';

  @override
  String get looksValueRed => 'Црвена';

  @override
  String get looksValueOrange => 'Наранџаста';

  @override
  String get looksValuePink => 'Розе';

  @override
  String get looksValueWhiteBib => 'Бели прслук';

  @override
  String get looksValueWhitePaws => 'Беле шапе';

  @override
  String get looksValueWhiteTailTip => 'Бели врх репа';

  @override
  String get looksValueBlaze => 'Звезда';

  @override
  String get looksValueMask => 'Маска';

  @override
  String get looksValueSpots => 'Тачкице';

  @override
  String get looksValuePatches => 'Флеке';

  @override
  String get looksValueStripes => 'Пруге';

  @override
  String get looksValueScar => 'Ожиљак';

  @override
  String get looksValueNotchedEar => 'Засечено уво';

  @override
  String get looksValueEarTip => 'Врх ува';

  @override
  String get looksValueCollar => 'Огрлица';

  @override
  String get looksValueShort => 'Кратка';

  @override
  String get looksValueLong => 'Дуга';

  @override
  String get looksValueHairless => 'Без длаке';

  @override
  String get looksValueBobtail => 'Кратак реп';

  @override
  String get looksValueNone => 'Нема';

  @override
  String get looksValueCurled => 'Уврнут';

  @override
  String get looksValueUpright => 'Усправне';

  @override
  String get looksValueFloppy => 'Клемпаве';

  @override
  String get looksValueFolded => 'Пресавијене';

  @override
  String get looksValueRounded => 'Заобљене';

  @override
  String get looksValueSolid => 'Једнобојна';

  @override
  String get looksValueTabby => 'Тиграста';

  @override
  String get looksValueTortoiseshell => 'Корњачина';

  @override
  String get looksValueCalico => 'Калико';

  @override
  String get looksValueColourpoint => 'Колорпоинт';

  @override
  String get looksValueBicolour => 'Двобојна';

  @override
  String get looksValueTuxedo => 'Смокинг';

  @override
  String get looksValueBrindle => 'Пругаста';

  @override
  String get looksValueMerle => 'Мерл';

  @override
  String get looksValueSpotted => 'Тачкаста';

  @override
  String get looksValuePatched => 'Шарена';

  @override
  String get looksValueTricolour => 'Тробојна';

  @override
  String get looksValueSable => 'Самуровина';

  @override
  String get looksGroupEyes => 'Очи';

  @override
  String get looksGroupFeatures => 'Особености';

  @override
  String get looksValueAmber => 'Ћилибарне';

  @override
  String get looksValueCopper => 'Бакарне';

  @override
  String get looksValueOddEyed => 'Разнобојне';

  @override
  String get looksValueChocolate => 'Чоколадна';

  @override
  String get looksValueLilac => 'Лила';

  @override
  String get looksValueSilver => 'Сребрна';

  @override
  String get looksValueSmoke => 'Димна';

  @override
  String get looksValueTicked => 'Тикирани';

  @override
  String get looksValueVan => 'Ван';

  @override
  String get looksValueCurly => 'Коврџава';

  @override
  String get looksValueWiry => 'Оштра';

  @override
  String get looksValueKinked => 'Преломљен';

  @override
  String get looksValueCropped => 'Купиране';

  @override
  String get looksValueTippedEar => 'Одсечен врх ува';

  @override
  String get looksValueEarTattoo => 'Тетоважа у уву';

  @override
  String get looksValueMissingEar => 'Недостаје уво';

  @override
  String get looksValueMissingEye => 'Недостаје око';

  @override
  String get looksValueCloudyEye => 'Замућено око';

  @override
  String get looksValueMissingFrontLeg => 'Недостаје предња нога';

  @override
  String get looksValueMissingHindLeg => 'Недостаје задња нога';

  @override
  String get looksValueNoTeeth => 'Без зуба';

  @override
  String get looksValueExtraToes => 'Додатни прсти';

  @override
  String get rejectMatch => 'Није исто';

  @override
  String traitsAgree(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count обележја се слаже',
      few: '$count обележја се слажу',
      one: '$count обележје се слаже',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Системски подразумевано';

  @override
  String get iosLocalNetworkHint =>
      'Ако и даље не успева на iPhone/iPad-у: Подешавања → Приватност и безбедност → Локална мрежа → дозволи cat(a)log па покушај поново.';

  @override
  String get includePrivate => 'Подели приватне податке';

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
  String get starterStatus => 'Тип';

  @override
  String get statusFoster => 'Хранитељски дом';

  @override
  String get statusForeverHome => 'Дом';

  @override
  String get statusClinic => 'Клиника';

  @override
  String get statusShelter => 'Склониште';

  @override
  String get statusBarn => 'Штала';

  @override
  String get valueCat => 'Мачка';

  @override
  String get valueDog => 'Пас';

  @override
  String get valueRabbit => 'Зец';

  @override
  String get valueGuineaPig => 'Заморац';

  @override
  String get valueHamster => 'Хрчак';

  @override
  String get valueBird => 'Птица';

  @override
  String get valueHorse => 'Коњ';

  @override
  String get valueTortoise => 'Корњача';

  @override
  String get valueFerret => 'Твор';

  @override
  String get otherOption => 'Друго…';

  @override
  String get celebrationsToggle => 'Прослави усвајања';

  @override
  String get celebrationsSubtitle =>
      'Конфете и клицање када се мачка сели у свој дом';

  @override
  String get cheerToggle => 'Звук славља';

  @override
  String get cheerSubtitle => 'Кратко славље уз конфете, сваки пут другачије';

  @override
  String get celebrationsSubtitleNeutral =>
      'Конфете и клицање када се љубимац сели у свој дом';

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
  String get mapSearchHintNeutral => 'Тражи љубимце, домаћинства, особе';

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
  String get yourKey => 'Твој кључ';

  @override
  String get yourTitle => 'Твоја титула';

  @override
  String get titleNone => 'Без титуле';

  @override
  String keyLine(Object code) {
    return 'кључ $code';
  }

  @override
  String get keyVerified => 'потврђен лично';

  @override
  String get keyFromFile => 'из датотеке, још непотврђен';

  @override
  String get keyUnsigned => 'још нема кључа, уноси непотписани';

  @override
  String get summaryRefused => 'Одбијено';

  @override
  String refusedEntries(int count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count уноса одбијено',
      few: '$count уноса одбијена',
      one: '$count унос одбијен',
    );
    return '$_temp0: нису потписани познатим кључем за $name';
  }

  @override
  String newKeyCallsItself(Object code, Object name) {
    return 'Нови кључ $code назива се $name. Провери код те особе пре него што му поверујеш.';
  }

  @override
  String keyChangedRefused(Object name) {
    return '$name је понудио кључ различит од овде познатог. Познати остаје; нови није узет.';
  }

  @override
  String metaNewKey(Object name, Object code, Object how) {
    return 'Нови кључ: $name · $code ($how)';
  }

  @override
  String hardDeleteWarningKey(Object name, Object key) {
    return 'Уклања из овог каталога сваки унос и фотографију које је $name написао под кључем $key. Други уређаји задржавају своје. Не може се поништити.';
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
  String conflictsMenu(int n) {
    return 'Конфликти ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Овде сте решили конфликт, зато „Одбаци“ није доступно: поништило би и то.';

  @override
  String get arrivalIntro =>
      'Ове измене су већ у вашем каталогу. „Одбаци“ га враћа како је било.';

  @override
  String get summaryUpdated => 'Измењени';

  @override
  String get summaryDeleted => 'Избрисани';

  @override
  String get keepMine => 'Задржи моје';

  @override
  String keptMine(String name) {
    return 'Ваша верзија за $name остаје на овом уређају.';
  }

  @override
  String get summaryMeta => 'Такође стигло';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n измена',
      few: '$n измене',
      one: '$n измена',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Прихвати';

  @override
  String get rejectArrival => 'Одбаци';

  @override
  String get photoAdded => 'Додата фотографија';

  @override
  String get photoNotReceived => 'Фотографија још није примљена';

  @override
  String get photoRemoved => 'Уклоњена фотографија';

  @override
  String metaFieldAdded(String name) {
    return 'Ново поље: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Измењено поље: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser спојено у $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n фотографија',
      few: '$n фотографије',
      one: '$n фотографија',
    );
    return '$_temp0';
  }

  @override
  String get starterMother => 'Мајка';

  @override
  String get starterFather => 'Отац';

  @override
  String get familySection => 'Породица';

  @override
  String get littermatesLabel => 'Из истог легла';

  @override
  String get siblingsLabel => 'Браћа и сестре';

  @override
  String get kittensLabel => 'Мачићи';

  @override
  String get kittensLabelNeutral => 'Младунци';

  @override
  String get toastSettingsTitle => 'Шта најавити';

  @override
  String get toastSettingsSubtitle => 'Мале поруке након синхронизације';

  @override
  String get toastKindAdoptions => 'Усвајања';

  @override
  String get toastKindBirths => 'Рођења';

  @override
  String get toastKindDeaths => 'Смрти';

  @override
  String get toastKindEscapes => 'Бегови';

  @override
  String get toastKindMoves => 'Селидбе';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat удомљена код $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Ново маче: $cat ✨';
  }

  @override
  String toastBornNeutral(Object cat) {
    return '✨ Ново младунче: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat је угинула';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat је побегла';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat се преселила у $home';
  }

  @override
  String get notACatlogFile => 'Ово није cat(a)log датотека';

  @override
  String get nothingNewInBundle => 'Ништа ново у датотеци — већ имаш све';

  @override
  String get syncChooserInPerson => 'Уживо';

  @override
  String get syncChooserInPersonSub => 'Синхронизација преко Wi-Fi';

  @override
  String get syncChooserRemote => 'На даљину';

  @override
  String get syncChooserRemoteSub => 'Синхронизација преко фасцикле или USB-а';

  @override
  String get syncChooserMessenger => 'Месинџер';

  @override
  String get syncChooserMessengerSub => 'Извоз и увоз преко друштвених мрежа';

  @override
  String get connectToWifiFirst =>
      'Прво се повежи на Wi-Fi — тада се уређаји проналазе';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) жели синхронизацију';
  }

  @override
  String get trustBothWaysNote => 'Каталози ће се разменити у оба смера.';

  @override
  String get allowOnce => 'Дозволи';

  @override
  String get allowAlways => 'Увек дозволи овај уређај';

  @override
  String get declineAction => 'Одбиј';

  @override
  String get syncDeclined => 'Други уређај је одбио синхронизацију';

  @override
  String get trustedDevicesSection => 'Увек дозвољени уређаји';

  @override
  String get removeTrust => 'Уклони';

  @override
  String get hostWithoutWifi => 'Хостуј без Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Успоставља привремену директну везу са другим телефоном (без интернета). Користи је само cat(a)log и сама се прекида након синхронизације.';

  @override
  String get hotspotAndroidOnly =>
      'Овај код захтева два Android телефона — на iPhone/iPad користи заједнички Wi-Fi';

  @override
  String get selectClowderHint => 'Изабери клаудер лево';

  @override
  String get selectClowderHintNeutral => 'Изабери домаћинство лево';

  @override
  String get introTitle1 => 'Ваше мачке, прегледно';

  @override
  String get introTitle1Neutral => 'Ваши љубимци, прегледно';

  @override
  String get introBody1 =>
      'Направите картицу за сваку мачку: фотографија, пол, здравље, шта год желите да забележите. Мачке су груписане по месту где живе — апликација га зове колонија (clowder).';

  @override
  String get introBody1Neutral =>
      'Направите картицу за сваког љубимца о ком бринете: фотографија, пол, здравље, шта год желите да забележите. Љубимци су груписани по месту где живе — апликација га зове домаћинство.';

  @override
  String get introTitle2 => 'Ради без интернета';

  @override
  String get introBody2 =>
      'Све се чува само на вашем телефону. Без налога, без облака. Ништа се не шаље док сами не поделите.';

  @override
  String get introTitle3 => 'Радите заједно';

  @override
  String get introBody3 =>
      'Свако користи своју апликацију и повремено размењујете податке: нађите се и скенирајте код, користите заједничку фасциклу или пошаљите једну датотеку месинџером. После тога сви имају исте податке.';

  @override
  String get introSkip => 'Прескочи';

  @override
  String get introNext => 'Даље';

  @override
  String get introDone => 'Крећемо';

  @override
  String get introReplayTitle => 'Брзи увод';

  @override
  String get spotHomeSync =>
      'Овде синхронизујете са познаницима. Ви одлучујете шта делите.';

  @override
  String get spotHomeStrays =>
      'Ова картица скупља све луталице — мачке без дома. Додирните за листу.';

  @override
  String get spotHomeStraysNeutral =>
      'Ова картица скупља све луталице — љубимце без дома. Додирните за листу.';

  @override
  String get spotHomeMenu =>
      'У овом менију: подешавања, налажење и спајање дупликата, извоз CSV и више.';

  @override
  String get spotCatEdit =>
      'Додирните оловку да уредите мачку. Савет: дуги притисак на поље уређује га директно.';

  @override
  String get spotCatEditNeutral =>
      'Додирните оловку да уредите љубимца. Савет: дуги притисак на поље уређује га директно.';

  @override
  String get spotMapLayers =>
      'Тражите несталу мачку? Прикажите кругове око места њених огласа и око дома из којег је побегла.';

  @override
  String get spotMapLayersNeutral =>
      'Тражите несталог љубимца? Прикажите кругове око места његових огласа и око дома из којег је побегао.';

  @override
  String get spotStraysFlier =>
      'Оглас о несталој мачки? Фотографишите га овде — апликација чува мачку и контакт за вас.';

  @override
  String get spotStraysFlierNeutral =>
      'Оглас о несталом љубимцу? Фотографишите га овде — апликација чува љубимца и контакт за вас.';

  @override
  String get spotStraysScan =>
      'Неки огласи носе cat(a)log QR код. Скенирајте га овде и увезите мачку без куцања.';

  @override
  String get spotStraysScanNeutral =>
      'Неки огласи носе cat(a)log QR код. Скенирајте га овде и увезите љубимца без куцања.';

  @override
  String get introTitle4 => 'Пронађите нестале мачке';

  @override
  String get introTitle4Neutral => 'Пронађите нестале љубимце';

  @override
  String get introBody4 =>
      'Видите оглас о несталој мачки? Фотографишите га у апликацији: чува мачку, контакт власника и место. Појави ли се касније слична луталица, апликација предлаже могуће парове.';

  @override
  String get introBody4Neutral =>
      'Видите оглас о несталом љубимцу? Фотографишите га у апликацији: чува љубимца, контакт власника и место. Појави ли се касније слична луталица, апликација предлаже могуће парове.';

  @override
  String get spotMapSearch =>
      'Упишите мачку, место или особу да скочите тамо на карти.';

  @override
  String get spotMapSearchNeutral =>
      'Упишите љубимца, место или особу да скочите тамо на карти.';

  @override
  String get spotCardChips =>
      'Означите шта треба да буде на картици за дељење — остало остаје ван ње.';

  @override
  String get spotCatMenu =>
      'Овде има још радњи: сакриј мачку, споји дупликате или забележи виђење.';

  @override
  String get spotCatMenuNeutral =>
      'Овде има још радњи: сакриј љубимца, споји дупликате или забележи виђење.';

  @override
  String get spotDone => 'Јасно';

  @override
  String get spotReplayTitle => 'Тура кроз новине';

  @override
  String get spotReplaySubtitle => 'Поново прикажи савете на свакој страници';

  @override
  String get spotReplayDone => 'Савети ће се поново приказати';

  @override
  String get searchNoResults => 'Није пронађена мачка с тим именом';

  @override
  String get searchNoResultsNeutral => 'Није пронађен љубимац с тим именом';

  @override
  String get syncUnreachable =>
      'Други уређај је недоступан. Да ли су оба на истом Wi-Fi-ју?';

  @override
  String get folderUnreachable =>
      'Фасцикла је недоступна. Да ли диск или клауд фасцикла још постоји?';

  @override
  String get crashTitle => 'Ово није смело да се деси';

  @override
  String get crashBody =>
      'cat(a)log је наишао на неочекивану грешку. Твоји подаци су безбедни — све се чува чим се промени. Рестартуј апликацију, а ако се понавља, пошаљи извештај да се поправи.';

  @override
  String get crashRestart => 'Рестартуј апликацију';

  @override
  String get crashSendReport => 'Пошаљи извештај програмеру';

  @override
  String get crashLastRunBody =>
      'cat(a)log се прошли пут неочекивано зауставио — највероватније је нестало меморије. Послати кратак извештај да се поправи?';

  @override
  String get catalogsTitle => 'Каталози';

  @override
  String get newCatalog => 'Нови каталог';

  @override
  String get intoCatalog => 'У каталог';

  @override
  String get catalogNameLabel => 'Назив каталога';

  @override
  String catalogNameTaken(String name) {
    return 'Каталог под називом $name већ постоји. Изабери друго име.';
  }

  @override
  String get manageCatalogs => 'Управљање каталозима';

  @override
  String get restoreTitle => 'Врати резервне копије';

  @override
  String get restoreIntro =>
      'На овом уређају су резервне копије раније инсталације. Свака поново постаје каталог.';

  @override
  String get restoreNone =>
      'На овом уређају нема резервних копија. Изаберите датотеке за враћање с другог места.';

  @override
  String get restoreBackupsMenu => 'Врати резервне копије…';

  @override
  String get restorePickFiles => 'Изабери датотеке…';

  @override
  String restoreFileLine(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count датотека',
      few: '$count датотеке',
      one: '$count датотека',
    );
    return '$_temp0, најновија $date';
  }

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Враћено је $count каталога.',
      few: 'Враћена су $count каталога.',
      one: 'Враћен је $count каталог.',
      zero: 'Ништа није враћено.',
    );
    return '$_temp0';
  }

  @override
  String get helpCatalogs =>
      'Каталог је свет за себе: своје мачке, колоније, поља, фотографије и партнери за синхронизацију. Берлин и Париз се никад не мешају. Додирните каталог да пређете на њега. Зупчаник на каталогу отвара његова подешавања: име, мачке или животиње, поља, аутори и блокаде, архива, повратак назад, брисање. Ваше име, језик и већ виђени савети заједнички су свима.';

  @override
  String get helpCatalogsNeutral =>
      'Каталог је свет за себе: своје животиње, домаћинства, поља, фотографије и партнери за синхронизацију. Берлин и Париз се никад не мешају. Додирните каталог да пређете на њега. Зупчаник на каталогу отвара његова подешавања: име, мачке или животиње, поља, аутори и блокаде, архива, повратак назад, брисање. Ваше име, језик и већ виђени савети заједнички су свима.';

  @override
  String get helpCatalogSettings =>
      'Све што припада само овом каталогу: име, да ли садржи мачке или животиње, поља, аутори и блокаде, архива и повратак назад у времену. Измене овде тичу се само овог каталога — и онога у коме сада нисте. Брисање прво уписује каталог у датотеку. Твој кључ је код који партнери виде поред твог имена; припада овом каталогу.';

  @override
  String get spotHomeCatalog =>
      'Ово је каталог у ком си. Додирни име да промениш или направиш нови.';

  @override
  String get deleteCatalog => 'Обриши каталог';

  @override
  String get catalogSettings => 'Подешавања каталога';

  @override
  String deleteCatalogBody(String name) {
    return 'Све у каталогу $name нестаје: мачке, фотографије, историја. Прво се чува потпуна датотека тамо где иду аутоматске резервне копије — њен увоз враћа каталог.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Све у каталогу $name нестаје: љубимци, фотографије, историја. Прво се чува потпуна датотека тамо где иду аутоматске резервне копије — њен увоз враћа каталог. Упиши име да потврдиш.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name је обрисан. Датотека је у $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Упиши $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Ништа није обрисано: датотека каталога није могла да се упише ($error). Ослободи простор или покушај касније.';
  }

  @override
  String get moveToCatalog => 'Премести у други каталог';

  @override
  String movedToCatalog(int count, String name) {
    return '$count премештено у $name';
  }

  @override
  String get chooseWhatToMove => 'Шта се сели?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Преместити нешто у $name?';
  }

  @override
  String get undoThisImport => 'Поништи овај увоз';

  @override
  String undoImportBody(int count) {
    return '$count промена из овог увоза се уклања. Прво се уписују у датотеку, чији их увоз враћа. Они са којима си већ синхронизовао задржавају своју копију — то се не може повући.';
  }

  @override
  String undoneImport(String where) {
    return 'Поништено. Датотека је у $where.';
  }

  @override
  String get goBackTitle => 'Врати се назад';

  @override
  String get goBackToHere => 'Врати се овде';

  @override
  String get momentImport => 'Пре увоза';

  @override
  String get momentSync => 'Пре синхронизације';

  @override
  String get momentMerge => 'Пре спајања';

  @override
  String get momentHardDelete => 'Пре брисања података једног аутора';

  @override
  String get momentArchive => 'Пре архивирања';

  @override
  String get momentManual => 'Означио си сам';

  @override
  String get showOlderMoments => 'Прикажи старије';

  @override
  String goBackBody(int count) {
    return 'Све после овог тренутка се уклања — $count промена. Прво се уписује у датотеку, чији увоз све враћа, а сваки новији тренутак одлази с тим. Они са којима си већ синхронизовао задржавају копију — то се не може повући.';
  }

  @override
  String get nameThisMoment => 'Именуј овај тренутак';

  @override
  String get helpGoBack =>
      'Тренуци у којима је овај каталог променио облик: пре сваког увоза и сваке синхронизације, пре спајања, архивирања или брисања, и сваки пут када си сам означио тренутак. Избором једног каталог се враћа у то стање — све после њега уписује се у датотеку коју задржаваш и затим уклања, а сваки новији тренутак одлази с тим. Они са којима си већ синхронизовао задржавају оно што су добили.';

  @override
  String goBackFileFailed(String error) {
    return 'Ништа није уклоњено: датотека која то чува није могла да се упише ($error). Ослободи простор и покушај поново.';
  }

  @override
  String get goBackChanged =>
      'Ништа није уклоњено: каталог се променио док се датотека чувала. Покушај поново.';

  @override
  String get switchBeforeDeleting =>
      'Ово је каталог у ком си. Пређи на други, па га обриши.';

  @override
  String shareFileFailed(String error) {
    return 'Датотека за дељење није могла да се упише ($error). Ослободи простор и покушај поново.';
  }

  @override
  String get privateLabel => 'Приватно';

  @override
  String sharedCatalogIs(String name) {
    return 'Каталог: $name';
  }

  @override
  String get markPrivate => 'Означи као приватно';

  @override
  String get unmarkPrivate => 'Уклони приватну ознаку';

  @override
  String get agenda => 'Подсетници';

  @override
  String get reminderLabel => 'Подсетник';

  @override
  String get agendaEmpty =>
      'Нема планираних термина. Нове планираш овде плусом или на страници мачке или клаудера.';

  @override
  String get agendaEmptyNeutral =>
      'Нема планираних термина. Нове планираш овде плусом или на страници љубимца или домаћинства.';

  @override
  String get dueToday => 'данас';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count дана',
      few: 'за $count дана',
      one: 'за $count дан',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дана кашњења',
      few: '$count дана кашњења',
      one: '$count дан кашњења',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Обављено';

  @override
  String get repeatTitle => 'Поново за…';

  @override
  String get noRepeatLabel => 'Без понављања';

  @override
  String get unitDays => 'дана';

  @override
  String get unitWeeks => 'недеља';

  @override
  String get unitMonths => 'месеци';

  @override
  String get unitYears => 'година';

  @override
  String ageYears(int years) {
    return '$years год.';
  }

  @override
  String ageMonths(int months) {
    return '$months мес.';
  }

  @override
  String get changeDateLabel => 'Промени датум';

  @override
  String get removeReminderLabel => 'Уклони подсетник';

  @override
  String get exportIcs => 'Извези календарску датотеку';

  @override
  String get resyncCalendar => 'Поново синхронизуј календар';

  @override
  String icsSavedTo(String path) {
    return 'Календарска датотека сачувана у $path';
  }

  @override
  String get calendarMirrorLabel => 'Пресликај у календар уређаја';

  @override
  String get calendarMirrorSubtitle =>
      'Термини се у календару појављују као целодневни догађаји. cat(a)log их тамо ажурира при сваком покретању и после сваке промене. Подсетницима на термине управљаш у календару.';

  @override
  String get syncPeerOlder =>
      'Други уређај има старији cat(a)log без подсетника. Ажурирај cat(a)log тамо и синхронизуј поново.';

  @override
  String get syncPeerNewer =>
      'Други уређај има новији cat(a)log. Ажурирај cat(a)log на овом уређају и синхронизуј поново.';

  @override
  String get syncPeerNoTls =>
      'Други уређај има cat(a)log старији од 1.1.0, без шифроване синхронизације. Ажурирај cat(a)log тамо, па синхронизуј поново.';

  @override
  String get syncWrongHost =>
      'Сертификат не одговара коду за упаривање — ово није уређај са којег је код дошао. Скенирај или упиши код поново.';

  @override
  String get bundleNewerError =>
      'Ова датотека долази из новијег cat(a)log-а. Ажурирај cat(a)log на овом уређају да је увезеш.';

  @override
  String get spotEar => 'Мало мачје уво у углу значи: држи притиснуто за више.';

  @override
  String get addReminder => 'Додај подсетник';

  @override
  String get plannedSection => 'Планирано';

  @override
  String get reminderDialogHint =>
      'Термин се приказује у подсетницима. Тамо можеш да га потврдиш или одбациш. Вредност се преузима само ако је термин потврђен.';

  @override
  String get reminderFor => 'За';

  @override
  String get reminderField => 'Поље';

  @override
  String get dueDateLabel => 'Рок';

  @override
  String get pickCalendar => 'Који календар?';

  @override
  String get calendarPermissionDenied =>
      'Приступ календару је блокиран, па је пресликавање искључено. Дозволи га у подешавањима система и поново укључи пресликавање.';

  @override
  String get calendarNotChosen =>
      'Није одабран календар, па је пресликавање искључено. Укључи га поново и одабери један.';

  @override
  String get calendarGone =>
      'Одабрани календар више не постоји, па је пресликавање искључено. Укључи га поново и одабери други.';

  @override
  String get noWritableCalendar =>
      'Календар није пронађен. Пријави се у подешавањима система на налог календара, на пример Google, и покушај поново.';

  @override
  String get spotHomeAgenda =>
      'Подсетници: списак планираних термина — ветеринар, лекови, контроле.';

  @override
  String get spotAgendaAdd => 'Планирај нови термин.';

  @override
  String get spotAgendaCalendar =>
      'Укључи овде пресликавање cat(a)log термина у одабрани календар.';

  @override
  String get spotAgendaToday =>
      'Данашње обавезе: штиклирај кад је готово. Тачке показују последњих седам дана.';

  @override
  String get helpAgenda =>
      'Подсетници приказују планиране термине по датуму. Постоје две врсте: термини са временом и подсетници који важе за дан. Пропуштени остају на врху. Додир отвара мачку или клаудер. Квачица потврђује термин: вредност се уписује у поље и одмах можеш да планираш следећи, на пример за три месеца. Држање мења датум или брише термин. Прекидач на врху пресликава термине у календар твог телефона. Мени их извози као календарску датотеку. Одлазак код ветеринара са више мачака је један термин: означи мачке, Агенда приказује једну картицу са њиховим именима, а при завршетку пита које су мачке третиране — одзначи остале, остају планиране. Обавезе су понављајући задаци као храњење, песак или лекови. Стоје под Данас са квачицом, низом и последњих седам дана као тачке; Ускоро приказује следећу недељу без дневних. Обавеза може да подсети обавештењем у изабрано време. Пехар отвара достигнућа.';

  @override
  String get helpAgendaNeutral =>
      'Подсетници приказују планиране термине по датуму. Постоје две врсте: термини са временом и подсетници који важе за дан. Пропуштени остају на врху. Додир отвара љубимца или домаћинство. Квачица потврђује термин: вредност се уписује у поље и одмах можеш да планираш следећи, на пример за три месеца. Држање мења датум или брише термин. Прекидач на врху пресликава термине у календар твог телефона. Мени их извози као календарску датотеку. Одлазак код ветеринара са више љубимаца је један термин: означи љубимце, Агенда приказује једну картицу са њиховим именима, а при завршетку пита који су љубимци третирани — одзначи остале, остају планирани. Обавезе су понављајући задаци као храњење, песак или лекови. Стоје под Данас са квачицом, низом и последњих седам дана као тачке; Ускоро приказује следећу недељу без дневних. Обавеза може да подсети обавештењем у изабрано време. Пехар отвара достигнућа.';

  @override
  String get calendarRowOff => 'Календар: искључен';

  @override
  String calendarRowOn(String name) {
    return 'Календар: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Планирај термин за ову мачку. Приказује се у подсетницима и тамо се потврђује.';

  @override
  String get spotAddReminderCatNeutral =>
      'Планирај термин за овог љубимца. Приказује се у подсетницима и тамо се потврђује.';

  @override
  String get spotAddReminderClowder =>
      'Планирај термин за овај клаудер. Приказује се у подсетницима и тамо се потврђује.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Планирај термин за ово домаћинство. Приказује се у подсетницима и тамо се потврђује.';

  @override
  String get readOnlyCalendar => 'само за читање';

  @override
  String get appointmentLabel => 'Термин';

  @override
  String get addAppointment => 'Додај термин';

  @override
  String get planChooserTitle => 'Термин или подсетник?';

  @override
  String get planChooserAppointment =>
      'Термин — посета на датум и време, са белешкама';

  @override
  String get planChooserReminder =>
      'Подсетник — вредност која доспева одређеног дана';

  @override
  String get planChooserChore =>
      'Задатак — нешто што се понавља: храњење, капи, песак';

  @override
  String get newChore => 'Нови задатак';

  @override
  String get choreEdit => 'Уреди задатак';

  @override
  String get choreTitleLabel => 'Шта';

  @override
  String get choreRepeatDaily => 'Свакодневно';

  @override
  String get choreRepeatEvery => 'Сваких…';

  @override
  String get choreRepeatWeekdays => 'Дани';

  @override
  String choreEveryDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'сваких $n дана',
      few: 'свака $n дана',
      one: 'сваки дан',
    );
    return '$_temp0';
  }

  @override
  String choreEveryWeeks(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'сваких $n недеља',
      few: 'сваке $n недеље',
      one: 'сваке недеље',
    );
    return '$_temp0';
  }

  @override
  String choreEveryMonths(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'сваких $n месеци',
      few: 'свака $n месеца',
      one: 'сваког месеца',
    );
    return '$_temp0';
  }

  @override
  String choreEveryYears(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'сваких $n година',
      few: 'сваке $n године',
      one: 'сваке године',
    );
    return '$_temp0';
  }

  @override
  String get choreNoTime => 'Било када у току дана';

  @override
  String get chorePause => 'Пауза';

  @override
  String get chorePaused => 'Паузирано';

  @override
  String get choreResume => 'Настави';

  @override
  String get choreEnd => 'Заврши задатак';

  @override
  String get choreHistory => 'Историја';

  @override
  String choreDoneAt(Object when, Object who) {
    return 'урађено $when · $who';
  }

  @override
  String get choreDoneEarly => 'раније';

  @override
  String get choreDoneLate => 'касније';

  @override
  String get choreMissed => 'Пропуштено';

  @override
  String get choreStillOpen => 'Још отворено';

  @override
  String get choreEndConfirm =>
      'Обавеза нестаје са листе. Штиклирано остаје у историји.';

  @override
  String get todaySection => 'Данас';

  @override
  String get upcomingSection => 'Ускоро';

  @override
  String get allDoneToday => 'Данас: све урађено';

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дана заредом',
      few: '$n дана заредом',
      one: '$n дан заредом',
    );
    return '$_temp0';
  }

  @override
  String choreDue(String date) {
    return 'Рок $date';
  }

  @override
  String get remindMe => 'Подсети ме';

  @override
  String remindNext(Object when) {
    return 'Следећи подсетник: $when';
  }

  @override
  String get remindNone => 'Нема планираног подсетника: ништа не предстоји.';

  @override
  String remindPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count подсетника заказано на овом телефону',
      few: '$count подсетника заказана на овом телефону',
      one: '$count подсетник заказан на овом телефону',
      zero: 'Још ништа није заказано на овом телефону',
    );
    return '$_temp0';
  }

  @override
  String get remindTest => 'Пошаљи пробни подсетник сада';

  @override
  String get remindLateHint =>
      'Подсетници могу стићи неколико минута касније; тачан тренутак бира телефон.';

  @override
  String get remindPermissionDenied =>
      'Нема дозволе за обавештења, подсетник остаје искључен. Дозволите их у подешавањима апликације на телефону и покушајте поново.';

  @override
  String get batteryHint =>
      'Ако подсетници не стижу, дозволите cat(a)log да ради у позадини у подешавањима батерије телефона.';

  @override
  String get batterySettings => 'Подешавања батерије';

  @override
  String get achievementsTitle => 'Достигнућа';

  @override
  String get rankServant => 'Слуга';

  @override
  String get rankButler => 'Батлер';

  @override
  String get rankSteward => 'Управитељ';

  @override
  String get rankChancellor => 'Канцелар';

  @override
  String get rankMinister => 'Министар';

  @override
  String titleWithChore(Object title, Object chore) {
    return '$title ($chore)';
  }

  @override
  String get coatCalico => 'Калико';

  @override
  String get coatCheetah => 'Гепард';

  @override
  String get coatTiger => 'Тигар';

  @override
  String get coatTabby => 'Тиграста';

  @override
  String get coatPaws => 'Шапе';

  @override
  String get coatRosettes => 'Розете';

  @override
  String get coatZebra => 'Зебра';

  @override
  String get coatSetting => 'Крзно';

  @override
  String get coatRandom => 'Другачије при сваком покретању';

  @override
  String get coatSnowLeopard => 'Снежни леопард';

  @override
  String get coatSiamese => 'Сијамске ознаке';

  @override
  String get coatLynx => 'Рис';

  @override
  String get coatTortoiseshell => 'Корњачина';

  @override
  String coatUnlocked(Object coat) {
    return 'Ново крзно: $coat';
  }

  @override
  String get coatUnlockedHow => 'Цео месец обавеза, све урађене.';

  @override
  String get achievementsEmpty => 'Још ништа. Обавезе знају пут.';

  @override
  String get achievementMonth => 'Цео месец';

  @override
  String get achievementYear => 'Цела година';

  @override
  String get achievementDecade => 'Цела деценија';

  @override
  String get achievementCentury => 'Цео век';

  @override
  String get achievementCenturyHint => 'Обоје ћемо бити веома поносни.';

  @override
  String achievementMaster(String title) {
    return 'Мајстор: $title';
  }

  @override
  String achievementReached(int times, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'Постигнуто $times пута',
      few: 'Постигнуто $times пута',
      one: 'Постигнуто $times пут',
    );
    return '$_temp0, први пут $date';
  }

  @override
  String achievementNext(int n) {
    return 'Следеће на $n';
  }

  @override
  String get achievementLocked => 'Још не';

  @override
  String achievementUnlocked(String name) {
    return 'Достигнуће: $name';
  }

  @override
  String get appointmentTitleLabel => 'Шта';

  @override
  String get notesLabel => 'Белешке';

  @override
  String get timeLabel => 'Време';

  @override
  String get allDayLabel => 'Цео дан';

  @override
  String get alertLabel => 'Упозорење';

  @override
  String get alertNone => 'Нема';

  @override
  String get alertDayBefore => 'Дан раније';

  @override
  String get alertHourBefore => 'Сат раније';

  @override
  String get linkFieldLabel => 'По завршетку упиши у поље';

  @override
  String get noLinkedField => 'Нема поља';

  @override
  String get outcomeTitle => 'Како је прошло?';

  @override
  String get finishLabel => 'Заврши';

  @override
  String get editLabelAppointment => 'Уреди термин';

  @override
  String get deleteAppointment => 'Обриши термин';

  @override
  String get stepFlierText => 'Текст огласа';

  @override
  String get qrFoundHint =>
      'На огласу је пронађен QR код. Означени кодови се читају ради бројева регистра и веза.';

  @override
  String get useCode => 'Користи овај код';

  @override
  String get qrNone => 'На фотографији није пронађен QR код.';

  @override
  String qrFailed(String error) {
    return 'Читање QR кода није успело: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Препознат оглас $name. Провери испод у које поље иде сваки ред.';
  }

  @override
  String get flierLayoutUnknown =>
      'Непознат распоред огласа. Додели редове пољима испод; остало остаје у напоменама.';

  @override
  String get targetRegistryNumber => 'Број у регистру';

  @override
  String get targetLostPlace => 'Адреса (место нестанка)';

  @override
  String get targetContact => 'Контакт регистра';

  @override
  String get targetDrop => 'Одбаци';

  @override
  String get existingCat => 'Постојећа мачка';

  @override
  String get existingCatNeutral => 'Постојећи љубимац';

  @override
  String get existingClowder => 'Постојећа група';

  @override
  String get existingClowderNeutral => 'Постојеће домаћинство';

  @override
  String get createNewInstead => 'Ништа — направи ново';

  @override
  String overwritesValue(String value) {
    return 'Преписује тренутну вредност \"$value\"';
  }

  @override
  String get abortScanTitle => 'Прекинути снимање?';

  @override
  String get abortScanBody => 'Ништа неће бити сачувано.';

  @override
  String get abortScan => 'Прекини';

  @override
  String get keepScanning => 'Настави';

  @override
  String get catsOnAppointment => 'Мачке на овом термину';

  @override
  String get catsOnAppointmentNeutral => 'Љубимци на овом термину';

  @override
  String get noCatsHint =>
      'Ниједна мачка није означена — термин припада самој колонији.';

  @override
  String get noCatsHintNeutral =>
      'Ниједан љубимац није означен — термин припада самом домаћинству.';

  @override
  String get pickCatsTitle => 'Које мачке иду?';

  @override
  String get pickCatsTitleNeutral => 'Који љубимци иду?';

  @override
  String catsCount(int count) {
    return '$count мачака';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count љубимаца';
  }

  @override
  String get finishUntickHint =>
      'Одзначи мачке које нису третиране; остају планиране.';

  @override
  String get finishUntickHintNeutral =>
      'Одзначи љубимце који нису третирани; остају планирани.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Обриши термин за свих $count мачака';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Обриши термин за свих $count љубимаца';
  }

  @override
  String get correctThisValue => 'Исправи ову вредност';

  @override
  String get removeThisValue => 'Уклони ову вредност';

  @override
  String get restoreThisValue => 'Врати ову вредност';

  @override
  String get showRemovedValues => 'Прикажи уклоњене вредности';

  @override
  String get hideRemovedValues => 'Сакриј уклоњене вредности';

  @override
  String entryRemovedBy(Object who, Object when) {
    return 'Уклоњено · $who · $when';
  }

  @override
  String entryReplacedBy(Object value, Object who, Object when) {
    return 'Замењено са $value · $who · $when';
  }

  @override
  String get entryCorrection => 'Исправка';

  @override
  String get restorePickFolder => 'Изабери фасциклу резервних копија…';

  @override
  String get restoreAndroidHint =>
      'Резервне копије претходне инсталације су у Documents/catlog (код старијих верзија Downloads/catlog). Изаберите ту фасциклу једном; њене копије се приказују овде.';

  @override
  String get backupsTitle => 'Резервне копије';

  @override
  String get backupsSubtitle => 'Где су ваши каталози на сигурном';

  @override
  String get backupsAndroidSystem =>
      'Google чува каталоге ове апликације уз ваш налог, без фотографија. Враћају се сами после поновне инсталације или на новом телефону.';

  @override
  String get backupsAndroidFiles =>
      'Потпуна копија сваког каталога, са фотографијама, уписује се у Documents/catlog кад год напустите апликацију после измена.';

  @override
  String get backupsIosSystem =>
      'iCloud резервна копија обухвата ову апликацију са њеним каталозима и фотографијама, као и сваку другу апликацију на овом iPhone-у.';

  @override
  String get backupsIosFiles =>
      'Потпуна копија сваког каталога налази се у апликацији Files под cat(a)log. Одатле може на iCloud Drive, преко AirDrop-а или на други телефон.';

  @override
  String get backupsDesktopFiles =>
      'Потпуна копија сваког каталога, са фотографијама, уписује се у фасциклу Преузимања кад год напустите апликацију после измена.';

  @override
  String backupsLast(Object date) {
    return 'Последња копија: $date';
  }

  @override
  String get backupsNever => 'Копија још није уписана.';

  @override
  String get backupsNow => 'Направи копију сада';

  @override
  String get backupsDone => 'Копија уписана.';

  @override
  String backupsRestoredNote(Object date) {
    return 'Враћено из Google резервне копије $date. Ако стари телефон и даље користи cat(a)log, синхронизујте једном са њега, па тамо уклоните апликацију.';
  }

  @override
  String get backupsFolderHint =>
      'Сваку копију може да добија и фасцикла по вашем избору: она коју апликација за облак синхронизује на овом телефону (Nextcloud, Syncthing и друге), меморијска картица, било која фасцикла из избора. Копије завршавају у catlog-backups унутар ње.';

  @override
  String get backupsFolderPick => 'Копирај и у фасциклу…';

  @override
  String backupsFolderIs(Object name) {
    return 'Копира се и у $name';
  }

  @override
  String get backupsFolderRemove => 'Престани да копираш тамо';

  @override
  String remindFailed(Object error) {
    return 'Обавештења не раде на овом телефону: $error';
  }

  @override
  String get copyText => 'Копирај текст';

  @override
  String get colWhen => 'Када';

  @override
  String get colValue => 'Вредност';

  @override
  String get colWho => 'Ко';

  @override
  String get pdfFontMissing =>
      'Фонт за овај језик још није на телефону; нека слова се штампају као квадратићи. Повежите се једном на интернет и поново направите PDF.';

  @override
  String get vetReportTitle => 'Извештај за ветеринара';

  @override
  String get vetReportMenu => 'Извештај за ветеринара…';

  @override
  String get vetReportFields => 'Поља';

  @override
  String get vetReportFrom => 'Од';

  @override
  String get vetReportTo => 'До';

  @override
  String get vetReportSummary => 'Преглед пацијента';

  @override
  String get vetReportOwner => 'Власник';

  @override
  String get vetReportLegend => 'Легенда';

  @override
  String get vetReportCurves => 'Крива';

  @override
  String get posterMenu => 'Плакат „Нестао“…';

  @override
  String get posterHeadline => 'НЕСТАО';

  @override
  String get posterStanding =>
      'Молимо проверите подруме, шупе и гараже. Не јурите, само позовите.';

  @override
  String get posterLastSeen => 'Последњи пут виђен код';

  @override
  String get posterFreeText => 'Додатни ред';

  @override
  String get posterQr => 'QR код за cat(a)log';

  @override
  String get posterPhoto => 'Фотографија';

  @override
  String get newCatIn => 'Нова мачка у…';

  @override
  String get newCatInNeutral => 'Нови љубимац у…';

  @override
  String get choreLabel => 'Задатак';

  @override
  String get choreTickLabel => 'Задатак урађен';

  @override
  String get choreEnded => 'Завршено';

  @override
  String choreRemindAt(Object time) {
    return 'подсетник $time';
  }

  @override
  String doneOn(Object date) {
    return 'урађено $date';
  }

  @override
  String get withheldByPartner => 'задржано од партнера';

  @override
  String get titleLabel => 'Титула';

  @override
  String get deletedLabel => 'Обрисано';

  @override
  String get favouriteAdd => 'Означи као омиљено';

  @override
  String get favouriteRemove => 'Уклони из омиљених';

  @override
  String get coverPick => 'Насловна слика…';

  @override
  String get coverHint =>
      'Слика места: кућа, двориште, хранилиште. На картици уместо мачке.';

  @override
  String get coverRemove => 'Уклони насловну слику';

  @override
  String get skipTour => 'Прескочи увод и савете на овој инсталацији';
}
