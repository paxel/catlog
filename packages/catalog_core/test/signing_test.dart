import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Signed entries: every own row verifies, tampering shows, partners'
/// keys are pinned on first use and forged rows are refused without
/// touching the version vector.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a;
  late CatalogStore b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  /// Everything [from] has that [to] lacks, with the keys it holds.
  ImportReport send(CatalogStore from, CatalogStore to,
      {bool verified = false, List<Entry>? tampered}) {
    final report = ImportReport();
    to.applyEntries(tampered ?? from.entriesSince(to.versionVector()),
        senderVector: from.versionVector(),
        keys: from.keyRecords(),
        verifiedDevice: verified ? from.deviceId : null,
        report: report);
    return report;
  }

  Entry forged(Entry e, {String? value, String? sig}) => Entry(
        seq: -1,
        device: e.device,
        dseq: e.dseq,
        entity: e.entity,
        field: e.field,
        value: value ?? e.value,
        date: e.date,
        author: e.author,
        recorded: e.recorded,
        reminder: e.reminder,
        sig: sig ?? e.sig,
      );

  group('own key', () {
    test('a new catalog derives its device id from its key', () {
      expect(a.deviceId, deviceIdFromKey(a.signingKey.publicKey));
      expect(a.deviceId, hasLength(32));
      expect(a.signingSince, 1);
      expect(a.keyCode, matches(RegExp(r'^[0-9a-f]{4}-[0-9a-f]{4}$')));
      expect(a.ownKeyRecord.selfSigned, isTrue);
    });

    test('every own row verifies, whichever path wrote it', () {
      final cat = a.createCat('Miezi');
      final home = a.createClowder('Müllers');
      a.moveCat(cat, home);
      a.append(cat, 'f:remarks', 'shy');
      a.append(cat, 'f:remarks', null);
      a.setFieldPrivate(cat, 'f:remarks', true);
      a.setFieldPrivate(cat, 'f:remarks', false);
      final other = a.createCat('Miezi 2');
      a.mergeCat(other, cat);
      a.adoptEntries(b.entriesSince(const {}));
      final rows = a.entriesSince(const {}, includePrivate: true);
      expect(rows, isNotEmpty);
      for (final e in rows) {
        expect(e.device, a.deviceId);
        expect(e.sig, isNotNull, reason: '$e');
        expect(a.verifiesEntry(e), isTrue, reason: '$e');
      }
    });

    test('a changed value or signature no longer verifies', () {
      final cat = a.createCat('Miezi');
      final e = a.entriesSince(const {}).firstWhere((e) => e.entity == cat);
      expect(a.verifiesEntry(forged(e, value: 'Mauzi')), isFalse);
      expect(a.verifiesEntry(forged(e, sig: base64.encode(Uint8List(64)))),
          isFalse);
      expect(a.verifiesEntry(forged(e, sig: 'not base64!')), isFalse);
    });

    test('the signature survives the wire', () {
      a.createCat('Miezi');
      for (final e in a.entriesSince(const {})) {
        final back =
            Entry.fromJson((jsonDecode(jsonEncode(e.toJson())) as Map).cast());
        expect(back.sig, e.sig);
        expect(a.verifiesEntry(back), isTrue);
      }
    });

    test('own rows come home only under the own key', () {
      final cat = a.createCat('Miezi');
      final rows = a.entriesSince(const {});
      final mine = rows.firstWhere((e) => e.entity == cat && e.field == 'name');
      // A go-back file: the same rows, applied again, are a no-op.
      expect(a.applyEntries(rows), isEmpty);
      // The same row with another name: refused, not even as a no-op.
      final report = ImportReport();
      a.applyEntries([forged(mine, value: 'Mauzi')], report: report);
      expect(report.refusedCount, 1);
      expect(a.current(cat, 'name'), 'Miezi');
    });
  });

  group('partner keys', () {
    test('a key list pins on first use; forged records do not', () {
      a.createCat('Miezi');
      final report = send(a, b);
      expect(report.newKeys.single.record.device, a.deviceId);
      expect(report.newKeys.single.trust, KeyTrust.tofu);
      expect(b.pinnedKey(a.deviceId)!.record.code, a.keyCode);
      expect(b.cats().single.name, 'Miezi');

      // A record that does not sign itself is ignored.
      final c = CatalogStore.inMemory();
      addTearDown(c.close);
      final fake = KeyRecord(c.deviceId, a.signingKey.publicKey, 1, 'x');
      b.learnKeys([fake]);
      expect(b.pinnedKey(c.deviceId), isNull);
    });

    test('an in-person session makes a key verified', () {
      a.createCat('Miezi');
      send(a, b);
      expect(b.pinnedKey(a.deviceId)!.trust, KeyTrust.tofu);
      send(a, b, verified: true);
      expect(b.pinnedKey(a.deviceId)!.trust, KeyTrust.verified);
    });

    test('once pinned, a forged row is refused and the vector untouched', () {
      final cat = a.createCat('Miezi');
      send(a, b);
      final vector = b.versionVector()[a.deviceId];
      final real = a.entriesSince(const {}).last;
      final forgedRow = Entry(
        seq: -1,
        device: a.deviceId,
        dseq: real.dseq + 5,
        entity: cat,
        field: 'name',
        value: 'Mauzi',
        date: DateTime.now().add(const Duration(days: 1)),
        author: 'anna',
        recorded: DateTime.now(),
      );
      final report = ImportReport();
      b.applyEntries([forgedRow, forged(real, value: 'x')], report: report);
      expect(report.refused[('anna', a.deviceId)], 2);
      expect(b.current(cat, 'name'), 'Miezi');
      expect(b.versionVector()[a.deviceId], vector,
          reason: 'a refusal must not make real rows unreachable');
      // The real rows still arrive later.
      a.append(cat, 'name', 'Minka');
      send(a, b);
      expect(b.current(cat, 'name'), 'Minka');
    });

    test('unsigned rows pass below the key\'s since, not above', () {
      // Bob's key says it signs from dseq 1 on; a row without a
      // signature at dseq 1 is refused, one below the watermark passes.
      final cat = a.createCat('Miezi');
      send(a, b);
      final real = a.entriesSince(const {}).last;
      final unsigned = forged(real, sig: null);
      final stripped = Entry(
        seq: -1,
        device: real.device,
        dseq: real.dseq,
        entity: real.entity,
        field: real.field,
        value: 'x',
        date: real.date,
        author: real.author,
        recorded: real.recorded,
      );
      expect(unsigned.sig, isNotNull, reason: 'forged keeps the sig');
      final report = ImportReport();
      b.applyEntries([stripped], report: report);
      expect(report.refusedCount, 1);
      expect(b.current(cat, real.field), real.value);
      // A device whose key started later accepts its older, unsigned rows.
      final old = KeyRecord.make(a.signingKey, a.deviceId, real.dseq + 10);
      b.unpinKey(a.deviceId);
      b.learnKeys([old]);
      final report2 = ImportReport();
      b.applyEntries([
        Entry(
          seq: -1,
          device: a.deviceId,
          dseq: real.dseq + 1,
          entity: cat,
          field: 'f:remarks',
          value: 'old note',
          date: DateTime(2020),
          author: 'anna',
          recorded: DateTime(2020),
        )
      ], report: report2);
      expect(report2.refusedCount, 0);
      expect(b.current(cat, 'f:remarks'), 'old note');
    });

    test('a device without a key is taken as unsigned', () {
      // A partner on 1.1: rows without signatures, no key list.
      final cat = a.createCat('Miezi');
      final rows = [for (final e in a.entriesSince(const {})) forged(e)];
      final plain = [
        for (final e in rows)
          Entry(
            seq: -1,
            device: 'old-phone',
            dseq: e.dseq,
            entity: e.entity,
            field: e.field,
            value: e.value,
            date: e.date,
            author: 'carla',
            recorded: e.recorded,
          )
      ];
      final report = ImportReport();
      b.applyEntries(plain, report: report);
      expect(report.isEmpty, isTrue);
      expect(b.current(cat, 'name'), 'Miezi');
      expect(b.verifiesEntry(plain.first), isNull);
    });

    test('a second key for a pinned device is refused and reported', () {
      a.createCat('Miezi');
      send(a, b);
      final other = SigningKey.generate();
      final report = ImportReport();
      b.learnKeys([KeyRecord.make(other, a.deviceId, 1)], report: report);
      expect(report.changedKeys, [a.deviceId]);
      expect(b.pinnedKey(a.deviceId)!.record.code, a.keyCode);
    });

    test('a new key wearing a known name is reported', () {
      a.createCat('Miezi');
      send(a, b);
      // A third catalog calling itself anna.
      final c = CatalogStore.inMemory()..author = 'anna';
      addTearDown(c.close);
      c.createCat('Mauzi');
      final report = send(c, b);
      expect(report.impostors, [('anna', c.deviceId)]);
      // And one calling itself bob, the receiver's own name.
      final d = CatalogStore.inMemory()..author = 'bob';
      addTearDown(d.close);
      d.createCat('Mimi');
      expect(send(d, b).impostors, [('bob', d.deviceId)]);
      // A new name is nobody's business.
      final e = CatalogStore.inMemory()..author = 'erik';
      addTearDown(e.close);
      e.createCat('Momo');
      expect(send(e, b).impostors, isEmpty);
    });

    test('keys travel on: a partner\'s partner gets the key too', () {
      a.createCat('Miezi');
      send(a, b);
      final c = CatalogStore.inMemory()..author = 'carla';
      addTearDown(c.close);
      final report = send(b, c);
      expect(report.newKeys.map((k) => k.record.device),
          containsAll([a.deviceId, b.deviceId]));
    });
  });

  group('person records', () {
    test('a title travels and only its own device can write it', () {
      a.createCat('Miezi');
      a.setOwnTitle('chancellor|Feed');
      send(a, b);
      expect(b.titleOf(a.deviceId), 'chancellor|Feed');
      // Bob forges Anna's record under his own device: dropped.
      b.append(Keys.person(a.deviceId), Keys.personTitle, 'minister|Feed');
      expect(b.titleOf(a.deviceId), 'minister|Feed',
          reason: 'locally written, locally visible');
      final report = ImportReport();
      a.applyEntries(b.entriesSince(a.versionVector()),
          senderVector: b.versionVector(), report: report);
      expect(a.titleOf(a.deviceId), 'chancellor|Feed');
      // Taking it off travels too.
      a.setOwnTitle(null);
      send(a, b);
      expect(b.titleOf(a.deviceId), isNull);
    });
  });
}
