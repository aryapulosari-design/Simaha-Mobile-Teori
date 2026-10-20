import 'package:flutter/material.dart';

/// Semantic status chip for academic status, attendance, and risk levels.
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    this.status,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
  });

  final String label;
  final String? status;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final key = (status ?? label).toLowerCase().trim();

    Color bg;
    Color fg;
    IconData ic;

    switch (key) {
      case 'aktif':
      case 'hadir':
      case 'aman':
      case 'disetujui':
      case 'lulus':
        bg = Colors.green.withValues(alpha: 0.15);
        fg = Colors.green.shade800;
        ic = Icons.check_circle_outline;
        break;
      case 'cuti':
      case 'izin':
      case 'waspada':
      case 'draft':
      case 'menunggu':
        bg = Colors.amber.withValues(alpha: 0.2);
        fg = Colors.amber.shade900;
        ic = Icons.schedule_outlined;
        break;
      case 'sakit':
        bg = Colors.orange.withValues(alpha: 0.15);
        fg = Colors.orange.shade900;
        ic = Icons.healing_outlined;
        break;
      case 'alpa':
      case 'nonaktif':
      case 'kritis':
      case 'ditolak':
      case 'do':
      case 'batal':
        bg = Colors.red.withValues(alpha: 0.15);
        fg = Colors.red.shade800;
        ic = Icons.cancel_outlined;
        break;
      default:
        bg = theme.colorScheme.surfaceContainerHighest;
        fg = theme.colorScheme.onSurfaceVariant;
        ic = Icons.info_outline;
    }

    if (theme.brightness == Brightness.dark) {
      fg = switch (key) {
        'aktif' ||
        'hadir' ||
        'aman' ||
        'disetujui' ||
        'lulus' => Colors.green.shade200,
        'cuti' ||
        'izin' ||
        'waspada' ||
        'draft' ||
        'menunggu' => Colors.amber.shade200,
        'sakit' => Colors.orange.shade200,
        'alpa' ||
        'nonaktif' ||
        'kritis' ||
        'ditolak' ||
        'do' ||
        'batal' => Colors.red.shade200,
        _ => theme.colorScheme.onSurfaceVariant,
      };
    }
    if (backgroundColor != null) bg = backgroundColor!;
    if (foregroundColor != null) fg = foregroundColor!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? ic, size: 14, color: fg),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
