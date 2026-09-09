// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Вітаємо в cat(a)log';

  @override
  String get welcomeBody =>
      'Оберіть собі ім\'я. Кожна зміна записується під цим ім\'ям, щоб інші бачили, хто що зробив.';

  @override
  String get yourName => 'Ваше ім\'я';

  @override
  String get start => 'Почати';

  @override
  String get clowders => 'Клаудери';

  @override
  String get clowdersNeutral => 'Домогосподарства';

  @override
  String get noClowdersYet =>
      'Клаудерів ще немає. Клаудер — це місце, де живуть коти: ваш тимчасовий дім, квартира усиновлювача. Створіть перший нижче.';

  @override
  String get noClowdersYetNeutral =>
      'Домогосподарств ще немає. Домогосподарство — це місце, де живуть улюбленці: ваш дім, тимчасовий дім, квартира усиновлювача. Створіть перше нижче.';

  @override
  String get strays => 'Безпритульні';

  @override
  String get searchCats => 'Пошук котів';

  @override
  String get searchCatsNeutral => 'Пошук улюбленців';

  @override
  String get map => 'Мапа';

  @override
  String get sync => 'Синхронізація';

  @override
  String get fields => 'Поля';

  @override
  String get pickerColumns => 'Стовпці';

  @override
  String get pickerCardFields => 'На картці';

  @override
  String get exportCsv => 'Експорт CSV';

  @override
  String get aboutAndFeedback => 'Про застосунок і відгуки';

  @override
  String get settings => 'Налаштування';

  @override
  String get newClowder => 'Новий клаудер';

  @override
  String get newClowderNeutral => 'Нове домогосподарство';

  @override
  String get name => 'Ім\'я';

  @override
  String get cancel => 'Скасувати';

  @override
  String get create => 'Створити';

  @override
  String get save => 'Зберегти';

  @override
  String get delete => 'Видалити';

  @override
  String get merge => 'Об\'єднати';

  @override
  String get resolve => 'Вирішити';

  @override
  String get open => 'Відкрити';

  @override
  String csvSavedTo(String path) {
    return 'CSV збережено в $path';
  }

  @override
  String get renameClowder => 'Перейменувати клаудер';

  @override
  String get renameClowderNeutral => 'Перейменувати домогосподарство';

  @override
  String get rename => 'Перейменувати';

  @override
  String get timeline => 'Історія';

  @override
  String get mergeInto => 'Об\'єднати з…';

  @override
  String get deleteClowder => 'Видалити клаудер';

  @override
  String get deleteClowderNeutral => 'Видалити домогосподарство';

  @override
  String get cats => 'Коти';

  @override
  String get catsNeutral => 'Улюбленці';

  @override
  String get addCat => 'Додати кота';

  @override
  String get addCatNeutral => 'Додати улюбленця';

  @override
  String get newCat => 'Новий кіт';

  @override
  String get newCatNeutral => 'Новий улюбленець';

  @override
  String deleteQuestion(String name) {
    return 'Видалити $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудер зникне зі списку.';

  @override
  String get deleteClowderEmptyBodyNeutral =>
      'Домогосподарство зникне зі списку.';

  @override
  String deleteClowderBody(int count) {
    return 'Його котів ($count) не буде видалено — вони стануть безпритульними. Спершу перемістіть їх до іншого клаудера, якщо це не те, чого ви хочете.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Його улюбленців ($count) не буде видалено — вони стануть безпритульними. Спершу перемістіть їх до іншого домогосподарства, якщо це не те, чого ви хочете.';
  }

  @override
  String get card => 'Картка';

  @override
  String get shareAsImage => 'Поділитися як зображенням';

  @override
  String get sortOldestFirst => 'Спочатку старі';

  @override
  String get sortNewestFirst => 'Спочатку нові';

  @override
  String get shareAsText => 'Поділитися текстом';

  @override
  String get shareAsPdf => 'Поділитися як PDF';

  @override
  String get print => 'Друк';

  @override
  String cardTitle(String name) {
    return 'Картка — $name';
  }

  @override
  String get renameCat => 'Перейменувати кота';

  @override
  String get renameCatNeutral => 'Перейменувати улюбленця';

  @override
  String get seenHereNow => 'Бачили тут щойно';

  @override
  String get deleteCat => 'Видалити кота';

  @override
  String get deleteCatNeutral => 'Видалити улюбленця';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get clowderLabelNeutral => 'Домогосподарство';

  @override
  String get strayNoClowder => 'Безпритульний — без клаудера';

  @override
  String get strayNoClowderNeutral => 'Безпритульний — без домогосподарства';

  @override
  String get stray => 'Безпритульний';

  @override
  String get photos => 'Фото';

  @override
  String get addPhoto => 'Додати фото';

  @override
  String get setAsProfileImage => 'Зробити фото профілю';

  @override
  String get thisIsProfileImage => 'Це фото профілю';

  @override
  String get deletePhoto => 'Видалити фото';

  @override
  String get deletePhotoTitle => 'Видалити фото?';

  @override
  String get deletePhotoBody =>
      'Дані фото буде видалено назавжди — це неможливо скасувати.';

  @override
  String get deleteCatBody =>
      'Кіт зникне з усіх списків, його фото буде видалено — тут і, після наступної синхронізації, на інших пристроях.';

  @override
  String get deleteCatBodyNeutral =>
      'Улюбленець зникне з усіх списків, його фото буде видалено — тут і, після наступної синхронізації, на інших пристроях.';

  @override
  String get sightingRecorded => 'Зустріч записано у вашій позиції.';

  @override
  String get noLocationAvailable =>
      'Немає геолокації — натомість утримуйте палець на мапі.';

  @override
  String get locationDeniedForever =>
      'Доступ до місцезнаходження заблоковано. Дозвольте його в налаштуваннях системи, щоб користуватися Stray Cam.';

  @override
  String get locationServiceOff =>
      'Геолокацію на цьому пристрої вимкнено. Увімкніть її в налаштуваннях і спробуйте ще раз.';

  @override
  String get locationDenied =>
      'cat(a)log не має дозволу використовувати ваше місцезнаходження. Спробуйте ще раз і надайте дозвіл, коли з\'явиться запит.';

  @override
  String get locationNoFix =>
      'Не вдалося визначити вашу позицію. Спробуйте ще раз просто неба — GPS потрібен відкритий огляд неба.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Номер чипа';

  @override
  String get starterRemarks => 'Нотатки';

  @override
  String get captureFlier => 'Сфотографувати оголошення';

  @override
  String get addPhotosTo => 'Додати фото до…';

  @override
  String photosAddedTo(String count, String name) {
    return 'Додано фото: $count — $name';
  }

  @override
  String get scanPrintedCode => 'Сканувати надрукований код';

  @override
  String get chipScanHint =>
      'Сканує надрукований QR/штрихкод з картки чипа або ветеринарних документів — сам чип у кішці телефон прочитати не може.';

  @override
  String get chipScanHintNeutral =>
      'Сканує надрукований QR/штрихкод з картки чипа або ветеринарних документів — сам чип у тварині телефон прочитати не може.';

  @override
  String get savingLabel => 'Збереження…';

  @override
  String ownerOfCat(String name) {
    return 'Власник $name';
  }

  @override
  String get sortLabel => 'Сортування';

  @override
  String get viewAsTable => 'Показати таблицею';

  @override
  String get viewAsTiles => 'Показати плитками';

  @override
  String get viewAsList => 'Показати списком';

  @override
  String get ageLabel => 'Вік';

  @override
  String get catList => 'Список котів';

  @override
  String get catListNeutral => 'Список улюбленців';

  @override
  String get matchCandidatesTitle => 'Можливі збіги';

  @override
  String get findDuplicates => 'Знайти дублікати';

  @override
  String get noDuplicates => 'Наразі можливих дублікатів немає.';

  @override
  String get similarName => 'Схоже ім\'я';

  @override
  String get sharePublicly => 'Поділитися публічно…';

  @override
  String get pickFramesTitle => 'Вибір кадрів';

  @override
  String get suggestedFrames => 'Запропоновані кадри';

  @override
  String get scrubFrames => 'Перемотування відео';

  @override
  String get keepThisFrame => 'Залишити цей кадр';

  @override
  String get fromVideo => 'З відео…';

  @override
  String addingPhotos(int done, int total) {
    return 'Додавання світлини $done з $total…';
  }

  @override
  String get videoMobileOnly =>
      'Вибір кадрів з відео працює в телефонному застосунку (Android та iPhone) — на цьому пристрої поки ні.';

  @override
  String get shareWhitelistExplainer =>
      'Виберіть, що потрапить у файл. Включаються лише позначені поля.';

  @override
  String get exportShareFile => 'Експортувати файл обміну…';

  @override
  String get hostedLink => 'Розміщене посилання (URL завантаженого файлу)';

  @override
  String get inlineQr => 'Вбудований QR (лише текст, без фото)';

  @override
  String get inlineTooBig =>
      'Забагато даних для вбудованого коду — зніміть поля або скористайтеся розміщеним посиланням.';

  @override
  String get scanShareLabel => 'Сканувати код обміну';

  @override
  String get notAShareCode => 'Цей код — не обмін cat(a)log.';

  @override
  String get importShareTitle => 'Імпортувати цю кішку?';

  @override
  String get importShareTitleNeutral => 'Імпортувати цього улюбленця?';

  @override
  String shareSource(String url) {
    return 'Джерело: $url';
  }

  @override
  String get importLabel => 'Імпортувати';

  @override
  String get strayAreaLabel => 'Можлива зона блукання';

  @override
  String get prevPin => 'Попередня мітка';

  @override
  String get nextPin => 'Наступна мітка';

  @override
  String get noMissingCats =>
      'Поки немає зниклих котів із позиціями оголошень.';

  @override
  String get noMissingCatsNeutral =>
      'Поки немає зниклих улюбленців із позиціями оголошень.';

  @override
  String get noMatchCandidates => 'Наразі можливих збігів немає.';

  @override
  String sameIdField(String field) {
    return 'Однаковий $field';
  }

  @override
  String metersApart(String distance) {
    return 'На відстані $distance м';
  }

  @override
  String get addFlier => 'Додати оголошення';

  @override
  String get missingSinceLabel => 'Зник з';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get cropPortrait => 'Обрізати портрет';

  @override
  String get statusOwner => 'Власник';

  @override
  String get ocrUnavailable =>
      'Розпізнавання тексту недоступне на цьому пристрої — введіть текст оголошення вручну.';

  @override
  String get displayFormat => 'Показується як';

  @override
  String get displayPlain => 'Звичайний текст';

  @override
  String get displayQr => 'QR-код';

  @override
  String get displayBarcode => 'Штрихкод';

  @override
  String get editLabel => 'Редагувати';

  @override
  String get doneLabel => 'Готово';

  @override
  String get openSettings => 'Відкрити налаштування';

  @override
  String get notSaved => 'Не збережено';

  @override
  String get birthdateInFuture => 'Дата народження не може бути в майбутньому.';

  @override
  String get deceasedInFuture => 'Дата смерті не може бути в майбутньому.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Дата смерті не може бути раніше за дату народження ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Дата народження не може бути пізніше за дату смерті ($date).';
  }

  @override
  String get malePregnant =>
      'Цього кота записано як самця — самець не може бути вагітним. Спершу перевірте стать.';

  @override
  String get malePregnantNeutral =>
      'Цього улюбленця записано як самця — самець не може бути вагітним. Спершу перевірте стать.';

  @override
  String fatherNotMale(String name) {
    return '$name записана як самка і не може бути батьком. Спершу перевірте стать.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name записаний як самець і не може бути матір\'ю. Спершу перевірте стать.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name народився $date — батько чи мати не можуть народитися після свого кошеняти.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name народився $date — батько чи мати не можуть народитися після свого малюка.';
  }

  @override
  String get genderFatherFemale =>
      'Цього кота записано як батька інших котів — батько не може бути самкою. Спершу перевірте родину.';

  @override
  String get genderFatherFemaleNeutral =>
      'Цього улюбленця записано як батька інших улюбленців — батько не може бути самкою. Спершу перевірте родину.';

  @override
  String get genderMotherMale =>
      'Цю кішку записано як матір інших котів — мати не може бути самцем. Спершу перевірте родину.';

  @override
  String get genderMotherMaleNeutral =>
      'Цього улюбленця записано як матір інших улюбленців — мати не може бути самцем. Спершу перевірте родину.';

  @override
  String get moveTo => 'Перемістити до';

  @override
  String get noClowderStrayOption => 'Без клаудера — безпритульний / втік';

  @override
  String get noClowderStrayOptionNeutral =>
      'Без домогосподарства — безпритульний / втік';

  @override
  String timelineOf(String name) {
    return 'Історія — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String fieldCleared(String field) {
    return '$field очищено';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field повернуто до «$value»';
  }

  @override
  String get leftStray => 'Пішов — безпритульний';

  @override
  String movedTo(String name) {
    return 'Переміщено до $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat прибув';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat прибув з $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat пішов до $place';
  }

  @override
  String get duplicateMergedIn => 'Дублікат об\'єднано';

  @override
  String get asOfToday => 'Станом на сьогодні';

  @override
  String asOfDate(String date) {
    return 'Станом на $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Неправильний формат — використовуйте $format';
  }

  @override
  String get dateInFuture => 'Ця дата не може бути в майбутньому.';

  @override
  String get value => 'Значення';

  @override
  String get latitudeLongitude => 'широта, довгота';

  @override
  String get newField => 'Нове поле';

  @override
  String get fieldType => 'Тип';

  @override
  String get usedOn => 'Використовується для';

  @override
  String get forCats => 'котів';

  @override
  String get forCatsNeutral => 'улюбленців';

  @override
  String get forClowders => 'клаудерів';

  @override
  String get forClowdersNeutral => 'домогосподарств';

  @override
  String get forBoth => 'обох';

  @override
  String get optionsOnePerLine => 'Варіанти (по одному в рядку)';

  @override
  String get ownValue => 'Власне значення';

  @override
  String get renameField => 'Перейменувати поле';

  @override
  String get editOptions => 'Змінити варіанти…';

  @override
  String get noStraysRightNow => 'Зараз безпритульних немає.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Додати безпритульного';

  @override
  String get newStray => 'Новий безпритульний';

  @override
  String get searchByNameHint => 'Пошук котів за ім\'ям…';

  @override
  String get searchByNameHintNeutral => 'Пошук улюбленців за ім\'ям…';

  @override
  String get host => 'Роздати';

  @override
  String get hostExplainer =>
      'Почніть тут, потім відскануйте код або введіть його на іншому пристрої.';

  @override
  String get startHosting => 'Почати роздачу';

  @override
  String get stopHosting => 'Зупинити роздачу';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Сеансів: $count';
  }

  @override
  String get join => 'Приєднатися';

  @override
  String get addressFromHost => 'Адреса (з пристрою-хоста)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Синхронізувати зараз';

  @override
  String get addressFormatHint => 'Адреса має виглядати як 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Синхронізовано: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Помилка синхронізації: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Остання синхронізація з $peer: $time';
  }

  @override
  String get sharedFolder => 'Спільна тека';

  @override
  String get sharedFolderExplainer =>
      'Обидва пристрої використовують одну теку (наприклад, у Nextcloud або на флешці). Кожна синхронізація кладе туди ваші зміни й забирає чужі.';

  @override
  String get noFolderChosenYet => 'Теку ще не обрано';

  @override
  String get choose => 'Обрати…';

  @override
  String get syncFolderNow => 'Синхронізувати теку зараз';

  @override
  String folderCatalogHint(Object name) {
    return 'Усередині цей каталог використовує теку «$name», тож одна спільна тека може нести всі ваші каталоги.';
  }

  @override
  String get useSameFolder => 'Використати ту саму теку, що й інші каталоги';

  @override
  String get folderHint =>
      'Підійде будь-яка тека, яку два пристрої тримають однаковою: хмарний диск або Syncthing для теки, що залишається на ваших телефонах. Syncthing безкоштовний: встановіть його на кожному телефоні, відкрийте одну теку між ними й оберіть її тут на кожному пристрої.';

  @override
  String folderSynced(String result) {
    return 'Теку синхронізовано: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Помилка синхронізації теки: $error';
  }

  @override
  String get recordSightingHere => 'Записати зустріч тут:';

  @override
  String trailOf(String name, int count) {
    return 'Маршрут: $name (зустрічей: $count)';
  }

  @override
  String trailOfField(String name, String field, int count) {
    return 'Маршрут: $name — $field ($count значень)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Маршрут: $name ($count позицій)';
  }

  @override
  String conflictOn(String field) {
    return 'Конфлікт — $field';
  }

  @override
  String get conflictBody =>
      'Змінено у двох місцях одночасно. Оберіть, що є правдою:';

  @override
  String privateMarker(Object field) {
    return '$field (особисте)';
  }

  @override
  String conflictSame(Object value) {
    return 'Обидві зміни кажуть те саме: $value. Нема чого вибирати; «Розв’язати» знімає позначку.';
  }

  @override
  String mergeThisInto(String kind) {
    return 'Об\'єднати цей запис ($kind) з…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Немає іншого запису ($kind) для об\'єднання.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Об\'єднати з $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Два записи стануть одним. $name збереже поточні значення; історія іншого приєднається до нього. Це неможливо скасувати.';
  }

  @override
  String get kindCat => 'кіт';

  @override
  String get kindCatNeutral => 'улюбленець';

  @override
  String get kindClowder => 'клаудер';

  @override
  String get kindClowderNeutral => 'домогосподарство';

  @override
  String get kindField => 'поле';

  @override
  String get takePhoto => 'Зробити фото';

  @override
  String get chooseFromGallery => 'Обрати з галереї';

  @override
  String get about => 'Про застосунок';

  @override
  String get aboutTagline =>
      'Локальний каталог котів на перетримці. Ваші дані залишаються на ваших пристроях — без сервера, без облікового запису.';

  @override
  String get aboutTaglineNeutral =>
      'Локальний каталог улюбленців, про яких ви дбаєте. Ваші дані залишаються на ваших пристроях — без сервера, без облікового запису.';

  @override
  String versionLabel(String version, String build) {
    return 'Версія $version ($build)';
  }

  @override
  String get sourceCode => 'Вихідний код';

  @override
  String get reportProblemOrIdea => 'Повідомити про проблему чи ідею';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Написати розробнику';

  @override
  String get buyCoffee => 'Пригостити розробника кавою';

  @override
  String get coffeeSubtitle =>
      'Застосунок залишається безплатним. Навіть якщо кави мені не буде :)';

  @override
  String get openSourceLicenses => 'Ліцензії відкритого коду';

  @override
  String get machineTranslated =>
      'Переклади машинні — виправлення вітаються на GitHub.';

  @override
  String get unnamed => '(без імені)';

  @override
  String get labelName => 'Ім\'я';

  @override
  String get labelProfileImage => 'Фото профілю';

  @override
  String get labelPhoto => 'Фото';

  @override
  String get starterGender => 'Стать';

  @override
  String get starterBreed => 'Порода';

  @override
  String get valueMixed => 'метис';

  @override
  String get breedEuropeanShorthair => 'Європейська короткошерста';

  @override
  String get breedMaineCoon => 'Мейн-кун';

  @override
  String get breedBritishShorthair => 'Британська короткошерста';

  @override
  String get breedNorwegianForestCat => 'Норвезька лісова';

  @override
  String get breedRagdoll => 'Регдол';

  @override
  String get breedSiamese => 'Сіамська';

  @override
  String get breedPersian => 'Перська';

  @override
  String get breedBengal => 'Бенгальська';

  @override
  String get breedSphynx => 'Сфінкс';

  @override
  String get breedAbyssinian => 'Абіссінська';

  @override
  String get breedAmericanShorthair => 'Американська короткошерста';

  @override
  String get breedBalinese => 'Балінезійська';

  @override
  String get breedBirman => 'Бірманська';

  @override
  String get breedBombay => 'Бомбейська';

  @override
  String get breedBurmese => 'Бурманська';

  @override
  String get breedBurmilla => 'Бурмілла';

  @override
  String get breedBritishLonghair => 'Британська довгошерста';

  @override
  String get breedChartreux => 'Шартрез';

  @override
  String get breedCornishRex => 'Корніш-рекс';

  @override
  String get breedDevonRex => 'Девон-рекс';

  @override
  String get breedEgyptianMau => 'Єгипетська мау';

  @override
  String get breedExoticShorthair => 'Екзотична короткошерста';

  @override
  String get breedHimalayan => 'Гімалайська';

  @override
  String get breedKorat => 'Корат';

  @override
  String get breedManx => 'Менкс';

  @override
  String get breedMunchkin => 'Манчкін';

  @override
  String get breedOcicat => 'Оцикет';

  @override
  String get breedOrientalShorthair => 'Орієнтальна короткошерста';

  @override
  String get breedRagamuffin => 'Рагамаффін';

  @override
  String get breedRussianBlue => 'Російська блакитна';

  @override
  String get breedSavannah => 'Савана';

  @override
  String get breedScottishFold => 'Шотландська висловуха';

  @override
  String get breedSelkirkRex => 'Селкірк-рекс';

  @override
  String get breedSiberian => 'Сибірська';

  @override
  String get breedSnowshoe => 'Сноу-шу';

  @override
  String get breedSomali => 'Сомалійська';

  @override
  String get breedTonkinese => 'Тонкінська';

  @override
  String get breedTurkishAngora => 'Турецька ангора';

  @override
  String get breedTurkishVan => 'Турецький ван';

  @override
  String get starterColor => 'Забарвлення';

  @override
  String get starterNeutered => 'Стерилізований';

  @override
  String get starterPregnant => 'Вагітна';

  @override
  String get starterBirthdate => 'Дата народження';

  @override
  String get starterDeceased => 'Помер';

  @override
  String get starterAddress => 'Адреса';

  @override
  String get starterResponsible => 'Відповідальна особа';

  @override
  String get starterEmail => 'Ел. пошта';

  @override
  String get starterPhone => 'Телефон';

  @override
  String get lookupUrlLabel => 'Посилання для пошуку';

  @override
  String lookupUrlHelp(String token) {
    return 'Сторінка служби з $token на місці номера, напр. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Знайти';

  @override
  String lookupFailed(String url) {
    return 'Жодний застосунок не зміг відкрити $url. Скопіюйте посилання у браузер.';
  }

  @override
  String get stepCat => 'Кіт';

  @override
  String get stepCatNeutral => 'Улюбленець';

  @override
  String get stepOwner => 'Власник';

  @override
  String get stepFace => 'Фото мордочки';

  @override
  String get stepRegistry => 'Реєстр';

  @override
  String get stepReview => 'Перевірити й зберегти';

  @override
  String get stepOwnerHint =>
      'Той, хто шукає кота, — з цього вийде його клаудер з контактом з оголошення.';

  @override
  String get stepOwnerHintNeutral =>
      'Той, хто шукає улюбленця, — з цього вийде його домогосподарство з контактом з оголошення.';

  @override
  String get stepFaceHint =>
      'Виріжте мордочку кота з оголошення; вона стане фото профілю. Крок можна пропустити.';

  @override
  String get stepFaceHintNeutral =>
      'Виріжте мордочку улюбленця з оголошення; вона стане фото профілю. Крок можна пропустити.';

  @override
  String get stepRegistryHint =>
      'Номери, знайдені в оголошенні. Позначені збережуться в кота й відкриються пізніше.';

  @override
  String get stepRegistryHintNeutral =>
      'Номери, знайдені в оголошенні. Позначені збережуться в улюбленця й відкриються пізніше.';

  @override
  String get noRegistryLinks =>
      'У цьому оголошенні немає посилань на реєстри — якщо якісь пропущено, повідомте про помилку.';

  @override
  String get unknownServiceHint => 'Невідома служба';

  @override
  String get rememberService => 'Запам\'ятати службу';

  @override
  String get rememberServiceHint =>
      'Назвіть службу і вкажіть номер у посиланні. Наступне оголошення заповниться саме.';

  @override
  String get noIdInLink =>
      'У цьому посиланні немає номера, який застосунок міг би зберегти.';

  @override
  String get whichNumber => 'Яка частина — номер?';

  @override
  String get cropAgain => 'Обрізати ще раз';

  @override
  String get noFaceYet => 'Фото мордочки ще немає — береться фото оголошення.';

  @override
  String get backLabel => 'Назад';

  @override
  String get dangerButton => 'НЕ НАТИСКАТИ.\nНЕБЕЗПЕЧНО';

  @override
  String get dangerThanks => 'Дякуємо, що користуєтеся cat(a)log!';

  @override
  String get helpTitle => 'Довідка';

  @override
  String get showTipsAgain => 'Показати підказки знову';

  @override
  String get helpHome =>
      'Огляд ваших колоній — колонія це місце, де живуть коти: ваш дім, перетримка, притулок. Торкніться картки, щоб побачити її котів; довге натискання відкриває меню. Кнопка внизу праворуч створює колонію, а картка безпритульних збирає всіх котів без дому. Назва вгорі — каталог, у якому ви зараз; торкніться, щоб перемкнути або додати.';

  @override
  String get helpHomeNeutral =>
      'Огляд ваших домогосподарств — домогосподарство це місце, де живуть улюбленці: ваш дім, перетримка, притулок. Торкніться картки, щоб побачити її улюбленців; довге натискання відкриває меню. Кнопка внизу праворуч створює домогосподарство, а картка безпритульних збирає всіх улюбленців без дому. Назва вгорі — каталог, у якому ви зараз; торкніться, щоб перемкнути або додати.';

  @override
  String get helpClowder =>
      'Усе про це місце: його коти, поля (адреса, контакт, тип) та історія. Сторінка відкривається лише для читання; олівець вмикає редагування, там же можна додати поле. Довге натискання на поле редагує його одразу, на кота — переміщує, приховує або відкриває його. Доданий тут прийом може взяти кількох котів колонії, наприклад на стерилізацію: позначте котів, які їдуть, завершіть один раз, зніміть позначку з тих, кого не лікували. Годинник біля поля відкриває його історію.';

  @override
  String get helpClowderNeutral =>
      'Усе про це місце: його улюбленці, поля (адреса, контакт, тип) та історія. Сторінка відкривається лише для читання; олівець вмикає редагування, там же можна додати поле. Довге натискання на поле редагує його одразу, на улюбленця — переміщує, приховує або відкриває його. Доданий тут прийом може взяти кількох улюбленців домогосподарства, наприклад на стерилізацію: позначте улюбленців, які їдуть, завершіть один раз, зніміть позначку з тих, кого не лікували. Годинник біля поля відкриває його історію.';

  @override
  String get helpCat =>
      'Усе про цю кішку: фото, поля, родина, історія. Сторінка лише для читання, поки не торкнешся олівця. Довге натискання на поле одразу відкриває редагування; довге натискання на фото відкриває його меню. Меню праворуч угорі тримає решту: сховати, об\'єднати, записати спостереження, поділитися кішкою. «Приватно» задається під час редагування поля. Годинник біля поля відкриває його історію.';

  @override
  String get helpCatNeutral =>
      'Усе про цього улюбленця: фото, поля, родина, історія. Сторінка лише для читання, поки не торкнешся олівця. Довге натискання на поле одразу відкриває редагування; довге натискання на фото відкриває його меню. Меню праворуч угорі тримає решту: сховати, об\'єднати, записати спостереження, поділитися улюбленцем. «Приватно» задається під час редагування поля. Годинник біля поля відкриває його історію.';

  @override
  String get helpStrays =>
      'Коти, які зараз не мають дому: знайдені, втеклі або взяті з оголошення. Кнопка камери записує кота, що сидить перед вами; кнопка оголошення перетворює плакат на кота з контактом власника; сканер читає код cat(a)log з плаката. Торкніться Stray Cam для фото; утримуйте, щоб зняти відео й зберегти найкращі кадри як фото.';

  @override
  String get helpStraysNeutral =>
      'Улюбленці, які зараз не мають дому: знайдені, втеклі або взяті з оголошення. Кнопка камери записує тварину, що перед вами; кнопка оголошення перетворює плакат на улюбленця з контактом власника; сканер читає код cat(a)log з плаката. Торкніться Stray Cam для фото; утримуйте, щоб зняти відео й зберегти найкращі кадри як фото.';

  @override
  String get helpMap =>
      'Усі коти й місця з координатами. Пошук знаходить котів, людей і місця — незнайому назву шукає в усьому світі. Кнопка шарів малює кола 500 м навколо місць оголошень зниклого кота та навколо дому, з якого він утік. Стрілки ведуть від мітки до мітки, довге натискання на карту записує спостереження. Кожне поле з місцем — шпилька на мапі; торкніться шпильки, щоб побачити маршрут.';

  @override
  String get helpMapNeutral =>
      'Усі улюбленці й місця з координатами. Пошук знаходить улюбленців, людей і місця — незнайому назву шукає в усьому світі. Кнопка шарів малює кола 500 м навколо місць оголошень зниклого улюбленця та навколо дому, з якого він утік. Стрілки ведуть від мітки до мітки, довге натискання на карту записує спостереження. Кожне поле з місцем — шпилька на мапі; торкніться шпильки, щоб побачити маршрут.';

  @override
  String get helpCard =>
      'Друкована картка кота: угорі чипами обираєте, що на ній буде, потім ділитеся нею як зображенням або PDF. Номери друкуються як QR чи штрихкод, а координати стають QR, що відкриває карту, плюс короткий Plus Code.';

  @override
  String get helpCardNeutral =>
      'Друкована картка улюбленця: угорі чипами обираєте, що на ній буде, потім ділитеся нею як зображенням або PDF. Номери друкуються як QR чи штрихкод, а координати стають QR, що відкриває карту, плюс короткий Plus Code.';

  @override
  String get helpSync =>
      'Як дані потрапляють до інших: з\'єднатися напряму, використати теку, яку бачать обидва пристрої, або надіслати файл через месенджер. Ви завжди вирішуєте, що надсилати — і отримані файли .catsync відкриваються теж тут. Кожен каталог підписує свої записи власним ключем; партнери бачать код ключа поруч із вашим іменем. Перший ключ партнера приймається на довірі з файлу і вважається підтвердженим після особистої синхронізації. Записи під відомим іменем без правильного підпису відхиляються й перелічуються на сторінці прибуття.';

  @override
  String get helpFields =>
      'Поля, які використовує ваш каталог. Перейменуйте їх, змініть варіанти поля вибору або створіть власні. Поле-ідентифікатор може вказувати на службу (реєстр), тоді номер у кота стає натискним.';

  @override
  String get helpFieldsNeutral =>
      'Поля, які використовує ваш каталог. Перейменуйте їх, змініть варіанти поля вибору або створіть власні. Поле-ідентифікатор може вказувати на службу (реєстр), тоді номер в улюбленця стає натискним.';

  @override
  String get helpTimeline =>
      'Усі зміни, найновіші зверху: хто, коли і на яке значення. Торкніться запису, щоб виправити, утримуйте, щоб прибрати або повернути; прихований запис лишається в журналі й показується на запит.';

  @override
  String get helpDuplicates =>
      'Коти або колонії, які виглядають як той самий запис двічі: однакові номери чи дуже схожі імена зі збіжними деталями. Торкніться пари, щоб об\'єднати; це незворотно, тому спитають заздалегідь.';

  @override
  String get helpDuplicatesNeutral =>
      'Улюбленці або домогосподарства, які виглядають як той самий запис двічі: однакові номери чи дуже схожі імена зі збіжними деталями. Торкніться пари, щоб об\'єднати; це незворотно, тому спитають заздалегідь.';

  @override
  String get helpMatches =>
      'Коти, які можуть бути однією твариною: однаковий номер або безпритульний, помічений у зоні пошуку зниклого кота. Торкніться пари, щоб об\'єднати, довге натискання відкриє першого кота для порівняння. У списку є й пари, чия зовнішність збігається щонайменше у двох ознаках без суперечностей; чипи показують у яких. «Не той самий» ховає пару на цьому телефоні, доки зовнішність одної з тварин не зміниться.';

  @override
  String get helpMatchesNeutral =>
      'Улюбленці, які можуть бути однією твариною: однаковий номер або безпритульна тварина, помічена в зоні пошуку зниклого улюбленця. Торкніться пари, щоб об\'єднати, довге натискання відкриє першого улюбленця для порівняння. У списку є й пари, чия зовнішність збігається щонайменше у двох ознаках без суперечностей; чипи показують у яких. «Не той самий» ховає пару на цьому телефоні, доки зовнішність одної з тварин не зміниться.';

  @override
  String get helpFlier =>
      'Зі сфотографованого оголошення виходить кіт разом із власником. Крок за кроком: дані кота, контакт власника, обрізання мордочки для фото профілю, номери реєстрів з оголошення і остаточна перевірка. Усе це пропозиції — виправте те, що камера прочитала хибно.';

  @override
  String get helpFlierNeutral =>
      'Зі сфотографованого оголошення виходить улюбленець разом із власником. Крок за кроком: дані улюбленця, контакт власника, обрізання мордочки для фото профілю, номери реєстрів з оголошення і остаточна перевірка. Усе це пропозиції — виправте те, що камера прочитала хибно.';

  @override
  String get archiveTitle => 'Архів';

  @override
  String get archiveExplainer =>
      'Померлі коти й порожні колонії, до яких роками ніхто не торкався, однаково займають місце — надто їхні фотографії. Архівація записує їх у файл, який ви зберігаєте, і потім видаляє їх звідси.';

  @override
  String get archiveExplainerNeutral =>
      'Померлі улюбленці й порожні домогосподарства, до яких роками ніхто не торкався, однаково займають місце — надто їхні фотографії. Архівація записує їх у файл, який ви зберігаєте, і потім видаляє їх звідси.';

  @override
  String get archiveAction => 'Архівувати';

  @override
  String archiveSelected(int count) {
    return 'Архівувати $count записів';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Архівувати $count записів?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names буде записано у файл і потім видалено — на вашому пристрої та на всіх, з якими ви синхронізуєтеся. Імпорт файлу поверне все; без нього вони втрачені.';
  }

  @override
  String archiveDone(int count) {
    return 'Архівовано та видалено записів: $count';
  }

  @override
  String archiveFailed(String error) {
    return 'Нічого не видалено: не вдалося записати файл архіву ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'База даних $db, фото $photos у $count файлах';
  }

  @override
  String quietForYears(int years) {
    return 'Без змін $years років';
  }

  @override
  String get nothingToArchive =>
      'Немає нічого достатньо старого для архівації.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Остання зміна $date · фото $size';
  }

  @override
  String get helpArchive =>
      'Старі дані займають місце, передусім фотографії, які тягне за собою кожен синхронізований пристрій. Тут ви обираєте померлих котів і порожні колонії, що роками не змінювалися, записуєте їх у файл, який зберігаєте, і видаляєте. Видалення сягає всіх, з ким ви синхронізуєтеся; імпорт файлу відновлює все.';

  @override
  String get helpArchiveNeutral =>
      'Старі дані займають місце, передусім фотографії, які тягне за собою кожен синхронізований пристрій. Тут ви обираєте померлих улюбленців і порожні домогосподарства, що роками не змінювалися, записуєте їх у файл, який зберігаєте, і видаляєте. Видалення сягає всіх, з ким ви синхронізуєтеся; імпорт файлу відновлює все.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Відновити видалені записи ($count)?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names видалені в цьому каталозі, а щойно імпортований файл їх містить. Відновлення поверне їх сюди і на всі пристрої, з якими ви синхронізуєтеся.';
  }

  @override
  String get restoreAction => 'Відновити';

  @override
  String get keepDeleted => 'Залишити видаленими';

  @override
  String get archiveNotSaved => 'Нічого не видалено: архів ніде не збережено.';

  @override
  String get locateAddress => 'Знайти адресу на карті';

  @override
  String get addressFoundTitle => 'Адресу знайдено';

  @override
  String get replaceAddressOption => 'Замінити адресу знайденою';

  @override
  String get addPositionOption => 'Зберегти місцезнаходження';

  @override
  String get addressLocated => 'Адресу знайдено';

  @override
  String get addressNotFound =>
      'Для цієї адреси нічого не знайдено. Перевірте написання або лишіть порожнім.';

  @override
  String get starterPosition => 'Місцезнаходження';

  @override
  String get valueYes => 'так';

  @override
  String get valueNo => 'ні';

  @override
  String get valueFemale => 'кішка';

  @override
  String get valueMale => 'кіт';

  @override
  String get valueUnknown => 'невідомо';

  @override
  String get cropTitle => 'Обрізати фото';

  @override
  String get markTitle => 'Позначити кота';

  @override
  String get markTitleNeutral => 'Позначити улюбленця';

  @override
  String get applyCrop => 'Обрізати';

  @override
  String get useFullPhoto => 'Використати все фото';

  @override
  String get dragToSelect => 'Проведіть прямокутник навколо кота';

  @override
  String get dragToSelectNeutral => 'Проведіть прямокутник навколо улюбленця';

  @override
  String get dragOverTheCat => 'Проведіть еліпс над котом';

  @override
  String get dragOverTheCatNeutral => 'Проведіть еліпс над улюбленцем';

  @override
  String get cropPhoto => 'Обрізати…';

  @override
  String get markPhoto => 'Позначити…';

  @override
  String get scanCode => 'Сканувати код';

  @override
  String get orTypeCode => 'Або введіть код';

  @override
  String get copyCode => 'Копіювати код';

  @override
  String get copied => 'Скопійовано';

  @override
  String get invalidCode => 'Цей код недійсний';

  @override
  String get hotspotHint =>
      'Немає спільного Wi-Fi? Увімкніть точку доступу на одному телефоні, підключіть інший і роздавайте тут.';

  @override
  String get byMessenger => 'Через месенджер';

  @override
  String get byMessengerExplainer =>
      'Надішліть увесь каталог одним файлом через WhatsApp, Signal чи пошту — інша сторона його імпортує.';

  @override
  String get shareBundle => 'Поділитися пакетом синхронізації…';

  @override
  String get importBundle => 'Імпортувати пакет синхронізації…';

  @override
  String bundleImported(String result) {
    return 'Пакет імпортовано: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Останнє автоматичне резервне копіювання не вдалося: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Помилка імпорту: $error';
  }

  @override
  String get pickOnMap => 'Обрати на мапі';

  @override
  String get useMyLocation => 'Використати моє місцезнаходження';

  @override
  String get language => 'Мова';

  @override
  String get typeUnitValue => 'Значення з одиницею';

  @override
  String get dimension => 'Величина';

  @override
  String get dimensionWeight => 'Вага';

  @override
  String get dimensionLength => 'Довжина';

  @override
  String get dimensionVolume => 'Обʼєм';

  @override
  String get dimensionTemperature => 'Температура';

  @override
  String get unitsLabel => 'Одиниці';

  @override
  String get catalogHolds => 'У цьому каталозі';

  @override
  String get modeCats => 'Коти';

  @override
  String get modePets => 'Улюбленці';

  @override
  String get graphLabel => 'Графік';

  @override
  String get fieldHistoryTooltip => 'Історія';

  @override
  String get rangeWeek => 'Тиждень';

  @override
  String get rangeMonth => 'Місяць';

  @override
  String get rangeYear => 'Рік';

  @override
  String get rangeAll => 'Усе';

  @override
  String get rangeCustom => 'Власний…';

  @override
  String changeSince(String delta, String date) {
    return '$delta з $date';
  }

  @override
  String get unitsAuto => 'Як у вашому регіоні';

  @override
  String get unitsMetric => 'Метричні (кг, см, мл, °C)';

  @override
  String get unitsImperial => 'Імперські (фунт, дюйм, fl oz, °F)';

  @override
  String get starterWeight => 'Вага';

  @override
  String get starterLooks => 'Зовнішність';

  @override
  String get looksGroupSize => 'Розмір';

  @override
  String get looksGroupColours => 'Кольори';

  @override
  String get looksGroupPattern => 'Малюнок';

  @override
  String get looksGroupFur => 'Шерсть';

  @override
  String get looksGroupTail => 'Хвіст';

  @override
  String get looksGroupEars => 'Вуха';

  @override
  String get looksGroupMarks => 'Прикмети';

  @override
  String get looksGroupCrest => 'Чубчик';

  @override
  String get looksGroupBeak => 'Дзьоб';

  @override
  String get looksGroupRing => 'Кільце';

  @override
  String get looksValueSmall => 'Малий';

  @override
  String get looksValueMedium => 'Середній';

  @override
  String get looksValueLarge => 'Великий';

  @override
  String get looksValueBlack => 'Чорний';

  @override
  String get looksValueWhite => 'Білий';

  @override
  String get looksValueGrey => 'Сірий';

  @override
  String get looksValueBrown => 'Коричневий';

  @override
  String get looksValueGinger => 'Рудий';

  @override
  String get looksValueCream => 'Кремовий';

  @override
  String get looksValueGolden => 'Золотистий';

  @override
  String get looksValueTan => 'Палевий';

  @override
  String get looksValueGreen => 'Зелений';

  @override
  String get looksValueBlue => 'Синій';

  @override
  String get looksValueYellow => 'Жовтий';

  @override
  String get looksValueRed => 'Червоний';

  @override
  String get looksValueOrange => 'Помаранчевий';

  @override
  String get looksValuePink => 'Рожевий';

  @override
  String get looksValueWhiteBib => 'Біла манишка';

  @override
  String get looksValueWhitePaws => 'Білі лапи';

  @override
  String get looksValueWhiteTailTip => 'Білий кінчик хвоста';

  @override
  String get looksValueBlaze => 'Проточина';

  @override
  String get looksValueMask => 'Маска';

  @override
  String get looksValueSpots => 'Цятки';

  @override
  String get looksValuePatches => 'Плями';

  @override
  String get looksValueStripes => 'Смуги';

  @override
  String get looksValueScar => 'Шрам';

  @override
  String get looksValueNotchedEar => 'Надріз на вусі';

  @override
  String get looksValueEarTip => 'Кінчик вуха';

  @override
  String get looksValueCollar => 'Нашийник';

  @override
  String get looksValueShort => 'Коротка';

  @override
  String get looksValueLong => 'Довга';

  @override
  String get looksValueHairless => 'Без шерсті';

  @override
  String get looksValueBobtail => 'Короткий хвіст';

  @override
  String get looksValueNone => 'Немає';

  @override
  String get looksValueCurled => 'Закручений';

  @override
  String get looksValueUpright => 'Стоячі';

  @override
  String get looksValueFloppy => 'Висячі';

  @override
  String get looksValueFolded => 'Складені';

  @override
  String get looksValueRounded => 'Округлі';

  @override
  String get looksValueSolid => 'Однотонний';

  @override
  String get looksValueTabby => 'Табі';

  @override
  String get looksValueTortoiseshell => 'Черепаховий';

  @override
  String get looksValueCalico => 'Каліко';

  @override
  String get looksValueColourpoint => 'Колорпойнт';

  @override
  String get looksValueBicolour => 'Двоколірний';

  @override
  String get looksValueTuxedo => 'Смокінг';

  @override
  String get looksValueBrindle => 'Тигровий';

  @override
  String get looksValueMerle => 'Мерль';

  @override
  String get looksValueSpotted => 'Плямистий';

  @override
  String get looksValuePatched => 'Рябий';

  @override
  String get looksValueTricolour => 'Триколірний';

  @override
  String get looksValueSable => 'Соболиний';

  @override
  String get looksGroupEyes => 'Очі';

  @override
  String get looksGroupFeatures => 'Особливості';

  @override
  String get looksValueAmber => 'Бурштинові';

  @override
  String get looksValueCopper => 'Мідні';

  @override
  String get looksValueOddEyed => 'Різнокольорові';

  @override
  String get looksValueChocolate => 'Шоколадний';

  @override
  String get looksValueLilac => 'Ліловий';

  @override
  String get looksValueSilver => 'Сріблястий';

  @override
  String get looksValueSmoke => 'Димчастий';

  @override
  String get looksValueTicked => 'Тикований';

  @override
  String get looksValueVan => 'Ван';

  @override
  String get looksValueCurly => 'Кучерява';

  @override
  String get looksValueWiry => 'Жорстка';

  @override
  String get looksValueKinked => 'Із зламом';

  @override
  String get looksValueCropped => 'Купіровані';

  @override
  String get looksValueTippedEar => 'Підрізане вухо';

  @override
  String get looksValueEarTattoo => 'Татуювання у вусі';

  @override
  String get looksValueMissingEar => 'Немає вуха';

  @override
  String get looksValueMissingEye => 'Немає ока';

  @override
  String get looksValueCloudyEye => 'Мутне око';

  @override
  String get looksValueMissingFrontLeg => 'Немає передньої лапи';

  @override
  String get looksValueMissingHindLeg => 'Немає задньої лапи';

  @override
  String get looksValueNoTeeth => 'Немає зубів';

  @override
  String get looksValueExtraToes => 'Зайві пальці';

  @override
  String get rejectMatch => 'Не той самий';

  @override
  String traitsAgree(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ознаки збігаються',
      many: '$count ознак збігаються',
      few: '$count ознаки збігаються',
      one: '$count ознака збігається',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Системна за замовчуванням';

  @override
  String get iosLocalNetworkHint =>
      'Якщо на iPhone/iPad далі не вдається: Параметри → Конфіденційність і безпека → Локальна мережа → дозвольте cat(a)log і спробуйте ще раз.';

  @override
  String get includePrivate => 'Поділитися приватними даними';

  @override
  String get hideLabel => 'Сховати на цьому пристрої';

  @override
  String get unhideLabel => 'Показати знову';

  @override
  String get showHiddenLabel => 'Показати приховані';

  @override
  String get stopShowingHidden => 'Не показувати приховані';

  @override
  String get starterSpecies => 'Вид';

  @override
  String get starterStatus => 'Тип';

  @override
  String get statusFoster => 'Тимчасовий дім';

  @override
  String get statusForeverHome => 'Дім';

  @override
  String get statusClinic => 'Клініка';

  @override
  String get statusShelter => 'Притулок';

  @override
  String get statusBarn => 'Стодола';

  @override
  String get valueCat => 'Кіт';

  @override
  String get valueDog => 'Собака';

  @override
  String get valueRabbit => 'Кріль';

  @override
  String get valueGuineaPig => 'Морська свинка';

  @override
  String get valueHamster => 'Хом\'як';

  @override
  String get valueBird => 'Птах';

  @override
  String get valueHorse => 'Кінь';

  @override
  String get valueTortoise => 'Черепаха';

  @override
  String get valueFerret => 'Тхір';

  @override
  String get otherOption => 'Інше…';

  @override
  String get celebrationsToggle => 'Святкувати прилаштування';

  @override
  String get celebrationsSubtitle =>
      'Конфеті та радість, коли кіт переїжджає у свій дім';

  @override
  String get cheerToggle => 'Звук вітання';

  @override
  String get cheerSubtitle => 'Коротке вітання до конфеті, щоразу інше';

  @override
  String get celebrationsSubtitleNeutral =>
      'Конфеті та радість, коли улюбленець переїжджає у свій дім';

  @override
  String get onMapLabel => 'На карті';

  @override
  String get showOnMap => 'Показати на карті';

  @override
  String get searchPlaceHint => 'Шукати місце чи адресу';

  @override
  String get noPlacesFound => 'Місць не знайдено';

  @override
  String get mapSearchHint => 'Шукати котів, групи, людей';

  @override
  String get mapSearchHintNeutral =>
      'Шукати улюбленців, домогосподарства, людей';

  @override
  String get proposeAnotherName => 'Запропонувати інше ім\'я';

  @override
  String get moderationTitle => 'Автори та заборони';

  @override
  String get moderationSubtitle => 'Назавжди видалити дані людини';

  @override
  String get authorsSection => 'Хто писав у цей каталог';

  @override
  String get hardDeleteAction => 'Видалити все від цього автора';

  @override
  String hardDeleteWarning(Object name) {
    return 'Видаляє кожен запис і фото від $name з цього пристрою. Інші пристрої зберігають свої. Неможливо скасувати.';
  }

  @override
  String get yourKey => 'Ваш ключ';

  @override
  String get yourTitle => 'Ваш титул';

  @override
  String get titleNone => 'Без титулу';

  @override
  String keyLine(Object code) {
    return 'ключ $code';
  }

  @override
  String get keyVerified => 'підтверджено особисто';

  @override
  String get keyFromFile => 'з файлу, ще не підтверджено';

  @override
  String get keyUnsigned => 'ключа ще немає, записи без підпису';

  @override
  String get summaryRefused => 'Відхилено';

  @override
  String refusedEntries(int count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count запису відхилено',
      many: '$count записів відхилено',
      few: '$count записи відхилено',
      one: '$count запис відхилено',
    );
    return '$_temp0: не підписані ключем, відомим для $name';
  }

  @override
  String newKeyCallsItself(Object code, Object name) {
    return 'Новий ключ $code називає себе $name. Уточніть у людини, перш ніж довіряти.';
  }

  @override
  String keyChangedRefused(Object name) {
    return '$name запропонував ключ, відмінний від відомого тут. Відомий залишається, новий не прийнято.';
  }

  @override
  String metaNewKey(Object name, Object code, Object how) {
    return 'Новий ключ: $name · $code ($how)';
  }

  @override
  String hardDeleteWarningKey(Object name, Object key) {
    return 'Видаляє з цього каталогу всі записи й фото, написані $name під ключем $key. Інші пристрої зберігають свої. Скасувати неможливо.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Введіть $name для підтвердження';
  }

  @override
  String get alsoBan => 'Також заборонити — більше ніколи не приймати дані';

  @override
  String get bansSection => 'Заборони';

  @override
  String get unbanAction => 'Зняти заборону';

  @override
  String get deletedDone => 'Видалено.';

  @override
  String get syncSummaryTitle => 'Що надійшло';

  @override
  String get summaryAdopted => 'Прилаштовані';

  @override
  String get summaryDeceased => 'Померли';

  @override
  String get summaryEscaped => 'Втекли';

  @override
  String get summaryNew => 'Нові';

  @override
  String get summaryConflicts => 'Конфлікти для вирішення';

  @override
  String conflictsMenu(int n) {
    return 'Конфлікти ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Ви розв’язали тут конфлікт, тому «Відхилити» недоступне: це скасувало б і його.';

  @override
  String get arrivalIntro =>
      'Ці зміни вже у вашому каталозі. «Відхилити» повертає його до попереднього стану.';

  @override
  String get summaryUpdated => 'Змінені';

  @override
  String get summaryDeleted => 'Видалені';

  @override
  String get keepMine => 'Залишити моє';

  @override
  String keptMine(String name) {
    return 'Вашу версію «$name» збережено на цьому пристрої.';
  }

  @override
  String get summaryMeta => 'Також надійшло';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n змін',
      few: '$n зміни',
      one: '$n зміна',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Прийняти';

  @override
  String get rejectArrival => 'Відхилити';

  @override
  String get photoAdded => 'Додано світлину';

  @override
  String get photoNotReceived => 'Світлину ще не отримано';

  @override
  String get photoRemoved => 'Світлину вилучено';

  @override
  String metaFieldAdded(String name) {
    return 'Нове поле: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Поле змінено: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser об’єднано з $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n світлин',
      few: '$n світлини',
      one: '$n світлина',
    );
    return '$_temp0';
  }

  @override
  String get starterMother => 'Мати';

  @override
  String get starterFather => 'Батько';

  @override
  String get familySection => 'Сім\'я';

  @override
  String get littermatesLabel => 'З одного приплоду';

  @override
  String get siblingsLabel => 'Брати й сестри';

  @override
  String get kittensLabel => 'Кошенята';

  @override
  String get kittensLabelNeutral => 'Малюки';

  @override
  String get toastSettingsTitle => 'Про що повідомляти';

  @override
  String get toastSettingsSubtitle =>
      'Короткі повідомлення після синхронізації';

  @override
  String get toastKindAdoptions => 'Прилаштування';

  @override
  String get toastKindBirths => 'Народження';

  @override
  String get toastKindDeaths => 'Смерті';

  @override
  String get toastKindEscapes => 'Втечі';

  @override
  String get toastKindMoves => 'Переїзди';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat прилаштовано в $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Нове кошеня: $cat ✨';
  }

  @override
  String toastBornNeutral(Object cat) {
    return '✨ Новонароджений: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat помер';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat втік';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat переїхав до $home';
  }

  @override
  String get notACatlogFile => 'Це не файл cat(a)log';

  @override
  String get nothingNewInBundle => 'Нічого нового у файлі — у вас уже все є';

  @override
  String get syncChooserInPerson => 'Особисто';

  @override
  String get syncChooserInPersonSub => 'Синхронізація через Wi-Fi';

  @override
  String get syncChooserRemote => 'Віддалено';

  @override
  String get syncChooserRemoteSub => 'Синхронізація через теку або USB-флешку';

  @override
  String get syncChooserMessenger => 'Месенджер';

  @override
  String get syncChooserMessengerSub => 'Експорт та імпорт через соцмережі';

  @override
  String get connectToWifiFirst =>
      'Спершу підключіться до Wi-Fi — тоді пристрої знайдуть одне одного';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) хоче синхронізуватися';
  }

  @override
  String get trustBothWaysNote => 'Каталоги буде обміняно в обох напрямках.';

  @override
  String get allowOnce => 'Дозволити';

  @override
  String get allowAlways => 'Завжди дозволяти цьому пристрою';

  @override
  String get declineAction => 'Відхилити';

  @override
  String get syncDeclined => 'Інший пристрій відхилив синхронізацію';

  @override
  String get trustedDevicesSection => 'Завжди дозволені пристрої';

  @override
  String get removeTrust => 'Прибрати';

  @override
  String get hostWithoutWifi => 'Хостити без Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Створює тимчасове пряме з\'єднання з іншим телефоном (без інтернету). Ним користується лише cat(a)log, після синхронізації воно роз\'єднується саме.';

  @override
  String get hotspotAndroidOnly =>
      'Цей код потребує два Android-телефони — на iPhone/iPad користуйтеся спільним Wi-Fi';

  @override
  String get selectClowderHint => 'Виберіть клаудер ліворуч';

  @override
  String get selectClowderHintNeutral => 'Виберіть домогосподарство ліворуч';

  @override
  String get introTitle1 => 'Ваші коти під контролем';

  @override
  String get introTitle1Neutral => 'Ваші улюбленці під контролем';

  @override
  String get introBody1 =>
      'Заведіть картку на кожного кота: фото, стать, здоров\'я — усе, що хочете занотувати. Коти згруповані за місцем, де живуть, — застосунок називає його колонією (clowder).';

  @override
  String get introBody1Neutral =>
      'Заведіть картку на кожного улюбленця, про якого дбаєте: фото, стать, здоров\'я — усе, що хочете занотувати. Улюбленці згруповані за місцем, де живуть, — застосунок називає його домогосподарством.';

  @override
  String get introTitle2 => 'Працює без інтернету';

  @override
  String get introBody2 =>
      'Усе зберігається лише на вашому телефоні. Без облікового запису та хмари. Нічого не надсилається, доки ви самі не поділитеся.';

  @override
  String get introTitle3 => 'Працюйте разом';

  @override
  String get introBody3 =>
      'Кожен користується своїм застосунком, і час від часу ви обмінюєтеся даними: зустріньтеся й відскануйте код, використайте спільну теку або надішліть один файл у месенджері. Після цього всі мають однакові дані.';

  @override
  String get introSkip => 'Пропустити';

  @override
  String get introNext => 'Далі';

  @override
  String get introDone => 'Почнімо';

  @override
  String get introReplayTitle => 'Швидке знайомство';

  @override
  String get spotHomeSync =>
      'Тут ви синхронізуєтеся зі знайомими. Що надсилати — вирішуєте ви.';

  @override
  String get spotHomeStrays =>
      'Ця картка збирає всіх безпритульних котів. Торкніться, щоб побачити список.';

  @override
  String get spotHomeStraysNeutral =>
      'Ця картка збирає всіх безпритульних — улюбленців без дому. Торкніться, щоб побачити список.';

  @override
  String get spotHomeMenu =>
      'У цьому меню: налаштування, пошук і об’єднання дублікатів, експорт CSV та інше.';

  @override
  String get spotCatEdit =>
      'Торкніться олівця, щоб редагувати кота. Порада: довге натискання на поле редагує його одразу.';

  @override
  String get spotCatEditNeutral =>
      'Торкніться олівця, щоб редагувати улюбленця. Порада: довге натискання на поле редагує його одразу.';

  @override
  String get spotMapLayers =>
      'Шукаєте зниклого кота? Покажіть кола навколо місць його оголошень і навколо дому, з якого він утік.';

  @override
  String get spotMapLayersNeutral =>
      'Шукаєте зниклого улюбленця? Покажіть кола навколо місць його оголошень і навколо дому, з якого він утік.';

  @override
  String get spotStraysFlier =>
      'Знайшли оголошення про зниклого кота? Сфотографуйте його тут — застосунок збереже кота й контакт за вас.';

  @override
  String get spotStraysFlierNeutral =>
      'Знайшли оголошення про зниклого улюбленця? Сфотографуйте його тут — застосунок збереже улюбленця й контакт за вас.';

  @override
  String get spotStraysScan =>
      'На деяких оголошеннях є QR-код cat(a)log. Відскануйте його тут і імпортуйте кота без набору.';

  @override
  String get spotStraysScanNeutral =>
      'На деяких оголошеннях є QR-код cat(a)log. Відскануйте його тут і імпортуйте улюбленця без набору.';

  @override
  String get introTitle4 => 'Шукайте зниклих котів';

  @override
  String get introTitle4Neutral => 'Шукайте зниклих улюбленців';

  @override
  String get introBody4 =>
      'Побачили оголошення про зниклого кота? Сфотографуйте його в застосунку: він збереже кота, контакт власника й місце. Якщо згодом з\'явиться схожий безпритульний кіт, застосунок запропонує можливі збіги.';

  @override
  String get introBody4Neutral =>
      'Побачили оголошення про зниклого улюбленця? Сфотографуйте його в застосунку: він збереже улюбленця, контакт власника й місце. Якщо згодом з\'явиться схожа безпритульна тварина, застосунок запропонує можливі збіги.';

  @override
  String get spotMapSearch =>
      'Введіть кота, місце чи людину, щоб перейти туди на карті.';

  @override
  String get spotMapSearchNeutral =>
      'Введіть улюбленця, місце чи людину, щоб перейти туди на карті.';

  @override
  String get spotCardChips =>
      'Позначте, що має бути на картці для поширення — решта на неї не потрапить.';

  @override
  String get spotCatMenu =>
      'Тут ще дії: сховати кішку, об\'єднати дублікати або записати спостереження.';

  @override
  String get spotCatMenuNeutral =>
      'Тут ще дії: сховати улюбленця, об\'єднати дублікати або записати спостереження.';

  @override
  String get spotDone => 'Зрозуміло';

  @override
  String get spotReplayTitle => 'Тур новинками';

  @override
  String get spotReplaySubtitle => 'Показати підказки знову на кожній сторінці';

  @override
  String get spotReplayDone => 'Підказки з\'являться знову';

  @override
  String get searchNoResults => 'Кота з таким ім\'ям не знайдено';

  @override
  String get searchNoResultsNeutral => 'Улюбленця з таким ім\'ям не знайдено';

  @override
  String get syncUnreachable =>
      'Не вдалося зв\'язатися з іншим пристроєм. Чи обидва в одній мережі Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Не вдалося відкрити папку. Чи диск або хмарна папка ще існує?';

  @override
  String get crashTitle => 'Цього не мало статися';

  @override
  String get crashBody =>
      'cat(a)log натрапив на неочікувану помилку. Ваші дані в безпеці — усе зберігається в момент зміни. Перезапустіть застосунок, а якщо повториться — надішліть звіт, щоб це виправити.';

  @override
  String get crashRestart => 'Перезапустити застосунок';

  @override
  String get crashSendReport => 'Надіслати звіт розробнику';

  @override
  String get crashLastRunBody =>
      'Минулого разу cat(a)log неочікувано зупинився — найімовірніше, забракло пам\'яті. Надіслати короткий звіт, щоб виправити?';

  @override
  String get catalogsTitle => 'Каталоги';

  @override
  String get newCatalog => 'Новий каталог';

  @override
  String get intoCatalog => 'У каталог';

  @override
  String get catalogNameLabel => 'Назва каталогу';

  @override
  String catalogNameTaken(String name) {
    return 'Каталог з назвою $name вже є. Виберіть іншу назву.';
  }

  @override
  String get manageCatalogs => 'Керування каталогами';

  @override
  String get restoreTitle => 'Відновити резервні копії';

  @override
  String get restoreIntro =>
      'На цьому пристрої є резервні копії попередньої установки. Кожна знову стане каталогом.';

  @override
  String get restoreNone =>
      'На цьому пристрої резервних копій немає. Виберіть файли, щоб відновити з іншого місця.';

  @override
  String get restoreBackupsMenu => 'Відновити резервні копії…';

  @override
  String get restorePickFiles => 'Вибрати файли…';

  @override
  String restoreFileLine(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файлів',
      few: '$count файли',
      one: '$count файл',
    );
    return '$_temp0, найновіший $date';
  }

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Відновлено $count каталогів.',
      few: 'Відновлено $count каталоги.',
      one: 'Відновлено $count каталог.',
      zero: 'Нічого не відновлено.',
    );
    return '$_temp0';
  }

  @override
  String get helpCatalogs =>
      'Кожен каталог — окремий світ: свої коти, колонії, поля, фотографії та партнери синхронізації. Берлін і Париж ніколи не змішуються. Торкніться каталогу, щоб перейти до нього. Шестірня біля каталогу відкриває його налаштування: назва, коти чи тварини, поля, автори та блокування, архів, повернення назад, видалення. Ваше ім’я, мова та вже показані підказки спільні для всіх.';

  @override
  String get helpCatalogsNeutral =>
      'Кожен каталог — окремий світ: свої тварини, домогосподарства, поля, фотографії та партнери синхронізації. Берлін і Париж ніколи не змішуються. Торкніться каталогу, щоб перейти до нього. Шестірня біля каталогу відкриває його налаштування: назва, коти чи тварини, поля, автори та блокування, архів, повернення назад, видалення. Ваше ім’я, мова та вже показані підказки спільні для всіх.';

  @override
  String get helpCatalogSettings =>
      'Усе, що належить лише цьому каталогу: назва, коти в ньому чи тварини, поля, автори та блокування, архів і повернення назад у часі. Зміни тут стосуються лише цього каталогу — і того, в якому ви зараз не перебуваєте. Видалення спершу записує каталог у файл. Ваш ключ — код, який партнери бачать поруч із вашим іменем; він належить цьому каталогу.';

  @override
  String get spotHomeCatalog =>
      'Це каталог, у якому ви зараз. Торкніться назви, щоб перемкнути або створити новий.';

  @override
  String get deleteCatalog => 'Видалити каталог';

  @override
  String get catalogSettings => 'Налаштування каталогу';

  @override
  String deleteCatalogBody(String name) {
    return 'Усе в каталозі $name зникне: коти, світлини, історія. Спершу повний файл зберігається там, куди йдуть автоматичні резервні копії, — його імпорт поверне каталог.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Усе в каталозі $name зникне: улюбленці, світлини, історія. Спершу повний файл зберігається там, куди йдуть автоматичні резервні копії, — його імпорт поверне каталог. Введіть назву для підтвердження.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name видалено. Файл у $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Введіть $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Нічого не видалено: файл каталогу не вдалося записати ($error). Звільніть місце або спробуйте пізніше.';
  }

  @override
  String get moveToCatalog => 'Перемістити до іншого каталогу';

  @override
  String movedToCatalog(int count, String name) {
    return '$count переміщено до $name';
  }

  @override
  String get chooseWhatToMove => 'Що перемістити?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Перемістити щось до $name?';
  }

  @override
  String get undoThisImport => 'Скасувати цей імпорт';

  @override
  String undoImportBody(int count) {
    return '$count змін із цього імпорту буде вилучено. Спершу вони записуються у файл, імпорт якого поверне їх. Ті, з ким ви вже синхронізувалися, збережуть свою копію — це не відкликати.';
  }

  @override
  String undoneImport(String where) {
    return 'Скасовано. Файл у $where.';
  }

  @override
  String get goBackTitle => 'Повернутися назад';

  @override
  String get goBackToHere => 'Повернутися сюди';

  @override
  String get momentImport => 'Перед імпортом';

  @override
  String get momentSync => 'Перед синхронізацією';

  @override
  String get momentMerge => 'Перед об’єднанням';

  @override
  String get momentHardDelete => 'Перед видаленням даних одного автора';

  @override
  String get momentArchive => 'Перед архівуванням';

  @override
  String get momentManual => 'Позначено вами';

  @override
  String get showOlderMoments => 'Показати давніші';

  @override
  String goBackBody(int count) {
    return 'Усе після цієї миті буде вилучено — $count змін. Спершу все записується у файл, імпорт якого поверне це назад, і кожна пізніша мить зникне разом. Ті, з ким ви вже синхронізувалися, збережуть копію — це не відкликати.';
  }

  @override
  String get nameThisMoment => 'Назвіть цю мить';

  @override
  String get helpGoBack =>
      'Миті, коли цей каталог сильно змінювався: перед кожним імпортом і кожною синхронізацією, перед об’єднанням, архівуванням чи видаленням — і щоразу, коли ви позначили мить самі. Вибір однієї повертає каталог у той стан: усе після неї записується у файл, який ви залишаєте собі, а потім вилучається, і кожна пізніша мить зникає разом. Ті, з ким ви вже синхронізувалися, зберігають отримане.';

  @override
  String goBackFileFailed(String error) {
    return 'Нічого не вилучено: файл, який це зберігає, не вдалося записати ($error). Звільніть місце і спробуйте ще раз.';
  }

  @override
  String get goBackChanged =>
      'Нічого не видалено: каталог змінився, поки файл зберігався. Спробуйте ще раз.';

  @override
  String get switchBeforeDeleting =>
      'Це каталог, у якому ви зараз. Перемкніться на інший, потім видаліть його.';

  @override
  String shareFileFailed(String error) {
    return 'Файл для надсилання не вдалося записати ($error). Звільніть місце і спробуйте ще раз.';
  }

  @override
  String get privateLabel => 'Приватно';

  @override
  String sharedCatalogIs(String name) {
    return 'Каталог: $name';
  }

  @override
  String get markPrivate => 'Позначити як особисте';

  @override
  String get unmarkPrivate => 'Зняти особисту позначку';

  @override
  String get agenda => 'Нагадування';

  @override
  String get reminderLabel => 'Нагадування';

  @override
  String get agendaEmpty =>
      'Візитів не заплановано. Нові плануйте тут плюсом або на сторінці кота чи клаудера.';

  @override
  String get agendaEmptyNeutral =>
      'Візитів не заплановано. Нові плануйте тут плюсом або на сторінці улюбленця чи домогосподарства.';

  @override
  String get dueToday => 'сьогодні';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'через $count дня',
      many: 'через $count днів',
      few: 'через $count дні',
      one: 'через $count день',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'прострочено на $count дня',
      many: 'прострочено на $count днів',
      few: 'прострочено на $count дні',
      one: 'прострочено на $count день',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Готово';

  @override
  String get repeatTitle => 'Знову через…';

  @override
  String get noRepeatLabel => 'Без повтору';

  @override
  String get unitDays => 'днів';

  @override
  String get unitWeeks => 'тижнів';

  @override
  String get unitMonths => 'місяців';

  @override
  String get unitYears => 'років';

  @override
  String ageYears(int years) {
    return '$years р.';
  }

  @override
  String ageMonths(int months) {
    return '$months міс.';
  }

  @override
  String get changeDateLabel => 'Змінити дату';

  @override
  String get removeReminderLabel => 'Прибрати нагадування';

  @override
  String get exportIcs => 'Експортувати файл календаря';

  @override
  String get resyncCalendar => 'Пересинхронізувати календар';

  @override
  String icsSavedTo(String path) {
    return 'Файл календаря збережено в $path';
  }

  @override
  String get calendarMirrorLabel => 'Віддзеркалювати в календар пристрою';

  @override
  String get calendarMirrorSubtitle =>
      'Візити з\'являються в календарі як події на весь день. cat(a)log оновлює їх там під час кожного запуску й після кожної зміни. Сповіщення про візити налаштовуйте в календарі.';

  @override
  String get syncPeerOlder =>
      'На іншому пристрої старіший cat(a)log без нагадувань. Оновіть cat(a)log там і синхронізуйте знову.';

  @override
  String get syncPeerNewer =>
      'На іншому пристрої новіший cat(a)log. Оновіть cat(a)log на цьому пристрої й синхронізуйте знову.';

  @override
  String get syncPeerNoTls =>
      'На іншому пристрої cat(a)log старіший за 1.1.0, без шифрованої синхронізації. Оновіть cat(a)log там і синхронізуйте знову.';

  @override
  String get syncWrongHost =>
      'Сертифікат не відповідає коду сполучення — це не той пристрій, з якого прийшов код. Відскануйте або введіть код ще раз.';

  @override
  String get bundleNewerError =>
      'Цей файл із новішого cat(a)log. Оновіть cat(a)log на цьому пристрої, щоб імпортувати його.';

  @override
  String get spotEar =>
      'Маленьке котяче вухо в куті означає: утримуйте, щоб побачити більше.';

  @override
  String get addReminder => 'Додати нагадування';

  @override
  String get plannedSection => 'Заплановано';

  @override
  String get reminderDialogHint =>
      'Візит показується в нагадуваннях. Там його можна підтвердити або відхилити. Значення переймається, лише якщо візит підтверджено.';

  @override
  String get reminderFor => 'Для';

  @override
  String get reminderField => 'Поле';

  @override
  String get dueDateLabel => 'Термін';

  @override
  String get pickCalendar => 'Який календар?';

  @override
  String get calendarPermissionDenied =>
      'Доступ до календаря заблоковано, тому віддзеркалення вимкнено. Дозвольте його в налаштуваннях системи й увімкніть віддзеркалення знову.';

  @override
  String get calendarNotChosen =>
      'Календар не вибрано, тому віддзеркалення вимкнено. Увімкніть його знову й виберіть календар.';

  @override
  String get calendarGone =>
      'Вибраного календаря більше немає, тому віддзеркалення вимкнено. Увімкніть його знову й виберіть інший.';

  @override
  String get noWritableCalendar =>
      'Календар не знайдено. Увійдіть у налаштуваннях системи в обліковий запис календаря, наприклад Google, і спробуйте знову.';

  @override
  String get spotHomeAgenda =>
      'Нагадування: список запланованих візитів — ветеринар, ліки, огляди.';

  @override
  String get spotAgendaAdd => 'Запланувати новий візит.';

  @override
  String get spotAgendaCalendar =>
      'Увімкніть тут віддзеркалення візитів cat(a)log у вибраний календар.';

  @override
  String get spotAgendaToday =>
      'Справи на сьогодні: позначте, коли зроблено. Точки показують останні сім днів.';

  @override
  String get helpAgenda =>
      'Нагадування показують заплановані візити за датою. Є два види: візити із зазначенням часу і нагадування на день. Пропущені лишаються вгорі. Дотик відкриває кота чи клаудер. Галочка підтверджує візит: значення записується в поле, і можна одразу запланувати наступний, наприклад через три місяці. Утримання змінює дату або видаляє візит. Перемикач угорі віддзеркалює візити в календар телефона. Меню експортує їх файлом календаря. Поїздка до ветеринара з кількома котами — один прийом: позначте котів, Порядок денний покаже одну картку з їхніми іменами, а при завершенні запитає, яких котів лікували — зніміть позначку з решти, вони залишаються в плані. Справи — це повторювані обов’язки: годування, лоток, ліки. Вони стоять під «Сьогодні» з галочкою, серією та останніми сімома днями точками; «Незабаром» показує наступний тиждень без щоденних. Справа може нагадати сповіщенням у вибраний час. Кубок відкриває досягнення.';

  @override
  String get helpAgendaNeutral =>
      'Нагадування показують заплановані візити за датою. Є два види: візити із зазначенням часу і нагадування на день. Пропущені лишаються вгорі. Дотик відкриває улюбленця чи домогосподарство. Галочка підтверджує візит: значення записується в поле, і можна одразу запланувати наступний, наприклад через три місяці. Утримання змінює дату або видаляє візит. Перемикач угорі віддзеркалює візити в календар телефона. Меню експортує їх файлом календаря. Поїздка до ветеринара з кількома улюбленцями — один прийом: позначте улюбленців, Порядок денний покаже одну картку з їхніми іменами, а при завершенні запитає, яких улюбленців лікували — зніміть позначку з решти, вони залишаються в плані. Справи — це повторювані обов’язки: годування, лоток, ліки. Вони стоять під «Сьогодні» з галочкою, серією та останніми сімома днями точками; «Незабаром» показує наступний тиждень без щоденних. Справа може нагадати сповіщенням у вибраний час. Кубок відкриває досягнення.';

  @override
  String get calendarRowOff => 'Календар: вимк.';

  @override
  String calendarRowOn(String name) {
    return 'Календар: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Запланувати візит для цього кота. Він показується в нагадуваннях і підтверджується там.';

  @override
  String get spotAddReminderCatNeutral =>
      'Запланувати візит для цього улюбленця. Він показується в нагадуваннях і підтверджується там.';

  @override
  String get spotAddReminderClowder =>
      'Запланувати візит для цього клаудера. Він показується в нагадуваннях і підтверджується там.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Запланувати візит для цього домогосподарства. Він показується в нагадуваннях і підтверджується там.';

  @override
  String get readOnlyCalendar => 'лише читання';

  @override
  String get appointmentLabel => 'Візит';

  @override
  String get addAppointment => 'Додати візит';

  @override
  String get planChooserTitle => 'Візит чи нагадування?';

  @override
  String get planChooserAppointment =>
      'Візит — відвідування в день і час, із нотатками';

  @override
  String get planChooserReminder =>
      'Нагадування — значення, що настає певного дня';

  @override
  String get planChooserChore =>
      'Справа — те, що повторюється: годування, краплі, лоток';

  @override
  String get newChore => 'Нова справа';

  @override
  String get choreEdit => 'Змінити справу';

  @override
  String get choreTitleLabel => 'Що';

  @override
  String get choreRepeatDaily => 'Щодня';

  @override
  String get choreRepeatEvery => 'Кожні…';

  @override
  String get choreRepeatWeekdays => 'Дні тижня';

  @override
  String choreEveryDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'кожні $n днів',
      few: 'кожні $n дні',
      one: 'щодня',
    );
    return '$_temp0';
  }

  @override
  String choreEveryWeeks(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'кожні $n тижнів',
      few: 'кожні $n тижні',
      one: 'щотижня',
    );
    return '$_temp0';
  }

  @override
  String choreEveryMonths(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'кожні $n місяців',
      few: 'кожні $n місяці',
      one: 'щомісяця',
    );
    return '$_temp0';
  }

  @override
  String choreEveryYears(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'кожні $n років',
      few: 'кожні $n роки',
      one: 'щороку',
    );
    return '$_temp0';
  }

  @override
  String get choreNoTime => 'Будь-коли протягом дня';

  @override
  String get chorePause => 'Призупинити';

  @override
  String get chorePaused => 'Призупинено';

  @override
  String get choreResume => 'Відновити';

  @override
  String get choreEnd => 'Завершити справу';

  @override
  String get choreHistory => 'Історія';

  @override
  String choreDoneAt(Object when, Object who) {
    return 'зроблено $when · $who';
  }

  @override
  String get choreDoneEarly => 'раніше';

  @override
  String get choreDoneLate => 'пізніше';

  @override
  String get choreMissed => 'Пропущено';

  @override
  String get choreStillOpen => 'Ще не зроблено';

  @override
  String get choreEndConfirm =>
      'Справа зникає зі списку. Позначене залишається в історії.';

  @override
  String get todaySection => 'Сьогодні';

  @override
  String get upcomingSection => 'Незабаром';

  @override
  String get allDoneToday => 'Сьогодні: усе зроблено';

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n днів поспіль',
      few: '$n дні поспіль',
      one: '$n день поспіль',
    );
    return '$_temp0';
  }

  @override
  String choreDue(String date) {
    return 'Термін $date';
  }

  @override
  String get remindMe => 'Нагадувати';

  @override
  String remindNext(Object when) {
    return 'Наступне нагадування: $when';
  }

  @override
  String get remindNone => 'Нагадування не заплановано: попереду нічого.';

  @override
  String remindPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нагадувань заплановано на цьому телефоні',
      few: '$count нагадування заплановано на цьому телефоні',
      one: '$count нагадування заплановано на цьому телефоні',
      zero: 'На цьому телефоні ще нічого не заплановано',
    );
    return '$_temp0';
  }

  @override
  String get remindTest => 'Надіслати пробне нагадування зараз';

  @override
  String get remindLateHint =>
      'Нагадування можуть приходити на кілька хвилин пізніше; точний момент обирає телефон.';

  @override
  String get remindPermissionDenied =>
      'Немає дозволу на сповіщення, нагадування залишається вимкненим. Дозвольте їх у налаштуваннях застосунку на телефоні й спробуйте ще раз.';

  @override
  String get batteryHint =>
      'Якщо нагадування не приходять, дозвольте cat(a)log працювати у фоні в налаштуваннях батареї телефона.';

  @override
  String get batterySettings => 'Налаштування батареї';

  @override
  String get achievementsTitle => 'Досягнення';

  @override
  String get rankServant => 'Слуга';

  @override
  String get rankButler => 'Дворецький';

  @override
  String get rankSteward => 'Управитель';

  @override
  String get rankChancellor => 'Канцлер';

  @override
  String get rankMinister => 'Міністр';

  @override
  String titleWithChore(Object title, Object chore) {
    return '$title ($chore)';
  }

  @override
  String get coatCalico => 'Каліко';

  @override
  String get coatCheetah => 'Гепард';

  @override
  String get coatTiger => 'Тигр';

  @override
  String get coatTabby => 'Табі';

  @override
  String get coatPaws => 'Лапки';

  @override
  String get coatRosettes => 'Розетки';

  @override
  String get coatZebra => 'Зебра';

  @override
  String get coatSetting => 'Шубка';

  @override
  String get coatRandom => 'Щоразу інша';

  @override
  String get coatSnowLeopard => 'Сніговий барс';

  @override
  String get coatSiamese => 'Сіамські відмітини';

  @override
  String get coatLynx => 'Рись';

  @override
  String get coatTortoiseshell => 'Черепаховий';

  @override
  String coatUnlocked(Object coat) {
    return 'Нова шубка: $coat';
  }

  @override
  String get coatUnlockedHow => 'Цілий місяць справ, усі зроблені.';

  @override
  String get achievementsEmpty =>
      'Поки нічого не зароблено. Справи знають дорогу.';

  @override
  String get achievementMonth => 'Повний місяць';

  @override
  String get achievementYear => 'Повний рік';

  @override
  String get achievementDecade => 'Повне десятиліття';

  @override
  String get achievementCentury => 'Повне століття';

  @override
  String get achievementCenturyHint => 'Ми обоє дуже пишатимемось.';

  @override
  String achievementMaster(String title) {
    return 'Майстер: $title';
  }

  @override
  String achievementReached(int times, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'Досягнуто $times разів',
      few: 'Досягнуто $times рази',
      one: 'Досягнуто $times раз',
    );
    return '$_temp0, уперше $date';
  }

  @override
  String achievementNext(int n) {
    return 'Наступна сходинка: $n';
  }

  @override
  String get achievementLocked => 'Ще ні';

  @override
  String achievementUnlocked(String name) {
    return 'Досягнення: $name';
  }

  @override
  String get appointmentTitleLabel => 'Що';

  @override
  String get notesLabel => 'Нотатки';

  @override
  String get timeLabel => 'Час';

  @override
  String get allDayLabel => 'Увесь день';

  @override
  String get alertLabel => 'Сповіщення';

  @override
  String get alertNone => 'Немає';

  @override
  String get alertDayBefore => 'За день';

  @override
  String get alertHourBefore => 'За годину';

  @override
  String get linkFieldLabel => 'Після завершення записати в поле';

  @override
  String get noLinkedField => 'Без поля';

  @override
  String get outcomeTitle => 'Як минуло?';

  @override
  String get finishLabel => 'Завершити';

  @override
  String get editLabelAppointment => 'Змінити візит';

  @override
  String get deleteAppointment => 'Видалити візит';

  @override
  String get stepFlierText => 'Текст оголошення';

  @override
  String get qrFoundHint =>
      'На оголошенні знайдено QR-код. Позначені коди читаються для пошуку номерів реєстру та посилань.';

  @override
  String get useCode => 'Використати цей код';

  @override
  String get qrNone => 'QR-код на фото не знайдено.';

  @override
  String qrFailed(String error) {
    return 'Не вдалося прочитати QR-код: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Розпізнано оголошення $name. Перевірте нижче, у яке поле потрапляє кожен рядок.';
  }

  @override
  String get flierLayoutUnknown =>
      'Невідомий формат оголошення. Призначте рядки полям нижче; решта залишиться в нотатках.';

  @override
  String get targetRegistryNumber => 'Номер у реєстрі';

  @override
  String get targetLostPlace => 'Адреса (місце зникнення)';

  @override
  String get targetContact => 'Контакт реєстру';

  @override
  String get targetDrop => 'Відкинути';

  @override
  String get existingCat => 'Наявна кішка';

  @override
  String get existingCatNeutral => 'Наявний улюбленець';

  @override
  String get existingClowder => 'Наявна група';

  @override
  String get existingClowderNeutral => 'Наявне домогосподарство';

  @override
  String get createNewInstead => 'Немає — створити нову';

  @override
  String overwritesValue(String value) {
    return 'Перезапише поточне значення \"$value\"';
  }

  @override
  String get abortScanTitle => 'Перервати сканування?';

  @override
  String get abortScanBody => 'Нічого не буде збережено.';

  @override
  String get abortScan => 'Перервати';

  @override
  String get keepScanning => 'Продовжити';

  @override
  String get catsOnAppointment => 'Коти на цьому прийомі';

  @override
  String get catsOnAppointmentNeutral => 'Улюбленці на цьому прийомі';

  @override
  String get noCatsHint =>
      'Жодного кота не позначено — прийом належить самій колонії.';

  @override
  String get noCatsHintNeutral =>
      'Жодного улюбленця не позначено — прийом належить самому домогосподарству.';

  @override
  String get pickCatsTitle => 'Які коти їдуть?';

  @override
  String get pickCatsTitleNeutral => 'Які улюбленці їдуть?';

  @override
  String catsCount(int count) {
    return '$count котів';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count улюбленців';
  }

  @override
  String get finishUntickHint =>
      'Зніміть позначку з котів, яких не лікували; вони залишаються в плані.';

  @override
  String get finishUntickHintNeutral =>
      'Зніміть позначку з улюбленців, яких не лікували; вони залишаються в плані.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Видалити прийом для всіх $count котів';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Видалити прийом для всіх $count улюбленців';
  }

  @override
  String get correctThisValue => 'Виправити це значення';

  @override
  String get removeThisValue => 'Прибрати це значення';

  @override
  String get restoreThisValue => 'Повернути це значення';

  @override
  String get showRemovedValues => 'Показати прибрані значення';

  @override
  String get hideRemovedValues => 'Сховати прибрані значення';

  @override
  String entryRemovedBy(Object who, Object when) {
    return 'Прибрано · $who · $when';
  }

  @override
  String entryReplacedBy(Object value, Object who, Object when) {
    return 'Замінено на $value · $who · $when';
  }

  @override
  String get entryCorrection => 'Виправлення';

  @override
  String get restorePickFolder => 'Вибрати теку резервних копій…';

  @override
  String get restoreAndroidHint =>
      'Резервні копії попередньої інсталяції лежать у Documents/catlog (у старіших версіях Downloads/catlog). Виберіть цю теку один раз; її копії з\'являться тут.';

  @override
  String get backupsTitle => 'Резервні копії';

  @override
  String get backupsSubtitle => 'Де зберігаються копії ваших каталогів';

  @override
  String get backupsAndroidSystem =>
      'Google зберігає каталоги цього застосунку у вашому обліковому записі, без фотографій. Після перевстановлення або на новому телефоні вони повертаються самі.';

  @override
  String get backupsAndroidFiles =>
      'Повна копія кожного каталогу, з фотографіями, записується в Documents/catlog щоразу, коли ви виходите із застосунку після змін.';

  @override
  String get backupsIosSystem =>
      'Резервна копія iCloud містить цей застосунок з його каталогами й фотографіями, як і будь-який інший застосунок на цьому iPhone.';

  @override
  String get backupsIosFiles =>
      'Повна копія кожного каталогу лежить у застосунку «Файли» в теці cat(a)log. Звідти її можна надіслати в iCloud Drive, через AirDrop або на інший телефон.';

  @override
  String get backupsDesktopFiles =>
      'Повна копія кожного каталогу, з фотографіями, записується в теку «Завантаження» щоразу, коли ви виходите із застосунку після змін.';

  @override
  String backupsLast(Object date) {
    return 'Остання копія: $date';
  }

  @override
  String get backupsNever => 'Копію ще не записано.';

  @override
  String get backupsNow => 'Зберегти копію зараз';

  @override
  String get backupsDone => 'Копію записано.';

  @override
  String backupsRestoredNote(Object date) {
    return 'Відновлено з резервної копії Google $date. Якщо на старому телефоні ще працює cat(a)log, синхронізуйтеся з ним один раз, потім видаліть там застосунок.';
  }

  @override
  String get backupsFolderHint =>
      'Кожну копію може отримувати й тека на ваш вибір: та, яку хмарний застосунок синхронізує на цьому телефоні (Nextcloud, Syncthing та інші), карта пам\'яті, будь-яка тека з вікна вибору. Копії лягають у catlog-backups усередині неї.';

  @override
  String get backupsFolderPick => 'Копіювати і в теку…';

  @override
  String backupsFolderIs(Object name) {
    return 'Копіюється і в $name';
  }

  @override
  String get backupsFolderRemove => 'Більше не копіювати туди';
}
