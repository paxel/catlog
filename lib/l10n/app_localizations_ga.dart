// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Irish (`ga`).
class AppLocalizationsGa extends AppLocalizations {
  AppLocalizationsGa([String locale = 'ga']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Fáilte go cat(a)log';

  @override
  String get welcomeBody =>
      'Roghnaigh ainm duit féin. Taifeadtar gach athrú faoin ainm seo, ionas go bhfeicfidh daoine eile cé a rinne cad.';

  @override
  String get yourName => 'D\'ainm';

  @override
  String get start => 'Tosaigh';

  @override
  String get clowders => 'Clowdair';

  @override
  String get noClowdersYet =>
      'Níl aon chlowdar fós.\nCruthaigh an chéad cheann thíos.';

  @override
  String get strays => 'Cait fáin';

  @override
  String get searchCats => 'Cuardaigh cait';

  @override
  String get map => 'Léarscáil';

  @override
  String get sync => 'Sioncrónú';

  @override
  String get fields => 'Réimsí';

  @override
  String get exportCsv => 'Easpórtáil CSV';

  @override
  String get aboutAndFeedback => 'Maidir leis & aiseolas';

  @override
  String get newClowder => 'Clowdar nua';

  @override
  String get name => 'Ainm';

  @override
  String get cancel => 'Cealaigh';

  @override
  String get create => 'Cruthaigh';

  @override
  String get save => 'Sábháil';

  @override
  String get delete => 'Scrios';

  @override
  String get merge => 'Cumaisc';

  @override
  String get resolve => 'Socraigh';

  @override
  String get open => 'Oscail';

  @override
  String csvSavedTo(String path) {
    return 'CSV sábháilte in $path';
  }

  @override
  String get renameClowder => 'Athainmnigh an clowdar';

  @override
  String get rename => 'Athainmnigh';

  @override
  String get timeline => 'Amlíne';

  @override
  String get mergeInto => 'Cumaisc le…';

  @override
  String get deleteClowder => 'Scrios an clowdar';

  @override
  String get cats => 'Cait';

  @override
  String get addCat => 'Cuir cat leis';

  @override
  String get newCat => 'Cat nua';

  @override
  String deleteQuestion(String name) {
    return 'Scrios $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Imíonn an clowdar den liosta.';

  @override
  String deleteClowderBody(int count) {
    return 'Ní scriostar a chuid cat ($count) — déantar cait fáin díobh. Bog iad go clowdar eile ar dtús mura é sin atá uait.';
  }

  @override
  String get card => 'Cárta';

  @override
  String get shareAsImage => 'Roinn mar íomhá';

  @override
  String get shareAsPdf => 'Roinn mar PDF';

  @override
  String get print => 'Priontáil';

  @override
  String cardTitle(String name) {
    return 'Cárta — $name';
  }

  @override
  String get renameCat => 'Athainmnigh an cat';

  @override
  String get seenHereNow => 'Feicthe anseo anois';

  @override
  String get deleteCat => 'Scrios an cat';

  @override
  String get clowderLabel => 'Clowdar';

  @override
  String get strayNoClowder => 'Cat fáin — gan chlowdar';

  @override
  String get stray => 'Cat fáin';

  @override
  String get photos => 'Grianghraif';

  @override
  String get addPhoto => 'Cuir grianghraf leis';

  @override
  String get setAsProfileImage => 'Socraigh mar phictiúr próifíle';

  @override
  String get thisIsProfileImage => 'Seo an pictiúr próifíle';

  @override
  String get deletePhoto => 'Scrios an grianghraf';

  @override
  String get deletePhotoTitle => 'Scrios an grianghraf?';

  @override
  String get deletePhotoBody =>
      'Scriostar sonraí an ghrianghraif go deo — ní féidir é a chealú.';

  @override
  String get deleteCatBody =>
      'Imíonn an cat de gach liosta. Scriostar a ghrianghraif go deo.';

  @override
  String get sightingRecorded => 'Feiceáil taifeadta ag do shuíomh.';

  @override
  String get noLocationAvailable =>
      'Níl suíomh ar fáil — brúigh go fada ar an léarscáil ina ionad.';

  @override
  String get moveTo => 'Bog go';

  @override
  String get noClowderStrayOption => 'Gan chlowdar — cat fáin / d\'éalaigh sé';

  @override
  String timelineOf(String name) {
    return 'Amlíne — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Cuir an t-athrú seo ar ceal';

  @override
  String get revertSubtitle =>
      'Athchóiríonn sé an luach roimhe mar iontráil nua — coimeádann an stair an dá cheann.';

  @override
  String fieldCleared(String field) {
    return '$field glanta';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field ar ais go \"$value\"';
  }

  @override
  String get leftStray => 'D\'imigh — cat fáin';

  @override
  String movedTo(String name) {
    return 'Bogtha go $name';
  }

  @override
  String arrivedPlain(String cat) {
    return 'Tháinig $cat';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return 'Tháinig $cat ó $place';
  }

  @override
  String leftTo(String cat, String place) {
    return 'D\'imigh $cat go $place';
  }

  @override
  String get duplicateMergedIn => 'Taifead dúbailte cumaiscthe';

  @override
  String get asOfToday => 'Amhail inniu';

  @override
  String asOfDate(String date) {
    return 'Amhail $date';
  }

  @override
  String get value => 'Luach';

  @override
  String get latitudeLongitude => 'domhanleithead, domhanfhad';

  @override
  String get newField => 'Réimse nua';

  @override
  String get fieldType => 'Cineál';

  @override
  String get usedOn => 'In úsáid le haghaidh';

  @override
  String get forCats => 'cait';

  @override
  String get forClowders => 'clowdair';

  @override
  String get forBoth => 'an dá cheann';

  @override
  String get optionsOnePerLine => 'Roghanna (ceann in aghaidh na líne)';

  @override
  String get renameField => 'Athainmnigh an réimse';

  @override
  String get noStraysRightNow => 'Níl aon chat fáin faoi láthair.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Cuir cat fáin leis';

  @override
  String get newStray => 'Cat fáin nua';

  @override
  String get searchByNameHint => 'Cuardaigh cait de réir ainm…';

  @override
  String get host => 'Óstáil';

  @override
  String get hostExplainer =>
      'Tosaigh anseo, ansin cuir isteach an seoladh agus an PIN ar an ngléas eile.';

  @override
  String get startHosting => 'Tosaigh ag óstáil';

  @override
  String get stopHosting => 'Stop ag óstáil';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Seisiúin go dtí seo: $count';
  }

  @override
  String get join => 'Glac páirt';

  @override
  String get addressFromHost => 'Seoladh (ón ngléas óstála)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sioncrónaigh anois';

  @override
  String get addressFormatHint =>
      'Caithfidh an seoladh a bheith mar 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sioncrónaithe: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Theip ar an sioncrónú: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Sioncrónú deireanach le $peer: $time';
  }

  @override
  String get sharedFolder => 'Fillteán comhroinnte';

  @override
  String get sharedFolderExplainer =>
      'Sioncrónaigh trí fhillteán a iompraíonn néal nó méaróg USB idir gléasanna — dóibh siúd nach bhfuil ar an líonra céanna.';

  @override
  String get noFolderChosenYet => 'Níl aon fhillteán roghnaithe fós';

  @override
  String get choose => 'Roghnaigh…';

  @override
  String get syncFolderNow => 'Sioncrónaigh an fillteán anois';

  @override
  String folderSynced(String result) {
    return 'Fillteán sioncrónaithe: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Theip ar shioncrónú an fhillteáin: $error';
  }

  @override
  String get recordSightingHere => 'Taifead feiceáil anseo:';

  @override
  String get orPlaceClowderHere => 'Nó cuir clowdar anseo:';

  @override
  String trailOf(String name, int count) {
    return 'Rian: $name ($count feiceáil)';
  }

  @override
  String conflictOn(String field) {
    return 'Coinbhleacht — $field';
  }

  @override
  String get conflictBody =>
      'Athraithe in dhá áit ag an am céanna. Roghnaigh cad atá fíor:';

  @override
  String mergeThisInto(String kind) {
    return 'Cumaisc an $kind seo le…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Níl aon $kind eile le cumasc leis.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Cumaisc le $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Déantar taifead amháin den dá thaifead. Coimeádann $name a luachanna reatha; téann stair an chinn eile leis. Ní féidir é a chealú.';
  }

  @override
  String get kindCat => 'cat';

  @override
  String get kindClowder => 'clowdar';

  @override
  String get kindField => 'réimse';

  @override
  String get takePhoto => 'Tóg grianghraf';

  @override
  String get chooseFromGallery => 'Roghnaigh ón ngailearaí';

  @override
  String get about => 'Maidir leis';

  @override
  String get aboutTagline =>
      'Catalóg áitiúil do chait altrama. Fanann do shonraí ar do ghléasanna — gan freastalaí, gan chuntas.';

  @override
  String versionLabel(String version, String build) {
    return 'Leagan $version ($build)';
  }

  @override
  String get sourceCode => 'Cód foinse';

  @override
  String get reportProblemOrIdea => 'Tuairiscigh fadhb nó smaoineamh';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Scríobh chuig an bhforbróir';

  @override
  String get buyCoffee => 'Ceannaigh caife don fhorbróir';

  @override
  String get coffeeSubtitle => 'Go hiomlán roghnach — tá an aip saor in aisce';

  @override
  String get openSourceLicenses => 'Ceadúnais foinse oscailte';

  @override
  String get machineTranslated =>
      'Is aistriúcháin mheaisín iad — fáiltítear roimh cheartúcháin ar GitHub.';

  @override
  String get unnamed => '(gan ainm)';

  @override
  String get labelName => 'Ainm';

  @override
  String get labelProfileImage => 'Pictiúr próifíle';

  @override
  String get labelPhoto => 'Grianghraf';

  @override
  String get starterGender => 'Gnéas';

  @override
  String get starterColor => 'Dath';

  @override
  String get starterNeutered => 'Coillte';

  @override
  String get starterPregnant => 'Torrach';

  @override
  String get starterBirthdate => 'Dáta breithe';

  @override
  String get starterDeceased => 'Marbh';

  @override
  String get starterAddress => 'Seoladh';

  @override
  String get starterResponsible => 'Duine freagrach';

  @override
  String get starterPosition => 'Suíomh';

  @override
  String get valueYes => 'tá';

  @override
  String get valueNo => 'níl';

  @override
  String get valueFemale => 'baineann';

  @override
  String get valueMale => 'fireann';

  @override
  String get valueUnknown => 'anaithnid';

  @override
  String get cropTitle => 'Bearr an grianghraf';

  @override
  String get markTitle => 'Marcáil an cat';

  @override
  String get useFullPhoto => 'Úsáid an grianghraf iomlán';

  @override
  String get dragToSelect => 'Tarraing dronuilleog timpeall an chait';

  @override
  String get dragOverTheCat => 'Tarraing éilips os cionn an chait';

  @override
  String get cropPhoto => 'Bearr…';

  @override
  String get markPhoto => 'Marcáil…';

  @override
  String get scanCode => 'Scan an cód';

  @override
  String get orTypeCode => 'Nó clóscríobh an cód';

  @override
  String get copyCode => 'Cóipeáil an cód';

  @override
  String get copied => 'Cóipeáilte';

  @override
  String get invalidCode => 'Níl an cód sin bailí';

  @override
  String get hotspotHint =>
      'Gan Wi-Fi comhroinnte? Cas air hotspot ar fhón amháin, ceangail an ceann eile, ansin óstáil anseo.';

  @override
  String get byMessenger => 'Trí theachtaire';

  @override
  String get byMessengerExplainer =>
      'Seol an chatalóg iomlán mar chomhad amháin trí WhatsApp, Signal nó ríomhphost — iompórtálann an taobh eile é.';

  @override
  String get shareBundle => 'Roinn paca sioncronaithe…';

  @override
  String get importBundle => 'Iompórtáil paca sioncronaithe…';

  @override
  String bundleImported(String result) {
    return 'Paca iompórtáilte: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Theip ar an iompórtáil: $error';
  }

  @override
  String get pickOnMap => 'Roghnaigh ar an léarscáil';

  @override
  String get useMyLocation => 'Úsáid mo shuíomh';

  @override
  String get language => 'Teanga';

  @override
  String get systemDefault => 'Réamhshocrú an chórais';

  @override
  String get iosLocalNetworkHint =>
      'Má theipeann air i gcónaí ar iPhone/iPad: Socruithe → Príobháideachas agus slándáil → Líonra áitiúil → ceadaigh cat(a)log agus bain triail eile as.';

  @override
  String get markPrivate => 'Marcáil mar phríobháideach';

  @override
  String get unmarkPrivate => 'Bain an marc príobháideach';

  @override
  String get includePrivate => 'Cuir sonraí príobháideacha san áireamh';

  @override
  String get includePrivateExplainer =>
      'Roinntear cait, grúpaí agus réimsí príobháideacha freisin — cas air seo ach amháin agus do ghléasanna féin á sioncronú agat.';

  @override
  String get hideLabel => 'Folaigh ar an ngléas seo';

  @override
  String get unhideLabel => 'Taispeáin arís';

  @override
  String get showHiddenLabel => 'Taispeáin rudaí folaithe';

  @override
  String get stopShowingHidden => 'Stop rudaí folaithe a thaispeáint';

  @override
  String get starterSpecies => 'Speiceas';

  @override
  String get starterStatus => 'Stádas';

  @override
  String get statusFoster => 'Teach altrama';

  @override
  String get statusForeverHome => 'Baile buan';

  @override
  String get statusClinic => 'Clinic';

  @override
  String get statusShelter => 'Tearmann';

  @override
  String get statusBarn => 'Scioból';

  @override
  String get valueCat => 'Cat';

  @override
  String get otherOption => 'Eile…';

  @override
  String get celebrationsToggle => 'Ceiliúradh uchtálacha';

  @override
  String get celebrationsSubtitle =>
      'Coinfití agus gártha nuair a bhogann cat go dtí a bhaile buan';

  @override
  String get onMapLabel => 'Ar an léarscáil';

  @override
  String get showOnMap => 'Taispeáin ar an léarscáil';

  @override
  String get searchPlaceHint => 'Cuardaigh áit nó seoladh';

  @override
  String get noPlacesFound => 'Níor aimsíodh áiteanna';

  @override
  String get mapSearchHint => 'Cuardaigh cait, grúpaí, daoine';

  @override
  String get proposeAnotherName => 'Mol ainm eile';

  @override
  String get moderationTitle => 'Údair & coisc';

  @override
  String get moderationSubtitle => 'Bain sonraí duine go deo';

  @override
  String get authorsSection => 'Cé a scríobh sa chatalóg';

  @override
  String get hardDeleteAction => 'Scrios gach rud ón údar seo';

  @override
  String hardDeleteWarning(Object name) {
    return 'Baineann sé gach iontráil agus grianghraf le $name den ghléas seo. Coinníonn gléasanna eile a gcuid. Ní féidir é a chealú.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Clóscríobh $name le deimhniú';
  }

  @override
  String get alsoBan => 'Cosc freisin — ná glac sonraí uaidh arís';

  @override
  String get bansSection => 'Coisc';

  @override
  String get unbanAction => 'Bain an cosc';

  @override
  String get deletedDone => 'Scriosta.';

  @override
  String get syncSummaryTitle => 'Cad a tháinig';

  @override
  String get summaryAdopted => 'Uchtaithe';

  @override
  String get summaryDeceased => 'Básaithe';

  @override
  String get summaryEscaped => 'Éalaithe';

  @override
  String get summaryNew => 'Nua';

  @override
  String get summaryConflicts => 'Coinbhleachtaí le réiteach';

  @override
  String summaryOther(Object n) {
    return '…agus $n athrú eile';
  }

  @override
  String get starterMother => 'Máthair';

  @override
  String get starterFather => 'Athair';

  @override
  String get familySection => 'Teaghlach';

  @override
  String get littermatesLabel => 'Ál céanna';

  @override
  String get siblingsLabel => 'Deartháireacha is deirfiúracha';

  @override
  String get kittensLabel => 'Piscíní';

  @override
  String get toastSettingsTitle => 'Cad atá le fógairt';

  @override
  String get toastSettingsSubtitle =>
      'Teachtaireachtaí beaga tar éis sioncronaithe';

  @override
  String get toastKindAdoptions => 'Uchtálacha';

  @override
  String get toastKindBirths => 'Breitheanna';

  @override
  String get toastKindDeaths => 'Básanna';

  @override
  String get toastKindEscapes => 'Éalúcháin';

  @override
  String get toastKindMoves => 'Aistrithe';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat uchtaithe ag $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Piscín nua: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return 'Fuair $cat bás';
  }

