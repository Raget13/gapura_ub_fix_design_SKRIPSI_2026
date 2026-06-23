import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';
import 'akademik_screen.dart';
import 'riwayat_pertemuan_screen.dart';

class JadwalPresensiScreen extends StatefulWidget {
  const JadwalPresensiScreen({super.key});

  @override
  State<JadwalPresensiScreen> createState() => _JadwalPresensiScreenState();
}

class _JadwalPresensiScreenState extends State<JadwalPresensiScreen> {
  String _selectedSemester = 'Reguler';
  int _selectedDayIndex = 0;
  int _currentNavIndex = 1;
  bool _reminderActive = false;

  final List<String> _days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  final List<String> _semesters = ['Reguler', 'Pendek'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.pop(context, _reminderActive);
      },
      child: Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF3F6FB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isDark),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSemesterDropdown(isDark),
                  const SizedBox(height: 14),
                  _buildDayTabs(isDark),
                  const SizedBox(height: 16),
                  _buildCourseCard(context, isDark, _days[_selectedDayIndex]),
                  const SizedBox(height: 12),
                  _buildCourseCard(context, isDark, _days[_selectedDayIndex]),
                  const SizedBox(height: 20),
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
          if (i == 0) Navigator.pop(context, _reminderActive);
        },
      ),
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
                onPressed: () => Navigator.pop(context, _reminderActive),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Text(
                'Jadwal & Presensi Kuliah',
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

  Widget _buildSemesterDropdown(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
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
            'Jenis Semester:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSemester,
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
              dropdownColor: isDark ? AppColors.darkCard : Colors.white,
              items: _semesters
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
              onChanged: (v) {
                if (v != null) setState(() => _selectedSemester = v);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayTabs(bool isDark) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSelected = i == _selectedDayIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : (isDark ? AppColors.darkCard : Colors.white),
                borderRadius: BorderRadius.circular(50),
                border: isSelected
                    ? null
                    : Border.all(color: AppColors.borderGrey),
              ),
              child: Text(
                _days[i],
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, bool isDark, String day) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AkademikScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.8),
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
            _buildCardTopSection(isDark, day),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    _buildDataPresensiBar(),
                    _buildStatsGrid(isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTopSection(bool isDark, String day) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 14, 14),
      child: IntrinsicHeight(
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Kolom kiri: badge hari (atas) + SKS+Jam (bawah), lebar otomatis sama
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '6',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                height: 1,
                              ),
                            ),
                            Text(
                              'SKS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF5B8BD6),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '07:00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                height: 1,
                              ),
                            ),
                            Text(
                              '08:39',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Kolom kanan: nama matkul + bell (atas), lokasi (bawah)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '(A) Rekayasa\nPerangkat Lunak',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showReminderSheet(isDark),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: _reminderActive
                              ? AppColors.accent
                              : const Color(0xFFD1D5DB),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _reminderActive
                              ? Icons.notifications_active
                              : Icons.notifications,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.infoBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Gedung F - FILKOM F2.1',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  void _showReminderSheet(bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.accentLight.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_active,
                color: AppColors.accent,
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Aktifkan Pengingat?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Sistem akan memberikan pengingat 30 menit sebelum mata kuliah dimulai. Apakah Anda bersedia mengaktifkan fitur pengingat ini?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => _reminderActive = true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: const Text('Iya',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: const Text('Tidak',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataPresensiBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      color: AppColors.primary,
      child: Row(
        children: [
          const Text(
            'Data Presensi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RiwayatPertemuanScreen()),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Riwayat',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(bool isDark) {
    final bgColor = isDark ? AppColors.darkElevated : const Color(0xFFEEF4FF);
    final divColor = isDark ? AppColors.darkBorder : AppColors.border;

    return Container(
      color: bgColor,
      child: Column(
        children: [
          Row(
            children: [
              _statCell('Pertemuan', '12', AppColors.textPrimary, isDark),
              _vertDivider(divColor),
              _statCell('Hadir', '10', AppColors.success, isDark),
              _vertDivider(divColor),
              _statCell('Izin', '1', AppColors.warning, isDark),
            ],
          ),
          Divider(height: 1, thickness: 1, color: divColor),
          Row(
            children: [
              _statCell('Alpha', '0', AppColors.error, isDark),
              _vertDivider(divColor),
              _statCell('Sakit', '1', AppColors.warning, isDark),
              _vertDivider(divColor),
              _statCell('Rekap', '83%', AppColors.success, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCell(String label, String value, Color valueColor, bool isDark) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vertDivider(Color color) {
    return Container(width: 1, height: 60, color: color);
  }
}