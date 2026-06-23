import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';

enum _StatusPresensi { hadir, izin, sakit, alpha }

class RiwayatPertemuanScreen extends StatefulWidget {
  const RiwayatPertemuanScreen({super.key});

  @override
  State<RiwayatPertemuanScreen> createState() => _RiwayatPertemuanScreenState();
}

class _RiwayatPertemuanScreenState extends State<RiwayatPertemuanScreen> {
  int _currentNavIndex = 1;

  final List<Map<String, dynamic>> _riwayat = [
    {
      'subCapaian': 'Sub Capaian Pembelajaran: Pengenalan Algoritma',
      'catatan': '-',
      'status': _StatusPresensi.hadir,
    },
    {
      'subCapaian': 'Sub Capaian Pembelajaran: Analisis Algoritma Rekursif',
      'catatan': '-',
      'status': _StatusPresensi.izin,
    },
    {
      'subCapaian': 'Sub Capaian Pembelajaran: Order of Growth',
      'catatan': '-',
      'status': _StatusPresensi.alpha,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF3F6FB),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                children: [
                  _buildCourseTitle(isDark),
                  const SizedBox(height: 20),
                  ..._riwayat.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildCard(isDark, item),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (i) {
          setState(() => _currentNavIndex = i);
          if (i == 0) Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildHeader() {
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 16, 20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'Riwayat Pertemuan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseTitle(bool isDark) {
    return Column(
      children: [
        Text(
          'CIF64112: Desain dan Analisis Algoritma Kelas B',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Divider(
          thickness: 1,
          color: isDark ? AppColors.darkBorder : AppColors.borderGrey,
        ),
      ],
    );
  }

  Widget _buildCard(bool isDark, Map<String, dynamic> item) {
    final status = item['status'] as _StatusPresensi;

    final Color statusBg;
    final Color statusColor;
    final IconData statusIcon;
    final String statusText;

    switch (status) {
      case _StatusPresensi.hadir:
        statusBg = isDark
            ? const Color(0xFF14532D).withValues(alpha: 0.35)
            : AppColors.successBg;
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle_outline;
        statusText = 'HADIR';
        break;
      case _StatusPresensi.izin:
        statusBg = isDark
            ? const Color(0xFF713F12).withValues(alpha: 0.35)
            : AppColors.warningBg;
        statusColor = AppColors.warning;
        statusIcon = Icons.info_outline;
        statusText = 'IZIN';
        break;
      case _StatusPresensi.sakit:
        statusBg = isDark
            ? const Color(0xFF713F12).withValues(alpha: 0.35)
            : AppColors.warningBg;
        statusColor = AppColors.warning;
        statusIcon = Icons.info_outline;
        statusText = 'SAKIT';
        break;
      case _StatusPresensi.alpha:
        statusBg = isDark
            ? const Color(0xFF7F1D1D).withValues(alpha: 0.35)
            : AppColors.errorBg;
        statusColor = AppColors.error;
        statusIcon = Icons.cancel_outlined;
        statusText = 'ALPHA';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header sub capaian
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            color: AppColors.primary,
            child: Text(
              item['subCapaian'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          // Catatan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            color: isDark ? AppColors.darkCard : Colors.white,
            child: Text(
              'Catatan: ${item['catatan']}',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
            ),
          ),
          // Status presensi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: statusBg,
            child: Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Status Presensi : $statusText',
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
