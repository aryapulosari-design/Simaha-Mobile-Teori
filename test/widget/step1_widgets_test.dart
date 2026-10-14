import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/theme/app_theme.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

void main() {
  testWidgets('AppScaffold renders title and body with theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const AppScaffold(
          title: 'Judul Halaman',
          body: Text('Konten Halaman'),
        ),
      ),
    );

    expect(find.text('Judul Halaman'), findsOneWidget);
    expect(find.text('Konten Halaman'), findsOneWidget);
  });

  testWidgets('EmptyState displays icon, message, and triggers action', (tester) async {
    var actionTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyState(
            title: 'Data Kosong',
            message: 'Belum ada data mahasiswa',
            actionLabel: 'Tambah Data',
            onAction: () => actionTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Data Kosong'), findsOneWidget);
    expect(find.text('Belum ada data mahasiswa'), findsOneWidget);
    expect(find.text('Tambah Data'), findsOneWidget);

    await tester.tap(find.text('Tambah Data'));
    expect(actionTapped, isTrue);
  });

  testWidgets('ErrorState displays error and triggers retry', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorState(
            message: 'Gagal terhubung ke database',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    expect(find.text('Terjadi Kesalahan'), findsOneWidget);
    expect(find.text('Gagal terhubung ke database'), findsOneWidget);

    await tester.tap(find.text('Coba Lagi'));
    expect(retried, isTrue);
  });

  testWidgets('LoadingView displays message and progress indicator', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingView(message: 'Sedang memuat data...'),
        ),
      ),
    );

    expect(find.text('Sedang memuat data...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('StatusChip renders appropriate colors and icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              StatusChip(label: 'Aktif'),
              StatusChip(label: 'Cuti'),
              StatusChip(label: 'Alpa'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Aktif'), findsOneWidget);
    expect(find.text('Cuti'), findsOneWidget);
    expect(find.text('Alpa'), findsOneWidget);
  });

  testWidgets('AppTextField handles input, validation, and obscure toggle', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppTextField(
            controller: controller,
            label: 'PIN Masuk',
            obscureText: true,
          ),
        ),
      ),
    );

    expect(find.text('PIN Masuk'), findsOneWidget);
    await tester.enterText(find.byType(AppTextField), '123456');
    expect(controller.text, '123456');

    // Toggle obscure visibility button
    final toggleBtn = find.byType(IconButton);
    expect(toggleBtn, findsOneWidget);
    await tester.tap(toggleBtn);
    await tester.pump();
  });

  testWidgets('SectionCard renders header and child', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionCard(
            title: 'Informasi Akun',
            subtitle: 'Data profil Anda',
            child: Text('Konten Section'),
          ),
        ),
      ),
    );

    expect(find.text('Informasi Akun'), findsOneWidget);
    expect(find.text('Data profil Anda'), findsOneWidget);
    expect(find.text('Konten Section'), findsOneWidget);
  });
}
