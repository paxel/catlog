import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../hidden.dart';
import '../l10n.dart';
import 'clowder_detail_screen.dart';
import 'clowder_list_screen.dart';

/// Width where the app stops being a stretched phone app: list pane
/// left, detail pane right. Purely width-based — iPad landscape and
/// resized desktop windows switch live; phones never see it.
const desktopBreakpoint = 840.0;

class HomeShell extends StatefulWidget {
  final CatalogStore store;

  const HomeShell({super.key, required this.store});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < desktopBreakpoint) {
        return ClowderListScreen(store: widget.store);
      }
      // A deleted or hidden clowder vacates the pane.
      final selected = _selected != null &&
              widget.store
                  .visibleClowders()
                  .any((c) => c.id == _selected)
          ? _selected
          : null;
      return Row(children: [
        SizedBox(
          width: 400,
          child: ClowderListScreen(
            store: widget.store,
            selectedClowderId: selected,
            onOpenClowder: (id) => setState(() => _selected = id),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          // The pane runs its own Navigator, so opening a cat from the
          // clowder stays inside the pane instead of covering the list.
          child: selected == null
              ? Center(
                  child: Text(context.t.selectClowderHint,
                      style: Theme.of(context).textTheme.bodyLarge),
                )
              : Navigator(
                  key: ValueKey(selected),
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (_) => ClowderDetailScreen(
                        store: widget.store, clowderId: selected),
                  ),
                ),
        ),
      ]);
    });
  }
}
