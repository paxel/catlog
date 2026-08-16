// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Welkom bij cat(a)log';

  @override
  String get welcomeBody =>
      'Kies een naam voor jezelf. Elke wijziging wordt onder deze naam vastgelegd, zodat anderen zien wie wat deed.';

  @override
  String get yourName => 'Je naam';

  @override
  String get start => 'Beginnen';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet =>
      'Nog geen clowders.\nMaak hieronder de eerste aan.';

  @override
  String get strays => 'Zwerfkatten';

  @override
  String get searchCats => 'Katten zoeken';

  @override
  String get map => 'Kaart';

  @override
  String get sync => 'Synchroniseren';

  @override
  String get fields => 'Velden';

  @override
  String get exportCsv => 'CSV exporteren';

  @override
  String get aboutAndFeedback => 'Over & feedback';

  @override
  String get newClowder => 'Nieuwe clowder';

  @override
  String get name => 'Naam';

  @override
  String get cancel => 'Annuleren';

  @override
  String get create => 'Aanmaken';

  @override
  String get save => 'Opslaan';

  @override
  String get delete => 'Verwijderen';

  @override
  String get merge => 'Samenvoegen';

  @override
  String get resolve => 'Oplossen';

  @override
  String get open => 'Openen';

  @override
  String csvSavedTo(String path) {
    return 'CSV opgeslagen in $path';
  }

  @override
  String get renameClowder => 'Clowder hernoemen';

  @override
  String get rename => 'Hernoemen';

  @override
  String get timeline => 'Tijdlijn';

  @override
  String get mergeInto => 'Samenvoegen met…';

  @override
  String get deleteClowder => 'Clowder verwijderen';

  @override
  String get cats => 'Katten';

  @override
  String get addCat => 'Kat toevoegen';

  @override
  String get newCat => 'Nieuwe kat';

  @override
  String deleteQuestion(String name) {
    return '$name verwijderen?';
  }

  @override
  String get deleteClowderEmptyBody => 'De clowder verdwijnt uit de lijst.';

  @override
  String deleteClowderBody(int count) {
    return 'Zijn $count kat(ten) worden niet verwijderd — ze worden zwerfkatten. Verplaats ze eerst naar een andere clowder als dat niet de bedoeling is.';
  }

  @override
  String get card => 'Kaart';

  @override
  String get shareAsImage => 'Delen als afbeelding';

  @override
  String get shareAsPdf => 'Delen als PDF';

  @override
  String get print => 'Afdrukken';

  @override
  String cardTitle(String name) {
    return 'Kaart — $name';
  }

  @override
  String get renameCat => 'Kat hernoemen';

  @override
  String get seenHereNow => 'Hier gezien';

  @override
  String get deleteCat => 'Kat verwijderen';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Zwerfkat — geen clowder';

  @override
  String get stray => 'Zwerfkat';

  @override
  String get photos => 'Foto\'s';

  @override
  String get addPhoto => 'Foto toevoegen';

  @override
  String get setAsProfileImage => 'Instellen als profielfoto';

  @override
  String get thisIsProfileImage => 'Dit is de profielfoto';

  @override
  String get deletePhoto => 'Foto verwijderen';

  @override
  String get deletePhotoTitle => 'Foto verwijderen?';

  @override
  String get deletePhotoBody =>
      'De fotogegevens worden definitief verwijderd — dit kan niet ongedaan worden gemaakt.';

  @override
  String get deleteCatBody =>
      'De kat verdwijnt uit alle lijsten. Zijn foto\'s worden definitief verwijderd.';

  @override
  String get sightingRecorded => 'Waarneming vastgelegd op je positie.';

  @override
  String get noLocationAvailable =>
      'Geen locatie beschikbaar — houd in plaats daarvan de kaart ingedrukt.';

  @override
  String get moveTo => 'Verplaatsen naar';

  @override
  String get noClowderStrayOption => 'Geen clowder — zwerfkat / weggelopen';

  @override
  String timelineOf(String name) {
    return 'Tijdlijn — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Deze wijziging terugdraaien';

  @override
  String get revertSubtitle =>
      'Zet de vorige waarde terug als nieuwe invoer — de tijdlijn bewaart beide.';

  @override
  String fieldCleared(String field) {
    return '$field leeggemaakt';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field terug naar \"$value\"';
  }

  @override
  String get leftStray => 'Vertrokken — zwerfkat';

  @override
  String movedTo(String name) {
    return 'Verhuisd naar $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat is aangekomen';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat kwam van $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat vertrok naar $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicaat samengevoegd';

  @override
  String get asOfToday => 'Per vandaag';

  @override
  String asOfDate(String date) {
    return 'Per $date';
  }

  @override
  String get value => 'Waarde';

  @override
  String get latitudeLongitude => 'breedtegraad, lengtegraad';

  @override
  String get newField => 'Nieuw veld';

  @override
  String get fieldType => 'Type';

  @override
  String get usedOn => 'Gebruikt voor';

  @override
  String get forCats => 'katten';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'beide';

  @override
  String get optionsOnePerLine => 'Opties (één per regel)';

  @override
  String get renameField => 'Veld hernoemen';

  @override
  String get noStraysRightNow => 'Momenteel geen zwerfkatten.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Zwerfkat toevoegen';

  @override
  String get newStray => 'Nieuwe zwerfkat';

  @override
  String get searchByNameHint => 'Katten op naam zoeken…';

  @override
  String get host => 'Hosten';

  @override
  String get hostExplainer =>
      'Begin hier en voer daarna het adres en de PIN op het andere apparaat in.';

  @override
  String get startHosting => 'Beginnen met hosten';

  @override
  String get stopHosting => 'Stoppen met hosten';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count sessie(s) tot nu toe';
  }

  @override
  String get join => 'Deelnemen';

  @override
  String get addressFromHost => 'Adres (van het hostende apparaat)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Nu synchroniseren';

  @override
  String get addressFormatHint =>
      'Het adres moet er zo uitzien: 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Gesynchroniseerd: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synchronisatie mislukt: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Laatste synchronisatie met $peer: $time';
  }

  @override
  String get sharedFolder => 'Gedeelde map';

  @override
  String get sharedFolderExplainer =>
      'Synchroniseer via een map die een clouddrive of USB-stick tussen apparaten meeneemt — voor wie niet op hetzelfde netwerk zit.';

  @override
  String get noFolderChosenYet => 'Nog geen map gekozen';

  @override
  String get choose => 'Kiezen…';

  @override
  String get syncFolderNow => 'Map nu synchroniseren';

  @override
  String folderSynced(String result) {
    return 'Map gesynchroniseerd: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Map synchroniseren mislukt: $error';
  }

  @override
  String get recordSightingHere => 'Hier een waarneming vastleggen:';

  @override
  String get orPlaceClowderHere => 'Of hier een clowder plaatsen:';

  @override
  String trailOf(String name, int count) {
    return 'Route: $name ($count waarnemingen)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflict — $field';
  }

  @override
  String get conflictBody =>
      'Op twee plekken tegelijk gewijzigd. Kies wat waar is:';

  @override
  String mergeThisInto(String kind) {
    return 'Deze $kind samenvoegen met…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Geen andere $kind om mee samen te voegen.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Samenvoegen met $name?';
  }

  @override
  String mergeBody(String name) {
    return 'De twee records worden één. $name behoudt de huidige waarden; de geschiedenis van de ander komt erbij. Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get kindCat => 'kat';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'veld';

  @override
  String get takePhoto => 'Foto maken';

  @override
  String get chooseFromGallery => 'Kiezen uit galerij';

  @override
  String get about => 'Over';

  @override
  String get aboutTagline =>
      'Een lokale catalogus voor opvangkatten. Je gegevens blijven op je apparaten — geen server, geen account.';

  @override
  String versionLabel(String version, String build) {
    return 'Versie $version ($build)';
  }

  @override
  String get sourceCode => 'Broncode';

  @override
  String get reportProblemOrIdea => 'Probleem of idee melden';

  @override
  String get githubIssues => 'GitHub-issues';

  @override
  String get writeTheDeveloper => 'De ontwikkelaar schrijven';

  @override
  String get buyCoffee => 'Trakteer de ontwikkelaar op koffie';

  @override
  String get coffeeSubtitle => 'Geheel vrijblijvend — de app is gratis';

  @override
  String get openSourceLicenses => 'Opensourcelicenties';

  @override
  String get machineTranslated =>
      'Vertalingen zijn machinaal — verbeteringen zijn welkom op GitHub.';

  @override
  String get unnamed => '(naamloos)';

  @override
  String get labelName => 'Naam';

  @override
  String get labelProfileImage => 'Profielfoto';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Geslacht';

  @override
  String get starterColor => 'Kleur';

  @override
  String get starterNeutered => 'Gecastreerd';

  @override
  String get starterPregnant => 'Drachtig';

  @override
  String get starterBirthdate => 'Geboortedatum';

  @override
  String get starterDeceased => 'Overleden';

  @override
  String get starterAddress => 'Adres';

  @override
  String get starterResponsible => 'Verantwoordelijke';

  @override
  String get starterPosition => 'Positie';

  @override
  String get valueYes => 'ja';

  @override
  String get valueNo => 'nee';

  @override
  String get valueFemale => 'poes';

  @override
  String get valueMale => 'kater';

  @override
  String get valueUnknown => 'onbekend';

  @override
  String get cropTitle => 'Foto bijsnijden';

  @override
  String get markTitle => 'Kat markeren';

  @override
  String get useFullPhoto => 'Hele foto gebruiken';

  @override
  String get dragToSelect => 'Sleep een rechthoek om de kat';

  @override
  String get dragOverTheCat => 'Sleep een ellips over de kat';

  @override
  String get cropPhoto => 'Bijsnijden…';

  @override
  String get markPhoto => 'Markeren…';

  @override
  String get scanCode => 'Code scannen';

  @override
  String get orTypeCode => 'Of typ de code';

  @override
  String get copyCode => 'Code kopiëren';

  @override
  String get copied => 'Gekopieerd';

  @override
  String get invalidCode => 'Die code is ongeldig';

  @override
  String get hotspotHint =>
      'Geen gedeelde wifi? Zet de hotspot van één telefoon aan, verbind de andere en host hier.';

  @override
  String get byMessenger => 'Via messenger';

  @override
  String get byMessengerExplainer =>
      'Stuur je hele catalogus als één bestand via WhatsApp, Signal of mail — de andere kant importeert hem.';

  @override
  String get shareBundle => 'Syncpakket delen…';

  @override
  String get importBundle => 'Syncpakket importeren…';

  @override
  String bundleImported(String result) {
    return 'Pakket geïmporteerd: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import mislukt: $error';
  }

  @override
  String get pickOnMap => 'Kies op de kaart';

  @override
  String get useMyLocation => 'Mijn locatie gebruiken';

  @override
  String get language => 'Taal';

  @override
  String get systemDefault => 'Systeemstandaard';

  @override
  String get iosLocalNetworkHint =>
      'Blijft het mislukken op iPhone/iPad: Instellingen → Privacy en beveiliging → Lokaal netwerk → cat(a)log toestaan en opnieuw proberen.';

  @override
  String get markPrivate => 'Markeren als privé';

  @override
  String get unmarkPrivate => 'Privémarkering verwijderen';

  @override
  String get includePrivate => 'Privégegevens meenemen';

  @override
  String get includePrivateExplainer =>
      'Privékatten, clowders en velden worden ook gedeeld — zet dit alleen aan bij het synchroniseren van je eigen apparaten.';
}
