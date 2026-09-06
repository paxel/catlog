import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

/// Chips one sets once and rarely touches again — table columns, the
/// fields on a card. A header names the set and counts the choice; a
/// chevron folds the chips away, and folded they read as one line of
/// the chosen labels. The fold is remembered per [id] on this device,
/// and a set that already has a choice starts folded.
class FoldableChips extends StatefulWidget {
  final CatalogStore store;
  final String id;
  final String title;
  final List<({String key, String label})> options;
  final Set<String> selected;
  final void Function(String key) onToggle;

  const FoldableChips({
    super.key,
    required this.store,
    required this.id,
    required this.title,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  @override
  State<FoldableChips> createState() => _FoldableChipsState();
}

class _FoldableChipsState extends State<FoldableChips> {
  String get _settingKey => 'chips:${widget.id}';

  bool get _open => switch (widget.store.localSetting(_settingKey)) {
    'open' => true,
    'closed' => false,
    _ => widget.selected.isEmpty,
  };

  void _toggleOpen() {
    widget.store.setLocalSetting(_settingKey, _open ? 'closed' : 'open');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chosen = [
      for (final o in widget.options)
        if (widget.selected.contains(o.key)) o.label,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggleOpen,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
            child: Row(
              children: [
                Text(widget.title, style: theme.textTheme.titleSmall),
                const SizedBox(width: 8),
                Text(
                  '${chosen.length} / ${widget.options.length}',
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                Icon(_open ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (_open)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 0,
              children: [
                for (final o in widget.options)
                  FilterChip(
                    label: Text(o.label),
                    selected: widget.selected.contains(o.key),
                    onSelected: (_) => widget.onToggle(o.key),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          )
        else if (chosen.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Text(
              chosen.join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
