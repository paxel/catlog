import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

export '../l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  /// The app's translations for the ambient locale.
  AppLocalizations get t => AppLocalizations.of(this)!;
}
