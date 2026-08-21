// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Bienvenido a cat(a)log';

  @override
  String get welcomeBody =>
      'Elige un nombre para ti. Cada cambio se registra con este nombre, para que otros vean quién hizo qué.';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get start => 'Empezar';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet =>
      'Aún no hay clowders. Un clowder es un lugar donde viven gatos — tu casa de acogida, el piso de un adoptante. Crea el primero abajo.';

  @override
  String get strays => 'Callejeros';

  @override
  String get searchCats => 'Buscar gatos';

  @override
  String get map => 'Mapa';

  @override
  String get sync => 'Sincronizar';

  @override
  String get fields => 'Campos';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get aboutAndFeedback => 'Acerca de y comentarios';

  @override
  String get newClowder => 'Nuevo clowder';

  @override
  String get name => 'Nombre';

  @override
  String get cancel => 'Cancelar';

  @override
  String get create => 'Crear';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get merge => 'Fusionar';

  @override
  String get resolve => 'Resolver';

  @override
  String get open => 'Abrir';

  @override
  String csvSavedTo(String path) {
    return 'CSV guardado en $path';
  }

  @override
  String get renameClowder => 'Renombrar clowder';

  @override
  String get rename => 'Renombrar';

  @override
  String get timeline => 'Historial';

  @override
  String get mergeInto => 'Fusionar con…';

  @override
  String get deleteClowder => 'Eliminar clowder';

  @override
  String get cats => 'Gatos';

  @override
  String get addCat => 'Añadir gato';

  @override
  String get newCat => 'Nuevo gato';

  @override
  String deleteQuestion(String name) {
    return '¿Eliminar $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'El clowder desaparece de la lista.';

  @override
  String deleteClowderBody(int count) {
    return 'Sus $count gato(s) no se eliminan — pasan a ser callejeros. Muévelos antes a otro clowder si no es lo que quieres.';
  }

  @override
  String get card => 'Ficha';

  @override
  String get shareAsImage => 'Compartir como imagen';

  @override
  String get shareAsPdf => 'Compartir como PDF';

  @override
  String get print => 'Imprimir';

  @override
  String cardTitle(String name) {
    return 'Ficha — $name';
  }

  @override
  String get renameCat => 'Renombrar gato';

  @override
  String get seenHereNow => 'Visto aquí ahora';

  @override
  String get deleteCat => 'Eliminar gato';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Callejero — sin clowder';

  @override
  String get stray => 'Callejero';

  @override
  String get photos => 'Fotos';

  @override
  String get addPhoto => 'Añadir foto';

  @override
  String get setAsProfileImage => 'Usar como foto de perfil';

  @override
  String get thisIsProfileImage => 'Esta es la foto de perfil';

  @override
  String get deletePhoto => 'Eliminar foto';

  @override
  String get deletePhotoTitle => '¿Eliminar foto?';

  @override
  String get deletePhotoBody =>
      'Los datos de la foto se eliminan para siempre — no se puede deshacer.';

  @override
  String get deleteCatBody =>
      'El gato desaparece de todas las listas y sus fotos se eliminan — aquí y, tras la próxima sincronización, también en los demás dispositivos.';

  @override
  String get sightingRecorded => 'Avistamiento registrado en tu posición.';

  @override
  String get noLocationAvailable =>
      'Sin ubicación disponible — mantén pulsado el mapa en su lugar.';

  @override
  String get locationDeniedForever =>
      'El acceso a la ubicación está bloqueado. Permítelo en los ajustes del sistema para usar Stray Cam.';

  @override
  String get locationServiceOff =>
      'La ubicación está desactivada en este dispositivo. Actívala en los ajustes e inténtalo de nuevo.';

  @override
  String get locationDenied =>
      'cat(a)log no tiene permiso para usar tu ubicación. Inténtalo de nuevo y permítelo cuando se te pregunte.';

  @override
  String get locationNoFix =>
      'No se pudo determinar tu posición ahora mismo. Inténtalo de nuevo al aire libre — el GPS necesita vista despejada del cielo.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Número de chip';

  @override
  String get starterRemarks => 'Observaciones';

  @override
  String get captureFlier => 'Fotografiar cartel';

  @override
  String get addPhotosTo => 'Añadir fotos a…';

  @override
  String photosAddedTo(String count, String name) {
    return '$count foto(s) añadidas a $name';
  }

  @override
  String get scanPrintedCode => 'Escanear código impreso';

  @override
  String get chipScanHint =>
      'Escanea el QR/código de barras impreso de la tarjeta del chip o los papeles del veterinario — el teléfono no puede leer el chip dentro del gato.';

  @override
  String get savingLabel => 'Guardando…';

  @override
  String ownerOfCat(String name) {
    return 'Dueño de $name';
  }

  @override
  String get sortLabel => 'Ordenar';

  @override
  String get viewAsTable => 'Ver como tabla';

  @override
  String get viewAsTiles => 'Ver como mosaicos';

  @override
  String get matchCandidatesTitle => 'Posibles coincidencias';

  @override
  String get findDuplicates => 'Buscar duplicados';

  @override
  String get noDuplicates => 'No hay posibles duplicados ahora mismo.';

  @override
  String get similarName => 'Nombre parecido';

  @override
  String get sharePublicly => 'Compartir públicamente…';

  @override
  String get privateNoShare =>
      'Este gato está marcado como privado — los datos privados nunca salen de tu dispositivo. Quita primero la marca para compartirlo públicamente.';

  @override
  String get pickFramesTitle => 'Elegir fotogramas';

  @override
  String get suggestedFrames => 'Fotogramas sugeridos';

  @override
  String get scrubFrames => 'Recorrer el vídeo';

  @override
  String get keepThisFrame => 'Conservar este fotograma';

  @override
  String get fromVideo => 'Desde vídeo…';

  @override
  String get videoMobileOnly =>
      'Elegir fotogramas de un vídeo funciona en la app del teléfono (Android y iPhone) — aún no en este dispositivo.';

  @override
  String get shareWhitelistExplainer =>
      'Elige qué va en el archivo. Solo se incluyen los campos marcados.';

  @override
  String get exportShareFile => 'Exportar archivo compartido…';

  @override
  String get hostedLink => 'Enlace alojado (URL del archivo subido)';

  @override
  String get inlineQr => 'QR integrado (solo texto, sin fotos)';

  @override
  String get inlineTooBig =>
      'Demasiados datos para un código integrado — desmarca campos o usa un enlace alojado.';

  @override
  String get scanShareLabel => 'Escanear código compartido';

  @override
  String get notAShareCode => 'Ese código no es un share de cat(a)log.';

  @override
  String get importShareTitle => '¿Importar este gato?';

  @override
  String shareSource(String url) {
    return 'Fuente: $url';
  }

  @override
  String get importLabel => 'Importar';

  @override
  String get strayAreaLabel => 'Posible zona de deambulación';

  @override
  String get prevPin => 'Marcador anterior';

  @override
  String get nextPin => 'Marcador siguiente';

  @override
  String get noMissingCats =>
      'Aún no hay gatos desaparecidos con posiciones de carteles.';

  @override
  String get noMatchCandidates => 'No hay posibles coincidencias ahora mismo.';

  @override
  String sameIdField(String field) {
    return 'Mismo $field';
  }

  @override
  String metersApart(String distance) {
    return 'A $distance m de distancia';
  }

  @override
  String get addFlier => 'Añadir cartel';

  @override
  String get missingSinceLabel => 'Desaparecido desde';

  @override
  String get phoneLabel => 'Teléfono';

  @override
  String get cropPortrait => 'Recortar retrato';

  @override
  String get statusOwner => 'Dueño';

  @override
  String get ocrUnavailable =>
      'El reconocimiento de texto no está disponible en este dispositivo — escribe tú el texto del cartel.';

  @override
  String get displayFormat => 'Se muestra como';

  @override
  String get displayPlain => 'Texto plano';

  @override
  String get displayQr => 'Código QR';

  @override
  String get displayBarcode => 'Código de barras';

  @override
  String get editLabel => 'Editar';

  @override
  String get doneLabel => 'Hecho';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get notSaved => 'No guardado';

  @override
  String get birthdateInFuture =>
      'La fecha de nacimiento no puede estar en el futuro.';

  @override
  String get deceasedInFuture =>
      'La fecha de fallecimiento no puede estar en el futuro.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'La fecha de fallecimiento no puede ser anterior a la fecha de nacimiento ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'La fecha de nacimiento no puede ser posterior a la fecha de fallecimiento ($date).';
  }

  @override
  String get malePregnant =>
      'Este gato está registrado como macho — un macho no puede estar preñado. Comprueba primero el sexo.';

  @override
  String fatherNotMale(String name) {
    return '$name está registrada como hembra y no puede ser el padre. Comprueba primero el sexo.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name está registrado como macho y no puede ser la madre. Comprueba primero el sexo.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name nació el $date — un progenitor no puede nacer después de su cría.';
  }

  @override
  String get genderFatherFemale =>
      'Este gato está registrado como padre de otros gatos — el padre no puede ser hembra. Comprueba primero la familia.';

  @override
  String get genderMotherMale =>
      'Este gato está registrado como madre de otros gatos — la madre no puede ser macho. Comprueba primero la familia.';

  @override
  String get moveTo => 'Mover a';

  @override
  String get noClowderStrayOption => 'Sin clowder — callejero / se escapó';

  @override
  String timelineOf(String name) {
    return 'Historial — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Revertir este cambio';

  @override
  String get revertSubtitle =>
      'Restaura el valor anterior como nueva entrada — el historial conserva ambos.';

  @override
  String fieldCleared(String field) {
    return '$field vaciado';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field vuelve a «$value»';
  }

  @override
  String get leftStray => 'Se fue — callejero';

  @override
  String movedTo(String name) {
    return 'Movido a $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat llegó';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat llegó de $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat se fue a $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicado fusionado';

  @override
  String get asOfToday => 'Con fecha de hoy';

  @override
  String asOfDate(String date) {
    return 'Con fecha $date';
  }

  @override
  String dateFormatError(String format) {
    return 'Formato incorrecto — usa $format';
  }

  @override
  String get value => 'Valor';

  @override
  String get latitudeLongitude => 'latitud, longitud';

  @override
  String get newField => 'Nuevo campo';

  @override
  String get fieldType => 'Tipo';

  @override
  String get usedOn => 'Usado en';

  @override
  String get forCats => 'gatos';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'ambos';

  @override
  String get optionsOnePerLine => 'Opciones (una por línea)';

  @override
  String get ownValue => 'Valor propio';

  @override
  String get renameField => 'Renombrar campo';

  @override
  String get editOptions => 'Editar opciones…';

  @override
  String get noStraysRightNow => 'No hay callejeros ahora mismo.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Añadir callejero';

  @override
  String get newStray => 'Nuevo callejero';

  @override
  String get searchByNameHint => 'Buscar gatos por nombre…';

  @override
  String get host => 'Anfitrión';

  @override
  String get hostExplainer =>
      'Empieza aquí y luego introduce la dirección y el PIN en el otro dispositivo.';

  @override
  String get startHosting => 'Empezar a hospedar';

  @override
  String get stopHosting => 'Dejar de hospedar';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count sesión(es) hasta ahora';
  }

  @override
  String get join => 'Unirse';

  @override
  String get addressFromHost => 'Dirección (del dispositivo anfitrión)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sincronizar ahora';

  @override
  String get addressFormatHint =>
      'La dirección debe ser como 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sincronizado: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Fallo de sincronización: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Última sincronización con $peer: $time';
  }

  @override
  String get sharedFolder => 'Carpeta compartida';

  @override
  String get sharedFolderExplainer =>
      'Ambos dispositivos usan la misma carpeta (por ejemplo en Dropbox o en un USB). Cada sincronización deja allí tus cambios y recoge los del otro lado.';

  @override
  String get noFolderChosenYet => 'Ninguna carpeta elegida aún';

  @override
  String get choose => 'Elegir…';

  @override
  String get syncFolderNow => 'Sincronizar carpeta ahora';

  @override
  String folderSynced(String result) {
    return 'Carpeta sincronizada: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Fallo al sincronizar carpeta: $error';
  }

  @override
  String get recordSightingHere => 'Registrar un avistamiento aquí:';

  @override
  String trailOf(String name, int count) {
    return 'Ruta: $name ($count avistamientos)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflicto — $field';
  }

  @override
  String get conflictBody =>
      'Cambiado en dos sitios a la vez. Elige qué es lo cierto:';

  @override
  String mergeThisInto(String kind) {
    return 'Fusionar este $kind con…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'No hay otro $kind con el que fusionar.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return '¿Fusionar con $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Los dos registros se vuelven uno. $name conserva sus valores actuales; el historial del otro se une al suyo. No se puede deshacer.';
  }

  @override
  String get kindCat => 'gato';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'campo';

  @override
  String get takePhoto => 'Hacer foto';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get about => 'Acerca de';

  @override
  String get aboutTagline =>
      'Un catálogo local para gatos de acogida. Tus datos se quedan en tus dispositivos — sin servidor, sin cuenta.';

  @override
  String versionLabel(String version, String build) {
    return 'Versión $version ($build)';
  }

  @override
  String get sourceCode => 'Código fuente';

  @override
  String get reportProblemOrIdea => 'Informar de un problema o idea';

  @override
  String get githubIssues => 'Issues de GitHub';

  @override
  String get writeTheDeveloper => 'Escribir al desarrollador';

  @override
  String get buyCoffee => 'Invitar a un café al desarrollador';

  @override
  String get coffeeSubtitle => 'Totalmente opcional — la app es gratis';

  @override
  String get openSourceLicenses => 'Licencias de código abierto';

  @override
  String get machineTranslated =>
      'Las traducciones son automáticas — las correcciones son bienvenidas en GitHub.';

  @override
  String get unnamed => '(sin nombre)';

  @override
  String get labelName => 'Nombre';

  @override
  String get labelProfileImage => 'Foto de perfil';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Sexo';

  @override
  String get starterBreed => 'Raza';

  @override
  String get valueMixed => 'mestizo';

  @override
  String get breedEuropeanShorthair => 'Europeo de pelo corto';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Británico de pelo corto';

  @override
  String get breedNorwegianForestCat => 'Bosque de Noruega';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamés';

  @override
  String get breedPersian => 'Persa';

  @override
  String get breedBengal => 'Bengalí';

  @override
  String get breedSphynx => 'Esfinge';

  @override
  String get starterColor => 'Color';

  @override
  String get starterNeutered => 'Esterilizado';

  @override
  String get starterPregnant => 'Preñada';

  @override
  String get starterBirthdate => 'Fecha de nacimiento';

  @override
  String get starterDeceased => 'Fallecido';

  @override
  String get starterAddress => 'Dirección';

  @override
  String get starterResponsible => 'Persona responsable';

  @override
  String get starterEmail => 'Correo electrónico';

  @override
  String get starterPhone => 'Teléfono';

  @override
  String get lookupUrlLabel => 'Enlace de consulta';

  @override
  String lookupUrlHelp(String token) {
    return 'La página del servicio con $token donde va el número, p. ej. https://www.tasso.net/Tierregister/Suchmeldungen?snr=$token';
  }

  @override
  String get lookUpId => 'Consultar';

  @override
  String lookupFailed(String url) {
    return 'Ninguna aplicación pudo abrir $url. Copia el enlace en un navegador.';
  }

  @override
  String get stepCat => 'Gato';

  @override
  String get stepOwner => 'Dueño';

  @override
  String get stepFace => 'Foto de la cara';

  @override
  String get stepRegistry => 'Registro';

  @override
  String get stepReview => 'Revisar y guardar';

  @override
  String get stepOwnerHint =>
      'Quien echa de menos al gato: esta será su ficha, con el contacto del cartel.';

  @override
  String get stepFaceHint =>
      'Recorta la cara del gato del cartel; será la foto de perfil. Puedes saltarte esto.';

  @override
  String get stepRegistryHint =>
      'Números encontrados en el cartel. Los marcados se guardan con el gato y se pueden abrir después.';

  @override
  String get noRegistryLinks =>
      'No hay enlaces de registro en este cartel: aquí no hay nada que hacer.';

  @override
  String get unknownServiceHint => 'Servicio desconocido';

  @override
  String get rememberService => 'Recordar servicio';

  @override
  String get rememberServiceHint =>
      'Nombra el servicio y señala el número dentro del enlace. El próximo cartel se rellenará solo.';

  @override
  String get noIdInLink =>
      'Este enlace no lleva ningún número que la app pueda guardar.';

  @override
  String get whichNumber => '¿Qué parte es el número?';

  @override
  String get cropAgain => 'Recortar de nuevo';

  @override
  String get noFaceYet =>
      'Aún no hay foto de la cara: se usa la foto del cartel.';

  @override
  String get backLabel => 'Atrás';

  @override
  String get dangerButton => 'NO PULSAR.\nPELIGRO';

  @override
  String get dangerThanks => '¡Gracias por usar cat(a)log!';

  @override
  String get helpTitle => 'Ayuda';

  @override
  String get showTipsAgain => 'Ver los consejos otra vez';

  @override
  String get helpHome =>
      'El resumen de tus colonias: una colonia es un lugar donde viven gatos: tu casa, una casa de acogida, una protectora. Toca una tarjeta para ver sus gatos; mantén pulsado para su menú. El botón de abajo a la derecha crea una colonia, y la tarjeta de callejeros reúne a todos los gatos sin hogar.';

  @override
  String get helpClowder =>
      'Todo sobre este lugar: sus gatos, sus campos (dirección, contacto, tipo) y su historial. La página se abre en solo lectura; el lápiz activa la edición, donde también puedes añadir un campo. Mantén pulsado un campo para editarlo directamente, o un gato para moverlo, ocultarlo o abrirlo.';

  @override
  String get helpCat =>
      'Todo sobre este gato: fotos, campos, familia, historial. La página es de solo lectura hasta que tocas el lápiz. Mantén pulsado un campo para editarlo directamente; una foto para su menú. El menú de arriba a la derecha tiene el resto: marcar privado, ocultar, fusionar, anotar un avistamiento, compartir.';

  @override
  String get helpStrays =>
      'Gatos que ahora mismo no tienen hogar: encontrados, escapados o sacados de un cartel. El botón de la cámara registra un gato que tienes delante; el botón del cartel convierte un cartel de gato perdido en un gato con el contacto de su dueño; el escáner lee un código cat(a)log del cartel.';

  @override
  String get helpMap =>
      'Todos los gatos y lugares con posición. La búsqueda encuentra gatos, personas y lugares; un nombre desconocido se busca en todo el mundo. El botón de capas dibuja los círculos de 500 m alrededor de los carteles de un gato desaparecido y de la casa de la que se fue. Las flechas van de pin en pin; mantén pulsado el mapa para anotar un avistamiento.';

  @override
  String get helpCard =>
      'La ficha imprimible de este gato: elige arriba con las etiquetas qué aparece, y luego compártela como imagen o PDF. Los identificadores pueden imprimirse como QR o código de barras, y una posición se convierte en un QR que abre un mapa, más un Plus Code corto.';

  @override
  String get helpSync =>
      'Cómo llegan los datos a otras personas: conectar en directo, usar una carpeta que ven los dos dispositivos, o enviar un archivo por mensajería. Siempre decides tú qué sale, y los archivos .catsync recibidos también se abren aquí.';

  @override
  String get helpFields =>
      'Los campos que usa tu catálogo. Renómbralos, cambia las opciones de un campo de lista o crea los tuyos. Un campo de identificador puede apuntar a un servicio (un registro), y entonces el número se puede tocar en el gato.';

  @override
  String get helpTimeline =>
      'Cada cambio realizado, el más reciente primero: quién cambió qué, cuándo y a qué valor. Cualquier entrada se puede revertir: eso escribe una entrada nueva, nunca se borra nada.';

  @override
  String get helpDuplicates =>
      'Gatos o colonias que parecen estar dos veces: identificadores iguales o nombres muy parecidos con detalles que coinciden. Toca un par para fusionarlo; la fusión no se puede deshacer, por eso se pregunta antes.';

  @override
  String get helpMatches =>
      'Gatos que podrían ser el mismo animal: identificador idéntico, o un callejero visto dentro del área de búsqueda de un gato desaparecido. Toca un par para fusionarlo; mantén pulsado para abrir el primer gato y comparar.';

  @override
  String get helpFlier =>
      'Un cartel fotografiado se convierte en un gato y su dueño. Paso a paso: datos del gato, contacto del dueño, recorte de la cara para la foto de perfil, números de registro del cartel y una comprobación final. Todo son sugerencias: corrige lo que la cámara leyó mal.';

  @override
  String get archiveTitle => 'Archivo';

  @override
  String get archiveExplainer =>
      'Los gatos fallecidos y las colonias vacías que nadie ha tocado en años siguen ocupando espacio, sobre todo sus fotos. Archivar los escribe en un archivo que tú guardas y luego los borra de aquí.';

  @override
  String get archiveAction => 'Archivar';

  @override
  String archiveSelected(int count) {
    return 'Archivar $count entradas';
  }

  @override
  String archiveConfirmTitle(int count) {
    return '¿Archivar $count entradas?';
  }

  @override
  String archiveConfirmBody(String names) {
    return '$names se escribirán en un archivo y después se borrarán, en tu dispositivo y en todos con los que sincronizas. Importar el archivo lo devuelve todo; sin él, se pierden.';
  }

  @override
  String archiveDone(int count) {
    return '$count entradas archivadas y borradas';
  }

  @override
  String archiveFailed(String error) {
    return 'No se borró nada: no se pudo escribir el archivo ($error).';
  }

  @override
  String storageLine(String db, String photos, int count) {
    return 'Base de datos $db, fotos $photos en $count archivos';
  }

  @override
  String quietForYears(int years) {
    return 'Sin cambios desde hace $years años';
  }

  @override
  String get nothingToArchive =>
      'No hay nada lo bastante antiguo para archivar.';

  @override
  String archiveCandidateLine(String date, String size) {
    return 'Último cambio $date · fotos $size';
  }

  @override
  String get helpArchive =>
      'Los datos viejos ocupan espacio, sobre todo las fotos, que cada dispositivo sincronizado arrastra. Aquí eliges gatos fallecidos y colonias vacías que llevan años quietos, los escribes en un archivo que guardas y los borras. El borrado llega a todos con quienes sincronizas; importar el archivo lo restaura todo.';

  @override
  String restoreDeletedTitle(int count) {
    return '¿Restaurar $count entradas borradas?';
  }

  @override
  String restoreDeletedBody(String names) {
    return '$names están borrados en este catálogo y el archivo que acabas de importar los contiene. Restaurarlos los devuelve aquí y a todos los dispositivos con los que sincronizas.';
  }

  @override
  String get restoreAction => 'Restaurar';

  @override
  String get keepDeleted => 'Dejar borrados';

  @override
  String get archiveNotSaved =>
      'No se borró nada: el archivo no se guardó en ningún sitio.';

  @override
  String get locateAddress => 'Buscar la dirección en el mapa';

  @override
  String get addressLocated => 'Dirección encontrada';

  @override
  String get addressNotFound =>
      'No se encontró ningún lugar para esta dirección. Revisa la escritura o déjala vacía.';

  @override
  String get starterPosition => 'Ubicación';

  @override
  String get valueYes => 'sí';

  @override
  String get valueNo => 'no';

  @override
  String get valueFemale => 'hembra';

  @override
  String get valueMale => 'macho';

  @override
  String get valueUnknown => 'desconocido';

  @override
  String get cropTitle => 'Recortar foto';

  @override
  String get markTitle => 'Marcar el gato';

  @override
  String get applyCrop => 'Recortar';

  @override
  String get useFullPhoto => 'Usar la foto completa';

  @override
  String get dragToSelect => 'Dibuja un rectángulo alrededor del gato';

  @override
  String get dragOverTheCat => 'Dibuja una elipse sobre el gato';

  @override
  String get cropPhoto => 'Recortar…';

  @override
  String get markPhoto => 'Marcar…';

  @override
  String get scanCode => 'Escanear código';

  @override
  String get orTypeCode => 'O escribe el código';

  @override
  String get copyCode => 'Copiar código';

  @override
  String get copied => 'Copiado';

  @override
  String get invalidCode => 'Ese código no es válido';

  @override
  String get hotspotHint =>
      '¿Sin Wi-Fi común? Activa el punto de acceso de un móvil, conecta el otro y hospeda aquí.';

  @override
  String get byMessenger => 'Por mensajería';

  @override
  String get byMessengerExplainer =>
      'Envía todo tu catálogo como un archivo por WhatsApp, Signal o correo — el otro lado lo importa.';

  @override
  String get shareBundle => 'Compartir paquete de sincronización…';

  @override
  String get importBundle => 'Importar paquete de sincronización…';

  @override
  String bundleImported(String result) {
    return 'Paquete importado: $result';
  }

  @override
  String lastBackupFailed(String error) {
    return 'La última copia de seguridad automática falló: $error';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Fallo al importar: $error';
  }

  @override
  String get pickOnMap => 'Elegir en el mapa';

  @override
  String get useMyLocation => 'Usar mi ubicación';

  @override
  String get language => 'Idioma';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get iosLocalNetworkHint =>
      'Si sigue fallando en iPhone/iPad: Ajustes → Privacidad y seguridad → Red local → permitir cat(a)log y vuelve a intentarlo.';

  @override
  String get markPrivate => 'Marcar como privado';

  @override
  String get unmarkPrivate => 'Quitar marca privada';

  @override
  String get includePrivate => 'Incluir datos privados';

  @override
  String get includePrivateExplainer =>
      'Esto también envía todo lo que marcaste como privado. Quien sincronice contigo lo verá.';

  @override
  String get hideLabel => 'Ocultar en este dispositivo';

  @override
  String get unhideLabel => 'Mostrar de nuevo';

  @override
  String get showHiddenLabel => 'Mostrar ocultos';

  @override
  String get stopShowingHidden => 'Dejar de mostrar ocultos';

  @override
  String get starterSpecies => 'Especie';

  @override
  String get starterStatus => 'Tipo';

  @override
  String get statusFoster => 'Casa de acogida';

  @override
  String get statusForeverHome => 'Hogar definitivo';

  @override
  String get statusClinic => 'Clínica';

  @override
  String get statusShelter => 'Refugio';

  @override
  String get statusBarn => 'Granero';

  @override
  String get valueCat => 'Gato';

  @override
  String get otherOption => 'Otro…';

  @override
  String get celebrationsToggle => 'Celebrar adopciones';

  @override
  String get celebrationsSubtitle =>
      'Confeti y vítores cuando un gato se muda a su hogar definitivo';

  @override
  String get onMapLabel => 'En el mapa';

  @override
  String get showOnMap => 'Mostrar en el mapa';

  @override
  String get searchPlaceHint => 'Buscar lugar o dirección';

  @override
  String get noPlacesFound => 'No se encontraron lugares';

  @override
  String get mapSearchHint => 'Buscar gatos, clowders, personas';

  @override
  String get proposeAnotherName => 'Proponer otro nombre';

  @override
  String get moderationTitle => 'Autores y bloqueos';

  @override
  String get moderationSubtitle =>
      'Eliminar los datos de una persona para siempre';

  @override
  String get authorsSection => 'Quién escribió en este catálogo';

  @override
  String get hardDeleteAction => 'Borrar todo de este autor';

  @override
  String hardDeleteWarning(Object name) {
    return 'Elimina cada entrada y foto de $name de este dispositivo. Los demás dispositivos conservan las suyas. No se puede deshacer.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Escribe $name para confirmar';
  }

  @override
  String get alsoBan => 'También bloquear — no aceptar nunca más sus datos';

  @override
  String get bansSection => 'Bloqueos';

  @override
  String get unbanAction => 'Quitar bloqueo';

  @override
  String get deletedDone => 'Borrado.';

  @override
  String get syncSummaryTitle => 'Qué ha llegado';

  @override
  String get summaryAdopted => 'Adoptados';

  @override
  String get summaryDeceased => 'Fallecidos';

  @override
  String get summaryEscaped => 'Escapados';

  @override
  String get summaryNew => 'Nuevos';

  @override
  String get summaryConflicts => 'Conflictos por resolver';

  @override
  String summaryOther(Object n) {
    return '…y $n cambios más';
  }

  @override
  String get starterMother => 'Madre';

  @override
  String get starterFather => 'Padre';

  @override
  String get familySection => 'Familia';

  @override
  String get littermatesLabel => 'De la misma camada';

  @override
  String get siblingsLabel => 'Hermanos';

  @override
  String get kittensLabel => 'Gatitos';

  @override
  String get toastSettingsTitle => 'Qué anunciar';

  @override
  String get toastSettingsSubtitle => 'Mensajitos tras una sincronización';

  @override
  String get toastKindAdoptions => 'Adopciones';

  @override
  String get toastKindBirths => 'Nacimientos';

  @override
  String get toastKindDeaths => 'Fallecimientos';

  @override
  String get toastKindEscapes => 'Fugas';

  @override
  String get toastKindMoves => 'Mudanzas';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adoptado por $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Nuevo gatito: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat ha fallecido';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat se ha escapado';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat se mudó a $home';
  }

  @override
  String get notACatlogFile => 'Eso no es un archivo de cat(a)log';

  @override
  String get nothingNewInBundle =>
      'Nada nuevo en ese archivo — ya lo tienes todo';

  @override
  String get syncChooserInPerson => 'En persona';

  @override
  String get syncChooserInPersonSub =>
      'Estáis en la misma habitación — escanea un código y listo';

  @override
  String get syncChooserRemote => 'A distancia';

  @override
  String get syncChooserRemoteSub =>
      'A través de una carpeta compartida como Dropbox o un USB';

  @override
  String get syncChooserMessenger => 'Mensajería';

  @override
  String get syncChooserMessengerSub =>
      'Envía todo como un archivo por cualquier mensajería — e importa aquí un archivo .catsync recibido';

  @override
  String get connectToWifiFirst =>
      'Conéctate primero a una Wi-Fi — así los dispositivos se encuentran';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) quiere sincronizar';
  }

  @override
  String get trustBothWaysNote =>
      'Los catálogos se intercambiarán en ambas direcciones.';

  @override
  String get allowOnce => 'Permitir';

  @override
  String get allowAlways => 'Permitir siempre este dispositivo';

  @override
  String get declineAction => 'Rechazar';

  @override
  String get syncDeclined => 'El otro dispositivo rechazó la sincronización';

  @override
  String get trustedDevicesSection => 'Dispositivos siempre permitidos';

  @override
  String get removeTrust => 'Quitar';

  @override
  String get hostWithoutWifi => 'Alojar sin Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Crea una conexión directa temporal con el otro teléfono (sin internet). Solo cat(a)log la usa y se desconecta sola tras la sincronización.';

  @override
  String get hotspotAndroidOnly =>
      'Este código necesita dos teléfonos Android — en iPhone/iPad usa una Wi-Fi compartida';

  @override
  String get selectClowderHint => 'Elige un clowder a la izquierda';

  @override
  String get introTitle1 => 'Tus gatos, organizados';

  @override
  String get introBody1 =>
      'Crea una ficha para cada gato: foto, sexo, salud, lo que quieras anotar. Los gatos se agrupan por el lugar donde viven — la app llama a ese lugar colonia (clowder).';

  @override
  String get introTitle2 => 'Funciona sin internet';

  @override
  String get introBody2 =>
      'Todo se guarda solo en tu teléfono. Sin cuenta, sin nube. No se sube nada salvo que tú lo compartas.';

  @override
  String get introTitle3 => 'Trabajar en equipo';

  @override
  String get introBody3 =>
      'Cada cual usa su propia app y de vez en cuando intercambiáis datos: quedad y escanead un código, usad una carpeta compartida o enviad un archivo por mensajería. Después todos tienen la misma información.';

  @override
  String get introSkip => 'Omitir';

  @override
  String get introNext => 'Siguiente';

  @override
  String get introDone => 'Vamos';

  @override
  String get introReplayTitle => 'Introducción rápida';

  @override
  String get spotHomeSync =>
      'Aquí sincronizas con tus conocidos. Tú decides qué compartes.';

  @override
  String get spotHomeStrays =>
      'Esta tarjeta reúne a todos los callejeros — gatos sin hogar. Tócala para ver la lista.';

  @override
  String get spotHomeMenu =>
      'En este menú: encontrar y fusionar duplicados, exportar CSV y más.';

  @override
  String get spotCatEdit =>
      'Toca el lápiz para editar este gato. Consejo: mantén pulsado un campo para editarlo directamente.';

  @override
  String get spotMapLayers =>
      '¿Buscas un gato desaparecido? Muestra círculos alrededor de los lugares de sus carteles y de su antiguo hogar.';

  @override
  String get spotStraysFlier =>
      '¿Un cartel de gato desaparecido? Fotografíalo aquí — la app guarda gato y contacto por ti.';

  @override
  String get spotStraysScan =>
      'Algunos carteles llevan un código QR de cat(a)log. Escanéalo aquí para importar el gato sin teclear.';

  @override
  String get introTitle4 => 'Encontrar gatos desaparecidos';

  @override
  String get introBody4 =>
      '¿Ves un cartel de gato desaparecido? Fotografíalo en la app: guarda el gato, el contacto del dueño y el lugar. Si más tarde aparece un callejero parecido, la app sugiere posibles coincidencias.';

  @override
  String get spotMapSearch =>
      'Escribe un gato, un lugar o una persona para saltar allí en el mapa.';

  @override
  String get spotCardChips =>
      'Marca lo que debe aparecer en la ficha compartible — lo demás queda fuera.';

  @override
  String get spotCatMenu =>
      'Aquí hay más acciones: marcar el gato como privado, ocultarlo, fusionar duplicados o anotar un avistamiento.';

  @override
  String get spotDone => 'Entendido';

  @override
  String get spotReplayTitle => 'Tour de novedades';

  @override
  String get spotReplaySubtitle => 'Mostrar las pistas de nuevo en cada página';

  @override
  String get spotReplayDone => 'Las pistas volverán a mostrarse';

  @override
  String get searchNoResults => 'No se encontró ningún gato con ese nombre';

  @override
  String get syncUnreachable =>
      'No se pudo conectar con el otro dispositivo. ¿Están ambos en la misma Wi-Fi?';

  @override
  String get folderUnreachable =>
      'No se pudo acceder a la carpeta. ¿Sigue existiendo la unidad o la carpeta en la nube?';

  @override
  String get crashTitle => 'Esto no debería haber pasado';

  @override
  String get crashBody =>
      'cat(a)log encontró un error inesperado. Tus datos están a salvo — todo se guarda en el momento en que lo cambias. Reinicia la app y, si se repite, envía el informe para poder arreglarlo.';

  @override
  String get crashRestart => 'Reiniciar la app';

  @override
  String get crashSendReport => 'Enviar informe al desarrollador';

  @override
  String get crashLastRunBody =>
      'cat(a)log se detuvo inesperadamente la última vez — probablemente se quedó sin memoria. ¿Enviar un informe breve para arreglarlo?';

  @override
  String get catalogsTitle => 'Catálogos';

  @override
  String get newCatalog => 'Nuevo catálogo';

  @override
  String get catalogNameLabel => 'Nombre del catálogo';

  @override
  String catalogNameTaken(String name) {
    return 'Ya existe un catálogo llamado $name. Elige otro nombre.';
  }

  @override
  String get manageCatalogs => 'Gestionar catálogos';

  @override
  String get helpCatalogs =>
      'Cada catálogo es un mundo propio: sus gatos, sus colonias, sus campos, sus fotos y sus compañeros de sincronización. Berlín y París nunca se mezclan. Toca el nombre en la parte superior para cambiar, añadir o renombrar. Tu nombre, tu idioma y los consejos ya vistos son comunes a todos.';

  @override
  String get spotHomeCatalog =>
      'Este es el catálogo en el que estás. Toca el nombre para cambiar o crear otro.';
}
