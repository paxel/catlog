// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Maltese (`mt`).
class AppLocalizationsMt extends AppLocalizations {
  AppLocalizationsMt([String locale = 'mt']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Merħba f\'cat(a)log';

  @override
  String get welcomeBody =>
      'Agħżel isem għalik. Kull bidla tiġi rreġistrata taħt dan l-isem, biex l-oħrajn jaraw min għamel xiex.';

  @override
  String get yourName => 'Ismek';

  @override
  String get start => 'Ibda';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet =>
      'Għad m\'hemmx clowders. Clowder huwa post fejn jgħixu l-qtates — id-dar tal-fostering tiegħek, appartament ta\' min jadotta. Oħloq l-ewwel wieħed hawn taħt.';

  @override
  String get strays => 'Qtates tat-triq';

  @override
  String get searchCats => 'Fittex qtates';

  @override
  String get map => 'Mappa';

  @override
  String get sync => 'Sinkronizzazzjoni';

  @override
  String get fields => 'Oqsma';

  @override
  String get exportCsv => 'Esporta CSV';

  @override
  String get aboutAndFeedback => 'Dwar & feedback';

  @override
  String get newClowder => 'Clowder ġdid';

  @override
  String get name => 'Isem';

  @override
  String get cancel => 'Ikkanċella';

  @override
  String get create => 'Oħloq';

  @override
  String get save => 'Issejvja';

  @override
  String get delete => 'Ħassar';

  @override
  String get merge => 'Għaqqad';

  @override
  String get resolve => 'Iddeċiedi';

  @override
  String get open => 'Iftaħ';

  @override
  String csvSavedTo(String path) {
    return 'CSV salvat f\'$path';
  }

  @override
  String get renameClowder => 'Ibdel isem il-clowder';

  @override
  String get rename => 'Ibdel l-isem';

  @override
  String get timeline => 'Linja taż-żmien';

  @override
  String get mergeInto => 'Għaqqad ma\'…';

  @override
  String get deleteClowder => 'Ħassar il-clowder';

  @override
  String get cats => 'Qtates';

  @override
  String get addCat => 'Żid qattus';

  @override
  String get newCat => 'Qattus ġdid';

  @override
  String deleteQuestion(String name) {
    return 'Tħassar $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Il-clowder jisparixxi mil-lista.';

  @override
  String deleteClowderBody(int count) {
    return 'Il-qtates tiegħu ($count) ma jitħassrux — isiru tat-triq. Mexxihom l-ewwel fi clowder ieħor jekk mhux dan li trid.';
  }

  @override
  String get card => 'Karta';

  @override
  String get shareAsImage => 'Aqsam bħala immaġni';

  @override
  String get shareAsPdf => 'Aqsam bħala PDF';

  @override
  String get print => 'Ipprintja';

  @override
  String cardTitle(String name) {
    return 'Karta — $name';
  }

  @override
  String get renameCat => 'Ibdel isem il-qattus';

  @override
  String get seenHereNow => 'Rajtu hawn issa';

  @override
  String get deleteCat => 'Ħassar il-qattus';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Tat-triq — bla clowder';

  @override
  String get stray => 'Tat-triq';

  @override
  String get photos => 'Ritratti';

  @override
  String get addPhoto => 'Żid ritratt';

  @override
  String get setAsProfileImage => 'Issettja bħala ritratt tal-profil';

  @override
  String get thisIsProfileImage => 'Dan hu r-ritratt tal-profil';

  @override
  String get deletePhoto => 'Ħassar ir-ritratt';

  @override
  String get deletePhotoTitle => 'Tħassar ir-ritratt?';

  @override
  String get deletePhotoBody =>
      'Id-data tar-ritratt titħassar għal dejjem — ma tistax terġa\' lura.';

  @override
  String get deleteCatBody =>
      'Il-qattus jisparixxi mil-listi kollha u r-ritratti tiegħu jitneħħew — hawn u, wara s-sync li jmiss, fuq l-apparati l-oħra wkoll.';

  @override
  String get sightingRecorded =>
      'Id-dehra ġiet irreġistrata fil-pożizzjoni tiegħek.';

  @override
  String get noLocationAvailable =>
      'M\'hemmx lok disponibbli — minflok agħfas fit-tul fuq il-mappa.';

  @override
  String get locationDeniedForever =>
      'L-aċċess għall-post huwa mblukkat. Ħallih fis-settings tas-sistema biex tuża Stray Cam.';

  @override
  String get locationServiceOff =>
      'Il-post huwa mitfi fuq dan l-apparat. Ixegħlu fis-settings u erġa\' pprova.';

  @override
  String get locationDenied =>
      'cat(a)log m\'għandux permess juża l-post tiegħek. Erġa\' pprova u ħallih meta tiġi mistoqsi.';

  @override
  String get locationNoFix =>
      'Il-pożizzjoni tiegħek ma setgħetx tiġi determinata bħalissa. Erġa\' pprova barra — il-GPS jeħtieġ veduta ċara tas-sema.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Numru taċ-ċippa';

  @override
  String get starterRemarks => 'Rimarki';

  @override
  String get captureFlier => 'Ħu ritratt tal-flier';

  @override
  String get addPhotosTo => 'Żid ir-ritratti ma\'…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count ritratt(i) miżjuda ma\' $name';
  }

  @override
  String get scanPrintedCode => 'Skennja kodiċi stampat';

  @override
  String get chipScanHint =>
      'Jiskennja l-QR/barcode stampat mill-karta taċ-ċippa jew mid-dokumenti tal-veterinarju — it-telefon ma jistax jaqra ċ-ċippa ġol-qattus.';

  @override
  String get savingLabel => 'Qed jissejvja…';

  @override
  String ownerOfCat(String name) {
    return 'Sid ta\' $name';
  }

  @override
  String get sortLabel => 'Issortja';

  @override
  String get viewAsTable => 'Uri bħala tabella';

  @override
  String get viewAsTiles => 'Uri bħala madum';

  @override
  String get viewAsList => 'Uri bħala lista';

  @override
  String get ageLabel => 'Età';

  @override
  String get catList => 'Lista tal-qtates';

  @override
  String get matchCandidatesTitle => 'Tqabbil possibbli';

  @override
  String get findDuplicates => 'Sib duplikati';

  @override
  String get noDuplicates => 'M\'hemm l-ebda duplikat possibbli bħalissa.';

  @override
  String get similarName => 'Isem simili';

  @override
  String get sharePublicly => 'Aqsam pubblikament…';

  @override
  String get pickFramesTitle => 'Agħżel frejms';

  @override
  String get suggestedFrames => 'Frejms issuġġeriti';

  @override
  String get scrubFrames => 'Skrolja l-video';

  @override
  String get keepThisFrame => 'Żomm dan il-frejm';

  @override
  String get fromVideo => 'Minn video…';

  @override
  String get videoMobileOnly =>
      'L-għażla ta\' frejms minn video taħdem fl-app tat-telefon (Android u iPhone) — għadha mhux fuq dan l-apparat.';

  @override
  String get shareWhitelistExplainer =>
      'Agħżel x\'jidħol fil-fajl. Jiġu inklużi biss l-oqsma mmarkati.';

  @override
  String get exportShareFile => 'Esporta l-fajl tal-qsim…';

  @override
  String get hostedLink => 'Link ospitat (URL tal-fajl imtella\')';

  @override
  String get inlineQr => 'QR inkorporat (test biss, mingħajr ritratti)';

  @override
  String get inlineTooBig =>
      'Wisq data għal kodiċi inkorporat — neħħi oqsma jew uża link ospitat.';

  @override
  String get scanShareLabel => 'Skennja l-kodiċi tal-qsim';

  @override
  String get notAShareCode => 'Dak il-kodiċi mhux qsim ta\' cat(a)log.';

  @override
  String get importShareTitle => 'Timporta dan il-qattus?';

  @override
  String shareSource(String url) {
    return 'Sors: $url';
  }

  @override
  String get importLabel => 'Importa';

  @override
  String get strayAreaLabel => 'Żona possibbli ta\' vagabondaġġ';

  @override
  String get prevPin => 'Pinna ta\' qabel';

  @override
  String get nextPin => 'Il-pinna li jmiss';

  @override
  String get noMissingCats =>
      'Għad m\'hemmx qtates mitlufa b\'pożizzjonijiet ta\' fliers.';

  @override
  String get noMatchCandidates => 'M\'hemm l-ebda tqabbil possibbli bħalissa.';

  @override
  String sameIdField(String field) {
    return 'L-istess $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m \'il bogħod';
  }

  @override
  String get addFlier => 'Żid flier';

  @override
  String get missingSinceLabel => 'Mitluf minn';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Aqta\' r-ritratt';

  @override
  String get statusOwner => 'Sid';

  @override
  String get ocrUnavailable =>
      'L-għarfien tat-test mhux disponibbli fuq dan l-apparat — ikteb it-test tal-flier int stess.';

  @override
  String get displayFormat => 'Muri bħala';

  @override
  String get displayPlain => 'Test sempliċi';

  @override
  String get displayQr => 'Kodiċi QR';

  @override
  String get displayBarcode => 'Barcode';

  @override
  String get editLabel => 'Editja';

  @override
  String get doneLabel => 'Lest';

  @override
  String get openSettings => 'Iftaħ is-settings';

  @override
  String get notSaved => 'Ma ġiex salvat';

  @override
  String get birthdateInFuture =>
      'Id-data tat-twelid ma tistax tkun fil-futur.';

  @override
  String get deceasedInFuture => 'Id-data tal-mewt ma tistax tkun fil-futur.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Id-data tal-mewt ma tistax tkun qabel id-data tat-twelid ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Id-data tat-twelid ma tistax tkun wara d-data tal-mewt ($date).';
  }

