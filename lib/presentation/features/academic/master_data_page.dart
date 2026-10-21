import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/data/services/master_data_service.dart';
import 'package:simaha/domain/academic/registration_policy.dart';
import 'package:simaha/presentation/features/academic/academic_workspace_page.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

final masterDataProvider = FutureProvider.autoDispose(
  (ref) => MasterDataService(ref.watch(academicServiceProvider)).snapshot(),
);

class MasterDataPage extends ConsumerWidget {
  const MasterDataPage({super.key});

  void _refresh(WidgetRef ref) {
    ref.invalidate(masterDataProvider);
    ref.invalidate(academicClassesProvider);
    ref.invalidate(workspaceOverviewProvider);
    ref.invalidate(dashboardCountsProvider);
    ref.invalidate(mahasiswaSearchProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = MasterDataService(ref.watch(academicServiceProvider));
    return Scaffold(
      appBar: AppBar(title: const Text('Data master akademik')),
      body: ref
          .watch(masterDataProvider)
          .when(
            loading: () => const LoadingView(),
            error: (e, _) =>
                ErrorState(message: '$e', onRetry: () => _refresh(ref)),
            data: (data) {
              final groups =
                  <MasterKind, List<({int id, String title, String detail})>>{
                    MasterKind.program: [
                      for (final r in data.programs)
                        (id: r.id, title: r.nama, detail: r.kode),
                    ],
                    MasterKind.lecturer: [
                      for (final r in data.lecturers)
                        (id: r.id, title: r.nama, detail: 'NIDN ${r.nidn}'),
                    ],
                    MasterKind.term: [
                      for (final r in data.terms)
                        (
                          id: r.id,
                          title: termLabel(r.tahun, r.semester),
                          detail: r.isActive ? 'Semester aktif' : 'Tidak aktif',
                        ),
                    ],
                    MasterKind.course: [
                      for (final r in data.courses)
                        (
                          id: r.id,
                          title: '${r.kode} — ${r.nama}',
                          detail: '${r.sks} SKS • Semester ${r.semester}',
                        ),
                    ],
                    MasterKind.classroom: [
                      for (final r in data.classes)
                        (
                          id: r.id,
                          title:
                              '${data.courses.where((c) => c.id == r.mkId).first.nama} / ${r.ruang}',
                          detail: '${r.hari} ${r.jamMulai}–${r.jamSelesai}',
                        ),
                    ],
                  };
              Future<void> edit(MasterKind kind, [int? id]) async {
                final saved = await showDialog<bool>(
                  context: context,
                  builder: (_) => _MasterForm(
                    kind: kind,
                    id: id,
                    data: data,
                    service: service,
                  ),
                );
                if (saved == true) _refresh(ref);
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Siapkan prodi, dosen, semester, mata kuliah, lalu kelas. Hubungkan akun dosen melalui Kelola akun; tambahkan peserta melalui KRS mahasiswa.',
                  ),
                  const SizedBox(height: 16),
                  for (final kind in MasterKind.values)
                    Card(
                      child: ExpansionTile(
                        title: Text('${kind.label} (${groups[kind]!.length})'),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              onPressed: () => edit(kind),
                              icon: const Icon(Icons.add),
                              label: Text('Tambah ${kind.label.toLowerCase()}'),
                            ),
                          ),
                          for (final row in groups[kind]!)
                            ListTile(
                              title: Text(row.title),
                              subtitle: Text(row.detail),
                              onTap: () => edit(kind, row.id),
                              trailing: IconButton(
                                tooltip: 'Hapus ${kind.label}',
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                      title: Text('Hapus ${row.title}?'),
                                      content: const Text(
                                        'Data yang masih digunakan tidak dapat dihapus.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            false,
                                          ),
                                          child: const Text('Batal'),
                                        ),
                                        FilledButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            true,
                                          ),
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirmed != true) return;
                                  try {
                                    await service.delete(kind, row.id);
                                    _refresh(ref);
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            SnackBar(content: Text('$e')),
                                          );
                                    }
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
    );
  }
}

class _MasterForm extends StatefulWidget {
  const _MasterForm({
    required this.kind,
    required this.id,
    required this.data,
    required this.service,
  });
  final MasterKind kind;
  final int? id;
  final MasterSnapshot data;
  final MasterDataService service;
  @override
  State<_MasterForm> createState() => _MasterFormState();
}

class _MasterFormState extends State<_MasterForm> {
  final fields = <String, TextEditingController>{};
  int? program, lecturer, course, term;
  int semester = 1;
  bool active = false, saving = false;
  String day = 'Senin';
  String? error;
  final prerequisites = <int>{};

  @override
  void initState() {
    super.initState();
    final d = widget.data, id = widget.id;
    program = d.programs.firstOrNull?.id;
    lecturer = d.lecturers.firstOrNull?.id;
    course = d.courses.firstOrNull?.id;
    term =
        d.terms.where((t) => t.isActive).firstOrNull?.id ??
        d.terms.firstOrNull?.id;
    final values = <String, String>{
      'code': '',
      'name': '',
      'nidn': '',
      'year': '2026/2027',
      'credits': '3',
      'semester': '1',
      'start': '08:00',
      'end': '10:00',
      'room': '',
    };
    if (id != null) {
      switch (widget.kind) {
        case MasterKind.program:
          final r = d.programs.firstWhere((r) => r.id == id);
          values.addAll({'code': r.kode, 'name': r.nama});
        case MasterKind.lecturer:
          final r = d.lecturers.firstWhere((r) => r.id == id);
          values.addAll({'nidn': r.nidn, 'name': r.nama});
          program = r.prodiId;
        case MasterKind.term:
          final r = d.terms.firstWhere((r) => r.id == id);
          values['year'] = r.tahun;
          semester = r.semester;
          active = r.isActive;
        case MasterKind.course:
          final r = d.courses.firstWhere((r) => r.id == id);
          values.addAll({
            'code': r.kode,
            'name': r.nama,
            'credits': '${r.sks}',
            'semester': '${r.semester}',
          });
          program = r.prodiId;
          prerequisites.addAll(
            d.prerequisites
                .where((p) => p.mkId == id)
                .map((p) => p.prasyaratMkId),
          );
        case MasterKind.classroom:
          final r = d.classes.firstWhere((r) => r.id == id);
          course = r.mkId;
          lecturer = r.dosenId;
          term = r.taId;
          day = r.hari;
          values.addAll({
            'start': r.jamMulai,
            'end': r.jamSelesai,
            'room': r.ruang,
          });
      }
    }
    for (final e in values.entries) {
      fields[e.key] = TextEditingController(text: e.value);
    }
  }

