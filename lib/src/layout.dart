import 'package:flutter/material.dart';

/// Width where the app stops being a stretched phone app: list pane
/// left, detail pane right. Purely width-based — iPad landscape and
/// resized desktop windows switch live; phones never see it.
const desktopBreakpoint = 840.0;

/// Height of the second line an app bar gains on a narrow screen.
const _titleLineHeight = 44.0;

/// An app bar that keeps its title readable.
///
/// The action buttons crowd a phone's title out: the Cat page spends a
/// back arrow and five buttons of a 360dp bar, leaving about six
/// characters for a cat's name. Below [desktopBreakpoint] the title
/// moves to its own line underneath the buttons; from there up the bar
/// is the ordinary one, because the title fits beside them.
PreferredSizeWidget roomyAppBar(BuildContext context,
    {required Widget title, List<Widget>? actions}) {
  if (MediaQuery.sizeOf(context).width >= desktopBreakpoint) {
    return AppBar(title: title, actions: actions);
  }
  final theme = Theme.of(context);
  return AppBar(
    actions: actions,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(_titleLineHeight),
      child: SizedBox(
        height: _titleLineHeight,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyle(
              style: (theme.appBarTheme.titleTextStyle ??
                      theme.textTheme.titleLarge!)
                  .copyWith(color: theme.colorScheme.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: title,
            ),
          ),
        ),
      ),
    ),
  );
}
