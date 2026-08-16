import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'import_summary.dart';
import 'l10n.dart';

/// Which synced-in events slide in as toasts. Adoptions and births are
/// on by default; the somber ones are opt-in.
const toastKinds = [
  ('adoption', true),
  ('birth', true),
  ('death', false),
  ('escape', false),
  ('move', false),
];

bool toastEnabled(CatalogStore store, String kind) {
  final saved = store.localSetting('toast:$kind');
  if (saved != null) return saved == 'on';
  return toastKinds.firstWhere((k) => k.$1 == kind).$2;
}

void setToastEnabled(CatalogStore store, String kind, bool on) =>
    store.setLocalSetting('toast:$kind', on ? 'on' : 'off');

/// Fires the configured toasts for one sync's applied entries. Local
/// changes never toast — the confetti covers local adoptions.
void showEventToasts(
    BuildContext context, CatalogStore store, List<Entry> applied) {
  final t = context.t;
  final summary = classifyImport(store, applied);
  String name(String id) => store.current(id, Keys.name) ?? '?';
  String home(String catId) {
    final clowder = store.current(catId, Keys.clowder);
    return clowder == null ? '?' : name(clowder);
  }

  final births = [
    for (final id in summary.newCats)
      if (store.current(id, 'f:mother') != null) id
  ];
  final moves = <String>{
    for (final e in applied)
      if (e.field == Keys.clowder && e.value != null)
        store.resolveEntity(e.entity)
  }..removeAll({...summary.adopted, ...summary.newCats});

  final messages = <(String, Color?)>[
    if (toastEnabled(store, 'adoption'))
      for (final id in summary.adopted)
        (t.toastAdopted(name(id), home(id)), Colors.green.shade700),
    if (toastEnabled(store, 'birth'))
      for (final id in births)
        (t.toastBorn(name(id)), Colors.teal.shade600),
    if (toastEnabled(store, 'death'))
      for (final id in summary.deceased)
        (t.toastDeceased(name(id)), Colors.blueGrey.shade700),
    if (toastEnabled(store, 'escape'))
      for (final id in summary.escaped)
        (t.toastEscaped(name(id)), Colors.orange.shade800),
    if (toastEnabled(store, 'move'))
      for (final id in moves)
        (t.toastMoved(name(id), home(id)), null),
  ];
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  for (final (text, color) in messages.take(5)) {
    messenger.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ));
  }
}

/// The per-event configuration page (About → What to announce).
class ToastSettingsScreen extends StatefulWidget {
  final CatalogStore store;

  const ToastSettingsScreen({super.key, required this.store});

  @override
  State<ToastSettingsScreen> createState() => _ToastSettingsScreenState();
}

class _ToastSettingsScreenState extends State<ToastSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final labels = {
      'adoption': t.toastKindAdoptions,
      'birth': t.toastKindBirths,
      'death': t.toastKindDeaths,
      'escape': t.toastKindEscapes,
      'move': t.toastKindMoves,
    };
    return Scaffold(
      appBar: AppBar(title: Text(t.toastSettingsTitle)),
      body: ListView(children: [
        for (final (kind, _) in toastKinds)
          SwitchListTile(
            title: Text(labels[kind]!),
            value: toastEnabled(widget.store, kind),
            onChanged: (v) =>
                setState(() => setToastEnabled(widget.store, kind, v)),
          ),
      ]),
    );
  }
}
