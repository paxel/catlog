// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Welcome to cat(a)log';

  @override
  String get welcomeBody =>
      'Pick a name for yourself. Every change you make is recorded under this name, so others can see who did what.';

  @override
  String get yourName => 'Your name';

  @override
  String get start => 'Start';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet => 'No clowders yet.\nCreate the first one below.';

  @override
  String get strays => 'Strays';

  @override
  String get searchCats => 'Search cats';

  @override
  String get map => 'Map';

  @override
  String get sync => 'Sync';

  @override
  String get fields => 'Fields';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get aboutAndFeedback => 'About & feedback';

  @override
  String get newClowder => 'New clowder';

  @override
  String get name => 'Name';

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get merge => 'Merge';

  @override
  String get resolve => 'Resolve';

  @override
  String get open => 'Open';

  @override
  String csvSavedTo(String path) {
    return 'CSV saved to $path';
  }

  @override
  String get renameClowder => 'Rename clowder';

  @override
  String get rename => 'Rename';

  @override
  String get timeline => 'Timeline';

  @override
  String get mergeInto => 'Merge into…';

  @override
  String get deleteClowder => 'Delete clowder';

  @override
  String get cats => 'Cats';

  @override
  String get addCat => 'Add cat';

  @override
  String get newCat => 'New cat';

  @override
  String deleteQuestion(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'The clowder disappears from the list.';

  @override
  String deleteClowderBody(int count) {
    return 'Its $count cat(s) are not deleted — they become strays. Move them to another clowder first if that is not what you want.';
  }

  @override
  String get card => 'Card';

  @override
  String get shareAsImage => 'Share as image';

  @override
  String get shareAsPdf => 'Share as PDF';

  @override
  String get print => 'Print';

  @override
  String cardTitle(String name) {
    return 'Card — $name';
  }

  @override
  String get renameCat => 'Rename cat';

  @override
  String get seenHereNow => 'Seen here now';

  @override
  String get deleteCat => 'Delete cat';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Stray — no clowder';

  @override
  String get stray => 'Stray';

  @override
  String get photos => 'Photos';

  @override
  String get addPhoto => 'Add photo';

  @override
  String get setAsProfileImage => 'Set as profile image';

  @override
  String get thisIsProfileImage => 'This is the profile image';

  @override
  String get deletePhoto => 'Delete photo';

  @override
  String get deletePhotoTitle => 'Delete photo?';

  @override
  String get deletePhotoBody =>
      'The photo data is removed for good — this cannot be undone.';

  @override
  String get deleteCatBody =>
      'The cat disappears from all lists. Its photos are removed for good.';

  @override
  String get sightingRecorded => 'Sighting recorded at your position.';

  @override
  String get noLocationAvailable =>
      'No location available — long-press the map instead.';

  @override
  String get moveTo => 'Move to';

  @override
  String get noClowderStrayOption => 'No clowder — stray / ran away';

  @override
  String timelineOf(String name) {
    return 'Timeline — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Revert this change';

  @override
  String get revertSubtitle =>
      'Restores the previous value as a new entry — history keeps both.';

  @override
  String fieldCleared(String field) {
    return '$field cleared';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field back to \"$value\"';
  }

  @override
  String get leftStray => 'Left — stray';

  @override
  String movedTo(String name) {
    return 'Moved to $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat arrived';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat arrived from $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat left to $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicate record merged in';

  @override
  String get asOfToday => 'As of today';

  @override
  String asOfDate(String date) {
    return 'As of $date';
  }

  @override
  String get value => 'Value';

  @override
  String get latitudeLongitude => 'latitude, longitude';

  @override
  String get newField => 'New field';

  @override
  String get fieldType => 'Type';

  @override
  String get usedOn => 'Used on';

  @override
  String get forCats => 'cats';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'both';

  @override
  String get optionsOnePerLine => 'Options (one per line)';

  @override
  String get renameField => 'Rename field';

  @override
  String get noStraysRightNow => 'No strays right now.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Add stray';

  @override
  String get newStray => 'New stray';

  @override
  String get searchByNameHint => 'Search cats by name…';

  @override
  String get host => 'Host';

  @override
  String get hostExplainer =>
      'Start here, then enter the address and PIN on the other device.';

  @override
  String get startHosting => 'Start hosting';

  @override
  String get stopHosting => 'Stop hosting';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count session(s) so far';
  }

  @override
  String get join => 'Join';

  @override
  String get addressFromHost => 'Address (from the hosting device)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sync now';

  @override
  String get addressFormatHint => 'Address must look like 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synced: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sync failed: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Last sync with $peer: $time';
  }

  @override
  String get sharedFolder => 'Shared folder';

  @override
  String get sharedFolderExplainer =>
      'Sync through a folder that a cloud drive or USB stick carries between devices — for people who are not on the same network.';

  @override
  String get noFolderChosenYet => 'No folder chosen yet';

  @override
  String get choose => 'Choose…';

  @override
  String get syncFolderNow => 'Sync folder now';

  @override
  String folderSynced(String result) {
    return 'Folder synced: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Folder sync failed: $error';
  }

  @override
  String get recordSightingHere => 'Record a sighting here:';

  @override
  String get orPlaceClowderHere => 'Or place a clowder here:';

  @override
  String trailOf(String name, int count) {
    return 'Trail: $name ($count sightings)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflict — $field';
  }

  @override
  String get conflictBody =>
      'Changed in two places at once. Pick what is true:';

  @override
  String mergeThisInto(String kind) {
    return 'Merge this $kind into…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'No other $kind to merge into.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Merge into $name?';
  }

  @override
  String mergeBody(String name) {
    return 'The two records become one. $name keeps its current values; the other record\'s history joins its timeline. This cannot be undone.';
  }

  @override
  String get kindCat => 'cat';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'field';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get about => 'About';

  @override
  String get aboutTagline =>
      'A local-first catalog for foster cats. Your data lives on your devices — no server, no account.';

  @override
  String versionLabel(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get sourceCode => 'Source code';

  @override
  String get reportProblemOrIdea => 'Report a problem or idea';

  @override
  String get githubIssues => 'GitHub issues';

  @override
  String get writeTheDeveloper => 'Write the developer';

  @override
  String get buyCoffee => 'Buy the developer a coffee';

  @override
  String get coffeeSubtitle => 'Entirely optional — the app is free';

  @override
  String get openSourceLicenses => 'Open-source licenses';

  @override
  String get machineTranslated =>
      'Translations are machine-made — corrections are welcome on GitHub.';

  @override
  String get unnamed => '(unnamed)';

  @override
  String get labelName => 'Name';

  @override
  String get labelProfileImage => 'Profile image';

  @override
  String get labelPhoto => 'Photo';

  @override
  String get starterGender => 'Gender';

  @override
  String get starterColor => 'Color';

  @override
  String get starterNeutered => 'Neutered';

  @override
  String get starterPregnant => 'Pregnant';

  @override
  String get starterBirthdate => 'Birth date';

  @override
  String get starterDeceased => 'Deceased';

  @override
  String get starterAddress => 'Address';

  @override
  String get starterResponsible => 'Responsible person';

  @override
  String get starterPosition => 'Position';

  @override
  String get valueYes => 'yes';

  @override
  String get valueNo => 'no';

  @override
  String get valueFemale => 'female';

  @override
  String get valueMale => 'male';

  @override
  String get valueUnknown => 'unknown';

  @override
  String get cropTitle => 'Crop photo';

  @override
  String get markTitle => 'Mark the cat';

  @override
  String get useFullPhoto => 'Use full photo';

  @override
  String get dragToSelect => 'Drag a rectangle around the cat';

  @override
  String get dragOverTheCat => 'Drag an ellipse over the cat';

  @override
  String get cropPhoto => 'Crop…';

  @override
  String get markPhoto => 'Mark…';

  @override
  String get scanCode => 'Scan code';

  @override
  String get orTypeCode => 'Or type the code';

  @override
  String get copyCode => 'Copy code';

  @override
  String get copied => 'Copied';

  @override
  String get invalidCode => 'That code is not valid';

  @override
  String get hotspotHint =>
      'No shared Wi-Fi? Turn on one phone\'s hotspot, connect the other phone to it, then host here.';

  @override
  String get byMessenger => 'By messenger';

  @override
  String get byMessengerExplainer =>
      'Send your whole catalog as one file through WhatsApp, Signal, or mail — the other side imports it.';

  @override
  String get shareBundle => 'Share sync bundle…';

  @override
  String get importBundle => 'Import sync bundle…';

  @override
  String bundleImported(String result) {
    return 'Bundle imported: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get pickOnMap => 'Pick on map';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System default';

  @override
  String get iosLocalNetworkHint =>
      'If it keeps failing on iPhone/iPad: Settings → Privacy & Security → Local Network → allow cat(a)log, then try again.';
}
