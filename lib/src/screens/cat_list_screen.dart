import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../age.dart';
import '../field_labels.dart';
import '../help.dart';
import '../l10n.dart';
import '../layout.dart';
import '../spotlight.dart';
import '../widgets/cat_avatar.dart';
import 'cat_detail_screen.dart';
import '../hidden.dart';

const catViewKey = 'catView';
const catColumnsKey = 'catColumns';
const catSortKey = 'catSort';

/// The cats to list, resolved fresh on every build so edits show.
typedef CatSource = List<EntityView> Function(CatalogStore store);

/// Extra app-bar actions or a floating button for one use of the list;
/// [refresh] redraws the list after whatever the action did.
typedef CatListExtras = List<Widget> Function(
  BuildContext context,
  VoidCallback refresh,
);
typedef CatListFab = Widget Function(
  BuildContext context,
  VoidCallback refresh,
);

/// One list for every set of cats (#87): strays, a search, a clowder's
/// members, the cats under one map pin. List or table, sortable, with
/// chosen field columns, a computed age column and a text filter over
/// names and values. View, columns and sort are remembered per device.
class CatListScreen extends StatefulWidget {
  final CatalogStore store;
  final String title;
  final CatSource source;

  /// Puts the cursor into the filter — the search entry point.
  final bool autofocusFilter;
  final CatListExtras? actions;
  final CatListFab? floatingActionButton;
  final String? emptyText;
  final String? helpScreenId;
  final String? spotlightScreenId;

  const CatListScreen({
    super.key,
    required this.store,
    required this.title,
    required this.source,
    this.autofocusFilter = false,
    this.actions,
    this.floatingActionButton,
    this.emptyText,
    this.helpScreenId,
    this.spotlightScreenId,
  });

  @override
  State<CatListScreen> createState() => _CatListScreenState();
}

class _CatListScreenState extends State<CatListScreen> {
  String _query = '';

  CatalogStore get store => widget.store;

  bool get _tableView => store.localSetting(catViewKey) == 'table';

  /// Chosen field columns; Name and Age are always present.
  Set<String> get _columns {
    final raw = store.localSetting(catColumnsKey);
    if (raw == null) return {'f:gender', 'f:color'};
    return raw.split(',').where((c) => c.isNotEmpty).toSet();
  }

  (String, bool) get _sort {
    final raw = store.localSetting(catSortKey) ?? 'name,asc';
    final parts = raw.split(',');
    return (parts[0], parts.length < 2 || parts[1] != 'desc');
  }

