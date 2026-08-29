import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../move_to_catalog.dart';
import '../layout.dart';
import '../help.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../name_date_dialog.dart';
import '../name_proposals.dart';
import '../flier_capture.dart';
import '../share_import.dart';
import '../spotlight.dart';
import '../video_frames_io.dart';
import 'match_candidates_screen.dart';
import '../field_labels.dart';
import '../stray_cam.dart';
import '../widgets/cat_avatar.dart';
import '../widgets/cat_ear.dart';
import 'cat_detail_screen.dart';
import '../age.dart';

/// Cats currently in no Clowder. The map view arrives with milestone M3;
/// until then this list keeps Strays visible.
class StraysScreen extends StatefulWidget {
  final CatalogStore store;

  const StraysScreen({super.key, required this.store});

  @override
  State<StraysScreen> createState() => _StraysScreenState();
}

enum _StraySort { name, gender, color }

class _StraysScreenState extends State<StraysScreen> {
  _StraySort _sort = _StraySort.name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => runSpotlights(context, widget.store, 'strays'));
  }

  /// Several strays at once: eight of forty must not cost eight moves.
  Future<void> _moveSelection() async {
    final chosen = await pickWhatToMove(context, widget.store,
        clowders: false);
    if (chosen == null || !mounted) return;
    await moveToAnotherCatalog(context, widget.store, chosen);
    if (mounted) setState(() {});
  }

  String _field(String catId, String slug) =>
      widget.store.current(catId, Keys.userField(slug)) ?? '';

  /// Gender and color under the name — the details one scans a stray
  /// list for (#52).
  String _subtitle(BuildContext context, String catId) {
    final t = context.t;
    final defs = widget.store.fieldDefs();
    String display(String slug) {
      final value = _field(catId, slug);
      if (value.isEmpty) return '';
      final def = defs.where((d) => d.slug == slug).firstOrNull;
      return fieldValueDisplay(t, def, value);
    }

    return [
      ageDisplay(t, widget.store, catId) ?? '',
      display('gender'),
      display('color'),
    ].where((s) => s.isNotEmpty).join(' · ');
  }

  Future<void> _addStray() async {
    final locale = Localizations.localeOf(context);
    final result = await askNameAndDate(context, context.t.newStray,
        propose: () => proposeCatName(widget.store, locale));
    if (result == null || !mounted) return;
    final catId = widget.store.createCat(result.name, date: result.date);
    setState(() {});
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CatDetailScreen(
          store: widget.store,
          catId: catId,
          promptPhoto: true,
          startEditing: true),
    ));
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final strays = widget.store.visibleStrays()
      ..sort((a, b) => switch (_sort) {
            _StraySort.name => a.name
                .toLowerCase()
                .compareTo(b.name.toLowerCase()),
            _StraySort.gender => _field(a.id, 'gender')
                .compareTo(_field(b.id, 'gender')),
            _StraySort.color =>
              _field(a.id, 'color').compareTo(_field(b.id, 'color')),
          });
    return Scaffold(
      appBar: roomyAppBar(context,
          title: Text(context.t.strays),
          actions: [
        HelpButton(store: widget.store, screenId: 'strays'),
        Spotlight(
          id: 'strays-scan',
          child: IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: context.t.scanShareLabel,
            onPressed: () async {
              await scanShareCode(context, widget.store);
              if (!mounted) return;
              setState(() {});
            },
          ),
        ),
        PopupMenuButton<_StraySort>(
          icon: const Icon(Icons.sort),
          tooltip: context.t.sortLabel,
          onSelected: (s) => setState(() => _sort = s),
          itemBuilder: (context) => [
            PopupMenuItem(
                value: _StraySort.name, child: Text(context.t.name)),
            PopupMenuItem(
                value: _StraySort.gender,
                child: Text(context.t.starterGender)),
            PopupMenuItem(
                value: _StraySort.color,
                child: Text(context.t.starterColor)),
          ],
        ),
        if (canMoveBetweenCatalogs)
          IconButton(
            icon: const Icon(Icons.drive_file_move_outline),
            tooltip: context.t.moveToCatalog,
            onPressed: _moveSelection,
          ),
        IconButton(
          icon: const Icon(Icons.join_inner),
          tooltip: context.t.matchCandidatesTitle,
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  MatchCandidatesScreen(store: widget.store),
            ));
            if (!mounted) return;
            setState(() {});
          },
        ),
      ]),
      floatingActionButton:
          Column(mainAxisSize: MainAxisSize.min, children: [
        Spotlight(
          id: 'strays-flier',
          child: FloatingActionButton.extended(
          heroTag: 'flier',
          onPressed: () async {
            final catId = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                    builder: (_) =>
                        FlierCaptureScreen(store: widget.store)));
            if (catId != null && context.mounted) {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CatDetailScreen(
                    store: widget.store, catId: catId),
              ));
            }
            if (!mounted) return;
            setState(() {});
          },
          icon: const Icon(Icons.assignment_outlined),
          label: Text(context.t.captureFlier),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onLongPress: () async {
            final catId = await strayCamVideo(context, widget.store);
            if (catId != null && context.mounted) {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CatDetailScreen(
                    store: widget.store,
                    catId: catId,
                    startEditing: true),
              ));
            }
            if (!mounted) return;
            setState(() {});
          },
          child: WithCatEar(
              child: FloatingActionButton.extended(
          heroTag: 'strayCam',
          onPressed: () async {
            final catId = await strayCam(context, widget.store);
            if (catId != null && context.mounted) {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CatDetailScreen(
                    store: widget.store,
                    catId: catId,
                    startEditing: true),
              ));
            }
            if (!mounted) return;
            setState(() {});
          },
          icon: const Icon(Icons.photo_camera),
          label: Text(context.t.strayCam),
          )),
        ),
        const SizedBox(height: 12),
        FloatingActionButton.extended(
          heroTag: 'addStray',
          onPressed: _addStray,
          icon: const Icon(Icons.add),
          label: Text(context.t.addStray),
        ),
      ]),
      body: strays.isEmpty
          ? Center(child: Text(context.t.noStraysRightNow))
          : ListView.builder(
              // Two floating buttons stack here; the last row scrolls
              // clear of both.
              padding: const EdgeInsets.only(bottom: 144),
              itemCount: strays.length,
              itemBuilder: (context, i) {
                final cat = strays[i];
                final details = _subtitle(context, cat.id);
                return ListTile(
                  leading: CatAvatar(
                      store: widget.store, catId: cat.id, size: 40),
                  title: Text(cat.name),
                  subtitle: details.isEmpty ? null : Text(details),
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CatDetailScreen(
                          store: widget.store, catId: cat.id),
                    ));
                    if (!mounted) return;
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}
