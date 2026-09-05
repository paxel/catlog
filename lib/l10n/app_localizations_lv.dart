// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Laipni lūdzam cat(a)log';

  @override
  String get welcomeBody =>
      'Izvēlieties sev vārdu. Katra izmaiņa tiek ierakstīta ar šo vārdu, lai citi redzētu, kurš ko izdarīja.';

  @override
  String get yourName => 'Jūsu vārds';

  @override
  String get start => 'Sākt';

  @override
  String get clowders => 'Klauderi';

  @override
  String get clowdersNeutral => 'Mājsaimniecības';

  @override
  String get noClowdersYet =>
      'Vēl nav neviena clowdera. Clowder ir vieta, kur dzīvo kaķi — tavas pagaidu mājas, adoptētāja dzīvoklis. Izveido pirmo zemāk.';

  @override
  String get noClowdersYetNeutral =>
      'Vēl nav nevienas mājsaimniecības. Mājsaimniecība ir vieta, kur dzīvo mājdzīvnieki — tavas mājas, pagaidu mājas, adoptētāja dzīvoklis. Izveido pirmo zemāk.';

  @override
  String get strays => 'Klaiņojošie kaķi';

  @override
  String get searchCats => 'Meklēt kaķus';

  @override
  String get searchCatsNeutral => 'Meklēt mājdzīvniekus';

  @override
  String get map => 'Karte';

  @override
  String get sync => 'Sinhronizācija';

  @override
  String get fields => 'Lauki';

  @override
  String get exportCsv => 'Eksportēt CSV';

  @override
  String get aboutAndFeedback => 'Par lietotni un atsauksmes';

  @override
  String get settings => 'Iestatījumi';

  @override
  String get newClowder => 'Jauns klauderis';

  @override
  String get newClowderNeutral => 'Jauna mājsaimniecība';

  @override
  String get name => 'Vārds';

  @override
  String get cancel => 'Atcelt';

  @override
  String get create => 'Izveidot';

  @override
  String get save => 'Saglabāt';

  @override
  String get delete => 'Dzēst';

  @override
  String get merge => 'Apvienot';

  @override
  String get resolve => 'Izlemt';

  @override
  String get open => 'Atvērt';

  @override
  String csvSavedTo(String path) {
    return 'CSV saglabāts: $path';
  }

  @override
  String get renameClowder => 'Pārdēvēt klauderi';

  @override
  String get renameClowderNeutral => 'Pārdēvēt mājsaimniecību';

  @override
  String get rename => 'Pārdēvēt';

  @override
  String get timeline => 'Laika skala';

  @override
  String get mergeInto => 'Apvienot ar…';

  @override
  String get deleteClowder => 'Dzēst klauderi';

  @override
  String get deleteClowderNeutral => 'Dzēst mājsaimniecību';

  @override
  String get cats => 'Kaķi';

  @override
  String get catsNeutral => 'Mājdzīvnieki';

  @override
  String get addCat => 'Pievienot kaķi';

  @override
  String get addCatNeutral => 'Pievienot mājdzīvnieku';

  @override
  String get newCat => 'Jauns kaķis';

  @override
  String get newCatNeutral => 'Jauns mājdzīvnieks';

  @override
  String deleteQuestion(String name) {
    return 'Dzēst $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Klauderis pazūd no saraksta.';

  @override
  String get deleteClowderEmptyBodyNeutral =>
      'Mājsaimniecība pazūd no saraksta.';

  @override
  String deleteClowderBody(int count) {
    return 'Tā kaķi ($count) netiek dzēsti — tie kļūst klaiņojoši. Ja to nevēlaties, vispirms pārvietojiet tos uz citu klauderi.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Tās mājdzīvnieki ($count) netiek dzēsti — tie kļūst klaiņojoši. Ja to nevēlaties, vispirms pārvietojiet tos uz citu mājsaimniecību.';
  }

  @override
  String get card => 'Kartīte';

  @override
  String get shareAsImage => 'Kopīgot kā attēlu';

  @override
  String get shareAsPdf => 'Kopīgot kā PDF';

  @override
  String get print => 'Drukāt';

  @override
  String cardTitle(String name) {
    return 'Kartīte — $name';
  }

  @override
  String get renameCat => 'Pārdēvēt kaķi';

  @override
  String get renameCatNeutral => 'Pārdēvēt mājdzīvnieku';

  @override
  String get seenHereNow => 'Tikko redzēts šeit';

  @override
  String get deleteCat => 'Dzēst kaķi';

  @override
  String get deleteCatNeutral => 'Dzēst mājdzīvnieku';

  @override
  String get clowderLabel => 'Klauderis';

  @override
  String get clowderLabelNeutral => 'Mājsaimniecība';

  @override
  String get strayNoClowder => 'Klaiņojošs — bez klaudera';

  @override
  String get strayNoClowderNeutral => 'Klaiņojošs — bez mājsaimniecības';

  @override
  String get stray => 'Klaiņojošs';

  @override
  String get photos => 'Fotoattēli';

  @override
  String get addPhoto => 'Pievienot fotoattēlu';

  @override
  String get setAsProfileImage => 'Iestatīt kā profila attēlu';

  @override
  String get thisIsProfileImage => 'Šis ir profila attēls';

  @override
  String get deletePhoto => 'Dzēst fotoattēlu';

  @override
  String get deletePhotoTitle => 'Dzēst fotoattēlu?';

  @override
  String get deletePhotoBody =>
      'Fotoattēla dati tiek dzēsti neatgriezeniski — to nevar atsaukt.';

  @override
  String get deleteCatBody =>
      'Kaķis pazūd no visiem sarakstiem, un tā fotoattēli tiek noņemti — šeit un pēc nākamās sinhronizācijas arī citās ierīcēs.';

  @override
  String get deleteCatBodyNeutral =>
      'Mājdzīvnieks pazūd no visiem sarakstiem, un tā fotoattēli tiek noņemti — šeit un pēc nākamās sinhronizācijas arī citās ierīcēs.';

  @override
  String get sightingRecorded => 'Novērojums ierakstīts jūsu pozīcijā.';

  @override
  String get noLocationAvailable =>
      'Atrašanās vieta nav pieejama — tā vietā turiet nospiestu karti.';

  @override
  String get locationDeniedForever =>
      'Piekļuve atrašanās vietai ir bloķēta. Atļaujiet to sistēmas iestatījumos, lai izmantotu Stray Cam.';

  @override
  String get locationServiceOff =>
      'Šajā ierīcē atrašanās vieta ir izslēgta. Ieslēdziet to iestatījumos un mēģiniet vēlreiz.';

  @override
  String get locationDenied =>
      'cat(a)log nav atļaujas izmantot jūsu atrašanās vietu. Mēģiniet vēlreiz un atļaujiet, kad tiks jautāts.';

  @override
  String get locationNoFix =>
      'Jūsu pozīciju šobrīd neizdevās noteikt. Mēģiniet vēlreiz ārā — GPS ir vajadzīgs brīvs skats uz debesīm.';

  @override
  String get ok => 'Labi';

  @override
  String get starterChipId => 'Mikroshēmas numurs';

  @override
  String get starterRemarks => 'Piezīmes';

  @override
  String get captureFlier => 'Nofotografēt sludinājumu';

  @override
  String get addPhotosTo => 'Pievienot fotoattēlus…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foto pievienoti $name';
  }

  @override
  String get scanPrintedCode => 'Skenēt drukātu kodu';

  @override
  String get chipScanHint =>
      'Skenē drukāto QR/svītrkodu no mikroshēmas kartes vai veterinārārsta dokumentiem — kaķī esošo mikroshēmu tālrunis nolasīt nevar.';

  @override
  String get chipScanHintNeutral =>
      'Skenē drukāto QR/svītrkodu no mikroshēmas kartes vai veterinārārsta dokumentiem — dzīvniekā esošo mikroshēmu tālrunis nolasīt nevar.';

  @override
  String get savingLabel => 'Saglabā…';

  @override
  String ownerOfCat(String name) {
    return '$name saimnieks';
  }

  @override
  String get sortLabel => 'Kārtot';

  @override
  String get viewAsTable => 'Rādīt kā tabulu';

  @override
  String get viewAsTiles => 'Rādīt kā elementus';

  @override
  String get viewAsList => 'Rādīt kā sarakstu';

  @override
  String get ageLabel => 'Vecums';

  @override
  String get catList => 'Kaķu saraksts';

  @override
  String get catListNeutral => 'Mājdzīvnieku saraksts';

  @override
  String get matchCandidatesTitle => 'Iespējamās sakritības';

  @override
  String get findDuplicates => 'Atrast dublikātus';

  @override
  String get noDuplicates => 'Šobrīd nav iespējamu dublikātu.';

  @override
  String get similarName => 'Līdzīgs vārds';

  @override
  String get sharePublicly => 'Kopīgot publiski…';

  @override
  String get pickFramesTitle => 'Kadru izvēle';

  @override
  String get suggestedFrames => 'Ieteiktie kadri';

  @override
  String get scrubFrames => 'Pārtīt video';

  @override
  String get keepThisFrame => 'Paturēt šo kadru';

  @override
  String get fromVideo => 'No video…';

  @override
  String get videoMobileOnly =>
      'Kadru izvēle no video darbojas tālruņa lietotnē (Android un iPhone) — šajā ierīcē vēl ne.';

  @override
  String get shareWhitelistExplainer =>
      'Izvēlieties, kas nonāk failā. Iekļauti tiek tikai atzīmētie lauki.';

  @override
  String get exportShareFile => 'Eksportēt kopīgošanas failu…';

  @override
  String get hostedLink => 'Mitināta saite (augšupielādētā faila URL)';

  @override
  String get inlineQr => 'Iegultais QR (tikai teksts, bez fotoattēliem)';

  @override
  String get inlineTooBig =>
      'Pārāk daudz datu iegultam kodam — noņemiet laukus vai izmantojiet mitinātu saiti.';

  @override
  String get scanShareLabel => 'Skenēt kopīgošanas kodu';

  @override
  String get notAShareCode => 'Šis kods nav cat(a)log kopīgošana.';

  @override
  String get importShareTitle => 'Importēt šo kaķi?';

  @override
  String get importShareTitleNeutral => 'Importēt šo mājdzīvnieku?';

  @override
  String shareSource(String url) {
    return 'Avots: $url';
  }

  @override
  String get importLabel => 'Importēt';

  @override
  String get strayAreaLabel => 'Iespējamā klejošanas zona';

  @override
  String get prevPin => 'Iepriekšējā kniepadata';

  @override
  String get nextPin => 'Nākamā kniepadata';

  @override
  String get noMissingCats => 'Vēl nav pazudušu kaķu ar sludinājumu pozīcijām.';

  @override
  String get noMissingCatsNeutral =>
      'Vēl nav pazudušu mājdzīvnieku ar sludinājumu pozīcijām.';

  @override
  String get noMatchCandidates => 'Šobrīd nav iespējamu sakritību.';

  @override
  String sameIdField(String field) {
    return 'Tas pats $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m attālumā';
  }

  @override
  String get addFlier => 'Pievienot sludinājumu';

  @override
  String get missingSinceLabel => 'Pazudis kopš';

  @override
  String get phoneLabel => 'Tālrunis';

  @override
  String get cropPortrait => 'Apgriezt portretu';

  @override
  String get statusOwner => 'Saimnieks';

  @override
  String get ocrUnavailable =>
      'Teksta atpazīšana šajā ierīcē nav pieejama — ierakstiet sludinājuma tekstu paši.';

  @override
  String get displayFormat => 'Rādīt kā';

  @override
  String get displayPlain => 'Vienkāršs teksts';

  @override
  String get displayQr => 'QR kods';

  @override
  String get displayBarcode => 'Svītrkods';

  @override
  String get editLabel => 'Rediģēt';

  @override
  String get doneLabel => 'Gatavs';

  @override
  String get openSettings => 'Atvērt iestatījumus';

  @override
  String get notSaved => 'Nav saglabāts';

  @override
  String get birthdateInFuture => 'Dzimšanas datums nevar būt nākotnē.';

  @override
  String get deceasedInFuture => 'Nāves datums nevar būt nākotnē.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Nāves datums nevar būt pirms dzimšanas datuma ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Dzimšanas datums nevar būt pēc nāves datuma ($date).';
  }

  @override
  String get malePregnant =>
      'Šis kaķis ir reģistrēts kā runcis — runcis nevar būt grūsns. Vispirms pārbaudiet dzimumu.';

  @override
  String get malePregnantNeutral =>
      'Šis mājdzīvnieks ir reģistrēts kā tēviņš — tēviņš nevar būt grūsns. Vispirms pārbaudiet dzimumu.';

  @override
  String fatherNotMale(String name) {
    return '$name ir reģistrēta kā kaķene un nevar būt tēvs. Vispirms pārbaudiet dzimumu.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name ir reģistrēts kā runcis un nevar būt māte. Vispirms pārbaudiet dzimumu.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name dzimis $date — vecāks nevar piedzimt pēc sava kaķēna.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name dzimis $date — vecāks nevar piedzimt pēc sava mazuļa.';
  }

  @override
  String get genderFatherFemale =>
      'Šis kaķis ir reģistrēts kā citu kaķu tēvs — tēvs nevar būt kaķene. Vispirms pārbaudiet ģimeni.';

  @override
  String get genderFatherFemaleNeutral =>
      'Šis mājdzīvnieks ir reģistrēts kā citu mājdzīvnieku tēvs — tēvs nevar būt mātīte. Vispirms pārbaudiet ģimeni.';

  @override
  String get genderMotherMale =>
      'Šis kaķis ir reģistrēts kā citu kaķu māte — māte nevar būt runcis. Vispirms pārbaudiet ģimeni.';

  @override
  String get genderMotherMaleNeutral =>
      'Šis mājdzīvnieks ir reģistrēts kā citu mājdzīvnieku māte — māte nevar būt tēviņš. Vispirms pārbaudiet ģimeni.';

  @override
  String get moveTo => 'Pārvietot uz';

  @override
  String get noClowderStrayOption => 'Bez klaudera — klaiņojošs / aizbēga';

  @override
  String get noClowderStrayOptionNeutral =>
      'Bez mājsaimniecības — klaiņojošs / aizbēga';

  @override
  String timelineOf(String name) {
    return 'Laika skala — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Atsaukt šo izmaiņu';

  @override
  String get revertSubtitle =>
      'Atjauno iepriekšējo vērtību kā jaunu ierakstu — vēsture saglabā abus.';

  @override
  String fieldCleared(String field) {
    return '$field iztukšots';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field atgriezts uz \"$value\"';
  }

  @override
  String get leftStray => 'Aizgāja — klaiņojošs';

  @override
  String movedTo(String name) {
    return 'Pārvietots uz $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat ieradās';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat ieradās no $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat devās uz $place';
  }

  @override
  String get duplicateMergedIn => 'Dublikāts apvienots';

  @override
  String get asOfToday => 'Ar šodienas datumu';

  @override
  String asOfDate(String date) {
    return 'Ar datumu $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Nepareizs formāts — izmantojiet $format';
  }

  @override
  String get dateInFuture => 'Šis datums nevar būt nākotnē.';

  @override
  String get value => 'Vērtība';

  @override
  String get latitudeLongitude => 'platums, garums';

  @override
  String get newField => 'Jauns lauks';

  @override
  String get fieldType => 'Tips';

  @override
  String get usedOn => 'Lieto';

  @override
  String get forCats => 'kaķiem';

  @override
  String get forCatsNeutral => 'mājdzīvniekiem';

  @override
  String get forClowders => 'klauderiem';

  @override
  String get forClowdersNeutral => 'mājsaimniecībām';

  @override
  String get forBoth => 'abiem';

  @override
  String get optionsOnePerLine => 'Iespējas (pa vienai rindā)';

  @override
  String get ownValue => 'Sava vērtība';

  @override
  String get renameField => 'Pārdēvēt lauku';

  @override
  String get editOptions => 'Rediģēt opcijas…';

  @override
  String get noStraysRightNow => 'Šobrīd klaiņojošu kaķu nav.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Pievienot klaiņojošu';

  @override
  String get newStray => 'Jauns klaiņojošs';

  @override
  String get searchByNameHint => 'Meklēt kaķus pēc vārda…';

  @override
  String get searchByNameHintNeutral => 'Meklēt mājdzīvniekus pēc vārda…';

  @override
  String get host => 'Uzņemt';

  @override
  String get hostExplainer =>
      'Sāciet šeit, tad otrā ierīcē noskenējiet kodu vai ievadiet to.';

  @override
  String get startHosting => 'Sākt uzņemšanu';

  @override
  String get stopHosting => 'Beigt uzņemšanu';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Sesijas līdz šim: $count';
  }

  @override
  String get join => 'Pievienoties';

  @override
  String get addressFromHost => 'Adrese (no uzņemošās ierīces)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sinhronizēt tagad';

  @override
  String get addressFormatHint => 'Adresei jāizskatās kā 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sinhronizēts: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sinhronizācija neizdevās: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Pēdējā sinhronizācija ar $peer: $time';
  }

  @override
  String get sharedFolder => 'Koplietota mape';

  @override
  String get sharedFolderExplainer =>
      'Abas ierīces izmanto vienu mapi (piem., Dropbox vai USB zibatmiņā). Katra sinhronizācija tur atstāj jūsu izmaiņas un paņem otras puses izmaiņas.';

  @override
  String get noFolderChosenYet => 'Mape vēl nav izvēlēta';

  @override
  String get choose => 'Izvēlēties…';

  @override
  String get syncFolderNow => 'Sinhronizēt mapi tagad';

  @override
  String folderSynced(String result) {
    return 'Mape sinhronizēta: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Mapes sinhronizācija neizdevās: $error';
  }

  @override
  String get recordSightingHere => 'Ierakstīt novērojumu šeit:';

  @override
  String trailOf(String name, int count) {
    return 'Maršruts: $name ($count novērojumi)';
  }

  @override
  String trailOfField(String name, String field, int count) {
    return 'Ceļš: $name — $field ($count vērtības)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikts — $field';
  }

  @override
  String get conflictBody =>
      'Mainīts divās vietās vienlaikus. Izvēlieties, kas ir patiesība:';

  @override
  String mergeThisInto(String kind) {
    return 'Apvienot šo ierakstu ($kind) ar…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Nav cita ieraksta ($kind), ar ko apvienot.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Apvienot ar $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Divi ieraksti kļūst par vienu. $name patur pašreizējās vērtības; otra vēsture pievienojas. To nevar atsaukt.';
  }

  @override
  String get kindCat => 'kaķis';

  @override
  String get kindCatNeutral => 'mājdzīvnieks';

  @override
  String get kindClowder => 'klauderis';

  @override
  String get kindClowderNeutral => 'mājsaimniecība';

  @override
  String get kindField => 'lauks';

  @override
  String get takePhoto => 'Uzņemt foto';

  @override
  String get chooseFromGallery => 'Izvēlēties no galerijas';

  @override
  String get about => 'Par lietotni';

  @override
  String get aboutTagline =>
      'Vietējs katalogs aprūpes kaķiem. Jūsu dati paliek jūsu ierīcēs — bez servera, bez konta.';

  @override
  String get aboutTaglineNeutral =>
      'Vietējs katalogs mājdzīvniekiem, par kuriem rūpējies. Jūsu dati paliek jūsu ierīcēs — bez servera, bez konta.';

  @override
  String versionLabel(String version, String build) {
    return 'Versija $version ($build)';
  }

  @override
  String get sourceCode => 'Pirmkods';

  @override
  String get reportProblemOrIdea => 'Ziņot par problēmu vai ideju';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Rakstīt izstrādātājam';

  @override
  String get buyCoffee => 'Uzsauc izstrādātājam kafiju';

  @override
  String get coffeeSubtitle =>
      'Lietotne paliek bezmaksas. Pat ja kafiju nedabūšu :)';

  @override
  String get openSourceLicenses => 'Atvērtā koda licences';

  @override
  String get machineTranslated =>
      'Tulkojumi ir mašīntulkoti — labojumi laipni gaidīti GitHub.';

  @override
  String get unnamed => '(bez vārda)';

  @override
  String get labelName => 'Vārds';

  @override
  String get labelProfileImage => 'Profila attēls';

  @override
  String get labelPhoto => 'Fotoattēls';

  @override
  String get starterGender => 'Dzimums';

  @override
  String get starterBreed => 'Šķirne';

  @override
  String get valueMixed => 'jauktenis';

  @override
  String get breedEuropeanShorthair => 'Eiropas īsspalvainā';

  @override
  String get breedMaineCoon => 'Meinkūns';

  @override
  String get breedBritishShorthair => 'Britu īsspalvainā';

  @override
  String get breedNorwegianForestCat => 'Norvēģijas meža kaķis';

  @override
  String get breedRagdoll => 'Regdolls';

  @override
  String get breedSiamese => 'Siāmas';

  @override
  String get breedPersian => 'Persu';

  @override
  String get breedBengal => 'Bengālijas';

  @override
  String get breedSphynx => 'Sfinkss';

  @override
  String get starterColor => 'Krāsa';

  @override
  String get starterNeutered => 'Sterilizēts';

  @override
  String get starterPregnant => 'Grūsna';

  @override
  String get starterBirthdate => 'Dzimšanas datums';

  @override
  String get starterDeceased => 'Miris';

  @override
  String get starterAddress => 'Adrese';

  @override
  String get starterResponsible => 'Atbildīgā persona';

  @override
  String get starterEmail => 'E-pasts';

  @override
  String get starterPhone => 'Tālrunis';

  @override
  String get lookupUrlLabel => 'Meklēšanas saite';

  @override
  String lookupUrlHelp(String token) {
    return 'Pakalpojuma lapa ar $token numura vietā, piem. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Meklēt';

  @override
  String lookupFailed(String url) {
    return 'Neviena lietotne nevarēja atvērt $url. Nokopējiet saiti pārlūkā.';
  }

  @override
  String get stepCat => 'Kaķis';

  @override
  String get stepCatNeutral => 'Mājdzīvnieks';

  @override
  String get stepOwner => 'Īpašnieks';

  @override
  String get stepFace => 'Sejas foto';

  @override
  String get stepRegistry => 'Reģistrs';

  @override
  String get stepReview => 'Pārbaudīt un saglabāt';

  @override
  String get stepOwnerHint =>
      'Tas, kam kaķis pazudis — no tā top viņa klauderis ar kontaktu no sludinājuma.';

  @override
  String get stepOwnerHintNeutral =>
      'Tas, kam mājdzīvnieks pazudis — no tā top viņa mājsaimniecība ar kontaktu no sludinājuma.';

  @override
  String get stepFaceHint =>
      'Izgriez kaķa seju no sludinājuma; tā kļūs par profila attēlu. Vari arī izlaist.';

  @override
  String get stepFaceHintNeutral =>
      'Izgriez mājdzīvnieka seju no sludinājuma; tā kļūs par profila attēlu. Vari arī izlaist.';

  @override
  String get stepRegistryHint =>
      'Sludinājumā atrastie numuri. Atzīmētie tiks saglabāti pie kaķa un vēlāk atverami.';

  @override
  String get stepRegistryHintNeutral =>
      'Sludinājumā atrastie numuri. Atzīmētie tiks saglabāti pie mājdzīvnieka un vēlāk atverami.';

  @override
  String get noRegistryLinks =>
      'Šajā sludinājumā nav reģistru saišu — ja kāda palaista garām, lūdzu, ziņojiet par kļūdu.';

  @override
  String get unknownServiceHint => 'Nezināms pakalpojums';

  @override
  String get rememberService => 'Atcerēties pakalpojumu';

  @override
  String get rememberServiceHint =>
      'Nosauc pakalpojumu un norādi numuru saitē. Nākamais sludinājums aizpildīsies pats.';

  @override
  String get noIdInLink =>
      'Šajā saitē nav numura, ko lietotne varētu saglabāt.';

  @override
  String get whichNumber => 'Kura daļa ir numurs?';

  @override
  String get cropAgain => 'Griezt vēlreiz';

  @override
  String get noFaceYet =>
      'Sejas foto vēl nav — tiek izmantots sludinājuma foto.';

  @override
  String get backLabel => 'Atpakaļ';

  @override
  String get dangerButton => 'NESPIED.\nBĪSTAMI';

  @override
  String get dangerThanks => 'Paldies, ka lieto cat(a)log!';

  @override
  String get helpTitle => 'Palīdzība';

  @override
  String get showTipsAgain => 'Rādīt padomus vēlreiz';

  @override
  String get helpHome =>
      'Tavu koloniju pārskats — kolonija ir vieta, kur dzīvo kaķi: tavas mājas, pagaidu mājas, patversme. Pieskaries kartītei, lai redzētu tās kaķus; ilga piespiešana atver izvēlni. Poga apakšā pa labi izveido koloniju, un klaiņotāju kartīte apkopo visus kaķus bez mājām. Nosaukums augšā ir katalogs, kurā esi — pieskaries, lai pārslēgtu vai pievienotu.';

  @override
  String get helpHomeNeutral =>
      'Tavu mājsaimniecību pārskats — mājsaimniecība ir vieta, kur dzīvo mājdzīvnieki: tavas mājas, pagaidu mājas, patversme. Pieskaries kartītei, lai redzētu tās mājdzīvniekus; ilga piespiešana atver izvēlni. Poga apakšā pa labi izveido mājsaimniecību, un klaiņotāju kartīte apkopo visus mājdzīvniekus bez mājām. Nosaukums augšā ir katalogs, kurā esi — pieskaries, lai pārslēgtu vai pievienotu.';

  @override
  String get helpClowder =>
      'Viss par šo vietu: tās kaķi, lauki (adrese, kontakts, veids) un vēsture. Lapa atveras tikai lasīšanai; zīmulis ieslēdz rediģēšanu, kur var pievienot arī jaunu lauku. Ilgi turot lauku, to rediģē uzreiz, kaķi — pārvieto, paslēpj vai atver. Šeit pievienots pieraksts var ņemt līdzi vairākus kolonijas kaķus, piemēram, uz sterilizāciju: atzīmē kaķus, kas brauc, pabeidz vienreiz, noņem atzīmi neārstētajiem. Pulkstenis pie lauka atver tā vēsturi.';

  @override
  String get helpClowderNeutral =>
      'Viss par šo vietu: tās mājdzīvnieki, lauki (adrese, kontakts, veids) un vēsture. Lapa atveras tikai lasīšanai; zīmulis ieslēdz rediģēšanu, kur var pievienot arī jaunu lauku. Ilgi turot lauku, to rediģē uzreiz, mājdzīvnieku — pārvieto, paslēpj vai atver. Šeit pievienots pieraksts var ņemt līdzi vairākus mājsaimniecības mājdzīvniekus, piemēram, uz sterilizāciju: atzīmē mājdzīvniekus, kas brauc, pabeidz vienreiz, noņem atzīmi neārstētajiem. Pulkstenis pie lauka atver tā vēsturi.';

  @override
  String get helpCat =>
      'Viss par šo kaķi: fotogrāfijas, lauki, ģimene, vēsture. Lapa ir tikai lasāma, līdz pieskaries zīmulim. Ilgi turi lauku, lai to uzreiz rediģētu; ilgi turi fotogrāfiju tās izvēlnei. Izvēlne augšā pa labi tur pārējo: paslēpt, apvienot, pierakstīt novērojumu, kopīgot kaķi. „Privāts“ tiek iestatīts, rediģējot lauku. Pulkstenis pie lauka atver tā vēsturi.';

  @override
  String get helpCatNeutral =>
      'Viss par šo mājdzīvnieku: fotogrāfijas, lauki, ģimene, vēsture. Lapa ir tikai lasāma, līdz pieskaries zīmulim. Ilgi turi lauku, lai to uzreiz rediģētu; ilgi turi fotogrāfiju tās izvēlnei. Izvēlne augšā pa labi tur pārējo: paslēpt, apvienot, pierakstīt novērojumu, kopīgot mājdzīvnieku. „Privāts“ tiek iestatīts, rediģējot lauku. Pulkstenis pie lauka atver tā vēsturi.';

  @override
  String get helpStrays =>
      'Kaķi, kuriem šobrīd nav māju: atrasti, aizbēguši vai no sludinājuma. Kameras poga pieraksta kaķi tavā priekšā; sludinājuma poga pārvērš pazuduša kaķa plakātu par kaķi ar īpašnieka kontaktu; skeneris nolasa cat(a)log kodu no plakāta. Pieskaries Stray Cam, lai uzņemtu foto; turi nospiestu, lai filmētu video un labākos kadrus paturētu kā foto.';

  @override
  String get helpStraysNeutral =>
      'Mājdzīvnieki, kuriem šobrīd nav māju: atrasti, aizbēguši vai no sludinājuma. Kameras poga pieraksta dzīvnieku tavā priekšā; sludinājuma poga pārvērš pazuduša mājdzīvnieka plakātu par mājdzīvnieku ar īpašnieka kontaktu; skeneris nolasa cat(a)log kodu no plakāta. Pieskaries Stray Cam, lai uzņemtu foto; turi nospiestu, lai filmētu video un labākos kadrus paturētu kā foto.';

  @override
  String get helpMap =>
      'Visi kaķi un vietas ar atrašanās vietu. Meklēšana atrod kaķus, cilvēkus un vietas — nezināmu nosaukumu meklē visā pasaulē. Slāņu poga uzzīmē 500 m apļus ap pazuduša kaķa sludinājumu vietām un ap māju, no kuras tas aizbēga. Bultas iet no adatas uz adatu, ilga piespiešana kartē pieraksta novērojumu. Katrs vietas lauks kartē ir spraudīte; pieskarieties spraudītei, lai redzētu tās ceļu.';

  @override
  String get helpMapNeutral =>
      'Visi mājdzīvnieki un vietas ar atrašanās vietu. Meklēšana atrod mājdzīvniekus, cilvēkus un vietas — nezināmu nosaukumu meklē visā pasaulē. Slāņu poga uzzīmē 500 m apļus ap pazuduša mājdzīvnieka sludinājumu vietām un ap māju, no kuras tas aizbēga. Bultas iet no adatas uz adatu, ilga piespiešana kartē pieraksta novērojumu. Katrs vietas lauks kartē ir spraudīte; pieskarieties spraudītei, lai redzētu tās ceļu.';

  @override
  String get helpCard =>
      'Kaķa izdrukājamā kartīte: augšā ar žetoniem izvēlies, kas uz tās būs, tad kopīgo to kā attēlu vai PDF. Numurus var drukāt kā QR vai svītrkodu, un atrašanās vieta kļūst par QR, kas atver karti, plus īss Plus Code.';

  @override
  String get helpCardNeutral =>
      'Mājdzīvnieka izdrukājamā kartīte: augšā ar žetoniem izvēlies, kas uz tās būs, tad kopīgo to kā attēlu vai PDF. Numurus var drukāt kā QR vai svītrkodu, un atrašanās vieta kļūst par QR, kas atver karti, plus īss Plus Code.';

  @override
  String get helpSync =>
      'Kā dati nonāk pie citiem: savienojies tieši, izmanto mapi, ko redz abas ierīces, vai sūti failu ar ziņapmaiņu. Vienmēr tu izlem, kas aiziet — un saņemtos .catsync failus atver arī šeit.';

  @override
  String get helpFields =>
      'Lauki, ko izmanto tavs katalogs. Pārdēvē tos, maini izvēles lauka iespējas vai izveido savus. Identifikatora lauks var norādīt uz pakalpojumu (reģistru), tad numurs pie kaķa kļūst piespiežams.';

  @override
  String get helpFieldsNeutral =>
      'Lauki, ko izmanto tavs katalogs. Pārdēvē tos, maini izvēles lauka iespējas vai izveido savus. Identifikatora lauks var norādīt uz pakalpojumu (reģistru), tad numurs pie mājdzīvnieka kļūst piespiežams.';

  @override
  String get helpTimeline =>
      'Katra jebkad veiktā izmaiņa, jaunākā augšā: kurš ko, kad un uz kādu vērtību mainīja. Jebkuru ierakstu var atsaukt — tas raksta jaunu ierakstu, nekas nekad netiek dzēsts.';

  @override
  String get helpDuplicates =>
      'Kaķi vai kolonijas, kas šķiet esam divreiz — vienādi numuri vai ļoti līdzīgi vārdi ar saskanīgām detaļām. Pieskaries pārim, lai apvienotu; apvienošanu nevar atsaukt, tāpēc vispirms tiek jautāts.';

  @override
  String get helpDuplicatesNeutral =>
      'Mājdzīvnieki vai mājsaimniecības, kas šķiet esam divreiz — vienādi numuri vai ļoti līdzīgi vārdi ar saskanīgām detaļām. Pieskaries pārim, lai apvienotu; apvienošanu nevar atsaukt, tāpēc vispirms tiek jautāts.';

  @override
  String get helpMatches =>
      'Kaķi, kas varētu būt viens un tas pats dzīvnieks: vienāds numurs vai klaiņotājs, redzēts pazuduša kaķa meklēšanas zonā. Pieskaries pārim, lai apvienotu, ilgi turot atver pirmo kaķi salīdzināšanai.';

  @override
  String get helpMatchesNeutral =>
      'Mājdzīvnieki, kas varētu būt viens un tas pats dzīvnieks: vienāds numurs vai klaiņotājs, redzēts pazuduša mājdzīvnieka meklēšanas zonā. Pieskaries pārim, lai apvienotu, ilgi turot atver pirmo mājdzīvnieku salīdzināšanai.';

  @override
  String get helpFlier =>
      'Nofotografēts sludinājums kļūst par kaķi un tā īpašnieku. Soli pa solim: kaķa dati, īpašnieka kontakts, sejas izgriešana profila attēlam, reģistru numuri no sludinājuma un beigās pārbaude. Viss ir tikai ieteikumi — izlabo to, ko kamera nolasīja nepareizi.';

  @override
  String get helpFlierNeutral =>
      'Nofotografēts sludinājums kļūst par mājdzīvnieku un tā īpašnieku. Soli pa solim: mājdzīvnieka dati, īpašnieka kontakts, sejas izgriešana profila attēlam, reģistru numuri no sludinājuma un beigās pārbaude. Viss ir tikai ieteikumi — izlabo to, ko kamera nolasīja nepareizi.';

  @override
  String get archiveTitle => 'Arhīvs';

  @override
  String get archiveExplainer =>
      'Mirušie kaķi un tukšās kolonijas, kurām gadiem neviens nav pieskāries, joprojām aizņem vietu — jo īpaši to fotoattēli. Arhivēšana ieraksta tos failā, ko paturat, un tad izdzēš no šejienes.';

  @override
  String get archiveExplainerNeutral =>
      'Mirušie mājdzīvnieki un tukšās mājsaimniecības, kurām gadiem neviens nav pieskāries, joprojām aizņem vietu — jo īpaši to fotoattēli. Arhivēšana ieraksta tos failā, ko paturat, un tad izdzēš no šejienes.';

  @override
  String get archiveAction => 'Arhivēt';

  @override
  String archiveSelected(int count) {
    return 'Arhivēt $count ierakstus';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arhivēt $count ierakstus?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names tiks ierakstīti failā un pēc tam izdzēsti — jūsu ierīcē un katrā, ar kuru sinhronizējat. Faila imports visu atgriež; bez tā tie ir zuduši.';
  }

  @override
  String archiveDone(int count) {
    return 'Arhivēti un izdzēsti $count ieraksti';
  }

  @override
  String archiveFailed(String error) {
    return 'Nekas netika izdzēsts: arhīva failu neizdevās ierakstīt ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Datubāze $db, fotoattēli $photos $count failos';
  }

  @override
  String quietForYears(int years) {
    return 'Nemainīts $years gadus';
  }

  @override
  String get nothingToArchive => 'Nekas nav pietiekami vecs arhivēšanai.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Pēdējās izmaiņas $date · foto $size';
  }

  @override
  String get helpArchive =>
      'Vecie dati maksā vietu, jo īpaši fotoattēli, ko nes līdzi katra sinhronizētā ierīce. Šeit izvēlaties mirušos kaķus un tukšās kolonijas, kas gadiem nav mainījušās, ierakstāt tos failā, ko paturat, un izdzēšat. Dzēšana sasniedz visus, ar kuriem sinhronizējat; faila imports visu atjauno.';

  @override
  String get helpArchiveNeutral =>
      'Vecie dati maksā vietu, jo īpaši fotoattēli, ko nes līdzi katra sinhronizētā ierīce. Šeit izvēlaties mirušos mājdzīvniekus un tukšās mājsaimniecības, kas gadiem nav mainījušās, ierakstāt tos failā, ko paturat, un izdzēšat. Dzēšana sasniedz visus, ar kuriem sinhronizējat; faila imports visu atjauno.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Atjaunot $count izdzēstos ierakstus?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names šajā katalogā ir izdzēsti, un tikko importētais fails tos satur. Atjaunošana tos atgriež šeit un katrā ierīcē, ar kuru sinhronizējat.';
  }

  @override
  String get restoreAction => 'Atjaunot';

  @override
  String get keepDeleted => 'Atstāt izdzēstus';

  @override
  String get archiveNotSaved =>
      'Nekas netika izdzēsts: arhīvs netika nekur saglabāts.';

  @override
  String get locateAddress => 'Meklēt adresi kartē';

  @override
  String get addressFoundTitle => 'Adrese atrasta';

  @override
  String get replaceAddressOption => 'Aizstāt adresi ar šo';

  @override
  String get addPositionOption => 'Saglabāt atrašanās vietu';

  @override
  String get addressLocated => 'Adrese atrasta';

  @override
  String get addressNotFound =>
      'Šai adresei vieta netika atrasta. Pārbaudi rakstību vai atstāj tukšu.';

  @override
  String get starterPosition => 'Atrašanās vieta';

  @override
  String get valueYes => 'jā';

  @override
  String get valueNo => 'nē';

  @override
  String get valueFemale => 'mātīte';

  @override
  String get valueMale => 'tēviņš';

  @override
  String get valueUnknown => 'nezināms';

  @override
  String get cropTitle => 'Apgriezt foto';

  @override
  String get markTitle => 'Atzīmēt kaķi';

  @override
  String get markTitleNeutral => 'Atzīmēt mājdzīvnieku';

  @override
  String get applyCrop => 'Apgriezt';

  @override
  String get useFullPhoto => 'Izmantot visu foto';

  @override
  String get dragToSelect => 'Velciet taisnstūri ap kaķi';

  @override
  String get dragToSelectNeutral => 'Velciet taisnstūri ap mājdzīvnieku';

  @override
  String get dragOverTheCat => 'Velciet elipsi pār kaķi';

  @override
  String get dragOverTheCatNeutral => 'Velciet elipsi pār mājdzīvnieku';

  @override
  String get cropPhoto => 'Apgriezt…';

  @override
  String get markPhoto => 'Atzīmēt…';

  @override
  String get scanCode => 'Skenēt kodu';

  @override
  String get orTypeCode => 'Vai ierakstiet kodu';

  @override
  String get copyCode => 'Kopēt kodu';

  @override
  String get copied => 'Nokopēts';

  @override
  String get invalidCode => 'Šis kods nav derīgs';

  @override
  String get hotspotHint =>
      'Nav kopīga Wi-Fi? Ieslēdziet tīklāju vienā tālrunī, pievienojiet otru un uzņemiet šeit.';

  @override
  String get byMessenger => 'Ar ziņotni';

  @override
  String get byMessengerExplainer =>
      'Nosūtiet visu katalogu kā vienu failu ar WhatsApp, Signal vai e-pastu — otra puse to importē.';

  @override
  String get shareBundle => 'Kopīgot sinhronizācijas paku…';

  @override
  String get importBundle => 'Importēt sinhronizācijas paku…';

  @override
  String bundleImported(String result) {
    return 'Paka importēta: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Pēdējā automātiskā dublēšana neizdevās: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Imports neizdevās: $error';
  }

  @override
  String get pickOnMap => 'Izvēlēties kartē';

  @override
  String get useMyLocation => 'Izmantot manu atrašanās vietu';

  @override
  String get language => 'Valoda';

  @override
  String get typeUnitValue => 'Vērtība ar vienību';

  @override
  String get dimension => 'Lielums';

  @override
  String get dimensionWeight => 'Svars';

  @override
  String get dimensionLength => 'Garums';

  @override
  String get dimensionVolume => 'Tilpums';

  @override
  String get dimensionTemperature => 'Temperatūra';

  @override
  String get unitsLabel => 'Mērvienības';

  @override
  String get catalogHolds => 'Šajā katalogā';

  @override
  String get modeCats => 'Kaķi';

  @override
  String get modePets => 'Mājdzīvnieki';

  @override
  String get graphLabel => 'Grafiks';

  @override
  String get fieldHistoryTooltip => 'Vēsture';

  @override
  String get rangeWeek => 'Nedēļa';

  @override
  String get rangeMonth => 'Mēnesis';

  @override
  String get rangeYear => 'Gads';

  @override
  String get rangeAll => 'Viss';

  @override
  String get rangeCustom => 'Pielāgots…';

  @override
  String changeSince(String delta, String date) {
    return '$delta kopš $date';
  }

  @override
  String get unitsAuto => 'Kā tavā reģionā';

  @override
  String get unitsMetric => 'Metriskā (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperiālā (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Svars';

  @override
  String get systemDefault => 'Sistēmas noklusējums';

  @override
  String get iosLocalNetworkHint =>
      'Ja iPhone/iPad joprojām neizdodas: Iestatījumi → Privātums un drošība → Lokālais tīkls → atļaut cat(a)log un mēģināt vēlreiz.';

  @override
  String get includePrivate => 'Kopīgot privātos datus';

  @override
  String get hideLabel => 'Paslēpt šajā ierīcē';

  @override
  String get unhideLabel => 'Rādīt atkal';

  @override
  String get showHiddenLabel => 'Rādīt paslēptos';

  @override
  String get stopShowingHidden => 'Pārtraukt rādīt paslēptos';

  @override
  String get starterSpecies => 'Suga';

  @override
  String get starterStatus => 'Tips';

  @override
  String get statusFoster => 'Pagaidu mājas';

  @override
  String get statusForeverHome => 'Mājas';

  @override
  String get statusClinic => 'Klīnika';

  @override
  String get statusShelter => 'Patversme';

  @override
  String get statusBarn => 'Šķūnis';

  @override
  String get valueCat => 'Kaķis';

  @override
  String get valueDog => 'Suns';

  @override
  String get valueRabbit => 'Trusis';

  @override
  String get valueGuineaPig => 'Jūrascūciņa';

  @override
  String get valueHamster => 'Kāmis';

  @override
  String get valueBird => 'Putns';

  @override
  String get valueHorse => 'Zirgs';

  @override
  String get valueTortoise => 'Bruņurupucis';

  @override
  String get valueFerret => 'Sesks';

  @override
  String get otherOption => 'Cits…';

  @override
  String get celebrationsToggle => 'Svinēt adopcijas';

  @override
  String get celebrationsSubtitle =>
      'Konfeti un gaviles, kad kaķis pārceļas uz mājām';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfeti un gaviles, kad mājdzīvnieks pārceļas uz mājām';

  @override
  String get onMapLabel => 'Kartē';

  @override
  String get showOnMap => 'Rādīt kartē';

  @override
  String get searchPlaceHint => 'Meklēt vietu vai adresi';

  @override
  String get noPlacesFound => 'Vietas nav atrastas';

  @override
  String get mapSearchHint => 'Meklēt kaķus, grupas, cilvēkus';

  @override
  String get mapSearchHintNeutral =>
      'Meklēt mājdzīvniekus, mājsaimniecības, cilvēkus';

  @override
  String get proposeAnotherName => 'Ieteikt citu vārdu';

  @override
  String get moderationTitle => 'Autori un aizliegumi';

  @override
  String get moderationSubtitle => 'Neatgriezeniski noņemt personas datus';

  @override
  String get authorsSection => 'Kurš rakstīja šajā katalogā';

  @override
  String get hardDeleteAction => 'Dzēst visu no šī autora';

  @override
  String hardDeleteWarning(Object name) {
    return 'Noņem visus $name ierakstus un fotoattēlus no šīs ierīces. Citas ierīces patur savus. Nevar atsaukt.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Apstiprināšanai ierakstiet $name';
  }

  @override
  String get alsoBan => 'Arī aizliegt — nekad vairs nepieņemt datus';

  @override
  String get bansSection => 'Aizliegumi';

  @override
  String get unbanAction => 'Noņemt aizliegumu';

  @override
  String get deletedDone => 'Dzēsts.';

  @override
  String get syncSummaryTitle => 'Kas pienāca';

  @override
  String get summaryAdopted => 'Adoptēti';

  @override
  String get summaryDeceased => 'Miruši';

  @override
  String get summaryEscaped => 'Aizbēguši';

  @override
  String get summaryNew => 'Jauni';

  @override
  String get summaryConflicts => 'Risināmi konflikti';

  @override
  String conflictsMenu(int n) {
    return 'Konflikti ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Jūs šeit atrisinājāt konfliktu, tāpēc „Noraidīt“ nav pieejams: tas atceltu arī to.';

  @override
  String get arrivalIntro =>
      'Šīs izmaiņas jau ir jūsu katalogā. „Noraidīt” atgriež to iepriekšējā stāvoklī.';

  @override
  String get summaryUpdated => 'Atjaunināti';

  @override
  String get summaryDeleted => 'Dzēsti';

  @override
  String get keepMine => 'Paturēt manējo';

  @override
  String keptMine(String name) {
    return 'Jūsu „$name“ versija paliek šajā ierīcē.';
  }

  @override
  String get summaryMeta => 'Arī pienāca';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n izmaiņas',
      one: '$n izmaiņa',
      zero: '$n izmaiņu',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Pieņemt';

  @override
  String get rejectArrival => 'Noraidīt';

  @override
  String get photoAdded => 'Pievienots fotoattēls';

  @override
  String get photoRemoved => 'Fotoattēls noņemts';

  @override
  String metaFieldAdded(String name) {
    return 'Jauns lauks: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Lauks mainīts: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser apvienots ar $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n fotoattēli',
      one: '$n fotoattēls',
      zero: '$n fotoattēlu',
    );
    return '$_temp0';
  }

  @override
  String get starterMother => 'Māte';

  @override
  String get starterFather => 'Tēvs';

  @override
  String get familySection => 'Ģimene';

  @override
  String get littermatesLabel => 'No viena metiena';

  @override
  String get siblingsLabel => 'Brāļi un māsas';

  @override
  String get kittensLabel => 'Kaķēni';

  @override
  String get kittensLabelNeutral => 'Mazuļi';

  @override
  String get toastSettingsTitle => 'Ko paziņot';

  @override
  String get toastSettingsSubtitle => 'Mazas ziņas pēc sinhronizācijas';

  @override
  String get toastKindAdoptions => 'Adopcijas';

  @override
  String get toastKindBirths => 'Dzimšanas';

  @override
  String get toastKindDeaths => 'Nāves';

  @override
  String get toastKindEscapes => 'Bēgšanas';

  @override
  String get toastKindMoves => 'Pārcelšanās';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptēja $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Jauns kaķēns: $cat ✨';
  }

  @override
  String toastBornNeutral(Object cat) {
    return '✨ Jaundzimušais: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat ir miris';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat aizbēga';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat pārcēlās uz $home';
  }

  @override
  String get notACatlogFile => 'Tas nav cat(a)log fails';

  @override
  String get nothingNewInBundle => 'Failā nekā jauna — viss jau ir';

  @override
  String get syncChooserInPerson => 'Klātienē';

  @override
  String get syncChooserInPersonSub => 'Sinhronizācija caur Wi-Fi';

  @override
  String get syncChooserRemote => 'Attālināti';

  @override
  String get syncChooserRemoteSub =>
      'Sinhronizācija caur mapi vai USB zibatmiņu';

  @override
  String get syncChooserMessenger => 'Ziņotne';

  @override
  String get syncChooserMessengerSub =>
      'Eksports un imports caur sociālajiem tīkliem';

  @override
  String get connectToWifiFirst =>
      'Vispirms pieslēdzies Wi-Fi — tad ierīces atradīs viena otru';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vēlas sinhronizēt';
  }

  @override
  String get trustBothWaysNote => 'Katalogi tiks apmainīti abos virzienos.';

  @override
  String get allowOnce => 'Atļaut';

  @override
  String get allowAlways => 'Vienmēr atļaut šo ierīci';

  @override
  String get declineAction => 'Noraidīt';

  @override
  String get syncDeclined => 'Otra ierīce noraidīja sinhronizāciju';

  @override
  String get trustedDevicesSection => 'Vienmēr atļautās ierīces';

  @override
  String get removeTrust => 'Noņemt';

  @override
  String get hostWithoutWifi => 'Viesot bez Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Izveido pagaidu tiešo savienojumu ar otru tālruni (bez interneta). To izmanto tikai cat(a)log, un pēc sinhronizācijas tas atvienojas pats.';

  @override
  String get hotspotAndroidOnly =>
      'Šim kodam vajag divus Android tālruņus — iPhone/iPad izmanto kopīgu Wi-Fi';

  @override
  String get selectClowderHint => 'Izvēlies clowder kreisajā pusē';

  @override
  String get selectClowderHintNeutral =>
      'Izvēlies mājsaimniecību kreisajā pusē';

  @override
  String get introTitle1 => 'Jūsu kaķi kārtībā';

  @override
  String get introTitle1Neutral => 'Jūsu mājdzīvnieki kārtībā';

  @override
  String get introBody1 =>
      'Izveidojiet katram kaķim kartīti: foto, dzimums, veselība — viss, ko vēlaties pierakstīt. Kaķi ir grupēti pēc dzīvesvietas — lietotne to sauc par koloniju (clowder).';

  @override
  String get introBody1Neutral =>
      'Izveidojiet katram mājdzīvniekam, par kuru rūpējaties, kartīti: foto, dzimums, veselība — viss, ko vēlaties pierakstīt. Mājdzīvnieki ir grupēti pēc dzīvesvietas — lietotne to sauc par mājsaimniecību.';

  @override
  String get introTitle2 => 'Darbojas bez interneta';

  @override
  String get introBody2 =>
      'Viss tiek saglabāts tikai jūsu tālrunī. Bez konta, bez mākoņa. Nekas netiek augšupielādēts, ja vien paši nedalāties.';

  @override
  String get introTitle3 => 'Strādājiet kopā';

  @override
  String get introBody3 =>
      'Katrs lieto savu lietotni un laiku pa laikam apmaināties ar datiem: satiekieties un noskenējiet kodu, izmantojiet koplietotu mapi vai nosūtiet vienu failu ziņotnē. Pēc tam visiem ir viena un tā pati informācija.';

  @override
  String get introSkip => 'Izlaist';

  @override
  String get introNext => 'Tālāk';

  @override
  String get introDone => 'Aiziet';

  @override
  String get introReplayTitle => 'Ātrs ievads';

  @override
  String get spotHomeSync =>
      'Šeit sinhronizējaties ar paziņām. Jūs izlemjat, ar ko dalīties.';

  @override
  String get spotHomeStrays =>
      'Šī kartīte apkopo visus klaiņotājus — kaķus bez mājām. Pieskarieties sarakstam.';

  @override
  String get spotHomeStraysNeutral =>
      'Šī kartīte apkopo visus klaiņotājus — mājdzīvniekus bez mājām. Pieskarieties sarakstam.';

  @override
  String get spotHomeMenu =>
      'Šajā izvēlnē: iestatījumi, dublikātu meklēšana un apvienošana, CSV eksports un vairāk.';

  @override
  String get spotCatEdit =>
      'Pieskarieties zīmulim, lai rediģētu kaķi. Padoms: ilgi turot lauku, rediģēsiet to uzreiz.';

  @override
  String get spotCatEditNeutral =>
      'Pieskarieties zīmulim, lai rediģētu mājdzīvnieku. Padoms: ilgi turot lauku, rediģēsiet to uzreiz.';

  @override
  String get spotMapLayers =>
      'Meklējat pazudušu kaķi? Parādiet apļus ap tā sludinājumu vietām un ap māju, no kuras tas aizbēga.';

  @override
  String get spotMapLayersNeutral =>
      'Meklējat pazudušu mājdzīvnieku? Parādiet apļus ap tā sludinājumu vietām un ap māju, no kuras tas aizbēga.';

  @override
  String get spotStraysFlier =>
      'Sludinājums par pazudušu kaķi? Nofotografējiet to šeit — lietotne saglabā kaķi un kontaktu jūsu vietā.';

  @override
  String get spotStraysFlierNeutral =>
      'Sludinājums par pazudušu mājdzīvnieku? Nofotografējiet to šeit — lietotne saglabā mājdzīvnieku un kontaktu jūsu vietā.';

  @override
  String get spotStraysScan =>
      'Dažiem sludinājumiem ir cat(a)log QR kods. Noskenējiet to šeit un importējiet kaķi bez rakstīšanas.';

  @override
  String get spotStraysScanNeutral =>
      'Dažiem sludinājumiem ir cat(a)log QR kods. Noskenējiet to šeit un importējiet mājdzīvnieku bez rakstīšanas.';

  @override
  String get introTitle4 => 'Atrodiet pazudušos kaķus';

  @override
  String get introTitle4Neutral => 'Atrodiet pazudušos mājdzīvniekus';

  @override
  String get introBody4 =>
      'Redzat sludinājumu par pazudušu kaķi? Nofotografējiet to lietotnē: tā saglabā kaķi, saimnieka kontaktu un vietu. Ja vēlāk parādīsies līdzīgs klaiņotājs, lietotne ieteiks iespējamās sakritības.';

  @override
  String get introBody4Neutral =>
      'Redzat sludinājumu par pazudušu mājdzīvnieku? Nofotografējiet to lietotnē: tā saglabā mājdzīvnieku, saimnieka kontaktu un vietu. Ja vēlāk parādīsies līdzīgs klaiņotājs, lietotne ieteiks iespējamās sakritības.';

  @override
  String get spotMapSearch =>
      'Ierakstiet kaķi, vietu vai cilvēku, lai kartē pārlektu turp.';

  @override
  String get spotMapSearchNeutral =>
      'Ierakstiet mājdzīvnieku, vietu vai cilvēku, lai kartē pārlektu turp.';

  @override
  String get spotCardChips =>
      'Atzīmējiet, kam jābūt koplietojamā kartītē — pārējais paliek ārpusē.';

  @override
  String get spotCatMenu =>
      'Šeit ir vēl darbības: paslēpt kaķi, apvienot dublikātus vai pierakstīt novērojumu.';

  @override
  String get spotCatMenuNeutral =>
      'Šeit ir vēl darbības: paslēpt mājdzīvnieku, apvienot dublikātus vai pierakstīt novērojumu.';

  @override
  String get spotDone => 'Skaidrs';

  @override
  String get spotReplayTitle => 'Jaunumu tūre';

  @override
  String get spotReplaySubtitle => 'Rādīt padomus atkal katrā lapā';

  @override
  String get spotReplayDone => 'Padomi tiks rādīti atkal';

  @override
  String get searchNoResults => 'Kaķis ar šādu vārdu nav atrasts';

  @override
  String get searchNoResultsNeutral => 'Mājdzīvnieks ar šādu vārdu nav atrasts';

  @override
  String get syncUnreachable =>
      'Neizdevās sasniegt otru ierīci. Vai abas ir vienā Wi-Fi tīklā?';

  @override
  String get folderUnreachable =>
      'Neizdevās sasniegt mapi. Vai disks vai mākoņa mape vēl pastāv?';

  @override
  String get crashTitle => 'Tam nevajadzēja notikt';

  @override
  String get crashBody =>
      'cat(a)log saskārās ar negaidītu kļūdu. Tavi dati ir drošībā — viss saglabājas izmaiņu brīdī. Restartē lietotni, un ja tas atkārtojas, nosūti ziņojumu, lai to var izlabot.';

  @override
  String get crashRestart => 'Restartēt lietotni';

  @override
  String get crashSendReport => 'Nosūtīt ziņojumu izstrādātājam';

  @override
  String get crashLastRunBody =>
      'cat(a)log pagājušajā reizē negaidīti apstājās — visticamāk pietrūka atmiņas. Nosūtīt īsu ziņojumu, lai izlabotu?';

  @override
  String get catalogsTitle => 'Katalogi';

  @override
  String get newCatalog => 'Jauns katalogs';

  @override
  String get intoCatalog => 'Katalogā';

  @override
  String get catalogNameLabel => 'Kataloga nosaukums';

  @override
  String catalogNameTaken(String name) {
    return 'Katalogs ar nosaukumu $name jau pastāv. Izvēlies citu nosaukumu.';
  }

  @override
  String get manageCatalogs => 'Pārvaldīt katalogus';

  @override
  String get helpCatalogs =>
      'Katalogs ir pasaule pati par sevi: savi kaķi, kolonijas, lauki, fotoattēli un sinhronizācijas partneri. Berlīne un Parīze nekad nesajaucas. Pieskarieties katalogam, lai uz to pārslēgtos. Zobrats pie kataloga atver tā iestatījumus: nosaukums, kaķi vai dzīvnieki, lauki, autori un bloķējumi, arhīvs, atgriešanās, dzēšana. Jūsu vārds, valoda un jau redzētie padomi ir kopīgi visiem.';

  @override
  String get helpCatalogsNeutral =>
      'Katalogs ir pasaule pati par sevi: savi dzīvnieki, mājsaimniecības, lauki, fotoattēli un sinhronizācijas partneri. Berlīne un Parīze nekad nesajaucas. Pieskarieties katalogam, lai uz to pārslēgtos. Zobrats pie kataloga atver tā iestatījumus: nosaukums, kaķi vai dzīvnieki, lauki, autori un bloķējumi, arhīvs, atgriešanās, dzēšana. Jūsu vārds, valoda un jau redzētie padomi ir kopīgi visiem.';

  @override
  String get helpCatalogSettings =>
      'Viss, kas pieder tikai šim katalogam: nosaukums, vai tajā ir kaķi vai dzīvnieki, lauki, autori un bloķējumi, arhīvs un atgriešanās laikā. Izmaiņas šeit skar tikai šo katalogu — arī tādu, kurā šobrīd neesat. Dzēšana vispirms ieraksta katalogu failā.';

  @override
  String get spotHomeCatalog =>
      'Šis ir katalogs, kurā esi. Pieskaries nosaukumam, lai pārslēgtu vai izveidotu jaunu.';

  @override
  String get deleteCatalog => 'Dzēst katalogu';

  @override
  String get catalogSettings => 'Kataloga iestatījumi';

  @override
  String deleteCatalogBody(String name) {
    return 'Viss katalogā $name pazūd: kaķi, fotoattēli, vēsture. Vispirms tur, kur nonāk automātiskās rezerves kopijas, tiek saglabāts pilns fails — tā imports katalogu atgriež. Apstiprini, ierakstot parādīto vārdu.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Viss katalogā $name pazūd: mājdzīvnieki, fotoattēli, vēsture. Vispirms tur, kur nonāk automātiskās rezerves kopijas, tiek saglabāts pilns fails — tā imports katalogu atgriež. Apstiprini, ierakstot nosaukumu.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name dzēsts. Fails ir $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Ieraksti $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nekas netika dzēsts: kataloga failu neizdevās ierakstīt ($error). Atbrīvo vietu vai mēģini vēlāk.';
  }

  @override
  String get moveToCatalog => 'Pārvietot uz citu katalogu';

  @override
  String movedToCatalog(int count, String name) {
    return '$count pārvietoti uz $name';
  }

  @override
  String get chooseWhatToMove => 'Kas pārvietojas?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Pārvietot kaut ko uz $name?';
  }

  @override
  String get undoThisImport => 'Atsaukt šo importu';

  @override
  String undoImportBody(int count) {
    return '$count šī importa izmaiņas tiks noņemtas. Vispirms tās tiek ierakstītas failā, kura imports tās atgriež. Tie, ar kuriem jau sinhronizēji, patur savu kopiju — to atsaukt nevar.';
  }

  @override
  String undoneImport(String where) {
    return 'Atsaukts. Fails ir $where.';
  }

  @override
  String get goBackTitle => 'Doties atpakaļ';

  @override
  String get goBackToHere => 'Atgriezties šeit';

  @override
  String get momentImport => 'Pirms importa';

  @override
  String get momentSync => 'Pirms sinhronizācijas';

  @override
  String get momentMerge => 'Pirms apvienošanas';

  @override
  String get momentHardDelete => 'Pirms viena autora datu dzēšanas';

  @override
  String get momentArchive => 'Pirms arhivēšanas';

  @override
  String get momentManual => 'Tevis atzīmēts';

  @override
  String get showOlderMoments => 'Rādīt vecākus';

  @override
  String goBackBody(int count) {
    return 'Viss pēc šī brīža tiek noņemts — $count izmaiņas. Vispirms tas tiek ierakstīts failā, kura imports visu atgriež, un katrs jaunāks brīdis pazūd līdzi. Tie, ar kuriem jau sinhronizēji, patur kopiju — to atsaukt nevar.';
  }

  @override
  String get nameThisMoment => 'Nosauc šo brīdi';

  @override
  String get helpGoBack =>
      'Brīži, kad šis katalogs mainīja formu: pirms katra importa un katras sinhronizācijas, pirms apvienošanas, arhivēšanas vai dzēšanas, un ikreiz, kad pats atzīmēji brīdi. Izvēloties vienu, katalogs atgriežas tajā stāvoklī — viss pēc tā tiek ierakstīts failā, ko paturi, un tad noņemts, un katrs jaunāks brīdis pazūd līdzi. Tie, ar kuriem jau sinhronizēji, patur saņemto.';

  @override
  String goBackFileFailed(String error) {
    return 'Nekas netika noņemts: failu, kas to saglabā, neizdevās ierakstīt ($error). Atbrīvo vietu un mēģini vēlreiz.';
  }

  @override
  String get goBackChanged =>
      'Nekas netika noņemts: katalogs mainījās, kamēr fails tika saglabāts. Mēģini vēlreiz.';

  @override
  String get switchBeforeDeleting =>
      'Šis ir katalogs, kurā esi. Pārslēdzies uz citu un tad dzēs to.';

  @override
  String shareFileFailed(String error) {
    return 'Koplietošanas failu neizdevās ierakstīt ($error). Atbrīvo vietu un mēģini vēlreiz.';
  }

  @override
  String get privateLabel => 'Privāts';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalogs: $name';
  }

  @override
  String get markPrivate => 'Atzīmēt kā privātu';

  @override
  String get unmarkPrivate => 'Noņemt privātuma atzīmi';

  @override
  String get agenda => 'Atgādinājumi';

  @override
  String get reminderLabel => 'Atgādinājums';

  @override
  String get agendaEmpty =>
      'Nav ieplānotu vizīšu. Jaunas plāno šeit ar plusu vai kaķa vai klaudera lapā.';

  @override
  String get agendaEmptyNeutral =>
      'Nav ieplānotu vizīšu. Jaunas plāno šeit ar plusu vai mājdzīvnieka vai mājsaimniecības lapā.';

  @override
  String get dueToday => 'šodien';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pēc $count dienām',
      one: 'pēc $count dienas',
      zero: 'pēc $count dienām',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'nokavēts par $count dienām',
      one: 'nokavēts par $count dienu',
      zero: 'nokavēts par $count dienām',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Izdarīts';

  @override
  String get repeatTitle => 'Atkal pēc…';

  @override
  String get noRepeatLabel => 'Bez atkārtošanas';

  @override
  String get unitDays => 'dienām';

  @override
  String get unitWeeks => 'nedēļām';

  @override
  String get unitMonths => 'mēnešiem';

  @override
  String get unitYears => 'gadiem';

  @override
  String ageYears(int years) {
    return '$years g.';
  }

  @override
  String ageMonths(int months) {
    return '$months mēn.';
  }

  @override
  String get changeDateLabel => 'Mainīt datumu';

  @override
  String get removeReminderLabel => 'Noņemt atgādinājumu';

  @override
  String get exportIcs => 'Eksportēt kalendāra failu';

  @override
  String get resyncCalendar => 'Sinhronizēt kalendāru vēlreiz';

  @override
  String icsSavedTo(String path) {
    return 'Kalendāra fails saglabāts $path';
  }

  @override
  String get calendarMirrorLabel => 'Atspoguļot ierīces kalendārā';

  @override
  String get calendarMirrorSubtitle =>
      'Vizītes kalendārā parādās kā visas dienas notikumi. cat(a)log tās tur atjaunina katrā palaišanā un pēc katras izmaiņas. Vizīšu atgādinājumus pārvaldi kalendārā.';

  @override
  String get syncPeerOlder =>
      'Otrā ierīcē ir vecāks cat(a)log bez atgādinājumiem. Atjaunini cat(a)log tur un sinhronizē vēlreiz.';

  @override
  String get syncPeerNewer =>
      'Otrā ierīcē ir jaunāks cat(a)log. Atjaunini cat(a)log šajā ierīcē un sinhronizē vēlreiz.';

  @override
  String get syncPeerNoTls =>
      'Otrā ierīcē ir cat(a)log pirms 1.1.0, bez šifrētas sinhronizācijas. Atjaunini tur cat(a)log un sinhronizē vēlreiz.';

  @override
  String get syncWrongHost =>
      'Sertifikāts neatbilst pārī savienošanas kodam — šī nav ierīce, no kuras kods nāca. Noskenē vai ievadi kodu vēlreiz.';

  @override
  String get bundleNewerError =>
      'Šis fails ir no jaunāka cat(a)log. Atjaunini cat(a)log šajā ierīcē, lai to importētu.';

  @override
  String get spotEar =>
      'Maza kaķa auss stūrī nozīmē: turi nospiestu, lai redzētu vairāk.';

  @override
  String get addReminder => 'Pievienot atgādinājumu';

  @override
  String get plannedSection => 'Ieplānots';

  @override
  String get reminderDialogHint =>
      'Vizīte rādās atgādinājumos. Tur vari to apstiprināt vai noraidīt. Vērtība tiek pārņemta tikai tad, ja vizīte ir apstiprināta.';

  @override
  String get reminderFor => 'Kam';

  @override
  String get reminderField => 'Lauks';

  @override
  String get dueDateLabel => 'Termiņš';

  @override
  String get pickCalendar => 'Kurš kalendārs?';

  @override
  String get calendarPermissionDenied =>
      'Piekļuve kalendāram ir bloķēta, tāpēc atspoguļošana ir izslēgta. Atļauj to sistēmas iestatījumos un ieslēdz atspoguļošanu vēlreiz.';

  @override
  String get calendarNotChosen =>
      'Kalendārs nav izvēlēts, tāpēc atspoguļošana ir izslēgta. Ieslēdz to vēlreiz un izvēlies kalendāru.';

  @override
  String get calendarGone =>
      'Izvēlētais kalendārs vairs nepastāv, tāpēc atspoguļošana ir izslēgta. Ieslēdz to vēlreiz un izvēlies citu.';

  @override
  String get noWritableCalendar =>
      'Kalendārs nav atrasts. Sistēmas iestatījumos pieslēdzies kalendāra kontam, piemēram Google, un mēģini vēlreiz.';

  @override
  String get spotHomeAgenda =>
      'Atgādinājumi: ieplānoto vizīšu saraksts — veterinārārsts, zāles, pārbaudes.';

  @override
  String get spotAgendaAdd => 'Ieplānot jaunu vizīti.';

  @override
  String get spotAgendaCalendar =>
      'Šeit ieslēdz cat(a)log vizīšu atspoguļošanu izvēlētā kalendārā.';

  @override
  String get helpAgenda =>
      'Atgādinājumi rāda ieplānotās vizītes pēc datuma. Ir divi veidi: vizītes ar pulksteņa laiku un atgādinājumi, kas attiecas uz dienu. Nokavētās paliek augšā. Pieskāriens atver kaķi vai klauderi. Ķeksītis apstiprina vizīti: vērtība tiek ierakstīta laukā, un uzreiz vari ieplānot nākamo, piemēram, pēc trim mēnešiem. Turēšana maina datumu vai dzēš vizīti. Slēdzis augšā atspoguļo vizītes tava tālruņa kalendārā. Izvēlne tās eksportē kā kalendāra failu. Vizīte pie veterinārārsta ar vairākiem kaķiem ir viens pieraksts: atzīmē kaķus, Dienaskārtība rāda vienu kartīti ar to vārdiem, un pabeidzot jautā, kuri kaķi tika ārstēti — noņem atzīmi pārējiem, tie paliek plānoti.';

  @override
  String get helpAgendaNeutral =>
      'Atgādinājumi rāda ieplānotās vizītes pēc datuma. Ir divi veidi: vizītes ar pulksteņa laiku un atgādinājumi, kas attiecas uz dienu. Nokavētās paliek augšā. Pieskāriens atver mājdzīvnieku vai mājsaimniecību. Ķeksītis apstiprina vizīti: vērtība tiek ierakstīta laukā, un uzreiz vari ieplānot nākamo, piemēram, pēc trim mēnešiem. Turēšana maina datumu vai dzēš vizīti. Slēdzis augšā atspoguļo vizītes tava tālruņa kalendārā. Izvēlne tās eksportē kā kalendāra failu. Vizīte pie veterinārārsta ar vairākiem mājdzīvniekiem ir viens pieraksts: atzīmē mājdzīvniekus, Dienaskārtība rāda vienu kartīti ar to vārdiem, un pabeidzot jautā, kuri mājdzīvnieki tika ārstēti — noņem atzīmi pārējiem, tie paliek plānoti.';

  @override
  String get calendarRowOff => 'Kalendārs: izslēgts';

  @override
  String calendarRowOn(String name) {
    return 'Kalendārs: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Ieplāno vizīti šim kaķim. Tā rādās atgādinājumos un tur tiek apstiprināta.';

  @override
  String get spotAddReminderCatNeutral =>
      'Ieplāno vizīti šim mājdzīvniekam. Tā rādās atgādinājumos un tur tiek apstiprināta.';

  @override
  String get spotAddReminderClowder =>
      'Ieplāno vizīti šim klauderim. Tā rādās atgādinājumos un tur tiek apstiprināta.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Ieplāno vizīti šai mājsaimniecībai. Tā rādās atgādinājumos un tur tiek apstiprināta.';

  @override
  String get readOnlyCalendar => 'tikai lasāms';

  @override
  String get appointmentLabel => 'Vizīte';

  @override
  String get addAppointment => 'Pievienot vizīti';

  @override
  String get planChooserTitle => 'Vizīte vai atgādinājums?';

  @override
  String get planChooserAppointment =>
      'Vizīte — apmeklējums datumā un laikā, ar piezīmēm';

  @override
  String get planChooserReminder =>
      'Atgādinājums — vērtība, kurai kādā dienā pienāk termiņš';

  @override
  String get appointmentTitleLabel => 'Kas';

  @override
  String get notesLabel => 'Piezīmes';

  @override
  String get timeLabel => 'Laiks';

  @override
  String get allDayLabel => 'Visu dienu';

  @override
  String get alertLabel => 'Brīdinājums';

  @override
  String get alertNone => 'Nav';

  @override
  String get alertDayBefore => 'Dienu iepriekš';

  @override
  String get alertHourBefore => 'Stundu iepriekš';

  @override
  String get linkFieldLabel => 'Pabeidzot ierakstīt laukā';

  @override
  String get noLinkedField => 'Nav lauka';

  @override
  String get outcomeTitle => 'Kā gāja?';

  @override
  String get finishLabel => 'Pabeigt';

  @override
  String get editLabelAppointment => 'Rediģēt vizīti';

  @override
  String get deleteAppointment => 'Dzēst vizīti';

  @override
  String get stepFlierText => 'Sludinājuma teksts';

  @override
  String get qrFoundHint =>
      'Sludinājumā atrasts QR kods. Atzīmētie kodi tiek lasīti reģistra numuriem un saitēm.';

  @override
  String get useCode => 'Izmantot šo kodu';

  @override
  String get qrNone => 'Fotoattēlā QR kods nav atrasts.';

  @override
  String qrFailed(String error) {
    return 'QR koda nolasīšana neizdevās: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Atpazīts $name sludinājums. Pārbaudi zemāk, kurā laukā nonāk katra rinda.';
  }

  @override
  String get flierLayoutUnknown =>
      'Nezināms sludinājuma izkārtojums. Piešķir rindas laukiem zemāk; pārējais paliek piezīmēs.';

  @override
  String get targetRegistryNumber => 'Reģistra numurs';

  @override
  String get targetLostPlace => 'Adrese (pazušanas vieta)';

  @override
  String get targetContact => 'Reģistra kontakts';

  @override
  String get targetDrop => 'Atmest';

  @override
  String get existingCat => 'Esošs kaķis';

  @override
  String get existingCatNeutral => 'Esošs mājdzīvnieks';

  @override
  String get existingClowder => 'Esoša grupa';

  @override
  String get existingClowderNeutral => 'Esoša mājsaimniecība';

  @override
  String get createNewInstead => 'Nav — izveidot jaunu';

  @override
  String overwritesValue(String value) {
    return 'Pārraksta pašreizējo vērtību \"$value\"';
  }

  @override
  String get abortScanTitle => 'Pārtraukt skenēšanu?';

  @override
  String get abortScanBody => 'Nekas netiks saglabāts.';

  @override
  String get abortScan => 'Pārtraukt';

  @override
  String get keepScanning => 'Turpināt';

  @override
  String get catsOnAppointment => 'Kaķi šajā pierakstā';

  @override
  String get catsOnAppointmentNeutral => 'Mājdzīvnieki šajā pierakstā';

  @override
  String get noCatsHint =>
      'Neviens kaķis nav atzīmēts — pieraksts pieder pašai kolonijai.';

  @override
  String get noCatsHintNeutral =>
      'Neviens mājdzīvnieks nav atzīmēts — pieraksts pieder pašai mājsaimniecībai.';

  @override
  String get pickCatsTitle => 'Kuri kaķi brauc līdzi?';

  @override
  String get pickCatsTitleNeutral => 'Kuri mājdzīvnieki brauc līdzi?';

  @override
  String catsCount(int count) {
    return '$count kaķi';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count mājdzīvnieki';
  }

  @override
  String get finishUntickHint =>
      'Noņem atzīmi kaķiem, kuri netika ārstēti; tie paliek plānoti.';

  @override
  String get finishUntickHintNeutral =>
      'Noņem atzīmi mājdzīvniekiem, kuri netika ārstēti; tie paliek plānoti.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Dzēst pierakstu visiem $count kaķiem';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Dzēst pierakstu visiem $count mājdzīvniekiem';
  }
}
