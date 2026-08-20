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
  String get privateNoShare =>
      'Dan il-qattus huwa mmarkat bħala privat — data privata qatt ma titlaq mill-apparat tiegħek. L-ewwel neħħi l-marka biex taqsmu pubblikament.';

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
      'Ibda hawn, imbagħad daħħal l-indirizz u l-PIN fuq l-apparat l-ieħor.';

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
  String get coffeeSubtitle => 'Kompletament volontarju — l-app hija b\'xejn';

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
      'Min tilef il-qattus — minn dan issir il-kard tiegħu, bil-kuntatt mill-flier.';

  @override
  String get stepFaceHint =>
      'Aqta\' wiċċ il-qattus mill-flier; isir ir-ritratt tal-profil. Tista\' taqbeż dan.';

  @override
  String get stepRegistryHint =>
      'Numri misjuba fuq il-flier. Dawk immarkati jinżammu mal-qattus u jinfetħu wara.';

  @override
  String get noRegistryLinks =>
      'L-ebda link ta\' reġistru fuq dan il-flier — m\'hemm xejn x\'tagħmel hawn.';

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
  String get systemDefault => 'Default tas-sistema';

  @override
  String get iosLocalNetworkHint =>
      'Jekk jibqa\' jfalli fuq iPhone/iPad: Settings → Privatezza u sigurtà → Netwerk lokali → ħalli cat(a)log u erġa\' pprova.';

  @override
  String get markPrivate => 'Immarka bħala privat';

  @override
  String get unmarkPrivate => 'Neħħi l-marka privata';

  @override
  String get includePrivate => 'Inkludi data privata';

  @override
  String get includePrivateExplainer =>
      'B\'hekk jintbagħat ukoll dak kollu li mmarkajt bħala privat. Min jissinkronizza miegħek se jarah.';

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
  String get statusForeverHome => 'Dar għal dejjem';

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
  String get celebrationsSubtitle =>
      'Konfetti u ferħ meta qattus imur f\'dar għal dejjem';

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
  String get syncChooserInPersonSub =>
      'Qegħdin fl-istess kamra — skennja kodiċi, lest f\'sekondi';

  @override
  String get syncChooserRemote => 'Mill-bogħod';

  @override
  String get syncChooserRemoteSub =>
      'Permezz ta\' folder kondiviż bħal Dropbox jew USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Ibgħat kollox bħala fajl wieħed minn kwalunkwe messenger — u importa fajl .catsync riċevut hawn';

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
      'Aktar azzjonijiet hawn: immarka l-qattus bħala privat, aħbih, għaqqad duplikati jew niżżel osservazzjoni.';

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
}
