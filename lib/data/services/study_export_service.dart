import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/security/roles.dart';

class StudyExportService {
  StudyExportService(this.academic);
  final AcademicService academic;

  Future<Uint8List> transcript(int studentId) async {
    await academic.counts();
    final user = await (academic.db.select(
      academic.db.users,
    )..where((u) => u.id.equals(academic.actorId!))).getSingle();
    if (Role.fromStorage(user.role) == Role.dosenPengampu) {
      throw const ForbiddenFailure(
        'Transkrip kumulatif hanya untuk mahasiswa, wali, dan admin.',
      );
    }
    final profile = (await academic.student(studentId))!;
    final items = await academic.grades(studentId);
    final courses = items
        .where((g) => g.adaNilai)
        .map(
          (g) => GradedCourse(
            mkKode: g.mkKode,
            sks: g.sks,
            nilaiAkhir: g.akhir,
            huruf: g.huruf,
            bobot: g.bobot,
          ),
        )
        .toList();
    final doc = pw.Document(
      title: 'Hasil Studi ${profile.nama}',
      author: 'SIMAHA Offline',
    );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        footer: (context) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 16),
          child: pw.Text(
            'SIMAHA Offline | Halaman ${context.pageNumber} dari ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ),
        build: (_) => [
          pw.Text(
            'SIMAHA',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#00685F'),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Ringkasan Hasil Studi',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Text(profile.nama),
          pw.Text('NIM ${profile.nim} | Angkatan ${profile.angkatan}'),
          pw.SizedBox(height: 16),
          pw.Text(
            'IPK ${hitungIpk(courses).toStringAsFixed(2)} | SKS lulus ${sksLulus(courses)}',
          ),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            headers: ['Kode', 'Mata kuliah', 'SKS', 'Nilai', 'Huruf'],
            data: [
              for (final g in items)
                [
                  g.mkKode,
                  g.mkNama,
                  '${g.sks}',
                  g.adaNilai ? g.akhir.toStringAsFixed(1) : '-',
                  g.adaNilai ? g.huruf : '-',
                ],
            ],
            headerStyle: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#00685F'),
            ),
            cellStyle: const pw.TextStyle(fontSize: 10),
            cellPadding: const pw.EdgeInsets.all(8),
            columnWidths: {
              0: const pw.FixedColumnWidth(54),
              2: const pw.FixedColumnWidth(34),
              3: const pw.FixedColumnWidth(42),
              4: const pw.FixedColumnWidth(40),
            },
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'IPK memakai nilai terbaik untuk mata kuliah yang diulang. Data yang belum dinilai ditandai dengan tanda minus.',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            'Dokumen informasi dari data lokal. Bukan transkrip resmi yang disahkan kampus.',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
        ],
      ),
    );
    return doc.save();
  }
}
