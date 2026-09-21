import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../cover_picture.dart';
import '../image_import.dart';
import '../move_to_catalog.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../name_date_dialog.dart';
import '../flier_capture.dart';
import '../share_import.dart';
import '../spotlight.dart';
import '../video_frames_io.dart';
import 'match_candidates_screen.dart';
import '../stray_cam.dart';
import '../widgets/add_fan.dart';
import 'cat_detail_screen.dart';
import 'cat_list_screen.dart';

/// Cats currently in no Clowder: the shared cat list (#87) with the
/// strays' own tools — flier capture, stray cam, match candidates,
/// moving several at once.
class StraysScreen extends StatelessWidget {
  final CatalogStore store;

  const StraysScreen({super.key, required this.store});

  /// Several strays at once: eight of forty must not cost eight moves.
  Future<void> _moveSelection(
    BuildContext context,
    VoidCallback refresh,
  ) async {
    final chosen = await pickWhatToMove(context, store, clowders: false);
    if (chosen == null || !context.mounted) return;
    await moveToAnotherCatalog(context, store, chosen);
    refresh();
  }

  Future<void> _addStray(BuildContext context, VoidCallback refresh) async {
    final catId = await createAnimal(context, store, title: context.t.newStray);
    if (catId == null || !context.mounted) return;
    refresh();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CatDetailScreen(
          store: store,
          catId: catId,
          promptPhoto: true,
          startEditing: true,
        ),
      ),
    );
    refresh();
  }

  /// The flier wizard from a poster photographed now or brought from
  /// the gallery; the new cat's page after it.
  Future<void> _captureFlier(
    BuildContext context,
    VoidCallback refresh,
    ImageSource source,
  ) async {
    final catId = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => FlierCaptureScreen(store: store, source: source),
      ),
    );
    if (!context.mounted) return;
    await _openNew(context, catId, refresh);
  }

  /// A stray from a picture taken now or one from the gallery, at the
  /// current position; its page opens in edit mode.
  Future<void> _strayFrom(
    BuildContext context,
    VoidCallback refresh,
    ImageSource source,
  ) async {
    final catId = await strayCam(context, store, source: source);
    if (!context.mounted) return;
    await _openNew(context, catId, refresh, startEditing: true);
  }

  Future<void> _openNew(
    BuildContext context,
    String? catId,
    VoidCallback refresh, {
    bool startEditing = false,
  }) async {
    // A fresh capture opens its page in edit mode: species and Looks
    // are fields there, nothing asks in the way.
    if (catId != null && context.mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CatDetailScreen(
            store: store,
            catId: catId,
            startEditing: startEditing,
          ),
        ),
      );
    }
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return CatListScreen(
      store: store,
      title: context.t.strays,
      source: (s) => s.visibleStrays(),
      emptyText: context.t.noStraysRightNow,
      helpScreenId: 'strays',
      spotlightScreenId: 'strays',
      // The strays' own picture leads, camera and gallery on the row.
      header: (context, refresh) => CoverBanner(
        store: store,
        entityId: straysEntity,
        title: context.t.coverLabelStrays,
        onChanged: refresh,
      ),
      actions: (context, refresh) => [
        Spotlight(
          id: 'strays-scan',
          child: IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: context.t.scanShareLabel,
            onPressed: () async {
              await scanShareCode(context, store);
              refresh();
            },
          ),
        ),
        if (canMoveBetweenCatalogs)
          IconButton(
            icon: const Icon(Icons.drive_file_move_outline),
            tooltip: context.t.moveToCatalog,
            onPressed: () => _moveSelection(context, refresh),
          ),
        IconButton(
          icon: const Icon(Icons.join_inner),
          tooltip: context.t.matchCandidatesTitle,
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MatchCandidatesScreen(store: store),
              ),
            );
            refresh();
          },
        ),
      ],
      // The one plus: every way a stray comes in fans out of it.
      floatingActionButton: (context, refresh) => Spotlight(
        id: 'strays-flier',
        child: AddFan(
          tooltip: context.t.addStray,
          items: [
            FanItem(
              icon: Icons.add,
              label: context.t.addStray,
              onTap: () => _addStray(context, refresh),
            ),
            FanItem(
              icon: Icons.photo_camera,
              label: context.t.takePhoto,
              onTap: () => _strayFrom(context, refresh, ImageSource.camera),
            ),
            FanItem(
              icon: Icons.photo_library,
              label: context.t.chooseFromGallery,
              onTap: () => _strayFrom(context, refresh, ImageSource.gallery),
            ),
            FanItem(
              icon: Icons.movie_outlined,
              label: context.t.fromVideo,
              onTap: () async {
                final catId = await strayCamVideo(context, store);
                if (!context.mounted) return;
                await _openNew(context, catId, refresh, startEditing: true);
              },
            ),
            FanItem(
              icon: Icons.assignment_outlined,
              label: context.t.flierFromCamera,
              onTap: () =>
                  _captureFlier(context, refresh, cameraIfThereIsOne),
            ),
            FanItem(
              icon: Icons.assignment_outlined,
              label: context.t.flierFromGallery,
              onTap: () =>
                  _captureFlier(context, refresh, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
