import 'package:flutter/material.dart';

/// Splits a grouped pair code (`xxxxx_xxxxx_...`) into lines of
/// [groupsPerLine] groups, so the whole code fits a phone screen.
List<String> pairCodeLines(String code, {int groupsPerLine = 3}) {
  final groups = code.split('_');
  return [
    for (var i = 0; i < groups.length; i += groupsPerLine)
      groups.sublist(i, (i + groupsPerLine).clamp(0, groups.length)).join('_'),
  ];
}

/// The pair code to read aloud or copy by hand: short lines, each in
/// its own colour, so the eye keeps its place between reading on one
/// phone and typing on the other. Selectable as a whole.
class PairCodeText extends StatelessWidget {
  final String code;

  const PairCodeText(this.code, {super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = [scheme.primary, scheme.tertiary, scheme.onSurface];
    final lines = pairCodeLines(code);
    return SelectableText.rich(
      TextSpan(
        children: [
          for (final (i, line) in lines.indexed)
            TextSpan(
              text: i == lines.length - 1 ? line : '$line\n',
              style: TextStyle(color: colors[i % colors.length]),
            ),
        ],
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