  @override
  String get malePregnant =>
      'Dan il-qattus huwa rreġistrat bħala raġel — qattus raġel ma jistax ikun tqil. L-ewwel iċċekkja s-sess.';

  @override
  String fatherNotMale(String name) {
    return '$name hija rreġistrata bħala mara u ma tistax tkun il-missier. L-ewwel iċċekkja s-sess.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name huwa rreġistrat bħala raġel u ma jistax ikun l-omm. L-ewwel iċċekkja s-sess.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name twieled fi $date — ġenitur ma jistax jitwieled wara l-ferħ tiegħu.';
  }

  @override
  String get genderFatherFemale =>
      'Dan il-qattus huwa rreġistrat bħala missier ta\' qtates oħra — il-missier ma jistax ikun mara. L-ewwel iċċekkja l-familja.';

  @override
  String get genderMotherMale =>
      'Dan il-qattus huwa rreġistrat bħala omm ta\' qtates oħra — l-omm ma tistax tkun raġel. L-ewwel iċċekkja l-familja.';

  @override
  String get moveTo => 'Mexxi lejn';

  @override
  String get noClowderStrayOption => 'Bla clowder — tat-triq / ħarab';

  @override
  String timelineOf(String name) {
    return 'Linja taż-żmien — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Reġġa\' lura din il-bidla';

  @override
  String get revertSubtitle =>
      'Jirrestawra l-valur ta\' qabel bħala entrata ġdida — l-istorja żżomm it-tnejn.';

  @override
  String fieldCleared(String field) {
    return '$field tbattal';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field lura għal \"$value\"';
  }

  @override
  String get leftStray => 'Telaq — tat-triq';

  @override
  String movedTo(String name) {
    return 'Imċaqlaq lejn $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat wasal';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat wasal minn $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat mar lejn $place';
  }

  @override
  String get duplicateMergedIn => 'Duplikat magħqud';

  @override
  String get asOfToday => 'Mil-lum';

  @override
  String asOfDate(String date) {
    return 'Mid-data $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Format ħażin — uża $format';
  }

  @override
  String get dateInFuture => 'Din id-data ma tistax tkun fil-futur.';

  @override
  String get value => 'Valur';

  @override
  String get latitudeLongitude => 'latitudni, lonġitudni';

  @override
  String get newField => 'Qasam ġdid';

  @override
  String get fieldType => 'Tip';

  @override
  String get usedOn => 'Użat għal';

  @override
  String get forCats => 'qtates';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'it-tnejn';

  @override
  String get optionsOnePerLine => 'Għażliet (waħda f\'kull linja)';

  @override
  String get ownValue => 'Valur tiegħek';

  @override
  String get renameField => 'Ibdel isem il-qasam';

  @override
  String get editOptions => 'Editja l-għażliet…';

  @override
  String get noStraysRightNow => 'M\'hemmx qtates tat-triq bħalissa.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Żid tat-triq';

  @override
  String get newStray => 'Tat-triq ġdid';

  @override
  String get searchByNameHint => 'Fittex qtates bl-isem…';

  @override
  String get host => 'Ospita';

  @override
  String get hostExplainer =>
      'Ibda hawn, imbagħad skennja l-kodiċi jew daħħlu fuq l-apparat l-ieħor.';

  @override
  String get startHosting => 'Ibda ospita';

  @override
  String get stopHosting => 'Ieqaf ospita';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Sessjonijiet s\'issa: $count';
  }

  @override
  String get join => 'Ingħaqad';

  @override
  String get addressFromHost => 'Indirizz (mill-apparat li qed jospita)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Issinkronizza issa';

