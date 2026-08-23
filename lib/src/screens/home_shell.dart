import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../layout.dart';
import '../move_to_catalog.dart';
import 'clowder_list_screen.dart';

class HomeShell extends StatefulWidget {
  final CatalogStore store;

  /// The name of the catalog being shown. Null in tests and wherever
  /// there is only ever one, where the plain word does the job.
  final String? catalogName;

  /// Switching between catalogs. With this in hand the home title
  /// becomes the switcher; without it the title is just a word.
  final CatalogSwitching? switching;

  const HomeShell(
      {super.key, required this.store, this.catalogName, this.switching});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  PanePage? _page;

  /// The catalog the open page was built against. Switching catalogs
  /// closes the old one a frame later, and the page's builder is still
  /// holding it — Strays, Search, Fields and Duplicates would go on
  /// reading from a database that is no longer open.
  CatalogStore? _pageStore;

  String? get _title =>
      widget.catalogName ?? widget.switching?.active.name;

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
            switching: widget.switching,
            onViewChanged: () => setState(() {}));
      }
      // A page vacates the pane when its catalog is no longer the one
      // open, and a clowder page also when its clowder is gone.
      final page = _page;
      final shown = page != null &&
              page.stillBelongs(widget.store, openedIn: _pageStore)
          ? page
          : null;
      return Row(children: [
        SizedBox(
          width: 400,
          child: ClowderListScreen(
            store: widget.store,
            catalogName: _title,
            switching: widget.switching,
            selectedPageId: shown?.id,
            onOpenPage: (page) => setState(() {
              _page = page;
              _pageStore = widget.store;
            }),
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
