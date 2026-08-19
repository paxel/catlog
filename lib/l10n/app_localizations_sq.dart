// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Mirë se vini në cat(a)log';

  @override
  String get welcomeBody =>
      'Zgjidhni një emër për veten. Çdo ndryshim regjistrohet me këtë emër, që të tjerët të shohin kush bëri çfarë.';

  @override
  String get yourName => 'Emri juaj';

  @override
  String get start => 'Fillo';

  @override
  String get clowders => 'Clowder-ët';

  @override
  String get noClowdersYet =>
      'Ende asnjë clowder. Clowder është një vend ku jetojnë macet — shtëpia jote e kujdestarisë, banesa e një birësuesi. Krijo të parin më poshtë.';

  @override
  String get strays => 'Macet endacake';

  @override
  String get searchCats => 'Kërko mace';

  @override
  String get map => 'Harta';

  @override
  String get sync => 'Sinkronizimi';

  @override
  String get fields => 'Fushat';

  @override
  String get exportCsv => 'Eksporto CSV';

  @override
  String get aboutAndFeedback => 'Rreth & komente';

  @override
  String get newClowder => 'Clowder i ri';

  @override
  String get name => 'Emri';

  @override
  String get cancel => 'Anulo';

  @override
  String get create => 'Krijo';

  @override
  String get save => 'Ruaj';

  @override
  String get delete => 'Fshi';

  @override
  String get merge => 'Bashko';

  @override
  String get resolve => 'Vendos';

  @override
  String get open => 'Hap';

  @override
  String csvSavedTo(String path) {
    return 'CSV u ruajt në $path';
  }

  @override
  String get renameClowder => 'Riemërto clowder-in';

  @override
  String get rename => 'Riemërto';

  @override
  String get timeline => 'Kronologjia';

  @override
  String get mergeInto => 'Bashko me…';

  @override
  String get deleteClowder => 'Fshi clowder-in';

  @override
  String get cats => 'Macet';

  @override
  String get addCat => 'Shto mace';

  @override
  String get newCat => 'Mace e re';

  @override
  String deleteQuestion(String name) {
    return 'Të fshihet $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder-i zhduket nga lista.';

  @override
  String deleteClowderBody(int count) {
    return 'Macet e tij ($count) nuk fshihen — bëhen endacake. Zhvendosini më parë në një clowder tjetër nëse nuk e doni këtë.';
  }

  @override
  String get card => 'Karta';

  @override
  String get shareAsImage => 'Ndaj si imazh';

  @override
  String get shareAsPdf => 'Ndaj si PDF';

  @override
  String get print => 'Printo';

  @override
  String cardTitle(String name) {
    return 'Karta — $name';
  }

  @override
  String get renameCat => 'Riemërto macen';

  @override
  String get seenHereNow => 'U pa këtu tani';

  @override
  String get deleteCat => 'Fshi macen';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Endacake — pa clowder';

  @override
  String get stray => 'Endacake';

  @override
  String get photos => 'Fotot';

  @override
  String get addPhoto => 'Shto foto';

  @override
  String get setAsProfileImage => 'Cakto si foto profili';

  @override
  String get thisIsProfileImage => 'Kjo është fotoja e profilit';

  @override
  String get deletePhoto => 'Fshi foton';

  @override
  String get deletePhotoTitle => 'Të fshihet fotoja?';

  @override
  String get deletePhotoBody =>
      'Të dhënat e fotos fshihen përgjithmonë — nuk kthehet mbrapsht.';

  @override
  String get deleteCatBody =>
      'Macja zhduket nga të gjitha listat dhe fotot e saj hiqen — këtu dhe, pas sinkronizimit të radhës, edhe te ndihmësit e tu.';

  @override
  String get sightingRecorded => 'Vëzhgimi u regjistrua në pozicionin tuaj.';

  @override
  String get noLocationAvailable =>
      'Vendndodhja s\'është e disponueshme — mbani shtypur hartën në vend të saj.';

  @override
  String get locationDeniedForever =>
      'Qasja në vendndodhje është e bllokuar. Lejojeni në cilësimet e sistemit për të përdorur Stray Cam.';

  @override
  String get locationServiceOff =>
      'Vendndodhja është e fikur në këtë pajisje. Ndizeni te cilësimet dhe provoni sërish.';

  @override
  String get locationDenied =>
      'cat(a)log nuk ka leje të përdorë vendndodhjen tuaj. Provoni sërish dhe lejojeni kur t\'ju pyetet.';

  @override
  String get locationNoFix =>
      'Pozicioni juaj nuk mund të përcaktohej tani. Provoni sërish në natyrë — GPS ka nevojë për pamje të lirë të qiellit.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Numri i çipit';

  @override
  String get starterRemarks => 'Shënime';

  @override
  String get captureFlier => 'Fotografo fletushkën';

  @override
  String get sortLabel => 'Rendit';

  @override
  String get matchCandidatesTitle => 'Përputhje të mundshme';

  @override
  String get sharePublicly => 'Ndaje publikisht…';

  @override
  String get pickFramesTitle => 'Zgjidh kuadro';

  @override
  String get suggestedFrames => 'Kuadro të sugjeruara';

  @override
  String get scrubFrames => 'Lëviz nëpër video';

  @override
  String get keepThisFrame => 'Mbaje këtë kuadër';

  @override
  String get fromVideo => 'Nga video…';

  @override
  String get videoMobileOnly =>
      'Zgjedhja e kuadrove nga videoja funksionon në aplikacionin e telefonit (Android dhe iPhone) — ende jo në këtë pajisje.';

  @override
  String get shareWhitelistExplainer =>
      'Vetëm fushat e shënuara largohen nga katalogu. Gjithçka tjetër mbetet në shtëpi.';

  @override
  String get exportShareFile => 'Eksporto skedarin e ndarjes…';

  @override
  String get hostedLink => 'Lidhje e strehuar (URL e skedarit të ngarkuar)';

  @override
  String get inlineQr => 'QR i integruar (vetëm tekst, pa foto)';

  @override
  String get inlineTooBig =>
      'Shumë të dhëna për një kod të integruar — hiqni fusha ose përdorni një lidhje të strehuar.';

  @override
  String get scanShareLabel => 'Skano kodin e ndarjes';

  @override
  String get notAShareCode => 'Ai kod nuk është ndarje cat(a)log.';

  @override
  String get importShareTitle => 'Të importohet kjo mace?';

  @override
  String shareSource(String url) {
    return 'Burimi: $url';
  }

  @override
  String get importLabel => 'Importo';

  @override
  String get strayAreaLabel => 'Zona e mundshme e endjes';

  @override
  String get noMissingCats =>
      'Ende asnjë mace e humbur me pozicione fletushkash.';

  @override
  String get noMatchCandidates => 'Aktualisht s\'ka përputhje të mundshme.';

  @override
  String sameIdField(String field) {
    return 'I njëjti $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m larg njëri-tjetrit';
  }

  @override
  String get addFlier => 'Shto fletushkë';

  @override
  String get missingSinceLabel => 'I humbur që nga';

  @override
  String get phoneLabel => 'Telefoni';

  @override
  String get cropPortrait => 'Prit portretin';

  @override
  String get statusOwner => 'Pronari';

  @override
  String get ocrUnavailable =>
      'Njohja e tekstit nuk ofrohet në këtë pajisje — shkruajeni vetë tekstin e fletushkës.';

  @override
  String get displayFormat => 'Shfaqet si';

  @override
  String get displayPlain => 'Tekst i thjeshtë';

  @override
  String get displayQr => 'Kod QR';

  @override
  String get displayBarcode => 'Barkod';

  @override
  String get editLabel => 'Redakto';

  @override
  String get doneLabel => 'U krye';

  @override
  String get openSettings => 'Hap cilësimet';

  @override
  String get notSaved => 'Nuk u ruajt';

  @override
  String get birthdateInFuture =>
      'Data e lindjes nuk mund të jetë në të ardhmen.';

  @override
  String get deceasedInFuture =>
      'Data e ngordhjes nuk mund të jetë në të ardhmen.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Data e ngordhjes nuk mund të jetë para datës së lindjes ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Data e lindjes nuk mund të jetë pas datës së ngordhjes ($date).';
  }

  @override
  String get malePregnant =>
      'Kjo mace është regjistruar si mashkull — një mashkull nuk mund të jetë shtatzënë. Kontrolloni fillimisht gjininë.';

  @override
  String get moveTo => 'Zhvendos te';

  @override
  String get noClowderStrayOption => 'Pa clowder — endacake / iku';

  @override
  String timelineOf(String name) {
    return 'Kronologjia — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Kthe mbrapsht këtë ndryshim';

  @override
  String get revertSubtitle =>
      'Rikthen vlerën e mëparshme si regjistrim të ri — historia i ruan të dyja.';

  @override
  String fieldCleared(String field) {
    return '$field u zbraz';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field u kthye te \"$value\"';
  }

  @override
  String get leftStray => 'Iku — endacake';

  @override
  String movedTo(String name) {
    return 'U zhvendos te $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat erdhi';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat erdhi nga $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat shkoi te $place';
  }

  @override
  String get duplicateMergedIn => 'Dublikata u bashkua';

  @override
  String get asOfToday => 'Me datën e sotme';

  @override
  String asOfDate(String date) {
    return 'Me datë $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Format i gabuar — përdorni $format';
  }

  @override
  String get value => 'Vlera';

  @override
  String get latitudeLongitude => 'gjerësia, gjatësia gjeografike';

  @override
  String get newField => 'Fushë e re';

  @override
  String get fieldType => 'Lloji';

  @override
  String get usedOn => 'Përdoret për';

  @override
  String get forCats => 'macet';

  @override
  String get forClowders => 'clowder-ët';

  @override
  String get forBoth => 'të dyja';

  @override
  String get optionsOnePerLine => 'Opsionet (një për rresht)';

  @override
  String get ownValue => 'Vlerë e vetja';

  @override
  String get renameField => 'Riemërto fushën';

  @override
  String get editOptions => 'Ndrysho opsionet…';

  @override
  String get noStraysRightNow => 'S\'ka mace endacake tani.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Shto endacake';

  @override
  String get newStray => 'Endacake e re';

  @override
  String get searchByNameHint => 'Kërko mace me emër…';

  @override
  String get host => 'Prit';

  @override
  String get hostExplainer =>
      'Filloni këtu, pastaj shkruani adresën dhe PIN-in në pajisjen tjetër.';

  @override
  String get startHosting => 'Fillo pritjen';

  @override
  String get stopHosting => 'Ndalo pritjen';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Seanca deri tani: $count';
  }

  @override
  String get join => 'Bashkohu';

  @override
  String get addressFromHost => 'Adresa (nga pajisja pritëse)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sinkronizo tani';

  @override
  String get addressFormatHint => 'Adresa duhet të duket si 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'U sinkronizua: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sinkronizimi dështoi: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Sinkronizimi i fundit me $peer: $time';
  }

  @override
  String get sharedFolder => 'Dosje e përbashkët';

  @override
  String get sharedFolderExplainer =>
      'Sinkronizoni përmes një dosjeje që e mbart reja ose një USB mes pajisjeve — për ata që s\'janë në të njëjtin rrjet.';

  @override
  String get noFolderChosenYet => 'Ende s\'është zgjedhur dosje';

  @override
  String get choose => 'Zgjidh…';

  @override
  String get syncFolderNow => 'Sinkronizo dosjen tani';

  @override
  String folderSynced(String result) {
    return 'Dosja u sinkronizua: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sinkronizimi i dosjes dështoi: $error';
  }

  @override
  String get recordSightingHere => 'Regjistro një vëzhgim këtu:';

  @override
  String trailOf(String name, int count) {
    return 'Gjurma: $name ($count vëzhgime)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'U ndryshua në dy vende njëkohësisht. Zgjidhni çfarë është e vërtetë:';

  @override
  String mergeThisInto(String kind) {
    return 'Bashko këtë $kind me…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'S\'ka $kind tjetër për ta bashkuar.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Të bashkohet me $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Dy regjistrimet bëhen një. $name mban vlerat e tanishme; historia e tjetrit i bashkohet. Nuk kthehet mbrapsht.';
  }

  @override
  String get kindCat => 'mace';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'fushë';

  @override
  String get takePhoto => 'Bëj foto';

  @override
  String get chooseFromGallery => 'Zgjidh nga galeria';

  @override
  String get about => 'Rreth';

  @override
  String get aboutTagline =>
      'Katalog lokal për macet në kujdestari. Të dhënat tuaja mbeten në pajisjet tuaja — pa server, pa llogari.';

  @override
  String versionLabel(String version, String build) {
    return 'Versioni $version ($build)';
  }

  @override
  String get sourceCode => 'Kodi burimor';

  @override
  String get reportProblemOrIdea => 'Raporto problem ose ide';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Shkruaji zhvilluesit';

  @override
  String get buyCoffee => 'Bleji zhvilluesit një kafe';

  @override
  String get coffeeSubtitle =>
      'Krejtësisht vullnetare — aplikacioni është falas';

  @override
  String get openSourceLicenses => 'Licencat me burim të hapur';

  @override
  String get machineTranslated =>
      'Përkthimet janë makinerike — korrigjimet mirëpriten në GitHub.';

  @override
  String get unnamed => '(pa emër)';

  @override
  String get labelName => 'Emri';

  @override
  String get labelProfileImage => 'Fotoja e profilit';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Gjinia';

  @override
  String get starterBreed => 'Raca';

  @override
  String get valueMixed => 'i përzier';

  @override
  String get breedEuropeanShorthair => 'Evropiane fleshkurtër';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britanike fleshkurtër';

  @override
  String get breedNorwegianForestCat => 'Macja e pyllit norvegjez';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siameze';

  @override
  String get breedPersian => 'Persiane';

  @override
  String get breedBengal => 'Bengale';

  @override
  String get breedSphynx => 'Sfinks';

  @override
  String get starterColor => 'Ngjyra';

  @override
  String get starterNeutered => 'E sterilizuar';

  @override
  String get starterPregnant => 'Shtatzënë';

  @override
  String get starterBirthdate => 'Data e lindjes';

  @override
  String get starterDeceased => 'E ngordhur';

  @override
  String get starterAddress => 'Adresa';

  @override
  String get starterResponsible => 'Personi përgjegjës';

  @override
  String get starterPosition => 'Pozicioni';

  @override
  String get valueYes => 'po';

  @override
  String get valueNo => 'jo';

  @override
  String get valueFemale => 'femër';

  @override
  String get valueMale => 'mashkull';

  @override
  String get valueUnknown => 'e panjohur';

  @override
  String get cropTitle => 'Prit foton';

  @override
  String get markTitle => 'Shëno macen';

  @override
  String get applyCrop => 'Prit';

  @override
  String get useFullPhoto => 'Përdor foton e plotë';

  @override
  String get dragToSelect => 'Tërhiq një drejtkëndësh rreth maces';

  @override
  String get dragOverTheCat => 'Tërhiq një elips mbi mace';

  @override
  String get cropPhoto => 'Prit…';

  @override
  String get markPhoto => 'Shëno…';

  @override
  String get scanCode => 'Skano kodin';

  @override
  String get orTypeCode => 'Ose shkruaje kodin';

  @override
  String get copyCode => 'Kopjo kodin';

  @override
  String get copied => 'U kopjua';

  @override
  String get invalidCode => 'Ky kod nuk është i vlefshëm';

  @override
  String get hotspotHint =>
      'S\'ka Wi-Fi të përbashkët? Ndiz hotspot-in e njërit telefon, lidh tjetrin dhe prit këtu.';

  @override
  String get byMessenger => 'Me messenger';

  @override
  String get byMessengerExplainer =>
      'Dërgo gjithë katalogun si një skedar me WhatsApp, Signal ose mail — pala tjetër e importon.';

  @override
  String get shareBundle => 'Ndaj paketën e sinkronizimit…';

  @override
  String get importBundle => 'Importo paketën e sinkronizimit…';

  @override
  String bundleImported(String result) {
    return 'Paketa u importua: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Kopja rezervë automatike e fundit dështoi: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Importi dështoi: $error';
  }

  @override
  String get pickOnMap => 'Zgjidh në hartë';

  @override
  String get useMyLocation => 'Përdor vendndodhjen time';

  @override
  String get language => 'Gjuha';

  @override
  String get systemDefault => 'Parazgjedhja e sistemit';

  @override
  String get iosLocalNetworkHint =>
      'Nëse dështon ende në iPhone/iPad: Cilësimet → Privatësia dhe siguria → Rrjeti lokal → lejo cat(a)log dhe provo sërish.';

  @override
  String get markPrivate => 'Shëno si private';

  @override
  String get unmarkPrivate => 'Hiq shënimin privat';

  @override
  String get includePrivate => 'Përfshi të dhënat private';

  @override
  String get includePrivateExplainer =>
      'Macet, grupet dhe fushat private ndahen gjithashtu — aktivizoje vetëm kur sinkronizon pajisjet e tua.';

  @override
  String get hideLabel => 'Fshih në këtë pajisje';

  @override
  String get unhideLabel => 'Shfaq përsëri';

  @override
  String get showHiddenLabel => 'Shfaq të fshehurat';

  @override
  String get stopShowingHidden => 'Ndalo shfaqjen e të fshehurave';

  @override
  String get starterSpecies => 'Specia';

  @override
  String get starterStatus => 'Statusi';

  @override
  String get statusFoster => 'Shtëpi kujdestarie';

  @override
  String get statusForeverHome => 'Shtëpi përgjithmonë';

  @override
  String get statusClinic => 'Klinikë';

  @override
  String get statusShelter => 'Strehëz';

  @override
  String get statusBarn => 'Hambar';

  @override
  String get valueCat => 'Mace';

  @override
  String get otherOption => 'Tjetër…';

  @override
  String get celebrationsToggle => 'Festo birësimet';

  @override
  String get celebrationsSubtitle =>
      'Konfeti dhe brohoritje kur një mace shpërngulet në shtëpinë e përhershme';

  @override
  String get onMapLabel => 'Në hartë';

  @override
  String get showOnMap => 'Shfaq në hartë';

  @override
  String get searchPlaceHint => 'Kërko vend ose adresë';

  @override
  String get noPlacesFound => 'Nuk u gjetën vende';

  @override
  String get mapSearchHint => 'Kërko mace, grupe, persona';

  @override
  String get proposeAnotherName => 'Propozo një emër tjetër';

  @override
  String get moderationTitle => 'Autorët & ndalimet';

  @override
  String get moderationSubtitle => 'Hiq përgjithmonë të dhënat e një personi';

  @override
  String get authorsSection => 'Kush ka shkruar në këtë katalog';

  @override
  String get hardDeleteAction => 'Fshi gjithçka nga ky autor';

  @override
  String hardDeleteWarning(Object name) {
    return 'Heq çdo hyrje dhe foto të $name nga kjo pajisje. Pajisjet e tjera i mbajnë të tyret. Nuk kthehet dot.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Shkruaj $name për konfirmim';
  }

  @override
  String get alsoBan => 'Ndalo gjithashtu — mos prano më kurrë të dhëna';

  @override
  String get bansSection => 'Ndalimet';

  @override
  String get unbanAction => 'Hiq ndalimin';

  @override
  String get deletedDone => 'U fshi.';

  @override
  String get syncSummaryTitle => 'Çfarë mbërriti';

  @override
  String get summaryAdopted => 'Të birësuara';

  @override
  String get summaryDeceased => 'Të ngordhura';

  @override
  String get summaryEscaped => 'Të arratisura';

  @override
  String get summaryNew => 'Të reja';

  @override
  String get summaryConflicts => 'Konflikte për zgjidhje';

  @override
  String summaryOther(Object n) {
    return '…dhe $n ndryshime të tjera';
  }

  @override
  String get starterMother => 'Nëna';

  @override
  String get starterFather => 'Babai';

  @override
  String get familySection => 'Familja';

  @override
  String get littermatesLabel => 'Nga e njëjta pjellë';

  @override
  String get siblingsLabel => 'Vëllezër e motra';

  @override
  String get kittensLabel => 'Kotelet';

  @override
  String get toastSettingsTitle => 'Çfarë të njoftohet';

  @override
  String get toastSettingsSubtitle => 'Mesazhe të vogla pas sinkronizimit';

  @override
  String get toastKindAdoptions => 'Birësimet';

  @override
  String get toastKindBirths => 'Lindjet';

  @override
  String get toastKindDeaths => 'Vdekjet';

  @override
  String get toastKindEscapes => 'Arratisjet';

  @override
  String get toastKindMoves => 'Zhvendosjet';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat u birësua nga $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Kotele e re: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat ndërroi jetë';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat u arratis';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat u zhvendos te $home';
  }

  @override
  String get notACatlogFile => 'Ky nuk është skedar cat(a)log';

  @override
  String get nothingNewInBundle => 'Asgjë e re në skedar — i ke të gjitha';

  @override
  String get syncChooserInPerson => 'Personalisht';

  @override
  String get syncChooserInPersonSub =>
      'Jeni në të njëjtën dhomë — skano një kod, gati për sekonda';

  @override
  String get syncChooserRemote => 'Në distancë';

  @override
  String get syncChooserRemoteSub =>
      'Përmes një dosjeje të përbashkët si Dropbox ose USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Dërgo gjithçka si një skedar me çdo messenger';

  @override
  String get connectToWifiFirst =>
      'Lidhu fillimisht me Wi-Fi — atëherë pajisjet gjejnë njëra-tjetrën';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) do të sinkronizojë';
  }

  @override
  String get trustBothWaysNote =>
      'Katalogët do të shkëmbehen në të dyja drejtimet.';

  @override
  String get allowOnce => 'Lejo';

  @override
  String get allowAlways => 'Lejo gjithmonë këtë pajisje';

  @override
  String get declineAction => 'Refuzo';

  @override
  String get syncDeclined => 'Pajisja tjetër e refuzoi sinkronizimin';

  @override
  String get trustedDevicesSection => 'Pajisjet e lejuara gjithmonë';

  @override
  String get removeTrust => 'Hiq';

  @override
  String get hostWithoutWifi => 'Prit pa Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Krijon një lidhje të drejtpërdrejtë të përkohshme me telefonin tjetër (pa internet). E përdor vetëm cat(a)log dhe shkëputet vetë pas sinkronizimit.';

  @override
  String get hotspotAndroidOnly =>
      'Ky kod kërkon dy telefona Android — në iPhone/iPad përdor një Wi-Fi të përbashkët';

  @override
  String get selectClowderHint => 'Zgjidh një clowder majtas';

  @override
  String get introTitle1 => 'Macet jetojnë në clowdera';

  @override
  String get introBody1 =>
      'Clowder është një vend ku jetojnë macet: shtëpia jote e kujdestarisë, banesa e një birësuesi, hambari ngjitur. Çdo mace ka një kartë me foto, fakte dhe gjithë historinë e saj.';

  @override
  String get introTitle2 => 'Gjithçka mbetet te ti';

  @override
  String get introBody2 =>
      'Pa llogari, pa cloud, pa gjurmim. Të dhënat e tua jetojnë në pajisjen tënde.';

  @override
  String get introTitle3 => 'Ndaj me ndihmësit';

  @override
  String get introBody3 =>
      'Skano një kod dhe dy pajisje sinkronizohen për sekonda, përdor një dosje të përbashkët ose dërgo gjithçka si një skedar.';

  @override
  String get introSkip => 'Kapërce';

  @override
  String get introNext => 'Tjetra';

  @override
  String get introDone => 'Nisemi';

  @override
  String get introReplayTitle => 'Hyrje e shpejtë';

  @override
  String get spotHomeSync =>
      'E re: sinkronizimi tani ofron tri rrugë të qarta — dhe një pyetje besimi para se të rrjedhë gjë.';

  @override
  String get spotMapSearch =>
      'E re: kërko këtu mace, clowdera dhe persona — direkt në hartë.';

  @override
  String get spotCardChips =>
      'E re: zgjidh çfarë shfaqet në kartë para se ta ndash.';

  @override
  String get spotCatMenu =>
      'E re: shëno një mace si private (nuk e lë kurrë pajisjen) ose fshihe këtu.';

  @override
  String get spotDone => 'Kuptova';

  @override
  String get spotReplayTitle => 'Turi i risive';

  @override
  String get spotReplaySubtitle => 'Shfaq këshillat sërish në çdo faqe';

  @override
  String get spotReplayDone => 'Këshillat do të shfaqen sërish';

  @override
  String get searchNoResults => 'Nuk u gjet mace me atë emër';

  @override
  String get syncUnreachable =>
      'Pajisja tjetër nuk arrihet. A janë të dyja në të njëjtin Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Dosja nuk arrihet. A ekziston ende disku ose dosja cloud?';

  @override
  String get crashTitle => 'Kjo nuk duhej të ndodhte';

  @override
  String get crashBody =>
      'cat(a)log hasi një gabim të papritur. Të dhënat e tua janë të sigurta — gjithçka ruhet në çastin që e ndryshon. Rinise aplikacionin dhe nëse përsëritet, dërgo raportin që të rregullohet.';

  @override
  String get crashRestart => 'Rinis aplikacionin';

  @override
  String get crashSendReport => 'Dërgo raport te zhvilluesi';

  @override
  String get crashLastRunBody =>
      'cat(a)log u ndal papritur herën e kaluar — me gjasë mbaroi memoria. Të dërgojmë një raport të shkurtër që të rregullohet?';
}
