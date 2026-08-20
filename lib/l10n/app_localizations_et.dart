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
  String get noClowdersYet =>
      'Veel pole ühtegi clowderit. Clowder on koht, kus kassid elavad — sinu hoiukodu, lapsendaja korter. Loo esimene allpool.';

  @override
  String get strays => 'Hulkuvad kassid';

  @override
  String get searchCats => 'Otsi kasse';

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
  String get newClowder => 'Uus klauder';

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
  String get rename => 'Nimeta ümber';

  @override
  String get timeline => 'Ajajoon';

  @override
  String get mergeInto => 'Ühenda…';

  @override
  String get deleteClowder => 'Kustuta klauder';

  @override
  String get cats => 'Kassid';

  @override
  String get addCat => 'Lisa kass';

  @override
  String get newCat => 'Uus kass';

  @override
  String deleteQuestion(String name) {
    return 'Kustutada $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Klauder kaob loendist.';

  @override
  String deleteClowderBody(int count) {
    return 'Selle $count kassi ei kustutata — neist saavad hulkujad. Kui sa seda ei soovi, liiguta nad enne teise klaudrisse.';
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
  String get seenHereNow => 'Nähtud siin praegu';

  @override
  String get deleteCat => 'Kustuta kass';

  @override
  String get clowderLabel => 'Klauder';

  @override
  String get strayNoClowder => 'Hulkuja — klaudrita';

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
      'Kass kaob kõigist nimekirjadest ja tema fotod eemaldatakse — siin ja pärast järgmist sünkroonimist ka su abiliste seadmetes.';

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
  String get privateNoShare =>
      'See kass on märgitud privaatseks — privaatsed andmed ei lahku kunagi sinu seadmest. Avalikuks jagamiseks eemalda esmalt märgistus.';

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
      'Kataloogist lahkuvad ainult märgitud väljad. Kõik muu jääb koju.';

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
  String get genderFatherFemale =>
      'See kass on kirjas teiste kasside isana — isa ei saa olla emane. Kontrolli esmalt perekonda.';

  @override
  String get genderMotherMale =>
      'See kass on kirjas teiste kasside emana — ema ei saa olla isane. Kontrolli esmalt perekonda.';

  @override
  String get moveTo => 'Liiguta';

  @override
  String get noClowderStrayOption => 'Klaudrita — hulkuja / jooksis ära';

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
  String get forClowders => 'klaudritel';

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
  String get host => 'Võõrusta';

  @override
  String get hostExplainer =>
      'Alusta siit, seejärel sisesta teises seadmes aadress ja PIN.';

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
      'Sünkrooni kausta kaudu, mida pilv või USB-pulk seadmete vahel kannab — neile, kes pole samas võrgus.';

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
  String get kindClowder => 'klauder';

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
  String get coffeeSubtitle => 'Täiesti vabatahtlik — rakendus on tasuta';

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
  String get applyCrop => 'Kärbi';

  @override
  String get useFullPhoto => 'Kasuta tervet fotot';

  @override
  String get dragToSelect => 'Lohista ristkülik kassi ümber';

  @override
  String get dragOverTheCat => 'Lohista ellips kassi peale';

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
  String get systemDefault => 'Süsteemi vaikimisi';

  @override
  String get iosLocalNetworkHint =>
      'Kui iPhone\'is/iPadis endiselt ebaõnnestub: Seaded → Privaatsus ja turvalisus → Kohalik võrk → luba cat(a)log ja proovi uuesti.';

  @override
  String get markPrivate => 'Märgi privaatseks';

  @override
  String get unmarkPrivate => 'Eemalda privaatsuse märge';

  @override
  String get includePrivate => 'Kaasa privaatsed andmed';

  @override
  String get includePrivateExplainer =>
      'Privaatsed kassid, rühmad ja väljad jagatakse samuti — lülita sisse ainult oma seadmete sünkroonimisel.';

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
  String get statusForeverHome => 'Päriskodu';

  @override
  String get statusClinic => 'Kliinik';

  @override
  String get statusShelter => 'Varjupaik';

  @override
  String get statusBarn => 'Küün';

  @override
  String get valueCat => 'Kass';

  @override
  String get otherOption => 'Muu…';

  @override
  String get celebrationsToggle => 'Tähista lapsendamisi';

  @override
  String get celebrationsSubtitle =>
      'Konfetid ja hõisked, kui kass kolib päriskoju';

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
  String summaryOther(Object n) {
    return '…ja veel $n muudatust';
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
  String get syncChooserInPersonSub =>
      'Olete samas ruumis — skanni kood, valmis sekunditega';

  @override
  String get syncChooserRemote => 'Eemalt';

  @override
  String get syncChooserRemoteSub =>
      'Jagatud kausta kaudu nagu Dropbox või USB-pulk';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Saada kõik ühe failina mis tahes sõnumirakendusega — ja impordi saadud .catsync-fail siin';

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
  String get introTitle1 => 'Kassid elavad clowderites';

  @override
  String get introBody1 =>
      'Clowder on koht, kus kassid elavad: sinu hoiukodu, lapsendaja korter, kõrvalasuv küün. Iga kass saab kaardi foto, faktide ja kogu looga.';

  @override
  String get introTitle2 => 'Kõik jääb sinule';

  @override
  String get introBody2 =>
      'Ei kontot, ei pilve, ei jälgimist. Sinu andmed elavad sinu seadmes.';

  @override
  String get introTitle3 => 'Jaga oma abilistega';

  @override
  String get introBody3 =>
      'Skanni kood ja kaks seadet sünkroonivad sekunditega, kasuta jagatud kausta või saada kõik ühe failina.';

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
      'Uus: sünkroonimine pakub nüüd kolme selget teed — ja usaldusküsimust enne, kui midagi liigub.';

  @override
  String get spotHomeStrays =>
      'Uus: hulkujatel on siin üleval oma kaart — arv, näod, ava puudutusega.';

  @override
  String get spotHomeMenu =>
      'Uus: see menüü leiab topeltkassid ja -kolooniad ning liidab nad.';

  @override
  String get spotCatEdit =>
      'Uus: leht on kirjutuskaitstud — pliiats lülitab muutmisele, pikk vajutus väljal muudab seda otse.';

  @override
  String get spotMapLayers =>
      'Uus: kuva 500 m otsinguringid kadunud kassi kuulutuste kohtade ümber.';

  @override
  String get spotStraysFlier =>
      'Uus: pildista kadunud kassi kuulutust — sellest saavad kass, omanik ja kontakt.';

  @override
  String get spotStraysScan =>
      'Uus: skanni kuulutuselt cat(a)log kood ja impordi kass otse.';

  @override
  String get introTitle4 => 'Kadunud kassid';

  @override
  String get introBody4 =>
      'Pildista kuulutust ja kadunud kass jõuab kataloogi koos omaniku kontaktiga. Nägemised, otsinguringid ja vastete soovitused aitavad ta koju tuua.';

  @override
  String get spotMapSearch =>
      'Uus: otsi siit kasse, clowdereid ja inimesi — otse kaardil.';

  @override
  String get spotCardChips => 'Uus: vali enne jagamist, mis kaardile jõuab.';

  @override
  String get spotCatMenu =>
      'Uus: märgi kass privaatseks (ei lahku kunagi seadmest) või peida ta siit.';

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
}
