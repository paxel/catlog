import 'package:catalog_core/catalog_core.dart';

/// Human-readable label for a raw field key, resolving user Fields through
/// their definitions and mapping reserved keys to friendly names.
String fieldLabel(CatalogStore store, String key) {
  if (key == Keys.name) return 'Name';
  if (key == Keys.clowder) return 'Clowder';
  if (key == Keys.profileImage) return 'Profile image';
  if (key == Keys.type) return 'Created as';
  if (key == Keys.deleted) return 'Deleted';
  if (key.startsWith(Keys.imagePrefix)) return 'Photo';
  for (final def in store.fieldDefs()) {
    if (def.key == key) return def.name;
  }
  return key;
}

/// Human-readable rendering of a raw entry value for a field key.
String valueLabel(CatalogStore store, String key, String? value) {
  if (value == null) return '—';
  if (key == Keys.clowder) {
    final name = store.current(value, Keys.name);
    return name ?? value;
  }
  if (key.startsWith(Keys.imagePrefix)) return value; // added / deleted
  if (key == Keys.profileImage) return 'changed';
  return value;
}
