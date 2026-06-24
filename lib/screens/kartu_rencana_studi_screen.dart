import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/page_transitions.dart';
import '../widgets/bottom_nav.dart';
import 'informasi_screen.dart';
import 'profile_screen.dart';

class KartuRencanaStudiScreen extends StatefulWidget {
  const KartuRencanaStudiScreen({super.key});

  @override
  State<KartuRencanaStudiScreen> createState() => _KartuRencanaStudiScreenState();
}

class _KartuRencanaStudiScreenState extends State<KartuRencanaStudiScreen> {
  String _selectedSemester = 'Ganjil 2024/2025';
  String _selectedJenis = 'Reguler';

  final List<String> _semesters = [
    'Ganjil 2024/2025',
    'Genap 2023/2024',
    'Ganjil 2023/2024',
  ];
  final List<String> _jenisSemester = ['Reguler', 'Pendek'];

  final List<Map<String, String>> _mataKuliah = [
    {'nama': 'Rekayasa Perangkat Lunak', 'kelas': 'E', 'sks': '4', 'kode': 'CIF61101'},
    {'nama': 'Rekayasa Perangkat Lunak', 'kelas': 'E', 'sks': '4', 'kode': 'CIF61101'},
    {'nama': 'Rekayasa Perangkat Lunak', 'kelas': 'E', 'sks': '4', 'kode': 'CIF61101'},
    {'nama': 'Rekayasa Perangkat Lunak', 'kelas': 'E', 'sks': '4', 'kode': 'CIF61101'},
  ];

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
                'Kartu Rencana Studi',
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

  Widget _buildMataKuliahCard(bool isDark, Map<String, String> mk) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mk['nama']!,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildBadge('Kelas : ${mk['kelas']}', const Color(0xFFEDE9FE), const Color(0xFF6D28D9)),
              const SizedBox(width: 8),
              _buildBadge('${mk['sks']} SKS', const Color(0xFFFFD4A8), const Color(0xFFB45309)),
              const SizedBox(width: 8),
              _buildBadge('Kode : ${mk['kode']}', const Color(0xFFDBEAFE), AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
