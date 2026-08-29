import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Keys of the user flows running right now (#91). Buttons watch it to
/// show they are busy instead of taking a second press.
final ValueNotifier<Set<String>> busyFlows = ValueNotifier(const {});

bool isBusy(String key) => busyFlows.value.contains(key);

/// Runs [body] unless a flow with [key] is already running — then does
/// nothing and returns null: a second press during a slow GPS fix or
/// an open camera must not start a second camera. A plugin's
/// [PlatformException] ends the flow with its own message instead of a
/// crash; image_picker's `already_active` says nothing, the earlier
/// flow is still on screen. The key is released whatever happens.
Future<T?> runExclusive<T>(
  String key,
  Future<T?> Function() body, {
  BuildContext? context,
}) async {
  if (isBusy(key)) return null;
  busyFlows.value = {...busyFlows.value, key};
  try {
    return await body();
  } on PlatformException catch (e) {
    if (e.code != 'already_active' && context != null && context.mounted) {
      ScaffoldMessenger.maybeOf(context)
          ?.showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
    }
    return null;
  } finally {
    busyFlows.value = {...busyFlows.value}..remove(key);
  }
}

/// [icon] while idle, a small spinner while any of [keys] runs.
class BusyIcon extends StatelessWidget {
  final Set<String> keys;
  final IconData icon;

  const BusyIcon({super.key, required this.keys, required this.icon});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: busyFlows,
    builder: (context, busy, _) => busy.any(keys.contains)
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Icon(icon),
  );
}
