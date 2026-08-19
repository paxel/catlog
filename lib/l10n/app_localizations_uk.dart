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
  String get noClowdersYet =>
      'Клаудерів ще немає. Клаудер — це місце, де живуть коти: ваш тимчасовий дім, квартира усиновлювача. Створіть перший нижче.';

  @override
  String get strays => 'Безпритульні';

  @override
  String get searchCats => 'Пошук котів';

  @override
  String get map => 'Мапа';

  @override
  String get sync => 'Синхронізація';

  @override
  String get fields => 'Поля';

  @override
  String get exportCsv => 'Експорт CSV';

  @override
  String get aboutAndFeedback => 'Про застосунок і відгуки';

  @override
  String get newClowder => 'Новий клаудер';

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
  String get rename => 'Перейменувати';

  @override
  String get timeline => 'Історія';

  @override
  String get mergeInto => 'Об\'єднати з…';

  @override
  String get deleteClowder => 'Видалити клаудер';

  @override
  String get cats => 'Коти';

  @override
  String get addCat => 'Додати кота';

  @override
  String get newCat => 'Новий кіт';

  @override
  String deleteQuestion(String name) {
    return 'Видалити $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудер зникне зі списку.';

  @override
  String deleteClowderBody(int count) {
    return 'Його котів ($count) не буде видалено — вони стануть безпритульними. Спершу перемістіть їх до іншого клаудера, якщо це не те, чого ви хочете.';
  }

  @override
  String get card => 'Картка';

  @override
  String get shareAsImage => 'Поділитися як зображенням';

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
  String get seenHereNow => 'Бачили тут щойно';

  @override
  String get deleteCat => 'Видалити кота';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get strayNoClowder => 'Безпритульний — без клаудера';

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
      'Кіт зникає з усіх списків, його фото видаляються — тут, а після наступної синхронізації й у ваших помічників.';

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
  String get savingLabel => 'Збереження…';

  @override
  String ownerOfCat(String name) {
    return 'Власник $name';
  }

  @override
  String get sortLabel => 'Сортування';

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
  String get videoMobileOnly =>
      'Вибір кадрів з відео працює в телефонному застосунку (Android та iPhone) — на цьому пристрої поки ні.';

  @override
  String get shareWhitelistExplainer =>
      'Каталог покидають лише позначені поля. Решта залишається вдома.';

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
  String shareSource(String url) {
    return 'Джерело: $url';
  }

  @override
  String get importLabel => 'Імпортувати';

  @override
  String get strayAreaLabel => 'Можлива зона блукання';

  @override
  String get noMissingCats =>
      'Поки немає зниклих котів із позиціями оголошень.';

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
  String get genderFatherFemale =>
      'Цього кота записано як батька інших котів — батько не може бути самкою. Спершу перевірте родину.';

  @override
  String get genderMotherMale =>
      'Цю кішку записано як матір інших котів — мати не може бути самцем. Спершу перевірте родину.';

  @override
  String get moveTo => 'Перемістити до';

  @override
  String get noClowderStrayOption => 'Без клаудера — безпритульний / втік';

  @override
  String timelineOf(String name) {
    return 'Історія — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Скасувати цю зміну';

  @override
  String get revertSubtitle =>
      'Повертає попереднє значення новим записом — історія зберігає обидва.';

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
  String get forClowders => 'клаудерів';

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
  String get host => 'Роздати';

  @override
  String get hostExplainer =>
      'Почніть тут, потім введіть адресу та PIN на іншому пристрої.';

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
      'Синхронізація через теку, яку хмара або флешка переносить між пристроями — для тих, хто не в одній мережі.';

  @override
  String get noFolderChosenYet => 'Теку ще не обрано';

  @override
  String get choose => 'Обрати…';

  @override
  String get syncFolderNow => 'Синхронізувати теку зараз';

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
  String conflictOn(String field) {
    return 'Конфлікт — $field';
  }

  @override
  String get conflictBody =>
      'Змінено у двох місцях одночасно. Оберіть, що є правдою:';

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
  String get kindClowder => 'клаудер';

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
  String get coffeeSubtitle => 'Цілком добровільно — застосунок безплатний';

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
  String get applyCrop => 'Обрізати';

  @override
  String get useFullPhoto => 'Використати все фото';

  @override
  String get dragToSelect => 'Проведіть прямокутник навколо кота';

  @override
  String get dragOverTheCat => 'Проведіть еліпс над котом';

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
  String get systemDefault => 'Системна за замовчуванням';

  @override
  String get iosLocalNetworkHint =>
      'Якщо на iPhone/iPad далі не вдається: Параметри → Конфіденційність і безпека → Локальна мережа → дозвольте cat(a)log і спробуйте ще раз.';

  @override
  String get markPrivate => 'Позначити як особисте';

  @override
  String get unmarkPrivate => 'Зняти особисту позначку';

  @override
  String get includePrivate => 'Включити особисті дані';

  @override
  String get includePrivateExplainer =>
      'Особисті коти, групи та поля теж передаються — вмикайте лише під час синхронізації власних пристроїв.';

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
  String get statusForeverHome => 'Постійний дім';

  @override
  String get statusClinic => 'Клініка';

  @override
  String get statusShelter => 'Притулок';

  @override
  String get statusBarn => 'Стодола';

  @override
  String get valueCat => 'Кіт';

  @override
  String get otherOption => 'Інше…';

  @override
  String get celebrationsToggle => 'Святкувати прилаштування';

  @override
  String get celebrationsSubtitle =>
      'Конфеті та радість, коли кіт переїжджає в постійний дім';

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
  String summaryOther(Object n) {
    return '…і ще $n змін';
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
  String get syncChooserInPersonSub =>
      'Ви в одній кімнаті — відскануйте код, готово за секунди';

  @override
  String get syncChooserRemote => 'Віддалено';

  @override
  String get syncChooserRemoteSub =>
      'Через спільну папку на кшталт Dropbox чи USB-флешки';

  @override
  String get syncChooserMessenger => 'Месенджер';

  @override
  String get syncChooserMessengerSub =>
      'Надішліть усе одним файлом через будь-який месенджер';

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
  String get introTitle1 => 'Коти живуть у клаудерах';

  @override
  String get introBody1 =>
      'Клаудер — це місце, де живуть коти: ваш тимчасовий дім, квартира усиновлювача, сусідня стодола. Кожен кіт має картку з фото, фактами та всією історією.';

  @override
  String get introTitle2 => 'Усе залишається у вас';

  @override
  String get introBody2 =>
      'Без облікового запису, без хмари, без стеження. Ваші дані живуть на вашому пристрої.';

  @override
  String get introTitle3 => 'Діліться з помічниками';

  @override
  String get introBody3 =>
      'Відскануйте код — і два пристрої синхронізуються за секунди; використовуйте спільну папку або надішліть усе одним файлом.';

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
      'Нове: синхронізація тепер пропонує три зрозумілі шляхи — і питання довіри, перш ніж щось піде.';

  @override
  String get spotHomeStrays =>
      'Нове: у безпритульних тепер своя картка тут угорі — кількість, мордочки, торкніться, щоб відкрити.';

  @override
  String get spotHomeMenu =>
      'Нове: це меню знаходить дублікати котів і колоній та об\'єднує їх.';

  @override
  String get spotCatEdit =>
      'Нове: сторінка лише для читання — олівець вмикає редагування, довге натискання на поле редагує його одразу.';

  @override
  String get spotMapLayers =>
      'Нове: показати кола пошуку 500 м навколо місць оголошень зниклого кота.';

  @override
  String get spotStraysFlier =>
      'Нове: сфотографуйте оголошення про зниклого кота — воно стане котом, власником і контактом.';

  @override
  String get spotStraysScan =>
      'Нове: відскануйте код cat(a)log з оголошення, щоб імпортувати кота напряму.';

  @override
  String get introTitle4 => 'Зниклі коти';

  @override
  String get introBody4 =>
      'Сфотографуйте оголошення — зниклий кіт потрапить до каталогу з контактом власника. Спостереження, кола пошуку та пропозиції збігів допомагають повернути його додому.';

  @override
  String get spotMapSearch =>
      'Нове: шукайте тут котів, клаудери та людей — просто на карті.';

  @override
  String get spotCardChips =>
      'Нове: виберіть, що потрапить на картку, перш ніж ділитися нею.';

  @override
  String get spotCatMenu =>
      'Нове: позначте кота як особистого (ніколи не покидає пристрій) або сховайте його тут.';

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
}
