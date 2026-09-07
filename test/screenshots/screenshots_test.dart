// Screenshot generator, not a test suite: renders key screens with a
// demo catalog and real fonts, writing PNGs to docs/screenshots/.
//
// Regenerate with:
//   flutter test test/screenshots --run-skipped
@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/achievements.dart';
import 'package:catlog/src/screens/achievements_screen.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:catlog/src/map/cached_tiles.dart';
import 'package:catlog/src/screens/map_screen.dart';
import 'package:catlog/src/screens/match_candidates_screen.dart';
import 'package:catlog/src/screens/strays_screen.dart';
import 'package:catlog/src/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catlog/src/screens/field_graph_screen.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/fur_background.dart';
import 'package:catlog/src/pet_mode.dart';

Future<void> _loadRealFonts() async {
  final root = Platform.environment['FLUTTER_ROOT']!;
  final fonts = '$root/bin/cache/artifacts/material_fonts';
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      final bytes = File('$fonts/$f').readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
    await loader.load();
  }

  await load('Roboto', [
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
  ]);
  await load('MaterialIcons', ['MaterialIcons-Regular.otf']);
}

/// Today as the shots see it: the demo is dated relative to the run, so
/// chores are due, appointments lie ahead and streaks end yesterday.
final DateTime _today = DateUtils.dateOnly(DateTime.now());
DateTime _ago(int days, {int hour = 10}) =>
    DateTime(_today.year, _today.month, _today.day - days, hour);
DateTime _ahead(int days, {int hour = 10}) => _ago(-days, hour: hour);

/// Thirteen portraits in test/screenshots/demo, one per cat.
Uint8List _photo(int n) => CatalogStore.compressImage(
  File('test/screenshots/demo/cat$n.jpg').readAsBytesSync(),
);

