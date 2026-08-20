import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../help.dart';
import '../hidden.dart';
import '../image_provider_cache.dart';
import '../l10n.dart';
import '../language_dialog.dart';
import '../name_date_dialog.dart';
import '../share.dart';
import '../spotlight.dart';
import '../widgets/cat_avatar.dart';
import '../field_labels.dart';
import 'about_screen.dart';
import 'clowder_detail_screen.dart';
import 'duplicates_screen.dart';
import 'fields_screen.dart';
import 'map_screen.dart';
import 'search_screen.dart';
import 'strays_screen.dart';
import 'sync_screen.dart';

/// Home screen: all Clowders.
class ClowderListScreen extends StatefulWidget {
  final CatalogStore store;

  /// Wide (master-detail) mode: opening a clowder selects it in the
  /// detail pane instead of pushing a route.
  final void Function(String clowderId)? onOpenClowder;
  final String? selectedClowderId;

  const ClowderListScreen(
      {super.key,
      required this.store,
      this.onOpenClowder,
      this.selectedClowderId});

  @override
  State<ClowderListScreen> createState() => _ClowderListScreenState();
}

/// Local-setting keys for the table view (#54) — per device, unsynced.
const clowderViewKey = 'clowderView';
const clowderColumnsKey = 'clowderColumns';
const clowderSortKey = 'clowderSort';

class _ClowderListScreenState extends State<ClowderListScreen> {
  bool get _tableView =>
      widget.store.localSetting(clowderViewKey) == 'table';

  /// Selected field columns; name and cat count are always present.
  Set<String> get _columns {
    final raw = widget.store.localSetting(clowderColumnsKey);
    if (raw == null) return {'f:status'};
    return raw.split(',').where((c) => c.isNotEmpty).toSet();
  }

  (String, bool) get _sort {
    final raw = widget.store.localSetting(clowderSortKey) ?? 'name,asc';
    final parts = raw.split(',');
    return (parts[0], parts.length < 2 || parts[1] != 'desc');
  }

