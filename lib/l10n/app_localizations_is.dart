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
      'Engir hópar ennþá.\nBúðu til þann fyrsta hér fyrir neðan.';

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
      'Kötturinn hverfur af öllum listum. Myndum hans er eytt varanlega.';

  @override
  String get sightingRecorded =>
      'Skráð að kötturinn sást á staðsetningu þinni.';

  @override
  String get noLocationAvailable =>
      'Engin staðsetning — haltu þess í stað fingri á kortinu.';

  @override
  String get locationDeniedForever =>
      'Aðgangur að staðsetningu er læstur. Leyfðu hann í kerfisstillingum til að nota Stray Cam.';

  @override
  String get locationServiceOff =>
      'Slökkt er á staðsetningu á þessu tæki. Kveiktu á henni í stillingum og reyndu aftur.';

  @override
  String get locationDenied =>
      'cat(a)log hefur ekki heimild til að nota staðsetningu þína. Reyndu aftur og leyfðu það þegar spurt er.';

  @override
  String get locationNoFix =>
      'Ekki tókst að ákvarða staðsetningu þína núna. Reyndu aftur utandyra — GPS þarf óhindrað útsýni til himins.';

  @override
  String get ok => 'Í lagi';

  @override
  String get openSettings => 'Opna stillingar';

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
  String dateFormatError(String format) {
    return 'Rangt snið — notaðu $format';
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
  String get ownValue => 'Eigið gildi';

  @override
  String get renameField => 'Endurnefna svæði';

  @override
  String get editOptions => 'Breyta valkostum…';

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
  String get starterBreed => 'Tegund';

  @override
  String get valueMixed => 'blendingur';

  @override
  String get breedEuropeanShorthair => 'Evrópskt stutthár';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Breskt stutthár';

  @override
  String get breedNorwegianForestCat => 'Norskur skógarköttur';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Síamsköttur';

  @override
  String get breedPersian => 'Persaköttur';

  @override
  String get breedBengal => 'Bengalköttur';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get applyCrop => 'Skera';

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
  String lastBackupFailed(String error) {
    return 'Síðasta sjálfvirka öryggisafritið mistókst: $error';
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
