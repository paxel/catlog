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
  String get clowdersNeutral => 'Líonta tí';

  @override
  String get noClowdersYet =>
      'Níl clowder ar bith fós. Áit é clowder ina gcónaíonn cait — do theach altrama, árasán uchtaitheora. Cruthaigh an chéad cheann thíos.';

  @override
  String get noClowdersYetNeutral =>
      'Níl líon tí ar bith fós. Áit é líon tí ina gcónaíonn peataí — do theach, teach altrama, árasán uchtaitheora. Cruthaigh an chéad cheann thíos.';

  @override
  String get strays => 'Cait fáin';

  @override
  String get searchCats => 'Cuardaigh cait';

  @override
  String get searchCatsNeutral => 'Cuardaigh peataí';

  @override
  String get map => 'Léarscáil';

  @override
  String get sync => 'Sioncrónú';

  @override
  String get fields => 'Réimsí';

  @override
  String get pickerColumns => 'Colúin';

  @override
  String get pickerCardFields => 'Ar an gcárta';

  @override
  String get exportCsv => 'Easpórtáil CSV';

  @override
  String get aboutAndFeedback => 'Maidir leis & aiseolas';

  @override
  String get settings => 'Socruithe';

  @override
  String get newClowder => 'Clowdar nua';

  @override
  String get newClowderNeutral => 'Líon tí nua';

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
  String get renameClowderNeutral => 'Athainmnigh an líon tí';

  @override
  String get rename => 'Athainmnigh';

  @override
  String get timeline => 'Amlíne';

  @override
  String get mergeInto => 'Cumaisc le…';

  @override
  String get deleteClowder => 'Scrios an clowdar';

  @override
  String get deleteClowderNeutral => 'Scrios an líon tí';

  @override
  String get cats => 'Cait';

  @override
  String get catsNeutral => 'Peataí';

  @override
  String get addCat => 'Cuir cat leis';

  @override
  String get addCatNeutral => 'Cuir peata leis';

  @override
  String get newCat => 'Cat nua';

  @override
  String get newCatNeutral => 'Peata nua';

  @override
  String deleteQuestion(String name) {
    return 'Scrios $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Imíonn an clowdar den liosta.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Imíonn an líon tí den liosta.';

  @override
  String deleteClowderBody(int count) {
    return 'Ní scriostar a chuid cat ($count) — déantar cait fáin díobh. Bog iad go clowdar eile ar dtús mura é sin atá uait.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Ní scriostar a chuid peataí ($count) — déantar fánaithe díobh. Bog iad go líon tí eile ar dtús mura é sin atá uait.';
  }

  @override
  String get card => 'Cárta';

  @override
  String get shareAsImage => 'Roinn mar íomhá';

  @override
  String get sortOldestFirst => 'Is sine ar dtús';

  @override
  String get sortNewestFirst => 'Is nuaí ar dtús';

  @override
  String get shareAsText => 'Roinn mar théacs';

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
  String get renameCatNeutral => 'Athainmnigh an peata';

  @override
  String get seenHereNow => 'Feicthe anseo anois';

  @override
  String get deleteCat => 'Scrios an cat';

  @override
  String get deleteCatNeutral => 'Scrios an peata';

  @override
  String get clowderLabel => 'Clowdar';

  @override
  String get clowderLabelNeutral => 'Líon tí';

  @override
  String get strayNoClowder => 'Cat fáin — gan chlowdar';

  @override
  String get strayNoClowderNeutral => 'Fánaí — gan líon tí';

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
      'Imíonn an cat as gach liosta agus baintear a ghrianghraif — anseo agus, tar éis an chéad sioncronaithe eile, ar na gléasanna eile freisin.';

  @override
  String get deleteCatBodyNeutral =>
      'Imíonn an peata as gach liosta agus baintear a ghrianghraif — anseo agus, tar éis an chéad sioncronaithe eile, ar na gléasanna eile freisin.';

  @override
  String get sightingRecorded => 'Feiceáil taifeadta ag do shuíomh.';

  @override
  String get noLocationAvailable =>
      'Níl suíomh ar fáil — brúigh go fada ar an léarscáil ina ionad.';

  @override
  String get locationDeniedForever =>
      'Tá rochtain ar an suíomh coiscthe. Ceadaigh í i socruithe an chórais chun Stray Cam a úsáid.';

  @override
  String get locationServiceOff =>
      'Tá an suíomh múchta ar an ngléas seo. Cuir air é sna socruithe agus bain triail eile as.';

  @override
  String get locationDenied =>
      'Níl cead ag cat(a)log do shuíomh a úsáid. Bain triail eile as agus ceadaigh é nuair a iarrtar ort.';

  @override
  String get locationNoFix =>
      'Níorbh fhéidir do shuíomh a dhéanamh amach anois. Bain triail eile as amuigh faoin aer — teastaíonn radharc glan ar an spéir ón GPS.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Uimhir slise';

  @override
  String get starterRemarks => 'Nótaí';

  @override
  String get captureFlier => 'Grianghraf den bhileog';

  @override
  String get addPhotosTo => 'Cuir grianghraif le…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count ghrianghraf curtha le $name';
  }

  @override
  String get scanPrintedCode => 'Scan cód clóite';

  @override
  String get chipScanHint =>
      'Scanann sé an cód QR/barrachód clóite ó chárta na slise nó ó pháipéir an tréidlia — ní féidir le fón an tslis sa chat a léamh.';

  @override
  String get chipScanHintNeutral =>
      'Scanann sé an cód QR/barrachód clóite ó chárta na slise nó ó pháipéir an tréidlia — ní féidir le fón an tslis san ainmhí a léamh.';

  @override
  String get savingLabel => 'Á shábháil…';

  @override
  String ownerOfCat(String name) {
    return 'Úinéir $name';
  }

  @override
  String get sortLabel => 'Sórtáil';

  @override
  String get viewAsTable => 'Taispeáin mar thábla';

  @override
  String get viewAsTiles => 'Taispeáin mar thíleanna';

  @override
  String get viewAsList => 'Taispeáin mar liosta';

  @override
  String get ageLabel => 'Aois';

  @override
  String get catList => 'Liosta cat';

  @override
  String get catListNeutral => 'Liosta peataí';

  @override
  String get matchCandidatesTitle => 'Meaitseálacha féideartha';

  @override
  String get findDuplicates => 'Aimsigh dúblaigh';

  @override
  String get noDuplicates => 'Níl aon dúblach féideartha faoi láthair.';

  @override
  String get similarName => 'Ainm cosúil';

  @override
  String get sharePublicly => 'Comhroinn go poiblí…';

  @override
  String get pickFramesTitle => 'Roghnaigh frámaí';

  @override
  String get suggestedFrames => 'Frámaí molta';

  @override
  String get scrubFrames => 'Scrollaigh tríd an bhfíseán';

  @override
  String get keepThisFrame => 'Coinnigh an fráma seo';

  @override
  String get fromVideo => 'Ó fhíseán…';

  @override
  String addingPhotos(int done, int total) {
    return 'Grianghraf $done de $total á chur leis…';
  }

  @override
  String get videoMobileOnly =>
      'Oibríonn frámaí a phiocadh as físeán san aip fóin (Android agus iPhone) — ní ar an ngléas seo go fóill.';

  @override
  String get shareWhitelistExplainer =>
      'Roghnaigh a dtéann isteach sa chomhad. Ní chuirtear san áireamh ach réimsí ticeáilte.';

  @override
  String get exportShareFile => 'Easpórtáil comhad comhroinnte…';

  @override
  String get hostedLink => 'Nasc óstáilte (URL an chomhaid uaslódáilte)';

  @override
  String get inlineQr => 'QR ionleabaithe (téacs amháin, gan ghrianghraif)';

  @override
  String get inlineTooBig =>
      'An iomarca sonraí do chód ionleabaithe — díthiceáil réimsí nó úsáid nasc óstáilte.';

  @override
  String get scanShareLabel => 'Scan cód comhroinnte';

  @override
  String get notAShareCode => 'Ní comhroinnt cat(a)log é an cód sin.';

  @override
  String get importShareTitle => 'An cat seo a iompórtáil?';

  @override
  String get importShareTitleNeutral => 'An peata seo a iompórtáil?';

  @override
  String shareSource(String url) {
    return 'Foinse: $url';
  }

  @override
  String get importLabel => 'Iompórtáil';

  @override
  String get strayAreaLabel => 'Limistéar fánaíochta féideartha';

  @override
  String get prevPin => 'Bioráin roimhe';

  @override
  String get nextPin => 'An chéad bhioráin eile';

  @override
  String get noMissingCats =>
      'Níl aon chait ar iarraidh le suíomhanna bileog fós.';

  @override
  String get noMissingCatsNeutral =>
      'Níl aon pheataí ar iarraidh le suíomhanna bileog fós.';

  @override
  String get noMatchCandidates =>
      'Níl aon mheaitseáil fhéideartha faoi láthair.';

  @override
  String sameIdField(String field) {
    return '$field céanna';
  }

  @override
  String metersApart(String distance) {
    return '$distance m óna chéile';
  }

  @override
  String get addFlier => 'Cuir bileog leis';

  @override
  String get missingSinceLabel => 'Ar iarraidh ó';

  @override
  String get phoneLabel => 'Teileafón';

  @override
  String get cropPortrait => 'Bearr an phortráid';

  @override
  String get statusOwner => 'Úinéir';

  @override
  String get ocrUnavailable =>
      'Níl aithint téacs ar fáil ar an ngléas seo — clóscríobh téacs na bileoige tú féin.';

  @override
  String get displayFormat => 'Taispeántar mar';

  @override
  String get displayPlain => 'Gnáth-théacs';

  @override
  String get displayQr => 'Cód QR';

  @override
  String get displayBarcode => 'Barrachód';

  @override
  String get editLabel => 'Cuir in eagar';

  @override
  String get doneLabel => 'Déanta';

  @override
  String get openSettings => 'Oscail socruithe';

  @override
  String get notSaved => 'Gan sábháil';

  @override
  String get birthdateInFuture =>
      'Ní féidir leis an dáta breithe a bheith san am atá le teacht.';

  @override
  String get deceasedInFuture =>
      'Ní féidir leis an dáta báis a bheith san am atá le teacht.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Ní féidir leis an dáta báis a bheith roimh an dáta breithe ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Ní féidir leis an dáta breithe a bheith i ndiaidh an dáta báis ($date).';
  }

  @override
  String get malePregnant =>
      'Tá an cat seo cláraithe mar fhireannach — ní féidir le cat fireann a bheith torrach. Seiceáil an gnéas ar dtús.';

  @override
  String get malePregnantNeutral =>
      'Tá an peata seo cláraithe mar fhireannach — ní féidir le fireannach a bheith torrach. Seiceáil an gnéas ar dtús.';

  @override
  String fatherNotMale(String name) {
    return 'Tá $name cláraithe mar bhaineannach agus ní féidir léi a bheith ina hathair. Seiceáil an gnéas ar dtús.';
  }

  @override
  String motherNotFemale(String name) {
    return 'Tá $name cláraithe mar fhireannach agus ní féidir leis a bheith ina mháthair. Seiceáil an gnéas ar dtús.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return 'Rugadh $name ar $date — ní féidir tuismitheoir a bhreith i ndiaidh a phiscín.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return 'Rugadh $name ar $date — ní féidir tuismitheoir a bhreith i ndiaidh a óig.';
  }

  @override
  String get genderFatherFemale =>
      'Tá an cat seo cláraithe mar athair cat eile — ní féidir leis an athair a bheith baineann. Seiceáil an teaghlach ar dtús.';

  @override
  String get genderFatherFemaleNeutral =>
      'Tá an peata seo cláraithe mar athair peataí eile — ní féidir leis an athair a bheith baineann. Seiceáil an teaghlach ar dtús.';

  @override
  String get genderMotherMale =>
      'Tá an cat seo cláraithe mar mháthair cat eile — ní féidir leis an máthair a bheith fireann. Seiceáil an teaghlach ar dtús.';

  @override
  String get genderMotherMaleNeutral =>
      'Tá an peata seo cláraithe mar mháthair peataí eile — ní féidir leis an máthair a bheith fireann. Seiceáil an teaghlach ar dtús.';

  @override
  String get moveTo => 'Bog go';

  @override
  String get noClowderStrayOption => 'Gan chlowdar — cat fáin / d\'éalaigh sé';

  @override
  String get noClowderStrayOptionNeutral =>
      'Gan líon tí — fánaí / d\'éalaigh sé';

  @override
  String timelineOf(String name) {
    return 'Amlíne — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

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
  String dateFormatError(String format) {
    return 'Formáid mhícheart — úsáid $format';
  }

  @override
  String get dateInFuture => 'Ní féidir leis an dáta seo a bheith sa todhchaí.';

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
  String get forCatsNeutral => 'peataí';

  @override
  String get forClowders => 'clowdair';

  @override
  String get forClowdersNeutral => 'líonta tí';

  @override
  String get forBoth => 'an dá cheann';

  @override
  String get optionsOnePerLine => 'Roghanna (ceann in aghaidh na líne)';

  @override
  String get ownValue => 'Luach féin';

  @override
  String get renameField => 'Athainmnigh an réimse';

  @override
  String get editOptions => 'Cuir roghanna in eagar…';

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
  String get searchByNameHintNeutral => 'Cuardaigh peataí de réir ainm…';

  @override
  String get host => 'Óstáil';

  @override
  String get hostExplainer =>
      'Tosaigh anseo, ansin scan an cód nó cuir isteach é ar an ngléas eile.';

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
      'Úsáideann an dá ghléas an fillteán céanna (m.sh. i Nextcloud nó ar mhéaróg USB). Fágann gach sioncronú do chuid athruithe ann agus tógann sé athruithe an taobh eile.';

  @override
  String get noFolderChosenYet => 'Níl aon fhillteán roghnaithe fós';

  @override
  String get choose => 'Roghnaigh…';

  @override
  String get syncFolderNow => 'Sioncrónaigh an fillteán anois';

  @override
  String folderCatalogHint(Object name) {
    return 'Istigh ann úsáideann an chatalóg seo an fillteán „$name“, mar sin is féidir le fillteán comhroinnte amháin do chuid catalóg ar fad a iompar.';
  }

  @override
  String get useSameFolder => 'Úsáid an fillteán céanna leis na catalóga eile';

  @override
  String get folderHint =>
      'Déanfaidh fillteán ar bith a choinníonn dhá ghléas mar a chéile cúis: tiomántán néil, nó Syncthing d’fhillteán a fhanann ar bhur nguthán. Tá Syncthing saor in aisce: suiteáil ar gach guthán é, comhroinn fillteán amháin eatarthu agus roghnaigh an fillteán sin anseo ar gach gléas.';

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
  String trailOf(String name, int count) {
    return 'Rian: $name ($count feiceáil)';
  }

  @override
  String trailOfField(String name, String field, int count) {
    return 'Rian: $name — $field ($count luach)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Rian: $name ($count suíomh)';
  }

  @override
  String conflictOn(String field) {
    return 'Coinbhleacht — $field';
  }

  @override
  String get conflictBody =>
      'Athraithe in dhá áit ag an am céanna. Roghnaigh cad atá fíor:';

  @override
  String privateMarker(Object field) {
    return '$field (príobháideach)';
  }

  @override
  String conflictSame(Object value) {
    return 'Deir an dá athrú an rud céanna: $value. Níl aon rud le roghnú; glanann Réitigh an marc.';
  }

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
  String get kindCatNeutral => 'peata';

  @override
  String get kindClowder => 'clowdar';

  @override
  String get kindClowderNeutral => 'líon tí';

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
  String get aboutTaglineNeutral =>
      'Catalóg áitiúil do na peataí a dtugann tú aire dóibh. Fanann do shonraí ar do ghléasanna — gan freastalaí, gan chuntas.';

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
  String get coffeeSubtitle =>
      'Fanann an aip saor in aisce. Fiú mura bhfaighidh mé caife :)';

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
  String get starterBreed => 'Pór';

  @override
  String get valueMixed => 'measctha';

  @override
  String get breedEuropeanShorthair => 'Gearrghruagach Eorpach';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Gearrghruagach Briotanach';

  @override
  String get breedNorwegianForestCat => 'Cat Foraoise na hIorua';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamach';

  @override
  String get breedPersian => 'Peirseach';

  @override
  String get breedBengal => 'Beangálach';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get breedAbyssinian => 'Aibisíneach';

  @override
  String get breedAmericanShorthair => 'Meiriceánach gearrfhionnaidh';

  @override
  String get breedBalinese => 'Bailíoch';

  @override
  String get breedBirman => 'Biormach';

  @override
  String get breedBombay => 'Bombay';

  @override
  String get breedBurmese => 'Burmach';

  @override
  String get breedBurmilla => 'Burmilla';

  @override
  String get breedBritishLonghair => 'Briotanach fadfhionnaidh';

  @override
  String get breedChartreux => 'Chartreux';

  @override
  String get breedCornishRex => 'Cornish Rex';

  @override
  String get breedDevonRex => 'Devon Rex';

  @override
  String get breedEgyptianMau => 'Mau Éigipteach';

  @override
  String get breedExoticShorthair => 'Coimhthíoch gearrfhionnaidh';

  @override
  String get breedHimalayan => 'Himiléach';

  @override
  String get breedKorat => 'Korat';

  @override
  String get breedManx => 'Manannach';

  @override
  String get breedMunchkin => 'Munchkin';

  @override
  String get breedOcicat => 'Ocicat';

  @override
  String get breedOrientalShorthair => 'Oirthearach gearrfhionnaidh';

  @override
  String get breedRagamuffin => 'Ragamuffin';

  @override
  String get breedRussianBlue => 'Gorm Rúiseach';

  @override
  String get breedSavannah => 'Savannah';

  @override
  String get breedScottishFold => 'Fillte Albanach';

  @override
  String get breedSelkirkRex => 'Selkirk Rex';

  @override
  String get breedSiberian => 'Sibéarach';

  @override
  String get breedSnowshoe => 'Snowshoe';

  @override
  String get breedSomali => 'Somálach';

  @override
  String get breedTonkinese => 'Tonkinéiseach';

  @override
  String get breedTurkishAngora => 'Angóra Turcach';

  @override
  String get breedTurkishVan => 'Van Turcach';

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
  String get starterEmail => 'Ríomhphost';

  @override
  String get starterPhone => 'Fón';

  @override
  String get lookupUrlLabel => 'Nasc cuardaigh';

  @override
  String lookupUrlHelp(String token) {
    return 'Leathanach na seirbhíse le $token in áit na huimhreach, m.sh. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Cuardaigh';

  @override
  String lookupFailed(String url) {
    return 'Níorbh fhéidir le haon aip $url a oscailt. Cóipeáil an nasc isteach i mbrabhsálaí.';
  }

  @override
  String get stepCat => 'Cat';

  @override
  String get stepCatNeutral => 'Peata';

  @override
  String get stepOwner => 'Úinéir';

  @override
  String get stepFace => 'Grianghraf aghaidhe';

  @override
  String get stepRegistry => 'Clár';

  @override
  String get stepReview => 'Seiceáil agus sábháil';

  @override
  String get stepOwnerHint =>
      'An té a chaill an cat — déantar a chlowdar as seo, leis an teagmháil ón bpóstaer.';

  @override
  String get stepOwnerHintNeutral =>
      'An té a chaill an peata — déantar a líon tí as seo, leis an teagmháil ón bpóstaer.';

  @override
  String get stepFaceHint =>
      'Gearr aghaidh an chait as an bpóstaer; is é sin an pictiúr próifíle. Is féidir é a scipeáil.';

  @override
  String get stepFaceHintNeutral =>
      'Gearr aghaidh an pheata as an bpóstaer; is é sin an pictiúr próifíle. Is féidir é a scipeáil.';

  @override
  String get stepRegistryHint =>
      'Uimhreacha a fuarthas ar an bpóstaer. Sábháiltear na cinn ticeáilte leis an gcat agus osclaítear iad níos déanaí.';

  @override
  String get stepRegistryHintNeutral =>
      'Uimhreacha a fuarthas ar an bpóstaer. Sábháiltear na cinn ticeáilte leis an bpeata agus osclaítear iad níos déanaí.';

  @override
  String get noRegistryLinks =>
      'Níl aon nasc cláir ar an bpóstaer seo — má rinneadh dearmad ar cheann, tuairiscigh fabht le do thoil.';

  @override
  String get unknownServiceHint => 'Seirbhís anaithnid';

  @override
  String get rememberService => 'Cuimhnigh ar an tseirbhís';

  @override
  String get rememberServiceHint =>
      'Ainmnigh an tseirbhís agus taispeáin an uimhir sa nasc. Líonfaidh an chéad phóstaer eile é féin.';

  @override
  String get noIdInLink =>
      'Níl uimhir sa nasc seo is féidir leis an aip a shábháil.';

  @override
  String get whichNumber => 'Cén chuid í an uimhir?';

  @override
  String get cropAgain => 'Gearr arís';

  @override
  String get noFaceYet =>
      'Gan grianghraf aghaidhe fós — úsáidtear grianghraf an phóstaeir.';

  @override
  String get backLabel => 'Ar ais';

  @override
  String get dangerButton => 'NÁ BRÚIGH.\nCONTÚIRT';

  @override
  String get dangerThanks => 'Go raibh maith agat as cat(a)log a úsáid!';

  @override
  String get helpTitle => 'Cabhair';

  @override
  String get showTipsAgain => 'Taispeáin na leideanna arís';

  @override
  String get helpHome =>
      'Forbhreathnú ar do chuid coilíneachtaí — is áit í coilíneacht ina gcónaíonn cait: do theach, teach altrama, tearmann. Tapáil cárta chun a chuid cat a fheiceáil; brúigh go fada don roghchlár. Cruthaíonn an cnaipe ag bun na láimhe deise coilíneacht nua, agus bailíonn cárta na bhfán gach cat gan bhaile. Is é an t-ainm ag barr an chatalóg ina bhfuil tú — tapáil é chun malartú nó ceann a chur leis.';

  @override
  String get helpHomeNeutral =>
      'Forbhreathnú ar do chuid líonta tí — is áit í líon tí ina gcónaíonn peataí: do theach, teach altrama, tearmann. Tapáil cárta chun a chuid peataí a fheiceáil; brúigh go fada don roghchlár. Cruthaíonn an cnaipe ag bun na láimhe deise líon tí nua, agus bailíonn cárta na bhfánaithe gach peata gan bhaile. Is é an t-ainm ag barr an chatalóg ina bhfuil tú — tapáil é chun malartú nó ceann a chur leis.';

  @override
  String get helpClowder =>
      'Gach rud faoin áit seo: a cuid cat, a réimsí (seoladh, teagmháil, cineál) agus a stair. Osclaíonn an leathanach inléite amháin; cuireann an peann luaidhe an eagarthóireacht ar siúl, áit ar féidir réimse nua a chur leis freisin. Brúigh réimse go fada chun é a chur in eagar láithreach, nó cat chun é a bhogadh, a fholú nó a oscailt. Is féidir le coinne a chuirtear leis anseo roinnt cat den choilíneacht a thabhairt léi, turas coillte mar shampla: ticeáil na cait a thagann, críochnaigh uair amháin, bain an tic díobh siúd nár cuireadh cóir orthu. Osclaíonn an clog ar réimse a stair.';

  @override
  String get helpClowderNeutral =>
      'Gach rud faoin áit seo: a cuid peataí, a réimsí (seoladh, teagmháil, cineál) agus a stair. Osclaíonn an leathanach inléite amháin; cuireann an peann luaidhe an eagarthóireacht ar siúl, áit ar féidir réimse nua a chur leis freisin. Brúigh réimse go fada chun é a chur in eagar láithreach, nó peata chun é a bhogadh, a fholú nó a oscailt. Is féidir le coinne a chuirtear leis anseo roinnt peataí den líon tí a thabhairt léi, turas coillte mar shampla: ticeáil na peataí a thagann, críochnaigh uair amháin, bain an tic díobh siúd nár cuireadh cóir orthu. Osclaíonn an clog ar réimse a stair.';

  @override
  String get helpCat =>
      'Gach rud faoin gcat seo: grianghraif, réimsí, teaghlach, stair. Tá an leathanach inléite amháin go dtí go dteagmhaíonn tú leis an bpeann luaidhe. Brúigh réimse go fada chun é a chur in eagar go díreach; brúigh grianghraf go fada dá roghchlár. Tá an chuid eile sa roghchlár ar barr ar dheis: folaigh, cumaisc, taifead amharc, comhroinn an cat. Socraítear „Príobháideach“ agus réimse á chur in eagar. Osclaíonn an clog ar réimse a stair.';

  @override
  String get helpCatNeutral =>
      'Gach rud faoin bpeata seo: grianghraif, réimsí, teaghlach, stair. Tá an leathanach inléite amháin go dtí go dteagmhaíonn tú leis an bpeann luaidhe. Brúigh réimse go fada chun é a chur in eagar go díreach; brúigh grianghraf go fada dá roghchlár. Tá an chuid eile sa roghchlár ar barr ar dheis: folaigh, cumaisc, taifead amharc, comhroinn an peata. Socraítear „Príobháideach“ agus réimse á chur in eagar. Osclaíonn an clog ar réimse a stair.';

  @override
  String get helpStrays =>
      'Cait gan bhaile faoi láthair: cait a fuarthas, cait a d\'éalaigh, nó cait ó phóstaer. Taifeadann cnaipe an cheamara cat atá os do chomhair; casann cnaipe an phóstaeir póstaer cat ar iarraidh ina chat le teagmháil an úinéara; léann an scanóir cód cat(a)log ón bpóstaer. Tapáil Stray Cam le haghaidh grianghraif; coinnigh brúite chun físeán a dhéanamh agus na frámaí is fearr a choinneáil mar ghrianghraif.';

  @override
  String get helpStraysNeutral =>
      'Peataí gan bhaile faoi láthair: ainmhithe a fuarthas, ainmhithe a d\'éalaigh, nó ainmhithe ó phóstaer. Taifeadann cnaipe an cheamara ainmhí atá os do chomhair; casann cnaipe an phóstaeir póstaer peata ar iarraidh ina pheata le teagmháil an úinéara; léann an scanóir cód cat(a)log ón bpóstaer. Tapáil Stray Cam le haghaidh grianghraif; coinnigh brúite chun físeán a dhéanamh agus na frámaí is fearr a choinneáil mar ghrianghraif.';

  @override
  String get helpMap =>
      'Gach cat agus áit a bhfuil suíomh acu. Aimsíonn an cuardach cait, daoine agus áiteanna — cuardaítear ainm anaithnid ar fud an domhain. Tarraingíonn cnaipe na sraitheanna na ciorcail 500 m timpeall áiteanna póstaer cat ar iarraidh agus timpeall an bhaile ar theith sé uaidh. Téann na saigheada ó bhiorán go biorán, agus taifeadann brú fada ar an léarscáil amharc. Is biorán ar an léarscáil gach réimse suímh; tapáil biorán dá rian.';

  @override
  String get helpMapNeutral =>
      'Gach peata agus áit a bhfuil suíomh acu. Aimsíonn an cuardach peataí, daoine agus áiteanna — cuardaítear ainm anaithnid ar fud an domhain. Tarraingíonn cnaipe na sraitheanna na ciorcail 500 m timpeall áiteanna póstaer peata ar iarraidh agus timpeall an bhaile ar theith sé uaidh. Téann na saigheada ó bhiorán go biorán, agus taifeadann brú fada ar an léarscáil amharc. Is biorán ar an léarscáil gach réimse suímh; tapáil biorán dá rian.';

  @override
  String get helpCard =>
      'Cárta inphriontáilte an chait: roghnaigh thuas leis na sliseanna cad a bheidh air, ansin roinn é mar íomhá nó PDF. Is féidir uimhreacha a phriontáil mar QR nó barrachód, agus déantar QR a osclaíonn léarscáil de shuíomh, chomh maith le Plus Code gearr.';

  @override
  String get helpCardNeutral =>
      'Cárta inphriontáilte an pheata: roghnaigh thuas leis na sliseanna cad a bheidh air, ansin roinn é mar íomhá nó PDF. Is féidir uimhreacha a phriontáil mar QR nó barrachód, agus déantar QR a osclaíonn léarscáil de shuíomh, chomh maith le Plus Code gearr.';

  @override
  String get helpSync =>
      'Conas a shroicheann sonraí daoine eile: ceangail go díreach, úsáid fillteán a fheiceann an dá ghléas, nó seol comhad trí theachtaireacht. Is tusa a shocraíonn i gcónaí cad a imíonn — agus osclaítear comhaid .catsync a fhaightear anseo freisin. Síníonn gach catalóg a scríobhann sí lena eochair féin; feiceann comhpháirtithe cód na heochrach in aice le d’ainm. Glactar le chéad eochair comhpháirtí ar iontaoibh ó chomhad agus áirítear í mar dheimhnithe nuair a shioncrónaíonn sibh go pearsanta. Diúltaítear d’iontrálacha faoi ainm aitheanta gan an síniú ceart agus liostaítear iad ar leathanach na teachta.';

  @override
  String get helpFields =>
      'Na réimsí a úsáideann do chatalóg. Athainmnigh iad, athraigh roghanna réimse rogha, nó cruthaigh do chuid féin. Is féidir le réimse aitheantais díriú ar sheirbhís (clár), agus ansin is féidir an uimhir a thapáil ag an gcat.';

  @override
  String get helpFieldsNeutral =>
      'Na réimsí a úsáideann do chatalóg. Athainmnigh iad, athraigh roghanna réimse rogha, nó cruthaigh do chuid féin. Is féidir le réimse aitheantais díriú ar sheirbhís (clár), agus ansin is féidir an uimhir a thapáil ag an bpeata.';

  @override
  String get helpTimeline =>
      'Gach athrú, an ceann is nuaí ar dtús: cé, cathain agus go dtí cén luach. Tapáil iontráil chun í a cheartú, coinnigh í chun í a bhaint nó a athchóiriú; fanann iontráil fholaithe sa loga agus taispeántar í ar iarratas.';

  @override
  String get helpDuplicates =>
      'Cait nó coilíneachtaí atá ann faoi dhó de réir cosúlachta — uimhreacha comhionanna nó ainmneacha an-chosúil le sonraí a mheaitseálann. Tapáil péire chun iad a chumasc; ní féidir cumasc a chur ar ceal, mar sin fiafraítear díot ar dtús.';

  @override
  String get helpDuplicatesNeutral =>
      'Peataí nó líonta tí atá ann faoi dhó de réir cosúlachta — uimhreacha comhionanna nó ainmneacha an-chosúil le sonraí a mheaitseálann. Tapáil péire chun iad a chumasc; ní féidir cumasc a chur ar ceal, mar sin fiafraítear díot ar dtús.';

  @override
  String get helpMatches =>
      'Cait a d\'fhéadfadh a bheith ar an ainmhí céanna: an uimhir chéanna, nó fánaí a chonacthas laistigh de limistéar cuardaigh cat ar iarraidh. Tapáil péire chun iad a chumasc, brúigh go fada chun an chéad chat a oscailt le comparáid a dhéanamh. Liostáiltear freisin péirí a dtagann a gcuma le chéile in dhá thréith nó níos mó gan aon chontrárthacht; taispeánann na sliseanna cé acu. Cuireann „Ní hé an ceann céanna“ péire i bhfolach ar an nguthán seo go dtí go n-athraíonn cuma ceachtar ainmhí.';

  @override
  String get helpMatchesNeutral =>
      'Peataí a d\'fhéadfadh a bheith ar an ainmhí céanna: an uimhir chéanna, nó fánaí a chonacthas laistigh de limistéar cuardaigh peata ar iarraidh. Tapáil péire chun iad a chumasc, brúigh go fada chun an chéad pheata a oscailt le comparáid a dhéanamh. Liostáiltear freisin péirí a dtagann a gcuma le chéile in dhá thréith nó níos mó gan aon chontrárthacht; taispeánann na sliseanna cé acu. Cuireann „Ní hé an ceann céanna“ péire i bhfolach ar an nguthán seo go dtí go n-athraíonn cuma ceachtar ainmhí.';

  @override
  String get helpFlier =>
      'Déantar cat agus a úinéir as póstaer a ghrianghrafáiltear. Céim ar chéim: sonraí an chait, teagmháil an úinéara, an aghaidh a ghearradh don phictiúr próifíle, uimhreacha cláir ón bpóstaer, ansin seiceáil dheiridh. Moltaí atá i ngach rud — ceartaigh cibé rud a léigh an ceamara mícheart.';

  @override
  String get helpFlierNeutral =>
      'Déantar peata agus a úinéir as póstaer a ghrianghrafáiltear. Céim ar chéim: sonraí an pheata, teagmháil an úinéara, an aghaidh a ghearradh don phictiúr próifíle, uimhreacha cláir ón bpóstaer, ansin seiceáil dheiridh. Moltaí atá i ngach rud — ceartaigh cibé rud a léigh an ceamara mícheart.';

  @override
  String get archiveTitle => 'Cartlann';

  @override
  String get archiveExplainer =>
      'Cait a fuair bás agus coilíneachtaí folmha nár bhain aon duine leo le blianta, tógann siad spás fós — go háirithe a gcuid grianghraf. Cuireann an chartlannú isteach i gcomhad iad a choinníonn tú, agus scriosann sé as seo iad ansin.';

  @override
  String get archiveExplainerNeutral =>
      'Peataí a fuair bás agus líonta tí folmha nár bhain aon duine leo le blianta, tógann siad spás fós — go háirithe a gcuid grianghraf. Cuireann an chartlannú isteach i gcomhad iad a choinníonn tú, agus scriosann sé as seo iad ansin.';

  @override
  String get archiveAction => 'Cartlannaigh';

  @override
  String archiveSelected(int count) {
    return 'Cartlannaigh $count iontráil';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Cartlannaigh $count iontráil?';
  }

  @override
  String archiveConfirmBody(String names) {
    return 'Scríobhfar $names i gcomhad agus scriosfar ansin iad — ar do ghléas agus ar gach gléas a shioncronaíonn tú leis. Cuireann iompórtáil an chomhaid gach rud ar ais; gan é, tá siad imithe.';
  }

  @override
  String archiveDone(int count) {
    return 'Cartlannaíodh agus scriosadh $count iontráil';
  }

  @override
  String archiveFailed(String error) {
    return 'Níor scriosadh aon rud: níorbh fhéidir comhad na cartlainne a scríobh ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Bunachar $db, grianghraif $photos i $count comhad';
  }

  @override
  String quietForYears(int years) {
    return 'Gan athrú le $years bliana';
  }

  @override
  String get nothingToArchive => 'Níl aon rud sean go leor le cartlannú.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Athrú deireanach $date · grianghraif $size';
  }

  @override
  String get helpArchive =>
      'Cosnaíonn sonraí sean spás, go háirithe na grianghraif a iompraíonn gach gléas sioncronaithe. Anseo roghnaíonn tú cait a fuair bás agus coilíneachtaí folmha atá ciúin le blianta, scríobhann tú i gcomhad iad a choinníonn tú, agus scriosann tú iad. Sroicheann an scriosadh gach duine a shioncronaíonn tú leis; cuireann iompórtáil an chomhaid gach rud ar ais.';

  @override
  String get helpArchiveNeutral =>
      'Cosnaíonn sonraí sean spás, go háirithe na grianghraif a iompraíonn gach gléas sioncronaithe. Anseo roghnaíonn tú peataí a fuair bás agus líonta tí folmha atá ciúin le blianta, scríobhann tú i gcomhad iad a choinníonn tú, agus scriosann tú iad. Sroicheann an scriosadh gach duine a shioncronaíonn tú leis; cuireann iompórtáil an chomhaid gach rud ar ais.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Athchóirigh $count iontráil scriosta?';
  }

  @override
  String restoreDeletedBody(String names) {
    return 'Tá $names scriosta sa chatalóg seo, agus tá siad sa chomhad a d\'iompórtáil tú anois. Cuireann an t-athchóiriú ar ais anseo iad agus ar gach gléas a shioncronaíonn tú leis.';
  }

  @override
  String get restoreAction => 'Athchóirigh';

  @override
  String get keepDeleted => 'Fág scriosta';

  @override
  String get archiveNotSaved =>
      'Níor scriosadh aon rud: níor sábháladh an chartlann in aon áit.';

  @override
  String get locateAddress => 'Aimsigh an seoladh ar an léarscáil';

  @override
  String get addressFoundTitle => 'Aimsíodh an seoladh';

  @override
  String get replaceAddressOption => 'An seoladh a athrú go dtí é seo';

  @override
  String get addPositionOption => 'An suíomh a shábháil';

  @override
  String get addressLocated => 'Seoladh aimsithe';

  @override
  String get addressNotFound =>
      'Níor aimsíodh aon áit don seoladh seo. Seiceáil an litriú nó fág folamh é.';

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
  String get markTitleNeutral => 'Marcáil an peata';

  @override
  String get applyCrop => 'Bearr';

  @override
  String get useFullPhoto => 'Úsáid an grianghraf iomlán';

  @override
  String get dragToSelect => 'Tarraing dronuilleog timpeall an chait';

  @override
  String get dragToSelectNeutral => 'Tarraing dronuilleog timpeall an pheata';

  @override
  String get dragOverTheCat => 'Tarraing éilips os cionn an chait';

  @override
  String get dragOverTheCatNeutral => 'Tarraing éilips os cionn an pheata';

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
  String lastBackupFailed(String error) {
    return 'Theip ar an gcúltaca uathoibríoch deireanach: $error';
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
  String get typeUnitValue => 'Luach le haonad';

  @override
  String get dimension => 'Méid';

  @override
  String get dimensionWeight => 'Meáchan';

  @override
  String get dimensionLength => 'Fad';

  @override
  String get dimensionVolume => 'Toirt';

  @override
  String get dimensionTemperature => 'Teocht';

  @override
  String get unitsLabel => 'Aonaid';

  @override
  String get catalogHolds => 'Sa chatalóg seo tá';

  @override
  String get modeCats => 'Cait';

  @override
  String get modePets => 'Peataí';

  @override
  String get graphLabel => 'Graf';

  @override
  String get fieldHistoryTooltip => 'Stair';

  @override
  String get rangeWeek => 'Seachtain';

  @override
  String get rangeMonth => 'Mí';

  @override
  String get rangeYear => 'Bliain';

  @override
  String get rangeAll => 'Uile';

  @override
  String get rangeCustom => 'Saincheaptha…';

  @override
  String changeSince(String delta, String date) {
    return '$delta ó $date';
  }

  @override
  String get unitsAuto => 'Mar atá i do réigiún';

  @override
  String get unitsMetric => 'Méadrach (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Impiriúil (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Meáchan';

  @override
  String get starterLooks => 'Cuma';

  @override
  String get looksGroupSize => 'Méid';

  @override
  String get looksGroupColours => 'Dathanna';

  @override
  String get looksGroupPattern => 'Patrún';

  @override
  String get looksGroupFur => 'Fionnadh';

  @override
  String get looksGroupTail => 'Eireaball';

  @override
  String get looksGroupEars => 'Cluasa';

  @override
  String get looksGroupMarks => 'Marcanna';

  @override
  String get looksGroupCrest => 'Cíor';

  @override
  String get looksGroupBeak => 'Gob';

  @override
  String get looksGroupRing => 'Fáinne';

  @override
  String get looksValueSmall => 'Beag';

  @override
  String get looksValueMedium => 'Meánach';

  @override
  String get looksValueLarge => 'Mór';

  @override
  String get looksValueBlack => 'Dubh';

  @override
  String get looksValueWhite => 'Bán';

  @override
  String get looksValueGrey => 'Liath';

  @override
  String get looksValueBrown => 'Donn';

  @override
  String get looksValueGinger => 'Rua';

  @override
  String get looksValueCream => 'Uachtar';

  @override
  String get looksValueGolden => 'Órga';

  @override
  String get looksValueTan => 'Buíbhán';

  @override
  String get looksValueGreen => 'Glas';

  @override
  String get looksValueBlue => 'Gorm';

  @override
  String get looksValueYellow => 'Buí';

  @override
  String get looksValueRed => 'Dearg';

  @override
  String get looksValueOrange => 'Oráiste';

  @override
  String get looksValuePink => 'Bándearg';

  @override
  String get looksValueWhiteBib => 'Bibe bán';

  @override
  String get looksValueWhitePaws => 'Lapaí bána';

  @override
  String get looksValueWhiteTailTip => 'Barr eireabaill bán';

  @override
  String get looksValueBlaze => 'Réalta';

  @override
  String get looksValueMask => 'Masc';

  @override
  String get looksValueSpots => 'Spotaí';

  @override
  String get looksValuePatches => 'Paistí';

  @override
  String get looksValueStripes => 'Straidhpeanna';

  @override
  String get looksValueScar => 'Colm';

  @override
  String get looksValueNotchedEar => 'Cluas eangaithe';

  @override
  String get looksValueEarTip => 'Barr cluaise';

  @override
  String get looksValueCollar => 'Coiléar';

  @override
  String get looksValueShort => 'Gearr';

  @override
  String get looksValueLong => 'Fada';

  @override
  String get looksValueHairless => 'Gan fionnadh';

  @override
  String get looksValueBobtail => 'Eireaball gearr';

  @override
  String get looksValueNone => 'Gan';

  @override
  String get looksValueCurled => 'Casta';

  @override
  String get looksValueUpright => 'Ina seasamh';

  @override
  String get looksValueFloppy => 'Ar sileadh';

  @override
  String get looksValueFolded => 'Fillte';

  @override
  String get looksValueRounded => 'Cruinn';

  @override
  String get looksValueSolid => 'Aondathach';

  @override
  String get looksValueTabby => 'Tabaí';

  @override
  String get looksValueTortoiseshell => 'Toirtís';

  @override
  String get looksValueCalico => 'Calico';

  @override
  String get looksValueColourpoint => 'Colourpoint';

  @override
  String get looksValueBicolour => 'Dédhathach';

  @override
  String get looksValueTuxedo => 'Tuxedo';

  @override
  String get looksValueBrindle => 'Brindle';

  @override
  String get looksValueMerle => 'Merle';

  @override
  String get looksValueSpotted => 'Spotach';

  @override
  String get looksValuePatched => 'Paisteach';

  @override
  String get looksValueTricolour => 'Trídhathach';

  @override
  String get looksValueSable => 'Sable';

  @override
  String get looksGroupEyes => 'Súile';

  @override
  String get looksGroupFeatures => 'Sainghnéithe';

  @override
  String get looksValueAmber => 'Ómra';

  @override
  String get looksValueCopper => 'Copair';

  @override
  String get looksValueOddEyed => 'Súile éagsúla';

  @override
  String get looksValueChocolate => 'Seacláid';

  @override
  String get looksValueLilac => 'Liath-chorcra';

  @override
  String get looksValueSilver => 'Airgead';

  @override
  String get looksValueSmoke => 'Deatach';

  @override
  String get looksValueTicked => 'Ticked';

  @override
  String get looksValueVan => 'Van';

  @override
  String get looksValueCurly => 'Catach';

  @override
  String get looksValueWiry => 'Garbh';

  @override
  String get looksValueKinked => 'Casta';

  @override
  String get looksValueCropped => 'Bearrtha';

  @override
  String get looksValueTippedEar => 'Cluas bearrtha';

  @override
  String get looksValueEarTattoo => 'Tatú cluaise';

  @override
  String get looksValueMissingEar => 'Cluas ar iarraidh';

  @override
  String get looksValueMissingEye => 'Súil ar iarraidh';

  @override
  String get looksValueCloudyEye => 'Súil scamallach';

  @override
  String get looksValueMissingFrontLeg => 'Cos tosaigh ar iarraidh';

  @override
  String get looksValueMissingHindLeg => 'Cos deiridh ar iarraidh';

  @override
  String get looksValueNoTeeth => 'Gan fiacla';

  @override
  String get looksValueExtraToes => 'Ladhracha breise';

  @override
  String get rejectMatch => 'Ní hé an ceann céanna';

  @override
  String traitsAgree(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tréith ag teacht le chéile',
      many: '$count dtréith ag teacht le chéile',
      few: '$count thréith ag teacht le chéile',
      two: '$count thréith ag teacht le chéile',
      one: '$count tréith ag teacht le chéile',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Réamhshocrú an chórais';

  @override
  String get iosLocalNetworkHint =>
      'Má theipeann air i gcónaí ar iPhone/iPad: Socruithe → Príobháideachas agus slándáil → Líonra áitiúil → ceadaigh cat(a)log agus bain triail eile as.';

  @override
  String get includePrivate => 'Comhroinn sonraí príobháideacha';

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
  String get starterStatus => 'Cineál';

  @override
  String get statusFoster => 'Teach altrama';

  @override
  String get statusForeverHome => 'Baile';

  @override
  String get statusClinic => 'Clinic';

  @override
  String get statusShelter => 'Tearmann';

  @override
  String get statusBarn => 'Scioból';

  @override
  String get valueCat => 'Cat';

  @override
  String get valueDog => 'Madra';

  @override
  String get valueRabbit => 'Coinín';

  @override
  String get valueGuineaPig => 'Muc ghuine';

  @override
  String get valueHamster => 'Hamstar';

  @override
  String get valueBird => 'Éan';

  @override
  String get valueHorse => 'Capall';

  @override
  String get valueTortoise => 'Toirtís';

  @override
  String get valueFerret => 'Firéad';

  @override
  String get otherOption => 'Eile…';

  @override
  String get celebrationsToggle => 'Ceiliúradh uchtálacha';

  @override
  String get celebrationsSubtitle =>
      'Coinfití agus gártha nuair a bhogann cat go dtí a bhaile';

  @override
  String get cheerToggle => 'Fuaim gártha';

  @override
  String get cheerSubtitle =>
      'Gártha gearra leis an confetti, ceann difriúil gach uair';

  @override
  String get celebrationsSubtitleNeutral =>
      'Coinfití agus gártha nuair a bhogann peata go dtí a bhaile';

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
  String get mapSearchHintNeutral => 'Cuardaigh peataí, líonta tí, daoine';

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
  String get yourKey => 'D’eochair';

  @override
  String get yourTitle => 'Do theideal';

  @override
  String get titleNone => 'Gan teideal';

  @override
  String keyLine(Object code) {
    return 'eochair $code';
  }

  @override
  String get keyVerified => 'deimhnithe go pearsanta';

  @override
  String get keyFromFile => 'ó chomhad, gan deimhniú fós';

  @override
  String get keyUnsigned => 'gan eochair fós, iontrálacha gan síniú';

  @override
  String get summaryRefused => 'Diúltaithe';

  @override
  String refusedEntries(int count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count iontráil diúltaithe',
      many: '$count n-iontráil diúltaithe',
      few: '$count iontráil diúltaithe',
      two: '$count iontráil diúltaithe',
      one: '$count iontráil diúltaithe',
    );
    return '$_temp0: gan síniú leis an eochair aitheanta do $name';
  }

  @override
  String newKeyCallsItself(Object code, Object name) {
    return 'Tugann eochair nua $code $name uirthi féin. Fiafraigh den duine sula gcuireann tú muinín inti.';
  }

  @override
  String keyChangedRefused(Object name) {
    return 'Thairg $name eochair seachas an ceann atá aitheanta anseo. Fanann an ceann aitheanta; níor glacadh leis an gceann nua.';
  }

  @override
  String metaNewKey(Object name, Object code, Object how) {
    return 'Eochair nua: $name · $code ($how)';
  }

  @override
  String hardDeleteWarningKey(Object name, Object key) {
    return 'Baineann sé gach iontráil agus grianghraf a scríobh $name faoin eochair $key den chatalóg seo. Coinníonn gléasanna eile a gcuid féin. Ní féidir é a chealú.';
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
  String conflictsMenu(int n) {
    return 'Coinbhleachtaí ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Réitigh tú coinbhleacht anseo, mar sin níl Diúltaigh ar fáil: chealódh sé sin freisin.';

  @override
  String get arrivalIntro =>
      'Tá na hathruithe seo sa chatalóg agat cheana. Cuireann Diúltaigh ar ais mar a bhí é.';

  @override
  String get summaryUpdated => 'Nuashonraithe';

  @override
  String get summaryDeleted => 'Scriosta';

  @override
  String get keepMine => 'Coinnigh mo cheann';

  @override
  String keptMine(String name) {
    return 'Coinníodh do leagan de $name ar an ngléas seo.';
  }

  @override
  String get summaryMeta => 'Tháinig freisin';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n athrú',
      many: '$n n-athrú',
      few: '$n athrú',
      two: '$n athrú',
      one: '1 athrú',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Glac';

  @override
  String get rejectArrival => 'Diúltaigh';

  @override
  String get photoAdded => 'Grianghraf curtha leis';

  @override
  String get photoNotReceived => 'Grianghraf gan a fháil fós';

  @override
  String get photoRemoved => 'Grianghraf bainte';

  @override
  String metaFieldAdded(String name) {
    return 'Réimse nua: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Réimse athraithe: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser cumaiscthe isteach i $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n grianghraf',
      many: '$n ngrianghraf',
      few: '$n ghrianghraf',
      two: '$n ghrianghraf',
      one: '1 ghrianghraf',
    );
    return '$_temp0';
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
  String get kittensLabelNeutral => 'Óga';

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
  String toastBornNeutral(Object cat) {
    return '✨ Nuabheirthe: $cat ✨';
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
  String get syncChooserInPersonSub => 'Sioncronú trí Wi-Fi';

  @override
  String get syncChooserRemote => 'I gcéin';

  @override
  String get syncChooserRemoteSub => 'Sioncronú trí fhillteán nó méaróg USB';

  @override
  String get syncChooserMessenger => 'Teachtaire';

  @override
  String get syncChooserMessengerSub =>
      'Easpórtáil agus iompórtáil trí na meáin shóisialta';

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
  String get selectClowderHintNeutral => 'Roghnaigh líon tí ar chlé';

  @override
  String get introTitle1 => 'Do chait, in ord';

  @override
  String get introTitle1Neutral => 'Do pheataí, in ord';

  @override
  String get introBody1 =>
      'Cruthaigh cárta do gach cat: grianghraf, gnéas, sláinte, rud ar bith is mian leat a nótáil. Grúpáiltear na cait de réir na háite a gcónaíonn siad — clowder a thugann an aip ar an áit sin.';

  @override
  String get introBody1Neutral =>
      'Cruthaigh cárta do gach peata a dtugann tú aire dó: grianghraf, gnéas, sláinte, rud ar bith is mian leat a nótáil. Grúpáiltear na peataí de réir na háite a gcónaíonn siad — líon tí a thugann an aip ar an áit sin.';

  @override
  String get introTitle2 => 'Oibríonn sé gan idirlíon';

  @override
  String get introBody2 =>
      'Sábháiltear gach rud ar do ghuthán amháin. Gan chuntas, gan néal. Ní uaslódáiltear rud ar bith mura roinneann tú féin é.';

  @override
  String get introTitle3 => 'Oibrigí le chéile';

  @override
  String get introBody3 =>
      'Úsáideann gach duine a aip féin agus malartaíonn sibh sonraí ó am go ham: buailigí le chéile agus scanáil cód, úsáidigí fillteán comhroinnte, nó seolaigí comhad amháin trí theachtaire. Ina dhiaidh sin bíonn an t-eolas céanna ag gach duine.';

  @override
  String get introSkip => 'Scipeáil';

  @override
  String get introNext => 'Ar aghaidh';

  @override
  String get introDone => 'Ar aghaidh linn';

  @override
  String get introReplayTitle => 'Réamhrá tapa';

  @override
  String get spotHomeSync =>
      'Sioncronaigh anseo le daoine a bhfuil aithne agat orthu. Is tusa a shocraíonn cad a roinneann tú.';

  @override
  String get spotHomeStrays =>
      'Bailíonn an cárta seo na fáin go léir — cait gan bhaile. Tapáil chun an liosta a fheiceáil.';

  @override
  String get spotHomeStraysNeutral =>
      'Bailíonn an cárta seo na fánaithe go léir — peataí gan bhaile. Tapáil chun an liosta a fheiceáil.';

  @override
  String get spotHomeMenu =>
      'Sa roghchlár seo: socruithe, dúbailtí a aimsiú agus a chumasc, CSV a easpórtáil, agus tuilleadh.';

  @override
  String get spotCatEdit =>
      'Tapáil an peann luaidhe chun an cat seo a chur in eagar. Leid: brúigh réimse go fada chun é a chur in eagar go díreach.';

  @override
  String get spotCatEditNeutral =>
      'Tapáil an peann luaidhe chun an peata seo a chur in eagar. Leid: brúigh réimse go fada chun é a chur in eagar go díreach.';

  @override
  String get spotMapLayers =>
      'Ag lorg cat ar iarraidh? Taispeáin ciorcail timpeall áiteanna a phóstaer agus timpeall an bhaile ar theith sé uaidh.';

  @override
  String get spotMapLayersNeutral =>
      'Ag lorg peata ar iarraidh? Taispeáin ciorcail timpeall áiteanna a phóstaer agus timpeall an bhaile ar theith sé uaidh.';

  @override
  String get spotStraysFlier =>
      'Póstaer cat ar iarraidh? Glac grianghraf de anseo — sábhálann an aip an cat agus an teagmháil duit.';

  @override
  String get spotStraysFlierNeutral =>
      'Póstaer peata ar iarraidh? Glac grianghraf de anseo — sábhálann an aip an peata agus an teagmháil duit.';

  @override
  String get spotStraysScan =>
      'Bíonn cód QR cat(a)log ar roinnt póstaer. Scan anseo é agus iompórtáil an cat gan clóscríobh.';

  @override
  String get spotStraysScanNeutral =>
      'Bíonn cód QR cat(a)log ar roinnt póstaer. Scan anseo é agus iompórtáil an peata gan clóscríobh.';

  @override
  String get introTitle4 => 'Aimsigh cait ar iarraidh';

  @override
  String get introTitle4Neutral => 'Aimsigh peataí ar iarraidh';

  @override
  String get introBody4 =>
      'An bhfeiceann tú póstaer faoi chat ar iarraidh? Glac grianghraf de san aip: sábhálann sí an cat, teagmháil an úinéara agus an áit. Má thagann fánaí cosúil leis chun cinn níos déanaí, molann an aip meaitseálacha féideartha.';

  @override
  String get introBody4Neutral =>
      'An bhfeiceann tú póstaer faoi pheata ar iarraidh? Glac grianghraf de san aip: sábhálann sí an peata, teagmháil an úinéara agus an áit. Má thagann fánaí cosúil leis chun cinn níos déanaí, molann an aip meaitseálacha féideartha.';

  @override
  String get spotMapSearch =>
      'Clóscríobh cat, áit nó duine chun léim ansin ar an léarscáil.';

  @override
  String get spotMapSearchNeutral =>
      'Clóscríobh peata, áit nó duine chun léim ansin ar an léarscáil.';

  @override
  String get spotCardChips =>
      'Ticeáil an méid ba chóir a bheith ar an gcárta inroinnte — fanann an chuid eile de.';

  @override
  String get spotCatMenu =>
      'Tuilleadh gníomhartha anseo: folaigh an cat, cumaisc dúbailtí, nó taifead amharc.';

  @override
  String get spotCatMenuNeutral =>
      'Tuilleadh gníomhartha anseo: folaigh an peata, cumaisc dúbailtí, nó taifead amharc.';

  @override
  String get spotDone => 'Tuigim';

  @override
  String get spotReplayTitle => 'Turas na nuachta';

  @override
  String get spotReplaySubtitle =>
      'Taispeáin na leideanna arís ar gach leathanach';

  @override
  String get spotReplayDone => 'Taispeánfar na leideanna arís';

  @override
  String get searchNoResults => 'Níor aimsíodh cat leis an ainm sin';

  @override
  String get searchNoResultsNeutral => 'Níor aimsíodh peata leis an ainm sin';

  @override
  String get syncUnreachable =>
      'Níorbh fhéidir an gléas eile a shroicheadh. An bhfuil an bheirt ar an Wi-Fi céanna?';

  @override
  String get folderUnreachable =>
      'Níorbh fhéidir an fillteán a shroicheadh. An ann fós don tiomántán nó don fhillteán néil?';

  @override
  String get crashTitle => 'Níor cheart go dtarlódh sé sin';

  @override
  String get crashBody =>
      'Bhuail cat(a)log earráid gan choinne. Tá do shonraí slán — sábháiltear gach rud an nóiméad a athraíonn tú é. Atosaigh an aip, agus má tharlaíonn sé arís, seol an tuairisc le go ndeiseofar é.';

  @override
  String get crashRestart => 'Atosaigh an aip';

  @override
  String get crashSendReport => 'Seol tuairisc chuig an bhforbróir';

  @override
  String get crashLastRunBody =>
      'Stad cat(a)log gan choinne an uair dheireanach — is dócha gur rith an chuimhne amach. Tuairisc ghearr a sheoladh le go ndeiseofar é?';

  @override
  String get catalogsTitle => 'Catalóga';

  @override
  String get newCatalog => 'Catalóg nua';

  @override
  String get intoCatalog => 'Isteach sa chatalóg';

  @override
  String get catalogNameLabel => 'Ainm na catalóige';

  @override
  String catalogNameTaken(String name) {
    return 'Tá catalóg darb ainm $name ann cheana. Roghnaigh ainm eile.';
  }

  @override
  String get manageCatalogs => 'Bainistigh catalóga';

  @override
  String get restoreTitle => 'Athchóirigh cúltacaí';

  @override
  String get restoreIntro =>
      'Tá cúltacaí ó shuiteáil roimhe seo ar an ngléas seo. Déantar catalóg arís de gach ceann.';

  @override
  String get restoreNone =>
      'Níor aimsíodh cúltacaí ar an ngléas seo. Roghnaigh comhaid le hathchóiriú ó áit eile.';

  @override
  String get restoreBackupsMenu => 'Athchóirigh cúltacaí…';

  @override
  String get restorePickFiles => 'Roghnaigh comhaid…';

  @override
  String restoreFileLine(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comhad',
      many: '$count gcomhad',
      few: '$count chomhad',
      two: '$count chomhad',
      one: '1 chomhad',
    );
    return '$_temp0, is déanaí $date';
  }

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Athchóiríodh $count catalóg.',
      many: 'Athchóiríodh $count gcatalóg.',
      few: 'Athchóiríodh $count chatalóg.',
      two: 'Athchóiríodh $count chatalóg.',
      one: 'Athchóiríodh 1 chatalóg.',
      zero: 'Níor athchóiríodh aon rud.',
    );
    return '$_temp0';
  }

  @override
  String get helpCatalogs =>
      'Is domhan ann féin gach catalóg: a cait féin, coilíneachtaí, réimsí, grianghraif agus comhpháirtithe sioncronaithe. Ní mheascann Beirlín agus Páras riamh. Tapáil catalóg le hathrú chuici. Osclaíonn an giar ar chatalóg a socruithe: ainm, cait nó peataí, réimsí, údair agus coscanna, cartlann, dul siar, scriosadh. Tá d’ainm, do theanga agus na leideanna atá feicthe agat i bpáirt acu uile.';

  @override
  String get helpCatalogsNeutral =>
      'Is domhan ann féin gach catalóg: a peataí féin, teaghlaigh, réimsí, grianghraif agus comhpháirtithe sioncronaithe. Ní mheascann Beirlín agus Páras riamh. Tapáil catalóg le hathrú chuici. Osclaíonn an giar ar chatalóg a socruithe: ainm, cait nó peataí, réimsí, údair agus coscanna, cartlann, dul siar, scriosadh. Tá d’ainm, do theanga agus na leideanna atá feicthe agat i bpáirt acu uile.';

  @override
  String get helpCatalogSettings =>
      'Gach rud a bhaineann leis an gcatalóg seo amháin: a hainm, cé acu cait nó peataí atá ann, a réimsí, a húdair agus coscanna, an chartlann agus dul siar in am. Ní bhaineann athruithe anseo ach leis an gcatalóg seo — fiú ceann nach bhfuil tú ann. Scríobhann scriosadh an chatalóg i gcomhad ar dtús. Is í d’eochair an cód a fheiceann comhpháirtithe in aice le d’ainm; fanann sí leis an gcatalóg seo.';

  @override
  String get spotHomeCatalog =>
      'Seo an chatalóg ina bhfuil tú. Tapáil an t-ainm chun malartú nó ceann eile a chruthú.';

  @override
  String get deleteCatalog => 'Scrios an chatalóg';

  @override
  String get catalogSettings => 'Socruithe an chatalóg';

  @override
  String deleteCatalogBody(String name) {
    return 'Imíonn gach rud in $name: na cait, na grianghraif, an stair. Sábháiltear comhad iomlán ar dtús san áit a dtéann na cúltacaí uathoibríocha — tugann a iompórtáil an chatalóg ar ais.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Imíonn gach rud in $name: na peataí, na grianghraif, an stair. Sábháiltear comhad iomlán ar dtús san áit a dtéann na cúltacaí uathoibríocha — tugann a iompórtáil an chatalóg ar ais. Clóscríobh an t-ainm le deimhniú.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return 'Scriosadh $name. Tá an comhad in $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Clóscríobh $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Níor scriosadh aon rud: níorbh fhéidir comhad na catalóige a scríobh ($error). Déan spás a shaoradh nó bain triail eile as níos déanaí.';
  }

  @override
  String get moveToCatalog => 'Bog go catalóg eile';

  @override
  String movedToCatalog(int count, String name) {
    return 'Bogadh $count go $name';
  }

  @override
  String get chooseWhatToMove => 'Cad a bhogfaidh?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Rud éigin a bhogadh go $name?';
  }

  @override
  String get undoThisImport => 'Cealaigh an t-iompórtáil seo';

  @override
  String undoImportBody(int count) {
    return 'Baintear na $count athrú a thug an t-iompórtáil seo isteach. Scríobhtar iad chuig comhad ar dtús, agus tugann a iompórtáil ar ais iad. Coinníonn na daoine ar shioncronaigh tú leo cheana a gcóip féin — ní féidir é sin a tharraingt siar.';
  }

  @override
  String undoneImport(String where) {
    return 'Cealaithe. Tá an comhad in $where.';
  }

  @override
  String get goBackTitle => 'Téigh siar';

  @override
  String get goBackToHere => 'Fill anseo';

  @override
  String get momentImport => 'Roimh an iompórtáil';

  @override
  String get momentSync => 'Roimh an sioncronú';

  @override
  String get momentMerge => 'Roimh an gcumasc';

  @override
  String get momentHardDelete => 'Roimh shonraí údair a scriosadh';

  @override
  String get momentArchive => 'Roimh an gcartlannú';

  @override
  String get momentManual => 'Marcáilte agatsa';

  @override
  String get showOlderMoments => 'Taispeáin cinn níos sine';

  @override
  String goBackBody(int count) {
    return 'Baintear gach rud i ndiaidh na nóiméide seo — $count athrú. Scríobhtar é chuig comhad ar dtús, agus tugann a iompórtáil ar ais é; imíonn gach nóiméad níos nuaí leis. Coinníonn na daoine ar shioncronaigh tú leo a gcóip — ní féidir é sin a tharraingt siar.';
  }

  @override
  String get nameThisMoment => 'Ainmnigh an nóiméad seo';

  @override
  String get helpGoBack =>
      'Na nóiméid inar athraigh an chatalóg seo a cruth: roimh gach iompórtáil agus gach sioncronú, roimh chumasc, cartlannú nó scriosadh, agus gach uair a mharcáil tú féin ceann. Má roghnaíonn tú ceann, filleann an chatalóg ar an staid sin — scríobhtar gach rud ina dhiaidh chuig comhad a choinníonn tú agus baintear ansin é, agus imíonn gach nóiméad níos nuaí leis. Coinníonn na daoine ar shioncronaigh tú leo an méid a fuair siad.';

  @override
  String goBackFileFailed(String error) {
    return 'Níor baineadh aon rud: níorbh fhéidir an comhad a choinníonn é a scríobh ($error). Saor spás agus bain triail eile as.';
  }

  @override
  String get goBackChanged =>
      'Níor baineadh aon rud: d\'athraigh an chatalóg fad a bhí an comhad á shábháil. Bain triail eile as.';

  @override
  String get switchBeforeDeleting =>
      'Seo an chatalóg ina bhfuil tú. Athraigh go ceann eile agus scrios ansin í.';

  @override
  String shareFileFailed(String error) {
    return 'Níorbh fhéidir an comhad comhroinnte a scríobh ($error). Saor spás agus bain triail eile as.';
  }

  @override
  String get privateLabel => 'Príobháideach';

  @override
  String sharedCatalogIs(String name) {
    return 'Catalóg: $name';
  }

  @override
  String get markPrivate => 'Marcáil mar phríobháideach';

  @override
  String get unmarkPrivate => 'Bain an marc príobháideach';

  @override
  String get agenda => 'Meabhrúcháin';

  @override
  String get reminderLabel => 'Meabhrúchán';

  @override
  String get agendaEmpty =>
      'Níl aon choinne beartaithe. Beartaigh cinn nua anseo leis an bplus, nó ar leathanach cait nó clowdair.';

  @override
  String get agendaEmptyNeutral =>
      'Níl aon choinne beartaithe. Beartaigh cinn nua anseo leis an bplus, nó ar leathanach peata nó lín tí.';

  @override
  String get dueToday => 'inniu';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'i gceann $count lá',
      many: 'i gceann $count lá',
      few: 'i gceann $count lá',
      two: 'i gceann $count lá',
      one: 'i gceann 1 lá',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lá thar téarma',
      many: '$count lá thar téarma',
      few: '$count lá thar téarma',
      two: '$count lá thar téarma',
      one: '1 lá thar téarma',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Déanta';

  @override
  String get repeatTitle => 'Arís i gceann…';

  @override
  String get noRepeatLabel => 'Gan athdhéanamh';

  @override
  String get unitDays => 'lá';

  @override
  String get unitWeeks => 'seachtaine';

  @override
  String get unitMonths => 'mí';

  @override
  String get unitYears => 'bliana';

  @override
  String ageYears(int years) {
    return '$years bl.';
  }

  @override
  String ageMonths(int months) {
    return '$months mhí';
  }

  @override
  String get changeDateLabel => 'Athraigh an dáta';

  @override
  String get removeReminderLabel => 'Bain an meabhrúchán';

  @override
  String get exportIcs => 'Easpórtáil comhad féilire';

  @override
  String get resyncCalendar => 'Athshioncronaigh an féilire';

  @override
  String icsSavedTo(String path) {
    return 'Sábháladh an comhad féilire faoi $path';
  }

  @override
  String get calendarMirrorLabel => 'Scáthánaigh chuig féilire an ghléis';

  @override
  String get calendarMirrorSubtitle =>
      'Feictear na coinní mar imeachtaí lae iomláin san fhéilire. Nuashonraíonn cat(a)log ansin iad ag gach tosú agus tar éis gach athraithe. Is féidir leat foláirimh do na coinní a bhainistiú san fhéilire.';

  @override
  String get syncPeerOlder =>
      'Tá cat(a)log níos sine gan mheabhrúcháin ar an ngléas eile. Nuashonraigh cat(a)log ansin agus sioncronaigh arís.';

  @override
  String get syncPeerNewer =>
      'Tá cat(a)log níos nuaí ar an ngléas eile. Nuashonraigh cat(a)log ar an ngléas seo agus sioncronaigh arís.';

  @override
  String get syncPeerNoTls =>
      'Tá cat(a)log roimh 1.1.0 ar an ngléas eile, gan sioncronú criptithe. Nuashonraigh cat(a)log ansin, ansin sioncronaigh arís.';

  @override
  String get syncWrongHost =>
      'Ní réitíonn an teastas leis an gcód péireála — ní hé seo an gléas ar tháinig an cód uaidh. Scan nó clóscríobh an cód arís.';

  @override
  String get bundleNewerError =>
      'Tagann an comhad seo ó cat(a)log níos nuaí. Nuashonraigh cat(a)log ar an ngléas seo chun é a iompórtáil.';

  @override
  String get spotEar =>
      'Ciallaíonn cluas bheag cait i gcúinne: coinnigh brúite le haghaidh tuilleadh.';

  @override
  String get addReminder => 'Cuir meabhrúchán leis';

  @override
  String get plannedSection => 'Beartaithe';

  @override
  String get reminderDialogHint =>
      'Feictear an choinne sna meabhrúcháin. Is féidir leat í a dheimhniú nó a dhiúltú ansin. Ní ghlactar an luach ach amháin nuair a dheimhnítear an choinne.';

  @override
  String get reminderFor => 'Do';

  @override
  String get reminderField => 'Réimse';

  @override
  String get dueDateLabel => 'Spriocdháta';

  @override
  String get pickCalendar => 'Cén féilire?';

  @override
  String get calendarPermissionDenied =>
      'Tá rochtain ar an bhféilire blocáilte, mar sin tá an scáthánú múchta. Ceadaigh í i socruithe an chórais agus cas an scáthánú air arís.';

  @override
  String get calendarNotChosen =>
      'Níor roghnaíodh féilire, mar sin tá an scáthánú múchta. Cas air arís é agus roghnaigh ceann.';

  @override
  String get calendarGone =>
      'Níl an féilire roghnaithe ann a thuilleadh, mar sin tá an scáthánú múchta. Cas air arís é agus roghnaigh ceann eile.';

  @override
  String get noWritableCalendar =>
      'Níor aimsíodh aon fhéilire. Logáil isteach i gcuntas féilire i socruithe an chórais, Google mar shampla, agus bain triail eile as.';

  @override
  String get spotHomeAgenda =>
      'Meabhrúcháin: liosta na gcoinní beartaithe — tréidlia, cógais, seiceálacha.';

  @override
  String get spotAgendaAdd => 'Beartaigh coinne nua.';

  @override
  String get spotAgendaCalendar =>
      'Cas air anseo scáthánú choinní cat(a)log isteach i bhféilire de do rogha.';

  @override
  String get spotAgendaToday =>
      'Cúraimí an lae inniu: cuir tic nuair atá sé déanta. Taispeánann na poncanna na seacht lá deireanacha.';

  @override
  String get helpAgenda =>
      'Liostálann na meabhrúcháin na coinní beartaithe de réir dáta. Tá dhá chineál ann: coinní le ham an lae, agus meabhrúcháin a bhaineann le lá. Fanann na cinn a cailleadh ar barr. Osclaíonn tapáil an cat nó an clowdar. Deimhníonn an tic coinne: scríobhtar an luach isteach sa réimse, agus is féidir leat an chéad cheann eile a bheartú láithreach, i gceann trí mhí mar shampla. Athraíonn brú fada an dáta nó scriosann sé an choinne. Scáthánaíonn an lasc ar barr na coinní isteach i bhféilire do ghutháin. Easpórtálann an roghchlár iad mar chomhad féilire. Is coinne amháin í cuairt tréidlia le roinnt cat: ticeáil na cait, taispeánann an Clár Oibre cárta amháin lena n-ainmneacha, agus ag an deireadh fiafraítear cé na cait ar cuireadh cóir orthu — bain an tic de na cinn eile, fanann siad pleanáilte. Is iad na cúraimí na tascanna athfhillteacha, mar bheathú, bosca bruscair nó leigheas. Seasann siad faoi Inniu le tic, sraith agus na seacht lá deireanacha mar phoncanna; taispeánann Ag teacht an tseachtain seo chugainn gan na cinn laethúla. Is féidir le cúram meabhrú duit le fógra ag am roghnaithe. Osclaíonn an trófaí na héachtaí.';

  @override
  String get helpAgendaNeutral =>
      'Liostálann na meabhrúcháin na coinní beartaithe de réir dáta. Tá dhá chineál ann: coinní le ham an lae, agus meabhrúcháin a bhaineann le lá. Fanann na cinn a cailleadh ar barr. Osclaíonn tapáil an peata nó an líon tí. Deimhníonn an tic coinne: scríobhtar an luach isteach sa réimse, agus is féidir leat an chéad cheann eile a bheartú láithreach, i gceann trí mhí mar shampla. Athraíonn brú fada an dáta nó scriosann sé an choinne. Scáthánaíonn an lasc ar barr na coinní isteach i bhféilire do ghutháin. Easpórtálann an roghchlár iad mar chomhad féilire. Is coinne amháin í cuairt tréidlia le roinnt peataí: ticeáil na peataí, taispeánann an Clár Oibre cárta amháin lena n-ainmneacha, agus ag an deireadh fiafraítear cé na peataí ar cuireadh cóir orthu — bain an tic de na cinn eile, fanann siad pleanáilte. Is iad na cúraimí na tascanna athfhillteacha, mar bheathú, bosca bruscair nó leigheas. Seasann siad faoi Inniu le tic, sraith agus na seacht lá deireanacha mar phoncanna; taispeánann Ag teacht an tseachtain seo chugainn gan na cinn laethúla. Is féidir le cúram meabhrú duit le fógra ag am roghnaithe. Osclaíonn an trófaí na héachtaí.';

  @override
  String get calendarRowOff => 'Féilire: as';

  @override
  String calendarRowOn(String name) {
    return 'Féilire: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Beartaigh coinne don chat seo. Feictear í sna meabhrúcháin agus deimhnítear ansin í.';

  @override
  String get spotAddReminderCatNeutral =>
      'Beartaigh coinne don pheata seo. Feictear í sna meabhrúcháin agus deimhnítear ansin í.';

  @override
  String get spotAddReminderClowder =>
      'Beartaigh coinne don chlowdar seo. Feictear í sna meabhrúcháin agus deimhnítear ansin í.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Beartaigh coinne don líon tí seo. Feictear í sna meabhrúcháin agus deimhnítear ansin í.';

  @override
  String get readOnlyCalendar => 'inléite amháin';

  @override
  String get appointmentLabel => 'Coinne';

  @override
  String get addAppointment => 'Cuir coinne leis';

  @override
  String get planChooserTitle => 'Coinne nó meabhrúchán?';

  @override
  String get planChooserAppointment =>
      'Coinne — cuairt ar dháta agus ag am, le nótaí';

  @override
  String get planChooserReminder =>
      'Meabhrúchán — luach a bhíonn dlite lá éigin';

  @override
  String get planChooserChore =>
      'Cúram — rud a thagann ar ais: beathú, braonta, bruscar';

  @override
  String get newChore => 'Cúram nua';

  @override
  String get choreEdit => 'Cuir cúram in eagar';

  @override
  String get choreTitleLabel => 'Cad';

  @override
  String get choreRepeatDaily => 'Gach lá';

  @override
  String get choreRepeatEvery => 'Gach…';

  @override
  String get choreRepeatWeekdays => 'Laethanta';

  @override
  String choreEveryDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'gach $n lá',
      many: 'gach $n lá',
      few: 'gach $n lá',
      two: 'gach $n lá',
      one: 'gach lá',
    );
    return '$_temp0';
  }

  @override
  String choreEveryWeeks(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'gach $n seachtain',
      many: 'gach $n seachtain',
      few: 'gach $n seachtaine',
      two: 'gach $n sheachtain',
      one: 'gach seachtain',
    );
    return '$_temp0';
  }

  @override
  String choreEveryMonths(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'gach $n mí',
      many: 'gach $n mí',
      few: 'gach $n mhí',
      two: 'gach $n mhí',
      one: 'gach mí',
    );
    return '$_temp0';
  }

  @override
  String choreEveryYears(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'gach $n bliain',
      many: 'gach $n mbliana',
      few: 'gach $n bliana',
      two: 'gach $n bhliain',
      one: 'gach bliain',
    );
    return '$_temp0';
  }

  @override
  String get choreNoTime => 'Am ar bith den lá';

  @override
  String get chorePause => 'Cuir ar sos';

  @override
  String get chorePaused => 'Ar sos';

  @override
  String get choreResume => 'Atosaigh';

  @override
  String get choreEnd => 'Cuir deireadh leis an gcúram';

  @override
  String get choreHistory => 'Stair';

  @override
  String choreDoneAt(Object when, Object who) {
    return 'déanta $when · $who';
  }

  @override
  String get choreDoneEarly => 'luath';

  @override
  String get choreDoneLate => 'déanach';

  @override
  String get choreMissed => 'Caillte';

  @override
  String get choreStillOpen => 'Fós oscailte';

  @override
  String get choreEndConfirm =>
      'Imíonn an cúram den liosta. Fanann a bhfuil ticeáilte sa stair.';

  @override
  String get todaySection => 'Inniu';

  @override
  String get upcomingSection => 'Ag teacht';

  @override
  String get allDoneToday => 'Inniu: gach rud déanta';

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n lá as a chéile',
      many: '$n lá as a chéile',
      few: '$n lá as a chéile',
      two: '$n lá as a chéile',
      one: '1 lá as a chéile',
    );
    return '$_temp0';
  }

  @override
  String choreDue(String date) {
    return 'Dlite $date';
  }

  @override
  String get remindMe => 'Cuir i gcuimhne dom';

  @override
  String remindNext(Object when) {
    return 'An chéad mheabhrúchán eile: $when';
  }

  @override
  String get remindNone =>
      'Níl meabhrúchán ar bith beartaithe: níl aon rud le teacht.';

  @override
  String remindPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meabhrúchán sceidealta ar an nguthán seo',
      many: '$count meabhrúchán sceidealta ar an nguthán seo',
      few: '$count mheabhrúchán sceidealta ar an nguthán seo',
      two: '$count mheabhrúchán sceidealta ar an nguthán seo',
      one: '$count meabhrúchán sceidealta ar an nguthán seo',
      zero: 'Níl aon rud sceidealta ar an nguthán seo fós',
    );
    return '$_temp0';
  }

  @override
  String get remindTest => 'Seol meabhrúchán tástála anois';

  @override
  String get remindLateHint =>
      'D’fhéadfadh meabhrúcháin teacht cúpla nóiméad déanach; roghnaíonn an guthán an nóiméad féin.';

  @override
  String get remindPermissionDenied =>
      'Níl cead ann d’fhógraí, mar sin fanann an meabhrúchán múchta. Ceadaigh iad i socruithe aip an ghutháin agus bain triail eile as.';

  @override
  String get batteryHint =>
      'Mura dtagann meabhrúcháin, lig do cat(a)log rith sa chúlra i socruithe ceallra an ghutháin.';

  @override
  String get batterySettings => 'Socruithe ceallra';

  @override
  String get achievementsTitle => 'Éachtaí';

  @override
  String get rankServant => 'Seirbhíseach';

  @override
  String get rankButler => 'Buitléir';

  @override
  String get rankSteward => 'Maor';

  @override
  String get rankChancellor => 'Seansailéir';

  @override
  String get rankMinister => 'Aire';

  @override
  String titleWithChore(Object title, Object chore) {
    return '$title ($chore)';
  }

  @override
  String get coatCalico => 'Calico';

  @override
  String get coatCheetah => 'Síota';

  @override
  String get coatTiger => 'Tíogar';

  @override
  String get coatTabby => 'Tabaí';

  @override
  String get coatPaws => 'Lapaí';

  @override
  String get coatRosettes => 'Roiséid';

  @override
  String get coatZebra => 'Séabra';

  @override
  String get coatSetting => 'Fionnadh';

  @override
  String get coatRandom => 'Ceann eile gach uair';

  @override
  String get coatSnowLeopard => 'Liopard sneachta';

  @override
  String get coatSiamese => 'Comharthaí Siamacha';

  @override
  String get coatLynx => 'Lincse';

  @override
  String get coatTortoiseshell => 'Toirtís';

  @override
  String coatUnlocked(Object coat) {
    return 'Fionnadh nua: $coat';
  }

  @override
  String get coatUnlockedHow => 'Mí iomlán de chúraimí, iad ar fad déanta.';

  @override
  String get achievementsEmpty =>
      'Faic go fóill. Tá an bealach ar eolas ag na cúraimí.';

  @override
  String get achievementMonth => 'Mí iomlán';

  @override
  String get achievementYear => 'Bliain iomlán';

  @override
  String get achievementDecade => 'Deich mbliana iomlána';

  @override
  String get achievementCentury => 'Céad bliain iomlán';

  @override
  String get achievementCenturyHint => 'Beidh an-bhród orainn beirt.';

  @override
  String achievementMaster(String title) {
    return 'Máistir $title';
  }

  @override
  String achievementReached(int times, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'Bainte amach $times uair',
      many: 'Bainte amach $times n-uaire',
      few: 'Bainte amach $times huaire',
      two: 'Bainte amach $times uair',
      one: 'Bainte amach uair amháin',
    );
    return '$_temp0, den chéad uair $date';
  }

  @override
  String achievementNext(int n) {
    return 'An chéad cheann eile ag $n';
  }

  @override
  String get achievementLocked => 'Níl fós';

  @override
  String achievementUnlocked(String name) {
    return 'Éacht: $name';
  }

  @override
  String get appointmentTitleLabel => 'Cad';

  @override
  String get notesLabel => 'Nótaí';

  @override
  String get timeLabel => 'Am';

  @override
  String get allDayLabel => 'An lá ar fad';

  @override
  String get alertLabel => 'Foláireamh';

  @override
  String get alertNone => 'Ceann ar bith';

  @override
  String get alertDayBefore => 'An lá roimhe';

  @override
  String get alertHourBefore => 'Uair an chloig roimhe';

  @override
  String get linkFieldLabel => 'Nuair a bheidh sé déanta, scríobh i réimse';

  @override
  String get noLinkedField => 'Gan réimse';

  @override
  String get outcomeTitle => 'Conas a d\'éirigh leis?';

  @override
  String get finishLabel => 'Críochnaigh';

  @override
  String get editLabelAppointment => 'Cuir an choinne in eagar';

  @override
  String get deleteAppointment => 'Scrios an choinne';

  @override
  String get stepFlierText => 'Téacs na bileoige';

  @override
  String get qrFoundHint =>
      'Aimsíodh cód QR ar an mbileog. Léitear cóid thiceáilte le haghaidh uimhreacha cláir agus nasc.';

  @override
  String get useCode => 'Úsáid an cód seo';

  @override
  String get qrNone => 'Níor aimsíodh cód QR sa ghrianghraf.';

  @override
  String qrFailed(String error) {
    return 'Theip ar léamh an chóid QR: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Bileog $name aitheanta. Seiceáil thíos cén réimse a dtéann gach líne isteach ann.';
  }

  @override
  String get flierLayoutUnknown =>
      'Leagan amach anaithnid. Sann na línte do réimsí thíos; fanann an chuid eile sna nótaí.';

  @override
  String get targetRegistryNumber => 'Uimhir chláir';

  @override
  String get targetLostPlace => 'Seoladh (áit ar cailleadh é)';

  @override
  String get targetContact => 'Teagmháil an chláir';

  @override
  String get targetDrop => 'Fág ar lár';

  @override
  String get existingCat => 'Cat atá ann';

  @override
  String get existingCatNeutral => 'Peata atá ann';

  @override
  String get existingClowder => 'Grúpa atá ann';

  @override
  String get existingClowderNeutral => 'Líon tí atá ann';

  @override
  String get createNewInstead => 'Ceann ar bith — cruthaigh nua';

  @override
  String overwritesValue(String value) {
    return 'Forscríobhann sé an luach reatha \"$value\"';
  }

  @override
  String get abortScanTitle => 'Éirigh as an scanadh?';

  @override
  String get abortScanBody => 'Ní shábhálfar rud ar bith.';

  @override
  String get abortScan => 'Éirigh as';

  @override
  String get keepScanning => 'Lean ar aghaidh';

  @override
  String get catsOnAppointment => 'Cait ar an gcoinne seo';

  @override
  String get catsOnAppointmentNeutral => 'Peataí ar an gcoinne seo';

  @override
  String get noCatsHint =>
      'Níl aon chat ticeáilte — is leis an gcoilíneacht féin an choinne.';

  @override
  String get noCatsHintNeutral =>
      'Níl aon pheata ticeáilte — is leis an líon tí féin an choinne.';

  @override
  String get pickCatsTitle => 'Cé na cait a thagann?';

  @override
  String get pickCatsTitleNeutral => 'Cé na peataí a thagann?';

  @override
  String catsCount(int count) {
    return '$count chat';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count peata';
  }

  @override
  String get finishUntickHint =>
      'Bain an tic de na cait nár cuireadh cóir leighis orthu; fanann siad pleanáilte.';

  @override
  String get finishUntickHintNeutral =>
      'Bain an tic de na peataí nár cuireadh cóir leighis orthu; fanann siad pleanáilte.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Scrios an choinne do na $count chat ar fad';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Scrios an choinne do na $count peata ar fad';
  }

  @override
  String get correctThisValue => 'Ceartaigh an luach seo';

  @override
  String get removeThisValue => 'Bain an luach seo';

  @override
  String get restoreThisValue => 'Athchóirigh an luach seo';

  @override
  String get showRemovedValues => 'Taispeáin luachanna a baineadh';

  @override
  String get hideRemovedValues => 'Folaigh luachanna a baineadh';

  @override
  String entryRemovedBy(Object who, Object when) {
    return 'Bainte · $who · $when';
  }

  @override
  String entryReplacedBy(Object value, Object who, Object when) {
    return 'Curtha in ionad $value · $who · $when';
  }

  @override
  String get entryCorrection => 'Ceartúchán';

  @override
  String get restorePickFolder => 'Roghnaigh fillteán na gcúltacaí…';

  @override
  String get restoreAndroidHint =>
      'Tá cúltacaí na suiteála roimhe seo in Documents/catlog (Downloads/catlog i leaganacha níos sine). Roghnaigh an fillteán sin uair amháin; liostáiltear a chúltacaí anseo.';

  @override
  String get backupsTitle => 'Cúltacaí';

  @override
  String get backupsSubtitle => 'An áit a gcoinnítear do chatalóga slán';

  @override
  String get backupsAndroidSystem =>
      'Déanann Google cúltaca de chatalóga an aip seo le do chuntas, gan grianghraif. Tagann siad ar ais uathu féin tar éis athshuiteála nó ar ghuthán nua.';

  @override
  String get backupsAndroidFiles =>
      'Scríobhtar cóip iomlán de gach catalóg, grianghraif san áireamh, chuig Documents/catlog gach uair a fhágann tú an aip tar éis athruithe.';

  @override
  String get backupsIosSystem =>
      'Cuimsíonn Cúltaca iCloud an aip seo lena catalóga agus grianghraif, mar gach aip eile ar an iPhone seo.';

  @override
  String get backupsIosFiles =>
      'Tá cóip iomlán de gach catalóg san aip Comhaid faoi cat(a)log. Uaidh sin is féidir í a chur chuig iCloud Drive, trí AirDrop nó chuig guthán eile.';

  @override
  String get backupsDesktopFiles =>
      'Scríobhtar cóip iomlán de gach catalóg, grianghraif san áireamh, chuig d\'fhillteán Íoslódálacha gach uair a fhágann tú an aip tar éis athruithe.';

  @override
  String backupsLast(Object date) {
    return 'An chóip dheireanach: $date';
  }

  @override
  String get backupsNever => 'Níor scríobhadh cóip fós.';

  @override
  String get backupsNow => 'Déan cúltaca anois';

  @override
  String get backupsDone => 'Cóip scríofa.';

  @override
  String backupsRestoredNote(Object date) {
    return 'Athchóirithe ó chúltaca Google ar $date. Má tá cat(a)log fós ar an seanghuthán, sioncronaigh uair amháin uaidh, ansin bain an aip ansin.';
  }

  @override
  String get backupsFolderHint =>
      'Is féidir le fillteán de do rogha gach cóip a fháil freisin: ceann a choinníonn aip néil sioncronaithe ar an nguthán seo (Nextcloud, Syncthing agus eile), cárta cuimhne, aon fhillteán a thairgeann an roghnóir. Téann na cóipeanna isteach i catlog-backups laistigh de.';

  @override
  String get backupsFolderPick => 'Cóipeáil chuig fillteán freisin…';

  @override
  String backupsFolderIs(Object name) {
    return 'Cóipeáilte chuig $name freisin';
  }

  @override
  String get backupsFolderRemove => 'Stop ag cóipeáil ansin';

  @override
  String remindFailed(Object error) {
    return 'Níl na fógraí ag obair ar an nguthán seo: $error';
  }

  @override
  String get copyText => 'Cóipeáil téacs';

  @override
  String get colWhen => 'Cathain';

  @override
  String get colValue => 'Luach';

  @override
  String get colWho => 'Cé';

  @override
  String get pdfFontMissing =>
      'Níl an cló don teanga seo ar an nguthán fós; priontáiltear roinnt litreacha mar bhoscaí. Ceangail leis an idirlíon uair amháin agus déan an PDF arís.';

  @override
  String get vetReportTitle => 'Tuairisc don tréidlia';

  @override
  String get vetReportMenu => 'Tuairisc don tréidlia…';

  @override
  String get vetReportFields => 'Réimsí';

  @override
  String get vetReportFrom => 'Ó';

  @override
  String get vetReportTo => 'Go';

  @override
  String get vetReportSummary => 'Achoimre othair';

  @override
  String get vetReportOwner => 'Úinéir';

  @override
  String get vetReportLegend => 'Eochair';

  @override
  String get vetReportCurves => 'Cuar';

  @override
  String get posterMenu => 'Póstaer ar iarraidh…';

  @override
  String get posterHeadline => 'AR IARRAIDH';

  @override
  String get posterStanding =>
      'Seiceáil siléir, seideanna agus garáistí le do thoil. Ná téigh sa tóir, glaoigh.';

  @override
  String get posterLastSeen => 'Feicthe go deireanach in aice le';

  @override
  String get posterFreeText => 'Líne bhreise';

  @override
  String get posterQr => 'Cód QR do cat(a)log';

  @override
  String get posterPhoto => 'Grianghraf';

  @override
  String get newCatIn => 'Cat nua i…';

  @override
  String get newCatInNeutral => 'Peata nua i…';

  @override
  String get choreLabel => 'Cúram';

  @override
  String get choreTickLabel => 'Cúram déanta';

  @override
  String get choreEnded => 'Críochnaithe';

  @override
  String choreRemindAt(Object time) {
    return 'meabhrúchán $time';
  }

  @override
  String doneOn(Object date) {
    return 'déanta ar $date';
  }

  @override
  String get withheldByPartner => 'coinnithe siar ag páirtí';

  @override
  String get titleLabel => 'Teideal';

  @override
  String get deletedLabel => 'Scriosta';

  @override
  String get favouriteAdd => 'Marcáil mar cheanán';

  @override
  String get favouriteRemove => 'Bain ó cheanáin';

  @override
  String get coverPick => 'Pictiúr clúdaigh…';

  @override
  String get coverHint =>
      'Pictiúr den áit: an teach, an clós, an láthair bheathaithe. Ar an gcárta in ionad cait.';

  @override
  String get coverRemove => 'Bain an pictiúr clúdaigh';

  @override
  String get skipTour =>
      'Léim thar an réamhrá agus na leideanna ar an suiteáil seo';
}
