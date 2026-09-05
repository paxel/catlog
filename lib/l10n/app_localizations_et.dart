// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Tere tulemast cat(a)logi';

  @override
  String get welcomeBody =>
      'Vali endale nimi. Iga muudatus salvestatakse selle nime all, et teised näeksid, kes mida tegi.';

  @override
  String get yourName => 'Sinu nimi';

  @override
  String get start => 'Alusta';

  @override
  String get clowders => 'Klaudrid';

  @override
  String get clowdersNeutral => 'Leibkonnad';

  @override
  String get noClowdersYet =>
      'Veel pole ühtegi clowderit. Clowder on koht, kus kassid elavad — sinu hoiukodu, lapsendaja korter. Loo esimene allpool.';

  @override
  String get noClowdersYetNeutral =>
      'Veel pole ühtegi leibkonda. Leibkond on koht, kus lemmikloomad elavad — sinu kodu, hoiukodu, lapsendaja korter. Loo esimene allpool.';

  @override
  String get strays => 'Hulkuvad kassid';

  @override
  String get searchCats => 'Otsi kasse';

  @override
  String get searchCatsNeutral => 'Otsi lemmikloomi';

  @override
  String get map => 'Kaart';

  @override
  String get sync => 'Sünkroonimine';

  @override
  String get fields => 'Väljad';

  @override
  String get exportCsv => 'Ekspordi CSV';

  @override
  String get aboutAndFeedback => 'Teave ja tagasiside';

  @override
  String get settings => 'Seaded';

  @override
  String get newClowder => 'Uus klauder';

  @override
  String get newClowderNeutral => 'Uus leibkond';

  @override
  String get name => 'Nimi';

  @override
  String get cancel => 'Tühista';

  @override
  String get create => 'Loo';

  @override
  String get save => 'Salvesta';

  @override
  String get delete => 'Kustuta';

  @override
  String get merge => 'Ühenda';

  @override
  String get resolve => 'Otsusta';

  @override
  String get open => 'Ava';

  @override
  String csvSavedTo(String path) {
    return 'CSV salvestatud: $path';
  }

  @override
  String get renameClowder => 'Nimeta klauder ümber';

  @override
  String get renameClowderNeutral => 'Nimeta leibkond ümber';

  @override
  String get rename => 'Nimeta ümber';

  @override
  String get timeline => 'Ajajoon';

  @override
  String get mergeInto => 'Ühenda…';

  @override
  String get deleteClowder => 'Kustuta klauder';

  @override
  String get deleteClowderNeutral => 'Kustuta leibkond';

  @override
  String get cats => 'Kassid';

  @override
  String get catsNeutral => 'Lemmikloomad';

  @override
  String get addCat => 'Lisa kass';

  @override
  String get addCatNeutral => 'Lisa lemmikloom';

  @override
  String get newCat => 'Uus kass';

  @override
  String get newCatNeutral => 'Uus lemmikloom';

  @override
  String deleteQuestion(String name) {
    return 'Kustutada $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Klauder kaob loendist.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Leibkond kaob loendist.';

  @override
  String deleteClowderBody(int count) {
    return 'Selle $count kassi ei kustutata — neist saavad hulkujad. Kui sa seda ei soovi, liiguta nad enne teise klaudrisse.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Selle $count lemmiklooma ei kustutata — neist saavad hulkujad. Kui sa seda ei soovi, liiguta nad enne teise leibkonda.';
  }

  @override
  String get card => 'Kaart';

  @override
  String get shareAsImage => 'Jaga pildina';

  @override
  String get shareAsPdf => 'Jaga PDF-ina';

  @override
  String get print => 'Prindi';

  @override
  String cardTitle(String name) {
    return 'Kaart — $name';
  }

  @override
  String get renameCat => 'Nimeta kass ümber';

  @override
  String get renameCatNeutral => 'Nimeta lemmikloom ümber';

  @override
  String get seenHereNow => 'Nähtud siin praegu';

  @override
  String get deleteCat => 'Kustuta kass';

  @override
  String get deleteCatNeutral => 'Kustuta lemmikloom';

  @override
  String get clowderLabel => 'Klauder';

  @override
  String get clowderLabelNeutral => 'Leibkond';

  @override
  String get strayNoClowder => 'Hulkuja — klaudrita';

  @override
  String get strayNoClowderNeutral => 'Hulkuja — leibkonnata';

  @override
  String get stray => 'Hulkuja';

  @override
  String get photos => 'Fotod';

  @override
  String get addPhoto => 'Lisa foto';

  @override
  String get setAsProfileImage => 'Määra profiilipildiks';

  @override
  String get thisIsProfileImage => 'See on profiilipilt';

  @override
  String get deletePhoto => 'Kustuta foto';

  @override
  String get deletePhotoTitle => 'Kustutada foto?';

  @override
  String get deletePhotoBody =>
      'Foto andmed kustutatakse jäädavalt — seda ei saa tagasi võtta.';

  @override
  String get deleteCatBody =>
      'Kass kaob kõigist loenditest ja tema fotod eemaldatakse — siit ja pärast järgmist sünkroonimist ka teistest seadmetest.';

  @override
  String get deleteCatBodyNeutral =>
      'Lemmikloom kaob kõigist loenditest ja tema fotod eemaldatakse — siit ja pärast järgmist sünkroonimist ka teistest seadmetest.';

  @override
  String get sightingRecorded => 'Vaatlus salvestatud sinu asukohas.';

  @override
  String get noLocationAvailable =>
      'Asukoht pole saadaval — hoia selle asemel kaarti all.';

  @override
  String get locationDeniedForever =>
      'Juurdepääs asukohale on blokeeritud. Luba see süsteemi seadetes, et kasutada Stray Cami.';

  @override
  String get locationServiceOff =>
      'Asukoht on selles seadmes välja lülitatud. Lülita see seadetes sisse ja proovi uuesti.';

  @override
  String get locationDenied =>
      'cat(a)log ei tohi sinu asukohta kasutada. Proovi uuesti ja luba see, kui küsitakse.';

  @override
  String get locationNoFix =>
      'Sinu asukohta ei õnnestunud praegu määrata. Proovi uuesti õues — GPS vajab vaba vaadet taevale.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Kiibi number';

  @override
  String get starterRemarks => 'Märkused';

  @override
  String get captureFlier => 'Pildista kuulutust';

  @override
  String get addPhotosTo => 'Lisa fotod…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotot lisatud: $name';
  }

  @override
  String get scanPrintedCode => 'Skanni trükitud kood';

  @override
  String get chipScanHint =>
      'Skannib kiibikaardilt või loomaarsti paberitelt trükitud QR-/vöötkoodi — kassi sees olevat kiipi telefon lugeda ei suuda.';

  @override
  String get chipScanHintNeutral =>
      'Skannib kiibikaardilt või loomaarsti paberitelt trükitud QR-/vöötkoodi — looma sees olevat kiipi telefon lugeda ei suuda.';

  @override
  String get savingLabel => 'Salvestamine…';

  @override
  String ownerOfCat(String name) {
    return '$name omanik';
  }

  @override
  String get sortLabel => 'Sordi';

  @override
  String get viewAsTable => 'Kuva tabelina';

  @override
  String get viewAsTiles => 'Kuva paanidena';

  @override
  String get viewAsList => 'Kuva loendina';

  @override
  String get ageLabel => 'Vanus';

  @override
  String get catList => 'Kasside loend';

  @override
  String get catListNeutral => 'Lemmikloomade loend';

  @override
  String get matchCandidatesTitle => 'Võimalikud vasted';

  @override
  String get findDuplicates => 'Otsi duplikaate';

  @override
  String get noDuplicates => 'Praegu pole võimalikke duplikaate.';

  @override
  String get similarName => 'Sarnane nimi';

  @override
  String get sharePublicly => 'Jaga avalikult…';

  @override
  String get pickFramesTitle => 'Kaadrite valik';

  @override
  String get suggestedFrames => 'Soovitatud kaadrid';

  @override
  String get scrubFrames => 'Keri videot';

  @override
  String get keepThisFrame => 'Jäta see kaader alles';

  @override
  String get fromVideo => 'Videost…';

  @override
  String get videoMobileOnly =>
      'Videost kaadrite valimine töötab telefonirakenduses (Android ja iPhone) — selles seadmes veel mitte.';

  @override
  String get shareWhitelistExplainer =>
      'Vali, mis faili läheb. Kaasatakse ainult märgitud väljad.';

  @override
  String get exportShareFile => 'Ekspordi jagamisfail…';

  @override
  String get hostedLink => 'Hostitud link (üleslaaditud faili URL)';

  @override
  String get inlineQr => 'Sisseehitatud QR (ainult tekst, ilma fotodeta)';

  @override
  String get inlineTooBig =>
      'Liiga palju andmeid sisseehitatud koodi jaoks — eemalda välju või kasuta hostitud linki.';

  @override
  String get scanShareLabel => 'Skanni jagamiskoodi';

  @override
  String get notAShareCode => 'See kood pole cat(a)log jagamine.';

  @override
  String get importShareTitle => 'Kas importida see kass?';

  @override
  String get importShareTitleNeutral => 'Kas importida see lemmikloom?';

  @override
  String shareSource(String url) {
    return 'Allikas: $url';
  }

  @override
  String get importLabel => 'Impordi';

  @override
  String get strayAreaLabel => 'Võimalik uitamisala';

  @override
  String get prevPin => 'Eelmine märgis';

  @override
  String get nextPin => 'Järgmine märgis';

  @override
  String get noMissingCats => 'Veel pole kadunud kasse kuulutuse asukohtadega.';

  @override
  String get noMissingCatsNeutral =>
      'Veel pole kadunud lemmikloomi kuulutuse asukohtadega.';

  @override
  String get noMatchCandidates => 'Praegu pole võimalikke vasteid.';

  @override
  String sameIdField(String field) {
    return 'Sama $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m kaugusel';
  }

  @override
  String get addFlier => 'Lisa kuulutus';

  @override
  String get missingSinceLabel => 'Kadunud alates';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Kärbi portree';

  @override
  String get statusOwner => 'Omanik';

  @override
  String get ocrUnavailable =>
      'Tekstituvastus pole selles seadmes saadaval — sisesta kuulutuse tekst ise.';

  @override
  String get displayFormat => 'Kuvatakse kui';

  @override
  String get displayPlain => 'Lihttekst';

  @override
  String get displayQr => 'QR-kood';

  @override
  String get displayBarcode => 'Vöötkood';

  @override
  String get editLabel => 'Muuda';

  @override
  String get doneLabel => 'Valmis';

  @override
  String get openSettings => 'Ava seaded';

  @override
  String get notSaved => 'Salvestamata';

  @override
  String get birthdateInFuture => 'Sünnikuupäev ei saa olla tulevikus.';

  @override
  String get deceasedInFuture => 'Surmakuupäev ei saa olla tulevikus.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Surmakuupäev ei saa olla enne sünnikuupäeva ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Sünnikuupäev ei saa olla pärast surmakuupäeva ($date).';
  }

  @override
  String get malePregnant =>
      'See kass on kirjas isasena — isane kass ei saa olla tiine. Kontrolli esmalt sugu.';

  @override
  String get malePregnantNeutral =>
      'See lemmikloom on kirjas isasena — isane ei saa olla tiine. Kontrolli esmalt sugu.';

  @override
  String fatherNotMale(String name) {
    return '$name on kirjas emasena ega saa olla isa. Kontrolli esmalt sugu.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name on kirjas isasena ega saa olla ema. Kontrolli esmalt sugu.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name sündis $date — vanem ei saa sündida pärast oma poega.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name sündis $date — vanem ei saa sündida pärast oma poega.';
  }

  @override
  String get genderFatherFemale =>
      'See kass on kirjas teiste kasside isana — isa ei saa olla emane. Kontrolli esmalt perekonda.';

  @override
  String get genderFatherFemaleNeutral =>
      'See lemmikloom on kirjas teiste lemmikloomade isana — isa ei saa olla emane. Kontrolli esmalt perekonda.';

  @override
  String get genderMotherMale =>
      'See kass on kirjas teiste kasside emana — ema ei saa olla isane. Kontrolli esmalt perekonda.';

  @override
  String get genderMotherMaleNeutral =>
      'See lemmikloom on kirjas teiste lemmikloomade emana — ema ei saa olla isane. Kontrolli esmalt perekonda.';

  @override
  String get moveTo => 'Liiguta';

  @override
  String get noClowderStrayOption => 'Klaudrita — hulkuja / jooksis ära';

  @override
  String get noClowderStrayOptionNeutral =>
      'Leibkonnata — hulkuja / jooksis ära';

  @override
  String timelineOf(String name) {
    return 'Ajajoon — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Võta see muudatus tagasi';

  @override
  String get revertSubtitle =>
      'Taastab eelmise väärtuse uue kirjena — ajalugu säilitab mõlemad.';

  @override
  String fieldCleared(String field) {
    return '$field tühjendatud';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field tagasi väärtusele \"$value\"';
  }

  @override
  String get leftStray => 'Lahkus — hulkuja';

  @override
  String movedTo(String name) {
    return 'Liigutatud: $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat saabus';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat saabus kohast $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat läks kohta $place';
  }

  @override
  String get duplicateMergedIn => 'Duplikaat ühendatud';

  @override
  String get asOfToday => 'Tänase seisuga';

  @override
  String asOfDate(String date) {
    return 'Seisuga $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Vale vorming — kasuta $format';
  }

  @override
  String get dateInFuture => 'See kuupäev ei saa olla tulevikus.';

  @override
  String get value => 'Väärtus';

  @override
  String get latitudeLongitude => 'laius, pikkus';

  @override
  String get newField => 'Uus väli';

  @override
  String get fieldType => 'Tüüp';

  @override
  String get usedOn => 'Kasutusel';

  @override
  String get forCats => 'kassidel';

  @override
  String get forCatsNeutral => 'lemmikloomadel';

  @override
  String get forClowders => 'klaudritel';

  @override
  String get forClowdersNeutral => 'leibkondadel';

  @override
  String get forBoth => 'mõlemal';

  @override
  String get optionsOnePerLine => 'Valikud (üks rea kohta)';

  @override
  String get ownValue => 'Oma väärtus';

  @override
  String get renameField => 'Nimeta väli ümber';

  @override
  String get editOptions => 'Muuda valikuid…';

  @override
  String get noStraysRightNow => 'Praegu hulkuvaid kasse pole.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Lisa hulkuja';

  @override
  String get newStray => 'Uus hulkuja';

  @override
  String get searchByNameHint => 'Otsi kasse nime järgi…';

  @override
  String get searchByNameHintNeutral => 'Otsi lemmikloomi nime järgi…';

  @override
  String get host => 'Võõrusta';

  @override
  String get hostExplainer =>
      'Alusta siit, seejärel skanni kood või sisesta see teises seadmes.';

  @override
  String get startHosting => 'Alusta võõrustamist';

  @override
  String get stopHosting => 'Lõpeta võõrustamine';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Seansse seni: $count';
  }

  @override
  String get join => 'Liitu';

  @override
  String get addressFromHost => 'Aadress (võõrustavast seadmest)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sünkrooni kohe';

  @override
  String get addressFormatHint =>
      'Aadress peab välja nägema nagu 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sünkroonitud: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sünkroonimine ebaõnnestus: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Viimane sünkroonimine seadmega $peer: $time';
  }

  @override
  String get sharedFolder => 'Jagatud kaust';

  @override
  String get sharedFolderExplainer =>
      'Mõlemad seadmed kasutavad sama kausta (nt Dropboxis või USB-pulgal). Iga sünkroonimine paneb sinna sinu muudatused ja võtab teise poole omad.';

  @override
  String get noFolderChosenYet => 'Kausta pole veel valitud';

  @override
  String get choose => 'Vali…';

  @override
  String get syncFolderNow => 'Sünkrooni kaust kohe';

  @override
  String folderSynced(String result) {
    return 'Kaust sünkroonitud: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Kausta sünkroonimine ebaõnnestus: $error';
  }

  @override
  String get recordSightingHere => 'Salvesta vaatlus siin:';

  @override
  String trailOf(String name, int count) {
    return 'Rada: $name ($count vaatlust)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody => 'Muudetud kahes kohas korraga. Vali, mis on õige:';

  @override
  String mergeThisInto(String kind) {
    return 'Ühenda see $kind…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Pole teist ($kind), millega ühendada.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Ühendada kirjega $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Kaks kirjet saavad üheks. $name säilitab praegused väärtused; teise ajalugu liitub temaga. Seda ei saa tagasi võtta.';
  }

  @override
  String get kindCat => 'kass';

  @override
  String get kindCatNeutral => 'lemmikloom';

  @override
  String get kindClowder => 'klauder';

  @override
  String get kindClowderNeutral => 'leibkond';

  @override
  String get kindField => 'väli';

  @override
  String get takePhoto => 'Tee foto';

  @override
  String get chooseFromGallery => 'Vali galeriist';

  @override
  String get about => 'Teave';

  @override
  String get aboutTagline =>
      'Kohalik kataloog hoiukodukassidele. Sinu andmed jäävad sinu seadmetesse — ilma serverita, ilma kontota.';

  @override
  String get aboutTaglineNeutral =>
      'Kohalik kataloog lemmikloomadele, kelle eest hoolitsed. Sinu andmed jäävad sinu seadmetesse — ilma serverita, ilma kontota.';

  @override
  String versionLabel(String version, String build) {
    return 'Versioon $version ($build)';
  }

  @override
  String get sourceCode => 'Lähtekood';

  @override
  String get reportProblemOrIdea => 'Teata probleemist või ideest';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Kirjuta arendajale';

  @override
  String get buyCoffee => 'Osta arendajale kohv';

  @override
  String get coffeeSubtitle =>
      'Rakendus jääb tasuta. Isegi kui ma kohvi ei saa :)';

  @override
  String get openSourceLicenses => 'Avatud lähtekoodi litsentsid';

  @override
  String get machineTranslated =>
      'Tõlked on masintõlked — parandused on GitHubis teretulnud.';

  @override
  String get unnamed => '(nimetu)';

  @override
  String get labelName => 'Nimi';

  @override
  String get labelProfileImage => 'Profiilipilt';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Sugu';

  @override
  String get starterBreed => 'Tõug';

  @override
  String get valueMixed => 'segavereline';

  @override
  String get breedEuropeanShorthair => 'Euroopa lühikarvaline';

  @override
  String get breedMaineCoon => 'Maine kass';

  @override
  String get breedBritishShorthair => 'Briti lühikarvaline';

  @override
  String get breedNorwegianForestCat => 'Norra metskass';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siiami';

  @override
  String get breedPersian => 'Pärsia';

  @override
  String get breedBengal => 'Bengali';

  @override
  String get breedSphynx => 'Sfinks';

  @override
  String get starterColor => 'Värv';

  @override
  String get starterNeutered => 'Steriliseeritud';

  @override
  String get starterPregnant => 'Tiine';

  @override
  String get starterBirthdate => 'Sünnikuupäev';

  @override
  String get starterDeceased => 'Surnud';

  @override
  String get starterAddress => 'Aadress';

  @override
  String get starterResponsible => 'Vastutav isik';

  @override
  String get starterEmail => 'E-post';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Otsingulink';

  @override
  String lookupUrlHelp(String token) {
    return 'Teenuse leht, kus $token on numbri kohal, nt https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Otsi';

  @override
  String lookupFailed(String url) {
    return 'Ükski rakendus ei suutnud avada aadressi $url. Kopeeri link brauserisse.';
  }

  @override
  String get stepCat => 'Kass';

  @override
  String get stepCatNeutral => 'Lemmikloom';

  @override
  String get stepOwner => 'Omanik';

  @override
  String get stepFace => 'Näopilt';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Kontrolli ja salvesta';

  @override
  String get stepOwnerHint =>
      'See, kes kassi taga otsib — sellest saab tema klauder koos kuulutuse kontaktiga.';

  @override
  String get stepOwnerHintNeutral =>
      'See, kes lemmiklooma taga otsib — sellest saab tema leibkond koos kuulutuse kontaktiga.';

  @override
  String get stepFaceHint =>
      'Lõika kassi nägu kuulutuselt välja; sellest saab profiilipilt. Võid ka vahele jätta.';

  @override
  String get stepFaceHintNeutral =>
      'Lõika lemmiklooma nägu kuulutuselt välja; sellest saab profiilipilt. Võid ka vahele jätta.';

  @override
  String get stepRegistryHint =>
      'Kuulutuselt leitud numbrid. Märgitud salvestatakse kassi juurde ja neid saab hiljem avada.';

  @override
  String get stepRegistryHintNeutral =>
      'Kuulutuselt leitud numbrid. Märgitud salvestatakse lemmiklooma juurde ja neid saab hiljem avada.';

  @override
  String get noRegistryLinks =>
      'Sellel kuulutusel pole registrilinke — kui mõni jäi kahe silma vahele, teata veast.';

  @override
  String get unknownServiceHint => 'Tundmatu teenus';

  @override
  String get rememberService => 'Jäta teenus meelde';

  @override
  String get rememberServiceHint =>
      'Anna teenusele nimi ja osuta numbrile lingis. Järgmine kuulutus täidab end ise.';

  @override
  String get noIdInLink =>
      'Selles lingis pole numbrit, mida rakendus salvestada saaks.';

  @override
  String get whichNumber => 'Milline osa on number?';

  @override
  String get cropAgain => 'Lõika uuesti';

  @override
  String get noFaceYet => 'Näopilti veel pole — kasutatakse kuulutuse pilti.';

  @override
  String get backLabel => 'Tagasi';

  @override
  String get dangerButton => 'ÄRA VAJUTA.\nOHTLIK';

  @override
  String get dangerThanks => 'Aitäh, et kasutad cat(a)logi!';

  @override
  String get helpTitle => 'Abi';

  @override
  String get showTipsAgain => 'Näita nõuandeid uuesti';

  @override
  String get helpHome =>
      'Sinu kolooniate ülevaade — koloonia on koht, kus kassid elavad: sinu kodu, hoiukodu, varjupaik. Puuduta kaarti, et näha selle kasse; pikk vajutus avab menüü. Nupp all paremal loob koloonia ja hulkurite kaart koondab kõik kodutud kassid. Nimi ülal on kataloog, milles oled — puuduta, et vahetada või uus lisada.';

  @override
  String get helpHomeNeutral =>
      'Sinu leibkondade ülevaade — leibkond on koht, kus lemmikloomad elavad: sinu kodu, hoiukodu, varjupaik. Puuduta kaarti, et näha selle lemmikloomi; pikk vajutus avab menüü. Nupp all paremal loob leibkonna ja hulkurite kaart koondab kõik kodutud lemmikloomad. Nimi ülal on kataloog, milles oled — puuduta, et vahetada või uus lisada.';

  @override
  String get helpClowder =>
      'Kõik selle koha kohta: kassid, väljad (aadress, kontakt, tüüp) ja ajalugu. Leht avaneb ainult lugemiseks; pliiats lülitab muutmise sisse, kus saab ka uue välja lisada. Välja pikk vajutus muudab seda kohe, kassi oma liigutab, peidab või avab. Siia lisatud kohtumine võib kaasa võtta mitu koloonia kassi, näiteks steriliseerimisele: märgi kaasa tulevad kassid, lõpeta üks kord, eemalda märge ravimata jäänutelt. Kell välja juures avab selle ajaloo.';

  @override
  String get helpClowderNeutral =>
      'Kõik selle koha kohta: lemmikloomad, väljad (aadress, kontakt, tüüp) ja ajalugu. Leht avaneb ainult lugemiseks; pliiats lülitab muutmise sisse, kus saab ka uue välja lisada. Välja pikk vajutus muudab seda kohe, lemmiklooma oma liigutab, peidab või avab. Siia lisatud kohtumine võib kaasa võtta mitu leibkonna lemmiklooma, näiteks steriliseerimisele: märgi kaasa tulevad lemmikloomad, lõpeta üks kord, eemalda märge ravimata jäänutelt. Kell välja juures avab selle ajaloo.';

  @override
  String get helpCat =>
      'Kõik selle kassi kohta: fotod, väljad, perekond, ajalugu. Leht on kirjutuskaitstud, kuni puudutad pliiatsit. Hoia välja all, et seda kohe muuta; hoia fotot all selle menüü jaoks. Menüü üleval paremal hoiab ülejäänut: peida, liida, märgi nägemine, jaga kassi. „Privaatne“ määratakse välja muutmisel. Kell välja juures avab selle ajaloo.';

  @override
  String get helpCatNeutral =>
      'Kõik selle lemmiklooma kohta: fotod, väljad, perekond, ajalugu. Leht on kirjutuskaitstud, kuni puudutad pliiatsit. Hoia välja all, et seda kohe muuta; hoia fotot all selle menüü jaoks. Menüü üleval paremal hoiab ülejäänut: peida, liida, märgi nägemine, jaga lemmiklooma. „Privaatne“ määratakse välja muutmisel. Kell välja juures avab selle ajaloo.';

  @override
  String get helpStrays =>
      'Kassid, kellel praegu kodu pole: leitud, plehku pannud või kuulutuselt. Kaamera nupp salvestab kassi sinu ees; kuulutuse nupp teeb kadunud-kuulutusest kassi koos omaniku kontaktiga; skanner loeb kuulutuselt cat(a)log koodi. Puuduta Stray Cami foto jaoks; hoia all, et filmida video ja jätta parimad kaadrid fotodeks.';

  @override
  String get helpStraysNeutral =>
      'Lemmikloomad, kellel praegu kodu pole: leitud, plehku pannud või kuulutuselt. Kaamera nupp salvestab looma sinu ees; kuulutuse nupp teeb kadunud-kuulutusest lemmiklooma koos omaniku kontaktiga; skanner loeb kuulutuselt cat(a)log koodi. Puuduta Stray Cami foto jaoks; hoia all, et filmida video ja jätta parimad kaadrid fotodeks.';

  @override
  String get helpMap =>
      'Kõik kassid ja kohad, millel on asukoht. Otsing leiab kassid, inimesed ja kohad — tundmatut nime otsitakse kogu maailmast. Kihtide nupp joonistab 500 m ringid kadunud kassi kuulutuste kohtade ja tema endise kodu ümber. Nooled liiguvad nõelalt nõelale, kaardi pikk vajutus kirjutab nägemise.';

  @override
  String get helpMapNeutral =>
      'Kõik lemmikloomad ja kohad, millel on asukoht. Otsing leiab lemmikloomad, inimesed ja kohad — tundmatut nime otsitakse kogu maailmast. Kihtide nupp joonistab 500 m ringid kadunud lemmiklooma kuulutuste kohtade ja tema endise kodu ümber. Nooled liiguvad nõelalt nõelale, kaardi pikk vajutus kirjutab nägemise.';

  @override
  String get helpCard =>
      'Kassi prinditav kaart: vali üleval kiipidega, mis sellel on, seejärel jaga seda pildi või PDF-ina. Numbreid saab printida QR- või vöötkoodina ja asukohast saab QR, mis avab kaardi, pluss lühike Plus Code.';

  @override
  String get helpCardNeutral =>
      'Lemmiklooma prinditav kaart: vali üleval kiipidega, mis sellel on, seejärel jaga seda pildi või PDF-ina. Numbreid saab printida QR- või vöötkoodina ja asukohast saab QR, mis avab kaardi, pluss lühike Plus Code.';

  @override
  String get helpSync =>
      'Kuidas andmed teisteni jõuavad: ühendu otse, kasuta kausta, mida mõlemad seadmed näevad, või saada fail sõnumirakendusega. Alati sina otsustad, mis välja läheb — ja saadud .catsync failid avanevad samuti siin.';

  @override
  String get helpFields =>
      'Väljad, mida sinu kataloog kasutab. Nimeta neid ümber, muuda valikvälja valikuid või lisa omi. Tunnusväli võib osutada teenusele (registrile), siis saab numbrit kassi juures puudutada.';

  @override
  String get helpFieldsNeutral =>
      'Väljad, mida sinu kataloog kasutab. Nimeta neid ümber, muuda valikvälja valikuid või lisa omi. Tunnusväli võib osutada teenusele (registrile), siis saab numbrit lemmiklooma juures puudutada.';

  @override
  String get helpTimeline =>
      'Iga kunagi tehtud muudatus, uusim ees: kes mida, millal ja millisele väärtusele muutis. Iga kirje saab tagasi võtta — see kirjutab uue kirje, midagi ei kustutata kunagi.';

  @override
  String get helpDuplicates =>
      'Kassid või kolooniad, mis tunduvad kaks korda olemas — samad numbrid või väga sarnased nimed sobivate üksikasjadega. Puuduta paari, et need ühendada; ühendamist ei saa tagasi võtta, seepärast küsitakse enne.';

  @override
  String get helpDuplicatesNeutral =>
      'Lemmikloomad või leibkonnad, mis tunduvad kaks korda olemas — samad numbrid või väga sarnased nimed sobivate üksikasjadega. Puuduta paari, et need ühendada; ühendamist ei saa tagasi võtta, seepärast küsitakse enne.';

  @override
  String get helpMatches =>
      'Kassid, kes võivad olla sama loom: sama number või hulkur, keda nähti kadunud kassi otsingualal. Puuduta paari ühendamiseks, pikk vajutus avab võrdluseks esimese kassi.';

  @override
  String get helpMatchesNeutral =>
      'Lemmikloomad, kes võivad olla sama loom: sama number või hulkur, keda nähti kadunud lemmiklooma otsingualal. Puuduta paari ühendamiseks, pikk vajutus avab võrdluseks esimese lemmiklooma.';

  @override
  String get helpFlier =>
      'Pildistatud kuulutusest saab kass koos omanikuga. Samm-sammult: kassi andmed, omaniku kontakt, näo lõikamine profiilipildiks, registrinumbrid kuulutuselt ja lõpuks kontroll. Kõik on ettepanekud — paranda see, mille kaamera valesti luges.';

  @override
  String get helpFlierNeutral =>
      'Pildistatud kuulutusest saab lemmikloom koos omanikuga. Samm-sammult: lemmiklooma andmed, omaniku kontakt, näo lõikamine profiilipildiks, registrinumbrid kuulutuselt ja lõpuks kontroll. Kõik on ettepanekud — paranda see, mille kaamera valesti luges.';

  @override
  String get archiveTitle => 'Arhiiv';

  @override
  String get archiveExplainer =>
      'Surnud kassid ja tühjad koloniad, mida keegi pole aastaid puutunud, võtavad ikka ruumi — eriti nende pildid. Arhiveerimine kirjutab need faili, mille sa alles hoiad, ja kustutab siis siit.';

  @override
  String get archiveExplainerNeutral =>
      'Surnud lemmikloomad ja tühjad leibkonnad, mida keegi pole aastaid puutunud, võtavad ikka ruumi — eriti nende pildid. Arhiveerimine kirjutab need faili, mille sa alles hoiad, ja kustutab siis siit.';

  @override
  String get archiveAction => 'Arhiveeri';

  @override
  String archiveSelected(int count) {
    return 'Arhiveeri $count kirjet';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Kas arhiveerida $count kirjet?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names kirjutatakse faili ja seejärel kustutatakse — sinu seadmest ja igast seadmest, millega sünkroonid. Faili importimine toob kõik tagasi; ilma selleta on need läinud.';
  }

  @override
  String archiveDone(int count) {
    return 'Arhiveeritud ja kustutatud $count kirjet';
  }

  @override
  String archiveFailed(String error) {
    return 'Midagi ei kustutatud: arhiivifaili ei õnnestunud kirjutada ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Andmebaas $db, pildid $photos $count failis';
  }

  @override
  String quietForYears(int years) {
    return 'Muutumatu $years aastat';
  }

  @override
  String get nothingToArchive => 'Midagi pole arhiveerimiseks piisavalt vana.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Viimane muudatus $date · pildid $size';
  }

  @override
  String get helpArchive =>
      'Vanad andmed maksavad ruumi, eelkõige pildid, mida iga sünkroonitud seade kaasas kannab. Siin valid surnud kassid ja tühjad koloniad, mis on aastaid vaikinud, kirjutad need faili, mille alles hoiad, ja kustutad. Kustutamine jõuab kõigini, kellega sünkroonid; faili import taastab kõik.';

  @override
  String get helpArchiveNeutral =>
      'Vanad andmed maksavad ruumi, eelkõige pildid, mida iga sünkroonitud seade kaasas kannab. Siin valid surnud lemmikloomad ja tühjad leibkonnad, mis on aastaid vaikinud, kirjutad need faili, mille alles hoiad, ja kustutad. Kustutamine jõuab kõigini, kellega sünkroonid; faili import taastab kõik.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Kas taastada $count kustutatud kirjet?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names on selles kataloogis kustutatud ja äsja imporditud fail sisaldab neid. Taastamine toob need tagasi siia ja igasse seadmesse, millega sünkroonid.';
  }

  @override
  String get restoreAction => 'Taasta';

  @override
  String get keepDeleted => 'Jäta kustutatuks';

  @override
  String get archiveNotSaved =>
      'Midagi ei kustutatud: arhiivi ei salvestatud kuhugi.';

  @override
  String get locateAddress => 'Otsi aadress kaardilt';

  @override
  String get addressFoundTitle => 'Aadress leitud';

  @override
  String get replaceAddressOption => 'Asenda aadress sellega';

  @override
  String get addPositionOption => 'Salvesta asukoht';

  @override
  String get addressLocated => 'Aadress leitud';

  @override
  String get addressNotFound =>
      'Selle aadressi jaoks kohta ei leitud. Kontrolli kirjapilti või jäta tühjaks.';

  @override
  String get starterPosition => 'Asukoht';

  @override
  String get valueYes => 'jah';

  @override
  String get valueNo => 'ei';

  @override
  String get valueFemale => 'emane';

  @override
  String get valueMale => 'isane';

  @override
  String get valueUnknown => 'teadmata';

  @override
  String get cropTitle => 'Kärbi fotot';

  @override
  String get markTitle => 'Märgi kass';

  @override
  String get markTitleNeutral => 'Märgi lemmikloom';

  @override
  String get applyCrop => 'Kärbi';

  @override
  String get useFullPhoto => 'Kasuta tervet fotot';

  @override
  String get dragToSelect => 'Lohista ristkülik kassi ümber';

  @override
  String get dragToSelectNeutral => 'Lohista ristkülik lemmiklooma ümber';

  @override
  String get dragOverTheCat => 'Lohista ellips kassi peale';

  @override
  String get dragOverTheCatNeutral => 'Lohista ellips lemmiklooma peale';

  @override
  String get cropPhoto => 'Kärbi…';

  @override
  String get markPhoto => 'Märgi…';

  @override
  String get scanCode => 'Skanni kood';

  @override
  String get orTypeCode => 'Või sisesta kood';

  @override
  String get copyCode => 'Kopeeri kood';

  @override
  String get copied => 'Kopeeritud';

  @override
  String get invalidCode => 'See kood ei kehti';

  @override
  String get hotspotHint =>
      'Ühist Wi-Fit pole? Lülita ühe telefoni kuumkoht sisse, ühenda teine ja majuta siin.';

  @override
  String get byMessenger => 'Sõnumirakendusega';

  @override
  String get byMessengerExplainer =>
      'Saada kogu kataloog ühe failina WhatsAppi, Signali või e-postiga — teine pool impordib selle.';

  @override
  String get shareBundle => 'Jaga sünkroonimispaketti…';

  @override
  String get importBundle => 'Impordi sünkroonimispakett…';

  @override
  String bundleImported(String result) {
    return 'Pakett imporditud: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Viimane automaatne varundus ebaõnnestus: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import ebaõnnestus: $error';
  }

  @override
  String get pickOnMap => 'Vali kaardilt';

  @override
  String get useMyLocation => 'Kasuta minu asukohta';

  @override
  String get language => 'Keel';

  @override
  String get typeUnitValue => 'Ühikuga väärtus';

  @override
  String get dimension => 'Suurus';

  @override
  String get dimensionWeight => 'Kaal';

  @override
  String get dimensionLength => 'Pikkus';

  @override
  String get dimensionVolume => 'Maht';

  @override
  String get dimensionTemperature => 'Temperatuur';

  @override
  String get unitsLabel => 'Ühikud';

  @override
  String get catalogHolds => 'See kataloog sisaldab';

  @override
  String get modeCats => 'Kassid';

  @override
  String get modePets => 'Lemmikloomad';

  @override
  String get graphLabel => 'Graafik';

  @override
  String get fieldHistoryTooltip => 'Ajalugu';

  @override
  String get rangeWeek => 'Nädal';

  @override
  String get rangeMonth => 'Kuu';

  @override
  String get rangeYear => 'Aasta';

  @override
  String get rangeAll => 'Kõik';

  @override
  String get rangeCustom => 'Kohandatud…';

  @override
  String changeSince(String delta, String date) {
    return '$delta alates $date';
  }

  @override
  String get unitsAuto => 'Nagu sinu piirkonnas';

  @override
  String get unitsMetric => 'Meetriline (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Inglise (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Kaal';

  @override
  String get systemDefault => 'Süsteemi vaikimisi';

  @override
  String get iosLocalNetworkHint =>
      'Kui iPhone\'is/iPadis endiselt ebaõnnestub: Seaded → Privaatsus ja turvalisus → Kohalik võrk → luba cat(a)log ja proovi uuesti.';

  @override
  String get includePrivate => 'Jaga privaatseid andmeid';

  @override
  String get hideLabel => 'Peida selles seadmes';

  @override
  String get unhideLabel => 'Näita uuesti';

  @override
  String get showHiddenLabel => 'Näita peidetuid';

  @override
  String get stopShowingHidden => 'Lõpeta peidetute näitamine';

  @override
  String get starterSpecies => 'Liik';

  @override
  String get starterStatus => 'Tüüp';

  @override
  String get statusFoster => 'Hoiukodu';

  @override
  String get statusForeverHome => 'Kodu';

  @override
  String get statusClinic => 'Kliinik';

  @override
  String get statusShelter => 'Varjupaik';

  @override
  String get statusBarn => 'Küün';

  @override
  String get valueCat => 'Kass';

  @override
  String get valueDog => 'Koer';

  @override
  String get valueRabbit => 'Küülik';

  @override
  String get valueGuineaPig => 'Merisiga';

  @override
  String get valueHamster => 'Hamster';

  @override
  String get valueBird => 'Lind';

  @override
  String get valueHorse => 'Hobune';

  @override
  String get valueTortoise => 'Kilpkonn';

  @override
  String get valueFerret => 'Tuhkur';

  @override
  String get otherOption => 'Muu…';

  @override
  String get celebrationsToggle => 'Tähista lapsendamisi';

  @override
  String get celebrationsSubtitle => 'Konfetid ja hõisked, kui kass kolib koju';

  @override
  String get celebrationsSubtitleNeutral =>
      'Konfetid ja hõisked, kui lemmikloom kolib koju';

  @override
  String get onMapLabel => 'Kaardil';

  @override
  String get showOnMap => 'Näita kaardil';

  @override
  String get searchPlaceHint => 'Otsi kohta või aadressi';

  @override
  String get noPlacesFound => 'Kohti ei leitud';

  @override
  String get mapSearchHint => 'Otsi kasse, rühmi, inimesi';

  @override
  String get mapSearchHintNeutral => 'Otsi lemmikloomi, leibkondi, inimesi';

  @override
  String get proposeAnotherName => 'Paku teine nimi';

  @override
  String get moderationTitle => 'Autorid ja keelud';

  @override
  String get moderationSubtitle => 'Eemalda inimese andmed jäädavalt';

  @override
  String get authorsSection => 'Kes on kataloogi kirjutanud';

  @override
  String get hardDeleteAction => 'Kustuta kõik sellelt autorilt';

  @override
  String hardDeleteWarning(Object name) {
    return 'Eemaldab kõik $name kirjed ja fotod sellest seadmest. Teised seadmed hoiavad omad alles. Ei saa tagasi võtta.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Kinnitamiseks kirjuta $name';
  }

  @override
  String get alsoBan => 'Keela ka — ära võta enam kunagi andmeid vastu';

  @override
  String get bansSection => 'Keelud';

  @override
  String get unbanAction => 'Eemalda keeld';

  @override
  String get deletedDone => 'Kustutatud.';

  @override
  String get syncSummaryTitle => 'Mis saabus';

  @override
  String get summaryAdopted => 'Lapsendatud';

  @override
  String get summaryDeceased => 'Surnud';

  @override
  String get summaryEscaped => 'Põgenenud';

  @override
  String get summaryNew => 'Uued';

  @override
  String get summaryConflicts => 'Lahendamist vajavad konfliktid';

  @override
  String conflictsMenu(int n) {
    return 'Konfliktid ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Lahendasid siin konflikti, seega Lükka tagasi ei ole saadaval: see võtaks ka selle tagasi.';

  @override
  String get arrivalIntro =>
      'Need muudatused on juba su kataloogis. Lükka tagasi taastab selle endisel kujul.';

  @override
  String get summaryUpdated => 'Muudetud';

  @override
  String get summaryDeleted => 'Kustutatud';

  @override
  String get keepMine => 'Jäta minu oma';

  @override
  String keptMine(String name) {
    return 'Sinu versioon kirjest $name jääb sellesse seadmesse.';
  }

  @override
  String get summaryMeta => 'Saabus ka';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n muudatust',
      one: '1 muudatus',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Nõustu';

  @override
  String get rejectArrival => 'Lükka tagasi';

  @override
  String get photoAdded => 'Foto lisatud';

  @override
  String get photoRemoved => 'Foto eemaldatud';

  @override
  String metaFieldAdded(String name) {
    return 'Uus väli: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Väli muudetud: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser ühendatud kirjega $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n fotot',
      one: '1 foto',
    );
    return '$_temp0';
  }

  @override
  String get starterMother => 'Ema';

  @override
  String get starterFather => 'Isa';

  @override
  String get familySection => 'Perekond';

  @override
  String get littermatesLabel => 'Pesakonnakaaslased';

  @override
  String get siblingsLabel => 'Õed-vennad';

  @override
  String get kittensLabel => 'Kassipojad';

  @override
  String get kittensLabelNeutral => 'Pojad';

  @override
  String get toastSettingsTitle => 'Millest teatada';

  @override
  String get toastSettingsSubtitle => 'Väikesed teated pärast sünkroonimist';

  @override
  String get toastKindAdoptions => 'Lapsendamised';

  @override
  String get toastKindBirths => 'Sünnid';

  @override
  String get toastKindDeaths => 'Surmad';

  @override
  String get toastKindEscapes => 'Põgenemised';

  @override
  String get toastKindMoves => 'Kolimised';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat lapsendati perre $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Uus kassipoeg: $cat ✨';
  }

  @override
  String toastBornNeutral(Object cat) {
    return '✨ Vastsündinu: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat on surnud';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat on põgenenud';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat kolis: $home';
  }

  @override
  String get notACatlogFile => 'See pole cat(a)logi fail';

  @override
  String get nothingNewInBundle =>
      'Failis pole midagi uut — sul on kõik olemas';

  @override
  String get syncChooserInPerson => 'Kohapeal';

  @override
  String get syncChooserInPersonSub => 'Sünkroonimine Wi-Fi kaudu';

  @override
  String get syncChooserRemote => 'Eemalt';

  @override
  String get syncChooserRemoteSub => 'Sünkroonimine kausta või USB-pulga kaudu';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Eksport ja import sotsiaalmeedia kaudu';

  @override
  String get connectToWifiFirst =>
      'Ühendu kõigepealt Wi-Fi-ga — siis seadmed leiavad teineteise';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) soovib sünkroonida';
  }

  @override
  String get trustBothWaysNote => 'Kataloogid vahetatakse mõlemas suunas.';

  @override
  String get allowOnce => 'Luba';

  @override
  String get allowAlways => 'Luba see seade alati';

  @override
  String get declineAction => 'Keeldu';

  @override
  String get syncDeclined => 'Teine seade keeldus sünkroonimisest';

  @override
  String get trustedDevicesSection => 'Alati lubatud seadmed';

  @override
  String get removeTrust => 'Eemalda';

  @override
  String get hostWithoutWifi => 'Majuta ilma Wi-Fi-ta';

  @override
  String get hotspotJoinNote =>
      'Loob ajutise otseühenduse teise telefoniga (ilma internetita). Ainult cat(a)log kasutab seda ja see katkeb pärast sünkroonimist ise.';

  @override
  String get hotspotAndroidOnly =>
      'See kood vajab kahte Androidi telefoni — iPhone\'is/iPadis kasuta ühist Wi-Fi-t';

  @override
  String get selectClowderHint => 'Vali vasakult clowder';

  @override
  String get selectClowderHintNeutral => 'Vali vasakult leibkond';

  @override
  String get introTitle1 => 'Sinu kassid, korras';

  @override
  String get introTitle1Neutral => 'Sinu lemmikloomad, korras';

  @override
  String get introBody1 =>
      'Loo igale kassile kaart: foto, sugu, tervis, kõik mida tahad kirja panna. Kassid on rühmitatud elukoha järgi — äpp nimetab seda kohta kolooniaks (clowder).';

  @override
  String get introBody1Neutral =>
      'Loo igale lemmikloomale, kelle eest hoolitsed, kaart: foto, sugu, tervis, kõik mida tahad kirja panna. Lemmikloomad on rühmitatud elukoha järgi — äpp nimetab seda kohta leibkonnaks.';

  @override
  String get introTitle2 => 'Töötab ilma internetita';

  @override
  String get introBody2 =>
      'Kõik salvestub ainult sinu telefoni. Kontot pole, pilve pole. Midagi ei saadeta, kui sa ise ei jaga.';

  @override
  String get introTitle3 => 'Töötage koos';

  @override
  String get introBody3 =>
      'Igaüks kasutab oma äppi ja aeg-ajalt vahetate andmeid: saage kokku ja skannige kood, kasutage jagatud kausta või saatke üks fail sõnumirakendusega. Pärast on kõigil sama info.';

  @override
  String get introSkip => 'Jäta vahele';

  @override
  String get introNext => 'Edasi';

  @override
  String get introDone => 'Alustame';

  @override
  String get introReplayTitle => 'Kiire tutvustus';

  @override
  String get spotHomeSync =>
      'Siin sünkroonid oma tuttavatega. Sina otsustad, mida jagad.';

  @override
  String get spotHomeStrays =>
      'See kaart kogub kõik hulkujad — kodutud kassid. Puuduta loendi nägemiseks.';

  @override
  String get spotHomeStraysNeutral =>
      'See kaart kogub kõik hulkujad — kodutud lemmikloomad. Puuduta loendi nägemiseks.';

  @override
  String get spotHomeMenu =>
      'Selles menüüs: seaded, duplikaatide leidmine ja ühendamine, CSV eksport ja muud.';

  @override
  String get spotCatEdit =>
      'Puuduta pliiatsit, et kassi muuta. Vihje: hoia välja all, et seda otse muuta.';

  @override
  String get spotCatEditNeutral =>
      'Puuduta pliiatsit, et lemmiklooma muuta. Vihje: hoia välja all, et seda otse muuta.';

  @override
  String get spotMapLayers =>
      'Otsid kadunud kassi? Näita ringe tema kuulutuste kohtade ja tema endise kodu ümber.';

  @override
  String get spotMapLayersNeutral =>
      'Otsid kadunud lemmiklooma? Näita ringe tema kuulutuste kohtade ja tema endise kodu ümber.';

  @override
  String get spotStraysFlier =>
      'Leidsid kadunud kassi kuulutuse? Pildista see siin — äpp salvestab kassi ja kontakti sinu eest.';

  @override
  String get spotStraysFlierNeutral =>
      'Leidsid kadunud lemmiklooma kuulutuse? Pildista see siin — äpp salvestab lemmiklooma ja kontakti sinu eest.';

  @override
  String get spotStraysScan =>
      'Mõnel kuulutusel on cat(a)log QR-kood. Skanni see siin ja impordi kass ilma tippimata.';

  @override
  String get spotStraysScanNeutral =>
      'Mõnel kuulutusel on cat(a)log QR-kood. Skanni see siin ja impordi lemmikloom ilma tippimata.';

  @override
  String get introTitle4 => 'Leia kadunud kassid';

  @override
  String get introTitle4Neutral => 'Leia kadunud lemmikloomad';

  @override
  String get introBody4 =>
      'Näed kadunud kassi kuulutust? Pildista see äpis: salvestatakse kass, omaniku kontakt ja koht. Kui hiljem ilmub sarnane hulkuja, pakub äpp võimalikke vasteid.';

  @override
  String get introBody4Neutral =>
      'Näed kadunud lemmiklooma kuulutust? Pildista see äpis: salvestatakse lemmikloom, omaniku kontakt ja koht. Kui hiljem ilmub sarnane hulkuja, pakub äpp võimalikke vasteid.';

  @override
  String get spotMapSearch =>
      'Sisesta kass, koht või inimene, et kaardil sinna hüpata.';

  @override
  String get spotMapSearchNeutral =>
      'Sisesta lemmikloom, koht või inimene, et kaardil sinna hüpata.';

  @override
  String get spotCardChips =>
      'Märgi, mis peaks jagataval kaardil olema — ülejäänu jääb sellelt välja.';

  @override
  String get spotCatMenu =>
      'Siin on veel toiminguid: peida kass, liida duplikaadid või märgi nägemine.';

  @override
  String get spotCatMenuNeutral =>
      'Siin on veel toiminguid: peida lemmikloom, liida duplikaadid või märgi nägemine.';

  @override
  String get spotDone => 'Selge';

  @override
  String get spotReplayTitle => 'Uuenduste tuur';

  @override
  String get spotReplaySubtitle => 'Näita vihjeid igal lehel uuesti';

  @override
  String get spotReplayDone => 'Vihjed kuvatakse uuesti';

  @override
  String get searchNoResults => 'Selle nimega kassi ei leitud';

  @override
  String get searchNoResultsNeutral => 'Selle nimega lemmiklooma ei leitud';

  @override
  String get syncUnreachable =>
      'Teist seadet ei õnnestunud kätte saada. Kas mõlemad on samas Wi-Fi võrgus?';

  @override
  String get folderUnreachable =>
      'Kausta ei õnnestunud kätte saada. Kas ketas või pilvekaust on veel olemas?';

  @override
  String get crashTitle => 'Seda poleks tohtinud juhtuda';

  @override
  String get crashBody =>
      'cat(a)log sattus ootamatule veale. Sinu andmed on kaitstud — kõik salvestatakse muutmise hetkel. Taaskäivita rakendus ja kui see kordub, saada raport, et saaks parandada.';

  @override
  String get crashRestart => 'Taaskäivita rakendus';

  @override
  String get crashSendReport => 'Saada raport arendajale';

  @override
  String get crashLastRunBody =>
      'cat(a)log peatus eelmisel korral ootamatult — tõenäoliselt sai mälu otsa. Kas saata lühike raport, et saaks parandada?';

  @override
  String get catalogsTitle => 'Kataloogid';

  @override
  String get newCatalog => 'Uus kataloog';

  @override
  String get intoCatalog => 'Kataloogi';

  @override
  String get catalogNameLabel => 'Kataloogi nimi';

  @override
  String catalogNameTaken(String name) {
    return 'Kataloog nimega $name on juba olemas. Vali teine nimi.';
  }

  @override
  String get manageCatalogs => 'Halda katalooge';

  @override
  String get helpCatalogs =>
      'Kataloog on omaette maailm: omad kassid, kolooniad, väljad, fotod ja sünkroonimispartnerid. Berliin ja Pariis ei segune kunagi. Puuduta kataloogi, et sellele lülituda. Kataloogi hammasratas avab selle seaded: nimi, kassid või lemmikloomad, väljad, autorid ja keelud, arhiiv, tagasiminek, kustutamine. Su nimi, keel ja juba nähtud nõuanded on kõigil ühised.';

  @override
  String get helpCatalogsNeutral =>
      'Kataloog on omaette maailm: omad lemmikloomad, majapidamised, väljad, fotod ja sünkroonimispartnerid. Berliin ja Pariis ei segune kunagi. Puuduta kataloogi, et sellele lülituda. Kataloogi hammasratas avab selle seaded: nimi, kassid või lemmikloomad, väljad, autorid ja keelud, arhiiv, tagasiminek, kustutamine. Su nimi, keel ja juba nähtud nõuanded on kõigil ühised.';

  @override
  String get helpCatalogSettings =>
      'Kõik, mis kuulub ainult sellele kataloogile: nimi, kas seal on kassid või lemmikloomad, väljad, autorid ja keelud, arhiiv ning ajas tagasiminek. Siinsed muudatused puudutavad ainult seda kataloogi — ka sellist, milles sa praegu ei ole. Kustutamine kirjutab kataloogi enne faili.';

  @override
  String get spotHomeCatalog =>
      'See on kataloog, milles oled. Puuduta nime, et vahetada või uus luua.';

  @override
  String get deleteCatalog => 'Kustuta kataloog';

  @override
  String get catalogSettings => 'Kataloogi seaded';

  @override
  String deleteCatalogBody(String name) {
    return 'Kõik kataloogis $name kaob: kassid, fotod, ajalugu. Enne salvestatakse täielik fail sinna, kuhu lähevad automaatsed varukoopiad — selle importimine toob kataloogi tagasi. Kinnitamiseks kirjuta näidatud sõna.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Kõik kataloogis $name kaob: lemmikloomad, fotod, ajalugu. Enne salvestatakse täielik fail sinna, kuhu lähevad automaatsed varukoopiad — selle importimine toob kataloogi tagasi. Kinnitamiseks kirjuta nimi.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name kustutatud. Fail on kaustas $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Kirjuta $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Midagi ei kustutatud: kataloogifaili ei õnnestunud kirjutada ($error). Vabasta ruumi või proovi hiljem uuesti.';
  }

  @override
  String get moveToCatalog => 'Teisalda teise kataloogi';

  @override
  String movedToCatalog(int count, String name) {
    return '$count teisaldatud kataloogi $name';
  }

  @override
  String get chooseWhatToMove => 'Mis liigub kaasa?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Kas liigutada midagi kataloogi $name?';
  }

  @override
  String get undoThisImport => 'Võta see import tagasi';

  @override
  String undoImportBody(int count) {
    return 'Selle impordi toodud $count muudatust eemaldatakse. Enne kirjutatakse need faili, mille import toob need tagasi. Need, kellega juba sünkroonisid, säilitavad oma koopia — seda ei saa tagasi võtta.';
  }

  @override
  String undoneImport(String where) {
    return 'Tagasi võetud. Fail on $where.';
  }

  @override
  String get goBackTitle => 'Mine tagasi';

  @override
  String get goBackToHere => 'Mine siia tagasi';

  @override
  String get momentImport => 'Enne importimist';

  @override
  String get momentSync => 'Enne sünkroonimist';

  @override
  String get momentMerge => 'Enne ühendamist';

  @override
  String get momentHardDelete => 'Enne ühe autori andmete kustutamist';

  @override
  String get momentArchive => 'Enne arhiveerimist';

  @override
  String get momentManual => 'Sinu märgitud';

  @override
  String get showOlderMoments => 'Näita vanemaid';

  @override
  String goBackBody(int count) {
    return 'Kõik pärast seda hetke eemaldatakse — $count muudatust. Enne kirjutatakse see faili, mille import toob kõik tagasi, ja iga uuem hetk kaob koos sellega. Need, kellega juba sünkroonisid, säilitavad koopia — seda ei saa tagasi võtta.';
  }

  @override
  String get nameThisMoment => 'Anna sellele hetkele nimi';

  @override
  String get helpGoBack =>
      'Hetked, mil see kataloog kuju muutis: enne iga importi ja iga sünkroonimist, enne ühendamist, arhiveerimist või kustutamist ning alati, kui ise hetke märkisid. Ühe valimine viib kataloogi sellesse olekusse tagasi — kõik pärast seda kirjutatakse faili, mille sa endale jätad, ja seejärel eemaldatakse; iga uuem hetk läheb kaasa. Need, kellega juba sünkroonisid, säilitavad saadu.';

  @override
  String goBackFileFailed(String error) {
    return 'Midagi ei eemaldatud: faili, mis selle alles hoiab, ei õnnestunud kirjutada ($error). Vabasta ruumi ja proovi uuesti.';
  }

  @override
  String get goBackChanged =>
      'Midagi ei eemaldatud: kataloog muutus faili salvestamise ajal. Proovi uuesti.';

  @override
  String get switchBeforeDeleting =>
      'See on kataloog, milles oled. Vaheta teisele ja kustuta see siis.';

  @override
  String shareFileFailed(String error) {
    return 'Jagamisfaili ei õnnestunud kirjutada ($error). Vabasta ruumi ja proovi uuesti.';
  }

  @override
  String get privateLabel => 'Privaatne';

  @override
  String sharedCatalogIs(String name) {
    return 'Kataloog: $name';
  }

  @override
  String get markPrivate => 'Märgi privaatseks';

  @override
  String get unmarkPrivate => 'Eemalda privaatsuse märge';

  @override
  String get agenda => 'Meeldetuletused';

  @override
  String get reminderLabel => 'Meeldetuletus';

  @override
  String get agendaEmpty =>
      'Visiite pole plaanitud. Uusi plaanid siin plussiga või kassi või klauderi lehel.';

  @override
  String get agendaEmptyNeutral =>
      'Visiite pole plaanitud. Uusi plaanid siin plussiga või lemmiklooma või leibkonna lehel.';

  @override
  String get dueToday => 'täna';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päeva pärast',
      one: '1 päeva pärast',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päeva üle tähtaja',
      one: '1 päev üle tähtaja',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Tehtud';

  @override
  String get repeatTitle => 'Uuesti…';

  @override
  String get noRepeatLabel => 'Ei kordu';

  @override
  String get unitDays => 'päeva pärast';

  @override
  String get unitWeeks => 'nädala pärast';

  @override
  String get unitMonths => 'kuu pärast';

  @override
  String get unitYears => 'aasta pärast';

  @override
  String ageYears(int years) {
    return '$years a';
  }

  @override
  String ageMonths(int months) {
    return '$months k';
  }

  @override
  String get changeDateLabel => 'Muuda kuupäeva';

  @override
  String get removeReminderLabel => 'Eemalda meeldetuletus';

  @override
  String get exportIcs => 'Ekspordi kalendrifail';

  @override
  String get resyncCalendar => 'Sünkrooni kalender uuesti';

  @override
  String icsSavedTo(String path) {
    return 'Kalendrifail salvestatud asukohta $path';
  }

  @override
  String get calendarMirrorLabel => 'Peegelda seadme kalendrisse';

  @override
  String get calendarMirrorSubtitle =>
      'Visiidid ilmuvad kalendrisse kogu päeva sündmustena. cat(a)log uuendab neid seal igal käivitusel ja pärast iga muudatust. Visiitide meeldetuletusi haldad kalendris.';

  @override
  String get syncPeerOlder =>
      'Teises seadmes on vanem cat(a)log ilma meeldetuletusteta. Uuenda cat(a)log seal ja sünkrooni uuesti.';

  @override
  String get syncPeerNewer =>
      'Teises seadmes on uuem cat(a)log. Uuenda cat(a)log selles seadmes ja sünkrooni uuesti.';

  @override
  String get syncPeerNoTls =>
      'Teises seadmes on cat(a)log enne 1.1.0, ilma krüptitud sünkroonimiseta. Uuenda seal cat(a)log ja sünkrooni uuesti.';

  @override
  String get syncWrongHost =>
      'Sertifikaat ei vasta paariskoodile — see pole seade, kust kood tuli. Skanni või sisesta kood uuesti.';

  @override
  String get bundleNewerError =>
      'See fail on uuemast cat(a)logist. Uuenda cat(a)log selles seadmes, et seda importida.';

  @override
  String get spotEar =>
      'Väike kassikõrv nurgas tähendab: hoia all, et näha rohkem.';

  @override
  String get addReminder => 'Lisa meeldetuletus';

  @override
  String get plannedSection => 'Plaanis';

  @override
  String get reminderDialogHint =>
      'Visiit kuvatakse meeldetuletustes. Seal saad selle kinnitada või tagasi lükata. Väärtus võetakse üle ainult siis, kui visiit on kinnitatud.';

  @override
  String get reminderFor => 'Kellele';

  @override
  String get reminderField => 'Väli';

  @override
  String get dueDateLabel => 'Tähtaeg';

  @override
  String get pickCalendar => 'Milline kalender?';

  @override
  String get calendarPermissionDenied =>
      'Kalendri kasutus on blokeeritud, seega on peegeldus väljas. Luba see süsteemi seadetes ja lülita peegeldus uuesti sisse.';

  @override
  String get calendarNotChosen =>
      'Kalendrit pole valitud, seega on peegeldus väljas. Lülita see uuesti sisse ja vali üks.';

  @override
  String get calendarGone =>
      'Valitud kalendrit enam pole, seega on peegeldus väljas. Lülita see uuesti sisse ja vali teine.';

  @override
  String get noWritableCalendar =>
      'Kalendrit ei leitud. Logi süsteemi seadetes kalendrikontosse sisse, näiteks Google, ja proovi uuesti.';

  @override
  String get spotHomeAgenda =>
      'Meeldetuletused: plaanitud visiitide nimekiri — loomaarst, ravimid, kontrollid.';

  @override
  String get spotAgendaAdd => 'Plaani uus visiit.';

  @override
  String get spotAgendaCalendar =>
      'Lülita siin sisse cat(a)logi visiitide peegeldus valitud kalendrisse.';

  @override
  String get helpAgenda =>
      'Meeldetuletused näitavad plaanitud visiite kuupäeva järgi. On kaht liiki: visiidid kellaajaga ja meeldetuletused, mis kehtivad päeva kohta. Möödalastud jäävad üles. Puudutus avab kassi või klauderi. Linnuke kinnitab visiidi: väärtus kirjutatakse väljale ja saad kohe plaanida järgmise, näiteks kolme kuu pärast. Allhoidmine muudab kuupäeva või kustutab visiidi. Ülemine lüliti peegeldab visiidid sinu telefoni kalendrisse. Menüü ekspordib need kalendrifailina. Loomaarsti külastus mitme kassiga on üks kohtumine: märgi kassid, Päevakava näitab ühte kaarti nende nimedega ja lõpetamisel küsitakse, milliseid kasse raviti — eemalda märge ülejäänutelt, nad jäävad planeerituks.';

  @override
  String get helpAgendaNeutral =>
      'Meeldetuletused näitavad plaanitud visiite kuupäeva järgi. On kaht liiki: visiidid kellaajaga ja meeldetuletused, mis kehtivad päeva kohta. Möödalastud jäävad üles. Puudutus avab lemmiklooma või leibkonna. Linnuke kinnitab visiidi: väärtus kirjutatakse väljale ja saad kohe plaanida järgmise, näiteks kolme kuu pärast. Allhoidmine muudab kuupäeva või kustutab visiidi. Ülemine lüliti peegeldab visiidid sinu telefoni kalendrisse. Menüü ekspordib need kalendrifailina. Loomaarsti külastus mitme lemmikloomaga on üks kohtumine: märgi lemmikloomad, Päevakava näitab ühte kaarti nende nimedega ja lõpetamisel küsitakse, milliseid lemmikloomi raviti — eemalda märge ülejäänutelt, nad jäävad planeerituks.';

  @override
  String get calendarRowOff => 'Kalender: väljas';

  @override
  String calendarRowOn(String name) {
    return 'Kalender: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Plaani sellele kassile visiit. See kuvatakse meeldetuletustes ja kinnitatakse seal.';

  @override
  String get spotAddReminderCatNeutral =>
      'Plaani sellele lemmikloomale visiit. See kuvatakse meeldetuletustes ja kinnitatakse seal.';

  @override
  String get spotAddReminderClowder =>
      'Plaani sellele klauderile visiit. See kuvatakse meeldetuletustes ja kinnitatakse seal.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Plaani sellele leibkonnale visiit. See kuvatakse meeldetuletustes ja kinnitatakse seal.';

  @override
  String get readOnlyCalendar => 'kirjutuskaitstud';

  @override
  String get appointmentLabel => 'Visiit';

  @override
  String get addAppointment => 'Lisa visiit';

  @override
  String get planChooserTitle => 'Visiit või meeldetuletus?';

  @override
  String get planChooserAppointment =>
      'Visiit — külastus kuupäeval ja kellaajal, märkmetega';

  @override
  String get planChooserReminder =>
      'Meeldetuletus — väärtus, mille tähtaeg saabub mingil päeval';

  @override
  String get appointmentTitleLabel => 'Mis';

  @override
  String get notesLabel => 'Märkmed';

  @override
  String get timeLabel => 'Kellaaeg';

  @override
  String get allDayLabel => 'Kogu päev';

  @override
  String get alertLabel => 'Hoiatus';

  @override
  String get alertNone => 'Puudub';

  @override
  String get alertDayBefore => 'Päev enne';

  @override
  String get alertHourBefore => 'Tund enne';

  @override
  String get linkFieldLabel => 'Lõpetamisel kirjuta väljale';

  @override
  String get noLinkedField => 'Väli puudub';

  @override
  String get outcomeTitle => 'Kuidas läks?';

  @override
  String get finishLabel => 'Lõpeta';

  @override
  String get editLabelAppointment => 'Muuda visiiti';

  @override
  String get deleteAppointment => 'Kustuta visiit';

  @override
  String get stepFlierText => 'Kuulutuse tekst';

  @override
  String get qrFoundHint =>
      'Kuulutuselt leiti QR-kood. Märgitud koodidest loetakse registrinumbreid ja linke.';

  @override
  String get useCode => 'Kasuta seda koodi';

  @override
  String get qrNone => 'Fotolt QR-koodi ei leitud.';

  @override
  String qrFailed(String error) {
    return 'QR-koodi lugemine ebaõnnestus: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$name kuulutus tuvastatud. Kontrolli allpool, millisele väljale iga rida läheb.';
  }

  @override
  String get flierLayoutUnknown =>
      'Tundmatu kuulutuse paigutus. Määra read allpool väljadele; ülejäänu jääb märkustesse.';

  @override
  String get targetRegistryNumber => 'Registrinumber';

  @override
  String get targetLostPlace => 'Aadress (kadumiskoht)';

  @override
  String get targetContact => 'Registri kontakt';

  @override
  String get targetDrop => 'Jäta ära';

  @override
  String get existingCat => 'Olemasolev kass';

  @override
  String get existingCatNeutral => 'Olemasolev lemmikloom';

  @override
  String get existingClowder => 'Olemasolev rühm';

  @override
  String get existingClowderNeutral => 'Olemasolev leibkond';

  @override
  String get createNewInstead => 'Puudub — loo uus';

  @override
  String overwritesValue(String value) {
    return 'Kirjutab üle praeguse väärtuse \"$value\"';
  }

  @override
  String get abortScanTitle => 'Katkestada jäädvustamine?';

  @override
  String get abortScanBody => 'Midagi ei salvestata.';

  @override
  String get abortScan => 'Katkesta';

  @override
  String get keepScanning => 'Jätka';

  @override
  String get catsOnAppointment => 'Kassid sellel kohtumisel';

  @override
  String get catsOnAppointmentNeutral => 'Lemmikloomad sellel kohtumisel';

  @override
  String get noCatsHint =>
      'Ükski kass pole märgitud — kohtumine kuulub kolooniale endale.';

  @override
  String get noCatsHintNeutral =>
      'Ükski lemmikloom pole märgitud — kohtumine kuulub leibkonnale endale.';

  @override
  String get pickCatsTitle => 'Millised kassid tulevad kaasa?';

  @override
  String get pickCatsTitleNeutral => 'Millised lemmikloomad tulevad kaasa?';

  @override
  String catsCount(int count) {
    return '$count kassi';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count lemmiklooma';
  }

  @override
  String get finishUntickHint =>
      'Eemalda märge kassidelt, keda ei ravitud; nad jäävad planeerituks.';

  @override
  String get finishUntickHintNeutral =>
      'Eemalda märge lemmikloomadelt, keda ei ravitud; nad jäävad planeerituks.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Kustuta kohtumine kõigi $count kassi jaoks';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Kustuta kohtumine kõigi $count lemmiklooma jaoks';
  }
}
