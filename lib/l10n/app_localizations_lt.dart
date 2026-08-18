// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Sveiki atvykę į cat(a)log';

  @override
  String get welcomeBody =>
      'Pasirinkite sau vardą. Kiekvienas pakeitimas įrašomas šiuo vardu, kad kiti matytų, kas ką padarė.';

  @override
  String get yourName => 'Jūsų vardas';

  @override
  String get start => 'Pradėti';

  @override
  String get clowders => 'Klauderiai';

  @override
  String get noClowdersYet => 'Klauderių dar nėra.\nSukurkite pirmąjį žemiau.';

  @override
  String get strays => 'Benamės katės';

  @override
  String get searchCats => 'Ieškoti kačių';

  @override
  String get map => 'Žemėlapis';

  @override
  String get sync => 'Sinchronizavimas';

  @override
  String get fields => 'Laukai';

  @override
  String get exportCsv => 'Eksportuoti CSV';

  @override
  String get aboutAndFeedback => 'Apie ir atsiliepimai';

  @override
  String get newClowder => 'Naujas klauderis';

  @override
  String get name => 'Vardas';

  @override
  String get cancel => 'Atšaukti';

  @override
  String get create => 'Sukurti';

  @override
  String get save => 'Išsaugoti';

  @override
  String get delete => 'Ištrinti';

  @override
  String get merge => 'Sujungti';

  @override
  String get resolve => 'Nuspręsti';

  @override
  String get open => 'Atidaryti';

  @override
  String csvSavedTo(String path) {
    return 'CSV išsaugotas: $path';
  }

  @override
  String get renameClowder => 'Pervadinti klauderį';

  @override
  String get rename => 'Pervadinti';

  @override
  String get timeline => 'Laiko juosta';

  @override
  String get mergeInto => 'Sujungti su…';

  @override
  String get deleteClowder => 'Ištrinti klauderį';

  @override
  String get cats => 'Katės';

  @override
  String get addCat => 'Pridėti katę';

  @override
  String get newCat => 'Nauja katė';

  @override
  String deleteQuestion(String name) {
    return 'Ištrinti $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Klauderis dingsta iš sąrašo.';

  @override
  String deleteClowderBody(int count) {
    return 'Jo katės ($count) neištrinamos — jos tampa benamėmis. Jei to nenorite, pirma perkelkite jas į kitą klauderį.';
  }

  @override
  String get card => 'Kortelė';

  @override
  String get shareAsImage => 'Bendrinti kaip paveikslėlį';

  @override
  String get shareAsPdf => 'Bendrinti kaip PDF';

  @override
  String get print => 'Spausdinti';

  @override
  String cardTitle(String name) {
    return 'Kortelė — $name';
  }

  @override
  String get renameCat => 'Pervadinti katę';

  @override
  String get seenHereNow => 'Ką tik matyta čia';

  @override
  String get deleteCat => 'Ištrinti katę';

  @override
  String get clowderLabel => 'Klauderis';

  @override
  String get strayNoClowder => 'Benamė — be klauderio';

  @override
  String get stray => 'Benamė';

  @override
  String get photos => 'Nuotraukos';

  @override
  String get addPhoto => 'Pridėti nuotrauką';

  @override
  String get setAsProfileImage => 'Nustatyti kaip profilio nuotrauką';

  @override
  String get thisIsProfileImage => 'Tai profilio nuotrauka';

  @override
  String get deletePhoto => 'Ištrinti nuotrauką';

  @override
  String get deletePhotoTitle => 'Ištrinti nuotrauką?';

  @override
  String get deletePhotoBody =>
      'Nuotraukos duomenys ištrinami visam laikui — atšaukti negalima.';

  @override
  String get deleteCatBody =>
      'Katė dingsta iš visų sąrašų. Jos nuotraukos ištrinamos visam laikui.';

  @override
  String get sightingRecorded => 'Pastebėjimas įrašytas jūsų pozicijoje.';

  @override
  String get noLocationAvailable =>
      'Vietos nėra — vietoj to palaikykite nuspaudę žemėlapį.';

  @override
  String get locationDeniedForever =>
      'Prieiga prie vietos užblokuota. Leiskite ją sistemos nustatymuose, kad galėtumėte naudoti Stray Cam.';

  @override
  String get openSettings => 'Atidaryti nustatymus';

  @override
  String get moveTo => 'Perkelti į';

  @override
  String get noClowderStrayOption => 'Be klauderio — benamė / pabėgo';

  @override
  String timelineOf(String name) {
    return 'Laiko juosta — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Atšaukti šį pakeitimą';

  @override
  String get revertSubtitle =>
      'Grąžina ankstesnę reikšmę kaip naują įrašą — istorija išsaugo abu.';

  @override
  String fieldCleared(String field) {
    return '$field išvalyta';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field grąžinta į \"$value\"';
  }

  @override
  String get leftStray => 'Išėjo — benamė';

  @override
  String movedTo(String name) {
    return 'Perkelta į $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat atvyko';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat atvyko iš $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat išvyko į $place';
  }

  @override
  String get duplicateMergedIn => 'Dublikatas sujungtas';

  @override
  String get asOfToday => 'Šios dienos data';

  @override
  String asOfDate(String date) {
    return 'Data: $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Neteisingas formatas — naudokite $format';
  }

  @override
  String get value => 'Reikšmė';

  @override
  String get latitudeLongitude => 'platuma, ilguma';

  @override
  String get newField => 'Naujas laukas';

  @override
  String get fieldType => 'Tipas';

  @override
  String get usedOn => 'Naudojama';

  @override
  String get forCats => 'katėms';

  @override
  String get forClowders => 'klauderiams';

  @override
  String get forBoth => 'abiem';

  @override
  String get optionsOnePerLine => 'Parinktys (po vieną eilutėje)';

  @override
  String get ownValue => 'Sava reikšmė';

  @override
  String get renameField => 'Pervadinti lauką';

  @override
  String get editOptions => 'Redaguoti parinktis…';

  @override
  String get noStraysRightNow => 'Šiuo metu benamių kačių nėra.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Pridėti benamę';

  @override
  String get newStray => 'Nauja benamė';

  @override
  String get searchByNameHint => 'Ieškoti kačių pagal vardą…';

  @override
  String get host => 'Priimti';

  @override
  String get hostExplainer =>
      'Pradėkite čia, tada kitame įrenginyje įveskite adresą ir PIN.';

  @override
  String get startHosting => 'Pradėti priėmimą';

  @override
  String get stopHosting => 'Sustabdyti priėmimą';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Seansų iki šiol: $count';
  }

  @override
  String get join => 'Prisijungti';

  @override
  String get addressFromHost => 'Adresas (iš priimančio įrenginio)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sinchronizuoti dabar';

  @override
  String get addressFormatHint =>
      'Adresas turi atrodyti kaip 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sinchronizuota: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sinchronizavimas nepavyko: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Paskutinis sinchronizavimas su $peer: $time';
  }

  @override
  String get sharedFolder => 'Bendras aplankas';

  @override
  String get sharedFolderExplainer =>
      'Sinchronizuokite per aplanką, kurį tarp įrenginių perneša debesis ar USB atmintukas — tiems, kurie ne tame pačiame tinkle.';

  @override
  String get noFolderChosenYet => 'Aplankas dar nepasirinktas';

  @override
  String get choose => 'Pasirinkti…';

  @override
  String get syncFolderNow => 'Sinchronizuoti aplanką dabar';

  @override
  String folderSynced(String result) {
    return 'Aplankas sinchronizuotas: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Aplanko sinchronizavimas nepavyko: $error';
  }

  @override
  String get recordSightingHere => 'Įrašyti pastebėjimą čia:';

  @override
  String trailOf(String name, int count) {
    return 'Maršrutas: $name ($count pastebėjimai)';
  }

  @override
  String conflictOn(String field) {
    return 'Konfliktas — $field';
  }

  @override
  String get conflictBody =>
      'Pakeista dviejose vietose vienu metu. Pasirinkite, kas teisinga:';

  @override
  String mergeThisInto(String kind) {
    return 'Sujungti šį įrašą ($kind) su…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Nėra kito įrašo ($kind) sujungimui.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Sujungti su $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Du įrašai tampa vienu. $name išlaiko dabartines reikšmes; kito istorija prisijungia. Atšaukti negalima.';
  }

  @override
  String get kindCat => 'katė';

  @override
  String get kindClowder => 'klauderis';

  @override
  String get kindField => 'laukas';

  @override
  String get takePhoto => 'Fotografuoti';

  @override
  String get chooseFromGallery => 'Pasirinkti iš galerijos';

  @override
  String get about => 'Apie';

  @override
  String get aboutTagline =>
      'Vietinis globojamų kačių katalogas. Jūsų duomenys lieka jūsų įrenginiuose — be serverio, be paskyros.';

  @override
  String versionLabel(String version, String build) {
    return 'Versija $version ($build)';
  }

  @override
  String get sourceCode => 'Šaltinio kodas';

  @override
  String get reportProblemOrIdea => 'Pranešti apie problemą ar idėją';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Parašyti kūrėjui';

  @override
  String get buyCoffee => 'Nupirkti kūrėjui kavos';

  @override
  String get coffeeSubtitle => 'Visiškai savanoriška — programa nemokama';

  @override
  String get openSourceLicenses => 'Atvirojo kodo licencijos';

  @override
  String get machineTranslated =>
      'Vertimai mašininiai — pataisymai laukiami GitHub.';

  @override
  String get unnamed => '(be vardo)';

  @override
  String get labelName => 'Vardas';

  @override
  String get labelProfileImage => 'Profilio nuotrauka';

  @override
  String get labelPhoto => 'Nuotrauka';

  @override
  String get starterGender => 'Lytis';

  @override
  String get starterBreed => 'Veislė';

  @override
  String get valueMixed => 'mišrūnas';

  @override
  String get breedEuropeanShorthair => 'Europos trumpaplaukė';

  @override
  String get breedMaineCoon => 'Meino meškėnas';

  @override
  String get breedBritishShorthair => 'Britų trumpaplaukė';

  @override
  String get breedNorwegianForestCat => 'Norvegų miško katė';

  @override
  String get breedRagdoll => 'Ragdolas';

  @override
  String get breedSiamese => 'Siamo';

  @override
  String get breedPersian => 'Persų';

  @override
  String get breedBengal => 'Bengalijos';

  @override
  String get breedSphynx => 'Sfinksas';

  @override
  String get starterColor => 'Spalva';

  @override
  String get starterNeutered => 'Sterilizuota';

  @override
  String get starterPregnant => 'Vaikinga';

  @override
  String get starterBirthdate => 'Gimimo data';

  @override
  String get starterDeceased => 'Nugaišo';

  @override
  String get starterAddress => 'Adresas';

  @override
  String get starterResponsible => 'Atsakingas asmuo';

  @override
  String get starterPosition => 'Pozicija';

  @override
  String get valueYes => 'taip';

  @override
  String get valueNo => 'ne';

  @override
  String get valueFemale => 'patelė';

  @override
  String get valueMale => 'patinas';

  @override
  String get valueUnknown => 'nežinoma';

  @override
  String get cropTitle => 'Apkirpti nuotrauką';

  @override
  String get markTitle => 'Pažymėti katę';

  @override
  String get applyCrop => 'Apkirpti';

  @override
  String get useFullPhoto => 'Naudoti visą nuotrauką';

  @override
  String get dragToSelect => 'Vilkite stačiakampį aplink katę';

  @override
  String get dragOverTheCat => 'Vilkite elipsę virš katės';

  @override
  String get cropPhoto => 'Apkirpti…';

  @override
  String get markPhoto => 'Pažymėti…';

  @override
  String get scanCode => 'Nuskaityti kodą';

  @override
  String get orTypeCode => 'Arba įveskite kodą';

  @override
  String get copyCode => 'Kopijuoti kodą';

  @override
  String get copied => 'Nukopijuota';

  @override
  String get invalidCode => 'Šis kodas negalioja';

  @override
  String get hotspotHint =>
      'Nėra bendro Wi-Fi? Įjunkite viešosios interneto prieigos tašką viename telefone, prijunkite kitą ir priimkite čia.';

  @override
  String get byMessenger => 'Per žinučių programą';

  @override
  String get byMessengerExplainer =>
      'Siųskite visą katalogą kaip vieną failą per WhatsApp, Signal ar el. paštą — kita pusė jį importuos.';

  @override
  String get shareBundle => 'Bendrinti sinchronizavimo paketą…';

  @override
  String get importBundle => 'Importuoti sinchronizavimo paketą…';

  @override
  String bundleImported(String result) {
    return 'Paketas importuotas: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Paskutinė automatinė atsarginė kopija nepavyko: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Importas nepavyko: $error';
  }

  @override
  String get pickOnMap => 'Pasirinkti žemėlapyje';

  @override
  String get useMyLocation => 'Naudoti mano vietą';

  @override
  String get language => 'Kalba';

  @override
  String get systemDefault => 'Sistemos numatytoji';

  @override
  String get iosLocalNetworkHint =>
      'Jei iPhone/iPad vis nepavyksta: Nustatymai → Privatumas ir sauga → Vietinis tinklas → leisti cat(a)log ir bandyti dar kartą.';

  @override
  String get crashTitle => 'Tai neturėjo nutikti';

  @override
  String get crashBody =>
      'cat(a)log susidūrė su netikėta klaida. Tavo duomenys saugūs — viskas išsaugoma keitimo akimirką. Paleisk programą iš naujo, o jei kartojasi — atsiųsk ataskaitą, kad būtų pataisyta.';

  @override
  String get crashRestart => 'Paleisti programą iš naujo';

  @override
  String get crashSendReport => 'Siųsti ataskaitą kūrėjui';

  @override
  String get crashLastRunBody =>
      'cat(a)log praėjusį kartą netikėtai sustojo — greičiausiai pritrūko atminties. Atsiųsti trumpą ataskaitą, kad būtų pataisyta?';
}
