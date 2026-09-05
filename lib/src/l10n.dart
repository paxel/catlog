import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import 'mode_l10n.dart';
import 'pet_mode.dart';

export '../l10n/app_localizations.dart';

/// In-app language override; null follows the system locale. Set from
/// the language picker, initialized from local settings at startup.
final ValueNotifier<Locale?> localeOverride = ValueNotifier(null);

/// The word typed to confirm a deletion: "Delete" in the app's language,
/// in capitals so it reads as a command. A fixed word, not the name of
/// what goes — a long name may not even fit on the screen.
String deleteWord(AppLocalizations t) => t.delete.toUpperCase();

/// Whether [typed] is the word, in any casing.
bool confirmsDelete(String typed, AppLocalizations t) =>
    typed.trim().toUpperCase() == deleteWord(t);

extension L10nContext on BuildContext {
  /// The app's translations for the ambient locale, with pet mode
  /// applied (#93).
  AppLocalizations get t =>
      ModeLocalizations(AppLocalizations.of(this)!, petMode.value);
}
