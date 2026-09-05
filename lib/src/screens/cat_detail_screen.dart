import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../move_to_catalog.dart';
import '../layout.dart';
import '../help.dart';
import '../celebration.dart';
import '../conflict_dialog.dart';
import '../field_editing.dart';
import '../registry_lookup.dart';
import '../flier_capture.dart';
import '../image_import.dart';
import '../hidden.dart';
import '../image_provider_cache.dart';
import '../plausibility.dart';
import '../share_publicly.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../name_date_dialog.dart';
import '../new_field_dialog.dart';
import '../spotlight.dart';
import '../stray_cam.dart';
import '../widgets/cat_avatar.dart';
import '../reminders/mirror_hook.dart';
import '../reminders/plan_chooser.dart';
import '../widgets/cat_ear.dart';
import '../widgets/field_list.dart';
import '../widgets/appointment_card.dart';
import '../widgets/reminder_card.dart';
import 'card_screen.dart';
import 'photo_edit_screen.dart';
import 'map_screen.dart';
import 'photo_viewer_screen.dart';
import 'timeline_screen.dart';
import 'field_graph_screen.dart';
import 'field_history_screen.dart';

/// One Cat: membership, Fields, photo gallery, timeline access.
class CatDetailScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  /// Opens the photo picker right away — used when a Cat was just created,
  /// so name + photo happen in one flow.
  final bool promptPhoto;

  /// Fresh cats open in edit mode: they exist to be filled in (#46).
  final bool startEditing;

  const CatDetailScreen({
    super.key,
    required this.store,
    required this.catId,
    this.promptPhoto = false,
    this.startEditing = false,
  });

  @override
  State<CatDetailScreen> createState() => _CatDetailScreenState();
}

// Sentinel for "no clowder" in the move dialog, where null means canceled.
const _strayMarker = '\$stray';

class _CatDetailScreenState extends State<CatDetailScreen> {
  CatalogStore get store => widget.store;
  String get id => widget.catId;

