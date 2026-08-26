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
      'Macja zhduket nga të gjitha listat dhe fotot e saj hiqen — këtu dhe, pas sinkronizimit të radhës, edhe në pajisjet e tjera.';

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
  String get addPhotosTo => 'Shto fotot te…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foto iu shtuan $name';
  }

  @override
  String get scanPrintedCode => 'Skano kodin e printuar';

  @override
  String get chipScanHint =>
      'Skanon kodin QR/barkodin e printuar nga karta e çipit ose dokumentet e veterinerit — çipin brenda maces telefoni s\'mund ta lexojë.';

  @override
  String get savingLabel => 'Po ruhet…';

  @override
  String ownerOfCat(String name) {
    return 'Pronari i $name';
  }

  @override
  String get sortLabel => 'Rendit';

  @override
  String get viewAsTable => 'Shfaq si tabelë';

  @override
  String get viewAsTiles => 'Shfaq si pllaka';

  @override
  String get matchCandidatesTitle => 'Përputhje të mundshme';

  @override
  String get findDuplicates => 'Gjej dublikatat';

  @override
  String get noDuplicates => 'Aktualisht s\'ka dublikata të mundshme.';

  @override
  String get similarName => 'Emër i ngjashëm';

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
      'Zgjidh çfarë hyn në skedar. Përfshihen vetëm fushat e shënuara.';

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
  String get prevPin => 'Gjilpëra e mëparshme';

  @override
  String get nextPin => 'Gjilpëra tjetër';

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
  String fatherNotMale(String name) {
    return '$name është regjistruar si femër dhe s\'mund të jetë babai. Kontrolloni fillimisht gjininë.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name është regjistruar si mashkull dhe s\'mund të jetë nëna. Kontrolloni fillimisht gjininë.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name ka lindur më $date — një prind s\'mund të lindë pas të voglit të tij.';
  }

  @override
  String get genderFatherFemale =>
      'Kjo mace është regjistruar si babai i maceve të tjera — babai s\'mund të jetë femër. Kontrolloni fillimisht familjen.';

  @override
  String get genderMotherMale =>
      'Kjo mace është regjistruar si nëna e maceve të tjera — nëna s\'mund të jetë mashkull. Kontrolloni fillimisht familjen.';

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
      'Filloni këtu, pastaj skanoni kodin ose shkruajeni në pajisjen tjetër.';

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
      'Të dyja pajisjet përdorin të njëjtën dosje (p.sh. në Dropbox ose në USB). Çdo sinkronizim i lë aty ndryshimet e tua dhe merr ato të palës tjetër.';

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
      'Aplikacioni mbetet falas. Edhe nëse s\'marr kafe :)';

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
  String get starterEmail => 'Email';

  @override
  String get starterPhone => 'Telefoni';

  @override
  String get lookupUrlLabel => 'Lidhje kërkimi';

  @override
  String lookupUrlHelp(String token) {
    return 'Faqja e shërbimit me $token aty ku shkon numri, p.sh. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Kërko';

  @override
  String lookupFailed(String url) {
    return 'Asnjë aplikacion nuk e hapi dot $url. Kopjo lidhjen në një shfletues.';
  }

  @override
  String get stepCat => 'Macja';

  @override
  String get stepOwner => 'Pronari';

  @override
  String get stepFace => 'Foto e fytyrës';

  @override
  String get stepRegistry => 'Regjistri';

  @override
  String get stepReview => 'Kontrollo dhe ruaj';

  @override
  String get stepOwnerHint =>
      'Ai që i ka humbur macja — nga kjo del clowderi i tij, me kontaktin nga fletushka.';

  @override
  String get stepFaceHint =>
      'Prije fytyrën e maces nga fletushka; bëhet fotoja e profilit. Mund ta kapërcesh.';

  @override
  String get stepRegistryHint =>
      'Numra të gjetur në fletushkë. Ata të shënuar ruhen te macja dhe hapen më vonë.';

  @override
  String get noRegistryLinks =>
      'Asnjë lidhje regjistri në këtë fletushkë — nëse ndonjëra është anashkaluar, ju lutem raportoni një bug.';

  @override
  String get unknownServiceHint => 'Shërbim i panjohur';

  @override
  String get rememberService => 'Mba mend shërbimin';

  @override
  String get rememberServiceHint =>
      'Emërto shërbimin dhe trego numrin në lidhje. Fletushka tjetër plotësohet vetë.';

  @override
  String get noIdInLink =>
      'Kjo lidhje nuk ka numër që aplikacioni të mund ta ruajë.';

  @override
  String get whichNumber => 'Cila pjesë është numri?';

  @override
  String get cropAgain => 'Prije sërish';

  @override
  String get noFaceYet => 'Ende pa foto fytyre — përdoret fotoja e fletushkës.';

  @override
  String get backLabel => 'Prapa';

  @override
  String get dangerButton => 'MOS E SHTYP.\nRREZIK';

  @override
  String get dangerThanks => 'Faleminderit që përdor cat(a)log!';

  @override
  String get helpTitle => 'Ndihmë';

  @override
  String get showTipsAgain => 'Shfaq sërish këshillat';

  @override
  String get helpHome =>
      'Pamja e kolonive të tua — një koloni është një vend ku jetojnë mace: shtëpia jote, një strehë e përkohshme, një strehimore. Prek një kartë për macet e saj; shtypja e gjatë hap menynë. Butoni poshtë djathtas krijon një koloni, ndërsa karta e endacakëve mbledh të gjitha macet pa shtëpi. Emri lart është katalogu ku ndodhesh — prekë për të ndërruar ose shtuar një.';

  @override
  String get helpClowder =>
      'Gjithçka për këtë vend: macet, fushat (adresa, kontakti, lloji) dhe historiku. Faqja hapet vetëm për lexim; lapsi ndez redaktimin, ku mund të shtosh edhe një fushë. Shtypja e gjatë mbi një fushë e redakton menjëherë, mbi një mace e zhvendos, e fsheh ose e hap.';

  @override
  String get helpCat =>
      'Gjithçka për këtë mace: foto, fusha, familja, historiku. Faqja është vetëm për lexim derisa të prekësh lapsin. Mbaje shtypur një fushë për ta ndryshuar direkt; mbaje shtypur një foto për menunë e saj. Menyja lart djathtas mban pjesën tjetër: fshih, bashko, shëno një vëzhgim, ndaj macen. „Private“ caktohet gjatë ndryshimit të një fushe.';

  @override
  String get helpStrays =>
      'Mace që tani nuk kanë shtëpi: të gjetura, të arratisura ose nga një fletushkë. Butoni i kamerës regjistron një mace para teje; butoni i fletushkës e kthen një afishe në mace me kontaktin e pronarit; skaneri lexon një kod cat(a)log nga afishja.';

  @override
  String get helpMap =>
      'Të gjitha macet dhe vendet me pozicion. Kërkimi gjen mace, persona dhe vende — një emër i panjohur kërkohet në gjithë botën. Butoni i shtresave vizaton rrathët 500 m rreth vendeve të fletushkave të një maceje të humbur dhe rreth shtëpisë nga iku. Shigjetat shkojnë nga një gozhdë te tjetra, shtypja e gjatë mbi hartë shënon një vëzhgim.';

  @override
  String get helpCard =>
      'Karta e printueshme e maces: lart me çipat zgjedh çfarë shfaqet, pastaj e ndan si imazh ose PDF. Numrat mund të printohen si QR ose barkod, dhe pozicioni bëhet një QR që hap hartën, plus një Plus Code i shkurtër.';

  @override
  String get helpSync =>
      'Si shkojnë të dhënat te të tjerët: lidhu drejtpërdrejt, përdor një dosje që e shohin të dyja pajisjet, ose dërgo një skedar me mesazhe. Gjithmonë ti vendos çfarë del — dhe skedarët .catsync të marrë hapen po këtu.';

  @override
  String get helpFields =>
      'Fushat që përdor katalogu yt. Riemërtoji, ndrysho opsionet e një fushe me zgjedhje ose krijo të tuat. Një fushë identifikuesi mund të tregojë drejt një shërbimi (regjistri), dhe atëherë numri te macja bëhet i prekshëm.';

  @override
  String get helpTimeline =>
      'Çdo ndryshim i bërë ndonjëherë, më i riu i pari: kush ndryshoi çfarë, kur dhe në cilën vlerë. Çdo shënim mund të kthehet — kjo shkruan një shënim të ri, asgjë nuk fshihet.';

  @override
  String get helpDuplicates =>
      'Mace ose koloni që duken sikur ekzistojnë dy herë — numra identikë ose emra shumë të ngjashëm me detaje që përputhen. Prek një çift për ta bashkuar; bashkimi nuk kthehet, prandaj pyetet më parë.';

  @override
  String get helpMatches =>
      'Mace që mund të jenë i njëjti kafshë: numër identik, ose një endacak i parë brenda zonës së kërkimit të një maceje të humbur. Prek një çift për bashkim, shtypja e gjatë hap macen e parë për krahasim.';

  @override
  String get helpFlier =>
      'Një fletushkë e fotografuar bëhet mace bashkë me pronarin. Hap pas hapi: të dhënat e maces, kontakti i pronarit, prerja e fytyrës për foton e profilit, numrat e regjistrave nga fletushka, pastaj një kontroll i fundit. Gjithçka është sugjerim — korrigjo çfarë kamera lexoi gabim.';

  @override
  String get archiveTitle => 'Arkivi';

  @override
  String get archiveExplainer =>
      'Macet e ngordhura dhe koloni bosh që s\'i ka prekur njeri prej vitesh prapë zënë vend — sidomos fotot e tyre. Arkivimi i shkruan në një skedar që e mban ti dhe pastaj i fshin nga këtu.';

  @override
  String get archiveAction => 'Arkivo';

  @override
  String archiveSelected(int count) {
    return 'Arkivo $count zëra';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Të arkivohen $count zëra?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names do të shkruhen në një skedar dhe pastaj do të fshihen — në pajisjen tënde dhe në çdo pajisje me të cilën sinkronizon. Importimi i skedarit i kthen të gjitha; pa të, humbin.';
  }

  @override
  String archiveDone(int count) {
    return 'U arkivuan dhe u fshinë $count zëra';
  }

  @override
  String archiveFailed(String error) {
    return 'Nuk u fshi asgjë: skedari i arkivit nuk u shkrua dot ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Baza $db, foto $photos në $count skedarë';
  }

  @override
  String quietForYears(int years) {
    return 'Pa ndryshim prej $years vjetësh';
  }

  @override
  String get nothingToArchive => 'Asgjë s\'është aq e vjetër sa të arkivohet.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Ndryshimi i fundit $date · foto $size';
  }

  @override
  String get helpArchive =>
      'Të dhënat e vjetra kushtojnë hapësirë, sidomos fotot që i mbart çdo pajisje e sinkronizuar. Këtu zgjedh macet e ngordhura dhe koloni bosh që rrinë prej vitesh, i shkruan në një skedar që e mban, dhe i fshin. Fshirja arrin te të gjithë me të cilët sinkronizon; importimi i skedarit i rikthen të gjitha.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Të rikthehen $count zëra të fshirë?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names janë të fshirë në këtë katalog, dhe skedari që sapo importove i përmban. Rikthimi i sjell këtu dhe në çdo pajisje me të cilën sinkronizon.';
  }

  @override
  String get restoreAction => 'Riktheji';

  @override
  String get keepDeleted => 'Lëri të fshirë';

  @override
  String get archiveNotSaved => 'Nuk u fshi asgjë: arkivi nuk u ruajt askund.';

  @override
  String get locateAddress => 'Gjej adresën në hartë';

  @override
  String get addressLocated => 'Adresa u gjet';

  @override
  String get addressNotFound =>
      'Nuk u gjet asnjë vend për këtë adresë. Kontrollo shkrimin ose lëre bosh.';

  @override
  String get starterPosition => 'Vendndodhja';

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
  String get includePrivate => 'Ndaj të dhënat private';

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
  String get starterStatus => 'Lloji';

  @override
  String get statusFoster => 'Shtëpi kujdestarie';

  @override
  String get statusForeverHome => 'Shtëpi';

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
      'Konfeti dhe brohoritje kur një mace shpërngulet në shtëpinë e saj';

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
  String get syncChooserInPersonSub => 'Sinkronizim përmes Wi-Fi';

  @override
  String get syncChooserRemote => 'Në distancë';

  @override
  String get syncChooserRemoteSub => 'Sinkronizim përmes dosjes ose USB-së';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Eksport dhe import përmes rrjeteve sociale';

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
  String get introTitle1 => 'Macet e tua, të organizuara';

  @override
  String get introBody1 =>
      'Krijo një kartë për çdo mace: foto, gjinia, shëndeti, gjithçka që do të shënosh. Macet grupohen sipas vendit ku jetojnë — aplikacioni e quan atë vend koloni (clowder).';

  @override
  String get introTitle2 => 'Punon pa internet';

  @override
  String get introBody2 =>
      'Gjithçka ruhet vetëm në telefonin tënd. Pa llogari, pa cloud. Asgjë nuk dërgohet nëse nuk e ndan vetë.';

  @override
  String get introTitle3 => 'Punoni së bashku';

  @override
  String get introBody3 =>
      'Secili përdor aplikacionin e vet dhe herë pas here shkëmbeni të dhëna: takohuni dhe skanoni një kod, përdorni një dosje të përbashkët ose dërgoni një skedar me messenger. Pastaj të gjithë kanë të njëjtin informacion.';

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
      'Këtu sinkronizon me të njohurit e tu. Ti vendos çfarë ndan.';

  @override
  String get spotHomeStrays =>
      'Kjo kartë mbledh të gjithë endacakët — macet pa shtëpi. Prek për listën.';

  @override
  String get spotHomeMenu =>
      'Në këtë meny: gjej dhe bashko dublikatat, eksporto CSV e më shumë.';

  @override
  String get spotCatEdit =>
      'Prek lapsin për ta redaktuar macen. Këshillë: shtypja e gjatë mbi një fushë e redakton direkt.';

  @override
  String get spotMapLayers =>
      'Kërkon një mace të humbur? Shfaq rrathë rreth vendeve të fletushkave të saj dhe rreth shtëpisë nga iku.';

  @override
  String get spotStraysFlier =>
      'Fletushkë maceje të humbur? Fotografoje këtu — aplikacioni ruan macen dhe kontaktin për ty.';

  @override
  String get spotStraysScan =>
      'Disa fletushka kanë kod QR cat(a)log. Skanoje këtu dhe importo macen pa shtypur.';

  @override
  String get introTitle4 => 'Gjeni macet e humbura';

  @override
  String get introBody4 =>
      'Sheh një fletushkë për mace të humbur? Fotografoje në aplikacion: ruan macen, kontaktin e pronarit dhe vendin. Nëse më vonë shfaqet një endacake e ngjashme, aplikacioni sugjeron përputhje të mundshme.';

  @override
  String get spotMapSearch =>
      'Shkruaj një mace, vend a person që të hidhesh aty në hartë.';

  @override
  String get spotCardChips =>
      'Shëno çfarë duhet të shfaqet në kartën e ndashme — pjesa tjetër mbetet jashtë.';

  @override
  String get spotCatMenu =>
      'Këtu ka më shumë veprime: fshih macen, bashko dublikatat ose shëno një vëzhgim.';

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

  @override
  String get catalogsTitle => 'Katalogët';

  @override
  String get newCatalog => 'Katalog i ri';

  @override
  String get catalogNameLabel => 'Emri i katalogut';

  @override
  String catalogNameTaken(String name) {
    return 'Një katalog me emrin $name ekziston tashmë. Zgjidh një emër tjetër.';
  }

  @override
  String get manageCatalogs => 'Menaxho katalogët';

  @override
  String get helpCatalogs =>
      'Çdo katalog është një botë më vete: macet, kolonitë, fushat, fotot dhe partnerët e sinkronizimit e vet. Berlini dhe Parisi nuk përzihen kurrë. Prek emrin lart në ekranin kryesor për të ndërruar, shtuar ose riemërtuar. Emri yt, gjuha dhe këshillat e para tashmë janë të përbashkëta.';

  @override
  String get spotHomeCatalog =>
      'Ky është katalogu ku ndodhesh. Prek emrin për të ndërruar ose për të krijuar një tjetër.';

  @override
  String get deleteCatalog => 'Fshi katalogun';

  @override
  String deleteCatalogBody(String name) {
    return 'Gjithçka në $name zhduket: macet, fotot, historiku. Së pari ruhet një skedar i plotë atje ku shkojnë kopjet automatike — importimi i tij e sjell katalogun mbrapsht. Shkruaj emrin për të konfirmuar.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name u fshi. Skedari është në $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Shkruaj $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nuk u fshi asgjë: skedari i katalogut nuk u shkrua dot ($error). Liro pak hapësirë ose provo më vonë.';
  }

  @override
  String get moveToCatalog => 'Zhvendos në një katalog tjetër';

  @override
  String movedToCatalog(int count, String name) {
    return '$count u zhvendosën te $name';
  }

  @override
  String get chooseWhatToMove => 'Çfarë do të zhvendoset?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Të zhvendoset diçka te $name?';
  }

  @override
  String get undoThisImport => 'Zhbëj këtë importim';

  @override
  String undoImportBody(int count) {
    return '$count ndryshimet që solli ky importim hiqen. Së pari shkruhen në një skedar, importimi i të cilit i kthen. Ata me të cilët je sinkronizuar tashmë e mbajnë kopjen e tyre — kjo nuk merret mbrapsht.';
  }

  @override
  String undoneImport(String where) {
    return 'U zhbë. Skedari është në $where.';
  }

  @override
  String get goBackTitle => 'Kthehu prapa';

  @override
  String get goBackToHere => 'Kthehu këtu';

  @override
  String get momentImport => 'Para importimit';

  @override
  String get momentSync => 'Para sinkronizimit';

  @override
  String get momentMerge => 'Para bashkimit';

  @override
  String get momentHardDelete => 'Para fshirjes së të dhënave të një autori';

  @override
  String get momentArchive => 'Para arkivimit';

  @override
  String get momentManual => 'Shënuar prej teje';

  @override
  String get showOlderMoments => 'Shfaq më të vjetrat';

  @override
  String goBackBody(int count) {
    return 'Gjithçka pas këtij çasti hiqet — $count ndryshime. Së pari shkruhet në një skedar, importimi i të cilit e kthen gjithçka, dhe çdo çast më i ri ikën bashkë me të. Ata me të cilët je sinkronizuar tashmë e mbajnë kopjen — kjo nuk merret mbrapsht.';
  }

  @override
  String get nameThisMoment => 'Emërto këtë çast';

  @override
  String get helpGoBack =>
      'Çastet kur ky katalog ndryshoi formë: para çdo importimi dhe çdo sinkronizimi, para një bashkimi, arkivimi ose fshirjeje, dhe sa herë që shënove vetë një çast. Zgjedhja e njërit e kthen katalogun në atë gjendje — gjithçka pas tij shkruhet në një skedar që e mban dhe pastaj hiqet, dhe çdo çast më i ri ikën bashkë me të. Ata me të cilët je sinkronizuar tashmë mbajnë atë që morën.';

  @override
  String goBackFileFailed(String error) {
    return 'Nuk u hoq asgjë: skedari që e ruan nuk u shkrua dot ($error). Liro pak hapësirë dhe provo sërish.';
  }

  @override
  String get switchBeforeDeleting =>
      'Ky është katalogu ku ndodhesh. Kalo te një tjetër, pastaj fshije.';

  @override
  String shareFileFailed(String error) {
    return 'Skedari i ndarjes nuk u shkrua dot ($error). Liro pak hapësirë dhe provo sërish.';
  }

  @override
  String get privateLabel => 'Private';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalogu: $name';
  }

  @override
  String get markPrivate => 'Shëno si private';

  @override
  String get unmarkPrivate => 'Hiq shënimin privat';

  @override
  String get agenda => 'Përkujtues';

  @override
  String get reminderLabel => 'Përkujtues';

  @override
  String get agendaEmpty =>
      'S\'ka takime të planifikuara. Planifiko të reja këtu me plusin, ose në faqen e një maceje a clowderi.';

  @override
  String get dueToday => 'sot';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pas $count ditësh',
      one: 'pas 1 dite',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ditë vonesë',
      one: '1 ditë vonesë',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'U bë';

  @override
  String get repeatTitle => 'Sërish pas…';

  @override
  String get noRepeatLabel => 'Pa përsëritje';

  @override
  String get unitDays => 'ditësh';

  @override
  String get unitWeeks => 'javësh';

  @override
  String get unitMonths => 'muajsh';

  @override
  String get unitYears => 'vjetësh';

  @override
  String get changeDateLabel => 'Ndrysho datën';

  @override
  String get removeReminderLabel => 'Hiq përkujtuesin';

  @override
  String get exportIcs => 'Eksporto skedarin e kalendarit';

  @override
  String icsSavedTo(String path) {
    return 'Skedari i kalendarit u ruajt te $path';
  }

  @override
  String get calendarMirrorLabel => 'Pasqyro në kalendarin e pajisjes';

  @override
  String get calendarMirrorSubtitle =>
      'Takimet shfaqen si ngjarje gjithëditore në kalendar. cat(a)log i përditëson atje në çdo nisje dhe pas çdo ndryshimi. Sinjalizimet për takimet i menaxhon në kalendar.';

  @override
  String get syncPeerOlder =>
      'Pajisja tjetër ka një cat(a)log më të vjetër pa përkujtues. Përditëso cat(a)log atje dhe sinkronizo sërish.';

  @override
  String get syncPeerNewer =>
      'Pajisja tjetër ka një cat(a)log më të ri. Përditëso cat(a)log në këtë pajisje dhe sinkronizo sërish.';

  @override
  String get bundleNewerError =>
      'Ky skedar vjen nga një cat(a)log më i ri. Përditëso cat(a)log në këtë pajisje për ta importuar.';

  @override
  String get spotEar =>
      'Një vesh i vogël maceje në qoshe do të thotë: mbaje shtypur për më shumë.';

  @override
  String get addReminder => 'Shto përkujtues';

  @override
  String get plannedSection => 'Planifikuar';

  @override
  String get reminderDialogHint =>
      'Takimi shfaqet te përkujtuesit. Atje mund ta konfirmosh ose ta hedhësh poshtë. Vlera merret vetëm kur takimi është konfirmuar.';

  @override
  String get reminderFor => 'Për';

  @override
  String get reminderField => 'Fusha';

  @override
  String get dueDateLabel => 'Afati';

  @override
  String get pickCalendar => 'Cili kalendar?';

  @override
  String get calendarPermissionDenied =>
      'Qasja te kalendari është bllokuar, prandaj pasqyrimi është fikur. Lejoje te cilësimet e sistemit dhe ndize pasqyrimin sërish.';

  @override
  String get calendarNotChosen =>
      'Nuk është zgjedhur kalendar, prandaj pasqyrimi është fikur. Ndize sërish dhe zgjidh një.';

  @override
  String get calendarGone =>
      'Kalendari i zgjedhur nuk ekziston më, prandaj pasqyrimi është fikur. Ndize sërish dhe zgjidh një tjetër.';

  @override
  String get noWritableCalendar =>
      'S\'u gjet asnjë kalendar. Hyr te cilësimet e sistemit në një llogari kalendari, për shembull Google, dhe provo sërish.';

  @override
  String get spotHomeAgenda =>
      'Përkujtuesit: lista e takimeve të planifikuara — veterineri, ilaçet, kontrollet.';

  @override
  String get spotAgendaAdd => 'Planifiko një takim të ri.';

  @override
  String get spotAgendaCalendar =>
      'Ndize këtu pasqyrimin e takimeve të cat(a)log në një kalendar sipas zgjedhjes.';

  @override
  String get helpAgenda =>
      'Përkujtuesit rendisin takimet e planifikuara sipas datës. Të humburat mbeten lart. Prekja hap macen ose clowderin. Shenja konfirmon një takim: vlera shkruhet në fushë dhe mund ta planifikosh menjëherë tjetrin, për shembull pas tre muajsh. Mbajtja shtypur ndryshon datën ose e fshin takimin. Çelësi lart pasqyron takimet në një kalendar të telefonit tënd. Menyja i eksporton si skedar kalendari.';

  @override
  String get calendarRowOff => 'Kalendari: fikur';

  @override
  String calendarRowOn(String name) {
    return 'Kalendari: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Planifiko një takim për këtë mace. Shfaqet te përkujtuesit dhe konfirmohet atje.';

  @override
  String get spotAddReminderClowder =>
      'Planifiko një takim për këtë clowder. Shfaqet te përkujtuesit dhe konfirmohet atje.';

  @override
  String get readOnlyCalendar => 'vetëm lexim';
}
