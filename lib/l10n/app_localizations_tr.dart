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
  String get noClowdersYet => 'Henüz clowder yok.\nAşağıdan ilkini oluşturun.';

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
      'Kedi tüm listelerden kaybolur. Fotoğrafları kalıcı olarak silinir.';

  @override
  String get sightingRecorded => 'Görülme, konumunuzda kaydedildi.';

  @override
  String get noLocationAvailable =>
      'Konum alınamadı — bunun yerine haritaya uzun basın.';

  @override
  String get locationDeniedForever =>
      'Konum erişimi engellendi. Stray Cam kullanmak için sistem ayarlarından izin verin.';

  @override
  String get openSettings => 'Ayarları aç';

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
      'Buradan başlayın, sonra adres ve PIN\'i diğer cihaza girin.';

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
      'Bulut ya da USB belleğin cihazlar arasında taşıdığı bir klasör üzerinden eşitleyin — aynı ağda olmayanlar için.';

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
  String get coffeeSubtitle => 'Tamamen isteğe bağlı — uygulama ücretsiz';

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
}