  @override
  void dispose() {
    for (final c in fields.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget text(String key, String label, {bool number = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: fields[key],
      keyboardType: number ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
    ),
  );

  Widget select(
    String label,
    int? value,
    Map<int, String> options,
    ValueChanged<int?> change,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<int>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final e in options.entries)
          DropdownMenuItem(
            value: e.key,
            child: Text(e.value, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: (v) => setState(() => change(v)),
    ),
  );

  Future<void> save() async {
    setState(() {
      saving = true;
      error = null;
    });
    String value(String key) => fields[key]!.text;
    int requiredId(int? id, String name) {
      if (id == null) throw ArgumentError('Tambahkan $name terlebih dahulu.');
      return id;
    }

    try {
      final s = widget.service, id = widget.id;
      switch (widget.kind) {
        case MasterKind.program:
          await s.saveProgram(id: id, code: value('code'), name: value('name'));
        case MasterKind.lecturer:
          await s.saveLecturer(
            id: id,
            nidn: value('nidn'),
            name: value('name'),
            programId: requiredId(program, 'prodi'),
          );
        case MasterKind.term:
          await s.saveTerm(
            id: id,
            year: value('year'),
            semester: semester,
            active: active,
          );
        case MasterKind.course:
          await s.saveCourse(
            id: id,
            code: value('code'),
            name: value('name'),
            credits: int.tryParse(value('credits')) ?? 0,
            semester: int.tryParse(value('semester')) ?? 0,
            programId: requiredId(program, 'prodi'),
            prerequisites: prerequisites,
          );
        case MasterKind.classroom:
          await s.saveClass(
            id: id,
            courseId: requiredId(course, 'mata kuliah'),
            lecturerId: requiredId(lecturer, 'dosen'),
            termId: requiredId(term, 'tahun ajaran'),
            day: day,
            start: value('start'),
            end: value('end'),
            room: value('room'),
          );
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() {
          error = '$e';
          saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data, kind = widget.kind;
    return AlertDialog(
      title: Text(
        '${widget.id == null ? 'Tambah' : 'Ubah'} ${kind.label.toLowerCase()}',
      ),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if ([MasterKind.program, MasterKind.course].contains(kind))
                text('code', 'Kode'),
              if (kind == MasterKind.lecturer)
                text('nidn', 'NIDN', number: true),
              if ([
                MasterKind.program,
                MasterKind.lecturer,
                MasterKind.course,
              ].contains(kind))
                text('name', 'Nama'),
              if ([MasterKind.lecturer, MasterKind.course].contains(kind))
                select('Program studi', program, {
                  for (final r in d.programs) r.id: r.nama,
                }, (v) => program = v),
              if (kind == MasterKind.term) ...[
                text('year', 'Tahun ajaran (2026/2027)'),
                select('Semester', semester, {
                  1: 'Gasal',
                  2: 'Genap',
                  3: 'Pendek',
                }, (v) => semester = v!),
                SwitchListTile(
                  title: const Text('Semester aktif'),
                  value: active,
                  onChanged: (v) => setState(() => active = v),
                ),
              ],
              if (kind == MasterKind.course) ...[
                text('credits', 'SKS (1–6)', number: true),
                text('semester', 'Semester kurikulum', number: true),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Prasyarat (opsional)'),
                ),
                for (final r in d.courses.where((r) => r.id != widget.id))
                  CheckboxListTile(
                    title: Text('${r.kode} — ${r.nama}'),
                    value: prerequisites.contains(r.id),
                    onChanged: (v) => setState(() {
                      if (v == true) {
                        prerequisites.add(r.id);
                      } else {
                        prerequisites.remove(r.id);
                      }
                    }),
                  ),
              ],
              if (kind == MasterKind.classroom) ...[
                select('Mata kuliah', course, {
                  for (final r in d.courses) r.id: '${r.kode} — ${r.nama}',
                }, (v) => course = v),
                select('Dosen pengampu', lecturer, {
                  for (final r in d.lecturers) r.id: r.nama,
                }, (v) => lecturer = v),
                select('Tahun ajaran', term, {
                  for (final r in d.terms) r.id: termLabel(r.tahun, r.semester),
                }, (v) => term = v),
                DropdownButtonFormField<String>(
                  initialValue: day,
                  decoration: const InputDecoration(labelText: 'Hari'),
                  items: [
                    for (final day in weekDays)
                      DropdownMenuItem(value: day, child: Text(day)),
                  ],
                  onChanged: (v) => setState(() => day = v!),
                ),
                const SizedBox(height: 12),
                text('start', 'Jam mulai (HH:MM)'),
                text('end', 'Jam selesai (HH:MM)'),
                text('room', 'Ruang'),
              ],
              if (error != null)
                Text(
                  error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: saving ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: saving ? null : save,
          child: Text(saving ? 'Menyimpan…' : 'Simpan'),
        ),
      ],
    );
  }
}
