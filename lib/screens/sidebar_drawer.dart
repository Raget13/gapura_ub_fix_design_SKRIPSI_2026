import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../main.dart';
import 'opening_login_screen.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({super.key});

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _darkMode = themeNotifier.value == ThemeMode.dark;
  }

  void _toggleDarkMode(bool value) {
    setState(() => _darkMode = value);
    themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
  }

  void _handleLogout(BuildContext context) {
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
            child: Text('Keluar', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkBg : Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header biru =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo_gapura_ub.png',
                        width: 64, height: 64,
                        color: Colors.white,
                        errorBuilder: (c, e, s) => const Icon(Icons.business, color: Colors.white, size: 64),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gapura UB',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          Text('Universitas Brawijaya',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFBFDBFE))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, color: Colors.white.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  const Text('Satu Aplikasi, Banyak Kemudahan',
                      style: TextStyle(fontSize: 13, color: Color(0xFFBFDBFE))),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Deskripsi app =====
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border(left: BorderSide(color: AppColors.primary, width: 3)),
                      ),
                      child: Text(
                        'GAPURA Mobile adalah aplikasi sistem informasi layanan terpadu yang memberikan akses informasi dan layanan bagi seluruh pengguna Sistem Informasi Universitas Brawijaya yang menggunakan perangkat mobile',
                        style: TextStyle(fontSize: 13, height: 1.5,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                      ),
                    ),

                    const SizedBox(height: 18),
                    _sectionLabel('Layanan', isDark),
                    const SizedBox(height: 10),
                    _menuTile(
                      icon: Icons.badge_outlined,
                      label: 'ID Card',
                      iconBg: isDark ? const Color(0xFF1D3461) : const Color(0xFFDDEEFF),
                      iconColor: isDark ? AppColors.darkAccentBlue : AppColors.primary,
                      isDark: isDark,
                      onTap: () {},
                    ),
                    _menuTile(
                      icon: Icons.qr_code_2,
                      label: 'Kode QR',
                      iconBg: isDark ? const Color(0xFF1D3461) : const Color(0xFFDDEEFF),
                      iconColor: isDark ? AppColors.darkAccentBlue : AppColors.primary,
                      isDark: isDark,
                      onTap: () {},
                    ),
                    _menuTile(
                      icon: Icons.refresh,
                      label: 'Cek Update Aplikasi',
                      iconBg: isDark ? const Color(0xFF0F2A1A) : const Color(0xFFDCFCE7),
                      iconColor: AppColors.success,
                      isDark: isDark,
                      onTap: () {},
                    ),

                    const SizedBox(height: 8),
                    Divider(color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
                    const SizedBox(height: 8),

                    _sectionLabel('Preferensi', isDark),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 48, height: 48,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkElevated : AppColors.bgGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.dark_mode_outlined, size: 24,
                                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF4B5563)),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text('Dark Mode',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                          ),
                          Switch(
                            value: _darkMode,
                            activeColor: AppColors.primary,
                            onChanged: _toggleDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== Footer =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                children: [
                  Text('Gapura UB Versi: 3.3.35+191',
                      style: TextStyle(fontSize: 11, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _handleLogout(context),
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text('Keluar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.errorBg.withOpacity(0.15) : AppColors.errorBg,
                        foregroundColor: AppColors.error,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
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

  Widget _sectionLabel(String text, bool isDark) {
    return Text(text.toUpperCase(),
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5,
            color: isDark ? AppColors.darkTextMuted : AppColors.textMuted));
  }

  Widget _menuTile({
    required IconData icon,
    required String label,
    required Color iconBg,
    required Color iconColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
            ),
            Icon(Icons.chevron_right, size: 22, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
