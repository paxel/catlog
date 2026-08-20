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
      'Мачката исчезнува од сите листи и нејзините слики се отстрануваат — тука и, по следната синхронизација, и кај твоите помагачи.';

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
      'Само штиклираните полиња го напуштаат каталогот. Сè друго останува дома.';

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
  String get starterStatus => 'Тип';

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

  @override
  String get selectClowderHint => 'Избери клаудер лево';

  @override
  String get introTitle1 => 'Мачките живеат во клаудери';

  @override
  String get introBody1 =>
      'Клаудер е место каде живеат мачки: твојот згрижувачки дом, станот на посвоителот, шталата до вас. Секоја мачка има карта со слика, факти и целата приказна.';

  @override
  String get introTitle2 => 'Сè останува кај тебе';

  @override
  String get introBody2 =>
      'Без сметка, без облак, без следење. Твоите податоци живеат на твојот уред.';

  @override
  String get introTitle3 => 'Сподели со помагачите';

  @override
  String get introBody3 =>
      'Скенирај код и два уреди се синхронизираат за секунди, користи споделена папка или испрати сè како една датотека.';

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
      'Ново: синхронизацијата сега нуди три јасни начини — и прашање за доверба пред нешто да тргне.';

  @override
  String get spotHomeStrays =>
      'Ново: скитниците имаат своја картичка тука горе — број, муцки, допрете за отворање.';

  @override
  String get spotHomeMenu =>
      'Ново: ова мени наоѓа дупликат мачки и колонии и ги спојува.';

  @override
  String get spotCatEdit =>
      'Ново: страницата е само за читање — моливот префрла на уредување, долг притисок на поле го уредува директно.';

  @override
  String get spotMapLayers =>
      'Ново: прикажете кругови за пребарување од 500 м околу местата на огласите на исчезната мачка.';

  @override
  String get spotStraysFlier =>
      'Ново: сликајте оглас за исчезната мачка — станува мачката, сопственикот и контактот.';

  @override
  String get spotStraysScan =>
      'Ново: скенирајте cat(a)log код од оглас за директно увезување на мачката.';

  @override
  String get introTitle4 => 'Исчезнати мачки';

  @override
  String get introBody4 =>
      'Сликајте оглас и исчезнатата мачка влегува во каталогот со контактот на сопственикот. Забележувања, кругови за пребарување и предлози за совпаѓање помагаат да се врати дома.';

  @override
  String get spotMapSearch =>
      'Ново: барај тука мачки, клаудери и луѓе — директно на картата.';

  @override
  String get spotCardChips =>
      'Ново: избери што се гледа на картичката пред да ја споделиш.';

  @override
  String get spotCatMenu =>
      'Ново: означи мачка како приватна (никогаш не го напушта уредот) или сокриј ја тука.';

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
}
