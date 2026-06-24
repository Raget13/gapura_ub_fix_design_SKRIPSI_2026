import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';
import '../screens/sidebar_drawer.dart';
import 'informasi_screen.dart';
import 'profile_screen.dart';
import '../core/page_transitions.dart';

class AkademikScreen extends StatelessWidget {
  const AkademikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF3F6FB),
      drawer: const SidebarDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text('Gapura UB', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                children: [
                  _menuItem(
                    context,
                    isDark,
                    icon: Icons.payments_outlined,
                    label: 'Biaya Kuliah',
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    context,
                    isDark,
                    icon: Icons.bar_chart_rounded,
                    label: 'Hasil Studi',
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    context,
                    isDark,
                    icon: Icons.calendar_month_outlined,
                    label: 'Jadwal & Presensi Kelas',
                  ),
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
            Navigator.pop(context);
          } else if (i == 2) {
            Navigator.pushReplacement(context, navRoute(const InformasiScreen()));
          } else if (i == 3) {
            Navigator.pushReplacement(context, navRoute(const ProfileScreen()));
          }
        },
      ),
    );
  }


  Widget _menuItem(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
