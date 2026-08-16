// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'cat(a)log';

  @override
  String get welcomeTitle => 'Bem-vindo ao cat(a)log';

  @override
  String get welcomeBody =>
      'Escolhe um nome para ti. Cada alteração fica registada com este nome, para que os outros vejam quem fez o quê.';

  @override
  String get yourName => 'O teu nome';

  @override
  String get start => 'Começar';

  @override
  String get clowders => 'Clowders';

  @override
  String get noClowdersYet => 'Ainda não há clowders.\nCria o primeiro abaixo.';

  @override
  String get strays => 'Vadios';

  @override
  String get searchCats => 'Procurar gatos';

  @override
  String get map => 'Mapa';

  @override
  String get sync => 'Sincronizar';

  @override
  String get fields => 'Campos';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get aboutAndFeedback => 'Sobre e feedback';

  @override
  String get newClowder => 'Novo clowder';

  @override
  String get name => 'Nome';

  @override
  String get cancel => 'Cancelar';

  @override
  String get create => 'Criar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get merge => 'Unir';

  @override
  String get resolve => 'Resolver';

  @override
  String get open => 'Abrir';

  @override
  String csvSavedTo(String path) {
    return 'CSV guardado em $path';
  }

  @override
  String get renameClowder => 'Renomear clowder';

  @override
  String get rename => 'Renomear';

  @override
  String get timeline => 'Histórico';

  @override
  String get mergeInto => 'Unir com…';

  @override
  String get deleteClowder => 'Eliminar clowder';

  @override
  String get cats => 'Gatos';

  @override
  String get addCat => 'Adicionar gato';

  @override
  String get newCat => 'Novo gato';

  @override
  String deleteQuestion(String name) {
    return 'Eliminar $name?';
  }

  @override
  String get deleteClowderEmptyBody => 'O clowder desaparece da lista.';

  @override
  String deleteClowderBody(int count) {
    return 'Os seus $count gato(s) não são eliminados — tornam-se vadios. Move-os antes para outro clowder se não é isso que queres.';
  }

  @override
  String get card => 'Ficha';

  @override
  String get shareAsImage => 'Partilhar como imagem';

  @override
  String get shareAsPdf => 'Partilhar como PDF';

  @override
  String get print => 'Imprimir';

  @override
  String cardTitle(String name) {
    return 'Ficha — $name';
  }

  @override
  String get renameCat => 'Renomear gato';

  @override
  String get seenHereNow => 'Visto aqui agora';

  @override
  String get deleteCat => 'Eliminar gato';

  @override
  String get clowderLabel => 'Clowder';

  @override
  String get strayNoClowder => 'Vadio — sem clowder';

  @override
  String get stray => 'Vadio';

  @override
  String get photos => 'Fotos';

  @override
  String get addPhoto => 'Adicionar foto';

  @override
  String get setAsProfileImage => 'Definir como foto de perfil';

  @override
  String get thisIsProfileImage => 'Esta é a foto de perfil';

  @override
  String get deletePhoto => 'Eliminar foto';

  @override
  String get deletePhotoTitle => 'Eliminar a foto?';

  @override
  String get deletePhotoBody =>
      'Os dados da foto são removidos para sempre — não é possível desfazer.';

  @override
  String get deleteCatBody =>
      'O gato desaparece de todas as listas. As suas fotos são removidas para sempre.';

  @override
  String get sightingRecorded => 'Avistamento registado na tua posição.';

  @override
  String get noLocationAvailable =>
      'Sem localização disponível — mantém premido o mapa em alternativa.';

  @override
  String get moveTo => 'Mover para';

  @override
  String get noClowderStrayOption => 'Sem clowder — vadio / fugiu';

  @override
  String timelineOf(String name) {
    return 'Histórico — $name';
  }

  @override
  String fieldHistoryOf(String field, String name) {
    return '$field — $name';
  }

  @override
  String get revertThisChange => 'Reverter esta alteração';

  @override
  String get revertSubtitle =>
      'Restaura o valor anterior como nova entrada — o histórico mantém ambos.';

  @override
  String fieldCleared(String field) {
    return '$field limpo';
  }

  @override
  String fieldBackTo(String field, String value) {
    return '$field de volta a \"$value\"';
  }

  @override
  String get leftStray => 'Foi-se embora — vadio';

  @override
  String movedTo(String name) {
    return 'Movido para $name';
  }

  @override
  String arrivedPlain(String cat) {
    return '$cat chegou';
  }

  @override
  String arrivedFrom(String cat, String place) {
    return '$cat chegou de $place';
  }

  @override
  String leftTo(String cat, String place) {
    return '$cat foi para $place';
  }

  @override
  String get duplicateMergedIn => 'Duplicado unido';

  @override
  String get asOfToday => 'Com data de hoje';

  @override
  String asOfDate(String date) {
    return 'Com data de $date';
  }

  @override
  String get value => 'Valor';

  @override
  String get latitudeLongitude => 'latitude, longitude';

  @override
  String get newField => 'Novo campo';

  @override
  String get fieldType => 'Tipo';

  @override
  String get usedOn => 'Usado em';

  @override
  String get forCats => 'gatos';

  @override
  String get forClowders => 'clowders';

  @override
  String get forBoth => 'ambos';

  @override
  String get optionsOnePerLine => 'Opções (uma por linha)';

  @override
  String get renameField => 'Renomear campo';

  @override
  String get noStraysRightNow => 'Sem vadios de momento.';

  @override
  String get strayCam => 'Stray Cam';

  @override
  String get addStray => 'Adicionar vadio';

  @override
  String get newStray => 'Novo vadio';

  @override
  String get searchByNameHint => 'Procurar gatos por nome…';

  @override
  String get host => 'Anfitrião';

  @override
  String get hostExplainer =>
      'Começa aqui e depois introduz o endereço e o PIN no outro dispositivo.';

  @override
  String get startHosting => 'Começar a hospedar';

  @override
  String get stopHosting => 'Parar de hospedar';

  @override
  String pinLabel(String pin) {
    return 'PIN: $pin';
  }

  @override
  String sessionsSoFar(int count) {
    return '$count sessão(ões) até agora';
  }

  @override
  String get join => 'Juntar-se';

  @override
  String get addressFromHost => 'Endereço (do dispositivo anfitrião)';

  @override
  String get pin => 'PIN';

  @override
  String get syncNow => 'Sincronizar agora';

  @override
  String get addressFormatHint => 'O endereço deve ser como 192.168.0.12:38472';

  @override
  String syncedResult(String result) {
    return 'Sincronizado: $result';
  }

  @override
  String syncFailed(String error) {
    return 'Falha na sincronização: $error';
  }

  @override
  String lastSyncWith(String peer, String time) {
    return 'Última sincronização com $peer: $time';
  }

  @override
  String get sharedFolder => 'Pasta partilhada';

  @override
  String get sharedFolderExplainer =>
      'Sincroniza através de uma pasta que uma cloud ou pen USB transporta entre dispositivos — para quem não está na mesma rede.';

  @override
  String get noFolderChosenYet => 'Nenhuma pasta escolhida';

  @override
  String get choose => 'Escolher…';

  @override
  String get syncFolderNow => 'Sincronizar pasta agora';

  @override
  String folderSynced(String result) {
    return 'Pasta sincronizada: $result';
  }

  @override
  String folderSyncFailed(String error) {
    return 'Falha ao sincronizar pasta: $error';
  }

  @override
  String get recordSightingHere => 'Registar um avistamento aqui:';

  @override
  String get orPlaceClowderHere => 'Ou colocar um clowder aqui:';

  @override
  String trailOf(String name, int count) {
    return 'Percurso: $name ($count avistamentos)';
  }

  @override
  String conflictOn(String field) {
    return 'Conflito — $field';
  }

  @override
  String get conflictBody =>
      'Alterado em dois sítios ao mesmo tempo. Escolhe o que é verdade:';

  @override
  String mergeThisInto(String kind) {
    return 'Unir este $kind com…';
  }

  @override
  String noOtherToMergeInto(String kind) {
    return 'Não há outro $kind para unir.';
  }

  @override
  String mergeIntoQuestion(String name) {
    return 'Unir com $name?';
  }

  @override
  String mergeBody(String name) {
    return 'Os dois registos tornam-se um. $name mantém os valores atuais; o histórico do outro junta-se ao seu. Não é possível desfazer.';
  }

  @override
  String get kindCat => 'gato';

  @override
  String get kindClowder => 'clowder';

  @override
  String get kindField => 'campo';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get about => 'Sobre';

  @override
  String get aboutTagline =>
      'Um catálogo local para gatos de acolhimento. Os teus dados ficam nos teus dispositivos — sem servidor, sem conta.';

  @override
  String versionLabel(String version, String build) {
    return 'Versão $version ($build)';
  }

  @override
  String get sourceCode => 'Código-fonte';

  @override
  String get reportProblemOrIdea => 'Reportar um problema ou ideia';

  @override
  String get githubIssues => 'Issues no GitHub';

  @override
  String get writeTheDeveloper => 'Escrever ao programador';

  @override
  String get buyCoffee => 'Pagar um café ao programador';

  @override
  String get coffeeSubtitle => 'Totalmente opcional — a app é grátis';

  @override
  String get openSourceLicenses => 'Licenças open source';

  @override
  String get machineTranslated =>
      'As traduções são automáticas — correções são bem-vindas no GitHub.';

  @override
  String get unnamed => '(sem nome)';

  @override
  String get labelName => 'Nome';

  @override
  String get labelProfileImage => 'Foto de perfil';

  @override
  String get labelPhoto => 'Foto';

  @override
  String get starterGender => 'Sexo';

  @override
  String get starterColor => 'Cor';

  @override
  String get starterNeutered => 'Esterilizado';

  @override
  String get starterPregnant => 'Prenha';

  @override
  String get starterBirthdate => 'Data de nascimento';

  @override
  String get starterDeceased => 'Falecido';

  @override
  String get starterAddress => 'Morada';

  @override
  String get starterResponsible => 'Pessoa responsável';

  @override
  String get starterPosition => 'Posição';

  @override
  String get valueYes => 'sim';

  @override
  String get valueNo => 'não';

  @override
  String get valueFemale => 'fêmea';

  @override
  String get valueMale => 'macho';

  @override
  String get valueUnknown => 'desconhecido';

  @override
  String get cropTitle => 'Recortar foto';

  @override
  String get markTitle => 'Marcar o gato';

  @override
  String get useFullPhoto => 'Usar a foto inteira';

  @override
  String get dragToSelect => 'Arrasta um retângulo à volta do gato';

  @override
  String get dragOverTheCat => 'Arrasta uma elipse sobre o gato';

  @override
  String get cropPhoto => 'Recortar…';

  @override
  String get markPhoto => 'Marcar…';

  @override
  String get scanCode => 'Ler código';

  @override
  String get orTypeCode => 'Ou escreve o código';

  @override
  String get copyCode => 'Copiar código';

  @override
  String get copied => 'Copiado';

  @override
  String get invalidCode => 'Esse código não é válido';

  @override
  String get hotspotHint =>
      'Sem Wi-Fi comum? Liga o hotspot de um telemóvel, liga o outro a ele e hospeda aqui.';

  @override
  String get byMessenger => 'Por mensagens';

  @override
  String get byMessengerExplainer =>
      'Envia o catálogo inteiro como um ficheiro por WhatsApp, Signal ou mail — o outro lado importa-o.';

  @override
  String get shareBundle => 'Partilhar pacote de sincronização…';

  @override
  String get importBundle => 'Importar pacote de sincronização…';

  @override
  String bundleImported(String result) {
    return 'Pacote importado: $result';
  }

  @override
  String bundleImportFailed(String error) {
    return 'Falha na importação: $error';
  }

  @override
  String get pickOnMap => 'Escolher no mapa';

  @override
  String get useMyLocation => 'Usar a minha localização';

  @override
  String get language => 'Idioma';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get iosLocalNetworkHint =>
      'Se continuar a falhar no iPhone/iPad: Definições → Privacidade e segurança → Rede local → permitir cat(a)log e tenta de novo.';

  @override
  String get markPrivate => 'Marcar como privado';

  @override
  String get unmarkPrivate => 'Remover marca de privado';

  @override
  String get includePrivate => 'Incluir dados privados';

  @override
  String get includePrivateExplainer =>
      'Gatos, clowders e campos privados também são partilhados — ative apenas ao sincronizar os seus próprios dispositivos.';
}
