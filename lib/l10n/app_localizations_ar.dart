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
      'تختفي القطة من كل القوائم وتُحذف صورها — هنا، وبعد المزامنة التالية، على الأجهزة الأخرى أيضًا.';

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
  String get starterChipId => 'رقم الشريحة';

  @override
  String get starterRemarks => 'ملاحظات';

  @override
  String get captureFlier => 'التقاط منشور';

  @override
  String get addPhotosTo => 'إضافة الصور إلى…';

  @override
  String photosAddedTo(String count, String name) {
    return 'أُضيفت $count صورة إلى $name';
  }

  @override
  String get scanPrintedCode => 'مسح الرمز المطبوع';

  @override
  String get chipScanHint =>
      'يمسح رمز QR/الباركود المطبوع من بطاقة الشريحة أو أوراق الطبيب البيطري — الهاتف لا يستطيع قراءة الشريحة داخل القطة.';

  @override
  String get savingLabel => 'جارٍ الحفظ…';

  @override
  String ownerOfCat(String name) {
    return 'مالك $name';
  }

  @override
  String get sortLabel => 'فرز';

  @override
  String get viewAsTable => 'عرض كجدول';

  @override
  String get viewAsTiles => 'عرض كبلاطات';

  @override
  String get matchCandidatesTitle => 'مرشّحو التطابق';

  @override
  String get findDuplicates => 'البحث عن التكرارات';

  @override
  String get noDuplicates => 'لا توجد تكرارات محتملة حاليًا.';

  @override
  String get similarName => 'اسم متشابه';

  @override
  String get sharePublicly => 'مشاركة علنية…';

  @override
  String get pickFramesTitle => 'اختيار اللقطات';

  @override
  String get suggestedFrames => 'لقطات مقترحة';

  @override
  String get scrubFrames => 'تحريك شريط الفيديو';

  @override
  String get keepThisFrame => 'احتفظ بهذه اللقطة';

  @override
  String get fromVideo => 'من فيديو…';

  @override
  String get videoMobileOnly =>
      'اختيار اللقطات من فيديو يعمل في تطبيق الهاتف (أندرويد وآيفون) — ليس على هذا الجهاز بعد.';

  @override
  String get shareWhitelistExplainer =>
      'اختر ما يدخل الملف. تُضمَّن الحقول المحددة فقط.';

  @override
  String get exportShareFile => 'تصدير ملف المشاركة…';

  @override
  String get hostedLink => 'رابط مستضاف (عنوان الملف المرفوع)';

  @override
  String get inlineQr => 'رمز QR مضمّن (نص فقط، بدون صور)';

  @override
  String get inlineTooBig =>
      'بيانات كثيرة على رمز مضمّن — ألغِ تحديد بعض الحقول أو استخدم رابطًا مستضافًا.';

  @override
  String get scanShareLabel => 'مسح رمز المشاركة';

  @override
  String get notAShareCode => 'هذا الرمز ليس مشاركة cat(a)log.';

  @override
  String get importShareTitle => 'استيراد هذه القطة؟';

  @override
  String shareSource(String url) {
    return 'المصدر: $url';
  }

  @override
  String get importLabel => 'استيراد';

  @override
  String get strayAreaLabel => 'منطقة التواجد المحتملة';

  @override
  String get prevPin => 'الدبوس السابق';

  @override
  String get nextPin => 'الدبوس التالي';

  @override
  String get noMissingCats => 'لا توجد قطط مفقودة بمواقع منشورات بعد.';

  @override
  String get noMatchCandidates => 'لا يوجد مرشّحون للتطابق حاليًا.';

  @override
  String sameIdField(String field) {
    return 'نفس $field';
  }

  @override
  String metersApart(String distance) {
    return 'يبعدان $distance م';
  }

  @override
  String get addFlier => 'إضافة منشور';

  @override
  String get missingSinceLabel => 'مفقود منذ';

  @override
  String get phoneLabel => 'الهاتف';

  @override
  String get cropPortrait => 'قصّ صورة الوجه';

  @override
  String get statusOwner => 'المالك';

  @override
  String get ocrUnavailable =>
      'التعرف على النص غير متاح على هذا الجهاز — اكتب نص المنشور بنفسك.';

  @override
  String get displayFormat => 'يعرض كـ';

  @override
  String get displayPlain => 'نص عادي';

  @override
  String get displayQr => 'رمز QR';

  @override
  String get displayBarcode => 'باركود';

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
  String fatherNotMale(String name) {
    return '$name مسجّلة كأنثى ولا يمكن أن تكون الأب. تحقّق من الجنس أولًا.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name مسجّل كذكر ولا يمكن أن يكون الأم. تحقّق من الجنس أولًا.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return 'وُلد $name في $date — لا يمكن أن يولد أحد الوالدين بعد صغيره.';
  }

  @override
  String get genderFatherFemale =>
      'هذه القطة مسجّلة كأب لقطط أخرى — لا يمكن للأب أن يكون أنثى. تحقّق من العائلة أولًا.';

  @override
  String get genderMotherMale =>
      'هذه القطة مسجّلة كأم لقطط أخرى — لا يمكن للأم أن تكون ذكرًا. تحقّق من العائلة أولًا.';

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
      'ابدأ هنا، ثم امسح الرمز أو أدخله على الجهاز الآخر.';

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
      'يستخدم الجهازان المجلد نفسه (مثلًا في Dropbox أو على ذاكرة USB). كل مزامنة تضع تغييراتك هناك وتأخذ تغييرات الطرف الآخر.';

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
  String get coffeeSubtitle =>
      'التطبيق يبقى مجانيًا. حتى لو لم أحصل على قهوة :)';

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
  String get starterEmail => 'البريد الإلكتروني';

  @override
  String get starterPhone => 'الهاتف';

  @override
  String get lookupUrlLabel => 'رابط البحث';

  @override
  String lookupUrlHelp(String token) {
    return 'صفحة الخدمة مع $token مكان الرقم، مثل https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'ابحث';

  @override
  String lookupFailed(String url) {
    return 'لم يتمكن أي تطبيق من فتح $url. انسخ الرابط إلى المتصفح.';
  }

  @override
  String get stepCat => 'القطة';

  @override
  String get stepOwner => 'المالك';

  @override
  String get stepFace => 'صورة الوجه';

  @override
  String get stepRegistry => 'السجل';

  @override
  String get stepReview => 'التحقق والحفظ';

  @override
  String get stepOwnerHint =>
      'من يبحث عن القطة — تصبح هذه مجموعته مع بيانات التواصل من المنشور.';

  @override
  String get stepFaceHint =>
      'اقتصّ وجه القطة من المنشور؛ سيصبح صورة الملف. يمكنك تخطي هذه الخطوة.';

  @override
  String get stepRegistryHint =>
      'أرقام وُجدت على المنشور. المحددة تُحفظ مع القطة ويمكن فتحها لاحقًا.';

  @override
  String get noRegistryLinks =>
      'لا روابط سجلات في هذا المنشور — إن فات شيء منها، فيرجى الإبلاغ عن خلل.';

  @override
  String get unknownServiceHint => 'خدمة غير معروفة';

  @override
  String get rememberService => 'تذكّر الخدمة';

  @override
  String get rememberServiceHint =>
      'سمِّ الخدمة وحدد الرقم داخل الرابط. المنشور التالي سيملأ نفسه.';

  @override
  String get noIdInLink => 'لا يحمل هذا الرابط رقمًا يمكن للتطبيق حفظه.';

  @override
  String get whichNumber => 'أي جزء هو الرقم؟';

  @override
  String get cropAgain => 'اقتصاص من جديد';

  @override
  String get noFaceYet => 'لا صورة وجه بعد — تُستخدم صورة المنشور.';

  @override
  String get backLabel => 'رجوع';

  @override
  String get dangerButton => 'لا تضغط.\nخطر';

  @override
  String get dangerThanks => 'شكرًا لاستخدامك cat(a)log!';

  @override
  String get helpTitle => 'مساعدة';

  @override
  String get showTipsAgain => 'إظهار النصائح مجددًا';

  @override
  String get helpHome =>
      'نظرة عامة على مستعمراتك — المستعمرة مكان تعيش فيه القطط: بيتك، بيت رعاية، ملجأ. انقر بطاقة لرؤية قططها؛ الضغط المطوّل يفتح القائمة. الزر أسفل اليمين ينشئ مستعمرة، وبطاقة القطط الضالة تجمع كل قطة بلا بيت. الاسم في الأعلى هو الكتالوج الذي أنت فيه — المسه للتبديل أو لإضافة واحد.';

  @override
  String get helpClowder =>
      'كل شيء عن هذا المكان: قططه وحقوله (العنوان، التواصل، النوع) وسجله. تفتح الصفحة للقراءة فقط؛ القلم يفعّل التحرير، وهناك يمكنك إضافة حقل. الضغط المطوّل على حقل يحرره مباشرة، وعلى قطة ينقلها أو يخفيها أو يفتحها.';

  @override
  String get helpCat =>
      'كل شيء عن هذه القطة: الصور والحقول والعائلة والتاريخ. الصفحة للقراءة فقط حتى تنقر على القلم. اضغط مطولًا على حقل للانتقال مباشرة إلى تحريره؛ اضغط مطولًا على صورة لفتح قائمتها. القائمة في الأعلى تحوي الباقي: إخفاء، دمج، تسجيل مشاهدة، مشاركة القطة. «خاص» يُضبط أثناء تحرير الحقل.';

  @override
  String get helpStrays =>
      'قطط بلا بيت الآن: موجودة أو هاربة أو مأخوذة من منشور. زر الكاميرا يسجل قطة أمامك؛ زر المنشور يحوّل منشور فقدان إلى قطة مع بيانات صاحبها؛ الماسح يقرأ رمز cat(a)log من المنشور.';

  @override
  String get helpMap =>
      'كل القطط والأماكن ذات الموقع. البحث يجد القطط والأشخاص والأماكن — والاسم غير المعروف يُبحث عنه عالميًا. زر الطبقات يرسم دوائر 500 م حول أماكن منشورات قطة مفقودة وحول البيت الذي هربت منه. الأسهم تنتقل من دبوس إلى دبوس، والضغط المطوّل على الخريطة يسجل مشاهدة.';

  @override
  String get helpCard =>
      'بطاقة القطة القابلة للطباعة: اختر بالأعلى بالرقائق ما يظهر عليها، ثم شاركها كصورة أو PDF. يمكن طباعة الأرقام كرمز QR أو باركود، ويصبح الموقع رمز QR يفتح خريطة مع Plus Code قصير.';

  @override
  String get helpSync =>
      'كيف تصل البيانات إلى الآخرين: اتصال مباشر، مجلد يراه الجهازان، أو ملف عبر تطبيق مراسلة. أنت من يقرر دائمًا ما يخرج — وملفات .catsync المستلمة تُفتح هنا أيضًا.';

  @override
  String get helpFields =>
      'الحقول التي يستخدمها فهرسك. أعد تسميتها، غيّر خيارات حقل الاختيار، أو أنشئ حقولك. يمكن لحقل المعرّف أن يشير إلى خدمة (سجل)، فيصبح الرقم قابلًا للنقر عند القطة.';

  @override
  String get helpTimeline =>
      'كل تغيير جرى يومًا، الأحدث أولًا: من غيّر ماذا ومتى وإلى أي قيمة. يمكن التراجع عن أي إدخال — يكتب ذلك إدخالًا جديدًا، ولا يُمحى شيء أبدًا.';

  @override
  String get helpDuplicates =>
      'قطط أو مستعمرات تبدو مكررة — أرقام متطابقة أو أسماء متشابهة جدًا بتفاصيل متوافقة. انقر زوجًا لدمجه؛ الدمج لا رجعة فيه لذلك يُسأل أولًا.';

  @override
  String get helpMatches =>
      'قطط قد تكون الحيوان نفسه: رقم متطابق، أو قطة ضالة شوهدت داخل منطقة البحث عن قطة مفقودة. انقر زوجًا للدمج، والضغط المطوّل يفتح القطة الأولى للمقارنة.';

  @override
  String get helpFlier =>
      'منشور مصوَّر يتحول إلى قطة مع صاحبها. خطوة بخطوة: بيانات القطة، تواصل الصاحب، قص الوجه لصورة الملف، أرقام السجلات من المنشور، ثم مراجعة أخيرة. كل ذلك اقتراحات — صحّح ما قرأته الكاميرا خطأ.';

  @override
  String get archiveTitle => 'الأرشيف';

  @override
  String get archiveExplainer =>
      'القطط المتوفاة والمستعمرات الفارغة التي لم يمسّها أحد منذ سنوات ما زالت تشغل مساحة — وخاصة صورها. الأرشفة تكتبها في ملف تحتفظ به ثم تحذفها من هنا.';

  @override
  String get archiveAction => 'أرشفة';

  @override
  String archiveSelected(int count) {
    return 'أرشفة $count عنصرًا';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'أرشفة $count عنصرًا؟';
  }

  @override
  String archiveConfirmBody(String names) {
    return 'سيُكتب $names في ملف ثم يُحذف — على جهازك وعلى كل جهاز تزامن معه. استيراد الملف يعيد كل شيء؛ وبدونه تضيع.';
  }

  @override
  String archiveDone(int count) {
    return 'تمت أرشفة وحذف $count عنصرًا';
  }

  @override
  String archiveFailed(String error) {
    return 'لم يُحذف شيء: تعذّرت كتابة ملف الأرشيف ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'قاعدة البيانات $db، الصور $photos في $count ملفات';
  }

  @override
  String quietForYears(int years) {
    return 'بلا تغيير منذ $years سنوات';
  }

  @override
  String get nothingToArchive => 'لا يوجد ما هو قديم بما يكفي للأرشفة.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'آخر تغيير $date · الصور $size';
  }

  @override
  String get helpArchive =>
      'البيانات القديمة تكلّف مساحة، وخاصة الصور التي يحملها كل جهاز مزامَن. هنا تختار القطط المتوفاة والمستعمرات الفارغة الساكنة منذ سنوات، وتكتبها في ملف تحتفظ به، ثم تحذفها. الحذف يصل إلى كل من تزامن معه؛ واستيراد الملف يعيد كل شيء.';

  @override
  String restoreDeletedTitle(int count) {
    return 'استعادة $count عنصرًا محذوفًا؟';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names محذوفة في هذا الفهرس، والملف الذي استوردته للتو يحتوي عليها. الاستعادة تعيدها هنا وعلى كل جهاز تزامن معه.';
  }

  @override
  String get restoreAction => 'استعادة';

  @override
  String get keepDeleted => 'اتركها محذوفة';

  @override
  String get archiveNotSaved => 'لم يُحذف شيء: لم يُحفظ الأرشيف في أي مكان.';

  @override
  String get locateAddress => 'ابحث عن العنوان على الخريطة';

  @override
  String get addressLocated => 'تم العثور على العنوان';

  @override
  String get addressNotFound =>
      'لم يُعثر على مكان لهذا العنوان. تحقق من الكتابة أو اترك الحقل فارغًا.';

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
  String get includePrivate => 'مشاركة البيانات الخاصة';

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
  String get starterStatus => 'النوع';

  @override
  String get statusFoster => 'دار رعاية';

  @override
  String get statusForeverHome => 'منزل';

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
      'قصاصات ملونة وهتاف عندما تنتقل قطة إلى منزلها';

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
  String get syncChooserInPersonSub => 'المزامنة عبر Wi-Fi';

  @override
  String get syncChooserRemote => 'عن بُعد';

  @override
  String get syncChooserRemoteSub => 'المزامنة عبر مجلد أو USB';

  @override
  String get syncChooserMessenger => 'المراسلة';

  @override
  String get syncChooserMessengerSub => 'التصدير والاستيراد عبر وسائل التواصل';

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
  String get introTitle1 => 'قططك بنظام';

  @override
  String get introBody1 =>
      'أنشئ بطاقة لكل قطة ترعاها: صورة، الجنس، الصحة، وكل ما تريد تدوينه. تُجمَّع القطط حسب مكان عيشها — يسمي التطبيق هذا المكان مستعمرة (clowder).';

  @override
  String get introTitle2 => 'يعمل بلا إنترنت';

  @override
  String get introBody2 =>
      'يُحفظ كل شيء على هاتفك فقط. لا حساب ولا سحابة. لا يُرفع شيء ما لم تشاركه بنفسك.';

  @override
  String get introTitle3 => 'اعملوا معًا';

  @override
  String get introBody3 =>
      'يستخدم كلٌّ تطبيقه الخاص وتتبادلون البيانات من حين لآخر: التقوا وامسحوا رمزًا، أو استخدموا مجلدًا مشتركًا، أو أرسلوا ملفًا واحدًا عبر تطبيق مراسلة. بعدها تكون المعلومات نفسها لدى الجميع.';

  @override
  String get introSkip => 'تخطي';

  @override
  String get introNext => 'التالي';

  @override
  String get introDone => 'هيا بنا';

  @override
  String get introReplayTitle => 'مقدمة سريعة';

  @override
  String get spotHomeSync => 'هنا تزامن مع معارفك. أنت من يقرر ما تشاركه.';

  @override
  String get spotHomeStrays =>
      'هذه البطاقة تجمع كل القطط الضالة — القطط بلا مأوى. انقر لعرض القائمة.';

  @override
  String get spotHomeMenu =>
      'في هذه القائمة: إيجاد التكرارات ودمجها، تصدير CSV والمزيد.';

  @override
  String get spotCatEdit =>
      'انقر على القلم لتحرير هذه القطة. نصيحة: الضغط المطوّل على أي حقل يحرره مباشرة.';

  @override
  String get spotMapLayers =>
      'تبحث عن قطة مفقودة؟ أظهر دوائر حول أماكن منشوراتها وحول البيت الذي هربت منه.';

  @override
  String get spotStraysFlier =>
      'وجدت منشور قطة مفقودة؟ صوّره هنا — يحفظ التطبيق القطة وبيانات التواصل عنك.';

  @override
  String get spotStraysScan =>
      'بعض المنشورات تحمل رمز QR الخاص بـ cat(a)log. امسحه هنا واستورد القطة دون كتابة.';

  @override
  String get introTitle4 => 'اعثر على القطط المفقودة';

  @override
  String get introBody4 =>
      'رأيت منشور قطة مفقودة؟ صوّره في التطبيق: يحفظ القطة وبيانات مالكها والمكان. وإذا ظهرت لاحقًا قطة ضالة مشابهة، يقترح التطبيق تطابقات محتملة.';

  @override
  String get spotMapSearch =>
      'اكتب قطة أو مكانًا أو شخصًا للانتقال إليه على الخريطة.';

  @override
  String get spotCardChips =>
      'حدد ما يظهر على البطاقة القابلة للمشاركة — الباقي يبقى خارجها.';

  @override
  String get spotCatMenu =>
      'هنا المزيد من الإجراءات: إخفاء القطة، دمج التكرارات، أو تسجيل مشاهدة.';

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

  @override
  String get catalogsTitle => 'الكتالوجات';

  @override
  String get newCatalog => 'كتالوج جديد';

  @override
  String get catalogNameLabel => 'اسم الكتالوج';

  @override
  String catalogNameTaken(String name) {
    return 'يوجد كتالوج باسم $name بالفعل. اختر اسماً آخر.';
  }

  @override
  String get manageCatalogs => 'إدارة الكتالوجات';

  @override
  String get helpCatalogs =>
      'كل كتالوج عالم قائم بذاته: قططه ومستعمراته وحقوله وصوره وشركاء المزامنة الخاصون به. برلين وباريس لا يختلطان أبداً. المس الاسم في أعلى الشاشة الرئيسية للتبديل أو الإضافة أو إعادة التسمية. اسمك ولغتك والتلميحات التي رأيتها مشتركة بينها جميعاً.';

  @override
  String get spotHomeCatalog =>
      'هذا هو الكتالوج الذي أنت فيه. المس الاسم للتبديل أو لإنشاء كتالوج آخر.';

  @override
  String get deleteCatalog => 'حذف الكتالوج';

  @override
  String deleteCatalogBody(String name) {
    return 'كل ما في $name سيختفي: القطط والصور والسجل. تُحفظ أولاً نسخة كاملة حيث تُحفظ النسخ الاحتياطية التلقائية، واستيرادها يعيد الكتالوج. اكتب الاسم للتأكيد.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return 'تم حذف $name. الملف في $where.';
  }

  @override
  String typeTheName(String name) {
    return 'اكتب $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'لم يُحذف شيء: تعذّرت كتابة ملف الكتالوج ($error). وفّر بعض المساحة أو أعد المحاولة لاحقاً.';
  }

  @override
  String get moveToCatalog => 'نقل إلى كتالوج آخر';

  @override
  String movedToCatalog(int count, String name) {
    return 'تم نقل $count إلى $name';
  }

  @override
  String get chooseWhatToMove => 'ما الذي يُنقل؟';

  @override
  String moveIntoNewCatalog(String name) {
    return 'نقل شيء إلى $name؟';
  }

  @override
  String get undoThisImport => 'التراجع عن هذا الاستيراد';

  @override
  String undoImportBody(int count) {
    return 'ستُزال $count من التغييرات التي جلبها هذا الاستيراد. تُكتب أولاً في ملف، واستيراده يعيدها. من زامنت معهم يحتفظون بنسختهم — لا يمكن سحب ذلك.';
  }

  @override
  String undoneImport(String where) {
    return 'تم التراجع. الملف في $where.';
  }

  @override
  String get goBackTitle => 'العودة إلى الوراء';

  @override
  String get goBackToHere => 'العودة إلى هنا';

  @override
  String get momentImport => 'قبل الاستيراد';

  @override
  String get momentSync => 'قبل المزامنة';

  @override
  String get momentMerge => 'قبل الدمج';

  @override
  String get momentHardDelete => 'قبل حذف بيانات مؤلف';

  @override
  String get momentArchive => 'قبل الأرشفة';

  @override
  String get momentManual => 'علامة وضعتها بنفسك';

  @override
  String get showOlderMoments => 'عرض الأقدم';

  @override
  String goBackBody(int count) {
    return 'كل ما بعد هذه اللحظة سيُزال — $count تغيير. يُكتب أولاً في ملف، واستيراده يعيده، وكل لحظة أحدث منها تذهب معه. من زامنت معهم يحتفظون بنسختهم — لا يمكن سحب ذلك.';
  }

  @override
  String get nameThisMoment => 'سمِّ هذه اللحظة';

  @override
  String get helpGoBack =>
      'اللحظات التي تغيّر فيها هذا الكتالوج: قبل كل استيراد وكل مزامنة، وقبل الدمج أو الأرشفة أو الحذف، وكلما وضعت علامة بنفسك. اختيار إحداها يعيد الكتالوج إلى تلك الحال — يُكتب كل ما بعدها في ملف تحتفظ به ثم يُزال، وتذهب معه كل لحظة أحدث. من زامنت معهم يحتفظون بما وصلهم.';

  @override
  String goBackFileFailed(String error) {
    return 'لم يُزل شيء: تعذّرت كتابة الملف الذي يحفظه ($error). وفّر بعض المساحة وأعد المحاولة.';
  }

  @override
  String get switchBeforeDeleting =>
      'هذا هو الكتالوج الذي أنت فيه. انتقل إلى كتالوج آخر ثم احذفه.';

  @override
  String shareFileFailed(String error) {
    return 'تعذّرت كتابة ملف المشاركة ($error). وفّر بعض المساحة وأعد المحاولة.';
  }

  @override
  String get privateLabel => 'خاص';

  @override
  String sharedCatalogIs(String name) {
    return 'الكتالوج: $name';
  }

  @override
  String get markPrivate => 'وضع علامة خاص';

  @override
  String get unmarkPrivate => 'إزالة علامة الخصوصية';
}
