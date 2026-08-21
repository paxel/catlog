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
  String get noClowdersYet =>
      'No clowders yet. A clowder is a place where cats live — your foster home, an adopter\'s flat. Create the first one below.';

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
      'The cat disappears from all lists and its photos are removed — here and, after the next sync, on the other synced devices too.';

  @override
  String get sightingRecorded => 'Sighting recorded at your position.';

  @override
  String get noLocationAvailable =>
      'No location available — long-press the map instead.';

  @override
  String get locationDeniedForever =>
      'Location access is blocked. Allow it in the system settings to use Stray Cam.';

  @override
  String get locationServiceOff =>
      'Location is turned off on this device. Turn it on in the settings and try again.';

  @override
  String get locationDenied =>
      'cat(a)log has no permission to use your location. Try again and allow it when asked.';

  @override
  String get locationNoFix =>
      'Your position could not be determined right now. Try again outdoors — GPS needs a clear view of the sky.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Chip ID';

  @override
  String get starterRemarks => 'Remarks';

  @override
  String get captureFlier => 'Capture flier';

  @override
  String get addPhotosTo => 'Add photos to…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count photo(s) added to $name';
  }

  @override
  String get scanPrintedCode => 'Scan printed code';

  @override
  String get chipScanHint =>
      'Scans the printed QR/barcode from chip cards or vet papers — the chip inside the cat can\'t be read by a phone.';

  @override
  String get savingLabel => 'Saving…';

  @override
  String ownerOfCat(String name) {
    return 'Owner of $name';
  }

  @override
  String get sortLabel => 'Sort';

  @override
  String get viewAsTable => 'Show as table';

  @override
  String get viewAsTiles => 'Show as tiles';

  @override
  String get matchCandidatesTitle => 'Match candidates';

  @override
  String get findDuplicates => 'Find duplicates';

  @override
  String get noDuplicates => 'No possible duplicates right now.';

  @override
  String get similarName => 'Similar name';

  @override
  String get sharePublicly => 'Share publicly…';

  @override
  String get privateNoShare =>
      'This cat is marked Private — private data never leaves your device. Unmark Private first to share it publicly.';

  @override
  String get pickFramesTitle => 'Pick frames';

  @override
  String get suggestedFrames => 'Suggested frames';

  @override
  String get scrubFrames => 'Scrub the video';

  @override
  String get keepThisFrame => 'Keep this frame';

  @override
  String get fromVideo => 'From video…';

  @override
  String get videoMobileOnly =>
      'Picking frames from a video works in the phone app (Android and iPhone) — not on this device yet.';

  @override
  String get shareWhitelistExplainer =>
      'Choose what goes into the file. Only ticked fields are included.';

  @override
  String get exportShareFile => 'Export share file…';

  @override
  String get hostedLink => 'Hosted link (URL of the uploaded file)';

  @override
  String get inlineQr => 'Inline QR (text only, no photos)';

  @override
  String get inlineTooBig =>
      'Too much data for an inline code — untick some fields or use a hosted link.';

  @override
  String get scanShareLabel => 'Scan share code';

  @override
  String get notAShareCode => 'That code is not a cat(a)log share.';

  @override
  String get importShareTitle => 'Import this cat?';

  @override
  String shareSource(String url) {
    return 'Source: $url';
  }

  @override
  String get importLabel => 'Import';

  @override
  String get strayAreaLabel => 'Possible stray area';

  @override
  String get prevPin => 'Previous pin';

  @override
  String get nextPin => 'Next pin';

  @override
  String get noMissingCats => 'No missing cats with flier positions yet.';

  @override
  String get noMatchCandidates => 'No match candidates right now.';

  @override
  String sameIdField(String field) {
    return 'Same $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m apart';
  }

  @override
  String get addFlier => 'Add flier';

  @override
  String get missingSinceLabel => 'Missing since';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get cropPortrait => 'Crop portrait';

  @override
  String get statusOwner => 'Owner';

  @override
  String get ocrUnavailable =>
      'Text recognition is not available on this device — type the flier text yourself.';

  @override
  String get displayFormat => 'Shown as';

  @override
  String get displayPlain => 'Plain text';

  @override
  String get displayQr => 'QR code';

  @override
  String get displayBarcode => 'Barcode';

  @override
  String get editLabel => 'Edit';

  @override
  String get doneLabel => 'Done';

  @override
  String get openSettings => 'Open settings';

  @override
  String get notSaved => 'Not saved';

  @override
  String get birthdateInFuture => 'The birth date can\'t be in the future.';

  @override
  String get deceasedInFuture => 'The date of death can\'t be in the future.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'The date of death can\'t be before the birth date ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'The birth date can\'t be after the date of death ($date).';
  }

  @override
  String get malePregnant =>
      'This cat is recorded as male — a male cat can\'t be pregnant. Check the gender first.';

  @override
  String fatherNotMale(String name) {
    return '$name is recorded as female and can\'t be the father. Check the gender first.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name is recorded as male and can\'t be the mother. Check the gender first.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name was born $date — a parent can\'t be born after its kitten.';
  }

  @override
  String get genderFatherFemale =>
      'This cat is recorded as the father of other cats — the father can\'t be female. Check the family first.';

  @override
  String get genderMotherMale =>
      'This cat is recorded as the mother of other cats — the mother can\'t be male. Check the family first.';

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
  String dateFormatError(String format) {
    return 'Wrong format — use $format';
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
  String get ownValue => 'Own value';

  @override
  String get renameField => 'Rename field';

  @override
  String get editOptions => 'Edit options…';

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
      'Both devices use the same folder (for example in Dropbox or on a USB stick). Each sync stores your changes there and picks up the other side\'s.';

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
  String get starterBreed => 'Breed';

  @override
  String get valueMixed => 'mixed';

  @override
  String get breedEuropeanShorthair => 'European Shorthair';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'British Shorthair';

  @override
  String get breedNorwegianForestCat => 'Norwegian Forest Cat';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamese';

  @override
  String get breedPersian => 'Persian';

  @override
  String get breedBengal => 'Bengal';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get starterEmail => 'Email';

  @override
  String get starterPhone => 'Phone';

  @override
  String get lookupUrlLabel => 'Lookup link';

  @override
  String lookupUrlHelp(String token) {
    return 'The service\'s page with $token where the number goes, e.g. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Look up';

  @override
  String lookupFailed(String url) {
    return 'No app could open $url. Copy the link into a browser.';
  }

  @override
  String get stepCat => 'Cat';

  @override
  String get stepOwner => 'Owner';

  @override
  String get stepFace => 'Face photo';

  @override
  String get stepRegistry => 'Registry';

  @override
  String get stepReview => 'Check and save';

  @override
  String get stepOwnerHint =>
      'Whoever is missing the cat — this becomes their card, with the contact from the poster.';

  @override
  String get stepFaceHint =>
      'Cut the cat\'s face out of the poster; it becomes the profile picture. You can skip this.';

  @override
  String get stepRegistryHint =>
      'Numbers found on the poster. Ticked ones are saved with the cat and can be opened later.';

  @override
  String get noRegistryLinks =>
      'No registry links on this poster — nothing to do here.';

  @override
  String get unknownServiceHint => 'Unknown service';

  @override
  String get rememberService => 'Remember service';

  @override
  String get rememberServiceHint =>
      'Name the service and point at the number in the link. The next poster from it fills itself.';

  @override
  String get noIdInLink => 'This link carries no number the app could store.';

  @override
  String get whichNumber => 'Which part is the number?';

  @override
  String get cropAgain => 'Crop again';

  @override
  String get noFaceYet =>
      'No face photo yet — the poster photo is used instead.';

  @override
  String get backLabel => 'Back';

  @override
  String get dangerButton => 'DON\'T PRESS.\nDANGER';

  @override
  String get dangerThanks => 'Thank you for using cat(a)log!';

  @override
  String get helpTitle => 'Help';

  @override
  String get showTipsAgain => 'Show tips again';

  @override
  String get helpHome =>
      'This is the overview of your clowders — a clowder is a place where cats live: your home, a foster home, a shelter. Tap a card to see its cats; long-press for its menu. The button at the bottom right creates a new clowder, and the strays card collects every cat that currently has no home.';

  @override
  String get helpClowder =>
      'Everything about this place: its cats, its fields (address, contact, type) and its history. The page opens read-only; the pencil turns on editing, where you can also add a new field. Long-press a field to edit it directly, and long-press a cat to move, hide, or open it.';

  @override
  String get helpCat =>
      'Everything about this cat: photos, fields, family, history. The page is read-only until you tap the pencil. Long-press a field to jump straight into editing it; long-press a photo for its menu. The menu in the top right holds the rest: mark private, hide, merge, record a sighting, share the cat.';

  @override
  String get helpStrays =>
      'Cats with no home right now: found cats, escaped cats, cats from a poster. The camera button records a cat you see in front of you; the poster button turns a missing-cat flier into a cat with its owner\'s contact; the scanner reads a cat(a)log code from a poster.';

  @override
  String get helpMap =>
      'Every cat and place with a position. Search finds cats, people, and places — an unknown name is looked up worldwide. The layers button draws the 500 m circles around a missing cat\'s poster spots and the home it ran from. The arrows walk from pin to pin, long-press the map to record a sighting.';

  @override
  String get helpCard =>
      'The printable card of this cat: pick what appears on it with the chips at the top, then share it as an image or a PDF. IDs can print as a QR or a barcode, and a position becomes a QR that opens a map plus a short Plus Code.';

  @override
  String get helpSync =>
      'Getting data to other people: meet and connect directly, use a folder both devices see, or send a file through a messenger. You always decide what to send, and receiving a .catsync file happens here too.';

  @override
  String get helpFields =>
      'The fields your catalog uses. Rename them, change the options of a choice field, or add your own. ID fields can point at a service (a registry), so the number becomes tappable on the cat.';

  @override
  String get helpTimeline =>
      'Every change ever made, newest first: who changed what, when, and to which value. Any entry can be reverted — that writes a new entry, nothing is ever erased.';

  @override
  String get helpDuplicates =>
      'Cats or clowders that look like the same one twice — identical IDs, or very similar names with matching details. Tap a pair to merge it; merging cannot be undone, so it asks first.';

  @override
  String get helpMatches =>
      'Cats that might be the same animal: an identical ID, or a stray seen inside a missing cat\'s search area. Tap a pair to merge it, long-press to open the first cat and compare.';

  @override
  String get helpFlier =>
      'A photographed missing-cat poster becomes a cat plus its owner. Step by step: the cat\'s data, the owner\'s contact, a face crop for the profile picture, any registry numbers on the poster, then a final check. Everything is a suggestion — correct whatever the camera got wrong.';

  @override
  String get archiveTitle => 'Archive';

  @override
  String get archiveExplainer =>
      'Deceased cats and empty clowders that nobody has touched in years still cost space — their photos most of all. Archiving writes them into a file you keep and then deletes them here.';

  @override
  String get archiveAction => 'Archive';

  @override
  String archiveSelected(int count) {
    return 'Archive $count entries';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archive $count entries?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names will be written into a file and then deleted — on your device and on every device you sync with. Importing the file brings everything back; without it, they are gone.';
  }

  @override
  String archiveDone(int count) {
    return '$count entries archived and deleted';
  }

  @override
  String archiveFailed(String error) {
    return 'Nothing was deleted: the archive file could not be written ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Database $db, photos $photos in $count files';
  }

  @override
  String quietForYears(int years) {
    return 'Quiet for $years years';
  }

  @override
  String get nothingToArchive => 'Nothing old enough to archive.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Last change $date · photos $size';
  }

  @override
  String get helpArchive =>
      'Old data costs space, above all the photos, which every synced device carries. Here you pick deceased cats and empty clowders that have been quiet for years, write them into a file you keep, and delete them. The deletion reaches everyone you sync with; importing the file restores everything.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Restore $count deleted entries?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names are deleted in this catalog, and the file you just imported carries them. Restoring brings them back here and on every device you sync with.';
  }

  @override
  String get restoreAction => 'Restore';

  @override
  String get keepDeleted => 'Keep deleted';

  @override
  String get archiveNotSaved =>
      'Nothing was deleted: the archive was not saved anywhere.';

  @override
  String get locateAddress => 'Find address on the map';

  @override
  String get addressLocated => 'Address found';

  @override
  String get addressNotFound =>
      'No place found for this address. Check the spelling, or leave it empty.';

  @override
  String get starterPosition => 'Location';

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
  String get applyCrop => 'Crop';

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
  String lastBackupFailed(String error) {
    return 'Last automatic backup failed: $error';
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

  @override
  String get markPrivate => 'Mark as private';

  @override
  String get unmarkPrivate => 'Remove private mark';

  @override
  String get includePrivate => 'Include private data';

  @override
  String get includePrivateExplainer =>
      'This also sends everything you marked private. The person you sync with will see it.';

  @override
  String get hideLabel => 'Hide on this device';

  @override
  String get unhideLabel => 'Show again';

  @override
  String get showHiddenLabel => 'Show hidden';

  @override
  String get stopShowingHidden => 'Stop showing hidden';

  @override
  String get starterSpecies => 'Species';

  @override
  String get starterStatus => 'Type';

  @override
  String get statusFoster => 'Foster home';

  @override
  String get statusForeverHome => 'Forever home';

  @override
  String get statusClinic => 'Clinic';

  @override
  String get statusShelter => 'Shelter';

  @override
  String get statusBarn => 'Barn';

  @override
  String get valueCat => 'Cat';

  @override
  String get otherOption => 'Other…';

  @override
  String get celebrationsToggle => 'Celebrate adoptions';

  @override
  String get celebrationsSubtitle =>
      'Confetti and a cheer when a cat moves into a forever home';

  @override
  String get onMapLabel => 'On the map';

  @override
  String get showOnMap => 'Show on map';

  @override
  String get searchPlaceHint => 'Search place or address';

  @override
  String get noPlacesFound => 'No places found';

  @override
  String get mapSearchHint => 'Search cats, clowders, people';

  @override
  String get proposeAnotherName => 'Propose another name';

  @override
  String get moderationTitle => 'Authors & bans';

  @override
  String get moderationSubtitle => 'Remove a person\'s data for good';

  @override
  String get authorsSection => 'Who wrote into this catalog';

  @override
  String get hardDeleteAction => 'Delete everything by this author';

  @override
  String hardDeleteWarning(Object name) {
    return 'Removes every entry and photo by $name from this device. Other devices keep theirs. This cannot be undone.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Type $name to confirm';
  }

  @override
  String get alsoBan => 'Also ban — never accept their data again';

  @override
  String get bansSection => 'Bans';

  @override
  String get unbanAction => 'Remove ban';

  @override
  String get deletedDone => 'Deleted.';

  @override
  String get syncSummaryTitle => 'What arrived';

  @override
  String get summaryAdopted => 'Adopted';

  @override
  String get summaryDeceased => 'Deceased';

  @override
  String get summaryEscaped => 'Escaped';

  @override
  String get summaryNew => 'New';

  @override
  String get summaryConflicts => 'Conflicts to resolve';

  @override
  String summaryOther(Object n) {
    return '…and $n other changes';
  }

  @override
  String get starterMother => 'Mother';

  @override
  String get starterFather => 'Father';

  @override
  String get familySection => 'Family';

  @override
  String get littermatesLabel => 'Littermates';

  @override
  String get siblingsLabel => 'Siblings';

  @override
  String get kittensLabel => 'Kittens';

  @override
  String get toastSettingsTitle => 'What to announce';

  @override
  String get toastSettingsSubtitle => 'Little messages after a sync';

  @override
  String get toastKindAdoptions => 'Adoptions';

  @override
  String get toastKindBirths => 'Births';

  @override
  String get toastKindDeaths => 'Deaths';

  @override
  String get toastKindEscapes => 'Escapes';

  @override
  String get toastKindMoves => 'Moves';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adopted by $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ New kitten: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat has passed away';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat has escaped';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat moved to $home';
  }

  @override
  String get notACatlogFile => 'That\'s not a cat(a)log file';

  @override
  String get nothingNewInBundle =>
      'Nothing new in that file — you already have everything';

  @override
  String get syncChooserInPerson => 'In person';

  @override
  String get syncChooserInPersonSub =>
      'You\'re in the same room — scan a code, done in seconds';

  @override
  String get syncChooserRemote => 'Remote';

  @override
  String get syncChooserRemoteSub =>
      'Via a shared folder like Dropbox or a USB stick';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Send everything as one file through any messenger — and import a received .catsync file here';

  @override
  String get connectToWifiFirst =>
      'Connect to a Wi-Fi first — then devices can find each other';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) wants to sync';
  }

  @override
  String get trustBothWaysNote =>
      'Your catalogs will be exchanged in both directions.';

  @override
  String get allowOnce => 'Allow';

  @override
  String get allowAlways => 'Always allow this device';

  @override
  String get declineAction => 'Decline';

  @override
  String get syncDeclined => 'The other device declined the sync';

  @override
  String get trustedDevicesSection => 'Always-allowed devices';

  @override
  String get removeTrust => 'Remove';

  @override
  String get hostWithoutWifi => 'Host without Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Joins a temporary direct connection to the other phone (no internet). Only cat(a)log uses it, and it disconnects by itself after the sync.';

  @override
  String get hotspotAndroidOnly =>
      'This code needs two Android phones — on iPhone/iPad, use a shared Wi-Fi instead';

  @override
  String get selectClowderHint => 'Pick a clowder on the left';

  @override
  String get introTitle1 => 'Your cats, organized';

  @override
  String get introBody1 =>
      'Create a card for every cat you care for: photo, gender, health, anything worth noting. Cats are grouped by where they live — the app calls such a place a clowder.';

  @override
  String get introTitle2 => 'Works without internet';

  @override
  String get introBody2 =>
      'Everything is saved on your phone only. No account, no cloud. Nothing is uploaded unless you share it yourself.';

  @override
  String get introTitle3 => 'Work together';

  @override
  String get introBody3 =>
      'Everyone uses their own app and you swap data now and then: meet and scan a code, use a shared folder, or send one file by messenger. Afterwards everyone has the same information.';

  @override
  String get introSkip => 'Skip';

  @override
  String get introNext => 'Next';

  @override
  String get introDone => 'Let\'s go';

  @override
  String get introReplayTitle => 'Quick intro';

  @override
  String get spotHomeSync =>
      'Sync with people you know here. You decide what you share.';

  @override
  String get spotHomeStrays =>
      'This card collects all strays — cats without a home. Tap it to see the list.';

  @override
  String get spotHomeMenu =>
      'In this menu: find and merge duplicate entries, export CSV, and more.';

  @override
  String get spotCatEdit =>
      'Tap the pencil to edit this cat. Tip: long-press any field to edit it directly.';

  @override
  String get spotMapLayers =>
      'Searching for a missing cat? Show circles around its poster spots and the home it ran from.';

  @override
  String get spotStraysFlier =>
      'Found a missing-cat poster? Photograph it here — the app saves cat and contact for you.';

  @override
  String get spotStraysScan =>
      'Some posters carry a cat(a)log QR code. Scan it here to import the cat without typing.';

  @override
  String get introTitle4 => 'Find missing cats';

  @override
  String get introBody4 =>
      'See a missing-cat poster? Photograph it in the app: it saves the cat, the owner\'s contact, and the place. When a similar stray turns up later, the app suggests possible matches.';

  @override
  String get spotMapSearch =>
      'Type a cat, place, or person here to jump to it on the map.';

  @override
  String get spotCardChips =>
      'Tick what should appear on the shareable card — everything else stays off it.';

  @override
  String get spotCatMenu =>
      'More actions live here: mark the cat private, hide it, merge duplicates, or record a sighting.';

  @override
  String get spotDone => 'Got it';

  @override
  String get spotReplayTitle => 'What\'s new tour';

  @override
  String get spotReplaySubtitle => 'Show the highlights again on each page';

  @override
  String get spotReplayDone => 'The highlights will show again';

  @override
  String get searchNoResults => 'No cat found with that name';

  @override
  String get syncUnreachable =>
      'Couldn\'t reach the other device. Are both on the same Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Couldn\'t reach the folder. Is the drive or cloud folder still there?';

  @override
  String get crashTitle => 'That should not have happened';

  @override
  String get crashBody =>
      'cat(a)log hit an unexpected error. Your data is safe — everything is saved the moment you change it. Restart the app, and if this keeps happening, send the report so it can be fixed.';

  @override
  String get crashRestart => 'Restart the app';

  @override
  String get crashSendReport => 'Send report to the developer';

  @override
  String get crashLastRunBody =>
      'cat(a)log stopped unexpectedly last time — most likely it ran out of memory. Send a short report so it can be fixed?';

  @override
  String get catalogsTitle => 'Catalogs';

  @override
  String get newCatalog => 'New catalog';

  @override
  String get catalogNameLabel => 'Catalog name';

  @override
  String catalogNameTaken(String name) {
    return 'A catalog called $name already exists. Pick a different name.';
  }

  @override
  String get manageCatalogs => 'Manage catalogs';

  @override
  String get helpCatalogs =>
      'A catalog is a world of its own: its own cats, clowders, fields, photos and sync partners. Berlin and Paris never mix. Tap the name at the top of the home screen to switch, add one, or rename it. Your name, your language and the tips you have already seen are shared by all of them.';

  @override
  String get spotHomeCatalog =>
      'This is the catalog you are in. Tap the name to switch, or to make another one.';

  @override
  String get deleteCatalog => 'Delete catalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Everything in $name goes: its cats, its photos, its history. A complete file is saved first, where the automatic backups go, so importing that file brings the catalog back. Type the name to confirm.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name deleted. The file is in $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Type $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Nothing was deleted: the catalog file could not be written ($error). Free some space or pick another moment, then try again.';
  }

  @override
  String get moveToCatalog => 'Move to another catalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count moved to $name';
  }
}
