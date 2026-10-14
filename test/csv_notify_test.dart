// CSV preview + notifikasi Noop (FR-27/28, FR-38).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/domain/import/csv_preview.dart';
import 'package:simaha/domain/notifications/local_notify.dart';

void main() {
  test('preview validasi per baris + lapor error', () {
    const csv = 'nim,nama,angkatan,email,no_hp\n'
        '2024010001,Ahmad Yani,2024,ahmad@kampus.ac.id,08123456789\n'
        ',Nama Pendek,2024,bukan-email,abc\n'
        '2024010001,Ganda,2024,,08123456789\n';
    final p = previewCsv(csv);
    expect(p.headers, containsAll(['nim', 'nama']));
    expect(p.rows, hasLength(3));
    expect(p.rows[0].ok, isTrue);
    expect(p.rows[1].ok, isFalse);
    expect(p.rows[1].errors, contains('NIM kosong'));
    expect(p.rows[1].errors, contains('Email invalid'));
    expect(p.rows[2].errors, contains('NIM duplikat di berkas'));
    expect(p.validCount, 1);
    expect(p.invalidCount, 2);
  });

  test('header tanpa nim/nama ditolak', () {
    expect(() => previewCsv('kode,nama\nA1,X'), throwsFormatException);
    expect(() => previewCsv('   \n  '), throwsFormatException);
  });

  test('NoopNotifications menyimpan tanpa plugin', () async {
    final n = NoopNotifications();
    await n.show(const LocalNotice(id: 1, title: 'KRS', body: 'Isi KRS'));
    await n.show(const LocalNotice(id: 2, title: 'Risiko', body: 'IPK turun'));
    final list = await n.scheduled;
    expect(list, hasLength(2));
    expect(list.first.title, 'KRS');
  });
}
