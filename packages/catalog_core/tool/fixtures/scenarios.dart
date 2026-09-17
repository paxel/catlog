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

  /// Edits the written folder and bundle after the writer published
  /// them: forged lines, stripped signatures, a second key. What the
  /// readers then see is what a hostile or old partner would send.
  final void Function(Tamper t)? tamper;

  /// When set, the untampered folder is kept as `folder-later/` and the
  /// readers run a second round on it after the first: what a cloud
  /// client that copies photos after entries looks like.
  final bool later;

  const Scenario(this.name, this.about, this.build,
      {this.tamper, this.later = false});
}

/// The written files, open for editing by a scenario's tamper step.
class Tamper {
  /// The writer's device id.
  final String writer;

  /// Lines of the writer's folder file, decoded; written back as edited.
  final List<Map<String, dynamic>> folderLines;

  /// Lines of the bundle's entries file, decoded; written back as edited.
  final List<Map<String, dynamic>> bundleLines;

  /// Extra key files for the folder's `keys/` directory, by file name.
  final Map<String, List<KeyRecord>> extraKeyFiles = {};

  /// Extra records appended to the bundle's `keys.json`.
  final List<KeyRecord> extraBundleKeys = [];

  /// When set, the writer's own key record is republished with this
  /// `since`, in the folder and the bundle.
  int? sinceOverride;

  /// Photo hashes removed from the folder and the bundle.
  final Set<String> removedBlobs = {};

  /// Photo hashes removed from the folder only: still on their way
  /// there, already inside the bundle.
  final Set<String> removedFolderBlobs = {};

  /// Photo hashes whose folder file is replaced by other bytes; the
  /// bundle keeps the real ones (a phone refuses to import a bundle
  /// with a wrong photo, so that case is the folder's alone).
  final Set<String> corruptedFolderBlobs = {};

  /// Extra photo files, by name, in the folder and the bundle: what no
  /// entry names.
  final Map<String, List<int>> strayBlobs = {};

  /// The photo hashes the writer's lines name as added.
  List<String> get imageHashes => [
        for (final l in folderLines)
          if ((l['field'] as String).startsWith(Keys.imagePrefix) &&
              l['value'] == 'added')
            (l['field'] as String).substring(Keys.imagePrefix.length)
      ];

  Tamper(this.writer, this.folderLines, this.bundleLines);

  /// The last line the writer wrote, in both files.
  Map<String, dynamic> get last => folderLines.last;

  /// Appends a line to both files: [edit] applied to a copy of [last].
  void forgeAfterLast(
      Map<String, dynamic> Function(Map<String, dynamic>) edit) {
    final row = {...last, 'dseq': last['dseq'] + 1};
    folderLines.add(edit({...row}));
    bundleLines.add(edit({...row}));
  }

  /// Applies [edit] to the line with [dseq] in both files.
  void editLine(int dseq, void Function(Map<String, dynamic>) edit) {
    for (final lines in [folderLines, bundleLines]) {
      edit(lines.firstWhere((l) => l['dseq'] == dseq));
    }
  }
}

