import 'package:flutter/material.dart';
import '../core/app_colors.dart';

enum AnnouncementIcon { megaphone, document }

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String dosen;
  final String waktu;
  final bool unread;
  final AnnouncementIcon iconType;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.dosen,
    required this.waktu,
    this.unread = false,
    this.iconType = AnnouncementIcon.megaphone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDoc = iconType == AnnouncementIcon.document;

    final iconBg = isDoc
        ? (isDark ? const Color(0xFF0F2A1A) : const Color(0xFFDCFCE7))
        : (isDark ? const Color(0xFF2D2415) : const Color(0xFFFFF3DC));
    final iconColor = isDoc ? AppColors.success : AppColors.accent;
    final iconData = isDoc ? Icons.description_outlined : Icons.campaign_outlined;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.borderGrey,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
                child: Icon(iconData, size: 19, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary, height: 1.3)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 13, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(dosen, style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
                        const SizedBox(width: 10),
                        Icon(Icons.access_time, size: 13, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(waktu, style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextMuted : AppColors.textMuted)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (unread)
            const Positioned(
              top: 2, right: 2,
              child: CircleAvatar(radius: 5, backgroundColor: AppColors.accent),
            ),
        ],
      ),
    );
  }
}
