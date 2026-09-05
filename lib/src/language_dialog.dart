import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// Native names of the supported languages, for the picker.
const _endonyms = {
  'ar': 'العربية',
  'bg': 'Български',
  'bs': 'Bosanski',
  'cs': 'Čeština',
  'da': 'Dansk',
  'de': 'Deutsch',
  'el': 'Ελληνικά',
  'en': 'English',
  'es': 'Español',
  'et': 'Eesti',
  'fa': 'فارسی',
  'fi': 'Suomi',
  'fr': 'Français',
  'ga': 'Gaeilge',
  'he': 'עברית',
  'hr': 'Hrvatski',
  'hu': 'Magyar',
  'is': 'Íslenska',
  'it': 'Italiano',
  'ja': '日本語',
  'lt': 'Lietuvių',
  'lv': 'Latviešu',
  'mk': 'Македонски',
  'mt': 'Malti',
  'nl': 'Nederlands',
  'no': 'Norsk',
  'pl': 'Polski',
  'pt': 'Português',
  'ro': 'Română',
  'ru': 'Русский',
  'sk': 'Slovenčina',
  'sl': 'Slovenščina',
  'sq': 'Shqip',
  'sr': 'Српски',
  'sv': 'Svenska',
  'tr': 'Türkçe',
  'uk': 'Українська',
  'zh': '中文',
};

/// The chosen language by its native name, or "System default".
String languageLabel(BuildContext context, CatalogStore store) {
  final code = store.localSetting('locale');
  return _endonyms[code] ?? context.t.systemDefault;
}

/// Language picker: system default plus every supported language, by
/// native name. The choice is device-local and applies immediately.
Future<void> showLanguageDialog(
    BuildContext context, CatalogStore store) async {
  final current = store.localSetting('locale');
  final chosen = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(context.t.language),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop('system'),
          child: Row(children: [
            if (current == null)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.check, size: 18),
              ),
            Expanded(child: Text(context.t.systemDefault)),
          ]),
        ),
        for (final code in _endonyms.keys)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(code),
            child: Row(children: [
              if (current == code)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.check, size: 18),
                ),
              Expanded(child: Text(_endonyms[code]!)),
            ]),
          ),
      ],
    ),
  );
  if (chosen == null) return;
  if (chosen == 'system') {
    store.setLocalSetting('locale', '');
    localeOverride.value = null;
  } else {
    store.setLocalSetting('locale', chosen);
    localeOverride.value = Locale(chosen);
  }
}