/// A key that is nobody's: made from a fixed seed, so the corpus stays
/// the same.
final intruderKey =
    SigningKey.fromSeed(Uint8List.fromList(List.generate(32, (i) => 77 + i)));

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
  Scenario(
    'forged-line',
    'The writer\'s file carries one extra line under a new number with '
        'another value and a copied signature: refused, the value before '
        'it stands, the version vector does not move past it.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.append(miezi, 'f:color', 'tabby');
    },
    tamper: (t) => t.forgeAfterLast((row) => {...row, 'value': 'forged'}),
  ),
  Scenario(
    'unsigned-rows',
    'Rows without a signature: one below the key\'s first signed number '
        'passes as from before the key, one at a new number above it is '
        'refused.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.append(miezi, 'f:color', 'tabby');
    },
    tamper: (t) {
      // The key record says signing began at 1, so a stripped row at a
      // held number is not looked at, and a stripped row at a new number
      // is refused. The writer's key list is rewritten to start at the
      // number of the colour row, so the stripped colour row still passes.
      final colour = t.folderLines.lastWhere((l) => l['field'] == 'f:color');
      t.editLine(colour['dseq'] as int, (l) => l.remove('sig'));
      t.forgeAfterLast((row) {
        final r = {...row, 'value': 'unsigned'};
        r.remove('sig');
        return r;
      });
      t.sinceOverride = (colour['dseq'] as int) + 1;
    },
  ),
  Scenario(
    'fields-all',
    'A definition of every Field type with its options, display and '
        'lookup, and a value of each on a Cat and a Clowder: text, yes/no, '
        'a partial date, a number, a choice, a location with a flier '
        'position, a cat reference, an ID, a unit value in grams, Looks '
        'tags. One value cleared again, one set on a starter field.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      final tom = cat(w, 2, 'Tom', clowderId: home);
      final mood = w.defineField('Mood', FieldType.choice,
          scope: FieldScope.cat, options: ['calm', 'wild']);
      w.setFieldOptions(mood, ['calm', 'wild', 'sleepy']);
      w.renameField(mood, 'Temper');
      final registry = w.defineField('Vet Registry', FieldType.id,
          scope: FieldScope.cat,
          idDisplay: IdDisplay.qr,
          lookupUrl: 'https://vet.example/{value}');
      w.setFieldLookupUrl(registry, 'https://registry.example/id/{value}');
      w.defineField('Indoor', FieldType.yesNo, scope: FieldScope.both);
      w.defineField('Visits', FieldType.number, scope: FieldScope.both);
      w.defineField('Height', FieldType.unitValue,
          scope: FieldScope.cat, dimension: Dimension.length);
      w.defineField('Notes', FieldType.text, scope: FieldScope.clowder);
      w.append(miezi, 'f:temper', 'sleepy');
      w.append(miezi, 'f:vet-registry', 'DE-123 456');
      w.append(miezi, 'f:indoor', 'yes');
      w.append(miezi, 'f:visits', '3');
      w.append(miezi, 'f:height', '24.5');
      w.append(miezi, 'f:weight', '4250');
      w.append(miezi, 'f:birthdate', '2021-05');
      w.append(miezi, 'f:chipid', '276098100123456');
      w.append(miezi, 'f:looks', 'size=medium; colours=black,white; fur=short');
      w.append(miezi, 'f:mother', catId(2));
      w.recordPosition(miezi, 51.34, 12.37);
      w.recordPosition(miezi, 51.35, 12.38, kind: PositionKind.flier);
      w.append(tom, 'f:color', 'ginger');
      w.append(tom, 'f:color', null);
      w.append(home, 'f:indoor', 'no');
      w.append(home, 'f:visits', '12');
      w.append(home, 'f:notes', 'Ring twice.');
      w.append(home, 'f:phone', '+49 341 000');
    },
  ),
  Scenario(
    'history-reverts',
    'One Field changed four times, one change backdated, one corrected '
        'into another value, one taken back and one restored: the current '
        'value follows the effective dates, the history shows every row '
        'and marks the hidden ones.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.append(miezi, 'f:weight', '3000', date: DateTime.utc(2026, 1, 5));
      w.append(miezi, 'f:weight', '3200', date: DateTime.utc(2026, 1, 20));
      w.append(miezi, 'f:weight', '3100', date: DateTime.utc(2026, 1, 12));
      w.append(miezi, 'f:weight', '3500', date: DateTime.utc(2026, 2, 1));
      final rows = w.fieldHistory(miezi, 'f:weight');
      final wrong = rows.firstWhere((e) => e.value == '3200');
      w.correctEntry(wrong.seq, '3250');
      final last = rows.firstWhere((e) => e.value == '3500');
      w.removeEntry(last.seq);
      final early = rows.firstWhere((e) => e.value == '3000');
      w.removeEntry(early.seq);
      w.restoreEntry(early.seq);
      w.append(miezi, 'f:remarks', 'shy');
      w.append(miezi, 'f:remarks', 'shy but curious');
    },
  ),
  Scenario(
    'species-pet',
    'A Catalog in Pet Mode with a dog, a rabbit and a cat: species '
        'preset values, a breed typed for the dog that the Breed field '
        'learns for dogs only, a deceased date, a per-species option list.',
    (w) {
      w.append('catalog:mode', 'mode', 'pets');
      final home = clowder(w, 1, 'Household');
      final rex = cat(w, 1, 'Rex', clowderId: home, species: 'dog');
      w.append(rex, 'f:breed', 'Mutt');
      w.learnBreed(rex, 'Mutt');
      w.append(rex, 'f:breed', 'Beagle');
      w.learnBreed(rex, 'Beagle');
      final bunny = cat(w, 2, 'Bunny', clowderId: home, species: 'rabbit');
      w.append(bunny, 'f:breed', 'Lionhead');
      w.learnBreed(bunny, 'Lionhead');
      final miezi = cat(w, 3, 'Miezi', clowderId: home);
      w.append(miezi, 'f:breed', 'Ragdoll');
      w.learnBreed(miezi, 'Ragdoll');
      w.append(miezi, 'f:deceased', '2026-02-14');
      w.addFieldOption('fielddef:breed', 'rabbit', 'Angora');
    },
  ),
  Scenario(
    'photo-missing',
    'A photo the entries name is in neither the folder nor the bundle: '
        'the entry lands, the photo counts as missing, the round says '
        'which one.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.addImage(miezi, photo(20, 20));
    },
    tamper: (t) => t.removedBlobs.addAll(t.imageHashes),
  ),
  Scenario(
    'photo-late',
    'The photo is still on its way in the first round and there in the '
        'second: the second round fetches it without a tap.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.addImage(miezi, photo(20, 20));
    },
    tamper: (t) => t.removedFolderBlobs.addAll(t.imageHashes),
    later: true,
  ),
  Scenario(
    'photo-unknown',
    'A photo file no entry names sits in the folder and the bundle: '
        'ignored, never stored.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      cat(w, 1, 'Miezi', clowderId: home);
    },
    tamper: (t) => t.strayBlobs['${'e' * 64}.jpg'] = photo(10, 10),
  ),
  Scenario(
    'photo-corrupt',
    'The folder\'s copy of a photo does not match its name: not taken, '
        'the reason names the bytes that came back; the next round finds '
        'the real one, as the bundle carried it all along.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      w.addImage(miezi, photo(20, 20));
    },
    tamper: (t) => t.corruptedFolderBlobs.addAll(t.imageHashes),
    later: true,
  ),
  Scenario(
    'photo-deleted',
    'A photo added and then deleted by the writer: the marker travels, '
        'the bytes do not, the profile picture falls back to the next one.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      final miezi = cat(w, 1, 'Miezi', clowderId: home);
      final first = w.addImage(miezi, photo(20, 20));
      w.addImage(miezi, photo(21, 21));
      w.setProfileImage(miezi, first);
      w.deleteImage(miezi, first);
    },
  ),
  Scenario(
    'second-key',
    'A second, different key claiming the writer\'s device arrives next to '
        'the pinned one, in a key file of its own and appended to the '
        'bundle\'s list: ignored and reported, the first key stands.',
    (w) {
      final home = clowder(w, 1, 'Foster Home');
      cat(w, 1, 'Miezi', clowderId: home);
    },
    tamper: (t) {
      final record = KeyRecord.make(intruderKey, t.writer, 1);
      t.extraKeyFiles['intruder.json'] = [record];
      t.extraBundleKeys.add(record);
    },
  ),
];
