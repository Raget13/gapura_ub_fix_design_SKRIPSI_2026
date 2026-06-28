import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../main.dart';
import '../widgets/bottom_nav.dart';
import 'sidebar_drawer.dart';
import 'opening_login_screen.dart';
import 'data_mahasiswa_screen.dart';
import 'akademik_screen.dart';
import 'informasi_screen.dart';
import 'pusat_bantuan_screen.dart';
import '../core/page_transitions.dart';

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
        title: Text(AppStrings.get(context, 'logout_confirm'),
            style: const TextStyle(fontWeight: FontWeight.w700)),
        content: Text(AppStrings.get(context, 'logout_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.get(context, 'cancel')),
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
            child: Text(AppStrings.get(context, 'logout'),
                style: const TextStyle(
                    color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, currentLocale, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBorder : AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.get(context, 'choose_language'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _languageOption(
                    ctx: ctx,
                    isDark: isDark,
                    flag: '🇮🇩',
                    label: AppStrings.get(context, 'indonesian'),
                    locale: const Locale('id'),
                    selected: currentLocale.languageCode == 'id',
                  ),
                  const SizedBox(height: 10),
                  _languageOption(
                    ctx: ctx,
                    isDark: isDark,
                    flag: '🇬🇧',
                    label: AppStrings.get(context, 'english'),
                    locale: const Locale('en'),
                    selected: currentLocale.languageCode == 'en',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _languageOption({
    required BuildContext ctx,
    required bool isDark,
    required String flag,
    required String label,
    required Locale locale,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        localeNotifier.value = locale;
        Navigator.pop(ctx);
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.08)
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : (isDark ? AppColors.darkBorder : AppColors.borderGrey),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? AppColors.primary
                      : (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
                ),
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = (String key) => AppStrings.get(context, key);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : Colors.white,
      drawer: const SidebarDrawer(),
      appBar: AppBar(
        centerTitle: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo_gapura_ub.png',
                width: 32,
                height: 32,
                color: Colors.white,
                errorBuilder: (c, e, st) => const SizedBox.shrink()),
            const SizedBox(width: 6),
            Text(s('app_name'),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Header biru =====
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
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLight,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 4),
                    ),
                    child:
                        const Icon(Icons.person, size: 64, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Text(s('student_name'),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text('22518383837',
                      style: TextStyle(fontSize: 14, color: Color(0xFFBFDBFE))),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle,
                            size: 16, color: Color(0xFFFFF3DC)),
                        const SizedBox(width: 6),
                        Text(s('student_ub'),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
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
                  Expanded(child: _statCard(s('last_gpa'), '3.85', isDark)),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard(s('total_sks'), '124', isDark)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== Informasi Akademik =====
            _sectionBlock(
              title: s('academic_info'),
              isDark: isDark,
              children: [
                _menuTile(Icons.badge_outlined, s('student_data'), isDark, () {
                  DataMahasiswaScreen.showOverlay(context);
                }),
              ],
            ),

            // ===== Pengaturan & Bantuan =====
            _sectionBlock(
              title: s('settings_help'),
              isDark: isDark,
              children: [
                _menuTile(Icons.help_outline, s('help_center'), isDark, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PusatBantuanScreen()));
                }),
                const SizedBox(height: 10),
                _menuTile(Icons.language, s('language'), isDark,
                    _showLanguagePicker),
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
                  label: Text(s('logout'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
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
          if (i == 3) return;
          if (i == 0) {
            Navigator.pop(context);
          } else if (i == 1) {
            Navigator.pushReplacement(
                context, navRoute(const AkademikScreen()));
          } else if (i == 2) {
            Navigator.pushReplacement(
                context, navRoute(const InformasiScreen()));
          }
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
        border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkAccentBlue
                      : AppColors.primary)),
        ],
      ),
    );
  }

  Widget _sectionBlock(
      {required String title,
      required bool isDark,
      required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _menuTile(
      IconData icon, String label, bool isDark, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 22,
                color: isDark ? AppColors.darkAccentBlue : AppColors.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary)),
            ),
            Icon(Icons.chevron_right,
                color: isDark ? AppColors.darkTextMuted : AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
