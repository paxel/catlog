import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';

import 'package:catalog_core/catalog_core.dart';

import 'image_import.dart';
import 'l10n.dart';
import 'notes.dart';
import 'stray_cam.dart';
import 'video_frames.dart';
import 'exclusive.dart';

/// Picks a video file and runs the frame picker over it. Returns the
/// kept frames as JPEG bytes at the video's own size — the crop step
/// cuts from them before compression; the video is never stored (#41).
/// Mobile only — elsewhere the reason is explained instead of failing.
Future<List<Uint8List>?> pickVideoFrames(BuildContext context) =>
    runExclusive('imagePicker', () => _pickVideoFrames(context),
        context: context);

Future<List<Uint8List>?> _pickVideoFrames(BuildContext context) async {
  if (defaultTargetPlatform != TargetPlatform.android &&
      defaultTargetPlatform != TargetPlatform.iOS) {
    noteFailed(context.t.videoMobileOnly);
    return null;
  }
  final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (video == null || !context.mounted) return null;
  return framesFromVideoFile(context, video.path, keptWidth: 0);
}

/// Runs the frame picker over a video already on disk — picked or
/// shared in. Returns the kept frames as JPEG bytes, at most
/// [keptWidth] wide; 0 keeps the video's own size.
Future<List<Uint8List>?> framesFromVideoFile(
    BuildContext context, String path, {int keptWidth = 2560}) async {
  final controller = VideoPlayerController.file(File(path));
  try {
    await controller.initialize();
    if (!context.mounted) return null;
    return await Navigator.of(context).push<List<Uint8List>>(MaterialPageRoute(
      builder: (_) => VideoFramesScreen(
        player: _ControllerPlayer(controller),
        // Preview size for the strip; photo size only for what is kept.
        extractFrame: (ms) => VideoThumbnail.thumbnailData(
          video: path,
          timeMs: ms,
          imageFormat: ImageFormat.JPEG,
          quality: 85,
          maxWidth: 1024,
        ),
        extractFull: (ms) => VideoThumbnail.thumbnailData(
          video: path,
          timeMs: ms,
          imageFormat: ImageFormat.JPEG,
          quality: 90,
          maxWidth: keptWidth,
        ),
      ),
    ));
  } finally {
    await controller.dispose();
  }
}

/// The video player as the picker sees it.
class _ControllerPlayer extends ChangeNotifier implements FramePlayer {
  final VideoPlayerController controller;

  _ControllerPlayer(this.controller) {
    controller.addListener(notifyListeners);
  }

  @override
  Duration get duration => controller.value.duration;

  @override
  Duration get position => controller.value.position;

  @override
  bool get playing => controller.value.isPlaying;

  /// The player does not tell the clip's rate; thirty is what phones
  /// film at, and a step of a thirtieth lands on some frame either way.
  @override
  double get fps => 30;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );

  @override
  Future<void> seekTo(Duration at) => controller.seekTo(at);

  @override
  Future<void> play() => controller.play();

  @override
  Future<void> pause() => controller.pause();

  @override
  void dispose() {
    controller.removeListener(notifyListeners);
    super.dispose();
  }
}

/// Stray Cam from a video (#41): pick a video file of the stray, pick
/// frames, each through the crop step, and only a kept frame creates
/// the cat — the photo-first rule holds. Extra kept frames join as
/// further photos.
Future<String?> strayCamVideo(BuildContext context, CatalogStore store,
    {Locator locate = locateDevice,
    Future<List<Uint8List>?> Function(BuildContext) pickFrames =
        pickVideoFrames,
    CropStep cropStep = cropPage}) async {
  var kept = <KeptFrame>[];
  final catId = await strayCam(context, store, locate: locate,
      pickPhoto: (c) async {
    final frames = await pickFrames(c);
    if (frames == null || !c.mounted) return null;
    kept = await cropFrames(c, frames, cropStep: cropStep);
    return kept.isEmpty ? null : kept.first.bytes;
  },
      addPhoto: (store, catId, bytes) =>
          addCompressedImage(store, catId, bytes, crop: kept.first.crop));
  if (catId != null) await addFrames(store, catId, kept.skip(1).toList());
  return catId;
}
