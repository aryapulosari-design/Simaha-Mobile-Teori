// Impor CSV: pratinjau + validasi per baris di isolate-able pure Dart
// (FR-27). Tanpa dependensi baru: parser sederhana (koma, kutip "...").
// Kolom wajib: nim, nama. Opsional: prodi_id, angkatan, status, email, no_hp.

/// Satu baris hasil validasi impor.
class CsvRowResult {
  const CsvRowResult({
    required this.line,
    required this.ok,
    required this.values,
    required this.errors,
  });

  final int line;
  final bool ok;
  final Map<String, String> values;
  final List<String> errors;
}

/// Hasil pratinjau: header + baris valid/invalid.
class CsvPreview {
  const CsvPreview({required this.headers, required this.rows});

  final List<String> headers;
  final List<CsvRowResult> rows;

  int get validCount => rows.where((r) => r.ok).length;
  int get invalidCount => rows.where((r) => !r.ok).length;
}

List<String> _splitCsvLine(String line) {
  final out = <String>[];
  final buf = StringBuffer();
  var inQuotes = false;
  for (var i = 0; i < line.length; i++) {
    final c = line[i];
    if (c == '"') {
      if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
        buf.write('"');
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (c == ',' && !inQuotes) {
      out.add(buf.toString().trim());
      buf.clear();
    } else {
      buf.write(c);
    }
  }
  out.add(buf.toString().trim());
  return out;
}

bool _validEmail(String v) {
  if (v.isEmpty) return true;
  return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
}

bool _validPhone(String v) {
  if (v.isEmpty) return true;
  return RegExp(r'^[0-9]{9,15}$')
      .hasMatch(v.replaceAll(RegExp(r'[\s\-+]'), ''));
}

/// Parse CSV [content] (baris pertama = header). Validasi tiap baris.
CsvPreview previewCsv(String content, {int maxRows = 500}) {
  final lines = content
      .split(RegExp(r'\r?\n'))
      .where((l) => l.trim().isNotEmpty)
      .toList();
  if (lines.isEmpty) {
    throw const FormatException('Berkas CSV kosong.');
  }
  final headers = _splitCsvLine(lines.first)
      .map((h) => h.toLowerCase())
      .toList();
  if (!headers.contains('nim') || !headers.contains('nama')) {
    throw const FormatException('Header wajib memuat nim dan nama.');
  }
  final seenNim = <String>{};
  final rows = <CsvRowResult>[];
  final dataLines = lines.skip(1).take(maxRows).toList();
  for (var i = 0; i < dataLines.length; i++) {
    final cells = _splitCsvLine(dataLines[i]);
    final values = <String, String>{
      for (var j = 0; j < headers.length; j++)
        headers[j]: j < cells.length ? cells[j] : '',
    };
    final errors = <String>[];
    final nim = (values['nim'] ?? '').trim();
    final nama = (values['nama'] ?? '').trim();
    if (nim.isEmpty) {
      errors.add('NIM kosong');
    } else if (!seenNim.add(nim)) {
      errors.add('NIM duplikat di berkas');
    }
    if (nama.length < 3) errors.add('Nama minimal 3 karakter');
    final angkatan = (values['angkatan'] ?? '').trim();
    if (angkatan.isNotEmpty) {
      final a = int.tryParse(angkatan);
      if (a == null || a < 2000 || a > 2100) errors.add('Angkatan invalid');
    }
    if (!_validEmail((values['email'] ?? '').trim())) {
      errors.add('Email invalid');
    }
    if (!_validPhone((values['no_hp'] ?? '').trim())) {
      errors.add('No HP invalid');
    }
    rows.add(
      CsvRowResult(
        line: i + 2,
        ok: errors.isEmpty,
        values: values,
        errors: errors,
      ),
    );
  }
  return CsvPreview(headers: headers, rows: rows);
}
