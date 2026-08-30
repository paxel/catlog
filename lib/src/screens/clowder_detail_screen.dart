import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../move_to_catalog.dart';
import '../layout.dart';
import '../help.dart';
import '../conflict_dialog.dart';
import '../field_editing.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../merge_dialogs.dart';
import '../name_date_dialog.dart';
import '../new_field_dialog.dart';
import '../name_proposals.dart';
import '../widgets/cat_avatar.dart';
import '../reminders/mirror_hook.dart';
import '../reminders/plan_chooser.dart';
import '../widgets/cat_ear.dart';
import '../widgets/field_list.dart';
import '../widgets/appointment_card.dart';
import '../widgets/reminder_card.dart';
import '../widgets/status_chip.dart';
import '../registry_lookup.dart';
import '../spotlight.dart';
import 'card_screen.dart';
import 'cat_detail_screen.dart';
import 'clowder_card_screen.dart';
import 'map_screen.dart';
import 'timeline_screen.dart';
import '../geocode.dart';
import 'cat_list_screen.dart';
import 'field_graph_screen.dart';

/// One Clowder: name, its Field values (address, responsible person, …),
/// and the Cats currently living there as a grid of faces.
class ClowderDetailScreen extends StatefulWidget {
  final CatalogStore store;
  final String clowderId;

  /// Address search; tests inject a stub instead of Nominatim.
  final GeocodeSearch? geocode;

  const ClowderDetailScreen({
    super.key,
    required this.store,
    required this.clowderId,
    this.geocode,
  });

  @override
  State<ClowderDetailScreen> createState() => _ClowderDetailScreenState();
}

class _ClowderDetailScreenState extends State<ClowderDetailScreen> {
  CatalogStore get store => widget.store;
  String get id => widget.clowderId;

  /// Read-only until the pencil is pressed (#46); every visit starts calm.
  bool _editing = false;

  bool _locating = false;

  /// The place the address search found, or why it found none (#81).
  String? _locateNote;

