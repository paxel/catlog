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
  String get noClowdersYet =>
      'Ainda não há clowders. Um clowder é um lugar onde vivem gatos — a sua casa de acolhimento, o apartamento de um adotante. Crie o primeiro abaixo.';

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
      'O gato desaparece de todas as listas e as suas fotos são removidas — aqui e, após a próxima sincronização, também nos dispositivos dos seus ajudantes.';

  @override
  String get sightingRecorded => 'Avistamento registado na tua posição.';

  @override
  String get noLocationAvailable =>
      'Sem localização disponível — mantém premido o mapa em alternativa.';

  @override
  String get locationDeniedForever =>
      'O acesso à localização está bloqueado. Permita-o nas definições do sistema para usar o Stray Cam.';

  @override
  String get locationServiceOff =>
      'A localização está desativada neste dispositivo. Ative-a nas definições e tente novamente.';

  @override
  String get locationDenied =>
      'O cat(a)log não tem permissão para usar a sua localização. Tente novamente e permita quando for perguntado.';

  @override
  String get locationNoFix =>
      'Não foi possível determinar a sua posição agora. Tente novamente ao ar livre — o GPS precisa de vista desimpedida do céu.';

  @override
  String get ok => 'OK';

  @override
  String get starterChipId => 'Número do chip';

  @override
  String get starterRemarks => 'Observações';

  @override
  String get captureFlier => 'Fotografar cartaz';

  @override
  String get scanPrintedCode => 'Ler código impresso';

  @override
  String get chipScanHint =>
      'Lê o QR/código de barras impresso do cartão do chip ou dos papéis do veterinário — o telemóvel não consegue ler o chip dentro do gato.';

  @override
  String get savingLabel => 'A guardar…';

  @override
  String ownerOfCat(String name) {
    return 'Dono de $name';
  }

  @override
  String get sortLabel => 'Ordenar';

  @override
  String get matchCandidatesTitle => 'Possíveis correspondências';

  @override
  String get findDuplicates => 'Encontrar duplicados';

  @override
  String get noDuplicates => 'Sem possíveis duplicados de momento.';

  @override
  String get similarName => 'Nome parecido';

  @override
  String get sharePublicly => 'Partilhar publicamente…';

  @override
  String get pickFramesTitle => 'Escolher fotogramas';

  @override
  String get suggestedFrames => 'Fotogramas sugeridos';

  @override
  String get scrubFrames => 'Percorrer o vídeo';

  @override
  String get keepThisFrame => 'Manter este fotograma';

  @override
  String get fromVideo => 'De um vídeo…';

  @override
  String get videoMobileOnly =>
      'Escolher fotogramas de um vídeo funciona na app do telemóvel (Android e iPhone) — ainda não neste dispositivo.';

  @override
  String get shareWhitelistExplainer =>
      'Só os campos marcados saem do catálogo. Tudo o resto fica em casa.';

  @override
  String get exportShareFile => 'Exportar ficheiro de partilha…';

  @override
  String get hostedLink => 'Link alojado (URL do ficheiro carregado)';

  @override
  String get inlineQr => 'QR incorporado (só texto, sem fotos)';

  @override
  String get inlineTooBig =>
      'Demasiados dados para um código incorporado — desmarque campos ou use um link alojado.';

  @override
  String get scanShareLabel => 'Ler código de partilha';

  @override
  String get notAShareCode => 'Esse código não é uma partilha cat(a)log.';

  @override
  String get importShareTitle => 'Importar este gato?';

  @override
  String shareSource(String url) {
    return 'Origem: $url';
  }

  @override
  String get importLabel => 'Importar';

  @override
  String get strayAreaLabel => 'Possível zona de deambulação';

  @override
  String get noMissingCats =>
      'Ainda sem gatos desaparecidos com posições de cartazes.';

  @override
  String get noMatchCandidates => 'Sem possíveis correspondências de momento.';

  @override
  String sameIdField(String field) {
    return 'Mesmo $field';
  }

  @override
  String metersApart(String distance) {
    return 'A $distance m de distância';
  }

  @override
  String get addFlier => 'Adicionar cartaz';

  @override
  String get missingSinceLabel => 'Desaparecido desde';

  @override
  String get phoneLabel => 'Telefone';

  @override
  String get cropPortrait => 'Recortar retrato';

  @override
  String get statusOwner => 'Dono';

  @override
  String get ocrUnavailable =>
      'O reconhecimento de texto não está disponível neste dispositivo — escreva você o texto do cartaz.';

  @override
  String get displayFormat => 'Mostrado como';

  @override
  String get displayPlain => 'Texto simples';

  @override
  String get displayQr => 'Código QR';

  @override
  String get displayBarcode => 'Código de barras';

  @override
  String get editLabel => 'Editar';

  @override
  String get doneLabel => 'Concluído';

  @override
  String get openSettings => 'Abrir definições';

  @override
  String get notSaved => 'Não guardado';

  @override
  String get birthdateInFuture =>
      'A data de nascimento não pode estar no futuro.';

  @override
  String get deceasedInFuture =>
      'A data de falecimento não pode estar no futuro.';

  @override
  String deceasedBeforeBirth(String date) {
    return 'A data de falecimento não pode ser anterior à data de nascimento ($date).';
  }

  @override
  String bornAfterDeceased(String date) {
    return 'A data de nascimento não pode ser posterior à data de falecimento ($date).';
  }

  @override
  String get malePregnant =>
      'Este gato está registado como macho — um macho não pode estar prenhe. Verifique primeiro o sexo.';

  @override
  String fatherNotMale(String name) {
    return '$name está registada como fêmea e não pode ser o pai. Verifique primeiro o sexo.';
  }

  @override
  String motherNotFemale(String name) {
    return '$name está registado como macho e não pode ser a mãe. Verifique primeiro o sexo.';
  }

  @override
  String parentBornAfterKitten(String name, String date) {
    return '$name nasceu em $date — um progenitor não pode nascer depois da sua cria.';
  }

  @override
  String get genderFatherFemale =>
      'Este gato está registado como pai de outros gatos — o pai não pode ser fêmea. Verifique primeiro a família.';

  @override
  String get genderMotherMale =>
      'Este gato está registado como mãe de outros gatos — a mãe não pode ser macho. Verifique primeiro a família.';

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
  String dateFormatError(String format) {
    return 'Formato errado — use $format';
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
  String get ownValue => 'Valor próprio';

  @override
  String get renameField => 'Renomear campo';

  @override
  String get editOptions => 'Editar opções…';

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
  String get starterBreed => 'Raça';

  @override
  String get valueMixed => 'misto';

  @override
  String get breedEuropeanShorthair => 'Europeu de pelo curto';

  @override
  String get breedMaineCoon => 'Maine Coon';

  @override
  String get breedBritishShorthair => 'Britânico de pelo curto';

  @override
  String get breedNorwegianForestCat => 'Gato da floresta norueguesa';

  @override
  String get breedRagdoll => 'Ragdoll';

  @override
  String get breedSiamese => 'Siamês';

  @override
  String get breedPersian => 'Persa';

  @override
  String get breedBengal => 'Bengal';

  @override
  String get breedSphynx => 'Sphynx';

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
  String get starterPosition => 'Localização';

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
  String get applyCrop => 'Recortar';

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
  String lastBackupFailed(String error) {
    return 'A última cópia de segurança automática falhou: $error';
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

  @override
  String get hideLabel => 'Ocultar neste dispositivo';

  @override
  String get unhideLabel => 'Mostrar novamente';

  @override
  String get showHiddenLabel => 'Mostrar ocultos';

  @override
  String get stopShowingHidden => 'Deixar de mostrar ocultos';

  @override
  String get starterSpecies => 'Espécie';

  @override
  String get starterStatus => 'Tipo';

  @override
  String get statusFoster => 'Família de acolhimento';

  @override
  String get statusForeverHome => 'Lar definitivo';

  @override
  String get statusClinic => 'Clínica';

  @override
  String get statusShelter => 'Abrigo';

  @override
  String get statusBarn => 'Celeiro';

  @override
  String get valueCat => 'Gato';

  @override
  String get otherOption => 'Outro…';

  @override
  String get celebrationsToggle => 'Celebrar adoções';

  @override
  String get celebrationsSubtitle =>
      'Confetes e vivas quando um gato se muda para o lar definitivo';

  @override
  String get onMapLabel => 'No mapa';

  @override
  String get showOnMap => 'Mostrar no mapa';

  @override
  String get searchPlaceHint => 'Procurar lugar ou morada';

  @override
  String get noPlacesFound => 'Nenhum lugar encontrado';

  @override
  String get mapSearchHint => 'Procurar gatos, clowders, pessoas';

  @override
  String get proposeAnotherName => 'Propor outro nome';

  @override
  String get moderationTitle => 'Autores e bloqueios';

  @override
  String get moderationSubtitle => 'Remover os dados de uma pessoa para sempre';

  @override
  String get authorsSection => 'Quem escreveu neste catálogo';

  @override
  String get hardDeleteAction => 'Apagar tudo deste autor';

  @override
  String hardDeleteWarning(Object name) {
    return 'Remove cada entrada e foto de $name deste dispositivo. Os outros dispositivos mantêm as suas. Não pode ser desfeito.';
  }

  @override
  String typeToConfirm(Object name) {
    return 'Escreva $name para confirmar';
  }

  @override
  String get alsoBan => 'Bloquear também — nunca mais aceitar os seus dados';

  @override
  String get bansSection => 'Bloqueios';

  @override
  String get unbanAction => 'Remover bloqueio';

  @override
  String get deletedDone => 'Apagado.';

  @override
  String get syncSummaryTitle => 'O que chegou';

  @override
  String get summaryAdopted => 'Adotados';

  @override
  String get summaryDeceased => 'Falecidos';

  @override
  String get summaryEscaped => 'Fugidos';

  @override
  String get summaryNew => 'Novos';

  @override
  String get summaryConflicts => 'Conflitos por resolver';

  @override
  String summaryOther(Object n) {
    return '…e mais $n alterações';
  }

  @override
  String get starterMother => 'Mãe';

  @override
  String get starterFather => 'Pai';

  @override
  String get familySection => 'Família';

  @override
  String get littermatesLabel => 'Da mesma ninhada';

  @override
  String get siblingsLabel => 'Irmãos';

  @override
  String get kittensLabel => 'Gatinhos';

  @override
  String get toastSettingsTitle => 'O que anunciar';

  @override
  String get toastSettingsSubtitle =>
      'Pequenas mensagens após uma sincronização';

  @override
  String get toastKindAdoptions => 'Adoções';

  @override
  String get toastKindBirths => 'Nascimentos';

  @override
  String get toastKindDeaths => 'Falecimentos';

  @override
  String get toastKindEscapes => 'Fugas';

  @override
  String get toastKindMoves => 'Mudanças';

  @override
  String toastAdopted(Object cat, Object home) {
    return '💚 $cat adotado por $home 💚';
  }

  @override
  String toastBorn(Object cat) {
    return '✨ Novo gatinho: $cat ✨';
  }

  @override
  String toastDeceased(Object cat) {
    return '$cat faleceu';
  }

  @override
  String toastEscaped(Object cat) {
    return '$cat fugiu';
  }

  @override
  String toastMoved(Object cat, Object home) {
    return '$cat mudou-se para $home';
  }

  @override
  String get notACatlogFile => 'Isso não é um ficheiro cat(a)log';

  @override
  String get nothingNewInBundle => 'Nada de novo no ficheiro — já tem tudo';

  @override
  String get syncChooserInPerson => 'Presencial';

  @override
  String get syncChooserInPersonSub =>
      'Estão na mesma sala — digitalize um código, pronto em segundos';

  @override
  String get syncChooserRemote => 'À distância';

  @override
  String get syncChooserRemoteSub =>
      'Através de uma pasta partilhada como Dropbox ou uma pen USB';

  @override
  String get syncChooserMessenger => 'Mensageiro';

  @override
  String get syncChooserMessengerSub =>
      'Envie tudo como um único ficheiro por qualquer mensageiro';

  @override
  String get connectToWifiFirst =>
      'Ligue-se primeiro a uma Wi-Fi — assim os dispositivos encontram-se';

  @override
  String trustQuestion(Object author, Object device) {
    return '$author ($device) quer sincronizar';
  }

  @override
  String get trustBothWaysNote =>
      'Os catálogos serão trocados em ambas as direções.';

  @override
  String get allowOnce => 'Permitir';

  @override
  String get allowAlways => 'Permitir sempre este dispositivo';

  @override
  String get declineAction => 'Recusar';

  @override
  String get syncDeclined => 'O outro dispositivo recusou a sincronização';

  @override
  String get trustedDevicesSection => 'Dispositivos sempre permitidos';

  @override
  String get removeTrust => 'Remover';

  @override
  String get hostWithoutWifi => 'Hospedar sem Wi-Fi';

  @override
  String get hotspotJoinNote =>
      'Cria uma ligação direta temporária ao outro telemóvel (sem internet). Só o cat(a)log a usa e desliga-se sozinha após a sincronização.';

  @override
  String get hotspotAndroidOnly =>
      'Este código precisa de dois telemóveis Android — no iPhone/iPad use uma Wi-Fi partilhada';

  @override
  String get selectClowderHint => 'Escolha um clowder à esquerda';

  @override
  String get introTitle1 => 'Os gatos vivem em clowders';

  @override
  String get introBody1 =>
      'Um clowder é um lugar onde vivem gatos: a sua casa de acolhimento, o apartamento de um adotante, o celeiro ao lado. Cada gato tem uma ficha com foto, factos e toda a sua história.';

  @override
  String get introTitle2 => 'Tudo fica consigo';

  @override
  String get introBody2 =>
      'Sem conta, sem nuvem, sem rastreio. Os seus dados vivem no seu dispositivo.';

  @override
  String get introTitle3 => 'Partilhe com os seus ajudantes';

  @override
  String get introBody3 =>
      'Digitalize um código e dois dispositivos sincronizam em segundos, use uma pasta partilhada ou envie tudo como um ficheiro.';

  @override
  String get introSkip => 'Saltar';

  @override
  String get introNext => 'Seguinte';

  @override
  String get introDone => 'Vamos lá';

  @override
  String get introReplayTitle => 'Introdução rápida';

  @override
  String get spotHomeSync =>
      'Novo: a sincronização oferece agora três caminhos claros — e uma pergunta de confiança antes de algo fluir.';

  @override
  String get spotHomeStrays =>
      'Novo: os vadios têm o seu próprio cartão aqui em cima — número, focinhos, toque para abrir.';

  @override
  String get spotHomeMenu =>
      'Novo: este menu encontra gatos e colónias duplicados e funde-os.';

  @override
  String get spotCatEdit =>
      'Novo: a página é só de leitura — o lápis muda para edição, e premir longamente um campo edita-o diretamente.';

  @override
  String get spotMapLayers =>
      'Novo: mostre círculos de busca de 500 m à volta dos cartazes de um gato desaparecido.';

  @override
  String get spotStraysFlier =>
      'Novo: fotografe um cartaz de gato desaparecido — torna-se o gato, o dono e o contacto.';

  @override
  String get spotStraysScan =>
      'Novo: leia um código cat(a)log de um cartaz para importar o gato diretamente.';

  @override
  String get introTitle4 => 'Gatos desaparecidos';

  @override
  String get introBody4 =>
      'Fotografe um cartaz e o gato desaparecido entra no catálogo com o contacto do dono. Avistamentos, círculos de busca e sugestões de correspondência ajudam-no a voltar a casa.';

  @override
  String get spotMapSearch =>
      'Novo: procure aqui gatos, clowders e pessoas — diretamente no mapa.';

  @override
  String get spotCardChips =>
      'Novo: escolha o que aparece na ficha antes de a partilhar.';

  @override
  String get spotCatMenu =>
      'Novo: marque um gato como privado (nunca sai do seu dispositivo) ou oculte-o aqui.';

  @override
  String get spotDone => 'Entendi';

  @override
  String get spotReplayTitle => 'Tour das novidades';

  @override
  String get spotReplaySubtitle => 'Mostrar as dicas novamente em cada página';

  @override
  String get spotReplayDone => 'As dicas voltarão a aparecer';

  @override
  String get searchNoResults => 'Nenhum gato encontrado com esse nome';

  @override
  String get syncUnreachable =>
      'Não foi possível contactar o outro dispositivo. Estão ambos na mesma Wi-Fi?';

  @override
  String get folderUnreachable =>
      'Não foi possível aceder à pasta. O disco ou a pasta na nuvem ainda existe?';

  @override
  String get crashTitle => 'Isto não devia ter acontecido';

  @override
  String get crashBody =>
      'O cat(a)log encontrou um erro inesperado. Os seus dados estão seguros — tudo é guardado no momento em que altera. Reinicie a app e, se se repetir, envie o relatório para que possa ser corrigido.';

  @override
  String get crashRestart => 'Reiniciar a app';

  @override
  String get crashSendReport => 'Enviar relatório ao programador';

  @override
  String get crashLastRunBody =>
      'O cat(a)log parou inesperadamente da última vez — provavelmente ficou sem memória. Enviar um relatório curto para corrigir?';
}
