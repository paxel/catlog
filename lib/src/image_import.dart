import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'l10n.dart';
import 'screens/photo_edit_screen.dart';

/// Lets the user pick or take a photo, offers the crop step (skippable;
/// Stray Cam passes [allowCrop] false), compresses off the UI thread,
/// and stores it on the Cat. Returns the content hash, or null if the
/// user canceled.
Future<String?> pickAndAddImage(
    BuildContext context, CatalogStore store, String catId,
    {bool allowCrop = true}) async {
  final raw = await pickImageBytes(context, allowCrop: allowCrop);
  if (raw == null) return null;
  final bytes = raw;
  final jpeg = await Isolate.run(() => CatalogStore.compressImage(bytes));
  return store.addImage(catId, jpeg);
}

/// Picks or takes a photo and returns the (optionally cropped) raw
/// bytes, or null if the user canceled.
Future<Uint8List?> pickImageBytes(BuildContext context,
    {bool allowCrop = true}) async {
  final canUseCamera = Platform.isAndroid || Platform.isIOS;
  ImageSource source = ImageSource.gallery;
  if (canUseCamera) {
    final picked = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(context.t.takePhoto),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(context.t.chooseFromGallery),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ]),
      ),
    );
    if (picked == null) return null;
    source = picked;
  }

  final file = await ImagePicker().pickImage(source: source);
  if (file == null) return null;
  var raw = await file.readAsBytes();

  if (allowCrop && context.mounted) {
    final edited = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => PhotoEditScreen(
            bytes: raw, mode: PhotoEditMode.crop, allowSkip: true),
      ),
    );
    if (edited == null) return null; // canceled the import
    raw = edited;
  }

  return raw;
}
