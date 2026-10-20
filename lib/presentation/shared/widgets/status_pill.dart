import 'package:flutter/material.dart';
import 'package:simaha/core/theme/app_colors.dart';

/// Semantic status pill for academic status, attendance, and risk levels.
/// Swiss Bento style with pill geometry and icon + label.
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.status,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.size = StatusPillSize.medium,
  });

  final String label;
  final String? status;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;
  final StatusPillSize size;

  static Color _defaultBg(String key) {
    switch (key) {
      case 'aktif':
      case 'hadir':
      case 'aman':
      case 'disetujui':
      case 'lulus':
        return AppColors.primaryFixed;
      case 'cuti':
      case 'izin':
      case 'waspada':
      case 'draft':
      case 'menunggu':
        return AppColors.secondaryFixed;
      case 'sakit':
        return AppColors.tertiaryFixed;
      case 'alpa':
      case 'nonaktif':
      case 'kritis':
      case 'ditolak':
      case 'do':
      case 'batal':
        return AppColors.errorContainer;
      default:
        return AppColors.surfaceContainer;
    }
  }

  static Color _defaultFg(String key) {
    switch (key) {
      case 'aktif':
      case 'hadir':
      case 'aman':
      case 'disetujui':
      case 'lulus':
        return AppColors.onPrimary;
      case 'cuti':
      case 'izin':
      case 'waspada':
      case 'draft':
      case 'menunggu':
        return AppColors.onSecondaryContainer;
      case 'sakit':
        return AppColors.onTertiaryFixedVariant;
      case 'alpa':
      case 'nonaktif':
      case 'kritis':
      case 'ditolak':
      case 'do':
      case 'batal':
        return AppColors.onErrorContainer;
      default:
        return AppColors.onSurfaceVariant;
    }
  }

  static IconData? _defaultIcon(String key) {
    switch (key) {
      case 'aktif':
      case 'hadir':
      case 'aman':
      case 'disetujui':
      case 'lulus':
        return Icons.check_circle_outline;
      case 'cuti':
      case 'izin':
      case 'waspada':
      case 'draft':
      case 'menunggu':
        return Icons.schedule_outlined;
      case 'sakit':
        return Icons.healing_outlined;
      case 'alpa':
      case 'nonaktif':
      case 'kritis':
      case 'ditolak':
      case 'do':
      case 'batal':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final key = (status ?? label).toLowerCase().trim();
    final bg = backgroundColor ?? _defaultBg(key);
    final fg = foregroundColor ?? _defaultFg(key);
    final ic = icon ?? _defaultIcon(key);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size == StatusPillSize.small ? 8 : 10,
        vertical: size == StatusPillSize.small ? 4 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (ic != null)
            Icon(ic, size: size == StatusPillSize.small ? 12 : 14, color: fg),
          if (ic != null) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: size == StatusPillSize.small ? 10 : 12,
              fontFamily: 'JetBrains Mono',
              letterSpacing: -0.01,
            ),
          ),
        ],
      ),
    );
  }
}

enum StatusPillSize { small, medium }
