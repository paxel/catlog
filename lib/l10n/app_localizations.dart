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
  /// **'No clowders yet.\nCreate the first one below.'**
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
  /// **'The cat disappears from all lists. Its photos are removed for good.'**
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
  /// **'Start here, then enter the address and PIN on the other device.'**
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
  /// **'Sync through a folder that a cloud drive or USB stick carries between devices — for people who are not on the same network.'**
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
  /// **'Entirely optional — the app is free'**
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

  /// No description provided for @starterPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
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
