import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'celebration.dart' show Cheer, firstOrDone;
import '../l10n/app_localizations.dart';

/// Every moment the app makes a sound at has its own choice, kept on
/// this device: none, one of the shipped cat sounds, or a file of the
/// keeper's own. A choice is made on the Settings page and heard there
/// as it is picked.
sealed class SoundChoice {
  const SoundChoice();
}

class NoSound extends SoundChoice {
  const NoSound();
}

class PresetSound extends SoundChoice {
  final Preset preset;
  const PresetSound(this.preset);
}

class OwnSound extends SoundChoice {
  final String path;
  const OwnSound(this.path);
}

/// The shipped sounds, see assets/sounds/LICENSES.md: a purr and a
/// party meow from Wikimedia Commons, three calls of one cat called
/// Socke, and a chorus made of those three.
enum Preset { purr, chorus, party, meep, mrrp, mrrr }

String presetAsset(Preset preset) => switch (preset) {
  Preset.purr => 'sounds/purr.wav',
  Preset.chorus => 'sounds/chorus.wav',
  Preset.party => 'sounds/party.wav',
  Preset.meep => 'sounds/socke1.wav',
  Preset.mrrp => 'sounds/socke2.wav',
  Preset.mrrr => 'sounds/socke3.wav',
};

/// The sound a moment has until the keeper picks another.
Preset defaultPreset(Cheer moment) => switch (moment) {
  Cheer.tick => Preset.meep,
  Cheer.dayDone => Preset.purr,
  Cheer.ladder => Preset.chorus,
  Cheer.adoption => Preset.party,
};

String soundKey(Cheer moment) => 'sound:${moment.name}';

/// The choice for a moment. Before the choices existed one switch
/// silenced every cheer; a device that had it off stays silent.
SoundChoice soundFor(CatalogStore store, Cheer moment) {
  final raw = store.localSetting(soundKey(moment));
  if (raw == null) {
    final legacyOff =
        store.localSetting('celebrationSound') == 'off' ||
        store.localSetting('celebrations') == 'off';
    return legacyOff ? const NoSound() : PresetSound(defaultPreset(moment));
  }
  if (raw == 'none') return const NoSound();
  if (raw.startsWith('file:')) return OwnSound(raw.substring(5));
  final preset = Preset.values.where((p) => p.name == raw).firstOrNull;
  return PresetSound(preset ?? defaultPreset(moment));
}

void setSound(CatalogStore store, Cheer moment, SoundChoice choice) {
  final raw = switch (choice) {
    NoSound() => 'none',
    PresetSound(:final preset) => preset.name,
    OwnSound(:final path) => 'file:$path',
  };
  store.setLocalSetting(soundKey(moment), raw);
}

/// Plays a choice; nothing for none, and nothing when the device has
/// no audio to give.
Future<void> playSound(SoundChoice choice) async {
  final source = switch (choice) {
    NoSound() => null,
    PresetSound(:final preset) => AssetSource(presetAsset(preset)),
    OwnSound(:final path) => DeviceFileSource(path),
  };
  if (source == null) return;
  final player = AudioPlayer();
  try {
    await player.setAudioContext(
      AudioContext(
        iOS: AudioContextIOS(category: AVAudioSessionCategory.ambient),
        android: const AudioContextAndroid(
          usageType: AndroidUsageType.game,
          audioFocus: AndroidAudioFocus.none,
        ),
      ),
    );
    await player.play(source);
    // Released when the sound ends — or after a few seconds if the
    // platform never says so, or at once when the platform closes the
    // stream without an event.
    firstOrDone(
      player.onPlayerComplete,
      const Duration(seconds: 10),
    ).whenComplete(player.dispose);
  } catch (_) {
    // No audio device or platform quirk — the moment passes in silence.
    player.dispose();
  }
}

/// The moment's sound, as chosen.
Future<void> playMoment(CatalogStore store, Cheer moment) =>
    playSound(soundFor(store, moment));

/// Asks for an audio file and keeps a copy of it with the app, so the
/// choice outlives the file it came from. Null when nothing was picked.
Future<OwnSound?> pickOwnSound(Cheer moment) async {
  final picked = await FilePicker.platform.pickFiles(type: FileType.audio);
  final source = picked?.files.singleOrNull?.path;
  if (source == null) return null;
  final dir = await getApplicationSupportDirectory();
  final sounds = Directory('${dir.path}/sounds');
  await sounds.create(recursive: true);
  final dot = source.lastIndexOf('.');
  final extension = dot < 0 ? '' : source.substring(dot);
  final target = '${sounds.path}/${moment.name}$extension';
  await File(source).copy(target);
  return OwnSound(target);
}

/// The moment's name on the Settings page.
String momentLabel(AppLocalizations t, Cheer moment) => switch (moment) {
  Cheer.tick => t.choreTickLabel,
  Cheer.dayDone => t.allDoneToday,
  Cheer.ladder => t.achievementsTitle,
  Cheer.adoption => t.toastKindAdoptions,
};

String presetLabel(AppLocalizations t, Preset preset) => switch (preset) {
  Preset.purr => t.soundPurr,
  Preset.chorus => t.soundChorus,
  Preset.party => t.soundParty,
  Preset.meep => t.soundMeep,
  Preset.mrrp => t.soundMrrp,
  Preset.mrrr => t.soundMrrr,
};

/// The choice's name: None, the preset, or the own file's name.
String choiceLabel(AppLocalizations t, SoundChoice choice) => switch (choice) {
  NoSound() => t.alertNone,
  PresetSound(:final preset) => presetLabel(t, preset),
  OwnSound(:final path) => path.split(Platform.pathSeparator).last,
};
