import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// A round does no work for entries it already holds: nothing is
/// checked or refused below the version vector, and a second pass of
/// the same file applies nothing.
void main() {
  setUpAll(useSystemSqlite);

  test('known entries are skipped before the signature check', () async {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'ben';
    addTearDown(a.close);
    addTearDown(b.close);
    a.createCat('Miezi');
    final folder = MemorySyncFolder();
    await folderSyncIn(a, folder);
    final first = await folderSyncIn(b, folder);
    expect(first.entriesIn, greaterThan(0));
    // The same entries again, this time with broken signatures: below
    // the vector they are not looked at, so nothing is refused.
    final again = [
      for (final e in a.entriesSince(const {}))
        Entry(
          seq: e.seq,
          device: e.device,
          dseq: e.dseq,
          entity: e.entity,
          field: e.field,
          value: e.value,
          date: e.date,
          author: e.author,
          recorded: e.recorded,
          sig: 'broken',
        ),
    ];
    final report = ImportReport();
    final applied =
        b.applyEntries(again, senderVector: a.versionVector(), report: report);
    expect(applied, isEmpty);
    expect(report.refused, isEmpty);
    // A second round brings nothing and stays quick.
    final sw = Stopwatch()..start();
    final second = await folderSyncIn(b, folder);
    expect(second.entriesIn, 0);
    expect(sw.elapsedMilliseconds, lessThan(2000));
  });
}
