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
  String get clowdersNeutral => 'Foyers';

  @override
  String get noClowdersYet =>
      'Pas encore de clowder. Un clowder est un lieu où vivent des chats — votre famille d\'accueil, l\'appartement d\'un adoptant. Créez le premier ci-dessous.';

  @override
  String get noClowdersYetNeutral =>
      'Pas encore de foyer. Un foyer est un lieu où vivent des animaux — votre logement, une famille d\'accueil, l\'appartement d\'un adoptant. Créez le premier ci-dessous.';

  @override
  String get strays => 'Chats errants';

  @override
  String get searchCats => 'Chercher des chats';

  @override
  String get searchCatsNeutral => 'Chercher des animaux';

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
  String get settings => 'Réglages';

  @override
  String get newClowder => 'Nouveau clowder';

  @override
  String get newClowderNeutral => 'Nouveau foyer';

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
  String get renameClowderNeutral => 'Renommer le foyer';

  @override
  String get rename => 'Renommer';

  @override
  String get timeline => 'Historique';

  @override
  String get mergeInto => 'Fusionner avec…';

  @override
  String get deleteClowder => 'Supprimer le clowder';

  @override
  String get deleteClowderNeutral => 'Supprimer le foyer';

  @override
  String get cats => 'Chats';

  @override
  String get catsNeutral => 'Animaux';

  @override
  String get addCat => 'Ajouter un chat';

  @override
  String get addCatNeutral => 'Ajouter un animal';

  @override
  String get newCat => 'Nouveau chat';

  @override
  String get newCatNeutral => 'Nouvel animal';

  @override
  String deleteQuestion(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get deleteClowderEmptyBody => 'Le clowder disparaît de la liste.';

  @override
  String get deleteClowderEmptyBodyNeutral => 'Le foyer disparaît de la liste.';

  @override
  String deleteClowderBody(int count) {
    return 'Ses $count chat(s) ne sont pas supprimés — ils deviennent errants. Déplace-les d\'abord dans un autre clowder si ce n\'est pas ce que tu veux.';
  }

  @override
  String deleteClowderBodyNeutral(int count) {
    return 'Ses $count animal(aux) ne sont pas supprimés — ils deviennent errants. Déplace-les d\'abord dans un autre foyer si ce n\'est pas ce que tu veux.';
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
  String get renameCatNeutral => 'Renommer l\'animal';

  @override
  String get seenHereNow => 'Vu ici maintenant';

  @override
  String get deleteCat => 'Supprimer le chat';

  @override
  String get deleteCatNeutral => 'Supprimer l\'animal';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get clowderLabelNeutral => 'Foyer';

  @override
  String get strayNoClowder => 'Errant — sans clowder';

  @override
  String get strayNoClowderNeutral => 'Errant — sans foyer';

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
      'Le chat disparaît de toutes les listes et ses photos sont supprimées — ici et, après la prochaine synchronisation, sur les autres appareils aussi.';

  @override
  String get deleteCatBodyNeutral =>
      'L\'animal disparaît de toutes les listes et ses photos sont supprimées — ici et, après la prochaine synchronisation, sur les autres appareils aussi.';

  @override
  String get sightingRecorded => 'Observation enregistrée à ta position.';

  @override
  String get noLocationAvailable =>
      'Pas de position disponible — appuie longuement sur la carte à la place.';

  @override
  String get locationDeniedForever =>
      'L\'accès à la position est bloqué. Autorisez-le dans les réglages du système pour utiliser Stray Cam.';

  @override
  String get locationServiceOff =>
      'La localisation est désactivée sur cet appareil. Activez-la dans les réglages puis réessayez.';

  @override
  String get locationDenied =>
      'cat(a)log n\'a pas l\'autorisation d\'utiliser votre position. Réessayez et autorisez-la quand on vous le demande.';

  @override
  String get locationNoFix =>
      'Votre position n\'a pas pu être déterminée pour le moment. Réessayez en extérieur — le GPS a besoin d\'une vue dégagée du ciel.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Numéro de puce';

  @override
  String get starterRemarks => 'Remarques';

  @override
  String get captureFlier => 'Photographier l\'affiche';

  @override
  String get addPhotosTo => 'Ajouter les photos à…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count photo(s) ajoutée(s) à $name';
  }

  @override
  String get scanPrintedCode => 'Scanner le code imprimé';

  @override
  String get chipScanHint =>
      'Scanne le QR/code-barres imprimé de la carte de puce ou des papiers vétérinaires — un téléphone ne peut pas lire la puce dans le chat.';

  @override
  String get chipScanHintNeutral =>
      'Scanne le QR/code-barres imprimé de la carte de puce ou des papiers vétérinaires — un téléphone ne peut pas lire la puce dans l\'animal.';

  @override
  String get savingLabel => 'Enregistrement…';

  @override
  String ownerOfCat(String name) {
    return 'Propriétaire de $name';
  }

  @override
  String get sortLabel => 'Trier';

  @override
  String get viewAsTable => 'Afficher en tableau';

  @override
  String get viewAsTiles => 'Afficher en vignettes';

  @override
  String get viewAsList => 'Afficher en liste';

  @override
  String get ageLabel => 'Âge';

  @override
  String get catList => 'Liste des chats';

  @override
  String get catListNeutral => 'Liste des animaux';

  @override
  String get matchCandidatesTitle => 'Correspondances possibles';

  @override
  String get findDuplicates => 'Trouver les doublons';

  @override
  String get noDuplicates => 'Aucun doublon possible pour le moment.';

  @override
  String get similarName => 'Nom similaire';

  @override
  String get sharePublicly => 'Partager publiquement…';

  @override
  String get pickFramesTitle => 'Choisir des images';

  @override
  String get suggestedFrames => 'Images suggérées';

  @override
  String get scrubFrames => 'Parcourir la vidéo';

  @override
  String get keepThisFrame => 'Garder cette image';

  @override
  String get fromVideo => 'Depuis une vidéo…';

  @override
  String addingPhotos(int done, int total) {
    return 'Ajout de la photo $done sur $total…';
  }

  @override
  String get videoMobileOnly =>
      'Extraire des images d\'une vidéo fonctionne dans l\'appli téléphone (Android et iPhone) — pas encore sur cet appareil.';

  @override
  String get shareWhitelistExplainer =>
      'Choisissez ce qui entre dans le fichier. Seuls les champs cochés sont inclus.';

  @override
  String get exportShareFile => 'Exporter le fichier de partage…';

  @override
  String get hostedLink => 'Lien hébergé (URL du fichier téléversé)';

  @override
  String get inlineQr => 'QR intégré (texte seul, sans photos)';

  @override
  String get inlineTooBig =>
      'Trop de données pour un code intégré — décochez des champs ou utilisez un lien hébergé.';

  @override
  String get scanShareLabel => 'Scanner un code de partage';

  @override
  String get notAShareCode => 'Ce code n\'est pas un partage cat(a)log.';

  @override
  String get importShareTitle => 'Importer ce chat ?';

  @override
  String get importShareTitleNeutral => 'Importer cet animal ?';

  @override
  String shareSource(String url) {
    return 'Source : $url';
  }

  @override
  String get importLabel => 'Importer';

  @override
  String get strayAreaLabel => 'Zone d\'errance possible';

  @override
  String get prevPin => 'Épingle précédente';

  @override
  String get nextPin => 'Épingle suivante';

  @override
  String get noMissingCats =>
      'Pas encore de chats disparus avec des positions d\'affiches.';

  @override
  String get noMissingCatsNeutral =>
      'Pas encore d\'animaux disparus avec des positions d\'affiches.';

  @override
  String get noMatchCandidates =>
      'Aucune correspondance possible pour le moment.';

  @override
  String sameIdField(String field) {
    return 'Même $field';
  }

  @override
  String metersApart(String distance) {
    return 'À $distance m l\'un de l\'autre';
  }

  @override
  String get addFlier => 'Ajouter une affiche';

  @override
  String get missingSinceLabel => 'Disparu depuis';

  @override
  String get phoneLabel => 'Téléphone';

  @override
  String get cropPortrait => 'Recadrer le portrait';

  @override
  String get statusOwner => 'Propriétaire';

  @override
  String get ocrUnavailable =>
      'La reconnaissance de texte n\'est pas disponible sur cet appareil — saisissez le texte de l\'affiche vous-même.';

  @override
  String get displayFormat => 'Affiché comme';

  @override
  String get displayPlain => 'Texte simple';

  @override
  String get displayQr => 'Code QR';

  @override
  String get displayBarcode => 'Code-barres';

  @override
  String get editLabel => 'Modifier';

  @override
  String get doneLabel => 'Terminé';

  @override
  String get openSettings => 'Ouvrir les réglages';

  @override
  String get notSaved => 'Non enregistré';

  @override
  String get birthdateInFuture =>
      'La date de naissance ne peut pas être dans le futur.';

  @override
  String get deceasedInFuture =>
      'La date de décès ne peut pas être dans le futur.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'La date de décès ne peut pas précéder la date de naissance ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'La date de naissance ne peut pas suivre la date de décès ($date).';
  }

  @override
  String get malePregnant =>
      'Ce chat est enregistré comme mâle — un mâle ne peut pas être gestant. Vérifiez d\'abord le sexe.';

  @override
  String get malePregnantNeutral =>
      'Cet animal est enregistré comme mâle — un mâle ne peut pas être gestant. Vérifiez d\'abord le sexe.';

  @override
  String fatherNotMale(String name) {
    return '$name est enregistrée comme femelle et ne peut pas être le père. Vérifiez d\'abord le sexe.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name est enregistré comme mâle et ne peut pas être la mère. Vérifiez d\'abord le sexe.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name est né le $date — un parent ne peut pas naître après son chaton.';
  }

  @override
  String parentBornAfterKittenNeutral(String name, String date) {
    return '$name est né le $date — un parent ne peut pas naître après son petit.';
  }

  @override
  String get genderFatherFemale =>
      'Ce chat est enregistré comme père d\'autres chats — le père ne peut pas être femelle. Vérifiez d\'abord la famille.';

  @override
  String get genderFatherFemaleNeutral =>
      'Cet animal est enregistré comme père d\'autres animaux — le père ne peut pas être femelle. Vérifiez d\'abord la famille.';

  @override
  String get genderMotherMale =>
      'Ce chat est enregistré comme mère d\'autres chats — la mère ne peut pas être mâle. Vérifiez d\'abord la famille.';

  @override
  String get genderMotherMaleNeutral =>
      'Cet animal est enregistré comme mère d\'autres animaux — la mère ne peut pas être mâle. Vérifiez d\'abord la famille.';

  @override
  String get moveTo => 'Déplacer vers';

  @override
  String get noClowderStrayOption => 'Sans clowder — errant / enfui';

  @override
  String get noClowderStrayOptionNeutral => 'Sans foyer — errant / enfui';

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
  String dateFormatError(String format) {
    return 'Format incorrect — utilisez $format';
  }

  @override
  String get dateInFuture => 'Cette date ne peut pas être dans le futur.';

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
  String get forCatsNeutral => 'animaux';

  @override
  String get forClowders => 'clowders';

  @override
  String get forClowdersNeutral => 'foyers';

  @override
  String get forBoth => 'les deux';

  @override
  String get optionsOnePerLine => 'Options (une par ligne)';

  @override
  String get ownValue => 'Valeur personnalisée';

  @override
  String get renameField => 'Renommer le champ';

  @override
  String get editOptions => 'Modifier les options…';

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
  String get searchByNameHintNeutral => 'Chercher un animal par nom…';

  @override
  String get host => 'Héberger';

  @override
  String get hostExplainer =>
      'Commence ici, puis scanne le code ou saisis-le sur l\'autre appareil.';

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
      'Les deux appareils utilisent le même dossier (par exemple dans Dropbox ou sur une clé USB). Chaque synchronisation y dépose vos changements et récupère ceux de l\'autre.';

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
  String trailOf(String name, int count) {
    return 'Trajet : $name ($count observations)';
  }

  @override
  String trailOfField(String name, String field, int count) {
    return 'Trajet : $name — $field ($count valeurs)';
  }

  @override
  String trailOfPlace(String name, int count) {
    return 'Trajet : $name ($count positions)';
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
  String get kindCatNeutral => 'animal';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindClowderNeutral => 'foyer';

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
  String get aboutTaglineNeutral =>
      'Un catalogue local pour les animaux dont tu t\'occupes. Tes données restent sur tes appareils — pas de serveur, pas de compte.';

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
  String get coffeeSubtitle =>
      'L\'appli reste gratuite. Même si je n\'ai pas de café :)';

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
  String get starterBreed => 'Race';

  @override
  String get valueMixed => 'croisé';

  @override
  String get breedEuropeanShorthair => 'Européen à poil court';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'British Shorthair';

  @override
  String get breedNorwegianForestCat => 'Chat des forêts norvégiennes';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamois';

  @override
  String get breedPersian => 'Persan';

  @override
  String get breedBengal => 'Bengal';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get starterEmail => 'E-mail';

  @override
  String get starterPhone => 'Téléphone';

  @override
  String get lookupUrlLabel => 'Lien de consultation';

  @override
  String lookupUrlHelp(String token) {
    return 'La page du service avec $token à la place du numéro, p. ex. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Consulter';

  @override
  String lookupFailed(String url) {
    return 'Aucune application n\'a pu ouvrir $url. Copiez le lien dans un navigateur.';
  }

  @override
  String get stepCat => 'Chat';

  @override
  String get stepCatNeutral => 'Animal';

  @override
  String get stepOwner => 'Propriétaire';

  @override
  String get stepFace => 'Photo du visage';

  @override
  String get stepRegistry => 'Registre';

  @override
  String get stepReview => 'Vérifier et enregistrer';

  @override
  String get stepOwnerHint =>
      'La personne qui a perdu le chat — ceci devient son clowder, avec le contact de l\'affiche.';

  @override
  String get stepOwnerHintNeutral =>
      'La personne qui a perdu l\'animal — ceci devient son foyer, avec le contact de l\'affiche.';

  @override
  String get stepFaceHint =>
      'Découpez la tête du chat sur l\'affiche ; elle devient la photo de profil. Vous pouvez passer.';

  @override
  String get stepFaceHintNeutral =>
      'Découpez la tête de l\'animal sur l\'affiche ; elle devient la photo de profil. Vous pouvez passer.';

  @override
  String get stepRegistryHint =>
      'Numéros trouvés sur l\'affiche. Ceux cochés sont enregistrés avec le chat et s\'ouvrent plus tard.';

  @override
  String get stepRegistryHintNeutral =>
      'Numéros trouvés sur l\'affiche. Ceux cochés sont enregistrés avec l\'animal et s\'ouvrent plus tard.';

  @override
  String get noRegistryLinks =>
      'Aucun lien de registre sur cette affiche — s\'il en manque, merci de signaler un bug.';

  @override
  String get unknownServiceHint => 'Service inconnu';

  @override
  String get rememberService => 'Mémoriser le service';

  @override
  String get rememberServiceHint =>
      'Nommez le service et désignez le numéro dans le lien. La prochaine affiche se remplira seule.';

  @override
  String get noIdInLink =>
      'Ce lien ne contient aucun numéro que l\'appli puisse enregistrer.';

  @override
  String get whichNumber => 'Quelle partie est le numéro ?';

  @override
  String get cropAgain => 'Recadrer';

  @override
  String get noFaceYet =>
      'Pas encore de photo de visage — la photo de l\'affiche est utilisée.';

  @override
  String get backLabel => 'Retour';

  @override
  String get dangerButton => 'NE PAS APPUYER.\nDANGER';

  @override
  String get dangerThanks => 'Merci d\'utiliser cat(a)log !';

  @override
  String get helpTitle => 'Aide';

  @override
  String get showTipsAgain => 'Revoir les astuces';

  @override
  String get helpHome =>
      'L\'aperçu de vos colonies — une colonie est un lieu où vivent des chats : votre logement, une famille d\'accueil, un refuge. Touchez une fiche pour voir ses chats ; appui long pour son menu. Le bouton en bas à droite crée une colonie, et la fiche des errants rassemble tous les chats sans foyer. Le nom en haut est le catalogue dans lequel tu es — touche-le pour changer ou en ajouter un.';

  @override
  String get helpHomeNeutral =>
      'L\'aperçu de vos foyers — un foyer est un lieu où vivent des animaux : votre logement, une famille d\'accueil, un refuge. Touchez une fiche pour voir ses animaux ; appui long pour son menu. Le bouton en bas à droite crée un foyer, et la fiche des errants rassemble tous les animaux sans foyer. Le nom en haut est le catalogue dans lequel tu es — touche-le pour changer ou en ajouter un.';

  @override
  String get helpClowder =>
      'Tout sur ce lieu : ses chats, ses champs (adresse, contact, type) et son historique. La page s\'ouvre en lecture seule ; le crayon active la modification, où vous pouvez aussi ajouter un champ. Un appui long sur un champ le modifie directement, sur un chat le déplace, le masque ou l\'ouvre. Un rendez-vous ajouté ici peut emmener plusieurs chats de la colonie, par exemple une tournée de stérilisation : cochez les chats qui viennent, terminez une fois, décochez ceux qui n\'ont pas été traités. L’horloge sur un champ ouvre son historique.';

  @override
  String get helpClowderNeutral =>
      'Tout sur ce lieu : ses animaux, ses champs (adresse, contact, type) et son historique. La page s\'ouvre en lecture seule ; le crayon active la modification, où vous pouvez aussi ajouter un champ. Un appui long sur un champ le modifie directement, sur un animal le déplace, le masque ou l\'ouvre. Un rendez-vous ajouté ici peut emmener plusieurs animaux du foyer, par exemple une tournée de stérilisation : cochez les animaux qui viennent, terminez une fois, décochez ceux qui n\'ont pas été traités. L’horloge sur un champ ouvre son historique.';

  @override
  String get helpCat =>
      'Tout sur ce chat : photos, champs, famille, historique. La page est en lecture seule jusqu\'à ce que tu touches le crayon. Un appui long sur un champ ouvre directement sa modification ; un appui long sur une photo ouvre son menu. Le menu en haut à droite contient le reste : masquer, fusionner, noter une observation, partager le chat. « Privé » se règle en modifiant un champ. L’horloge sur un champ ouvre son historique.';

  @override
  String get helpCatNeutral =>
      'Tout sur cet animal : photos, champs, famille, historique. La page est en lecture seule jusqu\'à ce que tu touches le crayon. Un appui long sur un champ ouvre directement sa modification ; un appui long sur une photo ouvre son menu. Le menu en haut à droite contient le reste : masquer, fusionner, noter une observation, partager l\'animal. « Privé » se règle en modifiant un champ. L’horloge sur un champ ouvre son historique.';

  @override
  String get helpStrays =>
      'Les chats sans foyer actuel : trouvés, échappés, ou venus d\'une affiche. Le bouton appareil photo enregistre un chat devant vous ; le bouton affiche transforme une affiche en chat avec le contact du propriétaire ; le scanner lit un code cat(a)log sur l\'affiche. Touchez Stray Cam pour une photo ; maintenez pour filmer une vidéo et garder les meilleures images comme photos.';

  @override
  String get helpStraysNeutral =>
      'Les animaux sans foyer actuel : trouvés, échappés, ou venus d\'une affiche. Le bouton appareil photo enregistre un animal devant vous ; le bouton affiche transforme une affiche en animal avec le contact du propriétaire ; le scanner lit un code cat(a)log sur l\'affiche. Touchez Stray Cam pour une photo ; maintenez pour filmer une vidéo et garder les meilleures images comme photos.';

  @override
  String get helpMap =>
      'Tous les chats et lieux ayant une position. La recherche trouve chats, personnes et lieux — un nom inconnu est cherché dans le monde entier. Le bouton calques trace les cercles de 500 m autour des affiches d\'un chat disparu et de son ancien foyer. Les flèches vont d\'un point à l\'autre, un appui long note une observation. Chaque champ de lieu apparaît comme épingle sur la carte ; touche une épingle pour son trajet.';

  @override
  String get helpMapNeutral =>
      'Tous les animaux et lieux ayant une position. La recherche trouve animaux, personnes et lieux — un nom inconnu est cherché dans le monde entier. Le bouton calques trace les cercles de 500 m autour des affiches d\'un animal disparu et de son ancien foyer. Les flèches vont d\'un point à l\'autre, un appui long note une observation. Chaque champ de lieu apparaît comme épingle sur la carte ; touche une épingle pour son trajet.';

  @override
  String get helpCard =>
      'La fiche imprimable de ce chat : choisissez son contenu avec les puces en haut, puis partagez-la en image ou en PDF. Les identifiants s\'impriment en QR ou code-barres, et une position devient un QR qui ouvre une carte, plus un court Plus Code.';

  @override
  String get helpCardNeutral =>
      'La fiche imprimable de cet animal : choisissez son contenu avec les puces en haut, puis partagez-la en image ou en PDF. Les identifiants s\'impriment en QR ou code-barres, et une position devient un QR qui ouvre une carte, plus un court Plus Code.';

  @override
  String get helpSync =>
      'Transmettre les données à d\'autres : se connecter en direct, utiliser un dossier visible par les deux appareils, ou envoyer un fichier par messagerie. C\'est toujours vous qui décidez de ce qui part — et un fichier .catsync reçu s\'ouvre ici aussi.';

  @override
  String get helpFields =>
      'Les champs utilisés par votre catalogue. Renommez-les, changez les options d\'une liste, ou créez les vôtres. Un champ identifiant peut pointer vers un service (un registre) : le numéro devient alors cliquable sur le chat.';

  @override
  String get helpFieldsNeutral =>
      'Les champs utilisés par votre catalogue. Renommez-les, changez les options d\'une liste, ou créez les vôtres. Un champ identifiant peut pointer vers un service (un registre) : le numéro devient alors cliquable sur l\'animal.';

  @override
  String get helpTimeline =>
      'Chaque modification jamais faite, la plus récente en haut : qui a changé quoi, quand et vers quelle valeur. Toute entrée peut être annulée — cela écrit une nouvelle entrée, rien n\'est jamais effacé.';

  @override
  String get helpDuplicates =>
      'Chats ou colonies qui semblent exister en double — identifiants identiques ou noms très proches avec des détails concordants. Touchez une paire pour la fusionner ; la fusion est définitive, elle demande confirmation.';

  @override
  String get helpDuplicatesNeutral =>
      'Animaux ou foyers qui semblent exister en double — identifiants identiques ou noms très proches avec des détails concordants. Touchez une paire pour la fusionner ; la fusion est définitive, elle demande confirmation.';

  @override
  String get helpMatches =>
      'Chats qui pourraient être le même animal : identifiant identique, ou errant vu dans la zone de recherche d\'un chat disparu. Touchez une paire pour fusionner, appui long pour ouvrir le premier chat et comparer.';

  @override
  String get helpMatchesNeutral =>
      'Animaux qui pourraient être le même : identifiant identique, ou errant vu dans la zone de recherche d\'un animal disparu. Touchez une paire pour fusionner, appui long pour ouvrir le premier animal et comparer.';

  @override
  String get helpFlier =>
      'Une affiche photographiée devient un chat et son propriétaire. Étape par étape : données du chat, contact du propriétaire, recadrage du visage pour la photo de profil, numéros de registre sur l\'affiche, puis vérification finale. Tout n\'est que suggestion — corrigez ce que l\'appareil a mal lu.';

  @override
  String get helpFlierNeutral =>
      'Une affiche photographiée devient un animal et son propriétaire. Étape par étape : données de l\'animal, contact du propriétaire, recadrage du visage pour la photo de profil, numéros de registre sur l\'affiche, puis vérification finale. Tout n\'est que suggestion — corrigez ce que l\'appareil a mal lu.';

  @override
  String get archiveTitle => 'Archives';

  @override
  String get archiveExplainer =>
      'Les chats décédés et les colonies vides que personne n\'a touchés depuis des années prennent quand même de la place — surtout leurs photos. L\'archivage les écrit dans un fichier que vous gardez, puis les supprime ici.';

  @override
  String get archiveExplainerNeutral =>
      'Les animaux décédés et les foyers vides que personne n\'a touchés depuis des années prennent quand même de la place — surtout leurs photos. L\'archivage les écrit dans un fichier que vous gardez, puis les supprime ici.';

  @override
  String get archiveAction => 'Archiver';

  @override
  String archiveSelected(int count) {
    return 'Archiver $count entrées';
  }

  @override
  String archiveConfirmTitle(int count) {
    return 'Archiver $count entrées ?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names seront écrits dans un fichier puis supprimés — sur votre appareil et sur tous ceux avec lesquels vous synchronisez. Importer le fichier ramène tout ; sans lui, c\'est perdu.';
  }

  @override
  String archiveDone(int count) {
    return '$count entrées archivées et supprimées';
  }

  @override
  String archiveFailed(String error) {
    return 'Rien n\'a été supprimé : le fichier d\'archive n\'a pas pu être écrit ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Base $db, photos $photos dans $count fichiers';
  }

  @override
  String quietForYears(int years) {
    return 'Sans activité depuis $years ans';
  }

  @override
  String get nothingToArchive => 'Rien d\'assez ancien à archiver.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Dernière modification $date · photos $size';
  }

  @override
  String get helpArchive =>
      'Les vieilles données coûtent de la place, surtout les photos que chaque appareil synchronisé transporte. Ici vous choisissez des chats décédés et des colonies vides restés inactifs des années, vous les écrivez dans un fichier que vous gardez, et vous les supprimez. La suppression atteint toutes les personnes avec qui vous synchronisez ; importer le fichier restaure tout.';

  @override
  String get helpArchiveNeutral =>
      'Les vieilles données coûtent de la place, surtout les photos que chaque appareil synchronisé transporte. Ici vous choisissez des animaux décédés et des foyers vides restés inactifs des années, vous les écrivez dans un fichier que vous gardez, et vous les supprimez. La suppression atteint toutes les personnes avec qui vous synchronisez ; importer le fichier restaure tout.';

  @override
  String restoreDeletedTitle(int count) {
    return 'Restaurer $count entrées supprimées ?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names sont supprimés dans ce catalogue, et le fichier importé les contient. Les restaurer les ramène ici et sur tous les appareils avec lesquels vous synchronisez.';
  }

  @override
  String get restoreAction => 'Restaurer';

  @override
  String get keepDeleted => 'Laisser supprimés';

  @override
  String get archiveNotSaved =>
      'Rien n\'a été supprimé : l\'archive n\'a été enregistrée nulle part.';

  @override
  String get locateAddress => 'Trouver l\'adresse sur la carte';

  @override
  String get addressFoundTitle => 'Adresse trouvée';

  @override
  String get replaceAddressOption => 'Remplacer l\'adresse par celle-ci';

  @override
  String get addPositionOption => 'Enregistrer l\'emplacement';

  @override
  String get addressLocated => 'Adresse trouvée';

  @override
  String get addressNotFound =>
      'Aucun lieu trouvé pour cette adresse. Vérifiez l\'orthographe ou laissez le champ vide.';

  @override
  String get starterPosition => 'Emplacement';

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
  String get markTitleNeutral => 'Marquer l\'animal';

  @override
  String get applyCrop => 'Rogner';

  @override
  String get useFullPhoto => 'Utiliser la photo entière';

  @override
  String get dragToSelect => 'Trace un rectangle autour du chat';

  @override
  String get dragToSelectNeutral => 'Trace un rectangle autour de l\'animal';

  @override
  String get dragOverTheCat => 'Trace une ellipse sur le chat';

  @override
  String get dragOverTheCatNeutral => 'Trace une ellipse sur l\'animal';

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
  String lastBackupFailed(String error) {
    return 'La dernière sauvegarde automatique a échoué : $error';
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
  String get typeUnitValue => 'Valeur avec unité';

  @override
  String get dimension => 'Grandeur';

  @override
  String get dimensionWeight => 'Poids';

  @override
  String get dimensionLength => 'Longueur';

  @override
  String get dimensionVolume => 'Volume';

  @override
  String get dimensionTemperature => 'Température';

  @override
  String get unitsLabel => 'Unités';

  @override
  String get catalogHolds => 'Ce catalogue contient';

  @override
  String get modeCats => 'Chats';

  @override
  String get modePets => 'Animaux';

  @override
  String get graphLabel => 'Graphique';

  @override
  String get fieldHistoryTooltip => 'Historique';

  @override
  String get rangeWeek => 'Semaine';

  @override
  String get rangeMonth => 'Mois';

  @override
  String get rangeYear => 'Année';

  @override
  String get rangeAll => 'Tout';

  @override
  String get rangeCustom => 'Personnalisé…';

  @override
  String changeSince(String delta, String date) {
    return '$delta depuis le $date';
  }

  @override
  String get unitsAuto => 'Comme dans votre région';

  @override
  String get unitsMetric => 'Métrique (kg, cm, ml, °C)';

  @override
  String get unitsImperial => 'Impérial (lb, in, fl oz, °F)';

  @override
  String get starterWeight => 'Poids';

  @override
  String get systemDefault => 'Langue du système';

  @override
  String get iosLocalNetworkHint =>
      'Si ça échoue encore sur iPhone/iPad : Réglages → Confidentialité et sécurité → Réseau local → autoriser cat(a)log, puis réessayer.';

  @override
  String get includePrivate => 'Partager les données privées';

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
  String get starterStatus => 'Type';

  @override
  String get statusFoster => 'Famille d\'accueil';

  @override
  String get statusForeverHome => 'Foyer';

  @override
  String get statusClinic => 'Clinique';

  @override
  String get statusShelter => 'Refuge';

  @override
  String get statusBarn => 'Grange';

  @override
  String get valueCat => 'Chat';

  @override
  String get valueDog => 'Chien';

  @override
  String get valueRabbit => 'Lapin';

  @override
  String get valueGuineaPig => 'Cochon d\'Inde';

  @override
  String get valueHamster => 'Hamster';

  @override
  String get valueBird => 'Oiseau';

  @override
  String get valueHorse => 'Cheval';

  @override
  String get valueTortoise => 'Tortue';

  @override
  String get valueFerret => 'Furet';

  @override
  String get otherOption => 'Autre…';

  @override
  String get celebrationsToggle => 'Fêter les adoptions';

  @override
  String get celebrationsSubtitle =>
      'Confettis et acclamations quand un chat rejoint son foyer';

  @override
  String get celebrationsSubtitleNeutral =>
      'Confettis et acclamations quand un animal rejoint son foyer définitif';

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
  String get mapSearchHintNeutral => 'Chercher animaux, foyers, personnes';

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
  String conflictsMenu(int n) {
    return 'Conflits ($n)';
  }

  @override
  String get rejectAfterResolve =>
      'Tu as réglé un conflit ici, donc Refuser n’est plus possible : cela l’annulerait aussi.';

  @override
  String get arrivalIntro =>
      'Ces changements sont déjà dans ton catalogue. Refuser le remet comme il était.';

  @override
  String get summaryUpdated => 'Modifiés';

  @override
  String get summaryDeleted => 'Supprimés';

  @override
  String get keepMine => 'Garder le mien';

  @override
  String keptMine(String name) {
    return 'Ta version de $name est conservée sur cet appareil.';
  }

  @override
  String get summaryMeta => 'Également arrivé';

  @override
  String changesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n changements',
      one: '1 changement',
    );
    return '$_temp0';
  }

  @override
  String get acceptArrival => 'Accepter';

  @override
  String get rejectArrival => 'Refuser';

  @override
  String get photoAdded => 'Photo ajoutée';

  @override
  String get photoRemoved => 'Photo retirée';

  @override
  String metaFieldAdded(String name) {
    return 'Nouveau champ : $name';
  }

  @override
  String metaFieldChanged(String name) {
    return 'Champ modifié : $name';
  }

  @override
  String metaMerged(String loser, String survivor) {
    return '$loser fusionné dans $survivor';
  }

  @override
  String metaPhotos(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n photos',
      one: '1 photo',
    );
    return '$_temp0';
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
  String get kittensLabelNeutral => 'Petits';

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
  String toastBornNeutral(Object cat) {
    return '✨ Nouveau-né : $cat ✨';
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
  String get syncChooserInPersonSub => 'Synchronisation par Wi-Fi';

  @override
  String get syncChooserRemote => 'À distance';

  @override
  String get syncChooserRemoteSub => 'Synchronisation par dossier ou clé USB';

  @override
  String get syncChooserMessenger => 'Messagerie';

  @override
  String get syncChooserMessengerSub =>
      'Export et import via les réseaux sociaux';

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
  String get selectClowderHintNeutral => 'Choisissez un foyer à gauche';

  @override
  String get introTitle1 => 'Vos chats, organisés';

  @override
  String get introTitle1Neutral => 'Vos animaux, organisés';

  @override
  String get introBody1 =>
      'Créez une fiche pour chaque chat : photo, sexe, santé, tout ce qui compte. Les chats sont regroupés par lieu de vie — l\'appli appelle ce lieu une chatterie (clowder).';

  @override
  String get introBody1Neutral =>
      'Créez une fiche pour chaque animal dont vous vous occupez : photo, sexe, santé, tout ce qui compte. Les animaux sont regroupés par lieu de vie — l\'appli appelle ce lieu un foyer.';

  @override
  String get introTitle2 => 'Fonctionne sans Internet';

  @override
  String get introBody2 =>
      'Tout est enregistré uniquement sur votre téléphone. Pas de compte, pas de cloud. Rien n\'est envoyé tant que vous ne le partagez pas vous-même.';

  @override
  String get introTitle3 => 'Travailler ensemble';

  @override
  String get introBody3 =>
      'Chacun utilise sa propre appli et vous échangez les données de temps en temps : scannez un code en vous voyant, utilisez un dossier partagé ou envoyez un fichier par messagerie. Ensuite tout le monde a les mêmes informations.';

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
      'Synchronisez ici avec vos connaissances. C\'est vous qui décidez ce que vous partagez.';

  @override
  String get spotHomeStrays =>
      'Cette carte rassemble tous les errants — les chats sans foyer. Touchez-la pour voir la liste.';

  @override
  String get spotHomeStraysNeutral =>
      'Cette carte rassemble tous les errants — les animaux sans foyer. Touchez-la pour voir la liste.';

  @override
  String get spotHomeMenu =>
      'Dans ce menu : réglages, trouver et fusionner les doublons, exporter en CSV, et plus.';

  @override
  String get spotCatEdit =>
      'Touchez le crayon pour modifier ce chat. Astuce : un appui long sur un champ le modifie directement.';

  @override
  String get spotCatEditNeutral =>
      'Touchez le crayon pour modifier cet animal. Astuce : un appui long sur un champ le modifie directement.';

  @override
  String get spotMapLayers =>
      'Vous cherchez un chat disparu ? Affichez des cercles autour des lieux de ses affiches et de son ancien foyer.';

  @override
  String get spotMapLayersNeutral =>
      'Vous cherchez un animal disparu ? Affichez des cercles autour des lieux de ses affiches et de son ancien foyer.';

  @override
  String get spotStraysFlier =>
      'Une affiche de chat disparu ? Photographiez-la ici — l\'appli enregistre le chat et le contact pour vous.';

  @override
  String get spotStraysFlierNeutral =>
      'Une affiche d\'animal disparu ? Photographiez-la ici — l\'appli enregistre l\'animal et le contact pour vous.';

  @override
  String get spotStraysScan =>
      'Certaines affiches portent un code QR cat(a)log. Scannez-le ici pour importer le chat sans rien taper.';

  @override
  String get spotStraysScanNeutral =>
      'Certaines affiches portent un code QR cat(a)log. Scannez-le ici pour importer l\'animal sans rien taper.';

  @override
  String get introTitle4 => 'Retrouver les chats disparus';

  @override
  String get introTitle4Neutral => 'Retrouver les animaux disparus';

  @override
  String get introBody4 =>
      'Vous voyez une affiche de chat disparu ? Photographiez-la dans l\'appli : elle enregistre le chat, le contact du propriétaire et le lieu. Si un chat errant semblable apparaît plus tard, l\'appli propose des correspondances.';

  @override
  String get introBody4Neutral =>
      'Vous voyez une affiche d\'animal disparu ? Photographiez-la dans l\'appli : elle enregistre l\'animal, le contact du propriétaire et le lieu. Si un animal errant semblable apparaît plus tard, l\'appli propose des correspondances.';

  @override
  String get spotMapSearch =>
      'Tapez un chat, un lieu ou une personne pour y sauter sur la carte.';

  @override
  String get spotMapSearchNeutral =>
      'Tapez un animal, un lieu ou une personne pour y sauter sur la carte.';

  @override
  String get spotCardChips =>
      'Cochez ce qui doit figurer sur la fiche à partager — tout le reste en reste absent.';

  @override
  String get spotCatMenu =>
      'D\'autres actions se trouvent ici : masquer le chat, fusionner les doublons ou noter une observation.';

  @override
  String get spotCatMenuNeutral =>
      'D\'autres actions se trouvent ici : masquer l\'animal, fusionner les doublons ou noter une observation.';

  @override
  String get spotDone => 'Compris';

  @override
  String get spotReplayTitle => 'Visite des nouveautés';

  @override
  String get spotReplaySubtitle => 'Réafficher les astuces sur chaque page';

  @override
  String get spotReplayDone => 'Les astuces s\'afficheront à nouveau';

  @override
  String get searchNoResults => 'Aucun chat trouvé avec ce nom';

  @override
  String get searchNoResultsNeutral => 'Aucun animal trouvé avec ce nom';

  @override
  String get syncUnreachable =>
      'Impossible de joindre l\'autre appareil. Sont-ils sur le même Wi-Fi ?';

  @override
  String get folderUnreachable =>
      'Impossible d\'accéder au dossier. Le disque ou le dossier cloud existe-t-il encore ?';

  @override
  String get crashTitle => 'Cela n\'aurait pas dû arriver';

  @override
  String get crashBody =>
      'cat(a)log a rencontré une erreur inattendue. Vos données sont en sécurité — tout est enregistré dès la modification. Redémarrez l\'app et, si cela se reproduit, envoyez le rapport pour que ce soit corrigé.';

  @override
  String get crashRestart => 'Redémarrer l\'app';

  @override
  String get crashSendReport => 'Envoyer le rapport au développeur';

  @override
  String get crashLastRunBody =>
      'cat(a)log s\'est arrêté de façon inattendue la dernière fois — probablement à court de mémoire. Envoyer un court rapport pour corriger ?';

  @override
  String get catalogsTitle => 'Catalogues';

  @override
  String get newCatalog => 'Nouveau catalogue';

  @override
  String get intoCatalog => 'Dans le catalogue';

  @override
  String get catalogNameLabel => 'Nom du catalogue';

  @override
  String catalogNameTaken(String name) {
    return 'Un catalogue nommé $name existe déjà. Choisis un autre nom.';
  }

  @override
  String get manageCatalogs => 'Gérer les catalogues';

  @override
  String get helpCatalogs =>
      'Un catalogue est un monde à part : ses chats, ses colonies, ses champs, ses photos et ses partenaires de synchronisation. Berlin et Paris ne se mélangent jamais. Touche un catalogue pour y passer. La roue dentée d’un catalogue ouvre ses réglages : nom, chats ou animaux, champs, auteurs et bannissements, archive, retour en arrière, suppression. Ton nom, ta langue et les astuces déjà vues sont communs à tous.';

  @override
  String get helpCatalogsNeutral =>
      'Un catalogue est un monde à part : ses animaux, ses foyers, ses champs, ses photos et ses partenaires de synchronisation. Berlin et Paris ne se mélangent jamais. Touche un catalogue pour y passer. La roue dentée d’un catalogue ouvre ses réglages : nom, chats ou animaux, champs, auteurs et bannissements, archive, retour en arrière, suppression. Ton nom, ta langue et les astuces déjà vues sont communs à tous.';

  @override
  String get helpCatalogSettings =>
      'Tout ce qui n’appartient qu’à ce catalogue : son nom, s’il contient des chats ou des animaux, ses champs, ses auteurs et bannissements, l’archive et le retour en arrière. Les changements ici ne touchent que ce catalogue — même un catalogue où tu n’es pas. La suppression écrit d’abord le catalogue dans un fichier.';

  @override
  String get spotHomeCatalog =>
      'Voici le catalogue dans lequel tu es. Touche le nom pour changer ou en créer un autre.';

  @override
  String get deleteCatalog => 'Supprimer le catalogue';

  @override
  String get catalogSettings => 'Réglages du catalogue';

  @override
  String deleteCatalogBody(String name) {
    return 'Tout ce qui est dans $name disparaît : ses chats, ses photos, son historique. Un fichier complet est d’abord enregistré là où vont les sauvegardes automatiques ; l’importer ramène le catalogue.';
  }

  @override
  String deleteCatalogBodyNeutral(String name) {
    return 'Tout ce qui est dans $name disparaît : ses animaux, ses photos, son historique. Un fichier complet est d’abord enregistré là où vont les sauvegardes automatiques ; l’importer ramène le catalogue. Tape le nom pour confirmer.';
  }

  @override
  String catalogDeleted(String name, String where) {
    return '$name supprimé. Le fichier est dans $where.';
  }

  @override
  String typeTheName(String name) {
    return 'Tape $name';
  }

  @override
  String catalogExportFailed(String error) {
    return 'Rien n’a été supprimé : le fichier du catalogue n’a pas pu être écrit ($error). Libère de la place ou réessaie plus tard.';
  }

  @override
  String get moveToCatalog => 'Déplacer vers un autre catalogue';

  @override
  String movedToCatalog(int count, String name) {
    return '$count déplacés vers $name';
  }

  @override
  String get chooseWhatToMove => 'Qu’est-ce qui déménage ?';

  @override
  String moveIntoNewCatalog(String name) {
    return 'Déplacer quelque chose vers $name ?';
  }

  @override
  String get undoThisImport => 'Annuler cet import';

  @override
  String undoImportBody(int count) {
    return 'Les $count changements apportés par cet import sont retirés. Ils sont d’abord écrits dans un fichier ; l’importer les ramène. Les personnes avec qui tu as déjà synchronisé gardent leur copie — cela ne se reprend pas.';
  }

  @override
  String undoneImport(String where) {
    return 'Annulé. Le fichier est dans $where.';
  }

  @override
  String get goBackTitle => 'Revenir en arrière';

  @override
  String get goBackToHere => 'Revenir ici';

  @override
  String get momentImport => 'Avant l’import';

  @override
  String get momentSync => 'Avant la synchronisation';

  @override
  String get momentMerge => 'Avant la fusion';

  @override
  String get momentHardDelete => 'Avant la suppression des données d’un auteur';

  @override
  String get momentArchive => 'Avant l’archivage';

  @override
  String get momentManual => 'Marqué par toi';

  @override
  String get showOlderMoments => 'Afficher les plus anciens';

  @override
  String goBackBody(int count) {
    return 'Tout ce qui suit ce moment est retiré — $count changements. Le tout est d’abord écrit dans un fichier ; l’importer le ramène, et chaque moment plus récent part avec. Les personnes avec qui tu as déjà synchronisé gardent leur copie — cela ne se reprend pas.';
  }

  @override
  String get nameThisMoment => 'Nomme ce moment';

  @override
  String get helpGoBack =>
      'Les moments où ce catalogue a changé de forme : avant chaque import et chaque synchronisation, avant une fusion, un archivage ou une suppression, et chaque fois que tu en as marqué un toi-même. En choisir un ramène le catalogue à cet état : tout ce qui suit est écrit dans un fichier que tu gardes puis retiré, et chaque moment plus récent part avec. Les personnes avec qui tu as déjà synchronisé gardent ce qu’elles ont reçu.';

  @override
  String goBackFileFailed(String error) {
    return 'Rien n’a été retiré : le fichier qui le conserve n’a pas pu être écrit ($error). Libère de la place et réessaie.';
  }

  @override
  String get goBackChanged =>
      'Rien n\'a été supprimé : le catalogue a changé pendant l\'enregistrement du fichier. Réessayez.';

  @override
  String get switchBeforeDeleting =>
      'C’est le catalogue dans lequel tu es. Passe à un autre, puis supprime-le.';

  @override
  String shareFileFailed(String error) {
    return 'Le fichier de partage n’a pas pu être écrit ($error). Libère de la place et réessaie.';
  }

  @override
  String get privateLabel => 'Privé';

  @override
  String sharedCatalogIs(String name) {
    return 'Catalogue : $name';
  }

  @override
  String get markPrivate => 'Marquer comme privé';

  @override
  String get unmarkPrivate => 'Retirer le marquage privé';

  @override
  String get agenda => 'Agenda';

  @override
  String get reminderLabel => 'Rappel';

  @override
  String get agendaEmpty =>
      'Aucun rendez-vous prévu. Prévois-en ici avec le plus, ou sur la page d\'un chat ou d\'un clowder.';

  @override
  String get agendaEmptyNeutral =>
      'Aucun rendez-vous prévu. Prévois-en ici avec le plus, ou sur la page d\'un animal ou d\'un foyer.';

  @override
  String get dueToday => 'aujourd\'hui';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dans $count jours',
      one: 'dans 1 jour',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'en retard de $count jours',
      one: 'en retard de 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get markDone => 'Fait';

  @override
  String get repeatTitle => 'À nouveau dans…';

  @override
  String get noRepeatLabel => 'Pas de répétition';

  @override
  String get unitDays => 'jours';

  @override
  String get unitWeeks => 'semaines';

  @override
  String get unitMonths => 'mois';

  @override
  String get unitYears => 'ans';

  @override
  String ageYears(int years) {
    return '$years ans';
  }

  @override
  String ageMonths(int months) {
    return '$months mois';
  }

  @override
  String get changeDateLabel => 'Changer la date';

  @override
  String get removeReminderLabel => 'Supprimer le rappel';

  @override
  String get exportIcs => 'Exporter le fichier calendrier';

  @override
  String get resyncCalendar => 'Resynchroniser le calendrier';

  @override
  String icsSavedTo(String path) {
    return 'Fichier calendrier enregistré sous $path';
  }

  @override
  String get calendarMirrorLabel =>
      'Refléter dans le calendrier de l\'appareil';

  @override
  String get calendarMirrorSubtitle =>
      'Les rendez-vous apparaissent comme des événements d\'une journée dans le calendrier. cat(a)log les y met à jour à chaque démarrage et après chaque modification. Tu peux gérer les alertes de ces rendez-vous dans le calendrier.';

  @override
  String get syncPeerOlder =>
      'L\'autre appareil utilise un cat(a)log plus ancien sans rappels. Mets-y cat(a)log à jour, puis resynchronise.';

  @override
  String get syncPeerNewer =>
      'L\'autre appareil utilise un cat(a)log plus récent. Mets cat(a)log à jour sur cet appareil, puis resynchronise.';

  @override
  String get syncPeerNoTls =>
      'L\'autre appareil utilise un cat(a)log antérieur à 1.1.0, sans synchronisation chiffrée. Mets cat(a)log à jour là-bas, puis resynchronise.';

  @override
  String get syncWrongHost =>
      'Le certificat ne correspond pas au code d\'appairage — ce n\'est pas l\'appareil d\'où vient le code. Scanne ou saisis le code à nouveau.';

  @override
  String get bundleNewerError =>
      'Ce fichier vient d\'un cat(a)log plus récent. Mets cat(a)log à jour sur cet appareil pour l\'importer.';

  @override
  String get spotEar =>
      'Une petite oreille de chat dans un coin signifie : rester appuyé pour plus.';

  @override
  String get addReminder => 'Ajouter un rappel';

  @override
  String get plannedSection => 'Prévu';

  @override
  String get reminderDialogHint =>
      'Le rendez-vous apparaît dans l\'agenda. Tu peux l\'y confirmer ou le rejeter. La valeur n\'est reprise que si le rendez-vous est confirmé.';

  @override
  String get reminderFor => 'Pour';

  @override
  String get reminderField => 'Champ';

  @override
  String get dueDateLabel => 'Échéance';

  @override
  String get pickCalendar => 'Quel calendrier ?';

  @override
  String get calendarPermissionDenied =>
      'L\'accès au calendrier est bloqué, le reflet est donc désactivé. Autorise-le dans les réglages du système, puis réactive le reflet.';

  @override
  String get calendarNotChosen =>
      'Aucun calendrier choisi, le reflet est donc désactivé. Réactive-le et choisis-en un.';

  @override
  String get calendarGone =>
      'Le calendrier choisi n\'existe plus, le reflet est donc désactivé. Réactive-le et choisis-en un autre.';

  @override
  String get noWritableCalendar =>
      'Aucun calendrier trouvé. Connecte-toi à un compte de calendrier dans les réglages du système, Google par exemple, puis réessaie.';

  @override
  String get spotHomeAgenda =>
      'Agenda : la liste des rendez-vous prévus — vétérinaire, médicaments, contrôles.';

  @override
  String get spotAgendaAdd => 'Prévoir un nouveau rendez-vous.';

  @override
  String get spotAgendaCalendar =>
      'Active ici le reflet des rendez-vous cat(a)log dans un calendrier de ton choix.';

  @override
  String get helpAgenda =>
      'L\'agenda liste les rendez-vous prévus par date. Il y a deux sortes : les rendez-vous avec une heure, et les rappels qui valent pour une journée. Les rendez-vous manqués restent en haut. Toucher ouvre le chat ou le clowder. La coche confirme un rendez-vous : la valeur est écrite dans le champ, et tu peux tout de suite prévoir le suivant, par exemple dans trois mois. Rester appuyé change la date ou supprime le rendez-vous. L\'interrupteur en haut reflète les rendez-vous dans un calendrier de ton téléphone. Le menu les exporte en fichier calendrier. Une visite chez le vétérinaire avec plusieurs chats est un seul rendez-vous : cochez les chats concernés, l\'Agenda affiche une carte avec leurs noms, et à la fin on demande quels chats ont été traités — décochez les autres, ils restent planifiés.';

  @override
  String get helpAgendaNeutral =>
      'L\'agenda liste les rendez-vous prévus par date. Il y a deux sortes : les rendez-vous avec une heure, et les rappels qui valent pour une journée. Les rendez-vous manqués restent en haut. Toucher ouvre l\'animal ou le foyer. La coche confirme un rendez-vous : la valeur est écrite dans le champ, et tu peux tout de suite prévoir le suivant, par exemple dans trois mois. Rester appuyé change la date ou supprime le rendez-vous. L\'interrupteur en haut reflète les rendez-vous dans un calendrier de ton téléphone. Le menu les exporte en fichier calendrier. Une visite chez le vétérinaire avec plusieurs animaux est un seul rendez-vous : cochez les animaux concernés, l\'Agenda affiche une carte avec leurs noms, et à la fin on demande quels animaux ont été traités — décochez les autres, ils restent planifiés.';

  @override
  String get calendarRowOff => 'Calendrier : désactivé';

  @override
  String calendarRowOn(String name) {
    return 'Calendrier : $name';
  }

  @override
  String get spotAddReminderCat =>
      'Prévoir un rendez-vous pour ce chat. Il apparaît dans l\'agenda et s\'y confirme.';

  @override
  String get spotAddReminderCatNeutral =>
      'Prévoir un rendez-vous pour cet animal. Il apparaît dans l\'agenda et s\'y confirme.';

  @override
  String get spotAddReminderClowder =>
      'Prévoir un rendez-vous pour ce clowder. Il apparaît dans l\'agenda et s\'y confirme.';

  @override
  String get spotAddReminderClowderNeutral =>
      'Prévoir un rendez-vous pour ce foyer. Il apparaît dans l\'agenda et s\'y confirme.';

  @override
  String get readOnlyCalendar => 'lecture seule';

  @override
  String get appointmentLabel => 'Rendez-vous';

  @override
  String get addAppointment => 'Ajouter un rendez-vous';

  @override
  String get planChooserTitle => 'Rendez-vous ou rappel ?';

  @override
  String get planChooserAppointment =>
      'Rendez-vous — une visite à une date et une heure, avec des notes';

  @override
  String get planChooserReminder =>
      'Rappel — une valeur qui arrive à échéance un jour';

  @override
  String get appointmentTitleLabel => 'Quoi';

  @override
  String get notesLabel => 'Notes';

  @override
  String get timeLabel => 'Heure';

  @override
  String get allDayLabel => 'Toute la journée';

  @override
  String get alertLabel => 'Alerte';

  @override
  String get alertNone => 'Aucune';

  @override
  String get alertDayBefore => 'La veille';

  @override
  String get alertHourBefore => 'Une heure avant';

  @override
  String get linkFieldLabel => 'Une fois fait, écrire dans un champ';

  @override
  String get noLinkedField => 'Aucun champ';

  @override
  String get outcomeTitle => 'Comment ça s\'est passé ?';

  @override
  String get finishLabel => 'Terminer';

  @override
  String get editLabelAppointment => 'Modifier le rendez-vous';

  @override
  String get deleteAppointment => 'Supprimer le rendez-vous';

  @override
  String get stepFlierText => 'Texte de l\'affiche';

  @override
  String get qrFoundHint =>
      'Un code QR a été trouvé sur l\'affiche. Les codes cochés sont lus pour trouver numéros de registre et liens.';

  @override
  String get useCode => 'Utiliser ce code';

  @override
  String get qrNone => 'Aucun code QR trouvé sur la photo.';

  @override
  String qrFailed(String error) {
    return 'Lecture du code QR échouée : $error';
  }

  @override
  String flierRecognized(String name) {
    return 'Affiche $name reconnue. Vérifiez ci-dessous dans quel champ va chaque ligne.';
  }

  @override
  String get flierLayoutUnknown =>
      'Mise en page inconnue. Attribuez les lignes aux champs ci-dessous ; le reste va dans les remarques.';

  @override
  String get targetRegistryNumber => 'Numéro de registre';

  @override
  String get targetLostPlace => 'Adresse (lieu de disparition)';

  @override
  String get targetContact => 'Contact du registre';

  @override
  String get targetDrop => 'Ignorer';

  @override
  String get existingCat => 'Chat existant';

  @override
  String get existingCatNeutral => 'Animal existant';

  @override
  String get existingClowder => 'Groupe existant';

  @override
  String get existingClowderNeutral => 'Foyer existant';

  @override
  String get createNewInstead => 'Aucun — créer';

  @override
  String overwritesValue(String value) {
    return 'Remplace la valeur actuelle \"$value\"';
  }

  @override
  String get abortScanTitle => 'Abandonner la capture ?';

  @override
  String get abortScanBody => 'Rien ne sera enregistré.';

  @override
  String get abortScan => 'Abandonner';

  @override
  String get keepScanning => 'Continuer';

  @override
  String get catsOnAppointment => 'Chats de ce rendez-vous';

  @override
  String get catsOnAppointmentNeutral => 'Animaux de ce rendez-vous';

  @override
  String get noCatsHint =>
      'Aucun chat coché — le rendez-vous appartient à la colonie.';

  @override
  String get noCatsHintNeutral =>
      'Aucun animal coché — le rendez-vous appartient au foyer.';

  @override
  String get pickCatsTitle => 'Quels chats viennent ?';

  @override
  String get pickCatsTitleNeutral => 'Quels animaux viennent ?';

  @override
  String catsCount(int count) {
    return '$count chats';
  }

  @override
  String catsCountNeutral(int count) {
    return '$count animaux';
  }

  @override
  String get finishUntickHint =>
      'Décochez les chats non traités ; ils restent planifiés.';

  @override
  String get finishUntickHintNeutral =>
      'Décochez les animaux non traités ; ils restent planifiés.';

  @override
  String deleteAppointmentGroup(int count) {
    return 'Supprimer le rendez-vous pour les $count chats';
  }

  @override
  String deleteAppointmentGroupNeutral(int count) {
    return 'Supprimer le rendez-vous pour les $count animaux';
  }
}
