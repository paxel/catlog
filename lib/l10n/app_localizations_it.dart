// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Benvenuto in cat(a)log';

  @override
  String get welcomeBody =>
      'Scegli un nome per te. Ogni modifica viene registrata con questo nome, così gli altri vedono chi ha fatto cosa.';

  @override
  String get yourName => 'Il tuo nome';

  @override
  String get start => 'Inizia';

  @override
  String get clowders => 'Clowder';

  @override
  String get noClowdersYet =>
      'Ancora nessun clowder.\nCrea il primo qui sotto.';

  @override
  String get strays => 'Randagi';

  @override
  String get searchCats => 'Cerca gatti';

  @override
  String get map => 'Mappa';

  @override
  String get sync => 'Sincronizza';

  @override
  String get fields => 'Campi';

  @override
  String get exportCsv => 'Esporta CSV';

  @override
  String get aboutAndFeedback => 'Informazioni e feedback';

  @override
  String get newClowder => 'Nuovo clowder';

  @override
  String get name => 'Nome';

  @override
  String get cancel => 'Annulla';

  @override
  String get create => 'Crea';

  @override
  String get save => 'Salva';

  @override
  String get delete => 'Elimina';

  @override
  String get merge => 'Unisci';

  @override
  String get resolve => 'Risolvi';

  @override
  String get open => 'Apri';

  @override
  String csvSavedTo(String path) {
    return 'CSV salvato in $path';
  }

  @override
  String get renameClowder => 'Rinomina clowder';

  @override
  String get rename => 'Rinomina';

  @override
  String get timeline => 'Cronologia';

  @override
  String get mergeInto => 'Unisci con…';

  @override
  String get deleteClowder => 'Elimina clowder';

  @override
  String get cats => 'Gatti';

  @override
  String get addCat => 'Aggiungi gatto';

  @override
  String get newCat => 'Nuovo gatto';

  @override
  String deleteQuestion(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'Il clowder scompare dall\'elenco.';

  @override
  String deleteClowderBody(int count) {
    return 'I suoi $count gatto/i non vengono eliminati — diventano randagi. Spostali prima in un altro clowder se non è ciò che vuoi.';
  }

  @override
  String get card => 'Scheda';

  @override
  String get shareAsImage => 'Condividi come immagine';

  @override
  String get shareAsPdf => 'Condividi come PDF';

  @override
  String get print => 'Stampa';

  @override
  String cardTitle(String name) {
    return 'Scheda — $name';
  }

  @override
  String get renameCat => 'Rinomina gatto';

  @override
  String get seenHereNow => 'Visto qui ora';

  @override
  String get deleteCat => 'Elimina gatto';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Randagio — senza clowder';

  @override
  String get stray => 'Randagio';

  @override
  String get photos => 'Foto';

  @override
  String get addPhoto => 'Aggiungi foto';

  @override
  String get setAsProfileImage => 'Imposta come foto profilo';

  @override
  String get thisIsProfileImage => 'Questa è la foto profilo';

  @override
  String get deletePhoto => 'Elimina foto';

  @override
  String get deletePhotoTitle => 'Eliminare la foto?';

  @override
  String get deletePhotoBody =>
      'I dati della foto vengono rimossi per sempre — non si può annullare.';

  @override
  String get deleteCatBody =>
      'Il gatto scompare da tutti gli elenchi. Le sue foto vengono rimosse per sempre.';

  @override
  String get sightingRecorded => 'Avvistamento registrato alla tua posizione.';

  @override
  String get noLocationAvailable =>
      'Posizione non disponibile — tieni premuto sulla mappa invece.';

  @override
  String get moveTo => 'Sposta in';

  @override
  String get noClowderStrayOption => 'Nessun clowder — randagio / scappato';

  @override
  String timelineOf(String name) {
    return 'Cronologia — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Annulla questa modifica';

  @override
  String get revertSubtitle =>
      'Ripristina il valore precedente come nuova voce — la cronologia conserva entrambi.';

  @override
  String fieldCleared(String field) {
    return '$field svuotato';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field torna a \"$value\"';
  }

  @override
  String get leftStray => 'Andato via — randagio';

  @override
  String movedTo(String name) {
    return 'Spostato in $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat è arrivato';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat è arrivato da $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat è andato a $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicato unito';

  @override
  String get asOfToday => 'In data odierna';

  @override
  String asOfDate(String date) {
    return 'In data $date';
  }

  @override
  String get value => 'Valore';

  @override
  String get latitudeLongitude => 'latitudine, longitudine';

  @override
  String get newField => 'Nuovo campo';

  @override
  String get fieldType => 'Tipo';

  @override
  String get usedOn => 'Usato per';

  @override
  String get forCats => 'gatti';

  @override
  String get forClowders => 'clowder';

  @override
  String get forBoth => 'entrambi';

  @override
  String get optionsOnePerLine => 'Opzioni (una per riga)';

  @override
  String get renameField => 'Rinomina campo';

  @override
  String get noStraysRightNow => 'Nessun randagio al momento.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Aggiungi randagio';

  @override
  String get newStray => 'Nuovo randagio';

  @override
  String get searchByNameHint => 'Cerca gatti per nome…';

  @override
  String get host => 'Ospita';

  @override
  String get hostExplainer =>
      'Inizia qui, poi inserisci indirizzo e PIN sull\'altro dispositivo.';

  @override
  String get startHosting => 'Inizia a ospitare';

  @override
  String get stopHosting => 'Smetti di ospitare';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count sessione/i finora';
  }

  @override
  String get join => 'Partecipa';

  @override
  String get addressFromHost => 'Indirizzo (dal dispositivo che ospita)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sincronizza ora';

  @override
  String get addressFormatHint =>
      'L\'indirizzo deve essere tipo 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sincronizzato: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Sincronizzazione fallita: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Ultima sincronizzazione con $peer: $time';
  }

  @override
  String get sharedFolder => 'Cartella condivisa';

  @override
  String get sharedFolderExplainer =>
      'Sincronizza tramite una cartella trasportata da un cloud o una chiavetta USB — per chi non è sulla stessa rete.';

  @override
  String get noFolderChosenYet => 'Nessuna cartella scelta';

  @override
  String get choose => 'Scegli…';

  @override
  String get syncFolderNow => 'Sincronizza cartella ora';

  @override
  String folderSynced(String result) {
    return 'Cartella sincronizzata: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Sincronizzazione cartella fallita: $error';
  }

  @override
  String get recordSightingHere => 'Registra un avvistamento qui:';

  @override
  String get orPlaceClowderHere => 'Oppure metti un clowder qui:';

  @override
  String trailOf(String name, int count) {
    return 'Percorso: $name ($count avvistamenti)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflitto — $field';
  }

  @override
  String get conflictBody =>
      'Modificato in due posti contemporaneamente. Scegli cosa è vero:';

  @override
  String mergeThisInto(String kind) {
    return 'Unisci questo $kind con…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Nessun altro $kind con cui unire.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Unire con $name?';
  }

  @override
  String mergeBody(String name) {
    return 'I due record diventano uno. $name mantiene i valori attuali; la cronologia dell\'altro si unisce alla sua. Non si può annullare.';
  }

  @override
  String get kindCat => 'gatto';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'campo';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String get about => 'Informazioni';

  @override
  String get aboutTagline =>
      'Un catalogo locale per gatti in affido. I tuoi dati restano sui tuoi dispositivi — niente server, niente account.';

  @override
  String versionLabel(String version, String build) {
    return 'Versione $version ($build)';
  }

  @override
  String get sourceCode => 'Codice sorgente';

  @override
  String get reportProblemOrIdea => 'Segnala un problema o un\'idea';

  @override
  String get githubIssues => 'Issue su GitHub';

  @override
  String get writeTheDeveloper => 'Scrivi allo sviluppatore';

  @override
  String get buyCoffee => 'Offri un caffè allo sviluppatore';

  @override
  String get coffeeSubtitle => 'Del tutto facoltativo — l\'app è gratis';

  @override
  String get openSourceLicenses => 'Licenze open source';

  @override
  String get machineTranslated =>
      'Le traduzioni sono automatiche — le correzioni sono benvenute su GitHub.';

  @override
  String get unnamed => '(senza nome)';

  @override
  String get labelName => 'Nome';

  @override
  String get labelProfileImage => 'Foto profilo';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Sesso';

  @override
  String get starterColor => 'Colore';

  @override
  String get starterNeutered => 'Sterilizzato';

  @override
  String get starterPregnant => 'Gravida';

  @override
  String get starterBirthdate => 'Data di nascita';

  @override
  String get starterDeceased => 'Deceduto';

  @override
  String get starterAddress => 'Indirizzo';

  @override
  String get starterResponsible => 'Persona responsabile';

  @override
  String get starterPosition => 'Posizione';

  @override
  String get valueYes => 'sì';

  @override
  String get valueNo => 'no';

  @override
  String get valueFemale => 'femmina';

  @override
  String get valueMale => 'maschio';

  @override
  String get valueUnknown => 'sconosciuto';

  @override
  String get cropTitle => 'Ritaglia foto';

  @override
  String get markTitle => 'Contrassegna il gatto';

  @override
  String get useFullPhoto => 'Usa la foto intera';

  @override
  String get dragToSelect => 'Trascina un rettangolo intorno al gatto';

  @override
  String get dragOverTheCat => 'Trascina un\'ellisse sul gatto';

  @override
  String get cropPhoto => 'Ritaglia…';

  @override
  String get markPhoto => 'Contrassegna…';

  @override
  String get scanCode => 'Scansiona codice';

  @override
  String get orTypeCode => 'Oppure digita il codice';

  @override
  String get copyCode => 'Copia codice';

  @override
  String get copied => 'Copiato';

  @override
  String get invalidCode => 'Codice non valido';

  @override
  String get hotspotHint =>
      'Niente Wi-Fi in comune? Attiva l\'hotspot di un telefono, collega l\'altro e ospita qui.';

  @override
  String get byMessenger => 'Via messenger';

  @override
  String get byMessengerExplainer =>
      'Invia tutto il catalogo come un solo file via WhatsApp, Signal o mail — l\'altra parte lo importa.';

  @override
  String get shareBundle => 'Condividi pacchetto di sincronizzazione…';

  @override
  String get importBundle => 'Importa pacchetto di sincronizzazione…';

  @override
  String bundleImported(String result) {
    return 'Pacchetto importato: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Importazione fallita: $error';
  }

  @override
  String get pickOnMap => 'Scegli sulla mappa';

  @override
  String get useMyLocation => 'Usa la mia posizione';

  @override
  String get language => 'Lingua';

  @override
  String get systemDefault => 'Predefinita di sistema';

  @override
  String get iosLocalNetworkHint =>
      'Se continua a fallire su iPhone/iPad: Impostazioni → Privacy e sicurezza → Rete locale → consenti cat(a)log, poi riprova.';

  @override
  String get markPrivate => 'Segna come privato';

  @override
  String get unmarkPrivate => 'Rimuovi contrassegno privato';

  @override
  String get includePrivate => 'Includi dati privati';

  @override
  String get includePrivateExplainer =>
      'Anche gatti, clowder e campi privati vengono condivisi — attivalo solo quando sincronizzi i tuoi dispositivi.';

  @override
  String get hideLabel => 'Nascondi su questo dispositivo';

  @override
  String get unhideLabel => 'Mostra di nuovo';

  @override
  String get showHiddenLabel => 'Mostra nascosti';

  @override
  String get stopShowingHidden => 'Smetti di mostrare i nascosti';

  @override
  String get starterSpecies => 'Specie';

  @override
  String get starterStatus => 'Stato';

  @override
  String get statusFoster => 'Casa affidataria';

  @override
  String get statusForeverHome => 'Casa per sempre';

  @override
  String get statusClinic => 'Clinica';

  @override
  String get statusShelter => 'Rifugio';

  @override
  String get statusBarn => 'Fienile';

  @override
  String get valueCat => 'Gatto';

  @override
  String get otherOption => 'Altro…';

  @override
  String get celebrationsToggle => 'Festeggia le adozioni';

  @override
  String get celebrationsSubtitle =>
      'Coriandoli e applausi quando un gatto trasloca nella casa per sempre';

  @override
  String get onMapLabel => 'Sulla mappa';

  @override
  String get showOnMap => 'Mostra sulla mappa';

  @override
  String get searchPlaceHint => 'Cerca luogo o indirizzo';

  @override
  String get noPlacesFound => 'Nessun luogo trovato';

  @override
  String get mapSearchHint => 'Cerca gatti, clowder, persone';

  @override
  String get proposeAnotherName => 'Proponi un altro nome';

  @override
  String get moderationTitle => 'Autori e blocchi';

  @override
  String get moderationSubtitle => 'Rimuovere per sempre i dati di una persona';

  @override
  String get authorsSection => 'Chi ha scritto in questo catalogo';

  @override
  String get hardDeleteAction => 'Elimina tutto di questo autore';

  @override
  String hardDeleteWarning(Object name) {
    return 'Rimuove ogni voce e foto di $name da questo dispositivo. Gli altri dispositivi conservano le loro. Irreversibile.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Digita $name per confermare';
  }

  @override
  String get alsoBan => 'Blocca anche — mai più accettare i suoi dati';

  @override
  String get bansSection => 'Blocchi';

  @override
  String get unbanAction => 'Rimuovi blocco';

  @override
  String get deletedDone => 'Eliminato.';

  @override
  String get syncSummaryTitle => 'Cosa è arrivato';

  @override
  String get summaryAdopted => 'Adottati';

  @override
  String get summaryDeceased => 'Deceduti';

  @override
  String get summaryEscaped => 'Scappati';

  @override
  String get summaryNew => 'Nuovi';

  @override
  String get summaryConflicts => 'Conflitti da risolvere';

  @override
  String summaryOther(Object n) {
    return '…e altre $n modifiche';
  }

  @override
  String get starterMother => 'Madre';

  @override
  String get starterFather => 'Padre';

  @override
  String get familySection => 'Famiglia';

  @override
  String get littermatesLabel => 'Della stessa cucciolata';

  @override
  String get siblingsLabel => 'Fratelli';

  @override
  String get kittensLabel => 'Gattini';

  @override
  String get toastSettingsTitle => 'Cosa annunciare';

  @override
  String get toastSettingsSubtitle =>
      'Piccoli messaggi dopo una sincronizzazione';

  @override
  String get toastKindAdoptions => 'Adozioni';

  @override
  String get toastKindBirths => 'Nascite';

  @override
  String get toastKindDeaths => 'Decessi';

  @override
  String get toastKindEscapes => 'Fughe';

  @override
  String get toastKindMoves => 'Traslochi';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adottato da $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nuovo gattino: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat è venuto a mancare';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat è scappato';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat si è trasferito da $home';
  }

  @override
  String get notACatlogFile => 'Questo non è un file cat(a)log';

  @override
  String get nothingNewInBundle => 'Niente di nuovo nel file — hai già tutto';

  @override
  String get syncChooserInPerson => 'Di persona';

  @override
  String get syncChooserInPersonSub =>
      'Siete nella stessa stanza — scansiona un codice, fatto in secondi';

  @override
  String get syncChooserRemote => 'A distanza';

  @override
  String get syncChooserRemoteSub =>
      'Tramite una cartella condivisa come Dropbox o una chiavetta USB';

  @override
  String get syncChooserMessenger => 'Messenger';

  @override
  String get syncChooserMessengerSub =>
      'Invia tutto come un unico file con qualsiasi messenger';

  @override
  String get connectToWifiFirst =>
      'Collegati prima a una Wi-Fi — così i dispositivi si trovano';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) vuole sincronizzare';
  }

  @override
  String get trustBothWaysNote =>
      'I cataloghi verranno scambiati in entrambe le direzioni.';

  @override
  String get allowOnce => 'Consenti';

  @override
  String get allowAlways => 'Consenti sempre questo dispositivo';

  @override
  String get declineAction => 'Rifiuta';

  @override
  String get syncDeclined =>
      'L\'altro dispositivo ha rifiutato la sincronizzazione';

  @override
  String get trustedDevicesSection => 'Dispositivi sempre consentiti';

  @override
  String get removeTrust => 'Rimuovi';

  @override
  String get hostWithoutWifi => 'Ospita senza Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Crea una connessione diretta temporanea con l\'altro telefono (senza internet). La usa solo cat(a)log e si disconnette da sola dopo la sincronizzazione.';

  @override
  String get hotspotAndroidOnly =>
      'Questo codice richiede due telefoni Android — su iPhone/iPad usa una Wi-Fi condivisa';
}
