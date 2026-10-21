import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/data/services/study_export_service.dart';
import 'package:simaha/presentation/providers/app_providers.dart';

class ExportStudyButton extends ConsumerStatefulWidget {
  const ExportStudyButton({super.key, required this.studentId});
  final int studentId;
  @override
  ConsumerState<ExportStudyButton> createState() => _ExportStudyButtonState();
}

class _ExportStudyButtonState extends ConsumerState<ExportStudyButton> {
  bool _busy = false;
  Future<void> _save() async {
    setState(() => _busy = true);
    try {
      final bytes = await StudyExportService(ref.read(academicServiceProvider))
          .transcript(widget.studentId);
      final path = await FilePicker.saveFile(
        dialogTitle: 'Simpan hasil studi',
        fileName: 'hasil-studi-${widget.studentId}.pdf',
        mimeType: 'application/pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        bytes: bytes,
      );
      if (path != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF hasil studi berhasil disimpan.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('PDF belum dapat disimpan. $e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: _busy ? null : _save,
    icon: _busy
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.download_outlined, size: 18),
    label: Text(_busy ? 'Menyiapkan PDF...' : 'Simpan hasil studi PDF'),
  );
}
