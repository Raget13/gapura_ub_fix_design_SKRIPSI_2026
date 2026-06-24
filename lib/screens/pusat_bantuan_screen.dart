import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';

class PusatBantuanScreen extends StatefulWidget {
  const PusatBantuanScreen({super.key});

  @override
  State<PusatBantuanScreen> createState() => _PusatBantuanScreenState();
}

class _PusatBantuanScreenState extends State<PusatBantuanScreen> {
  String _selectedTopik = 'Semua';
  final List<String> _topik = ['Semua', 'Login', 'Presensi', 'Akademik', 'Aplikasi'];

  final List<Map<String, String>> _faqList = [
    {
      'topik': 'Login',
      'icon': 'lock',
      'q': 'Kenapa saya harus login ulang terus?',
      'a': 'Sesi login memiliki batas waktu aktif. Pastikan Anda mengaktifkan opsi "Tetap Masuk" saat login. Jika masalah berlanjut, coba hapus cache aplikasi melalui pengaturan perangkat Anda.',
    },
    {
      'topik': 'Login',
      'icon': 'lock',
      'q': 'Kenapa saya harus login ulang terus?',
      'a': 'Sesi login memiliki batas waktu aktif. Pastikan Anda mengaktifkan opsi "Tetap Masuk" saat login. Jika masalah berlanjut, coba hapus cache aplikasi melalui pengaturan perangkat Anda.',
    },
    {
      'topik': 'Presensi',
      'icon': 'check',
      'q': 'Bagaimana cara melakukan presensi?',
      'a': 'Buka menu Jadwal & Presensi, pilih mata kuliah yang sedang berjalan, lalu tekan tombol Hadir dan pilih mode Luring atau Daring.',
    },
    {
      'topik': 'Akademik',
      'icon': 'school',
      'q': 'Di mana saya bisa melihat hasil studi?',
      'a': 'Hasil studi tersedia di menu Akademik → Hasil Studi. Data akan diperbarui setiap akhir semester.',
    },
    {
      'topik': 'Aplikasi',
      'icon': 'apps',
      'q': 'Aplikasi tidak bisa dibuka, apa yang harus dilakukan?',
      'a': 'Coba tutup aplikasi dan buka kembali. Jika masih bermasalah, hapus cache atau perbarui aplikasi ke versi terbaru.',
    },
  ];

  final Set<int> _expanded = {};

  List<Map<String, String>> get _filtered => _selectedTopik == 'Semua'
      ? _faqList
      : _faqList.where((f) => f['topik'] == _selectedTopik).toList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF3F6FB),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(isDark),
                  const SizedBox(height: 16),
                  _buildContactCard(),
                  const SizedBox(height: 24),
                  _buildTopikSection(isDark),
                  const SizedBox(height: 16),
                  _buildFaqList(isDark),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (i) {
          if (i != 3) Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                'Pusat Bantuan',
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

  Widget _buildSearchBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary, size: 20),
          const SizedBox(width: 10),
          Text(
            'Cari pertanyaan atau topik bantuan...',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masih butuh bantuan?',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Hubungi tim HALOFILKOM UB\nmelalui email atau\nWhatsApp resmi',
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Hubungi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildTopikSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOPIK BANTUAN',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _topik.map((t) {
            final isSelected = t == _selectedTopik;
            return GestureDetector(
              onTap: () => setState(() {
                _selectedTopik = t;
                _expanded.clear();
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : (isDark ? AppColors.darkCard : Colors.white),
                  borderRadius: BorderRadius.circular(50),
                  border: isSelected ? null : Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
                ),
                child: Text(
                  t,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFaqList(bool isDark) {
    final list = _filtered;
    return Column(
      children: List.generate(list.length, (i) => _buildFaqItem(i, list[i], isDark)),
    );
  }

  Widget _buildFaqItem(int index, Map<String, String> faq, bool isDark) {
    final isOpen = _expanded.contains(index);
    return GestureDetector(
      onTap: () => setState(() {
        if (isOpen) {
          _expanded.remove(index);
        } else {
          _expanded.add(index);
        }
      }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderGrey, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.lock_outline, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      faq['q']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              if (isOpen) ...[
                const SizedBox(height: 10),
                Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.borderGrey),
                const SizedBox(height: 10),
                Text(
                  faq['a']!,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.55,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
