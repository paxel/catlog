import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

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
import '../widgets/cat_ear.dart';
import 'cat_detail_screen.dart';
import 'cat_list_screen.dart';
import '../exclusive.dart';

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

  Future<void> _openNew(
    BuildContext context,
    String? catId,
    VoidCallback refresh, {
    bool startEditing = false,
  }) async {
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
      floatingActionButton: (context, refresh) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spotlight(
            id: 'strays-flier',
            child: FloatingActionButton.extended(
              heroTag: 'flier',
              onPressed: () async {
                final catId = await Navigator.of(context).push<String>(
                  MaterialPageRoute(
                    builder: (_) => FlierCaptureScreen(store: store),
                  ),
                );
                if (!context.mounted) return;
                await _openNew(context, catId, refresh);
              },
              icon: const Icon(Icons.assignment_outlined),
              label: Text(context.t.captureFlier),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onLongPress: () async {
              final catId = await strayCamVideo(context, store);
              if (!context.mounted) return;
              await _openNew(context, catId, refresh, startEditing: true);
            },
            child: WithCatEar(
              child: FloatingActionButton.extended(
                heroTag: 'strayCam',
                onPressed: () async {
                  final catId = await strayCam(context, store);
                  if (!context.mounted) return;
                  await _openNew(context, catId, refresh, startEditing: true);
                },
                icon: const BusyIcon(
                  keys: {'strayCam', 'imagePicker'},
                  icon: Icons.photo_camera,
                ),
                label: Text(context.t.strayCam),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'addStray',
            onPressed: () => _addStray(context, refresh),
            icon: const Icon(Icons.add),
            label: Text(context.t.addStray),
          ),
        ],
      ),
    );
  }
}
