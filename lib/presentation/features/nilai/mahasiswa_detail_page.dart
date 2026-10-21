import 'package:go_router/go_router.dart';
import 'package:simaha/presentation/features/campus/export_study_button.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/presentation/features/academic/advising_section.dart';
import 'package:simaha/domain/academic/grades.dart' as engine;
import 'package:simaha/domain/academic/validations.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/providers/app_providers.dart';

final _mhsProvider = FutureProvider.autoDispose.family<MahasiswaRow?, int>((
  ref,
  id,
) async {
  final db = ref.watch(academicServiceProvider);
  return db.student(id);
});

final _nilaiProvider = FutureProvider.autoDispose
    .family<List<KrsNilaiItem>, int>((ref, id) async {
      final db = ref.watch(academicServiceProvider);
      return db.grades(id);
    });

final _syaratSksProvider = FutureProvider.autoDispose<int>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getSyaratSksLulus();
});

/// Detail mahasiswa: biodata + semua nilai + IPK + status lulus (FR-15/16),
/// tambah/edit nilai (FR-13/15), simulasi IPK target + progres (FR-36/37).
class MahasiswaDetailPage extends ConsumerWidget {
  const MahasiswaDetailPage({super.key, required this.mahasiswaId});
  final int mahasiswaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mhs = ref.watch(_mhsProvider(mahasiswaId));
    final nilai = ref.watch(_nilaiProvider(mahasiswaId));
    final syarat = ref.watch(_syaratSksProvider);
    final role = ref.watch(sessionProvider).role;
    final canEdit = role != null && canRole(role, Permission.manageNilai);
    final canRegister = role != null && canRole(role, Permission.manageMaster);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mahasiswa'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                ..invalidate(_mhsProvider(mahasiswaId))
                ..invalidate(_nilaiProvider(mahasiswaId))
                ..invalidate(_syaratSksProvider)
                ..invalidate(workspaceOverviewProvider);
            },
          ),
        ],
      ),
      floatingActionButton: canRegister
          ? FloatingActionButton.extended(
              onPressed: () => _showTambah(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Tambah MK'),
            )
          : null,
      body: mhs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat: $e')),
        data: (m) {
          if (m == null) {
            return const Center(child: Text('Mahasiswa tidak ditemukan.'));
          }
          return nilai.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Gagal memuat nilai: $e')),
            data: (items) {
              final syaratSks = syarat.value ?? 144;
              final courses = items
                  .where((e) => e.adaNilai)
                  .map(
                    (e) => engine.GradedCourse(
                      mkKode: e.mkKode,
                      sks: e.sks,
                      nilaiAkhir: e.akhir,
                      huruf: e.huruf,
                      bobot: e.bobot,
                    ),
                  )
                  .toList();
              final ipk = engine.hitungIpk(courses);
              final best = <String, engine.GradedCourse>{};
              for (final course in courses) {
                if (!best.containsKey(course.mkKode) ||
                    course.bobot > best[course.mkKode]!.bobot) {
                  best[course.mkKode] = course;
                }
              }
              final sksDasar = best.values.fold<int>(
                0,
                (total, course) => total + course.sks,
              );
              final lulus = engine.sksLulus(courses);
              final tempuh = courses.fold<int>(0, (s, c) => s + c.sks);
              final progres = engine.progresKelulusan(
                lulus,
                syaratSks: syaratSks,
              );
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                children: [
                  _BioCard(m: m),
                  if (role != Role.dosenPengampu) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ExportStudyButton(studentId: mahasiswaId),
                        TextButton.icon(
                          onPressed: () => context.push('/studi/$mahasiswaId'),
                          icon: const Icon(Icons.insights_outlined),
                          label: const Text('Perkembangan studi'),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  if (role != Role.dosenPengampu)
                    _RingkasanCard(
                      ipk: ipk,
                      sksTempuh: tempuh,
                      sksLulus: lulus,
                      syaratSks: syaratSks,
                      progres: progres,
                      statusAkademik: m.status,
                    ),
                  const SizedBox(height: 12),
                  if (role != Role.dosenPengampu)
                    _SimulasiCard(ipk: ipk, sksDasar: sksDasar),
                  if (role == Role.dosenPengampu)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Daftar ini hanya menampilkan nilai kelas yang Anda ampu.',
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Nilai (${items.length} MK)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (items.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Belum ada KRS atau nilai yang tersedia.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    for (final it in items)
                      _NilaiCard(
                        item: it,
                        onEdit: canEdit
                            ? () => _showEdit(context, ref, it)
                            : null,
                        onDelete: canRegister
                            ? () => _confirmHapus(context, ref, it)
                            : null,
                      ),
                  AdvisingSection(studentId: mahasiswaId),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _refresh(WidgetRef ref) async {
    ref
      ..invalidate(_nilaiProvider(mahasiswaId))
      ..invalidate(_syaratSksProvider)
      ..invalidate(workspaceOverviewProvider);
  }

  Future<void> _showEdit(
    BuildContext context,
    WidgetRef ref,
    KrsNilaiItem it,
  ) async {
    final res = await showDialog<({double t, double u, double a})>(
      context: context,
      builder: (ctx) => _NilaiDialog(
        title: 'Edit nilai ${it.mkKode}',
        initialTugas: it.tugas,
        initialUts: it.uts,
        initialUas: it.uas,
      ),
    );
    if (res == null || !context.mounted) return;
    try {
      await ref
          .read(academicServiceProvider)
          .saveNilai(krsId: it.krsId, tugas: res.t, uts: res.u, uas: res.a);
      await _refresh(ref);
      if (context.mounted) {
        final h = engine.konversiHuruf(
          engine.hitungNilaiAkhir(res.t, res.u, res.a),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Nilai ${it.mkKode} disimpan: ${h.huruf} (bobot ${h.bobot}).',
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal: $e')));
      }
    }
  }

  Future<void> _showTambah(BuildContext context, WidgetRef ref) async {
    final db = ref.read(academicServiceProvider);
    final opsi = await db.classOptions();
    if (!context.mounted) return;
    final diambil = (await db.grades(mahasiswaId))
        .map((e) => e.kelasId)
        .toSet();
    final tersedia = opsi.where((o) => !diambil.contains(o.kelasId)).toList();
    if (!context.mounted) return;
    if (tersedia.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kelas sudah diambil.')),
      );
      return;
    }
    final res = await showDialog<({int kelasId, double t, double u, double a})>(
      context: context,
      builder: (ctx) => _TambahDialog(opsi: tersedia),
    );
    if (res == null || !context.mounted) return;
    try {
      await db.addKrsNilai(
        mahasiswaId: mahasiswaId,
        kelasId: res.kelasId,
        tugas: res.t,
        uts: res.u,
        uas: res.a,
      );
      await _refresh(ref);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('MK + nilai ditambahkan.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal: $e')));
      }
    }
  }

  Future<void> _confirmHapus(
    BuildContext context,
    WidgetRef ref,
    KrsNilaiItem it,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Hapus ${it.mkKode}?'),
        content: const Text('KRS dan nilainya akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await ref.read(academicServiceProvider).deleteKrs(it.krsId);
    await _refresh(ref);
  }
}

class _BioCard extends StatelessWidget {
  const _BioCard({required this.m});
  final MahasiswaRow m;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              child: Text(
                m.nama.isNotEmpty ? m.nama[0].toUpperCase() : '?',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text('${m.nim} • angk. ${m.angkatan}'),
                  Text(
                    'Status: ${m.status}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (m.email.isNotEmpty || m.noHp.isNotEmpty)
                    Text(
                      [m.email, m.noHp].where((e) => e.isNotEmpty).join(' • '),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingkasanCard extends StatelessWidget {
  const _RingkasanCard({
    required this.ipk,
    required this.sksTempuh,
    required this.sksLulus,
    required this.syaratSks,
    required this.progres,
    required this.statusAkademik,
  });
  final double ipk;
  final int sksTempuh;
  final int sksLulus;
  final int syaratSks;
  final double progres;
  final String statusAkademik;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final lulusSyarat =
        statusAkademik == 'lulus' || sksLulus >= syaratSks && ipk >= 2.0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Stat(label: 'IPK', value: ipk.toStringAsFixed(2)),
                _Stat(label: 'SKS tempuh', value: '$sksTempuh'),
                _Stat(label: 'SKS lulus', value: '$sksLulus/$syaratSks'),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progres / 100,
              minHeight: 8,
              borderRadius: BorderRadius.circular(99),
            ),
            const SizedBox(height: 6),
            Text('Progres kelulusan: ${progres.toStringAsFixed(1)}%'),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (lulusSyarat ? Colors.green : scheme.primary).withValues(
                  alpha: 0.12,
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                lulusSyarat
                    ? 'Memenuhi syarat lulus'
                    : 'Belum memenuhi syarat lulus (butuh $syaratSks SKS & IPK ≥ 2.00)',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: lulusSyarat ? Colors.green.shade800 : scheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// Simulasi IPK target (FR-36): input target + rencana SKS.
class _SimulasiCard extends StatefulWidget {
  const _SimulasiCard({required this.ipk, required this.sksDasar});
  final double ipk;
  final int sksDasar;

  @override
  State<_SimulasiCard> createState() => _SimulasiCardState();
}

class _SimulasiCardState extends State<_SimulasiCard> {
  final _targetCtrl = TextEditingController(text: '3.00');
  final _rencanaCtrl = TextEditingController(text: '20');

  @override
  void dispose() {
    _targetCtrl.dispose();
    _rencanaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final target = double.tryParse(_targetCtrl.text.replaceAll(',', '.')) ?? 0;
    final rencana = int.tryParse(_rencanaCtrl.text) ?? 0;
    String hasil = 'Isi target & rencana SKS.';
    if (target > 0 && target <= 4 && rencana > 0) {
      try {
        final r = engine.simulasiIpk(
          widget.ipk,
          widget.sksDasar,
          rencana,
          target,
        );
        hasil = r.tercapai
            ? 'Butuh IPS ${r.ipsDibutuhkan.toStringAsFixed(2)} semester depan.'
            : 'Tidak tercapai (butuh ${r.ipsDibutuhkan.toStringAsFixed(2)} > 4.00). '
                  'Maksimum mungkin: ${r.ipkMaksimum.toStringAsFixed(2)}.';
      } catch (e) {
        hasil = 'Input tidak valid.';
      }
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulasi IPK target',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _targetCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'IPK target (0-4)',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _rencanaCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Rencana SKS'),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(hasil),
          ],
        ),
      ),
    );
  }
}

class _NilaiCard extends StatelessWidget {
  const _NilaiCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });
  final KrsNilaiItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ok = item.lulusMk;
    final c = ok ? Colors.green.shade700 : scheme.error;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.mkKode} • ${item.sks} SKS',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(item.mkNama),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.adaNilai
                        ? '${item.huruf} • ${ok ? 'Lulus' : 'Mengulang'}'
                        : 'Belum ada nilai',
                    style: TextStyle(
                      color: c,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            if (item.adaNilai) ...[
              const SizedBox(height: 6),
              Text(
                'Tugas ${item.tugas.toStringAsFixed(0)} • UTS ${item.uts.toStringAsFixed(0)} '
                '• UAS ${item.uas.toStringAsFixed(0)} → ${item.akhir.toStringAsFixed(1)} '
                '(bobot ${item.bobot})',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                if (onEdit != null)
                  OutlinedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('Input / Edit'),
                  ),
                const SizedBox(width: 8),
                if (onDelete != null)
                  OutlinedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Hapus'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog input nilai dengan pratinjau akhir + huruf.
class _NilaiDialog extends StatefulWidget {
  const _NilaiDialog({
    required this.title,
    this.initialTugas = 0,
    this.initialUts = 0,
    this.initialUas = 0,
  });
  final String title;
  final double initialTugas;
  final double initialUts;
  final double initialUas;

  @override
  State<_NilaiDialog> createState() => _NilaiDialogState();
}

class _NilaiDialogState extends State<_NilaiDialog> {
  late final TextEditingController _t;
  late final TextEditingController _u;
  late final TextEditingController _a;
  String? _err;

  @override
  void initState() {
    super.initState();
    _t = TextEditingController(text: widget.initialTugas.toStringAsFixed(0));
    _u = TextEditingController(text: widget.initialUts.toStringAsFixed(0));
    _a = TextEditingController(text: widget.initialUas.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _t.dispose();
    _u.dispose();
    _a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = double.tryParse(_t.text.replaceAll(',', '.')) ?? -1;
    final u = double.tryParse(_u.text.replaceAll(',', '.')) ?? -1;
    final a = double.tryParse(_a.text.replaceAll(',', '.')) ?? -1;
    String preview = '-';
    if (t >= 0 && t <= 100 && u >= 0 && u <= 100 && a >= 0 && a <= 100) {
      final akhir = engine.hitungNilaiAkhir(t, u, a);
      final h = engine.konversiHuruf(akhir);
      preview =
          'Akhir ${akhir.toStringAsFixed(1)} → ${h.huruf} (bobot ${h.bobot})';
    }
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _num(_t, 'Tugas (0-100)'),
          const SizedBox(height: 8),
          _num(_u, 'UTS (0-100)'),
          const SizedBox(height: 8),
          _num(_a, 'UAS (0-100)'),
          const SizedBox(height: 8),
          Text(preview, style: const TextStyle(fontWeight: FontWeight.w700)),
          if (_err != null) ...[
            const SizedBox(height: 6),
            Text(
              _err!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () {
            final eT = validateNilaiAngka(_t.text);
            final eU = validateNilaiAngka(_u.text);
            final eA = validateNilaiAngka(_a.text);
            final err = eT ?? eU ?? eA;
            if (err != null) {
              setState(() => _err = err);
              return;
            }
            Navigator.pop(context, (
              t: double.parse(_t.text.replaceAll(',', '.')),
              u: double.parse(_u.text.replaceAll(',', '.')),
              a: double.parse(_a.text.replaceAll(',', '.')),
            ));
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }

  Widget _num(TextEditingController c, String label) => TextField(
    controller: c,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(labelText: label),
    onChanged: (_) => setState(() {}),
  );
}

/// Dialog tambah MK: pilih kelas + nilai awal.
class _TambahDialog extends StatefulWidget {
  const _TambahDialog({required this.opsi});
  final List<KelasOption> opsi;

  @override
  State<_TambahDialog> createState() => _TambahDialogState();
}

class _TambahDialogState extends State<_TambahDialog> {
  late int _kelasId;
  final _t = TextEditingController(text: '75');
  final _u = TextEditingController(text: '75');
  final _a = TextEditingController(text: '75');
  String? _err;

  @override
  void initState() {
    super.initState();
    _kelasId = widget.opsi.first.kelasId;
  }

  @override
  void dispose() {
    _t.dispose();
    _u.dispose();
    _a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah MK + nilai'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              initialValue: _kelasId,
              decoration: const InputDecoration(labelText: 'Kelas / MK'),
              items: widget.opsi
                  .map(
                    (o) => DropdownMenuItem(
                      value: o.kelasId,
                      child: Text('${o.mkKode} • ${o.sks} SKS'),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _kelasId = v ?? _kelasId),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _t,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Tugas (0-100)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _u,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'UTS (0-100)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _a,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'UAS (0-100)'),
            ),
            if (_err != null) ...[
              const SizedBox(height: 6),
              Text(
                _err!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () {
            final err =
                validateNilaiAngka(_t.text) ??
                validateNilaiAngka(_u.text) ??
                validateNilaiAngka(_a.text);
            if (err != null) {
              setState(() => _err = err);
              return;
            }
            Navigator.pop(context, (
              kelasId: _kelasId,
              t: double.parse(_t.text.replaceAll(',', '.')),
              u: double.parse(_u.text.replaceAll(',', '.')),
              a: double.parse(_a.text.replaceAll(',', '.')),
            ));
          },
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
