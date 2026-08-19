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
      'Nie ma jeszcze clowderów. Clowder to miejsce, gdzie mieszkają koty — twój dom tymczasowy, mieszkanie adoptującego. Utwórz pierwszy poniżej.';

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
      'Kot znika ze wszystkich list, a jego zdjęcia są usuwane — tutaj i, po następnej synchronizacji, także u twoich pomocników.';

  @override
  String get sightingRecorded => 'Zapisano obserwację w Twojej pozycji.';

  @override
  String get noLocationAvailable =>
      'Brak lokalizacji — zamiast tego przytrzymaj mapę.';

  @override
  String get locationDeniedForever =>
      'Dostęp do lokalizacji jest zablokowany. Zezwól na niego w ustawieniach systemu, aby korzystać ze Stray Cam.';

  @override
  String get locationServiceOff =>
      'Lokalizacja jest wyłączona na tym urządzeniu. Włącz ją w ustawieniach i spróbuj ponownie.';

  @override
  String get locationDenied =>
      'cat(a)log nie ma uprawnień do korzystania z twojej lokalizacji. Spróbuj ponownie i zezwól, gdy pojawi się pytanie.';

  @override
  String get locationNoFix =>
      'Nie udało się teraz ustalić twojej pozycji. Spróbuj ponownie na zewnątrz — GPS potrzebuje czystego widoku nieba.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Numer czipa';

  @override
  String get starterRemarks => 'Uwagi';

  @override
  String get captureFlier => 'Sfotografuj ogłoszenie';

  @override
  String get sortLabel => 'Sortuj';

  @override
  String get matchCandidatesTitle => 'Możliwe dopasowania';

  @override
  String get strayAreaLabel => 'Możliwy obszar wędrówki';

  @override
  String get noMissingCats => 'Brak zaginionych kotów z pozycjami ogłoszeń.';

  @override
  String get noMatchCandidates => 'Obecnie brak możliwych dopasowań.';

  @override
  String sameIdField(String field) {
    return 'Ten sam $field';
  }

  @override
  String metersApart(String distance) {
    return 'W odległości $distance m';
  }

  @override
  String get addFlier => 'Dodaj ogłoszenie';

  @override
  String get missingSinceLabel => 'Zaginiony od';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Przytnij portret';

  @override
  String get statusOwner => 'Właściciel';

  @override
  String get ocrUnavailable =>
      'Rozpoznawanie tekstu nie jest dostępne na tym urządzeniu — wpisz treść ogłoszenia ręcznie.';

  @override
  String get displayFormat => 'Wyświetlane jako';

  @override
  String get displayPlain => 'Zwykły tekst';

  @override
  String get displayQr => 'Kod QR';

  @override
  String get displayBarcode => 'Kod kreskowy';

  @override
  String get editLabel => 'Edytuj';

  @override
  String get doneLabel => 'Gotowe';

  @override
  String get openSettings => 'Otwórz ustawienia';

  @override
  String get notSaved => 'Nie zapisano';

  @override
  String get birthdateInFuture => 'Data urodzenia nie może być w przyszłości.';

  @override
  String get deceasedInFuture => 'Data śmierci nie może być w przyszłości.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Data śmierci nie może być wcześniejsza niż data urodzenia ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Data urodzenia nie może być późniejsza niż data śmierci ($date).';
  }

  @override
  String get malePregnant =>
      'Ten kot jest zapisany jako samiec — samiec nie może być w ciąży. Najpierw sprawdź płeć.';

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
  String dateFormatError(String format) {
    return 'Zły format — użyj $format';
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
  String get ownValue => 'Własna wartość';

  @override
  String get renameField => 'Zmień nazwę pola';

  @override
  String get editOptions => 'Edytuj opcje…';

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
  String get starterBreed => 'Rasa';

  @override
  String get valueMixed => 'mieszaniec';

  @override
  String get breedEuropeanShorthair => 'Europejski krótkowłosy';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Brytyjski krótkowłosy';

  @override
  String get breedNorwegianForestCat => 'Kot norweski leśny';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Syjamski';

  @override
  String get breedPersian => 'Perski';

  @override
  String get breedBengal => 'Bengalski';

  @override
  String get breedSphynx => 'Sfinks';

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
  String get applyCrop => 'Przytnij';

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
  String lastBackupFailed(String error) {
    return 'Ostatnia automatyczna kopia zapasowa nie powiodła się: $error';
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

  @override
  String get starterSpecies => 'Gatunek';

  @override
  String get starterStatus => 'Status';

  @override
  String get statusFoster => 'Dom tymczasowy';

  @override
  String get statusForeverHome => 'Dom na zawsze';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Schronisko';

  @override
  String get statusBarn => 'Stodoła';

  @override
  String get valueCat => 'Kot';

  @override
  String get otherOption => 'Inne…';

  @override
  String get celebrationsToggle => 'Świętuj adopcje';

  @override
  String get celebrationsSubtitle =>
      'Konfetti i wiwaty, gdy kot przeprowadza się do domu na zawsze';

  @override
  String get onMapLabel => 'Na mapie';

  @override
  String get showOnMap => 'Pokaż na mapie';

  @override
  String get searchPlaceHint => 'Szukaj miejsca lub adresu';

  @override
  String get noPlacesFound => 'Nie znaleziono miejsc';

  @override
  String get mapSearchHint => 'Szukaj kotów, grup, osób';

  @override
  String get proposeAnotherName => 'Zaproponuj inne imię';

  @override
  String get moderationTitle => 'Autorzy i blokady';

  @override
  String get moderationSubtitle => 'Trwale usuń dane osoby';

  @override
  String get authorsSection => 'Kto pisał w tym katalogu';

  @override
  String get hardDeleteAction => 'Usuń wszystko od tego autora';

  @override
  String hardDeleteWarning(Object name) {
    return 'Usuwa każdy wpis i zdjęcie od $name z tego urządzenia. Inne urządzenia zachowują swoje. Nie można cofnąć.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Wpisz $name, aby potwierdzić';
  }

  @override
  String get alsoBan => 'Także zablokuj — nigdy więcej nie przyjmuj danych';

  @override
  String get bansSection => 'Blokady';

  @override
  String get unbanAction => 'Usuń blokadę';

  @override
  String get deletedDone => 'Usunięto.';

  @override
  String get syncSummaryTitle => 'Co dotarło';

  @override
  String get summaryAdopted => 'Adoptowane';

  @override
  String get summaryDeceased => 'Zmarłe';

  @override
  String get summaryEscaped => 'Zbiegłe';

  @override
  String get summaryNew => 'Nowe';

  @override
  String get summaryConflicts => 'Konflikty do rozwiązania';

  @override
  String summaryOther(Object n) {
    return '…i $n innych zmian';
  }

  @override
  String get starterMother => 'Matka';

  @override
  String get starterFather => 'Ojciec';

  @override
  String get familySection => 'Rodzina';

  @override
  String get littermatesLabel => 'Z jednego miotu';

  @override
  String get siblingsLabel => 'Rodzeństwo';

  @override
  String get kittensLabel => 'Kocięta';

  @override
  String get toastSettingsTitle => 'Co ogłaszać';

  @override
  String get toastSettingsSubtitle => 'Krótkie wiadomości po synchronizacji';

  @override
  String get toastKindAdoptions => 'Adopcje';

  @override
  String get toastKindBirths => 'Narodziny';

  @override
  String get toastKindDeaths => 'Zgony';

  @override
  String get toastKindEscapes => 'Ucieczki';

  @override
  String get toastKindMoves => 'Przeprowadzki';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptowany przez $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nowy kociak: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat odszedł';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat uciekł';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat przeniósł się do $home';
  }

  @override
  String get notACatlogFile => 'To nie jest plik cat(a)log';

  @override
  String get nothingNewInBundle => 'Nic nowego w pliku — masz już wszystko';

  @override
  String get syncChooserInPerson => 'Osobiście';

  @override
  String get syncChooserInPersonSub =>
      'Jesteście w tym samym pokoju — zeskanuj kod, gotowe w sekundy';

  @override
  String get syncChooserRemote => 'Zdalnie';

  @override
  String get syncChooserRemoteSub =>
      'Przez wspólny folder jak Dropbox lub pendrive';

  @override
  String get syncChooserMessenger => 'Komunikator';

  @override
  String get syncChooserMessengerSub =>
      'Wyślij wszystko jako jeden plik dowolnym komunikatorem';

  @override
  String get connectToWifiFirst =>
      'Najpierw połącz się z Wi-Fi — wtedy urządzenia się znajdą';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) chce synchronizować';
  }

  @override
  String get trustBothWaysNote => 'Katalogi zostaną wymienione w obie strony.';

  @override
  String get allowOnce => 'Zezwól';

  @override
  String get allowAlways => 'Zawsze zezwalaj temu urządzeniu';

  @override
  String get declineAction => 'Odrzuć';

  @override
  String get syncDeclined => 'Drugie urządzenie odrzuciło synchronizację';

  @override
  String get trustedDevicesSection => 'Zawsze dozwolone urządzenia';

  @override
  String get removeTrust => 'Usuń';

  @override
  String get hostWithoutWifi => 'Hostuj bez Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Tworzy tymczasowe bezpośrednie połączenie z drugim telefonem (bez internetu). Korzysta z niego tylko cat(a)log i rozłącza się samo po synchronizacji.';

  @override
  String get hotspotAndroidOnly =>
      'Ten kod wymaga dwóch telefonów z Androidem — na iPhonie/iPadzie użyj wspólnego Wi-Fi';

  @override
  String get selectClowderHint => 'Wybierz clowder po lewej';

  @override
  String get introTitle1 => 'Koty mieszkają w clowderach';

  @override
  String get introBody1 =>
      'Clowder to miejsce, gdzie mieszkają koty: twój dom tymczasowy, mieszkanie adoptującego, stodoła obok. Każdy kot ma kartę ze zdjęciem, faktami i całą historią.';

  @override
  String get introTitle2 => 'Wszystko zostaje u ciebie';

  @override
  String get introBody2 =>
      'Bez konta, bez chmury, bez śledzenia. Twoje dane żyją na twoim urządzeniu.';

  @override
  String get introTitle3 => 'Dziel się z pomocnikami';

  @override
  String get introBody3 =>
      'Zeskanuj kod, a dwa urządzenia zsynchronizują się w sekundy, użyj wspólnego folderu albo wyślij wszystko jako jeden plik.';

  @override
  String get introSkip => 'Pomiń';

  @override
  String get introNext => 'Dalej';

  @override
  String get introDone => 'Zaczynamy';

  @override
  String get introReplayTitle => 'Szybkie wprowadzenie';

  @override
  String get spotHomeSync =>
      'Nowość: synchronizacja oferuje teraz trzy jasne drogi — i pytanie o zaufanie, zanim cokolwiek popłynie.';

  @override
  String get spotMapSearch =>
      'Nowość: szukaj tu kotów, clowderów i osób — bezpośrednio na mapie.';

  @override
  String get spotCardChips =>
      'Nowość: wybierz, co znajdzie się na karcie, zanim ją udostępnisz.';

  @override
  String get spotCatMenu =>
      'Nowość: oznacz kota jako prywatnego (nigdy nie opuszcza urządzenia) albo ukryj go tutaj.';

  @override
  String get spotDone => 'Rozumiem';

  @override
  String get spotReplayTitle => 'Przegląd nowości';

  @override
  String get spotReplaySubtitle => 'Pokaż wskazówki ponownie na każdej stronie';

  @override
  String get spotReplayDone => 'Wskazówki pojawią się ponownie';

  @override
  String get searchNoResults => 'Nie znaleziono kota o tym imieniu';

  @override
  String get syncUnreachable =>
      'Nie można połączyć się z drugim urządzeniem. Czy oba są w tej samej sieci Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Nie można otworzyć folderu. Czy dysk lub folder w chmurze nadal istnieje?';

  @override
  String get crashTitle => 'To nie powinno było się zdarzyć';

  @override
  String get crashBody =>
      'cat(a)log napotkał nieoczekiwany błąd. Twoje dane są bezpieczne — wszystko zapisuje się w chwili zmiany. Uruchom aplikację ponownie, a jeśli się powtarza, wyślij raport, żeby dało się to naprawić.';

  @override
  String get crashRestart => 'Uruchom aplikację ponownie';

  @override
  String get crashSendReport => 'Wyślij raport do dewelopera';

  @override
  String get crashLastRunBody =>
      'cat(a)log zatrzymał się niespodziewanie ostatnim razem — prawdopodobnie zabrakło pamięci. Wysłać krótki raport, żeby to naprawić?';
}
