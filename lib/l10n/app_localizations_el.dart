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
  String get clowdersNeutral => 'Νοικοκυριά';

  @override
  String get noClowdersYet =>
      'Κανένα clowder ακόμη. Το clowder είναι ένα μέρος όπου ζουν γάτες — το ανάδοχο σπίτι σου, το διαμέρισμα ενός υιοθέτη. Φτιάξε το πρώτο παρακάτω.';

  @override
  String get noClowdersYetNeutral =>
      'Κανένα νοικοκυριό ακόμη. Το νοικοκυριό είναι ένα μέρος όπου ζουν κατοικίδια — το σπίτι σου, ένα ανάδοχο σπίτι, το διαμέρισμα ενός υιοθέτη. Φτιάξε το πρώτο παρακάτω.';

  @override
  String get strays => 'Αδέσποτα';

  @override
  String get searchCats => 'Αναζήτηση γατών';

  @override
  String get searchCatsNeutral => 'Αναζήτηση κατοικιδίων';

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
  String get settings => 'Ρυθμίσεις';

  @override
  String get newClowder => 'Νέα ομάδα';

  @override
  String get newClowderNeutral => 'Νέο νοικοκυριό';

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
  String get renameClowderNeutral => 'Μετονομασία νοικοκυριού';

  @override
  String get rename => 'Μετονομασία';

  @override
  String get timeline => 'Χρονολόγιο';

  @override
  String get mergeInto => 'Συγχώνευση με…';

  @override
  String get deleteClowder => 'Διαγραφή ομάδας';

  @override
  String get deleteClowderNeutral => 'Διαγραφή νοικοκυριού';

  @override
  String get cats => 'Γάτες';

  @override
  String get catsNeutral => 'Κατοικίδια';

  @override
  String get addCat => 'Προσθήκη γάτας';

  @override
  String get addCatNeutral => 'Προσθήκη κατοικιδίου';

  @override
  String get newCat => 'Νέα γάτα';

  @override
  String get newCatNeutral => 'Νέο κατοικίδιο';

  @override
  String deleteQuestion(String name) {
    return 'Διαγραφή του $name;';
  }

  @override
  String get deleteClowderEmptyBody => 'Η ομάδα εξαφανίζεται από τη λίστα.';

  @override
  String get deleteClowderEmptyBodyNeutral =>
      'Το νοικοκυριό εξαφανίζεται από τη λίστα.';

  @override
  String deleteClowderBody(int count) {
    return 'Οι $count γάτες της δεν διαγράφονται — γίνονται αδέσποτες. Μετακινήστε τις πρώτα σε άλλη ομάδα αν δεν το θέλετε αυτό.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Τα $count κατοικίδιά του δεν διαγράφονται — γίνονται αδέσποτα. Μετακινήστε τα πρώτα σε άλλο νοικοκυριό αν δεν το θέλετε αυτό.';
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
  String get renameCatNeutral => 'Μετονομασία κατοικιδίου';

  @override
  String get seenHereNow => 'Εθεάθη εδώ τώρα';

  @override
  String get deleteCat => 'Διαγραφή γάτας';

  @override
  String get deleteCatNeutral => 'Διαγραφή κατοικιδίου';

  @override
  String get clowderLabel => 'Ομάδα';

  @override
  String get clowderLabelNeutral => 'Νοικοκυριό';

  @override
  String get strayNoClowder => 'Αδέσποτη — χωρίς ομάδα';

  @override
  String get strayNoClowderNeutral => 'Αδέσποτο — χωρίς νοικοκυριό';

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
      'Η γάτα εξαφανίζεται από όλες τις λίστες και οι φωτογραφίες της αφαιρούνται — εδώ και, μετά τον επόμενο συγχρονισμό, και στις άλλες συσκευές.';

  @override
  String get deleteCatBodyNeutral =>
      'Το κατοικίδιο εξαφανίζεται από όλες τις λίστες και οι φωτογραφίες του αφαιρούνται — εδώ και, μετά τον επόμενο συγχρονισμό, και στις άλλες συσκευές.';

  @override
  String get sightingRecorded => 'Η παρατήρηση καταγράφηκε στη θέση σας.';

  @override
  String get noLocationAvailable =>
      'Δεν υπάρχει τοποθεσία — πατήστε παρατεταμένα στον χάρτη.';

  @override
  String get locationDeniedForever =>
      'Η πρόσβαση στην τοποθεσία είναι αποκλεισμένη. Επιτρέψτε την στις ρυθμίσεις συστήματος για να χρησιμοποιήσετε το Stray Cam.';

  @override
  String get locationServiceOff =>
      'Η τοποθεσία είναι απενεργοποιημένη σε αυτήν τη συσκευή. Ενεργοποιήστε την στις ρυθμίσεις και δοκιμάστε ξανά.';

  @override
  String get locationDenied =>
      'Το cat(a)log δεν έχει άδεια να χρησιμοποιεί την τοποθεσία σας. Δοκιμάστε ξανά και επιτρέψτε την όταν ερωτηθείτε.';

  @override
  String get locationNoFix =>
      'Η θέση σας δεν μπόρεσε να προσδιοριστεί τώρα. Δοκιμάστε ξανά σε ανοιχτό χώρο — το GPS χρειάζεται καθαρή θέα στον ουρανό.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Αριθμός τσιπ';

  @override
  String get starterRemarks => 'Σημειώσεις';

  @override
  String get captureFlier => 'Φωτογράφιση αφίσας';

  @override
  String get addPhotosTo => 'Προσθήκη φωτογραφιών σε…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count φωτογραφίες προστέθηκαν σε $name';
  }

  @override
  String get scanPrintedCode => 'Σάρωση τυπωμένου κωδικού';

  @override
  String get chipScanHint =>
      'Σαρώνει τον τυπωμένο κωδικό QR/γραμμωτό από την κάρτα τσιπ ή τα κτηνιατρικά έγγραφα — το τηλέφωνο δεν μπορεί να διαβάσει το τσιπ μέσα στη γάτα.';

  @override
  String get chipScanHintNeutral =>
      'Σαρώνει τον τυπωμένο κωδικό QR/γραμμωτό από την κάρτα τσιπ ή τα κτηνιατρικά έγγραφα — το τηλέφωνο δεν μπορεί να διαβάσει το τσιπ μέσα στο ζώο.';

  @override
  String get savingLabel => 'Αποθήκευση…';

  @override
  String ownerOfCat(String name) {
    return 'Ιδιοκτήτης του/της $name';
  }

  @override
  String get sortLabel => 'Ταξινόμηση';

  @override
  String get viewAsTable => 'Προβολή ως πίνακα';

  @override
  String get viewAsTiles => 'Προβολή ως πλακίδια';

  @override
  String get viewAsList => 'Εμφάνιση ως λίστα';

  @override
  String get ageLabel => 'Ηλικία';

  @override
  String get catList => 'Λίστα γατών';

  @override
  String get catListNeutral => 'Λίστα κατοικιδίων';

  @override
  String get matchCandidatesTitle => 'Πιθανές αντιστοιχίες';

  @override
  String get findDuplicates => 'Εύρεση διπλότυπων';

  @override
  String get noDuplicates => 'Κανένα πιθανό διπλότυπο αυτήν τη στιγμή.';

  @override
  String get similarName => 'Παρόμοιο όνομα';

  @override
  String get sharePublicly => 'Δημόσια κοινοποίηση…';

  @override
  String get pickFramesTitle => 'Επιλογή καρέ';

  @override
  String get suggestedFrames => 'Προτεινόμενα καρέ';

  @override
  String get scrubFrames => 'Μετακίνηση στο βίντεο';

  @override
  String get keepThisFrame => 'Κράτησε αυτό το καρέ';

  @override
  String get fromVideo => 'Από βίντεο…';

  @override
  String get videoMobileOnly =>
      'Η επιλογή καρέ από βίντεο λειτουργεί στην εφαρμογή τηλεφώνου (Android και iPhone) — όχι ακόμη σε αυτήν τη συσκευή.';

  @override
  String get shareWhitelistExplainer =>
      'Διάλεξε τι μπαίνει στο αρχείο. Περιλαμβάνονται μόνο τα τσεκαρισμένα πεδία.';

  @override
  String get exportShareFile => 'Εξαγωγή αρχείου κοινοποίησης…';

  @override
  String get hostedLink => 'Φιλοξενούμενος σύνδεσμος (URL του αρχείου)';

  @override
  String get inlineQr => 'Ενσωματωμένο QR (μόνο κείμενο, χωρίς φωτογραφίες)';

  @override
  String get inlineTooBig =>
      'Πολλά δεδομένα για ενσωματωμένο κώδικα — αποεπιλέξτε πεδία ή χρησιμοποιήστε σύνδεσμο.';

  @override
  String get scanShareLabel => 'Σάρωση κωδικού κοινοποίησης';

  @override
  String get notAShareCode =>
      'Αυτός ο κωδικός δεν είναι κοινοποίηση cat(a)log.';

  @override
  String get importShareTitle => 'Εισαγωγή αυτής της γάτας;';

  @override
  String get importShareTitleNeutral => 'Εισαγωγή αυτού του κατοικιδίου;';

  @override
  String shareSource(String url) {
    return 'Πηγή: $url';
  }

  @override
  String get importLabel => 'Εισαγωγή';

  @override
  String get strayAreaLabel => 'Πιθανή περιοχή περιπλάνησης';

  @override
  String get prevPin => 'Προηγούμενη πινέζα';

  @override
  String get nextPin => 'Επόμενη πινέζα';

  @override
  String get noMissingCats => 'Καμία εξαφανισμένη γάτα με θέσεις αφισών ακόμη.';

  @override
  String get noMissingCatsNeutral =>
      'Κανένα εξαφανισμένο κατοικίδιο με θέσεις αφισών ακόμη.';

  @override
  String get noMatchCandidates => 'Καμία πιθανή αντιστοιχία αυτήν τη στιγμή.';

  @override
  String sameIdField(String field) {
    return 'Ίδιο $field';
  }

  @override
  String metersApart(String distance) {
    return 'Απέχουν $distance μ.';
  }

  @override
  String get addFlier => 'Προσθήκη αφίσας';

  @override
  String get missingSinceLabel => 'Αγνοείται από';

  @override
  String get phoneLabel => 'Τηλέφωνο';

  @override
  String get cropPortrait => 'Περικοπή πορτρέτου';

  @override
  String get statusOwner => 'Ιδιοκτήτης';

  @override
  String get ocrUnavailable =>
      'Η αναγνώριση κειμένου δεν είναι διαθέσιμη σε αυτήν τη συσκευή — πληκτρολογήστε το κείμενο της αφίσας.';

  @override
  String get displayFormat => 'Εμφάνιση ως';

  @override
  String get displayPlain => 'Απλό κείμενο';

  @override
  String get displayQr => 'Κωδικός QR';

  @override
  String get displayBarcode => 'Γραμμωτός κώδικας';

  @override
  String get editLabel => 'Επεξεργασία';

  @override
  String get doneLabel => 'Έτοιμο';

  @override
  String get openSettings => 'Άνοιγμα ρυθμίσεων';

  @override
  String get notSaved => 'Δεν αποθηκεύτηκε';

  @override
  String get birthdateInFuture =>
      'Η ημερομηνία γέννησης δεν μπορεί να είναι στο μέλλον.';

  @override
  String get deceasedInFuture =>
      'Η ημερομηνία θανάτου δεν μπορεί να είναι στο μέλλον.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Η ημερομηνία θανάτου δεν μπορεί να είναι πριν από την ημερομηνία γέννησης ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Η ημερομηνία γέννησης δεν μπορεί να είναι μετά την ημερομηνία θανάτου ($date).';
  }

  @override
  String get malePregnant =>
      'Αυτή η γάτα είναι καταχωρισμένη ως αρσενική — ένας αρσενικός γάτος δεν μπορεί να είναι έγκυος. Ελέγξτε πρώτα το φύλο.';

  @override
  String get malePregnantNeutral =>
      'Αυτό το κατοικίδιο είναι καταχωρισμένο ως αρσενικό — ένα αρσενικό δεν μπορεί να είναι έγκυο. Ελέγξτε πρώτα το φύλο.';

  @override
  String fatherNotMale(String name) {
    return 'Η $name είναι καταχωρισμένη ως θηλυκή και δεν μπορεί να είναι ο πατέρας. Ελέγξτε πρώτα το φύλο.';
  }

  @override
  String motherNotFemale(String name) {
    return 'Ο $name είναι καταχωρισμένος ως αρσενικός και δεν μπορεί να είναι η μητέρα. Ελέγξτε πρώτα το φύλο.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return 'Ο/Η $name γεννήθηκε στις $date — ένας γονιός δεν μπορεί να γεννηθεί μετά το μικρό του.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return 'Ο/Η $name γεννήθηκε στις $date — ένας γονιός δεν μπορεί να γεννηθεί μετά το μικρό του.';
  }

  @override
  String get genderFatherFemale =>
      'Αυτή η γάτα είναι καταχωρισμένη ως πατέρας άλλων γατών — ο πατέρας δεν μπορεί να είναι θηλυκός. Ελέγξτε πρώτα την οικογένεια.';

  @override
  String get genderFatherFemaleNeutral =>
      'Αυτό το κατοικίδιο είναι καταχωρισμένο ως πατέρας άλλων κατοικιδίων — ο πατέρας δεν μπορεί να είναι θηλυκός. Ελέγξτε πρώτα την οικογένεια.';

  @override
  String get genderMotherMale =>
      'Αυτή η γάτα είναι καταχωρισμένη ως μητέρα άλλων γατών — η μητέρα δεν μπορεί να είναι αρσενική. Ελέγξτε πρώτα την οικογένεια.';

  @override
  String get genderMotherMaleNeutral =>
      'Αυτό το κατοικίδιο είναι καταχωρισμένο ως μητέρα άλλων κατοικιδίων — η μητέρα δεν μπορεί να είναι αρσενική. Ελέγξτε πρώτα την οικογένεια.';

  @override
  String get moveTo => 'Μετακίνηση σε';

  @override
  String get noClowderStrayOption => 'Χωρίς ομάδα — αδέσποτη / το έσκασε';

  @override
  String get noClowderStrayOptionNeutral =>
      'Χωρίς νοικοκυριό — αδέσποτο / το έσκασε';

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
  String dateFormatError(String format) {
    return 'Λάθος μορφή — χρησιμοποιήστε $format';
  }

  @override
  String get dateInFuture =>
      'Αυτή η ημερομηνία δεν μπορεί να είναι στο μέλλον.';

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
  String get forCatsNeutral => 'κατοικίδια';

  @override
  String get forClowders => 'ομάδες';

  @override
  String get forClowdersNeutral => 'νοικοκυριά';

  @override
  String get forBoth => 'και τα δύο';

  @override
  String get optionsOnePerLine => 'Επιλογές (μία ανά γραμμή)';

  @override
  String get ownValue => 'Δική σας τιμή';

  @override
  String get renameField => 'Μετονομασία πεδίου';

  @override
  String get editOptions => 'Επεξεργασία επιλογών…';

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
  String get searchByNameHintNeutral => 'Αναζήτηση κατοικιδίων με όνομα…';

  @override
  String get host => 'Φιλοξενία';

  @override
  String get hostExplainer =>
      'Ξεκινήστε εδώ και μετά σαρώστε τον κωδικό ή εισαγάγετέ τον στην άλλη συσκευή.';

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
      'Και οι δύο συσκευές χρησιμοποιούν τον ίδιο φάκελο (π.χ. στο Dropbox ή σε USB). Κάθε συγχρονισμός αφήνει εκεί τις αλλαγές σου και παίρνει του άλλου.';

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
  String get kindCatNeutral => 'κατοικίδιο';

  @override
  String get kindClowder => 'ομάδα';

  @override
  String get kindClowderNeutral => 'νοικοκυριό';

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
  String get aboutTaglineNeutral =>
      'Τοπικός κατάλογος για τα κατοικίδια που φροντίζεις. Τα δεδομένα σας μένουν στις συσκευές σας — χωρίς διακομιστή, χωρίς λογαριασμό.';

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
  String get coffeeSubtitle =>
      'Η εφαρμογή μένει δωρεάν. Ακόμα κι αν δεν πάρω καφέ :)';

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
  String get starterBreed => 'Ράτσα';

  @override
  String get valueMixed => 'ημίαιμη';

  @override
  String get breedEuropeanShorthair => 'Ευρωπαϊκή κοντότριχη';

  @override
  String get breedMaineCoon => 'Μέιν Κουν';

  @override
  String get breedBritishShorthair => 'Βρετανική κοντότριχη';

  @override
  String get breedNorwegianForestCat => 'Γάτα του Νορβηγικού Δάσους';

  @override
  String get breedRagdoll => 'Ράγκντολ';

  @override
  String get breedSiamese => 'Σιαμαία';

  @override
  String get breedPersian => 'Περσική';

  @override
  String get breedBengal => 'Βεγγάλης';

  @override
  String get breedSphynx => 'Σφίγγα';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Τηλέφωνο';

  @override
  String get lookupUrlLabel => 'Σύνδεσμος αναζήτησης';

  @override
  String lookupUrlHelp(String token) {
    return 'Η σελίδα της υπηρεσίας με $token στη θέση του αριθμού, π.χ. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Αναζήτηση';

  @override
  String lookupFailed(String url) {
    return 'Καμία εφαρμογή δεν άνοιξε το $url. Αντίγραψε τον σύνδεσμο σε φυλλομετρητή.';
  }

  @override
  String get stepCat => 'Γάτα';

  @override
  String get stepCatNeutral => 'Κατοικίδιο';

  @override
  String get stepOwner => 'Ιδιοκτήτης';

  @override
  String get stepFace => 'Φωτογραφία προσώπου';

  @override
  String get stepRegistry => 'Μητρώο';

  @override
  String get stepReview => 'Έλεγχος και αποθήκευση';

  @override
  String get stepOwnerHint =>
      'Όποιος ψάχνει τη γάτα — αυτό γίνεται η ομάδα του, με την επαφή από την αφίσα.';

  @override
  String get stepOwnerHintNeutral =>
      'Όποιος ψάχνει το κατοικίδιο — αυτό γίνεται το νοικοκυριό του, με την επαφή από την αφίσα.';

  @override
  String get stepFaceHint =>
      'Κόψε το πρόσωπο της γάτας από την αφίσα· γίνεται η φωτογραφία προφίλ. Μπορείς να το παραλείψεις.';

  @override
  String get stepFaceHintNeutral =>
      'Κόψε το πρόσωπο του κατοικιδίου από την αφίσα· γίνεται η φωτογραφία προφίλ. Μπορείς να το παραλείψεις.';

  @override
  String get stepRegistryHint =>
      'Αριθμοί που βρέθηκαν στην αφίσα. Οι τσεκαρισμένοι αποθηκεύονται στη γάτα και ανοίγουν αργότερα.';

  @override
  String get stepRegistryHintNeutral =>
      'Αριθμοί που βρέθηκαν στην αφίσα. Οι τσεκαρισμένοι αποθηκεύονται στο κατοικίδιο και ανοίγουν αργότερα.';

  @override
  String get noRegistryLinks =>
      'Δεν υπάρχουν σύνδεσμοι μητρώου σε αυτή την αφίσα — αν κάποιοι διέφυγαν, αναφέρετε σφάλμα.';

  @override
  String get unknownServiceHint => 'Άγνωστη υπηρεσία';

  @override
  String get rememberService => 'Απομνημόνευση υπηρεσίας';

  @override
  String get rememberServiceHint =>
      'Δώσε όνομα στην υπηρεσία και δείξε τον αριθμό στον σύνδεσμο. Η επόμενη αφίσα θα συμπληρωθεί μόνη της.';

  @override
  String get noIdInLink =>
      'Αυτός ο σύνδεσμος δεν έχει αριθμό που να μπορεί να αποθηκευτεί.';

  @override
  String get whichNumber => 'Ποιο μέρος είναι ο αριθμός;';

  @override
  String get cropAgain => 'Νέα περικοπή';

  @override
  String get noFaceYet =>
      'Δεν υπάρχει ακόμη φωτογραφία προσώπου — χρησιμοποιείται η φωτογραφία της αφίσας.';

  @override
  String get backLabel => 'Πίσω';

  @override
  String get dangerButton => 'ΜΗΝ ΠΑΤΑΣ.\nΚΙΝΔΥΝΟΣ';

  @override
  String get dangerThanks => 'Ευχαριστούμε που χρησιμοποιείς το cat(a)log!';

  @override
  String get helpTitle => 'Βοήθεια';

  @override
  String get showTipsAgain => 'Εμφάνιση συμβουλών ξανά';

  @override
  String get helpHome =>
      'Η επισκόπηση των αποικιών σου — αποικία είναι ένας τόπος όπου ζουν γάτες: το σπίτι σου, ένα ανάδοχο σπίτι, ένα καταφύγιο. Πάτησε μια κάρτα για τις γάτες της· παρατεταμένο πάτημα ανοίγει το μενού. Το κουμπί κάτω δεξιά φτιάχνει αποικία, και η κάρτα των αδέσποτων μαζεύει όλες τις γάτες χωρίς σπίτι. Το όνομα επάνω είναι ο κατάλογος στον οποίο βρίσκεσαι — πάτησέ το για αλλαγή ή προσθήκη.';

  @override
  String get helpHomeNeutral =>
      'Η επισκόπηση των νοικοκυριών σου — νοικοκυριό είναι ένας τόπος όπου ζουν κατοικίδια: το σπίτι σου, ένα ανάδοχο σπίτι, ένα καταφύγιο. Πάτησε μια κάρτα για τα κατοικίδιά της· παρατεταμένο πάτημα ανοίγει το μενού. Το κουμπί κάτω δεξιά φτιάχνει νοικοκυριό, και η κάρτα των αδέσποτων μαζεύει όλα τα κατοικίδια χωρίς σπίτι. Το όνομα επάνω είναι ο κατάλογος στον οποίο βρίσκεσαι — πάτησέ το για αλλαγή ή προσθήκη.';

  @override
  String get helpClowder =>
      'Όλα για αυτόν τον τόπο: οι γάτες του, τα πεδία του (διεύθυνση, επαφή, είδος) και το ιστορικό του. Η σελίδα ανοίγει μόνο για ανάγνωση· το μολύβι ενεργοποιεί την επεξεργασία, όπου μπορείς να προσθέσεις και πεδίο. Παρατεταμένο πάτημα σε πεδίο το επεξεργάζεται αμέσως, σε γάτα τη μετακινεί, κρύβει ή ανοίγει. Ένα ραντεβού που προστίθεται εδώ μπορεί να πάρει πολλές γάτες της αποικίας, π.χ. για στείρωση: επιλέξτε τις γάτες που έρχονται, ολοκληρώστε μία φορά, αποεπιλέξτε όσες δεν εξετάστηκαν.';

  @override
  String get helpClowderNeutral =>
      'Όλα για αυτόν τον τόπο: τα κατοικίδιά του, τα πεδία του (διεύθυνση, επαφή, είδος) και το ιστορικό του. Η σελίδα ανοίγει μόνο για ανάγνωση· το μολύβι ενεργοποιεί την επεξεργασία, όπου μπορείς να προσθέσεις και πεδίο. Παρατεταμένο πάτημα σε πεδίο το επεξεργάζεται αμέσως, σε κατοικίδιο το μετακινεί, κρύβει ή ανοίγει. Ένα ραντεβού που προστίθεται εδώ μπορεί να πάρει πολλά κατοικίδια του νοικοκυριού, π.χ. για στείρωση: επιλέξτε τα κατοικίδια που έρχονται, ολοκληρώστε μία φορά, αποεπιλέξτε όσα δεν εξετάστηκαν.';

  @override
  String get helpCat =>
      'Τα πάντα για αυτή τη γάτα: φωτογραφίες, πεδία, οικογένεια, ιστορικό. Η σελίδα είναι μόνο για ανάγνωση μέχρι να πατήσεις το μολύβι. Κράτησε πατημένο ένα πεδίο για να το επεξεργαστείς αμέσως· κράτησε πατημένη μια φωτογραφία για το μενού της. Το μενού πάνω δεξιά έχει τα υπόλοιπα: απόκρυψη, συγχώνευση, καταγραφή θέασης, κοινοποίηση της γάτας. Το «Ιδιωτικό» ορίζεται κατά την επεξεργασία πεδίου.';

  @override
  String get helpCatNeutral =>
      'Τα πάντα για αυτό το κατοικίδιο: φωτογραφίες, πεδία, οικογένεια, ιστορικό. Η σελίδα είναι μόνο για ανάγνωση μέχρι να πατήσεις το μολύβι. Κράτησε πατημένο ένα πεδίο για να το επεξεργαστείς αμέσως· κράτησε πατημένη μια φωτογραφία για το μενού της. Το μενού πάνω δεξιά έχει τα υπόλοιπα: απόκρυψη, συγχώνευση, καταγραφή θέασης, κοινοποίηση του κατοικιδίου. Το «Ιδιωτικό» ορίζεται κατά την επεξεργασία πεδίου.';

  @override
  String get helpStrays =>
      'Γάτες χωρίς σπίτι αυτή τη στιγμή: βρεθείσες, δραπέτες ή από αφίσα. Το κουμπί της κάμερας καταγράφει μια γάτα μπροστά σου· το κουμπί της αφίσας μετατρέπει μια αφίσα σε γάτα με την επαφή του ιδιοκτήτη· ο σαρωτής διαβάζει κωδικό cat(a)log από την αφίσα. Πάτησε το Stray Cam για φωτογραφία· κράτησέ το πατημένο για βίντεο και κράτα τα καλύτερα καρέ ως φωτογραφίες.';

  @override
  String get helpStraysNeutral =>
      'Κατοικίδια χωρίς σπίτι αυτή τη στιγμή: βρεθέντα, δραπέτες ή από αφίσα. Το κουμπί της κάμερας καταγράφει ένα ζώο μπροστά σου· το κουμπί της αφίσας μετατρέπει μια αφίσα σε κατοικίδιο με την επαφή του ιδιοκτήτη· ο σαρωτής διαβάζει κωδικό cat(a)log από την αφίσα. Πάτησε το Stray Cam για φωτογραφία· κράτησέ το πατημένο για βίντεο και κράτα τα καλύτερα καρέ ως φωτογραφίες.';

  @override
  String get helpMap =>
      'Όλες οι γάτες και οι τόποι με θέση. Η αναζήτηση βρίσκει γάτες, ανθρώπους και τόπους — ένα άγνωστο όνομα αναζητείται σε όλο τον κόσμο. Το κουμπί επιπέδων σχεδιάζει τους κύκλους των 500 μ. γύρω από τα σημεία των αφισών μιας χαμένης γάτας και γύρω από το παλιό της σπίτι. Τα βέλη πηγαίνουν από καρφίτσα σε καρφίτσα, παρατεταμένο πάτημα καταγράφει παρατήρηση.';

  @override
  String get helpMapNeutral =>
      'Όλα τα κατοικίδια και οι τόποι με θέση. Η αναζήτηση βρίσκει κατοικίδια, ανθρώπους και τόπους — ένα άγνωστο όνομα αναζητείται σε όλο τον κόσμο. Το κουμπί επιπέδων σχεδιάζει τους κύκλους των 500 μ. γύρω από τα σημεία των αφισών ενός χαμένου κατοικιδίου και γύρω από το παλιό του σπίτι. Τα βέλη πηγαίνουν από καρφίτσα σε καρφίτσα, παρατεταμένο πάτημα καταγράφει παρατήρηση.';

  @override
  String get helpCard =>
      'Η εκτυπώσιμη κάρτα της γάτας: επίλεξε πάνω με τα τσιπάκια τι θα εμφανίζεται και μοιράσου την ως εικόνα ή PDF. Οι αριθμοί τυπώνονται ως QR ή barcode, και μια θέση γίνεται QR που ανοίγει χάρτη, συν έναν σύντομο Plus Code.';

  @override
  String get helpCardNeutral =>
      'Η εκτυπώσιμη κάρτα του κατοικιδίου: επίλεξε πάνω με τα τσιπάκια τι θα εμφανίζεται και μοιράσου την ως εικόνα ή PDF. Οι αριθμοί τυπώνονται ως QR ή barcode, και μια θέση γίνεται QR που ανοίγει χάρτη, συν έναν σύντομο Plus Code.';

  @override
  String get helpSync =>
      'Πώς φτάνουν τα δεδομένα σε άλλους: άμεση σύνδεση, φάκελος που βλέπουν και οι δύο συσκευές, ή αρχείο μέσω messenger. Εσύ αποφασίζεις πάντα τι φεύγει — και τα αρχεία .catsync που λαμβάνεις ανοίγουν επίσης εδώ.';

  @override
  String get helpFields =>
      'Τα πεδία που χρησιμοποιεί ο κατάλογός σου. Μετονόμασέ τα, άλλαξε τις επιλογές ενός πεδίου επιλογής ή φτιάξε δικά σου. Ένα πεδίο ταυτότητας μπορεί να δείχνει σε μια υπηρεσία (μητρώο), οπότε ο αριθμός γίνεται πατήσιμος στη γάτα.';

  @override
  String get helpFieldsNeutral =>
      'Τα πεδία που χρησιμοποιεί ο κατάλογός σου. Μετονόμασέ τα, άλλαξε τις επιλογές ενός πεδίου επιλογής ή φτιάξε δικά σου. Ένα πεδίο ταυτότητας μπορεί να δείχνει σε μια υπηρεσία (μητρώο), οπότε ο αριθμός γίνεται πατήσιμος στο κατοικίδιο.';

  @override
  String get helpTimeline =>
      'Κάθε αλλαγή που έγινε ποτέ, με τη νεότερη πρώτη: ποιος άλλαξε τι, πότε και σε ποια τιμή. Κάθε καταχώριση αναιρείται — αυτό γράφει νέα καταχώριση, τίποτα δεν σβήνεται.';

  @override
  String get helpDuplicates =>
      'Γάτες ή αποικίες που μοιάζουν να υπάρχουν δύο φορές — ίδιοι αριθμοί ή πολύ παρόμοια ονόματα με ταιριαστές λεπτομέρειες. Πάτησε ένα ζευγάρι για συγχώνευση· δεν αναιρείται, γι\' αυτό ρωτά πρώτα.';

  @override
  String get helpDuplicatesNeutral =>
      'Κατοικίδια ή νοικοκυριά που μοιάζουν να υπάρχουν δύο φορές — ίδιοι αριθμοί ή πολύ παρόμοια ονόματα με ταιριαστές λεπτομέρειες. Πάτησε ένα ζευγάρι για συγχώνευση· δεν αναιρείται, γι\' αυτό ρωτά πρώτα.';

  @override
  String get helpMatches =>
      'Γάτες που μπορεί να είναι το ίδιο ζώο: ίδιος αριθμός, ή αδέσποτη που εθεάθη μέσα στην περιοχή αναζήτησης μιας χαμένης γάτας. Πάτησε ένα ζευγάρι για συγχώνευση, παρατεταμένο πάτημα ανοίγει την πρώτη γάτα για σύγκριση.';

  @override
  String get helpMatchesNeutral =>
      'Κατοικίδια που μπορεί να είναι το ίδιο ζώο: ίδιος αριθμός, ή αδέσποτο που εθεάθη μέσα στην περιοχή αναζήτησης ενός χαμένου κατοικιδίου. Πάτησε ένα ζευγάρι για συγχώνευση, παρατεταμένο πάτημα ανοίγει το πρώτο κατοικίδιο για σύγκριση.';

  @override
  String get helpFlier =>
      'Μια φωτογραφημένη αφίσα γίνεται γάτα μαζί με τον ιδιοκτήτη της. Βήμα βήμα: στοιχεία της γάτας, επαφή του ιδιοκτήτη, περικοπή προσώπου για τη φωτογραφία προφίλ, αριθμοί μητρώων από την αφίσα, και τέλος έλεγχος. Όλα είναι προτάσεις — διόρθωσε ό,τι διάβασε λάθος η κάμερα.';

  @override
  String get helpFlierNeutral =>
      'Μια φωτογραφημένη αφίσα γίνεται κατοικίδιο μαζί με τον ιδιοκτήτη του. Βήμα βήμα: στοιχεία του κατοικιδίου, επαφή του ιδιοκτήτη, περικοπή προσώπου για τη φωτογραφία προφίλ, αριθμοί μητρώων από την αφίσα, και τέλος έλεγχος. Όλα είναι προτάσεις — διόρθωσε ό,τι διάβασε λάθος η κάμερα.';

  @override
  String get archiveTitle => 'Αρχείο';

  @override
  String get archiveExplainer =>
      'Οι γάτες που πέθαναν και οι άδειες αποικίες που κανείς δεν άγγιξε εδώ και χρόνια πιάνουν και πάλι χώρο — κυρίως οι φωτογραφίες τους. Η αρχειοθέτηση τις γράφει σε ένα αρχείο που κρατάς και μετά τις σβήνει από εδώ.';

  @override
  String get archiveExplainerNeutral =>
      'Τα κατοικίδια που πέθαναν και τα άδεια νοικοκυριά που κανείς δεν άγγιξε εδώ και χρόνια πιάνουν και πάλι χώρο — κυρίως οι φωτογραφίες τους. Η αρχειοθέτηση τα γράφει σε ένα αρχείο που κρατάς και μετά τα σβήνει από εδώ.';

  @override
  String get archiveAction => 'Αρχειοθέτηση';

  @override
  String archiveSelected(int count) {
    return 'Αρχειοθέτηση $count εγγραφών';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Να αρχειοθετηθούν $count εγγραφές;';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names θα γραφτούν σε ένα αρχείο και μετά θα διαγραφούν — στη συσκευή σου και σε κάθε συσκευή με την οποία συγχρονίζεις. Η εισαγωγή του αρχείου τα επαναφέρει· χωρίς αυτό, χάθηκαν.';
  }

  @override
  String archiveDone(int count) {
    return 'Αρχειοθετήθηκαν και διαγράφηκαν $count εγγραφές';
  }

  @override
  String archiveFailed(String error) {
    return 'Δεν διαγράφηκε τίποτα: το αρχείο δεν μπόρεσε να γραφτεί ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Βάση $db, φωτογραφίες $photos σε $count αρχεία';
  }

  @override
  String quietForYears(int years) {
    return 'Χωρίς αλλαγή $years χρόνια';
  }

  @override
  String get nothingToArchive =>
      'Τίποτα δεν είναι αρκετά παλιό για αρχειοθέτηση.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Τελευταία αλλαγή $date · φωτογραφίες $size';
  }

  @override
  String get helpArchive =>
      'Τα παλιά δεδομένα κοστίζουν χώρο, κυρίως οι φωτογραφίες που κουβαλά κάθε συγχρονισμένη συσκευή. Εδώ διαλέγεις γάτες που πέθαναν και άδειες αποικίες που μένουν ήσυχες χρόνια, τις γράφεις σε ένα αρχείο που κρατάς και τις σβήνεις. Η διαγραφή φτάνει σε όλους όσους συγχρονίζεις· η εισαγωγή του αρχείου τα επαναφέρει όλα.';

  @override
  String get helpArchiveNeutral =>
      'Τα παλιά δεδομένα κοστίζουν χώρο, κυρίως οι φωτογραφίες που κουβαλά κάθε συγχρονισμένη συσκευή. Εδώ διαλέγεις κατοικίδια που πέθαναν και άδεια νοικοκυριά που μένουν ήσυχα χρόνια, τα γράφεις σε ένα αρχείο που κρατάς και τα σβήνεις. Η διαγραφή φτάνει σε όλους όσους συγχρονίζεις· η εισαγωγή του αρχείου τα επαναφέρει όλα.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Επαναφορά $count διαγραμμένων εγγραφών;';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names είναι διαγραμμένα σε αυτόν τον κατάλογο και το αρχείο που μόλις εισήγαγες τα περιέχει. Η επαναφορά τα φέρνει πίσω εδώ και σε κάθε συσκευή με την οποία συγχρονίζεις.';
  }

  @override
  String get restoreAction => 'Επαναφορά';

  @override
  String get keepDeleted => 'Να μείνουν διαγραμμένα';

  @override
  String get archiveNotSaved =>
      'Δεν διαγράφηκε τίποτα: το αρχείο δεν αποθηκεύτηκε πουθενά.';

  @override
  String get locateAddress => 'Εύρεση διεύθυνσης στον χάρτη';

  @override
  String get addressFoundTitle => 'Η διεύθυνση βρέθηκε';

  @override
  String get replaceAddressOption => 'Αντικατάσταση της διεύθυνσης με αυτήν';

  @override
  String get addPositionOption => 'Αποθήκευση της τοποθεσίας';

  @override
  String get addressLocated => 'Η διεύθυνση βρέθηκε';

  @override
  String get addressNotFound =>
      'Δεν βρέθηκε τοποθεσία για αυτή τη διεύθυνση. Έλεγξε την ορθογραφία ή άφησέ το κενό.';

  @override
  String get starterPosition => 'Τοποθεσία';

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
  String get markTitleNeutral => 'Σήμανση του κατοικιδίου';

  @override
  String get applyCrop => 'Περικοπή';

  @override
  String get useFullPhoto => 'Χρήση ολόκληρης της φωτογραφίας';

  @override
  String get dragToSelect => 'Σύρετε ένα ορθογώνιο γύρω από τη γάτα';

  @override
  String get dragToSelectNeutral =>
      'Σύρετε ένα ορθογώνιο γύρω από το κατοικίδιο';

  @override
  String get dragOverTheCat => 'Σύρετε μια έλλειψη πάνω στη γάτα';

  @override
  String get dragOverTheCatNeutral => 'Σύρετε μια έλλειψη πάνω στο κατοικίδιο';

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
  String lastBackupFailed(String error) {
    return 'Το τελευταίο αυτόματο αντίγραφο ασφαλείας απέτυχε: $error';
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
  String get typeUnitValue => 'Τιμή με μονάδα';

  @override
  String get dimension => 'Μέγεθος';

  @override
  String get dimensionWeight => 'Βάρος';

  @override
  String get dimensionLength => 'Μήκος';

  @override
  String get dimensionVolume => 'Όγκος';

  @override
  String get dimensionTemperature => 'Θερμοκρασία';

  @override
  String get unitsLabel => 'Μονάδες';

  @override
  String get catalogHolds => 'Αυτός ο κατάλογος περιέχει';

  @override
  String get modeCats => 'Γάτες';

  @override
  String get modePets => 'Κατοικίδια';

  @override
  String get graphLabel => 'Γράφημα';

  @override
  String get rangeWeek => 'Εβδομάδα';

  @override
  String get rangeMonth => 'Μήνας';

  @override
  String get rangeYear => 'Έτος';

  @override
  String get rangeAll => 'Όλα';

  @override
  String get rangeCustom => 'Προσαρμογή…';

  @override
  String changeSince(String delta, String date) {
    return '$delta από $date';
  }

  @override
  String get unitsAuto => 'Όπως στην περιοχή σου';

  @override
  String get unitsMetric => 'Μετρικό (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Αγγλοσαξονικό (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Βάρος';

  @override
  String get systemDefault => 'Προεπιλογή συστήματος';

  @override
  String get iosLocalNetworkHint =>
      'Αν συνεχίζει να αποτυγχάνει σε iPhone/iPad: Ρυθμίσεις → Απόρρητο και ασφάλεια → Τοπικό δίκτυο → επιτρέψτε το cat(a)log και δοκιμάστε ξανά.';

  @override
  String get includePrivate => 'Κοινοποίηση ιδιωτικών δεδομένων';

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
  String get starterStatus => 'Τύπος';

  @override
  String get statusFoster => 'Ανάδοχο σπίτι';

  @override
  String get statusForeverHome => 'Σπίτι';

  @override
  String get statusClinic => 'Κλινική';

  @override
  String get statusShelter => 'Καταφύγιο';

  @override
  String get statusBarn => 'Αχυρώνας';

  @override
  String get valueCat => 'Γάτα';

  @override
  String get valueDog => 'Σκύλος';

  @override
  String get valueRabbit => 'Κουνέλι';

  @override
  String get valueGuineaPig => 'Ινδικό χοιρίδιο';

  @override
  String get valueHamster => 'Χάμστερ';

  @override
  String get valueBird => 'Πουλί';

  @override
  String get valueHorse => 'Άλογο';

  @override
  String get valueTortoise => 'Χελώνα';

  @override
  String get valueFerret => 'Κουνάβι';

  @override
  String get otherOption => 'Άλλο…';

  @override
  String get celebrationsToggle => 'Γιορτή υιοθεσιών';

  @override
  String get celebrationsSubtitle =>
      'Κομφετί και ζητωκραυγές όταν μια γάτα μετακομίζει στο σπίτι της';

  @override
  String get celebrationsSubtitleNeutral =>
      'Κομφετί και ζητωκραυγές όταν ένα κατοικίδιο μετακομίζει στο σπίτι του';

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
  String get mapSearchHintNeutral =>
      'Αναζήτηση κατοικιδίων, νοικοκυριών, ατόμων';

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
  String conflictsMenu(int n) {
    return 'Συγκρούσεις ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Έλυσες μια σύγκρουση εδώ, οπότε η Απόρριψη δεν είναι διαθέσιμη: θα αναιρούσε κι αυτό.';

  @override
  String get arrivalIntro =>
      'Αυτές οι αλλαγές είναι ήδη στον κατάλογό σου. Η Απόρριψη τον επαναφέρει όπως ήταν.';

  @override
  String get summaryUpdated => 'Ενημερώθηκαν';

  @override
  String get summaryMeta => 'Έφτασαν επίσης';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n αλλαγές',
      one: '1 αλλαγή',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Αποδοχή';

  @override
  String get rejectArrival => 'Απόρριψη';

  @override
  String get photoAdded => 'Προστέθηκε φωτογραφία';

  @override
  String get photoRemoved => 'Αφαιρέθηκε φωτογραφία';

  @override
  String metaFieldAdded(String name) {
    return 'Νέο πεδίο: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Πεδίο άλλαξε: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser συγχωνεύθηκε στο $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n φωτογραφίες',
      one: '1 φωτογραφία',
    );
    return '$_temp0';
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
  String get kittensLabelNeutral => 'Μικρά';

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
  String toastBornNeutral(Object cat) {
    return '✨ Νεογέννητο: $cat ✨';
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
  String get syncChooserInPersonSub => 'Συγχρονισμός μέσω Wi-Fi';

  @override
  String get syncChooserRemote => 'Απομακρυσμένα';

  @override
  String get syncChooserRemoteSub => 'Συγχρονισμός μέσω φακέλου ή USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Εξαγωγή και εισαγωγή μέσω κοινωνικών δικτύων';

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

  @override
  String get selectClowderHint => 'Διάλεξε ένα clowder αριστερά';

  @override
  String get selectClowderHintNeutral => 'Διάλεξε ένα νοικοκυριό αριστερά';

  @override
  String get introTitle1 => 'Οι γάτες σου, οργανωμένες';

  @override
  String get introTitle1Neutral => 'Τα κατοικίδιά σου, οργανωμένα';

  @override
  String get introBody1 =>
      'Φτιάξε καρτέλα για κάθε γάτα: φωτογραφία, φύλο, υγεία, ό,τι θες να σημειώσεις. Οι γάτες ομαδοποιούνται κατά τον τόπο που ζουν — η εφαρμογή τον λέει αποικία (clowder).';

  @override
  String get introBody1Neutral =>
      'Φτιάξε καρτέλα για κάθε κατοικίδιο που φροντίζεις: φωτογραφία, φύλο, υγεία, ό,τι θες να σημειώσεις. Τα κατοικίδια ομαδοποιούνται κατά τον τόπο που ζουν — η εφαρμογή τον λέει νοικοκυριό.';

  @override
  String get introTitle2 => 'Λειτουργεί χωρίς ίντερνετ';

  @override
  String get introBody2 =>
      'Όλα αποθηκεύονται μόνο στο τηλέφωνό σου. Χωρίς λογαριασμό, χωρίς cloud. Τίποτα δεν ανεβαίνει αν δεν το μοιραστείς εσύ.';

  @override
  String get introTitle3 => 'Συνεργαστείτε';

  @override
  String get introBody3 =>
      'Καθένας χρησιμοποιεί τη δική του εφαρμογή και πού και πού ανταλλάσσετε δεδομένα: βρεθείτε και σαρώστε έναν κωδικό, χρησιμοποιήστε κοινό φάκελο ή στείλτε ένα αρχείο με messenger. Μετά όλοι έχουν τις ίδιες πληροφορίες.';

  @override
  String get introSkip => 'Παράλειψη';

  @override
  String get introNext => 'Επόμενο';

  @override
  String get introDone => 'Πάμε';

  @override
  String get introReplayTitle => 'Γρήγορη εισαγωγή';

  @override
  String get spotHomeSync =>
      'Εδώ συγχρονίζεις με τους γνωστούς σου. Εσύ αποφασίζεις τι μοιράζεσαι.';

  @override
  String get spotHomeStrays =>
      'Αυτή η κάρτα μαζεύει όλες τις αδέσποτες — γάτες χωρίς σπίτι. Πάτησε για τη λίστα.';

  @override
  String get spotHomeStraysNeutral =>
      'Αυτή η κάρτα μαζεύει όλα τα αδέσποτα — κατοικίδια χωρίς σπίτι. Πάτησε για τη λίστα.';

  @override
  String get spotHomeMenu =>
      'Σε αυτό το μενού: ρυθμίσεις, εύρεση και συγχώνευση διπλότυπων, εξαγωγή CSV και άλλα.';

  @override
  String get spotCatEdit =>
      'Πάτησε το μολύβι για να επεξεργαστείς τη γάτα. Συμβουλή: παρατεταμένο πάτημα σε πεδίο το επεξεργάζεται άμεσα.';

  @override
  String get spotCatEditNeutral =>
      'Πάτησε το μολύβι για να επεξεργαστείς το κατοικίδιο. Συμβουλή: παρατεταμένο πάτημα σε πεδίο το επεξεργάζεται άμεσα.';

  @override
  String get spotMapLayers =>
      'Ψάχνεις χαμένη γάτα; Εμφάνισε κύκλους γύρω από τα σημεία των αφισών της και το σπίτι από όπου έφυγε.';

  @override
  String get spotMapLayersNeutral =>
      'Ψάχνεις χαμένο κατοικίδιο; Εμφάνισε κύκλους γύρω από τα σημεία των αφισών του και το σπίτι από όπου έφυγε.';

  @override
  String get spotStraysFlier =>
      'Αφίσα χαμένης γάτας; Φωτογράφισέ την εδώ — η εφαρμογή αποθηκεύει γάτα και επαφή για σένα.';

  @override
  String get spotStraysFlierNeutral =>
      'Αφίσα χαμένου κατοικιδίου; Φωτογράφισέ την εδώ — η εφαρμογή αποθηκεύει κατοικίδιο και επαφή για σένα.';

  @override
  String get spotStraysScan =>
      'Κάποιες αφίσες έχουν κωδικό QR cat(a)log. Σάρωσέ τον εδώ και εισήγαγε τη γάτα χωρίς πληκτρολόγηση.';

  @override
  String get spotStraysScanNeutral =>
      'Κάποιες αφίσες έχουν κωδικό QR cat(a)log. Σάρωσέ τον εδώ και εισήγαγε το κατοικίδιο χωρίς πληκτρολόγηση.';

  @override
  String get introTitle4 => 'Βρες τις χαμένες γάτες';

  @override
  String get introTitle4Neutral => 'Βρες τα χαμένα κατοικίδια';

  @override
  String get introBody4 =>
      'Βλέπεις αφίσα για χαμένη γάτα; Φωτογράφισέ την στην εφαρμογή: αποθηκεύει τη γάτα, την επαφή του ιδιοκτήτη και το μέρος. Αν αργότερα εμφανιστεί παρόμοια αδέσποτη, η εφαρμογή προτείνει πιθανές αντιστοιχίες.';

  @override
  String get introBody4Neutral =>
      'Βλέπεις αφίσα για χαμένο κατοικίδιο; Φωτογράφισέ την στην εφαρμογή: αποθηκεύει το κατοικίδιο, την επαφή του ιδιοκτήτη και το μέρος. Αν αργότερα εμφανιστεί παρόμοιο αδέσποτο, η εφαρμογή προτείνει πιθανές αντιστοιχίες.';

  @override
  String get spotMapSearch =>
      'Γράψε γάτα, μέρος ή άνθρωπο για να πας εκεί στον χάρτη.';

  @override
  String get spotMapSearchNeutral =>
      'Γράψε κατοικίδιο, μέρος ή άνθρωπο για να πας εκεί στον χάρτη.';

  @override
  String get spotCardChips =>
      'Τσέκαρε τι θα φαίνεται στην κοινοποιήσιμη κάρτα — τα υπόλοιπα μένουν εκτός.';

  @override
  String get spotCatMenu =>
      'Εδώ υπάρχουν κι άλλες ενέργειες: απόκρυψη της γάτας, συγχώνευση διπλότυπων ή καταγραφή θέασης.';

  @override
  String get spotCatMenuNeutral =>
      'Εδώ υπάρχουν κι άλλες ενέργειες: απόκρυψη του κατοικιδίου, συγχώνευση διπλότυπων ή καταγραφή θέασης.';

  @override
  String get spotDone => 'Κατάλαβα';

  @override
  String get spotReplayTitle => 'Περιήγηση στα νέα';

  @override
  String get spotReplaySubtitle => 'Εμφάνιση των οδηγιών ξανά σε κάθε σελίδα';

  @override
  String get spotReplayDone => 'Οι οδηγίες θα εμφανιστούν ξανά';

  @override
  String get searchNoResults => 'Δεν βρέθηκε γάτα με αυτό το όνομα';

  @override
  String get searchNoResultsNeutral =>
      'Δεν βρέθηκε κατοικίδιο με αυτό το όνομα';

  @override
  String get syncUnreachable =>
      'Αδύνατη η σύνδεση με την άλλη συσκευή. Είναι και οι δύο στο ίδιο Wi-Fi;';

  @override
  String get folderUnreachable =>
      'Αδύνατη η πρόσβαση στον φάκελο. Υπάρχει ακόμη ο δίσκος ή ο φάκελος cloud;';

  @override
  String get crashTitle => 'Αυτό δεν έπρεπε να συμβεί';

  @override
  String get crashBody =>
      'Το cat(a)log συνάντησε ένα απρόσμενο σφάλμα. Τα δεδομένα σου είναι ασφαλή — όλα αποθηκεύονται τη στιγμή της αλλαγής. Επανεκκίνησε την εφαρμογή και αν επαναλαμβάνεται, στείλε την αναφορά για να διορθωθεί.';

  @override
  String get crashRestart => 'Επανεκκίνηση εφαρμογής';

  @override
  String get crashSendReport => 'Αποστολή αναφοράς στον προγραμματιστή';

  @override
  String get crashLastRunBody =>
      'Το cat(a)log σταμάτησε απρόσμενα την τελευταία φορά — μάλλον εξαντλήθηκε η μνήμη. Να σταλεί σύντομη αναφορά για να διορθωθεί;';

  @override
  String get catalogsTitle => 'Κατάλογοι';

  @override
  String get newCatalog => 'Νέος κατάλογος';

  @override
  String get intoCatalog => 'Στον κατάλογο';

  @override
  String get catalogNameLabel => 'Όνομα καταλόγου';

  @override
  String catalogNameTaken(String name) {
    return 'Υπάρχει ήδη κατάλογος με το όνομα $name. Διάλεξε άλλο όνομα.';
  }

  @override
  String get manageCatalogs => 'Διαχείριση καταλόγων';

  @override
  String get helpCatalogs =>
      'Ένας κατάλογος είναι ένας κόσμος από μόνος του: δικές του γάτες, αποικίες, πεδία, φωτογραφίες και συνεργάτες συγχρονισμού. Βερολίνο και Παρίσι δεν ανακατεύονται ποτέ. Πάτησε έναν κατάλογο για να μεταβείς σε αυτόν. Το γρανάζι σε έναν κατάλογο ανοίγει τις ρυθμίσεις του: όνομα, γάτες ή κατοικίδια, πεδία, συντάκτες και αποκλεισμοί, αρχείο, επιστροφή, διαγραφή. Το όνομά σου, η γλώσσα σου και οι συμβουλές που έχεις ήδη δει είναι κοινές για όλους.';

  @override
  String get helpCatalogsNeutral =>
      'Ένας κατάλογος είναι ένας κόσμος από μόνος του: δικές του κατοικίδια, νοικοκυριά, πεδία, φωτογραφίες και συνεργάτες συγχρονισμού. Βερολίνο και Παρίσι δεν ανακατεύονται ποτέ. Πάτησε έναν κατάλογο για να μεταβείς σε αυτόν. Το γρανάζι σε έναν κατάλογο ανοίγει τις ρυθμίσεις του: όνομα, γάτες ή κατοικίδια, πεδία, συντάκτες και αποκλεισμοί, αρχείο, επιστροφή, διαγραφή. Το όνομά σου, η γλώσσα σου και οι συμβουλές που έχεις ήδη δει είναι κοινές για όλους.';

  @override
  String get helpCatalogSettings =>
      'Όλα όσα ανήκουν μόνο σε αυτόν τον κατάλογο: το όνομά του, αν έχει γάτες ή κατοικίδια, τα πεδία του, οι συντάκτες και οι αποκλεισμοί, το αρχείο και η επιστροφή στον χρόνο. Οι αλλαγές εδώ αφορούν μόνο αυτόν τον κατάλογο — και έναν στον οποίο δεν βρίσκεσαι τώρα. Η διαγραφή γράφει πρώτα τον κατάλογο σε αρχείο.';

  @override
  String get spotHomeCatalog =>
      'Αυτός είναι ο κατάλογος στον οποίο βρίσκεσαι. Πάτησε το όνομα για αλλαγή ή για νέον.';

  @override
  String get deleteCatalog => 'Διαγραφή καταλόγου';

  @override
  String get catalogSettings => 'Ρυθμίσεις καταλόγου';

  @override
  String deleteCatalogBody(String name) {
    return 'Όλα στο $name χάνονται: γάτες, φωτογραφίες, ιστορικό. Πρώτα αποθηκεύεται ένα πλήρες αρχείο εκεί όπου πηγαίνουν τα αυτόματα αντίγραφα — η εισαγωγή του επαναφέρει τον κατάλογο. Γράψε τη λέξη που εμφανίζεται για επιβεβαίωση.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Όλα στο $name χάνονται: κατοικίδια, φωτογραφίες, ιστορικό. Πρώτα αποθηκεύεται ένα πλήρες αρχείο εκεί όπου πηγαίνουν τα αυτόματα αντίγραφα — η εισαγωγή του επαναφέρει τον κατάλογο. Γράψε το όνομα για επιβεβαίωση.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return 'Ο κατάλογος $name διαγράφηκε. Το αρχείο είναι στο $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Γράψε $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Δεν διαγράφηκε τίποτα: το αρχείο του καταλόγου δεν γράφτηκε ($error). Ελευθέρωσε χώρο ή δοκίμασε αργότερα.';
  }

  @override
  String get moveToCatalog => 'Μετακίνηση σε άλλον κατάλογο';

  @override
  String movedToCatalog(int count, String name) {
    return '$count μετακινήθηκαν στο $name';
  }

  @override
  String get chooseWhatToMove => 'Τι να μετακινηθεί;';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Να μετακινηθεί κάτι στο $name;';
  }

  @override
  String get undoThisImport => 'Αναίρεση αυτής της εισαγωγής';

  @override
  String undoImportBody(int count) {
    return 'Οι $count αλλαγές αυτής της εισαγωγής αφαιρούνται. Γράφονται πρώτα σε αρχείο, η εισαγωγή του οποίου τις επαναφέρει. Όσοι έχουν ήδη συγχρονιστεί κρατούν το αντίγραφό τους — αυτό δεν παίρνεται πίσω.';
  }

  @override
  String undoneImport(String where) {
    return 'Αναιρέθηκε. Το αρχείο είναι στο $where.';
  }

  @override
  String get goBackTitle => 'Επιστροφή πίσω';

  @override
  String get goBackToHere => 'Επιστροφή εδώ';

  @override
  String get momentImport => 'Πριν την εισαγωγή';

  @override
  String get momentSync => 'Πριν τον συγχρονισμό';

  @override
  String get momentMerge => 'Πριν τη συγχώνευση';

  @override
  String get momentHardDelete => 'Πριν τη διαγραφή δεδομένων ενός συντάκτη';

  @override
  String get momentArchive => 'Πριν την αρχειοθέτηση';

  @override
  String get momentManual => 'Σημειωμένο από εσένα';

  @override
  String get showOlderMoments => 'Εμφάνιση παλαιότερων';

  @override
  String goBackBody(int count) {
    return 'Όλα μετά από αυτή τη στιγμή αφαιρούνται — $count αλλαγές. Γράφονται πρώτα σε αρχείο, η εισαγωγή του οποίου τα επαναφέρει, και κάθε νεότερη στιγμή φεύγει μαζί. Όσοι έχουν ήδη συγχρονιστεί κρατούν το αντίγραφό τους — αυτό δεν παίρνεται πίσω.';
  }

  @override
  String get nameThisMoment => 'Ονόμασε αυτή τη στιγμή';

  @override
  String get helpGoBack =>
      'Οι στιγμές που άλλαξε μορφή αυτός ο κατάλογος: πριν από κάθε εισαγωγή και κάθε συγχρονισμό, πριν από συγχώνευση, αρχειοθέτηση ή διαγραφή, και όποτε σημείωσες μια στιγμή ο ίδιος. Επιλέγοντας μία, ο κατάλογος επιστρέφει σε εκείνη την κατάσταση — ό,τι ήρθε μετά γράφεται σε αρχείο που κρατάς και μετά αφαιρείται, και κάθε νεότερη στιγμή φεύγει μαζί. Όσοι έχουν ήδη συγχρονιστεί κρατούν ό,τι πήραν.';

  @override
  String goBackFileFailed(String error) {
    return 'Δεν αφαιρέθηκε τίποτα: το αρχείο που το κρατά δεν γράφτηκε ($error). Ελευθέρωσε χώρο και δοκίμασε ξανά.';
  }

  @override
  String get goBackChanged =>
      'Δεν αφαιρέθηκε τίποτα: ο κατάλογος άλλαξε όσο αποθηκευόταν το αρχείο. Δοκίμασε ξανά.';

  @override
  String get switchBeforeDeleting =>
      'Αυτός είναι ο κατάλογος στον οποίο βρίσκεσαι. Άλλαξε σε άλλον και μετά διάγραψέ τον.';

  @override
  String shareFileFailed(String error) {
    return 'Το αρχείο κοινοποίησης δεν γράφτηκε ($error). Ελευθέρωσε χώρο και δοκίμασε ξανά.';
  }

  @override
  String get privateLabel => 'Ιδιωτικό';

  @override
  String sharedCatalogIs(String name) {
    return 'Κατάλογος: $name';
  }

  @override
  String get markPrivate => 'Σήμανση ως ιδιωτικό';

  @override
  String get unmarkPrivate => 'Αφαίρεση ιδιωτικής σήμανσης';

  @override
  String get agenda => 'Υπενθυμίσεις';

  @override
  String get reminderLabel => 'Υπενθύμιση';

  @override
  String get agendaEmpty =>
      'Δεν υπάρχουν προγραμματισμένα ραντεβού. Προγραμμάτισε νέα εδώ με το συν ή στη σελίδα μιας γάτας ή ομάδας.';

  @override
  String get agendaEmptyNeutral =>
      'Δεν υπάρχουν προγραμματισμένα ραντεβού. Προγραμμάτισε νέα εδώ με το συν ή στη σελίδα ενός κατοικιδίου ή νοικοκυριού.';

  @override
  String get dueToday => 'σήμερα';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'σε $count ημέρες',
      one: 'σε 1 ημέρα',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ημέρες καθυστέρηση',
      one: '1 ημέρα καθυστέρηση',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Έγινε';

  @override
  String get repeatTitle => 'Ξανά σε…';

  @override
  String get noRepeatLabel => 'Χωρίς επανάληψη';

  @override
  String get unitDays => 'ημέρες';

  @override
  String get unitWeeks => 'εβδομάδες';

  @override
  String get unitMonths => 'μήνες';

  @override
  String get unitYears => 'χρόνια';

  @override
  String ageYears(int years) {
    return '$years έτη';
  }

  @override
  String ageMonths(int months) {
    return '$months μήν.';
  }

  @override
  String get changeDateLabel => 'Αλλαγή ημερομηνίας';

  @override
  String get removeReminderLabel => 'Αφαίρεση υπενθύμισης';

  @override
  String get exportIcs => 'Εξαγωγή αρχείου ημερολογίου';

  @override
  String get resyncCalendar => 'Επανασυγχρονισμός ημερολογίου';

  @override
  String icsSavedTo(String path) {
    return 'Το αρχείο ημερολογίου αποθηκεύτηκε στο $path';
  }

  @override
  String get calendarMirrorLabel =>
      'Αντικατοπτρισμός στο ημερολόγιο της συσκευής';

  @override
  String get calendarMirrorSubtitle =>
      'Τα ραντεβού εμφανίζονται ως ολοήμερα συμβάντα στο ημερολόγιο. Το cat(a)log τα ενημερώνει εκεί σε κάθε εκκίνηση και μετά από κάθε αλλαγή. Τις ειδοποιήσεις για τα ραντεβού τις διαχειρίζεσαι στο ημερολόγιο.';

  @override
  String get syncPeerOlder =>
      'Η άλλη συσκευή έχει παλαιότερο cat(a)log χωρίς υπενθυμίσεις. Ενημέρωσε το cat(a)log εκεί και συγχρόνισε ξανά.';

  @override
  String get syncPeerNewer =>
      'Η άλλη συσκευή έχει νεότερο cat(a)log. Ενημέρωσε το cat(a)log σε αυτήν τη συσκευή και συγχρόνισε ξανά.';

  @override
  String get syncPeerNoTls =>
      'Η άλλη συσκευή τρέχει cat(a)log πριν από την 1.1.0, χωρίς κρυπτογραφημένο συγχρονισμό. Ενημέρωσε το cat(a)log εκεί και συγχρόνισε ξανά.';

  @override
  String get syncWrongHost =>
      'Το πιστοποιητικό δεν ταιριάζει με τον κωδικό σύζευξης — δεν είναι η συσκευή από την οποία ήρθε ο κωδικός. Σάρωσε ή πληκτρολόγησε τον κωδικό ξανά.';

  @override
  String get bundleNewerError =>
      'Αυτό το αρχείο προέρχεται από νεότερο cat(a)log. Ενημέρωσε το cat(a)log σε αυτήν τη συσκευή για να το εισαγάγεις.';

  @override
  String get spotEar =>
      'Ένα μικρό αυτί γάτας σε μια γωνία σημαίνει: κράτησε πατημένο για περισσότερα.';

  @override
  String get addReminder => 'Προσθήκη υπενθύμισης';

  @override
  String get plannedSection => 'Προγραμματισμένα';

  @override
  String get reminderDialogHint =>
      'Το ραντεβού εμφανίζεται στις υπενθυμίσεις. Εκεί μπορείς να το επιβεβαιώσεις ή να το απορρίψεις. Η τιμή υιοθετείται μόνο όταν το ραντεβού επιβεβαιωθεί.';

  @override
  String get reminderFor => 'Για';

  @override
  String get reminderField => 'Πεδίο';

  @override
  String get dueDateLabel => 'Προθεσμία';

  @override
  String get pickCalendar => 'Ποιο ημερολόγιο;';

  @override
  String get calendarPermissionDenied =>
      'Η πρόσβαση στο ημερολόγιο είναι μπλοκαρισμένη, οπότε ο αντικατοπτρισμός είναι απενεργοποιημένος. Επίτρεψέ την στις ρυθμίσεις συστήματος και ενεργοποίησέ τον ξανά.';

  @override
  String get calendarNotChosen =>
      'Δεν επιλέχθηκε ημερολόγιο, οπότε ο αντικατοπτρισμός είναι απενεργοποιημένος. Ενεργοποίησέ τον ξανά και διάλεξε ένα.';

  @override
  String get calendarGone =>
      'Το επιλεγμένο ημερολόγιο δεν υπάρχει πια, οπότε ο αντικατοπτρισμός είναι απενεργοποιημένος. Ενεργοποίησέ τον ξανά και διάλεξε άλλο.';

  @override
  String get noWritableCalendar =>
      'Δεν βρέθηκε ημερολόγιο. Συνδέσου στις ρυθμίσεις συστήματος σε έναν λογαριασμό ημερολογίου, για παράδειγμα Google, και δοκίμασε ξανά.';

  @override
  String get spotHomeAgenda =>
      'Υπενθυμίσεις: η λίστα των προγραμματισμένων ραντεβού — κτηνίατρος, φάρμακα, έλεγχοι.';

  @override
  String get spotAgendaAdd => 'Προγραμμάτισε νέο ραντεβού.';

  @override
  String get spotAgendaCalendar =>
      'Ενεργοποίησε εδώ τον αντικατοπτρισμό των ραντεβού του cat(a)log σε ένα ημερολόγιο της επιλογής σου.';

  @override
  String get helpAgenda =>
      'Οι υπενθυμίσεις δείχνουν τα προγραμματισμένα ραντεβού κατά ημερομηνία. Υπάρχουν δύο είδη: ραντεβού με ώρα και υπενθυμίσεις που ισχύουν για μια μέρα. Όσα χάθηκαν μένουν πάνω. Το πάτημα ανοίγει τη γάτα ή την ομάδα. Το τικ επιβεβαιώνει ένα ραντεβού: η τιμή γράφεται στο πεδίο και μπορείς αμέσως να προγραμματίσεις το επόμενο, για παράδειγμα σε τρεις μήνες. Το παρατεταμένο πάτημα αλλάζει την ημερομηνία ή διαγράφει το ραντεβού. Ο διακόπτης επάνω αντικατοπτρίζει τα ραντεβού σε ένα ημερολόγιο του τηλεφώνου σου. Το μενού τα εξάγει ως αρχείο ημερολογίου. Μια επίσκεψη στον κτηνίατρο με πολλές γάτες είναι ένα ραντεβού: επιλέξτε τις γάτες, η Ατζέντα δείχνει μία κάρτα με τα ονόματά τους, και στην ολοκλήρωση ρωτά ποιες γάτες εξετάστηκαν — αποεπιλέξτε τις υπόλοιπες, παραμένουν προγραμματισμένες.';

  @override
  String get helpAgendaNeutral =>
      'Οι υπενθυμίσεις δείχνουν τα προγραμματισμένα ραντεβού κατά ημερομηνία. Υπάρχουν δύο είδη: ραντεβού με ώρα και υπενθυμίσεις που ισχύουν για μια μέρα. Όσα χάθηκαν μένουν πάνω. Το πάτημα ανοίγει το κατοικίδιο ή το νοικοκυριό. Το τικ επιβεβαιώνει ένα ραντεβού: η τιμή γράφεται στο πεδίο και μπορείς αμέσως να προγραμματίσεις το επόμενο, για παράδειγμα σε τρεις μήνες. Το παρατεταμένο πάτημα αλλάζει την ημερομηνία ή διαγράφει το ραντεβού. Ο διακόπτης επάνω αντικατοπτρίζει τα ραντεβού σε ένα ημερολόγιο του τηλεφώνου σου. Το μενού τα εξάγει ως αρχείο ημερολογίου. Μια επίσκεψη στον κτηνίατρο με πολλά κατοικίδια είναι ένα ραντεβού: επιλέξτε τα κατοικίδια, η Ατζέντα δείχνει μία κάρτα με τα ονόματά τους, και στην ολοκλήρωση ρωτά ποια κατοικίδια εξετάστηκαν — αποεπιλέξτε τα υπόλοιπα, παραμένουν προγραμματισμένα.';

  @override
  String get calendarRowOff => 'Ημερολόγιο: ανενεργό';

  @override
  String calendarRowOn(String name) {
    return 'Ημερολόγιο: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Προγραμμάτισε ένα ραντεβού για αυτήν τη γάτα. Εμφανίζεται στις υπενθυμίσεις και επιβεβαιώνεται εκεί.';

  @override
  String get spotAddReminderCatNeutral =>
      'Προγραμμάτισε ένα ραντεβού για αυτό το κατοικίδιο. Εμφανίζεται στις υπενθυμίσεις και επιβεβαιώνεται εκεί.';

  @override
  String get spotAddReminderClowder =>
      'Προγραμμάτισε ένα ραντεβού για αυτήν την ομάδα. Εμφανίζεται στις υπενθυμίσεις και επιβεβαιώνεται εκεί.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Προγραμμάτισε ένα ραντεβού για αυτό το νοικοκυριό. Εμφανίζεται στις υπενθυμίσεις και επιβεβαιώνεται εκεί.';

  @override
  String get readOnlyCalendar => 'μόνο ανάγνωση';

  @override
  String get appointmentLabel => 'Ραντεβού';

  @override
  String get addAppointment => 'Προσθήκη ραντεβού';

  @override
  String get planChooserTitle => 'Ραντεβού ή υπενθύμιση;';

  @override
  String get planChooserAppointment =>
      'Ραντεβού — μια επίσκεψη σε ημερομηνία και ώρα, με σημειώσεις';

  @override
  String get planChooserReminder => 'Υπενθύμιση — μια τιμή που λήγει μια μέρα';

  @override
  String get appointmentTitleLabel => 'Τι';

  @override
  String get notesLabel => 'Σημειώσεις';

  @override
  String get timeLabel => 'Ώρα';

  @override
  String get allDayLabel => 'Ολοήμερο';

  @override
  String get alertLabel => 'Ειδοποίηση';

  @override
  String get alertNone => 'Καμία';

  @override
  String get alertDayBefore => 'Την προηγούμενη μέρα';

  @override
  String get alertHourBefore => 'Μία ώρα πριν';

  @override
  String get linkFieldLabel => 'Όταν γίνει, γράψε σε ένα πεδίο';

  @override
  String get noLinkedField => 'Κανένα πεδίο';

  @override
  String get outcomeTitle => 'Πώς πήγε;';

  @override
  String get finishLabel => 'Ολοκλήρωση';

  @override
  String get editLabelAppointment => 'Επεξεργασία ραντεβού';

  @override
  String get deleteAppointment => 'Διαγραφή ραντεβού';

  @override
  String get stepFlierText => 'Κείμενο της αφίσας';

  @override
  String get qrFoundHint =>
      'Βρέθηκε κωδικός QR στην αφίσα. Οι επιλεγμένοι κωδικοί διαβάζονται για αριθμούς μητρώου και συνδέσμους.';

  @override
  String get useCode => 'Χρήση αυτού του κωδικού';

  @override
  String get qrNone => 'Δεν βρέθηκε κωδικός QR στη φωτογραφία.';

  @override
  String qrFailed(String error) {
    return 'Η ανάγνωση του κωδικού QR απέτυχε: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Αναγνωρίστηκε αφίσα $name. Ελέγξτε παρακάτω σε ποιο πεδίο πηγαίνει κάθε γραμμή.';
  }

  @override
  String get flierLayoutUnknown =>
      'Άγνωστη διάταξη αφίσας. Αντιστοιχίστε τις γραμμές σε πεδία παρακάτω· τα υπόλοιπα μένουν στις σημειώσεις.';

  @override
  String get targetRegistryNumber => 'Αριθμός μητρώου';

  @override
  String get targetLostPlace => 'Διεύθυνση (τόπος απώλειας)';

  @override
  String get targetContact => 'Επικοινωνία μητρώου';

  @override
  String get targetDrop => 'Απόρριψη';

  @override
  String get existingCat => 'Υπάρχουσα γάτα';

  @override
  String get existingCatNeutral => 'Υπάρχον κατοικίδιο';

  @override
  String get existingClowder => 'Υπάρχουσα ομάδα';

  @override
  String get existingClowderNeutral => 'Υπάρχον νοικοκυριό';

  @override
  String get createNewInstead => 'Καμία — δημιουργία νέας';

  @override
  String overwritesValue(String value) {
    return 'Αντικαθιστά την τρέχουσα τιμή \"$value\"';
  }

  @override
  String get abortScanTitle => 'Ακύρωση της σάρωσης;';

  @override
  String get abortScanBody => 'Δεν θα αποθηκευτεί τίποτα.';

  @override
  String get abortScan => 'Ακύρωση';

  @override
  String get keepScanning => 'Συνέχεια';

  @override
  String get catsOnAppointment => 'Γάτες σε αυτό το ραντεβού';

  @override
  String get catsOnAppointmentNeutral => 'Κατοικίδια σε αυτό το ραντεβού';

  @override
  String get noCatsHint =>
      'Καμία γάτα επιλεγμένη — το ραντεβού ανήκει στην ίδια την αποικία.';

  @override
  String get noCatsHintNeutral =>
      'Κανένα κατοικίδιο επιλεγμένο — το ραντεβού ανήκει στο ίδιο το νοικοκυριό.';

  @override
  String get pickCatsTitle => 'Ποιες γάτες έρχονται;';

  @override
  String get pickCatsTitleNeutral => 'Ποια κατοικίδια έρχονται;';

  @override
  String catsCount(int count) {
    return '$count γάτες';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count κατοικίδια';
  }

  @override
  String get finishUntickHint =>
      'Αποεπιλέξτε τις γάτες που δεν εξετάστηκαν· παραμένουν προγραμματισμένες.';

  @override
  String get finishUntickHintNeutral =>
      'Αποεπιλέξτε τα κατοικίδια που δεν εξετάστηκαν· παραμένουν προγραμματισμένα.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Διαγραφή ραντεβού για όλες τις $count γάτες';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Διαγραφή ραντεβού για όλα τα $count κατοικίδια';
  }
}
