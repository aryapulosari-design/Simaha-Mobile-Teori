import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/domain/academic/validations.dart';
import 'package:simaha/presentation/providers/app_providers.dart';

/// Form tambah / edit mahasiswa (FR-07/08).
/// Jika [mahasiswaId] null → mode tambah.
class MahasiswaFormPage extends ConsumerStatefulWidget {
  const MahasiswaFormPage({super.key, this.mahasiswaId});
  final int? mahasiswaId;

  @override
  ConsumerState<MahasiswaFormPage> createState() => _MahasiswaFormPageState();
}

class _MahasiswaFormPageState extends ConsumerState<MahasiswaFormPage> {
  final _form = GlobalKey<FormState>();
  final _nim = TextEditingController();
  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _hp = TextEditingController();
  final _angkatan = TextEditingController(text: DateTime.now().year.toString());
  int? _prodiId;
  int? _dosenWaliId;
  String _status = 'aktif';
  bool _loading = true;
  bool _saving = false;

  static const _statuses = ['aktif', 'cuti', 'nonaktif', 'do', 'lulus'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _nim.dispose();
    _nama.dispose();
    _email.dispose();
    _hp.dispose();
    _angkatan.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final id = widget.mahasiswaId;
    if (id != null) {
      final m = await db.getMahasiswa(id);
      if (m != null && mounted) {
        _nim.text = m.nim;
        _nama.text = m.nama;
        _email.text = m.email;
        _hp.text = m.noHp;
        _angkatan.text = m.angkatan.toString();
        _prodiId = m.prodiId;
        _dosenWaliId = m.dosenWaliId;
        _status = m.status;
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    if (_prodiId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Pilih prodi dulu.')));
      return;
    }
    setState(() => _saving = true);
    final db = ref.read(appDatabaseProvider);
    try {
      if (widget.mahasiswaId == null) {
        await db.createMahasiswa(
          nim: _nim.text,
          nama: _nama.text,
          prodiId: _prodiId!,
          angkatan: int.parse(_angkatan.text.trim()),
          status: _status,
          email: _email.text,
          noHp: _hp.text,
          dosenWaliId: _dosenWaliId,
        );
      } else {
        await db.updateMahasiswa(
          id: widget.mahasiswaId!,
          nama: _nama.text,
          prodiId: _prodiId!,
          angkatan: int.parse(_angkatan.text.trim()),
          status: _status,
          email: _email.text,
          noHp: _hp.text,
          dosenWaliId: _dosenWaliId,
        );
      }
      if (mounted) {
        ref
          ..invalidate(dashboardCountsProvider)
          ..invalidate(mahasiswaSearchProvider);
        context.pop(true);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Data tersimpan.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'.replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.mahasiswaId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                children: [
                  TextFormField(
                    controller: _nim,
                    readOnly: isEdit,
                    decoration: InputDecoration(
                      labelText: 'NIM (unik)',
                      helperText: isEdit ? 'NIM tidak bisa diubah' : null,
                    ),
                    validator: (v) => validateNim(v ?? ''),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nama,
                    decoration: const InputDecoration(
                      labelText: 'Nama lengkap',
                    ),
                    validator: (v) => validateNama(v ?? ''),
                  ),
                  const SizedBox(height: 10),
                  _ProdiDropdown(
                    value: _prodiId,
                    onChanged: (v) => setState(() => _prodiId = v),
                  ),
                  const SizedBox(height: 10),
                  _DosenDropdown(
                    value: _dosenWaliId,
                    onChanged: (v) => setState(() => _dosenWaliId = v),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _angkatan,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Angkatan',
                          ),
                          validator: (v) {
                            final n = int.tryParse((v ?? '').trim());
                            if (n == null || n < 2000 || n > 2100) {
                              return 'Tahun tidak valid.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _status,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                          ),
                          items: _statuses
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _status = v ?? _status),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email (opsional)',
                    ),
                    validator: (v) => validateEmail(v ?? ''),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _hp,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'No HP (opsional)',
                    ),
                    validator: (v) => validatePhone(v ?? ''),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEdit ? 'Simpan' : 'Tambah'),
                  ),
                ],
              ),
            ),
    );
  }
}

class _ProdiDropdown extends ConsumerWidget {
  const _ProdiDropdown({required this.value, required this.onChanged});
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    return FutureBuilder<List<ProdiRow>>(
      future: db.listProdi(),
      builder: (ctx, snap) {
        final items = snap.data ?? const <ProdiRow>[];
        return DropdownButtonFormField<int>(
          initialValue: value,
          decoration: const InputDecoration(labelText: 'Prodi'),
          items: items
              .map(
                (p) => DropdownMenuItem(
                  value: p.id,
                  child: Text('${p.kode} • ${p.nama}'),
                ),
              )
              .toList(),
          onChanged: onChanged,
          validator: (v) => v == null ? 'Prodi wajib dipilih.' : null,
        );
      },
    );
  }
}

class _DosenDropdown extends ConsumerWidget {
  const _DosenDropdown({required this.value, required this.onChanged});
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    return FutureBuilder<List<DosenRow>>(
      future: db.listDosen(),
      builder: (ctx, snap) {
        final items = snap.data ?? const <DosenRow>[];
        return DropdownButtonFormField<int?>(
          initialValue: value,
          decoration: const InputDecoration(labelText: 'Dosen wali (opsional)'),
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text('- Tidak ada -'),
            ),
            ...items.map(
              (d) => DropdownMenuItem<int?>(value: d.id, child: Text(d.nama)),
            ),
          ],
          onChanged: onChanged,
        );
      },
    );
  }
}
