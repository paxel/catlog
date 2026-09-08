import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

/// A section that folds: a header with the count and a chevron, the
/// rows under it only while open. Closed until the keeper opens it; the
/// fold is remembered on this device under `fold:<id>`.
class FoldSection extends StatefulWidget {
  final CatalogStore store;
  final String id;
  final String title;
  final int count;
  final List<Widget> children;

  /// Header padding; the agenda and the pages indent differently.
  final EdgeInsets padding;

  const FoldSection({
    super.key,
    required this.store,
    required this.id,
    required this.title,
    required this.count,
    required this.children,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 8, 4),
  });

  @override
  State<FoldSection> createState() => _FoldSectionState();
}

class _FoldSectionState extends State<FoldSection> {
  String get _key => 'fold:${widget.id}';

  bool get _open => widget.store.localSetting(_key) == 'open';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            widget.store.setLocalSetting(_key, _open ? 'closed' : 'open');
            setState(() {});
          },
          child: Padding(
            padding: widget.padding,
            child: Row(
              children: [
                Text(widget.title, style: theme.textTheme.titleSmall),
                const SizedBox(width: 8),
                Text('${widget.count}', style: theme.textTheme.bodySmall),
                const Spacer(),
                Icon(_open ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (_open) ...widget.children,
      ],
    );
  }
}