  /// Turns the Address into a Position — on request only, because it
  /// asks the geocoding service. The first hit's name is shown so a
  /// wrong town does not pass unnoticed.
  Future<void> _locateAddress() async {
    final query = store.current(id, Keys.userField('address'))?.trim() ?? '';
    if (query.isEmpty || _locating) return;
    setState(() {
      _locating = true;
      _locateNote = null;
    });
    List<GeoHit> hits;
    try {
      hits = await (widget.geocode ?? nominatimSearch)(query);
    } catch (_) {
      hits = const [];
    }
    if (!mounted) return;
    setState(() {
      _locating = false;
      if (hits.isEmpty) {
        _locateNote = context.t.addressNotFound;
      } else {
        store.recordPosition(id, hits.first.lat, hits.first.lon);
        _locateNote = hits.first.name;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => runSpotlights(context, store, 'clowder'),
    );
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
    store.append(id, def.key, edit.value, date: edit.date);
    if (edit.private != store.isFieldPrivate(id, def.key)) {
      store.setFieldPrivate(id, def.key, edit.private);
    }
    setState(() {});
  }

  Future<void> _rename() async {
    final current = store.current(id, Keys.name) ?? '';
    final name = await _askForText(context, context.t.renameClowder, current);
    if (name == null || name.isEmpty || name == current) return;
    store.append(id, Keys.name, name);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _addCat() async {
    final locale = Localizations.localeOf(context);
    final result = await askNameAndDate(
      context,
      context.t.newCat,
      propose: () => proposeCatName(store, locale),
    );
    if (result == null || !mounted) return;
    final catId = store.createCat(
      result.name,
      clowderId: id,
      date: result.date,
    );
    setState(() {});
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
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _mergeClowder() async {
    final merged = await showMergeDialog(
      context: context,
      store: store,
      loserId: id,
      kindLabel: context.t.kindClowder,
      candidates: store.clowders(),
      merge: store.mergeClowder,
    );
    if (merged && mounted) Navigator.of(context).pop();
  }

  /// The clowder and everything living in it leave for another
  /// catalog, so this page has nothing left to show.
  Future<void> _moveToCatalog() async {
    final moved = await moveToAnotherCatalog(context, store, {id});
    if (moved != null && mounted) Navigator.of(context).pop();
  }

  Future<void> _deleteClowder() async {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final count = store.cats(clowderId: id).length;
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.deleteQuestion(name)),
        content: Text(
          count == 0
              ? context.t.deleteClowderEmptyBody
              : context.t.deleteClowderBody(count),
        ),
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
    if (sure != true || !mounted) return;
    store.deleteClowder(id);
    Navigator.of(context).pop();
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

  void _plansChanged() {
    setState(() {});
    mirrorAfterChange(context, store);
  }

  /// The clowder's live plans, as the agenda shows them.
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
          onOpenEntity: _openCat,
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

  Future<void> _openCat(String catId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CatDetailScreen(store: store, catId: catId),
      ),
    );
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? context.t.unnamed;
    final defs = store.visibleFieldDefs(scope: FieldScope.clowder);
    final cats = store.visibleCats(clowderId: id);
    final fields = FieldList(
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
      onHistory: (def) async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                TimelineScreen(store: store, entityId: id, field: def.key),
          ),
        );
        // Reverts happen on the timeline — the page must show them.
        if (mounted) setState(() {});
      },
      onShowMap: _showOnMap,
      onLocate: _locateAddress,
      locateNote: _locateNote,
      locating: _locating,
      onLookup: (def, value) => openLookup(context, def, value),
      onGraph: (def) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            FieldGraphScreen(store: store, entityId: id, def: def),
      )),
      // Long-press in read mode: jump into edit mode with the field's
      // editor open — fix what you just spotted (#46).
      onReadLongPress: (def) {
        setState(() => _editing = true);
        _editField(def);
      },
      onAddField: () async {
        final created = await showNewFieldDialog(
          context,
          store,
          initialScope: FieldScope.clowder,
        );
        if (created && mounted) setState(() {});
      },
    );
    final gallery = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(children: [
          Expanded(
            child: Text(
              '${context.t.cats} (${cats.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // The members as a sortable list or table (#87); the faces
          // stay here.
          TextButton.icon(
            icon: const Icon(Icons.view_list),
            label: Text(context.t.catList),
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CatListScreen(
                    store: store,
                    title: name,
                    source: (s) => s.visibleCats(clowderId: id)),
              ));
              if (mounted) setState(() {});
            },
          ),
        ]),
      ),
      _catGrid(cats),
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
            HelpButton(store: store, screenId: 'clowder'),
            IconButton(
              icon: const Icon(Icons.badge_outlined),
              tooltip: context.t.card,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ClowderCardScreen(store: store, clowderId: id),
                ),
              ),
            ),
            Spotlight(
              id: 'clowder-reminder',
              child: IconButton(
                icon: const Icon(Icons.alarm_add),
                tooltip: context.t.addReminder,
                onPressed: _addReminder,
              ),
            ),
            IconButton(
              icon: Icon(_editing ? Icons.check : Icons.edit),
              tooltip: _editing ? context.t.doneLabel : context.t.editLabel,
              onPressed: () => setState(() => _editing = !_editing),
            ),
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: context.t.timeline,
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TimelineScreen(store: store, entityId: id),
                  ),
                );
                if (mounted) setState(() {});
              },
            ),
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'delete') _deleteClowder();
                if (v == 'moveCatalog') _moveToCatalog();
                if (v == 'merge') _mergeClowder();
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
                  value: 'hide',
                  child: Text(
                    store.isHidden(id)
                        ? context.t.unhideLabel
                        : context.t.hideLabel,
                  ),
                ),
                PopupMenuItem(value: 'merge', child: Text(context.t.mergeInto)),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(context.t.deleteClowder),
                ),
              ],
            ),
          ],
        ),
        body: ListView(
          children: [
            if (store.current(id, 'f:status') != null)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: StatusChip(store: store, clowderId: id),
                ),
              ),
            // Read mode leads with what one opens a clowder for — the cats;
            // edit mode leads with its purpose — the fields (#46).
            if (_editing) ...[
              fields,
              const Divider(),
              ...gallery,
            ] else ...[
              ...gallery,
              const Divider(),
              fields,
            ],
            ..._plannedSection(),
            const SizedBox(height: 80),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addCat,
          icon: const Icon(Icons.add),
          label: Text(context.t.addCat),
        ),
      ),
    );
  }

  Widget _catGrid(List<EntityView> cats) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(8),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 120,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.8,
    ),
    itemCount: cats.length,
    itemBuilder: (context, i) {
      final cat = cats[i];
      Future<void> menu(Offset at) async {
        final action = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(at.dx, at.dy, at.dx, at.dy),
          items: [
            PopupMenuItem(value: 'open', child: Text(context.t.open)),
            PopupMenuItem(value: 'card', child: Text(context.t.card)),
          ],
        );
        if (!context.mounted) return;
        if (action == 'open') _openCat(cat.id);
        if (action == 'card') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CardScreen(store: store, catId: cat.id),
            ),
          );
        }
      }

      return InkWell(
        onTap: () => _openCat(cat.id),
        // Long-press = menu, the app-wide gesture convention —
        // right-click stays as the desktop way in.
        onSecondaryTapDown: (d) => menu(d.globalPosition),
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onLongPressStart: (d) => menu(d.globalPosition),
          child: WithCatEar(
            child: Column(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CatAvatar(store: store, catId: cat.id, size: 96),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    cat.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
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
