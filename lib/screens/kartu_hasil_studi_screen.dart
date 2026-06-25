import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/page_transitions.dart';
import '../widgets/bottom_nav.dart';
import 'informasi_screen.dart';
import 'profile_screen.dart';

class KartuHasilStudiScreen extends StatefulWidget {
  const KartuHasilStudiScreen({super.key});

  @override
  State<KartuHasilStudiScreen> createState() => _KartuHasilStudiScreenState();
}

class _KartuHasilStudiScreenState extends State<KartuHasilStudiScreen> {
  String _selectedSemester = 'Ganjil 2024/2025';
  String _selectedJenis = 'Reguler';

  final List<String> _semesters = [
    'Ganjil 2024/2025',
    'Genap 2023/2024',
    'Ganjil 2023/2024',
  ];
  final List<String> _jenisSemester = ['Reguler', 'Pendek'];

  final Map<String, List<Map<String, String>>> _mataKuliahBySemester = {
    'Ganjil 2024/2025': [
      {'nama': 'Rekayasa Perangkat Lunak', 'nilai': 'A', 'sks': '4', 'kode': 'CIF61101'},
      {'nama': 'Kecerdasan Buatan', 'nilai': 'A-', 'sks': '3', 'kode': 'CIF61203'},
      {'nama': 'Jaringan Komputer', 'nilai': 'B+', 'sks': '3', 'kode': 'CIF61305'},
      {'nama': 'Basis Data Lanjut', 'nilai': 'A', 'sks': '3', 'kode': 'CIF61402'},
    ],
    'Genap 2023/2024': [
      {'nama': 'Pemrograman Mobile', 'nilai': 'A', 'sks': '4', 'kode': 'CIF60901'},
      {'nama': 'Sistem Operasi', 'nilai': 'B+', 'sks': '3', 'kode': 'CIF60702'},
      {'nama': 'Pemrograman Web', 'nilai': 'A', 'sks': '3', 'kode': 'CIF60803'},
      {'nama': 'Statistika & Probabilitas', 'nilai': 'B', 'sks': '2', 'kode': 'MAT60401'},
      {'nama': 'Etika Profesi', 'nilai': 'A', 'sks': '2', 'kode': 'CIF60501'},
    ],
    'Ganjil 2023/2024': [
      {'nama': 'Algoritma & Struktur Data', 'nilai': 'A', 'sks': '4', 'kode': 'CIF50301'},
      {'nama': 'Matematika Diskrit', 'nilai': 'B+', 'sks': '3', 'kode': 'MAT50201'},
      {'nama': 'Pemrograman Berorientasi Objek', 'nilai': 'A', 'sks': '4', 'kode': 'CIF50402'},
      {'nama': 'Sistem Digital', 'nilai': 'B', 'sks': '3', 'kode': 'CIF50503'},
    ],
  };

  final Map<String, Map<String, String>> _summaryBySemester = {
    'Ganjil 2024/2025': {
      'ipLulus': '3.73', 'ipBeban': '3.73',
      'ipkLulus': '3.75', 'ipkBeban': '3.75',
      'sksLulus': '13', 'sksBeban': '13',
      'skskLulus': '89', 'skskBeban': '89',
    },
    'Genap 2023/2024': {
      'ipLulus': '3.68', 'ipBeban': '3.68',
      'ipkLulus': '3.71', 'ipkBeban': '3.71',
      'sksLulus': '14', 'sksBeban': '14',
      'skskLulus': '76', 'skskBeban': '76',
    },
    'Ganjil 2023/2024': {
      'ipLulus': '3.62', 'ipBeban': '3.62',
      'ipkLulus': '3.65', 'ipkBeban': '3.65',
      'sksLulus': '14', 'sksBeban': '14',
      'skskLulus': '62', 'skskBeban': '62',
    },
  };

  List<Map<String, String>> get _mataKuliah =>
      _mataKuliahBySemester[_selectedSemester] ?? [];

  Map<String, String> get _summary =>
      _summaryBySemester[_selectedSemester] ?? {};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF3F6FB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterCard(isDark),
                  const SizedBox(height: 16),
                  _buildSummaryCard(isDark, _summary),
                  const SizedBox(height: 16),
                  ..._mataKuliah.map((mk) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildMataKuliahCard(isDark, mk),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (i) {
          if (i == 1) return;
          if (i == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (i == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              navRoute(const InformasiScreen()),
              (route) => route.isFirst,
            );
          } else if (i == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              navRoute(const ProfileScreen()),
              (route) => route.isFirst,
            );
          }
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
              padding: EdgeInsets.fromLTRB(20, 50, 20, 24),
              child: Text(
                'Kartu Hasil Studi',
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

  Widget _buildFilterCard(bool isDark) {
    return Container(
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
      child: Column(
        children: [
          _buildDropdownRow(
            isDark,
            label: 'Pilih Semester:',
            value: _selectedSemester,
            items: _semesters,
            onChanged: (v) => setState(() => _selectedSemester = v!),
            showDivider: true,
          ),
          _buildDropdownRow(
            isDark,
            label: 'Jenis Semester:',
            value: _selectedJenis,
            items: _jenisSemester,
            onChanged: (v) => setState(() => _selectedJenis = v!),
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(
    bool isDark, {
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  ),
                  dropdownColor: isDark ? AppColors.darkCard : Colors.white,
                  items: items
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(
                              s,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? AppColors.darkBorder : AppColors.borderGrey,
          ),
      ],
    );
  }

  Widget _buildSummaryCard(bool isDark, Map<String, String> summary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatItem(isDark, value: '${summary['ipLulus']} / ${summary['ipBeban']}', label: 'IP Lulus/Beban'),
              _buildStatItem(isDark, value: '${summary['ipkLulus']} / ${summary['ipkBeban']}', label: 'IP Kumulatif Lulus/Beban'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem(isDark, value: '${summary['sksLulus']} / ${summary['sksBeban']}', label: 'SKS Lulus/Beban'),
              _buildStatItem(isDark, value: '${summary['skskLulus']} / ${summary['skskBeban']}', label: 'SKS Kumulatif Lulus/Beban'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(bool isDark, {required String value, required String label}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkAccentBlue : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.bgGrey : const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMataKuliahCard(bool isDark, Map<String, String> mk) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.borderGrey,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              mk['nilai']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 27,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mk['nama']!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildBadge('${mk['sks']} SKS', const Color(0xFFFFD4A8), const Color(0xFFB45309)),
                    const SizedBox(width: 8),
                    _buildBadge('Kode : ${mk['kode']}', const Color(0xFFDBEAFE), AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
