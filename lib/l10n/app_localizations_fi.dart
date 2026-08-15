// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Tervetuloa cat(a)logiin';

  @override
  String get welcomeBody =>
      'Valitse itsellesi nimi. Jokainen muutos tallennetaan tällä nimellä, jotta muut näkevät, kuka teki mitäkin.';

  @override
  String get yourName => 'Nimesi';

  @override
  String get start => 'Aloita';

  @override
  String get clowders => 'Clowderit';

  @override
  String get noClowdersYet => 'Ei vielä clowdereita.\nLuo ensimmäinen alta.';

  @override
  String get strays => 'Kulkukissat';

  @override
  String get searchCats => 'Etsi kissoja';

  @override
  String get map => 'Kartta';

  @override
  String get sync => 'Synkronointi';

  @override
  String get fields => 'Kentät';

  @override
  String get exportCsv => 'Vie CSV';

  @override
  String get aboutAndFeedback => 'Tietoja & palaute';

  @override
  String get newClowder => 'Uusi clowder';

  @override
  String get name => 'Nimi';

  @override
  String get cancel => 'Peruuta';

  @override
  String get create => 'Luo';

  @override
  String get save => 'Tallenna';

  @override
  String get delete => 'Poista';

  @override
  String get merge => 'Yhdistä';

  @override
  String get resolve => 'Ratkaise';

  @override
  String get open => 'Avaa';

  @override
  String csvSavedTo(String path) {
    return 'CSV tallennettu: $path';
  }

  @override
  String get renameClowder => 'Nimeä clowder uudelleen';

  @override
  String get rename => 'Nimeä uudelleen';

  @override
  String get timeline => 'Aikajana';

  @override
  String get mergeInto => 'Yhdistä kohteeseen…';

  @override
  String get deleteClowder => 'Poista clowder';

  @override
  String get cats => 'Kissat';

  @override
  String get addCat => 'Lisää kissa';

  @override
  String get newCat => 'Uusi kissa';

  @override
  String deleteQuestion(String name) {
    return 'Poistetaanko $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder katoaa luettelosta.';

  @override
  String deleteClowderBody(int count) {
    return 'Sen $count kissaa ei poisteta — niistä tulee kulkukissoja. Siirrä ne ensin toiseen clowderiin, jos et halua sitä.';
  }

  @override
  String get card => 'Kortti';

  @override
  String get shareAsImage => 'Jaa kuvana';

  @override
  String get shareAsPdf => 'Jaa PDF:nä';

  @override
  String get print => 'Tulosta';

  @override
  String cardTitle(String name) {
    return 'Kortti — $name';
  }

  @override
  String get renameCat => 'Nimeä kissa uudelleen';

  @override
  String get seenHereNow => 'Nähty täällä nyt';

  @override
  String get deleteCat => 'Poista kissa';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Kulkukissa — ei clowderia';

  @override
  String get stray => 'Kulkukissa';

  @override
  String get photos => 'Kuvat';

  @override
  String get addPhoto => 'Lisää kuva';

  @override
  String get setAsProfileImage => 'Aseta profiilikuvaksi';

  @override
  String get thisIsProfileImage => 'Tämä on profiilikuva';

  @override
  String get deletePhoto => 'Poista kuva';

  @override
  String get deletePhotoTitle => 'Poistetaanko kuva?';

  @override
  String get deletePhotoBody =>
      'Kuvan tiedot poistetaan pysyvästi — tätä ei voi perua.';

  @override
  String get deleteCatBody =>
      'Kissa katoaa kaikista luetteloista. Sen kuvat poistetaan pysyvästi.';

  @override
  String get sightingRecorded => 'Havainto tallennettu sijaintiisi.';

  @override
  String get noLocationAvailable =>
      'Sijainti ei saatavilla — paina sen sijaan karttaa pitkään.';

  @override
  String get moveTo => 'Siirrä kohteeseen';

  @override
  String get noClowderStrayOption => 'Ei clowderia — kulkukissa / karkasi';

  @override
  String timelineOf(String name) {
    return 'Aikajana — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Kumoa tämä muutos';

  @override
  String get revertSubtitle =>
      'Palauttaa edellisen arvon uutena merkintänä — historia säilyttää molemmat.';

  @override
  String fieldCleared(String field) {
    return '$field tyhjennetty';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field palautettu arvoon \"$value\"';
  }

  @override
  String get leftStray => 'Lähti — kulkukissa';

  @override
  String movedTo(String name) {
    return 'Siirretty kohteeseen $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat saapui';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat saapui paikasta $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat lähti paikkaan $place';
  }

  @override
  String get duplicateMergedIn => 'Kaksoiskappale yhdistetty';

  @override
  String get asOfToday => 'Tältä päivältä';

  @override
  String asOfDate(String date) {
    return 'Päivältä $date';
  }

  @override
  String get value => 'Arvo';

  @override
  String get latitudeLongitude => 'leveysaste, pituusaste';

  @override
  String get newField => 'Uusi kenttä';

  @override
  String get fieldType => 'Tyyppi';

  @override
  String get usedOn => 'Käytetään';

  @override
  String get forCats => 'kissoille';

  @override
  String get forClowders => 'clowdereille';

  @override
  String get forBoth => 'molemmille';

  @override
  String get optionsOnePerLine => 'Vaihtoehdot (yksi per rivi)';

  @override
  String get renameField => 'Nimeä kenttä uudelleen';

  @override
  String get noStraysRightNow => 'Ei kulkukissoja juuri nyt.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Lisää kulkukissa';

  @override
  String get newStray => 'Uusi kulkukissa';

  @override
  String get searchByNameHint => 'Etsi kissoja nimellä…';

  @override
  String get host => 'Isännöi';

  @override
  String get hostExplainer =>
      'Aloita tästä ja syötä sitten osoite ja PIN toisella laitteella.';

  @override
  String get startHosting => 'Aloita isännöinti';

  @override
  String get stopHosting => 'Lopeta isännöinti';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Istuntoja tähän mennessä: $count';
  }

  @override
  String get join => 'Liity';

  @override
  String get addressFromHost => 'Osoite (isäntälaitteelta)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synkronoi nyt';

  @override
  String get addressFormatHint =>
      'Osoitteen pitää näyttää tältä: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synkronoitu: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synkronointi epäonnistui: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Viimeisin synkronointi ($peer): $time';
  }

  @override
  String get sharedFolder => 'Jaettu kansio';

  @override
  String get sharedFolderExplainer =>
      'Synkronoi kansion kautta, jota pilvi tai USB-tikku kuljettaa laitteiden välillä — niille, jotka eivät ole samassa verkossa.';

  @override
  String get noFolderChosenYet => 'Kansiota ei ole vielä valittu';

  @override
  String get choose => 'Valitse…';

  @override
  String get syncFolderNow => 'Synkronoi kansio nyt';

  @override
  String folderSynced(String result) {
    return 'Kansio synkronoitu: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Kansion synkronointi epäonnistui: $error';
  }

  @override
  String get recordSightingHere => 'Kirjaa havainto tähän:';

  @override
  String get orPlaceClowderHere => 'Tai sijoita clowder tähän:';

  @override
  String trailOf(String name, int count) {
    return 'Reitti: $name ($count havaintoa)';
  }

  @override
  String conflictOn(String field) {
    return 'Ristiriita — $field';
  }

  @override
  String get conflictBody =>
      'Muutettu kahdessa paikassa yhtä aikaa. Valitse, mikä on totta:';

  @override
  String mergeThisInto(String kind) {
    return 'Yhdistä tämä $kind kohteeseen…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Ei toista kohdetta ($kind) yhdistettäväksi.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Yhdistetäänkö kohteeseen $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Kahdesta tietueesta tulee yksi. $name säilyttää nykyiset arvonsa; toisen historia liittyy siihen. Tätä ei voi perua.';
  }

  @override
  String get kindCat => 'kissa';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'kenttä';

  @override
  String get takePhoto => 'Ota kuva';

  @override
  String get chooseFromGallery => 'Valitse galleriasta';

  @override
  String get about => 'Tietoja';

  @override
  String get aboutTagline =>
      'Paikallinen luettelo sijaiskissoille. Tietosi pysyvät laitteillasi — ei palvelinta, ei tiliä.';

  @override
  String versionLabel(String version, String build) {
    return 'Versio $version ($build)';
  }

  @override
  String get sourceCode => 'Lähdekoodi';

  @override
  String get reportProblemOrIdea => 'Ilmoita ongelmasta tai ideasta';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Kirjoita kehittäjälle';

  @override
  String get buyCoffee => 'Tarjoa kehittäjälle kahvit';

  @override
  String get coffeeSubtitle => 'Täysin vapaaehtoista — sovellus on ilmainen';

  @override
  String get openSourceLicenses => 'Avoimen lähdekoodin lisenssit';

  @override
  String get machineTranslated =>
      'Käännökset ovat konekäännöksiä — korjaukset ovat tervetulleita GitHubissa.';

  @override
  String get unnamed => '(nimetön)';

  @override
  String get labelName => 'Nimi';

  @override
  String get labelProfileImage => 'Profiilikuva';

  @override
  String get labelPhoto => 'Kuva';

  @override
  String get starterGender => 'Sukupuoli';

  @override
  String get starterColor => 'Väri';

  @override
  String get starterNeutered => 'Steriloitu';

  @override
  String get starterPregnant => 'Tiine';

  @override
  String get starterBirthdate => 'Syntymäaika';

  @override
  String get starterDeceased => 'Kuollut';

  @override
  String get starterAddress => 'Osoite';

  @override
  String get starterResponsible => 'Vastuuhenkilö';

  @override
  String get starterPosition => 'Sijainti';

  @override
  String get valueYes => 'kyllä';

  @override
  String get valueNo => 'ei';

  @override
  String get valueFemale => 'naaras';

  @override
  String get valueMale => 'uros';

  @override
  String get valueUnknown => 'tuntematon';

  @override
  String get cropTitle => 'Rajaa kuva';

  @override
  String get markTitle => 'Merkitse kissa';

  @override
  String get useFullPhoto => 'Käytä koko kuvaa';

  @override
  String get dragToSelect => 'Vedä suorakulmio kissan ympärille';

  @override
  String get dragOverTheCat => 'Vedä ellipsi kissan päälle';

  @override
  String get cropPhoto => 'Rajaa…';

  @override
  String get markPhoto => 'Merkitse…';
}
