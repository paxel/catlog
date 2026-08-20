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
  String get noClowdersYet =>
      'Још нема клаудера. Клаудер је место где мачке живе — твој хранитељски дом, стан усвојитеља. Направи први испод.';

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
      'Мачка нестаје са свих листа и њене фотографије се уклањају — овде и, после следеће синхронизације, и на другим уређајима.';

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
  String get privateNoShare =>
      'Ова мачка је означена као приватна — приватни подаци никада не напуштају ваш уређај. Прво уклоните ознаку да бисте је јавно поделили.';

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
  String get genderFatherFemale =>
      'Ова мачка је уписана као отац других мачака — отац не може бити женка. Прво проверите породицу.';

  @override
  String get genderMotherMale =>
      'Ова мачка је уписана као мајка других мачака — мајка не може бити мужјак. Прво проверите породицу.';

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
  String dateFormatError(String format) {
    return 'Погрешан формат — користите $format';
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
      'Оба уређаја користе исту фасциклу (нпр. у Dropbox-у или на USB стику). Свака синхронизација тамо оставља ваше промене и преузима туђе.';

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
  String get stepOwner => 'Власник';

  @override
  String get stepFace => 'Фотографија њушке';

  @override
  String get stepRegistry => 'Регистар';

  @override
  String get stepReview => 'Провери и сачувај';

  @override
  String get stepOwnerHint =>
      'Ко тражи мачку — од тога настаје његова картица са контактом са огласа.';

  @override
  String get stepFaceHint =>
      'Исеци њушку мачке са огласа; постаје профилна слика. Можеш и да прескочиш.';

  @override
  String get stepRegistryHint =>
      'Бројеви пронађени на огласу. Означени се чувају уз мачку и могу се касније отворити.';

  @override
  String get noRegistryLinks =>
      'На овом огласу нема веза ка регистрима — овде нема посла.';

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
      'Преглед твојих колонија — колонија је место где живе мачке: твој дом, привремени смештај, склониште. Додирни картицу за њене мачке; дуги притисак отвара мени. Дугме доле десно прави колонију, а картица луталица скупља све мачке без дома.';

  @override
  String get helpClowder =>
      'Све о овом месту: његове мачке, поља (адреса, контакт, врста) и историја. Страница се отвара само за читање; оловка укључује уређивање, где можеш додати и ново поље. Дуги притисак на поље уређује га одмах, на мачку је премешта, скрива или отвара.';

  @override
  String get helpCat =>
      'Све о овој мачки: фотографије, поља, породица, историја. Страница је само за читање док не додирнеш оловку. Дуги притисак на поље води право у његово уређивање; на фотографију отвара њен мени. Мени горе десно има остало: приватно, сакриј, споји, забележи виђење, подели.';

  @override
  String get helpStrays =>
      'Мачке које тренутно немају дом: пронађене, побегле или са огласа. Дугме са камером бележи мачку испред тебе; дугме са огласом претвара плакат у мачку са контактом власника; скенер чита cat(a)log код са плаката.';

  @override
  String get helpMap =>
      'Све мачке и места са позицијом. Претрага налази мачке, особе и места — непознато име тражи се у целом свету. Дугме слојева црта кругове од 500 м око места огласа нестале мачке и око дома из којег је побегла. Стрелице иду од чиоде до чиоде, дуги притисак на карту бележи виђење.';

  @override
  String get helpCard =>
      'Картица мачке за штампу: горе чиповима бираш шта је на њој, затим је делиш као слику или PDF. Бројеви се могу штампати као QR или баркод, а позиција постаје QR који отвара карту, уз кратак Plus Code.';

  @override
  String get helpSync =>
      'Како подаци стижу до других: директно повезивање, фасцикла коју виде оба уређаја, или датотека послата месинџером. Увек ти одлучујеш шта одлази — а примљене .catsync датотеке отварају се такође овде.';

  @override
  String get helpFields =>
      'Поља која твој каталог користи. Преименуј их, промени могућности поља са избором или додај своја. Поље са идентификатором може показивати на сервис (регистар), па број код мачке постаје додирљив.';

  @override
  String get helpTimeline =>
      'Свака икада направљена промена, најновија прва: ко је шта, када и у коју вредност променио. Сваки унос може да се врати — то пише нови унос, ништа се никада не брише.';

  @override
  String get helpDuplicates =>
      'Мачке или колоније које изгледају као исти унос двапут — исти бројеви или врло слична имена са подударним детаљима. Додирни пар за спајање; спајање се не може поништити па се прво пита.';

  @override
  String get helpMatches =>
      'Мачке које би могле бити иста животиња: исти број или луталица виђена унутар подручја претраге нестале мачке. Додирни пар за спајање, дугим притиском отвори прву мачку за поређење.';

  @override
  String get helpFlier =>
      'Фотографисани оглас постаје мачка и њен власник. Корак по корак: подаци мачке, контакт власника, исецање њушке за профилну слику, бројеви регистара са огласа, па завршна провера. Све су то предлози — исправи оно што је камера погрешно прочитала.';

  @override
  String get locateAddress => 'Пронађи адресу на карти';

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
  String get applyCrop => 'Isecite';

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
      'Тиме се шаље и све што сте означили као приватно. Особа са којом синхронизујете то ће видети.';

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
  String get syncChooserInPersonSub =>
      'У истој сте просторији — скенирај код, готово за секунде';

  @override
  String get syncChooserRemote => 'На даљину';

  @override
  String get syncChooserRemoteSub =>
      'Преко дељене фасцикле попут Dropbox-а или USB-а';

  @override
  String get syncChooserMessenger => 'Месинџер';

  @override
  String get syncChooserMessengerSub =>
      'Пошаљите све као једну датотеку преко било ког месинџера — и увезите примљену .catsync датотеку овде';

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
  String get introTitle1 => 'Ваше мачке, прегледно';

  @override
  String get introBody1 =>
      'Направите картицу за сваку мачку: фотографија, пол, здравље, шта год желите да забележите. Мачке су груписане по месту где живе — апликација га зове колонија (clowder).';

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
  String get spotHomeMenu =>
      'У овом менију: пронађите и спојите дупликате, извезите CSV и више.';

  @override
  String get spotCatEdit =>
      'Додирните оловку да уредите мачку. Савет: дуги притисак на поље уређује га директно.';

  @override
  String get spotMapLayers =>
      'Тражите несталу мачку? Прикажите кругове око места њених огласа и око дома из којег је побегла.';

  @override
  String get spotStraysFlier =>
      'Оглас о несталој мачки? Фотографишите га овде — апликација чува мачку и контакт за вас.';

  @override
  String get spotStraysScan =>
      'Неки огласи носе cat(a)log QR код. Скенирајте га овде и увезите мачку без куцања.';

  @override
  String get introTitle4 => 'Пронађите нестале мачке';

  @override
  String get introBody4 =>
      'Видите оглас о несталој мачки? Фотографишите га у апликацији: чува мачку, контакт власника и место. Појави ли се касније слична луталица, апликација предлаже могуће парове.';

  @override
  String get spotMapSearch =>
      'Упишите мачку, место или особу да скочите тамо на карти.';

  @override
  String get spotCardChips =>
      'Означите шта треба да буде на картици за дељење — остало остаје ван ње.';

  @override
  String get spotCatMenu =>
      'Више радњи овде: означите мачку као приватну, сакријте је, спојите дупликате или забележите виђење.';

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
}
