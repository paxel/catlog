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
  String get noClowdersYet =>
      'Kol kas nėra clowderių. Clowder — tai vieta, kur gyvena katės: tavo laikinieji namai, globėjo butas. Sukurk pirmąjį žemiau.';

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
      'Katė dingsta iš visų sąrašų, o jos nuotraukos pašalinamos — čia ir po kito sinchronizavimo pas tavo pagalbininkus.';

  @override
  String get sightingRecorded => 'Pastebėjimas įrašytas jūsų pozicijoje.';

  @override
  String get noLocationAvailable =>
      'Vietos nėra — vietoj to palaikykite nuspaudę žemėlapį.';

  @override
  String get locationDeniedForever =>
      'Prieiga prie vietos užblokuota. Leiskite ją sistemos nustatymuose, kad galėtumėte naudoti Stray Cam.';

  @override
  String get locationServiceOff =>
      'Šiame įrenginyje vietos nustatymas išjungtas. Įjunkite jį nustatymuose ir bandykite dar kartą.';

  @override
  String get locationDenied =>
      'cat(a)log neturi leidimo naudoti jūsų vietos. Bandykite dar kartą ir leiskite, kai bus paklausta.';

  @override
  String get locationNoFix =>
      'Jūsų padėties dabar nepavyko nustatyti. Bandykite dar kartą lauke — GPS reikia atviro dangaus vaizdo.';

  @override
  String get ok => 'Gerai';

  @override
  String get starterChipId => 'Lusto numeris';

  @override
  String get starterRemarks => 'Pastabos';

  @override
  String get captureFlier => 'Nufotografuoti skelbimą';

  @override
  String get savingLabel => 'Įrašoma…';

  @override
  String ownerOfCat(String name) {
    return '$name šeimininkas';
  }

  @override
  String get sortLabel => 'Rikiuoti';

  @override
  String get matchCandidatesTitle => 'Galimi atitikmenys';

  @override
  String get findDuplicates => 'Rasti dublikatus';

  @override
  String get noDuplicates => 'Šiuo metu galimų dublikatų nėra.';

  @override
  String get similarName => 'Panašus vardas';

  @override
  String get sharePublicly => 'Bendrinti viešai…';

  @override
  String get pickFramesTitle => 'Kadrų pasirinkimas';

  @override
  String get suggestedFrames => 'Siūlomi kadrai';

  @override
  String get scrubFrames => 'Persukti vaizdo įrašą';

  @override
  String get keepThisFrame => 'Palikti šį kadrą';

  @override
  String get fromVideo => 'Iš vaizdo įrašo…';

  @override
  String get videoMobileOnly =>
      'Kadrų rinkimas iš vaizdo įrašo veikia telefono programėlėje (Android ir iPhone) — šiame įrenginyje dar ne.';

  @override
  String get shareWhitelistExplainer =>
      'Katalogą palieka tik pažymėti laukai. Visa kita lieka namie.';

  @override
  String get exportShareFile => 'Eksportuoti bendrinimo failą…';

  @override
  String get hostedLink => 'Talpinama nuoroda (įkelto failo URL)';

  @override
  String get inlineQr => 'Įterptas QR (tik tekstas, be nuotraukų)';

  @override
  String get inlineTooBig =>
      'Per daug duomenų įterptam kodui — nuimkite laukų arba naudokite talpinamą nuorodą.';

  @override
  String get scanShareLabel => 'Skenuoti bendrinimo kodą';

  @override
  String get notAShareCode => 'Šis kodas nėra cat(a)log bendrinimas.';

  @override
  String get importShareTitle => 'Importuoti šią katę?';

  @override
  String shareSource(String url) {
    return 'Šaltinis: $url';
  }

  @override
  String get importLabel => 'Importuoti';

  @override
  String get strayAreaLabel => 'Galima klajojimo zona';

  @override
  String get noMissingCats =>
      'Kol kas nėra dingusių kačių su skelbimų vietomis.';

  @override
  String get noMatchCandidates => 'Šiuo metu galimų atitikmenų nėra.';

  @override
  String sameIdField(String field) {
    return 'Tas pats $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m atstumu';
  }

  @override
  String get addFlier => 'Pridėti skelbimą';

  @override
  String get missingSinceLabel => 'Dingęs nuo';

  @override
  String get phoneLabel => 'Telefonas';

  @override
  String get cropPortrait => 'Apkirpti portretą';

  @override
  String get statusOwner => 'Šeimininkas';

  @override
  String get ocrUnavailable =>
      'Teksto atpažinimas šiame įrenginyje negalimas — įveskite skelbimo tekstą patys.';

  @override
  String get displayFormat => 'Rodoma kaip';

  @override
  String get displayPlain => 'Paprastas tekstas';

  @override
  String get displayQr => 'QR kodas';

  @override
  String get displayBarcode => 'Brūkšninis kodas';

  @override
  String get editLabel => 'Redaguoti';

  @override
  String get doneLabel => 'Atlikta';

  @override
  String get openSettings => 'Atidaryti nustatymus';

  @override
  String get notSaved => 'Neišsaugota';

  @override
  String get birthdateInFuture => 'Gimimo data negali būti ateityje.';

  @override
  String get deceasedInFuture => 'Mirties data negali būti ateityje.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Mirties data negali būti ankstesnė už gimimo datą ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Gimimo data negali būti vėlesnė už mirties datą ($date).';
  }

  @override
  String get malePregnant =>
      'Ši katė užregistruota kaip patinas — patinas negali būti vaikingas. Pirmiausia patikrinkite lytį.';

  @override
  String fatherNotMale(String name) {
    return '$name užregistruota kaip patelė ir negali būti tėvas. Pirmiausia patikrinkite lytį.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name užregistruotas kaip patinas ir negali būti motina. Pirmiausia patikrinkite lytį.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name gimė $date — tėvai negali gimti po savo kačiuko.';
  }

  @override
  String get genderFatherFemale =>
      'Ši katė užregistruota kaip kitų kačių tėvas — tėvas negali būti patelė. Pirmiausia patikrinkite šeimą.';

  @override
  String get genderMotherMale =>
      'Ši katė užregistruota kaip kitų kačių motina — motina negali būti patinas. Pirmiausia patikrinkite šeimą.';

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
  String get starterPosition => 'Vieta';

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
  String get markPrivate => 'Pažymėti kaip privatų';

  @override
  String get unmarkPrivate => 'Pašalinti privatumo žymą';

  @override
  String get includePrivate => 'Įtraukti privačius duomenis';

  @override
  String get includePrivateExplainer =>
      'Privačios katės, grupės ir laukai taip pat bendrinami — įjunkite tik sinchronizuodami savo įrenginius.';

  @override
  String get hideLabel => 'Slėpti šiame įrenginyje';

  @override
  String get unhideLabel => 'Rodyti vėl';

  @override
  String get showHiddenLabel => 'Rodyti paslėptus';

  @override
  String get stopShowingHidden => 'Nustoti rodyti paslėptus';

  @override
  String get starterSpecies => 'Rūšis';

  @override
  String get starterStatus => 'Tipas';

  @override
  String get statusFoster => 'Laikinieji namai';

  @override
  String get statusForeverHome => 'Nuolatiniai namai';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Prieglauda';

  @override
  String get statusBarn => 'Daržinė';

  @override
  String get valueCat => 'Katė';

  @override
  String get otherOption => 'Kita…';

  @override
  String get celebrationsToggle => 'Švęsti priglaudimus';

  @override
  String get celebrationsSubtitle =>
      'Konfeti ir šūksniai, kai katė persikelia į nuolatinius namus';

  @override
  String get onMapLabel => 'Žemėlapyje';

  @override
  String get showOnMap => 'Rodyti žemėlapyje';

  @override
  String get searchPlaceHint => 'Ieškoti vietos ar adreso';

  @override
  String get noPlacesFound => 'Vietų nerasta';

  @override
  String get mapSearchHint => 'Ieškoti kačių, grupių, žmonių';

  @override
  String get proposeAnotherName => 'Pasiūlyti kitą vardą';

  @override
  String get moderationTitle => 'Autoriai ir draudimai';

  @override
  String get moderationSubtitle => 'Visam laikui pašalinti asmens duomenis';

  @override
  String get authorsSection => 'Kas rašė į šį katalogą';

  @override
  String get hardDeleteAction => 'Ištrinti viską iš šio autoriaus';

  @override
  String hardDeleteWarning(Object name) {
    return 'Pašalina visus $name įrašus ir nuotraukas iš šio įrenginio. Kiti įrenginiai pasilieka savo. Neatšaukiama.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Patvirtinimui įveskite $name';
  }

  @override
  String get alsoBan =>
      'Taip pat uždrausti — daugiau niekada nepriimti duomenų';

  @override
  String get bansSection => 'Draudimai';

  @override
  String get unbanAction => 'Pašalinti draudimą';

  @override
  String get deletedDone => 'Ištrinta.';

  @override
  String get syncSummaryTitle => 'Kas atkeliavo';

  @override
  String get summaryAdopted => 'Priglausti';

  @override
  String get summaryDeceased => 'Nugaišę';

  @override
  String get summaryEscaped => 'Pabėgę';

  @override
  String get summaryNew => 'Nauji';

  @override
  String get summaryConflicts => 'Spręstini konfliktai';

  @override
  String summaryOther(Object n) {
    return '…ir dar $n pakeitimų';
  }

  @override
  String get starterMother => 'Motina';

  @override
  String get starterFather => 'Tėvas';

  @override
  String get familySection => 'Šeima';

  @override
  String get littermatesLabel => 'Iš tos pačios vados';

  @override
  String get siblingsLabel => 'Broliai ir seserys';

  @override
  String get kittensLabel => 'Kačiukai';

  @override
  String get toastSettingsTitle => 'Ką pranešti';

  @override
  String get toastSettingsSubtitle => 'Maži pranešimai po sinchronizavimo';

  @override
  String get toastKindAdoptions => 'Priglaudimai';

  @override
  String get toastKindBirths => 'Gimimai';

  @override
  String get toastKindDeaths => 'Mirtys';

  @override
  String get toastKindEscapes => 'Pabėgimai';

  @override
  String get toastKindMoves => 'Persikėlimai';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat priglaudė $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Naujas kačiukas: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat nugaišo';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat pabėgo';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat persikėlė į $home';
  }

  @override
  String get notACatlogFile => 'Tai ne cat(a)log failas';

  @override
  String get nothingNewInBundle => 'Faile nieko naujo — viską jau turite';

  @override
  String get syncChooserInPerson => 'Gyvai';

  @override
  String get syncChooserInPersonSub =>
      'Esate tame pačiame kambaryje — nuskenuok kodą, baigta per sekundes';

  @override
  String get syncChooserRemote => 'Nuotoliniu būdu';

  @override
  String get syncChooserRemoteSub =>
      'Per bendrinamą aplanką, pvz., Dropbox ar USB atmintinę';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Siųsk viską kaip vieną failą bet kuria programėle';

  @override
  String get connectToWifiFirst =>
      'Pirmiausia prisijunk prie Wi-Fi — tada įrenginiai susiras';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) nori sinchronizuoti';
  }

  @override
  String get trustBothWaysNote => 'Katalogai bus apsikeisti abiem kryptimis.';

  @override
  String get allowOnce => 'Leisti';

  @override
  String get allowAlways => 'Visada leisti šį įrenginį';

  @override
  String get declineAction => 'Atmesti';

  @override
  String get syncDeclined => 'Kitas įrenginys atmetė sinchronizavimą';

  @override
  String get trustedDevicesSection => 'Visada leidžiami įrenginiai';

  @override
  String get removeTrust => 'Pašalinti';

  @override
  String get hostWithoutWifi => 'Prieglobstis be Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Sukuria laikiną tiesioginį ryšį su kitu telefonu (be interneto). Jį naudoja tik cat(a)log ir po sinchronizavimo jis atsijungia pats.';

  @override
  String get hotspotAndroidOnly =>
      'Šiam kodui reikia dviejų Android telefonų — iPhone/iPad naudokite bendrą Wi-Fi';

  @override
  String get selectClowderHint => 'Kairėje pasirinkite clowder';

  @override
  String get introTitle1 => 'Katės gyvena clowderiuose';

  @override
  String get introBody1 =>
      'Clowder — tai vieta, kur gyvena katės: tavo laikinieji namai, globėjo butas, kaimyno daržinė. Kiekviena katė turi kortelę su nuotrauka, faktais ir visa istorija.';

  @override
  String get introTitle2 => 'Viskas lieka pas tave';

  @override
  String get introBody2 =>
      'Jokios paskyros, jokio debesies, jokio sekimo. Tavo duomenys gyvena tavo įrenginyje.';

  @override
  String get introTitle3 => 'Dalinkis su pagalbininkais';

  @override
  String get introBody3 =>
      'Nuskenuok kodą ir du įrenginiai susinchronizuojami per sekundes, naudok bendrą aplanką arba siųsk viską vienu failu.';

  @override
  String get introSkip => 'Praleisti';

  @override
  String get introNext => 'Toliau';

  @override
  String get introDone => 'Pirmyn';

  @override
  String get introReplayTitle => 'Greita pažintis';

  @override
  String get spotHomeSync =>
      'Nauja: sinchronizavimas dabar siūlo tris aiškius kelius — ir pasitikėjimo klausimą prieš kam nors keliaujant.';

  @override
  String get spotHomeStrays =>
      'Nauja: benamiai turi savo kortelę čia viršuje — skaičius, snukučiai, palieskite atidaryti.';

  @override
  String get spotHomeMenu =>
      'Nauja: šis meniu randa besidubliuojančias kates bei kolonijas ir jas sujungia.';

  @override
  String get spotCatEdit =>
      'Nauja: puslapis tik skaitymui — pieštukas įjungia redagavimą, ilgas lauko paspaudimas redaguoja jį tiesiogiai.';

  @override
  String get spotMapLayers =>
      'Nauja: rodykite 500 m paieškos apskritimus aplink dingusios katės skelbimų vietas.';

  @override
  String get spotStraysFlier =>
      'Nauja: nufotografuokite dingusios katės skelbimą — jis virsta kate, šeimininku ir kontaktu.';

  @override
  String get spotStraysScan =>
      'Nauja: nuskaitykite cat(a)log kodą nuo skelbimo ir importuokite katę tiesiogiai.';

  @override
  String get introTitle4 => 'Dingusios katės';

  @override
  String get introBody4 =>
      'Nufotografuokite skelbimą — dingusi katė pateks į katalogą su šeimininko kontaktu. Pastebėjimai, paieškos apskritimai ir atitikmenų pasiūlymai padeda jai grįžti namo.';

  @override
  String get spotMapSearch =>
      'Nauja: ieškok čia kačių, clowderių ir žmonių — tiesiai žemėlapyje.';

  @override
  String get spotCardChips =>
      'Nauja: prieš dalindamasis pasirink, kas bus kortelėje.';

  @override
  String get spotCatMenu =>
      'Nauja: pažymėk katę kaip privačią (niekada nepalieka įrenginio) arba paslėpk ją čia.';

  @override
  String get spotDone => 'Supratau';

  @override
  String get spotReplayTitle => 'Naujienų turas';

  @override
  String get spotReplaySubtitle => 'Vėl rodyti patarimus kiekviename puslapyje';

  @override
  String get spotReplayDone => 'Patarimai bus rodomi vėl';

  @override
  String get searchNoResults => 'Katės tokiu vardu nerasta';

  @override
  String get syncUnreachable =>
      'Nepavyko pasiekti kito įrenginio. Ar abu tame pačiame Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Nepavyko pasiekti aplanko. Ar diskas arba debesies aplankas dar yra?';

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
