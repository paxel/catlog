import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../move_to_catalog.dart';
import '../layout.dart';
import '../help.dart';
import '../celebration.dart';
import '../field_editing.dart';
import '../widgets/date_entry.dart';
import '../registry_lookup.dart';
import '../flier_capture.dart';
import '../image_import.dart';
import '../hidden.dart';
import '../image_provider_cache.dart';
import '../plausibility.dart';
import '../share_publicly.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../new_field_dialog.dart';
import '../spotlight.dart';
import '../stray_cam.dart';
import '../widgets/cat_avatar.dart';
import '../widgets/missing_photo.dart';
import '../reminders/mirror_hook.dart';
import '../reminders/appointment_dialog.dart';
import '../reminders/reminder_dialog.dart';
import '../chores/chore_dialog.dart';
import '../widgets/add_fan.dart';
import '../reminders/plan_entity.dart';
import '../widgets/cat_ear.dart';
import '../widgets/field_list.dart';
import '../widgets/appointment_card.dart';
import '../widgets/reminder_card.dart';
import 'card_screen.dart';
import 'conflicts_screen.dart';
import 'photo_edit_screen.dart';
import 'map_screen.dart';
import 'photo_viewer_screen.dart';
import 'timeline_screen.dart';
import 'missing_poster_screen.dart';
import 'vet_report_screen.dart';
import 'field_graph_screen.dart';
import 'field_history_screen.dart';
import '../widgets/chore_row.dart';
import '../chores/chore_feedback.dart';
import '../widgets/fold_section.dart';
import '../chores/chore_reminders.dart';

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

class _CatDetailScreenState extends State<CatDetailScreen> {
  CatalogStore get store => widget.store;
  String get id => widget.catId;

  /// Read-only until the pencil is pressed (#46); every visit starts
  /// calm — except a freshly created cat, which opens ready to fill in.
  late bool _editing = widget.startEditing;

