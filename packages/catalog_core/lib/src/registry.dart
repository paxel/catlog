import 'fields.dart';

/// Pet registries (Tasso, FINDEFIX, Petlog, …) differ per country and
/// none of them offers an open interface. cat(a)log therefore knows
/// them only as ID Fields carrying a lookup template: a URL with
/// `{value}` where the number goes. Tapping such a value opens the
/// service in the browser — the app itself never calls them.
const lookupPlaceholder = '{value}';

/// A ready-made registry offered when an ID Field is created, and used
/// to recognize a link found on a flier. Only services with a plain
/// GET URL can be listed; everything else is learned from a scan.
typedef RegistryPreset = ({String name, String template});

/// The one registry with a documented, parameter-addressable report
/// page. FINDEFIX, PETMAXX and Europetnet search by POST only, so they
/// cannot be offered — a poster carrying their link teaches the app the
/// template instead (see [learnLookupTemplate]).
const registryPresets = <RegistryPreset>[
  (
    name: 'Tasso',
    template:
        'https://www.tasso.net/Tierregister/Suchmeldungen?snr=$lookupPlaceholder',
  ),
];

/// The URL for looking [value] up in the service of [def], or null when
/// the Field has no template or the value is empty.
String? lookupUrl(FieldDef def, String value) {
  final template = def.lookupUrl;
  if (template == null || value.trim().isEmpty) return null;
  if (!isWebLookup(template)) return null;
  return buildLookupUrl(template, value);
}

/// [template] with the placeholder replaced by the encoded [value].
String buildLookupUrl(String template, String value) => template
    .replaceAll(lookupPlaceholder, Uri.encodeComponent(value.trim()));

/// The identifier [url] carries for [template], or null when the link
/// belongs to another service. Extra query parameters are ignored on
/// both sides — a scanned Tasso link brings `lang` and `lp` along, and
/// the template of course does not.
String? idFromLookupUrl(String template, String url) {
  final pattern = Uri.tryParse(template);
  final scanned = Uri.tryParse(url);
  if (pattern == null || scanned == null) return null;
  if (pattern.host.toLowerCase() != scanned.host.toLowerCase()) return null;

  // The placeholder sits in a query parameter: read that parameter.
  for (final entry in pattern.queryParameters.entries) {
    if (entry.value != lookupPlaceholder) continue;
    if (_path(pattern) != _path(scanned)) return null;
    final value = scanned.queryParameters[entry.key];
    return (value == null || value.isEmpty) ? null : value;
  }

  // Or in a path segment: every other segment must match.
  final want = pattern.pathSegments;
  final have = scanned.pathSegments;
  if (want.length != have.length) return null;
  String? found;
  for (var i = 0; i < want.length; i++) {
    if (want[i] == lookupPlaceholder) {
      found = have[i];
    } else if (want[i] != have[i]) {
      return null;
    }
  }
  return (found == null || found.isEmpty) ? null : found;
}

/// The preset [url] belongs to, with the identifier it carries — the
/// app can then offer to store that number in a Field of that service.
({RegistryPreset preset, String value})? recognizeLookupUrl(String url) {
  for (final preset in registryPresets) {
    final value = idFromLookupUrl(preset.template, url);
    if (value != null) return (preset: preset, value: value);
  }
  return null;
}

/// Whether [template] (or a scanned link) may be opened from an ID
/// value: web links only. Templates travel as synced entries, so a
/// partner's or a poster's `sms:`/`tel:`/app scheme must not become a
/// tap target on every device.
bool isWebLookup(String template) {
  final uri = Uri.tryParse(template);
  return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
}

/// Turns a scanned [url] into a template by replacing [value] with the
/// placeholder — this is how an unknown registry becomes usable. Null
/// when the URL does not carry the value at all. Volatile extras
/// (language, paging) are dropped: only the identifying parameter
/// survives.
String? learnLookupTemplate(String url, String value) {
  final scanned = Uri.tryParse(url);
  final wanted = normalizeId(value);
  if (scanned == null || wanted.isEmpty || !isWebLookup(url)) return null;

  for (final entry in scanned.queryParameters.entries) {
    if (normalizeId(entry.value) != wanted) continue;
    return Uri(
      scheme: scanned.scheme,
      host: scanned.host,
      port: scanned.hasPort ? scanned.port : null,
      path: scanned.path,
      queryParameters: {entry.key: lookupPlaceholder},
    ).toString().replaceAll(
        Uri.encodeQueryComponent(lookupPlaceholder), lookupPlaceholder);
  }

  final segments = [...scanned.pathSegments];
  for (var i = 0; i < segments.length; i++) {
    if (normalizeId(segments[i]) != wanted) continue;
    segments[i] = lookupPlaceholder;
    return Uri(
      scheme: scanned.scheme,
      host: scanned.host,
      port: scanned.hasPort ? scanned.port : null,
      pathSegments: segments,
    ).toString().replaceAll(
        Uri.encodeComponent(lookupPlaceholder), lookupPlaceholder);
  }
  return null;
}

/// The parts of [url] that could be the identifier — query parameters
/// and path segments that carry digits. Offered when a link belongs to
/// a registry the app does not know yet, so the user can point at the
/// number instead of typing a template.
List<({String where, String value})> idCandidatesIn(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return const [];
  bool looksLikeId(String v) =>
      v.length >= 3 && v.length <= 40 && RegExp(r'\d').hasMatch(v);
  return [
    for (final e in uri.queryParameters.entries)
      if (looksLikeId(e.value)) (where: e.key, value: e.value),
    for (final segment in uri.pathSegments)
      if (looksLikeId(segment)) (where: '/', value: segment),
  ];
}

/// Every http(s) link in a block of text — flier OCR delivers them
/// mid-sentence, often without a scheme.
List<String> urlsIn(String text) {
  final result = <String>[];
  final pattern = RegExp(
      r'(?:https?://|www\.)[^\s<>"' r"'" r']+',
      caseSensitive: false);
  for (final m in pattern.allMatches(text)) {
    var url = m.group(0)!;
    // Trailing sentence punctuation is not part of the link.
    url = url.replaceAll(RegExp(r'[.,;:)\]]+$'), '');
    if (!url.toLowerCase().startsWith('http')) url = 'https://$url';
    if (!result.contains(url)) result.add(url);
  }
  return result;
}

String _path(Uri uri) {
  final path = uri.path;
  if (path.length > 1 && path.endsWith('/')) {
    return path.substring(0, path.length - 1);
  }
  return path;
}
