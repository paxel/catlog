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
  String get noClowdersYet => 'Klauderu vēl nav.\nIzveidojiet pirmo zemāk.';

  @override
  String get strays => 'Klaiņojošie kaķi';

  @override
  String get searchCats => 'Meklēt kaķus';

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
  String get newClowder => 'Jauns klauderis';

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
  String get rename => 'Pārdēvēt';

  @override
  String get timeline => 'Laika skala';

  @override
  String get mergeInto => 'Apvienot ar…';

  @override
  String get deleteClowder => 'Dzēst klauderi';

  @override
  String get cats => 'Kaķi';

  @override
  String get addCat => 'Pievienot kaķi';

  @override
  String get newCat => 'Jauns kaķis';

  @override
  String deleteQuestion(String name) {
    return 'Dzēst $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Klauderis pazūd no saraksta.';

  @override
  String deleteClowderBody(int count) {
    return 'Tā kaķi ($count) netiek dzēsti — tie kļūst klaiņojoši. Ja to nevēlaties, vispirms pārvietojiet tos uz citu klauderi.';
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
  String get seenHereNow => 'Tikko redzēts šeit';

  @override
  String get deleteCat => 'Dzēst kaķi';

  @override
  String get clowderLabel => 'Klauderis';

  @override
  String get strayNoClowder => 'Klaiņojošs — bez klaudera';

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
      'Kaķis pazūd no visiem sarakstiem. Tā fotoattēli tiek dzēsti neatgriezeniski.';

  @override
  String get sightingRecorded => 'Novērojums ierakstīts jūsu pozīcijā.';

  @override
  String get noLocationAvailable =>
      'Atrašanās vieta nav pieejama — tā vietā turiet nospiestu karti.';

  @override
  String get moveTo => 'Pārvietot uz';

  @override
  String get noClowderStrayOption => 'Bez klaudera — klaiņojošs / aizbēga';

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
  String get forClowders => 'klauderiem';

  @override
  String get forBoth => 'abiem';

  @override
  String get optionsOnePerLine => 'Iespējas (pa vienai rindā)';

  @override
  String get renameField => 'Pārdēvēt lauku';

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
  String get host => 'Uzņemt';

  @override
  String get hostExplainer =>
      'Sāciet šeit, tad otrā ierīcē ievadiet adresi un PIN.';

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
      'Sinhronizējiet caur mapi, ko starp ierīcēm pārnēsā mākonis vai USB zibatmiņa — tiem, kas nav vienā tīklā.';

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
  String get orPlaceClowderHere => 'Vai novietot klauderi šeit:';

  @override
  String trailOf(String name, int count) {
    return 'Maršruts: $name ($count novērojumi)';
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
  String get kindClowder => 'klauderis';

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
  String get coffeeSubtitle => 'Pilnīgi brīvprātīgi — lietotne ir bezmaksas';

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
  String get starterPosition => 'Pozīcija';

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
  String get useFullPhoto => 'Izmantot visu foto';

  @override
  String get dragToSelect => 'Velciet taisnstūri ap kaķi';

  @override
  String get dragOverTheCat => 'Velciet elipsi pār kaķi';

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
  String get systemDefault => 'Sistēmas noklusējums';

  @override
  String get iosLocalNetworkHint =>
      'Ja iPhone/iPad joprojām neizdodas: Iestatījumi → Privātums un drošība → Lokālais tīkls → atļaut cat(a)log un mēģināt vēlreiz.';

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
}
