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
  String get renameField => 'Alanı yeniden adlandır';

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
  String get orPlaceClowderHere => 'Ya da buraya bir clowder yerleştir:';

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
  String get markPrivate => 'Özel olarak işaretle';

  @override
  String get unmarkPrivate => 'Özel işaretini kaldır';

  @override
  String get includePrivate => 'Özel verileri dahil et';

  @override
  String get includePrivateExplainer =>
      'Özel kediler, gruplar ve alanlar da paylaşılır — yalnızca kendi cihazlarınızı eşitlerken açın.';

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
  String get starterStatus => 'Durum';

  @override
  String get statusFoster => 'Geçici yuva';

  @override
  String get statusForeverHome => 'Kalıcı yuva';

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
      'Bir kedi kalıcı yuvasına taşındığında konfeti ve tezahürat';

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
  String get syncChooserInPersonSub =>
      'Aynı odadasınız — kodu tarayın, saniyeler içinde biter';

  @override
  String get syncChooserRemote => 'Uzaktan';

  @override
  String get syncChooserRemoteSub =>
      'Dropbox veya USB bellek gibi paylaşılan bir klasör üzerinden';

  @override
  String get syncChooserMessenger => 'Mesajlaşma';

  @override
  String get syncChooserMessengerSub =>
      'Her şeyi tek dosya olarak herhangi bir uygulamayla gönderin';

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
  String get introTitle1 => 'Kediler clowder\'larda yaşar';

  @override
  String get introBody1 =>
      'Clowder, kedilerin yaşadığı yerdir: geçici yuvanız, sahiplenen kişinin evi, yandaki ahır. Her kedinin fotoğraflı, bilgili ve tüm hikâyesini içeren bir kartı olur.';

  @override
  String get introTitle2 => 'Her şey sizde kalır';

  @override
  String get introBody2 =>
      'Hesap yok, bulut yok, takip yok. Verileriniz cihazınızda yaşar.';

  @override
  String get introTitle3 => 'Yardımcılarınızla paylaşın';

  @override
  String get introBody3 =>
      'Bir kodu tarayın, iki cihaz saniyeler içinde eşitlensin; ortak klasör kullanın ya da her şeyi tek dosya olarak gönderin.';

  @override
  String get introSkip => 'Atla';

  @override
  String get introNext => 'İleri';

  @override
  String get introDone => 'Başlayalım';

  @override
  String get introReplayTitle => 'Hızlı tanıtım';
}
