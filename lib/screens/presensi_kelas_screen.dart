import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';

class PresensiKelasScreen extends StatefulWidget {
  const PresensiKelasScreen({super.key});

  @override
  State<PresensiKelasScreen> createState() => _PresensiKelasScreenState();
}

class _PresensiKelasScreenState extends State<PresensiKelasScreen> {
  String _selectedJenis = 'Berjalan';
  final List<String> _jenisOptions = ['Berjalan', 'Selesai'];

  // null = belum absen, non-null = label status hasil absensi
  String? _attendanceResult;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF3F6FB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isDark),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildJenisDropdown(isDark),
                  const SizedBox(height: 16),
                  _buildCourseChip(),
                  const SizedBox(height: 16),
                  _buildPresensiCard(isDark),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Text(
                'Presensi Kelas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJenisDropdown(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Jenis Presensi:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedJenis,
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
              dropdownColor: isDark ? AppColors.darkCard : Colors.white,
              items: _jenisOptions
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          s,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedJenis = v);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseChip() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Text(
          'Keamanan Informasi (A)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildPresensiCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildCardHeader(),
          _buildCardBody(isDark),
          if (_selectedJenis == 'Selesai')
            _buildHasilPresensi(isDark)
          else if (_attendanceResult == null)
            _buildAttendanceButtons()
          else
            _buildStatusBar(),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: AppColors.primary,
      child: const Text(
        'Sub Capaian Pembelajaran: Praktikum Malware',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildCardBody(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        children: [
          _buildInfoRow('Catatan:', '-', isDark),
          const SizedBox(height: 12),
          _buildInfoRow(
            'Dosen:',
            'Mahendra Data, S.Kom., M.Kom., Ph.D.',
            isDark,
            valueColor: AppColors.primary,
          ),
          const SizedBox(height: 12),
          _buildDeadlineBanner(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark,
      {Color? valueColor}) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: valueColor ??
                (isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildDeadlineBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3DC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Presensi berlangsung hingga 2026-05-11 14:10:00',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.accent,
          fontSize: 13,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ── Hasil presensi saat jenis = Selesai ─────────────────────────────────────

  Widget _buildHasilPresensi(bool isDark) {
    final String result = _attendanceResult ?? 'TERLEWAT';

    final Color statusColor;
    final Color statusBg;
    final IconData statusIcon;
    final String statusLabel;

    if (result.startsWith('HADIR')) {
      statusColor = AppColors.success;
      statusBg = AppColors.successBg;
      statusIcon = Icons.check_circle_rounded;
      statusLabel = result;
    } else if (result == 'IZIN') {
      statusColor = AppColors.warning;
      statusBg = AppColors.warningBg;
      statusIcon = Icons.info_rounded;
      statusLabel = 'IZIN';
    } else if (result == 'SAKIT') {
      statusColor = AppColors.error;
      statusBg = AppColors.errorBg;
      statusIcon = Icons.local_hospital_rounded;
      statusLabel = 'SAKIT';
    } else {
      statusColor = AppColors.textSecondary;
      statusBg = isDark ? AppColors.darkElevated : AppColors.bgGrey;
      statusIcon = Icons.cancel_rounded;
      statusLabel = 'TERLEWAT';
    }

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: statusBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(statusIcon, color: statusColor, size: 22),
          const SizedBox(width: 8),
          Text(
            'Hasil Absensi :',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusLabel,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: statusColor,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ── Tombol 3 pilihan ────────────────────────────────────────────────────────

  Widget _buildAttendanceButtons() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: _attendanceButton('Sakit', const Color(0xFFDC2626),
                onTap: () => _showKonfirmasiSheet('SAKIT')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _attendanceButton('Izin', const Color(0xFFF5A623),
                onTap: () => _showKonfirmasiSheet('IZIN')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _attendanceButton('Hadir', const Color(0xFF16A34A),
                onTap: _showHadirSheet),
          ),
        ],
      ),
    );
  }

  Widget _attendanceButton(String label, Color color,
      {required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }

  // ── Status bar setelah absen ─────────────────────────────────────────────

  Widget _buildStatusBar() {
    final Color barColor;
    if (_attendanceResult!.startsWith('HADIR')) {
      barColor = AppColors.success;
    } else if (_attendanceResult == 'SAKIT') {
      barColor = AppColors.error;
    } else {
      barColor = AppColors.accent;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        'Status Presensi: $_attendanceResult',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ── Bottom sheet: Hadir (Luring / Daring) ────────────────────────────────

  void _showHadirSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _HadirSheet(
        onLuring: () {
          Navigator.pop(context);
          setState(() => _attendanceResult = 'HADIR (Luring)');
        },
        onDaring: () {
          Navigator.pop(context);
          setState(() => _attendanceResult = 'HADIR (Daring)');
        },
      ),
    );
  }

  // ── Bottom sheet: Sakit / Izin ────────────────────────────────────────────

  void _showKonfirmasiSheet(String status) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _KonfirmasiSheet(
        status: status,
        onKonfirmasi: () {
          Navigator.pop(context);
          setState(() => _attendanceResult = status);
        },
      ),
    );
  }
}

// ── Widget bottom sheet Hadir ─────────────────────────────────────────────────

class _HadirSheet extends StatelessWidget {
  final VoidCallback onLuring;
  final VoidCallback onDaring;

  const _HadirSheet({required this.onLuring, required this.onDaring});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Sistem akan mencatat kehadiran Anda\npada mata kuliah Keamanan Informasi\ndengan status:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'HADIR',
            style: TextStyle(
              color: AppColors.success,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Batal
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              // Luring
              ElevatedButton(
                onPressed: onLuring,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'Luring',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 12),
              // Daring
              ElevatedButton(
                onPressed: onDaring,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'Daring',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Widget bottom sheet Sakit / Izin ─────────────────────────────────────────

class _KonfirmasiSheet extends StatelessWidget {
  final String status;
  final VoidCallback onKonfirmasi;

  const _KonfirmasiSheet(
      {required this.status, required this.onKonfirmasi});

  Color get _statusColor {
    if (status == 'SAKIT') return AppColors.error;
    if (status == 'IZIN') return AppColors.accent;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Sistem akan mencatat kehadiran Anda\npada mata kuliah Keamanan Informasi\ndengan status:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            status,
            style: TextStyle(
              color: _statusColor,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 70),
              ElevatedButton(
                onPressed: onKonfirmasi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _statusColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
