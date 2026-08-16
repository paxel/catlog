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
      'Încă nu există clowdere.\nCreează-l pe primul mai jos.';

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
      'Pisica dispare din toate listele. Pozele ei se șterg definitiv.';

  @override
  String get sightingRecorded => 'Observație înregistrată la poziția ta.';

  @override
  String get noLocationAvailable =>
      'Locație indisponibilă — apasă lung pe hartă în schimb.';

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
  String get renameField => 'Redenumește câmpul';

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
      'Începe aici, apoi introdu adresa și PIN-ul pe celălalt dispozitiv.';

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
      'Sincronizează printr-un dosar purtat între dispozitive de un cloud sau un stick USB — pentru cei care nu sunt în aceeași rețea.';

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
  String get orPlaceClowderHere => 'Sau plasează un clowder aici:';

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
  String get coffeeSubtitle => 'Complet opțional — aplicația e gratuită';

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
  String get starterPosition => 'Poziție';

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
  String get markPrivate => 'Marchează ca privat';

  @override
  String get unmarkPrivate => 'Elimină marcajul privat';

  @override
  String get includePrivate => 'Include datele private';

  @override
  String get includePrivateExplainer =>
      'Pisicile, grupurile și câmpurile private sunt de asemenea partajate — activează doar când îți sincronizezi propriile dispozitive.';

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
  String get starterStatus => 'Stare';

  @override
  String get statusFoster => 'Casă de plasament';

  @override
  String get statusForeverHome => 'Cămin definitiv';

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
      'Confetti și urale când o pisică se mută în căminul definitiv';

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
  String get syncChooserInPersonSub =>
      'Sunteți în aceeași cameră — scanează un cod, gata în secunde';

  @override
  String get syncChooserRemote => 'De la distanță';

  @override
  String get syncChooserRemoteSub =>
      'Printr-un dosar partajat precum Dropbox sau un stick USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Trimite totul ca un singur fișier prin orice messenger';

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
  String get introTitle1 => 'Pisicile trăiesc în clowdere';

  @override
  String get introBody1 =>
      'Un clowder e un loc unde trăiesc pisici: casa ta de plasament, apartamentul unui adoptator, hambarul de alături. Fiecare pisică are o fișă cu poză, date și toată povestea ei.';

  @override
  String get introTitle2 => 'Totul rămâne la tine';

  @override
  String get introBody2 =>
      'Fără cont, fără cloud, fără urmărire. Datele tale trăiesc pe dispozitivul tău.';

  @override
  String get introTitle3 => 'Împarte cu ajutoarele tale';

  @override
  String get introBody3 =>
      'Scanează un cod și două dispozitive se sincronizează în secunde, folosește un dosar partajat sau trimite totul ca un fișier.';

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
      'Nou: sincronizarea oferă acum trei căi clare — și o întrebare de încredere înainte să curgă ceva.';

  @override
  String get spotMapSearch =>
      'Nou: caută aici pisici, clowdere și persoane — direct pe hartă.';

  @override
  String get spotCardChips =>
      'Nou: alege ce apare pe fișă înainte s-o distribui.';

  @override
  String get spotCatMenu =>
      'Nou: marchează o pisică drept privată (nu părăsește niciodată dispozitivul) sau ascunde-o aici.';

  @override
  String get spotDone => 'Am înțeles';

  @override
  String get spotReplayTitle => 'Turul noutăților';

  @override
  String get spotReplaySubtitle => 'Arată indiciile din nou pe fiecare pagină';

  @override
  String get spotReplayDone => 'Indiciile vor apărea din nou';
}
