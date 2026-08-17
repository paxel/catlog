// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Velkomin í cat(a)log';

  @override
  String get welcomeBody =>
      'Veldu þér nafn. Sérhver breyting er skráð undir þessu nafni svo aðrir sjái hver gerði hvað.';

  @override
  String get yourName => 'Nafnið þitt';

  @override
  String get start => 'Byrja';

  @override
  String get clowders => 'Clowder-hópar';

  @override
  String get noClowdersYet =>
      'Engir clowderar enn. Clowder er staður þar sem kettir búa — fósturheimilið þitt, íbúð ættleiðanda. Búðu til þann fyrsta hér fyrir neðan.';

  @override
  String get strays => 'Flækingskettir';

  @override
  String get searchCats => 'Leita að köttum';

  @override
  String get map => 'Kort';

  @override
  String get sync => 'Samstilling';

  @override
  String get fields => 'Svæði';

  @override
  String get exportCsv => 'Flytja út CSV';

  @override
  String get aboutAndFeedback => 'Um & ábendingar';

  @override
  String get newClowder => 'Nýr hópur';

  @override
  String get name => 'Nafn';

  @override
  String get cancel => 'Hætta við';

  @override
  String get create => 'Búa til';

  @override
  String get save => 'Vista';

  @override
  String get delete => 'Eyða';

  @override
  String get merge => 'Sameina';

  @override
  String get resolve => 'Úrskurða';

  @override
  String get open => 'Opna';

  @override
  String csvSavedTo(String path) {
    return 'CSV vistað í $path';
  }

  @override
  String get renameClowder => 'Endurnefna hóp';

  @override
  String get rename => 'Endurnefna';

  @override
  String get timeline => 'Tímalína';

  @override
  String get mergeInto => 'Sameina við…';

  @override
  String get deleteClowder => 'Eyða hópi';

  @override
  String get cats => 'Kettir';

  @override
  String get addCat => 'Bæta við ketti';

  @override
  String get newCat => 'Nýr köttur';

  @override
  String deleteQuestion(String name) {
    return 'Eyða $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Hópurinn hverfur af listanum.';

  @override
  String deleteClowderBody(int count) {
    return 'Kettir hans ($count) eyðast ekki — þeir verða flækingar. Færðu þá fyrst í annan hóp ef það er ekki ætlunin.';
  }

  @override
  String get card => 'Spjald';

  @override
  String get shareAsImage => 'Deila sem mynd';

  @override
  String get shareAsPdf => 'Deila sem PDF';

  @override
  String get print => 'Prenta';

  @override
  String cardTitle(String name) {
    return 'Spjald — $name';
  }

  @override
  String get renameCat => 'Endurnefna kött';

  @override
  String get seenHereNow => 'Sást hér núna';

  @override
  String get deleteCat => 'Eyða ketti';

  @override
  String get clowderLabel => 'Hópur';

  @override
  String get strayNoClowder => 'Flækingur — enginn hópur';

  @override
  String get stray => 'Flækingur';

  @override
  String get photos => 'Myndir';

  @override
  String get addPhoto => 'Bæta við mynd';

  @override
  String get setAsProfileImage => 'Gera að aðalmynd';

  @override
  String get thisIsProfileImage => 'Þetta er aðalmyndin';

  @override
  String get deletePhoto => 'Eyða mynd';

  @override
  String get deletePhotoTitle => 'Eyða myndinni?';

  @override
  String get deletePhotoBody =>
      'Myndgögnunum er eytt varanlega — það er ekki hægt að afturkalla.';

  @override
  String get deleteCatBody =>
      'Kötturinn hverfur af öllum listum og myndir hans fjarlægðar — hér og, eftir næstu samstillingu, líka hjá hjálparfólkinu þínu.';

  @override
  String get sightingRecorded =>
      'Skráð að kötturinn sást á staðsetningu þinni.';

  @override
  String get noLocationAvailable =>
      'Engin staðsetning — haltu þess í stað fingri á kortinu.';

  @override
  String get moveTo => 'Færa í';

  @override
  String get noClowderStrayOption => 'Enginn hópur — flækingur / strauk';

  @override
  String timelineOf(String name) {
    return 'Tímalína — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Afturkalla þessa breytingu';

  @override
  String get revertSubtitle =>
      'Endurheimtir fyrra gildi sem nýja færslu — sagan geymir bæði.';

  @override
  String fieldCleared(String field) {
    return '$field tæmt';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field aftur í \"$value\"';
  }

  @override
  String get leftStray => 'Fór — flækingur';

  @override
  String movedTo(String name) {
    return 'Fluttur í $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat kom';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat kom frá $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat fór í $place';
  }

  @override
  String get duplicateMergedIn => 'Tvítak sameinað';

  @override
  String get asOfToday => 'Miðað við í dag';

  @override
  String asOfDate(String date) {
    return 'Miðað við $date';
  }

  @override
  String get value => 'Gildi';

  @override
  String get latitudeLongitude => 'breiddargráða, lengdargráða';

  @override
  String get newField => 'Nýtt svæði';

  @override
  String get fieldType => 'Tegund';

  @override
  String get usedOn => 'Notað fyrir';

  @override
  String get forCats => 'ketti';

  @override
  String get forClowders => 'hópa';

  @override
  String get forBoth => 'bæði';

  @override
  String get optionsOnePerLine => 'Valkostir (einn í línu)';

  @override
  String get renameField => 'Endurnefna svæði';

  @override
  String get noStraysRightNow => 'Engir flækingskettir núna.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Bæta við flækingi';

  @override
  String get newStray => 'Nýr flækingur';

  @override
  String get searchByNameHint => 'Leita að köttum eftir nafni…';

  @override
  String get host => 'Hýsa';

  @override
  String get hostExplainer =>
      'Byrjaðu hér og sláðu svo inn netfang og PIN á hinu tækinu.';

  @override
  String get startHosting => 'Hefja hýsingu';

  @override
  String get stopHosting => 'Stöðva hýsingu';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Lotur hingað til: $count';
  }

  @override
  String get join => 'Tengjast';

  @override
  String get addressFromHost => 'Vistfang (frá hýsingartækinu)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Samstilla núna';

  @override
  String get addressFormatHint =>
      'Vistfangið á að líta út eins og 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Samstillt: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Samstilling mistókst: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Síðasta samstilling við $peer: $time';
  }

  @override
  String get sharedFolder => 'Sameiginleg mappa';

  @override
  String get sharedFolderExplainer =>
      'Samstilltu í gegnum möppu sem skýjaþjónusta eða USB-lykill ber milli tækja — fyrir þau sem eru ekki á sama neti.';

  @override
  String get noFolderChosenYet => 'Engin mappa valin ennþá';

  @override
  String get choose => 'Velja…';

  @override
  String get syncFolderNow => 'Samstilla möppu núna';

  @override
  String folderSynced(String result) {
    return 'Mappa samstillt: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Samstilling möppu mistókst: $error';
  }

  @override
  String get recordSightingHere => 'Skrá að köttur sást hér:';

  @override
  String get orPlaceClowderHere => 'Eða setja hóp hér:';

  @override
  String trailOf(String name, int count) {
    return 'Slóð: $name ($count skráningar)';
  }

  @override
  String conflictOn(String field) {
    return 'Árekstur — $field';
  }

  @override
  String get conflictBody =>
      'Breytt á tveimur stöðum í einu. Veldu hvað er rétt:';

  @override
  String mergeThisInto(String kind) {
    return 'Sameina þennan/þetta $kind við…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Ekkert annað ($kind) til að sameina við.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Sameina við $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Færslurnar tvær verða ein. $name heldur núverandi gildum; saga hinnar bætist við. Ekki hægt að afturkalla.';
  }

  @override
  String get kindCat => 'köttur';

  @override
  String get kindClowder => 'hópur';

  @override
  String get kindField => 'svæði';

  @override
  String get takePhoto => 'Taka mynd';

  @override
  String get chooseFromGallery => 'Velja úr myndasafni';

  @override
  String get about => 'Um';

  @override
  String get aboutTagline =>
      'Staðbundin skrá yfir fósturketti. Gögnin þín verða áfram á tækjunum þínum — enginn þjónn, enginn aðgangur.';

  @override
  String versionLabel(String version, String build) {
    return 'Útgáfa $version ($build)';
  }

  @override
  String get sourceCode => 'Frumkóði';

  @override
  String get reportProblemOrIdea => 'Tilkynna vandamál eða hugmynd';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Skrifa til forritarans';

  @override
  String get buyCoffee => 'Bjóða forritaranum upp á kaffi';

  @override
  String get coffeeSubtitle => 'Algjörlega valfrjálst — appið er ókeypis';

  @override
  String get openSourceLicenses => 'Opinn hugbúnaður — leyfi';

  @override
  String get machineTranslated =>
      'Þýðingar eru vélrænar — leiðréttingar eru vel þegnar á GitHub.';

  @override
  String get unnamed => '(nafnlaus)';

  @override
  String get labelName => 'Nafn';

  @override
  String get labelProfileImage => 'Aðalmynd';

  @override
  String get labelPhoto => 'Mynd';

  @override
  String get starterGender => 'Kyn';

  @override
  String get starterColor => 'Litur';

  @override
  String get starterNeutered => 'Geldur';

  @override
  String get starterPregnant => 'Kettlingafull';

  @override
  String get starterBirthdate => 'Fæðingardagur';

  @override
  String get starterDeceased => 'Dáinn';

  @override
  String get starterAddress => 'Heimilisfang';

  @override
  String get starterResponsible => 'Ábyrgðaraðili';

  @override
  String get starterPosition => 'Staðsetning';

  @override
  String get valueYes => 'já';

  @override
  String get valueNo => 'nei';

  @override
  String get valueFemale => 'læða';

  @override
  String get valueMale => 'fress';

  @override
  String get valueUnknown => 'óþekkt';

  @override
  String get cropTitle => 'Skera mynd';

  @override
  String get markTitle => 'Merkja köttinn';

  @override
  String get useFullPhoto => 'Nota alla myndina';

  @override
  String get dragToSelect => 'Dragðu rétthyrning utan um köttinn';

  @override
  String get dragOverTheCat => 'Dragðu sporöskju yfir köttinn';

  @override
  String get cropPhoto => 'Skera…';

  @override
  String get markPhoto => 'Merkja…';

  @override
  String get scanCode => 'Skanna kóða';

  @override
  String get orTypeCode => 'Eða sláðu inn kóðann';

  @override
  String get copyCode => 'Afrita kóða';

  @override
  String get copied => 'Afritað';

  @override
  String get invalidCode => 'Þessi kóði er ógildur';

  @override
  String get hotspotHint =>
      'Ekkert sameiginlegt Wi-Fi? Kveiktu á heitum reit á öðrum símanum, tengdu hinn og hýstu hér.';

  @override
  String get byMessenger => 'Með skilaboðaforriti';

  @override
  String get byMessengerExplainer =>
      'Sendu alla skrána sem eina skrá með WhatsApp, Signal eða pósti — hin hliðin flytur hana inn.';

  @override
  String get shareBundle => 'Deila samstillingarpakka…';

  @override
  String get importBundle => 'Flytja inn samstillingarpakka…';

  @override
  String bundleImported(String result) {
    return 'Pakki fluttur inn: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Innflutningur mistókst: $error';
  }

  @override
  String get pickOnMap => 'Velja á korti';

  @override
  String get useMyLocation => 'Nota staðsetningu mína';

  @override
  String get language => 'Tungumál';

  @override
  String get systemDefault => 'Sjálfgefið kerfis';

  @override
  String get iosLocalNetworkHint =>
      'Ef það mistekst áfram á iPhone/iPad: Stillingar → Persónuvernd og öryggi → Staðarnet → leyfa cat(a)log og reyna aftur.';

  @override
  String get markPrivate => 'Merkja sem einka';

  @override
  String get unmarkPrivate => 'Fjarlægja einkamerki';

  @override
  String get includePrivate => 'Taka einkagögn með';

  @override
  String get includePrivateExplainer =>
      'Einkakettir, hópar og reitir deilast líka — kveiktu aðeins á þessu þegar þú samstillir eigin tæki.';

  @override
  String get hideLabel => 'Fela á þessu tæki';

  @override
  String get unhideLabel => 'Sýna aftur';

  @override
  String get showHiddenLabel => 'Sýna falið';

  @override
  String get stopShowingHidden => 'Hætta að sýna falið';

  @override
  String get starterSpecies => 'Tegund';

  @override
  String get starterStatus => 'Staða';

  @override
  String get statusFoster => 'Fósturheimili';

  @override
  String get statusForeverHome => 'Framtíðarheimili';

  @override
  String get statusClinic => 'Dýralæknastofa';

  @override
  String get statusShelter => 'Athvarf';

  @override
  String get statusBarn => 'Hlaða';

  @override
  String get valueCat => 'Köttur';

  @override
  String get otherOption => 'Annað…';

  @override
  String get celebrationsToggle => 'Fagna ættleiðingum';

  @override
  String get celebrationsSubtitle =>
      'Skrautborðar og fagnaðarlæti þegar köttur flytur á framtíðarheimili';

  @override
  String get onMapLabel => 'Á kortinu';

  @override
  String get showOnMap => 'Sýna á korti';

  @override
  String get searchPlaceHint => 'Leita að stað eða heimilisfangi';

  @override
  String get noPlacesFound => 'Engir staðir fundust';

  @override
  String get mapSearchHint => 'Leita að köttum, hópum, fólki';

  @override
  String get proposeAnotherName => 'Stinga upp á öðru nafni';

  @override
  String get moderationTitle => 'Höfundar & bönn';

  @override
  String get moderationSubtitle => 'Fjarlægja gögn einstaklings varanlega';

  @override
  String get authorsSection => 'Hver skrifaði í skrána';

  @override
  String get hardDeleteAction => 'Eyða öllu frá þessum höfundi';

  @override
  String hardDeleteWarning(Object name) {
    return 'Fjarlægir allar færslur og myndir frá $name af þessu tæki. Önnur tæki halda sínum. Ekki hægt að afturkalla.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Sláðu inn $name til að staðfesta';
  }

  @override
  String get alsoBan => 'Banna líka — aldrei taka við gögnum aftur';

  @override
  String get bansSection => 'Bönn';

  @override
  String get unbanAction => 'Fjarlægja bann';

  @override
  String get deletedDone => 'Eytt.';

  @override
  String get syncSummaryTitle => 'Hvað barst';

  @override
  String get summaryAdopted => 'Ættleidd';

  @override
  String get summaryDeceased => 'Látin';

  @override
  String get summaryEscaped => 'Strokin';

  @override
  String get summaryNew => 'Ný';

  @override
  String get summaryConflicts => 'Árekstrar til að leysa';

  @override
  String summaryOther(Object n) {
    return '…og $n aðrar breytingar';
  }

  @override
  String get starterMother => 'Móðir';

  @override
  String get starterFather => 'Faðir';

  @override
  String get familySection => 'Fjölskylda';

  @override
  String get littermatesLabel => 'Úr sama goti';

  @override
  String get siblingsLabel => 'Systkini';

  @override
  String get kittensLabel => 'Kettlingar';

  @override
  String get toastSettingsTitle => 'Hverju á að tilkynna';

  @override
  String get toastSettingsSubtitle => 'Litlar tilkynningar eftir samstillingu';

  @override
  String get toastKindAdoptions => 'Ættleiðingar';

  @override
  String get toastKindBirths => 'Fæðingar';

  @override
  String get toastKindDeaths => 'Andlát';

  @override
  String get toastKindEscapes => 'Strok';

  @override
  String get toastKindMoves => 'Flutningar';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat ættleidd af $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nýr kettlingur: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat er látin';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat strauk';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat flutti til $home';
  }

  @override
  String get notACatlogFile => 'Þetta er ekki cat(a)log-skrá';

  @override
  String get nothingNewInBundle =>
      'Ekkert nýtt í skránni — þú átt allt nú þegar';

  @override
  String get syncChooserInPerson => 'Í eigin persónu';

  @override
  String get syncChooserInPersonSub =>
      'Þið eruð í sama herbergi — skannaðu kóða, tilbúið á sekúndum';

  @override
  String get syncChooserRemote => 'Fjarlægt';

  @override
  String get syncChooserRemoteSub =>
      'Í gegnum sameiginlega möppu eins og Dropbox eða USB-lykil';

  @override
  String get syncChooserMessenger => 'Skilaboðaforrit';

  @override
  String get syncChooserMessengerSub =>
      'Sendu allt sem eina skrá með hvaða skilaboðaforriti sem er';

  @override
  String get connectToWifiFirst =>
      'Tengstu fyrst Wi-Fi — þá finna tækin hvort annað';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vill samstilla';
  }

  @override
  String get trustBothWaysNote => 'Skrárnar ykkar skiptast í báðar áttir.';

  @override
  String get allowOnce => 'Leyfa';

  @override
  String get allowAlways => 'Alltaf leyfa þessu tæki';

  @override
  String get declineAction => 'Hafna';

  @override
  String get syncDeclined => 'Hitt tækið hafnaði samstillingunni';

  @override
  String get trustedDevicesSection => 'Alltaf leyfð tæki';

  @override
  String get removeTrust => 'Fjarlægja';

  @override
  String get hostWithoutWifi => 'Hýsa án Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Kemur á tímabundinni beintengingu við hinn símann (án internets). Aðeins cat(a)log notar hana og hún aftengist sjálf eftir samstillinguna.';

  @override
  String get hotspotAndroidOnly =>
      'Þessi kóði þarf tvo Android síma — á iPhone/iPad notaðu sameiginlegt Wi-Fi';

  @override
  String get selectClowderHint => 'Veldu clowder til vinstri';

  @override
  String get introTitle1 => 'Kettir búa í clowderum';

  @override
  String get introBody1 =>
      'Clowder er staður þar sem kettir búa: fósturheimilið þitt, íbúð ættleiðanda, hlaðan í næsta húsi. Hver köttur fær spjald með mynd, staðreyndum og allri sögunni.';

  @override
  String get introTitle2 => 'Allt verður hjá þér';

  @override
  String get introBody2 =>
      'Enginn reikningur, ekkert ský, engin rakning. Gögnin þín búa á tækinu þínu.';

  @override
  String get introTitle3 => 'Deildu með hjálparfólkinu';

  @override
  String get introBody3 =>
      'Skannaðu kóða og tvö tæki samstillast á sekúndum, notaðu sameiginlega möppu eða sendu allt sem eina skrá.';

  @override
  String get introSkip => 'Sleppa';

  @override
  String get introNext => 'Áfram';

  @override
  String get introDone => 'Byrjum';

  @override
  String get introReplayTitle => 'Snögg kynning';

  @override
  String get spotHomeSync =>
      'Nýtt: samstilling býður nú þrjár skýrar leiðir — og traustsspurningu áður en nokkuð flæðir.';

  @override
  String get spotMapSearch =>
      'Nýtt: leitaðu hér að köttum, hópum og fólki — beint á kortinu.';

  @override
  String get spotCardChips =>
      'Nýtt: veldu hvað birtist á spjaldinu áður en þú deilir því.';

  @override
  String get spotCatMenu =>
      'Nýtt: merktu kött sem einka (fer aldrei af tækinu) eða feldu hann hér.';

  @override
  String get spotDone => 'Skilið';

  @override
  String get spotReplayTitle => 'Nýjungaferð';

  @override
  String get spotReplaySubtitle => 'Sýna ábendingar aftur á hverri síðu';

  @override
  String get spotReplayDone => 'Ábendingarnar birtast aftur';

  @override
  String get searchNoResults => 'Enginn köttur fannst með þessu nafni';

  @override
  String get syncUnreachable =>
      'Náðist ekki í hitt tækið. Eru bæði á sama Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Náðist ekki í möppuna. Er drifið eða skýjamappan enn til?';

  @override
  String get crashTitle => 'Þetta hefði ekki átt að gerast';

  @override
  String get crashBody =>
      'cat(a)log rakst á óvænta villu. Gögnin þín eru örugg — allt vistast um leið og þú breytir því. Endurræstu forritið og ef þetta endurtekur sig, sendu skýrsluna svo hægt sé að laga það.';

  @override
  String get crashRestart => 'Endurræsa forritið';

  @override
  String get crashSendReport => 'Senda skýrslu til þróanda';

  @override
  String get crashLastRunBody =>
      'cat(a)log stöðvaðist óvænt síðast — líklega kláraðist minnið. Senda stutta skýrslu svo hægt sé að laga það?';
}
