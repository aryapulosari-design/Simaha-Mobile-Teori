// IntentParser on-device + ringkasan template (FR-34..37).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/domain/assistant/intent_parser.dart';

void main() {
  test('contoh PRD: angkatan + IPK bawah', () {
    final q = parsePertanyaan('mahasiswa angkatan 2023 IPK di bawah 2.5');
    expect(q.intent, AssistIntent.cariMahasiswa);
    expect(q.angkatan, 2023);
    expect(q.ipkBawah, closeTo(2.5, 1e-9));
  });

  test('deteksi intent hitung / ringkas / presensi', () {
    expect(parsePertanyaan('berapa mahasiswa aktif?').intent, AssistIntent.hitung);
    expect(
      parsePertanyaan('ringkas kondisi akademik').intent,
      AssistIntent.ringkas,
    );
    expect(
      parsePertanyaan('siapa yang alpa 3 kali?').intent,
      AssistIntent.presensi,
    );
    expect(parsePertanyaan('halo apa kabar').intent, AssistIntent.takDikenal);
  });

  test('ekstraksi prodi + status', () {
    final q = parsePertanyaan('mahasiswa prodi informatika status cuti');
    expect(q.prodi, 'informatika');
    expect(q.status, 'cuti');
  });

  test('template + NoopLlm tanpa nama/NIM', () async {
    final s = ringkasanTemplate(
      total: 100,
      aktif: 82,
      rataIpk: 3.12,
      kritis: 5,
    );
    expect(s, contains('100 mahasiswa'));
    expect(s, contains('5 mahasiswa perlu perhatian'));
    final llm = NoopLlm();
    expect(
      await llm.ringkasAgregat(total: 10, aktif: 9, rataIpk: 3.0, kritis: 1),
      contains('10 mahasiswa'),
    );
  });
}
