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
      'Kot znika ze wszystkich list, a jego zdjęcia są usuwane — tutaj i, po następnej synchronizacji, także na pozostałych urządzeniach.';

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
  String get addPhotosTo => 'Dodaj zdjęcia do…';

  @override
  String photosAddedTo(String count, String name) {
    return 'Dodano $count zdjęć do $name';
  }

  @override
  String get scanPrintedCode => 'Skanuj wydrukowany kod';

  @override
  String get chipScanHint =>
      'Skanuje wydrukowany kod QR/kreskowy z karty czipa lub dokumentów weterynaryjnych — telefon nie odczyta czipa w kocie.';

  @override
  String get savingLabel => 'Zapisywanie…';

  @override
  String ownerOfCat(String name) {
    return 'Właściciel $name';
  }

  @override
  String get sortLabel => 'Sortuj';

  @override
  String get viewAsTable => 'Pokaż jako tabelę';

  @override
  String get viewAsTiles => 'Pokaż jako kafelki';

  @override
  String get matchCandidatesTitle => 'Możliwe dopasowania';

  @override
  String get findDuplicates => 'Znajdź duplikaty';

  @override
  String get noDuplicates => 'Obecnie brak możliwych duplikatów.';

  @override
  String get similarName => 'Podobne imię';

  @override
  String get sharePublicly => 'Udostępnij publicznie…';

  @override
  String get pickFramesTitle => 'Wybór klatek';

  @override
  String get suggestedFrames => 'Sugerowane klatki';

  @override
  String get scrubFrames => 'Przewijanie wideo';

  @override
  String get keepThisFrame => 'Zachowaj tę klatkę';

  @override
  String get fromVideo => 'Z wideo…';

  @override
  String get videoMobileOnly =>
      'Wybieranie klatek z wideo działa w aplikacji na telefon (Android i iPhone) — na tym urządzeniu jeszcze nie.';

  @override
  String get shareWhitelistExplainer =>
      'Wybierz, co trafi do pliku. Dołączone są tylko zaznaczone pola.';

  @override
  String get exportShareFile => 'Eksportuj plik udostępniania…';

  @override
  String get hostedLink => 'Hostowany link (URL wgranego pliku)';

  @override
  String get inlineQr => 'Wbudowany QR (tylko tekst, bez zdjęć)';

  @override
  String get inlineTooBig =>
      'Za dużo danych na wbudowany kod — odznacz pola lub użyj hostowanego linku.';

  @override
  String get scanShareLabel => 'Skanuj kod udostępniania';

  @override
  String get notAShareCode => 'Ten kod nie jest udostępnieniem cat(a)log.';

  @override
  String get importShareTitle => 'Zaimportować tego kota?';

  @override
  String shareSource(String url) {
    return 'Źródło: $url';
  }

  @override
  String get importLabel => 'Importuj';

  @override
  String get strayAreaLabel => 'Możliwy obszar wędrówki';

  @override
  String get prevPin => 'Poprzednia pinezka';

  @override
  String get nextPin => 'Następna pinezka';

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
  String fatherNotMale(String name) {
    return '$name jest zapisana jako samica i nie może być ojcem. Najpierw sprawdź płeć.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name jest zapisany jako samiec i nie może być matką. Najpierw sprawdź płeć.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name urodził się $date — rodzic nie może urodzić się po swoim kociaku.';
  }

  @override
  String get genderFatherFemale =>
      'Ten kot jest zapisany jako ojciec innych kotów — ojciec nie może być samicą. Najpierw sprawdź rodzinę.';

  @override
  String get genderMotherMale =>
      'Ten kot jest zapisany jako matka innych kotów — matka nie może być samcem. Najpierw sprawdź rodzinę.';

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
      'Zacznij tutaj, potem zeskanuj kod lub wpisz go na drugim urządzeniu.';

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
      'Oba urządzenia używają tego samego folderu (np. w Dropboksie lub na pendrivie). Każda synchronizacja zostawia tam twoje zmiany i zabiera zmiany drugiej strony.';

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
  String get coffeeSubtitle =>
      'Aplikacja pozostaje darmowa. Nawet jeśli nie dostanę kawy :)';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Link wyszukiwania';

  @override
  String lookupUrlHelp(String token) {
    return 'Strona serwisu z $token w miejscu numeru, np. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Sprawdź';

  @override
  String lookupFailed(String url) {
    return 'Żadna aplikacja nie otworzyła $url. Skopiuj link do przeglądarki.';
  }

  @override
  String get stepCat => 'Kot';

  @override
  String get stepOwner => 'Właściciel';

  @override
  String get stepFace => 'Zdjęcie pyszczka';

  @override
  String get stepRegistry => 'Rejestr';

  @override
  String get stepReview => 'Sprawdź i zapisz';

  @override
  String get stepOwnerHint =>
      'Osoba, której zaginął kot — to będzie jej clowder, z kontaktem z ogłoszenia.';

  @override
  String get stepFaceHint =>
      'Wytnij pyszczek kota z ogłoszenia; zostanie zdjęciem profilowym. Możesz pominąć.';

  @override
  String get stepRegistryHint =>
      'Numery znalezione na ogłoszeniu. Zaznaczone zapiszą się przy kocie i można je później otworzyć.';

  @override
  String get noRegistryLinks =>
      'Brak linków do rejestrów na tym ogłoszeniu — jeśli któryś przeoczono, zgłoś błąd.';

  @override
  String get unknownServiceHint => 'Nieznany serwis';

  @override
  String get rememberService => 'Zapamiętaj serwis';

  @override
  String get rememberServiceHint =>
      'Nazwij serwis i wskaż numer w linku. Następne ogłoszenie wypełni się samo.';

  @override
  String get noIdInLink =>
      'Ten link nie zawiera numeru, który aplikacja mogłaby zapisać.';

  @override
  String get whichNumber => 'Która część to numer?';

  @override
  String get cropAgain => 'Przytnij ponownie';

  @override
  String get noFaceYet =>
      'Brak zdjęcia pyszczka — użyte zostanie zdjęcie ogłoszenia.';

  @override
  String get backLabel => 'Wstecz';

  @override
  String get dangerButton => 'NIE NACISKAĆ.\nNIEBEZPIECZEŃSTWO';

  @override
  String get dangerThanks => 'Dziękujemy za korzystanie z cat(a)log!';

  @override
  String get helpTitle => 'Pomoc';

  @override
  String get showTipsAgain => 'Pokaż wskazówki ponownie';

  @override
  String get helpHome =>
      'Przegląd twoich kolonii — kolonia to miejsce, gdzie mieszkają koty: twój dom, dom tymczasowy, schronisko. Dotknij karty, by zobaczyć jej koty; przytrzymaj, by otworzyć menu. Przycisk na dole po prawej tworzy kolonię, a karta bezdomniaków zbiera wszystkie koty bez domu. Nazwa u góry to katalog, w którym jesteś — dotknij, aby przełączyć lub dodać.';

  @override
  String get helpClowder =>
      'Wszystko o tym miejscu: jego koty, pola (adres, kontakt, rodzaj) i historia. Strona otwiera się tylko do odczytu; ołówek włącza edycję, tam też dodasz nowe pole. Przytrzymanie pola edytuje je od razu, przytrzymanie kota przenosi, ukrywa lub otwiera go.';

  @override
  String get helpCat =>
      'Wszystko o tym kocie: zdjęcia, pola, rodzina, historia. Strona jest tylko do odczytu, dopóki nie dotkniesz ołówka. Przytrzymaj pole, by od razu je edytować; przytrzymaj zdjęcie, by otworzyć jego menu. Menu w prawym górnym rogu ma resztę: ukryj, scal, zapisz zaobserwowanie, udostępnij kota. „Prywatne“ ustawia się przy edycji pola.';

  @override
  String get helpStrays =>
      'Koty, które teraz nie mają domu: znalezione, zbiegłe albo z ogłoszenia. Przycisk aparatu zapisuje kota, który siedzi przed tobą; przycisk ogłoszenia zamienia plakat w kota wraz z kontaktem właściciela; skaner odczytuje kod cat(a)log z plakatu.';

  @override
  String get helpMap =>
      'Wszystkie koty i miejsca z pozycją. Wyszukiwanie znajduje koty, osoby i miejsca — nieznaną nazwę szuka na całym świecie. Przycisk warstw rysuje okręgi 500 m wokół miejsc ogłoszeń zaginionego kota i wokół domu, z którego uciekł. Strzałki prowadzą od pinezki do pinezki, przytrzymanie mapy zapisuje obserwację.';

  @override
  String get helpCard =>
      'Karta kota do druku: u góry chipami wybierasz, co ma się na niej znaleźć, potem udostępniasz ją jako obrazek lub PDF. Numery mogą być drukowane jako QR albo kod kreskowy, a pozycja staje się kodem QR otwierającym mapę oraz krótkim Plus Code.';

  @override
  String get helpSync =>
      'Jak dane trafiają do innych: połączenie na miejscu, folder widoczny dla obu urządzeń albo plik wysłany komunikatorem. Zawsze decydujesz, co wychodzi — a otrzymane pliki .catsync otwierasz również tutaj.';

  @override
  String get helpFields =>
      'Pola używane przez twój katalog. Zmień im nazwy, zmień opcje pola wyboru albo dodaj własne. Pole identyfikatora może wskazywać na serwis (rejestr) — wtedy numer przy kocie da się kliknąć.';

  @override
  String get helpTimeline =>
      'Każda kiedykolwiek wprowadzona zmiana, od najnowszej: kto, kiedy i na jaką wartość coś zmienił. Każdy wpis można cofnąć — powstaje wtedy nowy wpis, nic nigdy nie znika.';

  @override
  String get helpDuplicates =>
      'Koty lub kolonie, które wyglądają na istniejące dwa razy — identyczne numery albo bardzo podobne imiona z pasującymi szczegółami. Dotknij pary, by ją scalić; tego nie da się cofnąć, więc pojawia się pytanie.';

  @override
  String get helpMatches =>
      'Koty, które mogą być tym samym zwierzęciem: ten sam numer albo bezdomniak widziany w obszarze poszukiwań zaginionego kota. Dotknij pary, by scalić, przytrzymaj, by otworzyć pierwszego kota i porównać.';

  @override
  String get helpFlier =>
      'Sfotografowane ogłoszenie staje się kotem wraz z właścicielem. Krok po kroku: dane kota, kontakt właściciela, wycięcie pyszczka na zdjęcie profilowe, numery rejestrów z ogłoszenia, na końcu sprawdzenie. Wszystko to propozycje — popraw to, co aparat odczytał źle.';

  @override
  String get archiveTitle => 'Archiwum';

  @override
  String get archiveExplainer =>
      'Zmarłe koty i puste kolonie, których nikt nie ruszał od lat, wciąż zajmują miejsce — zwłaszcza ich zdjęcia. Archiwizacja zapisuje je do pliku, który zatrzymujesz, a potem usuwa je stąd.';

  @override
  String get archiveAction => 'Archiwizuj';

  @override
  String archiveSelected(int count) {
    return 'Zarchiwizuj $count wpisów';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Zarchiwizować $count wpisów?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names zostaną zapisane do pliku, a potem usunięte — na twoim urządzeniu i na każdym, z którym synchronizujesz. Import pliku przywraca wszystko; bez niego przepadają.';
  }

  @override
  String archiveDone(int count) {
    return 'Zarchiwizowano i usunięto $count wpisów';
  }

  @override
  String archiveFailed(String error) {
    return 'Nic nie usunięto: nie udało się zapisać pliku archiwum ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Baza $db, zdjęcia $photos w $count plikach';
  }

  @override
  String quietForYears(int years) {
    return 'Bez zmian od $years lat';
  }

  @override
  String get nothingToArchive =>
      'Nie ma nic wystarczająco starego do archiwizacji.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Ostatnia zmiana $date · zdjęcia $size';
  }

  @override
  String get helpArchive =>
      'Stare dane zajmują miejsce, zwłaszcza zdjęcia, które nosi każde synchronizowane urządzenie. Tu wybierasz zmarłe koty i puste kolonie od lat bez zmian, zapisujesz je do pliku, który zatrzymujesz, i usuwasz. Usunięcie dociera do wszystkich, z którymi synchronizujesz; import pliku wszystko przywraca.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Przywrócić $count usuniętych wpisów?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names są usunięte w tym katalogu, a właśnie zaimportowany plik je zawiera. Przywrócenie sprowadzi je tutaj i na każde urządzenie, z którym synchronizujesz.';
  }

  @override
  String get restoreAction => 'Przywróć';

  @override
  String get keepDeleted => 'Zostaw usunięte';

  @override
  String get archiveNotSaved =>
      'Nic nie usunięto: archiwum nigdzie nie zostało zapisane.';

  @override
  String get locateAddress => 'Znajdź adres na mapie';

  @override
  String get addressLocated => 'Adres znaleziony';

  @override
  String get addressNotFound =>
      'Nie znaleziono miejsca dla tego adresu. Sprawdź pisownię albo zostaw puste.';

  @override
  String get starterPosition => 'Lokalizacja';

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
  String get includePrivate => 'Udostępnij prywatne dane';

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
  String get starterStatus => 'Typ';

  @override
  String get statusFoster => 'Dom tymczasowy';

  @override
  String get statusForeverHome => 'Dom';

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
      'Konfetti i wiwaty, gdy kot przeprowadza się do domu';

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
  String get syncChooserInPersonSub => 'Synchronizacja przez Wi-Fi';

  @override
  String get syncChooserRemote => 'Zdalnie';

  @override
  String get syncChooserRemoteSub => 'Synchronizacja przez folder lub pendrive';

  @override
  String get syncChooserMessenger => 'Komunikator';

  @override
  String get syncChooserMessengerSub =>
      'Eksport i import przez media społecznościowe';

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
  String get introTitle1 => 'Twoje koty pod kontrolą';

  @override
  String get introBody1 =>
      'Załóż kartę każdemu kotu: zdjęcie, płeć, zdrowie, co tylko chcesz zanotować. Koty są pogrupowane według miejsca, w którym żyją — aplikacja nazywa je kolonią (clowder).';

  @override
  String get introTitle2 => 'Działa bez internetu';

  @override
  String get introBody2 =>
      'Wszystko zapisuje się tylko na twoim telefonie. Bez konta, bez chmury. Nic nie jest wysyłane, dopóki sam tego nie udostępnisz.';

  @override
  String get introTitle3 => 'Współpraca';

  @override
  String get introBody3 =>
      'Każdy korzysta z własnej aplikacji, a co jakiś czas wymieniacie dane: spotkajcie się i zeskanujcie kod, użyjcie wspólnego folderu albo wyślijcie jeden plik komunikatorem. Potem wszyscy mają te same informacje.';

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
      'Tutaj synchronizujesz się ze znajomymi. To ty decydujesz, czym się dzielisz.';

  @override
  String get spotHomeStrays =>
      'Ta karta zbiera wszystkie bezdomniaki — koty bez domu. Dotknij, by zobaczyć listę.';

  @override
  String get spotHomeMenu =>
      'W tym menu: znajdowanie i scalanie duplikatów, eksport CSV i więcej.';

  @override
  String get spotCatEdit =>
      'Dotknij ołówka, by edytować tego kota. Wskazówka: przytrzymaj pole, by edytować je od razu.';

  @override
  String get spotMapLayers =>
      'Szukasz zaginionego kota? Pokaż okręgi wokół miejsc jego ogłoszeń i wokół domu, z którego uciekł.';

  @override
  String get spotStraysFlier =>
      'Ogłoszenie o zaginionym kocie? Sfotografuj je tutaj — aplikacja zapisze kota i kontakt za ciebie.';

  @override
  String get spotStraysScan =>
      'Niektóre ogłoszenia mają kod QR cat(a)log. Zeskanuj go tutaj i zaimportuj kota bez pisania.';

  @override
  String get introTitle4 => 'Odnajdywanie zaginionych kotów';

  @override
  String get introBody4 =>
      'Widzisz ogłoszenie o zaginionym kocie? Sfotografuj je w aplikacji: zapisze kota, kontakt właściciela i miejsce. Gdy później pojawi się podobny bezdomniak, aplikacja podpowie możliwe dopasowania.';

  @override
  String get spotMapSearch =>
      'Wpisz kota, miejsce lub osobę, by skoczyć tam na mapie.';

  @override
  String get spotCardChips =>
      'Zaznacz, co ma być na udostępnianej karcie — reszta zostaje poza nią.';

  @override
  String get spotCatMenu =>
      'Tu jest więcej działań: ukryj kota, scal duplikaty lub zapisz zaobserwowanie.';

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

  @override
  String get catalogsTitle => 'Katalogi';

  @override
  String get newCatalog => 'Nowy katalog';

  @override
  String get catalogNameLabel => 'Nazwa katalogu';

  @override
  String catalogNameTaken(String name) {
    return 'Katalog o nazwie $name już istnieje. Wybierz inną nazwę.';
  }

  @override
  String get manageCatalogs => 'Zarządzaj katalogami';

  @override
  String get helpCatalogs =>
      'Każdy katalog to osobny świat: własne koty, kolonie, pola, zdjęcia i partnerzy synchronizacji. Berlin i Paryż nigdy się nie mieszają. Dotknij nazwy u góry ekranu głównego, aby przełączyć, dodać lub zmienić nazwę. Twoje imię, język i już obejrzane wskazówki są wspólne dla wszystkich.';

  @override
  String get spotHomeCatalog =>
      'To katalog, w którym jesteś. Dotknij nazwy, aby przełączyć lub utworzyć nowy.';

  @override
  String get deleteCatalog => 'Usuń katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Wszystko w katalogu $name znika: koty, zdjęcia, historia. Najpierw zapisywany jest pełny plik tam, gdzie trafiają kopie automatyczne — jego import przywraca katalog. Wpisz nazwę, aby potwierdzić.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return 'Usunięto $name. Plik jest w $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Wpisz $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nic nie zostało usunięte: nie udało się zapisać pliku katalogu ($error). Zwolnij miejsce lub spróbuj później.';
  }

  @override
  String get moveToCatalog => 'Przenieś do innego katalogu';

  @override
  String movedToCatalog(int count, String name) {
    return 'Przeniesiono $count do $name';
  }

  @override
  String get chooseWhatToMove => 'Co ma się przenieść?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Przenieść coś do $name?';
  }

  @override
  String get undoThisImport => 'Cofnij ten import';

  @override
  String undoImportBody(int count) {
    return '$count zmian z tego importu zostanie usuniętych. Najpierw trafią do pliku, którego import je przywróci. Osoby, z którymi już zsynchronizowałeś, zachowają swoją kopię — tego nie da się cofnąć.';
  }

  @override
  String undoneImport(String where) {
    return 'Cofnięto. Plik jest w $where.';
  }

  @override
  String get goBackTitle => 'Cofnij się';

  @override
  String get goBackToHere => 'Wróć tutaj';

  @override
  String get momentImport => 'Przed importem';

  @override
  String get momentSync => 'Przed synchronizacją';

  @override
  String get momentMerge => 'Przed scaleniem';

  @override
  String get momentHardDelete => 'Przed usunięciem danych jednego autora';

  @override
  String get momentArchive => 'Przed archiwizacją';

  @override
  String get momentManual => 'Oznaczone przez ciebie';

  @override
  String get showOlderMoments => 'Pokaż starsze';

  @override
  String goBackBody(int count) {
    return 'Wszystko po tej chwili zostanie usunięte — $count zmian. Najpierw trafi do pliku, którego import to przywróci, a każda nowsza chwila zniknie razem z tym. Osoby, z którymi już zsynchronizowałeś, zachowają kopię — tego nie da się cofnąć.';
  }

  @override
  String get nameThisMoment => 'Nazwij tę chwilę';

  @override
  String get helpGoBack =>
      'Chwile, w których ten katalog zmienił kształt: przed każdym importem i każdą synchronizacją, przed scaleniem, archiwizacją lub usunięciem, oraz zawsze, gdy sam oznaczyłeś chwilę. Wybór jednej przywraca katalog do tego stanu — wszystko po niej trafia do pliku, który zachowujesz, a potem znika, i każda nowsza chwila odchodzi razem z tym. Osoby, z którymi już zsynchronizowałeś, zachowują to, co dostały.';

  @override
  String goBackFileFailed(String error) {
    return 'Nic nie zostało usunięte: nie udało się zapisać pliku, który to przechowuje ($error). Zwolnij miejsce i spróbuj ponownie.';
  }

  @override
  String get switchBeforeDeleting =>
      'To katalog, w którym jesteś. Przełącz się na inny, a potem go usuń.';

  @override
  String shareFileFailed(String error) {
    return 'Nie udało się zapisać pliku do udostępnienia ($error). Zwolnij miejsce i spróbuj ponownie.';
  }

  @override
  String get privateLabel => 'Prywatne';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Oznacz jako prywatne';

  @override
  String get unmarkPrivate => 'Usuń oznaczenie prywatne';

  @override
  String get agenda => 'Przypomnienia';

  @override
  String get reminderLabel => 'Przypomnienie';

  @override
  String get agendaEmpty =>
      'Brak zaplanowanych terminów. Nowe planujesz tutaj plusem albo na stronie kota lub clowdera.';

  @override
  String get dueToday => 'dzisiaj';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'za $count dnia',
      many: 'za $count dni',
      few: 'za $count dni',
      one: 'za 1 dzień',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnia po terminie',
      many: '$count dni po terminie',
      few: '$count dni po terminie',
      one: '1 dzień po terminie',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Zrobione';

  @override
  String get repeatTitle => 'Znowu za…';

  @override
  String get noRepeatLabel => 'Bez powtarzania';

  @override
  String get unitDays => 'dni';

  @override
  String get unitWeeks => 'tygodni';

  @override
  String get unitMonths => 'miesięcy';

  @override
  String get unitYears => 'lat';

  @override
  String get changeDateLabel => 'Zmień datę';

  @override
  String get removeReminderLabel => 'Usuń przypomnienie';

  @override
  String get exportIcs => 'Eksportuj plik kalendarza';

  @override
  String icsSavedTo(String path) {
    return 'Plik kalendarza zapisano w $path';
  }

  @override
  String get calendarMirrorLabel => 'Odbij w kalendarzu urządzenia';

  @override
  String get calendarMirrorSubtitle =>
      'Terminy pojawiają się jako całodniowe wydarzenia w kalendarzu. cat(a)log aktualizuje je tam przy każdym uruchomieniu i po każdej zmianie. Przypomnieniami o terminach zarządzasz w kalendarzu.';

  @override
  String get syncPeerOlder =>
      'Drugie urządzenie ma starszy cat(a)log bez przypomnień. Zaktualizuj tam cat(a)log i zsynchronizuj ponownie.';

  @override
  String get syncPeerNewer =>
      'Drugie urządzenie ma nowszy cat(a)log. Zaktualizuj cat(a)log na tym urządzeniu i zsynchronizuj ponownie.';

  @override
  String get bundleNewerError =>
      'Ten plik pochodzi z nowszego cat(a)log. Zaktualizuj cat(a)log na tym urządzeniu, aby go zaimportować.';

  @override
  String get spotEar =>
      'Małe kocie ucho w rogu oznacza: przytrzymaj, aby zobaczyć więcej.';

  @override
  String get addReminder => 'Dodaj przypomnienie';

  @override
  String get plannedSection => 'Zaplanowane';

  @override
  String get reminderDialogHint =>
      'Termin widać w przypomnieniach. Tam możesz go potwierdzić lub odrzucić. Wartość jest przejmowana tylko wtedy, gdy termin został potwierdzony.';

  @override
  String get reminderFor => 'Dla';

  @override
  String get reminderField => 'Pole';

  @override
  String get dueDateLabel => 'Termin';

  @override
  String get pickCalendar => 'Który kalendarz?';

  @override
  String get calendarPermissionDenied =>
      'Dostęp do kalendarza jest zablokowany, więc odbicie jest wyłączone. Zezwól na niego w ustawieniach systemu i włącz odbicie ponownie.';

  @override
  String get calendarNotChosen =>
      'Nie wybrano kalendarza, więc odbicie jest wyłączone. Włącz je ponownie i wybierz kalendarz.';

  @override
  String get calendarGone =>
      'Wybrany kalendarz już nie istnieje, więc odbicie jest wyłączone. Włącz je ponownie i wybierz inny.';

  @override
  String get noWritableCalendar =>
      'Nie znaleziono kalendarza. Zaloguj się w ustawieniach systemu na konto kalendarza, na przykład Google, i spróbuj ponownie.';

  @override
  String get spotHomeAgenda =>
      'Przypomnienia: lista zaplanowanych terminów — weterynarz, leki, kontrole.';

  @override
  String get spotAgendaAdd => 'Zaplanuj nowy termin.';

  @override
  String get spotAgendaCalendar =>
      'Włącz tutaj odbijanie terminów cat(a)log w wybranym kalendarzu.';

  @override
  String get helpAgenda =>
      'Przypomnienia pokazują zaplanowane terminy według daty. Są dwa rodzaje: terminy z godziną i przypomnienia obowiązujące na dany dzień. Przegapione zostają na górze. Dotknięcie otwiera kota lub clowder. Ptaszek potwierdza termin: wartość trafia do pola i możesz od razu zaplanować kolejny, na przykład za trzy miesiące. Przytrzymanie zmienia datę lub usuwa termin. Przełącznik u góry odbija terminy w kalendarzu telefonu. Menu eksportuje je jako plik kalendarza.';

  @override
  String get calendarRowOff => 'Kalendarz: wyłączony';

  @override
  String calendarRowOn(String name) {
    return 'Kalendarz: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Zaplanuj termin dla tego kota. Widać go w przypomnieniach i tam się go potwierdza.';

  @override
  String get spotAddReminderClowder =>
      'Zaplanuj termin dla tego clowdera. Widać go w przypomnieniach i tam się go potwierdza.';

  @override
  String get readOnlyCalendar => 'tylko do odczytu';

  @override
  String get appointmentLabel => 'Termin';

  @override
  String get addAppointment => 'Dodaj termin';

  @override
  String get planChooserTitle => 'Termin czy przypomnienie?';

  @override
  String get planChooserAppointment =>
      'Termin — wizyta w dniu i o godzinie, z notatkami';

  @override
  String get planChooserReminder =>
      'Przypomnienie — wartość, która staje się należna danego dnia';

  @override
  String get appointmentTitleLabel => 'Co';

  @override
  String get notesLabel => 'Notatki';

  @override
  String get timeLabel => 'Godzina';

  @override
  String get allDayLabel => 'Cały dzień';

  @override
  String get alertLabel => 'Powiadomienie';

  @override
  String get alertNone => 'Brak';

  @override
  String get alertDayBefore => 'Dzień wcześniej';

  @override
  String get alertHourBefore => 'Godzinę wcześniej';

  @override
  String get linkFieldLabel => 'Po zakończeniu wpisz do pola';

  @override
  String get noLinkedField => 'Brak pola';

  @override
  String get outcomeTitle => 'Jak poszło?';

  @override
  String get finishLabel => 'Zakończ';

  @override
  String get editLabelAppointment => 'Edytuj termin';

  @override
  String get deleteAppointment => 'Usuń termin';
}
