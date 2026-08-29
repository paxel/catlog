// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Bun venit în cat(a)log';

  @override
  String get welcomeBody =>
      'Alege-ți un nume. Fiecare modificare se înregistrează sub acest nume, ca ceilalți să vadă cine a făcut ce.';

  @override
  String get yourName => 'Numele tău';

  @override
  String get start => 'Începe';

  @override
  String get clowders => 'Clowdere';

  @override
  String get noClowdersYet =>
      'Încă niciun clowder. Un clowder e un loc unde trăiesc pisici — casa ta de plasament, apartamentul unui adoptator. Creează-l pe primul mai jos.';

  @override
  String get strays => 'Pisici fără stăpân';

  @override
  String get searchCats => 'Caută pisici';

  @override
  String get map => 'Hartă';

  @override
  String get sync => 'Sincronizare';

  @override
  String get fields => 'Câmpuri';

  @override
  String get exportCsv => 'Exportă CSV';

  @override
  String get aboutAndFeedback => 'Despre & feedback';

  @override
  String get newClowder => 'Clowder nou';

  @override
  String get name => 'Nume';

  @override
  String get cancel => 'Anulează';

  @override
  String get create => 'Creează';

  @override
  String get save => 'Salvează';

  @override
  String get delete => 'Șterge';

  @override
  String get merge => 'Îmbină';

  @override
  String get resolve => 'Decide';

  @override
  String get open => 'Deschide';

  @override
  String csvSavedTo(String path) {
    return 'CSV salvat în $path';
  }

  @override
  String get renameClowder => 'Redenumește clowderul';

  @override
  String get rename => 'Redenumește';

  @override
  String get timeline => 'Cronologie';

  @override
  String get mergeInto => 'Îmbină cu…';

  @override
  String get deleteClowder => 'Șterge clowderul';

  @override
  String get cats => 'Pisici';

  @override
  String get addCat => 'Adaugă pisică';

  @override
  String get newCat => 'Pisică nouă';

  @override
  String deleteQuestion(String name) {
    return 'Ștergi $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowderul dispare din listă.';

  @override
  String deleteClowderBody(int count) {
    return 'Cele $count pisici ale lui nu se șterg — devin fără stăpân. Mută-le întâi în alt clowder dacă nu asta vrei.';
  }

  @override
  String get card => 'Fișă';

  @override
  String get shareAsImage => 'Distribuie ca imagine';

  @override
  String get shareAsPdf => 'Distribuie ca PDF';

  @override
  String get print => 'Tipărește';

  @override
  String cardTitle(String name) {
    return 'Fișă — $name';
  }

  @override
  String get renameCat => 'Redenumește pisica';

  @override
  String get seenHereNow => 'Văzută aici acum';

  @override
  String get deleteCat => 'Șterge pisica';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Fără stăpân — fără clowder';

  @override
  String get stray => 'Fără stăpân';

  @override
  String get photos => 'Poze';

  @override
  String get addPhoto => 'Adaugă poză';

  @override
  String get setAsProfileImage => 'Setează ca poză de profil';

  @override
  String get thisIsProfileImage => 'Aceasta este poza de profil';

  @override
  String get deletePhoto => 'Șterge poza';

  @override
  String get deletePhotoTitle => 'Ștergi poza?';

  @override
  String get deletePhotoBody =>
      'Datele pozei se șterg definitiv — nu se poate anula.';

  @override
  String get deleteCatBody =>
      'Pisica dispare din toate listele, iar pozele ei sunt șterse — aici și, după următoarea sincronizare, și pe celelalte dispozitive.';

  @override
  String get sightingRecorded => 'Observație înregistrată la poziția ta.';

  @override
  String get noLocationAvailable =>
      'Locație indisponibilă — apasă lung pe hartă în schimb.';

  @override
  String get locationDeniedForever =>
      'Accesul la locație este blocat. Permiteți-l în setările sistemului pentru a folosi Stray Cam.';

  @override
  String get locationServiceOff =>
      'Localizarea este oprită pe acest dispozitiv. Porniți-o din setări și încercați din nou.';

  @override
  String get locationDenied =>
      'cat(a)log nu are permisiunea de a folosi locația dvs. Încercați din nou și permiteți-o când vi se cere.';

  @override
  String get locationNoFix =>
      'Poziția dvs. nu a putut fi determinată acum. Încercați din nou în aer liber — GPS-ul are nevoie de vedere liberă spre cer.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Număr cip';

  @override
  String get starterRemarks => 'Observații';

  @override
  String get captureFlier => 'Fotografiază afișul';

  @override
  String get addPhotosTo => 'Adaugă fotografiile la…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotografii adăugate la $name';
  }

  @override
  String get scanPrintedCode => 'Scanează codul tipărit';

  @override
  String get chipScanHint =>
      'Scanează codul QR/de bare tipărit de pe cardul cipului sau actele veterinare — telefonul nu poate citi cipul din pisică.';

  @override
  String get savingLabel => 'Se salvează…';

  @override
  String ownerOfCat(String name) {
    return 'Stăpânul lui $name';
  }

  @override
  String get sortLabel => 'Sortare';

  @override
  String get viewAsTable => 'Afișează ca tabel';

  @override
  String get viewAsTiles => 'Afișează ca plăci';

  @override
  String get matchCandidatesTitle => 'Potriviri posibile';

  @override
  String get findDuplicates => 'Găsește dubluri';

  @override
  String get noDuplicates => 'Nicio dublură posibilă momentan.';

  @override
  String get similarName => 'Nume asemănător';

  @override
  String get sharePublicly => 'Distribuie public…';

  @override
  String get pickFramesTitle => 'Alege cadre';

  @override
  String get suggestedFrames => 'Cadre sugerate';

  @override
  String get scrubFrames => 'Derulează videoclipul';

  @override
  String get keepThisFrame => 'Păstrează acest cadru';

  @override
  String get fromVideo => 'Din video…';

  @override
  String get videoMobileOnly =>
      'Alegerea cadrelor dintr-un video funcționează în aplicația de telefon (Android și iPhone) — încă nu pe acest dispozitiv.';

  @override
  String get shareWhitelistExplainer =>
      'Alege ce intră în fișier. Se includ doar câmpurile bifate.';

  @override
  String get exportShareFile => 'Exportă fișierul de distribuire…';

  @override
  String get hostedLink => 'Link găzduit (URL-ul fișierului încărcat)';

  @override
  String get inlineQr => 'QR încorporat (doar text, fără fotografii)';

  @override
  String get inlineTooBig =>
      'Prea multe date pentru un cod încorporat — debifați câmpuri sau folosiți un link găzduit.';

  @override
  String get scanShareLabel => 'Scanează codul de distribuire';

  @override
  String get notAShareCode => 'Acest cod nu este o distribuire cat(a)log.';

  @override
  String get importShareTitle => 'Importați această pisică?';

  @override
  String shareSource(String url) {
    return 'Sursă: $url';
  }

  @override
  String get importLabel => 'Importă';

  @override
  String get strayAreaLabel => 'Zonă posibilă de hoinăreală';

  @override
  String get prevPin => 'Pinul anterior';

  @override
  String get nextPin => 'Pinul următor';

  @override
  String get noMissingCats =>
      'Încă nicio pisică dispărută cu poziții de afișe.';

  @override
  String get noMatchCandidates => 'Nicio potrivire posibilă momentan.';

  @override
  String sameIdField(String field) {
    return 'Același $field';
  }

  @override
  String metersApart(String distance) {
    return 'La $distance m distanță';
  }

  @override
  String get addFlier => 'Adaugă afiș';

  @override
  String get missingSinceLabel => 'Dispărut din';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Decupează portretul';

  @override
  String get statusOwner => 'Stăpân';

  @override
  String get ocrUnavailable =>
      'Recunoașterea textului nu este disponibilă pe acest dispozitiv — tastați singur textul afișului.';

  @override
  String get displayFormat => 'Afișat ca';

  @override
  String get displayPlain => 'Text simplu';

  @override
  String get displayQr => 'Cod QR';

  @override
  String get displayBarcode => 'Cod de bare';

  @override
  String get editLabel => 'Editează';

  @override
  String get doneLabel => 'Gata';

  @override
  String get openSettings => 'Deschide setările';

  @override
  String get notSaved => 'Nesalvat';

  @override
  String get birthdateInFuture => 'Data nașterii nu poate fi în viitor.';

  @override
  String get deceasedInFuture => 'Data decesului nu poate fi în viitor.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Data decesului nu poate fi înaintea datei nașterii ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Data nașterii nu poate fi după data decesului ($date).';
  }

  @override
  String get malePregnant =>
      'Această pisică este înregistrată ca mascul — un mascul nu poate fi gestant. Verificați mai întâi sexul.';

  @override
  String fatherNotMale(String name) {
    return '$name este înregistrată ca femelă și nu poate fi tatăl. Verificați mai întâi sexul.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name este înregistrat ca mascul și nu poate fi mama. Verificați mai întâi sexul.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name s-a născut la $date — un părinte nu se poate naște după puiul său.';
  }

  @override
  String get genderFatherFemale =>
      'Această pisică este înregistrată ca tată al altor pisici — tatăl nu poate fi femelă. Verificați mai întâi familia.';

  @override
  String get genderMotherMale =>
      'Această pisică este înregistrată ca mamă a altor pisici — mama nu poate fi mascul. Verificați mai întâi familia.';

  @override
  String get moveTo => 'Mută în';

  @override
  String get noClowderStrayOption => 'Fără clowder — fără stăpân / a fugit';

  @override
  String timelineOf(String name) {
    return 'Cronologie — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Anulează această modificare';

  @override
  String get revertSubtitle =>
      'Restaurează valoarea anterioară ca înregistrare nouă — istoricul le păstrează pe ambele.';

  @override
  String fieldCleared(String field) {
    return '$field golit';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field înapoi la \"$value\"';
  }

  @override
  String get leftStray => 'A plecat — fără stăpân';

  @override
  String movedTo(String name) {
    return 'Mutată în $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat a sosit';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat a sosit din $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat a plecat în $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicat îmbinat';

  @override
  String get asOfToday => 'Cu data de azi';

  @override
  String asOfDate(String date) {
    return 'Cu data $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Format greșit — folosiți $format';
  }

  @override
  String get dateInFuture => 'Această dată nu poate fi în viitor.';

  @override
  String get value => 'Valoare';

  @override
  String get latitudeLongitude => 'latitudine, longitudine';

  @override
  String get newField => 'Câmp nou';

  @override
  String get fieldType => 'Tip';

  @override
  String get usedOn => 'Folosit pentru';

  @override
  String get forCats => 'pisici';

  @override
  String get forClowders => 'clowdere';

  @override
  String get forBoth => 'ambele';

  @override
  String get optionsOnePerLine => 'Opțiuni (una pe linie)';

  @override
  String get ownValue => 'Valoare proprie';

  @override
  String get renameField => 'Redenumește câmpul';

  @override
  String get editOptions => 'Editează opțiunile…';

  @override
  String get noStraysRightNow => 'Nicio pisică fără stăpân momentan.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Adaugă fără stăpân';

  @override
  String get newStray => 'Pisică fără stăpân nouă';

  @override
  String get searchByNameHint => 'Caută pisici după nume…';

  @override
  String get host => 'Găzduiește';

  @override
  String get hostExplainer =>
      'Începe aici, apoi scanează codul sau introdu-l pe celălalt dispozitiv.';

  @override
  String get startHosting => 'Pornește găzduirea';

  @override
  String get stopHosting => 'Oprește găzduirea';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Sesiuni până acum: $count';
  }

  @override
  String get join => 'Alătură-te';

  @override
  String get addressFromHost => 'Adresa (de pe dispozitivul gazdă)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sincronizează acum';

  @override
  String get addressFormatHint =>
      'Adresa trebuie să arate ca 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sincronizat: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sincronizare eșuată: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Ultima sincronizare cu $peer: $time';
  }

  @override
  String get sharedFolder => 'Dosar partajat';

  @override
  String get sharedFolderExplainer =>
      'Ambele dispozitive folosesc același dosar (de exemplu în Dropbox sau pe un stick USB). Fiecare sincronizare lasă acolo schimbările tale și le preia pe ale celuilalt.';

  @override
  String get noFolderChosenYet => 'Niciun dosar ales încă';

  @override
  String get choose => 'Alege…';

  @override
  String get syncFolderNow => 'Sincronizează dosarul acum';

  @override
  String folderSynced(String result) {
    return 'Dosar sincronizat: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sincronizarea dosarului a eșuat: $error';
  }

  @override
  String get recordSightingHere => 'Înregistrează o observație aici:';

  @override
  String trailOf(String name, int count) {
    return 'Traseu: $name ($count observații)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflict — $field';
  }

  @override
  String get conflictBody =>
      'Modificat în două locuri deodată. Alege ce e adevărat:';

  @override
  String mergeThisInto(String kind) {
    return 'Îmbină acest $kind cu…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Niciun alt $kind cu care să îmbini.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Îmbini cu $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Cele două înregistrări devin una. $name își păstrează valorile actuale; istoricul celeilalte i se alătură. Nu se poate anula.';
  }

  @override
  String get kindCat => 'pisică';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'câmp';

  @override
  String get takePhoto => 'Fă o poză';

  @override
  String get chooseFromGallery => 'Alege din galerie';

  @override
  String get about => 'Despre';

  @override
  String get aboutTagline =>
      'Un catalog local pentru pisici în plasament. Datele tale rămân pe dispozitivele tale — fără server, fără cont.';

  @override
  String versionLabel(String version, String build) {
    return 'Versiunea $version ($build)';
  }

  @override
  String get sourceCode => 'Cod sursă';

  @override
  String get reportProblemOrIdea => 'Raportează o problemă sau o idee';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Scrie-i dezvoltatorului';

  @override
  String get buyCoffee => 'Fă-i cinste dezvoltatorului cu o cafea';

  @override
  String get coffeeSubtitle =>
      'Aplicația rămâne gratuită. Chiar dacă nu primesc cafea :)';

  @override
  String get openSourceLicenses => 'Licențe open source';

  @override
  String get machineTranslated =>
      'Traducerile sunt automate — corecturile sunt binevenite pe GitHub.';

  @override
  String get unnamed => '(fără nume)';

  @override
  String get labelName => 'Nume';

  @override
  String get labelProfileImage => 'Poză de profil';

  @override
  String get labelPhoto => 'Poză';

  @override
  String get starterGender => 'Sex';

  @override
  String get starterBreed => 'Rasă';

  @override
  String get valueMixed => 'metis';

  @override
  String get breedEuropeanShorthair => 'European cu păr scurt';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britanic cu păr scurt';

  @override
  String get breedNorwegianForestCat => 'Pisică de pădure norvegiană';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siameză';

  @override
  String get breedPersian => 'Persană';

  @override
  String get breedBengal => 'Bengaleză';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get starterColor => 'Culoare';

  @override
  String get starterNeutered => 'Sterilizată';

  @override
  String get starterPregnant => 'Gestantă';

  @override
  String get starterBirthdate => 'Data nașterii';

  @override
  String get starterDeceased => 'Decedată';

  @override
  String get starterAddress => 'Adresă';

  @override
  String get starterResponsible => 'Persoană responsabilă';

  @override
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Link de căutare';

  @override
  String lookupUrlHelp(String token) {
    return 'Pagina serviciului cu $token în locul numărului, de ex. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Caută';

  @override
  String lookupFailed(String url) {
    return 'Nicio aplicație nu a putut deschide $url. Copiază linkul într-un browser.';
  }

  @override
  String get stepCat => 'Pisică';

  @override
  String get stepOwner => 'Proprietar';

  @override
  String get stepFace => 'Poza feței';

  @override
  String get stepRegistry => 'Registru';

  @override
  String get stepReview => 'Verifică și salvează';

  @override
  String get stepOwnerHint =>
      'Cine îi duce dorul pisicii — asta devine clowderul lui, cu contactul de pe afiș.';

  @override
  String get stepFaceHint =>
      'Decupează fața pisicii de pe afiș; devine poza de profil. Poți sări peste.';

  @override
  String get stepRegistryHint =>
      'Numere găsite pe afiș. Cele bifate se salvează la pisică și se pot deschide mai târziu.';

  @override
  String get noRegistryLinks =>
      'Niciun link de registru pe acest afiș — dacă vreunul a fost omis, te rugăm să raportezi un bug.';

  @override
  String get unknownServiceHint => 'Serviciu necunoscut';

  @override
  String get rememberService => 'Ține minte serviciul';

  @override
  String get rememberServiceHint =>
      'Denumește serviciul și arată numărul din link. Următorul afiș se completează singur.';

  @override
  String get noIdInLink =>
      'Acest link nu conține un număr pe care aplicația să-l salveze.';

  @override
  String get whichNumber => 'Care parte este numărul?';

  @override
  String get cropAgain => 'Decupează din nou';

  @override
  String get noFaceYet =>
      'Încă nicio poză a feței — se folosește poza afișului.';

  @override
  String get backLabel => 'Înapoi';

  @override
  String get dangerButton => 'NU APĂSA.\nPERICOL';

  @override
  String get dangerThanks => 'Mulțumim că folosești cat(a)log!';

  @override
  String get helpTitle => 'Ajutor';

  @override
  String get showTipsAgain => 'Arată sfaturile din nou';

  @override
  String get helpHome =>
      'Privirea de ansamblu asupra coloniilor tale — o colonie e un loc unde trăiesc pisici: casa ta, o casă temporară, un adăpost. Atinge un card ca să-i vezi pisicile; ține apăsat pentru meniu. Butonul din dreapta jos creează o colonie, iar cardul vagabonzilor adună toate pisicile fără casă. Numele de sus e catalogul în care ești — atinge-l ca să schimbi sau să adaugi.';

  @override
  String get helpClowder =>
      'Tot despre acest loc: pisicile, câmpurile (adresă, contact, tip) și istoricul. Pagina se deschide doar pentru citire; creionul pornește editarea, unde poți adăuga și un câmp. Ține apăsat un câmp ca să-l editezi direct, o pisică pentru a o muta, ascunde sau deschide. O programare adăugată aici poate lua mai multe pisici ale coloniei, de exemplu un drum de sterilizare: bifează pisicile care vin, încheie o dată, debifează-le pe cele netratate.';

  @override
  String get helpCat =>
      'Totul despre această pisică: fotografii, câmpuri, familie, istoric. Pagina este doar pentru citire până atingi creionul. Ține apăsat un câmp ca să-l editezi direct; ține apăsată o fotografie pentru meniul ei. Meniul din dreapta sus ține restul: ascunde, unește, notează o observare, partajează pisica. „Privat“ se setează la editarea unui câmp.';

  @override
  String get helpStrays =>
      'Pisici care acum nu au casă: găsite, fugite sau luate de pe un afiș. Butonul cu camera înregistrează o pisică din fața ta; butonul cu afișul transformă un afiș de pisică dispărută într-o pisică cu contactul stăpânului; scanerul citește un cod cat(a)log de pe afiș.';

  @override
  String get helpMap =>
      'Toate pisicile și locurile cu poziție. Căutarea găsește pisici, persoane și locuri — un nume necunoscut e căutat în toată lumea. Butonul de straturi desenează cercurile de 500 m în jurul locurilor afișelor unei pisici dispărute și în jurul casei din care a fugit. Săgețile merg din pin în pin, apăsarea lungă notează o observare.';

  @override
  String get helpCard =>
      'Cardul de tipărit al pisicii: alege sus, cu etichetele, ce apare pe el, apoi partajează-l ca imagine sau PDF. Numerele pot fi tipărite ca QR sau cod de bare, iar o poziție devine un QR care deschide o hartă, plus un Plus Code scurt.';

  @override
  String get helpSync =>
      'Cum ajung datele la alți oameni: conectare directă, un dosar pe care îl văd ambele dispozitive, sau un fișier trimis prin messenger. Tu decizi mereu ce pleacă — iar fișierele .catsync primite se deschid tot aici.';

  @override
  String get helpFields =>
      'Câmpurile folosite de catalogul tău. Redenumește-le, schimbă opțiunile unui câmp cu listă sau creează-ți proprii câmpuri. Un câmp de identificator poate trimite la un serviciu (un registru), iar atunci numărul devine apăsabil la pisică.';

  @override
  String get helpTimeline =>
      'Fiecare modificare făcută vreodată, cea mai nouă prima: cine ce a schimbat, când și în ce valoare. Orice intrare poate fi anulată — asta scrie o intrare nouă, nimic nu se șterge.';

  @override
  String get helpDuplicates =>
      'Pisici sau colonii care par să existe de două ori — identificatoare identice sau nume foarte asemănătoare cu detalii care se potrivesc. Atinge o pereche ca s-o unești; unirea nu se poate anula, de aceea se cere confirmare.';

  @override
  String get helpMatches =>
      'Pisici care ar putea fi același animal: identificator identic sau un vagabond văzut în zona de căutare a unei pisici dispărute. Atinge o pereche ca s-o unești, ține apăsat ca să deschizi prima pisică și să compari.';

  @override
  String get helpFlier =>
      'Un afiș fotografiat devine o pisică plus stăpânul ei. Pas cu pas: datele pisicii, contactul stăpânului, decuparea feței pentru poza de profil, numerele de registru de pe afiș, apoi o verificare finală. Totul e sugestie — corectează ce a citit greșit camera.';

  @override
  String get archiveTitle => 'Arhivă';

  @override
  String get archiveExplainer =>
      'Pisicile decedate și coloniile goale de care nu s-a atins nimeni de ani de zile tot ocupă spațiu — mai ales pozele lor. Arhivarea le scrie într-un fișier pe care îl păstrezi și apoi le șterge de aici.';

  @override
  String get archiveAction => 'Arhivează';

  @override
  String archiveSelected(int count) {
    return 'Arhivează $count intrări';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arhivezi $count intrări?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names vor fi scrise într-un fișier și apoi șterse — de pe dispozitivul tău și de pe fiecare dispozitiv cu care sincronizezi. Importul fișierului aduce totul înapoi; fără el, sunt pierdute.';
  }

  @override
  String archiveDone(int count) {
    return '$count intrări arhivate și șterse';
  }

  @override
  String archiveFailed(String error) {
    return 'Nu s-a șters nimic: fișierul de arhivă nu a putut fi scris ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Bază de date $db, poze $photos în $count fișiere';
  }

  @override
  String quietForYears(int years) {
    return 'Fără schimbări de $years ani';
  }

  @override
  String get nothingToArchive => 'Nimic destul de vechi pentru arhivare.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Ultima modificare $date · poze $size';
  }

  @override
  String get helpArchive =>
      'Datele vechi costă spațiu, mai ales pozele pe care fiecare dispozitiv sincronizat le cară. Aici alegi pisici decedate și colonii goale liniștite de ani de zile, le scrii într-un fișier pe care îl păstrezi și le ștergi. Ștergerea ajunge la toți cei cu care sincronizezi; importul fișierului restaurează totul.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Restaurezi $count intrări șterse?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names sunt șterse în acest catalog, iar fișierul tocmai importat le conține. Restaurarea le aduce înapoi aici și pe fiecare dispozitiv cu care sincronizezi.';
  }

  @override
  String get restoreAction => 'Restaurează';

  @override
  String get keepDeleted => 'Lasă șterse';

  @override
  String get archiveNotSaved =>
      'Nu s-a șters nimic: arhiva nu a fost salvată nicăieri.';

  @override
  String get locateAddress => 'Caută adresa pe hartă';

  @override
  String get addressLocated => 'Adresă găsită';

  @override
  String get addressNotFound =>
      'Nu s-a găsit niciun loc pentru această adresă. Verifică scrierea sau las-o goală.';

  @override
  String get starterPosition => 'Locație';

  @override
  String get valueYes => 'da';

  @override
  String get valueNo => 'nu';

  @override
  String get valueFemale => 'femelă';

  @override
  String get valueMale => 'mascul';

  @override
  String get valueUnknown => 'necunoscut';

  @override
  String get cropTitle => 'Decupează poza';

  @override
  String get markTitle => 'Marchează pisica';

  @override
  String get applyCrop => 'Decupează';

  @override
  String get useFullPhoto => 'Folosește toată poza';

  @override
  String get dragToSelect => 'Trage un dreptunghi în jurul pisicii';

  @override
  String get dragOverTheCat => 'Trage o elipsă peste pisică';

  @override
  String get cropPhoto => 'Decupează…';

  @override
  String get markPhoto => 'Marchează…';

  @override
  String get scanCode => 'Scanează codul';

  @override
  String get orTypeCode => 'Sau tastează codul';

  @override
  String get copyCode => 'Copiază codul';

  @override
  String get copied => 'Copiat';

  @override
  String get invalidCode => 'Codul nu este valid';

  @override
  String get hotspotHint =>
      'Fără Wi-Fi comun? Pornește hotspotul unui telefon, conectează-l pe celălalt și găzduiește aici.';

  @override
  String get byMessenger => 'Prin messenger';

  @override
  String get byMessengerExplainer =>
      'Trimite tot catalogul ca un singur fișier prin WhatsApp, Signal sau mail — cealaltă parte îl importă.';

  @override
  String get shareBundle => 'Partajează pachetul de sincronizare…';

  @override
  String get importBundle => 'Importă pachetul de sincronizare…';

  @override
  String bundleImported(String result) {
    return 'Pachet importat: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Ultima copie de rezervă automată a eșuat: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import eșuat: $error';
  }

  @override
  String get pickOnMap => 'Alege pe hartă';

  @override
  String get useMyLocation => 'Folosește locația mea';

  @override
  String get language => 'Limbă';

  @override
  String get systemDefault => 'Implicit sistem';

  @override
  String get iosLocalNetworkHint =>
      'Dacă tot eșuează pe iPhone/iPad: Configurări → Confidențialitate și securitate → Rețea locală → permite cat(a)log, apoi încearcă din nou.';

  @override
  String get includePrivate => 'Partajează datele private';

  @override
  String get hideLabel => 'Ascunde pe acest dispozitiv';

  @override
  String get unhideLabel => 'Afișează din nou';

  @override
  String get showHiddenLabel => 'Afișează elementele ascunse';

  @override
  String get stopShowingHidden => 'Nu mai afișa elementele ascunse';

  @override
  String get starterSpecies => 'Specie';

  @override
  String get starterStatus => 'Tip';

  @override
  String get statusFoster => 'Casă de plasament';

  @override
  String get statusForeverHome => 'Cămin';

  @override
  String get statusClinic => 'Clinică';

  @override
  String get statusShelter => 'Adăpost';

  @override
  String get statusBarn => 'Hambar';

  @override
  String get valueCat => 'Pisică';

  @override
  String get otherOption => 'Altele…';

  @override
  String get celebrationsToggle => 'Sărbătorește adopțiile';

  @override
  String get celebrationsSubtitle =>
      'Confetti și urale când o pisică se mută în căminul ei';

  @override
  String get onMapLabel => 'Pe hartă';

  @override
  String get showOnMap => 'Arată pe hartă';

  @override
  String get searchPlaceHint => 'Caută loc sau adresă';

  @override
  String get noPlacesFound => 'Niciun loc găsit';

  @override
  String get mapSearchHint => 'Caută pisici, grupuri, persoane';

  @override
  String get proposeAnotherName => 'Propune alt nume';

  @override
  String get moderationTitle => 'Autori și interdicții';

  @override
  String get moderationSubtitle => 'Elimină definitiv datele unei persoane';

  @override
  String get authorsSection => 'Cine a scris în acest catalog';

  @override
  String get hardDeleteAction => 'Șterge tot de la acest autor';

  @override
  String hardDeleteWarning(Object name) {
    return 'Elimină fiecare intrare și fotografie de la $name de pe acest dispozitiv. Celelalte dispozitive le păstrează pe ale lor. Ireversibil.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Tastează $name pentru confirmare';
  }

  @override
  String get alsoBan => 'Interzice și — nu mai accepta niciodată datele';

  @override
  String get bansSection => 'Interdicții';

  @override
  String get unbanAction => 'Elimină interdicția';

  @override
  String get deletedDone => 'Șters.';

  @override
  String get syncSummaryTitle => 'Ce a sosit';

  @override
  String get summaryAdopted => 'Adoptate';

  @override
  String get summaryDeceased => 'Decedate';

  @override
  String get summaryEscaped => 'Evadate';

  @override
  String get summaryNew => 'Noi';

  @override
  String get summaryConflicts => 'Conflicte de rezolvat';

  @override
  String summaryOther(Object n) {
    return '…și încă $n modificări';
  }

  @override
  String get starterMother => 'Mamă';

  @override
  String get starterFather => 'Tată';

  @override
  String get familySection => 'Familie';

  @override
  String get littermatesLabel => 'Din aceeași serie';

  @override
  String get siblingsLabel => 'Frați';

  @override
  String get kittensLabel => 'Pisoi';

  @override
  String get toastSettingsTitle => 'Ce se anunță';

  @override
  String get toastSettingsSubtitle => 'Mesaje scurte după o sincronizare';

  @override
  String get toastKindAdoptions => 'Adopții';

  @override
  String get toastKindBirths => 'Nașteri';

  @override
  String get toastKindDeaths => 'Decese';

  @override
  String get toastKindEscapes => 'Evadări';

  @override
  String get toastKindMoves => 'Mutări';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptată de $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Pisoi nou: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat a murit';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat a evadat';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat s-a mutat la $home';
  }

  @override
  String get notACatlogFile => 'Acesta nu este un fișier cat(a)log';

  @override
  String get nothingNewInBundle => 'Nimic nou în fișier — ai deja totul';

  @override
  String get syncChooserInPerson => 'Față în față';

  @override
  String get syncChooserInPersonSub => 'Sincronizare prin Wi-Fi';

  @override
  String get syncChooserRemote => 'De la distanță';

  @override
  String get syncChooserRemoteSub => 'Sincronizare prin folder sau stick USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Export și import prin rețele sociale';

  @override
  String get connectToWifiFirst =>
      'Conectează-te mai întâi la Wi-Fi — apoi dispozitivele se găsesc';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vrea să sincronizeze';
  }

  @override
  String get trustBothWaysNote =>
      'Cataloagele vor fi schimbate în ambele direcții.';

  @override
  String get allowOnce => 'Permite';

  @override
  String get allowAlways => 'Permite mereu acest dispozitiv';

  @override
  String get declineAction => 'Refuză';

  @override
  String get syncDeclined => 'Celălalt dispozitiv a refuzat sincronizarea';

  @override
  String get trustedDevicesSection => 'Dispozitive permise mereu';

  @override
  String get removeTrust => 'Elimină';

  @override
  String get hostWithoutWifi => 'Găzduiește fără Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Creează o conexiune directă temporară cu celălalt telefon (fără internet). O folosește doar cat(a)log și se deconectează singură după sincronizare.';

  @override
  String get hotspotAndroidOnly =>
      'Acest cod necesită două telefoane Android — pe iPhone/iPad folosește un Wi-Fi comun';

  @override
  String get selectClowderHint => 'Alege un clowder din stânga';

  @override
  String get introTitle1 => 'Pisicile tale, organizate';

  @override
  String get introBody1 =>
      'Creează o fișă pentru fiecare pisică: poză, sex, sănătate, orice vrei să notezi. Pisicile sunt grupate după locul unde trăiesc — aplicația îl numește colonie (clowder).';

  @override
  String get introTitle2 => 'Funcționează fără internet';

  @override
  String get introBody2 =>
      'Totul se salvează doar pe telefonul tău. Fără cont, fără cloud. Nimic nu se trimite decât dacă distribui tu.';

  @override
  String get introTitle3 => 'Lucrați împreună';

  @override
  String get introBody3 =>
      'Fiecare folosește aplicația proprie și schimbați date din când în când: întâlniți-vă și scanați un cod, folosiți un dosar comun sau trimiteți un fișier prin messenger. Apoi toți au aceleași informații.';

  @override
  String get introSkip => 'Sari peste';

  @override
  String get introNext => 'Înainte';

  @override
  String get introDone => 'Să începem';

  @override
  String get introReplayTitle => 'Introducere rapidă';

  @override
  String get spotHomeSync =>
      'Aici sincronizezi cu cunoscuții tăi. Tu decizi ce împarți.';

  @override
  String get spotHomeStrays =>
      'Acest card adună toți vagabonzii — pisici fără casă. Atinge-l pentru listă.';

  @override
  String get spotHomeMenu =>
      'În acest meniu: găsește și unește dublurile, exportă CSV și altele.';

  @override
  String get spotCatEdit =>
      'Atinge creionul ca să editezi pisica. Sfat: ține apăsat un câmp ca să-l editezi direct.';

  @override
  String get spotMapLayers =>
      'Cauți o pisică dispărută? Afișează cercuri în jurul locurilor afișelor ei și al casei din care a fugit.';

  @override
  String get spotStraysFlier =>
      'Afiș cu pisică dispărută? Fotografiază-l aici — aplicația salvează pisica și contactul pentru tine.';

  @override
  String get spotStraysScan =>
      'Unele afișe au un cod QR cat(a)log. Scanează-l aici și importă pisica fără să tastezi.';

  @override
  String get introTitle4 => 'Găsește pisicile dispărute';

  @override
  String get introBody4 =>
      'Vezi un afiș cu o pisică dispărută? Fotografiază-l în aplicație: salvează pisica, contactul stăpânului și locul. Dacă mai târziu apare un vagabond asemănător, aplicația sugerează potriviri posibile.';

  @override
  String get spotMapSearch =>
      'Scrie o pisică, un loc sau o persoană ca să sari acolo pe hartă.';

  @override
  String get spotCardChips =>
      'Bifează ce apare pe cardul de partajat — restul rămâne în afara lui.';

  @override
  String get spotCatMenu =>
      'Aici sunt mai multe acțiuni: ascunde pisica, unește duplicatele sau notează o observare.';

  @override
  String get spotDone => 'Am înțeles';

  @override
  String get spotReplayTitle => 'Turul noutăților';

  @override
  String get spotReplaySubtitle => 'Arată indiciile din nou pe fiecare pagină';

  @override
  String get spotReplayDone => 'Indiciile vor apărea din nou';

  @override
  String get searchNoResults => 'Nicio pisică găsită cu acest nume';

  @override
  String get syncUnreachable =>
      'Celălalt dispozitiv nu poate fi contactat. Sunt ambele pe același Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Dosarul nu poate fi accesat. Discul sau dosarul cloud mai există?';

  @override
  String get crashTitle => 'Asta nu trebuia să se întâmple';

  @override
  String get crashBody =>
      'cat(a)log a întâlnit o eroare neașteptată. Datele tale sunt în siguranță — totul se salvează în momentul modificării. Repornește aplicația și, dacă se repetă, trimite raportul ca să poată fi reparat.';

  @override
  String get crashRestart => 'Repornește aplicația';

  @override
  String get crashSendReport => 'Trimite raport dezvoltatorului';

  @override
  String get crashLastRunBody =>
      'cat(a)log s-a oprit neașteptat data trecută — probabil a rămas fără memorie. Trimitem un raport scurt ca să fie reparat?';

  @override
  String get catalogsTitle => 'Cataloage';

  @override
  String get newCatalog => 'Catalog nou';

  @override
  String get catalogNameLabel => 'Numele catalogului';

  @override
  String catalogNameTaken(String name) {
    return 'Există deja un catalog numit $name. Alege alt nume.';
  }

  @override
  String get manageCatalogs => 'Gestionează cataloagele';

  @override
  String get helpCatalogs =>
      'Fiecare catalog e o lume aparte: pisicile, coloniile, câmpurile, pozele și partenerii de sincronizare proprii. Berlinul și Parisul nu se amestecă niciodată. Atinge numele din capul ecranului principal ca să schimbi, să adaugi sau să redenumești. Numele tău, limba și sfaturile deja văzute sunt comune tuturor.';

  @override
  String get spotHomeCatalog =>
      'Acesta e catalogul în care ești. Atinge numele ca să schimbi sau să creezi altul.';

  @override
  String get deleteCatalog => 'Șterge catalogul';

  @override
  String deleteCatalogBody(String name) {
    return 'Tot ce e în $name dispare: pisicile, pozele, istoricul. Mai întâi se salvează un fișier complet acolo unde ajung copiile automate — importul lui aduce catalogul înapoi. Scrie numele ca să confirmi.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name șters. Fișierul e în $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Scrie $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nu s-a șters nimic: fișierul catalogului nu a putut fi scris ($error). Eliberează spațiu sau încearcă mai târziu.';
  }

  @override
  String get moveToCatalog => 'Mută în alt catalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count mutate în $name';
  }

  @override
  String get chooseWhatToMove => 'Ce se mută?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Muți ceva în $name?';
  }

  @override
  String get undoThisImport => 'Anulează acest import';

  @override
  String undoImportBody(int count) {
    return 'Cele $count modificări aduse de acest import se elimină. Sunt scrise mai întâi într-un fișier, al cărui import le aduce înapoi. Cei cu care ai sincronizat deja își păstrează copia — asta nu se poate retrage.';
  }

  @override
  String undoneImport(String where) {
    return 'Anulat. Fișierul e în $where.';
  }

  @override
  String get goBackTitle => 'Înapoi la un moment anterior';

  @override
  String get goBackToHere => 'Înapoi aici';

  @override
  String get momentImport => 'Înainte de import';

  @override
  String get momentSync => 'Înainte de sincronizare';

  @override
  String get momentMerge => 'Înainte de îmbinare';

  @override
  String get momentHardDelete => 'Înainte de ștergerea datelor unui autor';

  @override
  String get momentArchive => 'Înainte de arhivare';

  @override
  String get momentManual => 'Marcat de tine';

  @override
  String get showOlderMoments => 'Arată mai vechi';

  @override
  String goBackBody(int count) {
    return 'Tot ce vine după acest moment se elimină — $count modificări. Se scrie mai întâi într-un fișier, al cărui import aduce totul înapoi, iar fiecare moment mai nou pleacă odată cu el. Cei cu care ai sincronizat deja își păstrează copia — asta nu se poate retrage.';
  }

  @override
  String get nameThisMoment => 'Denumește acest moment';

  @override
  String get helpGoBack =>
      'Momentele în care acest catalog și-a schimbat forma: înainte de fiecare import și fiecare sincronizare, înainte de o îmbinare, o arhivare sau o ștergere, și ori de câte ori ai marcat tu unul. Alegând unul, catalogul revine la acea stare — tot ce vine după se scrie într-un fișier pe care îl păstrezi și apoi se elimină, iar fiecare moment mai nou pleacă odată cu el. Cei cu care ai sincronizat deja păstrează ce au primit.';

  @override
  String goBackFileFailed(String error) {
    return 'Nu s-a eliminat nimic: fișierul care îl păstrează nu a putut fi scris ($error). Eliberează spațiu și încearcă din nou.';
  }

  @override
  String get switchBeforeDeleting =>
      'Acesta e catalogul în care ești. Treci la altul, apoi șterge-l.';

  @override
  String shareFileFailed(String error) {
    return 'Fișierul de partajare nu a putut fi scris ($error). Eliberează spațiu și încearcă din nou.';
  }

  @override
  String get privateLabel => 'Privat';

  @override
  String sharedCatalogIs(String name) {
    return 'Catalog: $name';
  }

  @override
  String get markPrivate => 'Marchează ca privat';

  @override
  String get unmarkPrivate => 'Elimină marcajul privat';

  @override
  String get agenda => 'Agendă';

  @override
  String get reminderLabel => 'Memento';

  @override
  String get agendaEmpty =>
      'Nicio programare planificată. Planifică altele aici cu plusul sau pe pagina unei pisici sau a unui clowder.';

  @override
  String get dueToday => 'azi';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'peste $count de zile',
      few: 'peste $count zile',
      one: 'peste 1 zi',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de zile întârziere',
      few: '$count zile întârziere',
      one: '1 zi întârziere',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Gata';

  @override
  String get repeatTitle => 'Din nou peste…';

  @override
  String get noRepeatLabel => 'Fără repetare';

  @override
  String get unitDays => 'zile';

  @override
  String get unitWeeks => 'săptămâni';

  @override
  String get unitMonths => 'luni';

  @override
  String get unitYears => 'ani';

  @override
  String ageYears(int years) {
    return '$years ani';
  }

  @override
  String ageMonths(int months) {
    return '$months luni';
  }

  @override
  String get changeDateLabel => 'Schimbă data';

  @override
  String get removeReminderLabel => 'Elimină mementoul';

  @override
  String get exportIcs => 'Exportă fișierul de calendar';

  @override
  String icsSavedTo(String path) {
    return 'Fișierul de calendar a fost salvat în $path';
  }

  @override
  String get calendarMirrorLabel => 'Oglindește în calendarul dispozitivului';

  @override
  String get calendarMirrorSubtitle =>
      'Programările apar ca evenimente de o zi întreagă în calendar. cat(a)log le actualizează acolo la fiecare pornire și după fiecare modificare. Alertele pentru programări le gestionezi în calendar.';

  @override
  String get syncPeerOlder =>
      'Celălalt dispozitiv rulează un cat(a)log mai vechi, fără mementouri. Actualizează cat(a)log acolo și sincronizează din nou.';

  @override
  String get syncPeerNewer =>
      'Celălalt dispozitiv rulează un cat(a)log mai nou. Actualizează cat(a)log pe acest dispozitiv și sincronizează din nou.';

  @override
  String get bundleNewerError =>
      'Acest fișier vine dintr-un cat(a)log mai nou. Actualizează cat(a)log pe acest dispozitiv ca să îl imporți.';

  @override
  String get spotEar =>
      'O ureche mică de pisică într-un colț înseamnă: ține apăsat pentru mai mult.';

  @override
  String get addReminder => 'Adaugă memento';

  @override
  String get plannedSection => 'Planificat';

  @override
  String get reminderDialogHint =>
      'Programarea apare în agendă. Acolo o poți confirma sau respinge. Valoarea este preluată doar dacă programarea a fost confirmată.';

  @override
  String get reminderFor => 'Pentru';

  @override
  String get reminderField => 'Câmp';

  @override
  String get dueDateLabel => 'Data scadentă';

  @override
  String get pickCalendar => 'Care calendar?';

  @override
  String get calendarPermissionDenied =>
      'Accesul la calendar este blocat, așa că oglindirea e oprită. Permite-l în setările sistemului și pornește oglindirea din nou.';

  @override
  String get calendarNotChosen =>
      'Niciun calendar ales, așa că oglindirea e oprită. Pornește-o din nou și alege unul.';

  @override
  String get calendarGone =>
      'Calendarul ales nu mai există, așa că oglindirea e oprită. Pornește-o din nou și alege altul.';

  @override
  String get noWritableCalendar =>
      'Niciun calendar găsit. Conectează-te la un cont de calendar în setările sistemului, de exemplu Google, și încearcă din nou.';

  @override
  String get spotHomeAgenda =>
      'Agenda: lista programărilor planificate — veterinar, medicamente, controale.';

  @override
  String get spotAgendaAdd => 'Planifică o programare nouă.';

  @override
  String get spotAgendaCalendar =>
      'Pornește aici oglindirea programărilor cat(a)log într-un calendar la alegere.';

  @override
  String get helpAgenda =>
      'Agenda listează programările planificate după dată. Sunt două feluri: programări cu oră și mementouri valabile pentru o zi. Cele ratate rămân sus. Atingerea deschide pisica sau clowderul. Bifa confirmă o programare: valoarea se scrie în câmp și poți planifica imediat următoarea, de exemplu peste trei luni. Apăsarea lungă schimbă data sau șterge programarea. Comutatorul de sus oglindește programările într-un calendar al telefonului. Meniul le exportă ca fișier de calendar. O vizită la veterinar cu mai multe pisici este o singură programare: bifează pisicile, Agenda arată un card cu numele lor, iar la încheiere întreabă ce pisici au fost tratate — debifează-le pe celelalte, rămân planificate.';

  @override
  String get calendarRowOff => 'Calendar: oprit';

  @override
  String calendarRowOn(String name) {
    return 'Calendar: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Planifică o programare pentru această pisică. Apare în agendă și se confirmă acolo.';

  @override
  String get spotAddReminderClowder =>
      'Planifică o programare pentru acest clowder. Apare în agendă și se confirmă acolo.';

  @override
  String get readOnlyCalendar => 'doar citire';

  @override
  String get appointmentLabel => 'Programare';

  @override
  String get addAppointment => 'Adaugă programare';

  @override
  String get planChooserTitle => 'Programare sau memento?';

  @override
  String get planChooserAppointment =>
      'Programare — o vizită la o dată și oră, cu note';

  @override
  String get planChooserReminder =>
      'Memento — o valoare care devine scadentă într-o zi';

  @override
  String get appointmentTitleLabel => 'Ce';

  @override
  String get notesLabel => 'Note';

  @override
  String get timeLabel => 'Ora';

  @override
  String get allDayLabel => 'Toată ziua';

  @override
  String get alertLabel => 'Alertă';

  @override
  String get alertNone => 'Niciuna';

  @override
  String get alertDayBefore => 'Cu o zi înainte';

  @override
  String get alertHourBefore => 'Cu o oră înainte';

  @override
  String get linkFieldLabel => 'La finalizare, scrie într-un câmp';

  @override
  String get noLinkedField => 'Niciun câmp';

  @override
  String get outcomeTitle => 'Cum a fost?';

  @override
  String get finishLabel => 'Finalizează';

  @override
  String get editLabelAppointment => 'Editează programarea';

  @override
  String get deleteAppointment => 'Șterge programarea';

  @override
  String get stepFlierText => 'Textul afișului';

  @override
  String get qrFoundHint =>
      'Pe afiș a fost găsit un cod QR. Codurile bifate sunt citite pentru numere de registru și linkuri.';

  @override
  String get useCode => 'Folosește acest cod';

  @override
  String get qrNone => 'Niciun cod QR găsit în fotografie.';

  @override
  String qrFailed(String error) {
    return 'Citirea codului QR a eșuat: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Afiș $name recunoscut. Verifică mai jos în ce câmp merge fiecare rând.';
  }

  @override
  String get flierLayoutUnknown =>
      'Aspect necunoscut al afișului. Atribuie rândurile câmpurilor de mai jos; restul rămâne în observații.';

  @override
  String get targetRegistryNumber => 'Număr de registru';

  @override
  String get targetLostPlace => 'Adresă (locul pierderii)';

  @override
  String get targetContact => 'Contactul registrului';

  @override
  String get targetDrop => 'Renunță';

  @override
  String get abortScanTitle => 'Renunți la scanare?';

  @override
  String get abortScanBody => 'Nu se salvează nimic.';

  @override
  String get abortScan => 'Renunță';

  @override
  String get keepScanning => 'Continuă';

  @override
  String get catsOnAppointment => 'Pisici la această programare';

  @override
  String get noCatsHint => 'Nicio pisică bifată — programarea este a coloniei.';

  @override
  String get pickCatsTitle => 'Care pisici vin?';

  @override
  String catsCount(int count) {
    return '$count pisici';
  }

  @override
  String get finishUntickHint =>
      'Debifează pisicile care nu au fost tratate; rămân planificate.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Șterge programarea pentru toate cele $count pisici';
  }
}
