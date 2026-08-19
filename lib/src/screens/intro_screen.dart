import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

/// Three swipeable intro cards after author setup — skippable at every
/// moment (never blocks), replayable from About. Aunt Tilly gets the
/// concepts; power users hit Skip once and never see it again.
class IntroScreen extends StatefulWidget {
  final CatalogStore store;
  final VoidCallback onDone;

  const IntroScreen({super.key, required this.store, required this.onDone});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() {
    widget.store.setLocalSetting('introSeen', '1');
    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final pages = [
      (Icons.pets, t.introTitle1, t.introBody1),
      (Icons.phonelink_lock_outlined, t.introTitle2, t.introBody2),
      (Icons.sync, t.introTitle3, t.introBody3),
      (Icons.assignment_outlined, t.introTitle4, t.introBody4),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: _finish,
              child: Text(t.introSkip),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (p) => setState(() => _page = p),
              children: [
                for (final (icon, title, body) in pages)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon,
                            size: 96,
                            color:
                                Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 32),
                        Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        Text(body, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < pages.length; i++)
                Container(
                  margin: const EdgeInsets.all(4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _page
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: FilledButton(
              onPressed: _page == pages.length - 1
                  ? _finish
                  : () => _controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut),
              child: Text(
                  _page == pages.length - 1 ? t.introDone : t.introNext),
            ),
          ),
        ]),
      ),
    );
  }
}
