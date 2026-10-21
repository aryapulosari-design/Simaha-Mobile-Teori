import 'package:flutter/material.dart';

/// SIMAHA Swiss Bento Engineering Spacing System
/// Referensi: stitch_simaha_offline_saas_ui/swiss_bento_engineering/DESIGN.md
class AppSpacing {
  AppSpacing._();

  // Grid & Container Spacing
  static const double gutter = 12.0; // 0.75rem
  static const double gutterTablet = 12.0; // 0.75rem
  static const double gutterMobile = 8.0; // 0.5rem

  // Page Margins
  static const double margin = 24.0; // 1.5rem
  static const double marginMobile = 16.0; // 1rem

  // Sub-grid Spacing (4px base)
  static const double spaceXs = 4.0; // 0.25rem
  static const double spaceSm = 8.0; // 0.5rem
  static const double spaceMd = 12.0; // 0.75rem
  static const double spaceLg = 16.0; // 1rem
  static const double spaceXl = 24.0; // 1.5rem

  // Card Padding
  static const double cardPadding = 16.0;
  static const double cardHeaderPadding = 16.0;
  static const double cardContentPadding = 16.0;

  // Component Dimensions
  static const double buttonHeight = 36.0;
  static const double inputHeight = 36.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 48.0;

  // Elevation Shadows (simplified for Flutter)
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get cardHoverShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
