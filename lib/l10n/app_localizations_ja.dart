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
  String get noClowdersYet => 'まだクラウダーがありません。\n下から最初のひとつを作成してください。';

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
  String get deleteCatBody => '猫はすべての一覧から消え、写真は完全に削除されます。';

  @override
  String get sightingRecorded => '現在地で目撃を記録しました。';

  @override
  String get noLocationAvailable => '位置情報がありません — 代わりに地図を長押ししてください。';

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
  String get renameField => '項目名を変更';

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
      'クラウドや USB メモリが端末間で運ぶフォルダー経由で同期します — 同じネットワークにいない人向け。';

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
  String get orPlaceClowderHere => 'またはここにクラウダーを配置:';

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
  String get applyCrop => 'Crop';

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
