import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import 'mode_l10n.dart';
import 'pet_mode.dart';

export '../l10n/app_localizations.dart';

/// In-app language override; null follows the system locale. Set from
/// the language picker, initialized from local settings at startup.
final ValueNotifier<Locale?> localeOverride = ValueNotifier(null);

extension L10nContext on BuildContext {
  /// The app's translations for the ambient locale, with pet mode
  /// applied (#93).
  AppLocalizations get t =>
      ModeLocalizations(AppLocalizations.of(this)!, petMode.value);
}
