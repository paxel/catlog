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
  String get noClowdersYet =>
      'Vēl nav neviena clowdera. Clowder ir vieta, kur dzīvo kaķi — tavas pagaidu mājas, adoptētāja dzīvoklis. Izveido pirmo zemāk.';

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
      'Kaķis pazūd no visiem sarakstiem, un tā fotoattēli tiek noņemti — šeit un pēc nākamās sinhronizācijas arī citās ierīcēs.';

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
  String get privateNoShare =>
      'Šis kaķis ir atzīmēts kā privāts — privāti dati nekad nepamet jūsu ierīci. Vispirms noņemiet atzīmi, lai kopīgotu publiski.';

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
  String get genderFatherFemale =>
      'Šis kaķis ir reģistrēts kā citu kaķu tēvs — tēvs nevar būt kaķene. Vispirms pārbaudiet ģimeni.';

  @override
  String get genderMotherMale =>
      'Šis kaķis ir reģistrēts kā citu kaķu māte — māte nevar būt runcis. Vispirms pārbaudiet ģimeni.';

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
  String dateFormatError(String format) {
    return 'Nepareizs formāts — izmantojiet $format';
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
  String get applyCrop => 'Apgriezt';

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
  String get systemDefault => 'Sistēmas noklusējums';

  @override
  String get iosLocalNetworkHint =>
      'Ja iPhone/iPad joprojām neizdodas: Iestatījumi → Privātums un drošība → Lokālais tīkls → atļaut cat(a)log un mēģināt vēlreiz.';

  @override
  String get markPrivate => 'Atzīmēt kā privātu';

  @override
  String get unmarkPrivate => 'Noņemt privātuma atzīmi';

  @override
  String get includePrivate => 'Iekļaut privātos datus';

  @override
  String get includePrivateExplainer =>
      'Tā tiek nosūtīts arī viss, ko atzīmējāt kā privātu. Tas, ar ko sinhronizējat, to redzēs.';

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
  String get statusForeverHome => 'Pastāvīgās mājas';

  @override
  String get statusClinic => 'Klīnika';

  @override
  String get statusShelter => 'Patversme';

  @override
  String get statusBarn => 'Šķūnis';

  @override
  String get valueCat => 'Kaķis';

  @override
  String get otherOption => 'Cits…';

  @override
  String get celebrationsToggle => 'Svinēt adopcijas';

  @override
  String get celebrationsSubtitle =>
      'Konfeti un gaviles, kad kaķis pārceļas uz pastāvīgajām mājām';

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
  String summaryOther(Object n) {
    return '…un vēl $n izmaiņas';
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
  String get syncChooserInPersonSub =>
      'Esat vienā telpā — noskenē kodu, gatavs sekundēs';

  @override
  String get syncChooserRemote => 'Attālināti';

  @override
  String get syncChooserRemoteSub =>
      'Caur koplietotu mapi kā Dropbox vai USB zibatmiņu';

  @override
  String get syncChooserMessenger => 'Ziņotne';

  @override
  String get syncChooserMessengerSub =>
      'Sūtiet visu kā vienu failu ar jebkuru ziņotni — un importējiet saņemto .catsync failu šeit';

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
  String get introTitle1 => 'Jūsu kaķi kārtībā';

  @override
  String get introBody1 =>
      'Izveidojiet katram kaķim kartīti: foto, dzimums, veselība — viss, ko vēlaties pierakstīt. Kaķi ir grupēti pēc dzīvesvietas — lietotne to sauc par koloniju (clowder).';

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
  String get spotHomeMenu =>
      'Šajā izvēlnē: atrast un apvienot dublikātus, eksportēt CSV un vēl.';

  @override
  String get spotCatEdit =>
      'Pieskarieties zīmulim, lai rediģētu kaķi. Padoms: ilgi turot lauku, rediģēsiet to uzreiz.';

  @override
  String get spotMapLayers =>
      'Meklējat pazudušu kaķi? Parādiet apļus ap tā sludinājumu vietām un ap māju, no kuras tas aizbēga.';

  @override
  String get spotStraysFlier =>
      'Sludinājums par pazudušu kaķi? Nofotografējiet to šeit — lietotne saglabā kaķi un kontaktu jūsu vietā.';

  @override
  String get spotStraysScan =>
      'Dažiem sludinājumiem ir cat(a)log QR kods. Noskenējiet to šeit un importējiet kaķi bez rakstīšanas.';

  @override
  String get introTitle4 => 'Atrodiet pazudušos kaķus';

  @override
  String get introBody4 =>
      'Redzat sludinājumu par pazudušu kaķi? Nofotografējiet to lietotnē: tā saglabā kaķi, saimnieka kontaktu un vietu. Ja vēlāk parādīsies līdzīgs klaiņotājs, lietotne ieteiks iespējamās sakritības.';

  @override
  String get spotMapSearch =>
      'Ierakstiet kaķi, vietu vai cilvēku, lai kartē pārlektu turp.';

  @override
  String get spotCardChips =>
      'Atzīmējiet, kam jābūt koplietojamā kartītē — pārējais paliek ārpusē.';

  @override
  String get spotCatMenu =>
      'Vairāk darbību šeit: atzīmējiet kaķi kā privātu, paslēpiet to, apvienojiet dublikātus vai pierakstiet novērojumu.';

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
}
