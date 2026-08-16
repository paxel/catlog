// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Bienvenue dans cat(a)log';

  @override
  String get welcomeBody =>
      'Choisis un nom pour toi. Chaque modification est enregistrée sous ce nom, pour que les autres voient qui a fait quoi.';

  @override
  String get yourName => 'Ton nom';

  @override
  String get start => 'Commencer';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet =>
      'Pas encore de clowder.\nCrée le premier ci-dessous.';

  @override
  String get strays => 'Chats errants';

  @override
  String get searchCats => 'Chercher des chats';

  @override
  String get map => 'Carte';

  @override
  String get sync => 'Synchronisation';

  @override
  String get fields => 'Champs';

  @override
  String get exportCsv => 'Exporter en CSV';

  @override
  String get aboutAndFeedback => 'À propos & retours';

  @override
  String get newClowder => 'Nouveau clowder';

  @override
  String get name => 'Nom';

  @override
  String get cancel => 'Annuler';

  @override
  String get create => 'Créer';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get merge => 'Fusionner';

  @override
  String get resolve => 'Trancher';

  @override
  String get open => 'Ouvrir';

  @override
  String csvSavedTo(String path) {
    return 'CSV enregistré dans $path';
  }

  @override
  String get renameClowder => 'Renommer le clowder';

  @override
  String get rename => 'Renommer';

  @override
  String get timeline => 'Historique';

  @override
  String get mergeInto => 'Fusionner avec…';

  @override
  String get deleteClowder => 'Supprimer le clowder';

  @override
  String get cats => 'Chats';

  @override
  String get addCat => 'Ajouter un chat';

  @override
  String get newCat => 'Nouveau chat';

  @override
  String deleteQuestion(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get deleteClowderEmptyBody => 'Le clowder disparaît de la liste.';

  @override
  String deleteClowderBody(int count) {
    return 'Ses $count chat(s) ne sont pas supprimés — ils deviennent errants. Déplace-les d\'abord dans un autre clowder si ce n\'est pas ce que tu veux.';
  }

  @override
  String get card => 'Fiche';

  @override
  String get shareAsImage => 'Partager comme image';

  @override
  String get shareAsPdf => 'Partager en PDF';

  @override
  String get print => 'Imprimer';

  @override
  String cardTitle(String name) {
    return 'Fiche — $name';
  }

  @override
  String get renameCat => 'Renommer le chat';

  @override
  String get seenHereNow => 'Vu ici maintenant';

  @override
  String get deleteCat => 'Supprimer le chat';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Errant — sans clowder';

  @override
  String get stray => 'Errant';

  @override
  String get photos => 'Photos';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get setAsProfileImage => 'Définir comme photo de profil';

  @override
  String get thisIsProfileImage => 'C\'est la photo de profil';

  @override
  String get deletePhoto => 'Supprimer la photo';

  @override
  String get deletePhotoTitle => 'Supprimer la photo ?';

  @override
  String get deletePhotoBody =>
      'Les données de la photo sont supprimées définitivement — c\'est irréversible.';

  @override
  String get deleteCatBody =>
      'Le chat disparaît de toutes les listes. Ses photos sont supprimées définitivement.';

  @override
  String get sightingRecorded => 'Observation enregistrée à ta position.';

  @override
  String get noLocationAvailable =>
      'Pas de position disponible — appuie longuement sur la carte à la place.';

  @override
  String get moveTo => 'Déplacer vers';

  @override
  String get noClowderStrayOption => 'Sans clowder — errant / enfui';

  @override
  String timelineOf(String name) {
    return 'Historique — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Annuler cette modification';

  @override
  String get revertSubtitle =>
      'Rétablit la valeur précédente comme nouvelle entrée — l\'historique garde les deux.';

  @override
  String fieldCleared(String field) {
    return '$field vidé';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field revenu à « $value »';
  }

  @override
  String get leftStray => 'Parti — errant';

  @override
  String movedTo(String name) {
    return 'Déplacé vers $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat est arrivé';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat est arrivé de $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat est parti vers $place';
  }

  @override
  String get duplicateMergedIn => 'Doublon fusionné';

  @override
  String get asOfToday => 'En date d\'aujourd\'hui';

  @override
  String asOfDate(String date) {
    return 'En date du $date';
  }

  @override
  String get value => 'Valeur';

  @override
  String get latitudeLongitude => 'latitude, longitude';

  @override
  String get newField => 'Nouveau champ';

  @override
  String get fieldType => 'Type';

  @override
  String get usedOn => 'Utilisé pour';

  @override
  String get forCats => 'chats';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'les deux';

  @override
  String get optionsOnePerLine => 'Options (une par ligne)';

  @override
  String get renameField => 'Renommer le champ';

  @override
  String get noStraysRightNow => 'Pas d\'errants pour le moment.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Ajouter un errant';

  @override
  String get newStray => 'Nouvel errant';

  @override
  String get searchByNameHint => 'Chercher un chat par nom…';

  @override
  String get host => 'Héberger';

  @override
  String get hostExplainer =>
      'Commence ici, puis saisis l\'adresse et le PIN sur l\'autre appareil.';

  @override
  String get startHosting => 'Commencer à héberger';

  @override
  String get stopHosting => 'Arrêter d\'héberger';

  @override
  String pinLabel(String pin) {
    return 'PIN : $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count session(s) jusqu\'ici';
  }

  @override
  String get join => 'Rejoindre';

  @override
  String get addressFromHost => 'Adresse (de l\'appareil hôte)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Synchroniser maintenant';

  @override
  String get addressFormatHint =>
      'L\'adresse doit ressembler à 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Synchronisé : $result';
  }

  @override
  String syncFailed(String error) {
    return 'Échec de la synchronisation : $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Dernière synchro avec $peer : $time';
  }

  @override
  String get sharedFolder => 'Dossier partagé';

  @override
  String get sharedFolderExplainer =>
      'Synchronise via un dossier qu\'un cloud ou une clé USB transporte entre les appareils — pour ceux qui ne sont pas sur le même réseau.';

  @override
  String get noFolderChosenYet => 'Aucun dossier choisi';

  @override
  String get choose => 'Choisir…';

  @override
  String get syncFolderNow => 'Synchroniser le dossier';

  @override
  String folderSynced(String result) {
    return 'Dossier synchronisé : $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Échec de la synchro du dossier : $error';
  }

  @override
  String get recordSightingHere => 'Enregistrer une observation ici :';

  @override
  String get orPlaceClowderHere => 'Ou placer un clowder ici :';

  @override
  String trailOf(String name, int count) {
    return 'Trajet : $name ($count observations)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflit — $field';
  }

  @override
  String get conflictBody =>
      'Modifié à deux endroits en même temps. Choisis ce qui est vrai :';

  @override
  String mergeThisInto(String kind) {
    return 'Fusionner ce $kind avec…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Aucun autre $kind avec qui fusionner.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Fusionner avec $name ?';
  }

  @override
  String mergeBody(String name) {
    return 'Les deux fiches n\'en font plus qu\'une. $name garde ses valeurs actuelles ; l\'historique de l\'autre rejoint le sien. C\'est irréversible.';
  }

  @override
  String get kindCat => 'chat';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'champ';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get about => 'À propos';

  @override
  String get aboutTagline =>
      'Un catalogue local pour chats en famille d\'accueil. Tes données restent sur tes appareils — pas de serveur, pas de compte.';

  @override
  String versionLabel(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get sourceCode => 'Code source';

  @override
  String get reportProblemOrIdea => 'Signaler un problème ou une idée';

  @override
  String get githubIssues => 'Tickets GitHub';

  @override
  String get writeTheDeveloper => 'Écrire au développeur';

  @override
  String get buyCoffee => 'Offrir un café au développeur';

  @override
  String get coffeeSubtitle => 'Totalement facultatif — l\'appli est gratuite';

  @override
  String get openSourceLicenses => 'Licences open source';

  @override
  String get machineTranslated =>
      'Les traductions sont automatiques — les corrections sont bienvenues sur GitHub.';

  @override
  String get unnamed => '(sans nom)';

  @override
  String get labelName => 'Nom';

  @override
  String get labelProfileImage => 'Photo de profil';

  @override
  String get labelPhoto => 'Photo';

  @override
  String get starterGender => 'Sexe';

  @override
  String get starterColor => 'Couleur';

  @override
  String get starterNeutered => 'Stérilisé';

  @override
  String get starterPregnant => 'Gestante';

  @override
  String get starterBirthdate => 'Date de naissance';

  @override
  String get starterDeceased => 'Décédé';

  @override
  String get starterAddress => 'Adresse';

  @override
  String get starterResponsible => 'Personne responsable';

  @override
  String get starterPosition => 'Position';

  @override
  String get valueYes => 'oui';

  @override
  String get valueNo => 'non';

  @override
  String get valueFemale => 'femelle';

  @override
  String get valueMale => 'mâle';

  @override
  String get valueUnknown => 'inconnu';

  @override
  String get cropTitle => 'Recadrer la photo';

  @override
  String get markTitle => 'Marquer le chat';

  @override
  String get useFullPhoto => 'Utiliser la photo entière';

  @override
  String get dragToSelect => 'Trace un rectangle autour du chat';

  @override
  String get dragOverTheCat => 'Trace une ellipse sur le chat';

  @override
  String get cropPhoto => 'Recadrer…';

  @override
  String get markPhoto => 'Marquer…';

  @override
  String get scanCode => 'Scanner le code';

  @override
  String get orTypeCode => 'Ou taper le code';

  @override
  String get copyCode => 'Copier le code';

  @override
  String get copied => 'Copié';

  @override
  String get invalidCode => 'Ce code n\'est pas valide';

  @override
  String get hotspotHint =>
      'Pas de Wi-Fi commun ? Active le partage de connexion d\'un téléphone, connecte l\'autre, puis héberge ici.';

  @override
  String get byMessenger => 'Par messagerie';

  @override
  String get byMessengerExplainer =>
      'Envoie tout ton catalogue en un seul fichier via WhatsApp, Signal ou mail — l\'autre côté l\'importe.';

  @override
  String get shareBundle => 'Partager le paquet de synchro…';

  @override
  String get importBundle => 'Importer un paquet de synchro…';

  @override
  String bundleImported(String result) {
    return 'Paquet importé : $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Échec de l\'import : $error';
  }

  @override
  String get pickOnMap => 'Choisir sur la carte';

  @override
  String get useMyLocation => 'Utiliser ma position';

  @override
  String get language => 'Langue';

  @override
  String get systemDefault => 'Langue du système';

  @override
  String get iosLocalNetworkHint =>
      'Si ça échoue encore sur iPhone/iPad : Réglages → Confidentialité et sécurité → Réseau local → autoriser cat(a)log, puis réessayer.';

  @override
  String get markPrivate => 'Marquer comme privé';

  @override
  String get unmarkPrivate => 'Retirer le marquage privé';

  @override
  String get includePrivate => 'Inclure les données privées';

  @override
  String get includePrivateExplainer =>
      'Les chats, clowders et champs privés sont aussi partagés — n\'activez ceci que pour synchroniser vos propres appareils.';

  @override
  String get hideLabel => 'Masquer sur cet appareil';

  @override
  String get unhideLabel => 'Afficher à nouveau';

  @override
  String get showHiddenLabel => 'Afficher les éléments masqués';

  @override
  String get stopShowingHidden => 'Ne plus afficher les éléments masqués';

  @override
  String get starterSpecies => 'Espèce';

  @override
  String get starterStatus => 'Statut';

  @override
  String get statusFoster => 'Famille d\'accueil';

  @override
  String get statusForeverHome => 'Foyer définitif';

  @override
  String get statusClinic => 'Clinique';

  @override
  String get statusShelter => 'Refuge';

  @override
  String get statusBarn => 'Grange';

  @override
  String get valueCat => 'Chat';

  @override
  String get otherOption => 'Autre…';

  @override
  String get celebrationsToggle => 'Fêter les adoptions';

  @override
  String get celebrationsSubtitle =>
      'Confettis et acclamations quand un chat rejoint son foyer définitif';

  @override
  String get onMapLabel => 'Sur la carte';

  @override
  String get showOnMap => 'Afficher sur la carte';

  @override
  String get searchPlaceHint => 'Rechercher un lieu ou une adresse';

  @override
  String get noPlacesFound => 'Aucun lieu trouvé';

  @override
  String get mapSearchHint => 'Chercher chats, clowders, personnes';

  @override
  String get proposeAnotherName => 'Proposer un autre nom';

  @override
  String get moderationTitle => 'Auteurs et blocages';

  @override
  String get moderationSubtitle =>
      'Supprimer définitivement les données d\'une personne';

  @override
  String get authorsSection => 'Qui a écrit dans ce catalogue';

  @override
  String get hardDeleteAction => 'Tout supprimer de cet auteur';

  @override
  String hardDeleteWarning(Object name) {
    return 'Supprime chaque entrée et photo de $name de cet appareil. Les autres appareils gardent les leurs. Irréversible.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Tapez $name pour confirmer';
  }

  @override
  String get alsoBan => 'Bloquer aussi — ne plus jamais accepter ses données';

  @override
  String get bansSection => 'Blocages';

  @override
  String get unbanAction => 'Retirer le blocage';

  @override
  String get deletedDone => 'Supprimé.';

  @override
  String get syncSummaryTitle => 'Ce qui est arrivé';

  @override
  String get summaryAdopted => 'Adoptés';

  @override
  String get summaryDeceased => 'Décédés';

  @override
  String get summaryEscaped => 'Échappés';

  @override
  String get summaryNew => 'Nouveaux';

  @override
  String get summaryConflicts => 'Conflits à résoudre';

  @override
  String summaryOther(Object n) {
    return '…et $n autres changements';
  }

  @override
  String get starterMother => 'Mère';

  @override
  String get starterFather => 'Père';

  @override
  String get familySection => 'Famille';

  @override
  String get littermatesLabel => 'Même portée';

  @override
  String get siblingsLabel => 'Frères et sœurs';

  @override
  String get kittensLabel => 'Chatons';

  @override
  String get toastSettingsTitle => 'Quoi annoncer';

  @override
  String get toastSettingsSubtitle =>
      'Petits messages après une synchronisation';

  @override
  String get toastKindAdoptions => 'Adoptions';

  @override
  String get toastKindBirths => 'Naissances';

  @override
  String get toastKindDeaths => 'Décès';

  @override
  String get toastKindEscapes => 'Fugues';

  @override
  String get toastKindMoves => 'Déménagements';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adopté par $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nouveau chaton : $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat est décédé';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat s\'est échappé';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat a déménagé chez $home';
  }

  @override
  String get notACatlogFile => 'Ce n\'est pas un fichier cat(a)log';

  @override
  String get nothingNewInBundle =>
      'Rien de nouveau dans ce fichier — vous avez déjà tout';

  @override
  String get syncChooserInPerson => 'En personne';

  @override
  String get syncChooserInPersonSub =>
      'Vous êtes dans la même pièce — scannez un code, prêt en quelques secondes';

  @override
  String get syncChooserRemote => 'À distance';

  @override
  String get syncChooserRemoteSub =>
      'Via un dossier partagé comme Dropbox ou une clé USB';

  @override
  String get syncChooserMessenger => 'Messagerie';

  @override
  String get syncChooserMessengerSub =>
      'Envoyez tout en un seul fichier par n\'importe quelle messagerie';

  @override
  String get connectToWifiFirst =>
      'Connectez-vous d\'abord à un Wi-Fi — les appareils pourront se trouver';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) veut synchroniser';
  }

  @override
  String get trustBothWaysNote =>
      'Vos catalogues seront échangés dans les deux sens.';

  @override
  String get allowOnce => 'Autoriser';

  @override
  String get allowAlways => 'Toujours autoriser cet appareil';

  @override
  String get declineAction => 'Refuser';

  @override
  String get syncDeclined => 'L\'autre appareil a refusé la synchronisation';

  @override
  String get trustedDevicesSection => 'Appareils toujours autorisés';

  @override
  String get removeTrust => 'Retirer';

  @override
  String get hostWithoutWifi => 'Héberger sans Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Établit une connexion directe temporaire avec l\'autre téléphone (sans internet). Seul cat(a)log l\'utilise et elle se coupe d\'elle-même après la synchronisation.';

  @override
  String get hotspotAndroidOnly =>
      'Ce code nécessite deux téléphones Android — sur iPhone/iPad, utilisez un Wi-Fi commun';

  @override
  String get selectClowderHint => 'Choisissez un clowder à gauche';

  @override
  String get introTitle1 => 'Les chats vivent en clowders';

  @override
  String get introBody1 =>
      'Un clowder est un lieu où vivent des chats : votre famille d\'accueil, l\'appartement d\'un adoptant, la grange d\'à côté. Chaque chat a sa fiche avec photo, infos et toute son histoire.';

  @override
  String get introTitle2 => 'Tout reste chez vous';

  @override
  String get introBody2 =>
      'Pas de compte, pas de cloud, pas de pistage. Vos données vivent sur votre appareil.';

  @override
  String get introTitle3 => 'Partagez avec vos aides';

  @override
  String get introBody3 =>
      'Scannez un code et deux appareils se synchronisent en quelques secondes, utilisez un dossier partagé ou envoyez tout en un seul fichier.';

  @override
  String get introSkip => 'Passer';

  @override
  String get introNext => 'Suivant';

  @override
  String get introDone => 'C\'est parti';

  @override
  String get introReplayTitle => 'Intro rapide';

  @override
  String get spotHomeSync =>
      'Nouveau : la synchronisation propose trois voies claires — et une question de confiance avant tout échange.';

  @override
  String get spotMapSearch =>
      'Nouveau : cherchez ici chats, clowders et personnes — directement sur la carte.';

  @override
  String get spotCardChips =>
      'Nouveau : choisissez ce qui figure sur la fiche avant de la partager.';

  @override
  String get spotCatMenu =>
      'Nouveau : marquez un chat comme privé (il ne quitte jamais votre appareil) ou masquez-le ici.';

  @override
  String get spotDone => 'Compris';

  @override
  String get spotReplayTitle => 'Visite des nouveautés';

  @override
  String get spotReplaySubtitle => 'Réafficher les astuces sur chaque page';

  @override
  String get spotReplayDone => 'Les astuces s\'afficheront à nouveau';
}
