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
  String get openSettings => 'Відкрити налаштування';

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
