import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n.dart';
import '../language_dialog.dart';
import '../name_date_dialog.dart';
import 'about_screen.dart';
import 'clowder_detail_screen.dart';
import 'fields_screen.dart';
import 'map_screen.dart';
import 'search_screen.dart';
import 'strays_screen.dart';
import 'sync_screen.dart';

/// Home screen: all Clowders.
class ClowderListScreen extends StatefulWidget {
  final CatalogStore store;

  const ClowderListScreen({super.key, required this.store});

  @override
  State<ClowderListScreen> createState() => _ClowderListScreenState();
}

class _ClowderListScreenState extends State<ClowderListScreen> {
  Future<void> _exportCsv() async {
    final csv = exportCsv(widget.store);
    try {
      await Share.shareXFiles([
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
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ClowderDetailScreen(store: widget.store, clowderId: id),
    ));
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final clowders = widget.store.clowders()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    final strays = widget.store.strays();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.clowders),
        actions: [
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
          IconButton(
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
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: context.t.fields,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FieldsScreen(store: widget.store),
            )),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'csv') _exportCsv();
              if (v == 'language') {
                showLanguageDialog(context, widget.store);
              }
              if (v == 'about') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 'csv', child: Text(context.t.exportCsv)),
              PopupMenuItem(
                  value: 'language', child: Text(context.t.language)),
              PopupMenuItem(
                  value: 'about', child: Text(context.t.aboutAndFeedback)),
            ],
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.4,
            ),
            itemCount: clowders.length,
            itemBuilder: (context, i) {
              final clowder = clowders[i];
              return _ClowderCard(
                store: widget.store,
                clowder: clowder,
                onTap: () async {
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.explore),
            title: Text(context.t.strays),
            trailing: Text('${strays.length}'),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => StraysScreen(store: widget.store),
              ));
              if (!mounted) return;
              setState(() {});
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
}

/// A Clowder as a card: faded photo of one of its cats as background,
/// name on top with a shadow for contrast.
class _ClowderCard extends StatelessWidget {
  final CatalogStore store;
  final EntityView clowder;
  final VoidCallback onTap;

  const _ClowderCard(
      {required this.store, required this.clowder, required this.onTap});

  /// Background: profile image of the first cat in the clowder that has one.
  Uint8List? _cover() {
    for (final cat in store.cats(clowderId: clowder.id)) {
      final hash = store.profileImage(cat.id);
      if (hash != null) {
        final bytes = store.imageBytes(hash);
        if (bytes != null) return bytes;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cover = _cover();
    final scheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      color: scheme.surfaceContainerHighest,
      child: InkWell(
        onTap: onTap,
        child: Stack(fit: StackFit.expand, children: [
          if (cover != null)
            Opacity(
              opacity: 0.55,
              child: Image.memory(cover,
                  fit: BoxFit.cover, cacheWidth: 800),
            )
          else
            Center(
              child: Icon(Icons.pets,
                  size: 40, color: scheme.onSurfaceVariant.withValues(alpha: 0.4)),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                clowder.name,
                maxLines: 2,
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
            ),
          ),
        ]),
      ),
    );
  }
}

