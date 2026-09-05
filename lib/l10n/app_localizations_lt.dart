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
  String get clowdersNeutral => 'Namų ūkiai';

  @override
  String get noClowdersYet =>
      'Kol kas nėra clowderių. Clowder — tai vieta, kur gyvena katės: tavo laikinieji namai, globėjo butas. Sukurk pirmąjį žemiau.';

  @override
  String get noClowdersYetNeutral =>
      'Kol kas nėra namų ūkių. Namų ūkis — tai vieta, kur gyvena augintiniai: tavo namai, laikinieji namai, globėjo butas. Sukurk pirmąjį žemiau.';

  @override
  String get strays => 'Benamės katės';

  @override
  String get searchCats => 'Ieškoti kačių';

  @override
  String get searchCatsNeutral => 'Ieškoti augintinių';

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
  String get settings => 'Nustatymai';

  @override
  String get newClowder => 'Naujas klauderis';

  @override
  String get newClowderNeutral => 'Naujas namų ūkis';

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
  String get renameClowderNeutral => 'Pervadinti namų ūkį';

  @override
  String get rename => 'Pervadinti';

  @override
  String get timeline => 'Laiko juosta';

  @override
  String get mergeInto => 'Sujungti su…';

  @override
  String get deleteClowder => 'Ištrinti klauderį';

  @override
  String get deleteClowderNeutral => 'Ištrinti namų ūkį';

  @override
  String get cats => 'Katės';

  @override
  String get catsNeutral => 'Augintiniai';

  @override
  String get addCat => 'Pridėti katę';

  @override
  String get addCatNeutral => 'Pridėti augintinį';

  @override
  String get newCat => 'Nauja katė';

  @override
  String get newCatNeutral => 'Naujas augintinis';

  @override
  String deleteQuestion(String name) {
    return 'Ištrinti $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Klauderis dingsta iš sąrašo.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Namų ūkis dingsta iš sąrašo.';

  @override
  String deleteClowderBody(int count) {
    return 'Jo katės ($count) neištrinamos — jos tampa benamėmis. Jei to nenorite, pirma perkelkite jas į kitą klauderį.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Jo augintiniai ($count) neištrinami — jie tampa benamiais. Jei to nenorite, pirma perkelkite juos į kitą namų ūkį.';
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
  String get renameCatNeutral => 'Pervadinti augintinį';

  @override
  String get seenHereNow => 'Ką tik matyta čia';

  @override
  String get deleteCat => 'Ištrinti katę';

  @override
  String get deleteCatNeutral => 'Ištrinti augintinį';

  @override
  String get clowderLabel => 'Klauderis';

  @override
  String get clowderLabelNeutral => 'Namų ūkis';

  @override
  String get strayNoClowder => 'Benamė — be klauderio';

  @override
  String get strayNoClowderNeutral => 'Benamis — be namų ūkio';

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
      'Katė dingsta iš visų sąrašų, jos nuotraukos pašalinamos — čia ir, po kito sinchronizavimo, kituose įrenginiuose.';

  @override
  String get deleteCatBodyNeutral =>
      'Augintinis dingsta iš visų sąrašų, jo nuotraukos pašalinamos — čia ir, po kito sinchronizavimo, kituose įrenginiuose.';

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
  String get addPhotosTo => 'Pridėti nuotraukas prie…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count nuotr. pridėta prie $name';
  }

  @override
  String get scanPrintedCode => 'Skenuoti atspausdintą kodą';

  @override
  String get chipScanHint =>
      'Nuskaito atspausdintą QR/brūkšninį kodą iš lusto kortelės ar veterinaro dokumentų — katėje esančio lusto telefonas nuskaityti negali.';

  @override
  String get chipScanHintNeutral =>
      'Nuskaito atspausdintą QR/brūkšninį kodą iš lusto kortelės ar veterinaro dokumentų — gyvūne esančio lusto telefonas nuskaityti negali.';

  @override
  String get savingLabel => 'Įrašoma…';

  @override
  String ownerOfCat(String name) {
    return '$name šeimininkas';
  }

  @override
  String get sortLabel => 'Rikiuoti';

  @override
  String get viewAsTable => 'Rodyti lentele';

  @override
  String get viewAsTiles => 'Rodyti plytelėmis';

  @override
  String get viewAsList => 'Rodyti kaip sąrašą';

  @override
  String get ageLabel => 'Amžius';

  @override
  String get catList => 'Kačių sąrašas';

  @override
  String get catListNeutral => 'Augintinių sąrašas';

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
  String addingPhotos(int done, int total) {
    return 'Pridedama nuotrauka $done iš $total…';
  }

  @override
  String get videoMobileOnly =>
      'Kadrų rinkimas iš vaizdo įrašo veikia telefono programėlėje (Android ir iPhone) — šiame įrenginyje dar ne.';

  @override
  String get shareWhitelistExplainer =>
      'Pasirinkite, kas pateks į failą. Įtraukiami tik pažymėti laukai.';

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
  String get importShareTitleNeutral => 'Importuoti šį augintinį?';

  @override
  String shareSource(String url) {
    return 'Šaltinis: $url';
  }

  @override
  String get importLabel => 'Importuoti';

  @override
  String get strayAreaLabel => 'Galima klajojimo zona';

  @override
  String get prevPin => 'Ankstesnis smeigtukas';

  @override
  String get nextPin => 'Kitas smeigtukas';

  @override
  String get noMissingCats =>
      'Kol kas nėra dingusių kačių su skelbimų vietomis.';

  @override
  String get noMissingCatsNeutral =>
      'Kol kas nėra dingusių augintinių su skelbimų vietomis.';

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
  String get malePregnantNeutral =>
      'Šis augintinis užregistruotas kaip patinas — patinas negali būti vaikingas. Pirmiausia patikrinkite lytį.';

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
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name gimė $date — tėvai negali gimti po savo jauniklio.';
  }

  @override
  String get genderFatherFemale =>
      'Ši katė užregistruota kaip kitų kačių tėvas — tėvas negali būti patelė. Pirmiausia patikrinkite šeimą.';

  @override
  String get genderFatherFemaleNeutral =>
      'Šis augintinis užregistruotas kaip kitų augintinių tėvas — tėvas negali būti patelė. Pirmiausia patikrinkite šeimą.';

  @override
  String get genderMotherMale =>
      'Ši katė užregistruota kaip kitų kačių motina — motina negali būti patinas. Pirmiausia patikrinkite šeimą.';

  @override
  String get genderMotherMaleNeutral =>
      'Šis augintinis užregistruotas kaip kitų augintinių motina — motina negali būti patinas. Pirmiausia patikrinkite šeimą.';

  @override
  String get moveTo => 'Perkelti į';

  @override
  String get noClowderStrayOption => 'Be klauderio — benamė / pabėgo';

  @override
  String get noClowderStrayOptionNeutral => 'Be namų ūkio — benamis / pabėgo';

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
  String get dateInFuture => 'Ši data negali būti ateityje.';

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
  String get forCatsNeutral => 'augintiniams';

  @override
  String get forClowders => 'klauderiams';

  @override
  String get forClowdersNeutral => 'namų ūkiams';

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
  String get searchByNameHintNeutral => 'Ieškoti augintinių pagal vardą…';

  @override
  String get host => 'Priimti';

  @override
  String get hostExplainer =>
      'Pradėkite čia, tada kitame įrenginyje nuskaitykite kodą arba jį įveskite.';

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
      'Abu įrenginiai naudoja tą patį aplanką (pvz., „Dropbox“ ar USB rakte). Kiekvienas sinchronizavimas ten palieka jūsų pakeitimus ir paima kitos pusės.';

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
  String trailOfField(String name, String field, int count) {
    return 'Kelias: $name — $field ($count reikšm.)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Kelias: $name ($count pozic.)';
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
  String get kindCatNeutral => 'augintinis';

  @override
  String get kindClowder => 'klauderis';

  @override
  String get kindClowderNeutral => 'namų ūkis';

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
  String get aboutTaglineNeutral =>
      'Vietinis augintinių, kuriais rūpiniesi, katalogas. Jūsų duomenys lieka jūsų įrenginiuose — be serverio, be paskyros.';

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
  String get coffeeSubtitle =>
      'Programa lieka nemokama. Net jei kavos negausiu :)';

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
  String get starterEmail => 'El. paštas';

  @override
  String get starterPhone => 'Telefonas';

  @override
  String get lookupUrlLabel => 'Paieškos nuoroda';

  @override
  String lookupUrlHelp(String token) {
    return 'Paslaugos puslapis su $token vietoj numerio, pvz. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Ieškoti';

  @override
  String lookupFailed(String url) {
    return 'Nė viena programa negalėjo atverti $url. Nukopijuokite nuorodą į naršyklę.';
  }

  @override
  String get stepCat => 'Katė';

  @override
  String get stepCatNeutral => 'Augintinis';

  @override
  String get stepOwner => 'Savininkas';

  @override
  String get stepFace => 'Snukučio nuotrauka';

  @override
  String get stepRegistry => 'Registras';

  @override
  String get stepReview => 'Patikrinti ir išsaugoti';

  @override
  String get stepOwnerHint =>
      'Tas, kas pasigedo katės — iš to atsiras jo klauderis su kontaktu iš skelbimo.';

  @override
  String get stepOwnerHintNeutral =>
      'Tas, kas pasigedo augintinio — iš to atsiras jo namų ūkis su kontaktu iš skelbimo.';

  @override
  String get stepFaceHint =>
      'Iškirpk katės snukutį iš skelbimo; jis taps profilio nuotrauka. Gali ir praleisti.';

  @override
  String get stepFaceHintNeutral =>
      'Iškirpk augintinio snukutį iš skelbimo; jis taps profilio nuotrauka. Gali ir praleisti.';

  @override
  String get stepRegistryHint =>
      'Skelbime rasti numeriai. Pažymėti bus išsaugoti prie katės ir vėliau atidaromi.';

  @override
  String get stepRegistryHintNeutral =>
      'Skelbime rasti numeriai. Pažymėti bus išsaugoti prie augintinio ir vėliau atidaromi.';

  @override
  String get noRegistryLinks =>
      'Šiame skelbime registrų nuorodų nėra — jei kurios praleistos, praneškite apie klaidą.';

  @override
  String get unknownServiceHint => 'Nežinoma paslauga';

  @override
  String get rememberService => 'Įsiminti paslaugą';

  @override
  String get rememberServiceHint =>
      'Pavadink paslaugą ir parodyk numerį nuorodoje. Kitas skelbimas užsipildys pats.';

  @override
  String get noIdInLink =>
      'Šioje nuorodoje nėra numerio, kurį programėlė galėtų išsaugoti.';

  @override
  String get whichNumber => 'Kuri dalis yra numeris?';

  @override
  String get cropAgain => 'Kirpti iš naujo';

  @override
  String get noFaceYet =>
      'Snukučio nuotraukos dar nėra — naudojama skelbimo nuotrauka.';

  @override
  String get backLabel => 'Atgal';

  @override
  String get dangerButton => 'NESPAUSTI.\nPAVOJINGA';

  @override
  String get dangerThanks => 'Ačiū, kad naudojatės cat(a)log!';

  @override
  String get helpTitle => 'Pagalba';

  @override
  String get showTipsAgain => 'Rodyti patarimus dar kartą';

  @override
  String get helpHome =>
      'Tavo kolonijų apžvalga — kolonija yra vieta, kur gyvena katės: tavo namai, laikini globos namai, prieglauda. Palieskite kortelę, kad pamatytumėte jos kates; ilgas paspaudimas atveria meniu. Mygtukas apačioje dešinėje sukuria koloniją, o valkataujančių kortelė surenka visas kates be namų. Pavadinimas viršuje – katalogas, kuriame esi; bakstelėk, kad perjungtum ar pridėtum.';

  @override
  String get helpHomeNeutral =>
      'Tavo namų ūkių apžvalga — namų ūkis yra vieta, kur gyvena augintiniai: tavo namai, laikini globos namai, prieglauda. Palieskite kortelę, kad pamatytumėte jo augintinius; ilgas paspaudimas atveria meniu. Mygtukas apačioje dešinėje sukuria namų ūkį, o valkataujančių kortelė surenka visus augintinius be namų. Pavadinimas viršuje – katalogas, kuriame esi; bakstelėk, kad perjungtum ar pridėtum.';

  @override
  String get helpClowder =>
      'Viskas apie šią vietą: jos katės, laukai (adresas, kontaktas, tipas) ir istorija. Puslapis atsidaro tik skaitymui; pieštukas įjungia redagavimą, ten galima pridėti ir naują lauką. Ilgai palaikius lauką jis redaguojamas iškart, katę — perkeliama, paslepiama arba atveriama. Čia pridėtas vizitas gali pasiimti kelias kolonijos kates, pavyzdžiui, sterilizacijai: pažymėkite vykstančias kates, užbaikite vieną kartą, nuimkite žymą nuo negydytų. Laikrodis prie lauko atveria jo istoriją.';

  @override
  String get helpClowderNeutral =>
      'Viskas apie šią vietą: jos augintiniai, laukai (adresas, kontaktas, tipas) ir istorija. Puslapis atsidaro tik skaitymui; pieštukas įjungia redagavimą, ten galima pridėti ir naują lauką. Ilgai palaikius lauką jis redaguojamas iškart, augintinį — perkeliamas, paslepiamas arba atveriamas. Čia pridėtas vizitas gali pasiimti kelis namų ūkio augintinius, pavyzdžiui, sterilizacijai: pažymėkite vykstančius augintinius, užbaikite vieną kartą, nuimkite žymą nuo negydytų. Laikrodis prie lauko atveria jo istoriją.';

  @override
  String get helpCat =>
      'Viskas apie šią katę: nuotraukos, laukai, šeima, istorija. Puslapis tik skaitomas, kol paliesi pieštuką. Ilgai palaikyk lauką, kad iškart jį redaguotum; ilgai palaikyk nuotrauką jos meniu. Meniu viršuje dešinėje laiko likusius: paslėpti, sujungti, užfiksuoti pastebėjimą, bendrinti katę. „Privatu“ nustatoma redaguojant lauką. Laikrodis prie lauko atveria jo istoriją.';

  @override
  String get helpCatNeutral =>
      'Viskas apie šį augintinį: nuotraukos, laukai, šeima, istorija. Puslapis tik skaitomas, kol paliesi pieštuką. Ilgai palaikyk lauką, kad iškart jį redaguotum; ilgai palaikyk nuotrauką jos meniu. Meniu viršuje dešinėje laiko likusius: paslėpti, sujungti, užfiksuoti pastebėjimą, bendrinti augintinį. „Privatu“ nustatoma redaguojant lauką. Laikrodis prie lauko atveria jo istoriją.';

  @override
  String get helpStrays =>
      'Katės, kurios dabar neturi namų: rastos, pabėgusios arba iš skelbimo. Kameros mygtukas įrašo katę priešais jus; skelbimo mygtukas paverčia dingusios katės skelbimą kate su savininko kontaktu; skaitytuvas nuskaito cat(a)log kodą nuo skelbimo. Palieskite „Stray Cam“ nuotraukai; palaikykite, kad nufilmuotumėte vaizdo įrašą ir geriausius kadrus išsaugotumėte kaip nuotraukas.';

  @override
  String get helpStraysNeutral =>
      'Augintiniai, kurie dabar neturi namų: rasti, pabėgę arba iš skelbimo. Kameros mygtukas įrašo gyvūną priešais jus; skelbimo mygtukas paverčia dingusio augintinio skelbimą augintiniu su savininko kontaktu; skaitytuvas nuskaito cat(a)log kodą nuo skelbimo. Palieskite „Stray Cam“ nuotraukai; palaikykite, kad nufilmuotumėte vaizdo įrašą ir geriausius kadrus išsaugotumėte kaip nuotraukas.';

  @override
  String get helpMap =>
      'Visos katės ir vietos, turinčios poziciją. Paieška randa kates, žmones ir vietoves — nežinomas pavadinimas ieškomas visame pasaulyje. Sluoksnių mygtukas nubrėžia 500 m apskritimus aplink dingusios katės skelbimų vietas ir aplink namus, iš kurių ji pabėgo. Rodyklės eina nuo smeigtuko prie smeigtuko, ilgas paspaudimas žemėlapyje įrašo pastebėjimą. Kiekvienas vietos laukas žemėlapyje yra smeigtukas; bakstelėkite smeigtuką, kad matytumėte jo kelią.';

  @override
  String get helpMapNeutral =>
      'Visi augintiniai ir vietos, turinčios poziciją. Paieška randa augintinius, žmones ir vietoves — nežinomas pavadinimas ieškomas visame pasaulyje. Sluoksnių mygtukas nubrėžia 500 m apskritimus aplink dingusio augintinio skelbimų vietas ir aplink namus, iš kurių jis pabėgo. Rodyklės eina nuo smeigtuko prie smeigtuko, ilgas paspaudimas žemėlapyje įrašo pastebėjimą. Kiekvienas vietos laukas žemėlapyje yra smeigtukas; bakstelėkite smeigtuką, kad matytumėte jo kelią.';

  @override
  String get helpCard =>
      'Spausdinama katės kortelė: viršuje ženkleliais pasirenkate, kas joje bus, tada dalinatės kaip paveikslėliu ar PDF. Numeriai gali būti spausdinami kaip QR arba brūkšninis kodas, o pozicija tampa QR, atveriančiu žemėlapį, ir trumpu Plus Code.';

  @override
  String get helpCardNeutral =>
      'Spausdinama augintinio kortelė: viršuje ženkleliais pasirenkate, kas joje bus, tada dalinatės kaip paveikslėliu ar PDF. Numeriai gali būti spausdinami kaip QR arba brūkšninis kodas, o pozicija tampa QR, atveriančiu žemėlapį, ir trumpu Plus Code.';

  @override
  String get helpSync =>
      'Kaip duomenys pasiekia kitus: prisijunkite tiesiogiai, naudokite aplanką, kurį mato abu įrenginiai, arba siųskite failą per žinutes. Visada jūs sprendžiate, kas išeina — gauti .catsync failai taip pat atveriami čia.';

  @override
  String get helpFields =>
      'Laukai, kuriuos naudoja jūsų katalogas. Pervadinkite juos, pakeiskite pasirinkimo lauko parinktis arba sukurkite savo. Identifikatoriaus laukas gali nurodyti paslaugą (registrą) — tada numerį prie katės galima paliesti.';

  @override
  String get helpFieldsNeutral =>
      'Laukai, kuriuos naudoja jūsų katalogas. Pervadinkite juos, pakeiskite pasirinkimo lauko parinktis arba sukurkite savo. Identifikatoriaus laukas gali nurodyti paslaugą (registrą) — tada numerį prie augintinio galima paliesti.';

  @override
  String get helpTimeline =>
      'Kiekvienas kada nors atliktas pakeitimas, naujausi viršuje: kas, kada ir į kokią reikšmę ką pakeitė. Bet kurį įrašą galima atšaukti — tai sukuria naują įrašą, niekas niekada nedingsta.';

  @override
  String get helpDuplicates =>
      'Katės ar kolonijos, kurios atrodo esančios du kartus — vienodi numeriai arba labai panašūs vardai su sutampančiomis detalėmis. Palieskite porą, kad sujungtumėte; sujungimo atšaukti negalima, todėl pirma paklausiama.';

  @override
  String get helpDuplicatesNeutral =>
      'Augintiniai ar namų ūkiai, kurie atrodo esantys du kartus — vienodi numeriai arba labai panašūs vardai su sutampančiomis detalėmis. Palieskite porą, kad sujungtumėte; sujungimo atšaukti negalima, todėl pirma paklausiama.';

  @override
  String get helpMatches =>
      'Katės, kurios gali būti tas pats gyvūnas: tas pats numeris arba valkataujanti katė, pastebėta dingusios katės paieškos zonoje. Palieskite porą sujungimui, ilgai palaikę atversite pirmą katę palyginimui.';

  @override
  String get helpMatchesNeutral =>
      'Augintiniai, kurie gali būti tas pats gyvūnas: tas pats numeris arba valkataujantis gyvūnas, pastebėtas dingusio augintinio paieškos zonoje. Palieskite porą sujungimui, ilgai palaikę atversite pirmą augintinį palyginimui.';

  @override
  String get helpFlier =>
      'Nufotografuotas skelbimas virsta kate ir jos savininku. Žingsnis po žingsnio: katės duomenys, savininko kontaktas, snukučio iškirpimas profilio nuotraukai, registrų numeriai iš skelbimo ir galiausiai patikra. Visa tai pasiūlymai — pataisykite, ką kamera perskaitė ne taip.';

  @override
  String get helpFlierNeutral =>
      'Nufotografuotas skelbimas virsta augintiniu ir jo savininku. Žingsnis po žingsnio: augintinio duomenys, savininko kontaktas, snukučio iškirpimas profilio nuotraukai, registrų numeriai iš skelbimo ir galiausiai patikra. Visa tai pasiūlymai — pataisykite, ką kamera perskaitė ne taip.';

  @override
  String get archiveTitle => 'Archyvas';

  @override
  String get archiveExplainer =>
      'Nugaišusios katės ir tuščios kolonijos, kurių niekas nelietė metų metus, vis tiek užima vietą — ypač jų nuotraukos. Archyvavimas įrašo jas į failą, kurį pasiliekate, ir tada ištrina iš čia.';

  @override
  String get archiveExplainerNeutral =>
      'Nugaišę augintiniai ir tušti namų ūkiai, kurių niekas nelietė metų metus, vis tiek užima vietą — ypač jų nuotraukos. Archyvavimas įrašo juos į failą, kurį pasiliekate, ir tada ištrina iš čia.';

  @override
  String get archiveAction => 'Archyvuoti';

  @override
  String archiveSelected(int count) {
    return 'Archyvuoti $count įrašų';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archyvuoti $count įrašų?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names bus įrašyti į failą ir tada ištrinti — jūsų įrenginyje ir kiekviename, su kuriuo sinchronizuojate. Failo importas viską grąžina; be jo jie prarasti.';
  }

  @override
  String archiveDone(int count) {
    return 'Archyvuota ir ištrinta įrašų: $count';
  }

  @override
  String archiveFailed(String error) {
    return 'Nieko neištrinta: nepavyko įrašyti archyvo failo ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Duomenų bazė $db, nuotraukos $photos $count failuose';
  }

  @override
  String quietForYears(int years) {
    return 'Nekeista $years metus';
  }

  @override
  String get nothingToArchive => 'Nėra nieko pakankamai seno archyvuoti.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Paskutinis pakeitimas $date · nuotraukos $size';
  }

  @override
  String get helpArchive =>
      'Seni duomenys kainuoja vietos, ypač nuotraukos, kurias tempia kiekvienas sinchronizuotas įrenginys. Čia pasirenkate metų metus nejudėjusias nugaišusias kates ir tuščias kolonijas, įrašote jas į failą, kurį pasiliekate, ir ištrinate. Ištrynimas pasiekia visus, su kuriais sinchronizuojate; failo importas viską atkuria.';

  @override
  String get helpArchiveNeutral =>
      'Seni duomenys kainuoja vietos, ypač nuotraukos, kurias tempia kiekvienas sinchronizuotas įrenginys. Čia pasirenkate metų metus nejudėjusius nugaišusius augintinius ir tuščius namų ūkius, įrašote juos į failą, kurį pasiliekate, ir ištrinate. Ištrynimas pasiekia visus, su kuriais sinchronizuojate; failo importas viską atkuria.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Atkurti $count ištrintų įrašų?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names šiame kataloge ištrinti, o ką tik importuotas failas juos turi. Atkūrimas grąžins juos čia ir į kiekvieną įrenginį, su kuriuo sinchronizuojate.';
  }

  @override
  String get restoreAction => 'Atkurti';

  @override
  String get keepDeleted => 'Palikti ištrintus';

  @override
  String get archiveNotSaved =>
      'Nieko neištrinta: archyvas niekur neišsaugotas.';

  @override
  String get locateAddress => 'Rasti adresą žemėlapyje';

  @override
  String get addressFoundTitle => 'Adresas rastas';

  @override
  String get replaceAddressOption => 'Pakeisti adresą šiuo';

  @override
  String get addPositionOption => 'Išsaugoti vietą';

  @override
  String get addressLocated => 'Adresas rastas';

  @override
  String get addressNotFound =>
      'Šiam adresui vietos nerasta. Patikrink rašybą arba palik tuščią.';

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
  String get markTitleNeutral => 'Pažymėti augintinį';

  @override
  String get applyCrop => 'Apkirpti';

  @override
  String get useFullPhoto => 'Naudoti visą nuotrauką';

  @override
  String get dragToSelect => 'Vilkite stačiakampį aplink katę';

  @override
  String get dragToSelectNeutral => 'Vilkite stačiakampį aplink augintinį';

  @override
  String get dragOverTheCat => 'Vilkite elipsę virš katės';

  @override
  String get dragOverTheCatNeutral => 'Vilkite elipsę virš augintinio';

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
  String get typeUnitValue => 'Reikšmė su vienetu';

  @override
  String get dimension => 'Dydis';

  @override
  String get dimensionWeight => 'Svoris';

  @override
  String get dimensionLength => 'Ilgis';

  @override
  String get dimensionVolume => 'Tūris';

  @override
  String get dimensionTemperature => 'Temperatūra';

  @override
  String get unitsLabel => 'Vienetai';

  @override
  String get catalogHolds => 'Šiame kataloge';

  @override
  String get modeCats => 'Katės';

  @override
  String get modePets => 'Augintiniai';

  @override
  String get graphLabel => 'Grafikas';

  @override
  String get fieldHistoryTooltip => 'Istorija';

  @override
  String get rangeWeek => 'Savaitė';

  @override
  String get rangeMonth => 'Mėnuo';

  @override
  String get rangeYear => 'Metai';

  @override
  String get rangeAll => 'Viskas';

  @override
  String get rangeCustom => 'Pasirinktinis…';

  @override
  String changeSince(String delta, String date) {
    return '$delta nuo $date';
  }

  @override
  String get unitsAuto => 'Kaip jūsų regione';

  @override
  String get unitsMetric => 'Metrinė (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperinė (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Svoris';

  @override
  String get systemDefault => 'Sistemos numatytoji';

  @override
  String get iosLocalNetworkHint =>
      'Jei iPhone/iPad vis nepavyksta: Nustatymai → Privatumas ir sauga → Vietinis tinklas → leisti cat(a)log ir bandyti dar kartą.';

  @override
  String get includePrivate => 'Bendrinti privačius duomenis';

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
  String get statusForeverHome => 'Namai';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Prieglauda';

  @override
  String get statusBarn => 'Daržinė';

  @override
  String get valueCat => 'Katė';

  @override
  String get valueDog => 'Šuo';

  @override
  String get valueRabbit => 'Triušis';

  @override
  String get valueGuineaPig => 'Jūrų kiaulytė';

  @override
  String get valueHamster => 'Žiurkėnas';

  @override
  String get valueBird => 'Paukštis';

  @override
  String get valueHorse => 'Arklys';

  @override
  String get valueTortoise => 'Vėžlys';

  @override
  String get valueFerret => 'Šeškas';

  @override
  String get otherOption => 'Kita…';

  @override
  String get celebrationsToggle => 'Švęsti priglaudimus';

  @override
  String get celebrationsSubtitle =>
      'Konfeti ir šūksniai, kai katė persikelia į namus';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfeti ir šūksniai, kai augintinis persikelia į namus';

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
  String get mapSearchHintNeutral => 'Ieškoti augintinių, namų ūkių, žmonių';

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
  String conflictsMenu(int n) {
    return 'Konfliktai ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Čia išsprendėte konfliktą, todėl „Atmesti“ nebegalima: tai atšauktų ir jį.';

  @override
  String get arrivalIntro =>
      'Šie pakeitimai jau jūsų kataloge. „Atmesti“ grąžina jį į buvusią būseną.';

  @override
  String get summaryUpdated => 'Atnaujinta';

  @override
  String get summaryDeleted => 'Ištrinta';

  @override
  String get keepMine => 'Palikti mano';

  @override
  String keptMine(String name) {
    return 'Jūsų „$name“ versija liko šiame įrenginyje.';
  }

  @override
  String get summaryMeta => 'Taip pat atkeliavo';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pakeitimų',
      few: '$n pakeitimai',
      one: '$n pakeitimas',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Priimti';

  @override
  String get rejectArrival => 'Atmesti';

  @override
  String get photoAdded => 'Pridėta nuotrauka';

  @override
  String get photoRemoved => 'Nuotrauka pašalinta';

  @override
  String metaFieldAdded(String name) {
    return 'Naujas laukas: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Laukas pakeistas: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser sujungta su $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nuotraukų',
      few: '$n nuotraukos',
      one: '$n nuotrauka',
    );
    return '$_temp0';
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
  String get kittensLabelNeutral => 'Jaunikliai';

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
  String toastBornNeutral(Object cat) {
    return '✨ Naujagimis: $cat ✨';
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
  String get syncChooserInPersonSub => 'Sinchronizavimas per Wi-Fi';

  @override
  String get syncChooserRemote => 'Nuotoliniu būdu';

  @override
  String get syncChooserRemoteSub =>
      'Sinchronizavimas per aplanką ar USB atmintinę';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Eksportas ir importas per socialinius tinklus';

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
  String get selectClowderHintNeutral => 'Kairėje pasirinkite namų ūkį';

  @override
  String get introTitle1 => 'Jūsų katės tvarkingai';

  @override
  String get introTitle1Neutral => 'Jūsų augintiniai tvarkingai';

  @override
  String get introBody1 =>
      'Kiekvienai katei sukurkite kortelę: nuotrauka, lytis, sveikata — viskas, ką norite užsirašyti. Katės grupuojamos pagal gyvenamą vietą — programėlė ją vadina kolonija (clowder).';

  @override
  String get introBody1Neutral =>
      'Kiekvienam augintiniui, kuriuo rūpinatės, sukurkite kortelę: nuotrauka, lytis, sveikata — viskas, ką norite užsirašyti. Augintiniai grupuojami pagal gyvenamą vietą — programėlė ją vadina namų ūkiu.';

  @override
  String get introTitle2 => 'Veikia be interneto';

  @override
  String get introBody2 =>
      'Viskas saugoma tik jūsų telefone. Jokios paskyros, jokio debesies. Niekas nesiunčiama, kol patys nepasidalijate.';

  @override
  String get introTitle3 => 'Dirbkite kartu';

  @override
  String get introBody3 =>
      'Kiekvienas naudoja savo programėlę ir retkarčiais apsikeičiate duomenimis: susitikite ir nuskaitykite kodą, naudokite bendrą aplanką arba atsiųskite vieną failą per programėlę. Po to visi turi tą pačią informaciją.';

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
      'Čia sinchronizuojate su pažįstamais. Jūs sprendžiate, kuo dalintis.';

  @override
  String get spotHomeStrays =>
      'Ši kortelė surenka visas valkataujančias kates — kates be namų. Palieskite sąrašui.';

  @override
  String get spotHomeStraysNeutral =>
      'Ši kortelė surenka visus valkataujančius — augintinius be namų. Palieskite sąrašui.';

  @override
  String get spotHomeMenu =>
      'Šiame meniu: nustatymai, dublikatų paieška ir sujungimas, CSV eksportas ir daugiau.';

  @override
  String get spotCatEdit =>
      'Palieskite pieštuką ir redaguokite katę. Patarimas: ilgai palaikę lauką, redaguosite jį iškart.';

  @override
  String get spotCatEditNeutral =>
      'Palieskite pieštuką ir redaguokite augintinį. Patarimas: ilgai palaikę lauką, redaguosite jį iškart.';

  @override
  String get spotMapLayers =>
      'Ieškote dingusios katės? Rodykite apskritimus aplink jos skelbimų vietas ir aplink namus, iš kurių pabėgo.';

  @override
  String get spotMapLayersNeutral =>
      'Ieškote dingusio augintinio? Rodykite apskritimus aplink jo skelbimų vietas ir aplink namus, iš kurių pabėgo.';

  @override
  String get spotStraysFlier =>
      'Radote dingusios katės skelbimą? Nufotografuokite jį čia — programėlė išsaugos katę ir kontaktą už jus.';

  @override
  String get spotStraysFlierNeutral =>
      'Radote dingusio augintinio skelbimą? Nufotografuokite jį čia — programėlė išsaugos augintinį ir kontaktą už jus.';

  @override
  String get spotStraysScan =>
      'Kai kurie skelbimai turi cat(a)log QR kodą. Nuskaitykite jį čia ir importuokite katę nerašydami.';

  @override
  String get spotStraysScanNeutral =>
      'Kai kurie skelbimai turi cat(a)log QR kodą. Nuskaitykite jį čia ir importuokite augintinį nerašydami.';

  @override
  String get introTitle4 => 'Raskite dingusias kates';

  @override
  String get introTitle4Neutral => 'Raskite dingusius augintinius';

  @override
  String get introBody4 =>
      'Matote skelbimą apie dingusią katę? Nufotografuokite jį programėlėje: ji išsaugo katę, šeimininko kontaktą ir vietą. Jei vėliau pasirodys panaši valkataujanti katė, programėlė pasiūlys galimus atitikmenis.';

  @override
  String get introBody4Neutral =>
      'Matote skelbimą apie dingusį augintinį? Nufotografuokite jį programėlėje: ji išsaugo augintinį, šeimininko kontaktą ir vietą. Jei vėliau pasirodys panašus valkataujantis gyvūnas, programėlė pasiūlys galimus atitikmenis.';

  @override
  String get spotMapSearch =>
      'Įveskite katę, vietą ar žmogų ir peršokite ten žemėlapyje.';

  @override
  String get spotMapSearchNeutral =>
      'Įveskite augintinį, vietą ar žmogų ir peršokite ten žemėlapyje.';

  @override
  String get spotCardChips =>
      'Pažymėkite, kas turi būti bendrinamoje kortelėje — kita lieka už jos.';

  @override
  String get spotCatMenu =>
      'Čia daugiau veiksmų: paslėpti katę, sujungti dublikatus ar užfiksuoti pastebėjimą.';

  @override
  String get spotCatMenuNeutral =>
      'Čia daugiau veiksmų: paslėpti augintinį, sujungti dublikatus ar užfiksuoti pastebėjimą.';

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
  String get searchNoResultsNeutral => 'Augintinio tokiu vardu nerasta';

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

  @override
  String get catalogsTitle => 'Katalogai';

  @override
  String get newCatalog => 'Naujas katalogas';

  @override
  String get intoCatalog => 'Į katalogą';

  @override
  String get catalogNameLabel => 'Katalogo pavadinimas';

  @override
  String catalogNameTaken(String name) {
    return 'Katalogas pavadinimu $name jau yra. Pasirink kitą pavadinimą.';
  }

  @override
  String get manageCatalogs => 'Tvarkyti katalogus';

  @override
  String get helpCatalogs =>
      'Katalogas yra atskiras pasaulis: savi katės, kolonijos, laukai, nuotraukos ir sinchronizavimo partneriai. Berlynas ir Paryžius niekada nesimaišo. Bakstelėkite katalogą, kad į jį persijungtumėte. Krumpliaratis prie katalogo atveria jo nustatymus: pavadinimas, katės ar gyvūnai, laukai, autoriai ir blokavimai, archyvas, grįžimas atgal, šalinimas. Jūsų vardas, kalba ir jau matyti patarimai bendri visiems.';

  @override
  String get helpCatalogsNeutral =>
      'Katalogas yra atskiras pasaulis: savi gyvūnai, namų ūkiai, laukai, nuotraukos ir sinchronizavimo partneriai. Berlynas ir Paryžius niekada nesimaišo. Bakstelėkite katalogą, kad į jį persijungtumėte. Krumpliaratis prie katalogo atveria jo nustatymus: pavadinimas, katės ar gyvūnai, laukai, autoriai ir blokavimai, archyvas, grįžimas atgal, šalinimas. Jūsų vardas, kalba ir jau matyti patarimai bendri visiems.';

  @override
  String get helpCatalogSettings =>
      'Viskas, kas priklauso tik šiam katalogui: pavadinimas, ar jame katės, ar gyvūnai, laukai, autoriai ir blokavimai, archyvas ir grįžimas laiku atgal. Pakeitimai čia liečia tik šį katalogą — ir tą, kuriame dabar nesate. Šalinimas pirmiausia įrašo katalogą į failą.';

  @override
  String get spotHomeCatalog =>
      'Tai katalogas, kuriame esi. Bakstelėk pavadinimą, kad perjungtum ar sukurtum naują.';

  @override
  String get deleteCatalog => 'Ištrinti katalogą';

  @override
  String get catalogSettings => 'Katalogo nustatymai';

  @override
  String deleteCatalogBody(String name) {
    return 'Viskas kataloge $name dingsta: katės, nuotraukos, istorija. Pirma ten, kur keliauja automatinės atsargines kopijos, įrašomas pilnas failas — jį importavus katalogas grįžta.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Viskas kataloge $name dingsta: augintiniai, nuotraukos, istorija. Pirma ten, kur keliauja automatinės atsargines kopijos, įrašomas pilnas failas — jį importavus katalogas grįžta. Patvirtink įrašydamas pavadinimą.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name ištrintas. Failas yra $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Įrašyk $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nieko neištrinta: nepavyko įrašyti katalogo failo ($error). Atlaisvink vietos arba pabandyk vėliau.';
  }

  @override
  String get moveToCatalog => 'Perkelti į kitą katalogą';

  @override
  String movedToCatalog(int count, String name) {
    return '$count perkelta į $name';
  }

  @override
  String get chooseWhatToMove => 'Kas persikelia?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Perkelti ką nors į $name?';
  }

  @override
  String get undoThisImport => 'Atšaukti šį importą';

  @override
  String undoImportBody(int count) {
    return '$count šio importo pakeitimai bus pašalinti. Pirma jie įrašomi į failą, kurio importas juos grąžina. Tie, su kuriais jau sinchronizavai, pasilieka savo kopiją — to atšaukti negalima.';
  }

  @override
  String undoneImport(String where) {
    return 'Atšaukta. Failas yra $where.';
  }

  @override
  String get goBackTitle => 'Grįžti atgal';

  @override
  String get goBackToHere => 'Grįžti čia';

  @override
  String get momentImport => 'Prieš importą';

  @override
  String get momentSync => 'Prieš sinchronizavimą';

  @override
  String get momentMerge => 'Prieš sujungimą';

  @override
  String get momentHardDelete => 'Prieš ištrinant vieno autoriaus duomenis';

  @override
  String get momentArchive => 'Prieš archyvavimą';

  @override
  String get momentManual => 'Tavo pažymėta';

  @override
  String get showOlderMoments => 'Rodyti senesnius';

  @override
  String goBackBody(int count) {
    return 'Viskas po šios akimirkos pašalinama — $count pakeitimai. Pirma tai įrašoma į failą, kurio importas viską grąžina, ir kiekviena naujesnė akimirka dingsta kartu. Tie, su kuriais jau sinchronizavai, pasilieka kopiją — to atšaukti negalima.';
  }

  @override
  String get nameThisMoment => 'Pavadink šią akimirką';

  @override
  String get helpGoBack =>
      'Akimirkos, kai šis katalogas pasikeitė iš esmės: prieš kiekvieną importą ir sinchronizavimą, prieš sujungimą, archyvavimą ar ištrynimą, ir kaskart, kai pats pažymėjai akimirką. Pasirinkus vieną, katalogas grįžta į tą būseną — viskas po jos įrašoma į failą, kurį pasilieki, ir tada pašalinama, o kiekviena naujesnė akimirka dingsta kartu. Tie, su kuriais jau sinchronizavai, pasilieka tai, ką gavo.';

  @override
  String goBackFileFailed(String error) {
    return 'Niekas nepašalinta: failo, kuris tai išsaugo, nepavyko įrašyti ($error). Atlaisvink vietos ir bandyk dar kartą.';
  }

  @override
  String get goBackChanged =>
      'Nieko nepašalinta: katalogas pasikeitė, kol failas buvo įrašomas. Bandykite dar kartą.';

  @override
  String get switchBeforeDeleting =>
      'Tai katalogas, kuriame esi. Perjunk į kitą ir tada jį ištrink.';

  @override
  String shareFileFailed(String error) {
    return 'Nepavyko įrašyti dalijimosi failo ($error). Atlaisvink vietos ir bandyk dar kartą.';
  }

  @override
  String get privateLabel => 'Privatu';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalogas: $name';
  }

  @override
  String get markPrivate => 'Pažymėti kaip privatų';

  @override
  String get unmarkPrivate => 'Pašalinti privatumo žymą';

  @override
  String get agenda => 'Priminimai';

  @override
  String get reminderLabel => 'Priminimas';

  @override
  String get agendaEmpty =>
      'Suplanuotų vizitų nėra. Naujus planuok čia pliusu arba katės ar klauderio puslapyje.';

  @override
  String get agendaEmptyNeutral =>
      'Suplanuotų vizitų nėra. Naujus planuok čia pliusu arba augintinio ar namų ūkio puslapyje.';

  @override
  String get dueToday => 'šiandien';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'po $count dienų',
      many: 'po $count dienos',
      few: 'po $count dienų',
      one: 'po $count dienos',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vėluojama $count dienų',
      many: 'vėluojama $count dienos',
      few: 'vėluojama $count dienas',
      one: 'vėluojama $count dieną',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Atlikta';

  @override
  String get repeatTitle => 'Vėl po…';

  @override
  String get noRepeatLabel => 'Nekartoti';

  @override
  String get unitDays => 'dienų';

  @override
  String get unitWeeks => 'savaičių';

  @override
  String get unitMonths => 'mėnesių';

  @override
  String get unitYears => 'metų';

  @override
  String ageYears(int years) {
    return '$years m.';
  }

  @override
  String ageMonths(int months) {
    return '$months mėn.';
  }

  @override
  String get changeDateLabel => 'Keisti datą';

  @override
  String get removeReminderLabel => 'Pašalinti priminimą';

  @override
  String get exportIcs => 'Eksportuoti kalendoriaus failą';

  @override
  String get resyncCalendar => 'Iš naujo sinchronizuoti kalendorių';

  @override
  String icsSavedTo(String path) {
    return 'Kalendoriaus failas išsaugotas $path';
  }

  @override
  String get calendarMirrorLabel => 'Atspindėti įrenginio kalendoriuje';

  @override
  String get calendarMirrorSubtitle =>
      'Vizitai kalendoriuje rodomi kaip visos dienos įvykiai. cat(a)log juos ten atnaujina kiekvieną kartą paleidus ir po kiekvieno pakeitimo. Vizitų priminimus tvarkai kalendoriuje.';

  @override
  String get syncPeerOlder =>
      'Kitame įrenginyje senesnis cat(a)log be priminimų. Atnaujink cat(a)log ten ir sinchronizuok iš naujo.';

  @override
  String get syncPeerNewer =>
      'Kitame įrenginyje naujesnis cat(a)log. Atnaujink cat(a)log šiame įrenginyje ir sinchronizuok iš naujo.';

  @override
  String get syncPeerNoTls =>
      'Kitame įrenginyje yra cat(a)log iki 1.1.0, be šifruoto sinchronizavimo. Ten atnaujink cat(a)log ir sinchronizuok iš naujo.';

  @override
  String get syncWrongHost =>
      'Sertifikatas neatitinka susiejimo kodo — tai ne tas įrenginys, iš kurio kodas atėjo. Nuskaityk arba įvesk kodą iš naujo.';

  @override
  String get bundleNewerError =>
      'Šis failas iš naujesnio cat(a)log. Atnaujink cat(a)log šiame įrenginyje, kad jį importuotum.';

  @override
  String get spotEar =>
      'Maža katės ausis kampe reiškia: palaikyk nuspaudę, kad pamatytum daugiau.';

  @override
  String get addReminder => 'Pridėti priminimą';

  @override
  String get plannedSection => 'Suplanuota';

  @override
  String get reminderDialogHint =>
      'Vizitas rodomas priminimuose. Ten gali jį patvirtinti arba atmesti. Reikšmė perimama tik tada, kai vizitas patvirtintas.';

  @override
  String get reminderFor => 'Kam';

  @override
  String get reminderField => 'Laukas';

  @override
  String get dueDateLabel => 'Terminas';

  @override
  String get pickCalendar => 'Kuris kalendorius?';

  @override
  String get calendarPermissionDenied =>
      'Prieiga prie kalendoriaus užblokuota, todėl atspindėjimas išjungtas. Leisk ją sistemos nustatymuose ir vėl įjunk atspindėjimą.';

  @override
  String get calendarNotChosen =>
      'Kalendorius nepasirinktas, todėl atspindėjimas išjungtas. Vėl įjunk jį ir pasirink kalendorių.';

  @override
  String get calendarGone =>
      'Pasirinkto kalendoriaus nebėra, todėl atspindėjimas išjungtas. Vėl įjunk jį ir pasirink kitą.';

  @override
  String get noWritableCalendar =>
      'Kalendorius nerastas. Sistemos nustatymuose prisijunk prie kalendoriaus paskyros, pavyzdžiui Google, ir bandyk dar kartą.';

  @override
  String get spotHomeAgenda =>
      'Priminimai: suplanuotų vizitų sąrašas — veterinaras, vaistai, patikros.';

  @override
  String get spotAgendaAdd => 'Suplanuoti naują vizitą.';

  @override
  String get spotAgendaCalendar =>
      'Čia įjunk cat(a)log vizitų atspindėjimą į pasirinktą kalendorių.';

  @override
  String get helpAgenda =>
      'Priminimai rodo suplanuotus vizitus pagal datą. Yra dvi rūšys: vizitai su valanda ir priminimai, galiojantys dienai. Praleisti lieka viršuje. Bakstelėjimas atveria katę ar klauderį. Varnelė patvirtina vizitą: reikšmė įrašoma į lauką ir iškart gali suplanuoti kitą, pavyzdžiui, po trijų mėnesių. Palaikymas keičia datą arba ištrina vizitą. Jungiklis viršuje atspindi vizitus tavo telefono kalendoriuje. Meniu juos eksportuoja kalendoriaus failu. Vizitas pas veterinarą su keliomis katėmis yra vienas vizitas: pažymėkite kates, Darbotvarkė rodo vieną kortelę su jų vardais, o baigiant klausia, kurios katės buvo gydytos — nuimkite žymą nuo kitų, jos lieka suplanuotos.';

  @override
  String get helpAgendaNeutral =>
      'Priminimai rodo suplanuotus vizitus pagal datą. Yra dvi rūšys: vizitai su valanda ir priminimai, galiojantys dienai. Praleisti lieka viršuje. Bakstelėjimas atveria augintinį ar namų ūkį. Varnelė patvirtina vizitą: reikšmė įrašoma į lauką ir iškart gali suplanuoti kitą, pavyzdžiui, po trijų mėnesių. Palaikymas keičia datą arba ištrina vizitą. Jungiklis viršuje atspindi vizitus tavo telefono kalendoriuje. Meniu juos eksportuoja kalendoriaus failu. Vizitas pas veterinarą su keliais augintiniais yra vienas vizitas: pažymėkite augintinius, Darbotvarkė rodo vieną kortelę su jų vardais, o baigiant klausia, kurie augintiniai buvo gydyti — nuimkite žymą nuo kitų, jie lieka suplanuoti.';

  @override
  String get calendarRowOff => 'Kalendorius: išjungta';

  @override
  String calendarRowOn(String name) {
    return 'Kalendorius: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Suplanuok vizitą šiai katei. Jis rodomas priminimuose ir ten patvirtinamas.';

  @override
  String get spotAddReminderCatNeutral =>
      'Suplanuok vizitą šiam augintiniui. Jis rodomas priminimuose ir ten patvirtinamas.';

  @override
  String get spotAddReminderClowder =>
      'Suplanuok vizitą šiam klauderiui. Jis rodomas priminimuose ir ten patvirtinamas.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Suplanuok vizitą šiam namų ūkiui. Jis rodomas priminimuose ir ten patvirtinamas.';

  @override
  String get readOnlyCalendar => 'tik skaityti';

  @override
  String get appointmentLabel => 'Vizitas';

  @override
  String get addAppointment => 'Pridėti vizitą';

  @override
  String get planChooserTitle => 'Vizitas ar priminimas?';

  @override
  String get planChooserAppointment =>
      'Vizitas — apsilankymas tam tikrą dieną ir valandą, su pastabomis';

  @override
  String get planChooserReminder =>
      'Priminimas — reikšmė, kurios terminas sueina tam tikrą dieną';

  @override
  String get appointmentTitleLabel => 'Kas';

  @override
  String get notesLabel => 'Pastabos';

  @override
  String get timeLabel => 'Laikas';

  @override
  String get allDayLabel => 'Visą dieną';

  @override
  String get alertLabel => 'Įspėjimas';

  @override
  String get alertNone => 'Nėra';

  @override
  String get alertDayBefore => 'Dieną prieš';

  @override
  String get alertHourBefore => 'Valandą prieš';

  @override
  String get linkFieldLabel => 'Užbaigus įrašyti į lauką';

  @override
  String get noLinkedField => 'Nėra lauko';

  @override
  String get outcomeTitle => 'Kaip sekėsi?';

  @override
  String get finishLabel => 'Užbaigti';

  @override
  String get editLabelAppointment => 'Redaguoti vizitą';

  @override
  String get deleteAppointment => 'Ištrinti vizitą';

  @override
  String get stepFlierText => 'Skelbimo tekstas';

  @override
  String get qrFoundHint =>
      'Skelbime rastas QR kodas. Pažymėti kodai skaitomi ieškant registro numerių ir nuorodų.';

  @override
  String get useCode => 'Naudoti šį kodą';

  @override
  String get qrNone => 'Nuotraukoje QR kodas nerastas.';

  @override
  String qrFailed(String error) {
    return 'Nepavyko nuskaityti QR kodo: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Atpažintas $name skelbimas. Žemiau patikrinkite, į kurį lauką patenka kiekviena eilutė.';
  }

  @override
  String get flierLayoutUnknown =>
      'Nežinomas skelbimo išdėstymas. Priskirkite eilutes laukams žemiau; likusi dalis lieka pastabose.';

  @override
  String get targetRegistryNumber => 'Registro numeris';

  @override
  String get targetLostPlace => 'Adresas (dingimo vieta)';

  @override
  String get targetContact => 'Registro kontaktas';

  @override
  String get targetDrop => 'Atmesti';

  @override
  String get existingCat => 'Esama katė';

  @override
  String get existingCatNeutral => 'Esamas augintinis';

  @override
  String get existingClowder => 'Esama grupė';

  @override
  String get existingClowderNeutral => 'Esamas namų ūkis';

  @override
  String get createNewInstead => 'Nėra — sukurti naują';

  @override
  String overwritesValue(String value) {
    return 'Perrašo dabartinę reikšmę \"$value\"';
  }

  @override
  String get abortScanTitle => 'Nutraukti skenavimą?';

  @override
  String get abortScanBody => 'Niekas nebus išsaugota.';

  @override
  String get abortScan => 'Nutraukti';

  @override
  String get keepScanning => 'Tęsti';

  @override
  String get catsOnAppointment => 'Katės šiame vizite';

  @override
  String get catsOnAppointmentNeutral => 'Augintiniai šiame vizite';

  @override
  String get noCatsHint =>
      'Nė viena katė nepažymėta — vizitas priklauso pačiai kolonijai.';

  @override
  String get noCatsHintNeutral =>
      'Nė vienas augintinis nepažymėtas — vizitas priklauso pačiam namų ūkiui.';

  @override
  String get pickCatsTitle => 'Kurios katės vyksta?';

  @override
  String get pickCatsTitleNeutral => 'Kurie augintiniai vyksta?';

  @override
  String catsCount(int count) {
    return '$count katės';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count augintiniai';
  }

  @override
  String get finishUntickHint =>
      'Nuimkite žymą nuo kačių, kurios nebuvo gydytos; jos lieka suplanuotos.';

  @override
  String get finishUntickHintNeutral =>
      'Nuimkite žymą nuo augintinių, kurie nebuvo gydyti; jie lieka suplanuoti.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Ištrinti vizitą visoms $count katėms';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Ištrinti vizitą visiems $count augintiniams';
  }
}