  /// Read-only until the pencil is pressed (#46); every visit starts
  /// calm — except a freshly created cat, which opens ready to fill in.
  late bool _editing = widget.startEditing;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => runSpotlights(context, store, 'cat'),
    );
    if (widget.promptPhoto) {
      // The callback can fire after a quick back-out; a dead screen
      // must not open a picker it can never return to.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _addPhoto();
      });
    }
  }

  Future<void> _rename() async {
    final current = store.current(id, Keys.name) ?? '';
    final name = await _askForText(context, context.t.renameCat, current);
    if (name == null || name.isEmpty || name == current) return;
    store.append(id, Keys.name, name);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _addPhoto() async {
    // Refresh unconditionally: even a canceled or half-failed add must
    // leave the grid showing exactly what the store holds.
    await addPhotosViaSheet(context, store, id);
    if (mounted) setState(() {});
  }

  Future<void> _move() async {
    final currentClowder = store.current(id, Keys.clowder);
    final clowders = store.clowders();
    final target = await showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.t.moveTo),
        children: [
          for (final c in clowders)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(c.id),
              child: Row(
                children: [
                  if (c.id == currentClowder)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.check, size: 18),
                    ),
                  Expanded(child: Text(c.name)),
                ],
              ),
            ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(_strayMarker),
            child: Row(
              children: [
                const Icon(Icons.explore, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(context.t.noClowderStrayOption)),
              ],
            ),
          ),
        ],
      ),
    );
    if (target == null) return; // dialog dismissed
    final destination = target == _strayMarker ? null : target;
    if (destination == currentClowder) return;
    if (!mounted) return;
    // Historic moves happen: the date is askable, defaulting to today.
    final asOf = await askAsOfDate(context, context.t.moveTo);
    if (asOf == null) return;
    store.moveCat(id, destination, date: asOf);
    if (!mounted) return;
    setState(() {});
    if (mounted) maybeCelebrateAdoption(context, store, destination);
  }

  Future<void> _editField(FieldDef def) async {
    final edit = await editFieldValue(
      context,
      def,
      store.current(id, def.key),
      store: store,
      excludeId: id,
    );
    if (edit == null || !mounted) return;
    final objection = starterFieldObjection(store, id, def, edit.value);
    if (objection != null) {
      await explainObjection(context, objection);
      return;
    }
    store.append(id, def.key, edit.value, date: edit.date);
    if (def.slug == 'breed') store.learnBreed(id, edit.value);
    if (edit.private != store.isFieldPrivate(id, def.key)) {
      store.setFieldPrivate(id, def.key, edit.private);
    }
    if (!mounted) return;
    setState(() {});
  }

  void _showOnMap(String value) {
    final pos = CatalogStore.parsePosition(value);
    if (pos == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MapScreen(
          store: store,
          initialCenter: LatLng(pos.$1, pos.$2),
          // The spot the page asked for gets a pin, whatever the map's
          // own rules say (#88).
          focus: (id, LatLng(pos.$1, pos.$2)),
        ),
      ),
    );
  }

  Future<void> _addReminder() async {
    if (await showPlanChooser(context, store, entityId: id) && mounted) {
      _plansChanged();
    }
  }

  Future<void> _openEntity(String entityId) async {
    if (entityId == id) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CatDetailScreen(store: store, catId: entityId),
      ),
    );
    if (mounted) setState(() {});
  }

  void _plansChanged() {
    setState(() {});
    mirrorAfterChange(context, store);
  }

  /// The cat's live plans, as the agenda shows them — nothing vanishes
  /// into the agenda alone, and a field without a fact can carry one.
  List<Widget> _plannedSection() {
    final plans = [
      for (final r in store.activeReminders())
        if (r.entity == store.resolveEntity(id)) r,
    ];
    final appointments = store.appointmentsOf(id);
    if (plans.isEmpty && appointments.isEmpty) return const [];
    return [
      const Divider(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          context.t.plannedSection,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      // A vet run shows its other cats as chips; delete here takes only
      // this entity out of it.
      for (final a in appointments)
        AppointmentCard(
          store: store,
          appointment: a,
          members: store.groupOf(a),
          showEntity: false,
          onChanged: _plansChanged,
          onOpenEntity: _openEntity,
        ),
      for (final r in plans)
        ReminderCard(
          store: store,
          reminder: r,
          showEntity: false,
          onChanged: _plansChanged,
        ),
    ];
  }

  Future<void> _openTimeline({String? field}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            TimelineScreen(store: store, entityId: id, field: field),
      ),
    );
    // Reverts happen on the timeline — the page must show them.
    if (mounted) setState(() {});
  }

  void _imageMenu(String hash) {
    final isProfile = store.profileImage(id) == hash;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.star),
              title: Text(
                isProfile
                    ? context.t.thisIsProfileImage
                    : context.t.setAsProfileImage,
              ),
              enabled: !isProfile,
              onTap: () {
                store.setProfileImage(id, hash);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.crop),
              title: Text(context.t.cropPhoto),
              onTap: () {
                Navigator.of(context).pop();
                _editPhoto(hash, PhotoEditMode.crop);
              },
            ),
            ListTile(
              leading: const Icon(Icons.circle_outlined),
              title: Text(context.t.markPhoto),
              onTap: () {
                Navigator.of(context).pop();
                _editPhoto(hash, PhotoEditMode.mark);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: Text(context.t.deletePhoto),
              onTap: () async {
                Navigator.of(context).pop();
                final sure = await _confirm(
                  context,
                  context.t.deletePhotoTitle,
                  context.t.deletePhotoBody,
                );
                if (sure && mounted) {
                  store.deleteImage(id, hash);
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Crop or mark an existing photo: the edited copy joins as a NEW
  /// photo; the original stays (one litter photo can serve many cats).
  Future<void> _editPhoto(String hash, PhotoEditMode mode) async {
    final bytes = store.imageBytes(hash);
    if (bytes == null) return;
    final edited = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => PhotoEditScreen(bytes: bytes, mode: mode),
      ),
    );
    if (edited == null) return;
    await addCompressedImage(store, id, edited);
    if (!mounted) return;
    setState(() {});
  }

  /// The cat leaves this catalog for another one — so the page it was
  /// on has nothing left to show.
  Future<void> _moveToCatalog() async {
    final moved = await moveToAnotherCatalog(context, store, {id});
    if (moved != null && mounted) Navigator.of(context).pop();
  }

  Future<void> _deleteCat() async {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final sure = await _confirm(
      context,
      context.t.deleteQuestion(name),
      context.t.deleteCatBody,
    );
    if (!sure || !mounted) return;
    store.deleteCat(id);
    Navigator.of(context).pop();
  }

  /// "Add flier" on an existing missing cat: appends flier positions,
  /// IDs, and remarks from another flier of the same cat (#32).
  Future<void> _addFlier() async {
    await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => FlierCaptureScreen(store: store, existingCatId: id),
      ),
    );
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _seenHere() async {
    final failure = await seenHereNow(store, id);
    if (!mounted) return;
    if (failure != null) {
      await explainLocationFailure(context, failure);
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.t.sightingRecorded)));
    setState(() {});
  }

  Future<void> _mergeCat() async {
    final merged = await showMergeDialog(
      context: context,
      store: store,
      loserId: id,
      kindLabel: context.t.kindCat,
      candidates: store.cats(),
      merge: store.mergeCat,
    );
    if (merged && mounted) Navigator.of(context).pop();
  }

  bool _hasFamily() {
    final f = store.family(id);
    return f.mother != null ||
        f.father != null ||
        f.littermates.isNotEmpty ||
        f.siblings.isNotEmpty ||
        f.kittens.isNotEmpty;
  }

  Widget _familyRow(String label, List<String> catIds) => ListTile(
    dense: true,
    title: Text(label),
    subtitle: Wrap(
      spacing: 8,
      children: [
        for (final catId in catIds)
          ActionChip(
            avatar: CatAvatar(store: store, catId: catId, size: 24),
            label: Text(store.current(catId, Keys.name) ?? '?'),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CatDetailScreen(store: store, catId: catId),
                ),
              );
              if (mounted) setState(() {});
            },
          ),
      ],
    ),
  );

  List<Widget> _familyRows() {
    final f = store.family(id);
    return [
      if (f.mother != null) _familyRow(context.t.starterMother, [f.mother!]),
      if (f.father != null) _familyRow(context.t.starterFather, [f.father!]),
      if (f.littermates.isNotEmpty)
        _familyRow(context.t.littermatesLabel, f.littermates),
      if (f.siblings.isNotEmpty)
        _familyRow(context.t.siblingsLabel, f.siblings),
      if (f.kittens.isNotEmpty) _familyRow(context.t.kittensLabel, f.kittens),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final images = store.images(id);
    final profile = store.profileImage(id);
    final defs = store.visibleFieldDefs(scope: FieldScope.cat);
    final clowderId = store.current(id, Keys.clowder);
    return PopScope(
      // Back leaves edit mode before it leaves the page.
      canPop: !_editing,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _editing = false);
      },
      child: Scaffold(
        appBar: roomyAppBar(
          context,
          // Renaming lives in edit mode: the title becomes tappable there.
          title: _editing
              ? InkWell(onTap: _rename, child: Text(name))
              : Text(name),
          actions: [
            HelpButton(store: store, screenId: 'cat'),
            IconButton(
              icon: const Icon(Icons.badge_outlined),
              tooltip: context.t.card,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CardScreen(store: store, catId: id),
                ),
              ),
            ),
            Spotlight(
              id: 'cat-reminder',
              child: IconButton(
                icon: const Icon(Icons.alarm_add),
                tooltip: context.t.addReminder,
                onPressed: _addReminder,
              ),
            ),
            Spotlight(
              id: 'cat-edit',
              child: IconButton(
                icon: Icon(_editing ? Icons.check : Icons.edit),
                tooltip: _editing ? context.t.doneLabel : context.t.editLabel,
                onPressed: () => setState(() => _editing = !_editing),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: context.t.timeline,
              onPressed: _openTimeline,
            ),
            Spotlight(
              id: 'cat-menu',
              child: PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'delete') _deleteCat();
                  if (v == 'moveCatalog') _moveToCatalog();
                  if (v == 'merge') _mergeCat();
                  if (v == 'seen') _seenHere();
                  if (v == 'flier') _addFlier();
                  if (v == 'share') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            SharePubliclyScreen(store: store, catId: id),
                      ),
                    );
                  }
                  if (v == 'hide') {
                    final wasHidden = store.isHidden(id);
                    store.setHidden(id, !wasHidden);
                    if (wasHidden || showHidden.value) {
                      setState(() {});
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                itemBuilder: (context) => [
                  if (canMoveBetweenCatalogs)
                    PopupMenuItem(
                      value: 'moveCatalog',
                      child: Text(context.t.moveToCatalog),
                    ),
                  PopupMenuItem(
                    value: 'seen',
                    child: Text(context.t.seenHereNow),
                  ),
                  PopupMenuItem(
                    value: 'flier',
                    child: Text(context.t.addFlier),
                  ),
                  PopupMenuItem(
                    value: 'share',
                    child: Text(context.t.sharePublicly),
                  ),
                  PopupMenuItem(
                    value: 'hide',
                    child: Text(
                      store.isHidden(id)
                          ? context.t.unhideLabel
                          : context.t.hideLabel,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'merge',
                    child: Text(context.t.mergeInto),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(context.t.deleteCat),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            if (isDeceased(store, id))
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Chip(
                    label: Text(
                      '${context.t.starterDeceased} · ${store.current(id, 'f:deceased')}',
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
            WithCatEar(
              child: ListTile(
                leading: Icon(clowderId == null ? Icons.explore : Icons.home),
                title: Text(context.t.clowderLabel),
                subtitle: Text(
                  clowderId == null
                      ? context.t.strayNoClowder
                      : store.current(clowderId, Keys.name) ??
                            context.t.unnamed,
                ),
                trailing: _editing
                    ? const Icon(Icons.drive_file_move_outline)
                    : null,
                onTap: _editing ? _move : null,
                onLongPress: () => _openTimeline(field: Keys.clowder),
              ),
            ),
            const Divider(),
            FieldList(
              store: store,
              entityId: id,
              defs: defs,
              editing: _editing,
              onEdit: _editField,
              onConflict: (def) async {
                await showConflictDialog(context, store, id, def.key);
                if (!mounted) return;
                setState(() {});
              },
              onHistory: (def) => _openTimeline(field: def.key),
              onShowMap: _showOnMap,
              onLookup: (def, value) => openLookup(context, def, value),
      onGraph: (def) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            FieldGraphScreen(store: store, entityId: id, def: def),
      )),
      onValueHistory: (def) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            FieldHistoryScreen(store: store, entityId: id, def: def),
      )),
              // Long-press in read mode: jump into edit mode with the
              // field's editor open — fix what you just spotted (#46).
              onReadLongPress: (def) {
                setState(() => _editing = true);
                _editField(def);
              },
              onAddField: () async {
                final created = await showNewFieldDialog(
                  context,
                  store,
                  initialScope: FieldScope.cat,
                );
                if (created && mounted) setState(() {});
              },
            ),
            ..._plannedSection(),
            if (_hasFamily()) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  context.t.familySection,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ..._familyRows(),
            ],
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                context.t.photos,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: images.length,
              itemBuilder: (context, i) {
                final hash = images[i];
                final photo = imageProviderFor(store, hash);
                // Tap = quick action (view full-size), long-press = menu —
                // the app-wide gesture convention.
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PhotoViewerScreen(
                        store: store,
                        hashes: images,
                        initialIndex: i,
                        name: store.current(id, Keys.name) ?? 'cat',
                      ),
                    ),
                  ),
                  onLongPress: () => _imageMenu(hash),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (photo != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          // Decode at grid-tile size, not full resolution.
                          child: Image(
                            image: ResizeImage(photo, width: 480),
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (hash == profile)
                        const Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.star, color: Colors.amber),
                          ),
                        ),
                      // Top start, because the profile star owns the end.
                      const PositionedDirectional(
                        top: 0,
                        start: 0,
                        child: CatEarBadge(atStart: true),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addPhoto,
          tooltip: context.t.addPhoto,
          child: const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}

Future<bool> _confirm(
  BuildContext context,
  String title,
  String message,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.t.delete),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<String?> _askForText(
  BuildContext context,
  String title,
  String? initial,
) {
  final controller = TextEditingController(text: initial ?? '');
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(context.t.save),
        ),
      ],
    ),
  );
}
