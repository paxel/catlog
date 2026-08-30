// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'ברוכים הבאים ל-cat(a)log';

  @override
  String get welcomeBody =>
      'בחרו לעצמכם שם. כל שינוי נרשם תחת השם הזה, כדי שאחרים יראו מי עשה מה.';

  @override
  String get yourName => 'השם שלך';

  @override
  String get start => 'התחלה';

  @override
  String get clowders => 'קבוצות';

  @override
  String get noClowdersYet =>
      'אין עדיין קבוצות. קבוצה היא מקום שבו חתולים גרים — בית האומנה שלך, דירת מאמץ. צרו את הראשונה למטה.';

  @override
  String get strays => 'חתולי רחוב';

  @override
  String get searchCats => 'חיפוש חתולים';

  @override
  String get map => 'מפה';

  @override
  String get sync => 'סנכרון';

  @override
  String get fields => 'שדות';

  @override
  String get exportCsv => 'ייצוא CSV';

  @override
  String get aboutAndFeedback => 'אודות ומשוב';

  @override
  String get newClowder => 'קבוצה חדשה';

  @override
  String get name => 'שם';

  @override
  String get cancel => 'ביטול';

  @override
  String get create => 'יצירה';

  @override
  String get save => 'שמירה';

  @override
  String get delete => 'מחיקה';

  @override
  String get merge => 'מיזוג';

  @override
  String get resolve => 'הכרעה';

  @override
  String get open => 'פתיחה';

  @override
  String csvSavedTo(String path) {
    return 'CSV נשמר ב-$path';
  }

  @override
  String get renameClowder => 'שינוי שם הקבוצה';

  @override
  String get rename => 'שינוי שם';

  @override
  String get timeline => 'ציר זמן';

  @override
  String get mergeInto => 'מיזוג עם…';

  @override
  String get deleteClowder => 'מחיקת הקבוצה';

  @override
  String get cats => 'חתולים';

  @override
  String get addCat => 'הוספת חתול';

  @override
  String get newCat => 'חתול חדש';

  @override
  String deleteQuestion(String name) {
    return 'למחוק את $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'הקבוצה תיעלם מהרשימה.';

  @override
  String deleteClowderBody(int count) {
    return 'החתולים שבה ($count) לא נמחקים — הם הופכים לחתולי רחוב. העבירו אותם קודם לקבוצה אחרת אם זו לא הכוונה.';
  }

  @override
  String get card => 'כרטיס';

  @override
  String get shareAsImage => 'שיתוף כתמונה';

  @override
  String get shareAsPdf => 'שיתוף כ-PDF';

  @override
  String get print => 'הדפסה';

  @override
  String cardTitle(String name) {
    return 'כרטיס — $name';
  }

  @override
  String get renameCat => 'שינוי שם החתול';

  @override
  String get seenHereNow => 'נראה כאן עכשיו';

  @override
  String get deleteCat => 'מחיקת החתול';

  @override
  String get clowderLabel => 'קבוצה';

  @override
  String get strayNoClowder => 'חתול רחוב — ללא קבוצה';

  @override
  String get stray => 'חתול רחוב';

  @override
  String get photos => 'תמונות';

  @override
  String get addPhoto => 'הוספת תמונה';

  @override
  String get setAsProfileImage => 'הגדרה כתמונת פרופיל';

  @override
  String get thisIsProfileImage => 'זו תמונת הפרופיל';

  @override
  String get deletePhoto => 'מחיקת התמונה';

  @override
  String get deletePhotoTitle => 'למחוק את התמונה?';

  @override
  String get deletePhotoBody => 'נתוני התמונה נמחקים לצמיתות — אין דרך חזרה.';

  @override
  String get deleteCatBody =>
      'החתול נעלם מכל הרשימות ותמונותיו נמחקות — כאן, ואחרי הסנכרון הבא גם במכשירים האחרים.';

  @override
  String get sightingRecorded => 'התצפית נרשמה במיקומך.';

  @override
  String get noLocationAvailable =>
      'אין מיקום זמין — במקום זאת לחצו לחיצה ארוכה על המפה.';

  @override
  String get locationDeniedForever =>
      'הגישה למיקום חסומה. יש לאפשר אותה בהגדרות המערכת כדי להשתמש ב-Stray Cam.';

  @override
  String get locationServiceOff =>
      'המיקום כבוי במכשיר הזה. הפעילו אותו בהגדרות ונסו שוב.';

  @override
  String get locationDenied =>
      'ל‑cat(a)log אין הרשאה להשתמש במיקום שלכם. נסו שוב ואשרו כשתישאלו.';

  @override
  String get locationNoFix =>
      'לא ניתן היה לקבוע את מיקומכם כרגע. נסו שוב בחוץ — ה‑GPS זקוק לקו ראייה פתוח לשמיים.';

  @override
  String get ok => 'אישור';

  @override
  String get starterChipId => 'מספר שבב';

  @override
  String get starterRemarks => 'הערות';

  @override
  String get captureFlier => 'צילום מודעה';

  @override
  String get addPhotosTo => 'הוספת תמונות אל…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count תמונות נוספו אל $name';
  }

  @override
  String get scanPrintedCode => 'סריקת קוד מודפס';

  @override
  String get chipScanHint =>
      'סורק את קוד ה-QR/ברקוד המודפס מכרטיס השבב או ממסמכי הווטרינר — טלפון לא יכול לקרוא את השבב שבתוך החתול.';

  @override
  String get savingLabel => 'שומר…';

  @override
  String ownerOfCat(String name) {
    return 'הבעלים של $name';
  }

  @override
  String get sortLabel => 'מיון';

  @override
  String get viewAsTable => 'הצגה כטבלה';

  @override
  String get viewAsTiles => 'הצגה כאריחים';

  @override
  String get viewAsList => 'הצג כרשימה';

  @override
  String get ageLabel => 'גיל';

  @override
  String get catList => 'רשימת חתולים';

  @override
  String get matchCandidatesTitle => 'התאמות אפשריות';

  @override
  String get findDuplicates => 'איתור כפילויות';

  @override
  String get noDuplicates => 'אין כפילויות אפשריות כרגע.';

  @override
  String get similarName => 'שם דומה';

  @override
  String get sharePublicly => 'שיתוף ציבורי…';

  @override
  String get pickFramesTitle => 'בחירת פריימים';

  @override
  String get suggestedFrames => 'פריימים מוצעים';

  @override
  String get scrubFrames => 'גלילה בסרטון';

  @override
  String get keepThisFrame => 'שמור פריים זה';

  @override
  String get fromVideo => 'מסרטון…';

  @override
  String get videoMobileOnly =>
      'בחירת פריימים מסרטון עובדת באפליקציית הטלפון (אנדרואיד ואייפון) — עדיין לא במכשיר הזה.';

  @override
  String get shareWhitelistExplainer =>
      'בחרו מה ייכנס לקובץ. רק שדות מסומנים נכללים.';

  @override
  String get exportShareFile => 'ייצוא קובץ שיתוף…';

  @override
  String get hostedLink => 'קישור מאוחסן (כתובת הקובץ שהועלה)';

  @override
  String get inlineQr => 'QR מוטמע (טקסט בלבד, ללא תמונות)';

  @override
  String get inlineTooBig =>
      'יותר מדי נתונים לקוד מוטמע — בטלו סימון שדות או השתמשו בקישור מאוחסן.';

  @override
  String get scanShareLabel => 'סריקת קוד שיתוף';

  @override
  String get notAShareCode => 'הקוד הזה אינו שיתוף של cat(a)log.';

  @override
  String get importShareTitle => 'לייבא את החתול הזה?';

  @override
  String shareSource(String url) {
    return 'מקור: $url';
  }

  @override
  String get importLabel => 'ייבוא';

  @override
  String get strayAreaLabel => 'אזור שיטוט אפשרי';

  @override
  String get prevPin => 'סיכה קודמת';

  @override
  String get nextPin => 'סיכה הבאה';

  @override
  String get noMissingCats => 'אין עדיין חתולים נעדרים עם מיקומי מודעות.';

  @override
  String get noMatchCandidates => 'אין התאמות אפשריות כרגע.';

  @override
  String sameIdField(String field) {
    return '$field זהה';
  }

  @override
  String metersApart(String distance) {
    return 'במרחק $distance מ\' זה מזה';
  }

  @override
  String get addFlier => 'הוספת מודעה';

  @override
  String get missingSinceLabel => 'נעדר מאז';

  @override
  String get phoneLabel => 'טלפון';

  @override
  String get cropPortrait => 'חיתוך דיוקן';

  @override
  String get statusOwner => 'בעלים';

  @override
  String get ocrUnavailable =>
      'זיהוי טקסט אינו זמין במכשיר זה — הקלידו את טקסט המודעה בעצמכם.';

  @override
  String get displayFormat => 'מוצג בתור';

  @override
  String get displayPlain => 'טקסט רגיל';

  @override
  String get displayQr => 'קוד QR';

  @override
  String get displayBarcode => 'ברקוד';

  @override
  String get editLabel => 'עריכה';

  @override
  String get doneLabel => 'סיום';

  @override
  String get openSettings => 'פתיחת הגדרות';

  @override
  String get notSaved => 'לא נשמר';

  @override
  String get birthdateInFuture => 'תאריך הלידה לא יכול להיות בעתיד.';

  @override
  String get deceasedInFuture => 'תאריך המוות לא יכול להיות בעתיד.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'תאריך המוות לא יכול להיות לפני תאריך הלידה ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'תאריך הלידה לא יכול להיות אחרי תאריך המוות ($date).';
  }

  @override
  String get malePregnant =>
      'החתול הזה רשום כזכר — זכר לא יכול להיות בהיריון. בדקו קודם את המין.';

  @override
  String fatherNotMale(String name) {
    return '$name רשומה כנקבה ולא יכולה להיות האב. בדקו קודם את המין.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name רשום כזכר ולא יכול להיות האם. בדקו קודם את המין.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name נולד ב-$date — הורה לא יכול להיוולד אחרי הגור שלו.';
  }

  @override
  String get genderFatherFemale =>
      'החתול הזה רשום כאב של חתולים אחרים — האב לא יכול להיות נקבה. בדקו קודם את המשפחה.';

  @override
  String get genderMotherMale =>
      'החתול הזה רשום כאם של חתולים אחרים — האם לא יכולה להיות זכר. בדקו קודם את המשפחה.';

  @override
  String get moveTo => 'העברה אל';

  @override
  String get noClowderStrayOption => 'ללא קבוצה — חתול רחוב / ברח';

  @override
  String timelineOf(String name) {
    return 'ציר זמן — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'ביטול השינוי הזה';

  @override
  String get revertSubtitle =>
      'מחזיר את הערך הקודם כרשומה חדשה — ההיסטוריה שומרת את שניהם.';

  @override
  String fieldCleared(String field) {
    return '$field רוקן';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field חזר אל \"$value\"';
  }

  @override
  String get leftStray => 'עזב — חתול רחוב';

  @override
  String movedTo(String name) {
    return 'הועבר אל $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat הגיע';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat הגיע מ-$place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat עבר אל $place';
  }

  @override
  String get duplicateMergedIn => 'רשומה כפולה מוזגה';

  @override
  String get asOfToday => 'נכון להיום';

  @override
  String asOfDate(String date) {
    return 'נכון ל-$date';
  }

  @override
  String dateFormatError(String format) {
    return 'פורמט שגוי — יש להשתמש ב-$format';
  }

  @override
  String get dateInFuture => 'תאריך זה לא יכול להיות בעתיד.';

  @override
  String get value => 'ערך';

  @override
  String get latitudeLongitude => 'קו רוחב, קו אורך';

  @override
  String get newField => 'שדה חדש';

  @override
  String get fieldType => 'סוג';

  @override
  String get usedOn => 'בשימוש עבור';

  @override
  String get forCats => 'חתולים';

  @override
  String get forClowders => 'קבוצות';

  @override
  String get forBoth => 'שניהם';

  @override
  String get optionsOnePerLine => 'אפשרויות (אחת בכל שורה)';

  @override
  String get ownValue => 'ערך משלך';

  @override
  String get renameField => 'שינוי שם השדה';

  @override
  String get editOptions => 'עריכת אפשרויות…';

  @override
  String get noStraysRightNow => 'אין חתולי רחוב כרגע.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'הוספת חתול רחוב';

  @override
  String get newStray => 'חתול רחוב חדש';

  @override
  String get searchByNameHint => 'חיפוש חתולים לפי שם…';

  @override
  String get host => 'אירוח';

  @override
  String get hostExplainer =>
      'התחילו כאן, ואז סרקו את הקוד או הזינו אותו במכשיר השני.';

  @override
  String get startHosting => 'התחלת אירוח';

  @override
  String get stopHosting => 'עצירת האירוח';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'מפגשים עד כה: $count';
  }

  @override
  String get join => 'הצטרפות';

  @override
  String get addressFromHost => 'כתובת (מהמכשיר המארח)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'סנכרון עכשיו';

  @override
  String get addressFormatHint => 'הכתובת צריכה להיראות כמו 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'סונכרן: $result';
  }

  @override
  String syncFailed(String error) {
    return 'הסנכרון נכשל: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'סנכרון אחרון עם $peer: $time';
  }

  @override
  String get sharedFolder => 'תיקייה משותפת';

  @override
  String get sharedFolderExplainer =>
      'שני המכשירים משתמשים באותה תיקייה (למשל ב-Dropbox או בהתקן USB). כל סנכרון מניח שם את השינויים שלכם ואוסף את של הצד השני.';

  @override
  String get noFolderChosenYet => 'טרם נבחרה תיקייה';

  @override
  String get choose => 'בחירה…';

  @override
  String get syncFolderNow => 'סנכרון התיקייה עכשיו';

  @override
  String folderSynced(String result) {
    return 'התיקייה סונכרנה: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'סנכרון התיקייה נכשל: $error';
  }

  @override
  String get recordSightingHere => 'רישום תצפית כאן:';

  @override
  String trailOf(String name, int count) {
    return 'מסלול: $name (תצפיות: $count)';
  }

  @override
  String conflictOn(String field) {
    return 'התנגשות — $field';
  }

  @override
  String get conflictBody => 'שונה בשני מקומות בו-זמנית. בחרו מה נכון:';

  @override
  String mergeThisInto(String kind) {
    return 'מיזוג $kind זה עם…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'אין $kind אחר למזג איתו.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'למזג עם $name?';
  }

  @override
  String mergeBody(String name) {
    return 'שתי הרשומות הופכות לאחת. $name שומר על ערכיו הנוכחיים; ההיסטוריה של האחרת מצטרפת אליו. אין דרך חזרה.';
  }

  @override
  String get kindCat => 'חתול';

  @override
  String get kindClowder => 'קבוצה';

  @override
  String get kindField => 'שדה';

  @override
  String get takePhoto => 'צילום תמונה';

  @override
  String get chooseFromGallery => 'בחירה מהגלריה';

  @override
  String get about => 'אודות';

  @override
  String get aboutTagline =>
      'קטלוג מקומי לחתולי אומנה. הנתונים נשארים על המכשירים שלכם — בלי שרת, בלי חשבון.';

  @override
  String versionLabel(String version, String build) {
    return 'גרסה $version ($build)';
  }

  @override
  String get sourceCode => 'קוד מקור';

  @override
  String get reportProblemOrIdea => 'דיווח על בעיה או רעיון';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'כתיבה למפתח';

  @override
  String get buyCoffee => 'קנו קפה למפתח';

  @override
  String get coffeeSubtitle => 'האפליקציה נשארת חינמית. גם אם לא אקבל קפה :)';

  @override
  String get openSourceLicenses => 'רישיונות קוד פתוח';

  @override
  String get machineTranslated =>
      'התרגומים מכונה — תיקונים יתקבלו בברכה ב-GitHub.';

  @override
  String get unnamed => '(ללא שם)';

  @override
  String get labelName => 'שם';

  @override
  String get labelProfileImage => 'תמונת פרופיל';

  @override
  String get labelPhoto => 'תמונה';

  @override
  String get starterGender => 'מין';

  @override
  String get starterBreed => 'גזע';

  @override
  String get valueMixed => 'מעורב';

  @override
  String get breedEuropeanShorthair => 'אירופאי קצר שיער';

  @override
  String get breedMaineCoon => 'מיין קון';

  @override
  String get breedBritishShorthair => 'בריטי קצר שיער';

  @override
  String get breedNorwegianForestCat => 'חתול יער נורווגי';

  @override
  String get breedRagdoll => 'רגדול';

  @override
  String get breedSiamese => 'סיאמי';

  @override
  String get breedPersian => 'פרסי';

  @override
  String get breedBengal => 'בנגלי';

  @override
  String get breedSphynx => 'ספינקס';

  @override
  String get starterColor => 'צבע';

  @override
  String get starterNeutered => 'מעוקר';

  @override
  String get starterPregnant => 'בהיריון';

  @override
  String get starterBirthdate => 'תאריך לידה';

  @override
  String get starterDeceased => 'נפטר';

  @override
  String get starterAddress => 'כתובת';

  @override
  String get starterResponsible => 'אחראי';

  @override
  String get starterEmail => 'אימייל';

  @override
  String get starterPhone => 'טלפון';

  @override
  String get lookupUrlLabel => 'קישור לחיפוש';

  @override
  String lookupUrlHelp(String token) {
    return 'עמוד השירות עם $token במקום המספר, למשל https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'חיפוש';

  @override
  String lookupFailed(String url) {
    return 'אף אפליקציה לא הצליחה לפתוח את $url. העתיקו את הקישור לדפדפן.';
  }

  @override
  String get stepCat => 'חתול';

  @override
  String get stepOwner => 'בעלים';

  @override
  String get stepFace => 'תמונת פנים';

  @override
  String get stepRegistry => 'מרשם';

  @override
  String get stepReview => 'בדיקה ושמירה';

  @override
  String get stepOwnerHint =>
      'מי שמחפש את החתול — מזה נוצרת הקבוצה שלו, עם פרטי הקשר מהמודעה.';

  @override
  String get stepFaceHint =>
      'גזרו את פני החתול מהמודעה; זו תהיה תמונת הפרופיל. אפשר גם לדלג.';

  @override
  String get stepRegistryHint =>
      'מספרים שנמצאו במודעה. המסומנים יישמרו אצל החתול וניתן לפתוח אותם מאוחר יותר.';

  @override
  String get noRegistryLinks =>
      'אין קישורי מרשם במודעה הזו — אם פוספסו, נא לדווח על באג.';

  @override
  String get unknownServiceHint => 'שירות לא מוכר';

  @override
  String get rememberService => 'שמור את השירות';

  @override
  String get rememberServiceHint =>
      'תנו שם לשירות והצביעו על המספר בקישור. המודעה הבאה תתמלא לבד.';

  @override
  String get noIdInLink => 'בקישור הזה אין מספר שהאפליקציה יכולה לשמור.';

  @override
  String get whichNumber => 'איזה חלק הוא המספר?';

  @override
  String get cropAgain => 'חיתוך מחדש';

  @override
  String get noFaceYet => 'עדיין אין תמונת פנים — משתמשים בתמונת המודעה.';

  @override
  String get backLabel => 'חזרה';

  @override
  String get dangerButton => 'לא ללחוץ.\nסכנה';

  @override
  String get dangerThanks => 'תודה שאתם משתמשים ב-cat(a)log!';

  @override
  String get helpTitle => 'עזרה';

  @override
  String get showTipsAgain => 'הצג טיפים שוב';

  @override
  String get helpHome =>
      'סקירת המושבות שלך — מושבה היא מקום שבו חיים חתולים: הבית שלך, בית אומנה, מקלט. הקישו על כרטיס כדי לראות את החתולים; לחיצה ארוכה פותחת תפריט. הכפתור מימין למטה יוצר מושבה, וכרטיס חתולי הרחוב מרכז את כל החתולים בלי בית. השם למעלה הוא הקטלוג שאתה נמצא בו — הקש עליו כדי להחליף או להוסיף.';

  @override
  String get helpClowder =>
      'הכול על המקום הזה: החתולים, השדות (כתובת, איש קשר, סוג) וההיסטוריה. הדף נפתח לקריאה בלבד; העיפרון מפעיל עריכה, ושם אפשר גם להוסיף שדה. לחיצה ארוכה על שדה עורכת אותו מיד, על חתול מעבירה, מסתירה או פותחת אותו. תור שנוסף כאן יכול לקחת כמה חתולים מהמושבה, למשל לעיקור: סמנו את החתולים שבאים, סיימו פעם אחת, בטלו את הסימון של אלה שלא טופלו.';

  @override
  String get helpCat =>
      'הכול על החתול הזה: תמונות, שדות, משפחה, היסטוריה. הדף לקריאה בלבד עד שנוגעים בעיפרון. לחיצה ארוכה על שדה עוברת ישר לעריכתו; לחיצה ארוכה על תמונה פותחת את התפריט שלה. התפריט למעלה מחזיק את השאר: הסתרה, מיזוג, רישום תצפית, שיתוף החתול. פרטי נקבע בעת עריכת שדה.';

  @override
  String get helpStrays =>
      'חתולים שאין להם בית כרגע: נמצאו, ברחו או הגיעו ממודעה. כפתור המצלמה מתעד חתול שיושב מולך; כפתור המודעה הופך מודעת נעדר לחתול עם פרטי הבעלים; הסורק קורא קוד cat(a)log מהמודעה. הקש על Stray Cam לצילום תמונה; לחץ לחיצה ארוכה לצילום וידאו ושמור את הפריימים הטובים ביותר כתמונות.';

  @override
  String get helpMap =>
      'כל החתולים והמקומות עם מיקום. החיפוש מוצא חתולים, אנשים ומקומות — שם לא מוכר נבדק בכל העולם. כפתור השכבות מצייר מעגלי 500 מ\' סביב מקומות המודעות של חתול נעדר וסביב הבית שממנו ברח. החצים עוברים מסיכה לסיכה, לחיצה ארוכה על המפה רושמת תצפית.';

  @override
  String get helpCard =>
      'הכרטיס להדפסה של החתול: בחרו למעלה בעזרת התוויות מה יופיע בו, ואז שתפו כתמונה או PDF. מספרים אפשר להדפיס כ-QR או ברקוד, ומיקום הופך ל-QR שפותח מפה, בתוספת Plus Code קצר.';

  @override
  String get helpSync =>
      'כך הנתונים מגיעים לאחרים: חיבור ישיר, תיקייה ששני המכשירים רואים, או קובץ במסנג\'ר. אתם תמיד מחליטים מה יוצא — וקבצי ‎.catsync שהתקבלו נפתחים גם כאן.';

  @override
  String get helpFields =>
      'השדות שהקטלוג שלכם משתמש בהם. שנו את שמם, שנו אפשרויות של שדה בחירה או צרו שדות משלכם. שדה מזהה יכול להפנות לשירות (מרשם), ואז המספר ניתן ללחיצה אצל החתול.';

  @override
  String get helpTimeline =>
      'כל שינוי שנעשה אי פעם, החדש ביותר ראשון: מי שינה מה, מתי ולאיזה ערך. כל רשומה ניתנת לביטול — זה כותב רשומה חדשה, שום דבר לא נמחק.';

  @override
  String get helpDuplicates =>
      'חתולים או מושבות שנראים כפולים — מזהים זהים או שמות דומים מאוד עם פרטים תואמים. הקישו על זוג כדי למזג; מיזוג בלתי הפיך, ולכן נשאלת שאלה תחילה.';

  @override
  String get helpMatches =>
      'חתולים שעשויים להיות אותה חיה: מזהה זהה, או חתול רחוב שנצפה בתוך אזור החיפוש של חתול נעדר. הקישו על זוג למיזוג, לחיצה ארוכה פותחת את החתול הראשון להשוואה.';

  @override
  String get helpFlier =>
      'מודעה מצולמת הופכת לחתול ולבעלים שלו. שלב אחר שלב: פרטי החתול, פרטי הבעלים, חיתוך הפנים לתמונת הפרופיל, מספרי מרשם מהמודעה, ולבסוף בדיקה. הכול הצעות — תקנו את מה שהמצלמה קראה לא נכון.';

  @override
  String get archiveTitle => 'ארכיון';

  @override
  String get archiveExplainer =>
      'חתולים שמתו ומושבות ריקות שאיש לא נגע בהן שנים עדיין תופסים מקום — בעיקר התמונות שלהם. העברה לארכיון כותבת אותם לקובץ שאתם שומרים ואז מוחקת אותם מכאן.';

  @override
  String get archiveAction => 'לארכיון';

  @override
  String archiveSelected(int count) {
    return 'העבר $count רשומות לארכיון';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'להעביר $count רשומות לארכיון?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names ייכתבו לקובץ ואז יימחקו — במכשיר שלכם ובכל מכשיר שאתם מסתנכרנים איתו. ייבוא הקובץ מחזיר הכול; בלעדיו הם אבודים.';
  }

  @override
  String archiveDone(int count) {
    return '$count רשומות הועברו לארכיון ונמחקו';
  }

  @override
  String archiveFailed(String error) {
    return 'שום דבר לא נמחק: לא ניתן היה לכתוב את קובץ הארכיון ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'מסד נתונים $db, תמונות $photos ב-$count קבצים';
  }

  @override
  String quietForYears(int years) {
    return 'ללא שינוי $years שנים';
  }

  @override
  String get nothingToArchive => 'אין דבר ישן מספיק לארכיון.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'שינוי אחרון $date · תמונות $size';
  }

  @override
  String get helpArchive =>
      'נתונים ישנים עולים מקום, בעיקר התמונות שכל מכשיר מסונכרן נושא. כאן בוחרים חתולים שמתו ומושבות ריקות ששקטו שנים, כותבים אותם לקובץ שאתם שומרים, ומוחקים אותם. המחיקה מגיעה לכל מי שאתם מסתנכרנים איתו; ייבוא הקובץ משחזר הכול.';

  @override
  String restoreDeletedTitle(int count) {
    return 'לשחזר $count רשומות שנמחקו?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names מחוקים בקטלוג הזה, והקובץ שייבאתם מכיל אותם. שחזור מחזיר אותם לכאן ולכל מכשיר שאתם מסתנכרנים איתו.';
  }

  @override
  String get restoreAction => 'שחזר';

  @override
  String get keepDeleted => 'להשאיר מחוק';

  @override
  String get archiveNotSaved => 'שום דבר לא נמחק: הארכיון לא נשמר בשום מקום.';

  @override
  String get locateAddress => 'מצא את הכתובת במפה';

  @override
  String get addressLocated => 'הכתובת נמצאה';

  @override
  String get addressNotFound =>
      'לא נמצא מקום לכתובת הזו. בדקו את האיות או השאירו ריק.';

  @override
  String get starterPosition => 'מיקום';

  @override
  String get valueYes => 'כן';

  @override
  String get valueNo => 'לא';

  @override
  String get valueFemale => 'נקבה';

  @override
  String get valueMale => 'זכר';

  @override
  String get valueUnknown => 'לא ידוע';

  @override
  String get cropTitle => 'חיתוך התמונה';

  @override
  String get markTitle => 'סימון החתול';

  @override
  String get applyCrop => 'חיתוך';

  @override
  String get useFullPhoto => 'שימוש בתמונה המלאה';

  @override
  String get dragToSelect => 'גררו מלבן סביב החתול';

  @override
  String get dragOverTheCat => 'גררו אליפסה מעל החתול';

  @override
  String get cropPhoto => 'חיתוך…';

  @override
  String get markPhoto => 'סימון…';

  @override
  String get scanCode => 'סריקת קוד';

  @override
  String get orTypeCode => 'או הקלידו את הקוד';

  @override
  String get copyCode => 'העתקת קוד';

  @override
  String get copied => 'הועתק';

  @override
  String get invalidCode => 'הקוד הזה לא תקין';

  @override
  String get hotspotHint =>
      'אין Wi-Fi משותף? הפעילו נקודה חמה בטלפון אחד, חברו את השני וארחו כאן.';

  @override
  String get byMessenger => 'דרך מסנג\'ר';

  @override
  String get byMessengerExplainer =>
      'שלחו את כל הקטלוג כקובץ אחד ב-WhatsApp, Signal או מייל — הצד השני מייבא אותו.';

  @override
  String get shareBundle => 'שיתוף חבילת סנכרון…';

  @override
  String get importBundle => 'ייבוא חבילת סנכרון…';

  @override
  String bundleImported(String result) {
    return 'החבילה יובאה: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'הגיבוי האוטומטי האחרון נכשל: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'הייבוא נכשל: $error';
  }

  @override
  String get pickOnMap => 'בחירה במפה';

  @override
  String get useMyLocation => 'שימוש במיקום שלי';

  @override
  String get language => 'שפה';

  @override
  String get typeUnitValue => 'ערך עם יחידה';

  @override
  String get dimension => 'גודל';

  @override
  String get dimensionWeight => 'משקל';

  @override
  String get dimensionLength => 'אורך';

  @override
  String get dimensionVolume => 'נפח';

  @override
  String get dimensionTemperature => 'טמפרטורה';

  @override
  String get unitsLabel => 'יחידות';

  @override
  String get graphLabel => 'גרף';

  @override
  String get rangeWeek => 'שבוע';

  @override
  String get rangeMonth => 'חודש';

  @override
  String get rangeYear => 'שנה';

  @override
  String get rangeAll => 'הכל';

  @override
  String get rangeCustom => 'מותאם…';

  @override
  String changeSince(String delta, String date) {
    return '$delta מאז $date';
  }

  @override
  String get unitsAuto => 'כמו באזורך';

  @override
  String get unitsMetric => 'מטרי (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'אימפריאלי (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'משקל';

  @override
  String get systemDefault => 'ברירת מחדל של המערכת';

  @override
  String get iosLocalNetworkHint =>
      'אם זה ממשיך להיכשל ב-iPhone/iPad: הגדרות → פרטיות ואבטחה → רשת מקומית → אפשרו ל-cat(a)log ונסו שוב.';

  @override
  String get includePrivate => 'שיתוף נתונים פרטיים';

  @override
  String get hideLabel => 'הסתר במכשיר זה';

  @override
  String get unhideLabel => 'הצג שוב';

  @override
  String get showHiddenLabel => 'הצג מוסתרים';

  @override
  String get stopShowingHidden => 'הפסק להציג מוסתרים';

  @override
  String get starterSpecies => 'מין';

  @override
  String get starterStatus => 'סוג';

  @override
  String get statusFoster => 'בית אומנה';

  @override
  String get statusForeverHome => 'בית';

  @override
  String get statusClinic => 'מרפאה';

  @override
  String get statusShelter => 'מקלט';

  @override
  String get statusBarn => 'אסם';

  @override
  String get valueCat => 'חתול';

  @override
  String get otherOption => 'אחר…';

  @override
  String get celebrationsToggle => 'חגיגת אימוצים';

  @override
  String get celebrationsSubtitle => 'קונפטי ותרועות כשחתול עובר לבית';

  @override
  String get onMapLabel => 'על המפה';

  @override
  String get showOnMap => 'הצג על המפה';

  @override
  String get searchPlaceHint => 'חפש מקום או כתובת';

  @override
  String get noPlacesFound => 'לא נמצאו מקומות';

  @override
  String get mapSearchHint => 'חפש חתולים, קבוצות, אנשים';

  @override
  String get proposeAnotherName => 'הצע שם אחר';

  @override
  String get moderationTitle => 'מחברים וחסימות';

  @override
  String get moderationSubtitle => 'הסרת נתוני אדם לצמיתות';

  @override
  String get authorsSection => 'מי כתב בקטלוג הזה';

  @override
  String get hardDeleteAction => 'מחק הכול מהמחבר הזה';

  @override
  String hardDeleteWarning(Object name) {
    return 'מסיר כל רשומה ותמונה של $name מהמכשיר הזה. מכשירים אחרים שומרים את שלהם. לא ניתן לבטל.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'הקלד $name לאישור';
  }

  @override
  String get alsoBan => 'גם לחסום — לעולם לא לקבל עוד נתונים';

  @override
  String get bansSection => 'חסימות';

  @override
  String get unbanAction => 'הסר חסימה';

  @override
  String get deletedDone => 'נמחק.';

  @override
  String get syncSummaryTitle => 'מה הגיע';

  @override
  String get summaryAdopted => 'אומצו';

  @override
  String get summaryDeceased => 'נפטרו';

  @override
  String get summaryEscaped => 'ברחו';

  @override
  String get summaryNew => 'חדשים';

  @override
  String get summaryConflicts => 'קונפליקטים לפתרון';

  @override
  String summaryOther(Object n) {
    return '…ועוד $n שינויים';
  }

  @override
  String get starterMother => 'אם';

  @override
  String get starterFather => 'אב';

  @override
  String get familySection => 'משפחה';

  @override
  String get littermatesLabel => 'מאותה המלטה';

  @override
  String get siblingsLabel => 'אחים';

  @override
  String get kittensLabel => 'גורים';

  @override
  String get toastSettingsTitle => 'מה להכריז';

  @override
  String get toastSettingsSubtitle => 'הודעות קטנות אחרי סנכרון';

  @override
  String get toastKindAdoptions => 'אימוצים';

  @override
  String get toastKindBirths => 'לידות';

  @override
  String get toastKindDeaths => 'מקרי מוות';

  @override
  String get toastKindEscapes => 'בריחות';

  @override
  String get toastKindMoves => 'מעברים';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat אומץ על ידי $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ גור חדש: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat הלך לעולמו';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat ברח';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat עבר אל $home';
  }

  @override
  String get notACatlogFile => 'זה לא קובץ cat(a)log';

  @override
  String get nothingNewInBundle => 'אין חדש בקובץ — הכול כבר אצלך';

  @override
  String get syncChooserInPerson => 'פנים אל פנים';

  @override
  String get syncChooserInPersonSub => 'סנכרון דרך Wi-Fi';

  @override
  String get syncChooserRemote => 'מרחוק';

  @override
  String get syncChooserRemoteSub => 'סנכרון דרך תיקייה או USB';

  @override
  String get syncChooserMessenger => 'מסנג\'ר';

  @override
  String get syncChooserMessengerSub => 'ייצוא וייבוא דרך רשתות חברתיות';

  @override
  String get connectToWifiFirst =>
      'התחברו קודם ל-Wi-Fi — אז המכשירים ימצאו זה את זה';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) רוצה לסנכרן';
  }

  @override
  String get trustBothWaysNote => 'הקטלוגים יוחלפו בשני הכיוונים.';

  @override
  String get allowOnce => 'אפשר';

  @override
  String get allowAlways => 'אפשר תמיד למכשיר זה';

  @override
  String get declineAction => 'דחה';

  @override
  String get syncDeclined => 'המכשיר השני דחה את הסנכרון';

  @override
  String get trustedDevicesSection => 'מכשירים מאושרים תמיד';

  @override
  String get removeTrust => 'הסר';

  @override
  String get hostWithoutWifi => 'אירוח ללא Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'יוצר חיבור ישיר זמני לטלפון השני (ללא אינטרנט). רק cat(a)log משתמש בו והוא מתנתק לבד אחרי הסנכרון.';

  @override
  String get hotspotAndroidOnly =>
      'הקוד הזה דורש שני טלפוני אנדרואיד — ב-iPhone/iPad השתמשו ב-Wi-Fi משותף';

  @override
  String get selectClowderHint => 'בחרו קבוצה משמאל';

  @override
  String get introTitle1 => 'החתולים שלך, מסודרים';

  @override
  String get introBody1 =>
      'צרו כרטיס לכל חתול: תמונה, מין, בריאות, כל מה שתרצו לרשום. החתולים מקובצים לפי מקום המגורים — האפליקציה קוראת למקום כזה מושבה (clowder).';

  @override
  String get introTitle2 => 'עובד בלי אינטרנט';

  @override
  String get introBody2 =>
      'הכול נשמר רק בטלפון שלכם. בלי חשבון, בלי ענן. שום דבר לא נשלח אלא אם תשתפו בעצמכם.';

  @override
  String get introTitle3 => 'עבדו יחד';

  @override
  String get introBody3 =>
      'כל אחד משתמש באפליקציה שלו ומדי פעם אתם מחליפים נתונים: היפגשו וסרקו קוד, השתמשו בתיקייה משותפת או שלחו קובץ אחד במסנג\'ר. אחר כך לכולם אותו מידע.';

  @override
  String get introSkip => 'דלג';

  @override
  String get introNext => 'הבא';

  @override
  String get introDone => 'קדימה';

  @override
  String get introReplayTitle => 'היכרות מהירה';

  @override
  String get spotHomeSync => 'כאן מסתנכרנים עם מכרים. אתם מחליטים מה לשתף.';

  @override
  String get spotHomeStrays =>
      'הכרטיס הזה מרכז את כל חתולי הרחוב — חתולים בלי בית. הקישו לרשימה.';

  @override
  String get spotHomeMenu =>
      'בתפריט הזה: מציאת כפילויות ומיזוגן, ייצוא CSV ועוד.';

  @override
  String get spotCatEdit =>
      'הקישו על העיפרון כדי לערוך את החתול. טיפ: לחיצה ארוכה על שדה עורכת אותו ישירות.';

  @override
  String get spotMapLayers =>
      'מחפשים חתול נעדר? הציגו מעגלים סביב מקומות המודעות שלו וסביב הבית שממנו ברח.';

  @override
  String get spotStraysFlier =>
      'מצאתם מודעת חתול נעדר? צלמו אותה כאן — האפליקציה שומרת חתול ופרטי קשר בשבילכם.';

  @override
  String get spotStraysScan =>
      'בחלק מהמודעות יש קוד QR של cat(a)log. סרקו אותו כאן וייבאו את החתול בלי להקליד.';

  @override
  String get introTitle4 => 'מצאו חתולים נעדרים';

  @override
  String get introBody4 =>
      'ראיתם מודעה על חתול נעדר? צלמו אותה באפליקציה: היא שומרת את החתול, פרטי הבעלים והמקום. אם יופיע אחר כך חתול רחוב דומה, האפליקציה תציע התאמות אפשריות.';

  @override
  String get spotMapSearch => 'הקלידו חתול, מקום או אדם כדי לקפוץ לשם במפה.';

  @override
  String get spotCardChips =>
      'סמנו מה יופיע בכרטיס לשיתוף — השאר נשאר מחוץ לו.';

  @override
  String get spotCatMenu =>
      'כאן יש פעולות נוספות: הסתרת החתול, מיזוג כפילויות או רישום תצפית.';

  @override
  String get spotDone => 'הבנתי';

  @override
  String get spotReplayTitle => 'סיור חידושים';

  @override
  String get spotReplaySubtitle => 'הצג את הרמזים שוב בכל עמוד';

  @override
  String get spotReplayDone => 'הרמזים יוצגו שוב';

  @override
  String get searchNoResults => 'לא נמצא חתול בשם הזה';

  @override
  String get syncUnreachable =>
      'אין גישה למכשיר השני. האם שניהם באותה רשת Wi-Fi?';

  @override
  String get folderUnreachable =>
      'אין גישה לתיקייה. האם הכונן או תיקיית הענן עדיין קיימים?';

  @override
  String get crashTitle => 'זה לא היה אמור לקרות';

  @override
  String get crashBody =>
      'cat(a)log נתקל בשגיאה בלתי צפויה. הנתונים שלך בטוחים — הכול נשמר ברגע השינוי. הפעל מחדש את האפליקציה, ואם זה חוזר, שלח את הדוח כדי שנוכל לתקן.';

  @override
  String get crashRestart => 'הפעל מחדש את האפליקציה';

  @override
  String get crashSendReport => 'שלח דוח למפתח';

  @override
  String get crashLastRunBody =>
      'cat(a)log נעצר באופן בלתי צפוי בפעם הקודמת — כנראה נגמר הזיכרון. לשלוח דוח קצר כדי שנוכל לתקן?';

  @override
  String get catalogsTitle => 'קטלוגים';

  @override
  String get newCatalog => 'קטלוג חדש';

  @override
  String get intoCatalog => 'לקטלוג';

  @override
  String get catalogNameLabel => 'שם הקטלוג';

  @override
  String catalogNameTaken(String name) {
    return 'כבר קיים קטלוג בשם $name. בחר שם אחר.';
  }

  @override
  String get manageCatalogs => 'ניהול קטלוגים';

  @override
  String get helpCatalogs =>
      'כל קטלוג הוא עולם בפני עצמו: החתולים, המושבות, השדות, התמונות ושותפי הסנכרון שלו. ברלין ופריז לעולם לא מתערבבות. הקש על השם בראש המסך הראשי כדי להחליף, להוסיף או לשנות שם. השם שלך, השפה והטיפים שכבר ראית משותפים לכולם.';

  @override
  String get spotHomeCatalog =>
      'זה הקטלוג שאתה נמצא בו. הקש על השם כדי להחליף או ליצור עוד אחד.';

  @override
  String get deleteCatalog => 'מחיקת קטלוג';

  @override
  String deleteCatalogBody(String name) {
    return 'כל מה שיש ב-$name נעלם: החתולים, התמונות, ההיסטוריה. קודם נשמר קובץ מלא במקום שאליו הולכים הגיבויים האוטומטיים — ייבוא שלו מחזיר את הקטלוג. הקלד את השם לאישור.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name נמחק. הקובץ נמצא ב-$where.';
  }

  @override
  String typeTheName(String name) {
    return 'הקלד $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'שום דבר לא נמחק: לא ניתן היה לכתוב את קובץ הקטלוג ($error). פנה מקום או נסה שוב מאוחר יותר.';
  }

  @override
  String get moveToCatalog => 'העברה לקטלוג אחר';

  @override
  String movedToCatalog(int count, String name) {
    return '$count הועברו אל $name';
  }

  @override
  String get chooseWhatToMove => 'מה עובר?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'להעביר משהו אל $name?';
  }

  @override
  String get undoThisImport => 'ביטול הייבוא הזה';

  @override
  String undoImportBody(int count) {
    return '$count השינויים שהייבוא הזה הביא יוסרו. הם נכתבים תחילה לקובץ, וייבוא שלו מחזיר אותם. מי שכבר סנכרנת איתו שומר על העותק שלו — את זה אי אפשר לבטל.';
  }

  @override
  String undoneImport(String where) {
    return 'בוטל. הקובץ נמצא ב-$where.';
  }

  @override
  String get goBackTitle => 'חזרה אחורה';

  @override
  String get goBackToHere => 'לחזור לכאן';

  @override
  String get momentImport => 'לפני הייבוא';

  @override
  String get momentSync => 'לפני הסנכרון';

  @override
  String get momentMerge => 'לפני המיזוג';

  @override
  String get momentHardDelete => 'לפני מחיקת הנתונים של כותב';

  @override
  String get momentArchive => 'לפני הארכוב';

  @override
  String get momentManual => 'סומן על ידך';

  @override
  String get showOlderMoments => 'הצג ישנים יותר';

  @override
  String goBackBody(int count) {
    return 'כל מה שאחרי הרגע הזה יוסר — $count שינויים. הכול נכתב תחילה לקובץ, וייבוא שלו מחזיר הכול, וכל רגע חדש יותר הולך איתו. מי שכבר סנכרנת איתו שומר על העותק שלו — את זה אי אפשר לבטל.';
  }

  @override
  String get nameThisMoment => 'תן שם לרגע הזה';

  @override
  String get helpGoBack =>
      'הרגעים שבהם הקטלוג הזה שינה צורה: לפני כל ייבוא וכל סנכרון, לפני מיזוג, ארכוב או מחיקה, ובכל פעם שסימנת רגע בעצמך. בחירה באחד מהם מחזירה את הקטלוג לאותו מצב — כל מה שאחריו נכתב לקובץ שאתה שומר ואז מוסר, וכל רגע חדש יותר הולך איתו. מי שכבר סנכרנת איתו שומר את מה שקיבל.';

  @override
  String goBackFileFailed(String error) {
    return 'שום דבר לא הוסר: לא ניתן היה לכתוב את הקובץ ששומר אותו ($error). פנה מקום ונסה שוב.';
  }

  @override
  String get goBackChanged =>
      'לא הוסר דבר: הקטלוג השתנה בזמן שמירת הקובץ. נסה שוב.';

  @override
  String get switchBeforeDeleting =>
      'זה הקטלוג שאתה נמצא בו. עבור לאחר ואז מחק אותו.';

  @override
  String shareFileFailed(String error) {
    return 'לא ניתן היה לכתוב את קובץ השיתוף ($error). פנה מקום ונסה שוב.';
  }

  @override
  String get privateLabel => 'פרטי';

  @override
  String sharedCatalogIs(String name) {
    return 'קטלוג: $name';
  }

  @override
  String get markPrivate => 'סמן כפרטי';

  @override
  String get unmarkPrivate => 'הסר סימון פרטי';

  @override
  String get agenda => 'תזכורות';

  @override
  String get reminderLabel => 'תזכורת';

  @override
  String get agendaEmpty =>
      'אין פגישות מתוכננות. תכננו חדשות כאן בפלוס, או בדף של חתול או קבוצה.';

  @override
  String get dueToday => 'היום';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'בעוד $count ימים',
      two: 'בעוד יומיים',
      one: 'בעוד יום',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'באיחור של $count ימים',
      two: 'באיחור של יומיים',
      one: 'באיחור של יום',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'בוצע';

  @override
  String get repeatTitle => 'שוב בעוד…';

  @override
  String get noRepeatLabel => 'ללא חזרה';

  @override
  String get unitDays => 'ימים';

  @override
  String get unitWeeks => 'שבועות';

  @override
  String get unitMonths => 'חודשים';

  @override
  String get unitYears => 'שנים';

  @override
  String ageYears(int years) {
    return '$years שנים';
  }

  @override
  String ageMonths(int months) {
    return '$months חוד׳';
  }

  @override
  String get changeDateLabel => 'שינוי תאריך';

  @override
  String get removeReminderLabel => 'הסרת תזכורת';

  @override
  String get exportIcs => 'ייצוא קובץ יומן';

  @override
  String get resyncCalendar => 'סנכרן מחדש את היומן';

  @override
  String icsSavedTo(String path) {
    return 'קובץ היומן נשמר תחת $path';
  }

  @override
  String get calendarMirrorLabel => 'שיקוף ליומן המכשיר';

  @override
  String get calendarMirrorSubtitle =>
      'הפגישות מופיעות ביומן כאירועים של יום שלם. cat(a)log מעדכן אותן שם בכל הפעלה ואחרי כל שינוי. את ההתראות לפגישות מנהלים ביומן.';

  @override
  String get syncPeerOlder =>
      'במכשיר השני פועל cat(a)log ישן יותר בלי תזכורות. עדכנו שם את cat(a)log וסנכרנו שוב.';

  @override
  String get syncPeerNewer =>
      'במכשיר השני פועל cat(a)log חדש יותר. עדכנו את cat(a)log במכשיר הזה וסנכרנו שוב.';

  @override
  String get bundleNewerError =>
      'הקובץ הזה מגיע מ-cat(a)log חדש יותר. עדכנו את cat(a)log במכשיר הזה כדי לייבא אותו.';

  @override
  String get spotEar => 'אוזן חתול קטנה בפינה פירושה: לחיצה ארוכה לעוד.';

  @override
  String get addReminder => 'הוספת תזכורת';

  @override
  String get plannedSection => 'מתוכנן';

  @override
  String get reminderDialogHint =>
      'הפגישה מוצגת בתזכורות. שם אפשר לאשר או לדחות אותה. הערך מאומץ רק כשהפגישה אושרה.';

  @override
  String get reminderFor => 'עבור';

  @override
  String get reminderField => 'שדה';

  @override
  String get dueDateLabel => 'תאריך יעד';

  @override
  String get pickCalendar => 'איזה יומן?';

  @override
  String get calendarPermissionDenied =>
      'הגישה ליומן חסומה, ולכן השיקוף כבוי. אפשרו אותה בהגדרות המערכת והפעילו את השיקוף מחדש.';

  @override
  String get calendarNotChosen =>
      'לא נבחר יומן, ולכן השיקוף כבוי. הפעילו אותו מחדש ובחרו יומן.';

  @override
  String get calendarGone =>
      'היומן שנבחר כבר לא קיים, ולכן השיקוף כבוי. הפעילו אותו מחדש ובחרו יומן אחר.';

  @override
  String get noWritableCalendar =>
      'לא נמצא יומן. היכנסו בהגדרות המערכת לחשבון יומן, למשל Google, ונסו שוב.';

  @override
  String get spotHomeAgenda =>
      'התזכורות: רשימת הפגישות המתוכננות — וטרינר, תרופות, בדיקות.';

  @override
  String get spotAgendaAdd => 'תכננו פגישה חדשה.';

  @override
  String get spotAgendaCalendar =>
      'הפעילו כאן את שיקוף הפגישות של cat(a)log ליומן לבחירתכם.';

  @override
  String get helpAgenda =>
      'התזכורות מציגות את הפגישות המתוכננות לפי תאריך. יש שני סוגים: פגישות עם שעה, ותזכורות שתקפות ליום. פגישות שהוחמצו נשארות למעלה. הקשה פותחת את החתול או הקבוצה. הסימון מאשר פגישה: הערך נכתב לשדה ואפשר מיד לתכנן את הבאה, למשל בעוד שלושה חודשים. לחיצה ארוכה משנה את התאריך או מוחקת את הפגישה. המתג למעלה משקף את הפגישות ליומן בטלפון. התפריט מייצא אותן כקובץ יומן. ביקור אצל הווטרינר עם כמה חתולים הוא תור אחד: סמנו את החתולים, סדר היום מציג כרטיס אחד עם שמותיהם, ובסיום נשאל אילו חתולים טופלו — בטלו את הסימון של השאר, הם נשארים מתוכננים.';

  @override
  String get calendarRowOff => 'יומן: כבוי';

  @override
  String calendarRowOn(String name) {
    return 'יומן: $name';
  }

  @override
  String get spotAddReminderCat =>
      'תכננו פגישה לחתול הזה. היא מוצגת בתזכורות ומאושרת שם.';

  @override
  String get spotAddReminderClowder =>
      'תכננו פגישה לקבוצה הזו. היא מוצגת בתזכורות ומאושרת שם.';

  @override
  String get readOnlyCalendar => 'קריאה בלבד';

  @override
  String get appointmentLabel => 'פגישה';

  @override
  String get addAppointment => 'הוספת פגישה';

  @override
  String get planChooserTitle => 'פגישה או תזכורת?';

  @override
  String get planChooserAppointment => 'פגישה — ביקור בתאריך ושעה, עם הערות';

  @override
  String get planChooserReminder => 'תזכורת — ערך שמגיע מועדו ביום מסוים';

  @override
  String get appointmentTitleLabel => 'מה';

  @override
  String get notesLabel => 'הערות';

  @override
  String get timeLabel => 'שעה';

  @override
  String get allDayLabel => 'כל היום';

  @override
  String get alertLabel => 'התראה';

  @override
  String get alertNone => 'ללא';

  @override
  String get alertDayBefore => 'יום לפני';

  @override
  String get alertHourBefore => 'שעה לפני';

  @override
  String get linkFieldLabel => 'בסיום, לכתוב לשדה';

  @override
  String get noLinkedField => 'ללא שדה';

  @override
  String get outcomeTitle => 'איך היה?';

  @override
  String get finishLabel => 'סיום';

  @override
  String get editLabelAppointment => 'עריכת פגישה';

  @override
  String get deleteAppointment => 'מחיקת פגישה';

  @override
  String get stepFlierText => 'טקסט המודעה';

  @override
  String get qrFoundHint =>
      'נמצא קוד QR במודעה. קודים מסומנים נקראים לאיתור מספרי מרשם וקישורים.';

  @override
  String get useCode => 'להשתמש בקוד זה';

  @override
  String get qrNone => 'לא נמצא קוד QR בתמונה.';

  @override
  String qrFailed(String error) {
    return 'קריאת קוד ה-QR נכשלה: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'זוהתה מודעה של $name. יש לבדוק למטה לאיזה שדה הולכת כל שורה.';
  }

  @override
  String get flierLayoutUnknown =>
      'פריסת מודעה לא מוכרת. יש לשייך את השורות לשדות למטה; השאר נשאר בהערות.';

  @override
  String get targetRegistryNumber => 'מספר מרשם';

  @override
  String get targetLostPlace => 'כתובת (מקום האובדן)';

  @override
  String get targetContact => 'איש קשר של המרשם';

  @override
  String get targetDrop => 'התעלם';

  @override
  String get existingCat => 'חתול קיים';

  @override
  String get existingClowder => 'קבוצה קיימת';

  @override
  String get createNewInstead => 'ללא — ליצור חדש';

  @override
  String overwritesValue(String value) {
    return 'דורס את הערך הנוכחי \"$value\"';
  }

  @override
  String get abortScanTitle => 'לבטל את הסריקה?';

  @override
  String get abortScanBody => 'שום דבר לא יישמר.';

  @override
  String get abortScan => 'ביטול';

  @override
  String get keepScanning => 'להמשיך';

  @override
  String get catsOnAppointment => 'חתולים בתור הזה';

  @override
  String get noCatsHint => 'לא סומן אף חתול — התור שייך למושבה עצמה.';

  @override
  String get pickCatsTitle => 'אילו חתולים באים?';

  @override
  String catsCount(int count) {
    return '$count חתולים';
  }

  @override
  String get finishUntickHint =>
      'בטלו את הסימון של חתולים שלא טופלו; הם נשארים מתוכננים.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'מחיקת התור לכל $count החתולים';
  }
}
