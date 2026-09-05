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
  String get clowdersNeutral => '世帯';

  @override
  String get noClowdersYet =>
      'まだグループがありません。グループとは猫が暮らす場所 — 預かり宅や里親の部屋。下から最初のグループを作りましょう。';

  @override
  String get noClowdersYetNeutral =>
      'まだ世帯がありません。世帯とはペットが暮らす場所 — 自宅、預かり宅、里親の部屋。下から最初の世帯を作りましょう。';

  @override
  String get strays => '野良猫';

  @override
  String get searchCats => '猫を検索';

  @override
  String get searchCatsNeutral => 'ペットを検索';

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
  String get settings => '設定';

  @override
  String get newClowder => '新しいクラウダー';

  @override
  String get newClowderNeutral => '新しい世帯';

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
  String get renameClowderNeutral => '世帯名を変更';

  @override
  String get rename => '名前を変更';

  @override
  String get timeline => '履歴';

  @override
  String get mergeInto => '統合先を選ぶ…';

  @override
  String get deleteClowder => 'クラウダーを削除';

  @override
  String get deleteClowderNeutral => '世帯を削除';

  @override
  String get cats => '猫';

  @override
  String get catsNeutral => 'ペット';

  @override
  String get addCat => '猫を追加';

  @override
  String get addCatNeutral => 'ペットを追加';

  @override
  String get newCat => '新しい猫';

  @override
  String get newCatNeutral => '新しいペット';

  @override
  String deleteQuestion(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get deleteClowderEmptyBody => 'クラウダーは一覧から消えます。';

  @override
  String get deleteClowderEmptyBodyNeutral => '世帯は一覧から消えます。';

  @override
  String deleteClowderBody(int count) {
    return '所属する $count 匹の猫は削除されず、野良猫になります。望まない場合は先に別のクラウダーへ移してください。';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return '所属する $count 匹のペットは削除されず、野良になります。望まない場合は先に別の世帯へ移してください。';
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
  String get renameCatNeutral => 'ペットの名前を変更';

  @override
  String get seenHereNow => '今ここで目撃';

  @override
  String get deleteCat => '猫を削除';

  @override
  String get deleteCatNeutral => 'ペットを削除';

  @override
  String get clowderLabel => 'クラウダー';

  @override
  String get clowderLabelNeutral => '世帯';

  @override
  String get strayNoClowder => '野良猫 — クラウダーなし';

  @override
  String get strayNoClowderNeutral => '野良 — 世帯なし';

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
  String get deleteCatBodyNeutral =>
      'このペットはすべての一覧から消え、写真も削除されます。この端末だけでなく、次回の同期後には他の端末からも消えます。';

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
  String get chipScanHintNeutral =>
      'チップカードや獣医の書類に印刷されたQR/バーコードを読み取ります。動物の体内のチップは電話では読めません。';

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
  String get viewAsList => 'リストで表示';

  @override
  String get ageLabel => '年齢';

  @override
  String get catList => '猫リスト';

  @override
  String get catListNeutral => 'ペットリスト';

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
  String get importShareTitleNeutral => 'このペットを取り込みますか？';

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
  String get noMissingCatsNeutral => 'チラシの位置が登録された迷子ペットはまだいません。';

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
  String get malePregnantNeutral =>
      'このペットはオスとして登録されています。オスは妊娠できません。まず性別を確認してください。';

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
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$nameの誕生日は$dateです。親が子より後に生まれることはできません。';
  }

  @override
  String get genderFatherFemale =>
      'この猫は他の猫の父親として登録されています。父親はメスにできません。まず家族を確認してください。';

  @override
  String get genderFatherFemaleNeutral =>
      'このペットは他のペットの父親として登録されています。父親はメスにできません。まず家族を確認してください。';

  @override
  String get genderMotherMale =>
      'この猫は他の猫の母親として登録されています。母親はオスにできません。まず家族を確認してください。';

  @override
  String get genderMotherMaleNeutral =>
      'このペットは他のペットの母親として登録されています。母親はオスにできません。まず家族を確認してください。';

  @override
  String get moveTo => '移動先';

  @override
  String get noClowderStrayOption => 'クラウダーなし — 野良猫／逃走';

  @override
  String get noClowderStrayOptionNeutral => '世帯なし — 野良／逃走';

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
  String get dateInFuture => 'この日付は未来にはできません。';

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
  String get forCatsNeutral => 'ペット';

  @override
  String get forClowders => 'クラウダー';

  @override
  String get forClowdersNeutral => '世帯';

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
  String get searchByNameHintNeutral => '名前でペットを検索…';

  @override
  String get host => 'ホスト';

  @override
  String get hostExplainer => 'ここから開始し、もう一方の端末でコードをスキャンするか入力してください。';

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
  String trailOfField(String name, String field, int count) {
    return '経路: $name — $field（$count 件）';
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
  String get kindCatNeutral => 'ペット';

  @override
  String get kindClowder => 'クラウダー';

  @override
  String get kindClowderNeutral => '世帯';

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
  String get aboutTaglineNeutral =>
      'お世話しているペットのためのローカルカタログ。データは端末に留まります — サーバーもアカウントも不要。';

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
  String get coffeeSubtitle => 'アプリはずっと無料です。コーヒーをもらえなくても :)';

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
  String get stepCat => '猫';

  @override
  String get stepCatNeutral => 'ペット';

  @override
  String get stepOwner => '飼い主';

  @override
  String get stepFace => '顔写真';

  @override
  String get stepRegistry => '登録サービス';

  @override
  String get stepReview => '確認して保存';

  @override
  String get stepOwnerHint => '猫を探している人。ここからその人のクラウダーができます（チラシの連絡先つき）。';

  @override
  String get stepOwnerHintNeutral => 'ペットを探している人。ここからその人の世帯ができます（チラシの連絡先つき）。';

  @override
  String get stepFaceHint => 'チラシから猫の顔を切り抜くとプロフィール写真になります。省略もできます。';

  @override
  String get stepFaceHintNeutral => 'チラシからペットの顔を切り抜くとプロフィール写真になります。省略もできます。';

  @override
  String get stepRegistryHint => 'チラシで見つかった番号。チェックしたものは猫に保存され、あとで開けます。';

  @override
  String get stepRegistryHintNeutral =>
      'チラシで見つかった番号。チェックしたものはペットに保存され、あとで開けます。';

  @override
  String get noRegistryLinks => 'このチラシに登録サービスのリンクはありません。見落としがあればバグとして報告してください。';

  @override
  String get unknownServiceHint => '不明なサービス';

  @override
  String get rememberService => 'サービスを覚える';

  @override
  String get rememberServiceHint =>
      'サービスに名前を付け、リンクの中の番号を指定してください。次のチラシは自動で入ります。';

  @override
  String get noIdInLink => 'このリンクには保存できる番号がありません。';

  @override
  String get whichNumber => 'どの部分が番号ですか？';

  @override
  String get cropAgain => '切り抜き直す';

  @override
  String get noFaceYet => '顔写真はまだありません。チラシの写真を使います。';

  @override
  String get backLabel => '戻る';

  @override
  String get dangerButton => 'おさないで。\nきけん';

  @override
  String get dangerThanks => 'cat(a)log をお使いいただきありがとうございます！';

  @override
  String get helpTitle => 'ヘルプ';

  @override
  String get showTipsAgain => 'ヒントをもう一度表示';

  @override
  String get helpHome =>
      'コロニーの一覧です。コロニーとは猫が暮らす場所のこと（自宅、預かり先、保護施設など）。カードをタップするとその猫が見えます。長押しでメニュー。右下のボタンで新しいコロニーを作成、野良カードには家のない猫がすべて集まります。 上の名前はいま開いているカタログです。タップすると切り替えや追加ができます。';

  @override
  String get helpHomeNeutral =>
      '世帯の一覧です。世帯とはペットが暮らす場所のこと（自宅、預かり先、保護施設など）。カードをタップするとそのペットが見えます。長押しでメニュー。右下のボタンで新しい世帯を作成、野良カードには家のないペットがすべて集まります。 上の名前はいま開いているカタログです。タップすると切り替えや追加ができます。';

  @override
  String get helpClowder =>
      'この場所のすべて：猫、項目（住所・連絡先・種別）、履歴。最初は閲覧のみで、鉛筆で編集に切り替わり、そこで項目の追加もできます。項目を長押しすると直接編集、猫を長押しすると移動・非表示・表示ができます。 ここで追加する予定にはコロニーの複数の猫を含められます（例：去勢・避妊の通院）。一緒に行く猫にチェックを入れ、一度で完了し、処置されなかった猫のチェックを外します。項目の時計アイコンで履歴が開きます。';

  @override
  String get helpClowderNeutral =>
      'この場所のすべて：ペット、項目（住所・連絡先・種別）、履歴。最初は閲覧のみで、鉛筆で編集に切り替わり、そこで項目の追加もできます。項目を長押しすると直接編集、ペットを長押しすると移動・非表示・表示ができます。 ここで追加する予定には世帯の複数のペットを含められます（例：去勢・避妊の通院）。一緒に行くペットにチェックを入れ、一度で完了し、処置されなかったペットのチェックを外します。項目の時計アイコンで履歴が開きます。';

  @override
  String get helpCat =>
      'この猫のすべて: 写真、フィールド、家族、履歴。鉛筆をタップするまでページは読み取り専用です。フィールドを長押しするとすぐ編集できます。写真を長押しするとそのメニューが開きます。右上のメニューに残りがあります: 非表示、統合、目撃の記録、猫の共有。「プライベート」はフィールド編集時に設定します。項目の時計アイコンで履歴が開きます。';

  @override
  String get helpCatNeutral =>
      'このペットのすべて: 写真、フィールド、家族、履歴。鉛筆をタップするまでページは読み取り専用です。フィールドを長押しするとすぐ編集できます。写真を長押しするとそのメニューが開きます。右上のメニューに残りがあります: 非表示、統合、目撃の記録、ペットの共有。「プライベート」はフィールド編集時に設定します。項目の時計アイコンで履歴が開きます。';

  @override
  String get helpStrays =>
      'いま家のない猫：保護した猫、脱走した猫、チラシから登録した猫。カメラボタンは目の前の猫を記録、チラシボタンは迷子チラシを飼い主の連絡先つきの猫に変換、スキャナーはチラシの cat(a)log コードを読み取ります。 Stray Cam をタップすると写真、長押しすると動画を撮影し、良いフレームを写真として残せます。';

  @override
  String get helpStraysNeutral =>
      'いま家のないペット：保護した動物、脱走した動物、チラシから登録した動物。カメラボタンは目の前の動物を記録、チラシボタンは迷子チラシを飼い主の連絡先つきのペットに変換、スキャナーはチラシの cat(a)log コードを読み取ります。 Stray Cam をタップすると写真、長押しすると動画を撮影し、良いフレームを写真として残せます。';

  @override
  String get helpMap =>
      '位置がある猫と場所すべて。検索は猫・人・地名に対応し、知らない名前は世界中から探します。レイヤーボタンは迷子猫のチラシ地点と元いた家の周囲に500mの円を描きます。矢印はピンからピンへ移動、地図の長押しで目撃を記録します。すべての場所項目は地図上にピンで表示されます。ピンをタップすると経路が見られます。';

  @override
  String get helpMapNeutral =>
      '位置があるペットと場所すべて。検索はペット・人・地名に対応し、知らない名前は世界中から探します。レイヤーボタンは迷子ペットのチラシ地点と元いた家の周囲に500mの円を描きます。矢印はピンからピンへ移動、地図の長押しで目撃を記録します。すべての場所項目は地図上にピンで表示されます。ピンをタップすると経路が見られます。';

  @override
  String get helpCard =>
      'この猫の印刷用カード：上部のチップで載せる内容を選び、画像か PDF で共有します。番号は QR かバーコードで印刷でき、位置は地図を開く QR と短い Plus Code になります。';

  @override
  String get helpCardNeutral =>
      'このペットの印刷用カード：上部のチップで載せる内容を選び、画像か PDF で共有します。番号は QR かバーコードで印刷でき、位置は地図を開く QR と短い Plus Code になります。';

  @override
  String get helpSync =>
      'データを他の人に渡す方法：直接つなぐ、両方の端末が見えるフォルダーを使う、メッセンジャーでファイルを送る。何を送るかは常にあなたが決めます。受け取った .catsync ファイルもここで開きます。';

  @override
  String get helpFields =>
      'カタログが使う項目です。名前の変更、選択項目の選択肢の変更、独自項目の追加ができます。ID 項目はサービス（登録機関）を指定でき、その番号は猫のページでタップできるようになります。';

  @override
  String get helpFieldsNeutral =>
      'カタログが使う項目です。名前の変更、選択項目の選択肢の変更、独自項目の追加ができます。ID 項目はサービス（登録機関）を指定でき、その番号はペットのページでタップできるようになります。';

  @override
  String get helpTimeline =>
      'これまでのすべての変更（新しい順）：誰が・いつ・何を・どの値に変えたか。どの記録も取り消せます。取り消しは新しい記録として書かれ、消えるものはありません。';

  @override
  String get helpDuplicates =>
      '同じものが二重に見える猫やコロニー：同一の番号、または詳細が一致するよく似た名前。ペアをタップすると統合します。統合は取り消せないため、先に確認します。';

  @override
  String get helpDuplicatesNeutral =>
      '同じものが二重に見えるペットや世帯：同一の番号、または詳細が一致するよく似た名前。ペアをタップすると統合します。統合は取り消せないため、先に確認します。';

  @override
  String get helpMatches =>
      '同じ個体かもしれない猫：番号が同じ、または迷子猫の捜索範囲内で見つかった野良猫。ペアをタップで統合、長押しで最初の猫を開いて見比べられます。';

  @override
  String get helpMatchesNeutral =>
      '同じ個体かもしれないペット：番号が同じ、または迷子ペットの捜索範囲内で見つかった野良。ペアをタップで統合、長押しで最初のペットを開いて見比べられます。';

  @override
  String get helpFlier =>
      '撮影したチラシから猫と飼い主ができます。手順：猫のデータ、飼い主の連絡先、プロフィール写真用の顔の切り抜き、チラシの登録番号、最後に確認。すべて提案なので、カメラの読み違いは直してください。';

  @override
  String get helpFlierNeutral =>
      '撮影したチラシからペットと飼い主ができます。手順：ペットのデータ、飼い主の連絡先、プロフィール写真用の顔の切り抜き、チラシの登録番号、最後に確認。すべて提案なので、カメラの読み違いは直してください。';

  @override
  String get archiveTitle => 'アーカイブ';

  @override
  String get archiveExplainer =>
      '何年も触れられていない亡くなった猫や空のコロニーも容量を使います。とくに写真です。アーカイブは、それらを手元に残すファイルへ書き出してから、ここから削除します。';

  @override
  String get archiveExplainerNeutral =>
      '何年も触れられていない亡くなったペットや空の世帯も容量を使います。とくに写真です。アーカイブは、それらを手元に残すファイルへ書き出してから、ここから削除します。';

  @override
  String get archiveAction => 'アーカイブ';

  @override
  String archiveSelected(int count) {
    return '$count 件をアーカイブ';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '$count 件をアーカイブしますか？';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names をファイルに書き出したあと削除します。あなたの端末でも、同期しているすべての端末でも消えます。ファイルを取り込めば元に戻せますが、なければ戻せません。';
  }

  @override
  String archiveDone(int count) {
    return '$count 件をアーカイブして削除しました';
  }

  @override
  String archiveFailed(String error) {
    return '何も削除していません：アーカイブファイルを書き出せませんでした（$error）。';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'データベース $db、写真 $photos／$count ファイル';
  }

  @override
  String quietForYears(int years) {
    return '$years 年間変更なし';
  }

  @override
  String get nothingToArchive => 'アーカイブできるほど古いものはありません。';

  @override
  String archiveCandidateLine(String date, String size) {
    return '最終変更 $date・写真 $size';
  }

  @override
  String get helpArchive =>
      '古いデータは容量を使います。とくに、同期する端末すべてが持ち歩く写真です。ここでは何年も動きのない亡くなった猫や空のコロニーを選び、手元に残すファイルへ書き出してから削除します。削除は同期相手全員に伝わります。ファイルを取り込めばすべて復元できます。';

  @override
  String get helpArchiveNeutral =>
      '古いデータは容量を使います。とくに、同期する端末すべてが持ち歩く写真です。ここでは何年も動きのない亡くなったペットや空の世帯を選び、手元に残すファイルへ書き出してから削除します。削除は同期相手全員に伝わります。ファイルを取り込めばすべて復元できます。';

  @override
  String restoreDeletedTitle(int count) {
    return '削除済みの $count 件を復元しますか？';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names はこのカタログで削除済みですが、いま取り込んだファイルに含まれています。復元すると、この端末でも同期先のすべての端末でも元に戻ります。';
  }

  @override
  String get restoreAction => '復元';

  @override
  String get keepDeleted => '削除のままにする';

  @override
  String get archiveNotSaved => '何も削除していません：アーカイブはどこにも保存されませんでした。';

  @override
  String get locateAddress => '住所を地図で探す';

  @override
  String get addressFoundTitle => '住所が見つかりました';

  @override
  String get replaceAddressOption => '住所をこれに置き換える';

  @override
  String get addPositionOption => '位置を保存する';

  @override
  String get addressLocated => '住所が見つかりました';

  @override
  String get addressNotFound => 'この住所の場所が見つかりません。つづりを確認するか、空のままにしてください。';

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
  String get markTitleNeutral => 'ペットに印を付ける';

  @override
  String get applyCrop => '切り抜く';

  @override
  String get useFullPhoto => '写真全体を使う';

  @override
  String get dragToSelect => '猫の周りに四角形をドラッグ';

  @override
  String get dragToSelectNeutral => 'ペットの周りに四角形をドラッグ';

  @override
  String get dragOverTheCat => '猫の上に楕円をドラッグ';

  @override
  String get dragOverTheCatNeutral => 'ペットの上に楕円をドラッグ';

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
  String get typeUnitValue => '単位付きの値';

  @override
  String get dimension => '種類';

  @override
  String get dimensionWeight => '体重';

  @override
  String get dimensionLength => '長さ';

  @override
  String get dimensionVolume => '容量';

  @override
  String get dimensionTemperature => '体温';

  @override
  String get unitsLabel => '単位';

  @override
  String get catalogHolds => 'このカタログの対象';

  @override
  String get modeCats => '猫';

  @override
  String get modePets => 'ペット';

  @override
  String get graphLabel => 'グラフ';

  @override
  String get fieldHistoryTooltip => '履歴';

  @override
  String get rangeWeek => '週';

  @override
  String get rangeMonth => '月';

  @override
  String get rangeYear => '年';

  @override
  String get rangeAll => 'すべて';

  @override
  String get rangeCustom => 'カスタム…';

  @override
  String changeSince(String delta, String date) {
    return '$date から $delta';
  }

  @override
  String get unitsAuto => '地域に合わせる';

  @override
  String get unitsMetric => 'メートル法（kg、cm、ml、°C）';

  @override
  String get unitsImperial => 'ヤード・ポンド法（lb、in、fl oz、°F）';

  @override
  String get starterWeight => '体重';

  @override
  String get systemDefault => 'システムの既定';

  @override
  String get iosLocalNetworkHint =>
      'iPhone/iPad で失敗し続ける場合：設定 → プライバシーとセキュリティ → ローカルネットワーク → cat(a)log を許可して再試行してください。';

  @override
  String get includePrivate => 'プライベートデータを共有';

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
  String get statusForeverHome => 'おうち';

  @override
  String get statusClinic => 'クリニック';

  @override
  String get statusShelter => '保護施設';

  @override
  String get statusBarn => '納屋';

  @override
  String get valueCat => '猫';

  @override
  String get valueDog => '犬';

  @override
  String get valueRabbit => 'ウサギ';

  @override
  String get valueGuineaPig => 'モルモット';

  @override
  String get valueHamster => 'ハムスター';

  @override
  String get valueBird => '鳥';

  @override
  String get valueHorse => '馬';

  @override
  String get valueTortoise => 'カメ';

  @override
  String get valueFerret => 'フェレット';

  @override
  String get otherOption => 'その他…';

  @override
  String get celebrationsToggle => '譲渡をお祝いする';

  @override
  String get celebrationsSubtitle => '猫がおうちに移るときに紙吹雪と歓声';

  @override
  String get celebrationsSubtitleNeutral => 'ペットがおうちに移るときに紙吹雪と歓声';

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
  String get mapSearchHintNeutral => 'ペット・世帯・人を検索';

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
  String conflictsMenu(int n) {
    return '競合 ($n)';
  }

  @override
  String get rejectAfterResolve => 'ここで競合を解決したため「拒否」は使えません。解決も取り消されてしまうからです。';

  @override
  String get arrivalIntro => 'これらの変更はすでにカタログに入っています。「拒否」で元の状態に戻します。';

  @override
  String get summaryUpdated => '更新';

  @override
  String get summaryDeleted => '削除';

  @override
  String get keepMine => '自分のを保持';

  @override
  String keptMine(String name) {
    return '$name はこの端末ではあなたの版を保持しました。';
  }

  @override
  String get summaryMeta => 'その他の到着';

  @override
  String changesCount(int n) {
    return '$n件の変更';
  }

  @override
  String get acceptArrival => '受け入れる';

  @override
  String get rejectArrival => '拒否';

  @override
  String get photoAdded => '写真が追加されました';

  @override
  String get photoRemoved => '写真が削除されました';

  @override
  String metaFieldAdded(String name) {
    return '新しい項目: $name';
  }

  @override
  String metaFieldChanged(String name) {
    return '項目が変更されました: $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser を $survivor に統合';
  }

  @override
  String metaPhotos(int n) {
    return '$n枚の写真';
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
  String get kittensLabelNeutral => '子ども';

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
  String toastBornNeutral(Object cat) {
    return '✨ 新しい子ども: $cat ✨';
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
  String get syncChooserInPersonSub => 'Wi-Fiで同期';

  @override
  String get syncChooserRemote => 'リモート';

  @override
  String get syncChooserRemoteSub => 'フォルダーまたはUSBメモリで同期';

  @override
  String get syncChooserMessenger => 'メッセンジャー';

  @override
  String get syncChooserMessengerSub => 'SNSでエクスポート・インポート';

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
  String get selectClowderHintNeutral => '左から世帯を選択してください';

  @override
  String get introTitle1 => '猫たちを整理整頓';

  @override
  String get introTitle1Neutral => 'ペットたちを整理整頓';

  @override
  String get introBody1 =>
      '世話している猫ごとにカードを作りましょう：写真、性別、健康状態など、記録したいことは何でも。猫は住んでいる場所ごとにまとまります。アプリではその場所をクラウダー（clowder）と呼びます。';

  @override
  String get introBody1Neutral =>
      'お世話しているペットごとにカードを作りましょう：写真、性別、健康状態など、記録したいことは何でも。ペットは住んでいる場所ごとにまとまります。アプリではその場所を世帯と呼びます。';

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
  String get spotHomeStraysNeutral => 'このカードには野良（家のないペット）が集まります。タップで一覧を表示。';

  @override
  String get spotHomeMenu => 'このメニューには設定、重複の検出と統合、CSV書き出しなどがあります。';

  @override
  String get spotCatEdit => '鉛筆をタップして編集。ヒント：項目を長押しすると直接編集できます。';

  @override
  String get spotCatEditNeutral => '鉛筆をタップして編集。ヒント：項目を長押しすると直接編集できます。';

  @override
  String get spotMapLayers => '迷子猫を探していますか？チラシがあった場所と、元いた家の周りに円を表示できます。';

  @override
  String get spotMapLayersNeutral =>
      '迷子ペットを探していますか？チラシがあった場所と、元いた家の周りに円を表示できます。';

  @override
  String get spotStraysFlier => '迷子猫のチラシを見つけたら、ここで撮影。猫と連絡先をアプリが保存します。';

  @override
  String get spotStraysFlierNeutral =>
      '迷子ペットのチラシを見つけたら、ここで撮影。ペットと連絡先をアプリが保存します。';

  @override
  String get spotStraysScan => 'cat(a)log のQRコード付きチラシは、ここでスキャンすれば入力なしで取り込めます。';

  @override
  String get spotStraysScanNeutral =>
      'cat(a)log のQRコード付きチラシは、ここでスキャンすれば入力なしでペットを取り込めます。';

  @override
  String get introTitle4 => '迷子猫を探す';

  @override
  String get introTitle4Neutral => '迷子ペットを探す';

  @override
  String get introBody4 =>
      '迷子猫のチラシを見つけたら、アプリで撮影を。猫、飼い主の連絡先、場所が保存されます。後で似た野良猫が現れたら、アプリが候補を提案します。';

  @override
  String get introBody4Neutral =>
      '迷子ペットのチラシを見つけたら、アプリで撮影を。ペット、飼い主の連絡先、場所が保存されます。後で似た野良が現れたら、アプリが候補を提案します。';

  @override
  String get spotMapSearch => '猫・場所・人を入力すると、地図上のその場所へジャンプします。';

  @override
  String get spotMapSearchNeutral => 'ペット・場所・人を入力すると、地図上のその場所へジャンプします。';

  @override
  String get spotCardChips => '共有カードに載せる項目にチェックを。それ以外は載りません。';

  @override
  String get spotCatMenu => 'ここには他の操作があります: 猫を非表示、重複を統合、目撃を記録。';

  @override
  String get spotCatMenuNeutral => 'ここには他の操作があります: ペットを非表示、重複を統合、目撃を記録。';

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
  String get searchNoResultsNeutral => 'その名前のペットは見つかりません';

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

  @override
  String get catalogsTitle => 'カタログ';

  @override
  String get newCatalog => '新しいカタログ';

  @override
  String get intoCatalog => 'カタログへ';

  @override
  String get catalogNameLabel => 'カタログ名';

  @override
  String catalogNameTaken(String name) {
    return '$name という名前のカタログはすでにあります。別の名前を選んでください。';
  }

  @override
  String get manageCatalogs => 'カタログの管理';

  @override
  String get helpCatalogs =>
      'カタログはそれぞれ独立した世界です。猫、コロニー、項目、写真、同期相手はすべて固有のもので、ベルリンとパリが混ざることはありません。カタログをタップすると切り替わります。カタログの歯車を押すとその設定が開きます：名前、猫かペットか、項目、作成者とブロック、アーカイブ、戻る、削除。あなたの名前、言語、すでに見たヒントはすべてのカタログで共通です。';

  @override
  String get helpCatalogsNeutral =>
      'カタログはそれぞれ独立した世界です。ペット、世帯、項目、写真、同期相手はすべて固有のもので、ベルリンとパリが混ざることはありません。カタログをタップすると切り替わります。カタログの歯車を押すとその設定が開きます：名前、猫かペットか、項目、作成者とブロック、アーカイブ、戻る、削除。あなたの名前、言語、すでに見たヒントはすべてのカタログで共通です。';

  @override
  String get helpCatalogSettings =>
      'このカタログだけに属するもの：名前、猫かペットか、項目、作成者とブロック、アーカイブ、時間を戻す。ここでの変更はこのカタログだけに及びます。今開いていないカタログでも同じです。削除の前にカタログはファイルに書き出されます。';

  @override
  String get spotHomeCatalog => 'いま開いているカタログです。名前をタップすると切り替えや新規作成ができます。';

  @override
  String get deleteCatalog => 'カタログを削除';

  @override
  String get catalogSettings => 'カタログの設定';

  @override
  String deleteCatalogBody(String name) {
    return '$name の中身はすべて消えます。猫も写真も履歴もです。先に完全なファイルが自動バックアップと同じ場所に保存され、それを読み込めばカタログは戻ります。確認のため表示された言葉を入力してください。';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return '$name の中身はすべて消えます。ペットも写真も履歴もです。先に完全なファイルが自動バックアップと同じ場所に保存され、それを読み込めばカタログは戻ります。確認のため名前を入力してください。';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name を削除しました。ファイルは $where にあります。';
  }

  @override
  String typeTheName(String name) {
    return '$name と入力';
  }

  @override
  String catalogExportFailed(String error) {
    return '何も削除していません。カタログのファイルを書き出せませんでした（$error）。空き容量を作るか、時間をおいてやり直してください。';
  }

  @override
  String get moveToCatalog => '別のカタログへ移動';

  @override
  String movedToCatalog(int count, String name) {
    return '$count 件を $name に移動しました';
  }

  @override
  String get chooseWhatToMove => '何を移動しますか？';

  @override
  String moveIntoNewCatalog(String name) {
    return '$name に何か移動しますか？';
  }

  @override
  String get undoThisImport => 'この読み込みを取り消す';

  @override
  String undoImportBody(int count) {
    return 'この読み込みで入った $count 件の変更を取り除きます。先にファイルへ書き出すので、それを読み込めば戻せます。すでに同期した相手の手元には残ります。取り消せません。';
  }

  @override
  String undoneImport(String where) {
    return '取り消しました。ファイルは $where にあります。';
  }

  @override
  String get goBackTitle => '前の状態に戻す';

  @override
  String get goBackToHere => 'ここに戻す';

  @override
  String get momentImport => '読み込みの前';

  @override
  String get momentSync => '同期の前';

  @override
  String get momentMerge => '統合の前';

  @override
  String get momentHardDelete => 'ある記録者のデータを削除する前';

  @override
  String get momentArchive => 'アーカイブの前';

  @override
  String get momentManual => '自分で付けた印';

  @override
  String get showOlderMoments => '古いものを表示';

  @override
  String goBackBody(int count) {
    return 'この時点より後はすべて取り除かれます（$count 件）。先にファイルへ書き出すので読み込めば戻せますが、これより新しい時点も一緒に消えます。すでに同期した相手の手元には残り、取り消せません。';
  }

  @override
  String get nameThisMoment => 'この時点に名前をつける';

  @override
  String get helpGoBack =>
      'このカタログが大きく変わった時点の一覧です。読み込みや同期の前、統合・アーカイブ・削除の前、そして自分で印を付けたときに記録されます。ひとつ選ぶとカタログはその状態に戻ります。それ以降はすべて手元に残るファイルに書き出してから取り除かれ、それより新しい時点も一緒に消えます。すでに同期した相手は受け取ったものを持ち続けます。';

  @override
  String goBackFileFailed(String error) {
    return '何も取り除いていません。控えのファイルを書き出せませんでした（$error）。空き容量を作ってやり直してください。';
  }

  @override
  String get goBackChanged => '何も削除されませんでした：ファイルの保存中にカタログが変更されました。もう一度お試しください。';

  @override
  String get switchBeforeDeleting => 'いま開いているカタログです。別のカタログに切り替えてから削除してください。';

  @override
  String shareFileFailed(String error) {
    return '共有ファイルを書き出せませんでした（$error）。空き容量を作ってやり直してください。';
  }

  @override
  String get privateLabel => 'プライベート';

  @override
  String sharedCatalogIs(String name) {
    return 'カタログ: $name';
  }

  @override
  String get markPrivate => 'プライベートに設定';

  @override
  String get unmarkPrivate => 'プライベート設定を解除';

  @override
  String get agenda => '予定表';

  @override
  String get reminderLabel => 'リマインダー';

  @override
  String get agendaEmpty => '計画した予定はありません。ここのプラス、または猫やクラウダーのページで新しい予定を計画できます。';

  @override
  String get agendaEmptyNeutral =>
      '計画した予定はありません。ここのプラス、またはペットや世帯のページで新しい予定を計画できます。';

  @override
  String get dueToday => '今日';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日後',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日超過',
    );
    return '$_temp0';
  }

  @override
  String get markDone => '完了';

  @override
  String get repeatTitle => '次回は…';

  @override
  String get noRepeatLabel => '繰り返さない';

  @override
  String get unitDays => '日後';

  @override
  String get unitWeeks => '週間後';

  @override
  String get unitMonths => 'か月後';

  @override
  String get unitYears => '年後';

  @override
  String ageYears(int years) {
    return '$years歳';
  }

  @override
  String ageMonths(int months) {
    return '$monthsか月';
  }

  @override
  String get changeDateLabel => '日付を変更';

  @override
  String get removeReminderLabel => 'リマインダーを削除';

  @override
  String get exportIcs => 'カレンダーファイルを書き出す';

  @override
  String get resyncCalendar => 'カレンダーを再同期';

  @override
  String icsSavedTo(String path) {
    return 'カレンダーファイルを $path に保存しました';
  }

  @override
  String get calendarMirrorLabel => '端末のカレンダーへ反映';

  @override
  String get calendarMirrorSubtitle =>
      '予定はカレンダーに終日の予定として表示されます。cat(a)log は起動のたび、また変更のたびにカレンダー側を更新します。予定の通知はカレンダーで管理できます。';

  @override
  String get syncPeerOlder =>
      '相手の端末はリマインダーのない古い cat(a)log です。そちらで cat(a)log を更新して、もう一度同期してください。';

  @override
  String get syncPeerNewer =>
      '相手の端末は新しい cat(a)log です。この端末で cat(a)log を更新して、もう一度同期してください。';

  @override
  String get syncPeerNoTls =>
      '相手の端末は 1.1.0 より前の cat(a)log で、暗号化同期がありません。そちらで cat(a)log を更新して、もう一度同期してください。';

  @override
  String get syncWrongHost =>
      '証明書がペアコードと一致しません — コードの出どころの端末ではありません。コードをもう一度読み取るか入力してください。';

  @override
  String get bundleNewerError =>
      'このファイルは新しい cat(a)log のものです。読み込むには、この端末の cat(a)log を更新してください。';

  @override
  String get spotEar => '隅の小さな猫耳は「長押しでもっと」の印です。';

  @override
  String get addReminder => 'リマインダーを追加';

  @override
  String get plannedSection => '予定';

  @override
  String get reminderDialogHint =>
      '予定は予定表に表示されます。そこで確定するか取り消せます。値が取り込まれるのは、予定を確定したときだけです。';

  @override
  String get reminderFor => '対象';

  @override
  String get reminderField => 'フィールド';

  @override
  String get dueDateLabel => '期日';

  @override
  String get pickCalendar => 'どのカレンダー？';

  @override
  String get calendarPermissionDenied =>
      'カレンダーへのアクセスが拒否されているため、反映はオフです。システム設定で許可して、もう一度反映をオンにしてください。';

  @override
  String get calendarNotChosen =>
      'カレンダーが選ばれていないため、反映はオフです。もう一度オンにして、カレンダーを選んでください。';

  @override
  String get calendarGone =>
      '選んだカレンダーがなくなったため、反映はオフです。もう一度オンにして、別のカレンダーを選んでください。';

  @override
  String get noWritableCalendar =>
      'カレンダーが見つかりません。システム設定でカレンダーのアカウント（Google など）にログインして、もう一度お試しください。';

  @override
  String get spotHomeAgenda => '予定表：計画した予定の一覧 — 通院、投薬、健診。';

  @override
  String get spotAgendaAdd => '新しい予定を計画します。';

  @override
  String get spotAgendaCalendar => 'ここをオンにすると、cat(a)log の予定を選んだカレンダーに反映します。';

  @override
  String get helpAgenda =>
      '予定表は計画した予定を日付順に並べます。予定は2種類あります：時刻のある予定と、その日1日に対するリマインダーです。過ぎた予定は上に残ります。タップで猫やクラウダーを開きます。チェックで予定を確定すると、値がフィールドに書き込まれ、すぐに次の予定（たとえば3か月後）を計画できます。長押しで日付の変更や予定の削除ができます。上のスイッチで予定を端末のカレンダーに反映します。メニューからカレンダーファイルとして書き出せます。 複数の猫での通院は1つの予定です。猫にチェックを入れると、アジェンダには名前付きの1枚のカードが表示され、完了時にどの猫が処置されたか尋ねられます。処置されなかった猫はチェックを外すと予定のまま残ります。';

  @override
  String get helpAgendaNeutral =>
      '予定表は計画した予定を日付順に並べます。予定は2種類あります：時刻のある予定と、その日1日に対するリマインダーです。過ぎた予定は上に残ります。タップでペットや世帯を開きます。チェックで予定を確定すると、値がフィールドに書き込まれ、すぐに次の予定（たとえば3か月後）を計画できます。長押しで日付の変更や予定の削除ができます。上のスイッチで予定を端末のカレンダーに反映します。メニューからカレンダーファイルとして書き出せます。 複数のペットでの通院は1つの予定です。ペットにチェックを入れると、アジェンダには名前付きの1枚のカードが表示され、完了時にどのペットが処置されたか尋ねられます。処置されなかったペットはチェックを外すと予定のまま残ります。';

  @override
  String get calendarRowOff => 'カレンダー：オフ';

  @override
  String calendarRowOn(String name) {
    return 'カレンダー：$name';
  }

  @override
  String get spotAddReminderCat => 'この猫の予定を計画します。予定表に表示され、そこで確定します。';

  @override
  String get spotAddReminderCatNeutral => 'このペットの予定を計画します。予定表に表示され、そこで確定します。';

  @override
  String get spotAddReminderClowder => 'このクラウダーの予定を計画します。予定表に表示され、そこで確定します。';

  @override
  String get spotAddReminderClowderNeutral =>
      'この世帯の予定を計画します。予定表に表示され、そこで確定します。';

  @override
  String get readOnlyCalendar => '読み取り専用';

  @override
  String get appointmentLabel => '予定';

  @override
  String get addAppointment => '予定を追加';

  @override
  String get planChooserTitle => '予定とリマインダー、どちら？';

  @override
  String get planChooserAppointment => '予定 — 日付と時刻のある訪問、メモ付き';

  @override
  String get planChooserReminder => 'リマインダー — ある日に期日となる値';

  @override
  String get appointmentTitleLabel => '内容';

  @override
  String get notesLabel => 'メモ';

  @override
  String get timeLabel => '時刻';

  @override
  String get allDayLabel => '終日';

  @override
  String get alertLabel => '通知';

  @override
  String get alertNone => 'なし';

  @override
  String get alertDayBefore => '前日';

  @override
  String get alertHourBefore => '1時間前';

  @override
  String get linkFieldLabel => '完了時にフィールドへ書き込む';

  @override
  String get noLinkedField => 'フィールドなし';

  @override
  String get outcomeTitle => 'どうでしたか？';

  @override
  String get finishLabel => '完了';

  @override
  String get editLabelAppointment => '予定を編集';

  @override
  String get deleteAppointment => '予定を削除';

  @override
  String get stepFlierText => 'チラシの文字';

  @override
  String get qrFoundHint => 'チラシにQRコードが見つかりました。チェックしたコードから登録番号とリンクを読み取ります。';

  @override
  String get useCode => 'このコードを使う';

  @override
  String get qrNone => '写真にQRコードは見つかりませんでした。';

  @override
  String qrFailed(String error) {
    return 'QRコードの読み取りに失敗しました: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$nameのチラシを認識しました。各行がどの項目に入るか下で確認してください。';
  }

  @override
  String get flierLayoutUnknown => 'チラシの形式が不明です。下で各行を項目に割り当ててください。残りは備考に残ります。';

  @override
  String get targetRegistryNumber => '登録番号';

  @override
  String get targetLostPlace => '住所（迷子になった場所）';

  @override
  String get targetContact => '登録サービスの連絡先';

  @override
  String get targetDrop => '破棄';

  @override
  String get existingCat => '既存の猫';

  @override
  String get existingCatNeutral => '既存のペット';

  @override
  String get existingClowder => '既存のグループ';

  @override
  String get existingClowderNeutral => '既存の世帯';

  @override
  String get createNewInstead => 'なし — 新規作成';

  @override
  String overwritesValue(String value) {
    return '現在の値 \"$value\" を上書きします';
  }

  @override
  String get abortScanTitle => '取り込みを中止しますか？';

  @override
  String get abortScanBody => '何も保存されません。';

  @override
  String get abortScan => '中止';

  @override
  String get keepScanning => '続ける';

  @override
  String get catsOnAppointment => 'この予定の猫';

  @override
  String get catsOnAppointmentNeutral => 'この予定のペット';

  @override
  String get noCatsHint => '猫が選ばれていません — この予定はコロニー自体のものです。';

  @override
  String get noCatsHintNeutral => 'ペットが選ばれていません — この予定は世帯自体のものです。';

  @override
  String get pickCatsTitle => 'どの猫が一緒に行きますか？';

  @override
  String get pickCatsTitleNeutral => 'どのペットが一緒に行きますか？';

  @override
  String catsCount(int count) {
    return '$count匹の猫';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count匹のペット';
  }

  @override
  String get finishUntickHint => '処置されなかった猫のチェックを外してください。予定のまま残ります。';

  @override
  String get finishUntickHintNeutral => '処置されなかったペットのチェックを外してください。予定のまま残ります。';

  @override
  String deleteAppointmentGroup(int count) {
    return '$count匹すべての予定を削除';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return '$count匹すべての予定を削除';
  }
}
