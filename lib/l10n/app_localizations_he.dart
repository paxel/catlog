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
  String get noClowdersYet => 'אין עדיין קבוצות.\nצרו את הראשונה למטה.';

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
      'החתול ייעלם מכל הרשימות. תמונותיו נמחקות לצמיתות.';

  @override
  String get sightingRecorded => 'התצפית נרשמה במיקומך.';

  @override
  String get noLocationAvailable =>
      'אין מיקום זמין — במקום זאת לחצו לחיצה ארוכה על המפה.';

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
  String get renameField => 'שינוי שם השדה';

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
  String get orPlaceClowderHere => 'או הצבת קבוצה כאן:';

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
}