  @override
  String get addressFormatHint =>
      'L-indirizz irid jidher bħal 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sinkronizzat: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Is-sinkronizzazzjoni falliet: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'L-aħħar sinkronizzazzjoni ma\' $peer: $time';
  }

  @override
  String get sharedFolder => 'Folder kondiviż';

  @override
  String get sharedFolderExplainer =>
      'Iż-żewġ apparati jużaw l-istess folder (eż. f\'Dropbox jew fuq USB stick). Kull sync iħalli l-bidliet tiegħek hemm u jiġbor dawk tan-naħa l-oħra.';

  @override
  String get noFolderChosenYet => 'Għad m\'hemmx folder magħżul';

  @override
  String get choose => 'Agħżel…';

  @override
  String get syncFolderNow => 'Issinkronizza l-folder issa';

  @override
  String folderSynced(String result) {
    return 'Folder sinkronizzat: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Is-sinkronizzazzjoni tal-folder falliet: $error';
  }

  @override
  String get recordSightingHere => 'Irreġistra dehra hawn:';

  @override
  String trailOf(String name, int count) {
    return 'Rotta: $name ($count dehriet)';
  }

  @override
  String conflictOn(String field) {
    return 'Kunflitt — $field';
  }

  @override
  String get conflictBody =>
      'Inbidel f\'żewġ postijiet fl-istess ħin. Agħżel x\'inhu veru:';

  @override
  String mergeThisInto(String kind) {
    return 'Għaqqad dan il-$kind ma\'…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'M\'hemmx $kind ieħor biex tgħaqqad miegħu.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Tgħaqqad ma\' $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Iż-żewġ rekords isiru wieħed. $name iżomm il-valuri attwali tiegħu; l-istorja tal-ieħor tingħaqad miegħu. Ma tistax terġa\' lura.';
  }

  @override
  String get kindCat => 'qattus';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'qasam';

  @override
  String get takePhoto => 'Ħu ritratt';

  @override
  String get chooseFromGallery => 'Agħżel mill-gallerija';

  @override
  String get about => 'Dwar';

  @override
  String get aboutTagline =>
      'Katalgu lokali għal qtates f\'fostering. Id-data tiegħek tibqa\' fuq l-apparati tiegħek — l-ebda server, l-ebda kont.';

  @override
  String versionLabel(String version, String build) {
    return 'Verżjoni $version ($build)';
  }

  @override
  String get sourceCode => 'Kodiċi sors';

  @override
  String get reportProblemOrIdea => 'Irrapporta problema jew idea';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Ikteb lill-iżviluppatur';

  @override
  String get buyCoffee => 'Ixtri kafè lill-iżviluppatur';

  @override
  String get coffeeSubtitle =>
      'L-app tibqa\' b\'xejn. Anke jekk ma niħux kafè :)';

  @override
  String get openSourceLicenses => 'Liċenzji open source';

  @override
  String get machineTranslated =>
      'It-traduzzjonijiet huma awtomatiċi — korrezzjonijiet milqugħa fuq GitHub.';

  @override
  String get unnamed => '(bla isem)';

  @override
  String get labelName => 'Isem';

  @override
  String get labelProfileImage => 'Ritratt tal-profil';

  @override
  String get labelPhoto => 'Ritratt';

  @override
  String get starterGender => 'Sess';

  @override
  String get starterBreed => 'Razza';

  @override
  String get valueMixed => 'imħallat';

  @override
  String get breedEuropeanShorthair => 'Ewropew tax-xagħar qasir';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Brittaniku tax-xagħar qasir';

  @override
  String get breedNorwegianForestCat => 'Qattus tal-Foresta Norveġiża';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Sjamiż';

  @override
  String get breedPersian => 'Persjan';

  @override
  String get breedBengal => 'Bengali';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get starterColor => 'Kulur';

  @override
  String get starterNeutered => 'Sterilizzat';

  @override
  String get starterPregnant => 'Tqila';

  @override
  String get starterBirthdate => 'Data tat-twelid';

  @override
  String get starterDeceased => 'Mejjet';

  @override
  String get starterAddress => 'Indirizz';

  @override
  String get starterResponsible => 'Persuna responsabbli';

  @override
  String get starterEmail => 'Email';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Link tat-tiftix';

  @override
  String lookupUrlHelp(String token) {
    return 'Il-paġna tas-servizz b\'$token minflok in-numru, eż. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Fittex';

  @override
  String lookupFailed(String url) {
    return 'L-ebda app ma setgħet tiftaħ $url. Ikkopja l-link f\'browser.';
  }

  @override
  String get stepCat => 'Qattus';

  @override
  String get stepOwner => 'Sid';

  @override
  String get stepFace => 'Ritratt tal-wiċċ';

  @override
  String get stepRegistry => 'Reġistru';

  @override
  String get stepReview => 'Iċċekkja u ssejvja';

  @override
  String get stepOwnerHint =>
      'Min tilef il-qattus — minn dan isir il-clowder tiegħu, bil-kuntatt mill-flier.';

  @override
  String get stepFaceHint =>
      'Aqta\' wiċċ il-qattus mill-flier; isir ir-ritratt tal-profil. Tista\' taqbeż dan.';

  @override
  String get stepRegistryHint =>
      'Numri misjuba fuq il-flier. Dawk immarkati jinżammu mal-qattus u jinfetħu wara.';

  @override
  String get noRegistryLinks =>
      'L-ebda link ta\' reġistru fuq dan il-flier — jekk xi ħaġa ntesiet, jekk jogħġbok irrapporta bug.';

  @override
  String get unknownServiceHint => 'Servizz mhux magħruf';

  @override
  String get rememberService => 'Ftakar is-servizz';

  @override
  String get rememberServiceHint =>
      'Agħti isem lis-servizz u uri n-numru fil-link. Il-flier li jmiss jimtela waħdu.';

  @override
  String get noIdInLink => 'Dan il-link ma fihx numru li l-app tista\' żżomm.';

  @override
  String get whichNumber => 'Liema parti hi n-numru?';

  @override
  String get cropAgain => 'Aqta\' mill-ġdid';

  @override
  String get noFaceYet =>
      'Għadu m\'hemmx ritratt tal-wiċċ — jintuża r-ritratt tal-flier.';

  @override
  String get backLabel => 'Lura';

  @override
  String get dangerButton => 'TAGĦFASX.\nPERIKLU';

  @override
  String get dangerThanks => 'Grazzi talli tuża cat(a)log!';

  @override
  String get helpTitle => 'Għajnuna';

  @override
  String get showTipsAgain => 'Uri l-pariri mill-ġdid';

  @override
  String get helpHome =>
      'Il-ħarsa ġenerali tal-kolonji tiegħek — kolonja hija post fejn jgħixu l-qtates: darek, dar ta\' fostering, kenn. Agħfas kard biex tara l-qtates tagħha; għafsa twila tiftaħ il-menu. Il-buttuna t\'isfel lemin toħloq kolonja, u l-kard tal-qtates tat-triq tiġbor kull qattus bla dar. L-isem fuq nett huwa l-katalgu li qiegħed fih — agħfsu biex tibdel jew iżżid.';

  @override
  String get helpClowder =>
      'Kollox dwar dan il-post: il-qtates, l-oqsma (indirizz, kuntatt, tip) u l-istorja. Il-paġna tinfetaħ read-only; il-lapes jixgħel l-editjar, fejn tista\' żżid ukoll qasam ġdid. Għafsa twila fuq qasam teditjah mill-ewwel, fuq qattus tmexxih, taħbih jew tiftħu. Appuntament miżjud hawn jista\' jieħu diversi qtates tal-kolonja, pereżempju ġurnata ta\' sterilizzazzjoni: immarka l-qtates li ġejjin, temm darba, neħħi l-marka minn dawk li ma ġewx ittrattati.';

  @override
  String get helpCat =>
      'Kollox dwar dan il-qattus: ritratti, oqsma, familja, storja. Il-paġna hija għall-qari biss sakemm tmiss il-lapes. Agħfas fit-tul fuq qasam biex teditjah mill-ewwel; agħfas fit-tul fuq ritratt għall-menu tiegħu. Il-menu fuq il-lemin għandu l-bqija: aħbi, għaqqad, irreġistra dehra, aqsam il-qattus. „Privat“ jiġi ssettjat waqt l-editjar ta\' qasam.';

  @override
  String get helpStrays =>
      'Qtates li bħalissa m\'għandhomx dar: misjuba, maħruba jew minn flier. Il-buttuna tal-kamera tniżżel qattus quddiemek; il-buttuna tal-flier tibdel poster ta\' qattus mitluf f\'qattus bil-kuntatt tas-sid; l-iskaner jaqra kodiċi cat(a)log mill-poster. Mess Stray Cam għal ritratt; żomm magħfus biex tiffilmja vidjo u żomm l-aħjar frames bħala ritratti.';

  @override
  String get helpMap =>
      'Il-qtates u l-postijiet kollha bi pożizzjoni. It-tiftix isib qtates, nies u postijiet — isem mhux magħruf jitfittex mad-dinja kollha. Il-buttuna tas-saffi tpinġi ċrieki ta\' 500 m madwar il-postijiet tal-fliers ta\' qattus mitluf u madwar id-dar li ħarab minnha. Il-vleġġeġ jimxu minn pin għal ieħor, għafsa twila fuq il-mappa tniżżel osservazzjoni.';

  @override
  String get helpCard =>
      'Il-kard tal-qattus għall-istampar: fuq, bil-chips, tagħżel x\'jidher fuqha, imbagħad taqsamha bħala stampa jew PDF. In-numri jistgħu jiġu stampati bħala QR jew barcode, u pożizzjoni ssir QR li jiftaħ mappa, flimkien ma\' Plus Code qasir.';

  @override
  String get helpSync =>
      'Kif id-data tasal għand ħaddieħor: qabbad direttament, uża folder li jaraw iż-żewġ apparati, jew ibgħat fajl b\'messenger. Dejjem int tiddeċiedi x\'joħroġ — u l-fajls .catsync li tirċievi jinfetħu hawn ukoll.';

  @override
  String get helpFields =>
      'L-oqsma li juża l-katalgu tiegħek. Ibdlilhom l-isem, ibdel l-għażliet ta\' qasam ta\' għażla, jew oħloq tiegħek. Qasam ta\' identifikatur jista\' jipponta lejn servizz (reġistru), u mbagħad in-numru fuq il-qattus isir jingħafas.';

  @override
  String get helpTimeline =>
      'Kull bidla li qatt saret, l-aktar reċenti l-ewwel: min biddel xiex, meta u għal liema valur. Kull entrata tista\' titreġġa\' lura — dan jikteb entrata ġdida, xejn ma jitħassar.';

  @override
  String get helpDuplicates =>
      'Qtates jew kolonji li jidhru li jeżistu darbtejn — numri identiċi jew ismijiet simili ħafna b\'dettalji li jaqblu. Agħfas par biex tgħaqqadhom; l-għaqda ma tistax titreġġa\' lura, għalhekk tistaqsi l-ewwel.';

  @override
  String get helpMatches =>
      'Qtates li jistgħu jkunu l-istess annimal: numru identiku, jew qattus tat-triq li deher fiż-żona ta\' tfittxija ta\' qattus mitluf. Agħfas par biex tgħaqqad, għafsa twila tiftaħ l-ewwel qattus biex tqabbel.';

  @override
  String get helpFlier =>
      'Poster mitfugħ f\'ritratt isir qattus flimkien mas-sid tiegħu. Pass pass: id-data tal-qattus, il-kuntatt tas-sid, qtugħ tal-wiċċ għar-ritratt tal-profil, numri ta\' reġistri mill-poster, imbagħad verifika finali. Kollox suġġeriment — irranġa dak li l-kamera qrat ħażin.';

  @override
  String get archiveTitle => 'Arkivju';

  @override
  String get archiveExplainer =>
      'Qtates mejta u kolonji vojta li ħadd ma messhom għal snin xorta jieħdu spazju — l-aktar ir-ritratti tagħhom. L-arkivjar jiktibhom f\'fajl li żżomm int u mbagħad iħassarhom minn hawn.';

  @override
  String get archiveAction => 'Arkivja';

  @override
  String archiveSelected(int count) {
    return 'Arkivja $count entrati';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Tarkivja $count entrati?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names se jinkitbu f\'fajl u mbagħad jitħassru — fuq l-apparat tiegħek u fuq kull apparat li tissinkronizza miegħu. L-importazzjoni tal-fajl iġġib kollox lura; mingħajru jintilfu.';
  }

  @override
  String archiveDone(int count) {
    return '$count entrati arkivjati u mħassra';
  }

  @override
  String archiveFailed(String error) {
    return 'Ma tħassar xejn: il-fajl tal-arkivju ma setax jinkiteb ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Database $db, ritratti $photos f\'$count fajls';
  }

  @override
  String quietForYears(int years) {
    return 'Bla bidla għal $years snin';
  }

  @override
  String get nothingToArchive =>
      'M\'hemm xejn antik biżżejjed biex jiġi arkivjat.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'L-aħħar bidla $date · ritratti $size';
  }

  @override
  String get helpArchive =>
      'Data qadima tiswa spazju, l-aktar ir-ritratti li kull apparat sinkronizzat iġorr. Hawn tagħżel qtates mejta u kolonji vojta li ilhom kwieti snin, tiktibhom f\'fajl li żżomm, u tħassarhom. It-tħassir jasal għand kull min tissinkronizza miegħu; l-importazzjoni tal-fajl treġġa\' kollox lura.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Terġa\' ddaħħal $count entrati mħassra?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names huma mħassra f\'dan il-katalgu, u l-fajl li għadek kif importajt fih dawn. It-treġġigħ lura jġibhom hawn u fuq kull apparat li tissinkronizza miegħu.';
  }

  @override
  String get restoreAction => 'Erġa\' daħħal';

  @override
  String get keepDeleted => 'Ħallihom imħassra';

  @override
  String get archiveNotSaved =>
      'Ma tħassar xejn: l-arkivju ma ġie ssejvjat imkien.';

  @override
  String get locateAddress => 'Sib l-indirizz fuq il-mappa';

  @override
  String get addressLocated => 'L-indirizz instab';

  @override
  String get addressNotFound =>
      'Ma nstab l-ebda post għal dan l-indirizz. Iċċekkja l-kitba jew ħallih vojt.';

  @override
  String get starterPosition => 'Post';

  @override
  String get valueYes => 'iva';

  @override
  String get valueNo => 'le';

  @override
  String get valueFemale => 'mara';

  @override
  String get valueMale => 'raġel';

  @override
  String get valueUnknown => 'mhux magħruf';

  @override
  String get cropTitle => 'Aqta\' r-ritratt';

  @override
  String get markTitle => 'Immarka l-qattus';

  @override
  String get applyCrop => 'Aqta';

  @override
  String get useFullPhoto => 'Uża r-ritratt kollu';

  @override
  String get dragToSelect => 'Iġbed rettangolu madwar il-qattus';

  @override
  String get dragOverTheCat => 'Iġbed ellissi fuq il-qattus';

  @override
  String get cropPhoto => 'Aqta\'…';

  @override
  String get markPhoto => 'Immarka…';

  @override
  String get scanCode => 'Skennja l-kodiċi';

  @override
  String get orTypeCode => 'Jew ittajpja l-kodiċi';

  @override
  String get copyCode => 'Ikkopja l-kodiċi';

  @override
  String get copied => 'Ikkupjat';

  @override
  String get invalidCode => 'Dak il-kodiċi mhux validu';

  @override
  String get hotspotHint =>
      'M\'hemmx Wi-Fi komuni? Ixgħel il-hotspot ta\' telefown wieħed, qabbad l-ieħor, imbagħad ospita hawn.';

  @override
  String get byMessenger => 'Bil-messenger';

  @override
  String get byMessengerExplainer =>
      'Ibgħat il-katalgu kollu bħala fajl wieħed bil-WhatsApp, Signal jew mail — in-naħa l-oħra timportah.';

  @override
  String get shareBundle => 'Aqsam il-pakkett tas-sink…';

  @override
  String get importBundle => 'Importa l-pakkett tas-sink…';

  @override
  String bundleImported(String result) {
    return 'Pakkett importat: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'L-aħħar backup awtomatiku falla: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'L-importazzjoni falliet: $error';
  }

  @override
  String get pickOnMap => 'Agħżel fuq il-mappa';

  @override
  String get useMyLocation => 'Uża l-post tiegħi';

  @override
  String get language => 'Lingwa';

  @override
  String get typeUnitValue => 'Valur b\'unità';

  @override
  String get dimension => 'Kobor';

  @override
  String get dimensionWeight => 'Piż';

  @override
  String get dimensionLength => 'Tul';

  @override
  String get dimensionVolume => 'Volum';

  @override
  String get dimensionTemperature => 'Temperatura';

  @override
  String get unitsLabel => 'Unitajiet';

  @override
  String get unitsAuto => 'Bħal fir-reġjun tiegħek';

  @override
  String get unitsMetric => 'Metriku (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperjali (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Piż';

  @override
  String get systemDefault => 'Default tas-sistema';

  @override
  String get iosLocalNetworkHint =>
      'Jekk jibqa\' jfalli fuq iPhone/iPad: Settings → Privatezza u sigurtà → Netwerk lokali → ħalli cat(a)log u erġa\' pprova.';

  @override
  String get includePrivate => 'Aqsam id-data privata';

  @override
  String get hideLabel => 'Aħbi fuq dan l-apparat';

  @override
  String get unhideLabel => 'Erġa\' uri';

  @override
  String get showHiddenLabel => 'Uri l-moħbija';

  @override
  String get stopShowingHidden => 'Ieqaf uri l-moħbija';

  @override
  String get starterSpecies => 'Speċi';

  @override
  String get starterStatus => 'Tip';

  @override
  String get statusFoster => 'Dar tal-fostering';

  @override
  String get statusForeverHome => 'Dar';

  @override
  String get statusClinic => 'Klinika';

  @override
  String get statusShelter => 'Kenn';

  @override
  String get statusBarn => 'Maqjel';

  @override
  String get valueCat => 'Qattus';

  @override
  String get otherOption => 'Ieħor…';

  @override
  String get celebrationsToggle => 'Iċċelebra l-adozzjonijiet';

  @override
  String get celebrationsSubtitle => 'Konfetti u ferħ meta qattus imur f\'daru';

  @override
  String get onMapLabel => 'Fuq il-mappa';

  @override
  String get showOnMap => 'Uri fuq il-mappa';

  @override
  String get searchPlaceHint => 'Fittex post jew indirizz';

  @override
  String get noPlacesFound => 'Ma nstabux postijiet';

  @override
  String get mapSearchHint => 'Fittex qtates, gruppi, nies';

  @override
  String get proposeAnotherName => 'Ipproponi isem ieħor';

  @override
  String get moderationTitle => 'Awturi u projbizzjonijiet';

  @override
  String get moderationSubtitle => 'Neħħi d-data ta\' persuna għal dejjem';

  @override
  String get authorsSection => 'Min kiteb f\'dan il-katalgu';

  @override
  String get hardDeleteAction => 'Ħassar kollox minn dan l-awtur';

  @override
  String hardDeleteWarning(Object name) {
    return 'Ineħħi kull entrata u ritratt ta\' $name minn dan l-apparat. Apparati oħra jżommu tagħhom. Ma jistax jitreġġa\' lura.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Ikteb $name biex tikkonferma';
  }

  @override
  String get alsoBan => 'Ipprojbixxi wkoll — qatt iżjed data mingħandu';

  @override
  String get bansSection => 'Projbizzjonijiet';

  @override
  String get unbanAction => 'Neħħi l-projbizzjoni';

  @override
  String get deletedDone => 'Imħassar.';

  @override
  String get syncSummaryTitle => 'X\'wasal';

  @override
  String get summaryAdopted => 'Adottati';

  @override
  String get summaryDeceased => 'Mejta';

  @override
  String get summaryEscaped => 'Ħarbu';

  @override
  String get summaryNew => 'Ġodda';

  @override
  String get summaryConflicts => 'Kunflitti x\'jissolvew';

  @override
  String summaryOther(Object n) {
    return '…u $n bidliet oħra';
  }

  @override
  String get starterMother => 'Omm';

  @override
  String get starterFather => 'Missier';

  @override
  String get familySection => 'Familja';

  @override
  String get littermatesLabel => 'Mill-istess boton';

  @override
  String get siblingsLabel => 'Aħwa';

  @override
  String get kittensLabel => 'Frieħ';

  @override
  String get toastSettingsTitle => 'X\'għandu jitħabbar';

  @override
  String get toastSettingsSubtitle => 'Messaġġi żgħar wara sinkronizzazzjoni';

  @override
  String get toastKindAdoptions => 'Adozzjonijiet';

  @override
  String get toastKindBirths => 'Twelid';

  @override
  String get toastKindDeaths => 'Imwiet';

  @override
  String get toastKindEscapes => 'Ħarbiet';

  @override
  String get toastKindMoves => 'Ċaqliq';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adottat minn $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Fellus ġdid: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat miet';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat ħarab';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat mar joqgħod $home';
  }

  @override
  String get notACatlogFile => 'Dan mhux fajl ta\' cat(a)log';

  @override
  String get nothingNewInBundle => 'Xejn ġdid fil-fajl — għandek kollox diġà';

  @override
  String get syncChooserInPerson => 'Wiċċ imb wiċċ';

  @override
  String get syncChooserInPersonSub => 'Sinkronizzazzjoni bil-Wi-Fi';

  @override
  String get syncChooserRemote => 'Mill-bogħod';

  @override
  String get syncChooserRemoteSub => 'Sinkronizzazzjoni b\'folder jew USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Esportazzjoni u importazzjoni bil-midja soċjali';

  @override
  String get connectToWifiFirst =>
      'L-ewwel aqbad ma\' Wi-Fi — imbagħad l-apparati jsibu lil xulxin';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) irid jissinkronizza';
  }

  @override
  String get trustBothWaysNote =>
      'Il-katalgi jiġu skambjati fiż-żewġ direzzjonijiet.';

  @override
  String get allowOnce => 'Ħalli';

  @override
  String get allowAlways => 'Dejjem ħalli dan l-apparat';

  @override
  String get declineAction => 'Irrifjuta';

  @override
  String get syncDeclined => 'L-apparat l-ieħor irrifjuta s-sinkronizzazzjoni';

  @override
  String get trustedDevicesSection => 'Apparati dejjem permessi';

  @override
  String get removeTrust => 'Neħħi';

  @override
  String get hostWithoutWifi => 'Ospita mingħajr Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Joħloq konnessjoni diretta temporanja mat-telefown l-ieħor (mingħajr internet). Juża biss cat(a)log u tinqata\' waħedha wara s-sinkronizzazzjoni.';

  @override
  String get hotspotAndroidOnly =>
      'Dan il-kodiċi jeħtieġ żewġ telefowns Android — fuq iPhone/iPad uża Wi-Fi kondiviż';

  @override
  String get selectClowderHint => 'Agħżel clowder fuq ix-xellug';

  @override
  String get introTitle1 => 'Il-qtates tiegħek, organizzati';

  @override
  String get introBody1 =>
      'Oħloq kard għal kull qattus: ritratt, sess, saħħa, kulma trid tniżżel. Il-qtates huma miġbura skont fejn jgħixu — l-app issejjaħ dak il-post kolonja (clowder).';

  @override
  String get introTitle2 => 'Jaħdem mingħajr internet';

  @override
  String get introBody2 =>
      'Kollox jinħażen biss fuq it-telefon tiegħek. L-ebda kont, l-ebda cloud. Xejn ma jittella\' sakemm ma taqsmux int stess.';

  @override
  String get introTitle3 => 'Aħdmu flimkien';

  @override
  String get introBody3 =>
      'Kulħadd juża l-app tiegħu u kultant tpartu d-data: iltaqgħu u skennjaw kodiċi, użaw folder kondiviż jew ibagħtu fajl wieħed b\'messenger. Wara kulħadd ikollu l-istess informazzjoni.';

  @override
  String get introSkip => 'Aqbeż';

  @override
  String get introNext => 'Li jmiss';

  @override
  String get introDone => 'Ejja';

  @override
  String get introReplayTitle => 'Introduzzjoni mgħaġġla';

  @override
  String get spotHomeSync =>
      'Hawn tissinkronizza ma\' nies li taf. Int tiddeċiedi x\'taqsam.';

  @override
  String get spotHomeStrays =>
      'Din il-kard tiġbor il-qtates tat-triq kollha — qtates bla dar. Għafas għal-lista.';

  @override
  String get spotHomeMenu =>
      'F\'dan il-menu: sib u għaqqad id-duplikati, esporta CSV u aktar.';

  @override
  String get spotCatEdit =>
      'Għafas fuq il-lapes biex teditja dan il-qattus. Ħjiel: għafsa twila fuq qasam teditjah direttament.';

  @override
  String get spotMapLayers =>
      'Qed tfittex qattus mitluf? Uri ċrieki madwar il-postijiet tal-fliers tiegħu u madwar id-dar li ħarab minnha.';

  @override
  String get spotStraysFlier =>
      'Flier ta\' qattus mitluf? Ħu ritratt tiegħu hawn — l-app iżżomm il-qattus u l-kuntatt għalik.';

  @override
  String get spotStraysScan =>
      'Xi fliers għandhom kodiċi QR ta\' cat(a)log. Skennjah hawn u importa l-qattus mingħajr ma tikteb.';

  @override
  String get introTitle4 => 'Sib il-qtates mitlufa';

  @override
  String get introBody4 =>
      'Tara flier ta\' qattus mitluf? Ħu ritratt tiegħu fl-app: iżżomm il-qattus, il-kuntatt ta\' sidu u l-post. Jekk aktar tard jitfaċċa qattus tat-triq simili, l-app tissuġġerixxi tqabbil possibbli.';

  @override
  String get spotMapSearch =>
      'Ikteb qattus, post jew persuna biex taqbeż hemm fuq il-mappa.';

  @override
  String get spotCardChips =>
      'Immarka x\'għandu jidher fuq il-kard li tinqasam — il-bqija jibqa\' barra.';

  @override
  String get spotCatMenu =>
      'Hawn aktar azzjonijiet: aħbi l-qattus, għaqqad id-duplikati, jew irreġistra dehra.';

  @override
  String get spotDone => 'Fhimt';

  @override
  String get spotReplayTitle => 'Dawra tal-ġodda';

  @override
  String get spotReplaySubtitle => 'Erġa\' uri s-suġġerimenti f\'kull paġna';

  @override
  String get spotReplayDone => 'Is-suġġerimenti jerġgħu jidhru';

  @override
  String get searchNoResults => 'Ma nstab l-ebda qattus b\'dak l-isem';

  @override
  String get syncUnreachable =>
      'Ma setax jintlaħaq l-apparat l-ieħor. It-tnejn fuq l-istess Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Ma setgħetx tintlaħaq il-folder. Id-drive jew il-folder tal-cloud għadu hemm?';

  @override
  String get crashTitle => 'Dan ma kellux jiġri';

  @override
  String get crashBody =>
      'cat(a)log iltaqa\' ma\' żball mhux mistenni. Id-data tiegħek hija sikura — kollox jiġi salvat fil-mument li tibdlu. Erġa\' ibda l-app, u jekk jerġa\' jiġri, ibgħat ir-rapport biex ikun jista\' jissewwa.';

  @override
  String get crashRestart => 'Erġa\' ibda l-app';

  @override
  String get crashSendReport => 'Ibgħat rapport lill-iżviluppatur';

  @override
  String get crashLastRunBody =>
      'cat(a)log waqaf għal għarrieda l-aħħar darba — x\'aktarx spiċċat il-memorja. Tibgħat rapport qasir biex jissewwa?';

  @override
  String get catalogsTitle => 'Katalgi';

  @override
  String get newCatalog => 'Katalgu ġdid';

  @override
  String get intoCatalog => 'Fil-katalgu';

  @override
  String get catalogNameLabel => 'Isem tal-katalgu';

  @override
  String catalogNameTaken(String name) {
    return 'Diġà hemm katalgu jismu $name. Agħżel isem ieħor.';
  }

  @override
  String get manageCatalogs => 'Immaniġġja l-katalgi';

  @override
  String get helpCatalogs =>
      'Kull katalgu huwa dinja għalih: qtates, kolonji, oqsma, ritratti u sħab tas-sinkronizzazzjoni tiegħu. Berlin u Pariġi qatt ma jitħalltu. Agħfas l-isem fuq nett tal-iskrin prinċipali biex tibdel, iżżid jew tbiddel l-isem. Ismek, il-lingwa u l-pariri li rajt huma komuni għal kulħadd.';

  @override
  String get spotHomeCatalog =>
      'Dan huwa l-katalgu li qiegħed fih. Agħfas l-isem biex tibdel jew toħloq ieħor.';

  @override
  String get deleteCatalog => 'Ħassar il-katalgu';

  @override
  String deleteCatalogBody(String name) {
    return 'Kollox f’$name jisparixxi: il-qtates, ir-ritratti, l-istorja. L-ewwel jinħażen fajl sħiħ fejn imorru l-backups awtomatiċi — l-importazzjoni tiegħu ġġib il-katalgu lura. Ikteb l-isem biex tikkonferma.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name tħassar. Il-fajl qiegħed f’$where.';
  }

  @override
  String typeTheName(String name) {
    return 'Ikteb $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Ma tħassar xejn: il-fajl tal-katalgu ma setax jinkiteb ($error). Illibera spazju jew erġa’ pprova aktar tard.';
  }

  @override
  String get moveToCatalog => 'Mexxi għal katalgu ieħor';

  @override
  String movedToCatalog(int count, String name) {
    return '$count imxew għal $name';
  }

  @override
  String get chooseWhatToMove => 'X’għandu jitmexxa?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Tmexxi xi ħaġa għal $name?';
  }

  @override
  String get undoThisImport => 'Ħassar din l-importazzjoni';

  @override
  String undoImportBody(int count) {
    return 'It-$count bidliet li ġabet din l-importazzjoni jitneħħew. L-ewwel jinkitbu f’fajl, u l-importazzjoni tiegħu ġġibhom lura. Min diġà sinkronizza jżomm il-kopja tiegħu — dak ma jistax jiġi rtirat.';
  }

  @override
  String undoneImport(String where) {
    return 'Imħassar. Il-fajl qiegħed f’$where.';
  }

  @override
  String get goBackTitle => 'Mur lura';

  @override
  String get goBackToHere => 'Erġa’ lura hawn';

  @override
  String get momentImport => 'Qabel l-importazzjoni';

  @override
  String get momentSync => 'Qabel is-sinkronizzazzjoni';

  @override
  String get momentMerge => 'Qabel l-għaqda';

  @override
  String get momentHardDelete => 'Qabel it-tħassir tad-data ta’ awtur';

  @override
  String get momentArchive => 'Qabel l-arkivjar';

  @override
  String get momentManual => 'Immarkat minnek';

  @override
  String get showOlderMoments => 'Uri l-eqdem';

  @override
  String goBackBody(int count) {
    return 'Kollox wara dan il-mument jitneħħa — $count bidliet. L-ewwel jinkiteb f’fajl, u l-importazzjoni tiegħu ġġib kollox lura; kull mument aktar riċenti jmur miegħu. Min diġà sinkronizza jżomm il-kopja tiegħu — dak ma jistax jiġi rtirat.';
  }

  @override
  String get nameThisMoment => 'Agħti isem lil dan il-mument';

  @override
  String get helpGoBack =>
      'Il-mumenti meta dan il-katalgu nbidel: qabel kull importazzjoni u kull sinkronizzazzjoni, qabel għaqda, arkivjar jew tħassir, u kull darba li mmarkajt mument int. Jekk tagħżel wieħed, il-katalgu jerġa’ lura għal dak l-istat — kollox ta’ warajh jinkiteb f’fajl li żżomm u mbagħad jitneħħa, u kull mument aktar riċenti jmur miegħu. Min diġà sinkronizza jżomm dak li rċieva.';

  @override
  String goBackFileFailed(String error) {
    return 'Ma tneħħa xejn: il-fajl li jżommu ma setax jinkiteb ($error). Illibera spazju u erġa’ pprova.';
  }

  @override
  String get goBackChanged =>
      'Xejn ma tneħħa: il-katalgu nbidel waqt li l-fajl kien qed jiġi salvat. Erġa\' pprova.';

  @override
  String get switchBeforeDeleting =>
      'Dan huwa l-katalgu li qiegħed fih. Aqleb għal ieħor, imbagħad ħassru.';

  @override
  String shareFileFailed(String error) {
    return 'Il-fajl tal-qsim ma setax jinkiteb ($error). Illibera spazju u erġa’ pprova.';
  }

  @override
  String get privateLabel => 'Privat';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalgu: $name';
  }

  @override
  String get markPrivate => 'Immarka bħala privat';

  @override
  String get unmarkPrivate => 'Neħħi l-marka privata';

  @override
  String get agenda => 'Tfakkiriet';

  @override
  String get reminderLabel => 'Tfakkira';

  @override
  String get agendaEmpty =>
      'L-ebda appuntament ippjanat. Ippjana oħrajn hawn bil-plus, jew fuq il-paġna ta\' qattus jew clowder.';

  @override
  String get dueToday => 'illum';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fi żmien $count jum',
      many: 'fi żmien $count-il jum',
      few: 'fi żmien $count ijiem',
      one: 'fi żmien ġurnata',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jum tard',
      many: '$count-il jum tard',
      few: '$count ijiem tard',
      one: 'ġurnata tard',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Sar';

  @override
  String get repeatTitle => 'Mill-ġdid fi żmien…';

  @override
  String get noRepeatLabel => 'Mingħajr repetizzjoni';

  @override
  String get unitDays => 'ijiem';

  @override
  String get unitWeeks => 'ġimgħat';

  @override
  String get unitMonths => 'xhur';

  @override
  String get unitYears => 'snin';

  @override
  String ageYears(int years) {
    return '$years sn.';
  }

  @override
  String ageMonths(int months) {
    return '$months xhr.';
  }

  @override
  String get changeDateLabel => 'Ibdel id-data';

  @override
  String get removeReminderLabel => 'Neħħi t-tfakkira';

  @override
  String get exportIcs => 'Esporta l-fajl tal-kalendarju';

  @override
  String get resyncCalendar => 'Erġa\' ssinkronizza l-kalendarju';

  @override
  String icsSavedTo(String path) {
    return 'Il-fajl tal-kalendarju ġie salvat f\'$path';
  }

  @override
  String get calendarMirrorLabel => 'Irrifletti fil-kalendarju tal-apparat';

  @override
  String get calendarMirrorSubtitle =>
      'L-appuntamenti jidhru bħala avvenimenti ta\' ġurnata sħiħa fil-kalendarju. cat(a)log jaġġornahom hemm ma\' kull startjar u wara kull bidla. It-twissijiet għall-appuntamenti tista\' timmaniġġjahom fil-kalendarju.';

  @override
  String get syncPeerOlder =>
      'L-apparat l-ieħor għandu cat(a)log eqdem mingħajr tfakkiriet. Aġġorna cat(a)log hemmhekk u ssinkronizza mill-ġdid.';

  @override
  String get syncPeerNewer =>
      'L-apparat l-ieħor għandu cat(a)log aktar ġdid. Aġġorna cat(a)log fuq dan l-apparat u ssinkronizza mill-ġdid.';

  @override
  String get bundleNewerError =>
      'Dan il-fajl ġej minn cat(a)log aktar ġdid. Aġġorna cat(a)log fuq dan l-apparat biex timportah.';

  @override
  String get spotEar =>
      'Widna żgħira ta\' qattus f\'rokna tfisser: żomm magħfus għal aktar.';

  @override
  String get addReminder => 'Żid tfakkira';

  @override
  String get plannedSection => 'Ippjanat';

  @override
  String get reminderDialogHint =>
      'L-appuntament jidher fit-tfakkiriet. Hemm tista\' tikkonfermah jew twarrbu. Il-valur jittieħed biss meta l-appuntament ikun ġie kkonfermat.';

  @override
  String get reminderFor => 'Għal';

  @override
  String get reminderField => 'Qasam';

  @override
  String get dueDateLabel => 'Data tal-iskadenza';

  @override
  String get pickCalendar => 'Liema kalendarju?';

  @override
  String get calendarPermissionDenied =>
      'L-aċċess għall-kalendarju huwa mblukkat, għalhekk ir-riflessjoni hija mitfija. Ippermettih fis-settings tas-sistema u erġa\' ixgħel ir-riflessjoni.';

  @override
  String get calendarNotChosen =>
      'Ma ntgħażel l-ebda kalendarju, għalhekk ir-riflessjoni hija mitfija. Erġa\' ixgħelha u agħżel wieħed.';

  @override
  String get calendarGone =>
      'Il-kalendarju magħżul m\'għadux jeżisti, għalhekk ir-riflessjoni hija mitfija. Erġa\' ixgħelha u agħżel ieħor.';

  @override
  String get noWritableCalendar =>
      'Ma nstab l-ebda kalendarju. Idħol f\'kont ta\' kalendarju fis-settings tas-sistema, pereżempju Google, u erġa\' pprova.';

  @override
  String get spotHomeAgenda =>
      'It-tfakkiriet: il-lista tal-appuntamenti ppjanati — veterinarju, mediċina, kontrolli.';

  @override
  String get spotAgendaAdd => 'Ippjana appuntament ġdid.';

  @override
  String get spotAgendaCalendar =>
      'Ixgħel hawn ir-riflessjoni tal-appuntamenti ta\' cat(a)log f\'kalendarju tal-għażla tiegħek.';

  @override
  String get helpAgenda =>
      'It-tfakkiriet jelenkaw l-appuntamenti ppjanati skont id-data. Hemm żewġ tipi: appuntamenti b\'ħin, u tfakkiriet li jgħoddu għal ġurnata. Dawk mitlufa jibqgħu fuq. Mess jiftaħ il-qattus jew il-clowder. Is-sinjal jikkonferma appuntament: il-valur jinkiteb fil-qasam, u tista\' tippjana minnufih dak li jmiss, pereżempju fi tliet xhur. Żomm magħfus biex tibdel id-data jew tħassar l-appuntament. Is-swiċċ ta\' fuq jirrifletti l-appuntamenti f\'kalendarju tat-telefown tiegħek. Il-menu jesportahom bħala fajl tal-kalendarju. Żjara għand il-veterinarju b\'diversi qtates hija appuntament wieħed: immarka l-qtates, l-Aġenda turi karta waħda b\'isimhom, u fit-tmiem tistaqsi liema qtates ġew ittrattati — neħħi l-marka mill-oħrajn, jibqgħu ppjanati.';

  @override
  String get calendarRowOff => 'Kalendarju: mitfi';

  @override
  String calendarRowOn(String name) {
    return 'Kalendarju: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Ippjana appuntament għal dan il-qattus. Jidher fit-tfakkiriet u jiġi kkonfermat hemm.';

  @override
  String get spotAddReminderClowder =>
      'Ippjana appuntament għal dan il-clowder. Jidher fit-tfakkiriet u jiġi kkonfermat hemm.';

  @override
  String get readOnlyCalendar => 'qari biss';

  @override
  String get appointmentLabel => 'Appuntament';

  @override
  String get addAppointment => 'Żid appuntament';

  @override
  String get planChooserTitle => 'Appuntament jew tfakkira?';

  @override
  String get planChooserAppointment =>
      'Appuntament — żjara f\'data u ħin, b\'noti';

  @override
  String get planChooserReminder => 'Tfakkira — valur li jsir dovut f\'ġurnata';

  @override
  String get appointmentTitleLabel => 'X\'inhu';

  @override
  String get notesLabel => 'Noti';

  @override
  String get timeLabel => 'Ħin';

  @override
  String get allDayLabel => 'Il-ġurnata kollha';

  @override
  String get alertLabel => 'Twissija';

  @override
  String get alertNone => 'Xejn';

  @override
  String get alertDayBefore => 'Il-ġurnata ta\' qabel';

  @override
  String get alertHourBefore => 'Siegħa qabel';

  @override
  String get linkFieldLabel => 'Meta jitlesta, ikteb f\'qasam';

  @override
  String get noLinkedField => 'L-ebda qasam';

  @override
  String get outcomeTitle => 'Kif mar?';

  @override
  String get finishLabel => 'Lesti';

  @override
  String get editLabelAppointment => 'Editja l-appuntament';

  @override
  String get deleteAppointment => 'Ħassar l-appuntament';

  @override
  String get stepFlierText => 'Test tal-flier';

  @override
  String get qrFoundHint =>
      'Instab kodiċi QR fuq il-flier. Il-kodiċijiet immarkati jinqraw għal numri tar-reġistru u links.';

  @override
  String get useCode => 'Uża dan il-kodiċi';

  @override
  String get qrNone => 'Ma nstab l-ebda kodiċi QR fir-ritratt.';

  @override
  String qrFailed(String error) {
    return 'Il-qari tal-kodiċi QR falla: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Flier ta\' $name rikonoxxut. Iċċekkja hawn taħt f\'liema qasam tmur kull linja.';
  }

  @override
  String get flierLayoutUnknown =>
      'Layout tal-flier mhux magħruf. Assenja l-linji lill-oqsma hawn taħt; il-bqija jibqa\' fir-rimarki.';

  @override
  String get targetRegistryNumber => 'Numru tar-reġistru';

  @override
  String get targetLostPlace => 'Indirizz (fejn intilef)';

  @override
  String get targetContact => 'Kuntatt tar-reġistru';

  @override
  String get targetDrop => 'Warrab';

  @override
  String get existingCat => 'Qattus eżistenti';

  @override
  String get existingClowder => 'Grupp eżistenti';

  @override
  String get createNewInstead => 'Xejn — oħloq ġdid';

  @override
  String overwritesValue(String value) {
    return 'Jissostitwixxi l-valur attwali \"$value\"';
  }

  @override
  String get abortScanTitle => 'Twaqqaf l-iskan?';

  @override
  String get abortScanBody => 'Xejn ma jiġi salvat.';

  @override
  String get abortScan => 'Waqqaf';

  @override
  String get keepScanning => 'Kompli';

  @override
  String get catsOnAppointment => 'Qtates f\'dan l-appuntament';

  @override
  String get noCatsHint =>
      'L-ebda qattus immarkat — l-appuntament hu tal-kolonja stess.';

  @override
  String get pickCatsTitle => 'Liema qtates ġejjin?';

  @override
  String catsCount(int count) {
    return '$count qtates';
  }

  @override
  String get finishUntickHint =>
      'Neħħi l-marka mill-qtates li ma ġewx ittrattati; jibqgħu ppjanati.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Ħassar l-appuntament għall-$count qtates kollha';
  }
}
