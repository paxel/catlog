// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Witaj w cat(a)log';

  @override
  String get welcomeBody =>
      'Wybierz swoje imię. Każda zmiana zostanie zapisana pod tym imieniem, żeby inni widzieli, kto co zrobił.';

  @override
  String get yourName => 'Twoje imię';

  @override
  String get start => 'Start';

  @override
  String get clowders => 'Clowdery';

  @override
  String get noClowdersYet =>
      'Nie ma jeszcze clowderów.\nUtwórz pierwszy poniżej.';

  @override
  String get strays => 'Bezdomne';

  @override
  String get searchCats => 'Szukaj kotów';

  @override
  String get map => 'Mapa';

  @override
  String get sync => 'Synchronizacja';

  @override
  String get fields => 'Pola';

  @override
  String get exportCsv => 'Eksportuj CSV';

  @override
  String get aboutAndFeedback => 'O aplikacji i opinie';

  @override
  String get newClowder => 'Nowy clowder';

  @override
  String get name => 'Nazwa';

  @override
  String get cancel => 'Anuluj';

  @override
  String get create => 'Utwórz';

  @override
  String get save => 'Zapisz';

  @override
  String get delete => 'Usuń';

  @override
  String get merge => 'Scal';

  @override
  String get resolve => 'Rozstrzygnij';

  @override
  String get open => 'Otwórz';

  @override
  String csvSavedTo(String path) {
    return 'CSV zapisano w $path';
  }

  @override
  String get renameClowder => 'Zmień nazwę clowdera';

  @override
  String get rename => 'Zmień nazwę';

  @override
  String get timeline => 'Oś czasu';

  @override
  String get mergeInto => 'Scal z…';

  @override
  String get deleteClowder => 'Usuń clowder';

  @override
  String get cats => 'Koty';

  @override
  String get addCat => 'Dodaj kota';

  @override
  String get newCat => 'Nowy kot';

  @override
  String deleteQuestion(String name) {
    return 'Usunąć $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder zniknie z listy.';

  @override
  String deleteClowderBody(int count) {
    return 'Jego $count kot(y) nie zostaną usunięte — staną się bezdomne. Przenieś je najpierw do innego clowdera, jeśli nie o to chodzi.';
  }

  @override
  String get card => 'Karta';

  @override
  String get shareAsImage => 'Udostępnij jako obraz';

  @override
  String get shareAsPdf => 'Udostępnij jako PDF';

  @override
  String get print => 'Drukuj';

  @override
  String cardTitle(String name) {
    return 'Karta — $name';
  }

  @override
  String get renameCat => 'Zmień imię kota';

  @override
  String get seenHereNow => 'Widziany tu teraz';

  @override
  String get deleteCat => 'Usuń kota';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Bezdomny — bez clowdera';

  @override
  String get stray => 'Bezdomny';

  @override
  String get photos => 'Zdjęcia';

  @override
  String get addPhoto => 'Dodaj zdjęcie';

  @override
  String get setAsProfileImage => 'Ustaw jako zdjęcie profilowe';

  @override
  String get thisIsProfileImage => 'To jest zdjęcie profilowe';

  @override
  String get deletePhoto => 'Usuń zdjęcie';

  @override
  String get deletePhotoTitle => 'Usunąć zdjęcie?';

  @override
  String get deletePhotoBody =>
      'Dane zdjęcia zostaną usunięte na zawsze — nie można tego cofnąć.';

  @override
  String get deleteCatBody =>
      'Kot zniknie ze wszystkich list. Jego zdjęcia zostaną usunięte na zawsze.';

  @override
  String get sightingRecorded => 'Zapisano obserwację w Twojej pozycji.';

  @override
  String get noLocationAvailable =>
      'Brak lokalizacji — zamiast tego przytrzymaj mapę.';

  @override
  String get moveTo => 'Przenieś do';

  @override
  String get noClowderStrayOption => 'Bez clowdera — bezdomny / uciekł';

  @override
  String timelineOf(String name) {
    return 'Oś czasu — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Cofnij tę zmianę';

  @override
  String get revertSubtitle =>
      'Przywraca poprzednią wartość jako nowy wpis — historia zachowuje oba.';

  @override
  String fieldCleared(String field) {
    return '$field wyczyszczono';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field z powrotem na \"$value\"';
  }

  @override
  String get leftStray => 'Odszedł — bezdomny';

  @override
  String movedTo(String name) {
    return 'Przeniesiony do $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat przybył';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat przybył z $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat odszedł do $place';
  }

  @override
  String get duplicateMergedIn => 'Scalono duplikat';

  @override
  String get asOfToday => 'Na dziś';

  @override
  String asOfDate(String date) {
    return 'Na dzień $date';
  }

  @override
  String get value => 'Wartość';

  @override
  String get latitudeLongitude => 'szerokość, długość geogr.';

  @override
  String get newField => 'Nowe pole';

  @override
  String get fieldType => 'Typ';

  @override
  String get usedOn => 'Używane dla';

  @override
  String get forCats => 'kotów';

  @override
  String get forClowders => 'clowderów';

  @override
  String get forBoth => 'obu';

  @override
  String get optionsOnePerLine => 'Opcje (jedna na wiersz)';

  @override
  String get renameField => 'Zmień nazwę pola';

  @override
  String get noStraysRightNow => 'Obecnie brak bezdomnych.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Dodaj bezdomnego';

  @override
  String get newStray => 'Nowy bezdomny';

  @override
  String get searchByNameHint => 'Szukaj kotów po imieniu…';

  @override
  String get host => 'Hostuj';

  @override
  String get hostExplainer =>
      'Zacznij tutaj, potem wpisz adres i PIN na drugim urządzeniu.';

  @override
  String get startHosting => 'Rozpocznij hostowanie';

  @override
  String get stopHosting => 'Zatrzymaj hostowanie';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Dotychczas sesji: $count';
  }

  @override
  String get join => 'Dołącz';

  @override
  String get addressFromHost => 'Adres (z urządzenia hostującego)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synchronizuj teraz';

  @override
  String get addressFormatHint => 'Adres musi wyglądać jak 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Zsynchronizowano: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synchronizacja nieudana: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Ostatnia synchronizacja z $peer: $time';
  }

  @override
  String get sharedFolder => 'Wspólny folder';

  @override
  String get sharedFolderExplainer =>
      'Synchronizacja przez folder przenoszony między urządzeniami przez chmurę lub pendrive — dla osób spoza tej samej sieci.';

  @override
  String get noFolderChosenYet => 'Nie wybrano jeszcze folderu';

  @override
  String get choose => 'Wybierz…';

  @override
  String get syncFolderNow => 'Synchronizuj folder teraz';

  @override
  String folderSynced(String result) {
    return 'Folder zsynchronizowany: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Synchronizacja folderu nieudana: $error';
  }

  @override
  String get recordSightingHere => 'Zapisz obserwację tutaj:';

  @override
  String get orPlaceClowderHere => 'Albo umieść tu clowder:';

  @override
  String trailOf(String name, int count) {
    return 'Trasa: $name ($count obserwacji)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'Zmienione w dwóch miejscach naraz. Wybierz, co jest prawdą:';

  @override
  String mergeThisInto(String kind) {
    return 'Scal ten $kind z…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Brak innego ($kind) do scalenia.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Scalić z $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Dwa rekordy staną się jednym. $name zachowa obecne wartości; historia drugiego dołączy do jego osi czasu. Nie można tego cofnąć.';
  }

  @override
  String get kindCat => 'kot';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'pole';

  @override
  String get takePhoto => 'Zrób zdjęcie';

  @override
  String get chooseFromGallery => 'Wybierz z galerii';

  @override
  String get about => 'O aplikacji';

  @override
  String get aboutTagline =>
      'Lokalny katalog kotów tymczasowych. Twoje dane zostają na Twoich urządzeniach — bez serwera, bez konta.';

  @override
  String versionLabel(String version, String build) {
    return 'Wersja $version ($build)';
  }

  @override
  String get sourceCode => 'Kod źródłowy';

  @override
  String get reportProblemOrIdea => 'Zgłoś problem lub pomysł';

  @override
  String get githubIssues => 'Issues na GitHubie';

  @override
  String get writeTheDeveloper => 'Napisz do dewelopera';

  @override
  String get buyCoffee => 'Postaw deweloperowi kawę';

  @override
  String get coffeeSubtitle => 'Całkowicie dobrowolne — aplikacja jest darmowa';

  @override
  String get openSourceLicenses => 'Licencje open source';

  @override
  String get machineTranslated =>
      'Tłumaczenia są maszynowe — poprawki mile widziane na GitHubie.';

  @override
  String get unnamed => '(bez nazwy)';

  @override
  String get labelName => 'Imię';

  @override
  String get labelProfileImage => 'Zdjęcie profilowe';

  @override
  String get labelPhoto => 'Zdjęcie';

  @override
  String get starterGender => 'Płeć';

  @override
  String get starterColor => 'Umaszczenie';

  @override
  String get starterNeutered => 'Kastrowany';

  @override
  String get starterPregnant => 'Ciężarna';

  @override
  String get starterBirthdate => 'Data urodzenia';

  @override
  String get starterDeceased => 'Zmarły';

  @override
  String get starterAddress => 'Adres';

  @override
  String get starterResponsible => 'Osoba odpowiedzialna';

  @override
  String get starterPosition => 'Pozycja';

  @override
  String get valueYes => 'tak';

  @override
  String get valueNo => 'nie';

  @override
  String get valueFemale => 'kotka';

  @override
  String get valueMale => 'kocur';

  @override
  String get valueUnknown => 'nieznana';

  @override
  String get cropTitle => 'Przytnij zdjęcie';

  @override
  String get markTitle => 'Zaznacz kota';

  @override
  String get useFullPhoto => 'Użyj całego zdjęcia';

  @override
  String get dragToSelect => 'Przeciągnij prostokąt wokół kota';

  @override
  String get dragOverTheCat => 'Przeciągnij elipsę na kocie';

  @override
  String get cropPhoto => 'Przytnij…';

  @override
  String get markPhoto => 'Zaznacz…';

  @override
  String get scanCode => 'Skanuj kod';

  @override
  String get orTypeCode => 'Albo wpisz kod';

  @override
  String get copyCode => 'Kopiuj kod';

  @override
  String get copied => 'Skopiowano';

  @override
  String get invalidCode => 'Ten kod jest nieprawidłowy';

  @override
  String get hotspotHint =>
      'Brak wspólnego Wi-Fi? Włącz hotspot w jednym telefonie, połącz drugi i hostuj tutaj.';

  @override
  String get byMessenger => 'Przez komunikator';

  @override
  String get byMessengerExplainer =>
      'Wyślij cały katalog jako jeden plik przez WhatsApp, Signal lub mail — druga strona go zaimportuje.';

  @override
  String get shareBundle => 'Udostępnij pakiet synchronizacji…';

  @override
  String get importBundle => 'Importuj pakiet synchronizacji…';

  @override
  String bundleImported(String result) {
    return 'Pakiet zaimportowany: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import nieudany: $error';
  }

  @override
  String get pickOnMap => 'Wybierz na mapie';

  @override
  String get useMyLocation => 'Użyj mojej lokalizacji';

  @override
  String get language => 'Język';

  @override
  String get systemDefault => 'Domyślny systemowy';

  @override
  String get iosLocalNetworkHint =>
      'Jeśli na iPhone/iPad wciąż się nie udaje: Ustawienia → Prywatność i ochrona → Sieć lokalna → zezwól cat(a)log i spróbuj ponownie.';

  @override
  String get markPrivate => 'Oznacz jako prywatne';

  @override
  String get unmarkPrivate => 'Usuń oznaczenie prywatne';

  @override
  String get includePrivate => 'Uwzględnij dane prywatne';

  @override
  String get includePrivateExplainer =>
      'Prywatne koty, grupy i pola też są udostępniane — włączaj tylko przy synchronizacji własnych urządzeń.';

  @override
  String get hideLabel => 'Ukryj na tym urządzeniu';

  @override
  String get unhideLabel => 'Pokaż ponownie';

  @override
  String get showHiddenLabel => 'Pokaż ukryte';

  @override
  String get stopShowingHidden => 'Przestań pokazywać ukryte';
}
