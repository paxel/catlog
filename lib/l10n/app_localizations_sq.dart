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
      'Ende nuk ka clowder-ë.\nKrijoni të parin më poshtë.';

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
      'Macja zhduket nga të gjitha listat. Fotot e saj fshihen përgjithmonë.';

  @override
  String get sightingRecorded => 'Vëzhgimi u regjistrua në pozicionin tuaj.';

  @override
  String get noLocationAvailable =>
      'Vendndodhja s\'është e disponueshme — mbani shtypur hartën në vend të saj.';

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
  String get renameField => 'Riemërto fushën';

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
  String get orPlaceClowderHere => 'Ose vendos një clowder këtu:';

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
}