  @override
  void initState() {
    super.initState();
    // The agenda's plans start with the page looked at last.
    rememberViewed(store, id);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => runSpotlights(context, store, 'cat'),
    );
  }

  Future<void> _rename() async {
    final current = store.current(id, Keys.name) ?? '';
    final name = await _askForText(context, context.t.renameCat, current);
    if (name == null || name.isEmpty || name == current) return;
    store.append(id, Keys.name, name);
    if (!mounted) return;
    setState(() {});
  }

  /// Frames from a video landing one by one: (done, total) while it
  /// runs, null otherwise.
  (int, int)? _adding;

  /// A photo from the camera or the gallery. Refresh unconditionally:
  /// even a canceled or half-failed add must leave the grid showing
  /// exactly what the store holds.
  Future<void> _addPhotoFrom(ImageSource source) async {
    await addPhotoFrom(context, store, id, source);
    if (mounted) setState(() {});
  }

  Future<void> _addFromVideo() async {
    await addPhotosFromVideo(context, store, id, onProgress: (done, total) {
      if (!mounted) return;
      setState(() => _adding = done < total ? (done, total) : null);
    });
    if (mounted) setState(() => _adding = null);
  }

  /// One dialog: the homes and "stray", a tap moves at once; the date
  /// row at the foot is for the rare historic move, today otherwise.
  Future<void> _move() async {
    final currentClowder = store.current(id, Keys.clowder);
    final picked = await showDialog<(String?, DateTime)>(
      context: context,
      builder: (context) => _MoveDialog(
        clowders: store.clowders(),
        current: currentClowder,
      ),
    );
    if (picked == null || !mounted) return; // dialog dismissed
    final (destination, asOf) = picked;
    if (destination == currentClowder) return;
    store.moveCat(id, destination, date: asOf);
    setState(() {});
    maybeCelebrateAdoption(context, store, destination);
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

  void _showOnMap(FieldDef def, String value) {
    final pos = CatalogStore.parsePosition(value);
    if (pos == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MapScreen(
          store: store,
          initialCenter: LatLng(pos.$1, pos.$2),
          // The spot the page asked for gets a pin, whatever the map's
          // own rules say (#88) — and its trail, once there is one.
          focus: (id, LatLng(pos.$1, pos.$2)),
          trailOf: hasValueHistory(store, id, def.key) ? (id, def.key) : null,
        ),
      ),
    );
  }

  /// The three kinds of plan, each straight into its editor with this
  /// cat as the For field.
  Future<void> _addAppointment() async {
    final saved = await showAppointmentDialog(context, store, entityId: id);
    if (saved != null && mounted) _plansChanged();
  }

  Future<void> _addReminder() async {
    if (await showAddReminder(context, store, entityId: id) && mounted) {
      _plansChanged();
    }
  }

  Future<void> _addChore() async {
    final saved = await showChoreDialog(context, store, entityId: id);
    if (saved != null && mounted) _plansChanged();
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
    // A tick here earns the same cheer as one on the agenda.
    afterChoreTick(context, store, manager: catalogManager);
    setState(() {});
    mirrorAfterChange(context, store);
    refreshChoreReminders(store,
        body: (c) => store.current(c.entity, Keys.name) ?? context.t.unnamed);
  }

  /// The cat's live plans, as the agenda shows them — nothing vanishes
  /// into the agenda alone, and a field without a fact can carry one.
  List<Widget> _plannedSection() {
    final plans = [
      for (final r in store.activeReminders())
        if (r.entity == store.resolveEntity(id)) r,
    ];
    final appointments = store.appointmentsOf(id);
    final chores = partitionChores(
        store, store.choresOf(id), DateUtils.dateOnly(DateTime.now()));
    final laterCount = chores.later.length + chores.paused.length;
    if (plans.isEmpty &&
        appointments.isEmpty &&
        chores.due.isEmpty &&
        laterCount == 0) {
      return const [];
    }
    final today = DateUtils.dateOnly(DateTime.now());
    return [
      const Divider(),
      Spotlight(
        id: 'cat-chores',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            context.t.plannedSection,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      // Its chores: today's occurrence while the chore is due today,
      // ticked or not — a tick must not turn the row into tomorrow's;
      // otherwise the next due day.
      // Its chores due today, ticked or not; the rest, and the paused
      // ones, wait behind a fold like the agenda's Coming up.
      for (final c in chores.due)
        ChoreRow(
          store: store,
          chore: c,
          due: today,
          today: today,
          showEntity: false,
          onChanged: _plansChanged,
        ),
      if (laterCount > 0)
        FoldSection(
          store: store,
          id: 'page-upcoming',
          title: context.t.upcomingSection,
          count: laterCount,
          children: [
            for (final c in chores.later)
              ChoreRow(
              store: store,
              chore: c,
              due: nextDue(c, store.choreTicks(c), today) ?? today,
              today: today,
              showEntity: false,
              onChanged: _plansChanged,
            ),
            for (final c in chores.paused)
              ChoreRow(
              store: store,
              chore: c,
              due: today,
              today: today,
              showEntity: false,
              onChanged: _plansChanged,
            ),
          ],
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

  /// The menu behind a photo, at the finger: profile, crop, mark,
  /// delete.
  Future<void> _imageMenu(String hash, Offset at) async {
    final t = context.t;
    final isProfile = store.profileImage(id) == hash;
    final action = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(at.dx, at.dy, at.dx, at.dy),
      items: [
        PopupMenuItem(
          value: 'profile',
          enabled: !isProfile,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.star),
            title: Text(
              isProfile ? t.thisIsProfileImage : t.setAsProfileImage,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'crop',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.crop),
            title: Text(t.cropPhoto),
          ),
        ),
        PopupMenuItem(
          value: 'mark',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.circle_outlined),
            title: Text(t.markPhoto),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.delete_outline),
            title: Text(t.deletePhoto),
          ),
        ),
      ],
    );
    if (action == null || !mounted) return;
    switch (action) {
      case 'profile':
        store.setProfileImage(id, hash);
        setState(() {});
      case 'crop':
        await _editPhoto(hash, PhotoEditMode.crop);
      case 'mark':
        await _editPhoto(hash, PhotoEditMode.mark);
      case 'delete':
        final sure = await _confirm(
          context,
          t.deletePhotoTitle,
          t.deletePhotoBody,
        );
        if (sure && mounted) {
          store.deleteImage(id, hash);
          setState(() {});
        }
    }
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
    paw(context);
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
    final photosBlock = <Widget>[
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
                // Tap = quick action (view full-size), long-press = menu
                // at the finger — the app-wide gesture convention.
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
                  onLongPressStart: (d) => _imageMenu(hash, d.globalPosition),
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
                        )
                      else
                        // The entry is here, the bytes are not (a sync
                        // that never fetched them): say so instead of
                        // leaving a hole with a badge on it.
                        MissingPhoto(),
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
    ];
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
              id: 'cat-report',
              child: IconButton(
                icon: const Icon(Icons.medical_information_outlined),
                tooltip: context.t.vetReportMenu,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => VetReportScreen(store: store, catId: id),
                )),
              ),
            ),
            Spotlight(
              id: 'cat-poster',
              child: IconButton(
                icon: const Icon(Icons.campaign_outlined),
                tooltip: context.t.posterMenu,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MissingPosterScreen(store: store, catId: id),
                )),
              ),
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
            // Read mode: the photos first, then what is due, then the rest;
            // edit mode keeps the fields on top and the photos last.
            if (!_editing) ...[
              ...photosBlock,
              ..._plannedSection(),
            ],
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
              // The badge leads to the conflicts page, where the two
              // values are buttons on the row.
              onConflict: (_) async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => ConflictsScreen(store: store)),
                );
                if (mounted) setState(() {});
              },
              // A correction or removal there shows here on return.
              onHistory: (def) async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      FieldHistoryScreen(store: store, entityId: id, def: def),
                ));
                if (mounted) setState(() {});
              },
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
              // Long-press in read mode: this one field's editor, the page
              // stays as it is — fix what you just spotted (#46), nothing more.
              onReadLongPress: _editField,
              onAddField: () async {
                final created = await showNewFieldDialog(
                  context,
                  store,
                  initialScope: FieldScope.cat,
                );
                if (created && mounted) setState(() {});
              },
            ),
            if (_editing) ..._plannedSection(),
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
            if (_editing) ...[
              const Divider(),
              ...photosBlock,
            ],
            if (_adding case (final done, final total))
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(children: [
                  Text(context.t.addingPhotos(done + 1, total)),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(value: done / total),
                ]),
              ),
            const SizedBox(height: 80),
          ],
        ),
        // The one plus: photos three ways, plans three kinds. A fresh
        // cat opens with it fanned out, its first photo one tap away.
        floatingActionButton: Spotlight(
          id: 'cat-reminder',
          child: AddFan(
            tooltip: context.t.addPhoto,
            openAtStart: widget.promptPhoto,
            items: [
              if (hasCamera)
                FanItem(
                  icon: Icons.photo_camera,
                  label: context.t.takePhoto,
                  onTap: () => _addPhotoFrom(ImageSource.camera),
                ),
              FanItem(
                icon: Icons.photo_library,
                label: context.t.chooseFromGallery,
                onTap: () => _addPhotoFrom(ImageSource.gallery),
              ),
              if (hasCamera)
                FanItem(
                  icon: Icons.movie_outlined,
                  label: context.t.fromVideo,
                  onTap: _addFromVideo,
                ),
              FanItem(
                icon: Icons.event,
                label: context.t.appointmentLabel,
                onTap: _addAppointment,
              ),
              FanItem(
                icon: Icons.alarm,
                label: context.t.reminderLabel,
                onTap: _addReminder,
              ),
              FanItem(
                icon: Icons.checklist,
                label: context.t.choreLabel,
                onTap: _addChore,
              ),
            ],
          ),
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

/// The move dialog: a home or "stray" per row, the current one ticked,
/// and the day it happened at the foot. Pops the target and the day.
class _MoveDialog extends StatefulWidget {
  final List<EntityView> clowders;
  final String? current;
  const _MoveDialog({required this.clowders, required this.current});

  @override
  State<_MoveDialog> createState() => _MoveDialogState();
}

class _MoveDialogState extends State<_MoveDialog> {
  DateTime _asOf = DateTime.now();

  Future<void> _pickDay() async {
    final picked = await pickDay(
      context,
      initial: _asOf,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (!mounted || picked == null) return;
    setState(() => _asOf = picked);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return SimpleDialog(
      title: Text(t.moveTo),
      children: [
        for (final c in widget.clowders)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop((c.id, _asOf)),
            child: Row(
              children: [
                if (c.id == widget.current)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.check, size: 18),
                  ),
                Expanded(child: Text(c.name)),
              ],
            ),
          ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop((null, _asOf)),
          child: Row(
            children: [
              const Icon(Icons.explore, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(t.noClowderStrayOption)),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.event),
          title: Text(
            sameDay
                ? t.asOfToday
                : t.asOfDate(
                    DateFormat.yMd(
                      Localizations.localeOf(context).toString(),
                    ).format(_asOf),
                  ),
          ),
          trailing: const Icon(Icons.edit_calendar_outlined),
          onTap: _pickDay,
        ),
      ],
    );
  }
}
