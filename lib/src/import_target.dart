import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';
import 'screens/catalogs_screen.dart';

/// Where a shared file goes (#90): a catalog that exists, or one to
/// create first, named by the keeper.
sealed class ImportTarget {
  const ImportTarget();
}

class ImportInto extends ImportTarget {
  final CatalogInfo catalog;
  const ImportInto(this.catalog);
}

class ImportIntoNew extends ImportTarget {
  final String name;
  const ImportIntoNew(this.name);
}

/// Asks which catalog [fileName] goes into before anything is imported:
/// the active catalog preselected, every catalog listed, "New catalog"
/// last. Null when cancelled — the file is then left alone.
Future<ImportTarget?> chooseImportTarget(
  BuildContext context,
  CatalogManager catalogs,
  String fileName,
) {
  return showDialog<ImportTarget>(
    context: context,
    builder: (context) =>
        _ImportTargetDialog(catalogs: catalogs, fileName: fileName),
  );
}

class _ImportTargetDialog extends StatefulWidget {
  final CatalogManager catalogs;
  final String fileName;

  const _ImportTargetDialog({required this.catalogs, required this.fileName});

  @override
  State<_ImportTargetDialog> createState() => _ImportTargetDialogState();
}

class _ImportTargetDialogState extends State<_ImportTargetDialog> {
  /// A catalog id, or '' for a new one.
  late String _choice = widget.catalogs.active.id;

  Future<void> _import() async {
    final t = context.t;
    if (_choice.isNotEmpty) {
      final catalog = widget.catalogs.catalogs().firstWhere(
        (c) => c.id == _choice,
      );
      Navigator.of(context).pop(ImportInto(catalog));
      return;
    }
    // A name prefilled from the file: "Schneeweißchen-share".
    final base = widget.fileName.replaceFirst(RegExp(r'\.catsync$'), '');
    final name = await askCatalogName(context, t.newCatalog, initial: base);
    if (name == null || name.isEmpty || !mounted) return;
    Navigator.of(context).pop(ImportIntoNew(name));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(widget.fileName),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(t.intoCatalog),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: _choice,
            isExpanded: true,
            items: [
              for (final c in widget.catalogs.catalogs())
                DropdownMenuItem(value: c.id, child: Text(c.name)),
              DropdownMenuItem(value: '', child: Text('${t.newCatalog}…')),
            ],
            onChanged: (v) => setState(() => _choice = v ?? _choice),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(onPressed: _import, child: Text(t.importLabel)),
      ],
    );
  }
}
