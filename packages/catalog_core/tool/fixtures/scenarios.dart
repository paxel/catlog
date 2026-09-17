import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;

/// One fixture scenario: a writer catalog whose files the desktop core
/// has to read, and whose state it has to reproduce.
class Scenario {
  final String name;

  /// What the scenario is about, for the corpus README.
  final String about;

  /// Fills the writer's catalog. Entity ids are fixed so the corpus is
  /// the same on every run.
  final void Function(CatalogStore writer) build;

  const Scenario(this.name, this.about, this.build);
}

/// A small JPEG the way the store keeps one; different sizes give
/// different hashes.
Uint8List photo(int w, int h) => CatalogStore.compressImage(
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h))));

String clowderId(int n) =>
    'clowder:00000000-0000-4000-8000-${n.toString().padLeft(12, '0')}';
String catId(int n) =>
    'cat:00000000-0000-4000-8000-${n.toString().padLeft(12, '0')}';

/// Creates a Clowder under a fixed id, the way [CatalogStore.createClowder]
/// does under a random one.
String clowder(CatalogStore s, int n, String name) {
  final id = clowderId(n);
  s.append(id, Keys.type, Kinds.clowder);
  s.append(id, Keys.name, name);
  return id;
}

/// Creates a Cat under a fixed id, the way [CatalogStore.createCat] does.
String cat(CatalogStore s, int n, String name,
    {String? clowderId, String species = 'cat'}) {
  final id = catId(n);
  s.append(id, Keys.type, Kinds.cat);
  s.append(id, Keys.name, name);
  s.append(id, 'f:species', species);
  if (clowderId != null) s.append(id, Keys.clowder, clowderId);
  return id;
}

final scenarios = <Scenario>[
  Scenario(
    'fresh',
    'A fresh Catalog: two Clowders with address and status, three Cats '
        'with names, one a Stray; photos on two of them, a chosen Profile '
        'Image on one.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      w.append(home, 'f:address', 'Katzenweg 3, Leipzig');
      w.append(home, 'f:status', 'foster');
      w.append(home, 'f:responsible', 'Ada');
      final barn = clowder(w, 2, 'Barn');
      w.append(barn, 'f:status', 'barn');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.append(miezi, 'f:gender', 'female');
      w.append(miezi, 'f:color', 'tabby');
      final first = w.addImage(miezi, photo(40, 30));
      final second = w.addImage(miezi, photo(30, 40));
      w.setProfileImage(miezi, second);
      final tom = cat(w, 2, 'Tom', clowderId: barn);
      w.append(tom, 'f:gender', 'male');
      w.addImage(tom, photo(24, 24));
      cat(w, 3, 'Wanderer');
      assert(first != second);
    },
  ),
];