/// Demo catalog: five homes and colonies, ten cats with portraits,
/// fields, history, chores and appointments, written by three people.
CatalogStore _demoStore() {
  final store = CatalogStore.inMemory();
  store.author = 'Alex';
  void put(
    String entity,
    String field,
    String value, {
    DateTime? date,
    String as = 'Alex',
  }) => store.append(entity, field, value, date: date ?? _ago(60), as: as);

  // ---- homes and colonies
  final home = store.createClowder('Foster Home South', date: _ago(130));
  put(home, 'f:address', 'Main Street 7, 10178 Berlin', date: _ago(130));
  put(home, 'f:responsible', 'Marta', date: _ago(130));
  put(home, 'f:phone', '+49 30 1234567', date: _ago(130));
  put(home, 'f:status', 'foster', date: _ago(130));
  store.recordPosition(home, 52.5168, 13.4008, date: _ago(130));

  final barn = store.createClowder('Old Barn', date: _ago(110));
  put(barn, 'f:address', 'Field Road 2', date: _ago(110), as: 'Marta');
  put(barn, 'f:status', 'barn', date: _ago(110), as: 'Marta');
  put(
    barn,
    'f:remarks',
    'Feeding station behind the tractor shed',
    date: _ago(100),
    as: 'Marta',
  );
  store.recordPosition(barn, 52.5236, 13.4125, date: _ago(110));

  final riverside = store.createClowder('Riverside Colony', date: _ago(95));
  put(riverside, 'f:responsible', 'Jonas', date: _ago(95), as: 'Jonas');
  put(
    riverside,
    'f:remarks',
    'Seven cats seen at once in June',
    date: _ago(80),
    as: 'Jonas',
  );
  store.recordPosition(riverside, 52.5212, 13.4098, date: _ago(95));

  final clinic = store.createClowder('Vet Clinic Dr. Koch', date: _ago(90));
  put(clinic, 'f:status', 'clinic', date: _ago(90));
  put(clinic, 'f:address', 'Park Avenue 12', date: _ago(90));
  put(clinic, 'f:phone', '+49 30 7654321', date: _ago(90));

  final millers = store.createClowder('The Millers', date: _ago(40));
  put(millers, 'f:status', 'forever-home', date: _ago(40), as: 'Marta');
  put(millers, 'f:responsible', 'Anne Miller', date: _ago(40), as: 'Marta');
  put(millers, 'f:email', 'anne@example.org', date: _ago(40), as: 'Marta');
  store.recordPosition(millers, 52.5138, 13.4021, date: _ago(40));

  // ---- cats at the foster home
  final miezi = store.createCat('Miezi', clowderId: home, date: _ago(128));
  store.addImage(miezi, _photo(1), date: _ago(128));
  put(miezi, 'f:gender', 'female', date: _ago(128));
  put(miezi, 'f:color', 'white & ginger', date: _ago(128));
  put(miezi, 'f:breed', 'European Shorthair', date: _ago(128));
  put(miezi, 'f:chipid', '276 0981 0234 5678', date: _ago(120), as: 'Marta');
  put(miezi, 'f:neutered', 'yes', date: _ago(85), as: 'Marta');
  put(miezi, 'f:birthdate', '2026-03-01', date: _ago(128));
  put(
    miezi,
    'f:looks',
    'size=medium; colours=ginger,white; pattern=bicolour; fur=short; tail=long; ears=upright',
    date: _ago(128),
  );
  put(
    miezi,
    'f:remarks',
    'Shy at first, purrs within a minute',
    date: _ago(120),
  );
  put(
    miezi,
    'f:remarks',
    'Sneezing for two days, vet said harmless',
    date: _ago(44),
    as: 'Marta',
  );
  put(miezi, 'f:remarks', 'Loves the window seat', date: _ago(9), as: 'Jonas');
  for (final (i, grams) in [
    980,
    1240,
    1510,
    1760,
    2050,
    2290,
    2480,
    2610,
    2700,
  ].indexed) {
    put(
      miezi,
      'f:weight',
      '$grams',
      date: _ago(128 - 14 * i),
      as: i.isEven ? 'Alex' : 'Marta',
    );
  }

  final balu = store.createCat('Balu', clowderId: home, date: _ago(128));
  store.addImage(balu, _photo(13), date: _ago(128));
  put(balu, 'f:gender', 'male', date: _ago(128));
  put(balu, 'f:color', 'black', date: _ago(128));
  put(balu, 'f:breed', 'mixed', date: _ago(128));
  put(balu, 'f:neutered', 'yes', date: _ago(70), as: 'Marta');
  put(balu, 'f:birthdate', '2025-11', date: _ago(128));
  put(
    balu,
    'f:looks',
    'size=large; colours=black; pattern=solid; fur=short; tail=long; ears=upright; marks=white bib',
    date: _ago(128),
  );
  for (final (i, grams) in [3100, 3350, 3600, 3900, 4150, 4300].indexed) {
    put(balu, 'f:weight', '$grams', date: _ago(120 - 20 * i));
  }

  final nala = store.createCat('Nala', clowderId: home, date: _ago(60));
  store.addImage(nala, _photo(5), date: _ago(60));
  put(nala, 'f:gender', 'female', date: _ago(60), as: 'Marta');
  put(nala, 'f:color', 'tortoiseshell', date: _ago(60), as: 'Marta');
  put(nala, 'f:birthdate', '2026-06-15', date: _ago(60), as: 'Marta');
  put(
    nala,
    'f:looks',
    'size=small; colours=black,ginger; pattern=tortoiseshell; fur=medium',
    date: _ago(60),
    as: 'Marta',
  );
  put(
    nala,
    'f:remarks',
    'Kitten of Luna, bottle-fed the first week',
    date: _ago(58),
    as: 'Marta',
  );

  final simba = store.createCat('Simba', clowderId: home, date: _ago(60));
  store.addImage(simba, _photo(6), date: _ago(60));
  put(simba, 'f:gender', 'male', date: _ago(60), as: 'Marta');
  put(simba, 'f:color', 'ginger tabby', date: _ago(60), as: 'Marta');
  put(simba, 'f:birthdate', '2026-06-15', date: _ago(60), as: 'Marta');
  put(
    simba,
    'f:looks',
    'size=small; colours=ginger; pattern=tabby; fur=short',
    date: _ago(60),
    as: 'Marta',
  );

  // ---- the barn
  final luna = store.createCat('Luna', clowderId: home, date: _ago(121));
  store.addImage(luna, _photo(11), date: _ago(121));
  put(luna, 'f:gender', 'female', date: _ago(121));
  put(luna, 'f:color', 'grey', date: _ago(121));
  put(luna, 'f:pregnant', 'yes', date: _ago(99), as: 'Marta');
  put(luna, 'f:pregnant', 'no', date: _ago(60), as: 'Marta');
  put(
    luna,
    'f:looks',
    'size=medium; colours=grey; pattern=solid; fur=long; ears=upright',
    date: _ago(121),
  );
  store.moveCat(luna, barn, date: _ago(30));
  put(nala, 'f:mother', luna, date: _ago(60), as: 'Marta');
  put(simba, 'f:mother', luna, date: _ago(60), as: 'Marta');

  final smokey = store.createCat('Smokey', clowderId: barn, date: _ago(100));
  store.addImage(smokey, _photo(12), date: _ago(100));
  put(smokey, 'f:gender', 'male', date: _ago(100), as: 'Marta');
  put(smokey, 'f:color', 'blue grey', date: _ago(100), as: 'Marta');
  put(smokey, 'f:neutered', 'no', date: _ago(100), as: 'Marta');
  put(
    smokey,
    'f:looks',
    'size=large; colours=grey; pattern=solid; fur=medium; marks=notched ear',
    date: _ago(100),
    as: 'Marta',
  );
  put(
    smokey,
    'f:remarks',
    'Left ear notched: neutered before we met him?',
    date: _ago(98),
    as: 'Marta',
  );

  // ---- clinic and forever home
  final cleo = store.createCat('Cleo', clowderId: clinic, date: _ago(50));
  store.addImage(cleo, _photo(8), date: _ago(50));
  put(cleo, 'f:gender', 'female', date: _ago(50));
  put(cleo, 'f:color', 'calico', date: _ago(50));
  put(cleo, 'f:chipid', '276 0981 0234 9911', date: _ago(50));
  put(cleo, 'f:remarks', 'Broken leg, cast until end of month', date: _ago(50));
  put(
    cleo,
    'f:looks',
    'size=medium; colours=white,black,ginger; pattern=calico; fur=short',
    date: _ago(50),
  );
  store.moveCat(cleo, millers, date: _ago(12));

  final pumpkin = store.createCat(
    'Pumpkin',
    clowderId: millers,
    date: _ago(38),
  );
  store.addImage(pumpkin, _photo(9), date: _ago(38));
  put(pumpkin, 'f:gender', 'male', date: _ago(38), as: 'Marta');
  put(pumpkin, 'f:color', 'ginger & white', date: _ago(38), as: 'Marta');
  put(pumpkin, 'f:chipid', '276 0981 0234 4433', date: _ago(38), as: 'Marta');
  put(
    pumpkin,
    'f:looks',
    'size=medium; colours=ginger,white; pattern=bicolour; fur=short; tail=long; marks=white paws',
    date: _ago(38),
    as: 'Marta',
  );
  // Missing since a week: a flier hangs where he was last seen.
  store.moveCat(pumpkin, null, date: _ago(7));
  store.recordPosition(
    pumpkin,
    52.5152,
    13.4082,
    date: _ago(6),
    kind: PositionKind.flier,
  );

  // ---- strays
  final findus = store.createCat('Findus', date: _ago(48));
  store.addImage(findus, _photo(4), date: _ago(48));
  put(findus, 'f:gender', 'male', date: _ago(48), as: 'Jonas');
  put(findus, 'f:color', 'ginger & white', date: _ago(48), as: 'Jonas');
  put(
    findus,
    'f:looks',
    'size=medium; colours=ginger,white; fur=short; tail=long; marks=white paws',
    date: _ago(48),
    as: 'Jonas',
  );
  put(
    findus,
    'f:remarks',
    'Comes for food at dusk, keeps two metres away',
    date: _ago(47),
    as: 'Jonas',
  );
  store.recordPosition(findus, 52.5205, 13.4049, date: _ago(48));
  store.recordPosition(findus, 52.5228, 13.4102, date: _ago(36));
  store.recordPosition(findus, 52.5241, 13.4021, date: _ago(26));
  store.recordPosition(findus, 52.5168, 13.4045, date: _ago(3));

  final oskar = store.createCat('Oskar', date: _ago(20));
  store.addImage(oskar, _photo(10), date: _ago(20));
  put(oskar, 'f:gender', 'unknown', date: _ago(20), as: 'Jonas');
  put(oskar, 'f:color', 'brown tabby', date: _ago(20), as: 'Jonas');
  put(
    oskar,
    'f:looks',
    'size=large; colours=brown; pattern=tabby; fur=short; marks=scar',
    date: _ago(20),
    as: 'Jonas',
  );
  store.recordPosition(oskar, 52.5232, 13.4052, date: _ago(20));
  store.recordPosition(oskar, 52.5226, 13.4068, date: _ago(5));

  // ---- appointments ahead
  store.createAppointment(
    Appointment(
      id: '',
      entity: miezi,
      date: _ahead(3),
      time: (hour: 10, minute: 30),
      title: 'Vaccination booster',
      notes: 'Bring the blue booklet',
      alert: AppointmentAlert.dayBefore,
    ),
  );
  store.createAppointment(
    Appointment(
      id: '',
      entity: balu,
      date: _ahead(10),
      time: null,
      title: 'Deworming',
      notes: '',
      alert: AppointmentAlert.none,
    ),
  );
  store.createAppointment(
    Appointment(
      id: '',
      entity: cleo,
      date: _ahead(18),
      time: (hour: 9, minute: 0),
      title: 'Cast comes off',
      notes: 'Dr. Koch, bring the X-ray',
      alert: AppointmentAlert.dayBefore,
    ),
  );

  // ---- chores: a routine with streaks, one due today undone
  final feed = store.createChore(
    Chore(
      id: '',
      entity: home,
      title: 'Feed',
      schedule: const ChoreSchedule.daily(),
      time: (hour: 8, minute: 0),
      start: _ago(40),
      remind: true,
      remindAt: (hour: 8, minute: 0),
    ),
  );
  for (var d = 12; d >= 0; d--) {
    store.tickChore(feed, _ago(d), doneOn: _ago(d));
  }
  final litter = store.createChore(
    Chore(
      id: '',
      entity: home,
      title: 'Litter boxes',
      schedule: const ChoreSchedule.daily(),
      time: (hour: 18, minute: 0),
      start: _ago(40),
    ),
  );
  for (var d = 6; d >= 1; d--) {
    if (d != 3) store.tickChore(litter, _ago(d), doneOn: _ago(d));
  }
  final drops = store.createChore(
    Chore(
      id: '',
      entity: luna,
      title: 'Eye drops',
      schedule: const ChoreSchedule.every(2, ChoreUnit.days),
      time: (hour: 20, minute: 0),
      start: _ago(8),
      remind: true,
      remindAt: (hour: 20, minute: 0),
    ),
  );
  store.tickChore(drops, _ago(8), doneOn: _ago(8));
  store.tickChore(drops, _ago(6), doneOn: _ago(6));
  store.tickChore(drops, _ago(4), doneOn: _ago(4));
  store.tickChore(drops, _ago(2), doneOn: _ago(2));
  store.createChore(
    Chore(
      id: '',
      entity: cleo,
      title: 'Check the cast',
      schedule: ChoreSchedule.weekdays({DateTime.monday, DateTime.thursday}),
      start: _ago(12),
    ),
  );
  store.createChore(
    Chore(
      id: '',
      entity: nala,
      title: 'Weigh the kittens',
      schedule: const ChoreSchedule.every(1, ChoreUnit.weeks),
      time: (hour: 9, minute: 0),
      start: _ago(2),
    ),
  );
  store.createChore(
    Chore(
      id: '',
      entity: miezi,
      title: 'Vaccination',
      schedule: const ChoreSchedule.every(1, ChoreUnit.years),
      start: _ahead(3),
    ),
  );
  store.setLocalSetting('fold:agenda-upcoming', 'open');
  // The map opens on the demo's quarter at street zoom: pins apart.
  store.setLocalSetting(mapViewportKey, '52.5190,13.4065,15');
  return store;
}

