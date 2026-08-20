// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'cat(a)log へようこそ';

  @override
  String get welcomeBody => '自分の名前を決めてください。すべての変更はこの名前で記録され、誰が何をしたかが分かります。';

  @override
  String get yourName => 'あなたの名前';

  @override
  String get start => 'はじめる';

  @override
  String get clowders => 'クラウダー';

  @override
  String get noClowdersYet =>
      'まだグループがありません。グループとは猫が暮らす場所 — 預かり宅や里親の部屋。下から最初のグループを作りましょう。';

  @override
  String get strays => '野良猫';

  @override
  String get searchCats => '猫を検索';

  @override
  String get map => '地図';

  @override
  String get sync => '同期';

  @override
  String get fields => '項目';

  @override
  String get exportCsv => 'CSV をエクスポート';

  @override
  String get aboutAndFeedback => '情報とフィードバック';

  @override
  String get newClowder => '新しいクラウダー';

  @override
  String get name => '名前';

  @override
  String get cancel => 'キャンセル';

  @override
  String get create => '作成';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get merge => '統合';

  @override
  String get resolve => '確定';

  @override
  String get open => '開く';

  @override
  String csvSavedTo(String path) {
    return 'CSV を $path に保存しました';
  }

  @override
  String get renameClowder => 'クラウダー名を変更';

  @override
  String get rename => '名前を変更';

  @override
  String get timeline => '履歴';

  @override
  String get mergeInto => '統合先を選ぶ…';

  @override
  String get deleteClowder => 'クラウダーを削除';

  @override
  String get cats => '猫';

  @override
  String get addCat => '猫を追加';

  @override
  String get newCat => '新しい猫';

  @override
  String deleteQuestion(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get deleteClowderEmptyBody => 'クラウダーは一覧から消えます。';

  @override
  String deleteClowderBody(int count) {
    return '所属する $count 匹の猫は削除されず、野良猫になります。望まない場合は先に別のクラウダーへ移してください。';
  }

  @override
  String get card => 'カード';

  @override
  String get shareAsImage => '画像として共有';

  @override
  String get shareAsPdf => 'PDF として共有';

  @override
  String get print => '印刷';

  @override
  String cardTitle(String name) {
    return 'カード — $name';
  }

  @override
  String get renameCat => '猫の名前を変更';

  @override
  String get seenHereNow => '今ここで目撃';

  @override
  String get deleteCat => '猫を削除';

  @override
  String get clowderLabel => 'クラウダー';

  @override
  String get strayNoClowder => '野良猫 — クラウダーなし';

  @override
  String get stray => '野良猫';

  @override
  String get photos => '写真';

  @override
  String get addPhoto => '写真を追加';

  @override
  String get setAsProfileImage => 'プロフィール写真に設定';

  @override
  String get thisIsProfileImage => 'これがプロフィール写真です';

  @override
  String get deletePhoto => '写真を削除';

  @override
  String get deletePhotoTitle => '写真を削除しますか？';

  @override
  String get deletePhotoBody => '写真データは完全に削除され、元に戻せません。';

  @override
  String get deleteCatBody =>
      'この猫はすべての一覧から消え、写真も削除されます。この端末だけでなく、次回の同期後には他の端末からも消えます。';

  @override
  String get sightingRecorded => '現在地で目撃を記録しました。';

  @override
  String get noLocationAvailable => '位置情報がありません — 代わりに地図を長押ししてください。';

  @override
  String get locationDeniedForever =>
      '位置情報へのアクセスがブロックされています。Stray Cam を使うにはシステム設定で許可してください。';

  @override
  String get locationServiceOff =>
      'この端末では位置情報がオフになっています。設定でオンにしてから、もう一度お試しください。';

  @override
  String get locationDenied =>
      'cat(a)log に位置情報の使用許可がありません。もう一度試して、確認されたら許可してください。';

  @override
  String get locationNoFix =>
      '現在地を特定できませんでした。屋外でもう一度お試しください — GPS には空への見通しが必要です。';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'チップ番号';

  @override
  String get starterRemarks => '備考';

  @override
  String get captureFlier => 'チラシを撮影';

  @override
  String get addPhotosTo => '写真の追加先…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count枚の写真を$nameに追加しました';
  }

  @override
  String get scanPrintedCode => '印刷されたコードをスキャン';

  @override
  String get chipScanHint =>
      'チップカードや獣医の書類に印刷されたQR/バーコードを読み取ります。猫の体内のチップは電話では読めません。';

  @override
  String get savingLabel => '保存中…';

  @override
  String ownerOfCat(String name) {
    return '$nameの飼い主';
  }

  @override
  String get sortLabel => '並べ替え';

  @override
  String get viewAsTable => '表形式で表示';

  @override
  String get viewAsTiles => 'タイル表示';

  @override
  String get matchCandidatesTitle => '一致候補';

  @override
  String get findDuplicates => '重複を探す';

  @override
  String get noDuplicates => '現在、重複の可能性はありません。';

  @override
  String get similarName => '似た名前';

  @override
  String get sharePublicly => '公開共有…';

  @override
  String get privateNoShare =>
      'この猫はプライベットに設定されています。プライベートなデータは端末の外に出ません。公開共有するには先に設定を解除してください。';

  @override
  String get pickFramesTitle => 'フレームを選ぶ';

  @override
  String get suggestedFrames => 'おすすめフレーム';

  @override
  String get scrubFrames => '動画をスクラブ';

  @override
  String get keepThisFrame => 'このフレームを残す';

  @override
  String get fromVideo => '動画から…';

  @override
  String get videoMobileOnly =>
      '動画からのフレーム抽出はスマホアプリ（Android・iPhone）で使えます。この端末ではまだ使えません。';

  @override
  String get shareWhitelistExplainer => 'ファイルに入れる内容を選びます。チェックした項目だけが含まれます。';

  @override
  String get exportShareFile => '共有ファイルを書き出す…';

  @override
  String get hostedLink => 'ホスト済みリンク（アップロードしたファイルのURL）';

  @override
  String get inlineQr => '埋め込みQR（テキストのみ・写真なし）';

  @override
  String get inlineTooBig => '埋め込みコードにはデータが多すぎます。項目を減らすか、ホスト済みリンクを使ってください。';

  @override
  String get scanShareLabel => '共有コードをスキャン';

  @override
  String get notAShareCode => 'このコードはcat(a)logの共有ではありません。';

  @override
  String get importShareTitle => 'この猫を取り込みますか？';

  @override
  String shareSource(String url) {
    return '提供元: $url';
  }

  @override
  String get importLabel => 'インポート';

  @override
  String get strayAreaLabel => '想定される行動範囲';

  @override
  String get prevPin => '前のピン';

  @override
  String get nextPin => '次のピン';

  @override
  String get noMissingCats => 'チラシの位置が登録された迷子猫はまだいません。';

  @override
  String get noMatchCandidates => '現在、一致候補はありません。';

  @override
  String sameIdField(String field) {
    return '同じ$field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m 離れています';
  }

  @override
  String get addFlier => 'チラシを追加';

  @override
  String get missingSinceLabel => '行方不明になった日';

  @override
  String get phoneLabel => '電話';

  @override
  String get cropPortrait => '顔写真を切り抜く';

  @override
  String get statusOwner => '飼い主';

  @override
  String get ocrUnavailable => 'この端末では文字認識を利用できません。チラシの文章を手入力してください。';

  @override
  String get displayFormat => '表示形式';

  @override
  String get displayPlain => 'テキスト';

  @override
  String get displayQr => 'QRコード';

  @override
  String get displayBarcode => 'バーコード';

  @override
  String get editLabel => '編集';

  @override
  String get doneLabel => '完了';

  @override
  String get openSettings => '設定を開く';

  @override
  String get notSaved => '保存されませんでした';

  @override
  String get birthdateInFuture => '誕生日を未来の日付にはできません。';

  @override
  String get deceasedInFuture => '死亡日を未来の日付にはできません。';

  @override
  String deceasedBeforeBirth(String date) {
    return '死亡日を誕生日（$date）より前にはできません。';
  }

  @override
  String bornAfterDeceased(String date) {
    return '誕生日を死亡日（$date）より後にはできません。';
  }

  @override
  String get malePregnant => 'この猫はオスとして登録されています。オスは妊娠できません。まず性別を確認してください。';

  @override
  String fatherNotMale(String name) {
    return '$nameはメスとして登録されているため父親にはなれません。まず性別を確認してください。';
  }

  @override
  String motherNotFemale(String name) {
    return '$nameはオスとして登録されているため母親にはなれません。まず性別を確認してください。';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$nameの誕生日は$dateです。親が子より後に生まれることはできません。';
  }

  @override
  String get genderFatherFemale =>
      'この猫は他の猫の父親として登録されています。父親はメスにできません。まず家族を確認してください。';

  @override
  String get genderMotherMale =>
      'この猫は他の猫の母親として登録されています。母親はオスにできません。まず家族を確認してください。';

  @override
  String get moveTo => '移動先';

  @override
  String get noClowderStrayOption => 'クラウダーなし — 野良猫／逃走';

  @override
  String timelineOf(String name) {
    return '履歴 — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'この変更を取り消す';

  @override
  String get revertSubtitle => '以前の値を新しい記録として復元します — 履歴には両方残ります。';

  @override
  String fieldCleared(String field) {
    return '$field をクリアしました';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field を「$value」に戻しました';
  }

  @override
  String get leftStray => '去った — 野良猫';

  @override
  String movedTo(String name) {
    return '$name へ移動';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat が来ました';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat が $place から来ました';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat が $place へ行きました';
  }

  @override
  String get duplicateMergedIn => '重複レコードを統合しました';

  @override
  String get asOfToday => '今日付け';

  @override
  String asOfDate(String date) {
    return '$date 付け';
  }

  @override
  String dateFormatError(String format) {
    return '形式が正しくありません。$format の形式で入力してください';
  }

  @override
  String get value => '値';

  @override
  String get latitudeLongitude => '緯度、経度';

  @override
  String get newField => '新しい項目';

  @override
  String get fieldType => '種類';

  @override
  String get usedOn => '対象';

  @override
  String get forCats => '猫';

  @override
  String get forClowders => 'クラウダー';

  @override
  String get forBoth => '両方';

  @override
  String get optionsOnePerLine => '選択肢（1 行に 1 つ）';

  @override
  String get ownValue => '独自の値';

  @override
  String get renameField => '項目名を変更';

  @override
  String get editOptions => '選択肢を編集…';

  @override
  String get noStraysRightNow => '現在、野良猫はいません。';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => '野良猫を追加';

  @override
  String get newStray => '新しい野良猫';

  @override
  String get searchByNameHint => '名前で猫を検索…';

  @override
  String get host => 'ホスト';

  @override
  String get hostExplainer => 'ここから開始し、もう一方の端末でアドレスと PIN を入力してください。';

  @override
  String get startHosting => 'ホストを開始';

  @override
  String get stopHosting => 'ホストを停止';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return 'これまでのセッション: $count';
  }

  @override
  String get join => '参加';

  @override
  String get addressFromHost => 'アドレス（ホスト端末から）';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => '今すぐ同期';

  @override
  String get addressFormatHint => 'アドレスは 192.168.0.12:38472 の形式です';

  @override
  String syncedResult(String result) {
    return '同期完了: $result';
  }

  @override
  String syncFailed(String error) {
    return '同期に失敗: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return '$peer との最終同期: $time';
  }

  @override
  String get sharedFolder => '共有フォルダー';

  @override
  String get sharedFolderExplainer =>
      '両方の端末で同じフォルダーを使います（Dropbox や USB メモリなど）。同期のたびに自分の変更を置き、相手の変更を受け取ります。';

  @override
  String get noFolderChosenYet => 'フォルダー未選択';

  @override
  String get choose => '選択…';

  @override
  String get syncFolderNow => 'フォルダーを今すぐ同期';

  @override
  String folderSynced(String result) {
    return 'フォルダーを同期しました: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'フォルダー同期に失敗: $error';
  }

  @override
  String get recordSightingHere => 'ここで目撃を記録:';

  @override
  String trailOf(String name, int count) {
    return '経路: $name（目撃 $count 件）';
  }

  @override
  String conflictOn(String field) {
    return '競合 — $field';
  }

  @override
  String get conflictBody => '2 か所で同時に変更されました。正しい方を選んでください:';

  @override
  String mergeThisInto(String kind) {
    return 'この$kindの統合先…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return '統合できる他の$kindがありません。';
  }

  @override
  String mergeIntoQuestion(String name) {
    return '$name に統合しますか？';
  }

  @override
  String mergeBody(String name) {
    return '2 つのレコードが 1 つになります。$name は現在の値を保持し、もう一方の履歴が加わります。元に戻せません。';
  }

  @override
  String get kindCat => '猫';

  @override
  String get kindClowder => 'クラウダー';

  @override
  String get kindField => '項目';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get chooseFromGallery => 'ギャラリーから選ぶ';

  @override
  String get about => '情報';

  @override
  String get aboutTagline => '保護猫のためのローカルカタログ。データは端末に留まります — サーバーもアカウントも不要。';

  @override
  String versionLabel(String version, String build) {
    return 'バージョン $version ($build)';
  }

  @override
  String get sourceCode => 'ソースコード';

  @override
  String get reportProblemOrIdea => '問題やアイデアを報告';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => '開発者に連絡';

  @override
  String get buyCoffee => '開発者にコーヒーをおごる';

  @override
  String get coffeeSubtitle => '完全に任意です — アプリは無料';

  @override
  String get openSourceLicenses => 'オープンソースライセンス';

  @override
  String get machineTranslated => '翻訳は機械翻訳です — 修正は GitHub で歓迎します。';

  @override
  String get unnamed => '（名前なし）';

  @override
  String get labelName => '名前';

  @override
  String get labelProfileImage => 'プロフィール写真';

  @override
  String get labelPhoto => '写真';

  @override
  String get starterGender => '性別';

  @override
  String get starterBreed => '品種';

  @override
  String get valueMixed => '雑種';

  @override
  String get breedEuropeanShorthair => 'ヨーロピアンショートヘア';

  @override
  String get breedMaineCoon => 'メインクーン';

  @override
  String get breedBritishShorthair => 'ブリティッシュショートヘア';

  @override
  String get breedNorwegianForestCat => 'ノルウェージャンフォレストキャット';

  @override
  String get breedRagdoll => 'ラグドール';

  @override
  String get breedSiamese => 'シャム';

  @override
  String get breedPersian => 'ペルシャ';

  @override
  String get breedBengal => 'ベンガル';

  @override
  String get breedSphynx => 'スフィンクス';

  @override
  String get starterColor => '毛色';

  @override
  String get starterNeutered => '去勢・避妊済み';

  @override
  String get starterPregnant => '妊娠中';

  @override
  String get starterBirthdate => '誕生日';

  @override
  String get starterDeceased => '死亡';

  @override
  String get starterAddress => '住所';

  @override
  String get starterResponsible => '担当者';

  @override
  String get starterEmail => 'メール';

  @override
  String get starterPhone => '電話番号';

  @override
  String get lookupUrlLabel => '照会リンク';

  @override
  String lookupUrlHelp(String token) {
    return '番号の位置に $token を入れたサービスのページ。例：https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => '照会する';

  @override
  String lookupFailed(String url) {
    return '$url を開けるアプリがありません。リンクをブラウザに貼り付けてください。';
  }

  @override
  String get starterPosition => '位置';

  @override
  String get valueYes => 'はい';

  @override
  String get valueNo => 'いいえ';

  @override
  String get valueFemale => 'メス';

  @override
  String get valueMale => 'オス';

  @override
  String get valueUnknown => '不明';

  @override
  String get cropTitle => '写真をトリミング';

  @override
  String get markTitle => '猫に印を付ける';

  @override
  String get applyCrop => '切り抜く';

  @override
  String get useFullPhoto => '写真全体を使う';

  @override
  String get dragToSelect => '猫の周りに四角形をドラッグ';

  @override
  String get dragOverTheCat => '猫の上に楕円をドラッグ';

  @override
  String get cropPhoto => 'トリミング…';

  @override
  String get markPhoto => '印を付ける…';

  @override
  String get scanCode => 'コードをスキャン';

  @override
  String get orTypeCode => 'またはコードを入力';

  @override
  String get copyCode => 'コードをコピー';

  @override
  String get copied => 'コピーしました';

  @override
  String get invalidCode => 'このコードは無効です';

  @override
  String get hotspotHint =>
      '共通のWi-Fiがない場合は、片方のスマホのテザリングをオンにし、もう片方を接続してからここでホストしてください。';

  @override
  String get byMessenger => 'メッセンジャーで';

  @override
  String get byMessengerExplainer =>
      'カタログ全体を1つのファイルとしてWhatsApp・Signal・メールで送信 — 相手側が取り込みます。';

  @override
  String get shareBundle => '同期パッケージを共有…';

  @override
  String get importBundle => '同期パッケージを取り込む…';

  @override
  String bundleImported(String result) {
    return 'パッケージを取り込みました: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return '前回の自動バックアップに失敗しました: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return '取り込みに失敗: $error';
  }

  @override
  String get pickOnMap => '地図で選ぶ';

  @override
  String get useMyLocation => '現在地を使う';

  @override
  String get language => '言語';

  @override
  String get systemDefault => 'システムの既定';

  @override
  String get iosLocalNetworkHint =>
      'iPhone/iPad で失敗し続ける場合：設定 → プライバシーとセキュリティ → ローカルネットワーク → cat(a)log を許可して再試行してください。';

  @override
  String get markPrivate => 'プライベートに設定';

  @override
  String get unmarkPrivate => 'プライベート設定を解除';

  @override
  String get includePrivate => 'プライベートデータを含める';

  @override
  String get includePrivateExplainer =>
      'これをオンにすると、プライベートにした項目も送信されます。同期相手には見えるようになります。';

  @override
  String get hideLabel => 'この端末で非表示にする';

  @override
  String get unhideLabel => '再表示する';

  @override
  String get showHiddenLabel => '非表示の項目を表示';

  @override
  String get stopShowingHidden => '非表示の項目を隠す';

  @override
  String get starterSpecies => '種類';

  @override
  String get starterStatus => '種別';

  @override
  String get statusFoster => '預かり宅';

  @override
  String get statusForeverHome => '永遠のおうち';

  @override
  String get statusClinic => 'クリニック';

  @override
  String get statusShelter => '保護施設';

  @override
  String get statusBarn => '納屋';

  @override
  String get valueCat => '猫';

  @override
  String get otherOption => 'その他…';

  @override
  String get celebrationsToggle => '譲渡をお祝いする';

  @override
  String get celebrationsSubtitle => '猫が永遠のおうちに移るときに紙吹雪と歓声';

  @override
  String get onMapLabel => '地図上';

  @override
  String get showOnMap => '地図で表示';

  @override
  String get searchPlaceHint => '場所や住所を検索';

  @override
  String get noPlacesFound => '場所が見つかりません';

  @override
  String get mapSearchHint => '猫・グループ・人を検索';

  @override
  String get proposeAnotherName => '別の名前を提案';

  @override
  String get moderationTitle => '作成者とブロック';

  @override
  String get moderationSubtitle => 'ある人のデータを完全に削除';

  @override
  String get authorsSection => 'このカタログに書き込んだ人';

  @override
  String get hardDeleteAction => 'この作成者のすべてを削除';

  @override
  String hardDeleteWarning(Object name) {
    return '$name のすべての記録と写真をこの端末から削除します。他の端末には残ります。元に戻せません。';
  }

  @override
  String typeToConfirm(Object name) {
    return '確認のため $name と入力';
  }

  @override
  String get alsoBan => 'ブロックもする — 今後データを受け取らない';

  @override
  String get bansSection => 'ブロック';

  @override
  String get unbanAction => 'ブロック解除';

  @override
  String get deletedDone => '削除しました。';

  @override
  String get syncSummaryTitle => '届いた内容';

  @override
  String get summaryAdopted => '譲渡';

  @override
  String get summaryDeceased => '死亡';

  @override
  String get summaryEscaped => '脱走';

  @override
  String get summaryNew => '新規';

  @override
  String get summaryConflicts => '要解決の競合';

  @override
  String summaryOther(Object n) {
    return '…他 $n 件の変更';
  }

  @override
  String get starterMother => '母';

  @override
  String get starterFather => '父';

  @override
  String get familySection => '家族';

  @override
  String get littermatesLabel => '同腹の兄弟';

  @override
  String get siblingsLabel => '兄弟姉妹';

  @override
  String get kittensLabel => '子猫';

  @override
  String get toastSettingsTitle => 'お知らせする内容';

  @override
  String get toastSettingsSubtitle => '同期後の小さなお知らせ';

  @override
  String get toastKindAdoptions => '譲渡';

  @override
  String get toastKindBirths => '誕生';

  @override
  String get toastKindDeaths => '死亡';

  @override
  String get toastKindEscapes => '脱走';

  @override
  String get toastKindMoves => '引っ越し';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat が $home に譲渡されました 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ 新しい子猫: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat が亡くなりました';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat が脱走しました';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat が $home に引っ越しました';
  }

  @override
  String get notACatlogFile => 'cat(a)log のファイルではありません';

  @override
  String get nothingNewInBundle => '新しい内容はありません — すべて既にあります';

  @override
  String get syncChooserInPerson => '対面';

  @override
  String get syncChooserInPersonSub => '同じ部屋にいるとき — コードをスキャンして数秒で完了';

  @override
  String get syncChooserRemote => 'リモート';

  @override
  String get syncChooserRemoteSub => 'Dropbox や USB メモリなどの共有フォルダ経由';

  @override
  String get syncChooserMessenger => 'メッセンジャー';

  @override
  String get syncChooserMessengerSub =>
      '任意のメッセンジャーで全データを1ファイルとして送信 — 受け取った.catsyncファイルの取り込みもここから';

  @override
  String get connectToWifiFirst => 'まず Wi-Fi に接続してください — 端末同士が見つかります';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author（$device）が同期を求めています';
  }

  @override
  String get trustBothWaysNote => 'カタログは双方向で交換されます。';

  @override
  String get allowOnce => '許可';

  @override
  String get allowAlways => 'この端末を常に許可';

  @override
  String get declineAction => '拒否';

  @override
  String get syncDeclined => '相手の端末が同期を拒否しました';

  @override
  String get trustedDevicesSection => '常に許可された端末';

  @override
  String get removeTrust => '削除';

  @override
  String get hostWithoutWifi => 'Wi-Fi なしでホスト';

  @override
  String get hotspotJoinNote =>
      '相手の端末との一時的な直接接続を作ります（インターネットなし）。cat(a)log だけが使用し、同期後は自動的に切断されます。';

  @override
  String get hotspotAndroidOnly =>
      'このコードは Android 2台が必要です — iPhone/iPad では共有 Wi-Fi を使ってください';

  @override
  String get selectClowderHint => '左からグループを選択してください';

  @override
  String get introTitle1 => '猫たちを整理整頓';

  @override
  String get introBody1 =>
      '世話している猫ごとにカードを作りましょう：写真、性別、健康状態など、記録したいことは何でも。猫は住んでいる場所ごとにまとまります。アプリではその場所をクラウダー（clowder）と呼びます。';

  @override
  String get introTitle2 => 'ネットなしで動く';

  @override
  String get introBody2 =>
      'すべてはあなたのスマホだけに保存されます。アカウントもクラウドもありません。自分で共有しない限り、何もアップロードされません。';

  @override
  String get introTitle3 => 'みんなで使う';

  @override
  String get introBody3 =>
      'それぞれが自分のアプリを使い、ときどきデータを交換します。会ってコードをスキャンする、共有フォルダーを使う、メッセンジャーでファイルを1つ送る。そのあと全員が同じ情報を持ちます。';

  @override
  String get introSkip => 'スキップ';

  @override
  String get introNext => '次へ';

  @override
  String get introDone => 'はじめる';

  @override
  String get introReplayTitle => 'クイック紹介';

  @override
  String get spotHomeSync => 'ここで知り合いと同期します。何を共有するかはあなたが決めます。';

  @override
  String get spotHomeStrays => 'このカードには野良猫（家のない猫）が集まります。タップで一覧を表示。';

  @override
  String get spotHomeMenu => 'このメニューでは：重複の検索と統合、CSVエクスポートなど。';

  @override
  String get spotCatEdit => '鉛筆をタップして編集。ヒント：項目を長押しすると直接編集できます。';

  @override
  String get spotMapLayers => '迷子猫を探していますか？チラシがあった場所と、元いた家の周りに円を表示できます。';

  @override
  String get spotStraysFlier => '迷子猫のチラシを見つけたら、ここで撮影。猫と連絡先をアプリが保存します。';

  @override
  String get spotStraysScan => 'cat(a)log のQRコード付きチラシは、ここでスキャンすれば入力なしで取り込めます。';

  @override
  String get introTitle4 => '迷子猫を探す';

  @override
  String get introBody4 =>
      '迷子猫のチラシを見つけたら、アプリで撮影を。猫、飼い主の連絡先、場所が保存されます。後で似た野良猫が現れたら、アプリが候補を提案します。';

  @override
  String get spotMapSearch => '猫・場所・人を入力すると、地図上のその場所へジャンプします。';

  @override
  String get spotCardChips => '共有カードに載せる項目にチェックを。それ以外は載りません。';

  @override
  String get spotCatMenu => 'その他の操作はここ：プライベット設定、非表示、重複の統合、目撃の記録。';

  @override
  String get spotDone => 'OK';

  @override
  String get spotReplayTitle => '新機能ツアー';

  @override
  String get spotReplaySubtitle => '各ページでヒントを再表示';

  @override
  String get spotReplayDone => 'ヒントを再表示します';

  @override
  String get searchNoResults => 'その名前の猫は見つかりません';

  @override
  String get syncUnreachable => '相手の端末に接続できません。両方とも同じ Wi-Fi ですか？';

  @override
  String get folderUnreachable => 'フォルダにアクセスできません。ドライブやクラウドフォルダはまだありますか？';

  @override
  String get crashTitle => 'これは起きてはいけないことでした';

  @override
  String get crashBody =>
      'cat(a)log で予期しないエラーが発生しました。データは安全です — 変更した瞬間に保存されています。アプリを再起動し、繰り返す場合はレポートを送信してください。修正に役立ちます。';

  @override
  String get crashRestart => 'アプリを再起動';

  @override
  String get crashSendReport => '開発者にレポートを送信';

  @override
  String get crashLastRunBody =>
      '前回 cat(a)log が予期せず停止しました — おそらくメモリ不足です。修正のため簡単なレポートを送信しますか？';
}