  void _setSort(String column, {bool toggle = true}) {
    final (current, asc) = _sort;
    store.setLocalSetting(
      catSortKey,
      column == current && toggle
          ? '$column,${asc ? 'desc' : 'asc'}'
          : '$column,asc',
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    final spotlight = widget.spotlightScreenId;
    if (spotlight != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => runSpotlights(context, store, spotlight),
      );
    }
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  /// Field columns a cat table can show: values with a text form.
  List<FieldDef> get _columnDefs => [
    for (final def in store.visibleFieldDefs(scope: FieldScope.cat))
      if (def.type != FieldType.location && def.type != FieldType.cat) def,
  ];

  String _value(String catId, String key) => store.current(catId, key) ?? '';

  /// Name, then any field value, case-insensitive.
  bool _matches(EntityView cat, String q) {
    if (cat.name.toLowerCase().contains(q)) return true;
    for (final def in store.fieldDefs(scope: FieldScope.cat)) {
      if (_value(cat.id, def.key).toLowerCase().contains(q)) return true;
    }
    return false;
  }

  int _compare(EntityView a, EntityView b) {
    final (key, asc) = _sort;
    int result;
    if (key == 'name') {
      result = a.name.toLowerCase().compareTo(b.name.toLowerCase());
    } else if (key == 'age') {
      // Older first when ascending by age — later birth date sorts
      // after; unknown birth dates go last either way.
      final ba = _value(a.id, Keys.userField('birthdate'));
      final bb = _value(b.id, Keys.userField('birthdate'));
      if (ba.isEmpty || bb.isEmpty) {
        return ba.isEmpty == bb.isEmpty
            ? 0
            : ba.isEmpty
            ? 1
            : -1;
      }
      result = ba.compareTo(bb);
    } else {
      final def = store.fieldDefs().where((d) => d.key == key).firstOrNull;
      final numeric =
          def?.type == FieldType.number || def?.type == FieldType.unitValue;
      final na = numeric ? double.tryParse(_value(a.id, key)) : null;
      final nb = numeric ? double.tryParse(_value(b.id, key)) : null;
      if (numeric && (na != null || nb != null)) {
        // Numbers sort as numbers; the ones without go last either way.
        if (na == null || nb == null) return na == null ? 1 : -1;
        result = na.compareTo(nb);
      } else {
        result = _value(
          a.id,
          key,
        ).toLowerCase().compareTo(_value(b.id, key).toLowerCase());
      }
    }
    return asc ? result : -result;
  }

  List<EntityView> _cats() {
    final q = _query.trim().toLowerCase();
    return [
      for (final cat in widget.source(store))
        if (q.isEmpty || _matches(cat, q)) cat,
    ]..sort(_compare);
  }

  /// Where the cat lives, its age, gender and colour — what one scans
  /// a cat list for (#52, #80).
  String _subtitle(BuildContext context, String catId) {
    final t = context.t;
    final defs = store.fieldDefs();
    String display(String slug) {
      final value = _value(catId, Keys.userField(slug));
      if (value.isEmpty) return '';
      final def = defs.where((d) => d.slug == slug).firstOrNull;
      return fieldValueDisplay(t, def, value);
    }

    final clowderId = store.current(catId, Keys.clowder);
    return [
      if (clowderId != null) store.current(clowderId, Keys.name) ?? t.unnamed,
      ageDisplay(t, store, catId) ?? '',
      display('gender'),
      display('color'),
    ].where((s) => s.isNotEmpty).join(' · ');
  }

  Future<void> _openCat(String catId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CatDetailScreen(store: store, catId: catId),
      ),
    );
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final cats = _cats();
    final empty = widget.source(store).isEmpty;
    return Scaffold(
      appBar: roomyAppBar(
        context,
        title: Text(widget.title),
        actions: [
          if (widget.helpScreenId != null)
            HelpButton(store: store, screenId: widget.helpScreenId!),
          IconButton(
            icon: Icon(
              _tableView ? Icons.view_list : Icons.table_rows_outlined,
            ),
            tooltip: _tableView ? t.viewAsList : t.viewAsTable,
            onPressed: () {
              store.setLocalSetting(catViewKey, _tableView ? 'list' : 'table');
              setState(() {});
            },
          ),
          if (!_tableView)
            PopupMenuButton<String>(
              icon: const Icon(Icons.sort),
              tooltip: t.sortLabel,
              onSelected: (s) => _setSort(s, toggle: false),
              itemBuilder: (context) => [
                PopupMenuItem(value: 'name', child: Text(t.name)),
                PopupMenuItem(value: 'age', child: Text(t.ageLabel)),
                for (final def in _columnDefs)
                  PopupMenuItem(
                    value: def.key,
                    child: Text(fieldDefName(t, def)),
                  ),
              ],
            ),
          ...?widget.actions?.call(context, _refresh),
        ],
      ),
      floatingActionButton: widget.floatingActionButton?.call(
        context,
        _refresh,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              autofocus: widget.autofocusFilter,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: t.searchByNameHint,
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: empty && widget.emptyText != null
                ? Center(child: Text(widget.emptyText!))
                : cats.isEmpty
                ? Center(child: Text(t.searchNoResults))
                : _tableView
                ? _table(cats)
                : _list(cats),
          ),
        ],
      ),
    );
  }

  Widget _list(List<EntityView> cats) => ListView.builder(
    // Floating buttons may stack here; the last row scrolls clear.
    padding: const EdgeInsets.only(bottom: 144),
    itemCount: cats.length,
    itemBuilder: (context, i) {
      final cat = cats[i];
      final details = _subtitle(context, cat.id);
      return ListTile(
        leading: CatAvatar(store: store, catId: cat.id, size: 40),
        title: Text(cat.name),
        subtitle: details.isEmpty ? null : Text(details),
        onTap: () => _openCat(cat.id),
      );
    },
  );

  /// Sortable table: Name and Age fixed, chosen field columns after.
  Widget _table(List<EntityView> cats) {
    final t = context.t;
    final defs = _columnDefs;
    final chosen = _columns;
    final columns = [
      for (final def in defs)
        if (chosen.contains(def.key)) def,
    ];
    final (sortKey, asc) = _sort;
    final sortIndex = sortKey == 'name'
        ? 0
        : sortKey == 'age'
        ? 1
        : 2 + columns.indexWhere((d) => d.key == sortKey);
    return ListView(
      padding: const EdgeInsets.only(bottom: 144),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            spacing: 8,
            runSpacing: 0,
            children: [
              for (final def in defs)
                FilterChip(
                  label: Text(fieldDefName(t, def)),
                  selected: chosen.contains(def.key),
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) {
                    final next = {...chosen};
                    if (!next.remove(def.key)) next.add(def.key);
                    store.setLocalSetting(catColumnsKey, next.join(','));
                    setState(() {});
                  },
                ),
            ],
          ),
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
                onSort: (_, _) => _setSort('name'),
              ),
              DataColumn(
                label: Text(t.ageLabel),
                onSort: (_, _) => _setSort('age'),
              ),
              for (final def in columns)
                DataColumn(
                  label: Text(fieldDefName(t, def)),
                  onSort: (_, _) => _setSort(def.key),
                ),
            ],
            rows: [
              for (final cat in cats)
                DataRow(
                  onSelectChanged: (_) => _openCat(cat.id),
                  cells: [
                    DataCell(Text(cat.name)),
                    DataCell(Text(ageDisplay(t, store, cat.id) ?? '')),
                    for (final def in columns)
                      DataCell(
                        Text(
                          fieldValueDisplay(
                            t,
                            def,
                            store.current(cat.id, def.key),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
