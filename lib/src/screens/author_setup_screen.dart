import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../spotlight.dart';

/// First-launch screen: asks for the Author name that every change made on
/// this device will be attributed to (see CONTEXT.md: Author).
class AuthorSetupScreen extends StatefulWidget {
  final CatalogStore store;
  final VoidCallback onDone;

  const AuthorSetupScreen(
      {super.key, required this.store, required this.onDone});

  @override
  State<AuthorSetupScreen> createState() => _AuthorSetupScreenState();
}

class _AuthorSetupScreenState extends State<AuthorSetupScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Testers and developers install again and again: one tick and the
  /// intro and every tip count as seen. Settings brings them back.
  bool _skipTour = false;

  void _save() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    widget.store.author = name;
    if (_skipTour) {
      widget.store.setLocalSetting('introSeen', '1');
      markAllSpotlightsSeen(widget.store);
    }
    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.t.welcomeTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text(
                  context.t.welcomeBody,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: context.t.yourName,
                    border: const OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _save(),
                ),
                const SizedBox(height: 16),
                FilledButton(
                    onPressed: _save, child: Text(context.t.start)),
                const SizedBox(height: 24),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _skipTour,
                  onChanged: (v) => setState(() => _skipTour = v ?? false),
                  title: Text(context.t.skipTour,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
