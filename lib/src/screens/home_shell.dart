import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../hidden.dart';
import '../l10n.dart';
import '../layout.dart';
import 'clowder_list_screen.dart';

class HomeShell extends StatefulWidget {
  final CatalogStore store;

  const HomeShell({super.key, required this.store});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  PanePage? _page;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < desktopBreakpoint) {
        return ClowderListScreen(store: widget.store);
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
            selectedPageId: shown?.id,
            onOpenPage: (page) => setState(() => _page = page),
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
