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
  String get noClowdersYet =>
      'Inga clowdrar ännu. En clowder är en plats där katter bor — ditt jourhem, en adoptörs lägenhet. Skapa den första nedan.';

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
      'Katten försvinner från alla listor och dess foton tas bort — här och, efter nästa synkronisering, även hos dina hjälpare.';

  @override
  String get sightingRecorded => 'Observation sparad på din position.';

  @override
  String get noLocationAvailable =>
      'Ingen plats tillgänglig — håll in kartan i stället.';

  @override
  String get locationDeniedForever =>
      'Platsåtkomst är blockerad. Tillåt den i systeminställningarna för att använda Stray Cam.';

  @override
  String get locationServiceOff =>
      'Plats är avstängd på den här enheten. Slå på den i inställningarna och försök igen.';

  @override
  String get locationDenied =>
      'cat(a)log har inte tillstånd att använda din plats. Försök igen och tillåt det när du tillfrågas.';

  @override
  String get locationNoFix =>
      'Din position kunde inte bestämmas just nu. Försök igen utomhus — GPS behöver fri sikt mot himlen.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Chipnummer';

  @override
  String get starterRemarks => 'Anmärkningar';

  @override
  String get captureFlier => 'Fotografera anslag';

  @override
  String get addPhotosTo => 'Lägg till foton till…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foton tillagda till $name';
  }

  @override
  String get scanPrintedCode => 'Skanna tryckt kod';

  @override
  String get chipScanHint =>
      'Skannar den tryckta QR-/streckkoden från chipkortet eller veterinärpapper — chippet i katten kan en telefon inte läsa.';

  @override
  String get savingLabel => 'Sparar…';

  @override
  String ownerOfCat(String name) {
    return 'Ägare till $name';
  }

  @override
  String get sortLabel => 'Sortera';

  @override
  String get matchCandidatesTitle => 'Möjliga matchningar';

  @override
  String get findDuplicates => 'Hitta dubbletter';

  @override
  String get noDuplicates => 'Inga möjliga dubbletter just nu.';

  @override
  String get similarName => 'Liknande namn';

  @override
  String get sharePublicly => 'Dela offentligt…';

  @override
  String get privateNoShare =>
      'Den här katten är markerad som privat — privata data lämnar aldrig din enhet. Ta bort markeringen först för att dela offentligt.';

  @override
  String get pickFramesTitle => 'Välj bildrutor';

  @override
  String get suggestedFrames => 'Föreslagna bildrutor';

  @override
  String get scrubFrames => 'Spola i videon';

  @override
  String get keepThisFrame => 'Behåll den här bildrutan';

  @override
  String get fromVideo => 'Från video…';

  @override
  String get videoMobileOnly =>
      'Att välja bildrutor ur video fungerar i telefonappen (Android och iPhone) — inte på den här enheten ännu.';

  @override
  String get shareWhitelistExplainer =>
      'Bara de ikryssade fälten lämnar katalogen. Allt annat stannar hemma.';

  @override
  String get exportShareFile => 'Exportera delningsfil…';

  @override
  String get hostedLink => 'Värdlänk (URL till den uppladdade filen)';

  @override
  String get inlineQr => 'Inbäddad QR (endast text, inga foton)';

  @override
  String get inlineTooBig =>
      'För mycket data för en inbäddad kod — kryssa ur fält eller använd en värdlänk.';

  @override
  String get scanShareLabel => 'Skanna delningskod';

  @override
  String get notAShareCode => 'Den koden är ingen cat(a)log-delning.';

  @override
  String get importShareTitle => 'Importera den här katten?';

  @override
  String shareSource(String url) {
    return 'Källa: $url';
  }

  @override
  String get importLabel => 'Importera';

  @override
  String get strayAreaLabel => 'Möjligt strövområde';

  @override
  String get noMissingCats =>
      'Inga försvunna katter med anslagspositioner ännu.';

  @override
  String get noMatchCandidates => 'Inga möjliga matchningar just nu.';

  @override
  String sameIdField(String field) {
    return 'Samma $field';
  }

  @override
  String metersApart(String distance) {
    return '$distance m ifrån varandra';
  }

  @override
  String get addFlier => 'Lägg till anslag';

  @override
  String get missingSinceLabel => 'Försvunnen sedan';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get cropPortrait => 'Beskär porträtt';

  @override
  String get statusOwner => 'Ägare';

  @override
  String get ocrUnavailable =>
      'Textigenkänning är inte tillgänglig på den här enheten — skriv anslags­texten själv.';

  @override
  String get displayFormat => 'Visas som';

  @override
  String get displayPlain => 'Vanlig text';

  @override
  String get displayQr => 'QR-kod';

  @override
  String get displayBarcode => 'Streckkod';

  @override
  String get editLabel => 'Redigera';

  @override
  String get doneLabel => 'Klar';

  @override
  String get openSettings => 'Öppna inställningar';

  @override
  String get notSaved => 'Inte sparat';

  @override
  String get birthdateInFuture => 'Födelsedatumet kan inte ligga i framtiden.';

  @override
  String get deceasedInFuture => 'Dödsdatumet kan inte ligga i framtiden.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'Dödsdatumet kan inte ligga före födelsedatumet ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'Födelsedatumet kan inte ligga efter dödsdatumet ($date).';
  }

  @override
  String get malePregnant =>
      'Den här katten är registrerad som hane — en hankatt kan inte vara dräktig. Kontrollera könet först.';

  @override
  String fatherNotMale(String name) {
    return '$name är registrerad som hona och kan inte vara pappan. Kontrollera könet först.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name är registrerad som hane och kan inte vara mamman. Kontrollera könet först.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name föddes $date — en förälder kan inte födas efter sin kattunge.';
  }

  @override
  String get genderFatherFemale =>
      'Den här katten är registrerad som pappa till andra katter — pappan kan inte vara hona. Kontrollera familjen först.';

  @override
  String get genderMotherMale =>
      'Den här katten är registrerad som mamma till andra katter — mamman kan inte vara hane. Kontrollera familjen först.';

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
  String dateFormatError(String format) {
    return 'Fel format — använd $format';
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
  String get starterPosition => 'Plats';

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
  String get markPrivate => 'Markera som privat';

  @override
  String get unmarkPrivate => 'Ta bort privat markering';

  @override
  String get includePrivate => 'Inkludera privata data';

  @override
  String get includePrivateExplainer =>
      'Privata katter, grupper och fält delas också — slå bara på när du synkroniserar dina egna enheter.';

  @override
  String get hideLabel => 'Dölj på den här enheten';

  @override
  String get unhideLabel => 'Visa igen';

  @override
  String get showHiddenLabel => 'Visa dolda';

  @override
  String get stopShowingHidden => 'Sluta visa dolda';

  @override
  String get starterSpecies => 'Art';

  @override
  String get starterStatus => 'Typ';

  @override
  String get statusFoster => 'Jourhem';

  @override
  String get statusForeverHome => 'För-alltid-hem';

  @override
  String get statusClinic => 'Klinik';

  @override
  String get statusShelter => 'Katthem';

  @override
  String get statusBarn => 'Lada';

  @override
  String get valueCat => 'Katt';

  @override
  String get otherOption => 'Annat…';

  @override
  String get celebrationsToggle => 'Fira adoptioner';

  @override
  String get celebrationsSubtitle =>
      'Konfetti och jubel när en katt flyttar till sitt för-alltid-hem';

  @override
  String get onMapLabel => 'På kartan';

  @override
  String get showOnMap => 'Visa på karta';

  @override
  String get searchPlaceHint => 'Sök plats eller adress';

  @override
  String get noPlacesFound => 'Inga platser hittades';

  @override
  String get mapSearchHint => 'Sök katter, grupper, personer';

  @override
  String get proposeAnotherName => 'Föreslå ett annat namn';

  @override
  String get moderationTitle => 'Författare & spärrar';

  @override
  String get moderationSubtitle => 'Ta bort en persons data för gott';

  @override
  String get authorsSection => 'Vem som skrivit i katalogen';

  @override
  String get hardDeleteAction => 'Radera allt från denna författare';

  @override
  String hardDeleteWarning(Object name) {
    return 'Tar bort alla poster och foton från $name på den här enheten. Andra enheter behåller sina. Kan inte ångras.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Skriv $name för att bekräfta';
  }

  @override
  String get alsoBan => 'Spärra också — ta aldrig emot data igen';

  @override
  String get bansSection => 'Spärrar';

  @override
  String get unbanAction => 'Ta bort spärr';

  @override
  String get deletedDone => 'Raderat.';

  @override
  String get syncSummaryTitle => 'Vad som kom';

  @override
  String get summaryAdopted => 'Adopterade';

  @override
  String get summaryDeceased => 'Avlidna';

  @override
  String get summaryEscaped => 'Rymda';

  @override
  String get summaryNew => 'Nya';

  @override
  String get summaryConflicts => 'Konflikter att lösa';

  @override
  String summaryOther(Object n) {
    return '…och $n andra ändringar';
  }

  @override
  String get starterMother => 'Mamma';

  @override
  String get starterFather => 'Pappa';

  @override
  String get familySection => 'Familj';

  @override
  String get littermatesLabel => 'Kullsyskon';

  @override
  String get siblingsLabel => 'Syskon';

  @override
  String get kittensLabel => 'Kattungar';

  @override
  String get toastSettingsTitle => 'Vad som meddelas';

  @override
  String get toastSettingsSubtitle => 'Små meddelanden efter en synkronisering';

  @override
  String get toastKindAdoptions => 'Adoptioner';

  @override
  String get toastKindBirths => 'Födslar';

  @override
  String get toastKindDeaths => 'Dödsfall';

  @override
  String get toastKindEscapes => 'Rymningar';

  @override
  String get toastKindMoves => 'Flyttar';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adopterad av $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Ny kattunge: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat har dött';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat har rymt';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat flyttade till $home';
  }

  @override
  String get notACatlogFile => 'Det är inte en cat(a)log-fil';

  @override
  String get nothingNewInBundle => 'Inget nytt i filen — du har redan allt';

  @override
  String get syncChooserInPerson => 'Ansikte mot ansikte';

  @override
  String get syncChooserInPersonSub =>
      'Ni är i samma rum — skanna en kod, klart på sekunder';

  @override
  String get syncChooserRemote => 'På distans';

  @override
  String get syncChooserRemoteSub =>
      'Via en delad mapp som Dropbox eller ett USB-minne';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Skicka allt som en fil genom valfri messenger';

  @override
  String get connectToWifiFirst =>
      'Anslut till Wi-Fi först — då hittar enheterna varandra';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vill synkronisera';
  }

  @override
  String get trustBothWaysNote => 'Era kataloger utbyts i båda riktningarna.';

  @override
  String get allowOnce => 'Tillåt';

  @override
  String get allowAlways => 'Tillåt alltid den här enheten';

  @override
  String get declineAction => 'Avböj';

  @override
  String get syncDeclined => 'Den andra enheten avböjde synkroniseringen';

  @override
  String get trustedDevicesSection => 'Alltid tillåtna enheter';

  @override
  String get removeTrust => 'Ta bort';

  @override
  String get hostWithoutWifi => 'Var värd utan Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Skapar en tillfällig direktanslutning till den andra telefonen (utan internet). Bara cat(a)log använder den och den kopplas ner av sig själv efter synkroniseringen.';

  @override
  String get hotspotAndroidOnly =>
      'Den här koden kräver två Android-telefoner — använd ett delat Wi-Fi på iPhone/iPad';

  @override
  String get selectClowderHint => 'Välj en clowder till vänster';

  @override
  String get introTitle1 => 'Katter bor i clowdrar';

  @override
  String get introBody1 =>
      'En clowder är en plats där katter bor: ditt jourhem, en adoptörs lägenhet, ladan intill. Varje katt får ett kort med foto, fakta och hela sin historia.';

  @override
  String get introTitle2 => 'Allt stannar hos dig';

  @override
  String get introBody2 =>
      'Inget konto, inget moln, ingen spårning. Dina data bor på din enhet.';

  @override
  String get introTitle3 => 'Dela med dina hjälpare';

  @override
  String get introBody3 =>
      'Skanna en kod så synkas två enheter på sekunder, använd en delad mapp eller skicka allt som en fil.';

  @override
  String get introSkip => 'Hoppa över';

  @override
  String get introNext => 'Nästa';

  @override
  String get introDone => 'Nu kör vi';

  @override
  String get introReplayTitle => 'Snabb intro';

  @override
  String get spotHomeSync =>
      'Nytt: synkronisering erbjuder nu tre tydliga vägar — och en förtroendefråga innan något flödar.';

  @override
  String get spotHomeStrays =>
      'Nytt: strykare har sitt eget kort här uppe — antal, nosar, tryck för att öppna.';

  @override
  String get spotHomeMenu =>
      'Nytt: den här menyn hittar dubblettkatter och -kolonier och slår ihop dem.';

  @override
  String get spotCatEdit =>
      'Nytt: sidan är skrivskyddad — pennan växlar till redigering, långtryck på ett fält redigerar det direkt.';

  @override
  String get spotMapLayers =>
      'Nytt: visa 500 m sökcirklar runt en försvunnen katts anslagsplatser.';

  @override
  String get spotStraysFlier =>
      'Nytt: fotografera ett anslag om en försvunnen katt — det blir katten, ägaren och kontakten.';

  @override
  String get spotStraysScan =>
      'Nytt: skanna en cat(a)log-kod från ett anslag och importera katten direkt.';

  @override
  String get introTitle4 => 'Försvunna katter';

  @override
  String get introBody4 =>
      'Fotografera ett anslag så hamnar den försvunna katten i katalogen med ägarens kontakt. Observationer, sökcirklar och matchförslag hjälper den hem.';

  @override
  String get spotMapSearch =>
      'Nytt: sök katter, clowdrar och personer här — direkt på kartan.';

  @override
  String get spotCardChips =>
      'Nytt: välj vad som visas på kortet innan du delar det.';

  @override
  String get spotCatMenu =>
      'Nytt: markera en katt som privat (lämnar aldrig din enhet) eller dölj den här.';

  @override
  String get spotDone => 'Uppfattat';

  @override
  String get spotReplayTitle => 'Nyhetstur';

  @override
  String get spotReplaySubtitle => 'Visa tipsen igen på varje sida';

  @override
  String get spotReplayDone => 'Tipsen visas igen';

  @override
  String get searchNoResults => 'Ingen katt hittades med det namnet';

  @override
  String get syncUnreachable =>
      'Kunde inte nå den andra enheten. Är båda på samma Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Kunde inte nå mappen. Finns enheten eller molnmappen kvar?';

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