  void _setSort(String column) {
    final (current, asc) = _sort;
    widget.store.setLocalSetting(clowderSortKey,
        column == current ? '$column,${asc ? 'desc' : 'asc'}' : '$column,asc');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => runSpotlights(context, widget.store, 'home'));
  }

  Future<void> _exportCsv() async {
    final csv = exportCsv(widget.store);
    try {
      await shareFiles(context, [
        XFile.fromData(Uint8List.fromList(utf8.encode(csv)),
            mimeType: 'text/csv', name: 'catlog.csv'),
      ]);
    } catch (_) {
      // Share sheet unavailable (some desktops): save next to the data.
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/catlog.csv');
      await file.writeAsString(csv);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.csvSavedTo(file.path))),
      );
    }
  }

  Future<void> _addClowder() async {
    final result = await askNameAndDate(context, context.t.newClowder);
    if (result == null || !mounted) return;
    final id = widget.store.createClowder(result.name, date: result.date);
    setState(() {});
    if (!mounted) return;
    if (widget.onOpenClowder != null) {
      widget.onOpenClowder!(id);
      return;
    }
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ClowderDetailScreen(store: widget.store, clowderId: id),
    ));
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final clowders = widget.store.visibleClowders()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.clowders),
        actions: [
          HelpButton(store: widget.store, screenId: 'home'),
          IconButton(
            icon: Icon(
                _tableView ? Icons.grid_view : Icons.table_rows_outlined),
            tooltip:
                _tableView ? context.t.viewAsTiles : context.t.viewAsTable,
            onPressed: () {
              widget.store.setLocalSetting(
                  clowderViewKey, _tableView ? 'tiles' : 'table');
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: context.t.searchCats,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SearchScreen(store: widget.store),
            )),
          ),
          IconButton(
            icon: const Icon(Icons.map_outlined),
            tooltip: context.t.map,
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MapScreen(store: widget.store),
              ));
              if (!mounted) return;
              setState(() {});
            },
          ),
          Spotlight(
            id: 'home-sync',
            child: IconButton(
              icon: const Icon(Icons.sync),
              tooltip: context.t.sync,
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SyncScreen(store: widget.store),
                ));
                if (!mounted) return;
                setState(() {});
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: context.t.fields,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FieldsScreen(store: widget.store),
            )),
          ),
          Spotlight(
            id: 'home-menu',
            child: PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'csv') _exportCsv();
              if (v == 'duplicates') {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (_) =>
                          DuplicatesScreen(store: widget.store),
                    ))
                    .then((_) => mounted ? setState(() {}) : null);
              }
              if (v == 'language') {
                showLanguageDialog(context, widget.store);
              }
              if (v == 'hidden') {
                setState(() => showHidden.value = !showHidden.value);
              }
              if (v == 'about') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AboutScreen(store: widget.store),
                ));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 'hidden',
                  child: Text(showHidden.value
                      ? context.t.stopShowingHidden
                      : context.t.showHiddenLabel)),
              PopupMenuItem(
                  value: 'duplicates',
                  child: Text(context.t.findDuplicates)),
              PopupMenuItem(
                  value: 'csv', child: Text(context.t.exportCsv)),
              PopupMenuItem(
                  value: 'language', child: Text(context.t.language)),
              PopupMenuItem(
                  value: 'about', child: Text(context.t.aboutAndFeedback)),
            ],
          ),
          ),
        ],
      ),
      body: ListView(
        children: [
          if (clowders.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(context.t.noClowdersYet,
                  textAlign: TextAlign.center),
            ),
          if (_tableView) _clowderTable(clowders) else GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.4,
            ),
            itemCount: clowders.length + 1,
            itemBuilder: (context, i) {
              // Slot 0: the strays pseudo-clowder (#52) — strays are a
              // place too, just one without an address.
              if (i == 0) {
                return Spotlight(
                    id: 'home-strays',
                    child: _StraysCard(
                  store: widget.store,
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          StraysScreen(store: widget.store),
                    ));
                    if (!mounted) return;
                    setState(() {});
                  },
                ));
              }
              final clowder = clowders[i - 1];
              return _ClowderCard(
                store: widget.store,
                clowder: clowder,
                selected: clowder.id == widget.selectedClowderId,
                onContextMenu: (position) async {
                  final action = await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(position.dx,
                        position.dy, position.dx, position.dy),
                    items: [
                      PopupMenuItem(
                          value: 'open', child: Text(context.t.open)),
                      PopupMenuItem(
                          value: 'hide',
                          child: Text(widget.store.isHidden(clowder.id)
                              ? context.t.unhideLabel
                              : context.t.hideLabel)),
                    ],
                  );
                  if (action == 'hide') {
                    setState(() => widget.store.setHidden(clowder.id,
                        !widget.store.isHidden(clowder.id)));
                  }
                  if (action == 'open' && context.mounted) {
                    if (widget.onOpenClowder != null) {
                      widget.onOpenClowder!(clowder.id);
                    } else {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ClowderDetailScreen(
                            store: widget.store, clowderId: clowder.id),
                      ));
                    }
                    setState(() {});
                  }
                },
                onTap: () async {
                  if (widget.onOpenClowder != null) {
                    widget.onOpenClowder!(clowder.id);
                    setState(() {});
                    return;
                  }
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ClowderDetailScreen(
                        store: widget.store, clowderId: clowder.id),
                  ));
                  if (!mounted) return;
                  setState(() {});
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addClowder,
        tooltip: context.t.newClowder,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// The clowder overview as a sortable table (#54): fixed Name and
  /// Cats columns, chosen field columns, strays pinned first.
  Widget _clowderTable(List<EntityView> clowders) {
    final t = context.t;
    final store = widget.store;
    final defs = store.visibleFieldDefs(scope: FieldScope.clowder);
    final chosen = _columns;
    final columns = [
      for (final def in defs)
        if (chosen.contains(def.key)) def
    ];
    final (sortKey, asc) = _sort;
    final rows = [...clowders];
    int compare(EntityView a, EntityView b) {
      int result;
      if (sortKey == 'name') {
        result = a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else if (sortKey == 'count') {
        result = store
            .visibleCats(clowderId: a.id)
            .length
            .compareTo(store.visibleCats(clowderId: b.id).length);
      } else {
        result = (store.current(a.id, sortKey) ?? '')
            .toLowerCase()
            .compareTo((store.current(b.id, sortKey) ?? '').toLowerCase());
      }
      return asc ? result : -result;
    }

    rows.sort(compare);
    final sortIndex = sortKey == 'name'
        ? 0
        : sortKey == 'count'
            ? 1
            : 2 + columns.indexWhere((d) => d.key == sortKey);
    void open(String clowderId) async {
      if (widget.onOpenClowder != null) {
        widget.onOpenClowder!(clowderId);
        setState(() {});
        return;
      }
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            ClowderDetailScreen(store: store, clowderId: clowderId),
      ));
      if (mounted) setState(() {});
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Wrap(spacing: 8, runSpacing: 0, children: [
          for (final def in defs)
            FilterChip(
              label: Text(fieldDefName(t, def)),
              selected: chosen.contains(def.key),
              visualDensity: VisualDensity.compact,
              onSelected: (_) {
                final next = {...chosen};
                if (!next.remove(def.key)) next.add(def.key);
                store.setLocalSetting(
                    clowderColumnsKey, next.join(','));
                setState(() {});
              },
            ),
        ]),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: sortIndex < 0 ? null : sortIndex,
          sortAscending: asc,
          showCheckboxColumn: false,
          columns: [
            DataColumn(
                label: Text(t.name),
                onSort: (_, _) => _setSort('name')),
            DataColumn(
                label: Text(t.cats),
                numeric: true,
                onSort: (_, _) => _setSort('count')),
            for (final def in columns)
              DataColumn(
                  label: Text(fieldDefName(t, def)),
                  onSort: (_, _) => _setSort(def.key)),
          ],
          rows: [
            // Strays pinned first, visually distinct, never sorted away.
            DataRow(
              color: WidgetStatePropertyAll(Theme.of(context)
                  .colorScheme
                  .tertiaryContainer
                  .withValues(alpha: 0.4)),
              onSelectChanged: (_) async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => StraysScreen(store: store),
                ));
                if (mounted) setState(() {});
              },
              cells: [
                DataCell(Row(children: [
                  const Icon(Icons.explore, size: 18),
                  const SizedBox(width: 6),
                  Text(t.strays),
                ])),
                DataCell(Text('${store.visibleStrays().length}')),
                for (final _ in columns) const DataCell(Text('')),
              ],
            ),
            for (final clowder in rows)
              DataRow(
                selected: clowder.id == widget.selectedClowderId,
                onSelectChanged: (_) => open(clowder.id),
                cells: [
                  DataCell(Text(clowder.name)),
                  DataCell(Text(
                      '${store.visibleCats(clowderId: clowder.id).length}')),
                  for (final def in columns)
                    DataCell(Text(fieldValueDisplay(
                        t, def, store.current(clowder.id, def.key)))),
                ],
              ),
          ],
        ),
      ),
    ]);
  }
}

