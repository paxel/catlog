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
  String get noClowdersYet => 'Клаудеров пока нет.\nСоздайте первый ниже.';

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
      'Кошка исчезнет из всех списков. Её фото удаляются навсегда.';

  @override
  String get sightingRecorded => 'Встреча записана в вашей позиции.';

  @override
  String get noLocationAvailable =>
      'Геолокация недоступна — вместо этого удерживайте палец на карте.';

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
  String get renameField => 'Переименовать поле';

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
      'Начните здесь, затем введите адрес и PIN на другом устройстве.';

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
      'Синхронизация через папку, которую облако или флешка переносит между устройствами — для тех, кто не в одной сети.';

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
  String get orPlaceClowderHere => 'Или разместить клаудер здесь:';

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
  String get coffeeSubtitle => 'Совершенно добровольно — приложение бесплатное';

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
  String get starterPosition => 'Позиция';

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
  String get markPrivate => 'Пометить как личное';

  @override
  String get unmarkPrivate => 'Убрать пометку личного';

  @override
  String get includePrivate => 'Включить личные данные';

  @override
  String get includePrivateExplainer =>
      'Личные кошки, группы и поля тоже передаются — включайте только при синхронизации собственных устройств.';

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
  String get starterStatus => 'Статус';

  @override
  String get statusFoster => 'Передержка';

  @override
  String get statusForeverHome => 'Постоянный дом';

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
      'Конфетти и ликование, когда кошка переезжает в постоянный дом';

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
  String get syncChooserInPersonSub =>
      'Вы в одной комнате — отсканируйте код, готово за секунды';

  @override
  String get syncChooserRemote => 'Удалённо';

  @override
  String get syncChooserRemoteSub =>
      'Через общую папку вроде Dropbox или USB-флешки';

  @override
  String get syncChooserMessenger => 'Мессенджер';

  @override
  String get syncChooserMessengerSub =>
      'Отправьте всё одним файлом через любой мессенджер';

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
}
