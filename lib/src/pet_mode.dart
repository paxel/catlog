import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';

/// Pet mode (#93): a catalog of pets and households instead of cats and
/// clowders. The choice belongs to the catalog — an ordinary synced
/// entry, so every device shows that data the same way; older versions
/// ignore it and keep saying "cat". Words, placeholder pictures and
/// name proposals follow it; the data does not change.
final ValueNotifier<bool> petMode = ValueNotifier(false);

const catalogModeEntity = 'catalog:mode';

/// Whether [entity] is a catalog-wide setting like the mode — synced
/// like everything else, but configuration, not news about an animal.
bool isCatalogSetting(String entity) => entity.startsWith('catalog:');
const catalogModeField = 'mode';

bool isPetMode(CatalogStore store) =>
    store.current(catalogModeEntity, catalogModeField) == 'pets';

/// Sets the open catalog's choice and lets the app's words follow.
void setPetMode(CatalogStore store, bool pets) {
  writePetMode(store, pets);
  petMode.value = pets;
}

/// Records the choice in [store] alone — for a catalog that is not the
/// open one, whose words must not change under you.
void writePetMode(CatalogStore store, bool pets) =>
    store.append(catalogModeEntity, catalogModeField, pets ? 'pets' : 'cats');

/// Reads the open catalog's choice — at start, after a switch, and
/// whenever the home screen shows (a sync may have brought it).
void refreshPetMode(CatalogStore store) =>
    petMode.value = store.isOpen && isPetMode(store);

/// The species picked last when adding an animal — the next dialog
/// starts there (#94). Device-local.
const lastSpeciesKey = 'lastSpecies';