/// A second catalog in pet mode: a household with a dog and a rabbit.
CatalogStore _petStore() {
  final store = CatalogStore.inMemory();
  store.author = 'Alex';
  setPetMode(store, true);
  final home = store.createClowder('Meadow Lane 3', date: _ago(98));
  store.append(home, 'f:responsible', 'Jonas', date: _ago(98));
  final rex = store.createCat(
    'Rex',
    clowderId: home,
    date: _ago(98),
    species: 'dog',
  );
  store.append(rex, 'f:breed', 'Beagle', date: _ago(98));
  store.append(rex, 'f:gender', 'male', date: _ago(98));
  store.append(rex, 'f:birthdate', '2021-04-12', date: _ago(98));
  store.append(rex, 'f:weight', '11200', date: _ago(98));
  store.append(rex, 'f:weight', '11600', date: _ago(40));
  store.append(
    rex,
    'f:looks',
    'size=medium; colours=brown,white,black; pattern=tricolour; fur=short; ears=floppy',
    date: _ago(98),
  );
  final hoppel = store.createCat(
    'Hoppel',
    clowderId: home,
    date: _ago(98),
    species: 'rabbit',
  );
  store.append(hoppel, 'f:weight', '1850', date: _ago(98));
  store.append(hoppel, 'f:gender', 'female', date: _ago(98));
  store.append(
    hoppel,
    'f:looks',
    'size=small; colours=grey,white; fur=long; ears=floppy',
    date: _ago(98),
  );
  final kiwi = store.createCat(
    'Kiwi',
    clowderId: home,
    date: _ago(60),
    species: 'bird',
  );
  store.append(
    kiwi,
    'f:looks',
    'size=small; colours=green,yellow; crest=no; beak=grey; ring=yes',
    date: _ago(60),
  );
  store.createChore(
    Chore(
      id: '',
      entity: rex,
      title: 'Walk',
      schedule: const ChoreSchedule.daily(),
      time: (hour: 7, minute: 30),
      start: _ago(30),
    ),
  );
  return store;
}

