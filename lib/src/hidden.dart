import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';

/// The transient "show hidden" view toggle — deliberately not persisted:
/// hiding is the normal state, peeking is a moment.
final ValueNotifier<bool> showHidden = ValueNotifier(false);

/// The single filtering point every view reads through (spec: Hidden is
/// display-only; data syncs unchanged).
extension VisibleReads on CatalogStore {
  bool visible(String id) => showHidden.value || !isHidden(id);

  List<EntityView> visibleCats({String? clowderId}) =>
      [for (final c in cats(clowderId: clowderId)) if (visible(c.id)) c];

  List<EntityView> visibleClowders() =>
      [for (final c in clowders()) if (visible(c.id)) c];

  List<EntityView> visibleStrays() =>
      [for (final c in strays()) if (visible(c.id)) c];

  List<FieldDef> visibleFieldDefs({FieldScope? scope}) =>
      [for (final d in fieldDefs(scope: scope)) if (visible(d.id)) d];
}
