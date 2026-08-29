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
      'Сè уште нема клаудери. Клаудер е место каде живеат мачки — твојот згрижувачки дом, станот на посвоител. Направи го првиот подолу.';

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
      'Мачката исчезнува од сите списоци и нејзините фотографии се отстрануваат — тука и, по следната синхронизација, и на другите уреди.';

  @override
  String get sightingRecorded => 'Видувањето е запишано на вашата позиција.';

  @override
  String get noLocationAvailable =>
      'Нема локација — наместо тоа задржете на мапата.';

  @override
  String get locationDeniedForever =>
      'Пристапот до локацијата е блокиран. Дозволете го во системските поставки за да користите Stray Cam.';

  @override
  String get locationServiceOff =>
      'Локацијата е исклучена на овој уред. Вклучете ја во поставките и обидете се повторно.';

  @override
  String get locationDenied =>
      'cat(a)log нема дозвола да ја користи вашата локација. Обидете се повторно и дозволете кога ќе бидете прашани.';

  @override
  String get locationNoFix =>
      'Вашата позиција сега не можеше да се одреди. Обидете се повторно на отворено — GPS му треба чист поглед кон небото.';

  @override
  String get ok => 'Во ред';

  @override
  String get starterChipId => 'Број на чип';

  @override
  String get starterRemarks => 'Забелешки';

  @override
  String get captureFlier => 'Сликај оглас';

  @override
  String get addPhotosTo => 'Додај ги фотографиите на…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count фотографии додадени на $name';
  }

  @override
  String get scanPrintedCode => 'Скенирај печатен код';

  @override
  String get chipScanHint =>
      'Го скенира печатениот QR/баркод од картичката на чипот или ветеринарните документи — телефонот не може да го прочита чипот во мачката.';

  @override
  String get savingLabel => 'Зачувување…';

  @override
  String ownerOfCat(String name) {
    return 'Сопственик на $name';
  }

  @override
  String get sortLabel => 'Подреди';

  @override
  String get viewAsTable => 'Прикажи како табела';

  @override
  String get viewAsTiles => 'Прикажи како плочки';

  @override
  String get viewAsList => 'Прикажи како листа';

  @override
  String get ageLabel => 'Возраст';

  @override
  String get catList => 'Листа на мачки';

  @override
  String get matchCandidatesTitle => 'Можни совпаѓања';

  @override
  String get findDuplicates => 'Најди дупликати';

  @override
  String get noDuplicates => 'Моментално нема можни дупликати.';

  @override
  String get similarName => 'Слично име';

  @override
  String get sharePublicly => 'Сподели јавно…';

  @override
  String get pickFramesTitle => 'Избор на кадри';

  @override
  String get suggestedFrames => 'Предложени кадри';

  @override
  String get scrubFrames => 'Премотување на видеото';

  @override
  String get keepThisFrame => 'Задржи го овој кадар';

  @override
  String get fromVideo => 'Од видео…';

  @override
  String get videoMobileOnly =>
      'Изборот на кадри од видео работи во телефонската апликација (Android и iPhone) — на овој уред сè уште не.';

  @override
  String get shareWhitelistExplainer =>
      'Изберете што влегува во датотеката. Се вклучуваат само штиклираните полиња.';

  @override
  String get exportShareFile => 'Извези датотека за споделување…';

  @override
  String get hostedLink => 'Хостиран линк (URL на подигнатата датотека)';

  @override
  String get inlineQr => 'Вграден QR (само текст, без фотографии)';

  @override
  String get inlineTooBig =>
      'Премногу податоци за вграден код — тргнете полиња или користете хостиран линк.';

  @override
  String get scanShareLabel => 'Скенирај код за споделување';

  @override
  String get notAShareCode => 'Тој код не е cat(a)log споделување.';

  @override
  String get importShareTitle => 'Да се увезе оваа мачка?';

  @override
  String shareSource(String url) {
    return 'Извор: $url';
  }

  @override
  String get importLabel => 'Увези';

  @override
  String get strayAreaLabel => 'Можна зона на талкање';

  @override
  String get prevPin => 'Претходна игла';

  @override
  String get nextPin => 'Следна игла';

  @override
  String get noMissingCats =>
      'Сè уште нема исчезнати мачки со позиции на огласи.';

  @override
  String get noMatchCandidates => 'Моментално нема можни совпаѓања.';

  @override
  String sameIdField(String field) {
    return 'Ист $field';
  }

  @override
  String metersApart(String distance) {
    return 'На $distance м растојание';
  }

  @override
  String get addFlier => 'Додај оглас';

  @override
  String get missingSinceLabel => 'Исчезнат од';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get cropPortrait => 'Исечи портрет';

  @override
  String get statusOwner => 'Сопственик';

  @override
  String get ocrUnavailable =>
      'Препознавањето текст не е достапно на овој уред — внесете го текстот на огласот сами.';

  @override
  String get displayFormat => 'Прикажано како';

  @override
  String get displayPlain => 'Обичен текст';

  @override
  String get displayQr => 'QR-код';

  @override
  String get displayBarcode => 'Баркод';

  @override
  String get editLabel => 'Уреди';

  @override
  String get doneLabel => 'Готово';

  @override
  String get openSettings => 'Отвори поставки';

  @override
  String get notSaved => 'Не е зачувано';

  @override
  String get birthdateInFuture =>
      'Датумот на раѓање не може да биде во иднината.';

  @override
  String get deceasedInFuture =>
      'Датумот на смртта не може да биде во иднината.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Датумот на смртта не може да биде пред датумот на раѓање ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Датумот на раѓање не може да биде по датумот на смртта ($date).';
  }

  @override
  String get malePregnant =>
      'Оваа мачка е запишана како машка — машка мачка не може да биде бремена. Прво проверете го полот.';

  @override
  String fatherNotMale(String name) {
    return '$name е запишана како женка и не може да биде таткото. Прво проверете го полот.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name е запишан како мажјак и не може да биде мајката. Прво проверете го полот.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name е роден на $date — родител не може да се роди по своето маче.';
  }

  @override
  String get genderFatherFemale =>
      'Оваа мачка е запишана како татко на други мачки — таткото не може да биде женка. Прво проверете го семејството.';

  @override
  String get genderMotherMale =>
      'Оваа мачка е запишана како мајка на други мачки — мајката не може да биде мажјак. Прво проверете го семејството.';

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
  String dateFormatError(String format) {
    return 'Погрешен формат — користете $format';
  }

  @override
  String get dateInFuture => 'Овој датум не може да биде во иднина.';

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
  String get ownValue => 'Сопствена вредност';

  @override
  String get renameField => 'Преименувај поле';

  @override
  String get editOptions => 'Уреди опции…';

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
      'Почнете тука, потоа скенирајте го кодот или внесете го на другиот уред.';

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
      'Двата уреда користат иста папка (на пр. во Dropbox или на USB). Секоја синхронизација ги остава таму вашите промени и ги зема туѓите.';

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
  String get coffeeSubtitle =>
      'Апликацијата останува бесплатна. Дури и ако не добијам кафе :)';

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
  String get starterBreed => 'Раса';

  @override
  String get valueMixed => 'мешана';

  @override
  String get breedEuropeanShorthair => 'Европска краткодлака';

  @override
  String get breedMaineCoon => 'Мејн кун';

  @override
  String get breedBritishShorthair => 'Британска краткодлака';

  @override
  String get breedNorwegianForestCat => 'Норвешка шумска мачка';

  @override
  String get breedRagdoll => 'Рагдол';

  @override
  String get breedSiamese => 'Сијамска';

  @override
  String get breedPersian => 'Персиска';

  @override
  String get breedBengal => 'Бенгалска';

  @override
  String get breedSphynx => 'Сфинкс';

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
  String get starterEmail => 'Е-пошта';

  @override
  String get starterPhone => 'Телефон';

  @override
  String get lookupUrlLabel => 'Врска за проверка';

  @override
  String lookupUrlHelp(String token) {
    return 'Страницата на услугата со $token на местото на бројот, пр. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Провери';

  @override
  String lookupFailed(String url) {
    return 'Ниедна апликација не можеше да отвори $url. Копирајте ја врската во прелистувач.';
  }

  @override
  String get stepCat => 'Мачка';

  @override
  String get stepOwner => 'Сопственик';

  @override
  String get stepFace => 'Фотографија на муцката';

  @override
  String get stepRegistry => 'Регистар';

  @override
  String get stepReview => 'Провери и зачувај';

  @override
  String get stepOwnerHint =>
      'Оној што ја бара мачката — од тоа настанува неговиот клаудер со контактот од огласот.';

  @override
  String get stepFaceHint =>
      'Исечи ја муцката на мачката од огласот; станува профилна слика. Може и да прескокнеш.';

  @override
  String get stepRegistryHint =>
      'Броеви најдени на огласот. Штиклираните се зачувуваат кај мачката и може подоцна да се отворат.';

  @override
  String get noRegistryLinks =>
      'На овој оглас нема врски до регистри — ако некоја е пропуштена, пријавете грешка.';

  @override
  String get unknownServiceHint => 'Непозната услуга';

  @override
  String get rememberService => 'Запамти ја услугата';

  @override
  String get rememberServiceHint =>
      'Именувај ја услугата и покажи го бројот во врската. Следниот оглас ќе се пополни сам.';

  @override
  String get noIdInLink =>
      'Оваа врска не содржи број што апликацијата би можела да го зачува.';

  @override
  String get whichNumber => 'Кој дел е бројот?';

  @override
  String get cropAgain => 'Исечи повторно';

  @override
  String get noFaceYet =>
      'Сè уште нема фотографија на муцката — се користи фотографијата од огласот.';

  @override
  String get backLabel => 'Назад';

  @override
  String get dangerButton => 'НЕ ПРИТИСКАЈ.\nОПАСНО';

  @override
  String get dangerThanks => 'Ви благодариме што користите cat(a)log!';

  @override
  String get helpTitle => 'Помош';

  @override
  String get showTipsAgain => 'Прикажи ги советите повторно';

  @override
  String get helpHome =>
      'Преглед на твоите колонии — колонија е место каде живеат мачки: твојот дом, привремено сместување, засолниште. Допри картичка за нејзините мачки; долг притисок отвора мени. Копчето долу десно создава колонија, а картичката на скитниците ги собира сите мачки без дом. Името горе е каталогот во кој си — допри го за да смениш или додадеш.';

  @override
  String get helpClowder =>
      'Сè за ова место: неговите мачки, полиња (адреса, контакт, вид) и историја. Страницата се отвора само за читање; моливот вклучува уредување, каде може да додадеш и ново поле. Долг притисок на поле го уредува веднаш, на мачка ја преместува, крие или отвора. Термин додаден овде може да поведе повеќе мачки од колонијата, на пример на стерилизација: означи ги мачките што доаѓаат, заврши еднаш, одзначи ги нетретираните.';

  @override
  String get helpCat =>
      'Сè за оваа мачка: фотографии, полиња, семејство, историја. Страницата е само за читање додека не го допреш моливот. Долг притисок на поле оди директно на уредување; долг притисок на фотографија го отвора нејзиното мени. Менито горе десно го држи остатокот: сокривање, спојување, запишување видување, споделување на мачката. „Приватно“ се поставува при уредување на поле.';

  @override
  String get helpStrays =>
      'Мачки што сега немаат дом: најдени, избегани или од оглас. Копчето со камера запишува мачка пред тебе; копчето со оглас претвора плакат во мачка со контакт на сопственикот; скенерот чита cat(a)log код од плакатот.';

  @override
  String get helpMap =>
      'Сите мачки и места со позиција. Пребарувањето наоѓа мачки, луѓе и места — непознато име се бара низ целиот свет. Копчето за слоеви црта кругови од 500 м околу местата на огласите на исчезната мачка и околу домот од кој избегала. Стрелките одат од игла до игла, долг притисок на картата запишува видување.';

  @override
  String get helpCard =>
      'Печатлива картичка на мачката: горе со чипови избираш што ќе биде на неа, потоа ја споделуваш како слика или PDF. Броевите може да се печатат како QR или баркод, а позицијата станува QR што отвора карта, плус краток Plus Code.';

  @override
  String get helpSync =>
      'Како податоците стигнуваат до други: поврзи се директно, користи папка што ја гледаат двата уреда, или испрати датотека преку месинџер. Секогаш ти одлучуваш што излегува — а примените .catsync датотеки се отвораат исто така овде.';

  @override
  String get helpFields =>
      'Полињата што ги користи твојот каталог. Преименувај ги, промени ги опциите на поле со избор или додади свои. Поле со идентификатор може да покажува кон услуга (регистар), па бројот кај мачката станува допирлив.';

  @override
  String get helpTimeline =>
      'Секоја некогаш направена промена, најновата прва: кој што, кога и во која вредност променил. Секој запис може да се врати — тоа запишува нов запис, ништо не се брише.';

  @override
  String get helpDuplicates =>
      'Мачки или колонии што изгледаат како ист запис двапати — исти броеви или многу слични имиња со совпаѓачки детали. Допри пар за спојување; спојувањето не може да се врати, затоа прво прашува.';

  @override
  String get helpMatches =>
      'Мачки што можеби се исто животно: ист број или скитник виден во подрачјето на барање на исчезната мачка. Допри пар за спојување, долг притисок ја отвора првата мачка за споредба.';

  @override
  String get helpFlier =>
      'Фотографиран оглас станува мачка заедно со сопственикот. Чекор по чекор: податоци за мачката, контакт на сопственикот, исечок на муцката за профилна слика, броеви од регистри на огласот, па конечна проверка. Сè е предлог — поправи го она што камерата го прочитала погрешно.';

  @override
  String get archiveTitle => 'Архива';

  @override
  String get archiveExplainer =>
      'Умрените мачки и празните колонии што со години никој не ги допрел сепак заземаат простор — најмногу нивните фотографии. Архивирањето ги запишува во датотека што ја чувате и потоа ги брише оттука.';

  @override
  String get archiveAction => 'Архивирај';

  @override
  String archiveSelected(int count) {
    return 'Архивирај $count записи';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Да се архивираат $count записи?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names ќе бидат запишани во датотека и потоа избришани — на вашиот уред и на секој со кој синхронизирате. Увозот на датотеката враќа сè; без неа се изгубени.';
  }

  @override
  String archiveDone(int count) {
    return 'Архивирани и избришани $count записи';
  }

  @override
  String archiveFailed(String error) {
    return 'Ништо не е избришано: датотеката на архивата не можеше да се запише ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'База $db, фотографии $photos во $count датотеки';
  }

  @override
  String quietForYears(int years) {
    return 'Без промена $years години';
  }

  @override
  String get nothingToArchive => 'Нема ништо доволно старо за архивирање.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Последна промена $date · фотографии $size';
  }

  @override
  String get helpArchive =>
      'Старите податоци чинат простор, најмногу фотографиите што ги носи секој синхронизиран уред. Тука избирате умрени мачки и празни колонии што со години мируваат, ги запишувате во датотека што ја чувате и ги бришете. Бришењето стигнува до сите со кои синхронизирате; увозот на датотеката враќа сè.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Да се вратат $count избришани записи?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names се избришани во овој каталог, а датотеката што штотуку ја увезовте ги содржи. Враќањето ги враќа тука и на секој уред со кој синхронизирате.';
  }

  @override
  String get restoreAction => 'Врати';

  @override
  String get keepDeleted => 'Остави избришани';

  @override
  String get archiveNotSaved =>
      'Ништо не е избришано: архивата не е зачувана никаде.';

  @override
  String get locateAddress => 'Најди ја адресата на картата';

  @override
  String get addressLocated => 'Адресата е најдена';

  @override
  String get addressNotFound =>
      'За оваа адреса не е најдено место. Провери го правописот или остави празно.';

  @override
  String get starterPosition => 'Локација';

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
  String get applyCrop => 'Исечи';

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
  String lastBackupFailed(String error) {
    return 'Последната автоматска резервна копија не успеа: $error';
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
  String get includePrivate => 'Сподели приватни податоци';

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
  String get starterStatus => 'Тип';

  @override
  String get statusFoster => 'Згрижувачки дом';

  @override
  String get statusForeverHome => 'Дом';

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
      'Конфети и радост кога мачка се сели во својот дом';

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
  String get syncChooserInPersonSub => 'Синхронизација преку Wi-Fi';

  @override
  String get syncChooserRemote => 'Од далечина';

  @override
  String get syncChooserRemoteSub => 'Синхронизација преку папка или USB';

  @override
  String get syncChooserMessenger => 'Месинџер';

  @override
  String get syncChooserMessengerSub => 'Извоз и увоз преку социјални мрежи';

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

  @override
  String get selectClowderHint => 'Избери клаудер лево';

  @override
  String get introTitle1 => 'Вашите мачки, уредно';

  @override
  String get introBody1 =>
      'Направете картичка за секоја мачка: фотографија, пол, здравје, сè што сакате да забележите. Мачките се групирани според местото каде живеат — апликацијата го вика колонија (clowder).';

  @override
  String get introTitle2 => 'Работи без интернет';

  @override
  String get introBody2 =>
      'Сè се чува само на вашиот телефон. Без сметка, без облак. Ништо не се испраќа додека сами не споделите.';

  @override
  String get introTitle3 => 'Работете заедно';

  @override
  String get introBody3 =>
      'Секој користи своја апликација и повремено разменувате податоци: најдете се и скенирајте код, користете заедничка папка или испратете една датотека преку месинџер. Потоа сите имаат исти податоци.';

  @override
  String get introSkip => 'Прескокни';

  @override
  String get introNext => 'Следно';

  @override
  String get introDone => 'Одиме';

  @override
  String get introReplayTitle => 'Брз вовед';

  @override
  String get spotHomeSync =>
      'Тука синхронизирате со познаниците. Вие одлучувате што споделувате.';

  @override
  String get spotHomeStrays =>
      'Оваа картичка ги собира сите скитници — мачки без дом. Допрете за листата.';

  @override
  String get spotHomeMenu =>
      'Во ова мени: најдете и споите дупликати, извезете CSV и повеќе.';

  @override
  String get spotCatEdit =>
      'Допрете го моливот за да ја уредите мачката. Совет: долг притисок на поле го уредува директно.';

  @override
  String get spotMapLayers =>
      'Барате исчезната мачка? Прикажете кругови околу местата на нејзините огласи и околу домот од кој избегала.';

  @override
  String get spotStraysFlier =>
      'Оглас за исчезната мачка? Фотографирајте го тука — апликацијата ги чува мачката и контактот за вас.';

  @override
  String get spotStraysScan =>
      'Некои огласи имаат cat(a)log QR-код. Скенирајте го тука и увезете ја мачката без пишување.';

  @override
  String get introTitle4 => 'Најдете исчезнати мачки';

  @override
  String get introBody4 =>
      'Гледате оглас за исчезната мачка? Фотографирајте го во апликацијата: таа ги чува мачката, контактот на сопственикот и местото. Ако подоцна се појави слична скитница, апликацијата предлага можни совпаѓања.';

  @override
  String get spotMapSearch =>
      'Внесете мачка, место или личност за да скокнете таму на картата.';

  @override
  String get spotCardChips =>
      'Штиклирајте што да има на картичката за споделување — останатото останува надвор.';

  @override
  String get spotCatMenu =>
      'Тука има уште дејства: сокриј ја мачката, спои дупликати или запиши видување.';

  @override
  String get spotDone => 'Јасно';

  @override
  String get spotReplayTitle => 'Тура низ новото';

  @override
  String get spotReplaySubtitle =>
      'Прикажи ги советите повторно на секоја страница';

  @override
  String get spotReplayDone => 'Советите ќе се прикажат повторно';

  @override
  String get searchNoResults => 'Не е најдена мачка со тоа име';

  @override
  String get syncUnreachable =>
      'Другиот уред е недостапен. Дали двата се на иста Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Папката е недостапна. Дали дискот или облак-папката сè уште постои?';

  @override
  String get crashTitle => 'Ова не смееше да се случи';

  @override
  String get crashBody =>
      'cat(a)log наиде на неочекувана грешка. Твоите податоци се безбедни — сè се зачувува во моментот на промена. Рестартирај ја апликацијата, а ако се повторува, испрати го извештајот за да се поправи.';

  @override
  String get crashRestart => 'Рестартирај ја апликацијата';

  @override
  String get crashSendReport => 'Испрати извештај до развивачот';

  @override
  String get crashLastRunBody =>
      'cat(a)log запре неочекувано минатиот пат — најверојатно снема меморија. Да испратиме краток извештај за да се поправи?';

  @override
  String get catalogsTitle => 'Каталози';

  @override
  String get newCatalog => 'Нов каталог';

  @override
  String get catalogNameLabel => 'Име на каталогот';

  @override
  String catalogNameTaken(String name) {
    return 'Веќе постои каталог со име $name. Избери друго име.';
  }

  @override
  String get manageCatalogs => 'Управувај со каталозите';

  @override
  String get helpCatalogs =>
      'Секој каталог е свет за себе: свои мачки, колонии, полиња, фотографии и партнери за синхронизација. Берлин и Париз никогаш не се мешаат. Допри го името горе на почетниот екран за да смениш, додадеш или преименуваш. Твоето име, јазикот и веќе видените совети се заеднички.';

  @override
  String get spotHomeCatalog =>
      'Ова е каталогот во кој си. Допри го името за да смениш или да направиш нов.';

  @override
  String get deleteCatalog => 'Избриши каталог';

  @override
  String deleteCatalogBody(String name) {
    return 'Сè во $name исчезнува: мачките, фотографиите, историјата. Прво се зачувува целосна датотека таму каде одат автоматските резервни копии — нејзиниот увоз го враќа каталогот. Впиши го името за потврда.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name е избришан. Датотеката е во $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Впиши $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Ништо не е избришано: датотеката на каталогот не можеше да се запише ($error). Ослободи простор или обиди се подоцна.';
  }

  @override
  String get moveToCatalog => 'Премести во друг каталог';

  @override
  String movedToCatalog(int count, String name) {
    return '$count преместени во $name';
  }

  @override
  String get chooseWhatToMove => 'Што се преместува?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Да преместиме нешто во $name?';
  }

  @override
  String get undoThisImport => 'Врати го овој увоз';

  @override
  String undoImportBody(int count) {
    return '$count промени од овој увоз се отстрануваат. Прво се запишуваат во датотека, чиј увоз ги враќа. Оние со кои веќе си синхронизирал ја задржуваат својата копија — тоа не може да се повлече.';
  }

  @override
  String undoneImport(String where) {
    return 'Вратено. Датотеката е во $where.';
  }

  @override
  String get goBackTitle => 'Врати се назад';

  @override
  String get goBackToHere => 'Врати се овде';

  @override
  String get momentImport => 'Пред увозот';

  @override
  String get momentSync => 'Пред синхронизацијата';

  @override
  String get momentMerge => 'Пред спојувањето';

  @override
  String get momentHardDelete => 'Пред бришењето на податоците на еден автор';

  @override
  String get momentArchive => 'Пред архивирањето';

  @override
  String get momentManual => 'Означено од тебе';

  @override
  String get showOlderMoments => 'Прикажи постари';

  @override
  String goBackBody(int count) {
    return 'Сè по овој момент се отстранува — $count промени. Прво се запишува во датотека, чиј увоз сè враќа, а секој поново момент си оди со него. Оние со кои веќе си синхронизирал ја задржуваат копијата — тоа не може да се повлече.';
  }

  @override
  String get nameThisMoment => 'Именувај го овој момент';

  @override
  String get helpGoBack =>
      'Моментите кога овој каталог се промени: пред секој увоз и секоја синхронизација, пред спојување, архивирање или бришење, и секогаш кога сам си означил момент. Ако избереш еден, каталогот се враќа во таа состојба — сè по него се запишува во датотека што ја задржуваш и потоа се отстранува, а секој поново момент си оди со него. Оние со кои веќе си синхронизирал го задржуваат тоа што го добиле.';

  @override
  String goBackFileFailed(String error) {
    return 'Ништо не е отстрането: датотеката што го чува не можеше да се запише ($error). Ослободи простор и обиди се повторно.';
  }

  @override
  String get switchBeforeDeleting =>
      'Ова е каталогот во кој си. Префрли се на друг, па избриши го.';

  @override
  String shareFileFailed(String error) {
    return 'Датотеката за споделување не можеше да се запише ($error). Ослободи простор и обиди се повторно.';
  }

  @override
  String get privateLabel => 'Приватно';

  @override
  String sharedCatalogIs(String name) {
    return 'Каталог: $name';
  }

  @override
  String get markPrivate => 'Означи како приватно';

  @override
  String get unmarkPrivate => 'Отстрани приватна ознака';

  @override
  String get agenda => 'Потсетници';

  @override
  String get reminderLabel => 'Потсетник';

  @override
  String get agendaEmpty =>
      'Нема планирани термини. Нови планираш тука со плусот или на страницата на мачка или клаудер.';

  @override
  String get dueToday => 'денес';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count дена',
      one: 'за $count ден',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дена задоцнување',
      one: '$count ден задоцнување',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Завршено';

  @override
  String get repeatTitle => 'Повторно за…';

  @override
  String get noRepeatLabel => 'Без повторување';

  @override
  String get unitDays => 'дена';

  @override
  String get unitWeeks => 'недели';

  @override
  String get unitMonths => 'месеци';

  @override
  String get unitYears => 'години';

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
  String get removeReminderLabel => 'Отстрани потсетник';

  @override
  String get exportIcs => 'Извези календарска датотека';

  @override
  String icsSavedTo(String path) {
    return 'Календарската датотека е зачувана во $path';
  }

  @override
  String get calendarMirrorLabel => 'Пресликај во календарот на уредот';

  @override
  String get calendarMirrorSubtitle =>
      'Термините се појавуваат како целодневни настани во календарот. cat(a)log ги ажурира таму при секое стартување и по секоја промена. Потсетниците за термините ги управуваш во календарот.';

  @override
  String get syncPeerOlder =>
      'Другиот уред има постар cat(a)log без потсетници. Ажурирај го cat(a)log таму и синхронизирај повторно.';

  @override
  String get syncPeerNewer =>
      'Другиот уред има понов cat(a)log. Ажурирај го cat(a)log на овој уред и синхронизирај повторно.';

  @override
  String get bundleNewerError =>
      'Оваа датотека доаѓа од понов cat(a)log. Ажурирај го cat(a)log на овој уред за да ја увезеш.';

  @override
  String get spotEar => 'Мало мачешко уво во аголот значи: задржи за повеќе.';

  @override
  String get addReminder => 'Додај потсетник';

  @override
  String get plannedSection => 'Планирано';

  @override
  String get reminderDialogHint =>
      'Терминот се прикажува во потсетниците. Таму можеш да го потврдиш или отфрлиш. Вредноста се презема само ако терминот е потврден.';

  @override
  String get reminderFor => 'За';

  @override
  String get reminderField => 'Поле';

  @override
  String get dueDateLabel => 'Рок';

  @override
  String get pickCalendar => 'Кој календар?';

  @override
  String get calendarPermissionDenied =>
      'Пристапот до календарот е блокиран, па пресликувањето е исклучено. Дозволи го во системските поставки и повторно вклучи го пресликувањето.';

  @override
  String get calendarNotChosen =>
      'Не е избран календар, па пресликувањето е исклучено. Вклучи го повторно и избери еден.';

  @override
  String get calendarGone =>
      'Избраниот календар веќе не постои, па пресликувањето е исклучено. Вклучи го повторно и избери друг.';

  @override
  String get noWritableCalendar =>
      'Не е пронајден календар. Најави се во системските поставки на сметка за календар, на пример Google, и обиди се повторно.';

  @override
  String get spotHomeAgenda =>
      'Потсетници: список на планираните термини — ветеринар, лекови, контроли.';

  @override
  String get spotAgendaAdd => 'Планирај нов термин.';

  @override
  String get spotAgendaCalendar =>
      'Вклучи го тука пресликувањето на cat(a)log термините во избран календар.';

  @override
  String get helpAgenda =>
      'Потсетниците ги прикажуваат планираните термини по датум. Постојат два вида: термини со време и потсетници што важат за ден. Пропуштените остануваат најгоре. Допир ја отвора мачката или клаудерот. Штиклата потврдува термин: вредноста се запишува во полето и веднаш можеш да го планираш следниот, на пример за три месеци. Задржување го менува датумот или го брише терминот. Прекинувачот горе ги пресликува термините во календар на твојот телефон. Менито ги извезува како календарска датотека. Посета кај ветеринар со повеќе мачки е еден термин: означи ги мачките, Агендата покажува една картичка со нивните имиња, а при завршување прашува кои мачки беа третирани — одзначи ги другите, остануваат планирани.';

  @override
  String get calendarRowOff => 'Календар: исклучен';

  @override
  String calendarRowOn(String name) {
    return 'Календар: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Планирај термин за оваа мачка. Се прикажува во потсетниците и таму се потврдува.';

  @override
  String get spotAddReminderClowder =>
      'Планирај термин за овој клаудер. Се прикажува во потсетниците и таму се потврдува.';

  @override
  String get readOnlyCalendar => 'само за читање';

  @override
  String get appointmentLabel => 'Термин';

  @override
  String get addAppointment => 'Додај термин';

  @override
  String get planChooserTitle => 'Термин или потсетник?';

  @override
  String get planChooserAppointment =>
      'Термин — посета на датум и време, со белешки';

  @override
  String get planChooserReminder =>
      'Потсетник — вредност што доспева на определен ден';

  @override
  String get appointmentTitleLabel => 'Што';

  @override
  String get notesLabel => 'Белешки';

  @override
  String get timeLabel => 'Време';

  @override
  String get allDayLabel => 'Цел ден';

  @override
  String get alertLabel => 'Известување';

  @override
  String get alertNone => 'Нема';

  @override
  String get alertDayBefore => 'Ден претходно';

  @override
  String get alertHourBefore => 'Еден час претходно';

  @override
  String get linkFieldLabel => 'По завршување запиши во поле';

  @override
  String get noLinkedField => 'Нема поле';

  @override
  String get outcomeTitle => 'Како помина?';

  @override
  String get finishLabel => 'Заврши';

  @override
  String get editLabelAppointment => 'Уреди термин';

  @override
  String get deleteAppointment => 'Избриши термин';

  @override
  String get stepFlierText => 'Текст на огласот';

  @override
  String get qrFoundHint =>
      'На огласот е пронајден QR-код. Означените кодови се читаат за регистарски броеви и врски.';

  @override
  String get useCode => 'Користи го овој код';

  @override
  String get qrNone => 'Не е пронајден QR-код на фотографијата.';

  @override
  String qrFailed(String error) {
    return 'Читањето на QR-кодот не успеа: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Препознаен оглас на $name. Провери подолу во кое поле оди секој ред.';
  }

  @override
  String get flierLayoutUnknown =>
      'Непознат распоред на огласот. Додели ги редовите на полиња подолу; остатокот останува во забелешките.';

  @override
  String get targetRegistryNumber => 'Регистарски број';

  @override
  String get targetLostPlace => 'Адреса (место на исчезнување)';

  @override
  String get targetContact => 'Контакт на регистарот';

  @override
  String get targetDrop => 'Отфрли';

  @override
  String get abortScanTitle => 'Прекини снимање?';

  @override
  String get abortScanBody => 'Ништо нема да се зачува.';

  @override
  String get abortScan => 'Прекини';

  @override
  String get keepScanning => 'Продолжи';

  @override
  String get catsOnAppointment => 'Мачки на овој термин';

  @override
  String get noCatsHint =>
      'Ниедна мачка не е означена — терминот е на самата колонија.';

  @override
  String get pickCatsTitle => 'Кои мачки доаѓаат?';

  @override
  String catsCount(int count) {
    return '$count мачки';
  }

  @override
  String get finishUntickHint =>
      'Одзначи ги мачките што не беа третирани; остануваат планирани.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Избриши го терминот за сите $count мачки';
  }
}
