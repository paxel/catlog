// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Добро пожаловать в cat(a)log';

  @override
  String get welcomeBody =>
      'Выберите себе имя. Каждое изменение записывается под этим именем, чтобы другие видели, кто что сделал.';

  @override
  String get yourName => 'Ваше имя';

  @override
  String get start => 'Начать';

  @override
  String get clowders => 'Клаудеры';

  @override
  String get noClowdersYet =>
      'Клаудеров пока нет. Клаудер — это место, где живут кошки: ваша передержка, квартира усыновителя. Создайте первый ниже.';

  @override
  String get strays => 'Бездомные';

  @override
  String get searchCats => 'Поиск кошек';

  @override
  String get map => 'Карта';

  @override
  String get sync => 'Синхронизация';

  @override
  String get fields => 'Поля';

  @override
  String get exportCsv => 'Экспорт CSV';

  @override
  String get aboutAndFeedback => 'О приложении и отзывы';

  @override
  String get newClowder => 'Новый клаудер';

  @override
  String get name => 'Имя';

  @override
  String get cancel => 'Отмена';

  @override
  String get create => 'Создать';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get merge => 'Объединить';

  @override
  String get resolve => 'Решить';

  @override
  String get open => 'Открыть';

  @override
  String csvSavedTo(String path) {
    return 'CSV сохранён в $path';
  }

  @override
  String get renameClowder => 'Переименовать клаудер';

  @override
  String get rename => 'Переименовать';

  @override
  String get timeline => 'История';

  @override
  String get mergeInto => 'Объединить с…';

  @override
  String get deleteClowder => 'Удалить клаудер';

  @override
  String get cats => 'Кошки';

  @override
  String get addCat => 'Добавить кошку';

  @override
  String get newCat => 'Новая кошка';

  @override
  String deleteQuestion(String name) {
    return 'Удалить $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Клаудер исчезнет из списка.';

  @override
  String deleteClowderBody(int count) {
    return 'Его кошки ($count) не удаляются — они станут бездомными. Сначала переместите их в другой клаудер, если это не то, что нужно.';
  }

  @override
  String get card => 'Карточка';

  @override
  String get shareAsImage => 'Поделиться как изображением';

  @override
  String get shareAsPdf => 'Поделиться как PDF';

  @override
  String get print => 'Печать';

  @override
  String cardTitle(String name) {
    return 'Карточка — $name';
  }

  @override
  String get renameCat => 'Переименовать кошку';

  @override
  String get seenHereNow => 'Видели здесь сейчас';

  @override
  String get deleteCat => 'Удалить кошку';

  @override
  String get clowderLabel => 'Клаудер';

  @override
  String get strayNoClowder => 'Бездомная — без клаудера';

  @override
  String get stray => 'Бездомная';

  @override
  String get photos => 'Фото';

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String get setAsProfileImage => 'Сделать фото профиля';

  @override
  String get thisIsProfileImage => 'Это фото профиля';

  @override
  String get deletePhoto => 'Удалить фото';

  @override
  String get deletePhotoTitle => 'Удалить фото?';

  @override
  String get deletePhotoBody =>
      'Данные фото удаляются навсегда — это нельзя отменить.';

  @override
  String get deleteCatBody =>
      'Кошка исчезнет из всех списков, её фото будут удалены — здесь и, после следующей синхронизации, на остальных устройствах.';

  @override
  String get sightingRecorded => 'Встреча записана в вашей позиции.';

  @override
  String get noLocationAvailable =>
      'Геолокация недоступна — вместо этого удерживайте палец на карте.';

  @override
  String get locationDeniedForever =>
      'Доступ к местоположению заблокирован. Разрешите его в настройках системы, чтобы использовать Stray Cam.';

  @override
  String get locationServiceOff =>
      'Геолокация на этом устройстве выключена. Включите её в настройках и попробуйте снова.';

  @override
  String get locationDenied =>
      'У cat(a)log нет разрешения использовать ваше местоположение. Попробуйте снова и разрешите доступ, когда появится запрос.';

  @override
  String get locationNoFix =>
      'Не удалось определить ваше местоположение. Попробуйте снова на улице — GPS нужен открытый вид на небо.';

  @override
  String get ok => 'ОК';

  @override
  String get starterChipId => 'Номер чипа';

  @override
  String get starterRemarks => 'Заметки';

  @override
  String get captureFlier => 'Сфотографировать объявление';

  @override
  String get addPhotosTo => 'Добавить фото к…';

  @override
  String photosAddedTo(String count, String name) {
    return 'Добавлено фото: $count — $name';
  }

  @override
  String get scanPrintedCode => 'Сканировать напечатанный код';

  @override
  String get chipScanHint =>
      'Сканирует напечатанный QR/штрихкод с карты чипа или ветеринарных документов — сам чип в кошке телефон прочитать не может.';

  @override
  String get savingLabel => 'Сохранение…';

  @override
  String ownerOfCat(String name) {
    return 'Хозяин $name';
  }

  @override
  String get sortLabel => 'Сортировка';

  @override
  String get viewAsTable => 'Показать таблицей';

  @override
  String get viewAsTiles => 'Показать плитками';

  @override
  String get viewAsList => 'Показать списком';

  @override
  String get ageLabel => 'Возраст';

  @override
  String get catList => 'Список кошек';

  @override
  String get matchCandidatesTitle => 'Возможные совпадения';

  @override
  String get findDuplicates => 'Найти дубликаты';

  @override
  String get noDuplicates => 'Сейчас возможных дубликатов нет.';

  @override
  String get similarName => 'Похожее имя';

  @override
  String get sharePublicly => 'Поделиться публично…';

  @override
  String get pickFramesTitle => 'Выбор кадров';

  @override
  String get suggestedFrames => 'Предложенные кадры';

  @override
  String get scrubFrames => 'Перемотка видео';

  @override
  String get keepThisFrame => 'Оставить этот кадр';

  @override
  String get fromVideo => 'Из видео…';

  @override
  String get videoMobileOnly =>
      'Выбор кадров из видео работает в телефонном приложении (Android и iPhone) — на этом устройстве пока нет.';

  @override
  String get shareWhitelistExplainer =>
      'Выберите, что попадёт в файл. Включаются только отмеченные поля.';

  @override
  String get exportShareFile => 'Экспортировать файл обмена…';

  @override
  String get hostedLink => 'Размещённая ссылка (URL загруженного файла)';

  @override
  String get inlineQr => 'Встроенный QR (только текст, без фото)';

  @override
  String get inlineTooBig =>
      'Слишком много данных для встроенного кода — снимите поля или используйте размещённую ссылку.';

  @override
  String get scanShareLabel => 'Сканировать код обмена';

  @override
  String get notAShareCode => 'Этот код — не обмен cat(a)log.';

  @override
  String get importShareTitle => 'Импортировать эту кошку?';

  @override
  String shareSource(String url) {
    return 'Источник: $url';
  }

  @override
  String get importLabel => 'Импортировать';

  @override
  String get strayAreaLabel => 'Возможная зона блуждания';

  @override
  String get prevPin => 'Предыдущая метка';

  @override
  String get nextPin => 'Следующая метка';

  @override
  String get noMissingCats =>
      'Пока нет пропавших кошек с позициями объявлений.';

  @override
  String get noMatchCandidates => 'Сейчас возможных совпадений нет.';

  @override
  String sameIdField(String field) {
    return 'Одинаковый $field';
  }

  @override
  String metersApart(String distance) {
    return 'В $distance м друг от друга';
  }

  @override
  String get addFlier => 'Добавить объявление';

  @override
  String get missingSinceLabel => 'Пропал с';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get cropPortrait => 'Обрезать портрет';

  @override
  String get statusOwner => 'Хозяин';

  @override
  String get ocrUnavailable =>
      'Распознавание текста недоступно на этом устройстве — введите текст объявления вручную.';

  @override
  String get displayFormat => 'Отображается как';

  @override
  String get displayPlain => 'Обычный текст';

  @override
  String get displayQr => 'QR-код';

  @override
  String get displayBarcode => 'Штрихкод';

  @override
  String get editLabel => 'Редактировать';

  @override
  String get doneLabel => 'Готово';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get notSaved => 'Не сохранено';

  @override
  String get birthdateInFuture => 'Дата рождения не может быть в будущем.';

  @override
  String get deceasedInFuture => 'Дата смерти не может быть в будущем.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Дата смерти не может быть раньше даты рождения ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Дата рождения не может быть позже даты смерти ($date).';
  }

  @override
  String get malePregnant =>
      'Этот кот записан как самец — самец не может быть беременным. Сначала проверьте пол.';

  @override
  String fatherNotMale(String name) {
    return '$name записана как самка и не может быть отцом. Сначала проверьте пол.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name записан как самец и не может быть матерью. Сначала проверьте пол.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name родился $date — родитель не может родиться после своего котёнка.';
  }

  @override
  String get genderFatherFemale =>
      'Этот кот записан как отец других кошек — отец не может быть самкой. Сначала проверьте семью.';

  @override
  String get genderMotherMale =>
      'Эта кошка записана как мать других кошек — мать не может быть самцом. Сначала проверьте семью.';

  @override
  String get moveTo => 'Переместить в';

  @override
  String get noClowderStrayOption => 'Без клаудера — бездомная / сбежала';

  @override
  String timelineOf(String name) {
    return 'История — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Отменить это изменение';

  @override
  String get revertSubtitle =>
      'Возвращает прежнее значение новой записью — история сохраняет оба.';

  @override
  String fieldCleared(String field) {
    return '$field очищено';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field возвращено к «$value»';
  }

  @override
  String get leftStray => 'Ушла — бездомная';

  @override
  String movedTo(String name) {
    return 'Перемещена в $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat прибыла';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat прибыла из $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat ушла в $place';
  }

  @override
  String get duplicateMergedIn => 'Дубликат объединён';

  @override
  String get asOfToday => 'По состоянию на сегодня';

  @override
  String asOfDate(String date) {
    return 'По состоянию на $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Неверный формат — используйте $format';
  }

  @override
  String get dateInFuture => 'Эта дата не может быть в будущем.';

  @override
  String get value => 'Значение';

  @override
  String get latitudeLongitude => 'широта, долгота';

  @override
  String get newField => 'Новое поле';

  @override
  String get fieldType => 'Тип';

  @override
  String get usedOn => 'Используется для';

  @override
  String get forCats => 'кошек';

  @override
  String get forClowders => 'клаудеров';

  @override
  String get forBoth => 'обоих';

  @override
  String get optionsOnePerLine => 'Варианты (по одному в строке)';

  @override
  String get ownValue => 'Своё значение';

  @override
  String get renameField => 'Переименовать поле';

  @override
  String get editOptions => 'Изменить варианты…';

  @override
  String get noStraysRightNow => 'Сейчас бездомных нет.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Добавить бездомную';

  @override
  String get newStray => 'Новая бездомная';

  @override
  String get searchByNameHint => 'Поиск кошек по имени…';

  @override
  String get host => 'Раздать';

  @override
  String get hostExplainer =>
      'Начните здесь, затем отсканируйте код или введите его на другом устройстве.';

  @override
  String get startHosting => 'Начать раздачу';

  @override
  String get stopHosting => 'Остановить раздачу';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Сеансов: $count';
  }

  @override
  String get join => 'Присоединиться';

  @override
  String get addressFromHost => 'Адрес (с устройства-хоста)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Синхронизировать сейчас';

  @override
  String get addressFormatHint =>
      'Адрес должен выглядеть как 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Синхронизировано: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Ошибка синхронизации: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Последняя синхронизация с $peer: $time';
  }

  @override
  String get sharedFolder => 'Общая папка';

  @override
  String get sharedFolderExplainer =>
      'Оба устройства используют одну папку (например, в Dropbox или на флешке). Каждая синхронизация кладёт туда ваши изменения и забирает чужие.';

  @override
  String get noFolderChosenYet => 'Папка ещё не выбрана';

  @override
  String get choose => 'Выбрать…';

  @override
  String get syncFolderNow => 'Синхронизировать папку сейчас';

  @override
  String folderSynced(String result) {
    return 'Папка синхронизирована: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Ошибка синхронизации папки: $error';
  }

  @override
  String get recordSightingHere => 'Записать встречу здесь:';

  @override
  String trailOf(String name, int count) {
    return 'Маршрут: $name (встреч: $count)';
  }

  @override
  String conflictOn(String field) {
    return 'Конфликт — $field';
  }

  @override
  String get conflictBody =>
      'Изменено в двух местах одновременно. Выберите, что верно:';

  @override
  String mergeThisInto(String kind) {
    return 'Объединить эту запись ($kind) с…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Нет другой записи ($kind) для объединения.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Объединить с $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Две записи станут одной. $name сохранит текущие значения; история другой присоединится к ней. Это нельзя отменить.';
  }

  @override
  String get kindCat => 'кошка';

  @override
  String get kindClowder => 'клаудер';

  @override
  String get kindField => 'поле';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get about => 'О приложении';

  @override
  String get aboutTagline =>
      'Локальный каталог кошек на передержке. Ваши данные остаются на ваших устройствах — без сервера, без аккаунта.';

  @override
  String versionLabel(String version, String build) {
    return 'Версия $version ($build)';
  }

  @override
  String get sourceCode => 'Исходный код';

  @override
  String get reportProblemOrIdea => 'Сообщить о проблеме или идее';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Написать разработчику';

  @override
  String get buyCoffee => 'Угостить разработчика кофе';

  @override
  String get coffeeSubtitle =>
      'Приложение остаётся бесплатным. Даже если кофе мне не достанется :)';

  @override
  String get openSourceLicenses => 'Лицензии открытого кода';

  @override
  String get machineTranslated =>
      'Переводы машинные — исправления приветствуются на GitHub.';

  @override
  String get unnamed => '(без имени)';

  @override
  String get labelName => 'Имя';

  @override
  String get labelProfileImage => 'Фото профиля';

  @override
  String get labelPhoto => 'Фото';

  @override
  String get starterGender => 'Пол';

  @override
  String get starterBreed => 'Порода';

  @override
  String get valueMixed => 'метис';

  @override
  String get breedEuropeanShorthair => 'Европейская короткошёрстная';

  @override
  String get breedMaineCoon => 'Мейн-кун';

  @override
  String get breedBritishShorthair => 'Британская короткошёрстная';

  @override
  String get breedNorwegianForestCat => 'Норвежская лесная';

  @override
  String get breedRagdoll => 'Рэгдолл';

  @override
  String get breedSiamese => 'Сиамская';

  @override
  String get breedPersian => 'Персидская';

  @override
  String get breedBengal => 'Бенгальская';

  @override
  String get breedSphynx => 'Сфинкс';

  @override
  String get starterColor => 'Окрас';

  @override
  String get starterNeutered => 'Стерилизована';

  @override
  String get starterPregnant => 'Беременна';

  @override
  String get starterBirthdate => 'Дата рождения';

  @override
  String get starterDeceased => 'Умерла';

  @override
  String get starterAddress => 'Адрес';

  @override
  String get starterResponsible => 'Ответственный';

  @override
  String get starterEmail => 'Эл. почта';

  @override
  String get starterPhone => 'Телефон';

  @override
  String get lookupUrlLabel => 'Ссылка для поиска';

  @override
  String lookupUrlHelp(String token) {
    return 'Страница службы с $token на месте номера, напр. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Найти';

  @override
  String lookupFailed(String url) {
    return 'Ни одно приложение не смогло открыть $url. Скопируйте ссылку в браузер.';
  }

  @override
  String get stepCat => 'Кошка';

  @override
  String get stepOwner => 'Владелец';

  @override
  String get stepFace => 'Фото морды';

  @override
  String get stepRegistry => 'Реестр';

  @override
  String get stepReview => 'Проверить и сохранить';

  @override
  String get stepOwnerHint =>
      'Тот, кто ищет кошку, — из этого получится его клаудер с контактом с объявления.';

  @override
  String get stepFaceHint =>
      'Вырежьте морду кошки с объявления; она станет фото профиля. Шаг можно пропустить.';

  @override
  String get stepRegistryHint =>
      'Номера, найденные на объявлении. Отмеченные сохранятся у кошки и откроются позже.';

  @override
  String get noRegistryLinks =>
      'На этом объявлении нет ссылок на реестры — если какие-то пропущены, сообщите об ошибке.';

  @override
  String get unknownServiceHint => 'Неизвестная служба';

  @override
  String get rememberService => 'Запомнить службу';

  @override
  String get rememberServiceHint =>
      'Назовите службу и укажите номер в ссылке. Следующее объявление заполнится само.';

  @override
  String get noIdInLink =>
      'В этой ссылке нет номера, который приложение могло бы сохранить.';

  @override
  String get whichNumber => 'Какая часть — номер?';

  @override
  String get cropAgain => 'Обрезать заново';

  @override
  String get noFaceYet => 'Фото морды пока нет — используется фото объявления.';

  @override
  String get backLabel => 'Назад';

  @override
  String get dangerButton => 'НЕ НАЖИМАТЬ.\nОПАСНО';

  @override
  String get dangerThanks => 'Спасибо, что пользуетесь cat(a)log!';

  @override
  String get helpTitle => 'Справка';

  @override
  String get showTipsAgain => 'Показать подсказки снова';

  @override
  String get helpHome =>
      'Обзор ваших колоний — колония это место, где живут кошки: ваш дом, передержка, приют. Нажмите на карточку, чтобы увидеть её кошек; долгое нажатие открывает меню. Кнопка внизу справа создаёт колонию, а карточка бездомных собирает всех кошек без дома. Имя вверху — каталог, в котором вы находитесь; коснитесь, чтобы переключиться или добавить.';

  @override
  String get helpClowder =>
      'Всё об этом месте: его кошки, поля (адрес, контакт, тип) и история. Страница открывается только для чтения; карандаш включает правку, там же можно добавить поле. Долгое нажатие на поле правит его сразу, на кошку — перемещает, скрывает или открывает её. Добавленный здесь приём может взять несколько кошек колонии, например на стерилизацию: отметьте кошек, которые едут, завершите один раз, снимите отметку с тех, кого не лечили.';

  @override
  String get helpCat =>
      'Всё об этой кошке: фото, поля, семья, история. Страница только для чтения, пока не коснёшься карандаша. Долгое нажатие на поле сразу открывает его редактирование; долгое нажатие на фото открывает его меню. Меню справа вверху держит остальное: скрыть, объединить, записать наблюдение, поделиться кошкой. «Приватно» задаётся при редактировании поля.';

  @override
  String get helpStrays =>
      'Кошки, у которых сейчас нет дома: найденные, сбежавшие или взятые с объявления. Кнопка камеры записывает кошку, которая сидит перед вами; кнопка объявления превращает плакат в кошку с контактом владельца; сканер читает код cat(a)log с плаката.';

  @override
  String get helpMap =>
      'Все кошки и места с координатами. Поиск находит кошек, людей и места — незнакомое название ищется по всему миру. Кнопка слоёв рисует круги 500 м вокруг мест объявлений пропавшей кошки и вокруг дома, из которого она убежала. Стрелки ведут от метки к метке, долгое нажатие на карту записывает наблюдение.';

  @override
  String get helpCard =>
      'Печатная карточка кошки: сверху чипами выбираете, что на ней будет, затем делитесь ею как картинкой или PDF. Номера печатаются как QR или штрихкод, а координаты превращаются в QR, открывающий карту, плюс короткий Plus Code.';

  @override
  String get helpSync =>
      'Как данные попадают к другим людям: подключиться напрямую, использовать папку, видимую обоим устройствам, или отправить файл через мессенджер. Вы всегда решаете, что уходит, — и полученные файлы .catsync открываются тоже здесь.';

  @override
  String get helpFields =>
      'Поля, которые использует ваш каталог. Переименуйте их, измените варианты поля выбора или создайте свои. Поле-идентификатор может указывать на службу (реестр), тогда номер у кошки становится нажимаемым.';

  @override
  String get helpTimeline =>
      'Каждое сделанное изменение, новые сверху: кто, когда и на какое значение что менял. Любую запись можно отменить — это создаёт новую запись, ничего никогда не стирается.';

  @override
  String get helpDuplicates =>
      'Кошки или колонии, которые выглядят как одно и то же дважды: одинаковые номера или очень похожие имена с совпадающими деталями. Нажмите на пару, чтобы объединить; объединение необратимо, поэтому сначала спросят.';

  @override
  String get helpMatches =>
      'Кошки, которые могут быть одним животным: одинаковый номер или бездомная кошка, замеченная в зоне поиска пропавшей. Нажмите на пару, чтобы объединить, долгое нажатие открывает первую кошку для сравнения.';

  @override
  String get helpFlier =>
      'Из сфотографированного объявления получается кошка и её владелец. Шаг за шагом: данные кошки, контакт владельца, обрезка морды для фото профиля, номера реестров с объявления и финальная проверка. Всё это предложения — исправьте то, что камера прочитала неверно.';

  @override
  String get archiveTitle => 'Архив';

  @override
  String get archiveExplainer =>
      'Умершие кошки и пустые колонии, к которым годами никто не притрагивался, всё равно занимают место — особенно их фотографии. Архивация записывает их в файл, который вы храните, и затем удаляет их отсюда.';

  @override
  String get archiveAction => 'Архивировать';

  @override
  String archiveSelected(int count) {
    return 'Архивировать $count записей';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Архивировать $count записей?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names будут записаны в файл и затем удалены — на вашем устройстве и на всех, с которыми вы синхронизируетесь. Импорт файла вернёт всё; без него они потеряны.';
  }

  @override
  String archiveDone(int count) {
    return 'Архивировано и удалено записей: $count';
  }

  @override
  String archiveFailed(String error) {
    return 'Ничего не удалено: файл архива не удалось записать ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'База данных $db, фото $photos в $count файлах';
  }

  @override
  String quietForYears(int years) {
    return 'Без изменений $years лет';
  }

  @override
  String get nothingToArchive => 'Нет ничего достаточно старого для архивации.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Последнее изменение $date · фото $size';
  }

  @override
  String get helpArchive =>
      'Старые данные занимают место, прежде всего фотографии, которые тащит за собой каждое синхронизированное устройство. Здесь вы выбираете умерших кошек и пустые колонии, годами не менявшиеся, записываете их в файл, который храните, и удаляете. Удаление доходит до всех, с кем вы синхронизируетесь; импорт файла восстанавливает всё.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Восстановить удалённые записи ($count)?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names удалены в этом каталоге, а только что импортированный файл содержит их. Восстановление вернёт их сюда и на все устройства, с которыми вы синхронизируетесь.';
  }

  @override
  String get restoreAction => 'Восстановить';

  @override
  String get keepDeleted => 'Оставить удалёнными';

  @override
  String get archiveNotSaved => 'Ничего не удалено: архив нигде не сохранён.';

  @override
  String get locateAddress => 'Найти адрес на карте';

  @override
  String get addressLocated => 'Адрес найден';

  @override
  String get addressNotFound =>
      'Для этого адреса ничего не найдено. Проверьте написание или оставьте поле пустым.';

  @override
  String get starterPosition => 'Местоположение';

  @override
  String get valueYes => 'да';

  @override
  String get valueNo => 'нет';

  @override
  String get valueFemale => 'кошка';

  @override
  String get valueMale => 'кот';

  @override
  String get valueUnknown => 'неизвестно';

  @override
  String get cropTitle => 'Обрезать фото';

  @override
  String get markTitle => 'Отметить кошку';

  @override
  String get applyCrop => 'Обрезать';

  @override
  String get useFullPhoto => 'Использовать всё фото';

  @override
  String get dragToSelect => 'Проведите прямоугольник вокруг кошки';

  @override
  String get dragOverTheCat => 'Проведите эллипс над кошкой';

  @override
  String get cropPhoto => 'Обрезать…';

  @override
  String get markPhoto => 'Отметить…';

  @override
  String get scanCode => 'Сканировать код';

  @override
  String get orTypeCode => 'Или введите код';

  @override
  String get copyCode => 'Копировать код';

  @override
  String get copied => 'Скопировано';

  @override
  String get invalidCode => 'Этот код недействителен';

  @override
  String get hotspotHint =>
      'Нет общего Wi-Fi? Включите точку доступа на одном телефоне, подключите другой и раздавайте здесь.';

  @override
  String get byMessenger => 'Через мессенджер';

  @override
  String get byMessengerExplainer =>
      'Отправьте весь каталог одним файлом через WhatsApp, Signal или почту — другая сторона его импортирует.';

  @override
  String get shareBundle => 'Поделиться пакетом синхронизации…';

  @override
  String get importBundle => 'Импортировать пакет синхронизации…';

  @override
  String bundleImported(String result) {
    return 'Пакет импортирован: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Последнее автоматическое резервное копирование не удалось: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Ошибка импорта: $error';
  }

  @override
  String get pickOnMap => 'Выбрать на карте';

  @override
  String get useMyLocation => 'Использовать моё местоположение';

  @override
  String get language => 'Язык';

  @override
  String get systemDefault => 'Системный по умолчанию';

  @override
  String get iosLocalNetworkHint =>
      'Если на iPhone/iPad всё ещё не получается: Настройки → Конфиденциальность и безопасность → Локальная сеть → разрешите cat(a)log и попробуйте снова.';

  @override
  String get includePrivate => 'Поделиться приватными данными';

  @override
  String get hideLabel => 'Скрыть на этом устройстве';

  @override
  String get unhideLabel => 'Показать снова';

  @override
  String get showHiddenLabel => 'Показать скрытые';

  @override
  String get stopShowingHidden => 'Перестать показывать скрытые';

  @override
  String get starterSpecies => 'Вид';

  @override
  String get starterStatus => 'Тип';

  @override
  String get statusFoster => 'Передержка';

  @override
  String get statusForeverHome => 'Дом';

  @override
  String get statusClinic => 'Клиника';

  @override
  String get statusShelter => 'Приют';

  @override
  String get statusBarn => 'Сарай';

  @override
  String get valueCat => 'Кошка';

  @override
  String get otherOption => 'Другое…';

  @override
  String get celebrationsToggle => 'Праздновать пристройство';

  @override
  String get celebrationsSubtitle =>
      'Конфетти и ликование, когда кошка переезжает в свой дом';

  @override
  String get onMapLabel => 'На карте';

  @override
  String get showOnMap => 'Показать на карте';

  @override
  String get searchPlaceHint => 'Искать место или адрес';

  @override
  String get noPlacesFound => 'Места не найдены';

  @override
  String get mapSearchHint => 'Искать кошек, группы, людей';

  @override
  String get proposeAnotherName => 'Предложить другое имя';

  @override
  String get moderationTitle => 'Авторы и запреты';

  @override
  String get moderationSubtitle => 'Удалить данные человека навсегда';

  @override
  String get authorsSection => 'Кто писал в этот каталог';

  @override
  String get hardDeleteAction => 'Удалить всё от этого автора';

  @override
  String hardDeleteWarning(Object name) {
    return 'Удаляет каждую запись и фото от $name с этого устройства. Другие устройства сохраняют свои. Отменить нельзя.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Введите $name для подтверждения';
  }

  @override
  String get alsoBan => 'Также запретить — никогда больше не принимать данные';

  @override
  String get bansSection => 'Запреты';

  @override
  String get unbanAction => 'Снять запрет';

  @override
  String get deletedDone => 'Удалено.';

  @override
  String get syncSummaryTitle => 'Что пришло';

  @override
  String get summaryAdopted => 'Пристроены';

  @override
  String get summaryDeceased => 'Умерли';

  @override
  String get summaryEscaped => 'Сбежали';

  @override
  String get summaryNew => 'Новые';

  @override
  String get summaryConflicts => 'Конфликты для решения';

  @override
  String summaryOther(Object n) {
    return '…и ещё $n изменений';
  }

  @override
  String get starterMother => 'Мать';

  @override
  String get starterFather => 'Отец';

  @override
  String get familySection => 'Семья';

  @override
  String get littermatesLabel => 'Из одного помёта';

  @override
  String get siblingsLabel => 'Братья и сёстры';

  @override
  String get kittensLabel => 'Котята';

  @override
  String get toastSettingsTitle => 'О чём сообщать';

  @override
  String get toastSettingsSubtitle => 'Короткие сообщения после синхронизации';

  @override
  String get toastKindAdoptions => 'Пристройства';

  @override
  String get toastKindBirths => 'Рождения';

  @override
  String get toastKindDeaths => 'Смерти';

  @override
  String get toastKindEscapes => 'Побеги';

  @override
  String get toastKindMoves => 'Переезды';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat пристроен в $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Новый котёнок: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat умер';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat сбежал';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat переехал в $home';
  }

  @override
  String get notACatlogFile => 'Это не файл cat(a)log';

  @override
  String get nothingNewInBundle => 'Ничего нового в файле — у вас уже всё есть';

  @override
  String get syncChooserInPerson => 'Лично';

  @override
  String get syncChooserInPersonSub => 'Синхронизация по Wi-Fi';

  @override
  String get syncChooserRemote => 'Удалённо';

  @override
  String get syncChooserRemoteSub => 'Синхронизация через папку или USB-флешку';

  @override
  String get syncChooserMessenger => 'Мессенджер';

  @override
  String get syncChooserMessengerSub => 'Экспорт и импорт через соцсети';

  @override
  String get connectToWifiFirst =>
      'Сначала подключитесь к Wi-Fi — тогда устройства найдут друг друга';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) хочет синхронизироваться';
  }

  @override
  String get trustBothWaysNote => 'Каталоги будут обменяны в обе стороны.';

  @override
  String get allowOnce => 'Разрешить';

  @override
  String get allowAlways => 'Всегда разрешать этому устройству';

  @override
  String get declineAction => 'Отклонить';

  @override
  String get syncDeclined => 'Другое устройство отклонило синхронизацию';

  @override
  String get trustedDevicesSection => 'Всегда разрешённые устройства';

  @override
  String get removeTrust => 'Убрать';

  @override
  String get hostWithoutWifi => 'Хост без Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Создаёт временное прямое соединение с другим телефоном (без интернета). Его использует только cat(a)log, после синхронизации оно отключается само.';

  @override
  String get hotspotAndroidOnly =>
      'Этот код требует два Android-телефона — на iPhone/iPad используйте общий Wi-Fi';

  @override
  String get selectClowderHint => 'Выберите клаудер слева';

  @override
  String get introTitle1 => 'Ваши кошки под контролем';

  @override
  String get introBody1 =>
      'Заведите карточку на каждую кошку: фото, пол, здоровье — всё, что хотите записать. Кошки сгруппированы по месту, где живут, — приложение называет его колонией (clowder).';

  @override
  String get introTitle2 => 'Работает без интернета';

  @override
  String get introBody2 =>
      'Всё хранится только на вашем телефоне. Без аккаунта и облака. Ничего не отправляется, пока вы сами не поделитесь.';

  @override
  String get introTitle3 => 'Работайте вместе';

  @override
  String get introBody3 =>
      'Каждый пользуется своим приложением, и время от времени вы обмениваетесь данными: встретьтесь и отсканируйте код, используйте общую папку или отправьте один файл в мессенджере. После этого у всех одинаковые данные.';

  @override
  String get introSkip => 'Пропустить';

  @override
  String get introNext => 'Далее';

  @override
  String get introDone => 'Поехали';

  @override
  String get introReplayTitle => 'Быстрое знакомство';

  @override
  String get spotHomeSync =>
      'Здесь вы синхронизируетесь со знакомыми. Что отправлять — решаете вы.';

  @override
  String get spotHomeStrays =>
      'Эта карточка собирает всех бездомных кошек. Нажмите, чтобы увидеть список.';

  @override
  String get spotHomeMenu =>
      'В этом меню: поиск и объединение дубликатов, экспорт CSV и другое.';

  @override
  String get spotCatEdit =>
      'Нажмите на карандаш, чтобы редактировать кошку. Совет: долгое нажатие на поле редактирует его сразу.';

  @override
  String get spotMapLayers =>
      'Ищете пропавшую кошку? Покажите круги вокруг мест её объявлений и вокруг дома, из которого она убежала.';

  @override
  String get spotStraysFlier =>
      'Нашли объявление о пропавшей кошке? Сфотографируйте его здесь — приложение сохранит кошку и контакт за вас.';

  @override
  String get spotStraysScan =>
      'На некоторых объявлениях есть QR-код cat(a)log. Отсканируйте его здесь и импортируйте кошку без набора текста.';

  @override
  String get introTitle4 => 'Ищите пропавших кошек';

  @override
  String get introBody4 =>
      'Увидели объявление о пропавшей кошке? Сфотографируйте его в приложении: оно сохранит кошку, контакт хозяина и место. Если позже появится похожая бездомная кошка, приложение предложит возможные совпадения.';

  @override
  String get spotMapSearch =>
      'Введите кошку, место или человека, чтобы перейти туда на карте.';

  @override
  String get spotCardChips =>
      'Отметьте, что должно быть на карточке для печати — остальное на неё не попадёт.';

  @override
  String get spotCatMenu =>
      'Здесь ещё действия: скрыть кошку, объединить дубликаты или записать наблюдение.';

  @override
  String get spotDone => 'Понятно';

  @override
  String get spotReplayTitle => 'Тур по новинкам';

  @override
  String get spotReplaySubtitle =>
      'Показать подсказки снова на каждой странице';

  @override
  String get spotReplayDone => 'Подсказки появятся снова';

  @override
  String get searchNoResults => 'Кошка с таким именем не найдена';

  @override
  String get syncUnreachable =>
      'Не удалось связаться с другим устройством. Оба ли в одной сети Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Не удалось открыть папку. Диск или облачная папка ещё существует?';

  @override
  String get crashTitle => 'Этого не должно было случиться';

  @override
  String get crashBody =>
      'cat(a)log столкнулся с неожиданной ошибкой. Ваши данные в безопасности — всё сохраняется в момент изменения. Перезапустите приложение, а если повторится — отправьте отчёт, чтобы это исправить.';

  @override
  String get crashRestart => 'Перезапустить приложение';

  @override
  String get crashSendReport => 'Отправить отчёт разработчику';

  @override
  String get crashLastRunBody =>
      'В прошлый раз cat(a)log неожиданно остановился — скорее всего, кончилась память. Отправить короткий отчёт, чтобы исправить?';

  @override
  String get catalogsTitle => 'Каталоги';

  @override
  String get newCatalog => 'Новый каталог';

  @override
  String get intoCatalog => 'В каталог';

  @override
  String get catalogNameLabel => 'Название каталога';

  @override
  String catalogNameTaken(String name) {
    return 'Каталог с именем $name уже есть. Выберите другое имя.';
  }

  @override
  String get manageCatalogs => 'Управление каталогами';

  @override
  String get helpCatalogs =>
      'Каждый каталог — отдельный мир: свои кошки, колонии, поля, фотографии и партнёры синхронизации. Берлин и Париж никогда не смешиваются. Коснитесь имени вверху главного экрана, чтобы переключиться, добавить или переименовать. Ваше имя, язык и уже показанные подсказки общие для всех.';

  @override
  String get spotHomeCatalog =>
      'Это каталог, в котором вы находитесь. Коснитесь имени, чтобы переключиться или создать другой.';

  @override
  String get deleteCatalog => 'Удалить каталог';

  @override
  String deleteCatalogBody(String name) {
    return 'Всё в каталоге $name исчезнет: кошки, фотографии, история. Сначала полный файл сохраняется туда же, куда идут автоматические резервные копии, — его импорт вернёт каталог. Введите имя для подтверждения.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name удалён. Файл в $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Введите $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Ничего не удалено: файл каталога не удалось записать ($error). Освободите место или попробуйте позже.';
  }

  @override
  String get moveToCatalog => 'Переместить в другой каталог';

  @override
  String movedToCatalog(int count, String name) {
    return '$count перемещено в $name';
  }

  @override
  String get chooseWhatToMove => 'Что перенести?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Перенести что-нибудь в $name?';
  }

  @override
  String get undoThisImport => 'Отменить этот импорт';

  @override
  String undoImportBody(int count) {
    return '$count изменений из этого импорта будут удалены. Сначала они записываются в файл, импорт которого вернёт их. У тех, с кем вы уже синхронизировались, копия останется — это не отозвать.';
  }

  @override
  String undoneImport(String where) {
    return 'Отменено. Файл в $where.';
  }

  @override
  String get goBackTitle => 'Вернуться назад';

  @override
  String get goBackToHere => 'Вернуться сюда';

  @override
  String get momentImport => 'Перед импортом';

  @override
  String get momentSync => 'Перед синхронизацией';

  @override
  String get momentMerge => 'Перед объединением';

  @override
  String get momentHardDelete => 'Перед удалением данных одного автора';

  @override
  String get momentArchive => 'Перед архивированием';

  @override
  String get momentManual => 'Отмечено вами';

  @override
  String get showOlderMoments => 'Показать более ранние';

  @override
  String goBackBody(int count) {
    return 'Всё после этого момента будет удалено — $count изменений. Сначала всё записывается в файл, импорт которого вернёт это обратно, и каждый более поздний момент исчезнет вместе с ним. У тех, с кем вы уже синхронизировались, копия останется — это не отозвать.';
  }

  @override
  String get nameThisMoment => 'Назовите этот момент';

  @override
  String get helpGoBack =>
      'Моменты, когда этот каталог сильно менялся: перед каждым импортом и каждой синхронизацией, перед объединением, архивированием или удалением — и всякий раз, когда вы отметили момент сами. Выбор одного возвращает каталог в то состояние: всё после него записывается в файл, который вы оставляете себе, и затем удаляется, а каждый более поздний момент исчезает вместе с ним. У тех, с кем вы уже синхронизировались, остаётся то, что они получили.';

  @override
  String goBackFileFailed(String error) {
    return 'Ничего не удалено: файл, который это сохраняет, не удалось записать ($error). Освободите место и попробуйте ещё раз.';
  }

  @override
  String get switchBeforeDeleting =>
      'Это каталог, в котором вы находитесь. Переключитесь на другой, потом удалите его.';

  @override
  String shareFileFailed(String error) {
    return 'Файл для отправки не удалось записать ($error). Освободите место и попробуйте ещё раз.';
  }

  @override
  String get privateLabel => 'Приватно';

  @override
  String sharedCatalogIs(String name) {
    return 'Каталог: $name';
  }

  @override
  String get markPrivate => 'Пометить как личное';

  @override
  String get unmarkPrivate => 'Убрать пометку личного';

  @override
  String get agenda => 'Напоминания';

  @override
  String get reminderLabel => 'Напоминание';

  @override
  String get agendaEmpty =>
      'Визитов не запланировано. Новые планируйте здесь плюсом или на странице кошки или клаудера.';

  @override
  String get dueToday => 'сегодня';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'через $count дня',
      many: 'через $count дней',
      few: 'через $count дня',
      one: 'через $count день',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'просрочено на $count дня',
      many: 'просрочено на $count дней',
      few: 'просрочено на $count дня',
      one: 'просрочено на $count день',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Готово';

  @override
  String get repeatTitle => 'Снова через…';

  @override
  String get noRepeatLabel => 'Без повтора';

  @override
  String get unitDays => 'дней';

  @override
  String get unitWeeks => 'недель';

  @override
  String get unitMonths => 'месяцев';

  @override
  String get unitYears => 'лет';

  @override
  String ageYears(int years) {
    return '$years л.';
  }

  @override
  String ageMonths(int months) {
    return '$months мес.';
  }

  @override
  String get changeDateLabel => 'Изменить дату';

  @override
  String get removeReminderLabel => 'Убрать напоминание';

  @override
  String get exportIcs => 'Экспортировать файл календаря';

  @override
  String get resyncCalendar => 'Пересинхронизировать календарь';

  @override
  String icsSavedTo(String path) {
    return 'Файл календаря сохранён в $path';
  }

  @override
  String get calendarMirrorLabel => 'Отражать в календарь устройства';

  @override
  String get calendarMirrorSubtitle =>
      'Визиты появляются в календаре как события на весь день. cat(a)log обновляет их там при каждом запуске и после каждого изменения. Оповещения о визитах настраивайте в календаре.';

  @override
  String get syncPeerOlder =>
      'На другом устройстве более старый cat(a)log без напоминаний. Обновите cat(a)log там и синхронизируйте снова.';

  @override
  String get syncPeerNewer =>
      'На другом устройстве более новый cat(a)log. Обновите cat(a)log на этом устройстве и синхронизируйте снова.';

  @override
  String get bundleNewerError =>
      'Этот файл из более нового cat(a)log. Обновите cat(a)log на этом устройстве, чтобы импортировать его.';

  @override
  String get spotEar =>
      'Маленькое кошачье ухо в углу означает: удерживайте, чтобы увидеть больше.';

  @override
  String get addReminder => 'Добавить напоминание';

  @override
  String get plannedSection => 'Запланировано';

  @override
  String get reminderDialogHint =>
      'Визит показывается в напоминаниях. Там его можно подтвердить или отклонить. Значение принимается, только если визит подтверждён.';

  @override
  String get reminderFor => 'Для';

  @override
  String get reminderField => 'Поле';

  @override
  String get dueDateLabel => 'Срок';

  @override
  String get pickCalendar => 'Какой календарь?';

  @override
  String get calendarPermissionDenied =>
      'Доступ к календарю запрещён, поэтому отражение выключено. Разрешите его в настройках системы и включите отражение снова.';

  @override
  String get calendarNotChosen =>
      'Календарь не выбран, поэтому отражение выключено. Включите его снова и выберите календарь.';

  @override
  String get calendarGone =>
      'Выбранного календаря больше нет, поэтому отражение выключено. Включите его снова и выберите другой.';

  @override
  String get noWritableCalendar =>
      'Календарь не найден. Войдите в настройках системы в аккаунт календаря, например Google, и попробуйте снова.';

  @override
  String get spotHomeAgenda =>
      'Напоминания: список запланированных визитов — ветеринар, лекарства, осмотры.';

  @override
  String get spotAgendaAdd => 'Запланировать новый визит.';

  @override
  String get spotAgendaCalendar =>
      'Включите здесь отражение визитов cat(a)log в выбранный календарь.';

  @override
  String get helpAgenda =>
      'Напоминания показывают запланированные визиты по датам. Есть два вида: визиты с указанием времени и напоминания на день. Пропущенные остаются наверху. Нажатие открывает кошку или клаудер. Галочка подтверждает визит: значение записывается в поле, и можно сразу запланировать следующий, например через три месяца. Удержание меняет дату или удаляет визит. Переключатель вверху отражает визиты в календарь телефона. Меню экспортирует их файлом календаря. Поездка к ветеринару с несколькими кошками — один приём: отметьте кошек, Повестка покажет одну карточку с их именами, а при завершении спросит, каких кошек лечили — снимите отметку с остальных, они остаются в плане.';

  @override
  String get calendarRowOff => 'Календарь: выкл.';

  @override
  String calendarRowOn(String name) {
    return 'Календарь: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Запланировать визит для этой кошки. Он показывается в напоминаниях и подтверждается там.';

  @override
  String get spotAddReminderClowder =>
      'Запланировать визит для этого клаудера. Он показывается в напоминаниях и подтверждается там.';

  @override
  String get readOnlyCalendar => 'только чтение';

  @override
  String get appointmentLabel => 'Визит';

  @override
  String get addAppointment => 'Добавить визит';

  @override
  String get planChooserTitle => 'Визит или напоминание?';

  @override
  String get planChooserAppointment =>
      'Визит — посещение в день и время, с заметками';

  @override
  String get planChooserReminder =>
      'Напоминание — значение, которое наступает в определённый день';

  @override
  String get appointmentTitleLabel => 'Что';

  @override
  String get notesLabel => 'Заметки';

  @override
  String get timeLabel => 'Время';

  @override
  String get allDayLabel => 'Весь день';

  @override
  String get alertLabel => 'Оповещение';

  @override
  String get alertNone => 'Нет';

  @override
  String get alertDayBefore => 'За день';

  @override
  String get alertHourBefore => 'За час';

  @override
  String get linkFieldLabel => 'По завершении записать в поле';

  @override
  String get noLinkedField => 'Без поля';

  @override
  String get outcomeTitle => 'Как прошло?';

  @override
  String get finishLabel => 'Завершить';

  @override
  String get editLabelAppointment => 'Изменить визит';

  @override
  String get deleteAppointment => 'Удалить визит';

  @override
  String get stepFlierText => 'Текст объявления';

  @override
  String get qrFoundHint =>
      'На объявлении найден QR-код. Отмеченные коды читаются для поиска номеров реестра и ссылок.';

  @override
  String get useCode => 'Использовать этот код';

  @override
  String get qrNone => 'QR-код на фото не найден.';

  @override
  String qrFailed(String error) {
    return 'Не удалось прочитать QR-код: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Распознано объявление $name. Проверьте ниже, в какое поле попадает каждая строка.';
  }

  @override
  String get flierLayoutUnknown =>
      'Неизвестный формат объявления. Назначьте строки полям ниже; остальное останется в заметках.';

  @override
  String get targetRegistryNumber => 'Номер в реестре';

  @override
  String get targetLostPlace => 'Адрес (место пропажи)';

  @override
  String get targetContact => 'Контакт реестра';

  @override
  String get targetDrop => 'Отбросить';

  @override
  String get existingCat => 'Существующая кошка';

  @override
  String get existingClowder => 'Существующая группа';

  @override
  String get createNewInstead => 'Нет — создать новую';

  @override
  String overwritesValue(String value) {
    return 'Перезапишет текущее значение \"$value\"';
  }

  @override
  String get abortScanTitle => 'Прервать сканирование?';

  @override
  String get abortScanBody => 'Ничего не будет сохранено.';

  @override
  String get abortScan => 'Прервать';

  @override
  String get keepScanning => 'Продолжить';

  @override
  String get catsOnAppointment => 'Кошки на этом приёме';

  @override
  String get noCatsHint =>
      'Ни одна кошка не отмечена — приём относится к самой колонии.';

  @override
  String get pickCatsTitle => 'Какие кошки едут?';

  @override
  String catsCount(int count) {
    return '$count кошек';
  }

  @override
  String get finishUntickHint =>
      'Снимите отметку с кошек, которых не лечили; они остаются в плане.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Удалить приём для всех $count кошек';
  }
}
