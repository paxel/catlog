import 'dart:math';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

/// Offline name proposals: a big global list (classics, ancient/mythic,
/// funny) merged with a small bonus list for the active language.
/// Never proposes a name already in the catalog — no second Luna.
final Map<String, List<String>> _cache = {};

Future<List<String>> _load(String asset) async {
  if (_cache.containsKey(asset)) return _cache[asset]!;
  List<String> names;
  try {
    names = (await rootBundle.loadString(asset))
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
  } catch (_) {
    names = const [];
  }
  return _cache[asset] = names;
}

Future<String?> proposeCatName(CatalogStore store, Locale locale) async {
  final pool = [
    ...await _load('assets/names/global.txt'),
    ...await _load('assets/names/${locale.languageCode}.txt'),
  ];
  final used = {
    for (final c in store.cats()) c.name.toLowerCase().trim(),
  };
  final free = [
    for (final n in pool)
      if (!used.contains(n.toLowerCase())) n
  ];
  if (free.isEmpty) return null;
  return free[Random().nextInt(free.length)];
}
