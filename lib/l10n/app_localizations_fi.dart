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
      'Kissa katoaa kaikista listoista ja sen kuvat poistetaan — täältä ja seuraavan synkronoinnin jälkeen myös muilta laitteilta.';

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
  String get starterChipId => 'Sirunumero';

  @override
  String get starterRemarks => 'Huomautukset';

  @override
  String get captureFlier => 'Kuvaa ilmoitus';

  @override
  String get addPhotosTo => 'Lisää kuvat kohteeseen…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count kuvaa lisätty: $name';
  }

  @override
  String get scanPrintedCode => 'Skannaa painettu koodi';

  @override
  String get chipScanHint =>
      'Skannaa painetun QR-/viivakoodin sirukortista tai eläinlääkärin papereista — puhelin ei voi lukea kissan sisällä olevaa sirua.';

  @override
  String get savingLabel => 'Tallennetaan…';

  @override
  String ownerOfCat(String name) {
    return 'Omistaja: $name';
  }

  @override
  String get sortLabel => 'Järjestä';

  @override
  String get viewAsTable => 'Näytä taulukkona';

  @override
  String get viewAsTiles => 'Näytä ruutuina';

  @override
  String get matchCandidatesTitle => 'Mahdolliset osumat';

  @override
  String get findDuplicates => 'Etsi kaksoiskappaleet';

  @override
  String get noDuplicates => 'Ei mahdollisia kaksoiskappaleita juuri nyt.';

  @override
  String get similarName => 'Samankaltainen nimi';

  @override
  String get sharePublicly => 'Jaa julkisesti…';

  @override
  String get privateNoShare =>
      'Tämä kissa on merkitty yksityiseksi — yksityiset tiedot eivät koskaan poistu laitteeltasi. Poista merkintä ensin jakaaksesi julkisesti.';

  @override
  String get pickFramesTitle => 'Valitse ruudut';

  @override
  String get suggestedFrames => 'Ehdotetut ruudut';

  @override
  String get scrubFrames => 'Kelaa videota';

  @override
  String get keepThisFrame => 'Pidä tämä ruutu';

  @override
  String get fromVideo => 'Videosta…';

  @override
  String get videoMobileOnly =>
      'Ruutujen poiminta videosta toimii puhelinsovelluksessa (Android ja iPhone) — ei vielä tällä laitteella.';

  @override
  String get shareWhitelistExplainer =>
      'Valitse, mitä tiedostoon tulee. Vain valitut kentät otetaan mukaan.';

  @override
  String get exportShareFile => 'Vie jakotiedosto…';

  @override
  String get hostedLink => 'Isännöity linkki (ladatun tiedoston URL)';

  @override
  String get inlineQr => 'Upotettu QR (vain tekstiä, ei kuvia)';

  @override
  String get inlineTooBig =>
      'Liikaa dataa upotettuun koodiin — poista kenttiä tai käytä isännöityä linkkiä.';

  @override
  String get scanShareLabel => 'Skannaa jakokoodi';

  @override
  String get notAShareCode => 'Tuo koodi ei ole cat(a)log-jako.';

  @override
  String get importShareTitle => 'Tuodaanko tämä kissa?';

  @override
  String shareSource(String url) {
    return 'Lähde: $url';
  }

  @override
  String get importLabel => 'Tuo';

  @override
  String get strayAreaLabel => 'Mahdollinen kulkualue';

  @override
  String get prevPin => 'Edellinen merkki';

  @override
  String get nextPin => 'Seuraava merkki';

  @override
  String get noMissingCats =>
      'Ei vielä kadonneita kissoja, joilla on ilmoitussijainteja.';

  @override
  String get noMatchCandidates => 'Ei mahdollisia osumia juuri nyt.';

  @override
  String sameIdField(String field) {
    return 'Sama $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m päässä toisistaan';
  }

  @override
  String get addFlier => 'Lisää ilmoitus';

  @override
  String get missingSinceLabel => 'Kadonnut alkaen';

  @override
  String get phoneLabel => 'Puhelin';

  @override
  String get cropPortrait => 'Rajaa muotokuva';

  @override
  String get statusOwner => 'Omistaja';

  @override
  String get ocrUnavailable =>
      'Tekstintunnistus ei ole käytettävissä tällä laitteella — kirjoita ilmoituksen teksti itse.';

  @override
  String get displayFormat => 'Näytetään muodossa';

  @override
  String get displayPlain => 'Pelkkä teksti';

  @override
  String get displayQr => 'QR-koodi';

  @override
  String get displayBarcode => 'Viivakoodi';

  @override
  String get editLabel => 'Muokkaa';

  @override
  String get doneLabel => 'Valmis';

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
  String fatherNotMale(String name) {
    return '$name on merkitty naaraaksi eikä voi olla isä. Tarkista ensin sukupuoli.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name on merkitty urokseksi eikä voi olla emo. Tarkista ensin sukupuoli.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name syntyi $date — vanhempi ei voi syntyä pentunsa jälkeen.';
  }

  @override
  String get genderFatherFemale =>
      'Tämä kissa on merkitty muiden kissojen isäksi — isä ei voi olla naaras. Tarkista ensin perhe.';

  @override
  String get genderMotherMale =>
      'Tämä kissa on merkitty muiden kissojen emoksi — emo ei voi olla uros. Tarkista ensin perhe.';

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
      'Molemmat laitteet käyttävät samaa kansiota (esim. Dropboxissa tai USB-tikulla). Jokainen synkronointi vie muutoksesi sinne ja noutaa toisen osapuolen muutokset.';

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
  String get starterEmail => 'Sähköposti';

  @override
  String get starterPhone => 'Puhelin';

  @override
  String get lookupUrlLabel => 'Hakulinkki';

  @override
  String lookupUrlHelp(String token) {
    return 'Palvelun sivu, jossa $token on numeron paikalla, esim. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Hae';

  @override
  String lookupFailed(String url) {
    return 'Mikään sovellus ei voinut avata osoitetta $url. Kopioi linkki selaimeen.';
  }

  @override
  String get stepCat => 'Kissa';

  @override
  String get stepOwner => 'Omistaja';

  @override
  String get stepFace => 'Kasvokuva';

  @override
  String get stepRegistry => 'Rekisteri';

  @override
  String get stepReview => 'Tarkista ja tallenna';

  @override
  String get stepOwnerHint =>
      'Se, jolta kissa on kadonnut — tästä tulee hänen korttinsa ilmoituksen yhteystiedoin.';

  @override
  String get stepFaceHint =>
      'Rajaa kissan kasvot ilmoituksesta; niistä tulee profiilikuva. Voit ohittaa tämän.';

  @override
  String get stepRegistryHint =>
      'Ilmoituksesta löytyneet numerot. Valitut tallennetaan kissalle ja ne voi avata myöhemmin.';

  @override
  String get noRegistryLinks =>
      'Tässä ilmoituksessa ei ole rekisterilinkkejä — täällä ei ole tehtävää.';

  @override
  String get unknownServiceHint => 'Tuntematon palvelu';

  @override
  String get rememberService => 'Muista palvelu';

  @override
  String get rememberServiceHint =>
      'Anna palvelulle nimi ja osoita numero linkistä. Seuraava ilmoitus täyttyy itsestään.';

  @override
  String get noIdInLink =>
      'Tässä linkissä ei ole numeroa, jonka sovellus voisi tallentaa.';

  @override
  String get whichNumber => 'Mikä osa on numero?';

  @override
  String get cropAgain => 'Rajaa uudelleen';

  @override
  String get noFaceYet => 'Ei vielä kasvokuvaa — käytetään ilmoituksen kuvaa.';

  @override
  String get backLabel => 'Takaisin';

  @override
  String get dangerButton => 'ÄLÄ PAINA.\nVAARA';

  @override
  String get dangerThanks => 'Kiitos, että käytät cat(a)logia!';

  @override
  String get helpTitle => 'Ohje';

  @override
  String get showTipsAgain => 'Näytä vinkit uudelleen';

  @override
  String get helpHome =>
      'Yleisnäkymä kolonioihisi — kolonia on paikka, jossa kissat asuvat: kotisi, sijaiskoti, löytöeläintalo. Napauta korttia nähdäksesi sen kissat; pitkä painallus avaa valikon. Oikean alakulman painike luo kolonian, ja kulkukissakortti kokoaa kaikki kodittomat kissat.';

  @override
  String get helpClowder =>
      'Kaikki tästä paikasta: sen kissat, kentät (osoite, yhteystiedot, tyyppi) ja historia. Sivu avautuu vain luettavaksi; kynä kytkee muokkauksen, jossa voit myös lisätä kentän. Pidä kenttää painettuna muokataksesi sitä suoraan, kissaa siirtääksesi, piilottaaksesi tai avataksesi sen.';

  @override
  String get helpCat =>
      'Kaikki tästä kissasta: kuvat, kentät, suku, historia. Sivu on vain luettava, kunnes napautat kynää. Pidä kenttää painettuna päästäksesi suoraan sen muokkaukseen; kuvaa avataksesi sen valikon. Oikean yläkulman valikossa on loput: merkitse yksityiseksi, piilota, yhdistä, kirjaa havainto, jaa.';

  @override
  String get helpStrays =>
      'Kissat, joilla ei juuri nyt ole kotia: löydetyt, karanneet tai ilmoituksesta poimitut. Kamerapainike kirjaa kissan, joka istuu edessäsi; ilmoituspainike tekee kadonnut-ilmoituksesta kissan omistajan yhteystietoineen; skanneri lukee cat(a)log-koodin ilmoituksesta.';

  @override
  String get helpMap =>
      'Kaikki kissat ja paikat, joilla on sijainti. Haku löytää kissat, ihmiset ja paikat — tuntematon nimi haetaan koko maailmasta. Tasopainike piirtää 500 metrin ympyrät kadonneen kissan ilmoituspaikkojen ja sen entisen kodin ympärille. Nuolet kulkevat nastalta nastalle, pitkä painallus kartalla kirjaa havainnon.';

  @override
  String get helpCard =>
      'Kissan tulostettava kortti: valitse ylhäältä siruilla mitä siihen tulee, jaa se sitten kuvana tai PDF:nä. Numerot voi tulostaa QR- tai viivakoodina, ja sijainnista tulee QR, joka avaa kartan, sekä lyhyt Plus Code.';

  @override
  String get helpSync =>
      'Näin tiedot kulkevat muille: yhdistäkää suoraan, käyttäkää kansiota jonka molemmat laitteet näkevät, tai lähetä tiedosto pikaviestimellä. Sinä päätät aina mitä lähtee — ja saapuneet .catsync-tiedostot avataan myös täällä.';

  @override
  String get helpFields =>
      'Kentät, joita luettelosi käyttää. Nimeä ne uudelleen, muuta valintakentän vaihtoehtoja tai lisää omia. Tunnuskenttä voi osoittaa palveluun (rekisteriin), jolloin numeroa voi napauttaa kissan kohdalla.';

  @override
  String get helpTimeline =>
      'Jokainen tehty muutos, uusin ensin: kuka muutti mitä, milloin ja mihin arvoon. Minkä tahansa merkinnän voi perua — se kirjoittaa uuden merkinnän, mitään ei koskaan poisteta.';

  @override
  String get helpDuplicates =>
      'Kissat tai koloniat, jotka näyttävät olevan kahdesti — samat tunnukset tai hyvin samankaltaiset nimet ja täsmäävät tiedot. Napauta paria yhdistääksesi; yhdistämistä ei voi perua, siksi kysytään ensin.';

  @override
  String get helpMatches =>
      'Kissat, jotka voivat olla sama eläin: sama tunnus tai kulkukissa nähtynä kadonneen kissan hakualueella. Napauta paria yhdistääksesi, pitkä painallus avaa ensimmäisen kissan vertailua varten.';

  @override
  String get helpFlier =>
      'Valokuvatusta ilmoituksesta tulee kissa ja sen omistaja. Vaihe vaiheelta: kissan tiedot, omistajan yhteystiedot, kasvojen rajaus profiilikuvaksi, ilmoituksen rekisterinumerot ja lopuksi tarkistus. Kaikki ovat ehdotuksia — korjaa se, minkä kamera luki väärin.';

  @override
  String get archiveTitle => 'Arkisto';

  @override
  String get archiveExplainer =>
      'Kuolleet kissat ja tyhjät koloniat, joihin kukaan ei ole koskenut vuosiin, vievät silti tilaa — etenkin niiden kuvat. Arkistointi kirjoittaa ne tiedostoon, jonka säilytät, ja poistaa ne sitten täältä.';

  @override
  String get archiveAction => 'Arkistoi';

  @override
  String archiveSelected(int count) {
    return 'Arkistoi $count kohdetta';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arkistoidaanko $count kohdetta?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names kirjoitetaan tiedostoon ja poistetaan sitten — laitteeltasi ja jokaiselta laitteelta, jonka kanssa synkronoit. Tiedoston tuonti palauttaa kaiken; ilman sitä ne ovat poissa.';
  }

  @override
  String archiveDone(int count) {
    return '$count kohdetta arkistoitu ja poistettu';
  }

  @override
  String archiveFailed(String error) {
    return 'Mitään ei poistettu: arkistotiedostoa ei voitu kirjoittaa ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Tietokanta $db, kuvat $photos $count tiedostossa';
  }

  @override
  String quietForYears(int years) {
    return 'Hiljaa $years vuotta';
  }

  @override
  String get nothingToArchive =>
      'Mikään ei ole tarpeeksi vanhaa arkistoitavaksi.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Viimeisin muutos $date · kuvat $size';
  }

  @override
  String get helpArchive =>
      'Vanha tieto vie tilaa, ennen kaikkea kuvat, joita jokainen synkronoitu laite raahaa mukanaan. Täällä valitset kuolleet kissat ja tyhjät koloniat, jotka ovat olleet vuosia hiljaa, kirjoitat ne tiedostoon jonka säilytät, ja poistat ne. Poisto tavoittaa kaikki, joiden kanssa synkronoit; tiedoston tuonti palauttaa kaiken.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Palautetaanko $count poistettua kohdetta?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names on poistettu tästä luettelosta, ja juuri tuomasi tiedosto sisältää ne. Palauttaminen tuo ne takaisin tänne ja jokaiseen laitteeseen, jonka kanssa synkronoit.';
  }

  @override
  String get restoreAction => 'Palauta';

  @override
  String get keepDeleted => 'Pidä poistettuina';

  @override
  String get archiveNotSaved =>
      'Mitään ei poistettu: arkistoa ei tallennettu minnekään.';

  @override
  String get locateAddress => 'Etsi osoite kartalta';

  @override
  String get addressLocated => 'Osoite löytyi';

  @override
  String get addressNotFound =>
      'Osoitteelle ei löytynyt paikkaa. Tarkista kirjoitusasu tai jätä kenttä tyhjäksi.';

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
      'Tämä lähettää myös kaiken yksityiseksi merkityn. Se, jonka kanssa synkronoit, näkee sen.';

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
  String get starterStatus => 'Tyyppi';

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
      'Lähetä kaikki yhtenä tiedostona millä tahansa viestimellä — ja tuo vastaanotettu .catsync-tiedosto tässä';

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
  String get introTitle1 => 'Kissasi järjestyksessä';

  @override
  String get introBody1 =>
      'Luo jokaiselle kissalle kortti: kuva, sukupuoli, terveys, mitä ikinä haluat kirjata. Kissat ryhmitellään asuinpaikan mukaan — sovellus kutsuu paikkaa nimellä clowder.';

  @override
  String get introTitle2 => 'Toimii ilman nettiä';

  @override
  String get introBody2 =>
      'Kaikki tallentuu vain puhelimeesi. Ei tiliä, ei pilveä. Mitään ei lähetetä, ellet itse jaa sitä.';

  @override
  String get introTitle3 => 'Tehkää yhteistyötä';

  @override
  String get introBody3 =>
      'Jokainen käyttää omaa sovellustaan ja vaihdatte tietoja silloin tällöin: tavatkaa ja skannatkaa koodi, käyttäkää jaettua kansiota tai lähettäkää yksi tiedosto viestimellä. Sen jälkeen kaikilla on samat tiedot.';

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
      'Täällä synkronoit tuttujesi kanssa. Sinä päätät, mitä jaat.';

  @override
  String get spotHomeStrays =>
      'Tämä kortti kokoaa kaikki kulkukissat — kodittomat kissat. Napauta nähdäksesi listan.';

  @override
  String get spotHomeMenu =>
      'Tässä valikossa: etsi ja yhdistä kaksoiskappaleet, vie CSV ja muuta.';

  @override
  String get spotCatEdit =>
      'Napauta kynää muokataksesi kissaa. Vinkki: paina kenttää pitkään muokataksesi sitä suoraan.';

  @override
  String get spotMapLayers =>
      'Etsitkö kadonnutta kissaa? Näytä ympyrät sen ilmoitusten paikkojen ja sen entisen kodin ympärillä.';

  @override
  String get spotStraysFlier =>
      'Löysitkö ilmoituksen kadonneesta kissasta? Kuvaa se tässä — sovellus tallentaa kissan ja yhteystiedon puolestasi.';

  @override
  String get spotStraysScan =>
      'Joissakin ilmoituksissa on cat(a)log-QR-koodi. Skannaa se tässä ja tuo kissa kirjoittamatta.';

  @override
  String get introTitle4 => 'Löydä kadonneet kissat';

  @override
  String get introBody4 =>
      'Näetkö ilmoituksen kadonneesta kissasta? Kuvaa se sovelluksessa: se tallentaa kissan, omistajan yhteystiedot ja paikan. Jos samankaltainen kulkukissa ilmestyy myöhemmin, sovellus ehdottaa mahdollisia osumia.';

  @override
  String get spotMapSearch =>
      'Kirjoita kissa, paikka tai henkilö hypätäksesi sinne kartalla.';

  @override
  String get spotCardChips =>
      'Valitse, mitä jaettavalla kortilla näkyy — muu jää pois.';

  @override
  String get spotCatMenu =>
      'Lisää toimintoja täällä: merkitse kissa yksityiseksi, piilota se, yhdistä kaksoiskappaleet tai kirjaa havainto.';

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
