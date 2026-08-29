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
  String get deleteCatBody => '这只猫将从所有列表中消失，照片也会被删除——本机立即生效，下次同步后其他设备也一样。';

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
  String get starterChipId => '芯片号';

  @override
  String get starterRemarks => '备注';

  @override
  String get captureFlier => '拍摄寻猫启事';

  @override
  String get addPhotosTo => '将照片添加到…';

  @override
  String photosAddedTo(String count, String name) {
    return '已将 $count 张照片添加到 $name';
  }

  @override
  String get scanPrintedCode => '扫描印刷的条码';

  @override
  String get chipScanHint => '扫描芯片卡或兽医文件上印刷的二维码/条形码——手机无法读取猫体内的芯片。';

  @override
  String get savingLabel => '正在保存…';

  @override
  String ownerOfCat(String name) {
    return '$name的主人';
  }

  @override
  String get sortLabel => '排序';

  @override
  String get viewAsTable => '以表格显示';

  @override
  String get viewAsTiles => '以磁贴显示';

  @override
  String get matchCandidatesTitle => '疑似匹配';

  @override
  String get findDuplicates => '查找重复';

  @override
  String get noDuplicates => '当前没有疑似重复。';

  @override
  String get similarName => '相似的名字';

  @override
  String get sharePublicly => '公开分享…';

  @override
  String get pickFramesTitle => '挑选画面';

  @override
  String get suggestedFrames => '推荐画面';

  @override
  String get scrubFrames => '拖动视频';

  @override
  String get keepThisFrame => '保留此画面';

  @override
  String get fromVideo => '来自视频…';

  @override
  String get videoMobileOnly => '从视频挑选画面需要手机应用（Android 和 iPhone）——此设备暂不支持。';

  @override
  String get shareWhitelistExplainer => '选择放进文件的内容。只包含勾选的字段。';

  @override
  String get exportShareFile => '导出分享文件…';

  @override
  String get hostedLink => '托管链接（上传文件的 URL）';

  @override
  String get inlineQr => '内嵌二维码（仅文本，无照片）';

  @override
  String get inlineTooBig => '数据太多，无法生成内嵌码——请减少字段或使用托管链接。';

  @override
  String get scanShareLabel => '扫描分享码';

  @override
  String get notAShareCode => '该二维码不是 cat(a)log 分享。';

  @override
  String get importShareTitle => '导入这只猫？';

  @override
  String shareSource(String url) {
    return '来源：$url';
  }

  @override
  String get importLabel => '导入';

  @override
  String get strayAreaLabel => '可能的活动范围';

  @override
  String get prevPin => '上一个图钉';

  @override
  String get nextPin => '下一个图钉';

  @override
  String get noMissingCats => '还没有带启事位置的走失猫。';

  @override
  String get noMatchCandidates => '当前没有疑似匹配。';

  @override
  String sameIdField(String field) {
    return '相同的$field';
  }

  @override
  String metersApart(String distance) {
    return '相距 $distance 米';
  }

  @override
  String get addFlier => '添加启事';

  @override
  String get missingSinceLabel => '失踪日期';

  @override
  String get phoneLabel => '电话';

  @override
  String get cropPortrait => '裁剪头像';

  @override
  String get statusOwner => '主人';

  @override
  String get ocrUnavailable => '此设备不支持文字识别——请自行输入启事内容。';

  @override
  String get displayFormat => '显示为';

  @override
  String get displayPlain => '纯文本';

  @override
  String get displayQr => '二维码';

  @override
  String get displayBarcode => '条形码';

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
  String fatherNotMale(String name) {
    return '$name登记为母猫，不能作为父亲。请先检查性别。';
  }

  @override
  String motherNotFemale(String name) {
    return '$name登记为公猫，不能作为母亲。请先检查性别。';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name出生于$date——父母不可能晚于幼崽出生。';
  }

  @override
  String get genderFatherFemale => '这只猫登记为其他猫的父亲——父亲不能是母猫。请先检查家庭关系。';

  @override
  String get genderMotherMale => '这只猫登记为其他猫的母亲——母亲不能是公猫。请先检查家庭关系。';

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
  String get dateInFuture => '此日期不能是未来的日期。';

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
  String get hostExplainer => '从这里开始，然后在另一台设备上扫描或输入代码。';

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
  String get sharedFolderExplainer =>
      '两台设备使用同一个文件夹（例如 Dropbox 或U盘）。每次同步会把你的更改放进去，并取回对方的更改。';

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
  String get coffeeSubtitle => '应用保持免费。即使我喝不到咖啡 :)';

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
  String get starterEmail => '电子邮件';

  @override
  String get starterPhone => '电话';

  @override
  String get lookupUrlLabel => '查询链接';

  @override
  String lookupUrlHelp(String token) {
    return '服务页面地址，用 $token 代替号码，例如 https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => '查询';

  @override
  String lookupFailed(String url) {
    return '没有应用能打开 $url。请把链接复制到浏览器。';
  }

  @override
  String get stepCat => '猫';

  @override
  String get stepOwner => '主人';

  @override
  String get stepFace => '头像照片';

  @override
  String get stepRegistry => '登记服务';

  @override
  String get stepReview => '检查并保存';

  @override
  String get stepOwnerHint => '寻猫的人——这里会生成他的猫群，附上启事上的联系方式。';

  @override
  String get stepFaceHint => '从启事中裁出猫的脸，作为头像。此步可跳过。';

  @override
  String get stepRegistryHint => '在启事上找到的号码。勾选的会保存到猫，之后可以打开。';

  @override
  String get noRegistryLinks => '这张启事没有登记服务链接——如有遗漏，请报告 bug。';

  @override
  String get unknownServiceHint => '未知服务';

  @override
  String get rememberService => '记住该服务';

  @override
  String get rememberServiceHint => '给服务起个名字，并指出链接中的号码。下次同类启事会自动填好。';

  @override
  String get noIdInLink => '该链接中没有应用可保存的号码。';

  @override
  String get whichNumber => '哪一部分是号码？';

  @override
  String get cropAgain => '重新裁剪';

  @override
  String get noFaceYet => '还没有头像照片——将使用启事照片。';

  @override
  String get backLabel => '返回';

  @override
  String get dangerButton => '请勿按下。\n危险';

  @override
  String get dangerThanks => '感谢你使用 cat(a)log！';

  @override
  String get helpTitle => '帮助';

  @override
  String get showTipsAgain => '再次显示提示';

  @override
  String get helpHome =>
      '你的猫群概览——猫群是猫生活的地方：你家、寄养家庭、收容所。点按卡片查看其中的猫；长按打开菜单。右下角按钮新建猫群，流浪猫卡片汇集所有没有家的猫。 顶部的名称是你当前所在的目录，点按即可切换或新建。';

  @override
  String get helpClowder =>
      '关于这个地方的一切：它的猫、字段（地址、联系方式、类型）和历史。页面默认只读；铅笔开启编辑，在那里也能新增字段。长按字段可直接编辑，长按猫可移动、隐藏或打开它。 在此添加的预约可以带上猫群中的多只猫，例如一次绝育出行：勾选同去的猫，一次完成，取消勾选未处理的猫。';

  @override
  String get helpCat =>
      '关于这只猫的一切：照片、字段、家庭、历史。在点击铅笔之前页面为只读。长按字段可直接编辑；长按照片打开其菜单。右上角菜单包含其余操作：隐藏、合并、记录目击、分享这只猫。私密在编辑字段时设置。';

  @override
  String get helpStrays =>
      '当前没有家的猫：捡到的、走失的，或来自启事的猫。相机按钮记录眼前的猫；启事按钮把寻猫启事变成一只带主人联系方式的猫；扫描器读取启事上的 cat(a)log 码。';

  @override
  String get helpMap =>
      '所有带位置的猫和地点。搜索可找猫、人和地点——不认识的名字会在全球查找。图层按钮会在走失猫的启事地点和它出走的家周围画出 500 米圆圈。箭头在图钉间移动，长按地图可记录目击。';

  @override
  String get helpCard =>
      '这只猫的可打印卡片：用顶部的标签选择卡片内容，然后以图片或 PDF 分享。编号可打印为二维码或条形码，位置会变成打开地图的二维码，外加一个简短的 Plus Code。';

  @override
  String get helpSync =>
      '把数据交给他人的方式：当面直连、使用两台设备都能看到的文件夹，或用即时通讯发送文件。发送什么始终由你决定——收到的 .catsync 文件也在这里打开。';

  @override
  String get helpFields =>
      '你的目录所用的字段。可重命名、修改选择字段的选项，或添加自己的字段。ID 字段可指向某个服务（登记机构），这样编号在猫页面上就能点按。';

  @override
  String get helpTimeline =>
      '所有做过的更改，最新在上：谁在何时把什么改成了什么值。任何记录都可撤销——撤销会写入新记录，任何内容都不会被抹去。';

  @override
  String get helpDuplicates =>
      '看起来重复出现的猫或猫群——编号相同，或名字非常相似且细节吻合。点按一对进行合并；合并无法撤销，因此会先询问。';

  @override
  String get helpMatches =>
      '可能是同一只动物的猫：编号相同，或在走失猫搜索范围内出现的流浪猫。点按一对合并，长按可打开第一只猫进行比较。';

  @override
  String get helpFlier =>
      '拍下的启事会变成一只猫和它的主人。逐步进行：猫的资料、主人联系方式、裁出头像、启事上的登记编号，最后确认。所有内容都是建议——相机认错的地方请修改。';

  @override
  String get archiveTitle => '归档';

  @override
  String get archiveExplainer =>
      '多年无人过问的已故猫和空猫群仍然占用空间，尤其是它们的照片。归档会把它们写入一个由你保存的文件，然后从这里删除。';

  @override
  String get archiveAction => '归档';

  @override
  String archiveSelected(int count) {
    return '归档 $count 条';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '要归档 $count 条吗？';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names 将被写入文件后删除——在你的设备上，以及所有与你同步的设备上。导入该文件可全部恢复；没有它就找不回来了。';
  }

  @override
  String archiveDone(int count) {
    return '已归档并删除 $count 条';
  }

  @override
  String archiveFailed(String error) {
    return '未删除任何内容：归档文件写入失败（$error）。';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return '数据库 $db，照片 $photos，共 $count 个文件';
  }

  @override
  String quietForYears(int years) {
    return '$years 年无变化';
  }

  @override
  String get nothingToArchive => '没有足够久远的内容可归档。';

  @override
  String archiveCandidateLine(String date, String size) {
    return '最后更改 $date · 照片 $size';
  }

  @override
  String get helpArchive =>
      '旧数据占用空间，尤其是每台同步设备都要携带的照片。在这里你可以挑选多年没有变化的已故猫和空猫群，写入一个自己保存的文件，然后删除它们。删除会传达给所有与你同步的人；导入该文件可全部恢复。';

  @override
  String restoreDeletedTitle(int count) {
    return '恢复 $count 条已删除的记录吗？';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names 在本目录中已被删除，而你刚导入的文件包含它们。恢复会让它们回到这里，以及所有与你同步的设备上。';
  }

  @override
  String get restoreAction => '恢复';

  @override
  String get keepDeleted => '保持删除';

  @override
  String get archiveNotSaved => '未删除任何内容：归档没有保存到任何地方。';

  @override
  String get locateAddress => '在地图上查找地址';

  @override
  String get addressLocated => '已找到地址';

  @override
  String get addressNotFound => '没有找到该地址对应的地点。请检查拼写或留空。';

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
  String get includePrivate => '分享私密数据';

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
  String get starterStatus => '类型';

  @override
  String get statusFoster => '寄养家庭';

  @override
  String get statusForeverHome => '家';

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
  String get celebrationsSubtitle => '猫咪搬进新家时撒彩纸并欢呼';

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
  String get syncChooserInPersonSub => '通过 Wi-Fi 同步';

  @override
  String get syncChooserRemote => '远程';

  @override
  String get syncChooserRemoteSub => '通过文件夹或U盘同步';

  @override
  String get syncChooserMessenger => '通讯软件';

  @override
  String get syncChooserMessengerSub => '通过社交媒体导出和导入';

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
  String get introTitle1 => '猫咪井井有条';

  @override
  String get introBody1 =>
      '为你照顾的每只猫建一张卡片：照片、性别、健康，任何想记录的内容。猫按居住地点分组——应用把这样的地点叫做聚落（clowder）。';

  @override
  String get introTitle2 => '无需网络';

  @override
  String get introBody2 => '所有数据只保存在你的手机上。没有账号，没有云。除非你自己分享，否则什么都不会上传。';

  @override
  String get introTitle3 => '协同工作';

  @override
  String get introBody3 =>
      '每个人用自己的应用，不时交换数据：见面扫个码、用共享文件夹，或者通过通讯软件发送一个文件。之后大家的信息就一致了。';

  @override
  String get introSkip => '跳过';

  @override
  String get introNext => '下一步';

  @override
  String get introDone => '开始吧';

  @override
  String get introReplayTitle => '快速介绍';

  @override
  String get spotHomeSync => '在这里与认识的人同步。分享什么由你决定。';

  @override
  String get spotHomeStrays => '这张卡片汇集所有流浪猫——没有家的猫。点按查看列表。';

  @override
  String get spotHomeMenu => '这个菜单里有：查找并合并重复项、导出CSV等。';

  @override
  String get spotCatEdit => '点铅笔编辑这只猫。提示：长按任意字段可直接编辑。';

  @override
  String get spotMapLayers => '在找走失的猫？可在其启事出现地点和它出走的家周围显示圆圈。';

  @override
  String get spotStraysFlier => '发现寻猫启事？在这里拍下来——应用会帮你保存猫和联系方式。';

  @override
  String get spotStraysScan => '有些启事带有 cat(a)log 二维码。在这里扫描即可直接导入这只猫。';

  @override
  String get introTitle4 => '寻找走失的猫';

  @override
  String get introBody4 =>
      '看到寻猫启事？在应用里拍下来：它会保存这只猫、主人的联系方式和地点。以后出现相似的流浪猫时，应用会提示可能的匹配。';

  @override
  String get spotMapSearch => '输入猫、地点或人名，即可在地图上跳转过去。';

  @override
  String get spotCardChips => '勾选要出现在分享卡片上的内容——其余不会出现。';

  @override
  String get spotCatMenu => '这里有更多操作：隐藏这只猫、合并重复项或记录一次目击。';

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

  @override
  String get catalogsTitle => '目录';

  @override
  String get newCatalog => '新建目录';

  @override
  String get catalogNameLabel => '目录名称';

  @override
  String catalogNameTaken(String name) {
    return '已经有名为 $name 的目录。请换一个名称。';
  }

  @override
  String get manageCatalogs => '管理目录';

  @override
  String get helpCatalogs =>
      '每个目录都是独立的世界：自己的猫、群落、字段、照片和同步伙伴，柏林和巴黎永远不会混在一起。点按主界面顶部的名称即可切换、新建或改名。你的名字、语言和看过的提示由所有目录共用。';

  @override
  String get spotHomeCatalog => '这是你当前所在的目录。点按名称即可切换或新建。';

  @override
  String get deleteCatalog => '删除目录';

  @override
  String deleteCatalogBody(String name) {
    return '$name 里的一切都会消失：猫、照片、历史记录。删除前会把完整文件保存到自动备份所在的位置，导入它就能把目录找回来。请输入名称以确认。';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '已删除 $name。文件在 $where。';
  }

  @override
  String typeTheName(String name) {
    return '输入 $name';
  }

  @override
  String catalogExportFailed(String error) {
    return '没有删除任何内容：无法写入目录文件（$error）。请腾出空间或稍后再试。';
  }

  @override
  String get moveToCatalog => '移动到其他目录';

  @override
  String movedToCatalog(int count, String name) {
    return '已将 $count 项移动到 $name';
  }

  @override
  String get chooseWhatToMove => '要移动什么？';

  @override
  String moveIntoNewCatalog(String name) {
    return '要把什么移动到 $name 吗？';
  }

  @override
  String get undoThisImport => '撤销这次导入';

  @override
  String undoImportBody(int count) {
    return '这次导入带来的 $count 处改动会被移除。它们会先写入一个文件，导入该文件即可恢复。已经与你同步过的人仍保有各自的副本，这一点无法收回。';
  }

  @override
  String undoneImport(String where) {
    return '已撤销。文件在 $where。';
  }

  @override
  String get goBackTitle => '回到之前';

  @override
  String get goBackToHere => '回到这里';

  @override
  String get momentImport => '导入之前';

  @override
  String get momentSync => '同步之前';

  @override
  String get momentMerge => '合并之前';

  @override
  String get momentHardDelete => '删除某位记录者的数据之前';

  @override
  String get momentArchive => '归档之前';

  @override
  String get momentManual => '你标记的时刻';

  @override
  String get showOlderMoments => '显示更早的';

  @override
  String goBackBody(int count) {
    return '这一刻之后的一切都会被移除，共 $count 处改动。全部会先写入文件，导入即可恢复；比它更新的每个时刻也会一并消失。已经与你同步过的人仍保有副本，无法收回。';
  }

  @override
  String get nameThisMoment => '给这个时刻起个名字';

  @override
  String get helpGoBack =>
      '这个目录发生较大变化的时刻：每次导入和同步之前，合并、归档或删除之前，以及你自己标记的时候。选择其中一个，目录就回到那个状态——之后的一切会先写入你保留的文件再移除，比它更新的每个时刻也会一并消失。已经与你同步过的人仍保有收到的内容。';

  @override
  String goBackFileFailed(String error) {
    return '没有移除任何内容：保存它的文件无法写入（$error）。请腾出空间后重试。';
  }

  @override
  String get switchBeforeDeleting => '这是你当前所在的目录。请先切换到另一个目录，再删除它。';

  @override
  String shareFileFailed(String error) {
    return '无法写入分享文件（$error）。请腾出空间后重试。';
  }

  @override
  String get privateLabel => '私密';

  @override
  String sharedCatalogIs(String name) {
    return '目录：$name';
  }

  @override
  String get markPrivate => '标记为私密';

  @override
  String get unmarkPrivate => '取消私密标记';

  @override
  String get agenda => '日程';

  @override
  String get reminderLabel => '提醒';

  @override
  String get agendaEmpty => '没有已计划的安排。可以在这里用加号，或在猫或猫群的页面上计划新的安排。';

  @override
  String get dueToday => '今天到期';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天后',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已超期 $count 天',
    );
    return '$_temp0';
  }

  @override
  String get markDone => '完成';

  @override
  String get repeatTitle => '下次间隔…';

  @override
  String get noRepeatLabel => '不重复';

  @override
  String get unitDays => '天后';

  @override
  String get unitWeeks => '周后';

  @override
  String get unitMonths => '个月后';

  @override
  String get unitYears => '年后';

  @override
  String ageYears(int years) {
    return '$years岁';
  }

  @override
  String ageMonths(int months) {
    return '$months个月';
  }

  @override
  String get changeDateLabel => '更改日期';

  @override
  String get removeReminderLabel => '移除提醒';

  @override
  String get exportIcs => '导出日历文件';

  @override
  String icsSavedTo(String path) {
    return '日历文件已保存到 $path';
  }

  @override
  String get calendarMirrorLabel => '同步到设备日历';

  @override
  String get calendarMirrorSubtitle =>
      '安排会以全天事件的形式出现在日历中。cat(a)log 每次启动和每次更改后都会在那里更新它们。安排的提醒可以在日历中管理。';

  @override
  String get syncPeerOlder =>
      '对方设备运行的 cat(a)log 版本较旧，不支持提醒。请在那台设备上更新 cat(a)log 后重新同步。';

  @override
  String get syncPeerNewer =>
      '对方设备运行的 cat(a)log 版本较新。请在本设备上更新 cat(a)log 后重新同步。';

  @override
  String get bundleNewerError => '此文件来自较新的 cat(a)log。请在本设备上更新 cat(a)log 后再导入。';

  @override
  String get spotEar => '角落里的小猫耳表示：长按可查看更多。';

  @override
  String get addReminder => '添加提醒';

  @override
  String get plannedSection => '计划';

  @override
  String get reminderDialogHint => '安排会显示在日程中。你可以在那里确认或放弃它。只有在确认安排后，该值才会被采用。';

  @override
  String get reminderFor => '对象';

  @override
  String get reminderField => '字段';

  @override
  String get dueDateLabel => '到期日';

  @override
  String get pickCalendar => '哪个日历？';

  @override
  String get calendarPermissionDenied => '日历访问已被阻止，因此同步已关闭。请在系统设置中允许，然后重新打开同步。';

  @override
  String get calendarNotChosen => '未选择日历，因此同步已关闭。请重新打开并选择一个日历。';

  @override
  String get calendarGone => '所选日历已不存在，因此同步已关闭。请重新打开并选择另一个日历。';

  @override
  String get noWritableCalendar => '未找到日历。请在系统设置中登录一个日历账户（例如 Google），然后重试。';

  @override
  String get spotHomeAgenda => '日程：已计划的安排列表——看兽医、用药、检查。';

  @override
  String get spotAgendaAdd => '计划一次新的安排。';

  @override
  String get spotAgendaCalendar => '在这里开启，把 cat(a)log 的安排同步到你选择的日历。';

  @override
  String get helpAgenda =>
      '日程按日期列出已计划的安排。有两种类型：带具体时间的安排，以及按天生效的提醒。错过的安排会一直留在顶部。点击可打开猫或猫群。勾选即确认安排：该值写入字段，并可立即计划下一次，例如三个月后。长按可更改日期或删除安排。顶部的开关把安排同步到手机日历。菜单可导出为日历文件。 多只猫一起看兽医是一个预约：勾选这些猫，日程会显示一张带有它们名字的卡片，完成时会询问哪些猫接受了处理——取消勾选其余的猫，它们仍保持计划中。';

  @override
  String get calendarRowOff => '日历：关';

  @override
  String calendarRowOn(String name) {
    return '日历：$name';
  }

  @override
  String get spotAddReminderCat => '为这只猫计划一次安排。它会显示在日程中，并在那里确认。';

  @override
  String get spotAddReminderClowder => '为这个猫群计划一次安排。它会显示在日程中，并在那里确认。';

  @override
  String get readOnlyCalendar => '只读';

  @override
  String get appointmentLabel => '安排';

  @override
  String get addAppointment => '添加安排';

  @override
  String get planChooserTitle => '安排还是提醒？';

  @override
  String get planChooserAppointment => '安排——在某个日期和时间的拜访，附带备注';

  @override
  String get planChooserReminder => '提醒——在某一天到期的值';

  @override
  String get appointmentTitleLabel => '事项';

  @override
  String get notesLabel => '备注';

  @override
  String get timeLabel => '时间';

  @override
  String get allDayLabel => '全天';

  @override
  String get alertLabel => '提醒通知';

  @override
  String get alertNone => '无';

  @override
  String get alertDayBefore => '前一天';

  @override
  String get alertHourBefore => '提前一小时';

  @override
  String get linkFieldLabel => '完成时写入字段';

  @override
  String get noLinkedField => '无字段';

  @override
  String get outcomeTitle => '情况如何？';

  @override
  String get finishLabel => '完成';

  @override
  String get editLabelAppointment => '编辑安排';

  @override
  String get deleteAppointment => '删除安排';

  @override
  String get stepFlierText => '启事文字';

  @override
  String get qrFoundHint => '在启事上发现二维码。勾选的二维码会用于读取登记编号和链接。';

  @override
  String get useCode => '使用此二维码';

  @override
  String get qrNone => '照片中未找到二维码。';

  @override
  String qrFailed(String error) {
    return '二维码读取失败：$error';
  }

  @override
  String flierRecognized(String name) {
    return '已识别 $name 启事。请在下方检查每一行归入哪个字段。';
  }

  @override
  String get flierLayoutUnknown => '未知的启事版式。请在下方将各行分配到字段；其余内容保留在备注中。';

  @override
  String get targetRegistryNumber => '登记编号';

  @override
  String get targetLostPlace => '地址（走失地点）';

  @override
  String get targetContact => '登记服务联系方式';

  @override
  String get abortScanTitle => '中止扫描？';

  @override
  String get abortScanBody => '不会保存任何内容。';

  @override
  String get abortScan => '中止';

  @override
  String get keepScanning => '继续';

  @override
  String get catsOnAppointment => '此预约中的猫';

  @override
  String get noCatsHint => '未勾选任何猫 — 该预约属于猫群本身。';

  @override
  String get pickCatsTitle => '哪些猫一起去？';

  @override
  String catsCount(int count) {
    return '$count 只猫';
  }

  @override
  String get finishUntickHint => '取消勾选未接受处理的猫；它们仍保持计划中。';

  @override
  String deleteAppointmentGroup(int count) {
    return '删除全部 $count 只猫的预约';
  }
}
