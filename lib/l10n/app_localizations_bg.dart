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
  String get noClowdersYet =>
      'Още няма клаудъри. Клаудърът е място, където живеят котки — приемният ти дом, жилището на осиновител. Създай първия по-долу.';

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
      'Котката изчезва от всички списъци и снимките ѝ се премахват — тук и, след следващата синхронизация, и на другите устройства.';

  @override
  String get sightingRecorded => 'Забелязването е записано на вашата позиция.';

  @override
  String get noLocationAvailable =>
      'Няма местоположение — вместо това задръжте върху картата.';

  @override
  String get locationDeniedForever =>
      'Достъпът до местоположението е блокиран. Разрешете го в системните настройки, за да използвате Stray Cam.';

  @override
  String get locationServiceOff =>
      'Местоположението е изключено на това устройство. Включете го в настройките и опитайте отново.';

  @override
  String get locationDenied =>
      'cat(a)log няма разрешение да използва местоположението ви. Опитайте отново и го разрешете при запитване.';

  @override
  String get locationNoFix =>
      'Позицията ви не можа да бъде определена сега. Опитайте отново на открито — GPS се нуждае от чист изглед към небето.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Чип номер';

  @override
  String get starterRemarks => 'Бележки';

  @override
  String get captureFlier => 'Заснемане на обява';

  @override
  String get addPhotosTo => 'Добавяне на снимките към…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count снимки добавени към $name';
  }

  @override
  String get scanPrintedCode => 'Сканиране на отпечатан код';

  @override
  String get chipScanHint =>
      'Сканира отпечатания QR/баркод от чип картата или ветеринарните документи — телефонът не може да прочете чипа в котката.';

  @override
  String get savingLabel => 'Запазване…';

  @override
  String ownerOfCat(String name) {
    return 'Собственик на $name';
  }

  @override
  String get sortLabel => 'Сортиране';

  @override
  String get viewAsTable => 'Показване като таблица';

  @override
  String get viewAsTiles => 'Показване като плочки';

  @override
  String get matchCandidatesTitle => 'Кандидати за съвпадение';

  @override
  String get findDuplicates => 'Търсене на дубликати';

  @override
  String get noDuplicates => 'В момента няма възможни дубликати.';

  @override
  String get similarName => 'Подобно име';

  @override
  String get sharePublicly => 'Публично споделяне…';

  @override
  String get privateNoShare =>
      'Тази котка е отбелязана като лична — личните данни никога не напускат устройството ви. Първо премахнете отметката, за да я споделите публично.';

  @override
  String get pickFramesTitle => 'Избор на кадри';

  @override
  String get suggestedFrames => 'Предложени кадри';

  @override
  String get scrubFrames => 'Превъртане на видеото';

  @override
  String get keepThisFrame => 'Запази този кадър';

  @override
  String get fromVideo => 'От видео…';

  @override
  String get videoMobileOnly =>
      'Изборът на кадри от видео работи в телефонното приложение (Android и iPhone) — още не на това устройство.';

  @override
  String get shareWhitelistExplainer =>
      'Изберете какво влиза във файла. Включват се само отметнатите полета.';

  @override
  String get exportShareFile => 'Експортиране на файл за споделяне…';

  @override
  String get hostedLink => 'Хостван линк (URL на качения файл)';

  @override
  String get inlineQr => 'Вграден QR (само текст, без снимки)';

  @override
  String get inlineTooBig =>
      'Твърде много данни за вграден код — махнете полета или използвайте хостван линк.';

  @override
  String get scanShareLabel => 'Сканиране на код за споделяне';

  @override
  String get notAShareCode => 'Този код не е споделяне на cat(a)log.';

  @override
  String get importShareTitle => 'Импортиране на тази котка?';

  @override
  String shareSource(String url) {
    return 'Източник: $url';
  }

  @override
  String get importLabel => 'Импортиране';

  @override
  String get strayAreaLabel => 'Възможна зона на скитане';

  @override
  String get prevPin => 'Предишен маркер';

  @override
  String get nextPin => 'Следващ маркер';

  @override
  String get noMissingCats => 'Още няма изчезнали котки с позиции на обяви.';

  @override
  String get noMatchCandidates => 'В момента няма кандидати за съвпадение.';

  @override
  String sameIdField(String field) {
    return 'Еднакъв $field';
  }

  @override
  String metersApart(String distance) {
    return 'На $distance м един от друг';
  }

  @override
  String get addFlier => 'Добавяне на обява';

  @override
  String get missingSinceLabel => 'Изчезнал от';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get cropPortrait => 'Изрязване на портрет';

  @override
  String get statusOwner => 'Собственик';

  @override
  String get ocrUnavailable =>
      'Разпознаването на текст не е налично на това устройство — въведете текста на обявата сами.';

  @override
  String get displayFormat => 'Показва се като';

  @override
  String get displayPlain => 'Обикновен текст';

  @override
  String get displayQr => 'QR код';

  @override
  String get displayBarcode => 'Баркод';

  @override
  String get editLabel => 'Редактиране';

  @override
  String get doneLabel => 'Готово';

  @override
  String get openSettings => 'Отвори настройките';

  @override
  String get notSaved => 'Не е запазено';

  @override
  String get birthdateInFuture => 'Датата на раждане не може да е в бъдещето.';

  @override
  String get deceasedInFuture => 'Датата на смъртта не може да е в бъдещето.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Датата на смъртта не може да е преди датата на раждане ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Датата на раждане не може да е след датата на смъртта ($date).';
  }

  @override
  String get malePregnant =>
      'Тази котка е записана като мъжка — мъжка котка не може да е бременна. Първо проверете пола.';

  @override
  String fatherNotMale(String name) {
    return '$name е записана като женска и не може да е бащата. Първо проверете пола.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name е записан като мъжки и не може да е майката. Първо проверете пола.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name е роден на $date — родител не може да се роди след котето си.';
  }

  @override
  String get genderFatherFemale =>
      'Тази котка е записана като баща на други котки — бащата не може да е женски. Първо проверете семейството.';

  @override
  String get genderMotherMale =>
      'Тази котка е записана като майка на други котки — майката не може да е мъжки. Първо проверете семейството.';

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
  String dateFormatError(String format) {
    return 'Грешен формат — използвайте $format';
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
      'Двете устройства ползват една и съща папка (напр. в Dropbox или на флашка). Всяка синхронизация оставя там вашите промени и взима тези на другата страна.';

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
  String get starterEmail => 'Имейл';

  @override
  String get starterPhone => 'Телефон';

  @override
  String get lookupUrlLabel => 'Връзка за търсене';

  @override
  String lookupUrlHelp(String token) {
    return 'Страницата на услугата с $token на мястото на номера, напр. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Провери';

  @override
  String lookupFailed(String url) {
    return 'Никое приложение не можа да отвори $url. Копирайте връзката в браузър.';
  }

  @override
  String get stepCat => 'Котка';

  @override
  String get stepOwner => 'Собственик';

  @override
  String get stepFace => 'Снимка на муцунката';

  @override
  String get stepRegistry => 'Регистър';

  @override
  String get stepReview => 'Проверка и запис';

  @override
  String get stepOwnerHint =>
      'Този, който търси котката — от това става неговата карта с контакта от обявата.';

  @override
  String get stepFaceHint =>
      'Изрежете муцунката на котката от обявата; тя става профилната снимка. Може да прескочите.';

  @override
  String get stepRegistryHint =>
      'Номера, намерени в обявата. Отметнатите се запазват при котката и се отварят по-късно.';

  @override
  String get noRegistryLinks =>
      'В тази обява няма връзки към регистри — тук няма какво да се прави.';

  @override
  String get unknownServiceHint => 'Непозната услуга';

  @override
  String get rememberService => 'Запомни услугата';

  @override
  String get rememberServiceHint =>
      'Дайте име на услугата и посочете номера във връзката. Следващата обява ще се попълни сама.';

  @override
  String get noIdInLink =>
      'Тази връзка не съдържа номер, който приложението да запази.';

  @override
  String get whichNumber => 'Коя част е номерът?';

  @override
  String get cropAgain => 'Изрежи отново';

  @override
  String get noFaceYet =>
      'Още няма снимка на муцунката — използва се снимката на обявата.';

  @override
  String get backLabel => 'Назад';

  @override
  String get dangerButton => 'НЕ НАТИСКАЙ.\nОПАСНО';

  @override
  String get dangerThanks => 'Благодарим, че използвате cat(a)log!';

  @override
  String get helpTitle => 'Помощ';

  @override
  String get showTipsAgain => 'Покажи съветите отново';

  @override
  String get helpHome =>
      'Прегледът на вашите колонии — колония е място, където живеят котки: домът ви, приемен дом, приют. Докоснете карта, за да видите котките ѝ; задържане отваря менюто. Бутонът долу вдясно създава колония, а картата на скитниците събира всички котки без дом.';

  @override
  String get helpClowder =>
      'Всичко за това място: котките му, полетата (адрес, контакт, вид) и историята. Страницата се отваря само за четене; моливът включва редакцията, там може и да добавите поле. Задържане на поле го редактира веднага, на котка — я мести, скрива или отваря.';

  @override
  String get helpCat =>
      'Всичко за тази котка: снимки, полета, семейство, история. Страницата е само за четене, докато не докоснете молива. Задържане на поле отваря директно редакцията му; на снимка — нейното меню. Менюто горе вдясно има останалото: лично, скрий, обедини, запиши наблюдение, сподели.';

  @override
  String get helpStrays =>
      'Котки, които сега нямат дом: намерени, избягали или взети от обява. Бутонът с камерата записва котка пред вас; бутонът с обявата превръща плакат в котка с контакта на стопанина; скенерът чете код cat(a)log от плаката.';

  @override
  String get helpMap =>
      'Всички котки и места с позиция. Търсенето намира котки, хора и места — непознато име се търси по целия свят. Бутонът за слоеве чертае кръговете от 500 м около местата на обявите на изчезнала котка и около дома, от който е избягала. Стрелките водят от карфица на карфица, задържане върху картата записва наблюдение.';

  @override
  String get helpCard =>
      'Печатната карта на котката: горе с чиповете избирате какво да пише на нея, после я споделяте като изображение или PDF. Номерата се печатат като QR или баркод, а позицията става QR, който отваря карта, плюс кратък Plus Code.';

  @override
  String get helpSync =>
      'Как данните стигат до други хора: свързване на място, папка, която двете устройства виждат, или файл през месинджър. Вие винаги решавате какво излиза — а получените .catsync файлове се отварят също тук.';

  @override
  String get helpFields =>
      'Полетата, които каталогът ви използва. Преименувайте ги, сменете опциите на поле с избор или добавете свои. Поле с идентификатор може да сочи към услуга (регистър) — тогава номерът при котката става натискаем.';

  @override
  String get helpTimeline =>
      'Всяка някога направена промяна, най-новата отгоре: кой какво кога и на каква стойност е сменил. Всеки запис може да се върне — това записва нов ред, нищо не се изтрива.';

  @override
  String get helpDuplicates =>
      'Котки или колонии, които изглеждат като едно и също два пъти — еднакви номера или много близки имена със съвпадащи детайли. Докоснете двойка, за да я слеете; сливането е необратимо, затова пита предварително.';

  @override
  String get helpMatches =>
      'Котки, които може да са едно и също животно: еднакъв номер или скитник, видян в района на търсене на изчезнала котка. Докоснете двойка за сливане, задържането отваря първата котка за сравнение.';

  @override
  String get helpFlier =>
      'От снимана обява става котка заедно със стопанина. Стъпка по стъпка: данни на котката, контакт на стопанина, изрязване на муцунката за профилната снимка, регистрационни номера от обявата и накрая проверка. Всичко са предложения — поправете каквото камерата е разчела грешно.';

  @override
  String get archiveTitle => 'Архив';

  @override
  String get archiveExplainer =>
      'Починали котки и празни колонии, които никой не е докосвал от години, пак заемат място — най-вече снимките им. Архивирането ги записва във файл, който пазите, и после ги изтрива оттук.';

  @override
  String get archiveAction => 'Архивирай';

  @override
  String archiveSelected(int count) {
    return 'Архивирай $count записа';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Да се архивират ли $count записа?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names ще бъдат записани във файл и после изтрити — на вашето устройство и на всяко, с което синхронизирате. Импортът на файла връща всичко; без него са загубени.';
  }

  @override
  String archiveDone(int count) {
    return 'Архивирани и изтрити записа: $count';
  }

  @override
  String archiveFailed(String error) {
    return 'Нищо не беше изтрито: архивният файл не можа да се запише ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'База данни $db, снимки $photos в $count файла';
  }

  @override
  String quietForYears(int years) {
    return 'Без промяна от $years години';
  }

  @override
  String get nothingToArchive => 'Няма нищо достатъчно старо за архивиране.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Последна промяна $date · снимки $size';
  }

  @override
  String get helpArchive =>
      'Старите данни заемат място, преди всичко снимките, които всяко синхронизирано устройство мъкне със себе си. Тук избирате починали котки и празни колонии, стояли без промяна с години, записвате ги във файл, който пазите, и ги изтривате. Изтриването стига до всички, с които синхронизирате; импортът на файла възстановява всичко.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Да се възстановят ли $count изтрити записа?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names са изтрити в този каталог, а току-що импортираният файл ги съдържа. Възстановяването ги връща тук и на всяко устройство, с което синхронизирате.';
  }

  @override
  String get restoreAction => 'Възстанови';

  @override
  String get keepDeleted => 'Остави изтрити';

  @override
  String get archiveNotSaved =>
      'Нищо не беше изтрито: архивът не беше запазен никъде.';

  @override
  String get locateAddress => 'Намери адреса на картата';

  @override
  String get addressLocated => 'Адресът е намерен';

  @override
  String get addressNotFound =>
      'Не е намерено място за този адрес. Проверете изписването или оставете полето празно.';

  @override
  String get starterPosition => 'Местоположение';

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
  String get markPrivate => 'Отбележи като лично';

  @override
  String get unmarkPrivate => 'Премахни личната отметка';

  @override
  String get includePrivate => 'Включи личните данни';

  @override
  String get includePrivateExplainer =>
      'Така се изпраща и всичко, отбелязано като лично. Този, с когото синхронизирате, ще го види.';

  @override
  String get hideLabel => 'Скрий на това устройство';

  @override
  String get unhideLabel => 'Покажи отново';

  @override
  String get showHiddenLabel => 'Покажи скритите';

  @override
  String get stopShowingHidden => 'Спри показването на скритите';

  @override
  String get starterSpecies => 'Вид';

  @override
  String get starterStatus => 'Тип';

  @override
  String get statusFoster => 'Приемен дом';

  @override
  String get statusForeverHome => 'Постоянен дом';

  @override
  String get statusClinic => 'Клиника';

  @override
  String get statusShelter => 'Приют';

  @override
  String get statusBarn => 'Плевня';

  @override
  String get valueCat => 'Котка';

  @override
  String get otherOption => 'Друго…';

  @override
  String get celebrationsToggle => 'Празнувай осиновяванията';

  @override
  String get celebrationsSubtitle =>
      'Конфети и радост, когато котка се мести в постоянен дом';

  @override
  String get onMapLabel => 'На картата';

  @override
  String get showOnMap => 'Покажи на картата';

  @override
  String get searchPlaceHint => 'Търси място или адрес';

  @override
  String get noPlacesFound => 'Няма намерени места';

  @override
  String get mapSearchHint => 'Търси котки, групи, хора';

  @override
  String get proposeAnotherName => 'Предложи друго име';

  @override
  String get moderationTitle => 'Автори и забрани';

  @override
  String get moderationSubtitle => 'Премахни данните на човек завинаги';

  @override
  String get authorsSection => 'Кой е писал в този каталог';

  @override
  String get hardDeleteAction => 'Изтрий всичко от този автор';

  @override
  String hardDeleteWarning(Object name) {
    return 'Премахва всеки запис и снимка от $name от това устройство. Другите устройства запазват своите. Не може да се отмени.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Въведи $name за потвърждение';
  }

  @override
  String get alsoBan => 'Също забрани — никога повече данни от него';

  @override
  String get bansSection => 'Забрани';

  @override
  String get unbanAction => 'Премахни забраната';

  @override
  String get deletedDone => 'Изтрито.';

  @override
  String get syncSummaryTitle => 'Какво пристигна';

  @override
  String get summaryAdopted => 'Осиновени';

  @override
  String get summaryDeceased => 'Починали';

  @override
  String get summaryEscaped => 'Избягали';

  @override
  String get summaryNew => 'Нови';

  @override
  String get summaryConflicts => 'Конфликти за решаване';

  @override
  String summaryOther(Object n) {
    return '…и още $n промени';
  }

  @override
  String get starterMother => 'Майка';

  @override
  String get starterFather => 'Баща';

  @override
  String get familySection => 'Семейство';

  @override
  String get littermatesLabel => 'От едно котило';

  @override
  String get siblingsLabel => 'Братя и сестри';

  @override
  String get kittensLabel => 'Котенца';

  @override
  String get toastSettingsTitle => 'Какво да се обявява';

  @override
  String get toastSettingsSubtitle => 'Кратки съобщения след синхронизация';

  @override
  String get toastKindAdoptions => 'Осиновявания';

  @override
  String get toastKindBirths => 'Раждания';

  @override
  String get toastKindDeaths => 'Смъртни случаи';

  @override
  String get toastKindEscapes => 'Бягства';

  @override
  String get toastKindMoves => 'Премествания';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat осиновена от $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Ново котенце: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat почина';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat избяга';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat се премести в $home';
  }

  @override
  String get notACatlogFile => 'Това не е файл на cat(a)log';

  @override
  String get nothingNewInBundle => 'Нищо ново във файла — вече имаш всичко';

  @override
  String get syncChooserInPerson => 'На живо';

  @override
  String get syncChooserInPersonSub =>
      'В една стая сте — сканирай код, готово за секунди';

  @override
  String get syncChooserRemote => 'От разстояние';

  @override
  String get syncChooserRemoteSub =>
      'Чрез споделена папка като Dropbox или USB';

  @override
  String get syncChooserMessenger => 'Месинджър';

  @override
  String get syncChooserMessengerSub =>
      'Изпратете всичко като един файл през кой да е месинджър — и импортирайте получен .catsync файл тук';

  @override
  String get connectToWifiFirst =>
      'Първо се свържи с Wi-Fi — тогава устройствата се намират';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) иска да синхронизира';
  }

  @override
  String get trustBothWaysNote => 'Каталозите ще се обменят в двете посоки.';

  @override
  String get allowOnce => 'Позволи';

  @override
  String get allowAlways => 'Винаги позволявай това устройство';

  @override
  String get declineAction => 'Откажи';

  @override
  String get syncDeclined => 'Другото устройство отказа синхронизацията';

  @override
  String get trustedDevicesSection => 'Винаги позволени устройства';

  @override
  String get removeTrust => 'Премахни';

  @override
  String get hostWithoutWifi => 'Хостване без Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Създава временна директна връзка с другия телефон (без интернет). Само cat(a)log я използва и се прекъсва сама след синхронизацията.';

  @override
  String get hotspotAndroidOnly =>
      'Този код изисква два Android телефона — на iPhone/iPad използвай обща Wi-Fi мрежа';

  @override
  String get selectClowderHint => 'Избери клаудър отляво';

  @override
  String get introTitle1 => 'Вашите котки, подредени';

  @override
  String get introBody1 =>
      'Създайте карта за всяка котка: снимка, пол, здраве — всичко, което искате да отбележите. Котките са групирани по мястото, където живеят — приложението го нарича колония (clowder).';

  @override
  String get introTitle2 => 'Работи без интернет';

  @override
  String get introBody2 =>
      'Всичко се записва само на телефона ви. Без акаунт, без облак. Нищо не се изпраща, освен ако сами не го споделите.';

  @override
  String get introTitle3 => 'Работете заедно';

  @override
  String get introBody3 =>
      'Всеки ползва своето приложение и от време на време обменяте данни: срещнете се и сканирайте код, ползвайте споделена папка или изпратете един файл по месинджър. После всички имат една и съща информация.';

  @override
  String get introSkip => 'Пропусни';

  @override
  String get introNext => 'Напред';

  @override
  String get introDone => 'Да започваме';

  @override
  String get introReplayTitle => 'Кратко въведение';

  @override
  String get spotHomeSync =>
      'Тук синхронизирате с познатите си. Вие решавате какво споделяте.';

  @override
  String get spotHomeStrays =>
      'Тази карта събира всички скитащи котки — котки без дом. Докоснете за списъка.';

  @override
  String get spotHomeMenu =>
      'В това меню: намиране и сливане на дубликати, експорт в CSV и още.';

  @override
  String get spotCatEdit =>
      'Докоснете молива, за да редактирате котката. Съвет: задръжте поле, за да го редактирате направо.';

  @override
  String get spotMapLayers =>
      'Търсите изчезнала котка? Покажете кръгове около местата на обявите ѝ и около дома, от който е избягала.';

  @override
  String get spotStraysFlier =>
      'Обява за изчезнала котка? Снимайте я тук — приложението записва котката и контакта вместо вас.';

  @override
  String get spotStraysScan =>
      'Някои обяви носят QR код на cat(a)log. Сканирайте го тук и импортирайте котката без писане.';

  @override
  String get introTitle4 => 'Намерете изчезнали котки';

  @override
  String get introBody4 =>
      'Виждате обява за изчезнала котка? Снимайте я в приложението: то записва котката, контакта на собственика и мястото. Появи ли се по-късно подобна скитаща котка, приложението предлага възможни съвпадения.';

  @override
  String get spotMapSearch =>
      'Въведете котка, място или човек, за да скочите там на картата.';

  @override
  String get spotCardChips =>
      'Отметнете какво да присъства на споделяемата карта — останалото остава извън нея.';

  @override
  String get spotCatMenu =>
      'Още действия тук: маркирайте котката като лична, скрийте я, слейте дубликати или запишете наблюдение.';

  @override
  String get spotDone => 'Ясно';

  @override
  String get spotReplayTitle => 'Обиколка на новото';

  @override
  String get spotReplaySubtitle =>
      'Покажи подсказките отново на всяка страница';

  @override
  String get spotReplayDone => 'Подсказките ще се покажат отново';

  @override
  String get searchNoResults => 'Няма котка с това име';

  @override
  String get syncUnreachable =>
      'Другото устройство е недостъпно. И двете ли са в една Wi-Fi мрежа?';

  @override
  String get folderUnreachable =>
      'Папката е недостъпна. Дискът или облачната папка още ли съществува?';

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

  @override
  String get catalogsTitle => 'Каталози';

  @override
  String get newCatalog => 'Нов каталог';

  @override
  String get catalogNameLabel => 'Име на каталога';

  @override
  String catalogNameTaken(String name) {
    return 'Вече има каталог с името $name. Изберете друго име.';
  }

  @override
  String get manageCatalogs => 'Управление на каталозите';

  @override
  String get helpCatalogs =>
      'Всеки каталог е свой свят: свои котки, колонии, полета, снимки и партньори за синхронизация. Берлин и Париж никога не се смесват. Докоснете името горе на началния екран, за да смените, добавите или преименувате. Името ви, езикът и вече видените съвети са общи за всички.';

  @override
  String get spotHomeCatalog =>
      'Това е каталогът, в който сте. Докоснете името, за да смените или да добавите нов.';
}
