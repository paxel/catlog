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
  String get noClowdersYet =>
      'هنوز گروهی نیست. گروه جایی است که گربه‌ها زندگی می‌کنند — خانه موقت شما، آپارتمان سرپرست. اولی را در پایین بسازید.';

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
      'گربه از همهٔ فهرست‌ها حذف می‌شود و عکس‌هایش پاک می‌شوند — اینجا و پس از همگام‌سازی بعدی روی دستگاه‌های دیگر نیز.';

  @override
  String get sightingRecorded => 'مشاهده در موقعیت شما ثبت شد.';

  @override
  String get noLocationAvailable =>
      'موقعیت در دسترس نیست — به‌جای آن روی نقشه لمس طولانی کنید.';

  @override
  String get locationDeniedForever =>
      'دسترسی به موقعیت مکانی مسدود است. برای استفاده از Stray Cam آن را در تنظیمات سیستم مجاز کنید.';

  @override
  String get locationServiceOff =>
      'موقعیت مکانی در این دستگاه خاموش است. آن را در تنظیمات روشن کنید و دوباره تلاش کنید.';

  @override
  String get locationDenied =>
      'cat(a)log اجازهٔ استفاده از موقعیت شما را ندارد. دوباره تلاش کنید و هنگام پرسش اجازه دهید.';

  @override
  String get locationNoFix =>
      'موقعیت شما اکنون قابل تعیین نیست. در فضای باز دوباره تلاش کنید — GPS به دید باز آسمان نیاز دارد.';

  @override
  String get ok => 'باشه';

  @override
  String get starterChipId => 'شمارهٔ تراشه';

  @override
  String get starterRemarks => 'یادداشت‌ها';

  @override
  String get captureFlier => 'عکس از آگهی';

  @override
  String get addPhotosTo => 'افزودن عکس‌ها به…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count عکس به $name افزوده شد';
  }

  @override
  String get scanPrintedCode => 'اسکن کد چاپی';

  @override
  String get chipScanHint =>
      'کد QR/بارکد چاپی روی کارت تراشه یا مدارک دامپزشکی را می‌خواند — تلفن نمی‌تواند تراشهٔ داخل گربه را بخواند.';

  @override
  String get savingLabel => 'در حال ذخیره…';

  @override
  String ownerOfCat(String name) {
    return 'صاحب $name';
  }

  @override
  String get sortLabel => 'مرتب‌سازی';

  @override
  String get viewAsTable => 'نمایش جدولی';

  @override
  String get viewAsTiles => 'نمایش کاشی‌وار';

  @override
  String get matchCandidatesTitle => 'موارد تطبیق احتمالی';

  @override
  String get findDuplicates => 'یافتن موارد تکراری';

  @override
  String get noDuplicates => 'در حال حاضر مورد تکراری احتمالی نیست.';

  @override
  String get similarName => 'نام مشابه';

  @override
  String get sharePublicly => 'اشتراک عمومی…';

  @override
  String get privateNoShare =>
      'این گربه خصوصی علامت‌گذاری شده — داده‌های خصوصی هرگز دستگاه شما را ترک نمی‌کنند. برای اشتراک عمومی ابتدا علامت را بردارید.';

  @override
  String get pickFramesTitle => 'انتخاب فریم‌ها';

  @override
  String get suggestedFrames => 'فریم‌های پیشنهادی';

  @override
  String get scrubFrames => 'پیمایش ویدیو';

  @override
  String get keepThisFrame => 'این فریم را نگه دار';

  @override
  String get fromVideo => 'از ویدیو…';

  @override
  String get videoMobileOnly =>
      'انتخاب فریم از ویدیو در برنامهٔ تلفن (اندروید و آیفون) کار می‌کند — هنوز در این دستگاه نه.';

  @override
  String get shareWhitelistExplainer =>
      'انتخاب کنید چه چیزی وارد فایل شود. فقط فیلدهای علامت‌خورده گنجانده می‌شوند.';

  @override
  String get exportShareFile => 'خروجی فایل اشتراک…';

  @override
  String get hostedLink => 'پیوند میزبانی‌شده (نشانی فایل بارگذاری‌شده)';

  @override
  String get inlineQr => 'QR داخلی (فقط متن، بدون عکس)';

  @override
  String get inlineTooBig =>
      'داده‌ها برای کد داخلی زیاد است — فیلدها را کم کنید یا از پیوند میزبانی‌شده استفاده کنید.';

  @override
  String get scanShareLabel => 'اسکن کد اشتراک';

  @override
  String get notAShareCode => 'این کد اشتراک cat(a)log نیست.';

  @override
  String get importShareTitle => 'این گربه وارد شود؟';

  @override
  String shareSource(String url) {
    return 'منبع: $url';
  }

  @override
  String get importLabel => 'وارد کردن';

  @override
  String get strayAreaLabel => 'محدودهٔ احتمالی پرسه‌زنی';

  @override
  String get prevPin => 'پین قبلی';

  @override
  String get nextPin => 'پین بعدی';

  @override
  String get noMissingCats => 'هنوز گربهٔ گمشده‌ای با موقعیت آگهی نیست.';

  @override
  String get noMatchCandidates => 'در حال حاضر موردی برای تطبیق نیست.';

  @override
  String sameIdField(String field) {
    return '$field یکسان';
  }

  @override
  String metersApart(String distance) {
    return '$distance متر فاصله';
  }

  @override
  String get addFlier => 'افزودن آگهی';

  @override
  String get missingSinceLabel => 'گم‌شده از';

  @override
  String get phoneLabel => 'تلفن';

  @override
  String get cropPortrait => 'برش چهره';

  @override
  String get statusOwner => 'صاحب';

  @override
  String get ocrUnavailable =>
      'تشخیص متن در این دستگاه در دسترس نیست — متن آگهی را خودتان بنویسید.';

  @override
  String get displayFormat => 'نمایش به‌صورت';

  @override
  String get displayPlain => 'متن ساده';

  @override
  String get displayQr => 'کد QR';

  @override
  String get displayBarcode => 'بارکد';

  @override
  String get editLabel => 'ویرایش';

  @override
  String get doneLabel => 'انجام شد';

  @override
  String get openSettings => 'باز کردن تنظیمات';

  @override
  String get notSaved => 'ذخیره نشد';

  @override
  String get birthdateInFuture => 'تاریخ تولد نمی‌تواند در آینده باشد.';

  @override
  String get deceasedInFuture => 'تاریخ مرگ نمی‌تواند در آینده باشد.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'تاریخ مرگ نمی‌تواند پیش از تاریخ تولد ($date) باشد.';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'تاریخ تولد نمی‌تواند پس از تاریخ مرگ ($date) باشد.';
  }

  @override
  String get malePregnant =>
      'این گربه به‌عنوان نر ثبت شده است — گربهٔ نر نمی‌تواند باردار باشد. ابتدا جنسیت را بررسی کنید.';

  @override
  String fatherNotMale(String name) {
    return '$name به‌عنوان ماده ثبت شده و نمی‌تواند پدر باشد. ابتدا جنسیت را بررسی کنید.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name به‌عنوان نر ثبت شده و نمی‌تواند مادر باشد. ابتدا جنسیت را بررسی کنید.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name در $date به دنیا آمده — والد نمی‌تواند بعد از بچه‌اش متولد شود.';
  }

  @override
  String get genderFatherFemale =>
      'این گربه به‌عنوان پدر گربه‌های دیگر ثبت شده — پدر نمی‌تواند ماده باشد. ابتدا خانواده را بررسی کنید.';

  @override
  String get genderMotherMale =>
      'این گربه به‌عنوان مادر گربه‌های دیگر ثبت شده — مادر نمی‌تواند نر باشد. ابتدا خانواده را بررسی کنید.';

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
  String dateFormatError(String format) {
    return 'قالب نادرست — از $format استفاده کنید';
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
  String get ownValue => 'مقدار دلخواه';

  @override
  String get renameField => 'تغییر نام فیلد';

  @override
  String get editOptions => 'ویرایش گزینه‌ها…';

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
      'هر دو دستگاه از یک پوشه استفاده می‌کنند (مثلاً در Dropbox یا روی فلش). هر همگام‌سازی تغییرات شما را آنجا می‌گذارد و تغییرات طرف مقابل را برمی‌دارد.';

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
  String get starterBreed => 'نژاد';

  @override
  String get valueMixed => 'مخلوط';

  @override
  String get breedEuropeanShorthair => 'اروپایی موکوتاه';

  @override
  String get breedMaineCoon => 'مین کون';

  @override
  String get breedBritishShorthair => 'بریتانیایی موکوتاه';

  @override
  String get breedNorwegianForestCat => 'گربه جنگلی نروژی';

  @override
  String get breedRagdoll => 'رگدال';

  @override
  String get breedSiamese => 'سیامی';

  @override
  String get breedPersian => 'ایرانی';

  @override
  String get breedBengal => 'بنگال';

  @override
  String get breedSphynx => 'اسفینکس';

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
  String get starterEmail => 'ایمیل';

  @override
  String get starterPhone => 'تلفن';

  @override
  String get lookupUrlLabel => 'پیوند جست‌وجو';

  @override
  String lookupUrlHelp(String token) {
    return 'صفحهٔ سرویس با $token به جای شماره، مثل https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'جست‌وجو';

  @override
  String lookupFailed(String url) {
    return 'هیچ برنامه‌ای نتوانست $url را باز کند. پیوند را در مرورگر کپی کنید.';
  }

  @override
  String get stepCat => 'گربه';

  @override
  String get stepOwner => 'صاحب';

  @override
  String get stepFace => 'عکس صورت';

  @override
  String get stepRegistry => 'سامانه ثبت';

  @override
  String get stepReview => 'بررسی و ذخیره';

  @override
  String get stepOwnerHint =>
      'کسی که گربه‌اش گم شده — این کارت او می‌شود، با تماس روی آگهی.';

  @override
  String get stepFaceHint =>
      'صورت گربه را از آگهی ببرید؛ عکس نمایه می‌شود. می‌توانید رد شوید.';

  @override
  String get stepRegistryHint =>
      'شماره‌های پیداشده روی آگهی. تیک‌خورده‌ها با گربه ذخیره می‌شوند و بعداً باز می‌شوند.';

  @override
  String get noRegistryLinks =>
      'در این آگهی پیوند سامانه‌ای نیست — اینجا کاری نیست.';

  @override
  String get unknownServiceHint => 'سرویس ناشناس';

  @override
  String get rememberService => 'سرویس را به خاطر بسپار';

  @override
  String get rememberServiceHint =>
      'سرویس را نام‌گذاری کنید و شماره را در پیوند نشان دهید. آگهی بعدی خودش پر می‌شود.';

  @override
  String get noIdInLink =>
      'این پیوند شماره‌ای ندارد که برنامه بتواند ذخیره کند.';

  @override
  String get whichNumber => 'کدام بخش شماره است؟';

  @override
  String get cropAgain => 'برش دوباره';

  @override
  String get noFaceYet => 'هنوز عکس صورت نیست — عکس آگهی استفاده می‌شود.';

  @override
  String get backLabel => 'بازگشت';

  @override
  String get dangerButton => 'فشار ندهید.\nخطر';

  @override
  String get dangerThanks => 'ممنون که از cat(a)log استفاده می‌کنید!';

  @override
  String get helpTitle => 'راهنما';

  @override
  String get showTipsAgain => 'نمایش دوبارهٔ نکته‌ها';

  @override
  String get helpHome =>
      'نمای کلی کلونی‌های شما — کلونی جایی است که گربه‌ها در آن زندگی می‌کنند: خانهٔ شما، خانهٔ نگهداری موقت، پناهگاه. روی کارت بزنید تا گربه‌هایش را ببینید؛ فشار طولانی منو را باز می‌کند. دکمهٔ پایین راست کلونی می‌سازد و کارت ولگردها همهٔ گربه‌های بی‌خانه را جمع می‌کند.';

  @override
  String get helpClowder =>
      'همه‌چیز دربارهٔ این مکان: گربه‌ها، فیلدها (نشانی، تماس، نوع) و تاریخچه. صفحه فقط خواندنی باز می‌شود؛ مداد ویرایش را روشن می‌کند و همان‌جا می‌توانید فیلد جدید بسازید. فشار طولانی روی فیلد آن را مستقیم ویرایش می‌کند و روی گربه آن را جابه‌جا، پنهان یا باز می‌کند.';

  @override
  String get helpCat =>
      'همه‌چیز دربارهٔ این گربه: عکس‌ها، فیلدها، خانواده، تاریخچه. صفحه تا زدن مداد فقط خواندنی است. فشار طولانی روی فیلد یک‌راست به ویرایش می‌برد؛ روی عکس منوی آن را باز می‌کند. منوی بالا سمت راست بقیه را دارد: خصوصی، پنهان، ادغام، ثبت مشاهده، اشتراک.';

  @override
  String get helpStrays =>
      'گربه‌هایی که اکنون خانه ندارند: پیداشده، فراری یا برگرفته از آگهی. دکمهٔ دوربین گربه‌ای را که جلوی شماست ثبت می‌کند؛ دکمهٔ آگهی یک پوستر گمشده را به گربه‌ای همراه با تماس صاحبش تبدیل می‌کند؛ اسکنر کد cat(a)log را از پوستر می‌خواند.';

  @override
  String get helpMap =>
      'همهٔ گربه‌ها و مکان‌هایی که موقعیت دارند. جست‌وجو گربه، شخص و مکان را پیدا می‌کند — نام ناشناس در سراسر جهان جست‌وجو می‌شود. دکمهٔ لایه‌ها دایره‌های ۵۰۰ متری را دور محل آگهی‌های گربهٔ گمشده و دور خانهٔ قبلی‌اش می‌کشد. پیکان‌ها از نشان به نشان می‌روند و فشار طولانی روی نقشه مشاهده ثبت می‌کند.';

  @override
  String get helpCard =>
      'کارت قابل چاپ گربه: بالا با تراشه‌ها انتخاب کنید چه چیزی روی آن بیاید، سپس آن را به‌صورت تصویر یا PDF به اشتراک بگذارید. شماره‌ها می‌توانند به شکل QR یا بارکد چاپ شوند و موقعیت به QR بازکنندهٔ نقشه به‌همراه یک Plus Code کوتاه تبدیل می‌شود.';

  @override
  String get helpSync =>
      'داده‌ها این‌گونه به دیگران می‌رسند: اتصال مستقیم، پوشه‌ای که هر دو دستگاه می‌بینند، یا فایلی از راه پیام‌رسان. همیشه شما تصمیم می‌گیرید چه چیزی برود — فایل‌های ‎.catsync دریافتی هم اینجا باز می‌شوند.';

  @override
  String get helpFields =>
      'فیلدهایی که فهرست شما به کار می‌برد. نامشان را عوض کنید، گزینه‌های یک فیلد انتخابی را تغییر دهید یا فیلد خودتان را بسازید. فیلد شناسه می‌تواند به یک سرویس (سامانهٔ ثبت) اشاره کند تا شماره نزد گربه قابل لمس شود.';

  @override
  String get helpTimeline =>
      'هر تغییری که تا کنون انجام شده، تازه‌ترین در بالا: چه کسی چه چیزی را کی و به چه مقداری تغییر داده. هر مدخل قابل بازگرداندن است — این کار مدخل تازه می‌نویسد و چیزی پاک نمی‌شود.';

  @override
  String get helpDuplicates =>
      'گربه‌ها یا کلونی‌هایی که انگار دو بار وجود دارند — شناسه‌های یکسان یا نام‌های بسیار نزدیک با جزئیات همخوان. روی یک جفت بزنید تا ادغام شود؛ ادغام بازگشت‌ناپذیر است، برای همین اول می‌پرسد.';

  @override
  String get helpMatches =>
      'گربه‌هایی که ممکن است یک حیوان باشند: شناسهٔ یکسان یا ولگردی که در محدودهٔ جست‌وجوی گربهٔ گمشده دیده شده. روی جفت بزنید تا ادغام شود، فشار طولانی گربهٔ اول را برای مقایسه باز می‌کند.';

  @override
  String get helpFlier =>
      'از یک پوستر عکس‌گرفته‌شده، گربه و صاحبش ساخته می‌شود. گام‌به‌گام: داده‌های گربه، تماس صاحب، برش صورت برای عکس نمایه، شماره‌های سامانه روی پوستر و در پایان یک بازبینی. همه پیشنهاد است — آنچه را دوربین اشتباه خوانده اصلاح کنید.';

  @override
  String get archiveTitle => 'بایگانی';

  @override
  String get archiveExplainer =>
      'گربه‌های درگذشته و کلونی‌های خالی که سال‌هاست کسی سراغشان نرفته باز هم جا می‌گیرند — به‌ویژه عکس‌هایشان. بایگانی آن‌ها را در فایلی که نگه می‌دارید می‌نویسد و سپس از اینجا حذف می‌کند.';

  @override
  String get archiveAction => 'بایگانی';

  @override
  String archiveSelected(int count) {
    return 'بایگانی $count مورد';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '$count مورد بایگانی شود؟';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names در فایلی نوشته و سپس حذف می‌شوند — روی دستگاه شما و روی هر دستگاهی که با آن همگام می‌شوید. وارد کردن فایل همه‌چیز را برمی‌گرداند؛ بدون آن از دست می‌روند.';
  }

  @override
  String archiveDone(int count) {
    return '$count مورد بایگانی و حذف شد';
  }

  @override
  String archiveFailed(String error) {
    return 'چیزی حذف نشد: فایل بایگانی نوشته نشد ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'پایگاه داده $db، عکس‌ها $photos در $count فایل';
  }

  @override
  String quietForYears(int years) {
    return '$years سال بدون تغییر';
  }

  @override
  String get nothingToArchive => 'چیزی به‌قدر کافی قدیمی برای بایگانی نیست.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'آخرین تغییر $date · عکس‌ها $size';
  }

  @override
  String get helpArchive =>
      'داده‌های قدیمی جا می‌گیرند، به‌ویژه عکس‌هایی که هر دستگاه همگام‌شده با خود می‌برد. اینجا گربه‌های درگذشته و کلونی‌های خالیِ سال‌ها ساکن را انتخاب می‌کنید، در فایلی که نگه می‌دارید می‌نویسید و حذفشان می‌کنید. حذف به همهٔ کسانی که با آن‌ها همگام می‌شوید می‌رسد؛ وارد کردن فایل همه‌چیز را بازمی‌گرداند.';

  @override
  String restoreDeletedTitle(int count) {
    return '$count مورد حذف‌شده بازیابی شود؟';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names در این فهرست حذف شده‌اند و فایلی که تازه وارد کردید آن‌ها را دارد. بازیابی آن‌ها را اینجا و روی همهٔ دستگاه‌هایی که با آن‌ها همگام می‌شوید برمی‌گرداند.';
  }

  @override
  String get restoreAction => 'بازیابی';

  @override
  String get keepDeleted => 'حذف‌شده بماند';

  @override
  String get archiveNotSaved => 'چیزی حذف نشد: بایگانی هیچ‌جا ذخیره نشد.';

  @override
  String get locateAddress => 'یافتن نشانی روی نقشه';

  @override
  String get addressLocated => 'نشانی پیدا شد';

  @override
  String get addressNotFound =>
      'برای این نشانی جایی پیدا نشد. املا را بررسی کنید یا خالی بگذارید.';

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
  String get applyCrop => 'برش';

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
  String lastBackupFailed(String error) {
    return 'آخرین پشتیبان‌گیری خودکار ناموفق بود: $error';
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
      'با این کار هر چیزی که خصوصی علامت زده‌اید هم فرستاده می‌شود. کسی که با شما همگام می‌شود آن را می‌بیند.';

  @override
  String get hideLabel => 'پنهان کردن در این دستگاه';

  @override
  String get unhideLabel => 'نمایش دوباره';

  @override
  String get showHiddenLabel => 'نمایش موارد پنهان';

  @override
  String get stopShowingHidden => 'توقف نمایش موارد پنهان';

  @override
  String get starterSpecies => 'گونه';

  @override
  String get starterStatus => 'نوع';

  @override
  String get statusFoster => 'خانه موقت';

  @override
  String get statusForeverHome => 'خانه همیشگی';

  @override
  String get statusClinic => 'درمانگاه';

  @override
  String get statusShelter => 'پناهگاه';

  @override
  String get statusBarn => 'انبار';

  @override
  String get valueCat => 'گربه';

  @override
  String get otherOption => 'دیگر…';

  @override
  String get celebrationsToggle => 'جشن گرفتن واگذاری‌ها';

  @override
  String get celebrationsSubtitle =>
      'کاغذرنگی و هلهله وقتی گربه‌ای به خانه همیشگی‌اش می‌رود';

  @override
  String get onMapLabel => 'روی نقشه';

  @override
  String get showOnMap => 'نمایش روی نقشه';

  @override
  String get searchPlaceHint => 'جستجوی مکان یا نشانی';

  @override
  String get noPlacesFound => 'مکانی یافت نشد';

  @override
  String get mapSearchHint => 'جستجوی گربه‌ها، گروه‌ها، افراد';

  @override
  String get proposeAnotherName => 'پیشنهاد نام دیگر';

  @override
  String get moderationTitle => 'نویسندگان و مسدودی‌ها';

  @override
  String get moderationSubtitle => 'حذف همیشگی داده‌های یک نفر';

  @override
  String get authorsSection => 'چه کسی در این دفتر نوشته';

  @override
  String get hardDeleteAction => 'حذف همهٔ موارد این نویسنده';

  @override
  String hardDeleteWarning(Object name) {
    return 'هر ورودی و عکس $name را از این دستگاه حذف می‌کند. دستگاه‌های دیگر نسخهٔ خود را نگه می‌دارند. قابل بازگشت نیست.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'برای تأیید $name را بنویسید';
  }

  @override
  String get alsoBan => 'مسدود هم بشود — دیگر هرگز داده نپذیر';

  @override
  String get bansSection => 'مسدودی‌ها';

  @override
  String get unbanAction => 'رفع مسدودی';

  @override
  String get deletedDone => 'حذف شد.';

  @override
  String get syncSummaryTitle => 'چه چیزی رسید';

  @override
  String get summaryAdopted => 'واگذارشده';

  @override
  String get summaryDeceased => 'درگذشته';

  @override
  String get summaryEscaped => 'فراری';

  @override
  String get summaryNew => 'جدید';

  @override
  String get summaryConflicts => 'تعارض‌های حل‌نشده';

  @override
  String summaryOther(Object n) {
    return '…و $n تغییر دیگر';
  }

  @override
  String get starterMother => 'مادر';

  @override
  String get starterFather => 'پدر';

  @override
  String get familySection => 'خانواده';

  @override
  String get littermatesLabel => 'هم‌شکم';

  @override
  String get siblingsLabel => 'خواهر و برادر';

  @override
  String get kittensLabel => 'بچه‌گربه‌ها';

  @override
  String get toastSettingsTitle => 'چه چیزی اعلام شود';

  @override
  String get toastSettingsSubtitle => 'پیام‌های کوچک پس از همگام‌سازی';

  @override
  String get toastKindAdoptions => 'واگذاری‌ها';

  @override
  String get toastKindBirths => 'تولدها';

  @override
  String get toastKindDeaths => 'مرگ‌ها';

  @override
  String get toastKindEscapes => 'فرارها';

  @override
  String get toastKindMoves => 'جابه‌جایی‌ها';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat توسط $home به فرزندی گرفته شد 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ بچه‌گربه جدید: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat درگذشت';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat فرار کرد';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat به $home نقل مکان کرد';
  }

  @override
  String get notACatlogFile => 'این یک فایل cat(a)log نیست';

  @override
  String get nothingNewInBundle => 'چیز جدیدی در فایل نیست — همه چیز را دارید';

  @override
  String get syncChooserInPerson => 'حضوری';

  @override
  String get syncChooserInPersonSub =>
      'در یک اتاق هستید — کد را اسکن کنید، در چند ثانیه تمام';

  @override
  String get syncChooserRemote => 'از راه دور';

  @override
  String get syncChooserRemoteSub =>
      'از طریق پوشه مشترک مانند Dropbox یا فلش USB';

  @override
  String get syncChooserMessenger => 'پیام‌رسان';

  @override
  String get syncChooserMessengerSub =>
      'همه چیز را به‌صورت یک فایل با هر پیام‌رسانی بفرستید — و فایل .catsync دریافتی را اینجا وارد کنید';

  @override
  String get connectToWifiFirst =>
      'اول به Wi-Fi وصل شوید — سپس دستگاه‌ها یکدیگر را پیدا می‌کنند';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) می‌خواهد همگام‌سازی کند';
  }

  @override
  String get trustBothWaysNote => 'دفترها در هر دو جهت مبادله می‌شوند.';

  @override
  String get allowOnce => 'اجازه';

  @override
  String get allowAlways => 'همیشه به این دستگاه اجازه بده';

  @override
  String get declineAction => 'رد';

  @override
  String get syncDeclined => 'دستگاه دیگر همگام‌سازی را رد کرد';

  @override
  String get trustedDevicesSection => 'دستگاه‌های همیشه مجاز';

  @override
  String get removeTrust => 'حذف';

  @override
  String get hostWithoutWifi => 'میزبانی بدون Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'یک اتصال مستقیم موقت با گوشی دیگر برقرار می‌کند (بدون اینترنت). فقط cat(a)log از آن استفاده می‌کند و پس از همگام‌سازی خودش قطع می‌شود.';

  @override
  String get hotspotAndroidOnly =>
      'این کد به دو گوشی اندروید نیاز دارد — در iPhone/iPad از Wi-Fi مشترک استفاده کنید';

  @override
  String get selectClowderHint => 'از سمت چپ یک گروه انتخاب کنید';

  @override
  String get introTitle1 => 'گربه‌هایتان، منظم';

  @override
  String get introBody1 =>
      'برای هر گربه یک کارت بسازید: عکس، جنسیت، سلامت و هرچه می‌خواهید یادداشت کنید. گربه‌ها بر اساس محل زندگی گروه‌بندی می‌شوند — برنامه به این مکان کلنی (clowder) می‌گوید.';

  @override
  String get introTitle2 => 'بدون اینترنت کار می‌کند';

  @override
  String get introBody2 =>
      'همه چیز فقط روی گوشی شما ذخیره می‌شود. نه حسابی، نه ابری. تا خودتان چیزی را به اشتراک نگذارید، چیزی ارسال نمی‌شود.';

  @override
  String get introTitle3 => 'با هم کار کنید';

  @override
  String get introBody3 =>
      'هر کس برنامهٔ خودش را دارد و گاه‌به‌گاه داده رد و بدل می‌کنید: همدیگر را ببینید و کدی اسکن کنید، از پوشهٔ مشترک استفاده کنید یا یک فایل با پیام‌رسان بفرستید. بعد همه اطلاعات یکسانی دارند.';

  @override
  String get introSkip => 'رد شدن';

  @override
  String get introNext => 'بعدی';

  @override
  String get introDone => 'برویم';

  @override
  String get introReplayTitle => 'معرفی سریع';

  @override
  String get spotHomeSync =>
      'اینجا با آشنایانتان همگام می‌شوید. شما تصمیم می‌گیرید چه چیزی را به اشتراک بگذارید.';

  @override
  String get spotHomeStrays =>
      'این کارت همهٔ ولگردها را جمع می‌کند — گربه‌های بی‌خانه. برای دیدن فهرست لمس کنید.';

  @override
  String get spotHomeMenu =>
      'در این منو: یافتن و ادغام موارد تکراری، خروجی CSV و بیشتر.';

  @override
  String get spotCatEdit =>
      'برای ویرایش گربه روی مداد بزنید. نکته: فشار طولانی روی فیلد آن را مستقیم ویرایش می‌کند.';

  @override
  String get spotMapLayers =>
      'دنبال گربهٔ گمشده‌اید؟ دور محل آگهی‌هایش و خانه‌ای که از آن فرار کرده دایره نشان دهید.';

  @override
  String get spotStraysFlier =>
      'آگهی گربهٔ گمشده دیدید؟ اینجا عکس بگیرید — برنامه گربه و تماس را برایتان ذخیره می‌کند.';

  @override
  String get spotStraysScan =>
      'بعضی آگهی‌ها کد QR مخصوص cat(a)log دارند. اینجا اسکن کنید و گربه را بدون تایپ وارد کنید.';

  @override
  String get introTitle4 => 'گربه‌های گمشده را بیابید';

  @override
  String get introBody4 =>
      'آگهی گربهٔ گمشده دیده‌اید؟ در برنامه از آن عکس بگیرید: گربه، تماس صاحبش و مکان را ذخیره می‌کند. اگر بعداً گربهٔ ولگرد مشابهی دیده شود، برنامه تطبیق‌های احتمالی را پیشنهاد می‌دهد.';

  @override
  String get spotMapSearch =>
      'گربه، مکان یا شخصی را بنویسید تا روی نقشه به آنجا بروید.';

  @override
  String get spotCardChips =>
      'علامت بزنید چه چیزی روی کارت اشتراکی باشد — بقیه بیرون می‌ماند.';

  @override
  String get spotCatMenu =>
      'کارهای بیشتر اینجاست: گربه را خصوصی کنید، پنهانش کنید، تکراری‌ها را ادغام یا مشاهده‌ای ثبت کنید.';

  @override
  String get spotDone => 'متوجه شدم';

  @override
  String get spotReplayTitle => 'تور تازه‌ها';

  @override
  String get spotReplaySubtitle => 'نمایش دوباره راهنماها در هر صفحه';

  @override
  String get spotReplayDone => 'راهنماها دوباره نمایش داده می‌شوند';

  @override
  String get searchNoResults => 'گربه‌ای با این نام یافت نشد';

  @override
  String get syncUnreachable =>
      'دستگاه دیگر در دسترس نیست. آیا هر دو در یک Wi-Fi هستند؟';

  @override
  String get folderUnreachable =>
      'پوشه در دسترس نیست. آیا درایو یا پوشه ابری هنوز وجود دارد؟';

  @override
  String get crashTitle => 'این نباید اتفاق می‌افتاد';

  @override
  String get crashBody =>
      'cat(a)log با خطای غیرمنتظره‌ای روبه‌رو شد. داده‌های شما امن است — همه چیز در لحظه تغییر ذخیره می‌شود. برنامه را دوباره راه‌اندازی کنید و اگر تکرار شد، گزارش را بفرستید تا برطرف شود.';

  @override
  String get crashRestart => 'راه‌اندازی دوباره برنامه';

  @override
  String get crashSendReport => 'ارسال گزارش به توسعه‌دهنده';

  @override
  String get crashLastRunBody =>
      'cat(a)log دفعه قبل به‌طور غیرمنتظره متوقف شد — احتمالاً حافظه تمام شد. گزارش کوتاهی فرستاده شود تا برطرف شود؟';

  @override
  String get catalogsTitle => 'کاتالوگ‌ها';

  @override
  String get newCatalog => 'کاتالوگ جدید';

  @override
  String get catalogNameLabel => 'نام کاتالوگ';

  @override
  String catalogNameTaken(String name) {
    return 'کاتالوگی با نام $name از قبل وجود دارد. نام دیگری انتخاب کنید.';
  }

  @override
  String get manageCatalogs => 'مدیریت کاتالوگ‌ها';

  @override
  String get helpCatalogs =>
      'هر کاتالوگ دنیای خودش است: گربه‌ها، کلونی‌ها، فیلدها، عکس‌ها و همگام‌سازهای خودش. برلین و پاریس هرگز مخلوط نمی‌شوند. برای تغییر، افزودن یا تغییر نام، بالای صفحهٔ خانه روی نام بزنید. نام شما، زبان و راهنماهایی که دیده‌اید بین همه مشترک است.';

  @override
  String get spotHomeCatalog =>
      'این کاتالوگی است که در آن هستید. برای تغییر یا ساخت یکی دیگر روی نام بزنید.';

  @override
  String get deleteCatalog => 'حذف کاتالوگ';

  @override
  String deleteCatalogBody(String name) {
    return 'همه‌چیز در $name از بین می‌رود: گربه‌ها، عکس‌ها و تاریخچه. ابتدا یک فایل کامل همان‌جا که پشتیبان‌های خودکار ذخیره می‌شوند نوشته می‌شود؛ وارد کردن آن کاتالوگ را برمی‌گرداند. برای تأیید نام را بنویسید.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name حذف شد. فایل در $where است.';
  }

  @override
  String typeTheName(String name) {
    return '$name را بنویسید';
  }

  @override
  String catalogExportFailed(String error) {
    return 'چیزی حذف نشد: نوشتن فایل کاتالوگ ممکن نشد ($error). کمی فضا آزاد کنید یا بعداً دوباره تلاش کنید.';
  }

  @override
  String get moveToCatalog => 'انتقال به کاتالوگ دیگر';

  @override
  String movedToCatalog(int count, String name) {
    return '$count به $name منتقل شد';
  }

  @override
  String get chooseWhatToMove => 'چه چیزی منتقل شود؟';

  @override
  String moveIntoNewCatalog(String name) {
    return 'چیزی به $name منتقل شود؟';
  }
}
