// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => '欢迎使用 cat(a)log';

  @override
  String get welcomeBody => '给自己取个名字。每次修改都会记录在这个名字下，让其他人知道是谁做了什么。';

  @override
  String get yourName => '你的名字';

  @override
  String get start => '开始';

  @override
  String get clowders => '猫群';

  @override
  String get noClowdersYet => '还没有猫群。猫群是猫居住的地方——你的寄养家庭、领养人的公寓。在下方创建第一个吧。';

  @override
  String get strays => '流浪猫';

  @override
  String get searchCats => '搜索猫';

  @override
  String get map => '地图';

  @override
  String get sync => '同步';

  @override
  String get fields => '字段';

  @override
  String get exportCsv => '导出 CSV';

  @override
  String get aboutAndFeedback => '关于与反馈';

  @override
  String get newClowder => '新建猫群';

  @override
  String get name => '名字';

  @override
  String get cancel => '取消';

  @override
  String get create => '创建';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get merge => '合并';

  @override
  String get resolve => '裁定';

  @override
  String get open => '打开';

  @override
  String csvSavedTo(String path) {
    return 'CSV 已保存到 $path';
  }

  @override
  String get renameClowder => '重命名猫群';

  @override
  String get rename => '重命名';

  @override
  String get timeline => '时间线';

  @override
  String get mergeInto => '合并到…';

  @override
  String get deleteClowder => '删除猫群';

  @override
  String get cats => '猫';

  @override
  String get addCat => '添加猫';

  @override
  String get newCat => '新的猫';

  @override
  String deleteQuestion(String name) {
    return '删除 $name？';
  }

  @override
  String get deleteClowderEmptyBody => '该猫群将从列表中消失。';

  @override
  String deleteClowderBody(int count) {
    return '它的 $count 只猫不会被删除——它们会变成流浪猫。如果这不是你想要的，请先把它们移到别的猫群。';
  }

  @override
  String get card => '卡片';

  @override
  String get shareAsImage => '以图片分享';

  @override
  String get shareAsPdf => '以 PDF 分享';

  @override
  String get print => '打印';

  @override
  String cardTitle(String name) {
    return '卡片 — $name';
  }

  @override
  String get renameCat => '重命名猫';

  @override
  String get seenHereNow => '刚在这里见到';

  @override
  String get deleteCat => '删除猫';

  @override
  String get clowderLabel => '猫群';

  @override
  String get strayNoClowder => '流浪猫 — 无猫群';

  @override
  String get stray => '流浪猫';

  @override
  String get photos => '照片';

  @override
  String get addPhoto => '添加照片';

  @override
  String get setAsProfileImage => '设为头像';

  @override
  String get thisIsProfileImage => '这是当前头像';

  @override
  String get deletePhoto => '删除照片';

  @override
  String get deletePhotoTitle => '删除照片？';

  @override
  String get deletePhotoBody => '照片数据将被永久删除——无法撤销。';

  @override
  String get deleteCatBody => '这只猫将从所有列表中消失，照片也会被删除——本设备以及下次同步后伙伴们的设备上都是如此。';

  @override
  String get sightingRecorded => '已在你的位置记录目击。';

  @override
  String get noLocationAvailable => '无法获取位置——请改为长按地图。';

  @override
  String get locationDeniedForever => '位置权限已被禁止。请在系统设置中允许，以使用 Stray Cam。';

  @override
  String get locationServiceOff => '此设备的定位已关闭。请在设置中开启后重试。';

  @override
  String get locationDenied => 'cat(a)log 没有使用您位置的权限。请重试，并在询问时允许。';

  @override
  String get locationNoFix => '当前无法确定您的位置。请到户外重试——GPS 需要开阔的天空视野。';

  @override
  String get ok => '好';

  @override
  String get editLabel => '编辑';

  @override
  String get doneLabel => '完成';

  @override
  String get openSettings => '打开设置';

  @override
  String get notSaved => '未保存';

  @override
  String get birthdateInFuture => '出生日期不能是未来的日期。';

  @override
  String get deceasedInFuture => '死亡日期不能是未来的日期。';

  @override
  String deceasedBeforeBirth(String date) {
    return '死亡日期不能早于出生日期（$date）。';
  }

  @override
  String bornAfterDeceased(String date) {
    return '出生日期不能晚于死亡日期（$date）。';
  }

  @override
  String get malePregnant => '这只猫登记为公猫——公猫不可能怀孕。请先检查性别。';

  @override
  String get moveTo => '移动到';

  @override
  String get noClowderStrayOption => '无猫群 — 流浪／跑掉了';

  @override
  String timelineOf(String name) {
    return '时间线 — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => '撤销此更改';

  @override
  String get revertSubtitle => '把之前的值作为新记录恢复——历史会保留两者。';

  @override
  String fieldCleared(String field) {
    return '已清空 $field';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field 已恢复为“$value”';
  }

  @override
  String get leftStray => '离开了 — 流浪猫';

  @override
  String movedTo(String name) {
    return '移动到 $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat 来了';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat 从 $place 来';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat 去了 $place';
  }

  @override
  String get duplicateMergedIn => '已合并重复记录';

  @override
  String get asOfToday => '记为今天';

  @override
  String asOfDate(String date) {
    return '记为 $date';
  }

  @override
  String dateFormatError(String format) {
    return '格式错误，请使用 $format';
  }

  @override
  String get value => '值';

  @override
  String get latitudeLongitude => '纬度，经度';

  @override
  String get newField => '新字段';

  @override
  String get fieldType => '类型';

  @override
  String get usedOn => '用于';

  @override
  String get forCats => '猫';

  @override
  String get forClowders => '猫群';

  @override
  String get forBoth => '两者';

  @override
  String get optionsOnePerLine => '选项（每行一个）';

  @override
  String get ownValue => '自定义值';

  @override
  String get renameField => '重命名字段';

  @override
  String get editOptions => '编辑选项…';

  @override
  String get noStraysRightNow => '现在没有流浪猫。';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => '添加流浪猫';

  @override
  String get newStray => '新的流浪猫';

  @override
  String get searchByNameHint => '按名字搜索猫…';

  @override
  String get host => '主机';

  @override
  String get hostExplainer => '从这里开始，然后在另一台设备上输入地址和 PIN。';

  @override
  String get startHosting => '开始托管';

  @override
  String get stopHosting => '停止托管';

  @override
  String pinLabel(String pin) {
    return 'PIN：$pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '已完成会话：$count';
  }

  @override
  String get join => '加入';

  @override
  String get addressFromHost => '地址（来自主机设备）';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => '立即同步';

  @override
  String get addressFormatHint => '地址格式应类似 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return '已同步：$result';
  }

  @override
  String syncFailed(String error) {
    return '同步失败：$error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return '与 $peer 的上次同步：$time';
  }

  @override
  String get sharedFolder => '共享文件夹';

  @override
  String get sharedFolderExplainer => '通过云盘或 U 盘在设备间携带的文件夹进行同步——适合不在同一网络的人。';

  @override
  String get noFolderChosenYet => '尚未选择文件夹';

  @override
  String get choose => '选择…';

  @override
  String get syncFolderNow => '立即同步文件夹';

  @override
  String folderSynced(String result) {
    return '文件夹已同步：$result';
  }

  @override
  String folderSyncFailed(String error) {
    return '文件夹同步失败：$error';
  }

  @override
  String get recordSightingHere => '在这里记录目击：';

  @override
  String trailOf(String name, int count) {
    return '路线：$name（目击 $count 次）';
  }

  @override
  String conflictOn(String field) {
    return '冲突 — $field';
  }

  @override
  String get conflictBody => '同时在两处被修改。选出正确的：';

  @override
  String mergeThisInto(String kind) {
    return '把这个$kind合并到…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return '没有其他$kind可合并。';
  }

  @override
  String mergeIntoQuestion(String name) {
    return '合并到 $name？';
  }

  @override
  String mergeBody(String name) {
    return '两条记录合为一条。$name 保留当前值；另一条的历史并入其时间线。无法撤销。';
  }

  @override
  String get kindCat => '猫';

  @override
  String get kindClowder => '猫群';

  @override
  String get kindField => '字段';

  @override
  String get takePhoto => '拍照';

  @override
  String get chooseFromGallery => '从相册选择';

  @override
  String get about => '关于';

  @override
  String get aboutTagline => '本地优先的寄养猫目录。数据只留在你的设备上——没有服务器，没有账号。';

  @override
  String versionLabel(String version, String build) {
    return '版本 $version（$build）';
  }

  @override
  String get sourceCode => '源代码';

  @override
  String get reportProblemOrIdea => '反馈问题或想法';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => '写信给开发者';

  @override
  String get buyCoffee => '请开发者喝杯咖啡';

  @override
  String get coffeeSubtitle => '完全自愿——应用免费';

  @override
  String get openSourceLicenses => '开源许可证';

  @override
  String get machineTranslated => '翻译为机器生成——欢迎在 GitHub 上提交修正。';

  @override
  String get unnamed => '（未命名）';

  @override
  String get labelName => '名字';

  @override
  String get labelProfileImage => '头像';

  @override
  String get labelPhoto => '照片';

  @override
  String get starterGender => '性别';

  @override
  String get starterBreed => '品种';

  @override
  String get valueMixed => '混种';

  @override
  String get breedEuropeanShorthair => '欧洲短毛猫';

  @override
  String get breedMaineCoon => '缅因猫';

  @override
  String get breedBritishShorthair => '英国短毛猫';

  @override
  String get breedNorwegianForestCat => '挪威森林猫';

  @override
  String get breedRagdoll => '布偶猫';

  @override
  String get breedSiamese => '暹罗猫';

  @override
  String get breedPersian => '波斯猫';

  @override
  String get breedBengal => '孟加拉猫';

  @override
  String get breedSphynx => '斯芬克斯猫';

  @override
  String get starterColor => '毛色';

  @override
  String get starterNeutered => '已绝育';

  @override
  String get starterPregnant => '怀孕';

  @override
  String get starterBirthdate => '出生日期';

  @override
  String get starterDeceased => '死亡';

  @override
  String get starterAddress => '地址';

  @override
  String get starterResponsible => '负责人';

  @override
  String get starterPosition => '位置';

  @override
  String get valueYes => '是';

  @override
  String get valueNo => '否';

  @override
  String get valueFemale => '母';

  @override
  String get valueMale => '公';

  @override
  String get valueUnknown => '未知';

  @override
  String get cropTitle => '裁剪照片';

  @override
  String get markTitle => '标记这只猫';

  @override
  String get applyCrop => '裁剪';

  @override
  String get useFullPhoto => '使用整张照片';

  @override
  String get dragToSelect => '围绕猫拖出矩形';

  @override
  String get dragOverTheCat => '在猫上拖出椭圆';

  @override
  String get cropPhoto => '裁剪…';

  @override
  String get markPhoto => '标记…';

  @override
  String get scanCode => '扫描代码';

  @override
  String get orTypeCode => '或输入代码';

  @override
  String get copyCode => '复制代码';

  @override
  String get copied => '已复制';

  @override
  String get invalidCode => '该代码无效';

  @override
  String get hotspotHint => '没有共同的 Wi-Fi？打开一部手机的热点，让另一部连接，然后在这里托管。';

  @override
  String get byMessenger => '通过聊天软件';

  @override
  String get byMessengerExplainer =>
      '把整个目录作为一个文件通过 WhatsApp、Signal 或邮件发送——对方导入即可。';

  @override
  String get shareBundle => '分享同步包…';

  @override
  String get importBundle => '导入同步包…';

  @override
  String bundleImported(String result) {
    return '已导入同步包：$result';
  }

  @override
  String lastBackupFailed(String error) {
    return '上次自动备份失败：$error';
  }

  @override
  String bundleImportFailed(String error) {
    return '导入失败：$error';
  }

  @override
  String get pickOnMap => '在地图上选择';

  @override
  String get useMyLocation => '使用我的位置';

  @override
  String get language => '语言';

  @override
  String get systemDefault => '跟随系统';

  @override
  String get iosLocalNetworkHint =>
      '如果在 iPhone/iPad 上仍然失败：设置 → 隐私与安全性 → 本地网络 → 允许 cat(a)log，然后重试。';

  @override
  String get markPrivate => '标记为私密';

  @override
  String get unmarkPrivate => '取消私密标记';

  @override
  String get includePrivate => '包含私密数据';

  @override
  String get includePrivateExplainer => '私密的猫、猫群和字段也会被分享——仅在同步自己的设备时开启。';

  @override
  String get hideLabel => '在此设备上隐藏';

  @override
  String get unhideLabel => '重新显示';

  @override
  String get showHiddenLabel => '显示隐藏项';

  @override
  String get stopShowingHidden => '停止显示隐藏项';

  @override
  String get starterSpecies => '物种';

  @override
  String get starterStatus => '状态';

  @override
  String get statusFoster => '寄养家庭';

  @override
  String get statusForeverHome => '永久的家';

  @override
  String get statusClinic => '诊所';

  @override
  String get statusShelter => '收容所';

  @override
  String get statusBarn => '谷仓';

  @override
  String get valueCat => '猫';

  @override
  String get otherOption => '其他…';

  @override
  String get celebrationsToggle => '庆祝领养';

  @override
  String get celebrationsSubtitle => '猫咪搬进永久的家时撒彩纸并欢呼';

  @override
  String get onMapLabel => '在地图上';

  @override
  String get showOnMap => '在地图上显示';

  @override
  String get searchPlaceHint => '搜索地点或地址';

  @override
  String get noPlacesFound => '未找到地点';

  @override
  String get mapSearchHint => '搜索猫、猫群、人员';

  @override
  String get proposeAnotherName => '换一个名字';

  @override
  String get moderationTitle => '作者与封禁';

  @override
  String get moderationSubtitle => '永久移除某人的数据';

  @override
  String get authorsSection => '谁写入过此目录';

  @override
  String get hardDeleteAction => '删除该作者的全部内容';

  @override
  String hardDeleteWarning(Object name) {
    return '从此设备移除 $name 的所有记录和照片。其他设备保留其副本。无法撤销。';
  }

  @override
  String typeToConfirm(Object name) {
    return '输入 $name 以确认';
  }

  @override
  String get alsoBan => '同时封禁——不再接收其数据';

  @override
  String get bansSection => '封禁';

  @override
  String get unbanAction => '解除封禁';

  @override
  String get deletedDone => '已删除。';

  @override
  String get syncSummaryTitle => '同步内容';

  @override
  String get summaryAdopted => '已领养';

  @override
  String get summaryDeceased => '已离世';

  @override
  String get summaryEscaped => '走失';

  @override
  String get summaryNew => '新增';

  @override
  String get summaryConflicts => '待解决的冲突';

  @override
  String summaryOther(Object n) {
    return '…及其他 $n 项变更';
  }

  @override
  String get starterMother => '母亲';

  @override
  String get starterFather => '父亲';

  @override
  String get familySection => '家庭';

  @override
  String get littermatesLabel => '同窝伙伴';

  @override
  String get siblingsLabel => '兄弟姐妹';

  @override
  String get kittensLabel => '小猫';

  @override
  String get toastSettingsTitle => '播报内容';

  @override
  String get toastSettingsSubtitle => '同步后的小提示';

  @override
  String get toastKindAdoptions => '领养';

  @override
  String get toastKindBirths => '出生';

  @override
  String get toastKindDeaths => '离世';

  @override
  String get toastKindEscapes => '走失';

  @override
  String get toastKindMoves => '搬家';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat 被 $home 领养了 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ 新的小猫：$cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat 离世了';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat 走失了';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat 搬到了 $home';
  }

  @override
  String get notACatlogFile => '这不是 cat(a)log 文件';

  @override
  String get nothingNewInBundle => '文件中没有新内容——您已拥有全部数据';

  @override
  String get syncChooserInPerson => '面对面';

  @override
  String get syncChooserInPersonSub => '你们在同一房间——扫码即可，几秒完成';

  @override
  String get syncChooserRemote => '远程';

  @override
  String get syncChooserRemoteSub => '通过 Dropbox 或 U 盘等共享文件夹';

  @override
  String get syncChooserMessenger => '通讯软件';

  @override
  String get syncChooserMessengerSub => '将全部数据作为一个文件通过任意通讯软件发送';

  @override
  String get connectToWifiFirst => '请先连接 Wi-Fi——设备才能互相发现';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author（$device）请求同步';
  }

  @override
  String get trustBothWaysNote => '双方的目录将双向交换。';

  @override
  String get allowOnce => '允许';

  @override
  String get allowAlways => '始终允许此设备';

  @override
  String get declineAction => '拒绝';

  @override
  String get syncDeclined => '对方设备拒绝了同步';

  @override
  String get trustedDevicesSection => '始终允许的设备';

  @override
  String get removeTrust => '移除';

  @override
  String get hostWithoutWifi => '无 Wi-Fi 主持';

  @override
  String get hotspotJoinNote => '与另一部手机建立临时直连（无互联网）。仅 cat(a)log 使用，同步后自动断开。';

  @override
  String get hotspotAndroidOnly =>
      '此二维码需要两部 Android 手机——iPhone/iPad 请改用共享 Wi-Fi';

  @override
  String get selectClowderHint => '从左侧选择一个猫群';

  @override
  String get introTitle1 => '猫住在猫群里';

  @override
  String get introBody1 =>
      '猫群是猫居住的地方：你的寄养家庭、领养人的公寓、隔壁的谷仓。每只猫都有一张卡片，有照片、信息和完整的故事。';

  @override
  String get introTitle2 => '一切都在你手中';

  @override
  String get introBody2 => '没有账号、没有云端、没有跟踪。数据只存在你的设备上。';

  @override
  String get introTitle3 => '与伙伴们共享';

  @override
  String get introBody3 => '扫码即可让两台设备秒速同步，也可以用共享文件夹或发送一个文件。所有人拥有同一份目录。';

  @override
  String get introSkip => '跳过';

  @override
  String get introNext => '下一步';

  @override
  String get introDone => '开始吧';

  @override
  String get introReplayTitle => '快速介绍';

  @override
  String get spotHomeSync => '新功能：同步现在提供三种清晰方式——数据流动前还会先询问信任。';

  @override
  String get spotMapSearch => '新功能：在这里搜索猫、猫群和人员——直接定位到地图上。';

  @override
  String get spotCardChips => '新功能：分享前可选择卡片上显示的内容。';

  @override
  String get spotCatMenu => '新功能：在这里将猫标记为私密（绝不离开你的设备）或隐藏它。';

  @override
  String get spotDone => '知道了';

  @override
  String get spotReplayTitle => '新功能导览';

  @override
  String get spotReplaySubtitle => '在每个页面重新显示提示';

  @override
  String get spotReplayDone => '提示将重新显示';

  @override
  String get searchNoResults => '没有找到这个名字的猫';

  @override
  String get syncUnreachable => '无法连接另一台设备。两台设备在同一个 Wi-Fi 上吗？';

  @override
  String get folderUnreachable => '无法访问文件夹。硬盘或云文件夹还在吗？';

  @override
  String get crashTitle => '这本不该发生';

  @override
  String get crashBody =>
      'cat(a)log 遇到了意外错误。您的数据是安全的——所有更改都会立即保存。请重启应用；如果反复出现，请发送报告以便修复。';

  @override
  String get crashRestart => '重启应用';

  @override
  String get crashSendReport => '向开发者发送报告';

  @override
  String get crashLastRunBody => '上次 cat(a)log 意外停止了——很可能是内存不足。发送一份简短报告以便修复吗？';
}
