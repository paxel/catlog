// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'به cat(a)log خوش آمدید';

  @override
  String get welcomeBody =>
      'نامی برای خود انتخاب کنید. هر تغییری با این نام ثبت می‌شود تا دیگران ببینند چه کسی چه کاری کرده است.';

  @override
  String get yourName => 'نام شما';

  @override
  String get start => 'شروع';

  @override
  String get clowders => 'گروه‌ها';

  @override
  String get noClowdersYet => 'هنوز گروهی نیست.\nاولین را در پایین بسازید.';

  @override
  String get strays => 'گربه‌های ولگرد';

  @override
  String get searchCats => 'جستجوی گربه‌ها';

  @override
  String get map => 'نقشه';

  @override
  String get sync => 'همگام‌سازی';

  @override
  String get fields => 'فیلدها';

  @override
  String get exportCsv => 'خروجی CSV';

  @override
  String get aboutAndFeedback => 'درباره و بازخورد';

  @override
  String get newClowder => 'گروه جدید';

  @override
  String get name => 'نام';

  @override
  String get cancel => 'لغو';

  @override
  String get create => 'ایجاد';

  @override
  String get save => 'ذخیره';

  @override
  String get delete => 'حذف';

  @override
  String get merge => 'ادغام';

  @override
  String get resolve => 'تصمیم‌گیری';

  @override
  String get open => 'باز کردن';

  @override
  String csvSavedTo(String path) {
    return 'CSV در $path ذخیره شد';
  }

  @override
  String get renameClowder => 'تغییر نام گروه';

  @override
  String get rename => 'تغییر نام';

  @override
  String get timeline => 'تاریخچه';

  @override
  String get mergeInto => 'ادغام با…';

  @override
  String get deleteClowder => 'حذف گروه';

  @override
  String get cats => 'گربه‌ها';

  @override
  String get addCat => 'افزودن گربه';

  @override
  String get newCat => 'گربهٔ جدید';

  @override
  String deleteQuestion(String name) {
    return '$name حذف شود؟';
  }

  @override
  String get deleteClowderEmptyBody => 'گروه از فهرست ناپدید می‌شود.';

  @override
  String deleteClowderBody(int count) {
    return 'گربه‌هایش ($count) حذف نمی‌شوند — ولگرد می‌شوند. اگر این را نمی‌خواهید، ابتدا آن‌ها را به گروه دیگری منتقل کنید.';
  }

  @override
  String get card => 'کارت';

  @override
  String get shareAsImage => 'اشتراک‌گذاری به‌صورت تصویر';

  @override
  String get shareAsPdf => 'اشتراک‌گذاری به‌صورت PDF';

  @override
  String get print => 'چاپ';

  @override
  String cardTitle(String name) {
    return 'کارت — $name';
  }

  @override
  String get renameCat => 'تغییر نام گربه';

  @override
  String get seenHereNow => 'همین حالا اینجا دیده شد';

  @override
  String get deleteCat => 'حذف گربه';

  @override
  String get clowderLabel => 'گروه';

  @override
  String get strayNoClowder => 'ولگرد — بدون گروه';

  @override
  String get stray => 'ولگرد';

  @override
  String get photos => 'عکس‌ها';

  @override
  String get addPhoto => 'افزودن عکس';

  @override
  String get setAsProfileImage => 'تنظیم به‌عنوان عکس نمایه';

  @override
  String get thisIsProfileImage => 'این عکس نمایه است';

  @override
  String get deletePhoto => 'حذف عکس';

  @override
  String get deletePhotoTitle => 'عکس حذف شود؟';

  @override
  String get deletePhotoBody =>
      'داده‌های عکس برای همیشه پاک می‌شوند — قابل بازگشت نیست.';

  @override
  String get deleteCatBody =>
      'گربه از همهٔ فهرست‌ها ناپدید می‌شود و عکس‌هایش برای همیشه پاک می‌شوند.';

  @override
  String get sightingRecorded => 'مشاهده در موقعیت شما ثبت شد.';

  @override
  String get noLocationAvailable =>
      'موقعیت در دسترس نیست — به‌جای آن روی نقشه لمس طولانی کنید.';

  @override
  String get moveTo => 'انتقال به';

  @override
  String get noClowderStrayOption => 'بدون گروه — ولگرد / فرار کرد';

  @override
  String timelineOf(String name) {
    return 'تاریخچه — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'واگردانی این تغییر';

  @override
  String get revertSubtitle =>
      'مقدار قبلی را به‌صورت رکوردی تازه برمی‌گرداند — تاریخچه هر دو را نگه می‌دارد.';

  @override
  String fieldCleared(String field) {
    return '$field خالی شد';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field به «$value» برگشت';
  }

  @override
  String get leftStray => 'رفت — ولگرد';

  @override
  String movedTo(String name) {
    return 'به $name منتقل شد';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat آمد';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat از $place آمد';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat به $place رفت';
  }

  @override
  String get duplicateMergedIn => 'رکورد تکراری ادغام شد';

  @override
  String get asOfToday => 'به تاریخ امروز';

  @override
  String asOfDate(String date) {
    return 'به تاریخ $date';
  }

  @override
  String get value => 'مقدار';

  @override
  String get latitudeLongitude => 'عرض جغرافیایی، طول جغرافیایی';

  @override
  String get newField => 'فیلد جدید';

  @override
  String get fieldType => 'نوع';

  @override
  String get usedOn => 'کاربرد برای';

  @override
  String get forCats => 'گربه‌ها';

  @override
  String get forClowders => 'گروه‌ها';

  @override
  String get forBoth => 'هر دو';

  @override
  String get optionsOnePerLine => 'گزینه‌ها (هر خط یکی)';

  @override
  String get renameField => 'تغییر نام فیلد';

  @override
  String get noStraysRightNow => 'فعلاً گربهٔ ولگردی نیست.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'افزودن ولگرد';

  @override
  String get newStray => 'ولگرد جدید';

  @override
  String get searchByNameHint => 'جستجوی گربه با نام…';

  @override
  String get host => 'میزبانی';

  @override
  String get hostExplainer =>
      'از اینجا شروع کنید، سپس نشانی و PIN را در دستگاه دیگر وارد کنید.';

  @override
  String get startHosting => 'شروع میزبانی';

  @override
  String get stopHosting => 'پایان میزبانی';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'نشست‌ها تاکنون: $count';
  }

  @override
  String get join => 'پیوستن';

  @override
  String get addressFromHost => 'نشانی (از دستگاه میزبان)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'اکنون همگام‌سازی کن';

  @override
  String get addressFormatHint => 'نشانی باید شبیه 192.168.0.12:38472 باشد';

  @override
  String syncedResult(String result) {
    return 'همگام شد: $result';
  }

  @override
  String syncFailed(String error) {
    return 'همگام‌سازی ناموفق: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'آخرین همگام‌سازی با $peer: $time';
  }

  @override
  String get sharedFolder => 'پوشهٔ مشترک';

  @override
  String get sharedFolderExplainer =>
      'از راه پوشه‌ای که فضای ابری یا فلش بین دستگاه‌ها می‌برد همگام شوید — برای کسانی که در یک شبکه نیستند.';

  @override
  String get noFolderChosenYet => 'هنوز پوشه‌ای انتخاب نشده';

  @override
  String get choose => 'انتخاب…';

  @override
  String get syncFolderNow => 'پوشه را اکنون همگام کن';

  @override
  String folderSynced(String result) {
    return 'پوشه همگام شد: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'همگام‌سازی پوشه ناموفق: $error';
  }

  @override
  String get recordSightingHere => 'اینجا یک مشاهده ثبت کن:';

  @override
  String get orPlaceClowderHere => 'یا اینجا یک گروه بگذار:';

  @override
  String trailOf(String name, int count) {
    return 'مسیر: $name (مشاهده‌ها: $count)';
  }

  @override
  String conflictOn(String field) {
    return 'تعارض — $field';
  }

  @override
  String get conflictBody =>
      'هم‌زمان در دو جا تغییر کرده است. درست را انتخاب کنید:';

  @override
  String mergeThisInto(String kind) {
    return 'ادغام این ($kind) با…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'مورد دیگری ($kind) برای ادغام نیست.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'با $name ادغام شود؟';
  }

  @override
  String mergeBody(String name) {
    return 'دو رکورد یکی می‌شوند. $name مقدارهای فعلی‌اش را نگه می‌دارد؛ تاریخچهٔ دیگری به آن می‌پیوندد. قابل بازگشت نیست.';
  }

  @override
  String get kindCat => 'گربه';

  @override
  String get kindClowder => 'گروه';

  @override
  String get kindField => 'فیلد';

  @override
  String get takePhoto => 'گرفتن عکس';

  @override
  String get chooseFromGallery => 'انتخاب از گالری';

  @override
  String get about => 'درباره';

  @override
  String get aboutTagline =>
      'فهرستی محلی برای گربه‌های تحت سرپرستی موقت. داده‌هایتان روی دستگاه‌های خودتان می‌ماند — بدون سرور، بدون حساب.';

  @override
  String versionLabel(String version, String build) {
    return 'نسخهٔ $version ($build)';
  }

  @override
  String get sourceCode => 'کد منبع';

  @override
  String get reportProblemOrIdea => 'گزارش مشکل یا ایده';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'نوشتن به توسعه‌دهنده';

  @override
  String get buyCoffee => 'برای توسعه‌دهنده قهوه بخر';

  @override
  String get coffeeSubtitle => 'کاملاً اختیاری — برنامه رایگان است';

  @override
  String get openSourceLicenses => 'مجوزهای متن‌باز';

  @override
  String get machineTranslated =>
      'ترجمه‌ها ماشینی‌اند — اصلاح‌ها در GitHub خوش‌آمدند.';

  @override
  String get unnamed => '(بی‌نام)';

  @override
  String get labelName => 'نام';

  @override
  String get labelProfileImage => 'عکس نمایه';

  @override
  String get labelPhoto => 'عکس';

  @override
  String get starterGender => 'جنسیت';

  @override
  String get starterColor => 'رنگ';

  @override
  String get starterNeutered => 'عقیم‌شده';

  @override
  String get starterPregnant => 'باردار';

  @override
  String get starterBirthdate => 'تاریخ تولد';

  @override
  String get starterDeceased => 'درگذشته';

  @override
  String get starterAddress => 'نشانی';

  @override
  String get starterResponsible => 'شخص مسئول';

  @override
  String get starterPosition => 'موقعیت';

  @override
  String get valueYes => 'بله';

  @override
  String get valueNo => 'خیر';

  @override
  String get valueFemale => 'ماده';

  @override
  String get valueMale => 'نر';

  @override
  String get valueUnknown => 'نامشخص';

  @override
  String get cropTitle => 'برش عکس';

  @override
  String get markTitle => 'نشانه‌گذاری گربه';

  @override
  String get useFullPhoto => 'استفاده از کل عکس';

  @override
  String get dragToSelect => 'دور گربه یک مستطیل بکشید';

  @override
  String get dragOverTheCat => 'روی گربه یک بیضی بکشید';

  @override
  String get cropPhoto => 'برش…';

  @override
  String get markPhoto => 'نشانه‌گذاری…';

  @override
  String get scanCode => 'اسکن کد';

  @override
  String get orTypeCode => 'یا کد را وارد کنید';

  @override
  String get copyCode => 'کپی کد';

  @override
  String get copied => 'کپی شد';

  @override
  String get invalidCode => 'این کد معتبر نیست';

  @override
  String get hotspotHint =>
      'وای‌فای مشترک ندارید؟ هات‌اسپات یک گوشی را روشن کنید، دیگری را وصل کنید و اینجا میزبان شوید.';

  @override
  String get byMessenger => 'با پیام‌رسان';

  @override
  String get byMessengerExplainer =>
      'کل فهرست را به‌صورت یک فایل با واتساپ، سیگنال یا ایمیل بفرستید — طرف مقابل آن را وارد می‌کند.';

  @override
  String get shareBundle => 'اشتراک بستهٔ همگام‌سازی…';

  @override
  String get importBundle => 'وارد کردن بستهٔ همگام‌سازی…';

  @override
  String bundleImported(String result) {
    return 'بسته وارد شد: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'ورود ناموفق: $error';
  }

  @override
  String get pickOnMap => 'انتخاب روی نقشه';

  @override
  String get useMyLocation => 'استفاده از موقعیت من';

  @override
  String get language => 'زبان';

  @override
  String get systemDefault => 'پیش‌فرض سیستم';

  @override
  String get iosLocalNetworkHint =>
      'اگر در iPhone/iPad همچنان ناموفق است: تنظیمات → حریم خصوصی و امنیت → شبکه محلی → به cat(a)log اجازه دهید و دوباره امتحان کنید.';

  @override
  String get markPrivate => 'علامت‌گذاری به‌عنوان خصوصی';

  @override
  String get unmarkPrivate => 'حذف علامت خصوصی';

  @override
  String get includePrivate => 'شامل کردن داده‌های خصوصی';

  @override
  String get includePrivateExplainer =>
      'گربه‌ها، گروه‌ها و فیلدهای خصوصی هم به اشتراک گذاشته می‌شوند — فقط هنگام همگام‌سازی دستگاه‌های خودتان روشن کنید.';
}