void main() {
  setUpAll(() async {
    useSystemSqlite();
    await _loadRealFonts();
  });

  // The coat under each page — pinned, so the shots are reproducible.
  const coats = {
    '01-home': FurPattern.tabby,
    '02-clowder': FurPattern.cheetah,
    '03-cat': FurPattern.rosettes,
    '04-card': FurPattern.paws,
    '05-timeline': FurPattern.tiger,
    '06-map': FurPattern.tabby,
    '07-graph': FurPattern.cheetah,
    '08-agenda': FurPattern.zebra,
    '09-pets': FurPattern.paws,
    '10-strays': FurPattern.tabby,
    '11-matches': FurPattern.rosettes,
    '12-achievements': FurPattern.zebra,
  };

  Future<void> shoot(
    WidgetTester tester,
    Widget home,
    String name, {
    Size physical = const Size(820, 1660),
    double dpr = 2,
  }) async {
    tester.view.physicalSize = physical;
    tester.view.devicePixelRatio = dpr;
    addTearDown(tester.view.reset);
    // The shot's own key is the tail: `12-achievements`, whatever the
    // store prefix (`tablet10-` carries digits of its own).
    activeFur = coats[RegExp(r'\d\d-[a-z]+$').firstMatch(name)!.group(0)!]!;
    final key = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            scaffoldBackgroundColor: Colors.transparent,
          ),
          home: FurBackground(child: home),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    // Real time so Image.memory decoding and tile loading complete.
    for (var i = 0; i < 4; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 400)),
      );
      await tester.pump(const Duration(milliseconds: 300));
    }
    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: dpr);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      File('docs/screenshots/$name.png')
          .writeAsBytesSync(data!.buffer.asUint8List());
    });
  }

  testWidgets('generate', (tester) async {
    // The home would open the agenda by itself (something is due): the
    // shot wants the home.
    agendaAutoOpened = true;
    final store = _demoStore();
    addTearDown(store.close);
    final miezi = store.searchCats('Miezi').single.id;
    final home = store
        .clowders()
        .firstWhere((c) => c.name == 'Foster Home South')
        .id;
    // Achievements live in the app database: a manager on a temp dir,
    // fed from the demo's ticks.
    final root = Directory.systemTemp.createTempSync('catlog-shots');
    addTearDown(() => root.deleteSync(recursive: true));
    final manager = CatalogManager.open(root.path, defaultName: 'Demo');
    addTearDown(manager.close);
    recordLadders(manager, ladders(gatherStats([store], _today)), _ago(1));

    final pets = _petStore();
    addTearDown(pets.close);
    final meadow = pets.clowders().single.id;
    final weight = store.fieldDefs().firstWhere((d) => d.slug == 'weight');

    // Map with REAL pre-downloaded OSM tiles (test/screenshots/tiles,
    // fetched once by the tile script) — no network in tests.
    final tiles = DiskCachingTileProvider(Directory('test/screenshots/tiles'));

    final shots = <String, Widget Function()>{
      '01-home': () => ClowderListScreen(store: store),
      '02-clowder': () => ClowderDetailScreen(store: store, clowderId: home),
      '03-cat': () => CatDetailScreen(store: store, catId: miezi),
      '04-card': () => CardScreen(store: store, catId: miezi),
      '05-timeline': () => TimelineScreen(store: store, entityId: miezi),
      '06-map': () => MapScreen(store: store, tileProvider: tiles),
      '07-graph': () =>
          FieldGraphScreen(store: store, entityId: miezi, def: weight),
      '08-agenda': () => AgendaScreen(store: store, manager: manager),
      '09-pets': () => ClowderDetailScreen(store: pets, clowderId: meadow),
      '10-strays': () => StraysScreen(store: store),
      '11-matches': () => MatchCandidatesScreen(store: store),
      '12-achievements': () =>
          AchievementsScreen(manager: manager, stores: [store]),
    };

    // The docs set, then the store sets: Apple 6.9" iPhone (1320×2868
    // @3x) and 13" iPad (2064×2752 @2x); Google Play phone (9:16) and
    // 10-inch tablet.
    Directory('docs/screenshots/appstore').createSync(recursive: true);
    Directory('docs/screenshots/play').createSync(recursive: true);
    Directory('docs/screenshots/tablet').createSync(recursive: true);
    const phone = Size(1320, 2868);
    const pad = Size(2064, 2752);
    const play = Size(1080, 1920);
    const tablet = Size(1440, 2560);
    for (final entry in shots.entries) {
      petMode.value = entry.key == '09-pets';
      await shoot(tester, entry.value(), entry.key);
      await shoot(
        tester,
        entry.value(),
        'appstore/iphone-${entry.key}',
        physical: phone,
        dpr: 3,
      );
      await shoot(
        tester,
        entry.value(),
        'appstore/ipad-${entry.key}',
        physical: pad,
        dpr: 2,
      );
      await shoot(
        tester,
        entry.value(),
        'play/play-${entry.key}',
        physical: play,
        dpr: 3,
      );
      await shoot(
        tester,
        entry.value(),
        'tablet/tablet10-${entry.key}',
        physical: tablet,
        dpr: 2,
      );
    }
    petMode.value = false;
  });
}
