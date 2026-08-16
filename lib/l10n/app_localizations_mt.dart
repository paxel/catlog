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
      'Għad m\'hemmx clowders.\nOħloq l-ewwel wieħed hawn taħt.';

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
      'Il-qattus jisparixxi mil-listi kollha. Ir-ritratti tiegħu jitħassru għal dejjem.';

  @override
  String get sightingRecorded =>
      'Id-dehra ġiet irreġistrata fil-pożizzjoni tiegħek.';

  @override
  String get noLocationAvailable =>
      'M\'hemmx lok disponibbli — minflok agħfas fit-tul fuq il-mappa.';

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
  String get renameField => 'Ibdel isem il-qasam';

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
      'Issinkronizza permezz ta\' folder li cloud jew USB iġorr bejn l-apparati — għal min mhux fuq l-istess netwerk.';

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
  String get orPlaceClowderHere => 'Jew poġġi clowder hawn:';

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
  String get starterPosition => 'Pożizzjoni';

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
      'Qtates, gruppi u oqsma privati jinqasmu wkoll — ixgħel biss meta tissinkronizza l-apparati tiegħek stess.';

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
  String get starterStatus => 'Status';

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
      'Ibgħat kollox bħala fajl wieħed bi kwalunkwe messenger';

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
  String get introTitle1 => 'Il-qtates jgħixu fi clowders';

  @override
  String get introBody1 =>
      'Clowder huwa post fejn jgħixu l-qtates: id-dar tal-fostering tiegħek, l-appartament ta\' min jadotta, il-maqjel tal-ġenb. Kull qattus għandu karta b\'ritratt, fatti u l-istorja kollha tiegħu.';

  @override
  String get introTitle2 => 'Kollox jibqa\' għandek';

  @override
  String get introBody2 =>
      'L-ebda kont, l-ebda cloud, l-ebda traċċar. Id-data tiegħek tgħix fuq l-apparat tiegħek.';

  @override
  String get introTitle3 => 'Aqsam mal-għajnuniet tiegħek';

  @override
  String get introBody3 =>
      'Skennja kodiċi u żewġ apparati jissinkronizzaw f\'sekondi, uża folder kondiviż jew ibgħat kollox bħala fajl wieħed.';

  @override
  String get introSkip => 'Aqbeż';

  @override
  String get introNext => 'Li jmiss';

  @override
  String get introDone => 'Ejja';

  @override
  String get introReplayTitle => 'Introduzzjoni mgħaġġla';
}
