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
      'Kötturinn hverfur af öllum listum og myndir hans eru fjarlægðar — hér og, eftir næstu samstillingu, einnig á hinum tækjunum.';

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
  String get starterChipId => 'Örflögunúmer';

  @override
  String get starterRemarks => 'Athugasemdir';

  @override
  String get captureFlier => 'Mynda auglýsingu';

  @override
  String get addPhotosTo => 'Bæta myndum við…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count mynd(ir) bætt við $name';
  }

  @override
  String get scanPrintedCode => 'Skanna prentaðan kóða';

  @override
  String get chipScanHint =>
      'Skannar prentaða QR-/strikamerkið af örflögukortinu eða dýralæknisskjölum — sími getur ekki lesið flöguna í kettinum.';

  @override
  String get savingLabel => 'Vista…';

  @override
  String ownerOfCat(String name) {
    return 'Eigandi $name';
  }

  @override
  String get sortLabel => 'Raða';

  @override
  String get viewAsTable => 'Sýna sem töflu';

  @override
  String get viewAsTiles => 'Sýna sem flísar';

  @override
  String get matchCandidatesTitle => 'Mögulegar samsvaranir';

  @override
  String get findDuplicates => 'Finna tvítök';

  @override
  String get noDuplicates => 'Engin möguleg tvítök núna.';

  @override
  String get similarName => 'Svipað nafn';

  @override
  String get sharePublicly => 'Deila opinberlega…';

  @override
  String get pickFramesTitle => 'Velja ramma';

  @override
  String get suggestedFrames => 'Tillögur að römmum';

  @override
  String get scrubFrames => 'Spóla í myndbandinu';

  @override
  String get keepThisFrame => 'Halda þessum ramma';

  @override
  String get fromVideo => 'Úr myndbandi…';

  @override
  String get videoMobileOnly =>
      'Að velja ramma úr myndbandi virkar í símaforritinu (Android og iPhone) — ekki enn á þessu tæki.';

  @override
  String get shareWhitelistExplainer =>
      'Veldu hvað fer í skrána. Aðeins merktir reitir fylgja með.';

  @override
  String get exportShareFile => 'Flytja út deiliskrá…';

  @override
  String get hostedLink => 'Hýstur hlekkur (URL upphlaðinnar skráar)';

  @override
  String get inlineQr => 'Innfellt QR (aðeins texti, engar myndir)';

  @override
  String get inlineTooBig =>
      'Of mikil gögn fyrir innfelldan kóða — afmerktu reiti eða notaðu hýstan hlekk.';

  @override
  String get scanShareLabel => 'Skanna deilikóða';

  @override
  String get notAShareCode => 'Þessi kóði er ekki cat(a)log-deiling.';

  @override
  String get importShareTitle => 'Flytja inn þennan kött?';

  @override
  String shareSource(String url) {
    return 'Uppruni: $url';
  }

  @override
  String get importLabel => 'Flytja inn';

  @override
  String get strayAreaLabel => 'Mögulegt flakkssvæði';

  @override
  String get prevPin => 'Fyrri pinni';

  @override
  String get nextPin => 'Næsti pinni';

  @override
  String get noMissingCats =>
      'Engir týndir kettir með auglýsingastaðsetningar enn.';

  @override
  String get noMatchCandidates => 'Engar mögulegar samsvaranir núna.';

  @override
  String sameIdField(String field) {
    return 'Sama $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m á milli';
  }

  @override
  String get addFlier => 'Bæta við auglýsingu';

  @override
  String get missingSinceLabel => 'Týndur síðan';

  @override
  String get phoneLabel => 'Sími';

  @override
  String get cropPortrait => 'Skera andlitsmynd';

  @override
  String get statusOwner => 'Eigandi';

  @override
  String get ocrUnavailable =>
      'Textagreining er ekki í boði á þessu tæki — sláðu sjálf(ur) inn texta auglýsingarinnar.';

  @override
  String get displayFormat => 'Birt sem';

  @override
  String get displayPlain => 'Venjulegur texti';

  @override
  String get displayQr => 'QR-kóði';

  @override
  String get displayBarcode => 'Strikamerki';

  @override
  String get editLabel => 'Breyta';

  @override
  String get doneLabel => 'Lokið';

  @override
  String get openSettings => 'Opna stillingar';

  @override
  String get notSaved => 'Ekki vistað';

  @override
  String get birthdateInFuture =>
      'Fæðingardagur getur ekki verið í framtíðinni.';

  @override
  String get deceasedInFuture => 'Dánardagur getur ekki verið í framtíðinni.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Dánardagur getur ekki verið á undan fæðingardegi ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Fæðingardagur getur ekki verið á eftir dánardegi ($date).';
  }

  @override
  String get malePregnant =>
      'Þessi köttur er skráður sem fress — fress getur ekki verið kettlingafullt. Athugaðu fyrst kynið.';

  @override
  String fatherNotMale(String name) {
    return '$name er skráð sem læða og getur ekki verið faðirinn. Athugaðu fyrst kynið.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name er skráður sem fress og getur ekki verið móðirin. Athugaðu fyrst kynið.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name fæddist $date — foreldri getur ekki fæðst á eftir kettlingnum sínum.';
  }

  @override
  String get genderFatherFemale =>
      'Þessi köttur er skráður faðir annarra katta — faðirinn getur ekki verið læða. Athugaðu fyrst fjölskylduna.';

  @override
  String get genderMotherMale =>
      'Þessi köttur er skráður móðir annarra katta — móðirin getur ekki verið fress. Athugaðu fyrst fjölskylduna.';

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
      'Byrjaðu hér og skannaðu svo kóðann eða sláðu hann inn á hinu tækinu.';

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
      'Bæði tækin nota sömu möppu (t.d. í Dropbox eða á USB-lykli). Hver samstilling skilur breytingarnar þínar eftir þar og sækir hinar.';

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
  String get coffeeSubtitle =>
      'Appið verður áfram ókeypis. Jafnvel þótt ég fái engan kaffibolla :)';

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
  String get starterEmail => 'Netfang';

  @override
  String get starterPhone => 'Sími';

  @override
  String get lookupUrlLabel => 'Uppflettitengill';

  @override
  String lookupUrlHelp(String token) {
    return 'Síða þjónustunnar með $token þar sem númerið á að vera, t.d. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Fletta upp';

  @override
  String lookupFailed(String url) {
    return 'Ekkert forrit gat opnað $url. Afritaðu tengilinn í vafra.';
  }

  @override
  String get stepCat => 'Köttur';

  @override
  String get stepOwner => 'Eigandi';

  @override
  String get stepFace => 'Andlitsmynd';

  @override
  String get stepRegistry => 'Skrá';

  @override
  String get stepReview => 'Yfirfara og vista';

  @override
  String get stepOwnerHint =>
      'Sá sem saknar kattarins — úr þessu verður hópurinn hans með tengilið af auglýsingunni.';

  @override
  String get stepFaceHint =>
      'Klipptu andlit kattarins út úr auglýsingunni; það verður prófílmyndin. Þú mátt sleppa þessu.';

  @override
  String get stepRegistryHint =>
      'Númer sem fundust á auglýsingunni. Þau sem eru merkt vistast hjá kettinum og opnast síðar.';

  @override
  String get noRegistryLinks =>
      'Engir skráartenglar á þessari auglýsingu — ef einhverjir fórust fyrir, tilkynntu þá villu.';

  @override
  String get unknownServiceHint => 'Óþekkt þjónusta';

  @override
  String get rememberService => 'Muna þjónustuna';

  @override
  String get rememberServiceHint =>
      'Gefðu þjónustunni nafn og bentu á númerið í tenglinum. Næsta auglýsing fyllist sjálf.';

  @override
  String get noIdInLink =>
      'Þessi tengill inniheldur ekkert númer sem forritið getur vistað.';

  @override
  String get whichNumber => 'Hvaða hluti er númerið?';

  @override
  String get cropAgain => 'Klippa aftur';

  @override
  String get noFaceYet =>
      'Engin andlitsmynd enn — mynd auglýsingarinnar er notuð.';

  @override
  String get backLabel => 'Til baka';

  @override
  String get dangerButton => 'EKKI ÝTA.\nHÆTTA';

  @override
  String get dangerThanks => 'Takk fyrir að nota cat(a)log!';

  @override
  String get helpTitle => 'Hjálp';

  @override
  String get showTipsAgain => 'Sýna ábendingar aftur';

  @override
  String get helpHome =>
      'Yfirlit yfir nýlendurnar þínar — nýlenda er staður þar sem kettir búa: heimilið þitt, fósturheimili, athvarf. Ýttu á spjald til að sjá kettina; haltu inni fyrir valmynd. Hnappurinn neðst til hægri býr til nýlendu og flækingsspjaldið safnar öllum köttum án heimilis. Heitið efst er skráin sem þú ert í — ýttu á það til að skipta eða bæta við.';

  @override
  String get helpClowder =>
      'Allt um þennan stað: kettirnir, reitirnir (heimilisfang, tengiliður, tegund) og sagan. Síðan opnast aðeins til lestrar; blýanturinn kveikir á breytingum, þar má líka bæta við reit. Haltu reit inni til að breyta honum strax, ketti til að færa, fela eða opna hann.';

  @override
  String get helpCat =>
      'Allt um þennan kött: myndir, reitir, fjölskylda, saga. Síðan er aðeins til lesturs þar til þú snertir blýantinn. Haltu reit inni til að breyta honum beint; haltu mynd inni fyrir valmynd hennar. Valmyndin efst til hægri geymir afganginn: fela, sameina, skrá að kötturinn sást, deila kettinum. „Einkamál“ er stillt þegar reit er breytt.';

  @override
  String get helpStrays =>
      'Kettir sem eiga ekkert heimili núna: fundnir, strokuköttur eða af auglýsingu. Myndavélarhnappurinn skráir kött fyrir framan þig; auglýsingahnappurinn breytir týndauglýsingu í kött með tengilið eigandans; skanninn les cat(a)log kóða af auglýsingunni.';

  @override
  String get helpMap =>
      'Allir kettir og staðir með staðsetningu. Leitin finnur ketti, fólk og staði — óþekkt nafn er slegið upp um allan heim. Lagahnappurinn teiknar 500 m hringi um auglýsingastaði týnds kattar og um fyrra heimili hans. Örvarnar fara frá nælu til nælu, langt hald á kortinu skráir athugun.';

  @override
  String get helpCard =>
      'Prentanlegt spjald kattarins: veldu efst með merkjunum hvað birtist á því og deildu því svo sem mynd eða PDF. Númer má prenta sem QR eða strikamerki og staðsetning verður QR sem opnar kort, ásamt stuttum Plus Code.';

  @override
  String get helpSync =>
      'Svona berast gögnin til annarra: tengist beint, notið möppu sem bæði tækin sjá, eða sendu skrá með skilaboðaforriti. Þú ræður alltaf hvað fer — og .catsync skrár sem berast opnast líka hér.';

  @override
  String get helpFields =>
      'Reitirnir sem skráin þín notar. Endurnefndu þá, breyttu valkostum valreits eða búðu til þína eigin. Auðkennisreitur getur bent á þjónustu (skrá), þá verður hægt að ýta á númerið hjá kettinum.';

  @override
  String get helpTimeline =>
      'Sérhver breyting sem gerð hefur verið, sú nýjasta efst: hver breytti hverju, hvenær og í hvaða gildi. Hverja færslu má afturkalla — það skrifar nýja færslu, engu er nokkurn tíma eytt.';

  @override
  String get helpDuplicates =>
      'Kettir eða nýlendur sem virðast vera til tvisvar — sömu númer eða mjög lík nöfn með samsvarandi smáatriðum. Ýttu á par til að sameina; sameiningu er ekki hægt að afturkalla, því er spurt fyrst.';

  @override
  String get helpMatches =>
      'Kettir sem gætu verið sama dýrið: sama númer, eða flækingur sem sást innan leitarsvæðis týnds kattar. Ýttu á par til að sameina, haltu inni til að opna fyrri köttinn til samanburðar.';

  @override
  String get helpFlier =>
      'Ljósmynduð auglýsing verður að ketti ásamt eiganda. Skref fyrir skref: gögn kattarins, tengiliður eigandans, andlit klippt fyrir prófílmynd, skráningarnúmer af auglýsingunni og loks yfirferð. Allt eru tillögur — leiðréttu það sem myndavélin las vitlaust.';

  @override
  String get archiveTitle => 'Safn';

  @override
  String get archiveExplainer =>
      'Kettir sem eru dánir og tómar nýlendur sem enginn hefur snert árum saman taka samt pláss — einkum myndirnar þeirra. Söfnun skrifar þau í skrá sem þú geymir og eyðir þeim svo héðan.';

  @override
  String get archiveAction => 'Setja í safn';

  @override
  String archiveSelected(int count) {
    return 'Setja $count færslur í safn';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Setja $count færslur í safn?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names verða skrifuð í skrá og síðan eytt — í tækinu þínu og í hverju tæki sem þú samstillir við. Innflutningur skrárinnar skilar öllu; án hennar eru þau horfin.';
  }

  @override
  String archiveDone(int count) {
    return '$count færslur settar í safn og eytt';
  }

  @override
  String archiveFailed(String error) {
    return 'Engu var eytt: ekki tókst að skrifa safnskrána ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Gagnagrunnur $db, myndir $photos í $count skrám';
  }

  @override
  String quietForYears(int years) {
    return 'Óbreytt í $years ár';
  }

  @override
  String get nothingToArchive => 'Ekkert er nógu gamalt til að setja í safn.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Síðasta breyting $date · myndir $size';
  }

  @override
  String get helpArchive =>
      'Gömul gögn kosta pláss, einkum myndirnar sem hvert samstillt tæki ber með sér. Hér velur þú dána ketti og tómar nýlendur sem hafa legið kyrrar árum saman, skrifar þau í skrá sem þú geymir og eyðir þeim. Eyðingin nær til allra sem þú samstillir við; innflutningur skrárinnar endurheimtir allt.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Endurheimta $count eyddar færslur?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names eru eydd í þessari skrá, og skráin sem þú fluttir inn inniheldur þau. Endurheimt skilar þeim hingað og í öll tæki sem þú samstillir við.';
  }

  @override
  String get restoreAction => 'Endurheimta';

  @override
  String get keepDeleted => 'Halda eyddum';

  @override
  String get archiveNotSaved =>
      'Engu var eytt: safnið var ekki vistað neins staðar.';

  @override
  String get locateAddress => 'Finna heimilisfang á korti';

  @override
  String get addressLocated => 'Heimilisfang fannst';

  @override
  String get addressNotFound =>
      'Enginn staður fannst fyrir þetta heimilisfang. Athugaðu stafsetninguna eða skildu eftir autt.';

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
  String get includePrivate => 'Deila einkagögnum';

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
  String get starterStatus => 'Tegund';

  @override
  String get statusFoster => 'Fósturheimili';

  @override
  String get statusForeverHome => 'Heimili';

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
      'Skrautborðar og fagnaðarlæti þegar köttur flytur á heimili sitt';

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
  String get syncChooserInPersonSub => 'Samstilling um Wi-Fi';

  @override
  String get syncChooserRemote => 'Fjarlægt';

  @override
  String get syncChooserRemoteSub => 'Samstilling um möppu eða USB-lykil';

  @override
  String get syncChooserMessenger => 'Skilaboðaforrit';

  @override
  String get syncChooserMessengerSub =>
      'Út- og innflutningur um samfélagsmiðla';

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
  String get introTitle1 => 'Kettirnir þínir, skipulagðir';

  @override
  String get introBody1 =>
      'Búðu til spjald fyrir hvern kött: mynd, kyn, heilsa, allt sem þú vilt skrá. Kettir flokkast eftir því hvar þeir búa — appið kallar slíkan stað clowder.';

  @override
  String get introTitle2 => 'Virkar án nettengingar';

  @override
  String get introBody2 =>
      'Allt vistast aðeins í símanum þínum. Enginn aðgangur, ekkert ský. Ekkert er sent nema þú deilir því sjálf(ur).';

  @override
  String get introTitle3 => 'Vinnið saman';

  @override
  String get introBody3 =>
      'Hver og einn notar sitt eigið app og þið skiptist á gögnum af og til: hittist og skannið kóða, notið sameiginlega möppu eða sendið eina skrá með skilaboðaforriti. Eftir það hafa allir sömu upplýsingar.';

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
      'Hér samstillir þú við kunningja þína. Þú ræður hverju þú deilir.';

  @override
  String get spotHomeStrays =>
      'Þetta spjald safnar öllum flækingum — köttum án heimilis. Ýttu til að sjá listann.';

  @override
  String get spotHomeMenu =>
      'Í þessari valmynd: finna og sameina tvítök, flytja út CSV og fleira.';

  @override
  String get spotCatEdit =>
      'Ýttu á blýantinn til að breyta kettinum. Ábending: haltu reit inni til að breyta honum beint.';

  @override
  String get spotMapLayers =>
      'Leitarðu að týndum ketti? Sýndu hringi um staði auglýsinga hans og um heimilið sem hann strauk frá.';

  @override
  String get spotStraysFlier =>
      'Fannstu auglýsingu um týndan kött? Myndaðu hana hér — appið vistar kött og tengilið fyrir þig.';

  @override
  String get spotStraysScan =>
      'Sumar auglýsingar bera cat(a)log QR-kóða. Skannaðu hann hér og flyttu köttinn inn án innsláttar.';

  @override
  String get introTitle4 => 'Finndu týnda ketti';

  @override
  String get introBody4 =>
      'Sérðu auglýsingu um týndan kött? Myndaðu hana í appinu: það vistar köttinn, tengilið eigandans og staðinn. Ef svipaður flækingur birtist síðar stingur appið upp á mögulegum samsvörunum.';

  @override
  String get spotMapSearch =>
      'Sláðu inn kött, stað eða manneskju til að hoppa þangað á kortinu.';

  @override
  String get spotCardChips =>
      'Merktu við það sem á að sjást á deilanlega spjaldinu — annað verður ekki með.';

  @override
  String get spotCatMenu =>
      'Hér eru fleiri aðgerðir: fela köttinn, sameina tvítök eða skrá að kötturinn sást.';

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

  @override
  String get catalogsTitle => 'Skrár';

  @override
  String get newCatalog => 'Ný skrá';

  @override
  String get catalogNameLabel => 'Heiti skrár';

  @override
  String catalogNameTaken(String name) {
    return 'Skrá sem heitir $name er þegar til. Veldu annað heiti.';
  }

  @override
  String get manageCatalogs => 'Sýsla með skrár';

  @override
  String get helpCatalogs =>
      'Hver skrá er sinn eigin heimur: eigin kettir, nýlendur, reitir, myndir og samstillingarfélagar. Berlín og París blandast aldrei. Ýttu á heitið efst á heimaskjánum til að skipta, bæta við eða endurnefna. Nafnið þitt, tungumálið og ábendingar sem þú hefur séð eru sameiginleg.';

  @override
  String get spotHomeCatalog =>
      'Þetta er skráin sem þú ert í. Ýttu á heitið til að skipta eða búa til aðra.';

  @override
  String get deleteCatalog => 'Eyða skrá';

  @override
  String deleteCatalogBody(String name) {
    return 'Allt í $name hverfur: kettirnir, myndirnar, sagan. Fyrst er heil skrá vistuð þar sem sjálfvirk afrit lenda — að flytja hana inn skilar skránni aftur. Sláðu inn heitið til að staðfesta.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name eytt. Skráin er í $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Sláðu inn $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Engu var eytt: ekki tókst að skrifa skráarskrána ($error). Losaðu pláss eða reyndu aftur síðar.';
  }

  @override
  String get moveToCatalog => 'Færa í aðra skrá';

  @override
  String movedToCatalog(int count, String name) {
    return '$count færð í $name';
  }

  @override
  String get chooseWhatToMove => 'Hvað á að flytja?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Færa eitthvað í $name?';
  }

  @override
  String get undoThisImport => 'Afturkalla þennan innflutning';

  @override
  String undoImportBody(int count) {
    return '$count breytingar sem þessi innflutningur kom með verða fjarlægðar. Þær eru fyrst skrifaðar í skrá og innflutningur hennar skilar þeim. Þeir sem þú hefur þegar samstillt við halda sínu eintaki — það verður ekki afturkallað.';
  }

  @override
  String undoneImport(String where) {
    return 'Afturkallað. Skráin er í $where.';
  }

  @override
  String get goBackTitle => 'Fara til baka';

  @override
  String get goBackToHere => 'Fara hingað til baka';

  @override
  String get momentImport => 'Fyrir innflutning';

  @override
  String get momentSync => 'Fyrir samstillingu';

  @override
  String get momentMerge => 'Fyrir sameiningu';

  @override
  String get momentHardDelete => 'Fyrir eyðingu gagna höfundar';

  @override
  String get momentArchive => 'Fyrir söfnun í skjalasafn';

  @override
  String get momentManual => 'Merkt af þér';

  @override
  String get showOlderMoments => 'Sýna eldri';

  @override
  String goBackBody(int count) {
    return 'Allt eftir þessa stund verður fjarlægt — $count breytingar. Það er fyrst skrifað í skrá og innflutningur hennar skilar öllu; hver nýrri stund fer með. Þeir sem þú hefur þegar samstillt við halda sínu eintaki — það verður ekki afturkallað.';
  }

  @override
  String get nameThisMoment => 'Gefðu þessari stund heiti';

  @override
  String get helpGoBack =>
      'Stundirnar þegar þessi skrá breytti um lögun: fyrir hvern innflutning og hverja samstillingu, fyrir sameiningu, söfnun eða eyðingu, og alltaf þegar þú merktir stund sjálf. Ef þú velur eina fer skráin aftur í það ástand — allt eftir hana er skrifað í skrá sem þú heldur og síðan fjarlægt, og hver nýrri stund fer með. Þeir sem þú hefur þegar samstillt við halda því sem þeir fengu.';

  @override
  String goBackFileFailed(String error) {
    return 'Engu var eytt: skráin sem geymir það var ekki skrifuð ($error). Losaðu pláss og reyndu aftur.';
  }

  @override
  String get switchBeforeDeleting =>
      'Þetta er skráin sem þú ert í. Skiptu yfir í aðra og eyddu henni svo.';

  @override
  String shareFileFailed(String error) {
    return 'Ekki tókst að skrifa deiliskrána ($error). Losaðu pláss og reyndu aftur.';
  }

  @override
  String get privateLabel => 'Einkamál';

  @override
  String sharedCatalogIs(String name) {
    return 'Skrá: $name';
  }

  @override
  String get markPrivate => 'Merkja sem einka';

  @override
  String get unmarkPrivate => 'Fjarlægja einkamerki';
}
