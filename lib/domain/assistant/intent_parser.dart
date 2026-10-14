// Asisten cerdas on-device Level 1+2 (FR-34..36, pure Dart).
// IntentParser: normalisasi + regex + ekstraksi entitas -> filter aman
// (tanpa string SQL mentah; UI memakai field terstruktur ke Drift).
// Level 3 (LLM) di belakang [LlmProvider], default [NoopLlm] nonaktif;
// hanya data agregat/anonim yang boleh keluar (tanpa nama/NIM).

enum AssistIntent {
  cariMahasiswa,
  hitung,
  ringkas,
  presensi,
  takDikenal,
}

/// Filter terstruktur hasil parse (dipakai QueryBuilder Drift di UI).
class AssistQuery {
  const AssistQuery({
    required this.intent,
    this.angkatan,
    this.prodi,
    this.ipkBawah,
    this.ipkAtas,
    this.status,
    this.minAlpa,
  });

  final AssistIntent intent;
  final int? angkatan;
  final String? prodi;
  final double? ipkBawah;
  final double? ipkAtas;
  final String? status;
  final int? minAlpa;
}

String _norm(String s) =>
    s.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

int? _extractAngkatan(String t) {
  final m = RegExp(r'angkatan\s*(20\d{2})').firstMatch(t);
  if (m != null) return int.tryParse(m.group(1)!);
  final m2 = RegExp(r'\b(20\d{2})\b').firstMatch(t);
  return m2 == null ? null : int.tryParse(m2.group(1)!);
}

double? _extractIpkBawah(String t) {
  for (final re in [
    RegExp(r'ipk\s*(?:di\s*bawah|dibawah|kurang\s*dari|<\s*)\s*(\d(?:[.,]\d+)?)'),
    RegExp(r'ipk\s*<\s*(\d(?:[.,]\d+)?)'),
  ]) {
    final m = re.firstMatch(t);
    if (m != null) return double.tryParse(m.group(1)!.replaceAll(',', '.'));
  }
  return null;
}

double? _extractIpkAtas(String t) {
  for (final re in [
    RegExp(r'ipk\s*(?:di\s*atas|diatas|lebih\s*dari|>\s*)\s*(\d(?:[.,]\d+)?)'),
    RegExp(r'ipk\s*>\s*(\d(?:[.,]\d+)?)'),
  ]) {
    final m = re.firstMatch(t);
    if (m != null) return double.tryParse(m.group(1)!.replaceAll(',', '.'));
  }
  return null;
}

String? _extractProdi(String t) {
  if (RegExp(r'\binformatika\b|\bteknik informatika\b').hasMatch(t)) {
    return 'informatika';
  }
  if (RegExp(r'\bsistem informasi\b').hasMatch(t)) return 'sistem informasi';
  final m = RegExp(r'\bprodi\s+([a-z ]+)').firstMatch(t);
  return m?.group(1)?.trim();
}

String? _extractStatus(String t) {
  for (final s in ['aktif', 'cuti', 'lulus', 'keluar', 'nonaktif']) {
    if (t.contains(s)) return s;
  }
  return null;
}

/// "mahasiswa angkatan 2023 IPK di bawah 2.5" -> angkatan=2023, ipk<2.5.
AssistQuery parsePertanyaan(String raw) {
  final t = _norm(raw);
  final angkatan = _extractAngkatan(t);
  final ipkBawah = _extractIpkBawah(t);
  final ipkAtas = _extractIpkAtas(t);
  final prodi = _extractProdi(t);
  final status = _extractStatus(t);
  int? minAlpa;
  final alpa = RegExp(r'alpa\s*(?:>=?|>)?\s*(\d+)').firstMatch(t);
  if (alpa != null) minAlpa = int.tryParse(alpa.group(1)!);

  AssistIntent intent;
  if (RegExp(r'\b(berapa|jumlah|hitung|total|rata-rata|rata rata)\b')
      .hasMatch(t)) {
    intent = AssistIntent.hitung;
  } else if (RegExp(r'\b(ringkas|ringkasan|simpulkan|kesimpulan)\b')
      .hasMatch(t)) {
    intent = AssistIntent.ringkas;
  } else if (RegExp(
    r'\b(presensi|kehadiran|hadir|bolos|alpha|alpa|izin|sakit)\b',
  ).hasMatch(t)) {
    intent = AssistIntent.presensi;
  } else if (RegExp(
    r'\b(mahasiswa|mhs|nim|nama|angkatan|prodi|ipk)\b',
  ).hasMatch(t)) {
    intent = AssistIntent.cariMahasiswa;
  } else {
    intent = AssistIntent.takDikenal;
  }
  return AssistQuery(
    intent: intent,
    angkatan: angkatan,
    prodi: prodi,
    ipkBawah: ipkBawah,
    ipkAtas: ipkAtas,
    status: status,
    minAlpa: minAlpa,
  );
}

/// Ringkasan narasi Level 2 dari angka agregat (tanpa nama/NIM).
String ringkasanTemplate({
  required int total,
  required int aktif,
  required double rataIpk,
  required int kritis,
}) {
  return 'Dari $total mahasiswa ($aktif aktif), rata-rata IPK '
      '${rataIpk.toStringAsFixed(2)}. $kritis mahasiswa perlu perhatian '
      'dosen wali. Saran: prioritaskan bimbingan untuk yang kritis minggu ini.';
}

/// Interface LLM opsional (default nonaktif). Implementasi dilarang
/// menerima nama/NIM (hanya agregat anonim).
abstract class LlmProvider {
  Future<String> ringkasAgregat({
    required int total,
    required int aktif,
    required double rataIpk,
    required int kritis,
  });
}

/// Default: tanpa LLM, pakai template lokal (100% offline).
class NoopLlm implements LlmProvider {
  @override
  Future<String> ringkasAgregat({
    required int total,
    required int aktif,
    required double rataIpk,
    required int kritis,
  }) async {
    return ringkasanTemplate(
      total: total,
      aktif: aktif,
      rataIpk: rataIpk,
      kritis: kritis,
    );
  }
}