/// A Clowder as a card: faded photo of one of its cats as background,
/// name on top with a shadow for contrast.
class _ClowderCard extends StatelessWidget {
  final CatalogStore store;
  final EntityView clowder;
  final VoidCallback onTap;
  final void Function(Offset globalPosition)? onContextMenu;
  final bool selected;

  const _ClowderCard(
      {required this.store,
      required this.clowder,
      required this.onTap,
      this.onContextMenu,
      this.selected = false});

  /// Background: profile image of the first cat in the clowder that has one.
  ImageProvider? _cover() {
    for (final cat in store.visibleCats(clowderId: clowder.id)) {
      final hash = store.profileImage(cat.id);
      if (hash != null) {
        final photo = imageProviderFor(store, hash);
        if (photo != null) return photo;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cover = _cover();
    final scheme = Theme.of(context).colorScheme;
    return Material(
      clipBehavior: Clip.antiAlias,
      color: selected
          ? scheme.primaryContainer
          : scheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: selected
            ? BorderSide(color: scheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        onSecondaryTapDown: onContextMenu == null
            ? null
            : (d) => onContextMenu!(d.globalPosition),
        child: Stack(fit: StackFit.expand, children: [
          if (cover != null)
            Opacity(
              opacity: 0.55,
              child: Image(
                  image: ResizeImage(cover, width: 800),
                  fit: BoxFit.cover),
            )
          else
            Center(
              child: Icon(Icons.pets,
                  size: 40, color: scheme.onSurfaceVariant.withValues(alpha: 0.4)),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clowder.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: cover != null ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.bold,
                    shadows: cover != null
                        ? const [
                            Shadow(blurRadius: 6, color: Colors.black87),
                            Shadow(blurRadius: 2, color: Colors.black),
                          ]
                        : null,
                  ),
                ),
                const Spacer(),
                _FaceRow(store: store, clowderId: clowder.id,
                    onLight: cover != null),
              ],
            ),
          ),
          // The type as a small end-aligned label on the center line —
          // the chip crowded the card and its text never fit (#54).
          if (store.current(clowder.id, 'f:status') case final status?)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: Text(
                  statusDisplay(context.t, status) ?? status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: cover != null ? Colors.white : scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    shadows: cover != null
                        ? const [Shadow(blurRadius: 4, color: Colors.black87)]
                        : null,
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}



/// Up to five little faces plus a count — who lives here, at a glance.
/// The Strays pseudo-clowder card: pinned first in the grid, cover from
/// the first stray with a photo, faces and count below (#52).
class _StraysCard extends StatelessWidget {
  final CatalogStore store;
  final VoidCallback onTap;

  const _StraysCard({required this.store, required this.onTap});

  ImageProvider? _cover(List<EntityView> strays) {
    for (final cat in strays) {
      final hash = store.profileImage(cat.id);
      if (hash != null) {
        final photo = imageProviderFor(store, hash);
        if (photo != null) return photo;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final strays = store.visibleStrays();
    final cover = _cover(strays);
    final scheme = Theme.of(context).colorScheme;
    const shown = 5;
    return Material(
      clipBehavior: Clip.antiAlias,
      color: scheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.tertiary, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(fit: StackFit.expand, children: [
          if (cover != null)
            Opacity(
              opacity: 0.55,
              child: Image(
                  image: ResizeImage(cover, width: 800),
                  fit: BoxFit.cover),
            )
          else
            Center(
              child: Icon(Icons.explore,
                  size: 40,
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.4)),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.t.strays} (${strays.length})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                    color:
                        cover != null ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.bold,
                    shadows: cover != null
                        ? const [
                            Shadow(blurRadius: 6, color: Colors.black87),
                            Shadow(blurRadius: 2, color: Colors.black),
                          ]
                        : null,
                  ),
                ),
                const Spacer(),
                if (strays.isNotEmpty)
                  Row(children: [
                    for (final cat in strays.take(shown))
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: CatAvatar(
                            store: store, catId: cat.id, size: 26),
                      ),
                    if (strays.length > shown)
                      Text('+${strays.length - shown}',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: cover != null ? Colors.white : null,
                                fontWeight: FontWeight.bold,
                              )),
                  ]),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _FaceRow extends StatelessWidget {
  final CatalogStore store;
  final String clowderId;
  final bool onLight;

  const _FaceRow(
      {required this.store, required this.clowderId, required this.onLight});

  @override
  Widget build(BuildContext context) {
    final cats = store.visibleCats(clowderId: clowderId);
    if (cats.isEmpty) return const SizedBox.shrink();
    const shown = 5;
    return Row(children: [
      for (final cat in cats.take(shown))
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: CatAvatar(store: store, catId: cat.id, size: 26),
        ),
      Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            cats.length > shown
                ? '+${cats.length - shown}'
                : '${cats.length}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: onLight ? Colors.white : null,
              fontWeight: FontWeight.bold,
              shadows: onLight
                  ? const [Shadow(blurRadius: 4, color: Colors.black87)]
                  : null,
            ),
          ),
        ),
    ]);
  }
}
