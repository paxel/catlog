// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'مرحبًا بك في cat(a)log';

  @override
  String get welcomeBody =>
      'اختر اسمًا لك. يُسجَّل كل تغيير باسمك، ليعرف الآخرون من فعل ماذا.';

  @override
  String get yourName => 'اسمك';

  @override
  String get start => 'ابدأ';

  @override
  String get clowders => 'المجموعات';

  @override
  String get noClowdersYet => 'لا توجد مجموعات بعد.\nأنشئ الأولى أدناه.';

  @override
  String get strays => 'القطط الضالة';

  @override
  String get searchCats => 'البحث عن قطط';

  @override
  String get map => 'الخريطة';

  @override
  String get sync => 'المزامنة';

  @override
  String get fields => 'الحقول';

  @override
  String get exportCsv => 'تصدير CSV';

  @override
  String get aboutAndFeedback => 'حول التطبيق والملاحظات';

  @override
  String get newClowder => 'مجموعة جديدة';

  @override
  String get name => 'الاسم';

  @override
  String get cancel => 'إلغاء';

  @override
  String get create => 'إنشاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get merge => 'دمج';

  @override
  String get resolve => 'حسم';

  @override
  String get open => 'فتح';

  @override
  String csvSavedTo(String path) {
    return 'حُفظ CSV في $path';
  }

  @override
  String get renameClowder => 'إعادة تسمية المجموعة';

  @override
  String get rename => 'إعادة تسمية';

  @override
  String get timeline => 'السجل الزمني';

  @override
  String get mergeInto => 'دمج مع…';

  @override
  String get deleteClowder => 'حذف المجموعة';

  @override
  String get cats => 'القطط';

  @override
  String get addCat => 'إضافة قطة';

  @override
  String get newCat => 'قطة جديدة';

  @override
  String deleteQuestion(String name) {
    return 'حذف $name؟';
  }

  @override
  String get deleteClowderEmptyBody => 'ستختفي المجموعة من القائمة.';

  @override
  String deleteClowderBody(int count) {
    return 'قططها ($count) لن تُحذف — بل تصبح ضالة. انقلها أولًا إلى مجموعة أخرى إن لم يكن هذا ما تريد.';
  }

  @override
  String get card => 'البطاقة';

  @override
  String get shareAsImage => 'مشاركة كصورة';

  @override
  String get shareAsPdf => 'مشاركة كملف PDF';

  @override
  String get print => 'طباعة';

  @override
  String cardTitle(String name) {
    return 'بطاقة — $name';
  }

  @override
  String get renameCat => 'إعادة تسمية القطة';

  @override
  String get seenHereNow => 'شوهدت هنا الآن';

  @override
  String get deleteCat => 'حذف القطة';

  @override
  String get clowderLabel => 'المجموعة';

  @override
  String get strayNoClowder => 'ضالة — بلا مجموعة';

  @override
  String get stray => 'ضالة';

  @override
  String get photos => 'الصور';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get setAsProfileImage => 'تعيين كصورة رئيسية';

  @override
  String get thisIsProfileImage => 'هذه هي الصورة الرئيسية';

  @override
  String get deletePhoto => 'حذف الصورة';

  @override
  String get deletePhotoTitle => 'حذف الصورة؟';

  @override
  String get deletePhotoBody =>
      'تُحذف بيانات الصورة نهائيًا — لا يمكن التراجع.';

  @override
  String get deleteCatBody =>
      'ستختفي القطة من كل القوائم، وتُحذف صورها نهائيًا.';

  @override
  String get sightingRecorded => 'سُجِّلت المشاهدة في موقعك.';

  @override
  String get noLocationAvailable =>
      'الموقع غير متاح — اضغط مطولًا على الخريطة بدلًا من ذلك.';

  @override
  String get moveTo => 'نقل إلى';

  @override
  String get noClowderStrayOption => 'بلا مجموعة — ضالة / هربت';

  @override
  String timelineOf(String name) {
    return 'السجل الزمني — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'التراجع عن هذا التغيير';

  @override
  String get revertSubtitle =>
      'يعيد القيمة السابقة كسجل جديد — يحتفظ السجل بالاثنين.';

  @override
  String fieldCleared(String field) {
    return 'أُفرغ $field';
  }

  @override
  String fieldBackTo(String field, String value) {
    return 'عاد $field إلى \"$value\"';
  }

  @override
  String get leftStray => 'غادرت — ضالة';

  @override
  String movedTo(String name) {
    return 'نُقلت إلى $name';
  }

  @override
  String arrivedPlain(String cat) {
    return 'وصلت $cat';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return 'وصلت $cat من $place';
  }

  @override
  String leftTo(String cat, String place) {
    return 'غادرت $cat إلى $place';
  }

  @override
  String get duplicateMergedIn => 'دُمج سجل مكرر';

  @override
  String get asOfToday => 'بتاريخ اليوم';

  @override
  String asOfDate(String date) {
    return 'بتاريخ $date';
  }

  @override
  String get value => 'القيمة';

  @override
  String get latitudeLongitude => 'خط العرض، خط الطول';

  @override
  String get newField => 'حقل جديد';

  @override
  String get fieldType => 'النوع';

  @override
  String get usedOn => 'يُستخدم مع';

  @override
  String get forCats => 'القطط';

  @override
  String get forClowders => 'المجموعات';

  @override
  String get forBoth => 'كليهما';

  @override
  String get optionsOnePerLine => 'الخيارات (خيار في كل سطر)';

  @override
  String get renameField => 'إعادة تسمية الحقل';

  @override
  String get noStraysRightNow => 'لا قطط ضالة حاليًا.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'إضافة قطة ضالة';

  @override
  String get newStray => 'قطة ضالة جديدة';

  @override
  String get searchByNameHint => 'ابحث عن القطط بالاسم…';

  @override
  String get host => 'استضافة';

  @override
  String get hostExplainer =>
      'ابدأ هنا، ثم أدخل العنوان ورمز PIN على الجهاز الآخر.';

  @override
  String get startHosting => 'بدء الاستضافة';

  @override
  String get stopHosting => 'إيقاف الاستضافة';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'الجلسات حتى الآن: $count';
  }

  @override
  String get join => 'انضمام';

  @override
  String get addressFromHost => 'العنوان (من الجهاز المضيف)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'زامن الآن';

  @override
  String get addressFormatHint =>
      'يجب أن يبدو العنوان هكذا: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'تمت المزامنة: $result';
  }

  @override
  String syncFailed(String error) {
    return 'فشلت المزامنة: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'آخر مزامنة مع $peer: $time';
  }

  @override
  String get sharedFolder => 'مجلد مشترك';

  @override
  String get sharedFolderExplainer =>
      'زامن عبر مجلد ينقله التخزين السحابي أو USB بين الأجهزة — لمن ليسوا على نفس الشبكة.';

  @override
  String get noFolderChosenYet => 'لم يُختَر مجلد بعد';

  @override
  String get choose => 'اختيار…';

  @override
  String get syncFolderNow => 'زامن المجلد الآن';

  @override
  String folderSynced(String result) {
    return 'تمت مزامنة المجلد: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'فشلت مزامنة المجلد: $error';
  }

  @override
  String get recordSightingHere => 'سجّل مشاهدة هنا:';

  @override
  String get orPlaceClowderHere => 'أو ضع مجموعة هنا:';

  @override
  String trailOf(String name, int count) {
    return 'المسار: $name (المشاهدات: $count)';
  }

  @override
  String conflictOn(String field) {
    return 'تعارض — $field';
  }

  @override
  String get conflictBody => 'تغيّر في مكانين في آن واحد. اختر الصحيح:';

  @override
  String mergeThisInto(String kind) {
    return 'دمج هذا ($kind) مع…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'لا يوجد ($kind) آخر للدمج معه.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'الدمج مع $name؟';
  }

  @override
  String mergeBody(String name) {
    return 'يصبح السجلان واحدًا. يحتفظ $name بقيمه الحالية؛ وينضم سجل الآخر إلى سجله الزمني. لا يمكن التراجع.';
  }

  @override
  String get kindCat => 'قطة';

  @override
  String get kindClowder => 'مجموعة';

  @override
  String get kindField => 'حقل';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get chooseFromGallery => 'اختيار من المعرض';

  @override
  String get about => 'حول';

  @override
  String get aboutTagline =>
      'فهرس محلي لقطط الرعاية المؤقتة. بياناتك تبقى على أجهزتك — لا خادم ولا حساب.';

  @override
  String versionLabel(String version, String build) {
    return 'الإصدار $version ($build)';
  }

  @override
  String get sourceCode => 'الكود المصدري';

  @override
  String get reportProblemOrIdea => 'الإبلاغ عن مشكلة أو فكرة';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'مراسلة المطوّر';

  @override
  String get buyCoffee => 'اشترِ قهوة للمطوّر';

  @override
  String get coffeeSubtitle => 'اختياري تمامًا — التطبيق مجاني';

  @override
  String get openSourceLicenses => 'تراخيص المصادر المفتوحة';

  @override
  String get machineTranslated =>
      'الترجمات آلية — التصحيحات مرحَّب بها على GitHub.';

  @override
  String get unnamed => '(بلا اسم)';

  @override
  String get labelName => 'الاسم';

  @override
  String get labelProfileImage => 'الصورة الرئيسية';

  @override
  String get labelPhoto => 'صورة';

  @override
  String get starterGender => 'الجنس';

  @override
  String get starterColor => 'اللون';

  @override
  String get starterNeutered => 'معقَّمة';

  @override
  String get starterPregnant => 'حامل';

  @override
  String get starterBirthdate => 'تاريخ الميلاد';

  @override
  String get starterDeceased => 'نافقة';

  @override
  String get starterAddress => 'العنوان';

  @override
  String get starterResponsible => 'الشخص المسؤول';

  @override
  String get starterPosition => 'الموقع';

  @override
  String get valueYes => 'نعم';

  @override
  String get valueNo => 'لا';

  @override
  String get valueFemale => 'أنثى';

  @override
  String get valueMale => 'ذكر';

  @override
  String get valueUnknown => 'غير معروف';

  @override
  String get cropTitle => 'قص الصورة';

  @override
  String get markTitle => 'تحديد القطة';

  @override
  String get useFullPhoto => 'استخدام الصورة كاملة';

  @override
  String get dragToSelect => 'ارسم مستطيلًا حول القطة';

  @override
  String get dragOverTheCat => 'ارسم شكلًا بيضاويًا فوق القطة';

  @override
  String get cropPhoto => 'قص…';

  @override
  String get markPhoto => 'تحديد…';

  @override
  String get scanCode => 'مسح الرمز';

  @override
  String get orTypeCode => 'أو اكتب الرمز';

  @override
  String get copyCode => 'نسخ الرمز';

  @override
  String get copied => 'تم النسخ';

  @override
  String get invalidCode => 'هذا الرمز غير صالح';

  @override
  String get hotspotHint =>
      'لا توجد شبكة Wi-Fi مشتركة؟ شغّل نقطة اتصال أحد الهاتفين، وصل الآخر بها، ثم استضف هنا.';

  @override
  String get byMessenger => 'عبر المراسلة';

  @override
  String get byMessengerExplainer =>
      'أرسل الفهرس كله كملف واحد عبر WhatsApp أو Signal أو البريد — والطرف الآخر يستورده.';

  @override
  String get shareBundle => 'مشاركة حزمة المزامنة…';

  @override
  String get importBundle => 'استيراد حزمة المزامنة…';

  @override
  String bundleImported(String result) {
    return 'تم استيراد الحزمة: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'فشل الاستيراد: $error';
  }

  @override
  String get pickOnMap => 'اختر على الخريطة';

  @override
  String get useMyLocation => 'استخدام موقعي';

  @override
  String get language => 'اللغة';

  @override
  String get systemDefault => 'افتراضي النظام';
}
