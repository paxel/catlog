// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'cat(a)log\'a hoş geldiniz';

  @override
  String get welcomeBody =>
      'Kendinize bir isim seçin. Her değişiklik bu isimle kaydedilir, böylece kimin ne yaptığı görülür.';

  @override
  String get yourName => 'Adınız';

  @override
  String get start => 'Başla';

  @override
  String get clowders => 'Clowder\'lar';

  @override
  String get noClowdersYet =>
      'Henüz clowder yok. Clowder, kedilerin yaşadığı yerdir — geçici yuvanız, sahiplenen kişinin evi. İlkini aşağıda oluşturun.';

  @override
  String get strays => 'Sokak kedileri';

  @override
  String get searchCats => 'Kedi ara';

  @override
  String get map => 'Harita';

  @override
  String get sync => 'Eşitle';

  @override
  String get fields => 'Alanlar';

  @override
  String get exportCsv => 'CSV dışa aktar';

  @override
  String get aboutAndFeedback => 'Hakkında ve geri bildirim';

  @override
  String get newClowder => 'Yeni clowder';

  @override
  String get name => 'İsim';

  @override
  String get cancel => 'İptal';

  @override
  String get create => 'Oluştur';

  @override
  String get save => 'Kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get merge => 'Birleştir';

  @override
  String get resolve => 'Çöz';

  @override
  String get open => 'Aç';

  @override
  String csvSavedTo(String path) {
    return 'CSV şuraya kaydedildi: $path';
  }

  @override
  String get renameClowder => 'Clowder\'ı yeniden adlandır';

  @override
  String get rename => 'Yeniden adlandır';

  @override
  String get timeline => 'Zaman çizelgesi';

  @override
  String get mergeInto => 'Şununla birleştir…';

  @override
  String get deleteClowder => 'Clowder\'ı sil';

  @override
  String get cats => 'Kediler';

  @override
  String get addCat => 'Kedi ekle';

  @override
  String get newCat => 'Yeni kedi';

  @override
  String deleteQuestion(String name) {
    return '$name silinsin mi?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowder listeden kaybolur.';

  @override
  String deleteClowderBody(int count) {
    return 'İçindeki $count kedi silinmez — sokak kedisi olurlar. İstediğiniz bu değilse önce onları başka bir clowder\'a taşıyın.';
  }

  @override
  String get card => 'Kart';

  @override
  String get shareAsImage => 'Görsel olarak paylaş';

  @override
  String get shareAsPdf => 'PDF olarak paylaş';

  @override
  String get print => 'Yazdır';

  @override
  String cardTitle(String name) {
    return 'Kart — $name';
  }

  @override
  String get renameCat => 'Kediyi yeniden adlandır';

  @override
  String get seenHereNow => 'Şimdi burada görüldü';

  @override
  String get deleteCat => 'Kediyi sil';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Sokak kedisi — clowder yok';

  @override
  String get stray => 'Sokak kedisi';

  @override
  String get photos => 'Fotoğraflar';

  @override
  String get addPhoto => 'Fotoğraf ekle';

  @override
  String get setAsProfileImage => 'Profil fotoğrafı yap';

  @override
  String get thisIsProfileImage => 'Bu, profil fotoğrafı';

  @override
  String get deletePhoto => 'Fotoğrafı sil';

  @override
  String get deletePhotoTitle => 'Fotoğraf silinsin mi?';

  @override
  String get deletePhotoBody =>
      'Fotoğraf verileri kalıcı olarak silinir — geri alınamaz.';

  @override
  String get deleteCatBody =>
      'Kedi tüm listelerden kaybolur ve fotoğrafları silinir — burada ve bir sonraki eşitlemeden sonra diğer cihazlarda da.';

  @override
  String get sightingRecorded => 'Görülme, konumunuzda kaydedildi.';

  @override
  String get noLocationAvailable =>
      'Konum alınamadı — bunun yerine haritaya uzun basın.';

  @override
  String get locationDeniedForever =>
      'Konum erişimi engellendi. Stray Cam kullanmak için sistem ayarlarından izin verin.';

  @override
  String get locationServiceOff =>
      'Bu cihazda konum kapalı. Ayarlardan açın ve yeniden deneyin.';

  @override
  String get locationDenied =>
      'cat(a)log konumunuzu kullanma iznine sahip değil. Yeniden deneyin ve sorulduğunda izin verin.';

  @override
  String get locationNoFix =>
      'Konumunuz şu anda belirlenemedi. Açık havada yeniden deneyin — GPS gökyüzünü net görmelidir.';

  @override
  String get ok => 'Tamam';

  @override
  String get starterChipId => 'Çip numarası';

  @override
  String get starterRemarks => 'Notlar';

  @override
  String get captureFlier => 'İlanı fotoğrafla';

  @override
  String get addPhotosTo => 'Fotoğrafları şuna ekle…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count fotoğraf $name adlı kediye eklendi';
  }

  @override
  String get scanPrintedCode => 'Basılı kodu tara';

  @override
  String get chipScanHint =>
      'Çip kartındaki veya veteriner belgelerindeki basılı QR/barkodu tarar — kedinin içindeki çipi telefon okuyamaz.';

  @override
  String get savingLabel => 'Kaydediliyor…';

  @override
  String ownerOfCat(String name) {
    return '$name sahibi';
  }

  @override
  String get sortLabel => 'Sırala';

  @override
  String get viewAsTable => 'Tablo olarak göster';

  @override
  String get viewAsTiles => 'Karo olarak göster';

  @override
  String get viewAsList => 'Liste olarak göster';

  @override
  String get ageLabel => 'Yaş';

  @override
  String get catList => 'Kedi listesi';

  @override
  String get matchCandidatesTitle => 'Olası eşleşmeler';

  @override
  String get findDuplicates => 'Kopyaları bul';

  @override
  String get noDuplicates => 'Şu anda olası kopya yok.';

  @override
  String get similarName => 'Benzer ad';

  @override
  String get sharePublicly => 'Herkese açık paylaş…';

  @override
  String get pickFramesTitle => 'Kare seç';

  @override
  String get suggestedFrames => 'Önerilen kareler';

  @override
  String get scrubFrames => 'Videoda gezin';

  @override
  String get keepThisFrame => 'Bu kareyi tut';

  @override
  String get fromVideo => 'Videodan…';

  @override
  String get videoMobileOnly =>
      'Videodan kare seçme telefon uygulamasında çalışır (Android ve iPhone) — bu cihazda henüz yok.';

  @override
  String get shareWhitelistExplainer =>
      'Dosyaya ne gireceğini seçin. Yalnızca işaretli alanlar eklenir.';

  @override
  String get exportShareFile => 'Paylaşım dosyasını dışa aktar…';

  @override
  String get hostedLink => 'Barındırılan bağlantı (yüklenen dosyanın URL\'si)';

  @override
  String get inlineQr => 'Gömülü QR (yalnızca metin, fotoğraf yok)';

  @override
  String get inlineTooBig =>
      'Gömülü kod için çok fazla veri — alanları azaltın veya barındırılan bağlantı kullanın.';

  @override
  String get scanShareLabel => 'Paylaşım kodunu tara';

  @override
  String get notAShareCode => 'Bu kod bir cat(a)log paylaşımı değil.';

  @override
  String get importShareTitle => 'Bu kedi içe aktarılsın mı?';

  @override
  String shareSource(String url) {
    return 'Kaynak: $url';
  }

  @override
  String get importLabel => 'İçe aktar';

  @override
  String get strayAreaLabel => 'Olası dolaşma alanı';

  @override
  String get prevPin => 'Önceki iğne';

  @override
  String get nextPin => 'Sonraki iğne';

  @override
  String get noMissingCats => 'Henüz ilan konumu olan kayıp kedi yok.';

  @override
  String get noMatchCandidates => 'Şu anda olası eşleşme yok.';

  @override
  String sameIdField(String field) {
    return 'Aynı $field';
  }

  @override
  String metersApart(String distance) {
    return 'Aralarında $distance m var';
  }

  @override
  String get addFlier => 'İlan ekle';

  @override
  String get missingSinceLabel => 'Kayıp tarihi';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Portreyi kırp';

  @override
  String get statusOwner => 'Sahip';

  @override
  String get ocrUnavailable =>
      'Metin tanıma bu cihazda kullanılamıyor — ilan metnini kendiniz yazın.';

  @override
  String get displayFormat => 'Şu şekilde gösterilir';

  @override
  String get displayPlain => 'Düz metin';

  @override
  String get displayQr => 'QR kodu';

  @override
  String get displayBarcode => 'Barkod';

  @override
  String get editLabel => 'Düzenle';

  @override
  String get doneLabel => 'Bitti';

  @override
  String get openSettings => 'Ayarları aç';

  @override
  String get notSaved => 'Kaydedilmedi';

  @override
  String get birthdateInFuture => 'Doğum tarihi gelecekte olamaz.';

  @override
  String get deceasedInFuture => 'Ölüm tarihi gelecekte olamaz.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Ölüm tarihi doğum tarihinden ($date) önce olamaz.';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Doğum tarihi ölüm tarihinden ($date) sonra olamaz.';
  }

  @override
  String get malePregnant =>
      'Bu kedi erkek olarak kayıtlı — erkek kedi gebe olamaz. Önce cinsiyeti kontrol edin.';

  @override
  String fatherNotMale(String name) {
    return '$name dişi olarak kayıtlı ve baba olamaz. Önce cinsiyeti kontrol edin.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name erkek olarak kayıtlı ve anne olamaz. Önce cinsiyeti kontrol edin.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name $date doğdu — bir ebeveyn yavrusundan sonra doğamaz.';
  }

  @override
  String get genderFatherFemale =>
      'Bu kedi başka kedilerin babası olarak kayıtlı — baba dişi olamaz. Önce aileyi kontrol edin.';

  @override
  String get genderMotherMale =>
      'Bu kedi başka kedilerin annesi olarak kayıtlı — anne erkek olamaz. Önce aileyi kontrol edin.';

  @override
  String get moveTo => 'Şuraya taşı';

  @override
  String get noClowderStrayOption => 'Clowder yok — sokak kedisi / kaçtı';

  @override
  String timelineOf(String name) {
    return 'Zaman çizelgesi — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Bu değişikliği geri al';

  @override
  String get revertSubtitle =>
      'Önceki değeri yeni bir kayıt olarak geri getirir — geçmiş ikisini de saklar.';

  @override
  String fieldCleared(String field) {
    return '$field temizlendi';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field \"$value\" değerine döndü';
  }

  @override
  String get leftStray => 'Ayrıldı — sokak kedisi';

  @override
  String movedTo(String name) {
    return '$name konumuna taşındı';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat geldi';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat, $place yerinden geldi';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat, $place yerine gitti';
  }

  @override
  String get duplicateMergedIn => 'Kopya kayıt birleştirildi';

  @override
  String get asOfToday => 'Bugün itibarıyla';

  @override
  String asOfDate(String date) {
    return '$date itibarıyla';
  }

  @override
  String dateFormatError(String format) {
    return 'Yanlış biçim — $format kullanın';
  }

  @override
  String get dateInFuture => 'Bu tarih gelecekte olamaz.';

  @override
  String get value => 'Değer';

  @override
  String get latitudeLongitude => 'enlem, boylam';

  @override
  String get newField => 'Yeni alan';

  @override
  String get fieldType => 'Tür';

  @override
  String get usedOn => 'Kullanım yeri';

  @override
  String get forCats => 'kediler';

  @override
  String get forClowders => 'clowder\'lar';

  @override
  String get forBoth => 'ikisi de';

  @override
  String get optionsOnePerLine => 'Seçenekler (her satıra bir tane)';

  @override
  String get ownValue => 'Kendi değeriniz';

  @override
  String get renameField => 'Alanı yeniden adlandır';

  @override
  String get editOptions => 'Seçenekleri düzenle…';

  @override
  String get noStraysRightNow => 'Şu anda sokak kedisi yok.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Sokak kedisi ekle';

  @override
  String get newStray => 'Yeni sokak kedisi';

  @override
  String get searchByNameHint => 'İsme göre kedi ara…';

  @override
  String get host => 'Sunucu ol';

  @override
  String get hostExplainer =>
      'Buradan başlayın, sonra kodu diğer cihazda tarayın veya girin.';

  @override
  String get startHosting => 'Sunmayı başlat';

  @override
  String get stopHosting => 'Sunmayı durdur';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'Şimdiye kadar $count oturum';
  }

  @override
  String get join => 'Katıl';

  @override
  String get addressFromHost => 'Adres (sunucu cihazdan)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Şimdi eşitle';

  @override
  String get addressFormatHint => 'Adres şöyle görünmeli: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Eşitlendi: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Eşitleme başarısız: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return '$peer ile son eşitleme: $time';
  }

  @override
  String get sharedFolder => 'Ortak klasör';

  @override
  String get sharedFolderExplainer =>
      'İki cihaz da aynı klasörü kullanır (örn. Dropbox\'ta veya USB bellekte). Her eşitleme değişikliklerinizi oraya bırakır ve karşı tarafınkileri alır.';

  @override
  String get noFolderChosenYet => 'Henüz klasör seçilmedi';

  @override
  String get choose => 'Seç…';

  @override
  String get syncFolderNow => 'Klasörü şimdi eşitle';

  @override
  String folderSynced(String result) {
    return 'Klasör eşitlendi: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Klasör eşitleme başarısız: $error';
  }

  @override
  String get recordSightingHere => 'Burada bir görülme kaydet:';

  @override
  String trailOf(String name, int count) {
    return 'Rota: $name ($count görülme)';
  }

  @override
  String conflictOn(String field) {
    return 'Çakışma — $field';
  }

  @override
  String get conflictBody =>
      'Aynı anda iki yerde değiştirildi. Doğru olanı seçin:';

  @override
  String mergeThisInto(String kind) {
    return 'Bu $kind kaydını şununla birleştir…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Birleştirilecek başka $kind yok.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return '$name ile birleştirilsin mi?';
  }

  @override
  String mergeBody(String name) {
    return 'İki kayıt tek olur. $name mevcut değerlerini korur; diğerinin geçmişi ona katılır. Geri alınamaz.';
  }

  @override
  String get kindCat => 'kedi';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'alan';

  @override
  String get takePhoto => 'Fotoğraf çek';

  @override
  String get chooseFromGallery => 'Galeriden seç';

  @override
  String get about => 'Hakkında';

  @override
  String get aboutTagline =>
      'Bakıma alınan kediler için yerel bir katalog. Verileriniz cihazlarınızda kalır — sunucu yok, hesap yok.';

  @override
  String versionLabel(String version, String build) {
    return 'Sürüm $version ($build)';
  }

  @override
  String get sourceCode => 'Kaynak kodu';

  @override
  String get reportProblemOrIdea => 'Sorun veya fikir bildir';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Geliştiriciye yaz';

  @override
  String get buyCoffee => 'Geliştiriciye kahve ısmarla';

  @override
  String get coffeeSubtitle =>
      'Uygulama ücretsiz kalacak. Kahve alamasam bile :)';

  @override
  String get openSourceLicenses => 'Açık kaynak lisansları';

  @override
  String get machineTranslated =>
      'Çeviriler makine yapımıdır — düzeltmeler GitHub\'da memnuniyetle karşılanır.';

  @override
  String get unnamed => '(isimsiz)';

  @override
  String get labelName => 'İsim';

  @override
  String get labelProfileImage => 'Profil fotoğrafı';

  @override
  String get labelPhoto => 'Fotoğraf';

  @override
  String get starterGender => 'Cinsiyet';

  @override
  String get starterBreed => 'Irk';

  @override
  String get valueMixed => 'melez';

  @override
  String get breedEuropeanShorthair => 'Avrupa kısa tüylü';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'İngiliz kısa tüylü';

  @override
  String get breedNorwegianForestCat => 'Norveç orman kedisi';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siyam';

  @override
  String get breedPersian => 'İran kedisi';

  @override
  String get breedBengal => 'Bengal';

  @override
  String get breedSphynx => 'Sfenks';

  @override
  String get starterColor => 'Renk';

  @override
  String get starterNeutered => 'Kısırlaştırılmış';

  @override
  String get starterPregnant => 'Gebe';

  @override
  String get starterBirthdate => 'Doğum tarihi';

  @override
  String get starterDeceased => 'Vefat';

  @override
  String get starterAddress => 'Adres';

  @override
  String get starterResponsible => 'Sorumlu kişi';

  @override
  String get starterEmail => 'E-posta';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Sorgu bağlantısı';

  @override
  String lookupUrlHelp(String token) {
    return 'Numaranın yerine $token yazılmış servis sayfası, ör. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Sorgula';

  @override
  String lookupFailed(String url) {
    return 'Hiçbir uygulama $url adresini açamadı. Bağlantıyı bir tarayıcıya kopyalayın.';
  }

  @override
  String get stepCat => 'Kedi';

  @override
  String get stepOwner => 'Sahibi';

  @override
  String get stepFace => 'Yüz fotoğrafı';

  @override
  String get stepRegistry => 'Kayıt servisi';

  @override
  String get stepReview => 'Kontrol et ve kaydet';

  @override
  String get stepOwnerHint =>
      'Kediyi arayan kişi — bu, ilandaki iletişim bilgisiyle onun clowder\'ı olur.';

  @override
  String get stepFaceHint =>
      'Kedinin yüzünü ilandan kırp; profil fotoğrafı olur. Bu adımı atlayabilirsin.';

  @override
  String get stepRegistryHint =>
      'İlanda bulunan numaralar. İşaretli olanlar kediyle kaydedilir ve sonra açılabilir.';

  @override
  String get noRegistryLinks =>
      'Bu ilanda kayıt servisi bağlantısı yok — gözden kaçan varsa lütfen hata bildirin.';

  @override
  String get unknownServiceHint => 'Bilinmeyen servis';

  @override
  String get rememberService => 'Servisi hatırla';

  @override
  String get rememberServiceHint =>
      'Servise bir ad ver ve bağlantıdaki numarayı göster. Sonraki ilan kendini doldurur.';

  @override
  String get noIdInLink =>
      'Bu bağlantıda uygulamanın kaydedebileceği bir numara yok.';

  @override
  String get whichNumber => 'Hangi kısım numara?';

  @override
  String get cropAgain => 'Yeniden kırp';

  @override
  String get noFaceYet =>
      'Henüz yüz fotoğrafı yok — ilan fotoğrafı kullanılır.';

  @override
  String get backLabel => 'Geri';

  @override
  String get dangerButton => 'BASMAYIN.\nTEHLİKE';

  @override
  String get dangerThanks => 'cat(a)log kullandığınız için teşekkürler!';

  @override
  String get helpTitle => 'Yardım';

  @override
  String get showTipsAgain => 'İpuçlarını tekrar göster';

  @override
  String get helpHome =>
      'Kolonilerinin genel görünümü — koloni, kedilerin yaşadığı bir yerdir: evin, bir geçici bakım evi, bir barınak. Kedilerini görmek için bir karta dokun; menü için uzun bas. Sağ alttaki düğme yeni koloni oluşturur, sokak kedileri kartı ise evi olmayan tüm kedileri toplar. Üstteki ad, içinde bulunduğun katalog — değiştirmek veya yeni eklemek için dokun.';

  @override
  String get helpClowder =>
      'Bu yer hakkında her şey: kedileri, alanları (adres, iletişim, tür) ve geçmişi. Sayfa salt okunur açılır; kalem düzenlemeyi açar, orada yeni alan da ekleyebilirsin. Bir alana uzun basmak onu doğrudan düzenler, bir kediye uzun basmak taşır, gizler veya açar. Buradan eklenen bir randevu koloninin birkaç kedisini götürebilir, örneğin kısırlaştırma seferi: gelen kedileri işaretleyin, bir kez bitirin, tedavi edilmeyenlerin işaretini kaldırın.';

  @override
  String get helpCat =>
      'Bu kedi hakkında her şey: fotoğraflar, alanlar, aile, geçmiş. Kaleme dokunana kadar sayfa salt okunur. Bir alana uzun bas, doğrudan düzenlemeye geçersin; bir fotoğrafa uzun bas, menüsü açılır. Sağ üstteki menüde gerisi var: gizle, birleştir, görülme kaydet, kediyi paylaş. Özel, bir alanı düzenlerken ayarlanır.';

  @override
  String get helpStrays =>
      'Şu anda evi olmayan kediler: bulunmuş, kaçmış ya da ilandan gelen kediler. Kamera düğmesi önündeki kediyi kaydeder; ilan düğmesi kayıp ilanını, sahibinin iletişimiyle birlikte bir kediye dönüştürür; tarayıcı ilandaki cat(a)log kodunu okur.';

  @override
  String get helpMap =>
      'Konumu olan tüm kediler ve yerler. Arama kedileri, kişileri ve yerleri bulur — bilinmeyen bir adı tüm dünyada arar. Katman düğmesi, kayıp bir kedinin ilan yerlerinin ve kaçtığı evin çevresine 500 m\'lik daireleri çizer. Oklar iğneden iğneye gider, haritaya uzun basmak görülme kaydeder.';

  @override
  String get helpCard =>
      'Kedinin yazdırılabilir kartı: üstteki çiplerle ne görüneceğini seç, sonra görsel ya da PDF olarak paylaş. Numaralar QR ya da barkod olarak basılabilir, konum ise haritayı açan bir QR\'a ve kısa bir Plus Code\'a dönüşür.';

  @override
  String get helpSync =>
      'Veriler başkalarına nasıl ulaşır: doğrudan bağlanın, iki cihazın da gördüğü bir klasör kullanın ya da mesajlaşmayla dosya gönderin. Neyin çıkacağına hep siz karar verirsiniz — gelen .catsync dosyaları da burada açılır.';

  @override
  String get helpFields =>
      'Kataloğunuzun kullandığı alanlar. Adlarını değiştirin, bir seçim alanının seçeneklerini düzenleyin ya da kendi alanınızı ekleyin. Kimlik alanı bir servise (kayıt sistemine) işaret edebilir; o zaman numara kedide tıklanabilir olur.';

  @override
  String get helpTimeline =>
      'Şimdiye kadar yapılmış her değişiklik, en yenisi üstte: kim neyi, ne zaman, hangi değere değiştirmiş. Her kayıt geri alınabilir — bu yeni bir kayıt yazar, hiçbir şey silinmez.';

  @override
  String get helpDuplicates =>
      'İki kez var gibi görünen kediler ya da koloniler — aynı numaralar veya ayrıntıları uyuşan çok benzer adlar. Birleştirmek için bir çifte dokun; geri alınamaz, bu yüzden önce sorar.';

  @override
  String get helpMatches =>
      'Aynı hayvan olabilecek kediler: aynı numara ya da kayıp bir kedinin arama alanında görülen bir sokak kedisi. Birleştirmek için çifte dokun, karşılaştırmak için uzun basıp ilk kediyi aç.';

  @override
  String get helpFlier =>
      'Fotoğraflanan bir ilan, kediye ve sahibine dönüşür. Adım adım: kedinin bilgileri, sahibinin iletişimi, profil fotoğrafı için yüz kırpma, ilandaki kayıt numaraları, sonra son kontrol. Hepsi öneridir — kameranın yanlış okuduğunu düzelt.';

  @override
  String get archiveTitle => 'Arşiv';

  @override
  String get archiveExplainer =>
      'Yıllardır kimsenin dokunmadığı ölmüş kediler ve boş koloniler yine de yer kaplar — özellikle fotoğrafları. Arşivleme onları sakladığınız bir dosyaya yazar ve sonra buradan siler.';

  @override
  String get archiveAction => 'Arşivle';

  @override
  String archiveSelected(int count) {
    return '$count kaydı arşivle';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '$count kayıt arşivlensin mi?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names bir dosyaya yazılacak ve sonra silinecek — cihazınızda ve eşitlediğiniz her cihazda. Dosyayı içe aktarmak her şeyi geri getirir; onsuz kaybolurlar.';
  }

  @override
  String archiveDone(int count) {
    return '$count kayıt arşivlendi ve silindi';
  }

  @override
  String archiveFailed(String error) {
    return 'Hiçbir şey silinmedi: arşiv dosyası yazılamadı ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Veritabanı $db, fotoğraflar $photos / $count dosya';
  }

  @override
  String quietForYears(int years) {
    return '$years yıldır değişmemiş';
  }

  @override
  String get nothingToArchive => 'Arşivlenecek kadar eski bir şey yok.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Son değişiklik $date · fotoğraflar $size';
  }

  @override
  String get helpArchive =>
      'Eski veriler yer kaplar, özellikle her eşitlenen cihazın taşıdığı fotoğraflar. Burada yıllardır sessiz duran ölmüş kedileri ve boş kolonileri seçer, sakladığınız bir dosyaya yazar ve silersiniz. Silme, eşitlediğiniz herkese ulaşır; dosyayı içe aktarmak her şeyi geri yükler.';

  @override
  String restoreDeletedTitle(int count) {
    return '$count silinmiş kayıt geri yüklensin mi?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names bu katalogda silinmiş durumda ve az önce içe aktardığınız dosya bunları içeriyor. Geri yükleme onları buraya ve eşitlediğiniz her cihaza geri getirir.';
  }

  @override
  String get restoreAction => 'Geri yükle';

  @override
  String get keepDeleted => 'Silinmiş kalsın';

  @override
  String get archiveNotSaved =>
      'Hiçbir şey silinmedi: arşiv hiçbir yere kaydedilmedi.';

  @override
  String get locateAddress => 'Adresi haritada bul';

  @override
  String get addressLocated => 'Adres bulundu';

  @override
  String get addressNotFound =>
      'Bu adres için yer bulunamadı. Yazımı kontrol edin ya da boş bırakın.';

  @override
  String get starterPosition => 'Konum';

  @override
  String get valueYes => 'evet';

  @override
  String get valueNo => 'hayır';

  @override
  String get valueFemale => 'dişi';

  @override
  String get valueMale => 'erkek';

  @override
  String get valueUnknown => 'bilinmiyor';

  @override
  String get cropTitle => 'Fotoğrafı kırp';

  @override
  String get markTitle => 'Kediyi işaretle';

  @override
  String get applyCrop => 'Kırp';

  @override
  String get useFullPhoto => 'Fotoğrafın tamamını kullan';

  @override
  String get dragToSelect => 'Kedinin etrafına dikdörtgen çiz';

  @override
  String get dragOverTheCat => 'Kedinin üzerine elips çiz';

  @override
  String get cropPhoto => 'Kırp…';

  @override
  String get markPhoto => 'İşaretle…';

  @override
  String get scanCode => 'Kodu tara';

  @override
  String get orTypeCode => 'Ya da kodu yaz';

  @override
  String get copyCode => 'Kodu kopyala';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get invalidCode => 'Bu kod geçersiz';

  @override
  String get hotspotHint =>
      'Ortak Wi-Fi yok mu? Bir telefonun erişim noktasını aç, diğerini bağla, sonra burada sun.';

  @override
  String get byMessenger => 'Mesajlaşma ile';

  @override
  String get byMessengerExplainer =>
      'Tüm kataloğu tek dosya olarak WhatsApp, Signal veya postayla gönder — karşı taraf içe aktarır.';

  @override
  String get shareBundle => 'Eşitleme paketini paylaş…';

  @override
  String get importBundle => 'Eşitleme paketini içe aktar…';

  @override
  String bundleImported(String result) {
    return 'Paket içe aktarıldı: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Son otomatik yedekleme başarısız oldu: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'İçe aktarma başarısız: $error';
  }

  @override
  String get pickOnMap => 'Haritadan seç';

  @override
  String get useMyLocation => 'Konumumu kullan';

  @override
  String get language => 'Dil';

  @override
  String get systemDefault => 'Sistem varsayılanı';

  @override
  String get iosLocalNetworkHint =>
      'iPhone/iPad\'de hâlâ olmuyorsa: Ayarlar → Gizlilik ve Güvenlik → Yerel Ağ → cat(a)log\'a izin ver, sonra tekrar dene.';

  @override
  String get includePrivate => 'Özel verileri paylaş';

  @override
  String get hideLabel => 'Bu cihazda gizle';

  @override
  String get unhideLabel => 'Yeniden göster';

  @override
  String get showHiddenLabel => 'Gizlenenleri göster';

  @override
  String get stopShowingHidden => 'Gizlenenleri göstermeyi bırak';

  @override
  String get starterSpecies => 'Tür';

  @override
  String get starterStatus => 'Tür';

  @override
  String get statusFoster => 'Geçici yuva';

  @override
  String get statusForeverHome => 'Yuva';

  @override
  String get statusClinic => 'Klinik';

  @override
  String get statusShelter => 'Barınak';

  @override
  String get statusBarn => 'Ahır';

  @override
  String get valueCat => 'Kedi';

  @override
  String get otherOption => 'Diğer…';

  @override
  String get celebrationsToggle => 'Sahiplendirmeleri kutla';

  @override
  String get celebrationsSubtitle =>
      'Bir kedi yuvasına taşındığında konfeti ve tezahürat';

  @override
  String get onMapLabel => 'Haritada';

  @override
  String get showOnMap => 'Haritada göster';

  @override
  String get searchPlaceHint => 'Yer veya adres ara';

  @override
  String get noPlacesFound => 'Yer bulunamadı';

  @override
  String get mapSearchHint => 'Kedi, grup, kişi ara';

  @override
  String get proposeAnotherName => 'Başka bir isim öner';

  @override
  String get moderationTitle => 'Yazarlar ve yasaklar';

  @override
  String get moderationSubtitle =>
      'Bir kişinin verilerini kalıcı olarak kaldır';

  @override
  String get authorsSection => 'Bu kataloğa kim yazdı';

  @override
  String get hardDeleteAction => 'Bu yazarın her şeyini sil';

  @override
  String hardDeleteWarning(Object name) {
    return '$name tarafından yazılan her kaydı ve fotoğrafı bu cihazdan kaldırır. Diğer cihazlar kendilerininkini tutar. Geri alınamaz.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Onaylamak için $name yazın';
  }

  @override
  String get alsoBan => 'Ayrıca yasakla — bir daha asla veri kabul etme';

  @override
  String get bansSection => 'Yasaklar';

  @override
  String get unbanAction => 'Yasağı kaldır';

  @override
  String get deletedDone => 'Silindi.';

  @override
  String get syncSummaryTitle => 'Ne geldi';

  @override
  String get summaryAdopted => 'Sahiplendirildi';

  @override
  String get summaryDeceased => 'Öldü';

  @override
  String get summaryEscaped => 'Kaçtı';

  @override
  String get summaryNew => 'Yeni';

  @override
  String get summaryConflicts => 'Çözülecek çakışmalar';

  @override
  String summaryOther(Object n) {
    return '…ve $n değişiklik daha';
  }

  @override
  String get starterMother => 'Anne';

  @override
  String get starterFather => 'Baba';

  @override
  String get familySection => 'Aile';

  @override
  String get littermatesLabel => 'Aynı batından';

  @override
  String get siblingsLabel => 'Kardeşler';

  @override
  String get kittensLabel => 'Yavrular';

  @override
  String get toastSettingsTitle => 'Neler duyurulsun';

  @override
  String get toastSettingsSubtitle => 'Eşitlemeden sonra küçük mesajlar';

  @override
  String get toastKindAdoptions => 'Sahiplendirmeler';

  @override
  String get toastKindBirths => 'Doğumlar';

  @override
  String get toastKindDeaths => 'Ölümler';

  @override
  String get toastKindEscapes => 'Kaçışlar';

  @override
  String get toastKindMoves => 'Taşınmalar';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat, $home tarafından sahiplenildi 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Yeni yavru: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat vefat etti';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat kaçtı';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat, $home adresine taşındı';
  }

  @override
  String get notACatlogFile => 'Bu bir cat(a)log dosyası değil';

  @override
  String get nothingNewInBundle =>
      'Dosyada yeni bir şey yok — zaten her şeye sahipsin';

  @override
  String get syncChooserInPerson => 'Yüz yüze';

  @override
  String get syncChooserInPersonSub => 'Wi-Fi ile eşitleme';

  @override
  String get syncChooserRemote => 'Uzaktan';

  @override
  String get syncChooserRemoteSub => 'Klasör veya USB bellek ile eşitleme';

  @override
  String get syncChooserMessenger => 'Mesajlaşma';

  @override
  String get syncChooserMessengerSub => 'Sosyal medya ile dışa ve içe aktarma';

  @override
  String get connectToWifiFirst =>
      'Önce bir Wi-Fi\'ye bağlanın — cihazlar birbirini o zaman bulur';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) eşitlemek istiyor';
  }

  @override
  String get trustBothWaysNote => 'Kataloglarınız iki yönde de değiştirilecek.';

  @override
  String get allowOnce => 'İzin ver';

  @override
  String get allowAlways => 'Bu cihaza her zaman izin ver';

  @override
  String get declineAction => 'Reddet';

  @override
  String get syncDeclined => 'Diğer cihaz eşitlemeyi reddetti';

  @override
  String get trustedDevicesSection => 'Her zaman izinli cihazlar';

  @override
  String get removeTrust => 'Kaldır';

  @override
  String get hostWithoutWifi => 'Wi-Fi olmadan barındır';

  @override
  String get hotspotJoinNote =>
      'Diğer telefonla geçici doğrudan bağlantı kurar (internet yok). Yalnızca cat(a)log kullanır ve eşitlemeden sonra kendiliğinden kesilir.';

  @override
  String get hotspotAndroidOnly =>
      'Bu kod iki Android telefon gerektirir — iPhone/iPad\'de ortak Wi-Fi kullanın';

  @override
  String get selectClowderHint => 'Soldan bir clowder seçin';

  @override
  String get introTitle1 => 'Kedileriniz düzenli';

  @override
  String get introBody1 =>
      'Baktığınız her kedi için bir kart oluşturun: fotoğraf, cinsiyet, sağlık, not etmek istediğiniz her şey. Kediler yaşadıkları yere göre gruplanır — uygulama bu yere koloni (clowder) der.';

  @override
  String get introTitle2 => 'İnternetsiz çalışır';

  @override
  String get introBody2 =>
      'Her şey yalnızca telefonunuza kaydedilir. Hesap yok, bulut yok. Siz paylaşmadıkça hiçbir şey gönderilmez.';

  @override
  String get introTitle3 => 'Birlikte çalışın';

  @override
  String get introBody3 =>
      'Herkes kendi uygulamasını kullanır, ara sıra veri alışverişi yaparsınız: buluşup bir kod okutun, ortak bir klasör kullanın ya da messenger ile tek dosya gönderin. Sonrasında herkes aynı bilgiye sahip olur.';

  @override
  String get introSkip => 'Atla';

  @override
  String get introNext => 'İleri';

  @override
  String get introDone => 'Başlayalım';

  @override
  String get introReplayTitle => 'Hızlı tanıtım';

  @override
  String get spotHomeSync =>
      'Burada tanıdıklarınızla eşitlersiniz. Neyi paylaşacağınıza siz karar verirsiniz.';

  @override
  String get spotHomeStrays =>
      'Bu kart tüm sokak kedilerini toplar — evi olmayan kedileri. Listeyi görmek için dokunun.';

  @override
  String get spotHomeMenu =>
      'Bu menüde: kopyaları bulup birleştirme, CSV dışa aktarma ve daha fazlası.';

  @override
  String get spotCatEdit =>
      'Kediyi düzenlemek için kaleme dokunun. İpucu: bir alana uzun basmak onu doğrudan düzenler.';

  @override
  String get spotMapLayers =>
      'Kayıp kedi mi arıyorsunuz? İlanlarının görüldüğü yerlerin ve kaçtığı evin çevresine daireler çizin.';

  @override
  String get spotStraysFlier =>
      'Kayıp kedi ilanı mı buldunuz? Burada fotoğraflayın — uygulama kediyi ve iletişimi sizin için kaydeder.';

  @override
  String get spotStraysScan =>
      'Bazı ilanlarda cat(a)log QR kodu bulunur. Burada tarayın, kediyi yazmadan içe aktarın.';

  @override
  String get introTitle4 => 'Kayıp kedileri bulun';

  @override
  String get introBody4 =>
      'Kayıp kedi ilanı mı gördünüz? Uygulamada fotoğraflayın: kediyi, sahibinin iletişimini ve yeri kaydeder. Daha sonra benzer bir sokak kedisi görülürse uygulama olası eşleşmeler önerir.';

  @override
  String get spotMapSearch =>
      'Haritada oraya atlamak için bir kedi, yer veya kişi yazın.';

  @override
  String get spotCardChips =>
      'Paylaşılabilir kartta ne görüneceğini işaretleyin — gerisi kartta yer almaz.';

  @override
  String get spotCatMenu =>
      'Burada daha çok işlem var: kediyi gizle, kopyaları birleştir veya bir görülme kaydet.';

  @override
  String get spotDone => 'Anladım';

  @override
  String get spotReplayTitle => 'Yenilik turu';

  @override
  String get spotReplaySubtitle => 'İpuçlarını her sayfada yeniden göster';

  @override
  String get spotReplayDone => 'İpuçları yeniden gösterilecek';

  @override
  String get searchNoResults => 'Bu isimde kedi bulunamadı';

  @override
  String get syncUnreachable =>
      'Diğer cihaza ulaşılamadı. İkisi de aynı Wi-Fi\'de mi?';

  @override
  String get folderUnreachable =>
      'Klasöre ulaşılamadı. Sürücü veya bulut klasörü hâlâ var mı?';

  @override
  String get crashTitle => 'Bunun olmaması gerekirdi';

  @override
  String get crashBody =>
      'cat(a)log beklenmedik bir hatayla karşılaştı. Verileriniz güvende — her şey değiştirdiğiniz anda kaydedilir. Uygulamayı yeniden başlatın, tekrarlanırsa düzeltilebilmesi için raporu gönderin.';

  @override
  String get crashRestart => 'Uygulamayı yeniden başlat';

  @override
  String get crashSendReport => 'Geliştiriciye rapor gönder';

  @override
  String get crashLastRunBody =>
      'cat(a)log geçen sefer beklenmedik şekilde durdu — büyük olasılıkla bellek doldu. Düzeltilmesi için kısa bir rapor gönderilsin mi?';

  @override
  String get catalogsTitle => 'Kataloglar';

  @override
  String get newCatalog => 'Yeni katalog';

  @override
  String get catalogNameLabel => 'Katalog adı';

  @override
  String catalogNameTaken(String name) {
    return '$name adlı bir katalog zaten var. Başka bir ad seç.';
  }

  @override
  String get manageCatalogs => 'Katalogları yönet';

  @override
  String get helpCatalogs =>
      'Her katalog kendi dünyasıdır: kendi kedileri, kolonileri, alanları, fotoğrafları ve eşitleme ortakları. Berlin ile Paris asla karışmaz. Değiştirmek, yeni eklemek veya adını değiştirmek için ana ekranın üstündeki ada dokun. Adın, dilin ve gördüğün ipuçları hepsinde ortaktır.';

  @override
  String get spotHomeCatalog =>
      'Bu, içinde bulunduğun katalog. Değiştirmek ya da yenisini oluşturmak için ada dokun.';

  @override
  String get deleteCatalog => 'Kataloğu sil';

  @override
  String deleteCatalogBody(String name) {
    return '$name içindeki her şey gider: kediler, fotoğraflar, geçmiş. Önce otomatik yedeklerin gittiği yere eksiksiz bir dosya kaydedilir; onu içe aktarmak kataloğu geri getirir. Onaylamak için adı yaz.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name silindi. Dosya $where içinde.';
  }

  @override
  String typeTheName(String name) {
    return '$name yaz';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Hiçbir şey silinmedi: katalog dosyası yazılamadı ($error). Yer aç ya da daha sonra yeniden dene.';
  }

  @override
  String get moveToCatalog => 'Başka bir kataloğa taşı';

  @override
  String movedToCatalog(int count, String name) {
    return '$count öğe $name kataloğuna taşındı';
  }

  @override
  String get chooseWhatToMove => 'Ne taşınsın?';

  @override
  String moveIntoNewCatalog(String name) {
    return '$name kataloğuna bir şey taşınsın mı?';
  }

  @override
  String get undoThisImport => 'Bu içe aktarmayı geri al';

  @override
  String undoImportBody(int count) {
    return 'Bu içe aktarmanın getirdiği $count değişiklik kaldırılır. Önce bir dosyaya yazılır; onu içe aktarmak geri getirir. Daha önce eşitlediğin kişilerde kopya kalır — o geri alınamaz.';
  }

  @override
  String undoneImport(String where) {
    return 'Geri alındı. Dosya $where içinde.';
  }

  @override
  String get goBackTitle => 'Geri dön';

  @override
  String get goBackToHere => 'Buraya dön';

  @override
  String get momentImport => 'İçe aktarmadan önce';

  @override
  String get momentSync => 'Eşitlemeden önce';

  @override
  String get momentMerge => 'Birleştirmeden önce';

  @override
  String get momentHardDelete => 'Bir yazarın verilerini silmeden önce';

  @override
  String get momentArchive => 'Arşivlemeden önce';

  @override
  String get momentManual => 'Senin işaretlediğin';

  @override
  String get showOlderMoments => 'Daha eskileri göster';

  @override
  String goBackBody(int count) {
    return 'Bu andan sonraki her şey kaldırılır — $count değişiklik. Önce bir dosyaya yazılır; onu içe aktarmak hepsini geri getirir, bundan yeni her an da onunla gider. Daha önce eşitlediğin kişilerde kopya kalır — o geri alınamaz.';
  }

  @override
  String get nameThisMoment => 'Bu ana bir ad ver';

  @override
  String get helpGoBack =>
      'Bu kataloğun biçim değiştirdiği anlar: her içe aktarmadan ve her eşitlemeden önce, birleştirme, arşivleme veya silme öncesinde, ve kendin bir an işaretlediğin her seferde. Birini seçmek kataloğu o duruma döndürür: sonrasındaki her şey elinde kalan bir dosyaya yazılır ve kaldırılır, ondan yeni her an da onunla gider. Daha önce eşitlediğin kişiler aldıklarını korur.';

  @override
  String goBackFileFailed(String error) {
    return 'Hiçbir şey kaldırılmadı: onu saklayan dosya yazılamadı ($error). Yer aç ve yeniden dene.';
  }

  @override
  String get switchBeforeDeleting =>
      'Bu, içinde bulunduğun katalog. Başka birine geç, sonra sil.';

  @override
  String shareFileFailed(String error) {
    return 'Paylaşım dosyası yazılamadı ($error). Yer aç ve yeniden dene.';
  }

  @override
  String get privateLabel => 'Özel';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Özel olarak işaretle';

  @override
  String get unmarkPrivate => 'Özel işaretini kaldır';

  @override
  String get agenda => 'Ajanda';

  @override
  String get reminderLabel => 'Hatırlatma';

  @override
  String get agendaEmpty =>
      'Planlanmış randevu yok. Yenilerini burada artı ile ya da bir kedinin veya clowder\'ın sayfasında planla.';

  @override
  String get dueToday => 'bugün';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün içinde',
      one: '1 gün içinde',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün gecikmiş',
      one: '1 gün gecikmiş',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Yapıldı';

  @override
  String get repeatTitle => 'Tekrar…';

  @override
  String get noRepeatLabel => 'Tekrar yok';

  @override
  String get unitDays => 'gün sonra';

  @override
  String get unitWeeks => 'hafta sonra';

  @override
  String get unitMonths => 'ay sonra';

  @override
  String get unitYears => 'yıl sonra';

  @override
  String ageYears(int years) {
    return '$years yıl';
  }

  @override
  String ageMonths(int months) {
    return '$months ay';
  }

  @override
  String get changeDateLabel => 'Tarihi değiştir';

  @override
  String get removeReminderLabel => 'Hatırlatmayı kaldır';

  @override
  String get exportIcs => 'Takvim dosyasını dışa aktar';

  @override
  String icsSavedTo(String path) {
    return 'Takvim dosyası $path konumuna kaydedildi';
  }

  @override
  String get calendarMirrorLabel => 'Cihaz takvimine yansıt';

  @override
  String get calendarMirrorSubtitle =>
      'Randevular takvimde tüm gün süren etkinlikler olarak görünür. cat(a)log her açılışta ve her değişiklikten sonra onları orada günceller. Randevu uyarılarını takvimde yönetebilirsin.';

  @override
  String get syncPeerOlder =>
      'Diğer cihazda hatırlatmasız daha eski bir cat(a)log var. Orada cat(a)log uygulamasını güncelle ve yeniden eşitle.';

  @override
  String get syncPeerNewer =>
      'Diğer cihazda daha yeni bir cat(a)log var. Bu cihazda cat(a)log uygulamasını güncelle ve yeniden eşitle.';

  @override
  String get bundleNewerError =>
      'Bu dosya daha yeni bir cat(a)log sürümünden geliyor. İçe aktarmak için bu cihazda cat(a)log uygulamasını güncelle.';

  @override
  String get spotEar =>
      'Köşedeki küçük kedi kulağı şu demek: daha fazlası için basılı tut.';

  @override
  String get addReminder => 'Hatırlatma ekle';

  @override
  String get plannedSection => 'Planlanan';

  @override
  String get reminderDialogHint =>
      'Randevu ajandada görünür. Orada onaylayabilir veya vazgeçebilirsin. Değer yalnızca randevu onaylandığında alınır.';

  @override
  String get reminderFor => 'Kimin için';

  @override
  String get reminderField => 'Alan';

  @override
  String get dueDateLabel => 'Son tarih';

  @override
  String get pickCalendar => 'Hangi takvim?';

  @override
  String get calendarPermissionDenied =>
      'Takvim erişimi engelli, bu yüzden yansıtma kapalı. Sistem ayarlarından izin ver ve yansıtmayı yeniden aç.';

  @override
  String get calendarNotChosen =>
      'Takvim seçilmedi, bu yüzden yansıtma kapalı. Yeniden aç ve bir takvim seç.';

  @override
  String get calendarGone =>
      'Seçilen takvim artık yok, bu yüzden yansıtma kapalı. Yeniden aç ve başka bir takvim seç.';

  @override
  String get noWritableCalendar =>
      'Takvim bulunamadı. Sistem ayarlarında bir takvim hesabına, örneğin Google\'a giriş yap ve yeniden dene.';

  @override
  String get spotHomeAgenda =>
      'Ajanda: planlanan randevuların listesi — veteriner, ilaç, kontroller.';

  @override
  String get spotAgendaAdd => 'Yeni bir randevu planla.';

  @override
  String get spotAgendaCalendar =>
      'cat(a)log randevularının seçtiğin bir takvime yansıtılmasını buradan aç.';

  @override
  String get helpAgenda =>
      'Ajanda planlanan randevuları tarihe göre listeler. İki tür vardır: saati olan randevular ve bir gün için geçerli hatırlatmalar. Kaçırılanlar üstte kalır. Dokunmak kediyi veya clowder\'ı açar. Onay işareti randevuyu onaylar: değer alana yazılır ve hemen bir sonrakini, örneğin üç ay sonrasına planlayabilirsin. Basılı tutmak tarihi değiştirir veya randevuyu siler. Üstteki anahtar randevuları telefonunun bir takvimine yansıtır. Menü onları takvim dosyası olarak dışa aktarır. Birkaç kediyle veteriner ziyareti tek bir randevudur: kedileri işaretleyin, Ajanda adlarıyla tek bir kart gösterir ve bitirirken hangi kedilerin tedavi edildiğini sorar — diğerlerinin işaretini kaldırın, planlı kalırlar.';

  @override
  String get calendarRowOff => 'Takvim: kapalı';

  @override
  String calendarRowOn(String name) {
    return 'Takvim: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Bu kedi için bir randevu planla. Ajandada görünür ve orada onaylanır.';

  @override
  String get spotAddReminderClowder =>
      'Bu clowder için bir randevu planla. Ajandada görünür ve orada onaylanır.';

  @override
  String get readOnlyCalendar => 'salt okunur';

  @override
  String get appointmentLabel => 'Randevu';

  @override
  String get addAppointment => 'Randevu ekle';

  @override
  String get planChooserTitle => 'Randevu mu, hatırlatma mı?';

  @override
  String get planChooserAppointment =>
      'Randevu — bir tarih ve saatte ziyaret, notlarla';

  @override
  String get planChooserReminder =>
      'Hatırlatma — bir gün vadesi gelen bir değer';

  @override
  String get appointmentTitleLabel => 'Ne';

  @override
  String get notesLabel => 'Notlar';

  @override
  String get timeLabel => 'Saat';

  @override
  String get allDayLabel => 'Tüm gün';

  @override
  String get alertLabel => 'Uyarı';

  @override
  String get alertNone => 'Yok';

  @override
  String get alertDayBefore => 'Bir gün önce';

  @override
  String get alertHourBefore => 'Bir saat önce';

  @override
  String get linkFieldLabel => 'Bitince bir alana yaz';

  @override
  String get noLinkedField => 'Alan yok';

  @override
  String get outcomeTitle => 'Nasıl geçti?';

  @override
  String get finishLabel => 'Bitir';

  @override
  String get editLabelAppointment => 'Randevuyu düzenle';

  @override
  String get deleteAppointment => 'Randevuyu sil';

  @override
  String get stepFlierText => 'İlan metni';

  @override
  String get qrFoundHint =>
      'İlanda bir QR kod bulundu. İşaretli kodlar kayıt numaraları ve bağlantılar için okunur.';

  @override
  String get useCode => 'Bu kodu kullan';

  @override
  String get qrNone => 'Fotoğrafta QR kod bulunamadı.';

  @override
  String qrFailed(String error) {
    return 'QR kod okunamadı: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$name ilanı tanındı. Her satırın hangi alana gideceğini aşağıda kontrol edin.';
  }

  @override
  String get flierLayoutUnknown =>
      'Bilinmeyen ilan düzeni. Satırları aşağıda alanlara atayın; kalanı notlarda kalır.';

  @override
  String get targetRegistryNumber => 'Kayıt numarası';

  @override
  String get targetLostPlace => 'Adres (kaybolduğu yer)';

  @override
  String get targetContact => 'Kayıt servisi iletişimi';

  @override
  String get targetDrop => 'At';

  @override
  String get abortScanTitle => 'Tarama iptal edilsin mi?';

  @override
  String get abortScanBody => 'Hiçbir şey kaydedilmez.';

  @override
  String get abortScan => 'İptal';

  @override
  String get keepScanning => 'Devam et';

  @override
  String get catsOnAppointment => 'Bu randevudaki kediler';

  @override
  String get noCatsHint =>
      'Hiçbir kedi işaretli değil — randevu koloninin kendisine ait.';

  @override
  String get pickCatsTitle => 'Hangi kediler geliyor?';

  @override
  String catsCount(int count) {
    return '$count kedi';
  }

  @override
  String get finishUntickHint =>
      'Tedavi edilmeyen kedilerin işaretini kaldırın; planlı kalırlar.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Randevuyu $count kedinin tümü için sil';
  }
}
