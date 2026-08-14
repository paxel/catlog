import 'dart:io';
import 'dart:isolate';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Lets the user pick or take a photo, compresses it off the UI thread,
/// and stores it on the Cat. Returns the content hash, or null if the
/// user canceled.
Future<String?> pickAndAddImage(
    BuildContext context, CatalogStore store, String catId) async {
  final canUseCamera = Platform.isAndroid || Platform.isIOS;
  ImageSource source = ImageSource.gallery;
  if (canUseCamera) {
    final picked = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Take photo'),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from gallery'),
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
  final raw = await file.readAsBytes();
  final jpeg = await Isolate.run(() => CatalogStore.compressImage(raw));
  return store.addImage(catId, jpeg);
}
