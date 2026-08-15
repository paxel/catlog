import 'fields.dart';
import 'store.dart';

/// All non-deleted Cats as RFC 4180 CSV (UTF-8, comma, CRLF): built-in
/// columns first (name, clowder, photos), then every cat-applicable
/// Field alphabetically by slug — a stable order spreadsheets and
/// shelter software can rely on.
String exportCsv(CatalogStore store) {
  final defs = store.fieldDefs(scope: FieldScope.cat)
    ..sort((a, b) => a.slug.compareTo(b.slug));
  final header = ['name', 'clowder', 'photos', ...defs.map((d) => d.slug)];
  final lines = [header.map(_quote).join(',')];

  for (final cat in store.cats()) {
    final clowderId = store.current(cat.id, Keys.clowder);
    final row = [
      cat.name,
      clowderId == null
          ? 'stray'
          : store.current(clowderId, Keys.name) ?? '',
      store.images(cat.id).length.toString(),
      for (final def in defs) store.current(cat.id, def.key) ?? '',
    ];
    lines.add(row.map(_quote).join(','));
  }
  return lines.join('\r\n');
}

String _quote(String value) {
  if (value.contains(',') ||
      value.contains('"') ||
      value.contains('\n') ||
      value.contains('\r')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}