  @override
  String toastEscaped(Object cat) {
    return 'D\'éalaigh $cat';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return 'Bhog $cat go $home';
  }

  @override
  String get notACatlogFile => 'Ní comhad cat(a)log é sin';

  @override
  String get nothingNewInBundle =>
      'Níl aon rud nua sa chomhad — tá gach rud agat cheana';

  @override
  String get syncChooserInPerson => 'Go pearsanta';

  @override
  String get syncChooserInPersonSub =>
      'Tá sibh sa seomra céanna — scan cód, déanta i soicindí';

  @override
  String get syncChooserRemote => 'I gcéin';

  @override
  String get syncChooserRemoteSub =>
      'Trí fhillteán roinnte cosúil le Dropbox nó méaróg USB';

  @override
  String get syncChooserMessenger => 'Teachtaire';

  @override
  String get syncChooserMessengerSub =>
      'Seol gach rud mar chomhad amháin trí theachtaire ar bith';

  @override
  String get connectToWifiFirst =>
      'Ceangail le Wi-Fi ar dtús — ansin aimsíonn na gléasanna a chéile';

  @override
  String trustQuestion(Object author, Object device) {
    return 'Ba mhaith le $author ($device) sioncronú';
  }

  @override
  String get trustBothWaysNote => 'Malartófar bhur gcatalóga sa dá threo.';

