import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bs.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ga.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_mt.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_no.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bg'),
    Locale('bs'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fa'),
    Locale('fi'),
    Locale('fr'),
    Locale('ga'),
    Locale('he'),
    Locale('hr'),
    Locale('hu'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('mt'),
    Locale('nl'),
    Locale('no'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'cat(a)log'**
  String get appTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to cat(a)log'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Pick a name for yourself. Every change you make is recorded under this name, so others can see who did what.'**
  String get welcomeBody;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @clowders.
  ///
  /// In en, this message translates to:
  /// **'Clowders'**
  String get clowders;

  /// No description provided for @noClowdersYet.
  ///
  /// In en, this message translates to:
  /// **'No clowders yet. A clowder is a place where cats live — your foster home, an adopter\'s flat. Create the first one below.'**
  String get noClowdersYet;

  /// No description provided for @strays.
  ///
  /// In en, this message translates to:
  /// **'Strays'**
  String get strays;

  /// No description provided for @searchCats.
  ///
  /// In en, this message translates to:
  /// **'Search cats'**
  String get searchCats;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @fields.
  ///
  /// In en, this message translates to:
  /// **'Fields'**
  String get fields;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @aboutAndFeedback.
  ///
  /// In en, this message translates to:
  /// **'About & feedback'**
  String get aboutAndFeedback;

  /// No description provided for @newClowder.
  ///
  /// In en, this message translates to:
  /// **'New clowder'**
  String get newClowder;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get merge;

  /// No description provided for @resolve.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get resolve;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @csvSavedTo.
  ///
  /// In en, this message translates to:
  /// **'CSV saved to {path}'**
  String csvSavedTo(String path);

  /// No description provided for @renameClowder.
  ///
  /// In en, this message translates to:
  /// **'Rename clowder'**
  String get renameClowder;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @mergeInto.
  ///
  /// In en, this message translates to:
  /// **'Merge into…'**
  String get mergeInto;

  /// No description provided for @deleteClowder.
  ///
  /// In en, this message translates to:
  /// **'Delete clowder'**
  String get deleteClowder;

  /// No description provided for @cats.
  ///
  /// In en, this message translates to:
  /// **'Cats'**
  String get cats;

  /// No description provided for @addCat.
  ///
  /// In en, this message translates to:
  /// **'Add cat'**
  String get addCat;

  /// No description provided for @newCat.
  ///
  /// In en, this message translates to:
  /// **'New cat'**
  String get newCat;

  /// No description provided for @deleteQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deleteQuestion(String name);

  /// No description provided for @deleteClowderEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'The clowder disappears from the list.'**
  String get deleteClowderEmptyBody;

  /// No description provided for @deleteClowderBody.
  ///
  /// In en, this message translates to:
  /// **'Its {count} cat(s) are not deleted — they become strays. Move them to another clowder first if that is not what you want.'**
  String deleteClowderBody(int count);

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @shareAsImage.
  ///
  /// In en, this message translates to:
  /// **'Share as image'**
  String get shareAsImage;

  /// No description provided for @shareAsPdf.
  ///
  /// In en, this message translates to:
  /// **'Share as PDF'**
  String get shareAsPdf;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @cardTitle.
  ///
  /// In en, this message translates to:
  /// **'Card — {name}'**
  String cardTitle(String name);

  /// No description provided for @renameCat.
  ///
  /// In en, this message translates to:
  /// **'Rename cat'**
  String get renameCat;

  /// No description provided for @seenHereNow.
  ///
  /// In en, this message translates to:
  /// **'Seen here now'**
  String get seenHereNow;

  /// No description provided for @deleteCat.
  ///
  /// In en, this message translates to:
  /// **'Delete cat'**
  String get deleteCat;

  /// No description provided for @clowderLabel.
  ///
  /// In en, this message translates to:
  /// **'Clowder'**
  String get clowderLabel;

  /// No description provided for @strayNoClowder.
  ///
  /// In en, this message translates to:
  /// **'Stray — no clowder'**
  String get strayNoClowder;

  /// No description provided for @stray.
  ///
  /// In en, this message translates to:
  /// **'Stray'**
  String get stray;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get addPhoto;

  /// No description provided for @setAsProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Set as profile image'**
  String get setAsProfileImage;

  /// No description provided for @thisIsProfileImage.
  ///
  /// In en, this message translates to:
  /// **'This is the profile image'**
  String get thisIsProfileImage;

  /// No description provided for @deletePhoto.
  ///
  /// In en, this message translates to:
  /// **'Delete photo'**
  String get deletePhoto;

  /// No description provided for @deletePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete photo?'**
  String get deletePhotoTitle;

  /// No description provided for @deletePhotoBody.
  ///
  /// In en, this message translates to:
  /// **'The photo data is removed for good — this cannot be undone.'**
  String get deletePhotoBody;

  /// No description provided for @deleteCatBody.
  ///
  /// In en, this message translates to:
  /// **'The cat disappears from all lists and its photos are removed — here and, after the next sync, on the other synced devices too.'**
  String get deleteCatBody;

  /// No description provided for @sightingRecorded.
  ///
  /// In en, this message translates to:
  /// **'Sighting recorded at your position.'**
  String get sightingRecorded;

  /// No description provided for @noLocationAvailable.
  ///
  /// In en, this message translates to:
  /// **'No location available — long-press the map instead.'**
  String get noLocationAvailable;

  /// No description provided for @locationDeniedForever.
  ///
  /// In en, this message translates to:
  /// **'Location access is blocked. Allow it in the system settings to use Stray Cam.'**
  String get locationDeniedForever;

  /// No description provided for @locationServiceOff.
  ///
  /// In en, this message translates to:
  /// **'Location is turned off on this device. Turn it on in the settings and try again.'**
  String get locationServiceOff;

  /// No description provided for @locationDenied.
  ///
  /// In en, this message translates to:
  /// **'cat(a)log has no permission to use your location. Try again and allow it when asked.'**
  String get locationDenied;

  /// No description provided for @locationNoFix.
  ///
  /// In en, this message translates to:
  /// **'Your position could not be determined right now. Try again outdoors — GPS needs a clear view of the sky.'**
  String get locationNoFix;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @starterChipId.
  ///
  /// In en, this message translates to:
  /// **'Chip ID'**
  String get starterChipId;

  /// No description provided for @starterRemarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get starterRemarks;

  /// No description provided for @captureFlier.
  ///
  /// In en, this message translates to:
  /// **'Capture flier'**
  String get captureFlier;

  /// No description provided for @addPhotosTo.
  ///
  /// In en, this message translates to:
  /// **'Add photos to…'**
  String get addPhotosTo;

  /// No description provided for @photosAddedTo.
  ///
  /// In en, this message translates to:
  /// **'{count} photo(s) added to {name}'**
  String photosAddedTo(String count, String name);

  /// No description provided for @scanPrintedCode.
  ///
  /// In en, this message translates to:
  /// **'Scan printed code'**
  String get scanPrintedCode;

  /// No description provided for @chipScanHint.
  ///
  /// In en, this message translates to:
  /// **'Scans the printed QR/barcode from chip cards or vet papers — the chip inside the cat can\'t be read by a phone.'**
  String get chipScanHint;

  /// No description provided for @savingLabel.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get savingLabel;

  /// No description provided for @ownerOfCat.
  ///
  /// In en, this message translates to:
  /// **'Owner of {name}'**
  String ownerOfCat(String name);

  /// No description provided for @sortLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortLabel;

  /// No description provided for @viewAsTable.
  ///
  /// In en, this message translates to:
  /// **'Show as table'**
  String get viewAsTable;

  /// No description provided for @viewAsTiles.
  ///
  /// In en, this message translates to:
  /// **'Show as tiles'**
  String get viewAsTiles;

  /// No description provided for @viewAsList.
  ///
  /// In en, this message translates to:
  /// **'Show as list'**
  String get viewAsList;

  /// No description provided for @ageLabel.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get ageLabel;

  /// No description provided for @catList.
  ///
  /// In en, this message translates to:
  /// **'Cat list'**
  String get catList;

  /// No description provided for @matchCandidatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Match candidates'**
  String get matchCandidatesTitle;

  /// No description provided for @findDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Find duplicates'**
  String get findDuplicates;

  /// No description provided for @noDuplicates.
  ///
  /// In en, this message translates to:
  /// **'No possible duplicates right now.'**
  String get noDuplicates;

  /// No description provided for @similarName.
  ///
  /// In en, this message translates to:
  /// **'Similar name'**
  String get similarName;

  /// No description provided for @sharePublicly.
  ///
  /// In en, this message translates to:
  /// **'Share publicly…'**
  String get sharePublicly;

  /// No description provided for @pickFramesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick frames'**
  String get pickFramesTitle;

  /// No description provided for @suggestedFrames.
  ///
  /// In en, this message translates to:
  /// **'Suggested frames'**
  String get suggestedFrames;

  /// No description provided for @scrubFrames.
  ///
  /// In en, this message translates to:
  /// **'Scrub the video'**
  String get scrubFrames;

  /// No description provided for @keepThisFrame.
  ///
  /// In en, this message translates to:
  /// **'Keep this frame'**
  String get keepThisFrame;

  /// No description provided for @fromVideo.
  ///
  /// In en, this message translates to:
  /// **'From video…'**
  String get fromVideo;

  /// No description provided for @videoMobileOnly.
  ///
  /// In en, this message translates to:
  /// **'Picking frames from a video works in the phone app (Android and iPhone) — not on this device yet.'**
  String get videoMobileOnly;

  /// No description provided for @shareWhitelistExplainer.
  ///
  /// In en, this message translates to:
  /// **'Choose what goes into the file. Only ticked fields are included.'**
  String get shareWhitelistExplainer;

  /// No description provided for @exportShareFile.
  ///
  /// In en, this message translates to:
  /// **'Export share file…'**
  String get exportShareFile;

  /// No description provided for @hostedLink.
  ///
  /// In en, this message translates to:
  /// **'Hosted link (URL of the uploaded file)'**
  String get hostedLink;

  /// No description provided for @inlineQr.
  ///
  /// In en, this message translates to:
  /// **'Inline QR (text only, no photos)'**
  String get inlineQr;

  /// No description provided for @inlineTooBig.
  ///
  /// In en, this message translates to:
  /// **'Too much data for an inline code — untick some fields or use a hosted link.'**
  String get inlineTooBig;

  /// No description provided for @scanShareLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan share code'**
  String get scanShareLabel;

  /// No description provided for @notAShareCode.
  ///
  /// In en, this message translates to:
  /// **'That code is not a cat(a)log share.'**
  String get notAShareCode;

  /// No description provided for @importShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Import this cat?'**
  String get importShareTitle;

  /// No description provided for @shareSource.
  ///
  /// In en, this message translates to:
  /// **'Source: {url}'**
  String shareSource(String url);

  /// No description provided for @importLabel.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importLabel;

  /// No description provided for @strayAreaLabel.
  ///
  /// In en, this message translates to:
  /// **'Possible stray area'**
  String get strayAreaLabel;

  /// No description provided for @prevPin.
  ///
  /// In en, this message translates to:
  /// **'Previous pin'**
  String get prevPin;

  /// No description provided for @nextPin.
  ///
  /// In en, this message translates to:
  /// **'Next pin'**
  String get nextPin;

  /// No description provided for @noMissingCats.
  ///
  /// In en, this message translates to:
  /// **'No missing cats with flier positions yet.'**
  String get noMissingCats;

  /// No description provided for @noMatchCandidates.
  ///
  /// In en, this message translates to:
  /// **'No match candidates right now.'**
  String get noMatchCandidates;

  /// No description provided for @sameIdField.
  ///
  /// In en, this message translates to:
  /// **'Same {field}'**
  String sameIdField(String field);

  /// No description provided for @metersApart.
  ///
  /// In en, this message translates to:
  /// **'{distance} m apart'**
  String metersApart(String distance);

  /// No description provided for @addFlier.
  ///
  /// In en, this message translates to:
  /// **'Add flier'**
  String get addFlier;

  /// No description provided for @missingSinceLabel.
  ///
  /// In en, this message translates to:
  /// **'Missing since'**
  String get missingSinceLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @cropPortrait.
  ///
  /// In en, this message translates to:
  /// **'Crop portrait'**
  String get cropPortrait;

  /// No description provided for @statusOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get statusOwner;

  /// No description provided for @ocrUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Text recognition is not available on this device — type the flier text yourself.'**
  String get ocrUnavailable;

  /// No description provided for @displayFormat.
  ///
  /// In en, this message translates to:
  /// **'Shown as'**
  String get displayFormat;

  /// No description provided for @displayPlain.
  ///
  /// In en, this message translates to:
  /// **'Plain text'**
  String get displayPlain;

  /// No description provided for @displayQr.
  ///
  /// In en, this message translates to:
  /// **'QR code'**
  String get displayQr;

  /// No description provided for @displayBarcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get displayBarcode;

  /// No description provided for @editLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editLabel;

  /// No description provided for @doneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneLabel;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @notSaved.
  ///
  /// In en, this message translates to:
  /// **'Not saved'**
  String get notSaved;

  /// No description provided for @birthdateInFuture.
  ///
  /// In en, this message translates to:
  /// **'The birth date can\'t be in the future.'**
  String get birthdateInFuture;

  /// No description provided for @deceasedInFuture.
  ///
  /// In en, this message translates to:
  /// **'The date of death can\'t be in the future.'**
  String get deceasedInFuture;

  /// No description provided for @deceasedBeforeBirth.
  ///
  /// In en, this message translates to:
  /// **'The date of death can\'t be before the birth date ({date}).'**
  String deceasedBeforeBirth(String date);

  /// No description provided for @bornAfterDeceased.
  ///
  /// In en, this message translates to:
  /// **'The birth date can\'t be after the date of death ({date}).'**
  String bornAfterDeceased(String date);

  /// No description provided for @malePregnant.
  ///
  /// In en, this message translates to:
  /// **'This cat is recorded as male — a male cat can\'t be pregnant. Check the gender first.'**
  String get malePregnant;

  /// No description provided for @fatherNotMale.
  ///
  /// In en, this message translates to:
  /// **'{name} is recorded as female and can\'t be the father. Check the gender first.'**
  String fatherNotMale(String name);

  /// No description provided for @motherNotFemale.
  ///
  /// In en, this message translates to:
  /// **'{name} is recorded as male and can\'t be the mother. Check the gender first.'**
  String motherNotFemale(String name);

  /// No description provided for @parentBornAfterKitten.
  ///
  /// In en, this message translates to:
  /// **'{name} was born {date} — a parent can\'t be born after its kitten.'**
  String parentBornAfterKitten(String name, String date);

  /// No description provided for @genderFatherFemale.
  ///
  /// In en, this message translates to:
  /// **'This cat is recorded as the father of other cats — the father can\'t be female. Check the family first.'**
  String get genderFatherFemale;

  /// No description provided for @genderMotherMale.
  ///
  /// In en, this message translates to:
  /// **'This cat is recorded as the mother of other cats — the mother can\'t be male. Check the family first.'**
  String get genderMotherMale;

  /// No description provided for @moveTo.
  ///
  /// In en, this message translates to:
  /// **'Move to'**
  String get moveTo;

  /// No description provided for @noClowderStrayOption.
  ///
  /// In en, this message translates to:
  /// **'No clowder — stray / ran away'**
  String get noClowderStrayOption;

  /// No description provided for @timelineOf.
  ///
  /// In en, this message translates to:
  /// **'Timeline — {name}'**
  String timelineOf(String name);

  /// No description provided for @fieldHistoryOf.
  ///
  /// In en, this message translates to:
  /// **'{field} — {name}'**
  String fieldHistoryOf(String field, String name);

  /// No description provided for @revertThisChange.
  ///
  /// In en, this message translates to:
  /// **'Revert this change'**
  String get revertThisChange;

  /// No description provided for @revertSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restores the previous value as a new entry — history keeps both.'**
  String get revertSubtitle;

  /// No description provided for @fieldCleared.
  ///
  /// In en, this message translates to:
  /// **'{field} cleared'**
  String fieldCleared(String field);

  /// No description provided for @fieldBackTo.
  ///
  /// In en, this message translates to:
  /// **'{field} back to \"{value}\"'**
  String fieldBackTo(String field, String value);

  /// No description provided for @leftStray.
  ///
  /// In en, this message translates to:
  /// **'Left — stray'**
  String get leftStray;

  /// No description provided for @movedTo.
  ///
  /// In en, this message translates to:
  /// **'Moved to {name}'**
  String movedTo(String name);

  /// No description provided for @arrivedPlain.
  ///
  /// In en, this message translates to:
  /// **'{cat} arrived'**
  String arrivedPlain(String cat);

  /// No description provided for @arrivedFrom.
  ///
  /// In en, this message translates to:
  /// **'{cat} arrived from {place}'**
  String arrivedFrom(String cat, String place);

  /// No description provided for @leftTo.
  ///
  /// In en, this message translates to:
  /// **'{cat} left to {place}'**
  String leftTo(String cat, String place);

  /// No description provided for @duplicateMergedIn.
  ///
  /// In en, this message translates to:
  /// **'Duplicate record merged in'**
  String get duplicateMergedIn;

  /// No description provided for @asOfToday.
  ///
  /// In en, this message translates to:
  /// **'As of today'**
  String get asOfToday;

  /// No description provided for @asOfDate.
  ///
  /// In en, this message translates to:
  /// **'As of {date}'**
  String asOfDate(String date);

  /// No description provided for @dateFormatError.
  ///
  /// In en, this message translates to:
  /// **'Wrong format — use {format}'**
  String dateFormatError(String format);

  /// No description provided for @dateInFuture.
  ///
  /// In en, this message translates to:
  /// **'This date can\'t be in the future.'**
  String get dateInFuture;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @latitudeLongitude.
  ///
  /// In en, this message translates to:
  /// **'latitude, longitude'**
  String get latitudeLongitude;

  /// No description provided for @newField.
  ///
  /// In en, this message translates to:
  /// **'New field'**
  String get newField;

  /// No description provided for @fieldType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get fieldType;

  /// No description provided for @usedOn.
  ///
  /// In en, this message translates to:
  /// **'Used on'**
  String get usedOn;

  /// No description provided for @forCats.
  ///
  /// In en, this message translates to:
  /// **'cats'**
  String get forCats;

  /// No description provided for @forClowders.
  ///
  /// In en, this message translates to:
  /// **'clowders'**
  String get forClowders;

  /// No description provided for @forBoth.
  ///
  /// In en, this message translates to:
  /// **'both'**
  String get forBoth;

  /// No description provided for @optionsOnePerLine.
  ///
  /// In en, this message translates to:
  /// **'Options (one per line)'**
  String get optionsOnePerLine;

  /// No description provided for @ownValue.
  ///
  /// In en, this message translates to:
  /// **'Own value'**
  String get ownValue;

  /// No description provided for @renameField.
  ///
  /// In en, this message translates to:
  /// **'Rename field'**
  String get renameField;

  /// No description provided for @editOptions.
  ///
  /// In en, this message translates to:
  /// **'Edit options…'**
  String get editOptions;

  /// No description provided for @noStraysRightNow.
  ///
  /// In en, this message translates to:
  /// **'No strays right now.'**
  String get noStraysRightNow;

  /// No description provided for @strayCam.
  ///
  /// In en, this message translates to:
  /// **'Stray Cam'**
  String get strayCam;

  /// No description provided for @addStray.
  ///
  /// In en, this message translates to:
  /// **'Add stray'**
  String get addStray;

  /// No description provided for @newStray.
  ///
  /// In en, this message translates to:
  /// **'New stray'**
  String get newStray;

  /// No description provided for @searchByNameHint.
  ///
  /// In en, this message translates to:
  /// **'Search cats by name…'**
  String get searchByNameHint;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @hostExplainer.
  ///
  /// In en, this message translates to:
  /// **'Start here, then scan the code or type it on the other device.'**
  String get hostExplainer;

  /// No description provided for @startHosting.
  ///
  /// In en, this message translates to:
  /// **'Start hosting'**
  String get startHosting;

  /// No description provided for @stopHosting.
  ///
  /// In en, this message translates to:
  /// **'Stop hosting'**
  String get stopHosting;

  /// No description provided for @pinLabel.
  ///
  /// In en, this message translates to:
  /// **'PIN: {pin}'**
  String pinLabel(String pin);

  /// No description provided for @sessionsSoFar.
  ///
  /// In en, this message translates to:
  /// **'{count} session(s) so far'**
  String sessionsSoFar(int count);

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @addressFromHost.
  ///
  /// In en, this message translates to:
  /// **'Address (from the hosting device)'**
  String get addressFromHost;

  /// No description provided for @pin.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get pin;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get syncNow;

  /// No description provided for @addressFormatHint.
  ///
  /// In en, this message translates to:
  /// **'Address must look like 192.168.0.12:38472'**
  String get addressFormatHint;

  /// No description provided for @syncedResult.
  ///
  /// In en, this message translates to:
  /// **'Synced: {result}'**
  String syncedResult(String result);

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed: {error}'**
  String syncFailed(String error);

  /// No description provided for @lastSyncWith.
  ///
  /// In en, this message translates to:
  /// **'Last sync with {peer}: {time}'**
  String lastSyncWith(String peer, String time);

  /// No description provided for @sharedFolder.
  ///
  /// In en, this message translates to:
  /// **'Shared folder'**
  String get sharedFolder;

  /// No description provided for @sharedFolderExplainer.
  ///
  /// In en, this message translates to:
  /// **'Both devices use the same folder (for example in Dropbox or on a USB stick). Each sync stores your changes there and picks up the other side\'s.'**
  String get sharedFolderExplainer;

  /// No description provided for @noFolderChosenYet.
  ///
  /// In en, this message translates to:
  /// **'No folder chosen yet'**
  String get noFolderChosenYet;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose…'**
  String get choose;

  /// No description provided for @syncFolderNow.
  ///
  /// In en, this message translates to:
  /// **'Sync folder now'**
  String get syncFolderNow;

  /// No description provided for @folderSynced.
  ///
  /// In en, this message translates to:
  /// **'Folder synced: {result}'**
  String folderSynced(String result);

  /// No description provided for @folderSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Folder sync failed: {error}'**
  String folderSyncFailed(String error);

  /// No description provided for @recordSightingHere.
  ///
  /// In en, this message translates to:
  /// **'Record a sighting here:'**
  String get recordSightingHere;

  /// No description provided for @trailOf.
  ///
  /// In en, this message translates to:
  /// **'Trail: {name} ({count} sightings)'**
  String trailOf(String name, int count);

  /// No description provided for @conflictOn.
  ///
  /// In en, this message translates to:
  /// **'Conflict — {field}'**
  String conflictOn(String field);

  /// No description provided for @conflictBody.
  ///
  /// In en, this message translates to:
  /// **'Changed in two places at once. Pick what is true:'**
  String get conflictBody;

  /// No description provided for @mergeThisInto.
  ///
  /// In en, this message translates to:
  /// **'Merge this {kind} into…'**
  String mergeThisInto(String kind);

  /// No description provided for @noOtherToMergeInto.
  ///
  /// In en, this message translates to:
  /// **'No other {kind} to merge into.'**
  String noOtherToMergeInto(String kind);

  /// No description provided for @mergeIntoQuestion.
  ///
  /// In en, this message translates to:
  /// **'Merge into {name}?'**
  String mergeIntoQuestion(String name);

  /// No description provided for @mergeBody.
  ///
  /// In en, this message translates to:
  /// **'The two records become one. {name} keeps its current values; the other record\'s history joins its timeline. This cannot be undone.'**
  String mergeBody(String name);

  /// No description provided for @kindCat.
  ///
  /// In en, this message translates to:
  /// **'cat'**
  String get kindCat;

  /// No description provided for @kindClowder.
  ///
  /// In en, this message translates to:
  /// **'clowder'**
  String get kindClowder;

  /// No description provided for @kindField.
  ///
  /// In en, this message translates to:
  /// **'field'**
  String get kindField;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutTagline.
  ///
  /// In en, this message translates to:
  /// **'A local-first catalog for foster cats. Your data lives on your devices — no server, no account.'**
  String get aboutTagline;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({build})'**
  String versionLabel(String version, String build);

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get sourceCode;

  /// No description provided for @reportProblemOrIdea.
  ///
  /// In en, this message translates to:
  /// **'Report a problem or idea'**
  String get reportProblemOrIdea;

  /// No description provided for @githubIssues.
  ///
  /// In en, this message translates to:
  /// **'GitHub issues'**
  String get githubIssues;

  /// No description provided for @writeTheDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Write the developer'**
  String get writeTheDeveloper;

  /// No description provided for @buyCoffee.
  ///
  /// In en, this message translates to:
  /// **'Buy the developer a coffee'**
  String get buyCoffee;

  /// No description provided for @coffeeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The app stays free. Even if I don\'t get a coffee :)'**
  String get coffeeSubtitle;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get openSourceLicenses;

  /// No description provided for @machineTranslated.
  ///
  /// In en, this message translates to:
  /// **'Translations are machine-made — corrections are welcome on GitHub.'**
  String get machineTranslated;

  /// No description provided for @unnamed.
  ///
  /// In en, this message translates to:
  /// **'(unnamed)'**
  String get unnamed;

  /// No description provided for @labelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get labelName;

  /// No description provided for @labelProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile image'**
  String get labelProfileImage;

  /// No description provided for @labelPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get labelPhoto;

  /// No description provided for @starterGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get starterGender;

  /// No description provided for @starterBreed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get starterBreed;

  /// No description provided for @valueMixed.
  ///
  /// In en, this message translates to:
  /// **'mixed'**
  String get valueMixed;

  /// No description provided for @breedEuropeanShorthair.
  ///
  /// In en, this message translates to:
  /// **'European Shorthair'**
  String get breedEuropeanShorthair;

  /// No description provided for @breedMaineCoon.
  ///
  /// In en, this message translates to:
  /// **'Maine Coon'**
  String get breedMaineCoon;

  /// No description provided for @breedBritishShorthair.
  ///
  /// In en, this message translates to:
  /// **'British Shorthair'**
  String get breedBritishShorthair;

  /// No description provided for @breedNorwegianForestCat.
  ///
  /// In en, this message translates to:
  /// **'Norwegian Forest Cat'**
  String get breedNorwegianForestCat;

  /// No description provided for @breedRagdoll.
  ///
  /// In en, this message translates to:
  /// **'Ragdoll'**
  String get breedRagdoll;

  /// No description provided for @breedSiamese.
  ///
  /// In en, this message translates to:
  /// **'Siamese'**
  String get breedSiamese;

  /// No description provided for @breedPersian.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get breedPersian;

  /// No description provided for @breedBengal.
  ///
  /// In en, this message translates to:
  /// **'Bengal'**
  String get breedBengal;

  /// No description provided for @breedSphynx.
  ///
  /// In en, this message translates to:
  /// **'Sphynx'**
  String get breedSphynx;

  /// No description provided for @starterColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get starterColor;

  /// No description provided for @starterNeutered.
  ///
  /// In en, this message translates to:
  /// **'Neutered'**
  String get starterNeutered;

  /// No description provided for @starterPregnant.
  ///
  /// In en, this message translates to:
  /// **'Pregnant'**
  String get starterPregnant;

  /// No description provided for @starterBirthdate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get starterBirthdate;

  /// No description provided for @starterDeceased.
  ///
  /// In en, this message translates to:
  /// **'Deceased'**
  String get starterDeceased;

  /// No description provided for @starterAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get starterAddress;

  /// No description provided for @starterResponsible.
  ///
  /// In en, this message translates to:
  /// **'Responsible person'**
  String get starterResponsible;

  /// No description provided for @starterEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get starterEmail;

  /// No description provided for @starterPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get starterPhone;

  /// No description provided for @lookupUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Lookup link'**
  String get lookupUrlLabel;

  /// No description provided for @lookupUrlHelp.
  ///
  /// In en, this message translates to:
  /// **'The service\'s page with {token} where the number goes, e.g. https://www.tasso.net/Tierregister/Suchmeldungen?snr={token}'**
  String lookupUrlHelp(String token);

  /// No description provided for @lookUpId.
  ///
  /// In en, this message translates to:
  /// **'Look up'**
  String get lookUpId;

  /// No description provided for @lookupFailed.
  ///
  /// In en, this message translates to:
  /// **'No app could open {url}. Copy the link into a browser.'**
  String lookupFailed(String url);

  /// No description provided for @stepCat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get stepCat;

  /// No description provided for @stepOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get stepOwner;

  /// No description provided for @stepFace.
  ///
  /// In en, this message translates to:
  /// **'Face photo'**
  String get stepFace;

  /// No description provided for @stepRegistry.
  ///
  /// In en, this message translates to:
  /// **'Registry'**
  String get stepRegistry;

  /// No description provided for @stepReview.
  ///
  /// In en, this message translates to:
  /// **'Check and save'**
  String get stepReview;

  /// No description provided for @stepOwnerHint.
  ///
  /// In en, this message translates to:
  /// **'Whoever is missing the cat — this becomes their clowder, with the contact from the poster.'**
  String get stepOwnerHint;

  /// No description provided for @stepFaceHint.
  ///
  /// In en, this message translates to:
  /// **'Cut the cat\'s face out of the poster; it becomes the profile picture. You can skip this.'**
  String get stepFaceHint;

  /// No description provided for @stepRegistryHint.
  ///
  /// In en, this message translates to:
  /// **'Numbers found on the poster. Ticked ones are saved with the cat and can be opened later.'**
  String get stepRegistryHint;

  /// No description provided for @noRegistryLinks.
  ///
  /// In en, this message translates to:
  /// **'No registry links on this poster — if any were missed, please report a bug.'**
  String get noRegistryLinks;

  /// No description provided for @unknownServiceHint.
  ///
  /// In en, this message translates to:
  /// **'Unknown service'**
  String get unknownServiceHint;

  /// No description provided for @rememberService.
  ///
  /// In en, this message translates to:
  /// **'Remember service'**
  String get rememberService;

  /// No description provided for @rememberServiceHint.
  ///
  /// In en, this message translates to:
  /// **'Name the service and point at the number in the link. The next poster from it fills itself.'**
  String get rememberServiceHint;

  /// No description provided for @noIdInLink.
  ///
  /// In en, this message translates to:
  /// **'This link carries no number the app could store.'**
  String get noIdInLink;

  /// No description provided for @whichNumber.
  ///
  /// In en, this message translates to:
  /// **'Which part is the number?'**
  String get whichNumber;

  /// No description provided for @cropAgain.
  ///
  /// In en, this message translates to:
  /// **'Crop again'**
  String get cropAgain;

  /// No description provided for @noFaceYet.
  ///
  /// In en, this message translates to:
  /// **'No face photo yet — the poster photo is used instead.'**
  String get noFaceYet;

  /// No description provided for @backLabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backLabel;

  /// No description provided for @dangerButton.
  ///
  /// In en, this message translates to:
  /// **'DON\'T PRESS.\nDANGER'**
  String get dangerButton;

  /// No description provided for @dangerThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using cat(a)log!'**
  String get dangerThanks;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpTitle;

  /// No description provided for @showTipsAgain.
  ///
  /// In en, this message translates to:
  /// **'Show tips again'**
  String get showTipsAgain;

  /// No description provided for @helpHome.
  ///
  /// In en, this message translates to:
  /// **'This is the overview of your clowders — a clowder is a place where cats live: your home, a foster home, a shelter. Tap a card to see its cats; long-press for its menu. The button at the bottom right creates a new clowder, and the strays card collects every cat that currently has no home. The name at the top is the catalog you are in — tap it to switch or add one.'**
  String get helpHome;

  /// No description provided for @helpClowder.
  ///
  /// In en, this message translates to:
  /// **'Everything about this place: its cats, its fields (address, contact, type) and its history. The page opens read-only; the pencil turns on editing, where you can also add a new field. Long-press a field to edit it directly, and long-press a cat to move, hide, or open it. An appointment added here can carry several cats of the clowder — a vet run for neutering, for example: tick the cats that come along, finish once, untick the ones that were not treated.'**
  String get helpClowder;

  /// No description provided for @helpCat.
  ///
  /// In en, this message translates to:
  /// **'Everything about this cat: photos, fields, family, history. The page is read-only until you tap the pencil. Long-press a field to jump straight into editing it; long-press a photo for its menu. The menu in the top right holds the rest: hide, merge, record a sighting, share the cat. Private is set while editing a field.'**
  String get helpCat;

  /// No description provided for @helpStrays.
  ///
  /// In en, this message translates to:
  /// **'Cats with no home right now: found cats, escaped cats, cats from a poster. The camera button records a cat you see in front of you; the poster button turns a missing-cat flier into a cat with its owner\'s contact; the scanner reads a cat(a)log code from a poster.'**
  String get helpStrays;

  /// No description provided for @helpMap.
  ///
  /// In en, this message translates to:
  /// **'Every cat and place with a position. Search finds cats, people, and places — an unknown name is looked up worldwide. The layers button draws the 500 m circles around a missing cat\'s poster spots and the home it ran from. The arrows walk from pin to pin, long-press the map to record a sighting.'**
  String get helpMap;

  /// No description provided for @helpCard.
  ///
  /// In en, this message translates to:
  /// **'The printable card of this cat: pick what appears on it with the chips at the top, then share it as an image or a PDF. IDs can print as a QR or a barcode, and a position becomes a QR that opens a map plus a short Plus Code.'**
  String get helpCard;

  /// No description provided for @helpSync.
  ///
  /// In en, this message translates to:
  /// **'Getting data to other people: meet and connect directly, use a folder both devices see, or send a file through a messenger. You always decide what to send, and receiving a .catsync file happens here too.'**
  String get helpSync;

  /// No description provided for @helpFields.
  ///
  /// In en, this message translates to:
  /// **'The fields your catalog uses. Rename them, change the options of a choice field, or add your own. ID fields can point at a service (a registry), so the number becomes tappable on the cat.'**
  String get helpFields;

  /// No description provided for @helpTimeline.
  ///
  /// In en, this message translates to:
  /// **'Every change ever made, newest first: who changed what, when, and to which value. Any entry can be reverted — that writes a new entry, nothing is ever erased.'**
  String get helpTimeline;

  /// No description provided for @helpDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Cats or clowders that look like the same one twice — identical IDs, or very similar names with matching details. Tap a pair to merge it; merging cannot be undone, so it asks first.'**
  String get helpDuplicates;

  /// No description provided for @helpMatches.
  ///
  /// In en, this message translates to:
  /// **'Cats that might be the same animal: an identical ID, or a stray seen inside a missing cat\'s search area. Tap a pair to merge it, long-press to open the first cat and compare.'**
  String get helpMatches;

  /// No description provided for @helpFlier.
  ///
  /// In en, this message translates to:
  /// **'A photographed missing-cat poster becomes a cat plus its owner. Step by step: the cat\'s data, the owner\'s contact, a face crop for the profile picture, any registry numbers on the poster, then a final check. Everything is a suggestion — correct whatever the camera got wrong.'**
  String get helpFlier;

  /// No description provided for @archiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveTitle;

  /// No description provided for @archiveExplainer.
  ///
  /// In en, this message translates to:
  /// **'Deceased cats and empty clowders that nobody has touched in years still cost space — their photos most of all. Archiving writes them into a file you keep and then deletes them here.'**
  String get archiveExplainer;

  /// No description provided for @archiveAction.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveAction;

  /// No description provided for @archiveSelected.
  ///
  /// In en, this message translates to:
  /// **'Archive {count} entries'**
  String archiveSelected(int count);

  /// No description provided for @archiveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive {count} entries?'**
  String archiveConfirmTitle(int count);

  /// No description provided for @archiveConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'{names} will be written into a file and then deleted — on your device and on every device you sync with. Importing the file brings everything back; without it, they are gone.'**
  String archiveConfirmBody(String names);

  /// No description provided for @archiveDone.
  ///
  /// In en, this message translates to:
  /// **'{count} entries archived and deleted'**
  String archiveDone(int count);

  /// No description provided for @archiveFailed.
  ///
  /// In en, this message translates to:
  /// **'Nothing was deleted: the archive file could not be written ({error}).'**
  String archiveFailed(String error);

  /// No description provided for @storageLine.
  ///
  /// In en, this message translates to:
  /// **'Database {db}, photos {photos} in {count} files'**
  String storageLine(String db, String photos, int count);

  /// No description provided for @quietForYears.
  ///
  /// In en, this message translates to:
  /// **'Quiet for {years} years'**
  String quietForYears(int years);

  /// No description provided for @nothingToArchive.
  ///
  /// In en, this message translates to:
  /// **'Nothing old enough to archive.'**
  String get nothingToArchive;

  /// No description provided for @archiveCandidateLine.
  ///
  /// In en, this message translates to:
  /// **'Last change {date} · photos {size}'**
  String archiveCandidateLine(String date, String size);

  /// No description provided for @helpArchive.
  ///
  /// In en, this message translates to:
  /// **'Old data costs space, above all the photos, which every synced device carries. Here you pick deceased cats and empty clowders that have been quiet for years, write them into a file you keep, and delete them. The deletion reaches everyone you sync with; importing the file restores everything.'**
  String get helpArchive;

  /// No description provided for @restoreDeletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore {count} deleted entries?'**
  String restoreDeletedTitle(int count);

  /// No description provided for @restoreDeletedBody.
  ///
  /// In en, this message translates to:
  /// **'{names} are deleted in this catalog, and the file you just imported carries them. Restoring brings them back here and on every device you sync with.'**
  String restoreDeletedBody(String names);

  /// No description provided for @restoreAction.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreAction;

  /// No description provided for @keepDeleted.
  ///
  /// In en, this message translates to:
  /// **'Keep deleted'**
  String get keepDeleted;

  /// No description provided for @archiveNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Nothing was deleted: the archive was not saved anywhere.'**
  String get archiveNotSaved;

  /// No description provided for @locateAddress.
  ///
  /// In en, this message translates to:
  /// **'Find address on the map'**
  String get locateAddress;

  /// No description provided for @addressLocated.
  ///
  /// In en, this message translates to:
  /// **'Address found'**
  String get addressLocated;

  /// No description provided for @addressNotFound.
  ///
  /// In en, this message translates to:
  /// **'No place found for this address. Check the spelling, or leave it empty.'**
  String get addressNotFound;

  /// No description provided for @starterPosition.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get starterPosition;

  /// No description provided for @valueYes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get valueYes;

  /// No description provided for @valueNo.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get valueNo;

  /// No description provided for @valueFemale.
  ///
  /// In en, this message translates to:
  /// **'female'**
  String get valueFemale;

  /// No description provided for @valueMale.
  ///
  /// In en, this message translates to:
  /// **'male'**
  String get valueMale;

  /// No description provided for @valueUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get valueUnknown;

  /// No description provided for @cropTitle.
  ///
  /// In en, this message translates to:
  /// **'Crop photo'**
  String get cropTitle;

  /// No description provided for @markTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark the cat'**
  String get markTitle;

  /// No description provided for @applyCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get applyCrop;

  /// No description provided for @useFullPhoto.
  ///
  /// In en, this message translates to:
  /// **'Use full photo'**
  String get useFullPhoto;

  /// No description provided for @dragToSelect.
  ///
  /// In en, this message translates to:
  /// **'Drag a rectangle around the cat'**
  String get dragToSelect;

  /// No description provided for @dragOverTheCat.
  ///
  /// In en, this message translates to:
  /// **'Drag an ellipse over the cat'**
  String get dragOverTheCat;

  /// No description provided for @cropPhoto.
  ///
  /// In en, this message translates to:
  /// **'Crop…'**
  String get cropPhoto;

  /// No description provided for @markPhoto.
  ///
  /// In en, this message translates to:
  /// **'Mark…'**
  String get markPhoto;

  /// No description provided for @scanCode.
  ///
  /// In en, this message translates to:
  /// **'Scan code'**
  String get scanCode;

  /// No description provided for @orTypeCode.
  ///
  /// In en, this message translates to:
  /// **'Or type the code'**
  String get orTypeCode;

  /// No description provided for @copyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copyCode;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'That code is not valid'**
  String get invalidCode;

  /// No description provided for @hotspotHint.
  ///
  /// In en, this message translates to:
  /// **'No shared Wi-Fi? Turn on one phone\'s hotspot, connect the other phone to it, then host here.'**
  String get hotspotHint;

  /// No description provided for @byMessenger.
  ///
  /// In en, this message translates to:
  /// **'By messenger'**
  String get byMessenger;

  /// No description provided for @byMessengerExplainer.
  ///
  /// In en, this message translates to:
  /// **'Send your whole catalog as one file through WhatsApp, Signal, or mail — the other side imports it.'**
  String get byMessengerExplainer;

  /// No description provided for @shareBundle.
  ///
  /// In en, this message translates to:
  /// **'Share sync bundle…'**
  String get shareBundle;

  /// No description provided for @importBundle.
  ///
  /// In en, this message translates to:
  /// **'Import sync bundle…'**
  String get importBundle;

  /// No description provided for @bundleImported.
  ///
  /// In en, this message translates to:
  /// **'Bundle imported: {result}'**
  String bundleImported(String result);

  /// No description provided for @lastBackupFailed.
  ///
  /// In en, this message translates to:
  /// **'Last automatic backup failed: {error}'**
  String lastBackupFailed(String error);

  /// No description provided for @bundleImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String bundleImportFailed(String error);

  /// No description provided for @pickOnMap.
  ///
  /// In en, this message translates to:
  /// **'Pick on map'**
  String get pickOnMap;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @iosLocalNetworkHint.
  ///
  /// In en, this message translates to:
  /// **'If it keeps failing on iPhone/iPad: Settings → Privacy & Security → Local Network → allow cat(a)log, then try again.'**
  String get iosLocalNetworkHint;

  /// No description provided for @includePrivate.
  ///
  /// In en, this message translates to:
  /// **'Share private data'**
  String get includePrivate;

  /// No description provided for @hideLabel.
  ///
  /// In en, this message translates to:
  /// **'Hide on this device'**
  String get hideLabel;

  /// No description provided for @unhideLabel.
  ///
  /// In en, this message translates to:
  /// **'Show again'**
  String get unhideLabel;

  /// No description provided for @showHiddenLabel.
  ///
  /// In en, this message translates to:
  /// **'Show hidden'**
  String get showHiddenLabel;

  /// No description provided for @stopShowingHidden.
  ///
  /// In en, this message translates to:
  /// **'Stop showing hidden'**
  String get stopShowingHidden;

  /// No description provided for @starterSpecies.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get starterSpecies;

  /// No description provided for @starterStatus.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get starterStatus;

  /// No description provided for @statusFoster.
  ///
  /// In en, this message translates to:
  /// **'Foster home'**
  String get statusFoster;

  /// No description provided for @statusForeverHome.
  ///
  /// In en, this message translates to:
  /// **'Forever home'**
  String get statusForeverHome;

  /// No description provided for @statusClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get statusClinic;

  /// No description provided for @statusShelter.
  ///
  /// In en, this message translates to:
  /// **'Shelter'**
  String get statusShelter;

  /// No description provided for @statusBarn.
  ///
  /// In en, this message translates to:
  /// **'Barn'**
  String get statusBarn;

  /// No description provided for @valueCat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get valueCat;

  /// No description provided for @otherOption.
  ///
  /// In en, this message translates to:
  /// **'Other…'**
  String get otherOption;

  /// No description provided for @celebrationsToggle.
  ///
  /// In en, this message translates to:
  /// **'Celebrate adoptions'**
  String get celebrationsToggle;

  /// No description provided for @celebrationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Confetti and a cheer when a cat moves into a forever home'**
  String get celebrationsSubtitle;

  /// No description provided for @onMapLabel.
  ///
  /// In en, this message translates to:
  /// **'On the map'**
  String get onMapLabel;

  /// No description provided for @showOnMap.
  ///
  /// In en, this message translates to:
  /// **'Show on map'**
  String get showOnMap;

  /// No description provided for @searchPlaceHint.
  ///
  /// In en, this message translates to:
  /// **'Search place or address'**
  String get searchPlaceHint;

  /// No description provided for @noPlacesFound.
  ///
  /// In en, this message translates to:
  /// **'No places found'**
  String get noPlacesFound;

  /// No description provided for @mapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search cats, clowders, people'**
  String get mapSearchHint;

  /// No description provided for @proposeAnotherName.
  ///
  /// In en, this message translates to:
  /// **'Propose another name'**
  String get proposeAnotherName;

  /// No description provided for @moderationTitle.
  ///
  /// In en, this message translates to:
  /// **'Authors & bans'**
  String get moderationTitle;

  /// No description provided for @moderationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove a person\'s data for good'**
  String get moderationSubtitle;

  /// No description provided for @authorsSection.
  ///
  /// In en, this message translates to:
  /// **'Who wrote into this catalog'**
  String get authorsSection;

  /// No description provided for @hardDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete everything by this author'**
  String get hardDeleteAction;

  /// No description provided for @hardDeleteWarning.
  ///
  /// In en, this message translates to:
  /// **'Removes every entry and photo by {name} from this device. Other devices keep theirs. This cannot be undone.'**
  String hardDeleteWarning(Object name);

  /// No description provided for @typeToConfirm.
  ///
  /// In en, this message translates to:
  /// **'Type {name} to confirm'**
  String typeToConfirm(Object name);

  /// No description provided for @alsoBan.
  ///
  /// In en, this message translates to:
  /// **'Also ban — never accept their data again'**
  String get alsoBan;

  /// No description provided for @bansSection.
  ///
  /// In en, this message translates to:
  /// **'Bans'**
  String get bansSection;

  /// No description provided for @unbanAction.
  ///
  /// In en, this message translates to:
  /// **'Remove ban'**
  String get unbanAction;

  /// No description provided for @deletedDone.
  ///
  /// In en, this message translates to:
  /// **'Deleted.'**
  String get deletedDone;

  /// No description provided for @syncSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'What arrived'**
  String get syncSummaryTitle;

  /// No description provided for @summaryAdopted.
  ///
  /// In en, this message translates to:
  /// **'Adopted'**
  String get summaryAdopted;

  /// No description provided for @summaryDeceased.
  ///
  /// In en, this message translates to:
  /// **'Deceased'**
  String get summaryDeceased;

  /// No description provided for @summaryEscaped.
  ///
  /// In en, this message translates to:
  /// **'Escaped'**
  String get summaryEscaped;

  /// No description provided for @summaryNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get summaryNew;

  /// No description provided for @summaryConflicts.
  ///
  /// In en, this message translates to:
  /// **'Conflicts to resolve'**
  String get summaryConflicts;

  /// No description provided for @summaryOther.
  ///
  /// In en, this message translates to:
  /// **'…and {n} other changes'**
  String summaryOther(Object n);

  /// No description provided for @starterMother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get starterMother;

  /// No description provided for @starterFather.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get starterFather;

  /// No description provided for @familySection.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get familySection;

  /// No description provided for @littermatesLabel.
  ///
  /// In en, this message translates to:
  /// **'Littermates'**
  String get littermatesLabel;

  /// No description provided for @siblingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Siblings'**
  String get siblingsLabel;

  /// No description provided for @kittensLabel.
  ///
  /// In en, this message translates to:
  /// **'Kittens'**
  String get kittensLabel;

  /// No description provided for @toastSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'What to announce'**
  String get toastSettingsTitle;

  /// No description provided for @toastSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Little messages after a sync'**
  String get toastSettingsSubtitle;

  /// No description provided for @toastKindAdoptions.
  ///
  /// In en, this message translates to:
  /// **'Adoptions'**
  String get toastKindAdoptions;

  /// No description provided for @toastKindBirths.
  ///
  /// In en, this message translates to:
  /// **'Births'**
  String get toastKindBirths;

  /// No description provided for @toastKindDeaths.
  ///
  /// In en, this message translates to:
  /// **'Deaths'**
  String get toastKindDeaths;

  /// No description provided for @toastKindEscapes.
  ///
  /// In en, this message translates to:
  /// **'Escapes'**
  String get toastKindEscapes;

  /// No description provided for @toastKindMoves.
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get toastKindMoves;

  /// No description provided for @toastAdopted.
  ///
  /// In en, this message translates to:
  /// **'💚 {cat} adopted by {home} 💚'**
  String toastAdopted(Object cat, Object home);

  /// No description provided for @toastBorn.
  ///
  /// In en, this message translates to:
  /// **'✨ New kitten: {cat} ✨'**
  String toastBorn(Object cat);

  /// No description provided for @toastDeceased.
  ///
  /// In en, this message translates to:
  /// **'{cat} has passed away'**
  String toastDeceased(Object cat);

  /// No description provided for @toastEscaped.
  ///
  /// In en, this message translates to:
  /// **'{cat} has escaped'**
  String toastEscaped(Object cat);

  /// No description provided for @toastMoved.
  ///
  /// In en, this message translates to:
  /// **'{cat} moved to {home}'**
  String toastMoved(Object cat, Object home);

  /// No description provided for @notACatlogFile.
  ///
  /// In en, this message translates to:
  /// **'That\'s not a cat(a)log file'**
  String get notACatlogFile;

  /// No description provided for @nothingNewInBundle.
  ///
  /// In en, this message translates to:
  /// **'Nothing new in that file — you already have everything'**
  String get nothingNewInBundle;

  /// No description provided for @syncChooserInPerson.
  ///
  /// In en, this message translates to:
  /// **'In person'**
  String get syncChooserInPerson;

  /// No description provided for @syncChooserInPersonSub.
  ///
  /// In en, this message translates to:
  /// **'Sync via WiFi'**
  String get syncChooserInPersonSub;

  /// No description provided for @syncChooserRemote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get syncChooserRemote;

  /// No description provided for @syncChooserRemoteSub.
  ///
  /// In en, this message translates to:
  /// **'Sync via folder or USB stick'**
  String get syncChooserRemoteSub;

  /// No description provided for @syncChooserMessenger.
  ///
  /// In en, this message translates to:
  /// **'Messenger'**
  String get syncChooserMessenger;

  /// No description provided for @syncChooserMessengerSub.
  ///
  /// In en, this message translates to:
  /// **'Export and import via social media'**
  String get syncChooserMessengerSub;

  /// No description provided for @connectToWifiFirst.
  ///
  /// In en, this message translates to:
  /// **'Connect to a Wi-Fi first — then devices can find each other'**
  String get connectToWifiFirst;

  /// No description provided for @trustQuestion.
  ///
  /// In en, this message translates to:
  /// **'{author} ({device}) wants to sync'**
  String trustQuestion(Object author, Object device);

  /// No description provided for @trustBothWaysNote.
  ///
  /// In en, this message translates to:
  /// **'Your catalogs will be exchanged in both directions.'**
  String get trustBothWaysNote;

  /// No description provided for @allowOnce.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allowOnce;

  /// No description provided for @allowAlways.
  ///
  /// In en, this message translates to:
  /// **'Always allow this device'**
  String get allowAlways;

  /// No description provided for @declineAction.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get declineAction;

  /// No description provided for @syncDeclined.
  ///
  /// In en, this message translates to:
  /// **'The other device declined the sync'**
  String get syncDeclined;

  /// No description provided for @trustedDevicesSection.
  ///
  /// In en, this message translates to:
  /// **'Always-allowed devices'**
  String get trustedDevicesSection;

  /// No description provided for @removeTrust.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeTrust;

  /// No description provided for @hostWithoutWifi.
  ///
  /// In en, this message translates to:
  /// **'Host without Wi-Fi'**
  String get hostWithoutWifi;

  /// No description provided for @hotspotJoinNote.
  ///
  /// In en, this message translates to:
  /// **'Joins a temporary direct connection to the other phone (no internet). Only cat(a)log uses it, and it disconnects by itself after the sync.'**
  String get hotspotJoinNote;

  /// No description provided for @hotspotAndroidOnly.
  ///
  /// In en, this message translates to:
  /// **'This code needs two Android phones — on iPhone/iPad, use a shared Wi-Fi instead'**
  String get hotspotAndroidOnly;

  /// No description provided for @selectClowderHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a clowder on the left'**
  String get selectClowderHint;

  /// No description provided for @introTitle1.
  ///
  /// In en, this message translates to:
  /// **'Your cats, organized'**
  String get introTitle1;

  /// No description provided for @introBody1.
  ///
  /// In en, this message translates to:
  /// **'Create a card for every cat you care for: photo, gender, health, anything worth noting. Cats are grouped by where they live — the app calls such a place a clowder.'**
  String get introBody1;

  /// No description provided for @introTitle2.
  ///
  /// In en, this message translates to:
  /// **'Works without internet'**
  String get introTitle2;

  /// No description provided for @introBody2.
  ///
  /// In en, this message translates to:
  /// **'Everything is saved on your phone only. No account, no cloud. Nothing is uploaded unless you share it yourself.'**
  String get introBody2;

  /// No description provided for @introTitle3.
  ///
  /// In en, this message translates to:
  /// **'Work together'**
  String get introTitle3;

  /// No description provided for @introBody3.
  ///
  /// In en, this message translates to:
  /// **'Everyone uses their own app and you swap data now and then: meet and scan a code, use a shared folder, or send one file by messenger. Afterwards everyone has the same information.'**
  String get introBody3;

  /// No description provided for @introSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get introSkip;

  /// No description provided for @introNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get introNext;

  /// No description provided for @introDone.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go'**
  String get introDone;

  /// No description provided for @introReplayTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick intro'**
  String get introReplayTitle;

  /// No description provided for @spotHomeSync.
  ///
  /// In en, this message translates to:
  /// **'Sync with people you know here. You decide what you share.'**
  String get spotHomeSync;

  /// No description provided for @spotHomeStrays.
  ///
  /// In en, this message translates to:
  /// **'This card collects all strays — cats without a home. Tap it to see the list.'**
  String get spotHomeStrays;

  /// No description provided for @spotHomeMenu.
  ///
  /// In en, this message translates to:
  /// **'In this menu: find and merge duplicate entries, export CSV, and more.'**
  String get spotHomeMenu;

  /// No description provided for @spotCatEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap the pencil to edit this cat. Tip: long-press any field to edit it directly.'**
  String get spotCatEdit;

  /// No description provided for @spotMapLayers.
  ///
  /// In en, this message translates to:
  /// **'Searching for a missing cat? Show circles around its poster spots and the home it ran from.'**
  String get spotMapLayers;

  /// No description provided for @spotStraysFlier.
  ///
  /// In en, this message translates to:
  /// **'Found a missing-cat poster? Photograph it here — the app saves cat and contact for you.'**
  String get spotStraysFlier;

  /// No description provided for @spotStraysScan.
  ///
  /// In en, this message translates to:
  /// **'Some posters carry a cat(a)log QR code. Scan it here to import the cat without typing.'**
  String get spotStraysScan;

  /// No description provided for @introTitle4.
  ///
  /// In en, this message translates to:
  /// **'Find missing cats'**
  String get introTitle4;

  /// No description provided for @introBody4.
  ///
  /// In en, this message translates to:
  /// **'See a missing-cat poster? Photograph it in the app: it saves the cat, the owner\'s contact, and the place. When a similar stray turns up later, the app suggests possible matches.'**
  String get introBody4;

  /// No description provided for @spotMapSearch.
  ///
  /// In en, this message translates to:
  /// **'Type a cat, place, or person here to jump to it on the map.'**
  String get spotMapSearch;

  /// No description provided for @spotCardChips.
  ///
  /// In en, this message translates to:
  /// **'Tick what should appear on the shareable card — everything else stays off it.'**
  String get spotCardChips;

  /// No description provided for @spotCatMenu.
  ///
  /// In en, this message translates to:
  /// **'More actions live here: hide the cat, merge duplicates, or record a sighting.'**
  String get spotCatMenu;

  /// No description provided for @spotDone.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get spotDone;

  /// No description provided for @spotReplayTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s new tour'**
  String get spotReplayTitle;

  /// No description provided for @spotReplaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show the highlights again on each page'**
  String get spotReplaySubtitle;

  /// No description provided for @spotReplayDone.
  ///
  /// In en, this message translates to:
  /// **'The highlights will show again'**
  String get spotReplayDone;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No cat found with that name'**
  String get searchNoResults;

  /// No description provided for @syncUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the other device. Are both on the same Wi-Fi?'**
  String get syncUnreachable;

  /// No description provided for @folderUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the folder. Is the drive or cloud folder still there?'**
  String get folderUnreachable;

  /// No description provided for @crashTitle.
  ///
  /// In en, this message translates to:
  /// **'That should not have happened'**
  String get crashTitle;

  /// No description provided for @crashBody.
  ///
  /// In en, this message translates to:
  /// **'cat(a)log hit an unexpected error. Your data is safe — everything is saved the moment you change it. Restart the app, and if this keeps happening, send the report so it can be fixed.'**
  String get crashBody;

  /// No description provided for @crashRestart.
  ///
  /// In en, this message translates to:
  /// **'Restart the app'**
  String get crashRestart;

  /// No description provided for @crashSendReport.
  ///
  /// In en, this message translates to:
  /// **'Send report to the developer'**
  String get crashSendReport;

  /// No description provided for @crashLastRunBody.
  ///
  /// In en, this message translates to:
  /// **'cat(a)log stopped unexpectedly last time — most likely it ran out of memory. Send a short report so it can be fixed?'**
  String get crashLastRunBody;

  /// No description provided for @catalogsTitle.
  ///
  /// In en, this message translates to:
  /// **'Catalogs'**
  String get catalogsTitle;

  /// No description provided for @newCatalog.
  ///
  /// In en, this message translates to:
  /// **'New catalog'**
  String get newCatalog;

  /// No description provided for @catalogNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Catalog name'**
  String get catalogNameLabel;

  /// No description provided for @catalogNameTaken.
  ///
  /// In en, this message translates to:
  /// **'A catalog called {name} already exists. Pick a different name.'**
  String catalogNameTaken(String name);

  /// No description provided for @manageCatalogs.
  ///
  /// In en, this message translates to:
  /// **'Manage catalogs'**
  String get manageCatalogs;

  /// No description provided for @helpCatalogs.
  ///
  /// In en, this message translates to:
  /// **'A catalog is a world of its own: its own cats, clowders, fields, photos and sync partners. Berlin and Paris never mix. Tap the name at the top of the home screen to switch, add one, or rename it. Your name, your language and the tips you have already seen are shared by all of them.'**
  String get helpCatalogs;

  /// No description provided for @spotHomeCatalog.
  ///
  /// In en, this message translates to:
  /// **'This is the catalog you are in. Tap the name to switch, or to make another one.'**
  String get spotHomeCatalog;

  /// No description provided for @deleteCatalog.
  ///
  /// In en, this message translates to:
  /// **'Delete catalog'**
  String get deleteCatalog;

  /// No description provided for @deleteCatalogBody.
  ///
  /// In en, this message translates to:
  /// **'Everything in {name} goes: its cats, its photos, its history. A complete file is saved first, where the automatic backups go, so importing that file brings the catalog back. Type the name to confirm.'**
  String deleteCatalogBody(String name);

  /// No description provided for @catalogDeleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted. The file is in {where}.'**
  String catalogDeleted(String name, String where);

  /// No description provided for @typeTheName.
  ///
  /// In en, this message translates to:
  /// **'Type {name}'**
  String typeTheName(String name);

  /// No description provided for @catalogExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Nothing was deleted: the catalog file could not be written ({error}). Free some space or pick another moment, then try again.'**
  String catalogExportFailed(String error);

  /// No description provided for @moveToCatalog.
  ///
  /// In en, this message translates to:
  /// **'Move to another catalog'**
  String get moveToCatalog;

  /// No description provided for @movedToCatalog.
  ///
  /// In en, this message translates to:
  /// **'{count} moved to {name}'**
  String movedToCatalog(int count, String name);

  /// No description provided for @chooseWhatToMove.
  ///
  /// In en, this message translates to:
  /// **'What should move?'**
  String get chooseWhatToMove;

  /// No description provided for @moveIntoNewCatalog.
  ///
  /// In en, this message translates to:
  /// **'Move something into {name}?'**
  String moveIntoNewCatalog(String name);

  /// No description provided for @undoThisImport.
  ///
  /// In en, this message translates to:
  /// **'Undo this import'**
  String get undoThisImport;

  /// No description provided for @undoImportBody.
  ///
  /// In en, this message translates to:
  /// **'The {count} change(s) this import brought in are removed. They are written to a file first, so importing that file puts them back. People you already synced with keep their copy — that cannot be unsent.'**
  String undoImportBody(int count);

  /// No description provided for @undoneImport.
  ///
  /// In en, this message translates to:
  /// **'Undone. The file is in {where}.'**
  String undoneImport(String where);

  /// No description provided for @goBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBackTitle;

  /// No description provided for @goBackToHere.
  ///
  /// In en, this message translates to:
  /// **'Go back to here'**
  String get goBackToHere;

  /// No description provided for @momentImport.
  ///
  /// In en, this message translates to:
  /// **'Before importing'**
  String get momentImport;

  /// No description provided for @momentSync.
  ///
  /// In en, this message translates to:
  /// **'Before syncing'**
  String get momentSync;

  /// No description provided for @momentMerge.
  ///
  /// In en, this message translates to:
  /// **'Before merging'**
  String get momentMerge;

  /// No description provided for @momentHardDelete.
  ///
  /// In en, this message translates to:
  /// **'Before deleting an author’s data'**
  String get momentHardDelete;

  /// No description provided for @momentArchive.
  ///
  /// In en, this message translates to:
  /// **'Before archiving'**
  String get momentArchive;

  /// No description provided for @momentManual.
  ///
  /// In en, this message translates to:
  /// **'Marked by you'**
  String get momentManual;

  /// No description provided for @showOlderMoments.
  ///
  /// In en, this message translates to:
  /// **'Show older'**
  String get showOlderMoments;

  /// No description provided for @goBackBody.
  ///
  /// In en, this message translates to:
  /// **'Everything after this moment is removed — {count} change(s). They are written to a file first, so importing it puts them back, and every moment newer than this one goes with them. People you already synced with keep their copy — that cannot be unsent.'**
  String goBackBody(int count);

  /// No description provided for @nameThisMoment.
  ///
  /// In en, this message translates to:
  /// **'Name this moment'**
  String get nameThisMoment;

  /// No description provided for @helpGoBack.
  ///
  /// In en, this message translates to:
  /// **'The moments this catalog changed shape: before every import and every sync, before a merge, an archive or a deletion, and whenever you marked one yourself. Choosing one returns the catalog to that state — everything after it is written to a file you keep and then removed, and every newer moment goes with it. People you already synced with keep what they received.'**
  String get helpGoBack;

  /// No description provided for @goBackFileFailed.
  ///
  /// In en, this message translates to:
  /// **'Nothing was removed: the file that keeps it could not be written ({error}). Free some space and try again.'**
  String goBackFileFailed(String error);

  /// No description provided for @switchBeforeDeleting.
  ///
  /// In en, this message translates to:
  /// **'This is the catalog you are in. Switch to another one, then delete it.'**
  String get switchBeforeDeleting;

  /// No description provided for @shareFileFailed.
  ///
  /// In en, this message translates to:
  /// **'The share file could not be written ({error}). Free some space and try again.'**
  String shareFileFailed(String error);

  /// No description provided for @privateLabel.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get privateLabel;

  /// No description provided for @sharedCatalogIs.
  ///
  /// In en, this message translates to:
  /// **'Catalog: {name}'**
  String sharedCatalogIs(String name);

  /// No description provided for @markPrivate.
  ///
  /// In en, this message translates to:
  /// **'Mark as private'**
  String get markPrivate;

  /// No description provided for @unmarkPrivate.
  ///
  /// In en, this message translates to:
  /// **'Remove private mark'**
  String get unmarkPrivate;

  /// No description provided for @agenda.
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// No description provided for @reminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminderLabel;

  /// No description provided for @agendaEmpty.
  ///
  /// In en, this message translates to:
  /// **'No appointments planned. Plan new ones here with the plus, or on a cat\'s or clowder\'s page.'**
  String get agendaEmpty;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'due today'**
  String get dueToday;

  /// No description provided for @dueInDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{in 1 day} other{in {count} days}}'**
  String dueInDays(int count);

  /// No description provided for @overdueByDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 day overdue} other{{count} days overdue}}'**
  String overdueByDays(int count);

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get markDone;

  /// No description provided for @repeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Again in…'**
  String get repeatTitle;

  /// No description provided for @noRepeatLabel.
  ///
  /// In en, this message translates to:
  /// **'No repeat'**
  String get noRepeatLabel;

  /// No description provided for @unitDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get unitDays;

  /// No description provided for @unitWeeks.
  ///
  /// In en, this message translates to:
  /// **'weeks'**
  String get unitWeeks;

  /// No description provided for @unitMonths.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get unitMonths;

  /// No description provided for @unitYears.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get unitYears;

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'{years} yrs'**
  String ageYears(int years);

  /// No description provided for @ageMonths.
  ///
  /// In en, this message translates to:
  /// **'{months} mo'**
  String ageMonths(int months);

  /// No description provided for @changeDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Change date'**
  String get changeDateLabel;

  /// No description provided for @removeReminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Remove reminder'**
  String get removeReminderLabel;

  /// No description provided for @exportIcs.
  ///
  /// In en, this message translates to:
  /// **'Export calendar file'**
  String get exportIcs;

  /// No description provided for @icsSavedTo.
  ///
  /// In en, this message translates to:
  /// **'Calendar file saved under {path}'**
  String icsSavedTo(String path);

  /// No description provided for @calendarMirrorLabel.
  ///
  /// In en, this message translates to:
  /// **'Mirror to device calendar'**
  String get calendarMirrorLabel;

  /// No description provided for @calendarMirrorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The appointments appear as all-day entries in the calendar. cat(a)log updates them there at every start and after every change. You can manage alerts for them in the calendar.'**
  String get calendarMirrorSubtitle;

  /// No description provided for @syncPeerOlder.
  ///
  /// In en, this message translates to:
  /// **'The other device runs an older cat(a)log that cannot carry reminders. Update cat(a)log there, then sync again.'**
  String get syncPeerOlder;

  /// No description provided for @syncPeerNewer.
  ///
  /// In en, this message translates to:
  /// **'The other device runs a newer cat(a)log. Update cat(a)log on this device, then sync again.'**
  String get syncPeerNewer;

  /// No description provided for @bundleNewerError.
  ///
  /// In en, this message translates to:
  /// **'This file comes from a newer cat(a)log. Update cat(a)log on this device to import it.'**
  String get bundleNewerError;

  /// No description provided for @spotEar.
  ///
  /// In en, this message translates to:
  /// **'A little cat ear in a corner means: press and hold for more.'**
  String get spotEar;

  /// No description provided for @addReminder.
  ///
  /// In en, this message translates to:
  /// **'Add reminder'**
  String get addReminder;

  /// No description provided for @plannedSection.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get plannedSection;

  /// No description provided for @reminderDialogHint.
  ///
  /// In en, this message translates to:
  /// **'The appointment shows in the Agenda. There you confirm or discard it. The value is taken over only when the appointment is confirmed.'**
  String get reminderDialogHint;

  /// No description provided for @reminderFor.
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get reminderFor;

  /// No description provided for @reminderField.
  ///
  /// In en, this message translates to:
  /// **'Field'**
  String get reminderField;

  /// No description provided for @dueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDateLabel;

  /// No description provided for @pickCalendar.
  ///
  /// In en, this message translates to:
  /// **'Which calendar?'**
  String get pickCalendar;

  /// No description provided for @calendarPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Calendar access is blocked, so the mirror is off. Allow it in the system settings, then switch the mirror on again.'**
  String get calendarPermissionDenied;

  /// No description provided for @calendarNotChosen.
  ///
  /// In en, this message translates to:
  /// **'No calendar chosen, so the mirror is off. Switch it on again and pick one.'**
  String get calendarNotChosen;

  /// No description provided for @calendarGone.
  ///
  /// In en, this message translates to:
  /// **'The chosen calendar no longer exists, so the mirror is off. Switch it on again and pick another one.'**
  String get calendarGone;

  /// No description provided for @noWritableCalendar.
  ///
  /// In en, this message translates to:
  /// **'No calendar found. Sign in to a calendar account in the system settings, Google for example, and try again.'**
  String get noWritableCalendar;

  /// No description provided for @spotHomeAgenda.
  ///
  /// In en, this message translates to:
  /// **'Agenda: the list of planned appointments — vet visits, medicine, check-ups.'**
  String get spotHomeAgenda;

  /// No description provided for @spotAgendaAdd.
  ///
  /// In en, this message translates to:
  /// **'Plan a new appointment.'**
  String get spotAgendaAdd;

  /// No description provided for @spotAgendaCalendar.
  ///
  /// In en, this message translates to:
  /// **'Switch on here to mirror the cat(a)log appointments into a calendar of your choice.'**
  String get spotAgendaCalendar;

  /// No description provided for @helpAgenda.
  ///
  /// In en, this message translates to:
  /// **'The Agenda lists the planned appointments by date. There are two kinds: appointments with a time of day, and reminders that apply to a day. Missed ones stay at the top. Tap opens the cat or clowder. The check confirms an appointment: the value is written into the field, and you can plan the next one right away, for example in three months. Press and hold changes the date or deletes the appointment. The switch at the top mirrors the appointments into a calendar of your phone. The menu exports them as a calendar file. A vet run with several cats is one appointment: tick the cats in it, the Agenda shows one card with their names, and finishing asks which cats were treated — untick the ones that were not, they stay planned.'**
  String get helpAgenda;

  /// No description provided for @calendarRowOff.
  ///
  /// In en, this message translates to:
  /// **'Calendar: off'**
  String get calendarRowOff;

  /// No description provided for @calendarRowOn.
  ///
  /// In en, this message translates to:
  /// **'Calendar: {name}'**
  String calendarRowOn(String name);

  /// No description provided for @spotAddReminderCat.
  ///
  /// In en, this message translates to:
  /// **'Plan an appointment for this cat. It shows in the Agenda and is confirmed there.'**
  String get spotAddReminderCat;

  /// No description provided for @spotAddReminderClowder.
  ///
  /// In en, this message translates to:
  /// **'Plan an appointment for this clowder. It shows in the Agenda and is confirmed there.'**
  String get spotAddReminderClowder;

  /// No description provided for @readOnlyCalendar.
  ///
  /// In en, this message translates to:
  /// **'read only'**
  String get readOnlyCalendar;

  /// No description provided for @appointmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointmentLabel;

  /// No description provided for @addAppointment.
  ///
  /// In en, this message translates to:
  /// **'Add appointment'**
  String get addAppointment;

  /// No description provided for @planChooserTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment or reminder?'**
  String get planChooserTitle;

  /// No description provided for @planChooserAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment — a visit at a date and time, with notes'**
  String get planChooserAppointment;

  /// No description provided for @planChooserReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder — a value that becomes due on a day'**
  String get planChooserReminder;

  /// No description provided for @appointmentTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'What'**
  String get appointmentTitleLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @allDayLabel.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get allDayLabel;

  /// No description provided for @alertLabel.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alertLabel;

  /// No description provided for @alertNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get alertNone;

  /// No description provided for @alertDayBefore.
  ///
  /// In en, this message translates to:
  /// **'The day before'**
  String get alertDayBefore;

  /// No description provided for @alertHourBefore.
  ///
  /// In en, this message translates to:
  /// **'One hour before'**
  String get alertHourBefore;

  /// No description provided for @linkFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'When done, write into a field'**
  String get linkFieldLabel;

  /// No description provided for @noLinkedField.
  ///
  /// In en, this message translates to:
  /// **'No field'**
  String get noLinkedField;

  /// No description provided for @outcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'How did it go?'**
  String get outcomeTitle;

  /// No description provided for @finishLabel.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishLabel;

  /// No description provided for @editLabelAppointment.
  ///
  /// In en, this message translates to:
  /// **'Edit appointment'**
  String get editLabelAppointment;

  /// No description provided for @deleteAppointment.
  ///
  /// In en, this message translates to:
  /// **'Delete appointment'**
  String get deleteAppointment;

  /// No description provided for @stepFlierText.
  ///
  /// In en, this message translates to:
  /// **'Flier text'**
  String get stepFlierText;

  /// No description provided for @qrFoundHint.
  ///
  /// In en, this message translates to:
  /// **'A QR code was found on the poster. Ticked codes are read for registry numbers and links.'**
  String get qrFoundHint;

  /// No description provided for @useCode.
  ///
  /// In en, this message translates to:
  /// **'Use this code'**
  String get useCode;

  /// No description provided for @qrNone.
  ///
  /// In en, this message translates to:
  /// **'No QR code found in the photo.'**
  String get qrNone;

  /// No description provided for @qrFailed.
  ///
  /// In en, this message translates to:
  /// **'QR reading failed: {error}'**
  String qrFailed(String error);

  /// No description provided for @flierRecognized.
  ///
  /// In en, this message translates to:
  /// **'{name} poster recognized. Check below which field each line goes to.'**
  String flierRecognized(String name);

  /// No description provided for @flierLayoutUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown poster layout. Assign the lines to fields below; the rest stays in remarks.'**
  String get flierLayoutUnknown;

  /// No description provided for @targetRegistryNumber.
  ///
  /// In en, this message translates to:
  /// **'Registry number'**
  String get targetRegistryNumber;

  /// No description provided for @targetLostPlace.
  ///
  /// In en, this message translates to:
  /// **'Address (lost at)'**
  String get targetLostPlace;

  /// No description provided for @targetContact.
  ///
  /// In en, this message translates to:
  /// **'Registry contact'**
  String get targetContact;

  /// No description provided for @targetDrop.
  ///
  /// In en, this message translates to:
  /// **'Drop'**
  String get targetDrop;

  /// No description provided for @existingCat.
  ///
  /// In en, this message translates to:
  /// **'Existing cat'**
  String get existingCat;

  /// No description provided for @existingClowder.
  ///
  /// In en, this message translates to:
  /// **'Existing clowder'**
  String get existingClowder;

  /// No description provided for @createNewInstead.
  ///
  /// In en, this message translates to:
  /// **'None — create new'**
  String get createNewInstead;

  /// No description provided for @overwritesValue.
  ///
  /// In en, this message translates to:
  /// **'Overwrites current value \"{value}\"'**
  String overwritesValue(String value);

  /// No description provided for @abortScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Abort the scan?'**
  String get abortScanTitle;

  /// No description provided for @abortScanBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing gets saved.'**
  String get abortScanBody;

  /// No description provided for @abortScan.
  ///
  /// In en, this message translates to:
  /// **'Abort'**
  String get abortScan;

  /// No description provided for @keepScanning.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get keepScanning;

  /// No description provided for @catsOnAppointment.
  ///
  /// In en, this message translates to:
  /// **'Cats on this appointment'**
  String get catsOnAppointment;

  /// No description provided for @noCatsHint.
  ///
  /// In en, this message translates to:
  /// **'No cat ticked — the appointment is the clowder\'s own.'**
  String get noCatsHint;

  /// No description provided for @pickCatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Which cats come along?'**
  String get pickCatsTitle;

  /// No description provided for @catsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} cats'**
  String catsCount(int count);

  /// No description provided for @finishUntickHint.
  ///
  /// In en, this message translates to:
  /// **'Untick the cats that were not treated; they stay planned.'**
  String get finishUntickHint;

  /// No description provided for @deleteAppointmentGroup.
  ///
  /// In en, this message translates to:
  /// **'Delete appointment for all {count} cats'**
  String deleteAppointmentGroup(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bg',
    'bs',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'et',
    'fa',
    'fi',
    'fr',
    'ga',
    'he',
    'hr',
    'hu',
    'is',
    'it',
    'ja',
    'lt',
    'lv',
    'mk',
    'mt',
    'nl',
    'no',
    'pl',
    'pt',
    'ro',
    'ru',
    'sk',
    'sl',
    'sq',
    'sr',
    'sv',
    'tr',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bg':
      return AppLocalizationsBg();
    case 'bs':
      return AppLocalizationsBs();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fa':
      return AppLocalizationsFa();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'ga':
      return AppLocalizationsGa();
    case 'he':
      return AppLocalizationsHe();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mk':
      return AppLocalizationsMk();
    case 'mt':
      return AppLocalizationsMt();
    case 'nl':
      return AppLocalizationsNl();
    case 'no':
      return AppLocalizationsNo();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sq':
      return AppLocalizationsSq();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
