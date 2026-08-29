import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import 'calendar_mirror.dart';
import 'calendar_port.dart';
import 'device_calendar_port.dart';

/// Runs the calendar mirror after a plan changed, from any screen.
/// Every failure is named and switches the mirror off — a silent
/// failure would pose as a working mirror (the 1.0.0 lesson).
///
/// Fire-and-forget: the screen must not wait on the platform calendar.
void mirrorAfterChange(BuildContext context, CatalogStore store,
    {CalendarPort? port}) {
  if (!calendarMirrorEnabled(store)) return;
  if (port == null && !deviceCalendarAvailable) return;
  final t = context.t;
  final messenger = ScaffoldMessenger.maybeOf(context);
  reconcileCalendar(store, port ?? DeviceCalendarPort(), t).then((outcome) {
    final message = mirrorFailureMessage(t, outcome);
    // A catalog switched away mid-reconcile is closed by now: nothing
    // to record, nothing to report (#89).
    if (message == null || !store.isOpen) return;
    store.setLocalSetting(calendarMirrorEnabledKey, 'off');
    messenger?.showSnackBar(SnackBar(content: Text(message)));
  }).catchError((_) {}, test: (e) => e is StateError && !store.isOpen);
}

/// The cause-plus-fix text for a failed reconcile, null when it worked
/// (or the mirror is simply off).
String? mirrorFailureMessage(AppLocalizations t, MirrorOutcome outcome) =>
    switch (outcome) {
      MirrorOutcome.ok || MirrorOutcome.off || MirrorOutcome.abandoned => null,
      MirrorOutcome.noAccess => t.calendarPermissionDenied,
      MirrorOutcome.noCalendarChosen => t.calendarNotChosen,
      MirrorOutcome.calendarGone => t.calendarGone,
    };
