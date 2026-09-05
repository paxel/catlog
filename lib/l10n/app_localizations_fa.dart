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
  String get clowdersNeutral => 'خانوارها';

  @override
  String get noClowdersYet =>
      'هنوز گروهی نیست. گروه جایی است که گربه‌ها زندگی می‌کنند — خانه موقت شما، آپارتمان سرپرست. اولی را در پایین بسازید.';

  @override
  String get noClowdersYetNeutral =>
      'هنوز خانواری نیست. خانوار جایی است که حیوانات خانگی زندگی می‌کنند — خانهٔ شما، خانه موقت، آپارتمان سرپرست. اولی را در پایین بسازید.';

  @override
  String get strays => 'گربه‌های ولگرد';

  @override
  String get searchCats => 'جستجوی گربه‌ها';

  @override
  String get searchCatsNeutral => 'جستجوی حیوانات خانگی';

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
  String get settings => 'تنظیمات';

  @override
  String get newClowder => 'گروه جدید';

  @override
  String get newClowderNeutral => 'خانوار جدید';

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
  String get renameClowderNeutral => 'تغییر نام خانوار';

  @override
  String get rename => 'تغییر نام';

  @override
  String get timeline => 'تاریخچه';

  @override
  String get mergeInto => 'ادغام با…';

  @override
  String get deleteClowder => 'حذف گروه';

  @override
  String get deleteClowderNeutral => 'حذف خانوار';

  @override
  String get cats => 'گربه‌ها';

  @override
  String get catsNeutral => 'حیوانات خانگی';

  @override
  String get addCat => 'افزودن گربه';

  @override
  String get addCatNeutral => 'افزودن حیوان خانگی';

  @override
  String get newCat => 'گربهٔ جدید';

  @override
  String get newCatNeutral => 'حیوان خانگی جدید';

  @override
  String deleteQuestion(String name) {
    return '$name حذف شود؟';
  }

  @override
  String get deleteClowderEmptyBody => 'گروه از فهرست ناپدید می‌شود.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'خانوار از فهرست ناپدید می‌شود.';

  @override
  String deleteClowderBody(int count) {
    return 'گربه‌هایش ($count) حذف نمی‌شوند — ولگرد می‌شوند. اگر این را نمی‌خواهید، ابتدا آن‌ها را به گروه دیگری منتقل کنید.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'حیوانات خانگی‌اش ($count) حذف نمی‌شوند — ولگرد می‌شوند. اگر این را نمی‌خواهید، ابتدا آن‌ها را به خانوار دیگری منتقل کنید.';
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
  String get renameCatNeutral => 'تغییر نام حیوان خانگی';

  @override
  String get seenHereNow => 'همین حالا اینجا دیده شد';

  @override
  String get deleteCat => 'حذف گربه';

  @override
  String get deleteCatNeutral => 'حذف حیوان خانگی';

  @override
  String get clowderLabel => 'گروه';

  @override
  String get clowderLabelNeutral => 'خانوار';

  @override
  String get strayNoClowder => 'ولگرد — بدون گروه';

  @override
  String get strayNoClowderNeutral => 'ولگرد — بدون خانوار';

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
  String get deleteCatBodyNeutral =>
      'حیوان خانگی از همهٔ فهرست‌ها حذف می‌شود و عکس‌هایش پاک می‌شوند — اینجا و پس از همگام‌سازی بعدی روی دستگاه‌های دیگر نیز.';

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
  String get chipScanHintNeutral =>
      'کد QR/بارکد چاپی روی کارت تراشه یا مدارک دامپزشکی را می‌خواند — تلفن نمی‌تواند تراشهٔ داخل حیوان را بخواند.';

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
  String get viewAsList => 'نمایش به صورت فهرست';

  @override
  String get ageLabel => 'سن';

  @override
  String get catList => 'فهرست گربه‌ها';

  @override
  String get catListNeutral => 'فهرست حیوانات خانگی';

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
  String get importShareTitleNeutral => 'این حیوان خانگی وارد شود؟';

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
  String get noMissingCatsNeutral =>
      'هنوز حیوان خانگی گمشده‌ای با موقعیت آگهی نیست.';

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
  String get malePregnantNeutral =>
      'این حیوان خانگی به‌عنوان نر ثبت شده است — نر نمی‌تواند باردار باشد. ابتدا جنسیت را بررسی کنید.';

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
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name در $date به دنیا آمده — والد نمی‌تواند بعد از بچه‌اش متولد شود.';
  }

  @override
  String get genderFatherFemale =>
      'این گربه به‌عنوان پدر گربه‌های دیگر ثبت شده — پدر نمی‌تواند ماده باشد. ابتدا خانواده را بررسی کنید.';

  @override
  String get genderFatherFemaleNeutral =>
      'این حیوان خانگی به‌عنوان پدر حیوانات خانگی دیگر ثبت شده — پدر نمی‌تواند ماده باشد. ابتدا خانواده را بررسی کنید.';

  @override
  String get genderMotherMale =>
      'این گربه به‌عنوان مادر گربه‌های دیگر ثبت شده — مادر نمی‌تواند نر باشد. ابتدا خانواده را بررسی کنید.';

  @override
  String get genderMotherMaleNeutral =>
      'این حیوان خانگی به‌عنوان مادر حیوانات خانگی دیگر ثبت شده — مادر نمی‌تواند نر باشد. ابتدا خانواده را بررسی کنید.';

  @override
  String get moveTo => 'انتقال به';

  @override
  String get noClowderStrayOption => 'بدون گروه — ولگرد / فرار کرد';

  @override
  String get noClowderStrayOptionNeutral => 'بدون خانوار — ولگرد / فرار کرد';

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
  String get dateInFuture => 'این تاریخ نمی‌تواند در آینده باشد.';

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
  String get forCatsNeutral => 'حیوانات خانگی';

  @override
  String get forClowders => 'گروه‌ها';

  @override
  String get forClowdersNeutral => 'خانوارها';

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
  String get searchByNameHintNeutral => 'جستجوی حیوان خانگی با نام…';

  @override
  String get host => 'میزبانی';

  @override
  String get hostExplainer =>
      'از اینجا شروع کنید، سپس کد را در دستگاه دیگر اسکن یا وارد کنید.';

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
  String get kindCatNeutral => 'حیوان خانگی';

  @override
  String get kindClowder => 'گروه';

  @override
  String get kindClowderNeutral => 'خانوار';

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
  String get aboutTaglineNeutral =>
      'فهرستی محلی برای حیوانات خانگی‌ای که از آن‌ها مراقبت می‌کنید. داده‌هایتان روی دستگاه‌های خودتان می‌ماند — بدون سرور، بدون حساب.';

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
  String get coffeeSubtitle =>
      'برنامه رایگان می‌ماند. حتی اگر قهوه‌ای گیرم نیاید :)';

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
  String get stepCatNeutral => 'حیوان خانگی';

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
      'کسی که گربه‌اش گم شده — این گروه او می‌شود، با تماس روی آگهی.';

  @override
  String get stepOwnerHintNeutral =>
      'کسی که حیوان خانگی‌اش گم شده — این خانوار او می‌شود، با تماس روی آگهی.';

  @override
  String get stepFaceHint =>
      'صورت گربه را از آگهی ببرید؛ عکس نمایه می‌شود. می‌توانید رد شوید.';

  @override
  String get stepFaceHintNeutral =>
      'صورت حیوان خانگی را از آگهی ببرید؛ عکس نمایه می‌شود. می‌توانید رد شوید.';

  @override
  String get stepRegistryHint =>
      'شماره‌های پیداشده روی آگهی. تیک‌خورده‌ها با گربه ذخیره می‌شوند و بعداً باز می‌شوند.';

  @override
  String get stepRegistryHintNeutral =>
      'شماره‌های پیداشده روی آگهی. تیک‌خورده‌ها با حیوان خانگی ذخیره می‌شوند و بعداً باز می‌شوند.';

  @override
  String get noRegistryLinks =>
      'در این آگهی پیوند سامانه‌ای نیست — اگر موردی از قلم افتاده، لطفاً باگ گزارش کنید.';

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
      'نمای کلی کلونی‌های شما — کلونی جایی است که گربه‌ها در آن زندگی می‌کنند: خانهٔ شما، خانهٔ نگهداری موقت، پناهگاه. روی کارت بزنید تا گربه‌هایش را ببینید؛ فشار طولانی منو را باز می‌کند. دکمهٔ پایین راست کلونی می‌سازد و کارت ولگردها همهٔ گربه‌های بی‌خانه را جمع می‌کند. نام بالا کاتالوگی است که در آن هستید — برای تغییر یا افزودن روی آن بزنید.';

  @override
  String get helpHomeNeutral =>
      'نمای کلی خانوارهای شما — خانوار جایی است که حیوانات خانگی در آن زندگی می‌کنند: خانهٔ شما، خانهٔ نگهداری موقت، پناهگاه. روی کارت بزنید تا حیوانات خانگی‌اش را ببینید؛ فشار طولانی منو را باز می‌کند. دکمهٔ پایین راست خانوار می‌سازد و کارت ولگردها همهٔ حیوانات خانگی بی‌خانه را جمع می‌کند. نام بالا کاتالوگی است که در آن هستید — برای تغییر یا افزودن روی آن بزنید.';

  @override
  String get helpClowder =>
      'همه‌چیز دربارهٔ این مکان: گربه‌ها، فیلدها (نشانی، تماس، نوع) و تاریخچه. صفحه فقط خواندنی باز می‌شود؛ مداد ویرایش را روشن می‌کند و همان‌جا می‌توانید فیلد جدید بسازید. فشار طولانی روی فیلد آن را مستقیم ویرایش می‌کند و روی گربه آن را جابه‌جا، پنهان یا باز می‌کند. نوبتی که اینجا اضافه می‌شود می‌تواند چند گربه از کلونی را با خود ببرد، مثلاً برای عقیم‌سازی: گربه‌هایی را که می‌آیند علامت بزنید، یک بار پایان دهید، علامت درمان‌نشده‌ها را بردارید.';

  @override
  String get helpClowderNeutral =>
      'همه‌چیز دربارهٔ این مکان: حیوانات خانگی، فیلدها (نشانی، تماس، نوع) و تاریخچه. صفحه فقط خواندنی باز می‌شود؛ مداد ویرایش را روشن می‌کند و همان‌جا می‌توانید فیلد جدید بسازید. فشار طولانی روی فیلد آن را مستقیم ویرایش می‌کند و روی حیوان خانگی آن را جابه‌جا، پنهان یا باز می‌کند. نوبتی که اینجا اضافه می‌شود می‌تواند چند حیوان خانگی از خانوار را با خود ببرد، مثلاً برای عقیم‌سازی: حیواناتی را که می‌آیند علامت بزنید، یک بار پایان دهید، علامت درمان‌نشده‌ها را بردارید.';

  @override
  String get helpCat =>
      'همه چیز درباره این گربه: عکس‌ها، فیلدها، خانواده، تاریخچه. صفحه فقط‌خواندنی است تا روی مداد بزنی. نگه‌داشتن یک فیلد مستقیم به ویرایش آن می‌رود؛ نگه‌داشتن یک عکس منوی آن را باز می‌کند. منوی بالا بقیه را دارد: پنهان کردن، ادغام، ثبت مشاهده، اشتراک گربه. «خصوصی» هنگام ویرایش فیلد تنظیم می‌شود.';

  @override
  String get helpCatNeutral =>
      'همه چیز درباره این حیوان خانگی: عکس‌ها، فیلدها، خانواده، تاریخچه. صفحه فقط‌خواندنی است تا روی مداد بزنی. نگه‌داشتن یک فیلد مستقیم به ویرایش آن می‌رود؛ نگه‌داشتن یک عکس منوی آن را باز می‌کند. منوی بالا بقیه را دارد: پنهان کردن، ادغام، ثبت مشاهده، اشتراک حیوان خانگی. «خصوصی» هنگام ویرایش فیلد تنظیم می‌شود.';

  @override
  String get helpStrays =>
      'گربه‌هایی که اکنون خانه ندارند: پیداشده، فراری یا برگرفته از آگهی. دکمهٔ دوربین گربه‌ای را که جلوی شماست ثبت می‌کند؛ دکمهٔ آگهی یک پوستر گمشده را به گربه‌ای همراه با تماس صاحبش تبدیل می‌کند؛ اسکنر کد cat(a)log را از پوستر می‌خواند. برای عکس روی Stray Cam ضربه بزنید؛ برای فیلم‌برداری نگه دارید و بهترین فریم‌ها را به‌عنوان عکس نگه دارید.';

  @override
  String get helpStraysNeutral =>
      'حیوانات خانگی‌ای که اکنون خانه ندارند: پیداشده، فراری یا برگرفته از آگهی. دکمهٔ دوربین حیوانی را که جلوی شماست ثبت می‌کند؛ دکمهٔ آگهی یک پوستر گمشده را به حیوان خانگی همراه با تماس صاحبش تبدیل می‌کند؛ اسکنر کد cat(a)log را از پوستر می‌خواند. برای عکس روی Stray Cam ضربه بزنید؛ برای فیلم‌برداری نگه دارید و بهترین فریم‌ها را به‌عنوان عکس نگه دارید.';

  @override
  String get helpMap =>
      'همهٔ گربه‌ها و مکان‌هایی که موقعیت دارند. جست‌وجو گربه، شخص و مکان را پیدا می‌کند — نام ناشناس در سراسر جهان جست‌وجو می‌شود. دکمهٔ لایه‌ها دایره‌های ۵۰۰ متری را دور محل آگهی‌های گربهٔ گمشده و دور خانهٔ قبلی‌اش می‌کشد. پیکان‌ها از نشان به نشان می‌روند و فشار طولانی روی نقشه مشاهده ثبت می‌کند.';

  @override
  String get helpMapNeutral =>
      'همهٔ حیوانات خانگی و مکان‌هایی که موقعیت دارند. جست‌وجو حیوان خانگی، شخص و مکان را پیدا می‌کند — نام ناشناس در سراسر جهان جست‌وجو می‌شود. دکمهٔ لایه‌ها دایره‌های ۵۰۰ متری را دور محل آگهی‌های حیوان خانگی گمشده و دور خانهٔ قبلی‌اش می‌کشد. پیکان‌ها از نشان به نشان می‌روند و فشار طولانی روی نقشه مشاهده ثبت می‌کند.';

  @override
  String get helpCard =>
      'کارت قابل چاپ گربه: بالا با تراشه‌ها انتخاب کنید چه چیزی روی آن بیاید، سپس آن را به‌صورت تصویر یا PDF به اشتراک بگذارید. شماره‌ها می‌توانند به شکل QR یا بارکد چاپ شوند و موقعیت به QR بازکنندهٔ نقشه به‌همراه یک Plus Code کوتاه تبدیل می‌شود.';

  @override
  String get helpCardNeutral =>
      'کارت قابل چاپ حیوان خانگی: بالا با تراشه‌ها انتخاب کنید چه چیزی روی آن بیاید، سپس آن را به‌صورت تصویر یا PDF به اشتراک بگذارید. شماره‌ها می‌توانند به شکل QR یا بارکد چاپ شوند و موقعیت به QR بازکنندهٔ نقشه به‌همراه یک Plus Code کوتاه تبدیل می‌شود.';

  @override
  String get helpSync =>
      'داده‌ها این‌گونه به دیگران می‌رسند: اتصال مستقیم، پوشه‌ای که هر دو دستگاه می‌بینند، یا فایلی از راه پیام‌رسان. همیشه شما تصمیم می‌گیرید چه چیزی برود — فایل‌های ‎.catsync دریافتی هم اینجا باز می‌شوند.';

  @override
  String get helpFields =>
      'فیلدهایی که فهرست شما به کار می‌برد. نامشان را عوض کنید، گزینه‌های یک فیلد انتخابی را تغییر دهید یا فیلد خودتان را بسازید. فیلد شناسه می‌تواند به یک سرویس (سامانهٔ ثبت) اشاره کند تا شماره نزد گربه قابل لمس شود.';

  @override
  String get helpFieldsNeutral =>
      'فیلدهایی که فهرست شما به کار می‌برد. نامشان را عوض کنید، گزینه‌های یک فیلد انتخابی را تغییر دهید یا فیلد خودتان را بسازید. فیلد شناسه می‌تواند به یک سرویس (سامانهٔ ثبت) اشاره کند تا شماره نزد حیوان خانگی قابل لمس شود.';

  @override
  String get helpTimeline =>
      'هر تغییری که تا کنون انجام شده، تازه‌ترین در بالا: چه کسی چه چیزی را کی و به چه مقداری تغییر داده. هر مدخل قابل بازگرداندن است — این کار مدخل تازه می‌نویسد و چیزی پاک نمی‌شود.';

  @override
  String get helpDuplicates =>
      'گربه‌ها یا کلونی‌هایی که انگار دو بار وجود دارند — شناسه‌های یکسان یا نام‌های بسیار نزدیک با جزئیات همخوان. روی یک جفت بزنید تا ادغام شود؛ ادغام بازگشت‌ناپذیر است، برای همین اول می‌پرسد.';

  @override
  String get helpDuplicatesNeutral =>
      'حیوانات خانگی یا خانوارهایی که انگار دو بار وجود دارند — شناسه‌های یکسان یا نام‌های بسیار نزدیک با جزئیات همخوان. روی یک جفت بزنید تا ادغام شود؛ ادغام بازگشت‌ناپذیر است، برای همین اول می‌پرسد.';

  @override
  String get helpMatches =>
      'گربه‌هایی که ممکن است یک حیوان باشند: شناسهٔ یکسان یا ولگردی که در محدودهٔ جست‌وجوی گربهٔ گمشده دیده شده. روی جفت بزنید تا ادغام شود، فشار طولانی گربهٔ اول را برای مقایسه باز می‌کند.';

  @override
  String get helpMatchesNeutral =>
      'حیوانات خانگی‌ای که ممکن است یک حیوان باشند: شناسهٔ یکسان یا ولگردی که در محدودهٔ جست‌وجوی حیوان خانگی گمشده دیده شده. روی جفت بزنید تا ادغام شود، فشار طولانی حیوان خانگی اول را برای مقایسه باز می‌کند.';

  @override
  String get helpFlier =>
      'از یک پوستر عکس‌گرفته‌شده، گربه و صاحبش ساخته می‌شود. گام‌به‌گام: داده‌های گربه، تماس صاحب، برش صورت برای عکس نمایه، شماره‌های سامانه روی پوستر و در پایان یک بازبینی. همه پیشنهاد است — آنچه را دوربین اشتباه خوانده اصلاح کنید.';

  @override
  String get helpFlierNeutral =>
      'از یک پوستر عکس‌گرفته‌شده، حیوان خانگی و صاحبش ساخته می‌شود. گام‌به‌گام: داده‌های حیوان خانگی، تماس صاحب، برش صورت برای عکس نمایه، شماره‌های سامانه روی پوستر و در پایان یک بازبینی. همه پیشنهاد است — آنچه را دوربین اشتباه خوانده اصلاح کنید.';

  @override
  String get archiveTitle => 'بایگانی';

  @override
  String get archiveExplainer =>
      'گربه‌های درگذشته و کلونی‌های خالی که سال‌هاست کسی سراغشان نرفته باز هم جا می‌گیرند — به‌ویژه عکس‌هایشان. بایگانی آن‌ها را در فایلی که نگه می‌دارید می‌نویسد و سپس از اینجا حذف می‌کند.';

  @override
  String get archiveExplainerNeutral =>
      'حیوانات خانگی درگذشته و خانوارهای خالی که سال‌هاست کسی سراغشان نرفته باز هم جا می‌گیرند — به‌ویژه عکس‌هایشان. بایگانی آن‌ها را در فایلی که نگه می‌دارید می‌نویسد و سپس از اینجا حذف می‌کند.';

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
  String get helpArchiveNeutral =>
      'داده‌های قدیمی جا می‌گیرند، به‌ویژه عکس‌هایی که هر دستگاه همگام‌شده با خود می‌برد. اینجا حیوانات خانگی درگذشته و خانوارهای خالیِ سال‌ها ساکن را انتخاب می‌کنید، در فایلی که نگه می‌دارید می‌نویسید و حذفشان می‌کنید. حذف به همهٔ کسانی که با آن‌ها همگام می‌شوید می‌رسد؛ وارد کردن فایل همه‌چیز را بازمی‌گرداند.';

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
  String get addressFoundTitle => 'نشانی پیدا شد';

  @override
  String get replaceAddressOption => 'جایگزینی نشانی با این';

  @override
  String get addPositionOption => 'ذخیرهٔ موقعیت';

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
  String get markTitleNeutral => 'نشانه‌گذاری حیوان خانگی';

  @override
  String get applyCrop => 'برش';

  @override
  String get useFullPhoto => 'استفاده از کل عکس';

  @override
  String get dragToSelect => 'دور گربه یک مستطیل بکشید';

  @override
  String get dragToSelectNeutral => 'دور حیوان خانگی یک مستطیل بکشید';

  @override
  String get dragOverTheCat => 'روی گربه یک بیضی بکشید';

  @override
  String get dragOverTheCatNeutral => 'روی حیوان خانگی یک بیضی بکشید';

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
  String get typeUnitValue => 'مقدار با واحد';

  @override
  String get dimension => 'کمیت';

  @override
  String get dimensionWeight => 'وزن';

  @override
  String get dimensionLength => 'طول';

  @override
  String get dimensionVolume => 'حجم';

  @override
  String get dimensionTemperature => 'دما';

  @override
  String get unitsLabel => 'واحدها';

  @override
  String get catalogHolds => 'این کاتالوگ شامل';

  @override
  String get modeCats => 'گربه‌ها';

  @override
  String get modePets => 'حیوانات خانگی';

  @override
  String get graphLabel => 'نمودار';

  @override
  String get rangeWeek => 'هفته';

  @override
  String get rangeMonth => 'ماه';

  @override
  String get rangeYear => 'سال';

  @override
  String get rangeAll => 'همه';

  @override
  String get rangeCustom => 'دلخواه…';

  @override
  String changeSince(String delta, String date) {
    return '$delta از $date';
  }

  @override
  String get unitsAuto => 'مطابق منطقهٔ شما';

  @override
  String get unitsMetric => 'متریک (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'امپریال (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'وزن';

  @override
  String get systemDefault => 'پیش‌فرض سیستم';

  @override
  String get iosLocalNetworkHint =>
      'اگر در iPhone/iPad همچنان ناموفق است: تنظیمات → حریم خصوصی و امنیت → شبکه محلی → به cat(a)log اجازه دهید و دوباره امتحان کنید.';

  @override
  String get includePrivate => 'اشتراک داده‌های خصوصی';

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
  String get statusForeverHome => 'خانه';

  @override
  String get statusClinic => 'درمانگاه';

  @override
  String get statusShelter => 'پناهگاه';

  @override
  String get statusBarn => 'انبار';

  @override
  String get valueCat => 'گربه';

  @override
  String get valueDog => 'سگ';

  @override
  String get valueRabbit => 'خرگوش';

  @override
  String get valueGuineaPig => 'خوکچه هندی';

  @override
  String get valueHamster => 'همستر';

  @override
  String get valueBird => 'پرنده';

  @override
  String get valueHorse => 'اسب';

  @override
  String get valueTortoise => 'لاک‌پشت';

  @override
  String get valueFerret => 'راسو';

  @override
  String get otherOption => 'دیگر…';

  @override
  String get celebrationsToggle => 'جشن گرفتن واگذاری‌ها';

  @override
  String get celebrationsSubtitle =>
      'کاغذرنگی و هلهله وقتی گربه‌ای به خانه‌اش می‌رود';

  @override
  String get celebrationsSubtitleNeutral =>
      'کاغذرنگی و هلهله وقتی حیوان خانگی‌ای به خانه‌اش می‌رود';

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
  String get mapSearchHintNeutral => 'جستجوی حیوانات خانگی، خانوارها، افراد';

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
  String conflictsMenu(int n) {
    return 'تعارض‌ها ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'اینجا یک تعارض را حل کردید، پس «رد» غیرفعال است: آن را هم برمی‌گرداند.';

  @override
  String get arrivalIntro =>
      'این تغییرات از قبل در کاتالوگ شما هستند. «رد» آن را به حالت قبل برمی‌گرداند.';

  @override
  String get summaryUpdated => 'به‌روز شده';

  @override
  String get summaryMeta => 'همچنین رسید';

  @override
  String changesCount(int n) {
    return '$n تغییر';
  }

  @override
  String get acceptArrival => 'پذیرش';

  @override
  String get rejectArrival => 'رد';

  @override
  String get photoAdded => 'عکس افزوده شد';

  @override
  String get photoRemoved => 'عکس حذف شد';

  @override
  String metaFieldAdded(String name) {
    return 'فیلد جدید: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'فیلد تغییر کرد: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser در $survivor ادغام شد';
  }

  @override
  String metaPhotos(int n) {
    return '$n عکس';
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
  String get kittensLabelNeutral => 'بچه‌ها';

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
  String toastBornNeutral(Object cat) {
    return '✨ تازه‌متولد: $cat ✨';
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
  String get syncChooserInPersonSub => 'همگام‌سازی از طریق Wi-Fi';

  @override
  String get syncChooserRemote => 'از راه دور';

  @override
  String get syncChooserRemoteSub => 'همگام‌سازی از طریق پوشه یا USB';

  @override
  String get syncChooserMessenger => 'پیام‌رسان';

  @override
  String get syncChooserMessengerSub =>
      'صادرات و واردات از طریق شبکه‌های اجتماعی';

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
  String get selectClowderHintNeutral => 'از سمت چپ یک خانوار انتخاب کنید';

  @override
  String get introTitle1 => 'گربه‌هایتان، منظم';

  @override
  String get introTitle1Neutral => 'حیوانات خانگی‌تان، منظم';

  @override
  String get introBody1 =>
      'برای هر گربه یک کارت بسازید: عکس، جنسیت، سلامت و هرچه می‌خواهید یادداشت کنید. گربه‌ها بر اساس محل زندگی گروه‌بندی می‌شوند — برنامه به این مکان کلنی (clowder) می‌گوید.';

  @override
  String get introBody1Neutral =>
      'برای هر حیوان خانگی‌ای که از آن مراقبت می‌کنید یک کارت بسازید: عکس، جنسیت، سلامت و هرچه می‌خواهید یادداشت کنید. حیوانات خانگی بر اساس محل زندگی گروه‌بندی می‌شوند — برنامه به این مکان خانوار می‌گوید.';

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
  String get spotHomeStraysNeutral =>
      'این کارت همهٔ ولگردها را جمع می‌کند — حیوانات خانگی بی‌خانه. برای دیدن فهرست لمس کنید.';

  @override
  String get spotHomeMenu =>
      'در این منو: تنظیمات، یافتن و ادغام موارد تکراری، خروجی CSV و بیشتر.';

  @override
  String get spotCatEdit =>
      'برای ویرایش گربه روی مداد بزنید. نکته: فشار طولانی روی فیلد آن را مستقیم ویرایش می‌کند.';

  @override
  String get spotCatEditNeutral =>
      'برای ویرایش حیوان خانگی روی مداد بزنید. نکته: فشار طولانی روی فیلد آن را مستقیم ویرایش می‌کند.';

  @override
  String get spotMapLayers =>
      'دنبال گربهٔ گمشده‌اید؟ دور محل آگهی‌هایش و خانه‌ای که از آن فرار کرده دایره نشان دهید.';

  @override
  String get spotMapLayersNeutral =>
      'دنبال حیوان خانگی گمشده‌اید؟ دور محل آگهی‌هایش و خانه‌ای که از آن فرار کرده دایره نشان دهید.';

  @override
  String get spotStraysFlier =>
      'آگهی گربهٔ گمشده دیدید؟ اینجا عکس بگیرید — برنامه گربه و تماس را برایتان ذخیره می‌کند.';

  @override
  String get spotStraysFlierNeutral =>
      'آگهی حیوان خانگی گمشده دیدید؟ اینجا عکس بگیرید — برنامه حیوان خانگی و تماس را برایتان ذخیره می‌کند.';

  @override
  String get spotStraysScan =>
      'بعضی آگهی‌ها کد QR مخصوص cat(a)log دارند. اینجا اسکن کنید و گربه را بدون تایپ وارد کنید.';

  @override
  String get spotStraysScanNeutral =>
      'بعضی آگهی‌ها کد QR مخصوص cat(a)log دارند. اینجا اسکن کنید و حیوان خانگی را بدون تایپ وارد کنید.';

  @override
  String get introTitle4 => 'گربه‌های گمشده را بیابید';

  @override
  String get introTitle4Neutral => 'حیوانات خانگی گمشده را بیابید';

  @override
  String get introBody4 =>
      'آگهی گربهٔ گمشده دیده‌اید؟ در برنامه از آن عکس بگیرید: گربه، تماس صاحبش و مکان را ذخیره می‌کند. اگر بعداً گربهٔ ولگرد مشابهی دیده شود، برنامه تطبیق‌های احتمالی را پیشنهاد می‌دهد.';

  @override
  String get introBody4Neutral =>
      'آگهی حیوان خانگی گمشده دیده‌اید؟ در برنامه از آن عکس بگیرید: حیوان خانگی، تماس صاحبش و مکان را ذخیره می‌کند. اگر بعداً حیوان ولگرد مشابهی دیده شود، برنامه تطبیق‌های احتمالی را پیشنهاد می‌دهد.';

  @override
  String get spotMapSearch =>
      'گربه، مکان یا شخصی را بنویسید تا روی نقشه به آنجا بروید.';

  @override
  String get spotMapSearchNeutral =>
      'حیوان خانگی، مکان یا شخصی را بنویسید تا روی نقشه به آنجا بروید.';

  @override
  String get spotCardChips =>
      'علامت بزنید چه چیزی روی کارت اشتراکی باشد — بقیه بیرون می‌ماند.';

  @override
  String get spotCatMenu =>
      'اینجا کارهای بیشتری هست: پنهان کردن گربه، ادغام موارد تکراری یا ثبت مشاهده.';

  @override
  String get spotCatMenuNeutral =>
      'اینجا کارهای بیشتری هست: پنهان کردن حیوان خانگی، ادغام موارد تکراری یا ثبت مشاهده.';

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
  String get searchNoResultsNeutral => 'حیوان خانگی‌ای با این نام یافت نشد';

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
  String get intoCatalog => 'به کاتالوگ';

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
      'هر کاتالوگ دنیایی برای خودش است: گربه‌ها، کلنی‌ها، فیلدها، عکس‌ها و شریک‌های همگام‌سازی خودش. برلین و پاریس هرگز قاطی نمی‌شوند. روی یک کاتالوگ بزنید تا به آن بروید. چرخ‌دنده کنار کاتالوگ تنظیماتش را باز می‌کند: نام، گربه یا حیوان، فیلدها، نویسندگان و مسدودی‌ها، آرشیو، بازگشت، حذف. نام، زبان و نکته‌هایی که دیده‌اید در همه مشترک است.';

  @override
  String get helpCatalogsNeutral =>
      'هر کاتالوگ دنیایی برای خودش است: حیوانات، خانوارها، فیلدها، عکس‌ها و شریک‌های همگام‌سازی خودش. برلین و پاریس هرگز قاطی نمی‌شوند. روی یک کاتالوگ بزنید تا به آن بروید. چرخ‌دنده کنار کاتالوگ تنظیماتش را باز می‌کند: نام، گربه یا حیوان، فیلدها، نویسندگان و مسدودی‌ها، آرشیو، بازگشت، حذف. نام، زبان و نکته‌هایی که دیده‌اید در همه مشترک است.';

  @override
  String get helpCatalogSettings =>
      'هر چیزی که فقط به این کاتالوگ تعلق دارد: نامش، اینکه گربه دارد یا حیوان، فیلدهایش، نویسندگان و مسدودی‌ها، آرشیو و بازگشت در زمان. تغییرات اینجا فقط به این کاتالوگ می‌رسد — حتی کاتالوگی که اکنون در آن نیستید. حذف ابتدا کاتالوگ را در فایلی می‌نویسد.';

  @override
  String get spotHomeCatalog =>
      'این کاتالوگی است که در آن هستید. برای تغییر یا ساخت یکی دیگر روی نام بزنید.';

  @override
  String get deleteCatalog => 'حذف کاتالوگ';

  @override
  String get catalogSettings => 'تنظیمات کاتالوگ';

  @override
  String deleteCatalogBody(String name) {
    return 'همه‌چیز در $name از بین می‌رود: گربه‌ها، عکس‌ها و تاریخچه. ابتدا یک فایل کامل همان‌جا که پشتیبان‌های خودکار ذخیره می‌شوند نوشته می‌شود؛ وارد کردن آن کاتالوگ را برمی‌گرداند. برای تأیید واژه نمایش‌داده‌شده را بنویسید.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'همه‌چیز در $name از بین می‌رود: حیوانات خانگی، عکس‌ها و تاریخچه. ابتدا یک فایل کامل همان‌جا که پشتیبان‌های خودکار ذخیره می‌شوند نوشته می‌شود؛ وارد کردن آن کاتالوگ را برمی‌گرداند. برای تأیید نام را بنویسید.';
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

  @override
  String get undoThisImport => 'برگرداندن این وارد کردن';

  @override
  String undoImportBody(int count) {
    return '$count تغییری که این وارد کردن آورده حذف می‌شود. ابتدا در فایلی نوشته می‌شوند و وارد کردن آن فایل آن‌ها را برمی‌گرداند. کسانی که قبلاً همگام شده‌اند نسخهٔ خود را نگه می‌دارند — این قابل بازگرداندن نیست.';
  }

  @override
  String undoneImport(String where) {
    return 'برگردانده شد. فایل در $where است.';
  }

  @override
  String get goBackTitle => 'بازگشت به عقب';

  @override
  String get goBackToHere => 'بازگشت به اینجا';

  @override
  String get momentImport => 'پیش از وارد کردن';

  @override
  String get momentSync => 'پیش از همگام‌سازی';

  @override
  String get momentMerge => 'پیش از ادغام';

  @override
  String get momentHardDelete => 'پیش از حذف داده‌های یک نویسنده';

  @override
  String get momentArchive => 'پیش از بایگانی';

  @override
  String get momentManual => 'نشان‌گذاری‌شده توسط شما';

  @override
  String get showOlderMoments => 'نمایش قدیمی‌ترها';

  @override
  String goBackBody(int count) {
    return 'هر چیزی پس از این لحظه حذف می‌شود — $count تغییر. ابتدا در فایلی نوشته می‌شود و وارد کردن آن همه را برمی‌گرداند؛ هر لحظهٔ تازه‌تر هم با آن می‌رود. کسانی که قبلاً همگام شده‌اند نسخهٔ خود را نگه می‌دارند — این قابل بازگرداندن نیست.';
  }

  @override
  String get nameThisMoment => 'این لحظه را نام‌گذاری کنید';

  @override
  String get helpGoBack =>
      'لحظه‌هایی که این کاتالوگ دگرگون شده است: پیش از هر وارد کردن و هر همگام‌سازی، پیش از ادغام، بایگانی یا حذف، و هر بار که خودتان لحظه‌ای را نشان کرده‌اید. با انتخاب یکی، کاتالوگ به همان حالت بازمی‌گردد؛ هرچه پس از آن آمده در فایلی که نگه می‌دارید نوشته و سپس حذف می‌شود و هر لحظهٔ تازه‌تر هم با آن می‌رود. کسانی که قبلاً همگام شده‌اند آنچه گرفته‌اند نگه می‌دارند.';

  @override
  String goBackFileFailed(String error) {
    return 'چیزی حذف نشد: فایلی که آن را نگه می‌دارد نوشته نشد ($error). کمی فضا آزاد کنید و دوباره تلاش کنید.';
  }

  @override
  String get goBackChanged =>
      'چیزی حذف نشد: کاتالوگ هنگام ذخیرهٔ فایل تغییر کرد. دوباره تلاش کنید.';

  @override
  String get switchBeforeDeleting =>
      'این کاتالوگی است که در آن هستید. به کاتالوگ دیگری بروید و سپس آن را حذف کنید.';

  @override
  String shareFileFailed(String error) {
    return 'فایل اشتراک‌گذاری نوشته نشد ($error). کمی فضا آزاد کنید و دوباره تلاش کنید.';
  }

  @override
  String get privateLabel => 'خصوصی';

  @override
  String sharedCatalogIs(String name) {
    return 'کاتالوگ: $name';
  }

  @override
  String get markPrivate => 'علامت‌گذاری به‌عنوان خصوصی';

  @override
  String get unmarkPrivate => 'حذف علامت خصوصی';

  @override
  String get agenda => 'یادآورها';

  @override
  String get reminderLabel => 'یادآور';

  @override
  String get agendaEmpty =>
      'قراری برنامه‌ریزی نشده. قرارهای جدید را اینجا با علامت مثبت یا در صفحهٔ گربه یا گروه برنامه‌ریزی کن.';

  @override
  String get agendaEmptyNeutral =>
      'قراری برنامه‌ریزی نشده. قرارهای جدید را اینجا با علامت مثبت یا در صفحهٔ حیوان خانگی یا خانوار برنامه‌ریزی کن.';

  @override
  String get dueToday => 'امروز';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز دیگر',
      one: '$count روز دیگر',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز عقب‌افتاده',
      one: '$count روز عقب‌افتاده',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'انجام شد';

  @override
  String get repeatTitle => 'دوباره پس از…';

  @override
  String get noRepeatLabel => 'بدون تکرار';

  @override
  String get unitDays => 'روز';

  @override
  String get unitWeeks => 'هفته';

  @override
  String get unitMonths => 'ماه';

  @override
  String get unitYears => 'سال';

  @override
  String ageYears(int years) {
    return '$years سال';
  }

  @override
  String ageMonths(int months) {
    return '$months ماه';
  }

  @override
  String get changeDateLabel => 'تغییر تاریخ';

  @override
  String get removeReminderLabel => 'حذف یادآور';

  @override
  String get exportIcs => 'برون‌بری پروندهٔ تقویم';

  @override
  String get resyncCalendar => 'همگام‌سازی مجدد تقویم';

  @override
  String icsSavedTo(String path) {
    return 'پروندهٔ تقویم در $path ذخیره شد';
  }

  @override
  String get calendarMirrorLabel => 'بازتاب در تقویم دستگاه';

  @override
  String get calendarMirrorSubtitle =>
      'قرارها به‌صورت رویدادهای تمام‌روز در تقویم ظاهر می‌شوند. cat(a)log آن‌ها را در هر بار اجرا و پس از هر تغییر به‌روز می‌کند. هشدارهای قرارها را در تقویم مدیریت کن.';

  @override
  String get syncPeerOlder =>
      'دستگاه دیگر cat(a)log قدیمی‌تری بدون یادآور دارد. آنجا cat(a)log را به‌روز کن و دوباره همگام‌سازی کن.';

  @override
  String get syncPeerNewer =>
      'دستگاه دیگر cat(a)log جدیدتری دارد. روی این دستگاه cat(a)log را به‌روز کن و دوباره همگام‌سازی کن.';

  @override
  String get syncPeerNoTls =>
      'دستگاه دیگر cat(a)log پیش از ۱.۱.۰ دارد، بدون همگام‌سازی رمزگذاری‌شده. آنجا cat(a)log را به‌روز کنید و دوباره همگام کنید.';

  @override
  String get syncWrongHost =>
      'گواهی با کد جفت‌سازی مطابقت ندارد — این آن دستگاهی نیست که کد از آن آمده. کد را دوباره اسکن یا وارد کنید.';

  @override
  String get bundleNewerError =>
      'این پرونده از cat(a)log جدیدتری می‌آید. برای درون‌ریزی، cat(a)log را روی این دستگاه به‌روز کن.';

  @override
  String get spotEar => 'گوش کوچک گربه در گوشه یعنی: برای بیشتر، نگه دار.';

  @override
  String get addReminder => 'افزودن یادآور';

  @override
  String get plannedSection => 'برنامه‌ریزی‌شده';

  @override
  String get reminderDialogHint =>
      'قرار در یادآورها نمایان می‌شود. آنجا می‌توانی آن را تأیید یا رد کنی. مقدار فقط وقتی پذیرفته می‌شود که قرار تأیید شده باشد.';

  @override
  String get reminderFor => 'برای';

  @override
  String get reminderField => 'فیلد';

  @override
  String get dueDateLabel => 'سررسید';

  @override
  String get pickCalendar => 'کدام تقویم؟';

  @override
  String get calendarPermissionDenied =>
      'دسترسی به تقویم مسدود است، پس بازتاب خاموش است. در تنظیمات سیستم اجازه بده و بازتاب را دوباره روشن کن.';

  @override
  String get calendarNotChosen =>
      'تقویمی انتخاب نشده، پس بازتاب خاموش است. دوباره روشنش کن و یکی را انتخاب کن.';

  @override
  String get calendarGone =>
      'تقویم انتخاب‌شده دیگر وجود ندارد، پس بازتاب خاموش است. دوباره روشنش کن و تقویم دیگری انتخاب کن.';

  @override
  String get noWritableCalendar =>
      'تقویمی پیدا نشد. در تنظیمات سیستم به یک حساب تقویم، مثلاً Google، وارد شو و دوباره امتحان کن.';

  @override
  String get spotHomeAgenda =>
      'یادآورها: فهرست قرارهای برنامه‌ریزی‌شده — دامپزشک، دارو، معاینه.';

  @override
  String get spotAgendaAdd => 'قرار جدیدی برنامه‌ریزی کن.';

  @override
  String get spotAgendaCalendar =>
      'بازتاب قرارهای cat(a)log در تقویم دلخواهت را اینجا روشن کن.';

  @override
  String get helpAgenda =>
      'یادآورها قرارهای برنامه‌ریزی‌شده را به ترتیب تاریخ نشان می‌دهند. دو نوع وجود دارد: قرارها با ساعت مشخص و یادآورهایی که برای یک روز هستند. قرارهای ازدست‌رفته بالا می‌مانند. ضربه، گربه یا گروه را باز می‌کند. تیک قرار را تأیید می‌کند: مقدار در فیلد نوشته می‌شود و می‌توانی بلافاصله قرار بعدی را برنامه‌ریزی کنی، مثلاً سه ماه بعد. نگه‌داشتن تاریخ را تغییر می‌دهد یا قرار را حذف می‌کند. کلید بالا قرارها را در تقویم گوشی‌ات بازتاب می‌دهد. منو آن‌ها را به‌صورت پروندهٔ تقویم برون‌بری می‌کند. مراجعه به دامپزشک با چند گربه یک نوبت است: گربه‌ها را علامت بزنید، برنامه یک کارت با نام آن‌ها نشان می‌دهد و هنگام پایان می‌پرسد کدام گربه‌ها درمان شدند — علامت بقیه را بردارید، برنامه‌ریزی‌شده می‌مانند.';

  @override
  String get helpAgendaNeutral =>
      'یادآورها قرارهای برنامه‌ریزی‌شده را به ترتیب تاریخ نشان می‌دهند. دو نوع وجود دارد: قرارها با ساعت مشخص و یادآورهایی که برای یک روز هستند. قرارهای ازدست‌رفته بالا می‌مانند. ضربه، حیوان خانگی یا خانوار را باز می‌کند. تیک قرار را تأیید می‌کند: مقدار در فیلد نوشته می‌شود و می‌توانی بلافاصله قرار بعدی را برنامه‌ریزی کنی، مثلاً سه ماه بعد. نگه‌داشتن تاریخ را تغییر می‌دهد یا قرار را حذف می‌کند. کلید بالا قرارها را در تقویم گوشی‌ات بازتاب می‌دهد. منو آن‌ها را به‌صورت پروندهٔ تقویم برون‌بری می‌کند. مراجعه به دامپزشک با چند حیوان خانگی یک نوبت است: حیوانات را علامت بزنید، برنامه یک کارت با نام آن‌ها نشان می‌دهد و هنگام پایان می‌پرسد کدام حیوانات درمان شدند — علامت بقیه را بردارید، برنامه‌ریزی‌شده می‌مانند.';

  @override
  String get calendarRowOff => 'تقویم: خاموش';

  @override
  String calendarRowOn(String name) {
    return 'تقویم: $name';
  }

  @override
  String get spotAddReminderCat =>
      'برای این گربه قراری برنامه‌ریزی کن. در یادآورها نمایان می‌شود و همان‌جا تأیید می‌شود.';

  @override
  String get spotAddReminderCatNeutral =>
      'برای این حیوان خانگی قراری برنامه‌ریزی کن. در یادآورها نمایان می‌شود و همان‌جا تأیید می‌شود.';

  @override
  String get spotAddReminderClowder =>
      'برای این گروه قراری برنامه‌ریزی کن. در یادآورها نمایان می‌شود و همان‌جا تأیید می‌شود.';

  @override
  String get spotAddReminderClowderNeutral =>
      'برای این خانوار قراری برنامه‌ریزی کن. در یادآورها نمایان می‌شود و همان‌جا تأیید می‌شود.';

  @override
  String get readOnlyCalendar => 'فقط خواندنی';

  @override
  String get appointmentLabel => 'قرار';

  @override
  String get addAppointment => 'افزودن قرار';

  @override
  String get planChooserTitle => 'قرار یا یادآور؟';

  @override
  String get planChooserAppointment =>
      'قرار — دیداری در تاریخ و ساعتی مشخص، با یادداشت';

  @override
  String get planChooserReminder => 'یادآور — مقداری که در روزی سررسید می‌شود';

  @override
  String get appointmentTitleLabel => 'چه';

  @override
  String get notesLabel => 'یادداشت‌ها';

  @override
  String get timeLabel => 'ساعت';

  @override
  String get allDayLabel => 'تمام روز';

  @override
  String get alertLabel => 'هشدار';

  @override
  String get alertNone => 'هیچ';

  @override
  String get alertDayBefore => 'روز قبل';

  @override
  String get alertHourBefore => 'یک ساعت قبل';

  @override
  String get linkFieldLabel => 'پس از انجام، در فیلدی نوشته شود';

  @override
  String get noLinkedField => 'بدون فیلد';

  @override
  String get outcomeTitle => 'چطور بود؟';

  @override
  String get finishLabel => 'پایان';

  @override
  String get editLabelAppointment => 'ویرایش قرار';

  @override
  String get deleteAppointment => 'حذف قرار';

  @override
  String get stepFlierText => 'متن آگهی';

  @override
  String get qrFoundHint =>
      'یک کد QR روی آگهی پیدا شد. کدهای علامت‌خورده برای شماره‌های ثبت و پیوندها خوانده می‌شوند.';

  @override
  String get useCode => 'استفاده از این کد';

  @override
  String get qrNone => 'کد QR در عکس پیدا نشد.';

  @override
  String qrFailed(String error) {
    return 'خواندن کد QR ناموفق بود: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'آگهی $name شناسایی شد. در زیر بررسی کنید هر خط به کدام فیلد می‌رود.';
  }

  @override
  String get flierLayoutUnknown =>
      'چیدمان آگهی ناشناخته است. خط‌ها را در زیر به فیلدها اختصاص دهید؛ بقیه در یادداشت‌ها می‌ماند.';

  @override
  String get targetRegistryNumber => 'شماره ثبت';

  @override
  String get targetLostPlace => 'نشانی (محل گم شدن)';

  @override
  String get targetContact => 'تماس سامانه ثبت';

  @override
  String get targetDrop => 'رد کردن';

  @override
  String get existingCat => 'گربه موجود';

  @override
  String get existingCatNeutral => 'حیوان خانگی موجود';

  @override
  String get existingClowder => 'گروه موجود';

  @override
  String get existingClowderNeutral => 'خانوار موجود';

  @override
  String get createNewInstead => 'هیچ — ایجاد جدید';

  @override
  String overwritesValue(String value) {
    return 'مقدار فعلی \"$value\" را بازنویسی می‌کند';
  }

  @override
  String get abortScanTitle => 'اسکن لغو شود؟';

  @override
  String get abortScanBody => 'چیزی ذخیره نمی‌شود.';

  @override
  String get abortScan => 'لغو';

  @override
  String get keepScanning => 'ادامه';

  @override
  String get catsOnAppointment => 'گربه‌های این نوبت';

  @override
  String get catsOnAppointmentNeutral => 'حیوانات خانگی این نوبت';

  @override
  String get noCatsHint =>
      'هیچ گربه‌ای علامت نخورده — نوبت متعلق به خود کلونی است.';

  @override
  String get noCatsHintNeutral =>
      'هیچ حیوان خانگی‌ای علامت نخورده — نوبت متعلق به خود خانوار است.';

  @override
  String get pickCatsTitle => 'کدام گربه‌ها می‌آیند؟';

  @override
  String get pickCatsTitleNeutral => 'کدام حیوانات خانگی می‌آیند؟';

  @override
  String catsCount(int count) {
    return '$count گربه';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count حیوان خانگی';
  }

  @override
  String get finishUntickHint =>
      'علامت گربه‌هایی را که درمان نشدند بردارید؛ برنامه‌ریزی‌شده می‌مانند.';

  @override
  String get finishUntickHintNeutral =>
      'علامت حیوانات خانگی‌ای را که درمان نشدند بردارید؛ برنامه‌ریزی‌شده می‌مانند.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'حذف نوبت برای هر $count گربه';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'حذف نوبت برای هر $count حیوان خانگی';
  }
}
