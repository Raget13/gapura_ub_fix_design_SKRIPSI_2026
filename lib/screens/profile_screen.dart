import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';
import 'sidebar_drawer.dart';
import 'opening_login_screen.dart';
import 'data_mahasiswa_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _handleLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Keluar', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const OpeningLoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Keluar', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : Colors.white,
      drawer: const SidebarDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Gapura UB', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Header biru — avatar + nama di dalam container =====
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Avatar
                  Container(
                    width: 110, height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLight,
                      border: Border.all(color: Colors.white.withOpacity(0.4), width: 4),
                    ),
                    child: const Icon(Icons.person, size: 64, color: Colors.white),
                  ),

                  const SizedBox(height: 14),

                  // Nama
                  const Text('Nama Mahasiswa',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text('22518383837',
                      style: TextStyle(fontSize: 14, color: Color(0xFFBFDBFE))),
                  const SizedBox(height: 14),

                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 16, color: Color(0xFFFFF3DC)),
                        SizedBox(width: 6),
                        Text('Mahasiswa UB',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== Stat cards =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _statCard('IPK TERAKHIR', '3.85', isDark)),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard('SKS TOTAL', '124', isDark)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== Informasi Akademik =====
            _sectionBlock(
              title: 'Informasi Akademik',
              isDark: isDark,
              children: [
                _menuTile(Icons.badge_outlined, 'Data Mahasiswa', isDark, () {
                  DataMahasiswaScreen.showOverlay(context);
                }),
              ],
            ),

            // ===== Pengaturan & Bantuan =====
            _sectionBlock(
              title: 'Pengaturan & Bantuan',
              isDark: isDark,
              children: [
                _menuTile(Icons.manage_accounts_outlined, 'Pengaturan Akun', isDark, () {}),
                const SizedBox(height: 10),
                _menuTile(Icons.help_outline, 'Pusat Bantuan', isDark, () {}),
                const SizedBox(height: 10),
                _menuTile(Icons.language, 'Bahasa', isDark, () {}),
              ],
            ),

            const SizedBox(height: 8),

            // ===== Tombol Keluar =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _handleLogout,
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (i) {
          if (i != 3) Navigator.pop(context);
        },
      ),
    );
  }

  Widget _statCard(String label, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.3,
                  color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkAccentBlue : AppColors.primary)),
        ],
      ),
    );
  }

  Widget _sectionBlock({required String title, required bool isDark, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4,
                  color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String label, bool isDark, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: isDark ? AppColors.darkAccentBlue : AppColors.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
            ),
            Icon(Icons.chevron_right, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