  @override
  String get allowOnce => 'Ceadaigh';

  @override
  String get allowAlways => 'Ceadaigh an gléas seo i gcónaí';

  @override
  String get declineAction => 'Diúltaigh';

  @override
  String get syncDeclined => 'Dhiúltaigh an gléas eile don sioncronú';

  @override
  String get trustedDevicesSection => 'Gléasanna a cheadaítear i gcónaí';

  @override
  String get removeTrust => 'Bain';

  @override
  String get hostWithoutWifi => 'Óstáil gan Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Cruthaíonn sé nasc díreach sealadach leis an bhfón eile (gan idirlíon). Ní úsáideann ach cat(a)log é agus dícheanglaíonn sé é féin tar éis an tsioncronaithe.';

  @override
  String get hotspotAndroidOnly =>
      'Tá dhá fhón Android de dhíth ar an gcód seo — ar iPhone/iPad úsáid Wi-Fi comhroinnte';

  @override
  String get selectClowderHint => 'Roghnaigh clowder ar chlé';

  @override
  String get introTitle1 => 'Cónaíonn cait i clowders';

  @override
  String get introBody1 =>
      'Áit é clowder ina gcónaíonn cait: do theach altrama, árasán uchtaitheora, an scioból béal dorais. Faigheann gach cat cárta le grianghraf, fíricí agus a scéal iomlán.';

  @override
  String get introTitle2 => 'Fanann gach rud agat';

  @override
  String get introBody2 =>
      'Gan chuntas, gan néal, gan rianú. Maireann do shonraí ar do ghléas.';

  @override
  String get introTitle3 => 'Roinn le do chúntóirí';

  @override
  String get introBody3 =>
      'Scan cód agus sioncrónaítear dhá ghléas i soicindí, úsáid fillteán roinnte nó seol gach rud mar chomhad amháin.';

  @override
  String get introSkip => 'Scipeáil';

  @override
  String get introNext => 'Ar aghaidh';

  @override
  String get introDone => 'Ar aghaidh linn';

  @override
  String get introReplayTitle => 'Réamhrá tapa';
}
