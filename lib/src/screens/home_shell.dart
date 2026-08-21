import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../hidden.dart';
import '../l10n.dart';
import '../layout.dart';
import 'clowder_list_screen.dart';

class HomeShell extends StatefulWidget {
  final CatalogStore store;

  /// The name of the catalog being shown. Null in tests and wherever
  /// there is only ever one, where the plain word does the job.
  final String? catalogName;

  /// Every catalog on the device. With one in hand the home title
  /// becomes the switcher; without one the title is just a word.
  final CatalogManager? catalogs;
  final void Function(CatalogInfo)? onSwitchCatalog;

  /// Something about the catalogs themselves changed — a new one, a
  /// rename — and the title may need redrawing.
  final VoidCallback? onCatalogsChanged;

  const HomeShell(
      {super.key,
      required this.store,
      this.catalogName,
      this.catalogs,
      this.onSwitchCatalog,
      this.onCatalogsChanged});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  PanePage? _page;

  String? get _title =>
      widget.catalogName ?? widget.catalogs?.active.name;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // The table is for scanning the columns you picked; squeezed into
      // the list pane it has to be dragged sideways to read, so in table
      // view the list keeps the whole window and rows open over it.
      final tableView =
          widget.store.localSetting(clowderViewKey) == 'table';
      if (constraints.maxWidth < desktopBreakpoint || tableView) {
        return ClowderListScreen(
            store: widget.store,
            catalogName: _title,
            catalogs: widget.catalogs,
            onSwitchCatalog: widget.onSwitchCatalog,
            onCatalogsChanged: widget.onCatalogsChanged,
            onViewChanged: () => setState(() {}));
      }
      // A deleted or hidden clowder vacates the pane; every other page
      // stays valid for as long as it is open.
      final page = _page;
      final clowderId = page?.clowderId;
      final shown = clowderId == null ||
              widget.store.visibleClowders().any((c) => c.id == clowderId)
          ? page
          : null;
      return Row(children: [
        SizedBox(
          width: 400,
          child: ClowderListScreen(
            store: widget.store,
            catalogName: _title,
            catalogs: widget.catalogs,
            onSwitchCatalog: widget.onSwitchCatalog,
            onCatalogsChanged: widget.onCatalogsChanged,
            selectedPageId: shown?.id,
            onOpenPage: (page) => setState(() => _page = page),
            onViewChanged: () => setState(() {}),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          // The pane runs its own Navigator, so opening a cat from the
          // clowder stays inside the pane instead of covering the list.
          child: shown == null
              ? Center(
                  child: Text(context.t.selectClowderHint,
                      style: Theme.of(context).textTheme.bodyLarge),
                )
              : Navigator(
                  key: ValueKey(shown.id),
                  onGenerateRoute: (settings) =>
                      MaterialPageRoute(builder: shown.build),
                ),
        ),
      ]);
    });
  }
}
