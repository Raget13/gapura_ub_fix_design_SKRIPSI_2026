import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class JadwalCard extends StatelessWidget {
  final String namaMatkul;
  final String jamLokasi;
  final String status;
  final bool isBerlangsung;

  const JadwalCard({
    super.key,
    required this.namaMatkul,
    required this.jamLokasi,
    required this.status,
    this.isBerlangsung = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.bgCard,
          border: Border.all(
            color: isDark ? AppColors.darkBorder : const Color(0xFFBFD7FF),
            width: 0.8,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent bar
              Container(
                width: 4,
                color: isDark ? AppColors.darkAccentBlue : AppColors.primary,
              ),
              // Card content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text('JADWAL HARI INI',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5,
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(namaMatkul,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(jamLokasi,
                          style: TextStyle(fontSize: 12,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 7, height: 7,
                                decoration: const BoxDecoration(
                                    color: AppColors.success, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 5),
                              Text(status,
                                  style: const TextStyle(
                                      fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: const Text('Presensi',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
