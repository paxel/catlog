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
  String get noClowdersYet =>
      'Ei vielä clowdereita. Clowder on paikka, jossa kissat asuvat — sijaiskotisi, adoptoijan asunto. Luo ensimmäinen alta.';

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
      'Kissa katoaa kaikista listoista ja sen kuvat poistetaan — täältä ja seuraavan synkronoinnin jälkeen myös auttajiesi laitteilta.';

  @override
  String get sightingRecorded => 'Havainto tallennettu sijaintiisi.';

  @override
  String get noLocationAvailable =>
      'Sijainti ei saatavilla — paina sen sijaan karttaa pitkään.';

  @override
  String get locationDeniedForever =>
      'Sijainnin käyttö on estetty. Salli se järjestelmäasetuksissa käyttääksesi Stray Camia.';

  @override
  String get locationServiceOff =>
      'Sijainti on pois päältä tällä laitteella. Kytke se päälle asetuksista ja yritä uudelleen.';

  @override
  String get locationDenied =>
      'cat(a)log ei saa käyttää sijaintiasi. Yritä uudelleen ja salli se kysyttäessä.';

  @override
  String get locationNoFix =>
      'Sijaintiasi ei juuri nyt voitu määrittää. Yritä uudelleen ulkona — GPS tarvitsee esteettömän näkymän taivaalle.';

  @override
  String get ok => 'OK';

  @override
  String get openSettings => 'Avaa asetukset';

  @override
  String get notSaved => 'Ei tallennettu';

  @override
  String get birthdateInFuture => 'Syntymäpäivä ei voi olla tulevaisuudessa.';

  @override
  String get deceasedInFuture => 'Kuolinpäivä ei voi olla tulevaisuudessa.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Kuolinpäivä ei voi olla ennen syntymäpäivää ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Syntymäpäivä ei voi olla kuolinpäivän ($date) jälkeen.';
  }

  @override
  String get malePregnant =>
      'Tämä kissa on merkitty urokseksi — uros ei voi olla tiineenä. Tarkista ensin sukupuoli.';

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
  String dateFormatError(String format) {
    return 'Väärä muoto — käytä muotoa $format';
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
  String get ownValue => 'Oma arvo';

  @override
  String get renameField => 'Nimeä kenttä uudelleen';

  @override
  String get editOptions => 'Muokkaa vaihtoehtoja…';

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
  String get starterBreed => 'Rotu';

  @override
  String get valueMixed => 'sekarotuinen';

  @override
  String get breedEuropeanShorthair => 'Eurooppalainen lyhytkarva';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Brittiläinen lyhytkarva';

  @override
  String get breedNorwegianForestCat => 'Norjalainen metsäkissa';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamilainen';

  @override
  String get breedPersian => 'Persialainen';

  @override
  String get breedBengal => 'Bengali';

  @override
  String get breedSphynx => 'Sfinksi';

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
  String get applyCrop => 'Rajaa';

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

  @override
  String get scanCode => 'Skannaa koodi';

  @override
  String get orTypeCode => 'Tai kirjoita koodi';

  @override
  String get copyCode => 'Kopioi koodi';

  @override
  String get copied => 'Kopioitu';

  @override
  String get invalidCode => 'Koodi ei kelpaa';

  @override
  String get hotspotHint =>
      'Ei yhteistä Wi-Fiä? Laita yhden puhelimen hotspot päälle, yhdistä toinen siihen ja isännöi tässä.';

  @override
  String get byMessenger => 'Viestisovelluksella';

  @override
  String get byMessengerExplainer =>
      'Lähetä koko luettelo yhtenä tiedostona WhatsAppilla, Signalilla tai sähköpostilla — toinen puoli tuo sen.';

  @override
  String get shareBundle => 'Jaa synkronointipaketti…';

  @override
  String get importBundle => 'Tuo synkronointipaketti…';

  @override
  String bundleImported(String result) {
    return 'Paketti tuotu: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Viimeisin automaattinen varmuuskopio epäonnistui: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Tuonti epäonnistui: $error';
  }

  @override
  String get pickOnMap => 'Valitse kartalta';

  @override
  String get useMyLocation => 'Käytä sijaintiani';

  @override
  String get language => 'Kieli';

  @override
  String get systemDefault => 'Järjestelmän oletus';

  @override
  String get iosLocalNetworkHint =>
      'Jos epäonnistuu yhä iPhonella/iPadilla: Asetukset → Tietosuoja ja turvallisuus → Paikallisverkko → salli cat(a)log ja yritä uudelleen.';

  @override
  String get markPrivate => 'Merkitse yksityiseksi';

  @override
  String get unmarkPrivate => 'Poista yksityisyysmerkintä';

  @override
  String get includePrivate => 'Sisällytä yksityiset tiedot';

  @override
  String get includePrivateExplainer =>
      'Yksityiset kissat, ryhmät ja kentät jaetaan myös — kytke päälle vain omien laitteidesi synkronoinnissa.';

  @override
  String get hideLabel => 'Piilota tällä laitteella';

  @override
  String get unhideLabel => 'Näytä uudelleen';

  @override
  String get showHiddenLabel => 'Näytä piilotetut';

  @override
  String get stopShowingHidden => 'Lopeta piilotettujen näyttäminen';

  @override
  String get starterSpecies => 'Laji';

  @override
  String get starterStatus => 'Tila';

  @override
  String get statusFoster => 'Sijaiskoti';

  @override
  String get statusForeverHome => 'Ikuinen koti';

  @override
  String get statusClinic => 'Klinikka';

  @override
  String get statusShelter => 'Löytöeläintalo';

  @override
  String get statusBarn => 'Lato';

  @override
  String get valueCat => 'Kissa';

  @override
  String get otherOption => 'Muu…';

  @override
  String get celebrationsToggle => 'Juhli adoptioita';

  @override
  String get celebrationsSubtitle =>
      'Konfettia ja hurraus, kun kissa muuttaa ikuiseen kotiinsa';

  @override
  String get onMapLabel => 'Kartalla';

  @override
  String get showOnMap => 'Näytä kartalla';

  @override
  String get searchPlaceHint => 'Hae paikkaa tai osoitetta';

  @override
  String get noPlacesFound => 'Paikkoja ei löytynyt';

  @override
  String get mapSearchHint => 'Hae kissoja, ryhmiä, henkilöitä';

  @override
  String get proposeAnotherName => 'Ehdota toista nimeä';

  @override
  String get moderationTitle => 'Tekijät ja estot';

  @override
  String get moderationSubtitle => 'Poista henkilön tiedot pysyvästi';

  @override
  String get authorsSection => 'Kuka on kirjoittanut luetteloon';

  @override
  String get hardDeleteAction => 'Poista kaikki tältä tekijältä';

  @override
  String hardDeleteWarning(Object name) {
    return 'Poistaa kaikki $name merkinnät ja kuvat tältä laitteelta. Muut laitteet pitävät omansa. Ei voi perua.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Vahvista kirjoittamalla $name';
  }

  @override
  String get alsoBan => 'Estä myös — älä koskaan enää vastaanota tietoja';

  @override
  String get bansSection => 'Estot';

  @override
  String get unbanAction => 'Poista esto';

  @override
  String get deletedDone => 'Poistettu.';

  @override
  String get syncSummaryTitle => 'Mitä saapui';

  @override
  String get summaryAdopted => 'Adoptoidut';

  @override
  String get summaryDeceased => 'Kuolleet';

  @override
  String get summaryEscaped => 'Karanneet';

  @override
  String get summaryNew => 'Uudet';

  @override
  String get summaryConflicts => 'Ratkaistavat ristiriidat';

  @override
  String summaryOther(Object n) {
    return '…ja $n muuta muutosta';
  }

  @override
  String get starterMother => 'Emo';

  @override
  String get starterFather => 'Isä';

  @override
  String get familySection => 'Perhe';

  @override
  String get littermatesLabel => 'Pentuesisarukset';

  @override
  String get siblingsLabel => 'Sisarukset';

  @override
  String get kittensLabel => 'Pennut';

  @override
  String get toastSettingsTitle => 'Mitä ilmoitetaan';

  @override
  String get toastSettingsSubtitle => 'Pienet viestit synkronoinnin jälkeen';

  @override
  String get toastKindAdoptions => 'Adoptiot';

  @override
  String get toastKindBirths => 'Syntymät';

  @override
  String get toastKindDeaths => 'Kuolemat';

  @override
  String get toastKindEscapes => 'Karkaamiset';

  @override
  String get toastKindMoves => 'Muutot';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptoitu: $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Uusi pentu: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat on kuollut';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat on karannut';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat muutti: $home';
  }

  @override
  String get notACatlogFile => 'Tuo ei ole cat(a)log-tiedosto';

  @override
  String get nothingNewInBundle => 'Ei mitään uutta — sinulla on jo kaikki';

  @override
  String get syncChooserInPerson => 'Kasvokkain';

  @override
  String get syncChooserInPersonSub =>
      'Olette samassa huoneessa — skannaa koodi, valmis sekunneissa';

  @override
  String get syncChooserRemote => 'Etänä';

  @override
  String get syncChooserRemoteSub =>
      'Jaetun kansion kautta, kuten Dropbox tai USB-tikku';

  @override
  String get syncChooserMessenger => 'Viestisovellus';

  @override
  String get syncChooserMessengerSub =>
      'Lähetä kaikki yhtenä tiedostona millä tahansa viestimellä';

  @override
  String get connectToWifiFirst =>
      'Yhdistä ensin Wi-Fiin — sitten laitteet löytävät toisensa';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) haluaa synkronoida';
  }

  @override
  String get trustBothWaysNote => 'Luettelot vaihdetaan molempiin suuntiin.';

  @override
  String get allowOnce => 'Salli';

  @override
  String get allowAlways => 'Salli tämä laite aina';

  @override
  String get declineAction => 'Hylkää';

  @override
  String get syncDeclined => 'Toinen laite hylkäsi synkronoinnin';

  @override
  String get trustedDevicesSection => 'Aina sallitut laitteet';

  @override
  String get removeTrust => 'Poista';

  @override
  String get hostWithoutWifi => 'Isännöi ilman Wi-Fiä';

  @override
  String get hotspotJoinNote =>
      'Muodostaa väliaikaisen suoran yhteyden toiseen puhelimeen (ilman internetiä). Vain cat(a)log käyttää sitä, ja se katkeaa itsestään synkronoinnin jälkeen.';

  @override
  String get hotspotAndroidOnly =>
      'Tämä koodi vaatii kaksi Android-puhelinta — iPhonella/iPadilla käytä yhteistä Wi-Fiä';

  @override
  String get selectClowderHint => 'Valitse clowder vasemmalta';

  @override
  String get introTitle1 => 'Kissat asuvat clowdereissa';

  @override
  String get introBody1 =>
      'Clowder on paikka, jossa kissat asuvat: sijaiskotisi, adoptoijan asunto, naapurin lato. Jokainen kissa saa kortin, jossa on kuva, tiedot ja koko tarina.';

  @override
  String get introTitle2 => 'Kaikki pysyy sinulla';

  @override
  String get introBody2 =>
      'Ei tiliä, ei pilveä, ei seurantaa. Tietosi asuvat laitteellasi.';

  @override
  String get introTitle3 => 'Jaa auttajiesi kanssa';

  @override
  String get introBody3 =>
      'Skannaa koodi ja kaksi laitetta synkronoituu sekunneissa, käytä jaettua kansiota tai lähetä kaikki yhtenä tiedostona.';

  @override
  String get introSkip => 'Ohita';

  @override
  String get introNext => 'Seuraava';

  @override
  String get introDone => 'Aloitetaan';

  @override
  String get introReplayTitle => 'Pikaesittely';

  @override
  String get spotHomeSync =>
      'Uutta: synkronointi tarjoaa nyt kolme selkeää tapaa — ja luottamuskysymyksen ennen kuin mitään liikkuu.';

  @override
  String get spotMapSearch =>
      'Uutta: hae täältä kissoja, clowdereita ja henkilöitä — suoraan kartalla.';

  @override
  String get spotCardChips =>
      'Uutta: valitse mitä kortilla näkyy ennen jakamista.';

  @override
  String get spotCatMenu =>
      'Uutta: merkitse kissa yksityiseksi (ei koskaan poistu laitteeltasi) tai piilota se täällä.';

  @override
  String get spotDone => 'Selvä';

  @override
  String get spotReplayTitle => 'Uutuuskierros';

  @override
  String get spotReplaySubtitle => 'Näytä vinkit uudelleen joka sivulla';

  @override
  String get spotReplayDone => 'Vinkit näytetään uudelleen';

  @override
  String get searchNoResults => 'Sillä nimellä ei löytynyt kissaa';

  @override
  String get syncUnreachable =>
      'Toista laitetta ei tavoitettu. Ovatko molemmat samassa Wi-Fissä?';

  @override
  String get folderUnreachable =>
      'Kansiota ei tavoitettu. Onko asema tai pilvikansio yhä olemassa?';

  @override
  String get crashTitle => 'Tämän ei olisi pitänyt tapahtua';

  @override
  String get crashBody =>
      'cat(a)log kohtasi odottamattoman virheen. Tietosi ovat turvassa — kaikki tallentuu heti muutoshetkellä. Käynnistä sovellus uudelleen, ja jos tämä toistuu, lähetä raportti korjaamista varten.';

  @override
  String get crashRestart => 'Käynnistä sovellus uudelleen';

  @override
  String get crashSendReport => 'Lähetä raportti kehittäjälle';

  @override
  String get crashLastRunBody =>
      'cat(a)log pysähtyi viime kerralla odottamatta — todennäköisesti muisti loppui. Lähetetäänkö lyhyt raportti korjaamista varten?';
}
