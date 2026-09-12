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
  String get clowdersNeutral => 'المنازل';

  @override
  String get noClowdersYet =>
      'لا مجموعات بعد. المجموعة هي مكان تعيش فيه القطط — دار الرعاية أو شقة المتبني. أنشئ الأولى أدناه.';

  @override
  String get noClowdersYetNeutral =>
      'لا منازل بعد. المنزل هو مكان تعيش فيه الحيوانات الأليفة — بيتك، دار رعاية، أو شقة المتبني. أنشئ الأول أدناه.';

  @override
  String get strays => 'القطط الضالة';

  @override
  String get searchCats => 'البحث عن قطط';

  @override
  String get searchCatsNeutral => 'البحث عن حيوانات أليفة';

  @override
  String get map => 'الخريطة';

  @override
  String get sync => 'المزامنة';

  @override
  String get fields => 'الحقول';

  @override
  String get pickerColumns => 'الأعمدة';

  @override
  String get pickerCardFields => 'على البطاقة';

  @override
  String get exportCsv => 'تصدير CSV';

  @override
  String get aboutAndFeedback => 'حول التطبيق والملاحظات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get newClowder => 'مجموعة جديدة';

  @override
  String get newClowderNeutral => 'منزل جديد';

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
  String get renameClowderNeutral => 'إعادة تسمية المنزل';

  @override
  String get rename => 'إعادة تسمية';

  @override
  String get timeline => 'السجل الزمني';

  @override
  String get mergeInto => 'دمج مع…';

  @override
  String get deleteClowder => 'حذف المجموعة';

  @override
  String get deleteClowderNeutral => 'حذف المنزل';

  @override
  String get cats => 'القطط';

  @override
  String get catsNeutral => 'الحيوانات الأليفة';

  @override
  String get addCat => 'إضافة قطة';

  @override
  String get addCatNeutral => 'إضافة حيوان أليف';

  @override
  String get newCat => 'قطة جديدة';

  @override
  String get newCatNeutral => 'حيوان أليف جديد';

  @override
  String deleteQuestion(String name) {
    return 'حذف $name؟';
  }

  @override
  String get deleteClowderEmptyBody => 'ستختفي المجموعة من القائمة.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'سيختفي المنزل من القائمة.';

  @override
  String deleteClowderBody(int count) {
    return 'قططها ($count) لن تُحذف — بل تصبح ضالة. انقلها أولًا إلى مجموعة أخرى إن لم يكن هذا ما تريد.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'حيواناته ($count) لن تُحذف — بل تصبح ضالة. انقلها أولًا إلى منزل آخر إن لم يكن هذا ما تريد.';
  }

  @override
  String get card => 'البطاقة';

  @override
  String get shareAsImage => 'مشاركة كصورة';

  @override
  String get sortOldestFirst => 'الأقدم أولًا';

  @override
  String get sortNewestFirst => 'الأحدث أولًا';

  @override
  String get shareAsText => 'مشاركة كنص';

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
  String get renameCatNeutral => 'إعادة تسمية الحيوان الأليف';

  @override
  String get seenHereNow => 'شوهدت هنا الآن';

  @override
  String get deleteCat => 'حذف القطة';

  @override
  String get deleteCatNeutral => 'حذف الحيوان الأليف';

  @override
  String get clowderLabel => 'المجموعة';

  @override
  String get clowderLabelNeutral => 'المنزل';

  @override
  String get strayNoClowder => 'ضالة — بلا مجموعة';

  @override
  String get strayNoClowderNeutral => 'ضال — بلا منزل';

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
  String get deleteCatBodyNeutral =>
      'يختفي الحيوان الأليف من كل القوائم وتُحذف صوره — هنا، وبعد المزامنة التالية، على الأجهزة الأخرى أيضًا.';

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
  String get chipScanHintNeutral =>
      'يمسح رمز QR/الباركود المطبوع من بطاقة الشريحة أو أوراق الطبيب البيطري — الهاتف لا يستطيع قراءة الشريحة داخل الحيوان.';

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
  String get viewAsList => 'عرض كقائمة';

  @override
  String get ageLabel => 'العمر';

  @override
  String get catList => 'قائمة القطط';

  @override
  String get catListNeutral => 'قائمة الحيوانات الأليفة';

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
  String addingPhotos(int done, int total) {
    return 'إضافة الصورة $done من $total…';
  }

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
  String get importShareTitleNeutral => 'استيراد هذا الحيوان الأليف؟';

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
  String get noMissingCatsNeutral =>
      'لا توجد حيوانات أليفة مفقودة بمواقع منشورات بعد.';

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
  String get malePregnantNeutral =>
      'هذا الحيوان الأليف مسجّل كذكر — لا يمكن لذكر أن يكون حاملًا. تحقّق من الجنس أولًا.';

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
  String parentBornAfterKittenNeutral(String name, String date) {
    return 'وُلد $name في $date — لا يمكن أن يولد أحد الوالدين بعد صغيره.';
  }

  @override
  String get genderFatherFemale =>
      'هذه القطة مسجّلة كأب لقطط أخرى — لا يمكن للأب أن يكون أنثى. تحقّق من العائلة أولًا.';

  @override
  String get genderFatherFemaleNeutral =>
      'هذا الحيوان الأليف مسجّل كأب لحيوانات أليفة أخرى — لا يمكن للأب أن يكون أنثى. تحقّق من العائلة أولًا.';

  @override
  String get genderMotherMale =>
      'هذه القطة مسجّلة كأم لقطط أخرى — لا يمكن للأم أن تكون ذكرًا. تحقّق من العائلة أولًا.';

  @override
  String get genderMotherMaleNeutral =>
      'هذا الحيوان الأليف مسجّل كأم لحيوانات أليفة أخرى — لا يمكن للأم أن تكون ذكرًا. تحقّق من العائلة أولًا.';

  @override
  String get moveTo => 'نقل إلى';

  @override
  String get noClowderStrayOption => 'بلا مجموعة — ضالة / هربت';

  @override
  String get noClowderStrayOptionNeutral => 'بلا منزل — ضال / هرب';

  @override
  String timelineOf(String name) {
    return 'السجل الزمني — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

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
  String get dateInFuture => 'لا يمكن أن يكون هذا التاريخ في المستقبل.';

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
  String get forCatsNeutral => 'الحيوانات الأليفة';

  @override
  String get forClowders => 'المجموعات';

  @override
  String get forClowdersNeutral => 'المنازل';

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
  String get searchByNameHintNeutral => 'ابحث عن الحيوانات الأليفة بالاسم…';

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
      'يستخدم الجهازان المجلد نفسه (مثلًا في Nextcloud أو على ذاكرة USB). كل مزامنة تضع تغييراتك هناك وتأخذ تغييرات الطرف الآخر.';

  @override
  String get noFolderChosenYet => 'لم يُختَر مجلد بعد';

  @override
  String get choose => 'اختيار…';

  @override
  String get syncFolderNow => 'زامن المجلد الآن';

  @override
  String folderCatalogHint(Object name) {
    return 'بداخله يستخدم هذا الفهرس المجلد «$name»، فيمكن لمجلد مشترك واحد أن يحمل كل فهارسك.';
  }

  @override
  String get useSameFolder => 'استخدم المجلد نفسه كالفهارس الأخرى';

  @override
  String get folderHint =>
      'يكفي أي مجلد يبقيه جهازان متطابقًا: قرص سحابي، أو Syncthing لمجلد يبقى على هواتفكم. Syncthing مجاني: ثبّته على كل هاتف، وشارك مجلدًا واحدًا بينها، واختر ذلك المجلد هنا على كل جهاز.';

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
  String trailOfField(String name, String field, int count) {
    return 'المسار: $name — $field ($count قيمة)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'المسار: $name ($count مواقع)';
  }

  @override
  String conflictOn(String field) {
    return 'تعارض — $field';
  }

  @override
  String get conflictBody => 'تغيّر في مكانين في آن واحد. اختر الصحيح:';

  @override
  String privateMarker(Object field) {
    return '$field (خاص)';
  }

  @override
  String conflictSame(Object value) {
    return 'كلا التغييرين يقول الشيء نفسه: $value. لا شيء للاختيار؛ «حل» يزيل العلامة.';
  }

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
  String get kindCatNeutral => 'حيوان أليف';

  @override
  String get kindClowder => 'مجموعة';

  @override
  String get kindClowderNeutral => 'منزل';

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
  String get aboutTaglineNeutral =>
      'فهرس محلي للحيوانات الأليفة التي ترعاها. بياناتك تبقى على أجهزتك — لا خادم ولا حساب.';

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
  String get breedAbyssinian => 'حبشي';

  @override
  String get breedAmericanShorthair => 'أمريكي قصير الشعر';

  @override
  String get breedBalinese => 'بالينيزي';

  @override
  String get breedBirman => 'بيرماني';

  @override
  String get breedBombay => 'بومباي';

  @override
  String get breedBurmese => 'بورمي';

  @override
  String get breedBurmilla => 'بورميلا';

  @override
  String get breedBritishLonghair => 'بريطاني طويل الشعر';

  @override
  String get breedChartreux => 'شارترو';

  @override
  String get breedCornishRex => 'كورنيش ركس';

  @override
  String get breedDevonRex => 'ديفون ركس';

  @override
  String get breedEgyptianMau => 'ماو مصري';

  @override
  String get breedExoticShorthair => 'إكزوتيك قصير الشعر';

  @override
  String get breedHimalayan => 'هيمالايا';

  @override
  String get breedKorat => 'كورات';

  @override
  String get breedManx => 'مانكس';

  @override
  String get breedMunchkin => 'مانشكين';

  @override
  String get breedOcicat => 'أوسيكات';

  @override
  String get breedOrientalShorthair => 'شرقي قصير الشعر';

  @override
  String get breedRagamuffin => 'راغامافين';

  @override
  String get breedRussianBlue => 'أزرق روسي';

  @override
  String get breedSavannah => 'سافانا';

  @override
  String get breedScottishFold => 'سكوتش فولد';

  @override
  String get breedSelkirkRex => 'سيلكيرك ركس';

  @override
  String get breedSiberian => 'سيبيري';

  @override
  String get breedSnowshoe => 'سنوشو';

  @override
  String get breedSomali => 'صومالي';

  @override
  String get breedTonkinese => 'تونكيني';

  @override
  String get breedTurkishAngora => 'أنغورا تركي';

  @override
  String get breedTurkishVan => 'فان تركي';

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
  String get stepCatNeutral => 'الحيوان الأليف';

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
  String get stepOwnerHintNeutral =>
      'من يبحث عن الحيوان الأليف — يصبح هذا منزله مع بيانات التواصل من المنشور.';

  @override
  String get stepFaceHint =>
      'اقتصّ وجه القطة من المنشور؛ سيصبح صورة الملف. يمكنك تخطي هذه الخطوة.';

  @override
  String get stepFaceHintNeutral =>
      'اقتصّ وجه الحيوان الأليف من المنشور؛ سيصبح صورة الملف. يمكنك تخطي هذه الخطوة.';

  @override
  String get stepRegistryHint =>
      'أرقام وُجدت على المنشور. المحددة تُحفظ مع القطة ويمكن فتحها لاحقًا.';

  @override
  String get stepRegistryHintNeutral =>
      'أرقام وُجدت على المنشور. المحددة تُحفظ مع الحيوان الأليف ويمكن فتحها لاحقًا.';

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
  String get helpHomeNeutral =>
      'نظرة عامة على منازلك — المنزل مكان تعيش فيه الحيوانات الأليفة: بيتك، بيت رعاية، ملجأ. انقر بطاقة لرؤية حيواناتها؛ الضغط المطوّل يفتح القائمة. الزر أسفل اليمين ينشئ منزلًا، وبطاقة الحيوانات الضالة تجمع كل حيوان أليف بلا بيت. الاسم في الأعلى هو الكتالوج الذي أنت فيه — المسه للتبديل أو لإضافة واحد.';

  @override
  String get helpClowder =>
      'كل شيء عن هذا المكان: قططه وحقوله (العنوان، التواصل، النوع) وسجله. تفتح الصفحة للقراءة فقط؛ القلم يفعّل التحرير، وهناك يمكنك إضافة حقل. الضغط المطوّل على حقل يحرره مباشرة، وعلى قطة ينقلها أو يخفيها أو يفتحها. الموعد المضاف هنا يمكن أن يأخذ عدة قطط من المستعمرة، مثل رحلة تعقيم: حدّد القطط التي ستأتي، أنهِ مرة واحدة، وألغِ تحديد التي لم تُعالج. الساعة على الحقل تفتح سجله.';

  @override
  String get helpClowderNeutral =>
      'كل شيء عن هذا المكان: حيواناته الأليفة وحقوله (العنوان، التواصل، النوع) وسجله. تفتح الصفحة للقراءة فقط؛ القلم يفعّل التحرير، وهناك يمكنك إضافة حقل. الضغط المطوّل على حقل يحرره مباشرة، وعلى حيوان أليف ينقله أو يخفيه أو يفتحه. الموعد المضاف هنا يمكن أن يأخذ عدة حيوانات أليفة من المنزل، مثل رحلة تعقيم: حدّد الحيوانات التي ستأتي، أنهِ مرة واحدة، وألغِ تحديد التي لم تُعالج. الساعة على الحقل تفتح سجله.';

  @override
  String get helpCat =>
      'كل شيء عن هذه القطة: الصور والحقول والعائلة والتاريخ. الصفحة للقراءة فقط حتى تنقر على القلم. اضغط مطولًا على حقل للانتقال مباشرة إلى تحريره؛ اضغط مطولًا على صورة لفتح قائمتها. القائمة في الأعلى تحوي الباقي: إخفاء، دمج، تسجيل مشاهدة، مشاركة القطة. «خاص» يُضبط أثناء تحرير الحقل. الساعة على الحقل تفتح سجله.';

  @override
  String get helpCatNeutral =>
      'كل شيء عن هذا الحيوان الأليف: الصور والحقول والعائلة والتاريخ. الصفحة للقراءة فقط حتى تنقر على القلم. اضغط مطولًا على حقل للانتقال مباشرة إلى تحريره؛ اضغط مطولًا على صورة لفتح قائمتها. القائمة في الأعلى تحوي الباقي: إخفاء، دمج، تسجيل مشاهدة، مشاركة الحيوان الأليف. «خاص» يُضبط أثناء تحرير الحقل. الساعة على الحقل تفتح سجله.';

  @override
  String get helpStrays =>
      'قطط بلا بيت الآن: موجودة أو هاربة أو مأخوذة من منشور. زر الكاميرا يسجل قطة أمامك؛ زر المنشور يحوّل منشور فقدان إلى قطة مع بيانات صاحبها؛ الماسح يقرأ رمز cat(a)log من المنشور. انقر على كاميرا الضالة لالتقاط صورة؛ اضغط مطولاً لتصوير فيديو والاحتفاظ بأفضل اللقطات كصور.';

  @override
  String get helpStraysNeutral =>
      'حيوانات أليفة بلا بيت الآن: موجودة أو هاربة أو مأخوذة من منشور. زر الكاميرا يسجل حيوانًا أمامك؛ زر المنشور يحوّل منشور فقدان إلى حيوان أليف مع بيانات صاحبه؛ الماسح يقرأ رمز cat(a)log من المنشور. انقر على كاميرا الضالة لالتقاط صورة؛ اضغط مطولاً لتصوير فيديو والاحتفاظ بأفضل اللقطات كصور.';

  @override
  String get helpMap =>
      'كل القطط والأماكن ذات الموقع. البحث يجد القطط والأشخاص والأماكن — والاسم غير المعروف يُبحث عنه عالميًا. زر الطبقات يرسم دوائر 500 م حول أماكن منشورات قطة مفقودة وحول البيت الذي هربت منه. الأسهم تنتقل من دبوس إلى دبوس، والضغط المطوّل على الخريطة يسجل مشاهدة. كل حقل موقع يظهر كدبوس على الخريطة؛ انقر على الدبوس لرؤية مساره.';

  @override
  String get helpMapNeutral =>
      'كل الحيوانات الأليفة والأماكن ذات الموقع. البحث يجد الحيوانات الأليفة والأشخاص والأماكن — والاسم غير المعروف يُبحث عنه عالميًا. زر الطبقات يرسم دوائر 500 م حول أماكن منشورات حيوان أليف مفقود وحول البيت الذي هرب منه. الأسهم تنتقل من دبوس إلى دبوس، والضغط المطوّل على الخريطة يسجل مشاهدة. كل حقل موقع يظهر كدبوس على الخريطة؛ انقر على الدبوس لرؤية مساره.';

  @override
  String get helpCard =>
      'بطاقة القطة القابلة للطباعة: اختر بالأعلى بالرقائق ما يظهر عليها، ثم شاركها كصورة أو PDF. يمكن طباعة الأرقام كرمز QR أو باركود، ويصبح الموقع رمز QR يفتح خريطة مع Plus Code قصير.';

  @override
  String get helpCardNeutral =>
      'بطاقة الحيوان الأليف القابلة للطباعة: اختر بالأعلى بالرقائق ما يظهر عليها، ثم شاركها كصورة أو PDF. يمكن طباعة الأرقام كرمز QR أو باركود، ويصبح الموقع رمز QR يفتح خريطة مع Plus Code قصير.';

  @override
  String get helpSync =>
      'كيف تصل البيانات إلى الآخرين: اتصال مباشر، مجلد يراه الجهازان، أو ملف عبر تطبيق مراسلة. أنت من يقرر دائمًا ما يخرج — وملفات .catsync المستلمة تُفتح هنا أيضًا. يوقّع كل فهرس ما يكتبه بمفتاحه الخاص؛ يرى الشركاء رمز المفتاح بجوار اسمك. يُقبل أول مفتاح لشريك من ملف على الثقة ويُعد متحققًا منه عند المزامنة شخصيًا. الإدخالات باسم معروف دون التوقيع الصحيح تُرفض وتُدرج في صفحة الوصول.';

  @override
  String get helpFields =>
      'الحقول التي يستخدمها فهرسك. أعد تسميتها، غيّر خيارات حقل الاختيار، أو أنشئ حقولك. يمكن لحقل المعرّف أن يشير إلى خدمة (سجل)، فيصبح الرقم قابلًا للنقر عند القطة.';

  @override
  String get helpFieldsNeutral =>
      'الحقول التي يستخدمها فهرسك. أعد تسميتها، غيّر خيارات حقل الاختيار، أو أنشئ حقولك. يمكن لحقل المعرّف أن يشير إلى خدمة (سجل)، فيصبح الرقم قابلًا للنقر عند الحيوان الأليف.';

  @override
  String get helpTimeline =>
      'كل تغيير، الأحدث أولاً: من غيّر ماذا ومتى وإلى أي قيمة. انقر على إدخال لتصحيحه، واضغط مطولاً لإزالته أو استعادته؛ يبقى الإدخال المخفي في السجل ويظهر عند الطلب.';

  @override
  String get helpDuplicates =>
      'قطط أو مستعمرات تبدو مكررة — أرقام متطابقة أو أسماء متشابهة جدًا بتفاصيل متوافقة. انقر زوجًا لدمجه؛ الدمج لا رجعة فيه لذلك يُسأل أولًا.';

  @override
  String get helpDuplicatesNeutral =>
      'حيوانات أليفة أو منازل تبدو مكررة — أرقام متطابقة أو أسماء متشابهة جدًا بتفاصيل متوافقة. انقر زوجًا لدمجه؛ الدمج لا رجعة فيه لذلك يُسأل أولًا.';

  @override
  String get helpMatches =>
      'قطط قد تكون الحيوان نفسه: رقم متطابق، أو قطة ضالة شوهدت داخل منطقة البحث عن قطة مفقودة. انقر زوجًا للدمج، والضغط المطوّل يفتح القطة الأولى للمقارنة. تُدرج أيضًا الأزواج التي يتطابق مظهرها في سمتين أو أكثر دون تناقض؛ تُظهر الرقائق أيها. «ليس نفسه» يخفي الزوج على هذا الهاتف حتى يتغير مظهر أحد الحيوانين.';

  @override
  String get helpMatchesNeutral =>
      'حيوانات أليفة قد تكون الحيوان نفسه: رقم متطابق، أو حيوان ضال شوهد داخل منطقة البحث عن حيوان أليف مفقود. انقر زوجًا للدمج، والضغط المطوّل يفتح الحيوان الأليف الأول للمقارنة. تُدرج أيضًا الأزواج التي يتطابق مظهرها في سمتين أو أكثر دون تناقض؛ تُظهر الرقائق أيها. «ليس نفسه» يخفي الزوج على هذا الهاتف حتى يتغير مظهر أحد الحيوانين.';

  @override
  String get helpFlier =>
      'منشور مصوَّر يتحول إلى قطة مع صاحبها. خطوة بخطوة: بيانات القطة، تواصل الصاحب، قص الوجه لصورة الملف، أرقام السجلات من المنشور، ثم مراجعة أخيرة. كل ذلك اقتراحات — صحّح ما قرأته الكاميرا خطأ.';

  @override
  String get helpFlierNeutral =>
      'منشور مصوَّر يتحول إلى حيوان أليف مع صاحبه. خطوة بخطوة: بيانات الحيوان الأليف، تواصل الصاحب، قص الوجه لصورة الملف، أرقام السجلات من المنشور، ثم مراجعة أخيرة. كل ذلك اقتراحات — صحّح ما قرأته الكاميرا خطأ.';

  @override
  String get archiveTitle => 'الأرشيف';

  @override
  String get archiveExplainer =>
      'القطط المتوفاة والمستعمرات الفارغة التي لم يمسّها أحد منذ سنوات ما زالت تشغل مساحة — وخاصة صورها. الأرشفة تكتبها في ملف تحتفظ به ثم تحذفها من هنا.';

  @override
  String get archiveExplainerNeutral =>
      'الحيوانات الأليفة المتوفاة والمنازل الفارغة التي لم يمسّها أحد منذ سنوات ما زالت تشغل مساحة — وخاصة صورها. الأرشفة تكتبها في ملف تحتفظ به ثم تحذفها من هنا.';

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
  String get helpArchiveNeutral =>
      'البيانات القديمة تكلّف مساحة، وخاصة الصور التي يحملها كل جهاز مزامَن. هنا تختار الحيوانات الأليفة المتوفاة والمنازل الفارغة الساكنة منذ سنوات، وتكتبها في ملف تحتفظ به، ثم تحذفها. الحذف يصل إلى كل من تزامن معه؛ واستيراد الملف يعيد كل شيء.';

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
  String get addressFoundTitle => 'تم العثور على العنوان';

  @override
  String get replaceAddressOption => 'استبدال العنوان بهذا';

  @override
  String get addPositionOption => 'حفظ الموقع';

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
  String get markTitleNeutral => 'تحديد الحيوان الأليف';

  @override
  String get applyCrop => 'قصّ';

  @override
  String get useFullPhoto => 'استخدام الصورة كاملة';

  @override
  String get dragToSelect => 'ارسم مستطيلًا حول القطة';

  @override
  String get dragToSelectNeutral => 'ارسم مستطيلًا حول الحيوان الأليف';

  @override
  String get dragOverTheCat => 'ارسم شكلًا بيضاويًا فوق القطة';

  @override
  String get dragOverTheCatNeutral => 'ارسم شكلًا بيضاويًا فوق الحيوان الأليف';

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
  String get typeUnitValue => 'قيمة بوحدة';

  @override
  String get dimension => 'البُعد';

  @override
  String get dimensionWeight => 'الوزن';

  @override
  String get dimensionLength => 'الطول';

  @override
  String get dimensionVolume => 'الحجم';

  @override
  String get dimensionTemperature => 'درجة الحرارة';

  @override
  String get unitsLabel => 'الوحدات';

  @override
  String get catalogHolds => 'يحتوي هذا الكتالوج على';

  @override
  String get modeCats => 'قطط';

  @override
  String get modePets => 'حيوانات أليفة';

  @override
  String get graphLabel => 'رسم بياني';

  @override
  String get fieldHistoryTooltip => 'السجل';

  @override
  String get rangeWeek => 'أسبوع';

  @override
  String get rangeMonth => 'شهر';

  @override
  String get rangeYear => 'سنة';

  @override
  String get rangeAll => 'الكل';

  @override
  String get rangeCustom => 'مخصص…';

  @override
  String changeSince(String delta, String date) {
    return '$delta منذ $date';
  }

  @override
  String get unitsAuto => 'حسب منطقتك';

  @override
  String get unitsMetric => 'متري (كغ، سم، مل، °م)';

  @override
  String get unitsImperial => 'إمبراطوري (رطل، بوصة، أونصة سائلة، °ف)';

  @override
  String get starterWeight => 'الوزن';

  @override
  String get starterLooks => 'المظهر';

  @override
  String get looksGroupSize => 'الحجم';

  @override
  String get looksGroupColours => 'الألوان';

  @override
  String get looksGroupPattern => 'النمط';

  @override
  String get looksGroupFur => 'الفراء';

  @override
  String get looksGroupTail => 'الذيل';

  @override
  String get looksGroupEars => 'الأذنان';

  @override
  String get looksGroupMarks => 'العلامات';

  @override
  String get looksGroupCrest => 'العرف';

  @override
  String get looksGroupBeak => 'المنقار';

  @override
  String get looksGroupRing => 'الحلقة';

  @override
  String get looksValueSmall => 'صغير';

  @override
  String get looksValueMedium => 'متوسط';

  @override
  String get looksValueLarge => 'كبير';

  @override
  String get looksValueBlack => 'أسود';

  @override
  String get looksValueWhite => 'أبيض';

  @override
  String get looksValueGrey => 'رمادي';

  @override
  String get looksValueBrown => 'بني';

  @override
  String get looksValueGinger => 'برتقالي محمر';

  @override
  String get looksValueCream => 'كريمي';

  @override
  String get looksValueGolden => 'ذهبي';

  @override
  String get looksValueTan => 'بني فاتح';

  @override
  String get looksValueGreen => 'أخضر';

  @override
  String get looksValueBlue => 'أزرق';

  @override
  String get looksValueYellow => 'أصفر';

  @override
  String get looksValueRed => 'أحمر';

  @override
  String get looksValueOrange => 'برتقالي';

  @override
  String get looksValuePink => 'وردي';

  @override
  String get looksValueWhiteBib => 'صدر أبيض';

  @override
  String get looksValueWhitePaws => 'أقدام بيضاء';

  @override
  String get looksValueWhiteTailTip => 'طرف ذيل أبيض';

  @override
  String get looksValueBlaze => 'غرة';

  @override
  String get looksValueMask => 'قناع';

  @override
  String get looksValueSpots => 'بقع';

  @override
  String get looksValuePatches => 'رقع';

  @override
  String get looksValueStripes => 'خطوط';

  @override
  String get looksValueScar => 'ندبة';

  @override
  String get looksValueNotchedEar => 'أذن مشقوقة';

  @override
  String get looksValueEarTip => 'طرف الأذن';

  @override
  String get looksValueCollar => 'طوق';

  @override
  String get looksValueShort => 'قصير';

  @override
  String get looksValueLong => 'طويل';

  @override
  String get looksValueHairless => 'بلا شعر';

  @override
  String get looksValueBobtail => 'ذيل قصير';

  @override
  String get looksValueNone => 'بلا ذيل';

  @override
  String get looksValueCurled => 'ملتف';

  @override
  String get looksValueUpright => 'منتصبة';

  @override
  String get looksValueFloppy => 'متدلية';

  @override
  String get looksValueFolded => 'مطوية';

  @override
  String get looksValueRounded => 'مستديرة';

  @override
  String get looksValueSolid => 'لون واحد';

  @override
  String get looksValueTabby => 'مخطط';

  @override
  String get looksValueTortoiseshell => 'صدفي';

  @override
  String get looksValueCalico => 'كاليكو';

  @override
  String get looksValueColourpoint => 'كولوربوينت';

  @override
  String get looksValueBicolour => 'لونان';

  @override
  String get looksValueTuxedo => 'بدلة';

  @override
  String get looksValueBrindle => 'مخطط داكن';

  @override
  String get looksValueMerle => 'مرل';

  @override
  String get looksValueSpotted => 'منقّط';

  @override
  String get looksValuePatched => 'مرقّع';

  @override
  String get looksValueTricolour => 'ثلاثة ألوان';

  @override
  String get looksValueSable => 'سمور';

  @override
  String get looksGroupEyes => 'العينان';

  @override
  String get looksGroupFeatures => 'سمات';

  @override
  String get looksValueAmber => 'كهرماني';

  @override
  String get looksValueCopper => 'نحاسي';

  @override
  String get looksValueOddEyed => 'عينان مختلفتان';

  @override
  String get looksValueChocolate => 'شوكولاتي';

  @override
  String get looksValueLilac => 'ليلكي';

  @override
  String get looksValueSilver => 'فضي';

  @override
  String get looksValueSmoke => 'دخاني';

  @override
  String get looksValueTicked => 'مرقّط الشعرة';

  @override
  String get looksValueVan => 'فان';

  @override
  String get looksValueCurly => 'مجعد';

  @override
  String get looksValueWiry => 'خشن';

  @override
  String get looksValueKinked => 'مثنيّ';

  @override
  String get looksValueCropped => 'مقصوصة';

  @override
  String get looksValueTippedEar => 'طرف أذن مقصوص';

  @override
  String get looksValueEarTattoo => 'وشم في الأذن';

  @override
  String get looksValueMissingEar => 'أذن مفقودة';

  @override
  String get looksValueMissingEye => 'عين مفقودة';

  @override
  String get looksValueCloudyEye => 'عين ضبابية';

  @override
  String get looksValueMissingFrontLeg => 'ساق أمامية مفقودة';

  @override
  String get looksValueMissingHindLeg => 'ساق خلفية مفقودة';

  @override
  String get looksValueNoTeeth => 'بلا أسنان';

  @override
  String get looksValueExtraToes => 'أصابع زائدة';

  @override
  String get rejectMatch => 'ليس نفسه';

  @override
  String traitsAgree(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سمة متطابقة',
      many: '$count سمة متطابقة',
      few: '$count سمات متطابقة',
      two: 'سمتان متطابقتان',
      one: 'سمة واحدة متطابقة',
      zero: 'لا سمات متطابقة',
    );
    return '$_temp0';
  }

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
  String get valueDog => 'كلب';

  @override
  String get valueRabbit => 'أرنب';

  @override
  String get valueGuineaPig => 'خنزير غينيا';

  @override
  String get valueHamster => 'هامستر';

  @override
  String get valueBird => 'طائر';

  @override
  String get valueHorse => 'حصان';

  @override
  String get valueTortoise => 'سلحفاة';

  @override
  String get valueFerret => 'نمس';

  @override
  String get otherOption => 'أخرى…';

  @override
  String get celebrationsToggle => 'الاحتفال بالتبني';

  @override
  String get celebrationsSubtitle =>
      'قصاصات ملونة وهتاف عندما تنتقل قطة إلى منزلها';

  @override
  String get cheerToggle => 'صوت الهتاف';

  @override
  String get cheerSubtitle => 'هتاف قصير مع القصاصات، مختلف في كل مرة';

  @override
  String get celebrationsSubtitleNeutral =>
      'قصاصات ملونة وهتاف عندما ينتقل حيوان أليف إلى منزله';

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
  String get mapSearchHintNeutral => 'ابحث عن حيوانات أليفة ومنازل وأشخاص';

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
  String get yourKey => 'مفتاحك';

  @override
  String get yourTitle => 'لقبك';

  @override
  String get titleNone => 'بلا لقب';

  @override
  String keyLine(Object code) {
    return 'المفتاح $code';
  }

  @override
  String get keyVerified => 'تم التحقق شخصيًا';

  @override
  String get keyFromFile => 'من ملف، لم يُتحقق منه بعد';

  @override
  String get keyUnsigned => 'لا مفتاح بعد، الإدخالات غير موقّعة';

  @override
  String get summaryRefused => 'مرفوض';

  @override
  String refusedEntries(int count, Object name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count إدخال مرفوض',
      many: '$count إدخالًا مرفوضًا',
      few: '$count إدخالات مرفوضة',
      two: 'إدخالان مرفوضان',
      one: 'إدخال واحد مرفوض',
      zero: 'لا إدخالات مرفوضة',
    );
    return '$_temp0: غير موقّعة بالمفتاح المعروف لـ $name';
  }

  @override
  String newKeyCallsItself(Object code, Object name) {
    return 'مفتاح جديد $code يسمّي نفسه $name. تحقق من الشخص قبل الوثوق به.';
  }

  @override
  String keyChangedRefused(Object name) {
    return 'قدّم $name مفتاحًا غير المعروف هنا. يبقى المعروف؛ لم يُقبل الجديد.';
  }

  @override
  String metaNewKey(Object name, Object code, Object how) {
    return 'مفتاح جديد: $name · $code ($how)';
  }

  @override
  String hardDeleteWarningKey(Object name, Object key) {
    return 'يزيل من هذا الفهرس كل إدخال وصورة كتبها $name تحت المفتاح $key. تحتفظ الأجهزة الأخرى بنسخها. لا يمكن التراجع.';
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
  String conflictsMenu(int n) {
    return 'تعارضات ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'لقد حللت تعارضًا هنا، لذا «رفض» غير متاح: كان سيلغي ذلك أيضًا.';

  @override
  String get arrivalIntro =>
      'هذه التغييرات موجودة بالفعل في الكتالوج. «رفض» يعيده كما كان.';

  @override
  String get summaryUpdated => 'محدَّثة';

  @override
  String get summaryDeleted => 'محذوفة';

  @override
  String get keepMine => 'احتفظ بنسختي';

  @override
  String keptMine(String name) {
    return 'بقيت نسختك من $name على هذا الجهاز.';
  }

  @override
  String get summaryMeta => 'وصل أيضًا';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تغيير',
      many: '$n تغييرًا',
      few: '$n تغييرات',
      two: 'تغييران',
      one: 'تغيير واحد',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'قبول';

  @override
  String get rejectArrival => 'رفض';

  @override
  String get photoAdded => 'أُضيفت صورة';

  @override
  String get photoNotReceived => 'لم تُستلم الصورة بعد';

  @override
  String get photoRemoved => 'أُزيلت صورة';

  @override
  String metaFieldAdded(String name) {
    return 'حقل جديد: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'تغيّر الحقل: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return 'دُمج $loser في $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n صورة',
      many: '$n صورة',
      few: '$n صور',
      two: 'صورتان',
      one: 'صورة واحدة',
    );
    return '$_temp0';
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
  String get kittensLabelNeutral => 'الصغار';

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
  String toastBornNeutral(Object cat) {
    return '✨ مولود جديد: $cat ✨';
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
  String get selectClowderHintNeutral => 'اختر منزلًا من اليسار';

  @override
  String get introTitle1 => 'قططك بنظام';

  @override
  String get introTitle1Neutral => 'حيواناتك الأليفة بنظام';

  @override
  String get introBody1 =>
      'أنشئ بطاقة لكل قطة ترعاها: صورة، الجنس، الصحة، وكل ما تريد تدوينه. تُجمَّع القطط حسب مكان عيشها — يسمي التطبيق هذا المكان مستعمرة (clowder).';

  @override
  String get introBody1Neutral =>
      'أنشئ بطاقة لكل حيوان أليف ترعاه: صورة، الجنس، الصحة، وكل ما تريد تدوينه. تُجمَّع الحيوانات الأليفة حسب مكان عيشها — يسمي التطبيق هذا المكان منزلًا.';

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
  String get spotHomeStraysNeutral =>
      'هذه البطاقة تجمع كل الحيوانات الضالة — الحيوانات الأليفة بلا مأوى. انقر لعرض القائمة.';

  @override
  String get spotHomeMenu =>
      'في هذه القائمة: الإعدادات، إيجاد التكرارات ودمجها، تصدير CSV، والمزيد.';

  @override
  String get spotCatEdit =>
      'انقر على القلم لتحرير هذه القطة. نصيحة: الضغط المطوّل على أي حقل يحرره مباشرة.';

  @override
  String get spotCatEditNeutral =>
      'انقر على القلم لتحرير هذا الحيوان الأليف. نصيحة: الضغط المطوّل على أي حقل يحرره مباشرة.';

  @override
  String get spotMapLayers =>
      'تبحث عن قطة مفقودة؟ أظهر دوائر حول أماكن منشوراتها وحول البيت الذي هربت منه.';

  @override
  String get spotMapLayersNeutral =>
      'تبحث عن حيوان أليف مفقود؟ أظهر دوائر حول أماكن منشوراته وحول البيت الذي هرب منه.';

  @override
  String get spotStraysFlier =>
      'وجدت منشور قطة مفقودة؟ صوّره هنا — يحفظ التطبيق القطة وبيانات التواصل عنك.';

  @override
  String get spotStraysFlierNeutral =>
      'وجدت منشور حيوان أليف مفقود؟ صوّره هنا — يحفظ التطبيق الحيوان الأليف وبيانات التواصل عنك.';

  @override
  String get spotStraysScan =>
      'بعض المنشورات تحمل رمز QR الخاص بـ cat(a)log. امسحه هنا واستورد القطة دون كتابة.';

  @override
  String get spotStraysScanNeutral =>
      'بعض المنشورات تحمل رمز QR الخاص بـ cat(a)log. امسحه هنا واستورد الحيوان الأليف دون كتابة.';

  @override
  String get introTitle4 => 'اعثر على القطط المفقودة';

  @override
  String get introTitle4Neutral => 'اعثر على الحيوانات الأليفة المفقودة';

  @override
  String get introBody4 =>
      'رأيت منشور قطة مفقودة؟ صوّره في التطبيق: يحفظ القطة وبيانات مالكها والمكان. وإذا ظهرت لاحقًا قطة ضالة مشابهة، يقترح التطبيق تطابقات محتملة.';

  @override
  String get introBody4Neutral =>
      'رأيت منشور حيوان أليف مفقود؟ صوّره في التطبيق: يحفظ الحيوان الأليف وبيانات مالكه والمكان. وإذا ظهر لاحقًا حيوان ضال مشابه، يقترح التطبيق تطابقات محتملة.';

  @override
  String get spotMapSearch =>
      'اكتب قطة أو مكانًا أو شخصًا للانتقال إليه على الخريطة.';

  @override
  String get spotMapSearchNeutral =>
      'اكتب حيوانًا أليفًا أو مكانًا أو شخصًا للانتقال إليه على الخريطة.';

  @override
  String get spotCardChips =>
      'حدد ما يظهر على البطاقة القابلة للمشاركة — الباقي يبقى خارجها.';

  @override
  String get spotCatMenu =>
      'هنا المزيد من الإجراءات: إخفاء القطة، دمج التكرارات، أو تسجيل مشاهدة.';

  @override
  String get spotCatMenuNeutral =>
      'هنا المزيد من الإجراءات: إخفاء الحيوان الأليف، دمج التكرارات، أو تسجيل مشاهدة.';

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
  String get searchNoResultsNeutral =>
      'لم يتم العثور على حيوان أليف بهذا الاسم';

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
  String get intoCatalog => 'إلى الكتالوج';

  @override
  String get catalogNameLabel => 'اسم الكتالوج';

  @override
  String catalogNameTaken(String name) {
    return 'يوجد كتالوج باسم $name بالفعل. اختر اسماً آخر.';
  }

  @override
  String get manageCatalogs => 'إدارة الكتالوجات';

  @override
  String get restoreTitle => 'استعادة النسخ الاحتياطية';

  @override
  String get restoreIntro =>
      'توجد على هذا الجهاز نسخ احتياطية من تثبيت سابق. تعود كل واحدة كتالوجًا.';

  @override
  String get restoreNone =>
      'لا توجد نسخ احتياطية على هذا الجهاز. اختر ملفات للاستعادة من مكان آخر.';

  @override
  String get restoreBackupsMenu => 'استعادة النسخ الاحتياطية…';

  @override
  String get restorePickFiles => 'اختيار الملفات…';

  @override
  String restoreFileLine(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملف',
      many: '$count ملفًا',
      few: '$count ملفات',
      two: 'ملفان',
      one: 'ملف واحد',
    );
    return '$_temp0، الأحدث $date';
  }

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'استُعيد $count كتالوج.',
      many: 'استُعيد $count كتالوجًا.',
      few: 'استُعيدت $count كتالوجات.',
      two: 'استُعيد كتالوجان.',
      one: 'استُعيد كتالوج واحد.',
      zero: 'لم يُستعاد شيء.',
    );
    return '$_temp0';
  }

  @override
  String get helpCatalogs =>
      'كل كتالوج عالمٌ بحد ذاته: قطط ومستعمرات وحقول وصور وشركاء مزامنة خاصة به. برلين وباريس لا تختلطان أبدًا. انقر على كتالوج للانتقال إليه. الترس بجانب الكتالوج يفتح إعداداته: الاسم، قطط أو حيوانات، الحقول، المؤلفون والحظر، الأرشيف، الرجوع، الحذف. اسمك ولغتك والنصائح التي رأيتها مشتركة بينها كلها.';

  @override
  String get helpCatalogsNeutral =>
      'كل كتالوج عالمٌ بحد ذاته: حيوانات وأسر وحقول وصور وشركاء مزامنة خاصة به. برلين وباريس لا تختلطان أبدًا. انقر على كتالوج للانتقال إليه. الترس بجانب الكتالوج يفتح إعداداته: الاسم، قطط أو حيوانات، الحقول، المؤلفون والحظر، الأرشيف، الرجوع، الحذف. اسمك ولغتك والنصائح التي رأيتها مشتركة بينها كلها.';

  @override
  String get helpCatalogSettings =>
      'كل ما يخص هذا الكتالوج وحده: اسمه، هل يضم قططًا أم حيوانات، حقوله، مؤلفوه والحظر، الأرشيف، والرجوع في الزمن. التغييرات هنا تمس هذا الكتالوج فقط — حتى كتالوجًا لست فيه الآن. الحذف يكتب الكتالوج في ملف أولًا. مفتاحك هو الرمز الذي يراه الشركاء بجوار اسمك؛ ويبقى مع هذا الفهرس.';

  @override
  String get spotHomeCatalog =>
      'هذا هو الكتالوج الذي أنت فيه. المس الاسم للتبديل أو لإنشاء كتالوج آخر.';

  @override
  String get deleteCatalog => 'حذف الكتالوج';

  @override
  String get catalogSettings => 'إعدادات الكتالوج';

  @override
  String deleteCatalogBody(String name) {
    return 'كل ما في $name سيختفي: القطط والصور والسجل. تُحفظ أولاً نسخة كاملة حيث تُحفظ النسخ الاحتياطية التلقائية، واستيرادها يعيد الكتالوج.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'كل ما في $name سيختفي: الحيوانات الأليفة والصور والسجل. تُحفظ أولاً نسخة كاملة حيث تُحفظ النسخ الاحتياطية التلقائية، واستيرادها يعيد الكتالوج. اكتب الاسم للتأكيد.';
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
  String get goBackChanged =>
      'لم تتم إزالة أي شيء: تغيّر الكتالوج أثناء حفظ الملف. حاول مرة أخرى.';

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

  @override
  String get agenda => 'المواعيد';

  @override
  String get reminderLabel => 'تذكير';

  @override
  String get agendaEmpty =>
      'لا مواعيد مخططة. خطّط مواعيد جديدة هنا بزر الزائد، أو في صفحة قطة أو مجموعة.';

  @override
  String get agendaEmptyNeutral =>
      'لا مواعيد مخططة. خطّط مواعيد جديدة هنا بزر الزائد، أو في صفحة حيوان أليف أو منزل.';

  @override
  String get dueToday => 'اليوم';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'بعد $count يوم',
      many: 'بعد $count يومًا',
      few: 'بعد $count أيام',
      two: 'بعد يومين',
      one: 'بعد يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'متأخر $count يوم',
      many: 'متأخر $count يومًا',
      few: 'متأخر $count أيام',
      two: 'متأخر يومين',
      one: 'متأخر يومًا واحدًا',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'تم';

  @override
  String get repeatTitle => 'مجددًا بعد…';

  @override
  String get noRepeatLabel => 'بلا تكرار';

  @override
  String get unitDays => 'أيام';

  @override
  String get unitWeeks => 'أسابيع';

  @override
  String get unitMonths => 'أشهر';

  @override
  String get unitYears => 'سنوات';

  @override
  String ageYears(int years) {
    return '$years سنة';
  }

  @override
  String ageMonths(int months) {
    return '$months شهر';
  }

  @override
  String get changeDateLabel => 'تغيير التاريخ';

  @override
  String get removeReminderLabel => 'إزالة التذكير';

  @override
  String get exportIcs => 'تصدير ملف التقويم';

  @override
  String get resyncCalendar => 'إعادة مزامنة التقويم';

  @override
  String icsSavedTo(String path) {
    return 'حُفظ ملف التقويم في $path';
  }

  @override
  String get calendarMirrorLabel => 'انعكاس في تقويم الجهاز';

  @override
  String get calendarMirrorSubtitle =>
      'تظهر المواعيد كأحداث ليوم كامل في التقويم. يحدّثها cat(a)log هناك عند كل تشغيل وبعد كل تغيير. ويمكنك إدارة تنبيهات المواعيد في التقويم.';

  @override
  String get syncPeerOlder =>
      'الجهاز الآخر يشغّل نسخة أقدم من cat(a)log بلا تذكيرات. حدّث cat(a)log هناك ثم زامن مجددًا.';

  @override
  String get syncPeerNewer =>
      'الجهاز الآخر يشغّل نسخة أحدث من cat(a)log. حدّث cat(a)log على هذا الجهاز ثم زامن مجددًا.';

  @override
  String get syncPeerNoTls =>
      'الجهاز الآخر يشغّل cat(a)log قبل الإصدار 1.1.0 دون مزامنة مشفّرة. حدّث cat(a)log هناك ثم زامن مجددًا.';

  @override
  String get syncWrongHost =>
      'الشهادة لا تطابق رمز الاقتران — هذا ليس الجهاز الذي جاء منه الرمز. امسح الرمز أو اكتبه مجددًا.';

  @override
  String get bundleNewerError =>
      'هذا الملف من نسخة أحدث من cat(a)log. حدّث cat(a)log على هذا الجهاز لاستيراده.';

  @override
  String get spotEar => 'أذن قطة صغيرة في الزاوية تعني: اضغط مطولًا للمزيد.';

  @override
  String get addReminder => 'إضافة تذكير';

  @override
  String get plannedSection => 'مخطط';

  @override
  String get reminderDialogHint =>
      'يظهر الموعد في المواعيد. هناك يمكنك تأكيده أو رفضه. لا تُعتمد القيمة إلا إذا تم تأكيد الموعد.';

  @override
  String get reminderFor => 'لمن';

  @override
  String get reminderField => 'الحقل';

  @override
  String get dueDateLabel => 'تاريخ الاستحقاق';

  @override
  String get pickCalendar => 'أي تقويم؟';

  @override
  String get calendarPermissionDenied =>
      'الوصول إلى التقويم محظور، لذا الانعكاس متوقف. اسمح به في إعدادات النظام ثم شغّل الانعكاس مجددًا.';

  @override
  String get calendarNotChosen =>
      'لم يُختر تقويم، لذا الانعكاس متوقف. شغّله مجددًا واختر تقويمًا.';

  @override
  String get calendarGone =>
      'التقويم المختار لم يعد موجودًا، لذا الانعكاس متوقف. شغّله مجددًا واختر تقويمًا آخر.';

  @override
  String get noWritableCalendar =>
      'لم يُعثر على تقويم. سجّل الدخول إلى حساب تقويم في إعدادات النظام، مثل Google، ثم حاول مجددًا.';

  @override
  String get spotHomeAgenda =>
      'المواعيد: قائمة المواعيد المخططة — البيطري، الدواء، الفحوص.';

  @override
  String get spotAgendaAdd => 'خطّط موعدًا جديدًا.';

  @override
  String get spotAgendaCalendar =>
      'شغّل هنا انعكاس مواعيد cat(a)log في تقويم تختاره.';

  @override
  String get spotAgendaToday =>
      'مهام اليوم: ضع علامة عند الإنجاز. النقاط تعرض آخر سبعة أيام.';

  @override
  String get helpAgenda =>
      'تعرض المواعيد المواعيدَ المخططة حسب التاريخ. هناك نوعان: مواعيد بوقت محدد، وتذكيرات تسري ليوم كامل. الفائتة تبقى في الأعلى. الضغط يفتح القطة أو المجموعة. علامة الصح تؤكد الموعد: تُكتب القيمة في الحقل ويمكنك فورًا تخطيط الموعد التالي، مثلًا بعد ثلاثة أشهر. الضغط المطوّل يغيّر التاريخ أو يحذف الموعد. المفتاح في الأعلى يعكس المواعيد في تقويم هاتفك. والقائمة تصدّرها كملف تقويم. زيارة الطبيب البيطري بعدة قطط هي موعد واحد: حدّد القطط، فتعرض الأجندة بطاقة واحدة بأسمائها، وعند الإنهاء تُسأل أي القطط عولجت — ألغِ تحديد الباقي، فتبقى مخططة. المهام هي الواجبات المتكررة مثل الإطعام أو صندوق الرمل أو الدواء. تقع تحت «اليوم» مع علامة وسلسلة وآخر سبعة أيام كنقاط؛ «قريبًا» يعرض الأسبوع التالي دون اليومية. يمكن للمهمة أن تذكّرك بإشعار في وقت مختار. الكأس تفتح الإنجازات.';

  @override
  String get helpAgendaNeutral =>
      'تعرض المواعيد المواعيدَ المخططة حسب التاريخ. هناك نوعان: مواعيد بوقت محدد، وتذكيرات تسري ليوم كامل. الفائتة تبقى في الأعلى. الضغط يفتح الحيوان الأليف أو المنزل. علامة الصح تؤكد الموعد: تُكتب القيمة في الحقل ويمكنك فورًا تخطيط الموعد التالي، مثلًا بعد ثلاثة أشهر. الضغط المطوّل يغيّر التاريخ أو يحذف الموعد. المفتاح في الأعلى يعكس المواعيد في تقويم هاتفك. والقائمة تصدّرها كملف تقويم. زيارة الطبيب البيطري بعدة حيوانات أليفة هي موعد واحد: حدّد الحيوانات، فتعرض الأجندة بطاقة واحدة بأسمائها، وعند الإنهاء تُسأل أي الحيوانات عولجت — ألغِ تحديد الباقي، فتبقى مخططة. المهام هي الواجبات المتكررة مثل الإطعام أو صندوق الرمل أو الدواء. تقع تحت «اليوم» مع علامة وسلسلة وآخر سبعة أيام كنقاط؛ «قريبًا» يعرض الأسبوع التالي دون اليومية. يمكن للمهمة أن تذكّرك بإشعار في وقت مختار. الكأس تفتح الإنجازات.';

  @override
  String get calendarRowOff => 'التقويم: متوقف';

  @override
  String calendarRowOn(String name) {
    return 'التقويم: $name';
  }

  @override
  String get spotAddReminderCat =>
      'خطّط موعدًا لهذه القطة. يظهر في المواعيد ويُؤكَّد هناك.';

  @override
  String get spotAddReminderCatNeutral =>
      'خطّط موعدًا لهذا الحيوان الأليف. يظهر في المواعيد ويُؤكَّد هناك.';

  @override
  String get spotAddReminderClowder =>
      'خطّط موعدًا لهذه المجموعة. يظهر في المواعيد ويُؤكَّد هناك.';

  @override
  String get spotAddReminderClowderNeutral =>
      'خطّط موعدًا لهذا المنزل. يظهر في المواعيد ويُؤكَّد هناك.';

  @override
  String get readOnlyCalendar => 'للقراءة فقط';

  @override
  String get appointmentLabel => 'موعد';

  @override
  String get addAppointment => 'إضافة موعد';

  @override
  String get planChooserTitle => 'موعد أم تذكير؟';

  @override
  String get planChooserAppointment => 'موعد — زيارة في تاريخ ووقت، مع ملاحظات';

  @override
  String get planChooserReminder => 'تذكير — قيمة تستحق في يوم ما';

  @override
  String get planChooserChore => 'مهمة — شيء يتكرر: إطعام، قطرات، رمل';

  @override
  String get newChore => 'مهمة جديدة';

  @override
  String get choreEdit => 'تعديل المهمة';

  @override
  String get choreTitleLabel => 'ماذا';

  @override
  String get choreRepeatDaily => 'يوميًا';

  @override
  String get choreRepeatEvery => 'كل…';

  @override
  String get choreRepeatWeekdays => 'أيام';

  @override
  String choreEveryDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'كل $n يوم',
      many: 'كل $n يومًا',
      few: 'كل $n أيام',
      two: 'كل يومين',
      one: 'كل يوم',
    );
    return '$_temp0';
  }

  @override
  String choreEveryWeeks(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'كل $n أسبوع',
      many: 'كل $n أسبوعًا',
      few: 'كل $n أسابيع',
      two: 'كل أسبوعين',
      one: 'كل أسبوع',
    );
    return '$_temp0';
  }

  @override
  String choreEveryMonths(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'كل $n شهر',
      many: 'كل $n شهرًا',
      few: 'كل $n أشهر',
      two: 'كل شهرين',
      one: 'كل شهر',
    );
    return '$_temp0';
  }

  @override
  String choreEveryYears(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'كل $n سنة',
      many: 'كل $n سنة',
      few: 'كل $n سنوات',
      two: 'كل سنتين',
      one: 'كل سنة',
    );
    return '$_temp0';
  }

  @override
  String get choreNoTime => 'في أي وقت من اليوم';

  @override
  String get chorePause => 'إيقاف مؤقت';

  @override
  String get chorePaused => 'متوقف مؤقتًا';

  @override
  String get choreResume => 'استئناف';

  @override
  String get choreEnd => 'إنهاء المهمة';

  @override
  String get choreHistory => 'السجل';

  @override
  String choreDoneAt(Object when, Object who) {
    return 'تم $when · $who';
  }

  @override
  String get choreDoneEarly => 'مبكرًا';

  @override
  String get choreDoneLate => 'متأخرًا';

  @override
  String get choreMissed => 'فائت';

  @override
  String get choreStillOpen => 'ما زال مفتوحًا';

  @override
  String get choreEndConfirm =>
      'تخرج المهمة من القائمة. ما تم تعليمه يبقى في السجل.';

  @override
  String get todaySection => 'اليوم';

  @override
  String get upcomingSection => 'قريبًا';

  @override
  String get allDoneToday => 'اليوم: كل شيء تم';

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم متتالٍ',
      many: '$n يومًا متتاليًا',
      few: '$n أيام متتالية',
      two: 'يومان متتاليان',
      one: 'يوم واحد متتالٍ',
    );
    return '$_temp0';
  }

  @override
  String choreDue(String date) {
    return 'موعده $date';
  }

  @override
  String get remindMe => 'ذكّرني';

  @override
  String remindNext(Object when) {
    return 'التذكير التالي: $when';
  }

  @override
  String get remindNone => 'لا تذكير مخطط: لا شيء قادم.';

  @override
  String remindPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تذكير مجدول على هذا الهاتف',
      many: '$count تذكيرًا مجدولًا على هذا الهاتف',
      few: '$count تذكيرات مجدولة على هذا الهاتف',
      two: 'تذكيران مجدولان على هذا الهاتف',
      one: 'تذكير واحد مجدول على هذا الهاتف',
      zero: 'لا شيء مجدول على هذا الهاتف بعد',
    );
    return '$_temp0';
  }

  @override
  String get remindTest => 'أرسل تذكيرًا تجريبيًا الآن';

  @override
  String get remindLateHint =>
      'قد تصل التذكيرات متأخرة بضع دقائق؛ الهاتف يحدد اللحظة الدقيقة.';

  @override
  String get remindPermissionDenied =>
      'لا إذن للإشعارات، فيبقى التذكير متوقفًا. اسمح بها في إعدادات التطبيق على الهاتف وحاول مرة أخرى.';

  @override
  String get batteryHint =>
      'إذا لم تصل التذكيرات، اسمح لـ cat(a)log بالعمل في الخلفية من إعدادات البطارية في الهاتف.';

  @override
  String get batterySettings => 'إعدادات البطارية';

  @override
  String get achievementsTitle => 'الإنجازات';

  @override
  String get rankServant => 'خادم';

  @override
  String get rankButler => 'كبير الخدم';

  @override
  String get rankSteward => 'وكيل';

  @override
  String get rankChancellor => 'مستشار';

  @override
  String get rankMinister => 'وزير';

  @override
  String titleWithChore(Object title, Object chore) {
    return '$title ($chore)';
  }

  @override
  String get coatCalico => 'كاليكو';

  @override
  String get coatCheetah => 'فهد';

  @override
  String get coatTiger => 'نمر';

  @override
  String get coatTabby => 'مخطط';

  @override
  String get coatPaws => 'كفوف';

  @override
  String get coatRosettes => 'وريدات';

  @override
  String get coatZebra => 'حمار وحشي';

  @override
  String get coatSetting => 'فراء';

  @override
  String get coatRandom => 'مختلف في كل تشغيل';

  @override
  String get coatSnowLeopard => 'نمر الثلج';

  @override
  String get coatSiamese => 'علامات سيامية';

  @override
  String get coatLynx => 'وشق';

  @override
  String get coatTortoiseshell => 'صدف السلحفاة';

  @override
  String coatUnlocked(Object coat) {
    return 'فراء جديد: $coat';
  }

  @override
  String get coatUnlockedHow => 'شهر كامل من المهام، كلها منجزة.';

  @override
  String get achievementsEmpty => 'لا شيء بعد. المهام تعرف الطريق.';

  @override
  String get achievementMonth => 'شهر كامل';

  @override
  String get achievementYear => 'سنة كاملة';

  @override
  String get achievementDecade => 'عقد كامل';

  @override
  String get achievementCentury => 'قرن كامل';

  @override
  String get achievementCenturyHint => 'سنكون كلانا فخورَين جدًا.';

  @override
  String achievementMaster(String title) {
    return 'خبير $title';
  }

  @override
  String achievementReached(int times, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'تحقق $times مرة',
      many: 'تحقق $times مرة',
      few: 'تحقق $times مرات',
      two: 'تحقق مرتين',
      one: 'تحقق مرة',
    );
    return '$_temp0، أول مرة في $date';
  }

  @override
  String achievementNext(int n) {
    return 'التالي عند $n';
  }

  @override
  String get achievementLocked => 'ليس بعد';

  @override
  String achievementUnlocked(String name) {
    return 'إنجاز: $name';
  }

  @override
  String get appointmentTitleLabel => 'ماذا';

  @override
  String get notesLabel => 'ملاحظات';

  @override
  String get timeLabel => 'الوقت';

  @override
  String get allDayLabel => 'طوال اليوم';

  @override
  String get alertLabel => 'تنبيه';

  @override
  String get alertNone => 'بلا';

  @override
  String get alertDayBefore => 'في اليوم السابق';

  @override
  String get alertHourBefore => 'قبل ساعة';

  @override
  String get linkFieldLabel => 'عند الإنجاز، اكتب في حقل';

  @override
  String get noLinkedField => 'لا حقل';

  @override
  String get outcomeTitle => 'كيف كان؟';

  @override
  String get finishLabel => 'إنهاء';

  @override
  String get editLabelAppointment => 'تعديل الموعد';

  @override
  String get deleteAppointment => 'حذف الموعد';

  @override
  String get stepFlierText => 'نص المنشور';

  @override
  String get qrFoundHint =>
      'تم العثور على رمز QR في المنشور. تُقرأ الرموز المحددة بحثًا عن أرقام السجل والروابط.';

  @override
  String get useCode => 'استخدام هذا الرمز';

  @override
  String get qrNone => 'لم يُعثر على رمز QR في الصورة.';

  @override
  String qrFailed(String error) {
    return 'فشل قراءة رمز QR: $error';
  }

  @override
  String flierRecognized(String name) {
    return 'تم التعرف على منشور $name. تحقق أدناه من الحقل الذي يذهب إليه كل سطر.';
  }

  @override
  String get flierLayoutUnknown =>
      'تخطيط المنشور غير معروف. عيّن الأسطر إلى الحقول أدناه؛ ويبقى الباقي في الملاحظات.';

  @override
  String get targetRegistryNumber => 'رقم السجل';

  @override
  String get targetLostPlace => 'العنوان (مكان الفقد)';

  @override
  String get targetContact => 'جهة اتصال السجل';

  @override
  String get targetDrop => 'تجاهل';

  @override
  String get existingCat => 'قطة موجودة';

  @override
  String get existingCatNeutral => 'حيوان أليف موجود';

  @override
  String get existingClowder => 'مجموعة موجودة';

  @override
  String get existingClowderNeutral => 'منزل موجود';

  @override
  String get createNewInstead => 'لا شيء — إنشاء جديد';

  @override
  String overwritesValue(String value) {
    return 'يستبدل القيمة الحالية \"$value\"';
  }

  @override
  String get abortScanTitle => 'إلغاء المسح؟';

  @override
  String get abortScanBody => 'لن يُحفظ أي شيء.';

  @override
  String get abortScan => 'إلغاء';

  @override
  String get keepScanning => 'متابعة';

  @override
  String get catsOnAppointment => 'القطط في هذا الموعد';

  @override
  String get catsOnAppointmentNeutral => 'الحيوانات الأليفة في هذا الموعد';

  @override
  String get noCatsHint => 'لم يتم تحديد أي قطة — الموعد يخص المستعمرة نفسها.';

  @override
  String get noCatsHintNeutral =>
      'لم يتم تحديد أي حيوان أليف — الموعد يخص المنزل نفسه.';

  @override
  String get pickCatsTitle => 'أي القطط ستأتي؟';

  @override
  String get pickCatsTitleNeutral => 'أي الحيوانات الأليفة ستأتي؟';

  @override
  String catsCount(int count) {
    return '$count قطط';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count حيوانات أليفة';
  }

  @override
  String get finishUntickHint => 'ألغِ تحديد القطط التي لم تُعالج؛ تبقى مخططة.';

  @override
  String get finishUntickHintNeutral =>
      'ألغِ تحديد الحيوانات الأليفة التي لم تُعالج؛ تبقى مخططة.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'حذف الموعد لكل القطط الـ$count';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'حذف الموعد لكل الحيوانات الأليفة الـ$count';
  }

  @override
  String get correctThisValue => 'تصحيح هذه القيمة';

  @override
  String get removeThisValue => 'إزالة هذه القيمة';

  @override
  String get restoreThisValue => 'استعادة هذه القيمة';

  @override
  String get showRemovedValues => 'إظهار القيم المزالة';

  @override
  String get hideRemovedValues => 'إخفاء القيم المزالة';

  @override
  String entryRemovedBy(Object who, Object when) {
    return 'أُزيل · $who · $when';
  }

  @override
  String entryReplacedBy(Object value, Object who, Object when) {
    return 'استُبدل بـ $value · $who · $when';
  }

  @override
  String get entryCorrection => 'تصحيح';

  @override
  String get restorePickFolder => 'اختيار مجلد النسخ الاحتياطية…';

  @override
  String get restoreAndroidHint =>
      'النسخ الاحتياطية للتثبيت السابق موجودة في Documents/catlog (وفي Downloads/catlog للإصدارات الأقدم). اختر ذلك المجلد مرة واحدة؛ تُعرض نسخه هنا.';

  @override
  String get backupsTitle => 'النسخ الاحتياطية';

  @override
  String get backupsSubtitle => 'أين تُحفظ فهارسك بأمان';

  @override
  String get backupsAndroidSystem =>
      'تنسخ Google فهارس هذا التطبيق احتياطياً مع حسابك، من دون الصور. تعود من تلقاء نفسها بعد إعادة التثبيت أو على هاتف جديد.';

  @override
  String get backupsAndroidFiles =>
      'تُكتب نسخة كاملة من كل فهرس، مع الصور، في Documents/catlog كلما غادرت التطبيق بعد تغييرات.';

  @override
  String get backupsIosSystem =>
      'يشمل نسخ iCloud الاحتياطي هذا التطبيق بفهارسه وصوره، مثل أي تطبيق آخر على هذا الـ iPhone.';

  @override
  String get backupsIosFiles =>
      'توجد نسخة كاملة من كل فهرس في تطبيق الملفات تحت cat(a)log. من هناك يمكن نقلها إلى iCloud Drive أو عبر AirDrop أو إلى هاتف آخر.';

  @override
  String get backupsDesktopFiles =>
      'تُكتب نسخة كاملة من كل فهرس، مع الصور، في مجلد التنزيلات كلما غادرت التطبيق بعد تغييرات.';

  @override
  String backupsLast(Object date) {
    return 'آخر نسخة: $date';
  }

  @override
  String get backupsNever => 'لم تُكتب نسخة بعد.';

  @override
  String get backupsNow => 'انسخ احتياطياً الآن';

  @override
  String get backupsDone => 'كُتبت النسخة.';

  @override
  String backupsRestoredNote(Object date) {
    return 'استُعيد من نسخة Google الاحتياطية في $date. إذا كان الهاتف القديم لا يزال يشغّل cat(a)log، فزامن منه مرة واحدة ثم أزل التطبيق هناك.';
  }

  @override
  String get backupsFolderHint =>
      'يمكن لمجلد من اختيارك أن يتلقى كل نسخة أيضاً: مجلد يبقيه تطبيق سحابي متزامناً على هذا الهاتف (Nextcloud وSyncthing وغيرهما)، أو بطاقة ذاكرة، أو أي مجلد يعرضه المنتقي. تُحفظ النسخ في catlog-backups داخله.';

  @override
  String get backupsFolderPick => 'انسخ أيضاً إلى مجلد…';

  @override
  String backupsFolderIs(Object name) {
    return 'يُنسخ أيضاً إلى $name';
  }

  @override
  String get backupsFolderRemove => 'توقف عن النسخ إلى هناك';

  @override
  String remindFailed(Object error) {
    return 'الإشعارات لا تعمل على هذا الهاتف: $error';
  }

  @override
  String get copyText => 'نسخ النص';

  @override
  String get colWhen => 'متى';

  @override
  String get colValue => 'القيمة';

  @override
  String get colWho => 'من';

  @override
  String get pdfFontMissing =>
      'خط هذه اللغة ليس على الهاتف بعد؛ تُطبع بعض الحروف كمربعات. اتصل بالإنترنت مرة واحدة ثم أنشئ ملف PDF من جديد.';

  @override
  String get vetReportTitle => 'تقرير للطبيب البيطري';

  @override
  String get vetReportMenu => 'تقرير للطبيب البيطري…';

  @override
  String get vetReportFields => 'الحقول';

  @override
  String get vetReportFrom => 'من';

  @override
  String get vetReportTo => 'إلى';

  @override
  String get vetReportSummary => 'ملخص المريض';

  @override
  String get vetReportOwner => 'المالك';

  @override
  String get vetReportLegend => 'مفتاح الرموز';

  @override
  String get vetReportCurves => 'المنحنى';

  @override
  String get posterMenu => 'ملصق مفقود…';

  @override
  String get posterHeadline => 'مفقود';

  @override
  String get posterStanding =>
      'يرجى تفقد الأقبية والسقائف والمرائب. لا تطارده، فقط اتصل.';

  @override
  String get posterLastSeen => 'شوهد آخر مرة قرب';

  @override
  String get posterFreeText => 'سطر إضافي';

  @override
  String get posterQr => 'رمز QR لـ cat(a)log';

  @override
  String get posterPhoto => 'صورة';

  @override
  String get newCatIn => 'قطة جديدة في…';

  @override
  String get newCatInNeutral => 'حيوان أليف جديد في…';

  @override
  String get choreLabel => 'مهمة';

  @override
  String get choreTickLabel => 'أُنجزت المهمة';

  @override
  String get choreEnded => 'انتهت';

  @override
  String choreRemindAt(Object time) {
    return 'تذكير $time';
  }

  @override
  String doneOn(Object date) {
    return 'أُنجزت في $date';
  }

  @override
  String get withheldByPartner => 'حجبه شريك';

  @override
  String get titleLabel => 'اللقب';

  @override
  String get deletedLabel => 'محذوف';

  @override
  String get favouriteAdd => 'تمييز كمفضّل';

  @override
  String get favouriteRemove => 'إزالة من المفضّلة';

  @override
  String get coverPick => 'صورة الغلاف…';

  @override
  String get coverHint =>
      'صورة للمكان: البيت، الفناء، موضع الإطعام. تُعرض على البطاقة بدل قطة.';

  @override
  String get coverRemove => 'إزالة صورة الغلاف';

  @override
  String get skipTour => 'تخطّي المقدمة والنصائح في هذا التثبيت';
}
