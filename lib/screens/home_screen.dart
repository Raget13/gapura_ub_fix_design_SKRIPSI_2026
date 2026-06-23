import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/jadwal_card.dart';
import '../widgets/menu_grid.dart';
import '../widgets/announcement_card.dart';
import '../widgets/bottom_nav.dart';
import 'sidebar_drawer.dart';
import 'profile_screen.dart';
import 'jadwal_presensi_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  bool _reminderActive = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.bgWhite,
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // ===== Banner Hero =====
            Container(
              padding: const EdgeInsets.fromLTRB(18, 18, 14, 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryLight, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PORTAL AKADEMIK UB',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700,
                                color: Color(0xFFBFDBFE), letterSpacing: 0.6)),
                        const SizedBox(height: 6),
                        const Text('Selamat Datang',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white, height: 1.25)),
                        const Text('di Gapura UB',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white, height: 1.25)),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today, size: 13, color: AppColors.primary),
                              const SizedBox(width: 6),
                              const Text('Semester Genap 2025/2026',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/logo_ub.png',
                    width: 110,
                    height: 110,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(width: 110, height: 110),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== Greeting =====
            Text('Halo, Nama Mahasiswa 👋',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
            const SizedBox(height: 14),

            // ===== Kartu Jadwal Hari Ini =====
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => const JadwalPresensiScreen()),
                );
                if (result == true && mounted) {
                  setState(() => _reminderActive = true);
                }
              },
              child: const JadwalCard(
                namaMatkul: 'Rekayasa Perangkat Lunak',
                jamLokasi: '08.00 - 10.00 · Gedung F - FILKOM F2.1',
                status: 'Sedang Berlangsung',
                isBerlangsung: true,
              ),
            ),

            if (_reminderActive) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3DC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.notifications_active, color: AppColors.accent, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Pengingat RPL aktif · 30 menit sebelum kelas',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 22),

            // ===== Menu Utama =====
            Text('MENU UTAMA',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.4,
                    color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
            const SizedBox(height: 10),
            const MenuGrid(),

            const SizedBox(height: 10),

            // ===== Pengumuman Kelas =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pengumuman Kelas',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                TextButton(
                  onPressed: () {},
                  child: const Text('Lihat Semua >',
                      style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const AnnouncementCard(
              title: 'Perkuliahan RPL diganti Jumat, 6 Juni 2025',
              dosen: 'Dr. Ahmad Faiz',
              waktu: '2 jam lalu',
              unread: true,
              iconType: AnnouncementIcon.megaphone,
            ),
            const AnnouncementCard(
              title: 'Kuis Basis Data minggu depan - materi Ch. 4-6',
              dosen: 'Dr. Sari Dewi',
              waktu: '5 jam lalu',
              unread: false,
              iconType: AnnouncementIcon.megaphone,
            ),
            const AnnouncementCard(
              title: 'Kuis Basis Data minggu depan - materi Ch. 4-6',
              dosen: 'Dr. Sari Dewi',
              waktu: '5 jam lalu',
              unread: false,
              iconType: AnnouncementIcon.document,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (i) {
          setState(() => _currentNavIndex = i);
          if (i == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()))
                .then((_) => setState(() => _currentNavIndex = 0));
          }
        },
      ),
    );
  }
}
