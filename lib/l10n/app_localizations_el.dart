// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Καλώς ήρθατε στο cat(a)log';

  @override
  String get welcomeBody =>
      'Διαλέξτε ένα όνομα για εσάς. Κάθε αλλαγή καταγράφεται με αυτό το όνομα, ώστε οι άλλοι να βλέπουν ποιος έκανε τι.';

  @override
  String get yourName => 'Το όνομά σας';

  @override
  String get start => 'Έναρξη';

  @override
  String get clowders => 'Ομάδες';

  @override
  String get noClowdersYet =>
      'Δεν υπάρχουν ομάδες ακόμα.\nΔημιουργήστε την πρώτη παρακάτω.';

  @override
  String get strays => 'Αδέσποτα';

  @override
  String get searchCats => 'Αναζήτηση γατών';

  @override
  String get map => 'Χάρτης';

  @override
  String get sync => 'Συγχρονισμός';

  @override
  String get fields => 'Πεδία';

  @override
  String get exportCsv => 'Εξαγωγή CSV';

  @override
  String get aboutAndFeedback => 'Σχετικά & σχόλια';

  @override
  String get newClowder => 'Νέα ομάδα';

  @override
  String get name => 'Όνομα';

  @override
  String get cancel => 'Άκυρο';

  @override
  String get create => 'Δημιουργία';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get merge => 'Συγχώνευση';

  @override
  String get resolve => 'Απόφαση';

  @override
  String get open => 'Άνοιγμα';

  @override
  String csvSavedTo(String path) {
    return 'Το CSV αποθηκεύτηκε στο $path';
  }

  @override
  String get renameClowder => 'Μετονομασία ομάδας';

  @override
  String get rename => 'Μετονομασία';

  @override
  String get timeline => 'Χρονολόγιο';

  @override
  String get mergeInto => 'Συγχώνευση με…';

  @override
  String get deleteClowder => 'Διαγραφή ομάδας';

  @override
  String get cats => 'Γάτες';

  @override
  String get addCat => 'Προσθήκη γάτας';

  @override
  String get newCat => 'Νέα γάτα';

  @override
  String deleteQuestion(String name) {
    return 'Διαγραφή του $name;';
  }

  @override
  String get deleteClowderEmptyBody => 'Η ομάδα εξαφανίζεται από τη λίστα.';

  @override
  String deleteClowderBody(int count) {
    return 'Οι $count γάτες της δεν διαγράφονται — γίνονται αδέσποτες. Μετακινήστε τις πρώτα σε άλλη ομάδα αν δεν το θέλετε αυτό.';
  }

  @override
  String get card => 'Καρτέλα';

  @override
  String get shareAsImage => 'Κοινοποίηση ως εικόνα';

  @override
  String get shareAsPdf => 'Κοινοποίηση ως PDF';

  @override
  String get print => 'Εκτύπωση';

  @override
  String cardTitle(String name) {
    return 'Καρτέλα — $name';
  }

  @override
  String get renameCat => 'Μετονομασία γάτας';

  @override
  String get seenHereNow => 'Εθεάθη εδώ τώρα';

  @override
  String get deleteCat => 'Διαγραφή γάτας';

  @override
  String get clowderLabel => 'Ομάδα';

  @override
  String get strayNoClowder => 'Αδέσποτη — χωρίς ομάδα';

  @override
  String get stray => 'Αδέσποτη';

  @override
  String get photos => 'Φωτογραφίες';

  @override
  String get addPhoto => 'Προσθήκη φωτογραφίας';

  @override
  String get setAsProfileImage => 'Ορισμός ως φωτογραφία προφίλ';

  @override
  String get thisIsProfileImage => 'Αυτή είναι η φωτογραφία προφίλ';

  @override
  String get deletePhoto => 'Διαγραφή φωτογραφίας';

  @override
  String get deletePhotoTitle => 'Διαγραφή φωτογραφίας;';

  @override
  String get deletePhotoBody =>
      'Τα δεδομένα της φωτογραφίας διαγράφονται οριστικά — δεν αναιρείται.';

  @override
  String get deleteCatBody =>
      'Η γάτα εξαφανίζεται από όλες τις λίστες. Οι φωτογραφίες της διαγράφονται οριστικά.';

  @override
  String get sightingRecorded => 'Η παρατήρηση καταγράφηκε στη θέση σας.';

  @override
  String get noLocationAvailable =>
      'Δεν υπάρχει τοποθεσία — πατήστε παρατεταμένα στον χάρτη.';

  @override
  String get moveTo => 'Μετακίνηση σε';

  @override
  String get noClowderStrayOption => 'Χωρίς ομάδα — αδέσποτη / το έσκασε';

  @override
  String timelineOf(String name) {
    return 'Χρονολόγιο — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Αναίρεση αυτής της αλλαγής';

  @override
  String get revertSubtitle =>
      'Επαναφέρει την προηγούμενη τιμή ως νέα εγγραφή — το ιστορικό κρατά και τις δύο.';

  @override
  String fieldCleared(String field) {
    return 'Το $field καθαρίστηκε';
  }

  @override
  String fieldBackTo(String field, String value) {
    return 'Το $field επανήλθε σε \"$value\"';
  }

  @override
  String get leftStray => 'Έφυγε — αδέσποτη';

  @override
  String movedTo(String name) {
    return 'Μετακινήθηκε σε $name';
  }

  @override
  String arrivedPlain(String cat) {
    return 'Η $cat ήρθε';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return 'Η $cat ήρθε από $place';
  }

  @override
  String leftTo(String cat, String place) {
    return 'Η $cat πήγε σε $place';
  }

  @override
  String get duplicateMergedIn => 'Συγχωνεύτηκε διπλότυπο';

  @override
  String get asOfToday => 'Με σημερινή ημερομηνία';

  @override
  String asOfDate(String date) {
    return 'Με ημερομηνία $date';
  }

  @override
  String get value => 'Τιμή';

  @override
  String get latitudeLongitude => 'γεωγρ. πλάτος, μήκος';

  @override
  String get newField => 'Νέο πεδίο';

  @override
  String get fieldType => 'Τύπος';

  @override
  String get usedOn => 'Χρήση για';

  @override
  String get forCats => 'γάτες';

  @override
  String get forClowders => 'ομάδες';

  @override
  String get forBoth => 'και τα δύο';

  @override
  String get optionsOnePerLine => 'Επιλογές (μία ανά γραμμή)';

  @override
  String get renameField => 'Μετονομασία πεδίου';

  @override
  String get noStraysRightNow => 'Δεν υπάρχουν αδέσποτα αυτή τη στιγμή.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Προσθήκη αδέσποτης';

  @override
  String get newStray => 'Νέα αδέσποτη';

  @override
  String get searchByNameHint => 'Αναζήτηση γατών με όνομα…';

  @override
  String get host => 'Φιλοξενία';

  @override
  String get hostExplainer =>
      'Ξεκινήστε εδώ και μετά εισαγάγετε διεύθυνση και PIN στην άλλη συσκευή.';

  @override
  String get startHosting => 'Έναρξη φιλοξενίας';

  @override
  String get stopHosting => 'Διακοπή φιλοξενίας';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Συνεδρίες μέχρι τώρα: $count';
  }

  @override
  String get join => 'Σύνδεση';

  @override
  String get addressFromHost => 'Διεύθυνση (από τη συσκευή-οικοδεσπότη)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Συγχρονισμός τώρα';

  @override
  String get addressFormatHint =>
      'Η διεύθυνση πρέπει να μοιάζει με 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Συγχρονίστηκε: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Αποτυχία συγχρονισμού: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Τελευταίος συγχρονισμός με $peer: $time';
  }

  @override
  String get sharedFolder => 'Κοινός φάκελος';

  @override
  String get sharedFolderExplainer =>
      'Συγχρονισμός μέσω φακέλου που μεταφέρει ένα cloud ή ένα USB stick μεταξύ συσκευών — για όσους δεν είναι στο ίδιο δίκτυο.';

  @override
  String get noFolderChosenYet => 'Δεν έχει επιλεγεί φάκελος ακόμα';

  @override
  String get choose => 'Επιλογή…';

  @override
  String get syncFolderNow => 'Συγχρονισμός φακέλου τώρα';

  @override
  String folderSynced(String result) {
    return 'Ο φάκελος συγχρονίστηκε: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Αποτυχία συγχρονισμού φακέλου: $error';
  }

  @override
  String get recordSightingHere => 'Καταγραφή παρατήρησης εδώ:';

  @override
  String get orPlaceClowderHere => 'Ή τοποθέτηση ομάδας εδώ:';

  @override
  String trailOf(String name, int count) {
    return 'Διαδρομή: $name ($count παρατηρήσεις)';
  }

  @override
  String conflictOn(String field) {
    return 'Σύγκρουση — $field';
  }

  @override
  String get conflictBody =>
      'Άλλαξε σε δύο μέρη ταυτόχρονα. Διαλέξτε τι ισχύει:';

  @override
  String mergeThisInto(String kind) {
    return 'Συγχώνευση αυτού ($kind) με…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Δεν υπάρχει άλλο ($kind) για συγχώνευση.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Συγχώνευση με $name;';
  }

  @override
  String mergeBody(String name) {
    return 'Οι δύο εγγραφές γίνονται μία. Η $name κρατά τις τρέχουσες τιμές της· το ιστορικό της άλλης προστίθεται. Δεν αναιρείται.';
  }

  @override
  String get kindCat => 'γάτα';

  @override
  String get kindClowder => 'ομάδα';

  @override
  String get kindField => 'πεδίο';

  @override
  String get takePhoto => 'Λήψη φωτογραφίας';

  @override
  String get chooseFromGallery => 'Επιλογή από τη συλλογή';

  @override
  String get about => 'Σχετικά';

  @override
  String get aboutTagline =>
      'Τοπικός κατάλογος για γάτες σε ανάδοχες οικογένειες. Τα δεδομένα σας μένουν στις συσκευές σας — χωρίς διακομιστή, χωρίς λογαριασμό.';

  @override
  String versionLabel(String version, String build) {
    return 'Έκδοση $version ($build)';
  }

  @override
  String get sourceCode => 'Πηγαίος κώδικας';

  @override
  String get reportProblemOrIdea => 'Αναφορά προβλήματος ή ιδέας';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Γράψτε στον προγραμματιστή';

  @override
  String get buyCoffee => 'Κεράστε τον προγραμματιστή έναν καφέ';

  @override
  String get coffeeSubtitle => 'Εντελώς προαιρετικό — η εφαρμογή είναι δωρεάν';

  @override
  String get openSourceLicenses => 'Άδειες ανοιχτού κώδικα';

  @override
  String get machineTranslated =>
      'Οι μεταφράσεις είναι μηχανικές — διορθώσεις ευπρόσδεκτες στο GitHub.';

  @override
  String get unnamed => '(χωρίς όνομα)';

  @override
  String get labelName => 'Όνομα';

  @override
  String get labelProfileImage => 'Φωτογραφία προφίλ';

  @override
  String get labelPhoto => 'Φωτογραφία';

  @override
  String get starterGender => 'Φύλο';

  @override
  String get starterColor => 'Χρώμα';

  @override
  String get starterNeutered => 'Στειρωμένη';

  @override
  String get starterPregnant => 'Έγκυος';

  @override
  String get starterBirthdate => 'Ημερομηνία γέννησης';

  @override
  String get starterDeceased => 'Απεβίωσε';

  @override
  String get starterAddress => 'Διεύθυνση';

  @override
  String get starterResponsible => 'Υπεύθυνο άτομο';

  @override
  String get starterPosition => 'Θέση';

  @override
  String get valueYes => 'ναι';

  @override
  String get valueNo => 'όχι';

  @override
  String get valueFemale => 'θηλυκό';

  @override
  String get valueMale => 'αρσενικό';

  @override
  String get valueUnknown => 'άγνωστο';

  @override
  String get cropTitle => 'Περικοπή φωτογραφίας';

  @override
  String get markTitle => 'Σήμανση της γάτας';

  @override
  String get useFullPhoto => 'Χρήση ολόκληρης της φωτογραφίας';

  @override
  String get dragToSelect => 'Σύρετε ένα ορθογώνιο γύρω από τη γάτα';

  @override
  String get dragOverTheCat => 'Σύρετε μια έλλειψη πάνω στη γάτα';

  @override
  String get cropPhoto => 'Περικοπή…';

  @override
  String get markPhoto => 'Σήμανση…';

  @override
  String get scanCode => 'Σάρωση κωδικού';

  @override
  String get orTypeCode => 'Ή πληκτρολογήστε τον κωδικό';

  @override
  String get copyCode => 'Αντιγραφή κωδικού';

  @override
  String get copied => 'Αντιγράφηκε';

  @override
  String get invalidCode => 'Ο κωδικός δεν είναι έγκυρος';

  @override
  String get hotspotHint =>
      'Χωρίς κοινό Wi-Fi; Ανοίξτε το hotspot του ενός τηλεφώνου, συνδέστε το άλλο και φιλοξενήστε εδώ.';

  @override
  String get byMessenger => 'Μέσω messenger';

  @override
  String get byMessengerExplainer =>
      'Στείλτε όλο τον κατάλογο ως ένα αρχείο με WhatsApp, Signal ή mail — η άλλη πλευρά τον εισάγει.';

  @override
  String get shareBundle => 'Κοινοποίηση πακέτου συγχρονισμού…';

  @override
  String get importBundle => 'Εισαγωγή πακέτου συγχρονισμού…';

  @override
  String bundleImported(String result) {
    return 'Το πακέτο εισήχθη: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Η εισαγωγή απέτυχε: $error';
  }

  @override
  String get pickOnMap => 'Επιλογή στον χάρτη';

  @override
  String get useMyLocation => 'Χρήση της θέσης μου';

  @override
  String get language => 'Γλώσσα';

  @override
  String get systemDefault => 'Προεπιλογή συστήματος';

  @override
  String get iosLocalNetworkHint =>
      'Αν συνεχίζει να αποτυγχάνει σε iPhone/iPad: Ρυθμίσεις → Απόρρητο και ασφάλεια → Τοπικό δίκτυο → επιτρέψτε το cat(a)log και δοκιμάστε ξανά.';

  @override
  String get markPrivate => 'Σήμανση ως ιδιωτικό';

  @override
  String get unmarkPrivate => 'Αφαίρεση ιδιωτικής σήμανσης';

  @override
  String get includePrivate => 'Συμπερίληψη ιδιωτικών δεδομένων';

  @override
  String get includePrivateExplainer =>
      'Ιδιωτικές γάτες, ομάδες και πεδία κοινοποιούνται επίσης — ενεργοποιήστε το μόνο όταν συγχρονίζετε δικές σας συσκευές.';

  @override
  String get hideLabel => 'Απόκρυψη σε αυτήν τη συσκευή';

  @override
  String get unhideLabel => 'Εμφάνιση ξανά';

  @override
  String get showHiddenLabel => 'Εμφάνιση κρυφών';

  @override
  String get stopShowingHidden => 'Διακοπή εμφάνισης κρυφών';

  @override
  String get starterSpecies => 'Είδος';

  @override
  String get starterStatus => 'Κατάσταση';

  @override
  String get statusFoster => 'Ανάδοχο σπίτι';

  @override
  String get statusForeverHome => 'Μόνιμο σπίτι';

  @override
  String get statusClinic => 'Κλινική';

  @override
  String get statusShelter => 'Καταφύγιο';

  @override
  String get statusBarn => 'Αχυρώνας';

  @override
  String get valueCat => 'Γάτα';

  @override
  String get otherOption => 'Άλλο…';

  @override
  String get celebrationsToggle => 'Γιορτή υιοθεσιών';

  @override
  String get celebrationsSubtitle =>
      'Κομφετί και ζητωκραυγές όταν μια γάτα μετακομίζει στο μόνιμο σπίτι της';

  @override
  String get onMapLabel => 'Στον χάρτη';

  @override
  String get showOnMap => 'Εμφάνιση στον χάρτη';

  @override
  String get searchPlaceHint => 'Αναζήτηση τοποθεσίας ή διεύθυνσης';

  @override
  String get noPlacesFound => 'Δεν βρέθηκαν τοποθεσίες';

  @override
  String get mapSearchHint => 'Αναζήτηση γατών, ομάδων, ατόμων';

  @override
  String get proposeAnotherName => 'Πρότεινε άλλο όνομα';

  @override
  String get moderationTitle => 'Συντάκτες & αποκλεισμοί';

  @override
  String get moderationSubtitle => 'Οριστική αφαίρεση δεδομένων ατόμου';

  @override
  String get authorsSection => 'Ποιος έγραψε στον κατάλογο';

  @override
  String get hardDeleteAction => 'Διαγραφή όλων από αυτόν τον συντάκτη';

  @override
  String hardDeleteWarning(Object name) {
    return 'Αφαιρεί κάθε καταχώρηση και φωτογραφία του $name από αυτήν τη συσκευή. Οι άλλες συσκευές κρατούν τις δικές τους. Δεν αναιρείται.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Πληκτρολογήστε $name για επιβεβαίωση';
  }

  @override
  String get alsoBan => 'Και αποκλεισμός — ποτέ ξανά δεδομένα του';

  @override
  String get bansSection => 'Αποκλεισμοί';

  @override
  String get unbanAction => 'Άρση αποκλεισμού';

  @override
  String get deletedDone => 'Διαγράφηκε.';

  @override
  String get syncSummaryTitle => 'Τι έφτασε';

  @override
  String get summaryAdopted => 'Υιοθετήθηκαν';

  @override
  String get summaryDeceased => 'Αποβίωσαν';

  @override
  String get summaryEscaped => 'Δραπέτευσαν';

  @override
  String get summaryNew => 'Νέα';

  @override
  String get summaryConflicts => 'Συγκρούσεις προς επίλυση';

  @override
  String summaryOther(Object n) {
    return '…και $n άλλες αλλαγές';
  }

  @override
  String get starterMother => 'Μητέρα';

  @override
  String get starterFather => 'Πατέρας';

  @override
  String get familySection => 'Οικογένεια';

  @override
  String get littermatesLabel => 'Από την ίδια γέννα';

  @override
  String get siblingsLabel => 'Αδέλφια';

  @override
  String get kittensLabel => 'Γατάκια';

  @override
  String get toastSettingsTitle => 'Τι ανακοινώνεται';

  @override
  String get toastSettingsSubtitle => 'Μικρά μηνύματα μετά τον συγχρονισμό';

  @override
  String get toastKindAdoptions => 'Υιοθεσίες';

  @override
  String get toastKindBirths => 'Γέννες';

  @override
  String get toastKindDeaths => 'Θάνατοι';

  @override
  String get toastKindEscapes => 'Αποδράσεις';

  @override
  String get toastKindMoves => 'Μετακομίσεις';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 Η $cat υιοθετήθηκε από $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Νέο γατάκι: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return 'Η $cat έφυγε από τη ζωή';
  }

  @override
  String toastEscaped(Object cat) {
    return 'Η $cat δραπέτευσε';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return 'Η $cat μετακόμισε στο $home';
  }

  @override
  String get notACatlogFile => 'Αυτό δεν είναι αρχείο cat(a)log';

  @override
  String get nothingNewInBundle => 'Τίποτα νέο στο αρχείο — τα έχεις ήδη όλα';

  @override
  String get syncChooserInPerson => 'Από κοντά';

  @override
  String get syncChooserInPersonSub =>
      'Είστε στον ίδιο χώρο — σκανάρετε έναν κωδικό, έτοιμο σε δευτερόλεπτα';

  @override
  String get syncChooserRemote => 'Απομακρυσμένα';

  @override
  String get syncChooserRemoteSub =>
      'Μέσω κοινόχρηστου φακέλου όπως Dropbox ή USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Στείλτε τα όλα ως ένα αρχείο με οποιονδήποτε messenger';

  @override
  String get connectToWifiFirst =>
      'Συνδεθείτε πρώτα σε Wi-Fi — τότε οι συσκευές βρίσκονται';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) θέλει συγχρονισμό';
  }

  @override
  String get trustBothWaysNote =>
      'Οι κατάλογοι θα ανταλλαγούν και προς τις δύο κατευθύνσεις.';

  @override
  String get allowOnce => 'Επιτρέπω';

  @override
  String get allowAlways => 'Πάντα να επιτρέπεται αυτή η συσκευή';

  @override
  String get declineAction => 'Απόρριψη';

  @override
  String get syncDeclined => 'Η άλλη συσκευή απέρριψε τον συγχρονισμό';

  @override
  String get trustedDevicesSection => 'Πάντα επιτρεπόμενες συσκευές';

  @override
  String get removeTrust => 'Αφαίρεση';

  @override
  String get hostWithoutWifi => 'Φιλοξενία χωρίς Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Δημιουργεί μια προσωρινή απευθείας σύνδεση με το άλλο τηλέφωνο (χωρίς ίντερνετ). Μόνο το cat(a)log τη χρησιμοποιεί και αποσυνδέεται μόνη της μετά τον συγχρονισμό.';

  @override
  String get hotspotAndroidOnly =>
      'Αυτός ο κωδικός χρειάζεται δύο Android — σε iPhone/iPad χρησιμοποιήστε κοινό Wi-Fi';
}
