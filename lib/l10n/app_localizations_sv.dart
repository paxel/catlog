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
      'Katten försvinner från alla listor och dess foton tas bort — här och, efter nästa synk, även på de andra enheterna.';

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
  String get viewAsTable => 'Visa som tabell';

  @override
  String get viewAsTiles => 'Visa som paneler';

  @override
  String get viewAsList => 'Visa som lista';

  @override
  String get ageLabel => 'Ålder';

  @override
  String get catList => 'Kattlista';

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
      'Välj vad som hamnar i filen. Bara ikryssade fält tas med.';

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
  String get prevPin => 'Föregående nål';

  @override
  String get nextPin => 'Nästa nål';

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
  String get dateInFuture => 'Det här datumet kan inte ligga i framtiden.';

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
      'Börja här och skanna sedan koden eller ange den på den andra enheten.';

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
      'Båda enheterna använder samma mapp (t.ex. i Dropbox eller på ett USB-minne). Varje synk lägger dina ändringar där och hämtar den andras.';

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
  String get coffeeSubtitle =>
      'Appen förblir gratis. Även om jag inte får något kaffe :)';

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
  String get starterEmail => 'E-post';

  @override
  String get starterPhone => 'Telefon';

  @override
  String get lookupUrlLabel => 'Uppslagslänk';

  @override
  String lookupUrlHelp(String token) {
    return 'Tjänstens sida med $token där numret ska stå, t.ex. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Slå upp';

  @override
  String lookupFailed(String url) {
    return 'Ingen app kunde öppna $url. Kopiera länken till en webbläsare.';
  }

  @override
  String get stepCat => 'Katt';

  @override
  String get stepOwner => 'Ägare';

  @override
  String get stepFace => 'Ansiktsfoto';

  @override
  String get stepRegistry => 'Register';

  @override
  String get stepReview => 'Kontrollera och spara';

  @override
  String get stepOwnerHint =>
      'Den som saknar katten — det blir deras clowder, med kontakten från anslaget.';

  @override
  String get stepFaceHint =>
      'Klipp ut kattens ansikte ur anslaget; det blir profilbilden. Du kan hoppa över.';

  @override
  String get stepRegistryHint =>
      'Nummer som hittats på anslaget. Ikryssade sparas hos katten och kan öppnas senare.';

  @override
  String get noRegistryLinks =>
      'Inga registerlänkar på det här anslaget — om någon missats, rapportera gärna en bugg.';

  @override
  String get unknownServiceHint => 'Okänd tjänst';

  @override
  String get rememberService => 'Kom ihåg tjänsten';

  @override
  String get rememberServiceHint =>
      'Namnge tjänsten och peka på numret i länken. Nästa anslag fyller i sig självt.';

  @override
  String get noIdInLink =>
      'Den här länken har inget nummer som appen kan spara.';

  @override
  String get whichNumber => 'Vilken del är numret?';

  @override
  String get cropAgain => 'Beskär igen';

  @override
  String get noFaceYet => 'Inget ansiktsfoto än — anslagets foto används.';

  @override
  String get backLabel => 'Tillbaka';

  @override
  String get dangerButton => 'TRYCK INTE.\nFARA';

  @override
  String get dangerThanks => 'Tack för att du använder cat(a)log!';

  @override
  String get helpTitle => 'Hjälp';

  @override
  String get showTipsAgain => 'Visa tipsen igen';

  @override
  String get helpHome =>
      'Översikten över dina kolonier — en koloni är en plats där katter bor: ditt hem, ett jourhem, ett katthem. Tryck på ett kort för att se dess katter; håll in för menyn. Knappen nere till höger skapar en koloni, och strykarkortet samlar alla katter utan hem. Namnet högst upp är katalogen du är i — tryck för att byta eller lägga till en.';

  @override
  String get helpClowder =>
      'Allt om den här platsen: dess katter, dess fält (adress, kontakt, typ) och dess historik. Sidan öppnas skrivskyddad; pennan slår på redigering, där du också kan lägga till ett fält. Håll in ett fält för att redigera det direkt, en katt för att flytta, dölja eller öppna den. En bokning som läggs till här kan ta med flera av kolonins katter, till exempel en kastreringsresa: markera katterna som följer med, avsluta en gång, avmarkera de som inte behandlades.';

  @override
  String get helpCat =>
      'Allt om den här katten: foton, fält, familj, historik. Sidan är skrivskyddad tills du trycker på pennan. Långtryck på ett fält för att redigera det direkt; långtryck på ett foto för dess meny. Menyn uppe till höger har resten: dölj, slå ihop, notera en observation, dela katten. Privat ställs in när du redigerar ett fält.';

  @override
  String get helpStrays =>
      'Katter utan hem just nu: hittade, rymda eller från ett anslag. Kameraknappen registrerar en katt framför dig; anslagsknappen gör ett efterlysningsanslag till en katt med ägarens kontakt; skannern läser en cat(a)log-kod från anslaget. Tryck på Stray Cam för ett foto; håll nere för att filma en video och behåll de bästa bildrutorna som foton.';

  @override
  String get helpMap =>
      'Alla katter och platser med position. Sökningen hittar katter, personer och platser — ett okänt namn slås upp i hela världen. Lagerknappen ritar 500 m-cirklarna runt en försvunnen katts anslagsplatser och runt dess förra hem. Pilarna går från nål till nål, långtryck noterar en observation.';

  @override
  String get helpCard =>
      'Kattens utskrivbara kort: välj överst med chipsen vad som ska stå på det, dela det sedan som bild eller PDF. Nummer kan skrivas ut som QR eller streckkod, och en position blir en QR som öppnar en karta, plus en kort Plus Code.';

  @override
  String get helpSync =>
      'Så når data andra människor: koppla upp er direkt, använd en mapp båda enheterna ser, eller skicka en fil via en meddelandeapp. Du bestämmer alltid vad som skickas — och mottagna .catsync-filer öppnas också här.';

  @override
  String get helpFields =>
      'Fälten som din katalog använder. Byt namn på dem, ändra alternativen i ett valfält eller skapa egna. Ett id-fält kan peka på en tjänst (ett register), då blir numret tryckbart hos katten.';

  @override
  String get helpTimeline =>
      'Varje ändring som gjorts, nyast först: vem som ändrade vad, när och till vilket värde. Varje post kan ångras — det skriver en ny post, inget raderas någonsin.';

  @override
  String get helpDuplicates =>
      'Katter eller kolonier som verkar finnas två gånger — samma nummer eller mycket lika namn med matchande detaljer. Tryck på ett par för att slå ihop; det går inte att ångra, därför frågas det först.';

  @override
  String get helpMatches =>
      'Katter som kan vara samma djur: samma nummer, eller en strykare sedd inom en försvunnen katts sökområde. Tryck på ett par för att slå ihop, håll in för att öppna första katten och jämföra.';

  @override
  String get helpFlier =>
      'Ett fotograferat anslag blir en katt plus ägare. Steg för steg: kattens uppgifter, ägarens kontakt, beskärning av ansiktet till profilbilden, registernummer från anslaget och sedan en sista koll. Allt är förslag — rätta det kameran läste fel.';

  @override
  String get archiveTitle => 'Arkiv';

  @override
  String get archiveExplainer =>
      'Avlidna katter och tomma kolonier som ingen rört på flera år tar ändå plats — framför allt deras foton. Arkivering skriver dem till en fil du behåller och raderar dem sedan här.';

  @override
  String get archiveAction => 'Arkivera';

  @override
  String archiveSelected(int count) {
    return 'Arkivera $count poster';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Arkivera $count poster?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names skrivs till en fil och raderas sedan — på din enhet och på varje enhet du synkar med. Importerar du filen kommer allt tillbaka; utan den är de borta.';
  }

  @override
  String archiveDone(int count) {
    return '$count poster arkiverade och raderade';
  }

  @override
  String archiveFailed(String error) {
    return 'Inget raderades: arkivfilen kunde inte skrivas ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Databas $db, foton $photos i $count filer';
  }

  @override
  String quietForYears(int years) {
    return 'Orörda i $years år';
  }

  @override
  String get nothingToArchive => 'Inget är gammalt nog att arkivera.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Senaste ändring $date · foton $size';
  }

  @override
  String get helpArchive =>
      'Gamla data kostar plats, framför allt bilderna som varje synkad enhet bär med sig. Här väljer du avlidna katter och tomma kolonier som legat stilla i åratal, skriver dem till en fil du behåller och raderar dem. Raderingen når alla du synkar med; att importera filen återställer allt.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Återställa $count raderade poster?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names är raderade i den här katalogen, och filen du just importerade innehåller dem. Att återställa hämtar tillbaka dem här och på varje enhet du synkar med.';
  }

  @override
  String get restoreAction => 'Återställ';

  @override
  String get keepDeleted => 'Låt vara raderade';

  @override
  String get archiveNotSaved =>
      'Inget raderades: arkivet sparades inte någonstans.';

  @override
  String get locateAddress => 'Hitta adressen på kartan';

  @override
  String get addressLocated => 'Adress hittad';

  @override
  String get addressNotFound =>
      'Ingen plats hittades för adressen. Kontrollera stavningen eller lämna tomt.';

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
  String get typeUnitValue => 'Värde med enhet';

  @override
  String get dimension => 'Storhet';

  @override
  String get dimensionWeight => 'Vikt';

  @override
  String get dimensionLength => 'Längd';

  @override
  String get dimensionVolume => 'Volym';

  @override
  String get dimensionTemperature => 'Temperatur';

  @override
  String get unitsLabel => 'Enheter';

  @override
  String get unitsAuto => 'Som i din region';

  @override
  String get unitsMetric => 'Metriskt (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Imperial (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Vikt';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get iosLocalNetworkHint =>
      'Om det fortsätter misslyckas på iPhone/iPad: Inställningar → Integritet och säkerhet → Lokalt nätverk → tillåt cat(a)log och försök igen.';

  @override
  String get includePrivate => 'Dela privata data';

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
  String get statusForeverHome => 'Hem';

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
      'Konfetti och jubel när en katt flyttar till sitt hem';

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
  String get syncChooserInPersonSub => 'Synkronisering via Wi-Fi';

  @override
  String get syncChooserRemote => 'På distans';

  @override
  String get syncChooserRemoteSub => 'Synkronisering via mapp eller USB-minne';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub => 'Export och import via sociala medier';

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
  String get introTitle1 => 'Dina katter, ordnade';

  @override
  String get introBody1 =>
      'Skapa ett kort för varje katt: foto, kön, hälsa, allt du vill anteckna. Katterna grupperas efter var de bor — appen kallar en sådan plats för clowder.';

  @override
  String get introTitle2 => 'Fungerar utan internet';

  @override
  String get introBody2 =>
      'Allt sparas bara på din telefon. Inget konto, inget moln. Inget laddas upp om du inte själv delar det.';

  @override
  String get introTitle3 => 'Arbeta tillsammans';

  @override
  String get introBody3 =>
      'Alla använder sin egen app och ni byter data då och då: träffas och skanna en kod, använd en delad mapp eller skicka en fil via messenger. Efteråt har alla samma information.';

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
      'Här synkar du med dina bekanta. Du bestämmer vad du delar.';

  @override
  String get spotHomeStrays =>
      'Det här kortet samlar alla strykare — katter utan hem. Tryck för att se listan.';

  @override
  String get spotHomeMenu =>
      'I den här menyn: hitta och slå ihop dubbletter, exportera CSV med mera.';

  @override
  String get spotCatEdit =>
      'Tryck på pennan för att redigera katten. Tips: långtryck på ett fält för att redigera det direkt.';

  @override
  String get spotMapLayers =>
      'Letar du efter en försvunnen katt? Visa cirklar runt platserna för dess anslag och runt dess förra hem.';

  @override
  String get spotStraysFlier =>
      'Hittat ett anslag om en försvunnen katt? Fotografera det här — appen sparar katt och kontakt åt dig.';

  @override
  String get spotStraysScan =>
      'Vissa anslag bär en cat(a)log-QR-kod. Skanna den här och importera katten utan att skriva.';

  @override
  String get introTitle4 => 'Hitta försvunna katter';

  @override
  String get introBody4 =>
      'Ser du ett anslag om en försvunnen katt? Fotografera det i appen: den sparar katten, ägarens kontakt och platsen. Dyker en liknande strykare upp senare föreslår appen möjliga träffar.';

  @override
  String get spotMapSearch =>
      'Skriv en katt, plats eller person för att hoppa dit på kartan.';

  @override
  String get spotCardChips =>
      'Kryssa i vad som ska synas på det delbara kortet — resten hålls utanför.';

  @override
  String get spotCatMenu =>
      'Här finns fler åtgärder: dölj katten, slå ihop dubbletter eller notera en observation.';

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

  @override
  String get catalogsTitle => 'Kataloger';

  @override
  String get newCatalog => 'Ny katalog';

  @override
  String get intoCatalog => 'Till katalog';

  @override
  String get catalogNameLabel => 'Katalogens namn';

  @override
  String catalogNameTaken(String name) {
    return 'Det finns redan en katalog som heter $name. Välj ett annat namn.';
  }

  @override
  String get manageCatalogs => 'Hantera kataloger';

  @override
  String get helpCatalogs =>
      'Varje katalog är en egen värld: egna katter, kolonier, fält, foton och synkroniseringspartner. Berlin och Paris blandas aldrig. Tryck på namnet högst upp på startskärmen för att byta, lägga till eller byta namn. Ditt namn, ditt språk och tipsen du sett delas av alla.';

  @override
  String get spotHomeCatalog =>
      'Det här är katalogen du är i. Tryck på namnet för att byta eller skapa en ny.';

  @override
  String get deleteCatalog => 'Ta bort katalog';

  @override
  String deleteCatalogBody(String name) {
    return 'Allt i $name försvinner: katterna, fotona, historiken. Först sparas en komplett fil där de automatiska säkerhetskopiorna hamnar — att importera den hämtar tillbaka katalogen. Skriv namnet för att bekräfta.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name har tagits bort. Filen finns i $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Skriv $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Inget togs bort: katalogfilen kunde inte skrivas ($error). Frigör utrymme eller försök igen senare.';
  }

  @override
  String get moveToCatalog => 'Flytta till en annan katalog';

  @override
  String movedToCatalog(int count, String name) {
    return '$count flyttade till $name';
  }

  @override
  String get chooseWhatToMove => 'Vad ska flyttas?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Ska något flyttas till $name?';
  }

  @override
  String get undoThisImport => 'Ångra den här importen';

  @override
  String undoImportBody(int count) {
    return 'De $count ändringar den här importen förde in tas bort. De skrivs först till en fil, och att importera den hämtar tillbaka dem. De du redan synkat med behåller sin kopia — det går inte att ta tillbaka.';
  }

  @override
  String undoneImport(String where) {
    return 'Ångrat. Filen finns i $where.';
  }

  @override
  String get goBackTitle => 'Gå tillbaka';

  @override
  String get goBackToHere => 'Gå tillbaka hit';

  @override
  String get momentImport => 'Före importen';

  @override
  String get momentSync => 'Före synkroniseringen';

  @override
  String get momentMerge => 'Före sammanslagningen';

  @override
  String get momentHardDelete => 'Före radering av en författares data';

  @override
  String get momentArchive => 'Före arkiveringen';

  @override
  String get momentManual => 'Markerat av dig';

  @override
  String get showOlderMoments => 'Visa äldre';

  @override
  String goBackBody(int count) {
    return 'Allt efter det här ögonblicket tas bort — $count ändringar. Det skrivs först till en fil, och att importera den hämtar tillbaka allt; varje nyare ögonblick följer med. De du redan synkat med behåller sin kopia — det går inte att ta tillbaka.';
  }

  @override
  String get nameThisMoment => 'Ge det här ögonblicket ett namn';

  @override
  String get helpGoBack =>
      'Ögonblicken då den här katalogen ändrade form: före varje import och varje synkronisering, före en sammanslagning, en arkivering eller en radering — och varje gång du själv markerade ett. Väljer du ett går katalogen tillbaka till det tillståndet: allt därefter skrivs till en fil du behåller och tas sedan bort, och varje nyare ögonblick följer med. De du redan synkat med behåller det de fick.';

  @override
  String goBackFileFailed(String error) {
    return 'Inget togs bort: filen som bevarar det kunde inte skrivas ($error). Frigör utrymme och försök igen.';
  }

  @override
  String get goBackChanged =>
      'Inget togs bort: katalogen ändrades medan filen sparades. Försök igen.';

  @override
  String get switchBeforeDeleting =>
      'Det här är katalogen du är i. Byt till en annan och ta bort den sedan.';

  @override
  String shareFileFailed(String error) {
    return 'Delningsfilen kunde inte skrivas ($error). Frigör utrymme och försök igen.';
  }

  @override
  String get privateLabel => 'Privat';

  @override
  String sharedCatalogIs(String name) {
    return 'Katalog: $name';
  }

  @override
  String get markPrivate => 'Markera som privat';

  @override
  String get unmarkPrivate => 'Ta bort privat markering';

  @override
  String get agenda => 'Påminnelser';

  @override
  String get reminderLabel => 'Påminnelse';

  @override
  String get agendaEmpty =>
      'Inga möten planerade. Planera nya här med plusset eller på en katts eller clowders sida.';

  @override
  String get dueToday => 'i dag';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'om $count dagar',
      one: 'om 1 dag',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagar försenad',
      one: '1 dag försenad',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Klar';

  @override
  String get repeatTitle => 'Igen om…';

  @override
  String get noRepeatLabel => 'Ingen upprepning';

  @override
  String get unitDays => 'dagar';

  @override
  String get unitWeeks => 'veckor';

  @override
  String get unitMonths => 'månader';

  @override
  String get unitYears => 'år';

  @override
  String ageYears(int years) {
    return '$years år';
  }

  @override
  String ageMonths(int months) {
    return '$months mån';
  }

  @override
  String get changeDateLabel => 'Ändra datum';

  @override
  String get removeReminderLabel => 'Ta bort påminnelse';

  @override
  String get exportIcs => 'Exportera kalenderfil';

  @override
  String get resyncCalendar => 'Synkronisera kalendern igen';

  @override
  String icsSavedTo(String path) {
    return 'Kalenderfil sparad under $path';
  }

  @override
  String get calendarMirrorLabel => 'Spegla till enhetens kalender';

  @override
  String get calendarMirrorSubtitle =>
      'Mötena visas som heldagshändelser i kalendern. cat(a)log uppdaterar dem där vid varje start och efter varje ändring. Påminnelser om mötena hanterar du i kalendern.';

  @override
  String get syncPeerOlder =>
      'Den andra enheten kör ett äldre cat(a)log utan påminnelser. Uppdatera cat(a)log där och synkronisera igen.';

  @override
  String get syncPeerNewer =>
      'Den andra enheten kör ett nyare cat(a)log. Uppdatera cat(a)log på den här enheten och synkronisera igen.';

  @override
  String get bundleNewerError =>
      'Den här filen kommer från ett nyare cat(a)log. Uppdatera cat(a)log på den här enheten för att importera den.';

  @override
  String get spotEar =>
      'Ett litet kattöra i ett hörn betyder: håll intryckt för mer.';

  @override
  String get addReminder => 'Lägg till påminnelse';

  @override
  String get plannedSection => 'Planerat';

  @override
  String get reminderDialogHint =>
      'Mötet visas bland påminnelserna. Där kan du bekräfta eller förkasta det. Värdet tas över först när mötet är bekräftat.';

  @override
  String get reminderFor => 'För';

  @override
  String get reminderField => 'Fält';

  @override
  String get dueDateLabel => 'Förfallodatum';

  @override
  String get pickCalendar => 'Vilken kalender?';

  @override
  String get calendarPermissionDenied =>
      'Kalenderåtkomst är blockerad, så speglingen är av. Tillåt den i systeminställningarna och slå på speglingen igen.';

  @override
  String get calendarNotChosen =>
      'Ingen kalender vald, så speglingen är av. Slå på den igen och välj en.';

  @override
  String get calendarGone =>
      'Den valda kalendern finns inte längre, så speglingen är av. Slå på den igen och välj en annan.';

  @override
  String get noWritableCalendar =>
      'Ingen kalender hittades. Logga in på ett kalenderkonto i systeminställningarna, till exempel Google, och försök igen.';

  @override
  String get spotHomeAgenda =>
      'Påminnelser: listan över planerade möten — veterinär, medicin, kontroller.';

  @override
  String get spotAgendaAdd => 'Planera ett nytt möte.';

  @override
  String get spotAgendaCalendar =>
      'Slå på spegling av cat(a)log-mötena till en kalender du väljer här.';

  @override
  String get helpAgenda =>
      'Påminnelserna visar de planerade mötena efter datum. Det finns två slag: möten med ett klockslag och påminnelser som gäller för en dag. Missade möten stannar överst. Tryck öppnar katten eller clowdern. Bocken bekräftar ett möte: värdet skrivs i fältet och du kan genast planera nästa, till exempel om tre månader. Håll intryckt för att ändra datum eller ta bort mötet. Brytaren överst speglar mötena till en kalender i din telefon. Menyn exporterar dem som kalenderfil. Ett veterinärbesök med flera katter är en bokning: markera katterna, Agendan visar ett kort med deras namn, och vid avslut frågas vilka katter som behandlades — avmarkera de andra, de förblir planerade.';

  @override
  String get calendarRowOff => 'Kalender: av';

  @override
  String calendarRowOn(String name) {
    return 'Kalender: $name';
  }

  @override
  String get spotAddReminderCat =>
      'Planera ett möte för den här katten. Det visas bland påminnelserna och bekräftas där.';

  @override
  String get spotAddReminderClowder =>
      'Planera ett möte för den här clowdern. Det visas bland påminnelserna och bekräftas där.';

  @override
  String get readOnlyCalendar => 'skrivskyddad';

  @override
  String get appointmentLabel => 'Möte';

  @override
  String get addAppointment => 'Lägg till möte';

  @override
  String get planChooserTitle => 'Möte eller påminnelse?';

  @override
  String get planChooserAppointment =>
      'Möte — ett besök på ett datum och en tid, med anteckningar';

  @override
  String get planChooserReminder =>
      'Påminnelse — ett värde som förfaller en dag';

  @override
  String get appointmentTitleLabel => 'Vad';

  @override
  String get notesLabel => 'Anteckningar';

  @override
  String get timeLabel => 'Tid';

  @override
  String get allDayLabel => 'Hela dagen';

  @override
  String get alertLabel => 'Avisering';

  @override
  String get alertNone => 'Ingen';

  @override
  String get alertDayBefore => 'Dagen innan';

  @override
  String get alertHourBefore => 'En timme innan';

  @override
  String get linkFieldLabel => 'Skriv i ett fält när det är klart';

  @override
  String get noLinkedField => 'Inget fält';

  @override
  String get outcomeTitle => 'Hur gick det?';

  @override
  String get finishLabel => 'Avsluta';

  @override
  String get editLabelAppointment => 'Redigera möte';

  @override
  String get deleteAppointment => 'Ta bort möte';

  @override
  String get stepFlierText => 'Anslagets text';

  @override
  String get qrFoundHint =>
      'En QR-kod hittades på anslaget. Markerade koder läses för registernummer och länkar.';

  @override
  String get useCode => 'Använd den här koden';

  @override
  String get qrNone => 'Ingen QR-kod hittades på bilden.';

  @override
  String qrFailed(String error) {
    return 'Läsning av QR-kod misslyckades: $error';
  }

  @override
  String flierRecognized(String name) {
    return '$name-anslag igenkänt. Kontrollera nedan vilket fält varje rad går till.';
  }

  @override
  String get flierLayoutUnknown =>
      'Okänd anslagslayout. Tilldela raderna till fält nedan; resten stannar i anmärkningarna.';

  @override
  String get targetRegistryNumber => 'Registernummer';

  @override
  String get targetLostPlace => 'Adress (försvunnen från)';

  @override
  String get targetContact => 'Registrets kontakt';

  @override
  String get targetDrop => 'Kasta';

  @override
  String get existingCat => 'Befintlig katt';

  @override
  String get existingClowder => 'Befintlig grupp';

  @override
  String get createNewInstead => 'Ingen — skapa ny';

  @override
  String overwritesValue(String value) {
    return 'Skriver över nuvarande värde \"$value\"';
  }

  @override
  String get abortScanTitle => 'Avbryta registreringen?';

  @override
  String get abortScanBody => 'Inget sparas.';

  @override
  String get abortScan => 'Avbryt';

  @override
  String get keepScanning => 'Fortsätt';

  @override
  String get catsOnAppointment => 'Katter på denna bokning';

  @override
  String get noCatsHint => 'Ingen katt markerad — bokningen är kolonins egen.';

  @override
  String get pickCatsTitle => 'Vilka katter följer med?';

  @override
  String catsCount(int count) {
    return '$count katter';
  }

  @override
  String get finishUntickHint =>
      'Avmarkera katter som inte behandlades; de förblir planerade.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Ta bort bokningen för alla $count katter';
  }
}
