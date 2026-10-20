> Status terkini 20 Oktober 2026: lihat [audit](doct/audit/README.md) dan [desain](doct/design/README.md). Daftar berikut menyimpan konteks integrasi desain terdahulu.

# Todo List - SIMAHA Offline

## Design System Integration

- [x] Existing project Flutter dengan struktur folder: `presentation`, `domain`, `data`, `shared`
- [x] Implementasi design system Swiss Bento: warna primary (`#00685f`), typography (Plus Jakarta Sans, Inter, JetBrains Mono), spacing (0.5/0.75/1rem), rounding
- [x] Update UI components berdasarkan desain reference (SectionCard, StatusChip, EmptyState, ErrorState, LoadingView, ConfirmDialog, AppTextField)
- [x] Update core theme dengan palette Swiss Bento
- [x] Implementasi shared widgets baru: `app_shell.dart`, `auto_lock_scope.dart`, `status_pill.dart`

## Implementation

- [ ] Presensi QR DINAMIS (Buka Presensi QR Dinamis dari beranda dosen/mahasiswa)
- [ ] Ringkasan Akademik dengan IPK kumulatif & tren IPS
- [ ] Feed Pengumuman Akademik dengan badge unread
- [ ] Evaluation Dosen Anonim (EDOM) dengan progress bars

## Deskripsi

Mengintegrasikan desain Swiss Bento Engineering (dari `stitch_simaha_offline_saas_ui`) ke project Flutter SIMAHA yang sudah ada. Fokus pada color palette, typography, spacing, dan komponen UI yang lebih konsisten dengan spesifikasi design system.

## Status

Design system Swiss Bento telah diimplementasikan:
- **Colors**: Palette primary/emerald (`#00685f`), secondary/slate, tertiary/indigo, error/crimson
- **Typography**: Plus Jakarta Sans (headings), Inter (body), JetBrains Mono (monospace)
- **Spacing**: Grid 12px, margin 24px/16px, sub-grid 4px/8px/12px/16px/24px
- **Components**: AppTextField, SectionCard, StatusChip, StatusPill, EmptyState, ErrorState, LoadingView, ConfirmDialog
- **Theme**: Light/Dark support dengan Material 3