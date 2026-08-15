import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

export '../l10n/app_localizations.dart';

/// In-app language override; null follows the system locale. Set from
/// the language picker, initialized from local settings at startup.
final ValueNotifier<Locale?> localeOverride = ValueNotifier(null);

extension L10nContext on BuildContext {
  /// The app's translations for the ambient locale.
  AppLocalizations get t => AppLocalizations.of(this)!;
}
