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
  String get noClowdersYet =>
      'لا مجموعات بعد. المجموعة هي مكان تعيش فيه القطط — دار الرعاية أو شقة المتبني. أنشئ الأولى أدناه.';

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
      'تختفي القطة من كل القوائم وتُزال صورها — هنا، وبعد المزامنة التالية على أجهزة مساعديك أيضًا.';

  @override
  String get sightingRecorded => 'سُجِّلت المشاهدة في موقعك.';

  @override
  String get noLocationAvailable =>
      'الموقع غير متاح — اضغط مطولًا على الخريطة بدلًا من ذلك.';

  @override
  String get locationDeniedForever =>
      'الوصول إلى الموقع محظور. اسمح به في إعدادات النظام لاستخدام Stray Cam.';

  @override
  String get locationServiceOff =>
      'خدمة الموقع مُعطَّلة على هذا الجهاز. فعِّلها في الإعدادات ثم حاول مجددًا.';

  @override
  String get locationDenied =>
      'لا يملك cat(a)log إذن استخدام موقعك. حاول مجددًا واسمح بذلك عند السؤال.';

  @override
  String get locationNoFix =>
      'تعذّر تحديد موقعك الآن. حاول مجددًا في الخارج — يحتاج GPS إلى رؤية واضحة للسماء.';

  @override
  String get ok => 'حسنًا';

  @override
  String get editLabel => 'تحرير';

  @override
  String get doneLabel => 'تم';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get notSaved => 'لم يُحفَظ';

  @override
  String get birthdateInFuture => 'لا يمكن أن يكون تاريخ الميلاد في المستقبل.';

  @override
  String get deceasedInFuture => 'لا يمكن أن يكون تاريخ النفوق في المستقبل.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'لا يمكن أن يكون تاريخ النفوق قبل تاريخ الميلاد ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'لا يمكن أن يكون تاريخ الميلاد بعد تاريخ النفوق ($date).';
  }

  @override
  String get malePregnant =>
      'هذه القطة مسجّلة كذكر — لا يمكن لذكر أن يكون حاملًا. تحقّق من الجنس أولًا.';

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
  String dateFormatError(String format) {
    return 'تنسيق خاطئ — استخدم $format';
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
  String get ownValue => 'قيمة خاصة';

  @override
  String get renameField => 'إعادة تسمية الحقل';

  @override
  String get editOptions => 'تعديل الخيارات…';

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
  String get starterBreed => 'السلالة';

  @override
  String get valueMixed => 'مختلط';

  @override
  String get breedEuropeanShorthair => 'أوروبية قصيرة الشعر';

  @override
  String get breedMaineCoon => 'مين كون';

  @override
  String get breedBritishShorthair => 'بريطانية قصيرة الشعر';

  @override
  String get breedNorwegianForestCat => 'قطة الغابات النرويجية';

  @override
  String get breedRagdoll => 'راغدول';

  @override
  String get breedSiamese => 'سيامية';

  @override
  String get breedPersian => 'شيرازية';

  @override
  String get breedBengal => 'بنغالية';

  @override
  String get breedSphynx => 'سفينكس';

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
  String get applyCrop => 'قصّ';

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
  String lastBackupFailed(String error) {
    return 'فشل آخر نسخ احتياطي تلقائي: $error';
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

  @override
  String get iosLocalNetworkHint =>
      'إذا استمر الفشل على iPhone/iPad: الإعدادات → الخصوصية والأمن → الشبكة المحلية → اسمح لـ cat(a)log ثم أعد المحاولة.';

  @override
  String get markPrivate => 'وضع علامة خاص';

  @override
  String get unmarkPrivate => 'إزالة علامة الخصوصية';

  @override
  String get includePrivate => 'تضمين البيانات الخاصة';

  @override
  String get includePrivateExplainer =>
      'تتم مشاركة القطط والمجموعات والحقول الخاصة أيضًا — فعّل هذا فقط عند المزامنة بين أجهزتك الخاصة.';

  @override
  String get hideLabel => 'إخفاء على هذا الجهاز';

  @override
  String get unhideLabel => 'إظهار مرة أخرى';

  @override
  String get showHiddenLabel => 'إظهار المخفي';

  @override
  String get stopShowingHidden => 'إيقاف إظهار المخفي';

  @override
  String get starterSpecies => 'النوع';

  @override
  String get starterStatus => 'الحالة';

  @override
  String get statusFoster => 'دار رعاية';

  @override
  String get statusForeverHome => 'منزل دائم';

  @override
  String get statusClinic => 'عيادة';

  @override
  String get statusShelter => 'مأوى';

  @override
  String get statusBarn => 'حظيرة';

  @override
  String get valueCat => 'قطة';

  @override
  String get otherOption => 'أخرى…';

  @override
  String get celebrationsToggle => 'الاحتفال بالتبني';

  @override
  String get celebrationsSubtitle =>
      'قصاصات ملونة وهتاف عندما تنتقل قطة إلى منزلها الدائم';

  @override
  String get onMapLabel => 'على الخريطة';

  @override
  String get showOnMap => 'إظهار على الخريطة';

  @override
  String get searchPlaceHint => 'ابحث عن مكان أو عنوان';

  @override
  String get noPlacesFound => 'لم يتم العثور على أماكن';

  @override
  String get mapSearchHint => 'ابحث عن قطط ومجموعات وأشخاص';

  @override
  String get proposeAnotherName => 'اقترح اسمًا آخر';

  @override
  String get moderationTitle => 'المؤلفون والحظر';

  @override
  String get moderationSubtitle => 'إزالة بيانات شخص نهائيًا';

  @override
  String get authorsSection => 'من كتب في هذا السجل';

  @override
  String get hardDeleteAction => 'حذف كل شيء من هذا المؤلف';

  @override
  String hardDeleteWarning(Object name) {
    return 'يزيل كل إدخال وصورة من $name من هذا الجهاز. تحتفظ الأجهزة الأخرى بنسخها. لا يمكن التراجع عن ذلك.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'اكتب $name للتأكيد';
  }

  @override
  String get alsoBan => 'حظر أيضًا — عدم قبول بياناته مجددًا';

  @override
  String get bansSection => 'المحظورون';

  @override
  String get unbanAction => 'إزالة الحظر';

  @override
  String get deletedDone => 'تم الحذف.';

  @override
  String get syncSummaryTitle => 'ما الذي وصل';

  @override
  String get summaryAdopted => 'تم تبنيها';

  @override
  String get summaryDeceased => 'متوفاة';

  @override
  String get summaryEscaped => 'هاربة';

  @override
  String get summaryNew => 'جديد';

  @override
  String get summaryConflicts => 'تعارضات للحل';

  @override
  String summaryOther(Object n) {
    return '…و$n تغييرات أخرى';
  }

  @override
  String get starterMother => 'الأم';

  @override
  String get starterFather => 'الأب';

  @override
  String get familySection => 'العائلة';

  @override
  String get littermatesLabel => 'إخوة البطن';

  @override
  String get siblingsLabel => 'الأشقاء';

  @override
  String get kittensLabel => 'الصغار';

  @override
  String get toastSettingsTitle => 'ما الذي يُعلن';

  @override
  String get toastSettingsSubtitle => 'رسائل صغيرة بعد المزامنة';

  @override
  String get toastKindAdoptions => 'التبني';

  @override
  String get toastKindBirths => 'الولادات';

  @override
  String get toastKindDeaths => 'الوفيات';

  @override
  String get toastKindEscapes => 'الهروب';

  @override
  String get toastKindMoves => 'الانتقالات';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 تم تبني $cat من $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ هريرة جديدة: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat فارقت الحياة';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat هربت';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat انتقلت إلى $home';
  }

  @override
  String get notACatlogFile => 'هذا ليس ملف cat(a)log';

  @override
  String get nothingNewInBundle => 'لا جديد في هذا الملف — لديك كل شيء بالفعل';

  @override
  String get syncChooserInPerson => 'وجهًا لوجه';

  @override
  String get syncChooserInPersonSub =>
      'أنتما في نفس الغرفة — امسح الرمز وينتهي الأمر في ثوانٍ';

  @override
  String get syncChooserRemote => 'عن بُعد';

  @override
  String get syncChooserRemoteSub => 'عبر مجلد مشترك مثل Dropbox أو ذاكرة USB';

  @override
  String get syncChooserMessenger => 'المراسلة';

  @override
  String get syncChooserMessengerSub =>
      'أرسل كل شيء كملف واحد عبر أي تطبيق مراسلة';

  @override
  String get connectToWifiFirst =>
      'اتصل بشبكة Wi-Fi أولًا — حينها تجد الأجهزة بعضها';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) يريد المزامنة';
  }

  @override
  String get trustBothWaysNote => 'سيتم تبادل السجلات في الاتجاهين.';

  @override
  String get allowOnce => 'السماح';

  @override
  String get allowAlways => 'السماح دائمًا لهذا الجهاز';

  @override
  String get declineAction => 'رفض';

  @override
  String get syncDeclined => 'رفض الجهاز الآخر المزامنة';

  @override
  String get trustedDevicesSection => 'الأجهزة المسموح بها دائمًا';

  @override
  String get removeTrust => 'إزالة';

  @override
  String get hostWithoutWifi => 'استضافة بدون Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'ينشئ اتصالًا مباشرًا مؤقتًا بالهاتف الآخر (بدون إنترنت). يستخدمه cat(a)log فقط وينقطع تلقائيًا بعد المزامنة.';

  @override
  String get hotspotAndroidOnly =>
      'هذا الرمز يتطلب هاتفي أندرويد — على iPhone/iPad استخدم شبكة Wi-Fi مشتركة';

  @override
  String get selectClowderHint => 'اختر مجموعة من اليسار';

  @override
  String get introTitle1 => 'القطط تعيش في مجموعات';

  @override
  String get introBody1 =>
      'المجموعة هي مكان تعيش فيه القطط: دار الرعاية، شقة المتبني، الحظيرة المجاورة. كل قطة لها بطاقة بصورة وحقائق وقصتها كاملة.';

  @override
  String get introTitle2 => 'كل شيء يبقى معك';

  @override
  String get introBody2 =>
      'لا حساب ولا سحابة ولا تتبع. بياناتك على جهازك ولا تذهب إلا حيث ترسلها.';

  @override
  String get introTitle3 => 'شارك مع مساعديك';

  @override
  String get introBody3 =>
      'امسح رمزًا لمزامنة جهازين في ثوانٍ، أو استخدم مجلدًا مشتركًا، أو أرسل كل شيء كملف واحد.';

  @override
  String get introSkip => 'تخطي';

  @override
  String get introNext => 'التالي';

  @override
  String get introDone => 'هيا بنا';

  @override
  String get introReplayTitle => 'مقدمة سريعة';

  @override
  String get spotHomeSync =>
      'جديد: المزامنة الآن بثلاث طرق واضحة — مع سؤال ثقة قبل أن ينتقل أي شيء.';

  @override
  String get spotMapSearch =>
      'جديد: ابحث هنا عن القطط والمجموعات والأشخاص — مباشرة على الخريطة.';

  @override
  String get spotCardChips => 'جديد: اختر ما يظهر على البطاقة قبل مشاركتها.';

  @override
  String get spotCatMenu =>
      'جديد: علّم قطة كخاصة (لا تغادر جهازك أبدًا) أو أخفها من العرض هنا.';

  @override
  String get spotDone => 'فهمت';

  @override
  String get spotReplayTitle => 'جولة الجديد';

  @override
  String get spotReplaySubtitle => 'إظهار الإرشادات مجددًا في كل صفحة';

  @override
  String get spotReplayDone => 'ستظهر الإرشادات مرة أخرى';

  @override
  String get searchNoResults => 'لم يتم العثور على قطة بهذا الاسم';

  @override
  String get syncUnreachable =>
      'تعذر الوصول إلى الجهاز الآخر. هل كلاهما على نفس شبكة Wi-Fi؟';

  @override
  String get folderUnreachable =>
      'تعذر الوصول إلى المجلد. هل القرص أو مجلد السحابة ما زال موجودًا؟';

  @override
  String get crashTitle => 'ما كان يجب أن يحدث هذا';

  @override
  String get crashBody =>
      'واجه cat(a)log خطأ غير متوقع. بياناتك آمنة — كل شيء يُحفظ فور تغييره. أعد تشغيل التطبيق، وإذا تكرر الأمر أرسل التقرير ليتم إصلاحه.';

  @override
  String get crashRestart => 'إعادة تشغيل التطبيق';

  @override
  String get crashSendReport => 'إرسال تقرير إلى المطور';

  @override
  String get crashLastRunBody =>
      'توقف cat(a)log بشكل غير متوقع في المرة الماضية — على الأرجح نفدت الذاكرة. هل تريد إرسال تقرير قصير ليتم الإصلاح؟';
}
