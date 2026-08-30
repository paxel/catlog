import 'fields.dart';

/// Species a pets catalog offers when an animal is added (#94). Values
/// are stored as they are here; the UI translates the display.
const speciesPresets = [
  'cat',
  'dog',
  'rabbit',
  'guinea pig',
  'hamster',
  'bird',
  'horse',
  'tortoise',
  'ferret',
];

/// Built-in breed lists per species (#95). The cat list is the starter
/// Breed field's own option list, kept there so a catalog that edited
/// it keeps its edits; the others live here. Species without a list
/// get free text only.
const breedsBySpecies = {
  'dog': [
    'Labrador Retriever',
    'German Shepherd',
    'Golden Retriever',
    'French Bulldog',
    'Beagle',
    'Poodle',
    'Dachshund',
    'Border Collie',
    'Jack Russell Terrier',
    'Chihuahua',
    'mixed',
  ],
  'rabbit': [
    'Dwarf Lop',
    'Netherland Dwarf',
    'Lionhead',
    'Flemish Giant',
    'Rex',
    'mixed',
  ],
  'guinea pig': ['Abyssinian', 'American', 'Peruvian', 'Teddy', 'mixed'],
  'horse': [
    'Haflinger',
    'Icelandic',
    'Arabian',
    'Thoroughbred',
    'Warmblood',
    'Shetland Pony',
    'mixed',
  ],
};

/// The breed options for an animal of [species]: a cat gets the field's
/// own list; every other species gets its built-in list plus what
/// keepers added for it; an animal without a species gets free text
/// only.
List<String> breedOptions(FieldDef breed, String? species) {
  if (species == null || species.isEmpty) return const [];
  if (species == 'cat') return breed.options;
  return [
    ...?breedsBySpecies[species],
    for (final o in breed.extraOptions[species] ?? const <String>[])
      if (!(breedsBySpecies[species] ?? const []).contains(o)) o,
  ];
}
