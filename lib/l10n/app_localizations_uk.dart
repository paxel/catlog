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
  String get noClowdersYet => 'Клаудерів ще немає.\nСтворіть перший нижче.';

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
      'Кіт зникне з усіх списків. Його фото буде видалено назавжди.';

  @override
  String get sightingRecorded => 'Зустріч записано у вашій позиції.';

  @override
  String get noLocationAvailable =>
      'Немає геолокації — натомість утримуйте палець на мапі.';

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
  String get renameField => 'Перейменувати поле';

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
  String get orPlaceClowderHere => 'Або розмістити клаудер тут:';

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
  String get starterPosition => 'Позиція';

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
  String get starterStatus => 'Статус';

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
}
