// Pure-Dart validators for student/master input (FR-08) and exam
// schedule conflict detection (FR-39). No Flutter imports.

/// NIM must be non-empty alphanumeric (allows '/', '-', '.').
String? validateNim(String nim) {
  final v = nim.trim();
  if (v.isEmpty) return 'NIM wajib diisi.';
  if (v.length < 4) return 'NIM minimal 4 karakter.';
  if (!RegExp(r'^[A-Za-z0-9/.\-]+$').hasMatch(v)) {
    return 'NIM hanya huruf, angka, / - .';
  }
  return null;
}

String? validateNama(String nama) {
  if (nama.trim().isEmpty) return 'Nama wajib diisi.';
  if (nama.trim().length < 3) return 'Nama minimal 3 karakter.';
  return null;
}

String? validateEmail(String email) {
  final v = email.trim();
  if (v.isEmpty) return null; // optional
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)) {
    return 'Format email tidak valid.';
  }
  return null;
}

String? validatePhone(String noHp) {
  final v = noHp.trim().replaceAll(RegExp(r'[\s\-+]'), '');
  if (v.isEmpty) return null; // optional
  if (!RegExp(r'^[0-9]{9,15}$').hasMatch(v)) {
    return 'No HP 9-15 digit angka.';
  }
  return null;
}

String? validateNilaiAngka(String raw) {
  final v = double.tryParse(raw.trim().replaceAll(',', '.'));
  if (v == null) return 'Harus angka 0-100.';
  if (v < 0 || v > 100) return 'Harus 0-100.';
  return null;
}

/// Exam conflict (FR-39): same date AND overlapping time intervals.
/// Times are 'HH:MM' strings on the same [tanggal] ('yyyy-MM-dd').
bool jadwalUjianBentrok({
  required String tanggalA,
  required String jamMulaiA,
  required String jamSelesaiA,
  required String tanggalB,
  required String jamMulaiB,
  required String jamSelesaiB,
}) {
  if (tanggalA != tanggalB) return false;
  int toMin(String hm) {
    final parts = hm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  final a1 = toMin(jamMulaiA);
  final a2 = toMin(jamSelesaiA);
  final b1 = toMin(jamMulaiB);
  final b2 = toMin(jamSelesaiB);
  return a1 < b2 && b1 < a2;
}

/// Class schedule conflict (FR-14): same day + overlapping hours.
bool jadwalKelasBentrok({
  required String hariA,
  required String jamMulaiA,
  required String jamSelesaiA,
  required String hariB,
  required String jamMulaiB,
  required String jamSelesaiB,
}) => jadwalUjianBentrok(
  tanggalA: hariA,
  jamMulaiA: jamMulaiA,
  jamSelesaiA: jamSelesaiA,
  tanggalB: hariB,
  jamMulaiB: jamMulaiB,
  jamSelesaiB: jamSelesaiB,
);
