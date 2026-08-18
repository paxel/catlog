// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Välkommen till cat(a)log';

  @override
  String get welcomeBody =>
      'Välj ett namn åt dig själv. Varje ändring sparas under det namnet, så att andra ser vem som gjorde vad.';

  @override
  String get yourName => 'Ditt namn';

  @override
  String get start => 'Börja';

  @override
  String get clowders => 'Clowdrar';

  @override
  String get noClowdersYet => 'Inga clowdrar ännu.\nSkapa den första nedan.';

  @override
  String get strays => 'Hemlösa katter';

  @override
  String get searchCats => 'Sök katter';

  @override
  String get map => 'Karta';

  @override
  String get sync => 'Synkronisering';

  @override
  String get fields => 'Fält';

  @override
  String get exportCsv => 'Exportera CSV';

  @override
  String get aboutAndFeedback => 'Om & feedback';

  @override
  String get newClowder => 'Ny clowder';

  @override
  String get name => 'Namn';

  @override
  String get cancel => 'Avbryt';

  @override
  String get create => 'Skapa';

  @override
  String get save => 'Spara';

  @override
  String get delete => 'Radera';

  @override
  String get merge => 'Slå ihop';

  @override
  String get resolve => 'Avgör';

  @override
  String get open => 'Öppna';

  @override
  String csvSavedTo(String path) {
    return 'CSV sparad i $path';
  }

  @override
  String get renameClowder => 'Byt namn på clowder';

  @override
  String get rename => 'Byt namn';

  @override
  String get timeline => 'Tidslinje';

  @override
  String get mergeInto => 'Slå ihop med…';

  @override
  String get deleteClowder => 'Radera clowder';

  @override
  String get cats => 'Katter';

  @override
  String get addCat => 'Lägg till katt';

  @override
  String get newCat => 'Ny katt';

  @override
  String deleteQuestion(String name) {
    return 'Radera $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Clowdern försvinner från listan.';

  @override
  String deleteClowderBody(int count) {
    return 'Dess $count katt(er) raderas inte — de blir hemlösa. Flytta dem först till en annan clowder om det inte är meningen.';
  }

  @override
  String get card => 'Kort';

  @override
  String get shareAsImage => 'Dela som bild';

  @override
  String get shareAsPdf => 'Dela som PDF';

  @override
  String get print => 'Skriv ut';

  @override
  String cardTitle(String name) {
    return 'Kort — $name';
  }

  @override
  String get renameCat => 'Byt namn på katt';

  @override
  String get seenHereNow => 'Sedd här nu';

  @override
  String get deleteCat => 'Radera katt';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Hemlös — ingen clowder';

  @override
  String get stray => 'Hemlös';

  @override
  String get photos => 'Foton';

  @override
  String get addPhoto => 'Lägg till foto';

  @override
  String get setAsProfileImage => 'Ange som profilbild';

  @override
  String get thisIsProfileImage => 'Det här är profilbilden';

  @override
  String get deletePhoto => 'Radera foto';

  @override
  String get deletePhotoTitle => 'Radera foto?';

  @override
  String get deletePhotoBody =>
      'Fotodata raderas för alltid — det går inte att ångra.';

  @override
  String get deleteCatBody =>
      'Katten försvinner från alla listor. Dess foton raderas för alltid.';

  @override
  String get sightingRecorded => 'Observation sparad på din position.';

  @override
  String get noLocationAvailable =>
      'Ingen plats tillgänglig — håll in kartan i stället.';

  @override
  String get locationDeniedForever =>
      'Platsåtkomst är blockerad. Tillåt den i systeminställningarna för att använda Stray Cam.';

  @override
  String get openSettings => 'Öppna inställningar';

  @override
  String get moveTo => 'Flytta till';

  @override
  String get noClowderStrayOption => 'Ingen clowder — hemlös / rymde';

  @override
  String timelineOf(String name) {
    return 'Tidslinje — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Ångra den här ändringen';

  @override
  String get revertSubtitle =>
      'Återställer föregående värde som ny post — historiken behåller båda.';

  @override
  String fieldCleared(String field) {
    return '$field rensat';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field tillbaka till \"$value\"';
  }

  @override
  String get leftStray => 'Gav sig av — hemlös';

  @override
  String movedTo(String name) {
    return 'Flyttad till $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat kom';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat kom från $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat flyttade till $place';
  }

  @override
  String get duplicateMergedIn => 'Dubblett ihopslagen';

  @override
  String get asOfToday => 'Per i dag';

  @override
  String asOfDate(String date) {
    return 'Per $date';
  }

  @override
  String get value => 'Värde';

  @override
  String get latitudeLongitude => 'latitud, longitud';

  @override
  String get newField => 'Nytt fält';

  @override
  String get fieldType => 'Typ';

  @override
  String get usedOn => 'Används för';

  @override
  String get forCats => 'katter';

  @override
  String get forClowders => 'clowdrar';

  @override
  String get forBoth => 'båda';

  @override
  String get optionsOnePerLine => 'Alternativ (ett per rad)';

  @override
  String get ownValue => 'Eget värde';

  @override
  String get renameField => 'Byt namn på fält';

  @override
  String get editOptions => 'Redigera alternativ…';

  @override
  String get noStraysRightNow => 'Inga hemlösa katter just nu.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Lägg till hemlös';

  @override
  String get newStray => 'Ny hemlös';

  @override
  String get searchByNameHint => 'Sök katter efter namn…';

  @override
  String get host => 'Agera värd';

  @override
  String get hostExplainer =>
      'Börja här och ange sedan adress och PIN på den andra enheten.';

  @override
  String get startHosting => 'Börja agera värd';

  @override
  String get stopHosting => 'Sluta agera värd';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count session(er) hittills';
  }

  @override
  String get join => 'Anslut';

  @override
  String get addressFromHost => 'Adress (från värdenheten)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synkronisera nu';

  @override
  String get addressFormatHint => 'Adressen ska se ut som 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synkroniserat: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Synkronisering misslyckades: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Senaste synkronisering med $peer: $time';
  }

  @override
  String get sharedFolder => 'Delad mapp';

  @override
  String get sharedFolderExplainer =>
      'Synkronisera via en mapp som en molntjänst eller USB-sticka bär mellan enheter — för dem som inte är på samma nätverk.';

  @override
  String get noFolderChosenYet => 'Ingen mapp vald ännu';

  @override
  String get choose => 'Välj…';

  @override
  String get syncFolderNow => 'Synkronisera mappen nu';

  @override
  String folderSynced(String result) {
    return 'Mapp synkroniserad: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Mappsynkronisering misslyckades: $error';
  }

  @override
  String get recordSightingHere => 'Registrera en observation här:';

  @override
  String trailOf(String name, int count) {
    return 'Rutt: $name ($count observationer)';
  }

  @override
  String conflictOn(String field) {
    return 'Konflikt — $field';
  }

  @override
  String get conflictBody =>
      'Ändrat på två ställen samtidigt. Välj vad som stämmer:';

  @override
  String mergeThisInto(String kind) {
    return 'Slå ihop denna $kind med…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Ingen annan $kind att slå ihop med.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Slå ihop med $name?';
  }

  @override
  String mergeBody(String name) {
    return 'De två posterna blir en. $name behåller sina nuvarande värden; den andras historik läggs till. Det går inte att ångra.';
  }

  @override
  String get kindCat => 'katt';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'fält';

  @override
  String get takePhoto => 'Ta foto';

  @override
  String get chooseFromGallery => 'Välj från galleriet';

  @override
  String get about => 'Om';

  @override
  String get aboutTagline =>
      'En lokal katalog för jourhemskatter. Dina data stannar på dina enheter — ingen server, inget konto.';

  @override
  String versionLabel(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get sourceCode => 'Källkod';

  @override
  String get reportProblemOrIdea => 'Rapportera problem eller idé';

  @override
  String get githubIssues => 'GitHub Issues';

  @override
  String get writeTheDeveloper => 'Skriv till utvecklaren';

  @override
  String get buyCoffee => 'Bjud utvecklaren på kaffe';

  @override
  String get coffeeSubtitle => 'Helt frivilligt — appen är gratis';

  @override
  String get openSourceLicenses => 'Licenser för öppen källkod';

  @override
  String get machineTranslated =>
      'Översättningarna är maskinella — rättelser välkomnas på GitHub.';

  @override
  String get unnamed => '(namnlös)';

  @override
  String get labelName => 'Namn';

  @override
  String get labelProfileImage => 'Profilbild';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Kön';

  @override
  String get starterBreed => 'Ras';

  @override
  String get valueMixed => 'blandras';

  @override
  String get breedEuropeanShorthair => 'Europeiskt korthår';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Brittiskt korthår';

  @override
  String get breedNorwegianForestCat => 'Norsk skogkatt';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siames';

  @override
  String get breedPersian => 'Perser';

  @override
  String get breedBengal => 'Bengal';

  @override
  String get breedSphynx => 'Sphynx';

  @override
  String get starterColor => 'Färg';

  @override
  String get starterNeutered => 'Kastrerad';

  @override
  String get starterPregnant => 'Dräktig';

  @override
  String get starterBirthdate => 'Födelsedatum';

  @override
  String get starterDeceased => 'Avliden';

  @override
  String get starterAddress => 'Adress';

  @override
  String get starterResponsible => 'Ansvarig person';

  @override
  String get starterPosition => 'Position';

  @override
  String get valueYes => 'ja';

  @override
  String get valueNo => 'nej';

  @override
  String get valueFemale => 'hona';

  @override
  String get valueMale => 'hane';

  @override
  String get valueUnknown => 'okänt';

  @override
  String get cropTitle => 'Beskär foto';

  @override
  String get markTitle => 'Markera katten';

  @override
  String get applyCrop => 'Beskär';

  @override
  String get useFullPhoto => 'Använd hela fotot';

  @override
  String get dragToSelect => 'Dra en rektangel runt katten';

  @override
  String get dragOverTheCat => 'Dra en ellips över katten';

  @override
  String get cropPhoto => 'Beskär…';

  @override
  String get markPhoto => 'Markera…';

  @override
  String get scanCode => 'Skanna kod';

  @override
  String get orTypeCode => 'Eller skriv koden';

  @override
  String get copyCode => 'Kopiera kod';

  @override
  String get copied => 'Kopierat';

  @override
  String get invalidCode => 'Den koden är inte giltig';

  @override
  String get hotspotHint =>
      'Inget gemensamt Wi-Fi? Slå på hotspot på en telefon, anslut den andra och agera värd här.';

  @override
  String get byMessenger => 'Via messenger';

  @override
  String get byMessengerExplainer =>
      'Skicka hela katalogen som en fil via WhatsApp, Signal eller mail — andra sidan importerar den.';

  @override
  String get shareBundle => 'Dela synkpaket…';

  @override
  String get importBundle => 'Importera synkpaket…';

  @override
  String bundleImported(String result) {
    return 'Paket importerat: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'Senaste automatiska säkerhetskopieringen misslyckades: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Import misslyckades: $error';
  }

  @override
  String get pickOnMap => 'Välj på kartan';

  @override
  String get useMyLocation => 'Använd min plats';

  @override
  String get language => 'Språk';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Om det fortsätter misslyckas på iPhone/iPad: Inställningar → Integritet och säkerhet → Lokalt nätverk → tillåt cat(a)log och försök igen.';

  @override
  String get crashTitle => 'Det här borde inte ha hänt';

  @override
  String get crashBody =>
      'cat(a)log stötte på ett oväntat fel. Dina data är säkra — allt sparas i samma stund du ändrar det. Starta om appen, och händer det igen, skicka rapporten så det kan lagas.';

  @override
  String get crashRestart => 'Starta om appen';

  @override
  String get crashSendReport => 'Skicka rapport till utvecklaren';

  @override
  String get crashLastRunBody =>
      'cat(a)log stannade oväntat förra gången — troligen tog minnet slut. Skicka en kort rapport så det kan lagas?';
}
