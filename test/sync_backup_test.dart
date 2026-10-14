// Sync LWW + backup .simaha (FR-29..32).
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/services/backup_service.dart';
import 'package:simaha/domain/sync/sync_merge.dart';

void main() {
  test('LWW: yang lebih baru menang, seri deviceId terbesar', () {
    const a = SyncRecord(
      table: 'mahasiswa',
      id: '1',
      updatedAt: 100,
      deviceId: 'A',
      data: {'nama': 'Lama'},
    );
    const b = SyncRecord(
      table: 'mahasiswa',
      id: '1',
      updatedAt: 200,
      deviceId: 'A',
      data: {'nama': 'Baru'},
    );
    expect(winsOver(b, a), isTrue);
    const c = SyncRecord(
      table: 'mahasiswa',
      id: '2',
      updatedAt: 100,
      deviceId: 'B',
      data: {},
    );
    const d = SyncRecord(
      table: 'mahasiswa',
      id: '2',
      updatedAt: 100,
      deviceId: 'A',
      data: {},
    );
    expect(winsOver(c, d), isTrue);
  });

  test('merge idempoten + catat konflik', () {
    const local = SyncRecord(
      table: 'mahasiswa',
      id: '1',
      updatedAt: 100,
      deviceId: 'A',
      data: {'nama': 'Lokal'},
    );
    const incBaru = SyncRecord(
      table: 'mahasiswa',
      id: '1',
      updatedAt: 150,
      deviceId: 'B',
      data: {'nama': 'Datang'},
    );
    final r1 = mergeSyncDeltas(
      local: {'mahasiswa:1': local},
      incoming: [incBaru],
    );
    expect(r1.applied, 1);
    expect(r1.conflicts, 1);
    expect(r1.merged['mahasiswa:1']!.data['nama'], 'Datang');
    // Terapkan paket yang sama lagi: tidak berubah (idempoten).
    final r2 = mergeSyncDeltas(local: r1.merged, incoming: [incBaru]);
    expect(r2.applied, 0);
    expect(r2.merged['mahasiswa:1']!.data['nama'], 'Datang');
  });

  test('backup round-trip; password salah & modifikasi ditolak', () async {
    final svc = BackupService(iterations: 2000);
    final plain = utf8.encode('{"mahasiswa":100}');
    final file = await svc.encryptBackup(plain, 'rahasia1');
    expect(await svc.decryptBackup(file, 'rahasia1'), equals(plain));
    // Password salah
    await expectLater(
      svc.decryptBackup(file, 'salahxx'),
      throwsA(isA<StateError>()),
    );
    // Modifikasi 1 byte -> checksum/mac gagal
    final tampered = List<int>.from(file);
    tampered[tampered.length - 5] ^= 0xFF;
    await expectLater(
      svc.decryptBackup(tampered, 'rahasia1'),
      throwsA(anything),
    );
  });
}
