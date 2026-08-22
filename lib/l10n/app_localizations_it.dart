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
      'Ancora nessun clowder. Un clowder è un posto dove vivono i gatti — la tua casa affidataria, l\'appartamento di un adottante. Crea il primo qui sotto.';

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
      'Il gatto sparisce da tutte le liste e le sue foto vengono rimosse — qui e, dopo la prossima sincronizzazione, anche sugli altri dispositivi.';

  @override
  String get sightingRecorded => 'Avvistamento registrato alla tua posizione.';

  @override
  String get noLocationAvailable =>
      'Posizione non disponibile — tieni premuto sulla mappa invece.';

  @override
  String get locationDeniedForever =>
      'L\'accesso alla posizione è bloccato. Consentilo nelle impostazioni di sistema per usare Stray Cam.';

  @override
  String get locationServiceOff =>
      'La posizione è disattivata su questo dispositivo. Attivala nelle impostazioni e riprova.';

  @override
  String get locationDenied =>
      'cat(a)log non ha il permesso di usare la tua posizione. Riprova e consentilo quando richiesto.';

  @override
  String get locationNoFix =>
      'Non è stato possibile determinare la tua posizione. Riprova all\'aperto — il GPS ha bisogno di una visuale libera del cielo.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Numero di chip';

  @override
  String get starterRemarks => 'Note';

  @override
  String get captureFlier => 'Fotografa volantino';

  @override
  String get addPhotosTo => 'Aggiungi foto a…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foto aggiunte a $name';
  }

  @override
  String get scanPrintedCode => 'Scansiona codice stampato';

  @override
  String get chipScanHint =>
      'Scansiona il QR/codice a barre stampato dalla tessera del chip o dai documenti veterinari — il telefono non può leggere il chip dentro il gatto.';

  @override
  String get savingLabel => 'Salvataggio…';

  @override
  String ownerOfCat(String name) {
    return 'Proprietario di $name';
  }

  @override
  String get sortLabel => 'Ordina';

  @override
  String get viewAsTable => 'Mostra come tabella';

  @override
  String get viewAsTiles => 'Mostra come riquadri';

  @override
  String get matchCandidatesTitle => 'Possibili corrispondenze';

  @override
  String get findDuplicates => 'Trova duplicati';

  @override
  String get noDuplicates => 'Nessun possibile duplicato al momento.';

  @override
  String get similarName => 'Nome simile';

  @override
  String get sharePublicly => 'Condividi pubblicamente…';

  @override
  String get privateNoShare =>
      'Questo gatto è contrassegnato come privato — i dati privati non lasciano mai il tuo dispositivo. Rimuovi prima il contrassegno per condividerlo pubblicamente.';

  @override
  String get pickFramesTitle => 'Scegli fotogrammi';

  @override
  String get suggestedFrames => 'Fotogrammi suggeriti';

  @override
  String get scrubFrames => 'Scorri il video';

  @override
  String get keepThisFrame => 'Tieni questo fotogramma';

  @override
  String get fromVideo => 'Da video…';

  @override
  String get videoMobileOnly =>
      'Scegliere fotogrammi da un video funziona nell\'app per telefono (Android e iPhone) — non ancora su questo dispositivo.';

  @override
  String get shareWhitelistExplainer =>
      'Scegli cosa entra nel file. Sono inclusi solo i campi spuntati.';

  @override
  String get exportShareFile => 'Esporta file di condivisione…';

  @override
  String get hostedLink => 'Link ospitato (URL del file caricato)';

  @override
  String get inlineQr => 'QR integrato (solo testo, senza foto)';

  @override
  String get inlineTooBig =>
      'Troppi dati per un codice integrato — deseleziona campi o usa un link ospitato.';

  @override
  String get scanShareLabel => 'Scansiona codice di condivisione';

  @override
  String get notAShareCode => 'Quel codice non è una condivisione cat(a)log.';

  @override
  String get importShareTitle => 'Importare questo gatto?';

  @override
  String shareSource(String url) {
    return 'Fonte: $url';
  }

  @override
  String get importLabel => 'Importa';

  @override
  String get strayAreaLabel => 'Possibile area di vagabondaggio';

  @override
  String get prevPin => 'Segnaposto precedente';

  @override
  String get nextPin => 'Segnaposto successivo';

  @override
  String get noMissingCats =>
      'Ancora nessun gatto scomparso con posizioni di volantini.';

  @override
  String get noMatchCandidates =>
      'Nessuna possibile corrispondenza al momento.';

  @override
  String sameIdField(String field) {
    return 'Stesso $field';
  }

  @override
  String metersApart(String distance) {
    return 'A $distance m di distanza';
  }

  @override
  String get addFlier => 'Aggiungi volantino';

  @override
  String get missingSinceLabel => 'Scomparso dal';

  @override
  String get phoneLabel => 'Telefono';

  @override
  String get cropPortrait => 'Ritaglia ritratto';

  @override
  String get statusOwner => 'Proprietario';

  @override
  String get ocrUnavailable =>
      'Il riconoscimento del testo non è disponibile su questo dispositivo — digita tu il testo del volantino.';

  @override
  String get displayFormat => 'Mostrato come';

  @override
  String get displayPlain => 'Testo semplice';

  @override
  String get displayQr => 'Codice QR';

  @override
  String get displayBarcode => 'Codice a barre';

  @override
  String get editLabel => 'Modifica';

  @override
  String get doneLabel => 'Fatto';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get notSaved => 'Non salvato';

  @override
  String get birthdateInFuture =>
      'La data di nascita non può essere nel futuro.';

  @override
  String get deceasedInFuture => 'La data di morte non può essere nel futuro.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'La data di morte non può precedere la data di nascita ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'La data di nascita non può seguire la data di morte ($date).';
  }

  @override
  String get malePregnant =>
      'Questo gatto è registrato come maschio — un maschio non può essere gravido. Controlla prima il sesso.';

  @override
  String fatherNotMale(String name) {
    return '$name è registrata come femmina e non può essere il padre. Controlla prima il sesso.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name è registrato come maschio e non può essere la madre. Controlla prima il sesso.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name è nato il $date — un genitore non può nascere dopo il suo cucciolo.';
  }

  @override
  String get genderFatherFemale =>
      'Questo gatto è registrato come padre di altri gatti — il padre non può essere femmina. Controlla prima la famiglia.';

  @override
  String get genderMotherMale =>
      'Questo gatto è registrato come madre di altri gatti — la madre non può essere maschio. Controlla prima la famiglia.';

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
  String dateFormatError(String format) {
    return 'Formato errato — usa $format';
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
  String get ownValue => 'Valore personalizzato';

  @override
  String get renameField => 'Rinomina campo';

  @override
  String get editOptions => 'Modifica opzioni…';

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
      'Entrambi i dispositivi usano la stessa cartella (per esempio in Dropbox o su una chiavetta USB). Ogni sincronizzazione vi deposita le tue modifiche e raccoglie quelle dell\'altro.';

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
  String get starterBreed => 'Razza';

  @override
  String get valueMixed => 'meticcio';

  @override
  String get breedEuropeanShorthair => 'Europeo a pelo corto';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'British Shorthair';

  @override
  String get breedNorwegianForestCat => 'Gatto delle foreste norvegesi';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamese';

  @override
  String get breedPersian => 'Persiano';

  @override
  String get breedBengal => 'Bengala';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Telefono';

  @override
  String get lookupUrlLabel => 'Link di ricerca';

  @override
  String lookupUrlHelp(String token) {
    return 'La pagina del servizio con $token al posto del numero, per es. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Cerca';

  @override
  String lookupFailed(String url) {
    return 'Nessuna app ha potuto aprire $url. Copia il link in un browser.';
  }

  @override
  String get stepCat => 'Gatto';

  @override
  String get stepOwner => 'Proprietario';

  @override
  String get stepFace => 'Foto del muso';

  @override
  String get stepRegistry => 'Registro';

  @override
  String get stepReview => 'Controlla e salva';

  @override
  String get stepOwnerHint =>
      'Chi ha perso il gatto: questa diventa la sua scheda, con il contatto del volantino.';

  @override
  String get stepFaceHint =>
      'Ritaglia il muso del gatto dal volantino; diventa la foto del profilo. Puoi saltare questo passo.';

  @override
  String get stepRegistryHint =>
      'Numeri trovati sul volantino. Quelli spuntati vengono salvati con il gatto e si aprono più tardi.';

  @override
  String get noRegistryLinks =>
      'Nessun link di registro su questo volantino: qui non c\'è nulla da fare.';

  @override
  String get unknownServiceHint => 'Servizio sconosciuto';

  @override
  String get rememberService => 'Ricorda il servizio';

  @override
  String get rememberServiceHint =>
      'Dai un nome al servizio e indica il numero nel link. Il prossimo volantino si compilerà da solo.';

  @override
  String get noIdInLink =>
      'Questo link non contiene alcun numero che l\'app possa salvare.';

  @override
  String get whichNumber => 'Quale parte è il numero?';

  @override
  String get cropAgain => 'Ritaglia di nuovo';

  @override
  String get noFaceYet =>
      'Ancora nessuna foto del muso: si usa la foto del volantino.';

  @override
  String get backLabel => 'Indietro';

  @override
  String get dangerButton => 'NON PREMERE.\nPERICOLO';

  @override
  String get dangerThanks => 'Grazie per usare cat(a)log!';

  @override
  String get helpTitle => 'Aiuto';

  @override
  String get showTipsAgain => 'Mostra di nuovo i suggerimenti';

  @override
  String get helpHome =>
      'La panoramica delle tue colonie: una colonia è un luogo dove vivono gatti — casa tua, una stalla di sosta, un rifugio. Tocca una scheda per vederne i gatti; tieni premuto per il menu. Il pulsante in basso a destra crea una colonia, e la scheda dei randagi raccoglie tutti i gatti senza casa. Il nome in alto è il catalogo in cui sei: toccalo per cambiare o aggiungerne uno.';

  @override
  String get helpClowder =>
      'Tutto su questo luogo: i suoi gatti, i suoi campi (indirizzo, contatto, tipo) e la sua cronologia. La pagina si apre in sola lettura; la matita attiva la modifica, dove puoi anche aggiungere un campo. Tieni premuto un campo per modificarlo subito, un gatto per spostarlo, nasconderlo o aprirlo.';

  @override
  String get helpCat =>
      'Tutto su questo gatto: foto, campi, famiglia, cronologia. La pagina è in sola lettura finché non tocchi la matita. Tieni premuto un campo per modificarlo direttamente; una foto per il suo menu. Il menu in alto a destra ha il resto: segna privato, nascondi, unisci, registra un avvistamento, condividi.';

  @override
  String get helpStrays =>
      'Gatti che ora non hanno casa: trovati, scappati o presi da un volantino. Il pulsante fotocamera registra un gatto che hai davanti; il pulsante volantino trasforma un manifesto in un gatto con il contatto del proprietario; lo scanner legge un codice cat(a)log dal manifesto.';

  @override
  String get helpMap =>
      'Tutti i gatti e i luoghi con una posizione. La ricerca trova gatti, persone e luoghi: un nome sconosciuto viene cercato nel mondo. Il pulsante livelli disegna i cerchi da 500 m attorno ai volantini di un gatto scomparso e alla casa da cui è fuggito. Le frecce passano da un pin all\'altro, un tocco prolungato registra un avvistamento.';

  @override
  String get helpCard =>
      'La scheda stampabile del gatto: scegli in alto con i chip cosa compare, poi condividila come immagine o PDF. Gli identificativi si stampano come QR o codice a barre, e una posizione diventa un QR che apre una mappa, più un breve Plus Code.';

  @override
  String get helpSync =>
      'Come i dati arrivano ad altre persone: collegarsi di persona, usare una cartella che entrambi i dispositivi vedono, o inviare un file via messaggistica. Decidi sempre tu cosa parte — e i file .catsync ricevuti si aprono qui.';

  @override
  String get helpFields =>
      'I campi usati dal tuo catalogo. Rinominali, cambia le opzioni di un campo a scelta o creane di tuoi. Un campo identificativo può puntare a un servizio (un registro): allora il numero diventa toccabile sul gatto.';

  @override
  String get helpTimeline =>
      'Ogni modifica mai fatta, dalla più recente: chi ha cambiato cosa, quando e con quale valore. Ogni voce può essere annullata — questo scrive una nuova voce, nulla viene mai cancellato.';

  @override
  String get helpDuplicates =>
      'Gatti o colonie che sembrano esistere due volte: identificativi uguali o nomi molto simili con dettagli concordi. Tocca una coppia per unirla; l\'unione non si può annullare, perciò viene chiesto prima.';

  @override
  String get helpMatches =>
      'Gatti che potrebbero essere lo stesso animale: identificativo identico, o un randagio visto nell\'area di ricerca di un gatto scomparso. Tocca una coppia per unirla, tieni premuto per aprire il primo gatto e confrontare.';

  @override
  String get helpFlier =>
      'Un volantino fotografato diventa un gatto e il suo proprietario. Passo dopo passo: dati del gatto, contatto del proprietario, ritaglio del muso per la foto profilo, numeri di registro sul volantino, poi il controllo finale. Sono tutti suggerimenti: correggi ciò che la fotocamera ha letto male.';

  @override
  String get archiveTitle => 'Archivio';

  @override
  String get archiveExplainer =>
      'I gatti deceduti e le colonie vuote che nessuno tocca da anni occupano comunque spazio, soprattutto le loro foto. Archiviare li scrive in un file che tieni tu e poi li elimina da qui.';

  @override
  String get archiveAction => 'Archivia';

  @override
  String archiveSelected(int count) {
    return 'Archivia $count voci';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archiviare $count voci?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names verranno scritti in un file e poi eliminati — sul tuo dispositivo e su ogni dispositivo con cui sincronizzi. Importare il file riporta tutto; senza, sono persi.';
  }

  @override
  String archiveDone(int count) {
    return '$count voci archiviate ed eliminate';
  }

  @override
  String archiveFailed(String error) {
    return 'Non è stato eliminato nulla: il file di archivio non è stato scritto ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Database $db, foto $photos in $count file';
  }

  @override
  String quietForYears(int years) {
    return 'Ferme da $years anni';
  }

  @override
  String get nothingToArchive => 'Niente di abbastanza vecchio da archiviare.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Ultima modifica $date · foto $size';
  }

  @override
  String get helpArchive =>
      'I dati vecchi costano spazio, soprattutto le foto che ogni dispositivo sincronizzato si porta dietro. Qui scegli gatti deceduti e colonie vuote ferme da anni, li scrivi in un file che tieni tu e li elimini. L\'eliminazione raggiunge tutti quelli con cui sincronizzi; importare il file ripristina tutto.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Ripristinare $count voci eliminate?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names sono eliminati in questo catalogo e il file appena importato li contiene. Il ripristino li riporta qui e su ogni dispositivo con cui sincronizzi.';
  }

  @override
  String get restoreAction => 'Ripristina';

  @override
  String get keepDeleted => 'Lascia eliminati';

  @override
  String get archiveNotSaved =>
      'Non è stato eliminato nulla: l\'archivio non è stato salvato da nessuna parte.';

  @override
  String get locateAddress => 'Trova l\'indirizzo sulla mappa';

  @override
  String get addressLocated => 'Indirizzo trovato';

  @override
  String get addressNotFound =>
      'Nessun luogo trovato per questo indirizzo. Controlla l\'ortografia o lascia vuoto.';

  @override
  String get starterPosition => 'Posizione geografica';

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
  String get applyCrop => 'Ritaglia';

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
  String lastBackupFailed(String error) {
    return 'L\'ultimo backup automatico non è riuscito: $error';
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
      'Questo invia anche tutto ciò che hai contrassegnato come privato. Chi sincronizza con te lo vedrà.';

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
  String get starterStatus => 'Tipo';

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
      'Invia tutto come un unico file con qualsiasi messenger — e importa qui un file .catsync ricevuto';

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

  @override
  String get selectClowderHint => 'Scegli un clowder a sinistra';

  @override
  String get introTitle1 => 'I tuoi gatti, in ordine';

  @override
  String get introBody1 =>
      'Crea una scheda per ogni gatto: foto, sesso, salute, tutto ciò che vuoi annotare. I gatti sono raggruppati per il luogo in cui vivono — l\'app chiama quel luogo colonia (clowder).';

  @override
  String get introTitle2 => 'Funziona senza internet';

  @override
  String get introBody2 =>
      'Tutto viene salvato solo sul tuo telefono. Nessun account, nessun cloud. Nulla viene caricato finché non lo condividi tu.';

  @override
  String get introTitle3 => 'Lavorare insieme';

  @override
  String get introBody3 =>
      'Ognuno usa la propria app e ogni tanto scambiate i dati: incontratevi e scansionate un codice, usate una cartella condivisa o inviate un file via messenger. Dopo, tutti hanno le stesse informazioni.';

  @override
  String get introSkip => 'Salta';

  @override
  String get introNext => 'Avanti';

  @override
  String get introDone => 'Si parte';

  @override
  String get introReplayTitle => 'Introduzione rapida';

  @override
  String get spotHomeSync =>
      'Qui sincronizzi con i tuoi conoscenti. Decidi tu cosa condividere.';

  @override
  String get spotHomeStrays =>
      'Questa scheda raccoglie tutti i randagi — gatti senza casa. Toccala per vedere l\'elenco.';

  @override
  String get spotHomeMenu =>
      'In questo menu: trovare e unire i duplicati, esportare CSV e altro.';

  @override
  String get spotCatEdit =>
      'Tocca la matita per modificare questo gatto. Suggerimento: tieni premuto un campo per modificarlo direttamente.';

  @override
  String get spotMapLayers =>
      'Cerchi un gatto scomparso? Mostra cerchi attorno ai luoghi dei suoi volantini e alla casa da cui è scappato.';

  @override
  String get spotStraysFlier =>
      'Un volantino di gatto scomparso? Fotografalo qui — l\'app salva gatto e contatto per te.';

  @override
  String get spotStraysScan =>
      'Alcuni volantini hanno un codice QR cat(a)log. Scansionalo qui per importare il gatto senza digitare.';

  @override
  String get introTitle4 => 'Ritrovare i gatti scomparsi';

  @override
  String get introBody4 =>
      'Vedi un volantino di gatto scomparso? Fotografalo nell\'app: salva il gatto, il contatto del proprietario e il luogo. Se più tardi compare un randagio simile, l\'app suggerisce possibili corrispondenze.';

  @override
  String get spotMapSearch =>
      'Scrivi un gatto, un luogo o una persona per saltarci sulla mappa.';

  @override
  String get spotCardChips =>
      'Spunta ciò che deve comparire sulla scheda da condividere — il resto ne resta fuori.';

  @override
  String get spotCatMenu =>
      'Qui trovi altre azioni: contrassegnare il gatto come privato, nasconderlo, unire duplicati o registrare un avvistamento.';

  @override
  String get spotDone => 'Capito';

  @override
  String get spotReplayTitle => 'Tour delle novità';

  @override
  String get spotReplaySubtitle =>
      'Mostra di nuovo i suggerimenti su ogni pagina';

  @override
  String get spotReplayDone => 'I suggerimenti verranno mostrati di nuovo';

  @override
  String get searchNoResults => 'Nessun gatto trovato con quel nome';

  @override
  String get syncUnreachable =>
      'Impossibile raggiungere l\'altro dispositivo. Sono entrambi sulla stessa Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Impossibile raggiungere la cartella. Il disco o la cartella cloud esiste ancora?';

  @override
  String get crashTitle => 'Questo non doveva succedere';

  @override
  String get crashBody =>
      'cat(a)log ha incontrato un errore inatteso. I tuoi dati sono al sicuro — tutto viene salvato nel momento in cui lo modifichi. Riavvia l\'app e, se si ripete, invia il rapporto così può essere corretto.';

  @override
  String get crashRestart => 'Riavvia l\'app';

  @override
  String get crashSendReport => 'Invia rapporto allo sviluppatore';

  @override
  String get crashLastRunBody =>
      'cat(a)log si è fermato inaspettatamente l\'ultima volta — probabilmente ha esaurito la memoria. Inviare un breve rapporto per correggerlo?';

  @override
  String get catalogsTitle => 'Cataloghi';

  @override
  String get newCatalog => 'Nuovo catalogo';

  @override
  String get catalogNameLabel => 'Nome del catalogo';

  @override
  String catalogNameTaken(String name) {
    return 'Esiste già un catalogo chiamato $name. Scegli un altro nome.';
  }

  @override
  String get manageCatalogs => 'Gestisci cataloghi';

  @override
  String get helpCatalogs =>
      'Ogni catalogo è un mondo a sé: i suoi gatti, le sue colonie, i suoi campi, le sue foto e i suoi partner di sincronizzazione. Berlino e Parigi non si mescolano mai. Tocca il nome in alto per cambiare, aggiungerne uno o rinominarlo. Il tuo nome, la lingua e i suggerimenti già visti valgono per tutti.';

  @override
  String get spotHomeCatalog =>
      'Questo è il catalogo in cui sei. Tocca il nome per cambiare o crearne un altro.';

  @override
  String get deleteCatalog => 'Elimina catalogo';

  @override
  String deleteCatalogBody(String name) {
    return 'Tutto ciò che è in $name sparisce: i gatti, le foto, la cronologia. Prima viene salvato un file completo dove vanno i backup automatici; importarlo riporta indietro il catalogo. Scrivi il nome per confermare.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name eliminato. Il file è in $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Scrivi $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Non è stato eliminato nulla: il file del catalogo non è stato scritto ($error). Libera spazio o riprova più tardi.';
  }

  @override
  String get moveToCatalog => 'Sposta in un altro catalogo';

  @override
  String movedToCatalog(int count, String name) {
    return '$count spostati in $name';
  }

  @override
  String get chooseWhatToMove => 'Che cosa si sposta?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Spostare qualcosa in $name?';
  }

  @override
  String get undoThisImport => 'Annulla questa importazione';

  @override
  String undoImportBody(int count) {
    return 'I $count cambiamenti portati da questa importazione vengono tolti. Prima vengono scritti in un file; importarlo li riporta. Chi ha già sincronizzato conserva la sua copia: quello non si può ritirare.';
  }

  @override
  String undoneImport(String where) {
    return 'Annullato. Il file è in $where.';
  }

  @override
  String get goBackTitle => 'Torna indietro';

  @override
  String get goBackToHere => 'Torna qui';

  @override
  String get momentImport => 'Prima dell’importazione';

  @override
  String get momentSync => 'Prima della sincronizzazione';

  @override
  String get momentMerge => 'Prima dell’unione';

  @override
  String get momentHardDelete => 'Prima di eliminare i dati di un autore';

  @override
  String get momentArchive => 'Prima dell’archiviazione';

  @override
  String get momentManual => 'Segnato da te';

  @override
  String get showOlderMoments => 'Mostra i più vecchi';

  @override
  String goBackBody(int count) {
    return 'Tutto ciò che viene dopo questo momento viene tolto — $count cambiamenti. Prima viene scritto in un file; importarlo lo riporta, e ogni momento più recente se ne va con esso. Chi ha già sincronizzato conserva la sua copia: quello non si può ritirare.';
  }

  @override
  String get nameThisMoment => 'Dai un nome a questo momento';

  @override
  String get helpGoBack =>
      'I momenti in cui questo catalogo ha cambiato forma: prima di ogni importazione e di ogni sincronizzazione, prima di un’unione, di un’archiviazione o di una cancellazione, e ogni volta che ne hai segnato uno tu. Sceglierne uno riporta il catalogo a quello stato: tutto ciò che viene dopo viene scritto in un file che conservi e poi tolto, e ogni momento più recente se ne va con esso. Chi ha già sincronizzato conserva ciò che ha ricevuto.';

  @override
  String goBackFileFailed(String error) {
    return 'Non è stato tolto nulla: il file che lo conserva non è stato scritto ($error). Libera spazio e riprova.';
  }

  @override
  String get switchBeforeDeleting =>
      'Questo è il catalogo in cui sei. Passa a un altro, poi eliminalo.';
}
