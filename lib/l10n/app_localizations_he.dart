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
      'החתול נעלם מכל הרשימות ותמונותיו מוסרות — כאן, ואחרי הסנכרון הבא גם אצל העוזרים שלך.';

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
  String get sortLabel => 'מיון';

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
      'רק השדות המסומנים עוזבים את הקטלוג. כל השאר נשאר בבית.';

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
      'התחילו כאן, ואז הזינו את הכתובת וה-PIN במכשיר השני.';

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
      'סנכרון דרך תיקייה שענן או החסן USB מעבירים בין מכשירים — למי שלא באותה רשת.';

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
  String get coffeeSubtitle => 'לגמרי רשות — האפליקציה חינמית';

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
  String get systemDefault => 'ברירת מחדל של המערכת';

  @override
  String get iosLocalNetworkHint =>
      'אם זה ממשיך להיכשל ב-iPhone/iPad: הגדרות → פרטיות ואבטחה → רשת מקומית → אפשרו ל-cat(a)log ונסו שוב.';

  @override
  String get markPrivate => 'סמן כפרטי';

  @override
  String get unmarkPrivate => 'הסר סימון פרטי';

  @override
  String get includePrivate => 'כלול נתונים פרטיים';

  @override
  String get includePrivateExplainer =>
      'חתולים, קבוצות ושדות פרטיים משותפים גם הם — הפעל רק בעת סנכרון המכשירים שלך.';

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
  String get starterStatus => 'סטטוס';

  @override
  String get statusFoster => 'בית אומנה';

  @override
  String get statusForeverHome => 'בית לתמיד';

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
  String get celebrationsSubtitle => 'קונפטי ותרועות כשחתול עובר לבית לתמיד';

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
  String get syncChooserInPersonSub => 'אתם באותו חדר — סרקו קוד, מוכן בשניות';

  @override
  String get syncChooserRemote => 'מרחוק';

  @override
  String get syncChooserRemoteSub => 'דרך תיקייה משותפת כמו Dropbox או USB';

  @override
  String get syncChooserMessenger => 'מסנג\'ר';

  @override
  String get syncChooserMessengerSub => 'שלחו הכול כקובץ אחד בכל מסנג\'ר';

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
  String get introTitle1 => 'חתולים גרים בקבוצות';

  @override
  String get introBody1 =>
      'קבוצה היא מקום שבו חתולים גרים: בית האומנה שלך, דירת מאמץ, האסם השכן. לכל חתול כרטיס עם תמונה, עובדות וכל הסיפור שלו.';

  @override
  String get introTitle2 => 'הכול נשאר אצלך';

  @override
  String get introBody2 =>
      'בלי חשבון, בלי ענן, בלי מעקב. הנתונים שלך חיים במכשיר שלך.';

  @override
  String get introTitle3 => 'שתפו את העוזרים';

  @override
  String get introBody3 =>
      'סרקו קוד ושני מכשירים מסתנכרנים בשניות, השתמשו בתיקייה משותפת או שלחו הכול כקובץ אחד.';

  @override
  String get introSkip => 'דלג';

  @override
  String get introNext => 'הבא';

  @override
  String get introDone => 'קדימה';

  @override
  String get introReplayTitle => 'היכרות מהירה';

  @override
  String get spotHomeSync =>
      'חדש: לסנכרון יש עכשיו שלוש דרכים ברורות — ושאלת אמון לפני שמשהו זורם.';

  @override
  String get spotHomeStrays =>
      'חדש: לחתולי הרחוב יש כרטיס משלהם כאן למעלה — מספר, פרצופים, הקישו לפתיחה.';

  @override
  String get spotHomeMenu =>
      'חדש: התפריט הזה מוצא חתולים ומושבות כפולים וממזג אותם.';

  @override
  String get spotCatEdit =>
      'חדש: הדף לקריאה בלבד — העיפרון עובר לעריכה, ולחיצה ארוכה על שדה עורכת אותו ישירות.';

  @override
  String get spotMapLayers =>
      'חדש: הציגו מעגלי חיפוש של 500 מ\' סביב מיקומי המודעות של חתול נעדר.';

  @override
  String get spotStraysFlier =>
      'חדש: צלמו מודעת חתול נעדר — היא הופכת לחתול, לבעלים ולפרטי הקשר.';

  @override
  String get spotStraysScan =>
      'חדש: סרקו קוד cat(a)log ממודעה לייבוא החתול ישירות.';

  @override
  String get introTitle4 => 'חתולים נעדרים';

  @override
  String get introBody4 =>
      'צלמו מודעה והחתול הנעדר נכנס לקטלוג עם פרטי הקשר של בעליו. תצפיות, מעגלי חיפוש והצעות התאמה עוזרים להחזירו הביתה.';

  @override
  String get spotMapSearch =>
      'חדש: חפשו כאן חתולים, קבוצות ואנשים — ישירות על המפה.';

  @override
  String get spotCardChips => 'חדש: בחרו מה יופיע בכרטיס לפני השיתוף.';

  @override
  String get spotCatMenu =>
      'חדש: סמנו חתול כפרטי (לעולם לא עוזב את המכשיר) או הסתירו אותו כאן.';

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
}
