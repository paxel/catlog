import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../hidden.dart';
import '../l10n.dart';
import '../widgets/cat_avatar.dart';
import 'cat_detail_screen.dart';

/// Find a Cat by name across all Clowders and Strays — the fast path
/// to one of ten look-alikes.
class SearchScreen extends StatefulWidget {
  final CatalogStore store;

  const SearchScreen({super.key, required this.store});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = [
      for (final c in widget.store.searchCats(_query))
        if (widget.store.visible(c.id)) c
    ];
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: context.t.searchByNameHint,
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => _query = v),
        ),
      ),
      body: _query.trim().isNotEmpty && results.isEmpty
          ? Center(child: Text(context.t.searchNoResults))
          : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, i) {
          final cat = results[i];
          final clowderId = widget.store.current(cat.id, Keys.clowder);
          final where = clowderId == null
              ? context.t.stray
              : widget.store.current(clowderId, Keys.name) ??
                  context.t.unnamed;
          return ListTile(
            leading:
                CatAvatar(store: widget.store, catId: cat.id, size: 40),
            title: Text(cat.name),
            subtitle: Text(where),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    CatDetailScreen(store: widget.store, catId: cat.id),
              ));
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
