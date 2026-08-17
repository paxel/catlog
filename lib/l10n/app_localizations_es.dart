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
  String get noClowdersYet => 'Aún no hay clowders.\nCrea el primero abajo.';

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
      'El gato desaparece de todas las listas. Sus fotos se eliminan para siempre.';

  @override
  String get sightingRecorded => 'Avistamiento registrado en tu posición.';

  @override
  String get noLocationAvailable =>
      'Sin ubicación disponible — mantén pulsado el mapa en su lugar.';

  @override
  String get locationDeniedForever =>
      'El acceso a la ubicación está bloqueado. Permítelo en los ajustes del sistema para usar Stray Cam.';

  @override
  String get openSettings => 'Abrir ajustes';

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
      'Sincroniza mediante una carpeta que una nube o un USB lleva entre dispositivos — para quienes no están en la misma red.';

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
  String get starterPosition => 'Posición';

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
}
