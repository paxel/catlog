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
  String get noClowdersYet => 'Klaudreid pole veel.\nLoo esimene allpool.';

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
      'Kass kaob kõigist loenditest. Tema fotod kustutatakse jäädavalt.';

  @override
  String get sightingRecorded => 'Vaatlus salvestatud sinu asukohas.';

  @override
  String get noLocationAvailable =>
      'Asukoht pole saadaval — hoia selle asemel kaarti all.';

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
  String get renameField => 'Nimeta väli ümber';

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
  String get orPlaceClowderHere => 'Või aseta klauder siia:';

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
  String get useFullPhoto => 'Kasuta tervet fotot';

  @override
  String get dragToSelect => 'Lohista ristkülik kassi ümber';

  @override
  String get dragOverTheCat => 'Lohista ellips kassi peale';

  @override
  String get cropPhoto => 'Kärbi…';

  @override
  String get markPhoto => 'Märgi…';
}
