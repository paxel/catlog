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
      'Кіт зникне з усіх списків, його фото буде видалено — тут і, після наступної синхронізації, на інших пристроях.';

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
      'Обидва пристрої використовують одну теку (наприклад, у Dropbox або на флешці). Кожна синхронізація кладе туди ваші зміни й забирає чужі.';

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
  String get stepFaceHint =>
      'Виріжте мордочку кота з оголошення; вона стане фото профілю. Крок можна пропустити.';

  @override
  String get stepRegistryHint =>
      'Номери, знайдені в оголошенні. Позначені збережуться в кота й відкриються пізніше.';

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
  String get helpClowder =>
      'Усе про це місце: його коти, поля (адреса, контакт, тип) та історія. Сторінка відкривається лише для читання; олівець вмикає редагування, там же можна додати поле. Довге натискання на поле редагує його одразу, на кота — переміщує, приховує або відкриває його.';

  @override
  String get helpCat =>
      'Усе про цю кішку: фото, поля, родина, історія. Сторінка лише для читання, поки не торкнешся олівця. Довге натискання на поле одразу відкриває редагування; довге натискання на фото відкриває його меню. Меню праворуч угорі тримає решту: сховати, об\'єднати, записати спостереження, поділитися кішкою. «Приватно» задається під час редагування поля.';

  @override
  String get helpStrays =>
      'Коти, які зараз не мають дому: знайдені, втеклі або взяті з оголошення. Кнопка камери записує кота, що сидить перед вами; кнопка оголошення перетворює плакат на кота з контактом власника; сканер читає код cat(a)log з плаката.';

  @override
  String get helpMap =>
      'Усі коти й місця з координатами. Пошук знаходить котів, людей і місця — незнайому назву шукає в усьому світі. Кнопка шарів малює кола 500 м навколо місць оголошень зниклого кота та навколо дому, з якого він утік. Стрілки ведуть від мітки до мітки, довге натискання на карту записує спостереження.';

  @override
  String get helpCard =>
      'Друкована картка кота: угорі чипами обираєте, що на ній буде, потім ділитеся нею як зображенням або PDF. Номери друкуються як QR чи штрихкод, а координати стають QR, що відкриває карту, плюс короткий Plus Code.';

  @override
  String get helpSync =>
      'Як дані потрапляють до інших: з\'єднатися напряму, використати теку, яку бачать обидва пристрої, або надіслати файл через месенджер. Ви завжди вирішуєте, що надсилати — і отримані файли .catsync відкриваються теж тут.';

  @override
  String get helpFields =>
      'Поля, які використовує ваш каталог. Перейменуйте їх, змініть варіанти поля вибору або створіть власні. Поле-ідентифікатор може вказувати на службу (реєстр), тоді номер у кота стає натискним.';

  @override
  String get helpTimeline =>
      'Кожна зроблена зміна, найновіші вгорі: хто, коли і на яке значення щось змінив. Будь-який запис можна скасувати — це створює новий запис, нічого ніколи не стирається.';

  @override
  String get helpDuplicates =>
      'Коти або колонії, які виглядають як той самий запис двічі: однакові номери чи дуже схожі імена зі збіжними деталями. Торкніться пари, щоб об\'єднати; це незворотно, тому спитають заздалегідь.';

  @override
  String get helpMatches =>
      'Коти, які можуть бути однією твариною: однаковий номер або безпритульний, помічений у зоні пошуку зниклого кота. Торкніться пари, щоб об\'єднати, довге натискання відкриє першого кота для порівняння.';

  @override
  String get helpFlier =>
      'Зі сфотографованого оголошення виходить кіт разом із власником. Крок за кроком: дані кота, контакт власника, обрізання мордочки для фото профілю, номери реєстрів з оголошення і остаточна перевірка. Усе це пропозиції — виправте те, що камера прочитала хибно.';

  @override
  String get archiveTitle => 'Архів';

  @override
  String get archiveExplainer =>
      'Померлі коти й порожні колонії, до яких роками ніхто не торкався, однаково займають місце — надто їхні фотографії. Архівація записує їх у файл, який ви зберігаєте, і потім видаляє їх звідси.';

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
  String get otherOption => 'Інше…';

  @override
  String get celebrationsToggle => 'Святкувати прилаштування';

  @override
  String get celebrationsSubtitle =>
      'Конфеті та радість, коли кіт переїжджає у свій дім';

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
  String get introTitle1 => 'Ваші коти під контролем';

  @override
  String get introBody1 =>
      'Заведіть картку на кожного кота: фото, стать, здоров\'я — усе, що хочете занотувати. Коти згруповані за місцем, де живуть, — застосунок називає його колонією (clowder).';

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
  String get spotHomeMenu =>
      'У цьому меню: пошук і об\'єднання дублікатів, експорт CSV та інше.';

  @override
  String get spotCatEdit =>
      'Торкніться олівця, щоб редагувати кота. Порада: довге натискання на поле редагує його одразу.';

  @override
  String get spotMapLayers =>
      'Шукаєте зниклого кота? Покажіть кола навколо місць його оголошень і навколо дому, з якого він утік.';

  @override
  String get spotStraysFlier =>
      'Знайшли оголошення про зниклого кота? Сфотографуйте його тут — застосунок збереже кота й контакт за вас.';

  @override
  String get spotStraysScan =>
      'На деяких оголошеннях є QR-код cat(a)log. Відскануйте його тут і імпортуйте кота без набору.';

  @override
  String get introTitle4 => 'Шукайте зниклих котів';

  @override
  String get introBody4 =>
      'Побачили оголошення про зниклого кота? Сфотографуйте його в застосунку: він збереже кота, контакт власника й місце. Якщо згодом з\'явиться схожий безпритульний кіт, застосунок запропонує можливі збіги.';

  @override
  String get spotMapSearch =>
      'Введіть кота, місце чи людину, щоб перейти туди на карті.';

  @override
  String get spotCardChips =>
      'Позначте, що має бути на картці для поширення — решта на неї не потрапить.';

  @override
  String get spotCatMenu =>
      'Тут ще дії: сховати кішку, об\'єднати дублікати або записати спостереження.';

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

  @override
  String get catalogsTitle => 'Каталоги';

  @override
  String get newCatalog => 'Новий каталог';

  @override
  String get catalogNameLabel => 'Назва каталогу';

  @override
  String catalogNameTaken(String name) {
    return 'Каталог з назвою $name вже є. Виберіть іншу назву.';
  }

  @override
  String get manageCatalogs => 'Керування каталогами';

  @override
  String get helpCatalogs =>
      'Кожен каталог — окремий світ: власні коти, колонії, поля, світлини та партнери синхронізації. Берлін і Париж ніколи не змішуються. Торкніться назви вгорі головного екрана, щоб перемкнути, додати або перейменувати. Ваше ім’я, мова та вже показані підказки спільні для всіх.';

  @override
  String get spotHomeCatalog =>
      'Це каталог, у якому ви зараз. Торкніться назви, щоб перемкнути або створити новий.';

  @override
  String get deleteCatalog => 'Видалити каталог';

  @override
  String deleteCatalogBody(String name) {
    return 'Усе в каталозі $name зникне: коти, світлини, історія. Спершу повний файл зберігається там, куди йдуть автоматичні резервні копії, — його імпорт поверне каталог. Введіть назву для підтвердження.';
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
  String get changeDateLabel => 'Змінити дату';

  @override
  String get removeReminderLabel => 'Прибрати нагадування';

  @override
  String get exportIcs => 'Експортувати файл календаря';

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
  String get helpAgenda =>
      'Нагадування показують заплановані візити за датою. Є два види: візити із зазначенням часу і нагадування на день. Пропущені лишаються вгорі. Дотик відкриває кота чи клаудер. Галочка підтверджує візит: значення записується в поле, і можна одразу запланувати наступний, наприклад через три місяці. Утримання змінює дату або видаляє візит. Перемикач угорі віддзеркалює візити в календар телефона. Меню експортує їх файлом календаря.';

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
  String get spotAddReminderClowder =>
      'Запланувати візит для цього клаудера. Він показується в нагадуваннях і підтверджується там.';

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
  String get abortScanTitle => 'Перервати сканування?';

  @override
  String get abortScanBody => 'Нічого не буде збережено.';

  @override
  String get abortScan => 'Перервати';

  @override
  String get keepScanning => 'Продовжити';
}
